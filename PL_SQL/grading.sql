--PL/SQL command to find the grading of a given student based on their total marks:
set serveroutput on
DECLARE
   v_s_id    student.s_id%TYPE := '&s_id';
   v_total_marks NUMBER := 0;
   v_grading VARCHAR2(10);
BEGIN
   
   SELECT SUM(a.marks * c.credits / s.tot_cred) INTO v_total_marks
   FROM assignment a
   JOIN course c ON a.c_id = c.c_id
   JOIN student s ON a.s_id = s.s_id
   WHERE a.s_id = v_s_id;

   
   IF v_total_marks >= 90 THEN
      v_grading := 'A';
   ELSIF v_total_marks >= 80 THEN
      v_grading := 'B';
   ELSIF v_total_marks >= 70 THEN
      v_grading := 'C';
   ELSIF v_total_marks >= 60 THEN
      v_grading := 'D';
   ELSE
      v_grading := 'F';
   END IF;

   DBMS_OUTPUT.PUT_LINE('Grading for student ' || v_s_id || ': ' || v_grading);
END;
/
