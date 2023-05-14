--trigger that shows an error message when attempting to insert an assignment with a score
--greater than 100 and a max_m value greater than 100:
set serveroutput on
CREATE OR REPLACE TRIGGER check_assignment_score
BEFORE INSERT ON assignment
FOR EACH ROW
BEGIN
  IF :NEW.marks > 100 OR :NEW.max_m > 100 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Error: Assignment score or max_m value cannot exceed 100');
  END IF;
END;
/

-- insert into assignment values(47,'insem',17,1,3,180);