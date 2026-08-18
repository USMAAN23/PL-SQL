DECLARE
    v_roll_no NUMBER := 15;
    v_balance NUMBER := (15 * 500) + 5000;
    v_total_withdrawn  NUMBER := 0;
    v_txn_count NUMBER := 0;
    v_iter NUMBER := 1;
    v_choice NUMBER;
    v_withdraw_amt NUMBER;
    v_fmt VARCHAR2(30) := 'FM99,99,99,990.00';
BEGIN
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('              WELCOME TO LJKU ATM                   ');
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('Initial Balance : Rs. ' || TO_CHAR(v_balance, v_fmt));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');

    LOOP
        IF v_iter = 1 THEN
            v_choice       := 1; 
            v_withdraw_amt := 2000;
        ELSIF v_iter = 2 THEN
            v_choice       := 1;
            v_withdraw_amt := 15000;
        ELSIF v_iter = 3 THEN
            v_choice       := 1;
            v_withdraw_amt := 350;
        ELSIF v_iter = 4 THEN
            v_choice       := 1;
            v_withdraw_amt := 5000;
        ELSE
            v_choice       := 3; 
            v_withdraw_amt := 0;
        END IF;

        DBMS_OUTPUT.PUT_LINE('--- Iteration ' || v_iter || ' ---');
        EXIT WHEN v_choice = 3 OR v_balance = 0;

        IF v_choice = 1 THEN
            DBMS_OUTPUT.PUT_LINE('Requested Withdrawal: Rs. ' || TO_CHAR(v_withdraw_amt, v_fmt));

            IF v_withdraw_amt <= 0 THEN
                DBMS_OUTPUT.PUT_LINE('ERROR: Withdrawal amount must be greater than 0.');
            ELSIF MOD(v_withdraw_amt, 100) != 0 THEN
                DBMS_OUTPUT.PUT_LINE('ERROR: Amount must be in multiples of 100.');
            ELSIF v_withdraw_amt > 10000 THEN
                DBMS_OUTPUT.PUT_LINE('ERROR: Maximum withdrawal per transaction is Rs. 10,000.00.');
            ELSIF v_withdraw_amt > v_balance THEN
                DBMS_OUTPUT.PUT_LINE('ERROR: Insufficient account balance.');
            ELSE

                v_balance         := v_balance - v_withdraw_amt;
                v_total_withdrawn := v_total_withdrawn + v_withdraw_amt;
                v_txn_count       := v_txn_count + 1;

                DBMS_OUTPUT.PUT_LINE('SUCCESS: Please collect your cash.');
                DBMS_OUTPUT.PUT_LINE('Remaining Balance   : Rs. ' || TO_CHAR(v_balance, v_fmt));
            END IF;
        END IF;

        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');


        v_iter := v_iter + 1;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('                TRANSACTION SUMMARY                 ');
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('Total Successful Taxation : ' || v_txn_count);
    DBMS_OUTPUT.PUT_LINE('Total Cash Withdrawn  : Rs. ' || TO_CHAR(v_total_withdrawn, v_fmt));
    DBMS_OUTPUT.PUT_LINE('Closing Balance       : Rs. ' || TO_CHAR(v_balance, v_fmt));
    DBMS_OUTPUT.PUT_LINE('====================================================');
END;
/