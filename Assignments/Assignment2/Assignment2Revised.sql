/*************************************************************
**
**	Jorge Pinochet							November 11, 2009
**
**	Problem: Manipulate information from a given table(new_registration) and update the database for ICCC
**				accordingly.
**
** 	How do I know this worked?
**		To triple check that my assignment does it's work, I will have to analyze the information in the new_registration
**			and run my assignment on a freshly reloaded ICCC database. Then if everything updates correctly then I know it
**			worked.
**		
**
**
*************************************************************/

DECLARE
	CURSOR cur_reg IS
		SELECT * 
			FROM new_registration;
BEGIN
	FOR rec_reg IN cur_reg LOOP
	
	IF rec_reg.transaction_type == 'N' THEN
		new_regis(rec_reg.student_id, rec_reg.course_code, rec_reg.section, rec_reg.semester, rec_reg.year, rec_reg.grade);
	ELSIF rec_reg.transaction_type == 'UG' THEN
		update_grade(rec_reg.student_id, rec_reg.course_code, rec_reg.section, rec_reg.semester, rec_reg.year, rec_reg.grade);
	ELSIF rec_reg.transaction_type == 'D' THEN
		delete_reg(rec_reg.student_id, rec_reg.course_code, rec_reg.section, rec_reg.semester, rec_reg.year, rec_reg.grade);
	ELSE 
		update_error_log(rec_reg.student_id, rec_reg.course_code, rec_reg.section, rec_reg.semester, rec_reg.year, rec_reg.grade, rec_reg.transaction_type, "Invalid transaction type.");
	END IF;
	
	END LOOP;
EXCEPTION
	WHEN OTHERS THEN
		v_message := SUBSTR(SQLERRM, 1, 100);
		update_error_log(rec_reg.student_id, rec_reg.course_code, rec_reg.section, rec_reg.semester, rec_reg.year, rec_reg.grade, rec_reg.transaction_type, v_message);
END;
/

CREATE OR REPLACE PROCEDURE new_regis(student_i VARCHAR2, course_cod VARCHAR2, sectio VARCHAR2, semeste VARCHAR2, yea VARCHAR2, grad NUMBER)
	IS
	BEGIN
		IF student_exist(student_i) = FALSE THEN
			RAISE_APPLICATION_ERROR(-20001, 'Student does not exist');
		END IF;
		IF course_exist(course_cod) = FALSE THEN
			RAISE_APPLICATION_ERROR(-20002, 'Course does not exist');
		END IF;

		update_class_section(course_cod, sectio, semeste, yea, 1);
		
		IF new_regis_student_exists(student_i, course_cod, sectio, semeste, yea) = FALSE THEN
			RAISE_APPLICATION_ERROR(-20003, 'Student does not exist in course registration.');
		ELSE
			IF grade_check(student_i, course_cod, sectio, semeste, yea) = FALSE THEN
				RAISE_APPLICATION_ERROR(-20004, 'Student already has a grade.');
			ELSE
				delete_from_crs_reg(student_i, course_cod, sectio, semeste, yea);
				update_class_section(course_cod, sectio, semeste, yea, -1);
				add_crs_reg(student_i, course_cod, sectio, semeste, yea, grad);
				update_class_section(course_cod, sectio, semeste, yea, 1);
			END IF;
		END IF;
	END;
	/

CREATE OR REPLACE PROCEDURE update_grade(student_i VARCHAR2, course_cod VARCHAR2, sectio VARCHAR2, semeste VARCHAR2, yea VARCHAR2, grad NUMBER)
	IS
	BEGIN
		IF new_regis_student_exists(student_i, course_cod, sectio, semeste, yea) = FALSE THEN
			RAISE_APPLICATION_ERROR(-20003, 'Student does not exist in course registration.');
		ELSE
			IF grade_check_new_reg(student_i, course_cod, sectio, semeste, yea) = FALSE THEN
				RAISE_APPLICATION_ERROR(-20005, 'Student already has a grade.');
			ELSE
				update_crsReg_grade(student_i, course_cod, sectio, semeste, yea, grad);
			END IF;
		END IF;
	END;
	/
	
CREATE OR REPLACE PROCEDURE delete_reg (student_i VARCHAR2, course_cod VARCHAR2, sectio VARCHAR2, semeste VARCHAR2, yea VARCHAR2, grad NUMBER)
	IS
	BEGIN
		IF new_regis_student_exists(student_i, course_cod, sectio, semeste, yea) = FALSE THEN
			RAISE_APPLICATION_ERROR(-20003, 'Student does not exist in course registration.');
		ELSE
			IF grade_check_new_reg(student_i, course_cod, sectio, semeste, yea) THEN
				RAISE_APPLICATION_ERROR(-20005, 'Student has a grade.');
			ELSE
				delete_from_crs_reg(student_i, course_cod, sectio, semeste, yea);
				update_class_section(course_cod, sectio, semeste, yea, -1);
			END IF;
		END IF;
	END;
	/
	
CREATE OR REPLACE FUNCTION student_exist (student_i VARCHAR2)
	RETURN BOOLEAN
	IS
	lv_student_id student.student_id%TYPE;
	BEGIN
		SELECT student_id
				INTO lv_student_id
				FROM student
				WHERE student_id = student_i;
		RETURN TRUE;
	EXCEPTION 
			WHEN NO_DATA_FOUND THEN
				RETURN FALSE;
	END;
	/

CREATE OR REPLACE FUNCTION course_exist (course_cod VARCHAR2)
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
	
CREATE OR REPLACE FUNCTION new_regis_student_exists (student_i VARCHAR2, course_cod VARCHAR2, sectio VARCHAR2, semeste VARCHAR2, yea VARCHAR2)
	RETURN BOOLEAN
	IS
	lv_student_id student.student_id%TYPE;
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

CREATE OR REPLACE PROCEDURE delete_from_crs_reg (student_i VARCHAR2, course_cod VARCHAR2, sectio VARCHAR2, semeste VARCHAR2, yea VARCHAR2)
	IS
	BEGIN
		DELETE 
			FROM course_registration
			WHERE student_id = student_i
				AND  course_code = course_cod
				AND section = sectio
				AND semester = semeste
				AND year = yea
				AND grade = NULL;
	END;
	/

CREATE OR REPLACE PROCEDURE add_crs_reg (student_i VARCHAR2, course_cod VARCHAR2, sectio VARCHAR2, semeste VARCHAR2, yea VARCHAR2, grad NUMBER)
	IS
	BEGIN
		INSERT INTO course_registration (student_id, course_code, section, semester, year, grade)
			VALUES(student_i, course_cod, sectio, semeste, yea, grad);
	END;
	/
	
CREATE OR REPLACE PROCEDURE update_crsReg_grade(student_i VARCHAR2, course_cod VARCHAR2, sectio VARCHAR2, semeste VARCHAR2, yea VARCHAR2, grad NUMBER)
	IS
	BEGIN
		UPDATE course_registration
			SET grade = grad
			WHERE student_id = student_i
				AND  course_code = course_cod
				AND section = sectio
				AND semester = semeste
				AND year = yea;
	END;
	/

CREATE OR REPLACE FUNCTION grade_check_new_reg (student_i VARCHAR2, course_cod VARCHAR2, sectio VARCHAR2, semeste VARCHAR2, yea VARCHAR2)
	RETURN BOOLEAN
	IS
	lv_grade NUMBER(3,0);
	BEGIN
		SELECT grade
			INTO lv_grade
			FROM new_registration
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