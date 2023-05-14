drop table assignment;
drop table takes;
drop table course;
drop table student;
drop table instructor;
drop table department;


CREATE TABLE department (
  d_id NUMBER(5) PRIMARY KEY,
  d_name VARCHAR2(50)
);

CREATE TABLE student (
  s_id NUMBER(5) PRIMARY KEY,
  s_name VARCHAR2(50),
  semail VARCHAR2(50),
  dob DATE,
  tot_cred NUMBER(5),
  d_id NUMBER(5),
  FOREIGN KEY (d_id) REFERENCES department(d_id)
);

CREATE TABLE instructor (
  i_id NUMBER(5) PRIMARY KEY,
  i_name VARCHAR2(50),
  iemail VARCHAR2(50),
  d_id NUMBER(5),
  FOREIGN KEY (d_id) REFERENCES department(d_id)
);

CREATE TABLE course (
  c_id NUMBER(5) PRIMARY KEY,
  c_name VARCHAR2(50),
  credits NUMBER(5),
  d_id NUMBER(5),
  i_id NUMBER(5),
  FOREIGN KEY (d_id) REFERENCES department(d_id),
  FOREIGN KEY (i_id) REFERENCES instructor(i_id)
);

CREATE TABLE takes (
  s_id NUMBER(5),
  c_id NUMBER(5),
  attendance NUMBER(5),
  primary key(s_id,c_id),
  FOREIGN KEY (s_id) REFERENCES student(s_id) on delete cascade,
  FOREIGN KEY (c_id) REFERENCES course(c_id)
);

CREATE TABLE assignment (
  a_id NUMBER(5) PRIMARY KEY,
  a_name VARCHAR2(50),
  marks NUMBER(5),
  c_id NUMBER(5),
  s_id NUMBER(5),
  max_m NUMBER(5),
  FOREIGN KEY (c_id) REFERENCES course(c_id),
  FOREIGN KEY (s_id) REFERENCES student(s_id) on delete cascade
);
