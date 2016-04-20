SET SERVEROUTPUT ON;

DROP TABLE bse_error_log;

CREATE TABLE bse_error_log
(trans_date	DATE,
 stock_code	VARCHAR2(3),
 seller		VARCHAR2(6),
 buyer		VARCHAR2(6),
 message	VARCHAR2(100));


DROP SEQUENCE bse_trans_number;

CREATE SEQUENCE bse_trans_number;


/* *****************************************************************
**
**	Purpose:  	Process stock selling and buying transactions.
**	
**	Created by:  	Nicole Berard
**	Date created:  	May 29, 2009
**
***************************************************************** */


DECLARE

	CURSOR c_in_trans IS
		SELECT *
			FROM bse_in_transactions_2;

	v_message			VARCHAR2(100);
	v_misc_count		NUMBER;

	v_ytd_high			bse_stock.ytd_high%TYPE;
	v_ytd_low			bse_stock.ytd_low%TYPE;

	v_account_bal		bse_client.account_balance%TYPE;
	v_quant_held		bse_portfolio.quantity_held%TYPE;

	k_buyer_value		CONSTANT NUMBER := 1.01;
	k_seller_value		CONSTANT NUMBER := 0.99;
	
	v_stock_issued		NUMBER;
	v_stock_authorized	NUMBER;
	v_client_no			NUMBER;

BEGIN
	FOR r_in_trans IN c_in_trans LOOP
		BEGIN
		
			BEGIN
				SELECT shares_issued, shares_authorized
					INTO v_stock_issued, v_stock_authorized
					FROM bse_stock
					WHERE r_in_trans.stock_code = stock_code;
				IF v_stock_authorized > v_stock_issued THEN
					RAISE_APPLICATION_ERROR(-20004,'Seller has insufficient stock quantity');
				END IF;
			EXCEPTION
				WHEN NO_DATA_FOUND THEN
					RAISE_APPLICATION_ERROR(-20003,'Incorrect stock code');
			END;

		
			BEGIN
				SELECT client_no
					INTO v_client_no
					FROM bse_client
					WHERE r_in_trans.buyer = client_no;
			EXCEPTION
				WHEN NO_DATA_FOUND THEN
					RAISE_APPLICATION_ERROR(-20002,'Buyer does not exist');
				WHEN OTHERS THEN
					DBMS_OUTPUT.PUT_LINE(SQLERRM);
			END;



			
			BEGIN
				SELECT client_no
					INTO v_client_no
					FROM bse_client
					WHERE r_in_trans.seller = client_no;
			EXCEPTION
				WHEN NO_DATA_FOUND THEN
					RAISE_APPLICATION_ERROR(-20001,'Seller does not exist');
			END;
			
			BEGIN
				SELECT quantity_held
					INTO v_stock_authorized
					FROM bse_portfolio
					WHERE r_in_trans.seller = client_no
					AND r_in_trans.stock_code = stock_code
					AND quantity_held > 0;
			EXCEPTION
				WHEN NO_DATA_FOUND THEN
					RAISE_APPLICATION_ERROR(-20005,'Seller does not own stock.');
			END;
			
			BEGIN
				SELECT account_balance
					INTO v_stock_authorized
					FROM bse_client
					WHERE r_in_trans.buyer = client_no
					AND account_balance >= (r_in_trans.price * r_in_trans.quantity * k_buyer_value);
			EXCEPTION
				WHEN NO_DATA_FOUND THEN
					RAISE_APPLICATION_ERROR(-20006,'Buyer does not have enough funds on hand');
			END;

/* *****************************************************************
**
**	Insert transaction into bse_transaction table
**
***************************************************************** */

			INSERT INTO bse_transaction
				VALUES(bse_trans_number.NEXTVAL,r_in_trans.trans_date,r_in_trans.stock_code,r_in_trans.seller,r_in_trans.buyer,r_in_trans.price,r_in_trans.quantity);

/* *****************************************************************
**
**	Start:  Calculation to determine current 
**	        ytd_high, and ytd_low
**
***************************************************************** */

		SELECT ytd_high, ytd_low
			INTO v_ytd_high, v_ytd_low
	        FROM bse_stock
			WHERE stock_code = r_in_trans.stock_code;

		IF v_ytd_high < r_in_trans.price THEN
		   v_ytd_high := r_in_trans.price;
		END IF;


		IF v_ytd_low > r_in_trans.price THEN
	   	   v_ytd_low := r_in_trans.price;
		END IF;

/* *****************************************************************
**
**	End:  Calculation to determine current 
**	        ytd_high, and ytd_low
**
***************************************************************** */

/* *****************************************************************
**
**	Update bse_stock table with new values
**
***************************************************************** */

		UPDATE bse_stock
			SET last_price_traded = r_in_trans.price,
		       ytd_high = v_ytd_high,
		       ytd_low  = v_ytd_low
			WHERE stock_code = r_in_trans.stock_code;

/* *****************************************************************
**
**	Update account_balance for the buyer in bse_client table
**
***************************************************************** */

		UPDATE bse_client
			SET account_balance = account_balance - (r_in_trans.price * r_in_trans.quantity * k_buyer_value)
			WHERE client_no = r_in_trans.buyer;

/* *****************************************************************
**
**	Update quantity_held for the buyer in bse_portfolio table
**
***************************************************************** */

		UPDATE bse_portfolio
			SET quantity_held = quantity_held + r_in_trans.quantity
	        WHERE stock_code = r_in_trans.stock_code
			AND client_no = r_in_trans.buyer;

	/* *****************************************************************
	**
	**	Add buyer record if it does not already exist
	**
	***************************************************************** */

		IF SQL%NOTFOUND THEN
			INSERT INTO bse_portfolio
		    VALUES(r_in_trans.buyer, r_in_trans.stock_code, r_in_trans.quantity);
		END IF;


/* *****************************************************************
**
**	Update account_balance for the seller in bse_client table
**
***************************************************************** */

		UPDATE bse_client
			SET account_balance = account_balance + (r_in_trans.price * r_in_trans.quantity * k_seller_value)
			WHERE client_no = r_in_trans.seller;

/* *****************************************************************
**
**	Update quantity_held for the seller in bse_portfolio table
**
***************************************************************** */

		UPDATE bse_portfolio
			SET quantity_held = quantity_held - r_in_trans.quantity
				WHERE stock_code = r_in_trans.stock_code
				AND client_no = r_in_trans.seller;
			COMMIT;
		END;
	  
	END LOOP;
	
	EXCEPTION
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
