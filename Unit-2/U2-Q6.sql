DECLARE
    v_food_amount NUMBER  := 350;      
    v_distance NUMBER  := 5;       
    v_is_rain BOOLEAN := TRUE;    
    v_is_late_night BOOLEAN := FALSE;   
    v_is_festival BOOLEAN := FALSE;   
    v_is_peak_hour BOOLEAN := FALSE;   
    v_is_first_order BOOLEAN := FALSE; 

    
    v_base_charge NUMBER := 0;
    v_surcharge_pct NUMBER := 0;
    v_surcharge_amt NUMBER := 0;
    v_delivery_charge NUMBER := 0;
    v_discount_amt NUMBER := 0;
    v_final_delivery NUMBER := 0;
    v_grand_total NUMBER := 0;
    v_fmt VARCHAR2(30) := 'FM99,99,99,990';
BEGIN
    IF v_distance < 3 THEN
        v_base_charge := 0;
    ELSIF v_distance BETWEEN 3 AND 8 THEN
        v_base_charge := 29;
    ELSIF v_distance BETWEEN 8 AND 15 THEN
        v_base_charge := 49;
    ELSE
        v_base_charge := 79;
    END IF;
    v_surcharge_pct := 
        CASE WHEN v_is_rain THEN 20 ELSE 0 END +
        CASE WHEN v_is_late_night THEN 15 ELSE 0 END +
        CASE WHEN v_is_festival THEN 10 ELSE 0 END +
        CASE WHEN v_is_peak_hour THEN 10 ELSE 0 END;

    v_surcharge_amt  := ROUND(v_base_charge * (v_surcharge_pct / 100));
    v_delivery_charge := v_base_charge + v_surcharge_amt;

    IF v_food_amount > 499 THEN

        v_discount_amt   := v_delivery_charge;
        v_final_delivery := 0;
    ELSIF v_is_first_order THEN

        v_discount_amt   := ROUND(v_delivery_charge * 0.50);
        v_final_delivery := v_delivery_charge - v_discount_amt;
    ELSE
        v_discount_amt   := 0;
        v_final_delivery := v_delivery_charge;
    END IF;

    v_grand_total := v_food_amount + v_final_delivery;
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('             ZOMATO DELIVERY RECEIPT                ');
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('Food Subtotal          : Rs. ' || TO_CHAR(v_food_amount, v_fmt));
    DBMS_OUTPUT.PUT_LINE('Delivery Distance      : ' || v_distance || ' km');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Base Delivery Charge   : Rs. ' || TO_CHAR(v_base_charge, v_fmt));
    DBMS_OUTPUT.PUT_LINE('Surcharges (' || LPAD(v_surcharge_pct, 2) || '%)      : Rs. ' || TO_CHAR(v_surcharge_amt, v_fmt));
    
    IF v_is_rain THEN
        DBMS_OUTPUT.PUT_LINE('  - Rain Surge (+20%)');
    END IF;
    IF v_is_late_night THEN
        DBMS_OUTPUT.PUT_LINE('  - Late Night Surge (+15%)');
    END IF;
    IF v_is_festival THEN
        DBMS_OUTPUT.PUT_LINE('  - Festival Surge (+10%)');
    END IF;
    IF v_is_peak_hour THEN
        DBMS_OUTPUT.PUT_LINE('  - Peak Hour Surge (+10%)');
    END IF;

    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Gross Delivery Charge  : Rs. ' || TO_CHAR(v_delivery_charge, v_fmt));
    DBMS_OUTPUT.PUT_LINE('Discounts Applied      : -Rs.' || TO_CHAR(v_discount_amt, v_fmt));

    IF v_food_amount > 499 THEN
        DBMS_OUTPUT.PUT_LINE('  - Free Delivery (Order > Rs. 499)');
    ELSIF v_is_first_order THEN
        DBMS_OUTPUT.PUT_LINE('  - First Order Discount (50% OFF)');
    END IF;

    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Net Delivery Charge    : Rs. ' || TO_CHAR(v_final_delivery, v_fmt));
    DBMS_OUTPUT.PUT_LINE('====================================================');
    DBMS_OUTPUT.PUT_LINE('GRAND TOTAL            : Rs. ' || TO_CHAR(v_grand_total, v_fmt));
    DBMS_OUTPUT.PUT_LINE('====================================================');
END;
/