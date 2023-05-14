--trigger that raises an error when a student tries to take up more than 6 courses:
CREATE OR REPLACE TRIGGER max_courses_trigger
BEFORE INSERT ON takes
FOR EACH ROW
DECLARE
    v_num_courses NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_num_courses
    FROM takes
    WHERE s_id = :new.s_id;
    
    IF v_num_courses >= 6 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Maximum limit of 6 courses exceeded for this student');
    END IF;
END;
/

-- insert into takes values(1,2,85);
