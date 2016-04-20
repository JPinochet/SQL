CREATE OR REPLACE FUNCTION on_reserve(
    p_accession_number wgl_accession_register.accession_number%TYPE)
  RETURN BOOLEAN IS

    lv_number  NUMBER;

BEGIN

    SELECT COUNT(*)
      INTO lv_number
      FROM wgl_accession_register war,
           wgl_title_catalogue wtc,
           wgl_reserve_list wrl
     WHERE war.isbn = wtc.isbn
       AND wtc.isbn = wrl.isbn
       AND accession_number = p_accession_number;

    IF lv_number > 0 THEN
      RETURN true;
    ELSE
      RETURN false;
    END IF;

END on_reserve;
/


CREATE OR REPLACE PROCEDURE status_update(
    p_accession_number wgl_loan.accession_number%TYPE) IS

    lv_status  wgl_accession_register.status%TYPE;

BEGIN

    IF on_reserve(p_accession_number) THEN
      lv_status := 'IT';
    ELSE
      lv_status := 'OS';
    END IF;

    UPDATE wgl_accession_register
       SET status = lv_status,
           due_date = NULL
     WHERE accession_number = p_accession_number;

END status_update;
/
    


