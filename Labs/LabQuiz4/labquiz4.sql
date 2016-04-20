SET SERVEROUTPUT ON;

CREATE OR REPLACE FUNCTION valid_course (course_cod VARCHAR2)
	RETURN BOOLEAN
	IS
	lv_course_code course.course_code%TYPE;
	BEGIN
		SELECT course_code
				INTO lv_course_code
				FROM course
				WHERE course_code = course_cod;
		RETURN TRUE;
	EXCEPTION 
			WHEN NO_DATA_FOUND THEN
				RETURN FALSE;
	END;
	/
	
CREATE OR REPLACE FUNCTION valid_faculty_member (employee_i VARCHAR2)
	RETURN BOOLEAN
	IS
	lv_employee_id faculty.employee_id%TYPE;
	BEGIN
		SELECT employee_id
				INTO lv_employee_id
				FROM faculty
				WHERE employee_id = employee_i;
		RETURN TRUE;
	EXCEPTION 
			WHEN NO_DATA_FOUND THEN
				RETURN FALSE;
	END;
	/
	
CREATE OR REPLACE FUNCTION expertise_exists (employee_i VARCHAR2, course_cod VARCHAR2)
	RETURN BOOLEAN
	IS
	lv_employee_id faculty.employee_id%TYPE;
	BEGIN
		SELECT employee_id
			INTO lv_employee_id
			FROM expertise
			WHERE employee_id = employee_i
			AND  course_code = course_cod
			AND expertise_level IS NOT NULL;
		RETURN TRUE;
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RETURN FALSE;
	END;
	/
	
CREATE OR REPLACE PROCEDURE add_expertise (course_cod VARCHAR2, employee_i VARCHAR2, expertise_leve NUMBER)
	IS
	BEGIN
		IF valid_faculty_member(employee_i) = FALSE THEN
			RAISE_APPLICATION_ERROR(-20001, 'Employee does not exist');
		END IF;
		IF valid_course(course_cod) = FALSE THEN
			RAISE_APPLICATION_ERROR(-20002, 'Course does not exist');
		END IF;
		IF expertise_exists(employee_i, course_cod) = FALSE THEN
			INSERT INTO expertise
				VALUES(employee_i, course_cod, expertise_leve);
		ELSE
			UPDATE expertise
				SET expertise_level = expertise_leve
				WHERE employee_id = employee_i
				AND course_code = course_cod;
		END IF;
	END;
	/