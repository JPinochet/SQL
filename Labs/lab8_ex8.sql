SET SERVEROUTPUT ON

CREATE OR REPLACE FUNCTION bb_basketitem_subtotal (bb_idbasket NUMBER)
	RETURN NUMBER
	IS
		lv_bb_subtotal NUMBER(5,2);
	BEGIN
		SELECT SUM(price * quantity)
			INTO lv_bb_subtotal
			FROM bb_basketitem
			WHERE idbasket = bb_idbasket;
		RETURN lv_bb_subtotal;
	END;
	/

CREATE OR REPLACE FUNCTION bb_basketitem_shipping_cost (bb_idbasket NUMBER)
	RETURN NUMBER
	IS
		lv_items_being_shipped	NUMBER(5,2);
		lv_bb_shipping_cost 	NUMBER(5,2);
	BEGIN
		SELECT SUM(quantity)
			INTO lv_items_being_shipped
			FROM bb_basketitem
			WHERE idbasket = bb_idbasket;
		IF lv_items_being_shipped >= 1 AND lv_items_being_shipped <= 4 THEN
			lv_bb_shipping_cost := 5;
		ELSIF lv_items_being_shipped >= 5 AND lv_items_being_shipped <= 9 THEN
			lv_bb_shipping_cost := 8;
		ELSIF lv_items_being_shipped >= 10 THEN
			lv_bb_shipping_cost := 11;
		ELSE
			lv_bb_shipping_cost := -1;
		END IF;
		RETURN lv_bb_shipping_cost;
	END;
	/

CREATE OR REPLACE FUNCTION bb_basketitem_total_with_tax (bb_subtotal NUMBER, bb_idbasket NUMBER)
	RETURN NUMBER
	IS
		lv_bb_tax 	NUMBER(5,2);
		lv_bb_taxrate		NUMBER(5,2);
	BEGIN
		SELECT taxrate
			INTO lv_bb_taxrate
			FROM bb_tax bt JOIN bb_basket bb ON bb.shipstate = bt.state
			WHERE bb.idbasket = bb_idbasket;
		lv_bb_tax := bb_subtotal * lv_bb_taxrate;
		RETURN lv_bb_tax;
	END;
	/

CREATE OR REPLACE PROCEDURE bb_check_out (bb_idbasket NUMBER)
	IS
		lv_subtotal			NUMBER(5,2);
		lv_shipping_cost 	NUMBER(5,2);	
		lv_tax				NUMBER(5,2);
	BEGIN
		lv_subtotal := bb_basketitem_subtotal(bb_idbasket);
		lv_shipping_cost := bb_basketitem_shipping_cost(bb_idbasket);
		IF lv_shipping_cost != -1 THEN
			lv_tax := bb_basketitem_total_with_tax(lv_subtotal, bb_idbasket);
			UPDATE bb_basket
				SET orderplaced = 1,
					subtotal = lv_subtotal,
					tax = lv_tax,
					shipping = lv_shipping_cost,
					total = lv_tax + lv_shipping_cost + lv_subtotal
				WHERE idbasket = bb_idbasket;
		ELSE
			DBMS_OUTPUT.PUT_LINE('Nothing being shipped');
		END IF;
		COMMIT;
	END;
	/
	
--Testing
UPDATE bb_basket
	SET orderplaced = NULL,
		subtotal = NULL,
		tax = NULL,
		shipping = NULL,
		total = NULL
	WHERE idbasket = 3;
COMMIT;
	