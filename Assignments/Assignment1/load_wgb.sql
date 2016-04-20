/*  This file is used to initialize the Walnut Grove Bank database
    in preparation for testing PL/SQL procedures.  There should be
    no errors encountered in the running of this file.        */

delete from WGB_ASSETS;
delete from WGB_TRANSACTION;
delete from WGB_ACCOUNT;
delete from WGB_CUSTOMER;
DELETE FROM wgb_account_type;

insert into WGB_CUSTOMER values (
'1112401', 'Synge', 'John', 'L.', 'Apt 201', '279 Humber Rd', 
'Harrison', 'AB', 'T9A4X4', 403, '5210001', SYSDATE - 8);

insert into WGB_CUSTOMER values (
'1113004',  'Griffith', 'Byron', 'Allen', '7 Back street', null,  
'Walnut Grove', 'AB', 'T8B5A6', 403, '6332112', sysdate - 3);

insert into WGB_CUSTOMER values (
'1113501', 'Poincare', 'Henri', 'Dumont', 'Box 5', null, 
'Eyebrow', 'SK', 'S7K7Y8', 306, '7274036', sysdate - 3);

insert into WGB_CUSTOMER values (
'2566217', 'Chen', 'Peter', 'C.', '19 Redstone Path', null, 
'Rosebud', 'AB', 'T6B0L1', 403, '6520128', sysdate - 1);

insert into WGB_CUSTOMER values (
'9871332', 'Lee', 'Patricia', null, '6 Front Street', null, 
'Walnut Grove', 'AB', 'T8B5A8', 403, '6332112', sysdate - 1);


commit;

INSERT INTO wgb_account_type VALUES (1, 'Chequing');
INSERT INTO wgb_account_type VALUES (2, 'Daily Interest Savings');
INSERT INTO wgb_account_type VALUES (3, 'Monthly Minimum Balance Savings');
INSERT INTO wgb_account_type VALUES (4, 'RRSP''s');
INSERT INTO wgb_account_type VALUES (5, 'GIC''s');

COMMIT;


insert into WGB_ACCOUNT values ('1112401', 1, sysdate - 8, 0);

insert into WGB_ACCOUNT values ('1112401', 2, sysdate - 7, 0);

insert into WGB_ACCOUNT (CUSTOMER_NUMBER, ACCOUNT_TYPE,
			 DATE_CREATED)
			values ('1113004', 3, sysdate - 3);

insert into WGB_ACCOUNT values ('1113501', 1, sysdate - 3, 0);

insert into WGB_ACCOUNT values ('1113501', 2, sysdate - 3, 0);

insert into WGB_ACCOUNT (CUSTOMER_NUMBER, ACCOUNT_TYPE,
			 DATE_CREATED)
			values ('1113501', 3, sysdate - 2);

insert into WGB_ACCOUNT values ('1113501', 5, sysdate - 3, 0);

insert into WGB_ACCOUNT values ('2566217', 1, sysdate - 1, 0);

insert into WGB_ACCOUNT values ('2566217', 4, sysdate - 1, 0);

insert into WGB_ACCOUNT values ('9871332', 3, sysdate - 1, 0);


commit;

insert into WGB_ASSETS (amount) values ( 0);

commit;


insert into WGB_TRANSACTION values (
1,'1112401', 1, 5000.00, 'C', sysdate - 1);

insert into WGB_TRANSACTION values (
2,'1112401', 2, 6000.00, 'C', sysdate - 1);


insert into WGB_TRANSACTION values (
4,'1113501', 2, 3000.00, 'C', sysdate);


insert into WGB_TRANSACTION values (
6,'1112401', 2, 1000.00, 'D', sysdate);

insert into WGB_TRANSACTION values (
7,'1112401', 1, 6000.00, 'C', sysdate);


insert into WGB_TRANSACTION values (
8,'1113004', 3, 2000.00, 'C', sysdate);


commit;


update WGB_ACCOUNT A
	set BALANCE =  (SELECT sum (TRANSACTION_AMOUNT*
			decode(TRANSACTION_TYPE, 'D', -1, 'C', 1))
			from WGB_TRANSACTION
			where CUSTOMER_NUMBER = A.CUSTOMER_NUMBER and
			      ACCOUNT_TYPE = A.ACCOUNT_TYPE);

update WGB_ACCOUNT
	set BALANCE = 0
where BALANCE is null;


update WGB_ASSETS
set AMOUNT = (
	select sum (BALANCE) from WGB_ACCOUNT);

select * from WGB_ASSETS;

set echo off

column surname format a20
column first_name format a20
set linesize 65

set heading off
select 'Customers' from dual;
set heading on

select customer_number, surname, first_name, date_entered
from wgb_customer
order by customer_number;

set heading off
select 'Accounts' from dual;
set heading on
select * from wgb_account
order by customer_number, account_type;

set heading off
select 'Transactions' from dual;
set heading on

select * from wgb_transaction
order by customer_number, account_type;


clear columns






