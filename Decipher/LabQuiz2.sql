SET SERVEROUTPUT ON

DECLARE
	CURSOR c_sentence IS
		SELECT * 
			FROM CODE_SENTENCE;
	v_letter	VARCHAR2(25);
	v_sentence	VARCHAR2(25);
BEGIN
	FOR r_decipher IN c_sentence LOOP
		SELECT key_character
			INTO v_letter
			FROM code_key
			WHERE key_number = r_decipher.key_number;
		v_sentence := v_sentence || v_letter;
	END LOOP;
	DBMS_OUTPUT.PUT_LINE(v_sentence);
END;
/
