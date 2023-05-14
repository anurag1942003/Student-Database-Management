--PL/SQL block that deletes the records of students with attendance less than 75 from the takes table:
set serveroutput on
DECLARE
   v_attendance takes.attendance%TYPE;
BEGIN
   FOR rec IN (SELECT * FROM takes)
   LOOP
      SELECT attendance INTO v_attendance
      FROM takes
      WHERE s_id = rec.s_id AND c_id = rec.c_id;
      
      IF v_attendance < 75 THEN
         DELETE FROM takes
         WHERE s_id = rec.s_id AND c_id = rec.c_id;
      END IF;
   END LOOP;
   COMMIT;
END;
/
