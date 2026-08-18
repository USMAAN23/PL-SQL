DECLARE
v_name VARCHAR2(30) := 'Usmaan Ansari';
v_rollno NUMBER := 02;
v_message VARCHAR2(100);
v_lucky_number NUMBER;

BEGIN
  DBMS_OUTPUT.PUT_LINE('My Name Is: ' || v_name);
  DBMS_OUTPUT.PUT_LINE('My Roll No Is: ' || v_rollno);
  v_message := 'Welcome to PL/SQL';
  DBMS_OUTPUT.PUT_LINE('My Message' || v_message);
  v_lucky_number := MOD(v_rollno, 7) + 1;
  DBMS_OUTPUT.PUT_LINE('My Lucky Number' || v_lucky_number);
END;
/
