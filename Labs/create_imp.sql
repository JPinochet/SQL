
DROP TABLE imp_person;
DROP TABLE imp_account;
DROP TABLE imp_credit_card;
DROP TABLE imp_card_type;
DROP TABLE imp_transaction;
DROP TABLE todays_new_transactions;

CREATE TABLE imp_person (
person_id                        NUMBER,
last_name                        VARCHAR2 (25),
first_name                       VARCHAR2 (25),
address_1                        VARCHAR2 (25),
address_2                        VARCHAR2 (25),
city                             VARCHAR2 (25),
province                         VARCHAR2 (2),
country                          VARCHAR2 (20),
postal_code                      VARCHAR2 (8),
home_phone                       VARCHAR2 (12),
work_phone                       VARCHAR2 (12),
date_of_birth                    DATE,
sex                              VARCHAR2 (1),
marital_status                   VARCHAR2 (12));


CREATE TABLE imp_account (
owner_id                         NUMBER,
account_number                   VARCHAR2 (12) not null,
date_created                     DATE,
credit_limit                     NUMBER (7,2),
account_balance                  NUMBER (7,2));

CREATE TABLE imp_credit_card (
account_number                   VARCHAR2 (12) not null,
card_number                      VARCHAR2 (3) not null,
card_limit                       NUMBER (7,2),
issue_date                       DATE,
valid_from_date                  DATE,
expiry_date                      DATE,
card_type                        VARCHAR2 (1),
card_holder_id                   NUMBER);

CREATE TABLE imp_card_type (
type                             VARCHAR (1) not null,
minimum_monthly_payment          NUMBER (3,2),
payment_terms                    VARCHAR2 (60));

CREATE TABLE imp_transaction (
transaction_number               NUMBER not null,
account_number                   VARCHAR2 (12),
card_number                      VARCHAR2 (3),
transaction_date                 DATE,
transaction_type                 VARCHAR2 (1),
transaction_amount               NUMBER (7,2));

CREATE TABLE todays_new_transactions (
account_number                   VARCHAR2 (12),
card_number                      VARCHAR2 (3),
transaction_type                 VARCHAR2 (1),
transaction_amount               NUMBER (7,2));
