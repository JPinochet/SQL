/*
**CREATE a Microsoft Word report. This report will include the following:
**	• Cover page.
**	• The original code listed above labeled as PLlSQL.
**	• The code above converted from PLlSQL to Transact-SQL (Microsoft's database programming language).
**	• Answers to the following questions:
**
**		o What is one major syntax difference between PLlSQL and Transact-SQl, (give an example of the differences)?
**		o What is one structure that only exists in either the PLlSQL or Transact-SQL language?
**		o What is one difference in terminology between PLlSQL and Transact-SQL?
**		o In your opinion, which language (PLlSQL or Transact-SQL) do you prefer and why?
**	• Your report should be formatted in a consistent, readable, professional manner.
*/

-- pl/sql code
CREATE OR REPLACE PROCEDURE salary_range (p_salary s_emp.salary%TYPE)
	IS
		v_count 	INTEGER := 0;
		v_name 		VARCHAR2(255) ;
		v_emp_name 	s_emp.last_name%TYPE;
		
		CURSOR emp_cursor IS
			SELECT last_name
				FROM s_emp
				WHERE salary BETWEEN (p_salary - 100)
				AND (p_salary + 100)
				ORDER BY last name DESC;
			
	BEGIN
		OPEN emp_cursor;
		LOOP
			FETCH emp_cursor
				INTO v_emp_name;
				
			EXIT WHEN emp_cursor%NOTFOUND;
			
			v_count := v_count + 1;
			
			IF (v_name IS NULL) THEN
				v_name := v_emp_name;
			ELSE
				v_name := v_name || ', ' || v_emp_name;
			END IF;
		END LOOP;
		
		CLOSE emp_cursor;
		
		IF (v_count = 0) THEN
			DBMS_OUTPUT.PUT_LINE('No employee salary between the ranges of ' ||
				TO_CHAR ((p_salary - 100), '$999,999.99') || ' AND ' ||
				TO_CHAR ((p_salary + 100), '$999,999.99'));
		ELSIF(v_count <= 3) THEN
			DBMS_OUTPUT.PUT_LINE('The employees whose salaries are in the requested range are: 11 v_name') ;
			
		ELSE
			DBMS_OUTPUT.PUT_LINE('There are ' || v_count || ' employees that are in the requested salary range. They are: '|| v_name);
		END IF;
	END;
	/
	
--To trans_sql
CREATE OR REPLACE PROCEDURE salary_range (@p_salary s_emp.salary%TYPE)
	AS
		DECLARE  	@v_count 	int;
		SET 		@v_count = 0;
		DECLARE 	@v_name		AS VARCHAR;
		DECLARE 	@v_emp_name s_emp.last_name%TYPE;
		
		DECLARE emp_cursor CURSOR FOR
			SELECT last_name
				FROM s_emp
				WHERE salary BETWEEN (@p_salary - 100)
					AND (@p_salary + 100)
				ORDER BY last_name DESC;
			
	BEGIN
		OPEN emp_cursor;
		FETCH NEXT FROM emp_cursor;
		WHILE @@FETCH_STATUS = 0
		(
			@v_count := @v_count + 1;
			
			IF (@v_name IS NULL) 
				BEGIN
					SET @v_name := @v_emp_name;
				END;
			ELSE
				SET @v_name := @v_name || ', ' || @v_emp_name;
			
			FETCH NEXT FROM emp_cursor;
		)
		
		IF (@v_count = 0) 
			BEGIN
			PRINT 'No employee salary between the ranges of ' +
				TO_CHAR ((@p_salary - 100), '$999,999.99') + ' AND ' +
				TO_CHAR ((@p_salary + 100), '$999,999.99');
			END;
		ELSE
			IF(@v_count <= 3) 
				BEGIN;
					PRINT 'The employees whose salaries are in the requested range are: ' + @v_name;
				END;
		ELSE
			PRINT 'There are ' + @v_count + ' employees that are in the requested salary range. They are: ' + @v_name;
		
		CLOSE emp cursor;
		DEALLOCATE emp_cursor;
		GO
	END;
	/