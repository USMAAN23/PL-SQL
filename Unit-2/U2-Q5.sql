DECLARE
    v_roll_no   NUMBER := 2;
    v_n         NUMBER;


    v_a         NUMBER := 0;
    v_b         NUMBER := 1;
    v_c         NUMBER := 0;
    v_count     NUMBER := 1;
    v_nth_fib   NUMBER;
    v_i         NUMBER;
    v_is_prime  BOOLEAN := TRUE;


    v_num       NUMBER := 2;
    v_div       NUMBER;
    v_pcount    NUMBER := 0;
    v_prime_flag BOOLEAN;


    v_gcd_a     NUMBER := 56;
    v_gcd_b     NUMBER := 98;
    v_orig_a    NUMBER;
    v_orig_b    NUMBER;
    v_rem       NUMBER;


    v_perf_num  NUMBER := 28;
    v_sum       NUMBER := 0;
    v_pdiv      NUMBER := 1;
BEGIN
    
    v_n := 5 + MOD(v_roll_no, 8);

   
    DBMS_OUTPUT.PUT_LINE('=== PART A: FIRST ' || v_n || ' FIBONACCI NUMBERS ===');
    DBMS_OUTPUT.PUT_LINE('Term 1: 0');
    IF v_n >= 2 THEN
        DBMS_OUTPUT.PUT_LINE('Term 2: 1');
    END IF;

    v_count := 3;
    v_a := 0;
    v_b := 1;
    WHILE v_count <= v_n LOOP
        v_c := v_a + v_b;
        DBMS_OUTPUT.PUT_LINE('Term ' || v_count || ': ' || v_c);
        v_a := v_b;
        v_b := v_c;
        v_count := v_count + 1;
    END LOOP;

   
    IF v_n = 1 THEN
        v_nth_fib := 0;
    ELSIF v_n = 2 THEN
        v_nth_fib := 1;
    ELSE
        v_nth_fib := v_c;
    END IF;

   
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('=== PART B: PRIME CHECK FOR Nth FIBONACCI (' || v_nth_fib || ') ===');
    IF v_nth_fib < 2 THEN
        v_is_prime := FALSE;
    ELSE
        v_i := 2;
        WHILE v_i <= TRUNC(v_nth_fib / 2) LOOP
            IF MOD(v_nth_fib, v_i) = 0 THEN
                v_is_prime := FALSE;
                EXIT;
            END IF;
            v_i := v_i + 1;
        END LOOP;
    END IF;

    IF v_is_prime THEN
        DBMS_OUTPUT.PUT_LINE(v_nth_fib || ' is a Prime Number.');
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_nth_fib || ' is NOT a Prime Number.');
    END IF;

   
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('=== PART C: PRIMES BETWEEN 1 AND 100 ===');
    v_num := 2;
    WHILE v_num <= 100 LOOP
        v_prime_flag := TRUE;
        v_div := 2;
        WHILE v_div <= TRUNC(v_num / 2) LOOP
            IF MOD(v_num, v_div) = 0 THEN
                v_prime_flag := FALSE;
                EXIT;
            END IF;
            v_div := v_div + 1;
        END LOOP;

        IF v_prime_flag THEN
            DBMS_OUTPUT.PUT(v_num || ' ');
            v_pcount := v_pcount + 1;
        END IF;
        v_num := v_num + 1;
    END LOOP;
    DBMS_OUTPUT.NEW_LINE;
    DBMS_OUTPUT.PUT_LINE('Total Prime Count: ' || v_pcount);

   
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('=== PART D: GCD OF TWO NUMBERS ===');
    v_orig_a := v_gcd_a;
    v_orig_b := v_gcd_b;
    WHILE v_gcd_b != 0 LOOP
        v_rem := MOD(v_gcd_a, v_gcd_b);
        v_gcd_a := v_gcd_b;
        v_gcd_b := v_rem;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('GCD of ' || v_orig_a || ' and ' || v_orig_b || ' is: ' || v_gcd_a);

   
    DBMS_OUTPUT.PUT_LINE('');
    DBMS_OUTPUT.PUT_LINE('=== PART E: PERFECT NUMBER CHECK (' || v_perf_num || ') ===');
    v_pdiv := 1;
    v_sum := 0;
    WHILE v_pdiv <= TRUNC(v_perf_num / 2) LOOP
        IF MOD(v_perf_num, v_pdiv) = 0 THEN
            v_sum := v_sum + v_pdiv;
        END IF;
        v_pdiv := v_pdiv + 1;
    END LOOP;

    IF v_sum = v_perf_num THEN
        DBMS_OUTPUT.PUT_LINE(v_perf_num || ' is a Perfect Number (Sum of divisors = ' || v_sum || ').');
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_perf_num || ' is NOT a Perfect Number (Sum of divisors = ' || v_sum || ').');
    END IF;
END;
/