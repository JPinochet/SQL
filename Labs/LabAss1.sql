/*************************************************************
**
**	Jorge Pinochet							October 16, 2009
**
**	Problem: To update the wgb(Walnut Grove Bank) database system 
**		whenever a transaction takes place. Credits increase, while
**		debits lower, their Assets.
**
** 	How do I know this worked?
**		When the sums of the output are the same for both the 
**			wgb_assets and wgb_account table.
**
**
*************************************************************/

SPOOL "D:\School\Semester_3\Assignments_Labs\CPRG_300_Database\Lab_Assignment_1\LabAss1.out"
SET SERVEROUTPUT ON;
SET ECHO ON;
CREATE SEQUENCE gen_trans_numbers
INCREMENT BY 1
START WITH 1000;
DESCRIBE wgb_in_transactions;
SELECT *
	FROM wgb_in_transactions;

DECLARE
	CURSOR cur_wgb_transaction IS
		SELECT * 
			FROM wgb_in_transactions;
	v_type_credit		CHAR := 'C';
	v_type_debit		CHAR := 'D';
BEGIN
	FOR rec_wgb_transaction IN cur_wgb_transaction LOOP
		INSERT INTO wgb_transaction (transaction_number, customer_number, account_type, transaction_amount, transaction_type, transaction_date) --Order of data being inputed.
			VALUES(gen_trans_numbers.NEXTVAL, rec_wgb_transaction.customer_number, rec_wgb_transaction.account_type, rec_wgb_transaction.transaction_amount, rec_wgb_transaction.transaction_type, SYSDATE); --What to put into the table
			
		IF rec_wgb_transaction.transaction_type = v_type_credit THEN --check if transaction_type is a credit or a debit
			UPDATE wgb_assets
				SET amount = amount + rec_wgb_transaction.transaction_amount;
			UPDATE wgb_account
				SET balance = balance + rec_wgb_transaction.transaction_amount
				WHERE rec_wgb_transaction.customer_number = customer_number
				AND rec_wgb_transaction.account_type = account_type;
		ELSIF rec_wgb_transaction.transaction_type = v_type_debit THEN --check if transaction_type is a credit or a debit
			UPDATE wgb_assets
				SET amount = amount - rec_wgb_transaction.transaction_amount;
			UPDATE wgb_account
				SET balance = balance - rec_wgb_transaction.transaction_amount
				WHERE rec_wgb_transaction.customer_number = customer_number
				AND rec_wgb_transaction.account_type = account_type;
		END IF;
		COMMIT;
	END LOOP;
	COMMIT;
END;
/

SELECT * FROM wgb_transaction;
SELECT * FROM wgb_account;
SELECT SUM(balance) FROM wgb_account;
SELECT SUM(amount) FROM wgb_assets;

SPOOL OFF;
