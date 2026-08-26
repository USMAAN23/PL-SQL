DECLARE
   CURSOR c_pub_by_country (p_country publisher.country%TYPE) IS
      SELECT pub_id, pub_name, city
      FROM publisher
      WHERE UPPER(country) = UPPER(p_country);
   v_target_country publisher.country%TYPE := 'India';
   v_found BOOLEAN := FALSE;
BEGIN
   DBMS_OUTPUT.PUT_LINE('--- Publishers in ' || v_target_country || ' ---');

   FOR r_pub IN c_pub_by_country(v_target_country) LOOP
      v_found := TRUE;
      
      DBMS_OUTPUT.PUT_LINE('ID: ' || r_pub.pub_id || 
                           ' | Name: ' || r_pub.pub_name || 
                           ' | City: ' || r_pub.city);
   END LOOP;
   IF NOT v_found THEN
      DBMS_OUTPUT.PUT_LINE('No publisher found in ' || v_target_country);
   END IF;
END;
/