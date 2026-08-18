<<student_id_card>>
DECLARE
    v_raw_name VARCHAR2(50) := 'Usmaan Ansari';
    v_roll_no NUMBER := 02;
    v_dob DATE := TO_DATE('23-MAR-2007', 'DD-MON-YYYY');
    v_full_name VARCHAR2(50);
    v_first_name VARCHAR2(30);
    v_last_name VARCHAR2(30);
    v_space_pos NUMBER;
    v_student_id VARCHAR2(20);
    v_age NUMBER;
BEGIN
    v_full_name := UPPER(TRIM(v_raw_name));
    v_space_pos := INSTR(v_full_name, ' ');

    IF v_space_pos > 0 THEN
        v_first_name := SUBSTR(v_full_name, 1, v_space_pos - 1);
        v_last_name  := SUBSTR(v_full_name, v_space_pos + 1);

        IF LENGTH(v_full_name) > 20 THEN
            v_full_name := v_first_name || ' ' || SUBSTR(v_last_name, 1, 1) || '.';
        END IF;
    ELSE
        v_first_name := v_full_name;
    END IF;

    v_student_id := 'LJICA' || TO_CHAR(v_dob, 'YYYY') || LPAD(v_roll_no, 3, '0');
    v_age := TRUNC(MONTHS_BETWEEN(SYSDATE, v_dob) / 12);
    DBMS_OUTPUT.PUT_LINE('+' || RPAD('-', 42, '-') || '+');
    DBMS_OUTPUT.PUT_LINE('| ' || RPAD('LJKU - LJICA STUDENT ID CARD', 40, ' ') || ' |');
    DBMS_OUTPUT.PUT_LINE('+' || RPAD('-', 42, '-') || '+');
    DBMS_OUTPUT.PUT_LINE('| ' || RPAD('ID CARD NO : ' || v_student_id, 40, ' ') || ' |');
    DBMS_OUTPUT.PUT_LINE('| ' || RPAD('FULL NAME  : ' || v_full_name, 40, ' ') || ' |');
    DBMS_OUTPUT.PUT_LINE('| ' || RPAD('FIRST NAME : ' || v_first_name, 40, ' ') || ' |');
    DBMS_OUTPUT.PUT_LINE('| ' || RPAD('ROLL NO    : ' || LPAD(v_roll_no, 3, '0'), 40, ' ') || ' |');
    DBMS_OUTPUT.PUT_LINE('| ' || RPAD('DOB        : ' || TO_CHAR(v_dob, 'DD-MON-YYYY'), 40, ' ') || ' |');
    DBMS_OUTPUT.PUT_LINE('| ' || RPAD('AGE        : ' || v_age || ' Years', 40, ' ') || ' |');
    DBMS_OUTPUT.PUT_LINE('+' || RPAD('-', 42, '-') || '+');
END student_id_card;
/