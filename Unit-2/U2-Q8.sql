DECLARE

    v_monthly_salary NUMBER := 25000;      
    v_existing_emi NUMBER := 0;          
    v_loan_amount NUMBER := 250000;     
    v_annual_rate NUMBER := 10.5;       
    v_tenure_months NUMBER := 120;        

    c_foir_pct NUMBER := 0.40;       
    c_min_salary NUMBER := 25000;      
    c_step_amount NUMBER := 10000;      

    v_monthly_rate NUMBER;
    v_foir_limit NUMBER;
    v_max_loan_allowed NUMBER;
    v_avail_foir_emi NUMBER;
    v_requested_emi NUMBER;
    v_approved_loan NUMBER := 0;
    v_approved_emi NUMBER := 0;
    v_decision_code VARCHAR2(10);
    v_decision_text VARCHAR2(50);
    v_rejection_reason VARCHAR2(100) := 'N/A';
    v_fmt              VARCHAR2(30) := 'FM99,99,99,990';
    FUNCTION calc_emi (
        p_principal NUMBER,
        p_m_rate    NUMBER,
        p_n_months  NUMBER
    ) RETURN NUMBER IS
        v_emi_val NUMBER := 0;
    BEGIN
        IF p_principal <= 0 OR p_m_rate <= 0 OR p_n_months <= 0 THEN
            RETURN 0;
        END IF;

        v_emi_val := p_principal * p_m_rate * POWER(1 + p_m_rate, p_n_months) /
                     (POWER(1 + p_m_rate, p_n_months) - 1);

        RETURN ROUND(v_emi_val);
    END calc_emi;

BEGIN
    v_monthly_rate     := (v_annual_rate / 12) / 100;
    v_foir_limit       := ROUND(v_monthly_salary * c_foir_pct);
    v_max_loan_allowed := v_monthly_salary * 60;
    v_avail_foir_emi   := v_foir_limit - v_existing_emi;

    v_requested_emi := calc_emi(v_loan_amount, v_monthly_rate, v_tenure_months);
    IF v_monthly_salary < c_min_salary THEN
        v_decision_code    := 'REJECTED';
        v_rejection_reason := 'Monthly salary is below minimum requirement of Rs. 25,000.';
        v_approved_loan    := 0;
        v_approved_emi     := 0;

    ELSIF v_avail_foir_emi <= 0 THEN
        v_decision_code    := 'REJECTED';
        v_rejection_reason := 'Existing EMIs already exceed maximum FOIR limit (40%).';
        v_approved_loan    := 0;
        v_approved_emi     := 0;

    ELSIF v_requested_emi <= v_avail_foir_emi AND v_loan_amount <= v_max_loan_allowed THEN
        v_decision_code := 'APPROVED';
        v_approved_loan := v_loan_amount;
        v_approved_emi  := v_requested_emi;

    ELSE
        v_decision_code := 'CONDITIONAL';
        v_approved_loan := LEAST(v_loan_amount, v_max_loan_allowed);
        v_approved_emi  := calc_emi(v_approved_loan, v_monthly_rate, v_tenure_months);
        WHILE v_approved_emi > v_avail_foir_emi AND v_approved_loan > 0 LOOP
            v_approved_loan := v_approved_loan - c_step_amount;
            IF v_approved_loan > 0 THEN
                v_approved_emi := calc_emi(v_approved_loan, v_monthly_rate, v_tenure_months);
            ELSE
                v_approved_emi := 0;
            END IF;
        END LOOP;

        IF v_approved_loan <= 0 THEN
            v_decision_code    := 'REJECTED';
            v_rejection_reason := 'Unable to offer loan within affordable EMI threshold.';
            v_approved_loan    := 0;
            v_approved_emi     := 0;
        END IF;
    END IF;
    v_decision_text := CASE v_decision_code
        WHEN 'APPROVED'    THEN 'APPROVED - Full requested amount granted'
        WHEN 'CONDITIONAL' THEN 'CONDITIONAL APPROVAL - Reduced loan amount offered'
        WHEN 'REJECTED'    THEN 'REJECTED - Application does not meet criteria'
        ELSE                    'UNDER REVIEW'
    END;

    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('        BANK LOAN AFFORDABILITY ASSESSMENT          ');
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('Monthly Salary        : Rs. ' || TO_CHAR(v_monthly_salary, v_fmt));
    DBMS_OUTPUT.PUT_LINE('Existing Monthly EMIs : Rs. ' || TO_CHAR(v_existing_emi, v_fmt));
    DBMS_OUTPUT.PUT_LINE('Max FOIR Limit (40%)  : Rs. ' || TO_CHAR(v_foir_limit, v_fmt));
    DBMS_OUTPUT.PUT_LINE('Available FOIR Capacity: Rs. ' || TO_CHAR(GREATEST(v_avail_foir_emi, 0), v_fmt));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Requested Loan Amount : Rs. ' || TO_CHAR(v_loan_amount, v_fmt));
    DBMS_OUTPUT.PUT_LINE('Interest Rate (p.a.)  : ' || v_annual_rate || '%');
    DBMS_OUTPUT.PUT_LINE('Tenure                : ' || v_tenure_months || ' Months (' || (v_tenure_months / 12) || ' Years)');
    DBMS_OUTPUT.PUT_LINE('Calculated EMI        : Rs. ' || TO_CHAR(v_requested_emi, v_fmt));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('DECISION              : ' || v_decision_text);

    IF v_decision_code = 'REJECTED' THEN
        DBMS_OUTPUT.PUT_LINE('Rejection Reason      : ' || v_rejection_reason);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Approved Loan Amount  : Rs. ' || TO_CHAR(v_approved_loan, v_fmt));
        DBMS_OUTPUT.PUT_LINE('Approved Loan EMI     : Rs. ' || TO_CHAR(v_approved_emi, v_fmt));
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('MONTHLY OBLIGATION BREAKDOWN:');
        DBMS_OUTPUT.PUT_LINE('  - Existing EMIs     : Rs. ' || TO_CHAR(v_existing_emi, v_fmt));
        DBMS_OUTPUT.PUT_LINE('  - New Loan EMI      : Rs. ' || TO_CHAR(v_approved_emi, v_fmt));
        DBMS_OUTPUT.PUT_LINE('  - Total Monthly EMI : Rs. ' || TO_CHAR(v_existing_emi + v_approved_emi, v_fmt));
        DBMS_OUTPUT.PUT_LINE('  - Net Remaining Pay : Rs. ' || TO_CHAR(v_monthly_salary - (v_existing_emi + v_approved_emi), v_fmt));
    END IF;

    DBMS_OUTPUT.PUT_LINE('====================================================');
END;
/