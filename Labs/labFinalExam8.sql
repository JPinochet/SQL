SPOOL D:\Database\Labfinal2.out

SET ECHO ON

--Question8

SET PAGESIZE 50

TTITLE CENTER "Impulse Credit Card Company" SKIP 1 -
        CENTER "Canada Revenue Agency Client Report" SKIP 1 -
        CENTER datevar SKIP 2
        
COLUMN today NOPRINT NEW_VALUE datevar
COLUMN name HEADING "Card|Holder" FORMAT A10              
COLUMN a.account_number HEADING "Account|Number" FORMAT A12
COLUMN ct.card_type HEADING "Type" FORMAT A1
COLUMN ct.payment_terms HEADING "Payment|Terms" FORMAT A20

BTITLE CENTER "Information is accurate as of "  
BTITLE CENTER datevar                          

BREAK ON name SKIP 2                                                          

        
SELECT DISTINCT(p.last_name ||', '|| p.first_name) AS name, a.account_number, ct.type, ct.payment_terms, TO_CHAR(SYSDATE, 'fmMonth dd, yyyy') today
FROM imp_person p JOIN imp_account a ON owner_id(+) = person_id
                 JOIN imp_credit_card cc ON cc.account_number = a.account_number
                 JOIN imp_card_type ct ON cc.card_type = ct.type
WHERE account_balance > 1000.00
ORDER BY name;

        
TTITLE OFF
CLEAR COLUMNS                                                    
CLEAR BREAKS
CLEAR COMPUTE
BTITLE OFF

SPOOL OFF