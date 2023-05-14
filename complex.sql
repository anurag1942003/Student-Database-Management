--1.Retrieve the name and email of all students who have not attended a course in department 1:

SELECT s_name, semail
FROM student
WHERE s_id NOT IN (
    SELECT s_id FROM takes
    JOIN course ON takes.c_id = course.c_id
    WHERE course.d_id =1
);

--2.Retrieve the name of all students who have attended a course taught by all instructors:

SELECT s_name
FROM student
WHERE NOT EXISTS (
    SELECT I_id FROM instructor
    WHERE NOT EXISTS (
        SELECT course.c_id FROM course
        JOIN takes ON course.c_id = takes.c_id
        WHERE takes.s_id = student.s_id AND course.I_id = instructor.I_id
    )
);

--3.Retrieve the name and email of all students who have taken courses in all departments:

SELECT s_name, semail
FROM student
WHERE NOT EXISTS (
    SELECT d_id FROM department
    WHERE NOT EXISTS (
        SELECT course.c_id FROM course
        JOIN takes ON course.c_id = takes.c_id
        WHERE takes.s_id = student.s_id AND course.d_id = department.d_id
    )
);

--4.Retrieve the name and email of all instructors who have taught at least 
--one course with a total number of credits greater than 4 in department 1,
--sorted by the total number of credits:

SELECT instructor.I_name, instructor.Iemail, SUM(course.credits) as total_credits
FROM instructor
JOIN course ON instructor.I_id = course.I_id
WHERE course.d_id = 1
GROUP BY instructor.I_id, instructor.I_name, instructor.Iemail
HAVING SUM(course.credits) > 4
ORDER BY total_credits DESC;

--5.List the names of all instructors who have taught at least one course outside their department:

SELECT DISTINCT i.I_name
FROM instructor i
JOIN course c ON i.I_id = c.I_id
WHERE c.d_id <> i.d_id;

--6.Query for finding the number of assignments given by each student

SELECT s.s_name, COUNT(a.a_id) AS num_assignments
FROM student s
LEFT JOIN assignment a ON s.s_id = a.s_id
GROUP BY s.s_id, s.s_name;

--7.Query to find the department with the highest total number of credits offered:

SELECT d.d_name, SUM(c.credits) as total_credits
FROM department d
JOIN course c ON d.d_id = c.d_id
GROUP BY d.d_name
ORDER BY total_credits DESC
FETCH FIRST 1 ROWS ONLY;


