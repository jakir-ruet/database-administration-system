-- In PL/SQL "Hello, World!"
begin
	dbms_output.put_line('Hello, World!');
end;
/

-- Hello, World! with a variable
DECLARE
    v_message VARCHAR2(100);
BEGIN
    v_message := 'This is my first stored procedure';
    DBMS_OUTPUT.PUT_LINE(v_message);
END;
/

-- Adding two numbers
DECLARE
    a INTEGER := 10;
    b INTEGER := 20;
    c INTEGER;
BEGIN
    c := a + b;
    DBMS_OUTPUT.PUT_LINE('The summation is: ' || c);
END;
/

-- Local and Grobal Variables
DECLARE
    -- Global variable
    n1 NUMBER := 100;
    n2 NUMBER := 200;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Global variable n1: ' || n1);
    DBMS_OUTPUT.PUT_LINE('Global variable n2: ' || n2);
    DECLARE
    -- Local variable
    n3 NUMBER := 120;
    n4 NUMBER := 150;
BEGIN
    DBMS_OUTPUT.PUT_LINE('Local variable n3: ' || n3);
    DBMS_OUTPUT.PUT_LINE('Local variable n4: ' || n4);
END;
END;
/
