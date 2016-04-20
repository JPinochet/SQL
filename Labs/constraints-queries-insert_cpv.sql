ALTER TABLE cp_category
ADD CONSTRAINT cp_category_pk PRIMARY KEY(category_code);

ALTER TABLE cp_customer
ADD CONSTRAINT cp_customer_pk PRIMARY KEY(customer_no);
 
ALTER TABLE cp_price
ADD CONSTRAINT cp_price_pk PRIMARY KEY(rental_class);

ALTER TABLE cp_rental
ADD CONSTRAINT cp_rental_pk PRIMARY KEY(tape_number, customer_no, date_out);

ALTER TABLE cp_tape
ADD CONSTRAINT cp_tape_pk PRIMARY KEY(tape_number);

ALTER TABLE cp_title
ADD CONSTRAINT cp_title_pk PRIMARY KEY(title_code);


ALTER TABLE cp_overdue_log
ADD CONSTRAINT cp_overdue_log_fk FOREIGN KEY(customer_no)
REFERENCES cp_customer(customer_no);

ALTER TABLE cp_overdue_log
ADD CONSTRAINT cp_overdue_log_fk FOREIGN KEY(tape_number)
REFERENCES cp_tape(tape_number);

ALTER TABLE cp_rental
ADD CONSTRAINT cp_rental_fk FOREIGN KEY(customer_no)
REFERENCES cp_customer(customer_no);

ALTER TABLE cp_rental
ADD CONSTRAINT cp_rental_fk FOREIGN KEY(tape_number)
REFERENCES cp_tape(tape_number);

ALTER TABLE cp_returns
ADD CONSTRAINT cp_returns_fk FOREIGN KEY(tape_number)
REFERENCES cp_tape(tape_number);

ALTER TABLE cp_tape
ADD CONSTRAINT cp_tape_fk FOREIGN KEY(rental_class)
REFERENCES cp_price(rental_class);

ALTER TABLE cp_title
ADD CONSTRAINT cp_title_fk FOREIGN KEY(category_code)
REFERENCES cp_category(category_code);

--Queries
SELECT title_code, category_code
 FROM cp_title
 WHERE category_code = 8;
 
SELECT customer_no, name
  FROM cp_customer
 WHERE area_code = 416
   AND UPPER(credit_card) = 'VI' 
    OR UPPER(credit_card) = 'AX'
   AND expiry_date >= '01-JAN-04';

SELECT c.category_description, c.category_code, ct.title_code
  FROM cp_category c JOIN cp_title ct ON c.category_code=ct.category_code(+)
 WHERE runtime = (SELECT MIN(runtime) 
                     FROM cp_title)
 ORDER BY category_code;
 
UPDATE cp_returns
  SET actual_date_returned = SYSDATE
  Where actual_date_returned IN(SELECT actual_date_returned
                                  FROM cp_returns
                                   WHERE actual_date_returned = NULL);
                      
--Insertions 
INSERT INTO cp_customer
(customer_no, name)
VALUES ('989', 'Kerri');


