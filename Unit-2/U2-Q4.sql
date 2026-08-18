DECLARE
    v_roll_no NUMBER := 02;
    v_table_num NUMBER;
    v_height NUMBER;
    v_line VARCHAR2(500);
BEGIN
    v_table_num := MOD(v_roll_no, 9) + 2;
    v_height    := 5 + MOD(v_roll_no, 5);

    DBMS_OUTPUT.PUT_LINE('=== PART A: MULTIPLICATION TABLE OF ' || v_table_num || ' ===');
    FOR i IN 1..20 LOOP
        DBMS_OUTPUT.PUT_LINE(LPAD(v_table_num, 2) || ' x ' || LPAD(i, 2) || ' = ' || LPAD(v_table_num * i, 4));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');


    DBMS_OUTPUT.PUT_LINE('=== PART B: TABLES 2 TO 5 ===');
    FOR i IN 1..10 LOOP
        v_line := '';
        FOR j IN 2..5 LOOP
            v_line := v_line || LPAD(j || 'x' || i || '=' || (j * i), 12);
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(v_line);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');


    DBMS_OUTPUT.PUT_LINE('=== PART C: STAR TRIANGLE (HEIGHT ' || v_height || ') ===');
    FOR i IN 1..v_height LOOP
        v_line := '';
        FOR j IN 1..i LOOP
            v_line := v_line || '*';
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(v_line);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');

    DBMS_OUTPUT.PUT_LINE('=== PART D: NUMBER PYRAMID ===');
    FOR i IN 1..6 LOOP
        v_line := '';
        FOR j IN 1..i LOOP
            v_line := v_line || j;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(v_line);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('');


    DBMS_OUTPUT.PUT_LINE('=== PART E: REVERSE STAR TRIANGLE ===');
    FOR i IN REVERSE 1..v_height LOOP
        v_line := '';
        FOR j IN 1..i LOOP
            v_line := v_line || '*';
        END LOOP;
        DBMS_OUTPUT.PUT_LINE(v_line);
    END LOOP;
END;
/