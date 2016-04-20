drop table bse_in_transactions_2;

create table bse_in_transactions_2
(TRANS_DATE                               DATE,
STOCK_CODE                               VARCHAR2(3),
SELLER                                   VARCHAR2(6),
BUYER                                    VARCHAR2(6),
PRICE                                    NUMBER(6,2),
QUANTITY                                 NUMBER(7));

insert into bse_in_transactions_2
values
(sysdate-10,'FBN','07899','00002',0.32,3000);

insert into bse_in_transactions_2
values
(sysdate-10,'TUL','00065','00001',1.2,30000);

insert into bse_in_transactions_2
values
(sysdate-9,'LSM','00002','00003',.65,2000);

insert into bse_in_transactions_2
values
(sysdate-9,'SGF','00065','00002',17.5,1000);

insert into bse_in_transactions_2
values
(sysdate-9,'CCC','07809','00065',5.75,15000);

insert into bse_in_transactions_2
values
(sysdate-9,'CCC','07809','00072',5.5,10000);

insert into bse_in_transactions_2
values
(sysdate-9,'CCC','07809','00002',5.49,1000);

insert into bse_in_transactions_2
values
(sysdate-9,'LSM','00002','00001',0.5,1000);

insert into bse_in_transactions_2
values
(sysdate-8,'CCC','07890','00065',5.75,15000);

insert into bse_in_transactions_2
values
(sysdate-8,'CCC','07809','00772',5.5,10000);

insert into bse_in_transactions_2
values
(sysdate-6,'LSM','07809','00002',5.49,1000);

insert into bse_in_transactions_2
values
(sysdate-7,'LMS','00002','00003',.65,20000);

insert into bse_in_transactions_2
values
(sysdate-5,'CMP','00001','07809',.15,5000);

insert into bse_in_transactions_2
values
(sysdate-5,'BCO','00002','00072',200,3000);

insert into bse_in_transactions_2
values
(sysdate-4,'TUL','00001','00003',.8,20000);

commit;

