CREATE OR REPLACE TRIGGER logon_aes
	AFTER logon ON SCHEMA
	BEGIN
		INSERT INTO bb_audit_logon
			VALUES(USER, SYSDATE);
	END;