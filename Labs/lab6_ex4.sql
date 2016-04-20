--3-3
SET SERVEROUTPUT ON;

VARIABLE g_shopper NUMBER;

DECLARE
 lv_total_num NUMBER(6,2);
 lv_rating_txt VARCHAR2(4);
BEGIN
  :g_shopper := 22;
 SELECT SUM(total)
  INTO lv_total_num
  FROM bb_basket
  WHERE idShopper = :g_shopper
    AND orderplaced = 1
  GROUP BY idshopper;
  IF lv_total_num > 200 THEN
    lv_rating_txt := 'High';
  ELSIF lv_total_num >= 100 AND lv_total_num >= 200 THEN
    lv_rating_txt := 'Mid';
  ELSIF lv_total_num < 100 THEN
    lv_rating_txt := 'Low';
  END IF; 
   DBMS_OUTPUT.PUT_LINE('Shopper '||:g_shopper||' is rated '||lv_rating_txt);
   DBMS_OUTPUT.PUT_LINE(lv_total_num);
END;
/

--Confirm
SELECT SUM(total)
  FROM bb_basket
  WHERE idShopper = 22
    AND orderplaced = 1
  GROUP BY idshopper;
  
--3-4
SET SERVEROUTPUT ON;

VARIABLE g_shopper NUMBER;

DECLARE
 lv_total_num NUMBER(6,2);
 lv_rating_txt VARCHAR2(4);
BEGIN
  :g_shopper := 22;
  SELECT SUM(total)
  INTO lv_total_num
  FROM bb_basket
  WHERE idShopper = :g_shopper
    AND orderplaced = 1
  GROUP BY idshopper;
  CASE
    WHEN lv_total_num < 100 THEN 
      lv_rating_txt := 'Low';
    WHEN lv_total_num >= 100 AND lv_total_num <=200 THEN
      lv_rating_txt := 'Med';
    WHEN lv_total_num > 200 THEN
      lv_rating_txt := 'High';
  END CASE;
  DBMS_OUTPUT.PUT_LINE('Shopper '||:g_shopper||' is rated '||lv_rating_txt);
   DBMS_OUTPUT.PUT_LINE(lv_total_num);
END;
/

--Confirm
SELECT SUM(total)
  FROM bb_basket
  WHERE idShopper = 22
    AND orderplaced = 1
  GROUP BY idshopper;

--4-1
SET SERVEROUTPUT ON;

VARIABLE g_basket NUMBER;

BEGIN 
  :g_basket := 6;
END;
/

DECLARE
   CURSOR cur_basket IS
     SELECT bi.idBasket, bi.quantity, p.stock
       FROM bb_basketitem bi INNER JOIN bb_product p
         USING (idProduct)
       WHERE bi.idBasket = :g_basket;
   TYPE type_basket IS RECORD (
     basket bb_basketitem.idBasket%TYPE,
     qty bb_basketitem.quantity%TYPE,
     stock bb_product.stock%TYPE);
   rec_basket type_basket;
   lv_flag_txt CHAR(1) := 'Y';
BEGIN
   OPEN cur_basket;
   LOOP 
     FETCH cur_basket INTO rec_basket;
      EXIT WHEN cur_basket%NOTFOUND;
      IF rec_basket.stock < rec_basket.qty THEN lv_flag_txt := 'N'; END IF;
   END LOOP;
   CLOSE cur_basket;
   IF lv_flag_txt = 'Y' THEN DBMS_OUTPUT.PUT_LINE('All items in stock!'); END IF;
   IF lv_flag_txt = 'N' THEN DBMS_OUTPUT.PUT_LINE('All items NOT in stock!'); END IF;   
END;
/

--4-2
DECLARE
   CURSOR cur_shopper IS
     SELECT a.idShopper, a.promo,  b.total                          
       FROM bb_shopper a, (SELECT b.idShopper, SUM(bi.quantity*bi.price) total
                            FROM bb_basketitem bi, bb_basket b
                            WHERE bi.idBasket = b.idBasket
                            GROUP BY idShopper) b
        WHERE a.idShopper = b.idShopper
     FOR UPDATE OF a.idShopper NOWAIT;
   lv_promo_txt CHAR(1);
BEGIN
  FOR rec_shopper IN cur_shopper LOOP
   lv_promo_txt := 'X';
   IF rec_shopper.total > 100 THEN 
          lv_promo_txt := 'A';
   END IF;
   IF rec_shopper.total BETWEEN 50 AND 99 THEN 
          lv_promo_txt := 'B';
   END IF;   
   IF lv_promo_txt <> 'X' THEN
     UPDATE bb_shopper
      SET promo = lv_promo_txt
      WHERE CURRENT OF cur_shopper;
   END IF;
  END LOOP;
  COMMIT;
END;
/

--Case 4-2
SET SERVEROUTPUT ON;

ALTER TABLE mm_movie
  ADD stk_flag CHAR;
  
DECLARE
  lv_threshold CONSTANT NUMBER := 75;
  CURSOR movies IS 
    SELECT movie_value, movie_qty
      FROM mm_movie
    FOR UPDATE;
BEGIN
  FOR something IN movies LOOP
    IF something.movie_value*something.movie_qty >= lv_threshold THEN
      UPDATE mm_movie
        SET stk_flag = '*'
        WHERE CURRENT OF movies;
    ELSE
      UPDATE mm_movie
        SET stk_flag = NULL
        WHERE CURRENT OF movies;
     END IF;
   END LOOP;
   COMMIT;
END;
/
