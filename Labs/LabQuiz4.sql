SPOOL D:\Database\lab4Quiz.out

SET ECHO ON

--Question 1
SELECT DISTINCT i.account_number
FROM imp_credit_card i JOIN imp_account a ON i.account_number = a.account_number
WHERE card_limit > 10000
AND account_balance < 1000;


--Question 2
SELECT t.transaction_date,
        t.transaction_type,
        t.transaction_amount,
        a.account_number,
        a.credit_limit
FROM imp_transaction t JOIN imp_credit_card c ON t.card_number = c.card_number
                        JOIN imp_account a ON t.account_number = a.account_number
GROUP BY t.transaction_date,
        t.transaction_type,
        t.transaction_amount,
        a.account_number,
        a.credit_limit;
        
        
--Question 3
SELECT first_name,
        last_name
FROM imp_person
WHERE date_of_birth > TO_DATE('January 10, 1972', 'MONTH DD, YYYY')
AND home_phone LIKE '%6%'
AND work_phone LIKE '%6%'
ORDER BY last_name;


--Question 4
SELECT first_name,
        last_name
FROM imp_person
WHERE UPPER(province) = (SELECT province
                         FROM imp_person
                         WHERE LOWER(last_name) = 'chan'
                         AND LOWER(first_name) = 'doug')
AND LOWER(last_name) != 'chan'
AND LOWER(first_name) != 'doug';


--Question 5
SELECT p.first_name,
        p.last_name,
        a.account_number
FROM imp_person p JOIN imp_account a ON p.person_id = a.owner_id
WHERE account_number IN (SELECT DISTINCT account_number
                          FROM imp_account
                          HAVING credit_limit = MAX(credit_limit)
                          GROUP BY account_number, credit_limit);

SPOOL OFF