CREATE TABLE employees (
    empid 	NUMBER PRIMARY KEY,
    name 	VARCHAR2(30),
    salary 	NUMBER
);

INSERT INTO employees VALUES (1,'Jakir',5000);
INSERT INTO employees VALUES (2,'John',6000);
INSERT INTO employees VALUES (3,'Alice',7000);

COMMIT;

-- Cursor
--    |
--    V
-- +-------+---------+--------+
-- | 1     | Jakir   | 5000   |
-- +-------+---------+--------+
--         |
--         V
-- +-------+---------+--------+
-- | 2     | John    | 6000   |
-- +-------+---------+--------+
--         |
--         V
-- +-------+---------+--------+
-- | 3     | Alice   | 7000   |
-- +-------+---------+--------+

-- The cursor points to one row at a time.

---------------
-- %FOUND`
---------------
DECLARE
    CURSOR c IS
        SELECT empid, name FROM employees;

    v_id employees.empid%TYPE;
    v_name employees.name%TYPE;
BEGIN
    OPEN c;

    FETCH c INTO v_id, v_name;

    IF c%FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Row Found: ' || v_name);
    END IF;

    CLOSE c;
END;
/

-- Means: last FETCH successfully got a row.


---------------
-- %NOTFOUND
---------------
DECLARE
    CURSOR c IS
        SELECT empid, name FROM employees;

    v_id employees.empid%TYPE;
    v_name employees.name%TYPE;
BEGIN
    OPEN c;

    LOOP
        FETCH c INTO v_id, v_name;

        EXIT WHEN c%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE(v_name);
    END LOOP;

    CLOSE c;
END;
/
-- Means: no more rows to fetch.


---------------
-- %ROWCOUNT
---------------
DECLARE
    CURSOR c IS
        SELECT empid, name FROM employees;

    v_id employees.empid%TYPE;
    v_name employees.name%TYPE;
BEGIN
    OPEN c;

    LOOP
        FETCH c INTO v_id, v_name;

        EXIT WHEN c%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Row No: ' || c%ROWCOUNT || ' Name: ' || v_name);
    END LOOP;

    CLOSE c;
END;
/

-- Means: how many rows have been fetched so far.

---------------
-- %ISOPEN
---------------
DECLARE
    CURSOR c IS
        SELECT empid, name FROM employees;

BEGIN
    OPEN c;

    IF c%ISOPEN THEN
        DBMS_OUTPUT.PUT_LINE('Cursor is OPEN');
    END IF;

    CLOSE c;

    IF NOT c%ISOPEN THEN
        DBMS_OUTPUT.PUT_LINE('Cursor is CLOSED');
    END IF;
END;
/

