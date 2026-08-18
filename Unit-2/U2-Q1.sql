DECLARE
    v_student_name VARCHAR2(50) := 'Usmaan Ansari';
    v_roll_no NUMBER:= 02;
    v_m1 NUMBER := 85; 
    v_m2 NUMBER := 78; 
    v_m3 NUMBER := 92; 
    v_m4 NUMBER := 64; 
    v_m5 NUMBER := 70; 

    v_total        NUMBER;
    v_percentage   NUMBER;
    v_grade        VARCHAR2(10);
    v_class_rank   VARCHAR2(30);
    v_is_detained  BOOLEAN := FALSE;
    v_fail_msg     VARCHAR2(200) := '';
BEGIN
   IF v_m1 < 35 THEN
        v_is_detained := TRUE;
        v_fail_msg := 'DBMS';
    ELSIF v_m2 < 35 THEN
        v_is_detained := TRUE;
        v_fail_msg := 'PHP';
    ELSIF v_m3 < 35 THEN
        v_is_detained := TRUE;
        v_fail_msg := 'Python';
    ELSIF v_m4 < 35 THEN
        v_is_detained := TRUE;
        v_fail_msg := 'Prompt Engineering';
    ELSIF v_m5 < 35 THEN
        v_is_detained := TRUE;
        v_fail_msg := 'Ethics';
    ELSE
        v_is_detained := FALSE;
    END IF;
    v_total      := v_m1 + v_m2 + v_m3 + v_m4 + v_m5;
    v_percentage := v_total / 5;
    IF v_is_detained THEN
        v_grade      := 'FAIL';
        v_class_rank := 'DETAINED (' || v_fail_msg || ')';
    ELSE
        IF v_percentage >= 90 THEN
            v_grade := 'A+';
        ELSIF v_percentage >= 80 THEN
            v_grade := 'A';
        ELSIF v_percentage >= 70 THEN
            v_grade := 'B';
        ELSIF v_percentage >= 60 THEN
            v_grade := 'C';
        ELSIF v_percentage >= 50 THEN
            v_grade := 'D';
        ELSE
            v_grade := 'FAIL';
        END IF;

        IF v_percentage >= 75 THEN
            v_class_rank := 'Distinction';
        ELSIF v_percentage >= 60 THEN
            v_class_rank := 'First Class';
        ELSIF v_percentage >= 50 THEN
            v_class_rank := 'Second Class';
        ELSE
            v_class_rank := 'Pass Class';
        END IF;
    END IF;
    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('           LJKU GRADE CARD REPORT             ');
    DBMS_OUTPUT.PUT_LINE('==============================================');
    DBMS_OUTPUT.PUT_LINE('Student Name : ' || v_student_name);
    DBMS_OUTPUT.PUT_LINE('Roll Number  : ' || LPAD(v_roll_no, 3, '0'));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('DBMS : ' || v_m1 || '/100');
    DBMS_OUTPUT.PUT_LINE('PHP : ' || v_m2 || '/100');
    DBMS_OUTPUT.PUT_LINE('Python : ' || v_m3 || '/100');
    DBMS_OUTPUT.PUT_LINE('Prompt Engineering : ' || v_m4 || '/100');
    DBMS_OUTPUT.PUT_LINE('Ethics : ' || v_m5 || '/100');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total Marks : ' || v_total || '/500');
    DBMS_OUTPUT.PUT_LINE('Percentage : ' || TO_CHAR(v_percentage, 'FM990.00') || '%');
    DBMS_OUTPUT.PUT_LINE('Grade : ' || v_grade);
    DBMS_OUTPUT.PUT_LINE('Result / Rank : ' || v_class_rank);
    DBMS_OUTPUT.PUT_LINE('==============================================');
  END;
/