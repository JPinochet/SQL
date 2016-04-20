SET SERVEROUTPUT ON;

DROP TABLE class_section_error;
CREATE TABLE class_section_error AS
	SELECT *
		FROM class_section_updates;
DELETE FROM class_section_error;
ALTER TABLE class_section_error
	ADD error_message VARCHAR2(100);
	
	
DECLARE 
	CURSOR class_updates IS
		SELECT *
		FROM class_section_updates;
	
	v_instructor_id		class_section.instructor_id%TYPE;
	v_capacity			class_section.capacity%TYPE;
	v_enrolment			class_section.enrolment%TYPE;
	v_message			VARCHAR2(100);
	
	no_match_found EXCEPTION;
	incorrect_transaction_type EXCEPTION;
	missing_input_to_update EXCEPTION;
	
BEGIN
	FOR c_updates IN class_updates LOOP
	
	SELECT instructor_id, capacity, enrolment
		INTO v_instructor_id, v_capacity, v_enrolment
		FROM class_section
		WHERE course_code = c_updates.course_code
			AND section_code = c_updates.section_code
			AND semester = c_updates.semester
			AND year = c_updates.year;
		IF SQL%NOTFOUND THEN
				RAISE missing_input_to_update;
			END IF;
	
	IF c_updates.transaction_type = 'U' THEN
		UPDATE class_section
			SET instructor_id = c_updates.instructor_id, capacity = c_updates.capacity, enrolment = c_updates.enrolment
			WHERE course_code = c_updates.course_code
				AND section_code = c_updates.section_code
				AND semester = c_updates.semester
				AND year = c_updates.year;
			IF SQL%NOTFOUND THEN
				RAISE no_match_found;
			END IF;
	
	ELSIF c_updates.transaction_type = 'D' THEN
		DELETE FROM class_section
			WHERE course_code = c_updates.course_code
				AND section_code = c_updates.section_code
				AND semester = c_updates.semester
				AND year = c_updates.year;
			IF SQL%NOTFOUND THEN
				RAISE no_match_found;
			END IF;
	
	ELSIF c_updates.transaction_type = 'I' THEN
		INSERT INTO class_section (instructor_id, capacity, enrolment, course_code, section_code, semester, year)
			VALUES (c_updates.instructor_id, c_updates.capacity, c_updates.enrolment, c_updates.course_code, c_updates.section_code, c_updates.semester, c_updates.year);
			IF SQL%NOTFOUND THEN
				RAISE no_match_found;
			END IF;
			
	ELSE
			RAISE incorrect_transaction_type;
	END IF;	
	COMMIT;
	END LOOP;
	
EXCEPTION
	WHEN no_match_found THEN 
		ROLLBACK;
		v_message := ('No Match Found to Update');
			INSERT INTO class_section_error (course_code, section_code, semester, year, instructor_id, capacity, enrolment, error_message)
				VALUES(c_updates.course_code, c_updates.section_code, c_updates.semester , c_updates.year, c_updates.instructor_id, c_updates.capacity, c_updates.enrolment, v_message);
		COMMIT;
	WHEN missing_input_to_update THEN
		ROLLBACK;
		v_message := ('Found null value when value expected');
			INSERT INTO class_section_error (course_code, section_code, semester, year, instructor_id, capacity, enrolment, error_message)
				VALUES(c_updates.course_code, c_updates.section_code, c_updates.semester , c_updates.year, c_updates.instructor_id, c_updates.capacity, c_updates.enrolment, v_message);
		COMMIT;
	WHEN incorrect_transaction_type THEN
		ROLLBACK;
		v_message := ('Incorrect Transaction Type');
			INSERT INTO class_section_error (course_code, section_code, semester, year, instructor_id, capacity, enrolment, error_message)
				VALUES(c_updates.course_code, c_updates.section_code, c_updates.semester , c_updates.year, c_updates.instructor_id, c_updates.capacity, c_updates.enrolment, v_message);
		COMMIT;
	WHEN NO_DATA_FOUND THEN
		ROLLBACK;
		v_message := ('No data was found');
			INSERT INTO class_section_error (course_code, section_code, semester, year, instructor_id, capacity, enrolment, error_message)
				VALUES(c_updates.course_code, c_updates.section_code, c_updates.semester , c_updates.year, c_updates.instructor_id, c_updates.capacity, c_updates.enrolment, v_message);
		COMMIT;
	WHEN OTHERS THEN
		ROLLBACK;
		v_message := SUBSTR(SQLERRM, 1, 100);
			INSERT INTO class_section_error (course_code, section_code, semester, year, instructor_id, capacity, enrolment, error_message)
				VALUES(c_updates.course_code, c_updates.section_code, c_updates.semester , c_updates.year, c_updates.instructor_id, c_updates.capacity, c_updates.enrolment, v_message);
		COMMIT;
END;
/

