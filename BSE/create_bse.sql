DROP TABLE BSE_STOCK CASCADE CONSTRAINTS;
DROP TABLE BSE_TRANSACTION CASCADE CONSTRAINTS;
DROP TABLE BSE_CLIENT CASCADE CONSTRAINTS;
DROP TABLE BSE_PORTFOLIO CASCADE CONSTRAINTS;

CREATE TABLE BSE_STOCK          (
	STOCK_CODE                      VARCHAR2 (3),
	CORP_NAME                       VARCHAR2 (20),
	CEO                             VARCHAR2 (20),
	SHARES_ISSUED                   NUMBER (9),
	SHARES_AUTHORIZED               NUMBER (9),
	LAST_PRICE_TRADED		NUMBER (6,2),
	YTD_HIGH                        NUMBER (6,2),
	YTD_LOW                         NUMBER (6,2));

CREATE TABLE BSE_CLIENT         (
	CLIENT_NO                       VARCHAR2 (6),
        NAME                            VARCHAR2 (20),
	ADDRESS                         VARCHAR2 (20),
	PHONE                           VARCHAR2 (10),
	ACCOUNT_BALANCE                 NUMBER (8,2));

CREATE TABLE BSE_TRANSACTION    (
	TRANSACTION_NO                  NUMBER (6),
	TRANS_DATE                      DATE,
	STOCK_CODE                      VARCHAR2(3),
	SELLER                          VARCHAR2 (6),
	BUYER                           VARCHAR2 (6),
	PRICE                           NUMBER (6,2),
	QUANTITY                        NUMBER (7));

CREATE TABLE BSE_PORTFOLIO      (
	CLIENT_NO                       VARCHAR2 (6),
	STOCK_CODE                      VARCHAR2 (3),
	QUANTITY_HELD                   NUMBER (6));

COMMENT ON TABLE BSE_TRANSACTION IS 
'A transaction consists  of a transfer of a given number of shares
between a given seller and a given buyer for a given price. A
transaction is the result of one buy and one sell order. It is 
possible that the same buyer and the same seller  could be involved
in more than one transaction involving a given stock.';

COMMENT ON COLUMN BSE_TRANSACTION.TRANSACTION_NO IS
'A unique number issued for each transaction.';

COMMENT ON COLUMN BSE_TRANSACTION.BUYER IS
'CLIENT_NO of the person buying.';

COMMENT ON COLUMN BSE_TRANSACTION.SELLER IS
'CLIENT_NO of the person selling.';

COMMENT ON COLUMN BSE_CLIENT.ACCOUNT_BALANCE IS
'The balance owed to the customer by the exchange. When a 
client sells a stock this value goes up  and when a client
buys a stock this value goes down. ';     

COMMENT ON COLUMN BSE_STOCK.LAST_PRICE_TRADED IS
'The price, agreed to by seller and buyer, at which the
stock was sold/bought in the
very last transaction.';

COMMENT ON COLUMN BSE_STOCK.YTD_HIGH IS
'The year to date high for the stock. This value is
checked and updated if necessary after each transaction.';

COMMENT ON COLUMN BSE_STOCK.YTD_LOW IS
'The year to date low for the stock. This value is
checked and updated if necessary after each transaction.';

COMMENT ON COLUMN BSE_PORTFOLIO.QUANTITY_HELD IS
'The number of shares of the stock held by the customer.
This value is updated after each transaction. The net holdings
of a given stock by a given customer may be the result of 
many transactions.';

commit;
