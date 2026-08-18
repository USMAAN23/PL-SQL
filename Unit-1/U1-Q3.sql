DECLARE
  c_gst_rate CONSTANT NUMBER := 18;
  v_base_price NUMBER := 1000;
  v_cgst_rate NUMBER;
  v_sgst_rate NUMBER;
  v_total_rate NUMBER;
BEGIN
  v_cgst_rate := v_base_price * 9/100;
  v_sgst_rate := v_base_price * 9/100;
  v_total_rate := v_base_price + v_cgst_rate + v_sgst_rate;
  DBMS_OUTPUT.PUT_LINE('BASE PRICE: ' || v_base_price);
  DBMS_OUTPUT.PUT_LINE('CGST: ' || v_cgst_rate);
  DBMS_OUTPUT.PUT_LINE('SGST: ' || v_sgst_rate);
  DBMS_OUTPUT.PUT_LINE('=============================================');
  DBMS_OUTPUT.PUT_LINE('TOTAL RATE: ' || v_total_rate);
  DBMS_OUTPUT.PUT_LINE('=============================================');
END;
/

//part2
DECLARE
  v_city VARCHAR2(50) := NULL;
  v_city_nvl VARCHAR2(50);
  v_city_status VARCHAR(100);
BEGIN
  v_city_nvl := NVL(v_city, 'Ahmedabad');
  v_city_status := NVL2(
    v_city,
    'CITY  KNOWN: ' || v_city,
    'CITY UNKNOWN: '
  );
DBMS_OUTPUT.PUT_LINE('--- INITIAL STATE (v_city IS NULL) ---');
DBMS_OUTPUT.PUT_LINE('NVL Result: ' || v_city_nvl);
DBMS_OUTPUT.PUT_LINE('NVL2 Result: ' ||v_city_status);
DBMS_OUTPUT.PUT_LINE('');
v_city := 'MUMBAI';
v_city_nvl    := NVL(v_city, 'Ahmedabad');
   v_city_status := NVL2(
      v_city,
      'City Known: ' || v_city,
      'City Unknown'
   );
   DBMS_OUTPUT.PUT_LINE('--- UPDATED STATE (v_city = ''Mumbai'') ---');
   DBMS_OUTPUT.PUT_LINE('NVL Result  : ' || v_city_nvl);
   DBMS_OUTPUT.PUT_LINE('NVL2 Result : ' || v_city_status);
END;
/