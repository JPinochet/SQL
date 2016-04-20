SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER blam_blam_bir
	BEFORE INSERT ON wgl_reserve_list
	FOR EACH ROW
	DECLARE
		lv_available VARCHAR2(2);
	BEGIN
		SELECT status
			INTO lv_available
			FROM wgl_accession_register
			WHERE isbn = :NEW.isbn 
			AND branch_number = :NEW.branch_reserved_at
			AND status != 'OS';
		:NEW.date_reserved := TRUNC(SYSDATE);
	EXCEPTION
		WHEN NO_DATA_FOUND THEN
			RAISE_APPLICATION_ERROR(-20001, 'Trigger worked, Insertion aborted. Book is available!');
	END;
	/

INSERT INTO wgl_reserve_list (patron_number, isbn, branch_reserved_at, pick_up_branch)
	VALUES (2, '0-566-03538-3', 1, 2);

INSERT INTO wgl_reserve_list(patron_number, isbn, branch_reserved_at, pick_up_branch)
	VALUES (10, '0-88830-100-6', 1, 1);
	
CREATE OR REPLACE TRIGGER blah_blam_bir
	BEFORE INSERT ON wgl_loan
	FOR EACH ROW
	DECLARE
		lv_loan_period	wgl_accession_register.loan_period%TYPE;
	BEGIN
		SELECT loan_period
			INTO lv_loan_period
			FROM wgl_accession_register
			WHERE accession_number = :NEW.accession_number;
		
		SELECT wgl_loan_seq.NEXTVAL 
			INTO :NEW.loan_number  
			FROM dual;
		:NEW.loan_date := TRUNC(SYSDATE);
		:NEW.due_date := :NEW.loan_date + lv_loan_period;
		:NEW.date_returned := NULL;
		
		UPDATE wgl_patron 
			SET books_on_loan = books_on_loan + 1
			WHERE patron_number = :NEW.patron_number;
		UPDATE wgl_accession_register
			SET due_date = :NEW.loan_date + lv_loan_period, status = 'OS'
			WHERE accession_number = :NEW.accession_number;
	END;
	/
	
INSERT INTO wgl_loan (patron_number, accession_number, loan_type)
	VALUES(13, 25 ,'O');
	
INSERT INTO wgl_loan (patron_number, accession_number, loan_type)
	VALUES(15, 2, 'O');
	
CREATE OR REPLACE TRIGGER logon_aes
	AFTER logon ON SCHEMA
	BEGIN
		INSERT INTO bb_audit_logon
			VALUES(USER, SYSDATE);
	END;