drop table wgb_in_transactions;
drop table wgb_in_transactions_2;

create table wgb_in_transactions
(customer_number    varchar2(7),
 account_type       number(1),
 transaction_amount number(9,2),
 transaction_type   varchar2(2));

create table wgb_in_transactions_2
(customer_number    varchar2(7),
 account_type       number(1),
 transaction_amount number(9,2),
 transaction_type   varchar2(2));

insert into wgb_in_transactions
 values ('1112401',2,3000,'C');

insert into wgb_in_transactions
 values ('1113501',1,567.25,'C');

insert into wgb_in_transactions
 values ('1113501',1,257.02,'C');

insert into wgb_in_transactions
 values ('1113501',1,300,'D');

insert into wgb_in_transactions
 values ('2566217',4,9800,'C');

insert into wgb_in_transactions
 values ('2566217',4,2200,'C');

insert into wgb_in_transactions
 values ('2566217',4,2000,'D');

insert into wgb_in_transactions_2
 values ('1112401',2,3000,'C');

insert into wgb_in_transactions_2
 values ('1113501',1,567.25,'C');

insert into wgb_in_transactions_2
 values ('1113501',1,257.02,'C');

insert into wgb_in_transactions_2
 values ('1113501',1,300,'Z');

insert into wgb_in_transactions_2
 values ('2566217',4,9800,'C');

insert into wgb_in_transactions_2
 values ('2566219',4,2200,'C');

insert into wgb_in_transactions_2
 values ('2566217',4,200000,'D');

COMMIT;
