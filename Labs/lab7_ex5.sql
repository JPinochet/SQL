--4-4
SET SERVEROUTPUT ON;

VARIABLE g_state CHAR(2);

BEGIN
  :g_state := 'NJ';
END;
/

DECLARE
  lv_tax_num NUMBER(2,2);
BEGIN
 CASE :g_state
  WHEN 'VA' THEN lv_tax_num := .04;
  WHEN 'NC' THEN lv_tax_num := .02;  
  WHEN 'NY' THEN lv_tax_num := .06;  
 END CASE;
 DBMS_OUTPUT.PUT_LINE('tax rate = '||lv_tax_num);
END;
/

--4-5
SET SERVEROUTPUT ON;

VARIABLE g_shopper NUMBER;

DECLARE
 rec_shopper bb_shopper%ROWTYPE;
BEGIN
  :g_shopper := 99;
 SELECT *
  INTO rec_shopper
  FROM bb_shopper
  WHERE idShopper = :g_shopper;
  EXCEPTION 
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Invalid shopper ID');
END;
/

--4-6
SET SERVEROUTPUT ON;

ALTER TABLE bb_basketitem
  ADD CONSTRAINT bitems_qty_ck CHECK (quantity < 20);

DECLARE
  too_many_update EXCEPTION;
  PRAGMA EXCEPTION_INIT(too_many_update, -02290);
BEGIN
  INSERT INTO bb_basketitem 
   VALUES (88,8,10.8,21,16,2,3);
  EXCEPTION
    WHEN too_many_update THEN
      DBMS_OUTPUT.PUT_LINE('Check quantity');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Wrong error catched this');
END;
/

--4-7
SET SERVEROUTPUT ON;

VARIABLE g_old NUMBER;
VARIABLE g_new NUMBER;

DECLARE 
  no_idbasket_match EXCEPTION;
  no_idbasket EXCEPTION;
BEGIN
  :g_old := 30;
  :g_new := 4;
  
  UPDATE bb_basketitem
   SET idBasket = :g_new
   WHERE idBasket = :g_old;
   IF SQL%NOTFOUND THEN
    RAISE no_idbasket;
   ELSIF :g_new = :g_old THEN
    RAISE no_idbasket_match;
   END IF;
   EXCEPTION
    WHEN no_idbasket THEN
      DBMS_OUTPUT.PUT_LINE('Invalid original basket id');
    WHEN no_idbasket_match THEN
      DBMS_OUTPUT.PUT_LINE('Ids do not match');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Wrong error catched this');
END;
/

--4-7-b
SET SERVEROUTPUT ON;

VARIABLE g_old NUMBER;
VARIABLE g_new NUMBER;

DECLARE
  no_idbasket EXCEPTION;
BEGIN
  :g_old := 30;
  :g_new := 4;
  
	UPDATE bb_basketitem
		SET idBasket = :g_new
		WHERE idBasket = :g_old;
	IF SQL%NOTFOUND THEN
		RAISE_APPLICATION_ERROR(-20001, 'Invalid original basket id');
	END IF;
	EXCEPTION
		WHEN OTHERS THEN
			DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/
