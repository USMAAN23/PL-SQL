DECLARE
    v_roll_no NUMBER := 2;
    v_student_name VARCHAR2(50) := 'Usmaan Ansari';
    v_attendance_pct NUMBER := 51;      
    v_theory_marks NUMBER := 31;        
    v_practical_marks NUMBER := 13;        
    v_assignment_marks NUMBER := 10;       

    v_assigned_counted NUMBER := 0;
    v_total_marks      NUMBER := 0;
    v_overall_pct      NUMBER := 0;
    v_status           VARCHAR2(30);
    v_grade            VARCHAR2(15);
    v_remark           VARCHAR2(100);
    v_fmt              VARCHAR2(20) := 'FM990.00';
BEGIN
  
    v_assigned_counted := LEAST(v_assignment_marks, 10);
    IF v_attendance_pct < 40 THEN
        v_status := 'DETAINED';
        v_grade  := 'F';
        v_remark := 'Shortage of attendance (<40%). Repeat semester required.';
    ELSIF v_theory_marks < 28 AND v_practical_marks < 12 THEN
        v_status := 'FAIL';
        v_grade  := 'F';
        v_remark := 'Failed in both Theory (<28) and Practical (<12).';
    ELSIF v_theory_marks < 28 THEN
        v_status := 'FAIL';
        v_grade  := 'F';
        v_remark := 'Failed in Theory (min 28 required out of 70).';
    ELSIF v_practical_marks < 12 THEN
        v_status := 'FAIL';
        v_grade  := 'F';
        v_remark := 'Failed in Practical (min 12 required out of 30).';
    ELSE
        v_status := 'PASS';
    END IF;

    v_total_marks := v_theory_marks + v_practical_marks + v_assigned_counted;
    v_overall_pct := ROUND((v_total_marks / 110) * 100, 2);
    IF v_status = 'PASS' THEN
        v_grade := CASE 
            WHEN v_overall_pct >= 85 THEN 'O'
            WHEN v_overall_pct >= 75 THEN 'A+'
            WHEN v_overall_pct >= 65 THEN 'A'
            WHEN v_overall_pct >= 55 THEN 'B'
            WHEN v_overall_pct >= 45 THEN 'C'
            ELSE 'D'
        END;

        v_remark := CASE v_grade
            WHEN 'O'  THEN 'DISTINCTION - Outstanding performance!'
            WHEN 'A+' THEN 'DISTINCTION - Excellent performance!'
            WHEN 'A'  THEN 'FIRST CLASS - Very Good performance.'
            WHEN 'B'  THEN 'SECOND CLASS - Good performance.'
            WHEN 'C'  THEN 'PASS CLASS - Satisfactory performance.'
            ELSE           'PASS CLASS - Average performance, scope for improvement.'
        END;
    END IF;

    DBMS_OUTPUT.PUT_LINE('===============================================================');
    DBMS_OUTPUT.PUT_LINE('             LOK JAGRUTI KEHAL INSTITUTE (LJICA)              ');
    DBMS_OUTPUT.PUT_LINE('                   SEMESTER RESULT SHEET                       ');
    DBMS_OUTPUT.PUT_LINE('===============================================================');
    DBMS_OUTPUT.PUT_LINE('Roll No.          : ' || v_roll_no);
    DBMS_OUTPUT.PUT_LINE('Student Name      : ' || v_student_name);
    DBMS_OUTPUT.PUT_LINE('Attendance        : ' || v_attendance_pct || '%');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Theory Marks      : ' || LPAD(v_theory_marks, 2) || ' / 70  (Min: 28)');
    DBMS_OUTPUT.PUT_LINE('Practical Marks   : ' || LPAD(v_practical_marks, 2) || ' / 30  (Min: 12)');
    DBMS_OUTPUT.PUT_LINE('Assignment Marks  : ' || LPAD(v_assigned_counted, 2) || ' / 10  (Submitted: ' || v_assignment_marks || '/20)');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total Marks       : ' || LPAD(v_total_marks, 3) || ' / 110');
    DBMS_OUTPUT.PUT_LINE('Overall Percentage: ' || TO_CHAR(v_overall_pct, v_fmt) || '%');
    DBMS_OUTPUT.PUT_LINE('Final Status      : ' || v_status);
    DBMS_OUTPUT.PUT_LINE('Grade             : ' || v_grade);
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('REMARK            : ' || v_remark);
    DBMS_OUTPUT.PUT_LINE('===============================================================');
END;
/