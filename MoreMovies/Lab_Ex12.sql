create table PLAN_TABLE (
        statement_id       varchar2(30),
        plan_id            number,
        timestamp          date,
        remarks            varchar2(4000),
        operation          varchar2(30),
        options            varchar2(255),
        object_node        varchar2(128),
        object_owner       varchar2(30),
        object_name        varchar2(30),
        object_alias       varchar2(65),
        object_instance    numeric,
        object_type        varchar2(30),
        optimizer          varchar2(255),
        search_columns     number,
        id                 numeric,
        parent_id          numeric,
        depth              numeric,
        position           numeric,
        cost               numeric,
        cardinality        numeric,
        bytes              numeric,
        other_tag          varchar2(255),
        partition_start    varchar2(255),
        partition_stop     varchar2(255),
        partition_id       numeric,
        other              long,
        distribution       varchar2(30),
        cpu_cost           numeric,
        io_cost            numeric,
        temp_space         numeric,
        access_predicates  varchar2(4000),
        filter_predicates  varchar2(4000),
        projection         varchar2(4000),
        time               numeric,
        qblock_name        varchar2(30),
        other_xml          clob
);

--4
EXPLAIN PLAN
	SET STATEMENT_ID = 'More_movies_test1'
	FOR
		SELECT m.movie_title AS "Movie Title", mr.checkout_date AS "Check Out Date"
			FROM mm_movie m, mm_rental mr
				WHERE mr.movie_id=m.movie_id
				AND checkin_date IS NULL;
				
SELECT lpad(' ',level-1)|| operation ||' '|| options ||' '||object_name "Plan"
  FROM PLAN_TABLE
		CONNECT BY prior id = parent_id
			AND prior statement_id = statement_id
				START WITH id = 0
					AND statement_id = 'More_movies_test1'
					ORDER BY id;
					
--6
		SELECT /*+ RULE */ m.movie_title AS "Movie Title", mr.checkout_date AS "Check Out Date"
			FROM mm_movie m, mm_rental mr
				WHERE mr.movie_id=m.movie_id
				AND checkin_date IS NULL;
				
--9
ANALYZE TABLE mm_movie COMPUTE STATISTICS;
ANALYZE TABLE mm_rental COMPUTE STATISTICS;

EXPLAIN PLAN
	SET STATEMENT_ID = 'More_movies_test2'
	FOR
		SELECT /*+ CHOOSE */ m.movie_title AS "Movie Title", mr.checkout_date AS "Check Out Date"
					FROM mm_movie m, mm_rental mr
						WHERE mr.movie_id=m.movie_id
						AND checkin_date IS NULL;
						
SELECT lpad(' ',level-1)|| operation ||' '|| options ||' '||object_name "Plan"
  FROM PLAN_TABLE
		CONNECT BY prior id = parent_id
			AND prior statement_id = statement_id
				START WITH id = 0
					AND statement_id = 'More_movies_test2'
					ORDER BY id;
					
--13
ALTER SESSION SET SQL_TRACE=TRUE;
ALTER SESSION SET TIMED_STATISTICS=TRUE;

SELECT m.movie_title AS "Movie Title", mr.checkout_date AS "Check Out Date"
					FROM mm_movie m, mm_rental mr
						WHERE mr.movie_id=m.movie_id
						AND checkin_date IS NULL;