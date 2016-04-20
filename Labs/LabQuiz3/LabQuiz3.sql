SET SERVEROUTPUT ON

CREATE SEQUENCE seq_accesion_number
	START WITH 100;

CREATE OR REPLACE PROCEDURE INSERT_BOOK (isbm VARCHAR2, branch_number NUMBER, loan_period NUMBER)
	IS
		BEGIN
			INSERT INTO wgl_accession_register
				VALUES(seq_accesion_number.NEXTVAL, isbm, branch_number, SYSDATE, 'OS', loan_period, NULL);
			UPDATE wgl_title_catalogue
				SET no_copies_in_system = no_copies_in_system + 1
				WHERE isbn = isbm;
		END;
		/
		
EXECUTE INSERT_BOOK('0-13-443631-8',3,7);
EXECUTE INSERT_BOOK('0-88830-100-6',2,14);
EXECUTE INSERT_BOOK('0-89435-356-X',3,21);
EXECUTE INSERT_BOOK('0-7707-1234-0',2,21);
EXECUTE INSERT_BOOK('0-471-93412-7',6,21);

CREATE OR REPLACE FUNCTION ON_RESERVE (accession NUMBER)
	RETURN BOOLEAN
	IS
		lv_isbn VARCHAR2(20);
		BEGIN
			SELECT isbn
				INTO lv_isbn
				FROM wgl_accession_register
				WHERE accession_number = accession;
			SELECT isbn
				INTO lv_isbn
				FROM wgl_reserve_list
				WHERE isbn = lv_isbn AND
				 ROWNUM = 1;
			RETURN TRUE;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				RETURN FALSE;
		END;
		/
		
CREATE OR REPLACE PROCEDURE CHECK_RESERVE(accession_number NUMBER)
	IS
		BEGIN
			IF ON_RESERVE(accession_number) THEN
				DBMS_OUTPUT.PUT_LINE(accession_number || ' is on reserve');
			ELSE
				DBMS_OUTPUT.PUT_LINE(accession_number || ' is not on reserve');
			END IF;
		END;
		/