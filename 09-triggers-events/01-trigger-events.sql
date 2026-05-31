CREATE TABLE employees (
    emp_id NUMBER PRIMARY KEY,
    emp_name VARCHAR2(100),
    salary NUMBER
);

-- A trigger created
CREATE OR REPLACE TRIGGER insert_trigger
BEFORE INSERT
ON employees
FOR EACH ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE('New employee created');
END;
/

INSERT INTO employees
VALUES (1, 'Jakir', 5000);
