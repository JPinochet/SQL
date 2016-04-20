COMMENT ON TABLE imp_person IS
'A person may be resonsible for an account and have one or more credit
cards, or he or she may have merely been issued a credit card issued 
under someone elses account';

COMMENT ON TABLE imp_account IS
'An account is the collector for transactions made under one or more
credit cards. One person is responsible for the debts incurred under
an account. A given account will have one person responsible for it,
but several persons may have been issued cards under that account. A
typical case might be a family, where the father or mother is 
responsible for paying the debts, but cards have been issued to
several family members.';

COMMENT ON COLUMN imp_credit_card.card_limit IS
'While there is a limit on the total liability that may be incurred
by an account, there is also a limit to the liability that may be 
incurred using one credit card. Since payments are made using the card
it is possible to keep track of the accumulated liability attributed
to a specific card. An example of a separate card limit could occur
when a parent wants a card for a child with a low limit';

COMMENT ON COLUMN imp_transaction.transaction_type IS
'There are two transaction types, C for credit ( a payment or return)
and D for Debit (a purchase).';

COMMENT ON TABLE imp_card_type IS 
'There are three types of card at this time. The type specifies the repayment
terms.
A, .03, Pay 3% of outstanding balance.
B, 1.00, Pay 100% of outstanding account balance.
C, 1.00, Pay 100% of this months purchases on that particular card.';




