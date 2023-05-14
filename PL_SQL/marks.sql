--PL/SQL for finding the total course marks using the computation of(weighted) sum of marks using procedures
set serveroutput on

CREATE OR REPLACE PROCEDURE calculate_total_marks (p_s_id  IN NUMBER, p_total_marks OUT NUMBER)
AS
    v_total_marks NUMBER := 0;
    v_c_id course.c_id%TYPE;
    v_marks assignment.marks%TYPE;
    v_credits course.credits%TYPE;
    v_total_cred student.tot_cred%TYPE;

    CURSOR C IS
        SELECT c.c_id, a.marks, c.credits, s.tot_cred
        FROM takes t
        JOIN course c ON t.c_id = c.c_id
        JOIN assignment a ON t.s_id = a.s_id AND t.c_id = a.c_id
        JOIN student s ON t.s_id = s.s_id
        WHERE t.s_id = p_s_id AND t.attendance >= 75;
BEGIN
    OPEN C;
    LOOP
        FETCH C INTO v_c_id, v_marks, v_credits, v_total_cred;
        EXIT WHEN C%NOTFOUND;

        v_total_marks := v_total_marks + (v_marks * (v_credits / v_total_cred));
    END LOOP;
    CLOSE C;

    p_total_marks := v_total_marks;
END;
/


DECLARE
    v_total_marks NUMBER;
BEGIN
    calculate_total_marks('&s_id', v_total_marks);
    DBMS_OUTPUT.PUT_LINE('Total marks: ' || v_total_marks);
END;
/ 