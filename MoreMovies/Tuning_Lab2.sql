SELECT mt.movie_category AS "Movie Category",
		m.movie_title AS "Movie Title",
		mem.last||', '||mem.first AS "Name",
		mr.checkout_date AS "Check Out Date"
	FROM mm_member mem,
		mm_rental mr,
		mm_movie_type mt,
		mm_movie m
	WHERE mem.member_id=mr.member_id
		AND m.movie_id=mr.movie_id
		AND m.movie_cat_id=mt.movie_cat_id
		AND mt.movie_category = 'Horror';
	
	SELECT /*+ RULE */mt.movie_category AS "Movie Category",
		m.movie_title AS "Movie Title",
		mem.last||', '||mem.first AS "Name",
		mr.checkout_date AS "Check Out Date"
	FROM mm_member mem,
		mm_rental mr,
		mm_movie_type mt,
		mm_movie m
	WHERE mem.member_id=mr.member_id
		AND m.movie_id=mr.movie_id
		AND m.movie_cat_id=mt.movie_cat_id
		AND mt.movie_category = 'Horror';
	
	SELECT /*+ FIRST_ROWS */mt.movie_category AS "Movie Category",
		m.movie_title AS "Movie Title",
		mem.last||', '||mem.first AS "Name",
		mr.checkout_date AS "Check Out Date"
	FROM mm_member mem,
		mm_rental mr,
		mm_movie_type mt,
		mm_movie m
	WHERE mem.member_id=mr.member_id
		AND m.movie_id=mr.movie_id
		AND m.movie_cat_id=mt.movie_cat_id
		AND mt.movie_category = 'Horror';
	
	
	SELECT /*+ ALL_ROWS */mt.movie_category AS "Movie Category",
			m.movie_title AS "Movie Title",
			mem.last||', '||mem.first AS "Name",
			mr.checkout_date AS "Check Out Date"
		FROM mm_member mem,
			mm_rental mr,
			mm_movie_type mt,
			mm_movie m
		WHERE mem.member_id=mr.member_id
			AND m.movie_id=mr.movie_id
			AND m.movie_cat_id=mt.movie_cat_id
			AND mt.movie_category = 'Horror';
			
ANALYZE TABLE mm_movie COMPUTE STATISTICS;
ANALYZE TABLE mm_rental COMPUTE STATISTICS;
ANALYZE TABLE mm_movie_type COMPUTE STATISTICS;
ANALYZE TABLE mm_member COMPUTE STATISTICS;

CREATE INDEX rental_idx
	ON mm_rental (member_id);
CREATE INDEX rental2_idx
	ON mm_rental (movie_id);
CREATE INDEX movie_type_idx
	ON mm_movie_type (movie_category);
CREATE INDEX movie_idx
	ON mm_movie (movie_cat_id);
	
SELECT mt.movie_category AS "Movie Category",
		m.movie_title AS "Movie Title",
		mem.last||', '||mem.first AS "Name",
		mr.checkout_date AS "Check Out Date"
	FROM mm_movie m,
		mm_rental mr,
		mm_movie_type mt,
		mm_member mem
	WHERE mt.movie_category = 'Horror'
		AND m.movie_id=mr.movie_id
		AND m.movie_cat_id=mt.movie_cat_id
		AND mem.member_id=mr.member_id;