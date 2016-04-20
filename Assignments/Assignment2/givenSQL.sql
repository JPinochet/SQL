/* ****************************************************************************
**
**	File:  		LA2_create.sql
**	Author:  	Nicole Berard
**	Created: 	June 5, 2009
**	Description:	Will create tables (NEW_REGISTRATION and ERROR_LOG).
**	Update History:
**
** ************************************************************************* */



DROP TABLE error_log;
DROP TABLE new_registration;

CREATE TABLE error_log AS
  SELECT *
    FROM course_registration
   WHERE 1=2;

ALTER TABLE error_log
 ADD transaction_type VARCHAR2(2)
 ADD message VARCHAR2(200);

CREATE TABLE new_registration AS
  SELECT *
    FROM course_registration
   WHERE 1=2;

ALTER TABLE new_registration
  ADD transaction_type VARCHAR2(2);

INSERT INTO new_registration
 VALUES
 ('382938', 'CMPP201','1FC','1','1994',NULL,'N');

INSERT INTO new_registration
 VALUES
 ('000509082', 'CMPK201','1FC','1','1994',NULL,'N');

INSERT INTO new_registration
 VALUES
 ('000612345','MATH215','1FB','1','1994',NULL,'N');

INSERT INTO new_registration
 VALUES
 ('000600189','MATH235','1FC','2','1994',NULL,'N');

INSERT INTO new_registration
 VALUES
 ('000600189','CMPP230','1FC','1','1994',NULL,'N');


INSERT INTO new_registration
 VALUES
 ('000600189','MATH235','1FC','2','1994',86,'UG');

INSERT INTO new_registration
 VALUES
 ('001500026','MATH215','1FC','1','1993',NULL,'UG');

INSERT INTO new_registration
 VALUES
 ('34500026','MATH215','1FC','1','1993',43,'UG');

INSERT INTO new_registration
 VALUES
 ('34500026','MATH215','1FC','1','1993',NULL,'D');

INSERT INTO new_registration
 VALUES
 ('002502060','ENGL201','1WA','1','1994',NULL,'D');

INSERT INTO new_registration
 VALUES
 ('000600189','MATH235','1FC','2','1994',NULL,'D');


COMMIT;

