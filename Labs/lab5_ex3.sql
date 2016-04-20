--Lab Exercise 3
--2-1
SET SERVEROUTPUT ON;

DECLARE
  lv_test_date DATE := '10-Dec-01';
  lv_test_num CONSTANT NUMBER(3) := 10;
  lv_test_txt   VARCHAR2(10);
  
BEGIN
  lv_test_txt := 'Pinochet';
  DBMS_OUTPUT.PUT_LINE(lv_test_txt);
  DBMS_OUTPUT.PUT_LINE(lv_test_date);
  DBMS_OUTPUT.PUT_LINE(lv_test_num);
END;
/

--3-1
SET SERVEROUTPUT ON

VARIABLE g_basket NUMBER
BEGIN
  :g_basket := 3;
END;
/
DECLARE
  lv_ship_date bb_basketstatus.dtstage%TYPE;
  lv_shipper_txt bb_basketstatus.shipper%TYPE;
  lv_ship_num bb_basketstatus.shippingnum%TYPE;
BEGIN
  SELECT dtstage, shipper, shippingnum
   INTO lv_ship_date, lv_shipper_txt, lv_ship_num
   FROM bb_basketstatus
   WHERE idbasket = :g_basket
    AND idstage = 5;
  DBMS_OUTPUT.PUT_LINE('Date Shipped: '||lv_ship_date);
  DBMS_OUTPUT.PUT_LINE('Shipper: '||lv_shipper_txt);
  DBMS_OUTPUT.PUT_LINE('Shipping #: '||lv_ship_num);
END;
/

SET SERVEROUTPUT ON

VARIABLE g_basket NUMBER
BEGIN
  :g_basket := 7;
END;
/
DECLARE
  lv_ship_date bb_basketstatus.dtstage%TYPE;
  lv_shipper_txt bb_basketstatus.shipper%TYPE;
  lv_ship_num bb_basketstatus.shippingnum%TYPE;
BEGIN
  SELECT dtstage, shipper, shippingnum
   INTO lv_ship_date, lv_shipper_txt, lv_ship_num
   FROM bb_basketstatus
   WHERE idbasket = :g_basket
    AND idstage = 5;
  DBMS_OUTPUT.PUT_LINE('Date Shipped: '||lv_ship_date);
  DBMS_OUTPUT.PUT_LINE('Shipper: '||lv_shipper_txt);
  DBMS_OUTPUT.PUT_LINE('Shipping #: '||lv_ship_num);
END;
/

--3-2
SET SERVEROUTPUT ON
VARIABLE g_basket NUMBER
BEGIN
  :g_basket := 3;
END;
/
DECLARE
  rec_ship bb_basketstatus%ROWTYPE;
BEGIN
  SELECT *
   INTO rec_ship
   FROM bb_basketstatus
   WHERE idbasket = :g_basket
    AND idstage = 5;
  DBMS_OUTPUT.PUT_LINE('Date Shipped: '||rec_ship.dtstage);
  DBMS_OUTPUT.PUT_LINE('Shipper: '||rec_ship.shipper);
  DBMS_OUTPUT.PUT_LINE('Shipping #: '||rec_ship.shippingnum);
  DBMS_OUTPUT.PUT_LINE('Notes: '||rec_ship.notes);
END;
/

--3-7
SET SERVEROUTPUT ON;

VARIABLE g_basket NUMBER;
DECLARE
  lv_subtotal_num NUMBER;
  lv_shipping_num NUMBER;
  lv_tax          NUMBER;
  lv_total_num    NUMBER;
BEGIN 
  :g_basket := 12;
  SELECT idbasket, subtotal, shipping, tax, total
    INTO :g_basket, lv_subtotal_num, lv_shipping_num, lv_tax, lv_total_num
    FROM bb_basket
    WHERE idbasket = :g_basket;
    DBMS_OUTPUT.PUT_LINE(:g_basket);
    DBMS_OUTPUT.PUT_LINE(lv_subtotal_num);
    DBMS_OUTPUT.PUT_LINE(lv_shipping_num);
    DBMS_OUTPUT.PUT_LINE(lv_tax);
    DBMS_OUTPUT.PUT_LINE(lv_total_num);
END;
/
  
--3-8
SET SERVEROUTPUT ON;
DECLARE
  TYPE type_basket IS RECORD(
  idbasket bb_basket.idbasket%TYPE,
  subtotal bb_basket.subtotal%TYPE,
  shipping bb_basket.shipping%TYPE,
  tax bb_basket.tax%TYPE,
  total bb_basket.total%TYPE);
  rec_basket type_basket;
BEGIN
  SELECT idbasket, subtotal, shipping, tax, total
    INTO rec_basket
    FROM bb_basket
    WHERE idbasket = :g_basket;
    DBMS_OUTPUT.PUT_LINE('IDBASKET: ' ||rec_basket.idbasket);
    DBMS_OUTPUT.PUT_LINE('SubTotal: ' ||rec_basket.subtotal);
    DBMS_OUTPUT.PUT_LINE('Shipping: ' ||rec_basket.shipping);
    DBMS_OUTPUT.PUT_LINE('Tax: ' ||rec_basket.tax);
    DBMS_OUTPUT.PUT_LINE('Total: ' ||rec_basket.total);
END;
/
