DECLARE
    v_p NUMBER := 100000; 
    v_r NUMBER := 8.5;    
    v_t NUMBER := 5;      
    v_si NUMBER;
    v_ci NUMBER;
    v_si_final NUMBER;
    v_ci_final NUMBER;
    v_diff NUMBER;
    v_diff_pct NUMBER;
    v_fmt VARCHAR2(30) := 'FM999,999,999,990.00';
BEGIN
    v_si := (v_p * v_r * v_t) / 100;
    v_si_final := v_p + v_si;
    v_ci := v_p * (POWER(1 + (v_r / 100), v_t)) - v_p;
    v_ci_final := v_p + v_ci;
    v_diff := v_ci - v_si;
    v_diff_pct := (v_ci - v_si) / v_si * 100;
    DBMS_OUTPUT.PUT_LINE('-----------BANK INTEREST CALCULATOR-----------');
    DBMS_OUTPUT.PUT_LINE('Principal       : ' || TO_CHAR(v_p, v_fmt));
    DBMS_OUTPUT.PUT_LINE('Rate (%)        : ' || v_r || '%');
    DBMS_OUTPUT.PUT_LINE('Time (Years)    : ' || v_t);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Simple Interest : ' || TO_CHAR(v_si, v_fmt));
    DBMS_OUTPUT.PUT_LINE('SI Final Amount : ' || TO_CHAR(v_si_final, v_fmt));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Compound Interest: ' || TO_CHAR(v_ci, v_fmt));
    DBMS_OUTPUT.PUT_LINE('CI Final Amount : ' || TO_CHAR(v_ci_final, v_fmt));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('CI - SI Difference : ' || TO_CHAR(v_diff, v_fmt));
    IF v_diff_pct > 10 THEN
        DBMS_OUTPUT.PUT_LINE('Tip: FD is better than savings account for this amount.');
    END IF;
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
END;
/