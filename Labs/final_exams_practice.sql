DROP TABLE ata_location;
DROP TABLE ata_performance_info;

CREATE TABLE ata_location
(id           NUMBER,
  name        VARCHAR2(30),
  addr        VARCHAR2(30),
  numGuests   NUMBER,
  CONSTRAINT ata_location_pk PRIMARY KEY(id)
);
  
ALTER TABLE ata_location 
  MODIFY name
    CONSTRAINT name_nn NOT NULL;
ALTER TABLE ata_location 
  ADD CONSTRAINT numGuests_ck
    CHECK(numGuests > 0);
    
INSERT INTO ata_location (id, name)
  VALUES(001, 'joey joe joe');

UPDATE ata_contract
  SET FEE = FEE*1.1;
  
UPDATE ata_contract
  SET FEE = FEE*1.05
  FROM ata_contract c, ata_entertainer e, ata_entertainers_style es
  WHERE c.entertainer_id = e.entertainer_id
  AND e.entertainer_id = es.entertainer_id
  AND LOWER(style_code) LIKE ('cw');
  
UPDATE ata_contract
  SET FEE = FEE * 1.05
  WHERE entertainer_id IN (SELECT e.entertainer_id
          FROM ata_entertainer e JOIN ata_entertainers_style es ON  e.entertainer_id = es.entertainer_id
          WHERE LOWER(style_code) = 'cw');
    
CREATE TABLE ata_performance_info AS
  SELECT c.first_name ||' '|| c.last_name client_name, performance_date, e.first_name ||' '|| e.last_name entertainer_name
    FROM ata_client c JOIN ata_contract co ON c.client_id = co.client_id
      JOIN ata_entertainer e ON co.entertainer_id  =e.entertainer_id
      JOIN ata_performance p ON p.contract_number = co.contract_number;