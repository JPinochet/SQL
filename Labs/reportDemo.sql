SET ECHO ON

SET PAGESIZE 50

TTITLE CENTER "Departmental Employee Report" SKIP 1 -
        CENTER "Management Version" SKIP 1 -
        CENTER datevar SKIP 2
        
COLUMN today NOPRINT NEW_VALUE datevar                          --ties datevar from the top with today in the select statement
COLUMN d_name HEADING "Department|Name" FORMAT A5               --output will be displayed like this. Straight line indicates a name line to display on, then how to format
COLUMN e_name HEADING "Employee|Name" FORMAT A20
COLUMN empno HEADING "Employee|Number" FORMAT 999
COLUMN title HEADING "Job|Title" FORMAT A10
COLUMN salary HEADING "Salary" FORMAT $999,999.99

BTITLE CENTER "Confidential Report"                             --Has to come before query, EVERYTHING?!!?

BREAK ON d_name SKIP 2                                          --for more then one, add ON "changed" after ON d_name
COMPUTE SUM Label "Total:" OF salary ON d_name                  --MUST use BREAK command when using COMPUTE

        
SELECT d.name d_name, e.name e_name, empno, title, salary
       TO_CHAR(SYSDATE, 'fmMonth dd, yyyy') today
   FROM emp e, dept d
   WHERE e.deptno = d.deptno
   ORDER BY d_name, e_name;                                      --Have to order the information if you are gonna use the break command.
        
TTITLE OFF
CLEAR COLUMNS                                                    -- CLEAR command breaks off the commands from repeating.
CLEAR BREAKS
CLEAR COMPUTE
BTITLE OFF