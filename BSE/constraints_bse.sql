/* This file is used to place standard constraints of the tables of the
   Balzac Stock Exchange (BSE).

   Written by:      Jack Moore
   Date written:    10 February 2000
   Date modified:

    */

ALTER TABLE bse_client
ADD CONSTRAINT pk_client
PRIMARY KEY (client_no);


ALTER TABLE bse_transaction
ADD CONSTRAINT fk_seller_to_client
FOREIGN KEY (seller)
REFERENCES bse_client;

ALTER TABLE bse_transaction
ADD CONSTRAINT fk_buyer_to_client
FOREIGN KEY (buyer)
REFERENCES bse_client;


ALTER TABLE bse_portfolio
ADD CONSTRAINT pk_bse_portfolio
PRIMARY KEY (client_no, stock_code);



ALTER TABLE bse_stock
ADD CONSTRAINT ck_last_price_in_range
CHECK (last_price_traded BETWEEN ytd_low AND ytd_high);

 
ALTER TABLE bse_stock
ADD CONSTRAINT ck_shares_issued
CHECK (shares_issued <= shares_authorized);


ALTER TABLE bse_stock
ADD CONSTRAINT pk_stock
PRIMARY KEY (stock_code);

ALTER TABLE bse_transaction
ADD CONSTRAINT fk_transaction_to_stock
FOREIGN KEY (stock_code)
REFERENCES bse_stock;


ALTER TABLE bse_client
ADD CONSTRAINT ck_client_balance
CHECK (account_balance >= 0);

