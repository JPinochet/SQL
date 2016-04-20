/*
   1.  Challenge 2-1 on page 45.
   2. Challenge 2-2 on page 45.
   3. Challenge 2-3 on page 46.
   4. Challenge 3-1 on page 78.
   5. Challenge 3-2 on page 83.
   6. Challenge 3-3 on page 84.
   7. Challenge 3-7 on page 90.
   8. Challenge 3-8 on page 94.
   9. Challenge 3-9 on page 94.

*/

--2-1
SET SERVEROUT ON
DECLARE 
  bb_billing_date       DATE:='21-OCT-2007';
  bb_last_name          VARCHAR2(25);
  bb_credit_balance     NUMBER(2,5):=1000;
BEGIN
  DBMS_OUTPUT.PUT_LINE(bb_billing_date);
  DBMS_OUTPUT.PUT_LINE(bb_credit_balance);
END;
/

--2-2
SET SERVEROUT ON
DECLARE
  bb_newsletter_mail CHAR NOT NULL:='Y';
  bb_balance_owed       NUMBER(6,2):=1200;
  bb_min_pmt_rate  CONSTANT  NUMBER(2,2):=.05;
  bb_amnt_paid          NUMBER(6,2);
BEGIN
  bb_amnt_paid:=bb_balance_owed*bb_min_pmt_rate;
  bb_newsletter_mail:='N';
  DBMS_OUTPUT.PUT_LINE(bb_amnt_paid);
  DBMS_OUTPUT.PUT_LINE(bb_newsletter_mail);
END;
/

--2-3
SET SERVEROUT ON
DECLARE
  bb_promo_code VARCHAR2(25):='A0807X';
  bb_promo_month  NUMBER(2);
  bb_promo_year   NUMBER(4);
BEGIN
  bb_promo_month:=SUBSTR(bb_promo_code, 2, 2);
  bb_promo_year:=SUBSTR(bb_promo_code, 4, 2);
END;
/

--3-1
SET SERVEROUT ON
DECLARE
  bb_purchase_info  VARCHAR2(25);
  bb_purchase_id    VARCHAR2(25);
BEGIN
 SELECT  total, idbasket
      INTO bb_purchase_info, bb_purchase_id
      FROM bb_basket
      WHERE idbasket=10;
END;
/

--3-2

VARIABLE g_bskt_id VARCHAR2(25);


SET SERVEROUT ON
BEGIN
  SELECT idbasket
    INTO  :g_bskt_id 
    FROM bb_basket
    WHERE idbasket=10;
END;
/

--3-3
SET SERVEROUT ON
DECLARE
  bb_purchase_info  bb_basket.total%TYPE;
  bb_purchase_id    bb_basket.idbasket%TYPE;
BEGIN
 SELECT  total, idbasket
      INTO bb_purchase_info, bb_purchase_id
      FROM bb_basket
      WHERE idbasket=10;
END;
/

--3-7
VARIABLE g_first VARCHAR2(15);
VARIABLE g_last VARCHAR2(20);
VARIABLE g_email VARCHAR2(25);

BEGIN 
  :g_first := 'Jeffrey';
  :g_last := 'Brand';
  :g_email  := 'jbrand@site.com';
END;
/

BEGIN
  INSERT INTO bb_shopper (idshopper, firstname, lastname, email)
  VALUES (bb_shopper_seq.NEXTVAL,:g_first,:g_last,:g_email);
  COMMIT;
END;
/

SELECT idshopper, firstname, lastname, email
  FROM bb_shopper
  WHERE lastname = 'Brand';
  
VARIABLE g_prev_shopper_id VARCHAR2(25);

BEGIN
  DELETE FROM bb_shopper
  WHERE idshopper = 30;
END;
/

--3-8
SET SERVEROUT ON
DECLARE
  rec_basket bb_basket%ROWTYPE;
BEGIN
  SELECT *
    INTO  rec_basket
    FROM bb_basket
    WHERE idbasket=10;
END;
/

--3-9
VARIABLE g_basketitem_id VARCHAR2(25);

SET SERVEROUT ON
DECLARE
  rec_basketitem bb_basketitem%ROWTYPE;
BEGIN
  SELECT *
    INTO rec_basketitem
    FROM bb_basketitem
    WHERE idproduct = :g_basketitem_id;
  DBMS_OUTPUT.PUT_LINE(rec_basketitem.idproduct);
  DBMS_OUTPUT.PUT_LINE(rec_basketitem.price);
END;
/
