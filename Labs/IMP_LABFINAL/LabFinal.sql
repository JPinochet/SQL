DECLARE
	TYPE imp_account_record_type IS RECORD
	(owner_id 				imp_account.owner_id%TYPE,
		account_number			imp_account.account_number%TYPE,
		date_created			imp_account.date_created%TYPE,
		credit_limit			imp_account.credit_limit%TYPE,
		account_balance			imp_account.account_balance%TYPE);
	
	TYPE imp_update_account_table IS TABLE OF imp_account_record_type
		INDEX BY BINARY_INTEGER;
		
	update_account 	imp_update_account_table;
	
	CURSOR cur_accounts IS
		SELECT * 
			FROM imp_account;
			
	v_table_counter NUMBER := 1;
	
BEGIN
	FOR r_imp IN cur_accounts LOOP
	
		update_account(v_table_counter).owner_id := r_imp.owner_id;
		update_account(v_table_counter).account_number := r_imp.account_number;
		update_account(v_table_counter).date_created := r_imp.date_created;
		update_account(v_table_counter).credit_limit := r_imp.credit_limit;
		update_account(v_table_counter).account_balance := r_imp.account_balance;
		
		v_table_counter := v_table_counter + 1;
	END LOOP;
	
	FOR i IN 1..(update_account.COUNT) LOOP
		v_table_counter := v_table_counter - 1;
		IF update_account(v_table_counter).account_balance > 5000 THEN
			UPDATE imp_account
				SET account_balance = account_balance * 1.08
				WHERE owner_id = update_account(v_table_counter).owner_id
				AND account_number = update_account(v_table_counter).account_number;
		ELSIF update_account(v_table_counter).account_balance >= 1000 AND update_account(v_table_counter).account_balance <= 5000 THEN
			UPDATE imp_account
				SET account_balance = account_balance * 1.03
				WHERE owner_id = update_account(v_table_counter).owner_id
				AND account_number = update_account(v_table_counter).account_number;
		ELSE
			UPDATE imp_account
				SET account_balance = account_balance * 1.01
				WHERE owner_id = update_account(v_table_counter).owner_id
				AND account_number = update_account(v_table_counter).account_number;
		END IF;
		COMMIT;
	END LOOP;
END;
/
EXPLAIN PLAN
     SET STATEMENT_ID = 'final_exam'
     FOR
		SELECT account_balance, credit_limit
			FROM imp_account
			WHERE account_number = '230019851600';