ALTER TABLE imp_person 
ADD CONSTRAINT pk_imp_person PRIMARY KEY (person_id);

ALTER TABLE imp_account
ADD CONSTRAINT pk_imp_account PRIMARY KEY (account_number);

ALTER TABLE imp_card_type
ADD CONSTRAINT pk_imp_card_type PRIMARY KEY (type);

ALTER TABLE imp_credit_card
ADD CONSTRAINT pk_imp_credit_card PRIMARY KEY (account_number, card_number);

ALTER TABLE imp_transaction
ADD CONSTRAINT pk_imp_transaction PRIMARY KEY (transaction_number);

ALTER TABLE imp_account
ADD CONSTRAINT fk_imp_account_to_person FOREIGN KEY (owner_id)
REFERENCES imp_person;

ALTER TABLE imp_credit_card
ADD CONSTRAINT fk_imp_card_to_person FOREIGN KEY (card_holder_id)
REFERENCES imp_person;

ALTER TABLE imp_credit_card
ADD CONSTRAINT fk_imp_card_to_account FOREIGN KEY (account_number)
REFERENCES imp_account;

ALTER TABLE imp_credit_card
ADD CONSTRAINT fk_imp_card_to_type FOREIGN KEY (card_type)
REFERENCES imp_card_type;

ALTER TABLE imp_transaction
ADD CONSTRAINT fk_imp_transaction_to_card FOREIGN KEY (account_number, card_number)
REFERENCES imp_credit_card;


