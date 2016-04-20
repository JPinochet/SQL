DELETE FROM CP_CATEGORY;
DELETE FROM CP_CUSTOMER;
DELETE FROM CP_OVERDUE_LOG;
DELETE FROM CP_PRICE;
DELETE FROM CP_RENTAL;
DELETE FROM CP_RETURNS;
DELETE FROM CP_TAPE;
DELETE FROM CP_TITLE;

INSERT INTO cp_price VALUES ('A', 2.99);
INSERT INTO cp_price VALUES ('B', 1.99);
INSERT INTO cp_price VALUES ('C', 0.99);

COMMIT;

INSERT INTO cp_category VALUES (
1, 'Adventure');
INSERT INTO cp_category VALUES (
2, 'Mystery');
INSERT INTO cp_category VALUES (
3, 'Drama');
INSERT INTO cp_category VALUES (
4, 'Musical');
INSERT INTO cp_category VALUES (
5, 'War');
INSERT INTO cp_category VALUES (
6, 'Western');
INSERT INTO cp_category VALUES (
7, 'Smut');
INSERT INTO cp_category VALUES (
8, 'Comedy');

COMMIT;

INSERT INTO cp_customer VALUES (1000, 'Rogers, Hal', 
'9 Chickweed Lane', 'Toronto ON', '416',
'5551234', 'VI', LAST_DAY (SYSDATE + 400), '9201653287');

INSERT INTO cp_customer VALUES (1001, 'Williams, Mel',
'65 Bloor St', 'Toronto ON', '416',
'2457812', 'VI', LAST_DAY (SYSDATE + 100), '8516235409');

INSERT INTO cp_customer VALUES (1002, 'Lee, Sarah',
'2205 Young St', 'Toronto, ON', '905',
'2547812', 'MC', LAST_DAY (SYSDATE + 250), '0927615923');

INSERT INTO cp_customer VALUES (1003, 'Ellard, John',
'75 Primrose Lane', 'Scarborough ON', '416',
'7687896', 'AX', LAST_DAY (SYSDATE + 90), '5678434332');

INSERT INTO cp_customer VALUES (1004, 'Johnson, Jeremy',
'37 Info Highway', 'Markham ON', '905',
'4458878', 'MC', LAST_DAY (SYSDATE), '4358790052');

INSERT INTO cp_customer VALUES (1005, 'Zink, Penny',
'47 Digital Drive', 'Toronto ON', '416',
'3248493', 'VI', LAST_DAY (SYSDATE + 30), '5782379387');

COMMIT;

INSERT INTO cp_title VALUES ('MACON COUNTY',
'Macon County Line',1,
'Alan Vint, Max Baer, Cheryl Waters',
89, '**');

INSERT INTO cp_title VALUES ('HORSE FEATHERS',
'Horse Feathers', 8,
'Marx Brothers',
80, '***');

INSERT INTO cp_title VALUES ('BEST YEARS', 
'Best Years of Our lives, The', 3,
'Frederick March, Myrna Loy, Dana Andrews',
172, '****');

INSERT INTO cp_title VALUES ('ANNE OF 1000',
'Anne of the Thousand Days', 3,
'Richard Burton, Genevieve Bujold, Irene Papas, Anthony Quale',
146, '***');

INSERT INTO cp_title VALUES ('SILENCE LAMBS',
'Silence of the Lambs, The', 2,
'Jody Foster, Anthony Hopkins, Scott Glenn',
120, '****');

INSERT INTO cp_title VALUES ('CHEAPER DOZEN',
'Cheaper by the Dozen', 8,
'Clifton Webb, Jeanne Crain, Myrna Loy',
85, '***');

COMMIT;

INSERT INTO cp_tape VALUES (100, 'BEST YEARS', 1, 'B');
INSERT INTO cp_tape VALUES (101, 'BEST YEARS', 1, 'B');
INSERT INTO cp_tape VALUES (102, 'SILENCE LAMBS', 2, 'A');
INSERT INTO cp_tape VALUES (103, 'SILENCE LAMBS', 2, 'A');
INSERT INTO cp_tape VALUES (104, 'SILENCE LAMBS', 1, 'A');
INSERT INTO cp_tape VALUES (105, 'SILENCE LAMBS', 2, 'A');
INSERT INTO cp_tape VALUES (106, 'HORSE FEATHERS', 2, 'C');
INSERT INTO cp_tape VALUES (107, 'ANNE OF 1000', 1, 'A');
INSERT INTO cp_tape VALUES (108, 'MACON COUNTY', 1, 'B');
INSERT INTO cp_tape VALUES (109, 'ANNE OF 1000', 1, 'A');
INSERT INTO cp_tape VALUES (110, 'HORSE FEATHERS', 1, 'C');

COMMIT;

INSERT INTO cp_rental VALUES (
1000, 100, SYSDATE, SYSDATE + 2, SYSDATE + 3);

INSERT INTO cp_rental VALUES (
1001, 101, SYSDATE, SYSDATE + 2, SYSDATE + 1);

INSERT INTO cp_rental VALUES (
1001, 107, SYSDATE - 1, SYSDATE + 1, SYSDATE + 1);

INSERT INTO cp_rental VALUES (
1001, 109, SYSDATE + 3, SYSDATE + 5, NULL);

INSERT INTO cp_rental VALUES (
1002, 102, SYSDATE + 1, SYSDATE + 3, SYSDATE + 4);

INSERT INTO cp_rental VALUES (
1003, 103, SYSDATE - 6, SYSDATE - 4, NULL);

INSERT INTO cp_rental VALUES (
1005, 105, SYSDATE + 1, SYSDATE + 3, SYSDATE + 3);

INSERT INTO cp_rental VALUES (
1005, 102, SYSDATE - 2, SYSDATE , NULL);

COMMIT;

INSERT INTO cp_returns VALUES (
109, SYSDATE + 7);
INSERT INTO cp_returns VALUES (
103, SYSDATE);
INSERT INTO cp_returns VALUES (
102, SYSDATE - 4);

COMMIT;
