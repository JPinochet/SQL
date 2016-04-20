SPOOL D:\Database\CaseStudyReport.out

SET ECHO ON

SET PAGESIZE 30

TTITLE CENTER "Outdoor Sports Shop" SKIP 1 -
        CENTER "Hike Participants" SKIP 1 -
        CENTER datevar SKIP 3
    
COLUMN today NOPRINT NEW_VALUE datevar                                   
COLUMN r_name HEADING "Region|Name" FORMAT A7               
COLUMN h_name HEADING "Hike|Name" FORMAT A16
COLUMN hike_date HEADING "Hike|Date" FORMAT A17
COLUMN name HEADING "Hiker|Name" FORMAT A15

BTITLE CENTER "Confidential Report"                             

BREAK ON r_name SKIP 2                                 
COMPUTE COUNT Label "Total:" OF name ON r_name

SELECT r.name r_name, h.name h_name, TO_CHAR(hp.hike_date, 'fmMonth dd, yyyy') hike_date, p.given_name||','|| p.surname name,TO_CHAR(SYSDATE, 'fmMonth dd, yyyy') today
FROM region r JOIN hike h ON r.region_id = h.REGION$region_id
              JOIN hike_participant hp ON h.hike_id = hp.HIKE$hike_id
              JOIN participant p ON hp.PARTICIPANT$participant_code = p.participant_code
ORDER BY r_name;                                    
        
TTITLE OFF
CLEAR COLUMNS                                                   
CLEAR BREAKS
CLEAR COMPUTE
BTITLE OFF

SPOOL OFF