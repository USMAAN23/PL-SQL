DECLARE
   v_name VARCHAR2(50) := 'Usmaan Ansari'; 
   v_marks NUMBER(5,2)  := 425.50;   
   v_percentage NUMBER(5,2);            
   v_dob DATE := TO_DATE('2006-05-15', 'YYYY-MM-DD'); 
   v_passed BOOLEAN;          
BEGIN
   v_percentage := ROUND((v_marks / 500) * 100, 2);
   IF v_percentage >= 40 THEN
      v_passed := TRUE;
   ELSE
      v_passed := FALSE;
   END IF;
   DBMS_OUTPUT.PUT_LINE('----------------------------------------');
   DBMS_OUTPUT.PUT_LINE('Student Name   : ' || v_name);
   DBMS_OUTPUT.PUT_LINE('Marks Obtained : ' || v_marks || ' / 500');
   DBMS_OUTPUT.PUT_LINE('Percentage     : ' || v_percentage || '%');
   DBMS_OUTPUT.PUT_LINE('Date of Birth  : ' || TO_CHAR(v_dob, 'DD-Mon-YYYY'));
   DBMS_OUTPUT.PUT_LINE('Today''s Date   : ' || TO_CHAR(SYSDATE, 'DD-Mon-YYYY HH24:MI:SS'));
   
   IF v_passed THEN
      DBMS_OUTPUT.PUT_LINE('Result Status  : PASS');
   ELSE
      DBMS_OUTPUT.PUT_LINE('Result Status  : FAIL');
   END IF;
   DBMS_OUTPUT.PUT_LINE('----------------------------------------');
END;
/
