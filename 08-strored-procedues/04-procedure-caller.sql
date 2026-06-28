-- Here Procedure is GREET
CREATE OR REPLACE PROCEDURE GREET
(
    p_name IN VARCHAR2
)
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello ' || p_name);
END;
/

-- Here Caller is GREET
BEGIN
    GREET('John');
END;
/
