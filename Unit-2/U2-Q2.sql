DECLARE
    v_gross_salary NUMBER := 1000000; 
    c_std_deduction CONSTANT NUMBER := 75000;
    v_taxable_income NUMBER;
    v_tax_slab_1 NUMBER := 0; 
    v_tax_slab_2 NUMBER := 0; 
    v_tax_slab_3 NUMBER := 0;
    v_tax_slab_4 NUMBER := 0;
    v_tax_slab_5 NUMBER := 0;
    v_tax_slab_6 NUMBER := 0;
    v_total_tax  NUMBER := 0;
    v_monthly_tds NUMBER := 0;
    v_monthly_takehome NUMBER := 0;
    v_fmt VARCHAR2(30) := 'FM99,99,99,990.00';
BEGIN
    v_taxable_income := GREATEST(0, v_gross_salary - c_std_deduction);
    v_tax_slab_1 := 0;
    v_tax_slab_2 := CASE 
                        WHEN v_taxable_income > 700000 THEN 400000 * 0.05
                        WHEN v_taxable_income > 300000 THEN (v_taxable_income - 300000) * 0.05
                        ELSE 0
                    END;
    v_tax_slab_3 := CASE 
                        WHEN v_taxable_income > 1000000 THEN 300000 * 0.10
                        WHEN v_taxable_income > 700000  THEN (v_taxable_income - 700000) * 0.10
                        ELSE 0
                    END;
    v_tax_slab_4 := CASE 
                        WHEN v_taxable_income > 1200000 THEN 200000 * 0.15
                        WHEN v_taxable_income > 1000000 THEN (v_taxable_income - 1000000) * 0.15
                        ELSE 0
                    END;
    v_tax_slab_5 := CASE 
                        WHEN v_taxable_income > 1500000 THEN 300000 * 0.20
                        WHEN v_taxable_income > 1200000 THEN (v_taxable_income - 1200000) * 0.20
                        ELSE 0
                    END;
    v_tax_slab_6 := CASE 
                        WHEN v_taxable_income > 1500000 THEN (v_taxable_income - 1500000) * 0.30
                        ELSE 0
                    END;
    v_total_tax        := v_tax_slab_1 + v_tax_slab_2 + v_tax_slab_3 + 
                          v_tax_slab_4 + v_tax_slab_5 + v_tax_slab_6;
    
    v_monthly_tds      := v_total_tax / 12;
    v_monthly_takehome := (v_gross_salary - v_total_tax) / 12;
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('   INDIAN INCOME TAX CALCULATOR (FY 2024-25)        ');
    DBMS_OUTPUT.PUT_LINE('   New Tax Regime Breakdown                         ');
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('Gross Annual Salary    : Rs. ' || TO_CHAR(v_gross_salary, v_fmt));
    DBMS_OUTPUT.PUT_LINE('Standard Deduction     : Rs. ' || TO_CHAR(c_std_deduction, v_fmt));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Taxable Income         : Rs. ' || TO_CHAR(v_taxable_income, v_fmt));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('TAX SLAB BREAKDOWN:');
    DBMS_OUTPUT.PUT_LINE('  0 - 3 Lakhs (0%)     : Rs. ' || TO_CHAR(v_tax_slab_1, v_fmt));
    DBMS_OUTPUT.PUT_LINE('  3 - 7 Lakhs (5%)     : Rs. ' || TO_CHAR(v_tax_slab_2, v_fmt));
    DBMS_OUTPUT.PUT_LINE('  7 - 10 Lakhs (10%)   : Rs. ' || TO_CHAR(v_tax_slab_3, v_fmt));
    DBMS_OUTPUT.PUT_LINE(' 10 - 12 Lakhs (15%)   : Rs. ' || TO_CHAR(v_tax_slab_4, v_fmt));
    DBMS_OUTPUT.PUT_LINE(' 12 - 15 Lakhs (20%)   : Rs. ' || TO_CHAR(v_tax_slab_5, v_fmt));
    DBMS_OUTPUT.PUT_LINE(' > 15 Lakhs (30%)      : Rs. ' || TO_CHAR(v_tax_slab_6, v_fmt));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Total Annual Tax       : Rs. ' || TO_CHAR(v_total_tax, v_fmt));
    DBMS_OUTPUT.PUT_LINE('Monthly TDS Deducted   : Rs. ' || TO_CHAR(v_monthly_tds, v_fmt));
    DBMS_OUTPUT.PUT_LINE('Monthly Take-Home      : Rs. ' || TO_CHAR(v_monthly_takehome, v_fmt));
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');

    IF v_total_tax = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No tax this year — save more with PPF/ELSS!');
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    END IF;

    DBMS_OUTPUT.PUT_LINE('====================================================');
END;
/