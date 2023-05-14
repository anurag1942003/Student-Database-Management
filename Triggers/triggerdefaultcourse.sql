--trigger that will insert a new row into the takes table 
--with c_id=1 whenever a new student is added to the student table:
CREATE OR REPLACE TRIGGER add_default_course_to_student
AFTER INSERT ON student
FOR EACH ROW
BEGIN
  INSERT INTO takes (s_id, c_id, attendance)
  VALUES (:NEW.s_id, 1, NULL);
END;
/

-- INSERT INTO student (s_id, s_name, semail, dob, tot_cred, d_id) VALUES (56, 'Adruti Onam', 'adruti@email.com', TO_DATE('1995-01-01', 'yyyy-mm-dd'), 45, 1);
-- SELECT * FROM takes;