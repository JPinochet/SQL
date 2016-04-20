SPOOL D:\database\caseStudyH.out

SET ECHO ON

--A:

--1.
--From the hike and region table
--h.REGION$region_id=r.region_id
SELECT r.name AS "Region Name", 
        h.name AS "Hike Name", 
        h.description AS "Hike Description"
   FROM region r, hike h
   WHERE h.REGION$region_id=r.region_id
   ORDER BY r.region_id, h.name;
   
--2.
--From the hike table
SELECT name AS "Name", length AS "Length", description AS "Hike Description"
   FROM hike, hike_rating
   WHERE HIKE_RATING$hikes_rating=hikes_rating
   AND UPPER(rating_description) LIKE ('EASY');
   
--3
--From hike, region, hike_rating
--HIKE_RATING$hikes_rating=hike_rating AND REGION$region_id=region_id 
SELECT r.name AS "Region Name", 
          h.name AS "Hike Name", 
          h.length AS "Length", 
          rating_description
   FROM hike h, hike_rating, region r
   WHERE HIKE_RATING$hikes_rating=hikes_rating
   AND h.REGION$region_id=r.region_id
   AND UPPER(h.name) LIKE ('%MOUNTAIN%') 
   OR UPPER(h.name) LIKE ('%PEAK%')
   ORDER BY r.name, h.name, rating_description;
   
--4
--From the hike table
SELECT h.name AS "Hike Name", 
        h.description AS "Hike Description", 
        h.length AS "Length"
   FROM hike h
   WHERE h.length BETWEEN 10 AND 20;
   
SELECT h.name AS "Hike Name", h.description AS "Hike Description", h.length AS "Length"
   FROM hike h
   WHERE h.length >=10 AND h.length <= 20;
   
--5
--From hike, participant, and hike_participant tables
--participant_code = PARTICIPANT$participant_code
--HIKE$hike_id=hike_id
SELECT p.given_name AS "Participant Given Name", 
          p.surname AS "Participant Surname",
          h.name AS "Hike Name", 
          h.description AS "Hike Description",
          hc.feedback
   FROM participant p, hike h, hike_participant hp, hike_comment hc
   WHERE participant_code = PARTICIPANT$participant_code(+)
   AND hp.HIKE$hike_id = h.hike_id (+)
   AND h.hike_id = hc.HIKE$hike_id(+)
  ORDER BY p.surname, h.name;
  
--6
--From hike, region, and hike_rating tables
--REGION$region_id = region_id
--HIKE_RATING$hikes_rating=hikes_rating 
SELECT r.name AS "Region Name",
        h.name AS "Hike Name",
        rating_description AS "Difficulty"
   FROM hike h JOIN region r ON REGION$region_id = region_id
                JOIN hike_rating ON HIKE_RATING$hikes_rating=hikes_rating 
   WHERE LOWER(r.name) NOT LIKE ('banff')
   ORDER BY r.name, rating_description;
   
--B:

--1
--From hike, region tables
--REGION$region_id = region_id
SELECT COUNT(h.name) AS "Hikes in Banff region"
   FROM hike h JOIN region r ON REGION$region_id = region_id
   WHERE LOWER(r.name) LIKE ('banff');
   
--2


--3
--From hike and region tables
--REGION$region_id = region_id
SELECT AVG(length)
   FROM hike
   WHERE REGION$region_id IN(SELECT region_id
                                 FROM region
                                 WHERE UPPER(name) = 'BANFF'
                                 OR UPPER(name) = 'CANMORE');
--4
--From participant, hike_participant, hike tables
--participant_code = PARTICIPANT$participant_code
--HIKE$hike_id = hike_id
SELECT SUM(length)
   FROM hike JOIN hike_participant ON HIKE$hike_id = hike_id
             JOIN participant ON participant_code = PARTICIPANT$participant_code
   WHERE surname = 'Knecht'
   AND given_name = 'Art'
   
--C:

--1.
--From hike and region tables
--REGION$region_id = region_id 
SELECT h.name
FROM hike h JOIN region r ON REGION$region_id = region_id 
WHERE h.name  NOT LIKE (SELECT name
                     FROM hike
                     WHERE UPPER(name) LIKE ('%HEART MOUNTAIN%'));
                     

--2
--From both hike and region tables
--REGION$region_id=region_id
SELECT h.name AS "Hike Name", r.name AS "Region", h.length 
FROM hike h JOIN region r ON REGION$region_id=region_id
WHERE h.length > (SELECT length
                     FROM hike
                     WHERE UPPER(name) LIKE '%YAMNUSKA CIRCUIT%');
                     
--3


--4
--FROM hike, hike_participant Tables
--hike_id=HIKE$hike_id
SELECT name
FROM hike JOIN hike_participant hp ON hike_id=HIKE$hike_id
GROUP BY name,hike_id HAVING COUNT(*) =
(SELECT MAX(COUNT(hp.HIKE$hike_id))
FROM hike h JOIN hike_participant hp ON hike_id=HIKE$hike_id
GROUP BY hp.HIKE$hike_id);

--5


--6
--From hike and picture tables
--hike_id=HIKE$hike_id
SELECT name
FROM hike JOIN picture on hike_id=HIKE$hike_id
WHERE picture_location = NULL

SPOOL OFF