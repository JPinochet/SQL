SPOOL D:\database\LabFinal1.out

SET ECHO ON


--Question 1
--1
CREATE TABLE part
(part_number      NUMBER(7,2),
  part_description  VARCHAR2(30),
  aisle             NUMBER(2),
  bin               NUMBER, 
  quantity_on_hand  NUMBER,
  re_order_point    NUMBER,
  CONSTRAINT part_pk PRIMARY KEY (part_number)
);

--2
CREATE TABLE supplier
(supplier_number    NUMBER(7,2) CONSTRAINT supplier_pk PRIMARY KEY,
  name              VARCHAR2(50),
  address           VARCHAR2(20),
  city              VARCHAR2(10),
  province          VARCHAR2(2),
  postal_code       VARCHAR2(6)
);

ALTER TABLE supplier
  MODIFY name
    CONSTRAINT name_nn NOT NULL;
    
--3
CREATE TABLE purchase_order
(order_number       NUMBER,
  order_date        DATE,
  supplier_number   NUMBER REFERENCES supplier(supplier_number),
  shipping_date     DATE,
  expected_delivery_date    DATE,
  part_number       NUMBER(7,2)
);

ALTER TABLE purchase_order
  ADD CONSTRAINT purchase_order_pk PRIMARY KEY(order_number);

ALTER TABLE purchase_order
  ADD CONSTRAINT purchase_order_part_fk FOREIGN KEY(part_number)
    REFERENCES part(part_number);

--Question 2
INSERT INTO part(part_number, part_description)
  VALUES (001, 'Jorge');

INSERT INTO supplier (supplier_number, name)
  VALUES (001, 'SAIT');
  
INSERT INTO purchase_order (order_number, supplier_number, part_number)
  VALUES (001, 001, 001);

--Question 3
CREATE TABLE new_accounts AS
  SELECT *
  FROM imp_account;
  
--Question 4
ALTER TABLE new_accounts 
   ADD start_date  DATE;

DESC new_accounts;

--Question 5
UPDATE new_accounts
  SET start_date = SYSDATE
  WHERE credit_limit IN (SELECT credit_limit
                            FROM new_accounts
                            WHERE credit_limit > 15000);
                            
                            
--Question 6
DROP TABLE new_accounts;
      
--Question 7
--In Booklet

--Question 8
--ON ANOTHER SHEET

--Question 9


SELECT last_name||', '|| first_name AS Name, a.account_number, cc.card_number, cc.card_type
FROM imp_person JOIN imp_account a ON person_id = a.owner_id
                 JOIN imp_credit_card cc ON a.account_number = cc.account_number
WHERE account_number IN (SELECT account_number
                            FROM imp_transaction
                            WHERE UPPER(transaction_type) IN 'D'
                            HAVING COUNT(card_number) > 1
                            GROUP BY account_number);

--Question 10
DELETE FROM imp_transaction
  WHERE transaction_date IN (SELECT transaction_date
                                  FROM imp_transaction
                                   WHERE transaction_date < TO_DATE('March 10, 2001','MONTH dd, yyyy'));

SPOOL OFF