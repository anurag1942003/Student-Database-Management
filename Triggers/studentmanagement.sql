--trigger that captures student changes and inserts them into the student_change table:
set serveroutput on
drop table student_change;
CREATE table student_change(op varchar(10) ,entry_date date, s_id NUMBER(5), s_name VARCHAR2(50), semail VARCHAR2(50), 
dob DATE, tot_cred NUMBER(5), d_id NUMBER(5));


CREATE OR REPLACE TRIGGER student_change_trigger
BEFORE INSERT OR UPDATE OR DELETE ON student
FOR EACH ROW
DECLARE
    v_op VARCHAR2(10);
BEGIN
    IF INSERTING THEN
        v_op := 'INSERT';
        INSERT INTO student_change(op,entry_date, s_id, s_name, semail, dob, tot_cred, d_id)
    VALUES(v_op, SYSDATE, :NEW.s_id, :NEW.s_name, :NEW.semail, :NEW.dob, :NEW.tot_cred, :NEW.d_id);
    ELSIF UPDATING THEN
        v_op := 'UPDATE';
        INSERT INTO student_change(op,entry_date, s_id, s_name, semail, dob, tot_cred, d_id)
    VALUES(v_op, SYSDATE, :OLD.s_id, :OLD.s_name, :OLD.semail, :OLD.dob, :OLD.tot_cred, :OLD.d_id);
    ELSIF DELETING THEN
        v_op := 'DELETE';
        INSERT INTO student_change(op,entry_date, s_id, s_name, semail, dob, tot_cred, d_id)
    VALUES(v_op, SYSDATE, :OLD.s_id, :OLD.s_name, :OLD.semail, :OLD.dob, :OLD.tot_cred, :OLD.d_id);
    END IF;
END;
/


--INSERT INTO student (s_id, s_name, semail, dob, tot_cred, d_id) VALUES (11, 'gg', 'gg@email.com', TO_DATE('1990-10-10', 'yyyy-mm-dd'), 28, 5);
--  select * from student_change;