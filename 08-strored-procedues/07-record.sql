------------------
-- Create Table
------------------
CREATE TABLE employees (
    empid NUMBER PRIMARY KEY,
    name VARCHAR2(30),
    salary NUMBER
);

------------------
-- Insert Data
------------------
INSERT INTO employees VALUES (1,'Jakir',5000);
INSERT INTO employees VALUES (2,'John',6000);
INSERT INTO employees VALUES (3,'Alice',7000);

COMMIT;

------------------
-- Without RECORD
------------------
DECLARE
    v_id     NUMBER;
    v_name   VARCHAR2(30);
    v_salary NUMBER;
BEGIN
    SELECT empid, name, salary
    INTO v_id, v_name, v_salary
    FROM employees
    WHERE empid = 2;

    DBMS_OUTPUT.PUT_LINE(v_id);
    DBMS_OUTPUT.PUT_LINE(v_name);
    DBMS_OUTPUT.PUT_LINE(v_salary);
END;
/

------------------
-- With RECORD:
------------------
DECLARE
    emp_rec employees%ROWTYPE;
BEGIN
    SELECT empid, name, salary
    INTO emp_rec
    FROM employees
    WHERE empid = 1;

    DBMS_OUTPUT.PUT_LINE(emp_rec.empid);
    DBMS_OUTPUT.PUT_LINE(emp_rec.name);
    DBMS_OUTPUT.PUT_LINE(emp_rec.salary);
END;
/
