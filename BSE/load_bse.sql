/* This file is used to load error free data into the tables 
   BSE_CLIENT,
   BSE_STOCK,
   BSE_PORTFOLIO.        

   It does not provide data for the transactions table.

   Written by:      Jack Moore
   Date Written:    10 February 2000

*/
PROMPT   Deleting all data from the four tables.



DELETE FROM bse_transaction;
DELETE FROM bse_portfolio;
DELETE FROM bse_client;
DELETE FROM bse_stock;
COMMIT;
PROMPT
PROMPT Load of base data.  There should be no errors.
PROMPT
insert into bse_client values ( '00001' , 'Adams, Brian', '34 - 2nd Ave', '555-1212', 500900);                                                                                                                 
insert into bse_client values ( '00002' , 'Benson, Bessie', '9 Chickweed Lane', '541-7502',50000);                                                                                                           
insert into bse_client values ( '00003' , 'Li, Tom', '7 Wistful Vista', '756-3245', 75600);                                                                                                                   
insert into bse_client values ( '07809' , 'Chung, Connie', '1302 - 17th Ave', '234-0900', 100000);                                                                                                             
insert into bse_client values ( '00065' , 'Berenger, Tom', '765 - Aldershot Rd', '555-7689', 250000);
insert into bse_client values ( '00072' , 'Hershey, Barbara', '19 Pleasant Drive', '555-4160', 92000);                                                                                                        
                                                                                                          
commit;
insert into bse_stock values ( 'CMP', 'CONS MOOSE PASTURE', 'BOYACK, CHARLIE', 500000,1500000,.60,.75,.22);                                                                                                 
insert into bse_stock values ( 'FBN', 'FLY BY NIGHT CO', 'COMRIN, DON', 750000,800000,.32,.32,.05);                                                                                                         
insert into bse_stock values ( 'CCC', 'COMPUTER CORP CANADA', 'DIGITAL, DAN', 2000000,2500000,5.49,5.49,3.78);                                                                                               
insert into bse_stock values ( 'LSM', 'LUCKY STRIKE MINES', 'PROSPECT, BETTY', 5000000,9000000,.50,.92,.37);                                                                                                
insert into bse_stock values ( 'WDV', 'WHITEWATER DEV', 'CLINTON, H', 1000000,9000000,73.5,75,10);                                                                                                            
insert into bse_stock values ( 'BCO', 'BABBAGE COMPUTERS', 'BABBAGE, CHARLIE', 5000000,35000000,170,178,165);                                                                                              
insert into bse_stock values ( 'TUL', 'THERMAL UNDERWEAR', 'LEE, BOB', 900000,1000000,1.2,1.25,.8);                                                                                                         
insert into bse_stock values ( 'SGF', 'SLOW GROWTH FUND', 'HELMSLEY, LEONA', 635000,635000,14.5,17.5,14.5);                                                                                                  

commit;


insert into bse_portfolio values ('00001', 'CMP', 10000);
insert into bse_portfolio values ('00001', 'LSM', 5000);
insert into bse_portfolio values ('00065', 'SGF', 1000);
insert into bse_portfolio values ('00065', 'TUL', 25000);
insert into bse_portfolio values ('00065', 'CMP', 20000);
insert into bse_portfolio values ('07809', 'FBN', 100000);
insert into bse_portfolio values ('07809', 'CCC', 50000);
insert into bse_portfolio values ('00072', 'BCO', 200000);
insert into bse_portfolio values ('00002', 'FBN', 10000);
insert into bse_portfolio values ('00002', 'LSM', 5000);
insert into bse_portfolio values ('00002', 'SGF', 5000);
insert into bse_portfolio values ('00002', 'BCO', 2000);
insert into bse_portfolio values ('00002', 'CCC', 1000);
insert into bse_portfolio values ('00072', 'CCC', 10000);
insert into bse_portfolio values ('00001', 'TUL', 25000);
insert into bse_portfolio values ('00003', 'LSM', 2000);
insert into bse_portfolio values ('00065', 'CCC', 20000);

commit;
