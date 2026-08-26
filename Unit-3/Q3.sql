DECLARE
   CURSOR c_publisher IS
      SELECT pub_name, city, country
      FROM publisher;
   r_pub c_publisher%ROWTYPE;
BEGIN
   OPEN c_publisher;
   LOOP
      FETCH c_publisher INTO r_pub;
      EXIT WHEN c_publisher%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE('Name: ' || r_pub.pub_name || 
                           ' | City: ' || r_pub.city || 
                           ' | Country: ' || r_pub.country);
   END LOOP;
   CLOSE c_publisher;
END;
/