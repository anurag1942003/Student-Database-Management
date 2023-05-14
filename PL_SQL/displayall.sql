-- PL/SQL procedure that takes a student ID as a parameter and displays all 
--the details related to that student across all tables:
set serveroutput on
CREATE OR REPLACE PROCEDURE GET_STUDENT_DETAILS(p_s_id IN NUMBER) AS
    v_s_id student.s_id%TYPE;
    v_s_name student.s_name%TYPE;
    v_semail student.semail%TYPE;
    v_dob student.dob%TYPE;
    v_tot_cred student.tot_cred%TYPE;
    v_d_name department.d_name%TYPE;
    v_c_id course.c_id%TYPE;
    v_c_name course.c_name%TYPE;
    v_credits course.credits%TYPE;
    v_i_name instructor.i_name%TYPE;
    v_attendance takes.attendance%TYPE;
    v_a_name assignment.a_name%TYPE;
    v_marks assignment.marks%TYPE;
    v_max_m assignment.max_m%TYPE;
    
    CURSOR C IS
        SELECT s.s_id, s.s_name, s.semail, s.dob, s.tot_cred, d.d_name, t.c_id, c.c_name, 
               c.credits, i.i_name, t.attendance, a.a_name, a.marks, a.max_m
        FROM student s
        JOIN takes t ON s.s_id = t.s_id
        JOIN course c ON t.c_id = c.c_id
        JOIN instructor i ON c.i_id = i.i_id
        JOIN department d ON s.d_id = d.d_id
        LEFT JOIN assignment a ON t.c_id = a.c_id AND t.s_id = a.s_id AND a.a_name = 'Assignment 1'
        WHERE s.s_id = p_s_id;
BEGIN
    OPEN C;
    LOOP
        FETCH C INTO v_s_id, v_s_name, v_semail, v_dob, v_tot_cred, v_d_name, v_c_id, v_c_name, 
                    v_credits, v_i_name, v_attendance, v_a_name, v_marks, v_max_m;
        EXIT WHEN C%NOTFOUND;
        
        DBMS_OUTPUT.PUT_LINE('Student ID: ' || v_s_id);
        DBMS_OUTPUT.PUT_LINE('Student Name: ' || v_s_name);
        DBMS_OUTPUT.PUT_LINE('Student Email: ' || v_semail);
        DBMS_OUTPUT.PUT_LINE('Date of Birth: ' || v_dob);
        DBMS_OUTPUT.PUT_LINE('Total Credits: ' || v_tot_cred);
        DBMS_OUTPUT.PUT_LINE('Department Name: ' || v_d_name);
        DBMS_OUTPUT.PUT_LINE('Course ID: ' || v_c_id);
        DBMS_OUTPUT.PUT_LINE('Course Name: ' || v_c_name);
        DBMS_OUTPUT.PUT_LINE('Course Credits: ' || v_credits);
        DBMS_OUTPUT.PUT_LINE('Instructor Name: ' || v_i_name);
        DBMS_OUTPUT.PUT_LINE('Attendance: ' || v_attendance);
        DBMS_OUTPUT.PUT_LINE('Assignment Name: ' || v_a_name);
        DBMS_OUTPUT.PUT_LINE('Marks: ' || v_marks);
        DBMS_OUTPUT.PUT_LINE('Maximum Marks: ' || v_max_m);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    END LOOP;
    CLOSE C;
    
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found for the given student ID');
END;
/


BEGIN
    GET_STUDENT_DETAILS('&s_id');
END;
/
