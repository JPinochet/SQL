/*************************************************************
**
**	Jorge Pinochet							November 11, 2009
**
**	Problem: 
**
** 	How do I know this worked?
**		
**
**
*************************************************************/

SPOOL "D:\Database\Semester_3\Assignment2\Assignment2.out"
SET ECHO ON;
SET SERVEROUTPUT ON;


CREATE OR REPLACE PROCEDURE update_class_section (course_cod VARCHAR2, sectio VARCHAR2, semeste VARCHAR2, yea VARCHAR2, enrol NUMBER)
	IS
	lv_enrolment VARCHAR2(1):= enrol;
	BEGIN
		UPDATE class_section
			SET enrolment = enrolment + lv_enrolment
			WHERE course_code = course_cod
			AND section_code = sectio
			AND semester = semeste
			AND year = yea;
	END;
	/

CREATE OR REPLACE PROCEDURE update_error_log (student_i VARCHAR2, course_cod VARCHAR2, sectio VARCHAR2, semeste VARCHAR2, yea VARCHAR2, grad NUMBER, transaction_typ VARCHAR2, messag VARCHAR2)
	IS
	BEGIN
		INSERT INTO error_log
			VALUES(student_i, course_cod, sectio, semeste, yea, grad, transaction_typ, messag);
	END;
	/

CREATE OR REPLACE FUNCTION grade_check (student_i VARCHAR2, course_cod VARCHAR2, sectio VARCHAR2, semeste VARCHAR2, yea VARCHAR2)
	RETURN BOOLEAN
	IS
	lv_grade NUMBER(3,0);
	BEGIN
		SELECT grade
			INTO lv_grade
			FROM course_registration
			WHERE student_id = student_i
				AND course_code = course_cod
				AND section = sectio
				AND semester = semeste
				AND year = yea;
			RETURN TRUE;
	EXCEPTION
			WHEN NO_DATA_FOUND THEN
				RETURN FALSE;
	END;
	/
	
CREATE OR REPLACE FUNCTION new_regis_student_exists (student_i VARCHAR2, course_registratio VARCHAR2, course_cod VARCHAR2, sectio VARCHAR2, semeste VARCHAR2, yea VARCHAR2)
	RETURN BOOLEAN
	IS
	lv_student_id VARCHAR2(25);
	BEGIN
		SELECT student_id
				INTO lv_student_id
				FROM course_registration
				WHERE student_id = student_i
				AND  course_code = course_cod
				AND section = sectio
				AND semester = semeste
				AND year = yea;
		RETURN TRUE;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
				RETURN FALSE;
	END;
	/
	
	

CREATE OR REPLACE PROCEDURE new_regis (student_i VARCHAR2, course_cod VARCHAR2, sectio VARCHAR2, semeste VARCHAR2, yea VARCHAR2, grad NUMBER)
	IS
	lv_student_id VARCHAR2(25);
	lv_course_code VARCHAR2(25);
	BEGIN
		BEGIN
			SELECT student_id
				INTO lv_student_id
				FROM student
				WHERE student_id = student_i;
		EXCEPTION 
			WHEN NO_DATA_FOUND THEN
				RAISE_APPLICATION_ERROR(-20001, 'Student does not exist');
		END;
		BEGIN
			SELECT course_code
				INTO lv_course_code
				FROM course
				WHERE course_code = course_cod;
		EXCEPTION 
			WHEN NO_DATA_FOUND THEN
				RAISE_APPLICATION_ERROR(-20002, 'Course does not exist');
		END;
		
		update_class_section(course_cod, sectio, semeste, yea, 1);
		IF new_regis_student_exists(student_i, course_registratio, course_cod, sectio, semeste, yea) THEN
			IF grade_check(student_i, course_registratio, course_cod, sectio, semeste, yea) THEN
				RAISE_APPLICATION_ERROR(-20004, 'Student already has a grade.');
			ELSE
				
				update_class_section(course_cod, sectio, semeste, yea, -1);
			END IF;
		ELSE
			RAISE_APPLICATION_ERROR(-20003, 'Student does not exist in course registration.');
		END IF;
	END;
	/

DECLARE
	CURSOR cur_reg IS
		SELECT * 
			FROM new_registration;
	invalid_student EXCEPTION;
	PRAGMA EXCEPTION_INIT(invalid_student, -20001);
	invalid_course_code EXCEPTION;
	PRAGMA EXCEPTION_INIT(invalid_course_code, -20002);
BEGIN
	FOR rec_reg IN cur_reg LOOP
	
	IF rec_reg.transaction_type == 'N' THEN
		DBMS_OUTPUT.PUT_LINE('TO DO Update Grade');
	ELSIF rec_reg.transaction_type == 'UG' THEN
		DBMS_OUTPUT.PUT_LINE('TO DO Update Grade');
	ELSIF rec_reg.transaction_type == 'D' THEN
		DBMS_OUTPUT.PUT_LINE('TO DO Delete');
	ELSE 
		update_error_log(rec_reg.student_id, rec_reg.course_code, rec_reg.section, rec_reg.semester, rec_reg.year, rec_reg.grade, rec_reg.transaction_type, "Invalid transaction type.");
	END IF;
	
	END LOOP;
EXCEPTION
	WHEN invalid_student THEN
		v_message := SUBSTR(SQLERRM, 1, 100);
		update_error_log(rec_reg.student_id, rec_reg.course_code, rec_reg.section, rec_reg.semester, rec_reg.year, rec_reg.grade, rec_reg.transaction_type, v_message);
	WHEN invalid_course_code THEN
		v_message := SUBSTR(SQLERRM, 1, 100);
		update_error_log(rec_reg.student_id, rec_reg.course_code, rec_reg.section, rec_reg.semester, rec_reg.year, rec_reg.grade, rec_reg.transaction_type, v_message);
	WHEN OTHERS THEN
		v_message := SUBSTR(SQLERRM, 1, 100);
		update_error_log(rec_reg.student_id, rec_reg.course_code, rec_reg.section, rec_reg.semester, rec_reg.year, rec_reg.grade, rec_reg.transaction_type, v_message);
END;
/

SPOOL OFF;