SPOOL "D:\Database\Semester_3\WGL\Lab_Quiz_5_trigs.out"
SET SERVEROUTPUT ON;
SET ECHO ON;

CREATE OR REPLACE TRIGGER book_return_bir
	BEFORE INSERT ON wgl_return
	FOR EACH ROW
	DECLARE
	lv_accession_number	wgl_loan.accession_number%TYPE;
	lv_patron_number wgl_loan.patron_number%TYPE;
	BEGIN
		BEGIN
			SELECT accession_number
				INTO lv_accession_number
				FROM wgl_loan
				WHERE accession_number = :NEW.accession_number 
				AND date_returned IS NULL;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				RAISE_APPLICATION_ERROR(-20001, 'That book was not on loan');
		END;
		
		BEGIN
			SELECT patron_number
				INTO lv_patron_number
				FROM wgl_loan
				WHERE accession_number = :NEW.accession_number 
				AND date_returned IS NULL;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				RAISE_APPLICATION_ERROR(-20002, 'That patron does not exist, or does not have a book on loan');
		END;
		
		:NEW.date_returned := TRUNC(SYSDATE);
		
		UPDATE wgl_loan
			SET date_returned = TRUNC(SYSDATE)
			WHERE accession_number = :NEW.accession_number
			AND date_returned IS NULL;
			
		UPDATE wgl_patron
			SET books_on_loan = books_on_loan - 1
			WHERE patron_number = lv_patron_number;
			
		status_update(:NEW.accession_number);
	END;
	/
	
--Trigger Tests
INSERT INTO wgl_return(accession_number, branch_returned_to)
	VALUES (12, 2);
	
INSERT INTO wgl_return(accession_number, branch_returned_to)
	VALUES (48, 4);
	
INSERT INTO wgl_return(accession_number, branch_returned_to)
	VALUES(1, 1);
	
INSERT INTO wgl_return(accession_number, branch_returned_to)
	VALUES(26, 4);
	
SPOOL OFF;