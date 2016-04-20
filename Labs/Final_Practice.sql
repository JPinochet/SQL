ALTER TABLE cp_category
  ADD CONSTRAINT cp_category_pk PRIMARY KEY (category_code);
  
ALTER TABLE cp_customer
  ADD CONSTRAINT customer_no PRIMARY KEY (customer_no);
  
ALTER TABLE cp_overdue_log
  ADD CONSTRAINT cp_overdue_log_pk PRIMARY KEY(customer_no, tape_number);
  
ALTER TABLE cp_price
  ADD CONSTRAINT cp_price_pk PRIMARY KEY(rental_class);
  
ALTER TABLE cp_rental
  ADD CONSTRAINT cp_rental_pk PRIMARY KEY(customer_no, tape_number, date_out);  

ALTER TABLE cp_returns
  ADD CONSTRAINT cp_returns_pk PRIMARY KEY(tape_number, actual_date_returned);
  
ALTER TABLE cp_tape
  ADD CONSTRAINT cp_tape_pk PRIMARY KEY(tape_number);
  
ALTER TABLE cp_title
  ADD CONSTRAINT cp_title_pk PRIMARY KEY(title_code);
  
ALTER TABLE cp_title
  ADD CONSTRAINT cp_title_category_fk FOREIGN KEY (category_code) REFERENCES cp_category(category_code);
  
ALTER TABLE cp_overdue_log
  ADD CONSTRAINT cp_overdue_customer_fk FOREIGN KEY (customer_no) REFERENCES cp_customer(customer_no);
  
ALTER TABLE cp_overdue_log
  ADD CONSTRAINT cp_overdue_tape_fk FOREIGN KEY (tape_number) REFERENCES cp_tape(tape_number);
  
ALTER TABLE cp_rental
  ADD CONSTRAINT cp_rental_customer_fk FOREIGN KEY (customer_no) REFERENCES cp_customer(customer_no);
  
ALTER TABLE cp_rental
  ADD CONSTRAINT cp_rental_tape_fk FOREIGN KEY (tape_number) REFERENCES cp_tape(tape_number);
  
ALTER TABLE cp_returns
  ADD CONSTRAINT cp_returns_tape_fk FOREIGN KEY (tape_number) REFERENCES cp_tape(tape_number);
  
ALTER TABLE cp_tape
  ADD CONSTRAINT cp_tape_title_fk FOREIGN KEY (title_code) REFERENCES cp_title(title_code);
  
  

SELECT t.film_title
  FROM cp_title t 
  WHERE category_code LIKE 8;
  
INSERT INTO cp_customer (customer_no, name, address_1)
  VALUES(001, 'Jorge', '123 fakestreet');
  
SELECT 