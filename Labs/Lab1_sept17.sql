--Task 1
CREATE SEQUENCE seq_movie_id
INCREMENT BY 5
START WITH 20;

--Task 2
--INTO SYS USER
USER_SEQUENCES;

--Task 3
INSERT INTO mm_movie 
  (movie_id, movie_title, movie_cat_id)
  VALUES (seq_movie_id.NEXTVAL, 'The dark knight', 1);
  
--Task 4
CREATE OR REPLACE VIEW vw_movie_rental
(movie_title, movie_category, checkin_date) AS 
(SELECT m.movie_title, mt.movie_category, mr.checkin_date
  FROM mm_movie m JOIN mm_movie_type mt ON m.movie_cat_id = mt.movie_cat_id
    JOIN mm_rental mr ON m.movie_id = mr.movie_id
    WHERE mr.checkin_date IS NULL);

--Task 5
INSERT INTO vw_movie_rental (movie_title, movie_category)
  VALUES('9', 'Drama');

--Task 6
CREATE OR REPLACE VIEW vw_customer_information
(customer_number, first_name, last_name, city, province, phone_number) AS
(SELECT customer_number, first_name, surname AS last_name, city, province, area_code || phone AS phone_number
FROM wgb_customer)
WITH READ ONLY;

--Task 7
INSERT INTO vw_customer_information (customer_number, first_name, last_name, city, province)
  VALUES(3333331, 'Jorge', 'Pinochet', 'Calgary', 'AB'); 

--Task 8
CREATE PUBLIC SYNONYM a_type
  FOR wgb_account_type;