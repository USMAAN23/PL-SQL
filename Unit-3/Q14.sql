DECLARE
   CURSOR c_publisher_books (p_pub_name publisher.pub_name%TYPE) IS
      SELECT b.title, b.price
      FROM book b
      JOIN publisher p ON b.pub_id = p.pub_id
      WHERE UPPER(p.pub_name) = UPPER(p_pub_name);

   v_title    book.title%TYPE;
   v_price    book.price%TYPE;
   v_count    NUMBER := 0;
   v_pub_name publisher.pub_name%TYPE := '&user_pub_name';
BEGIN
   IF NOT c_publisher_books%ISOPEN THEN
      OPEN c_publisher_books(v_pub_name);
   END IF;

   DBMS_OUTPUT.PUT_LINE('--- Books Published by: ' || UPPER(v_pub_name) || ' ---');

   -- Fetch and output details
   LOOP
      FETCH c_publisher_books INTO v_title, v_price;
      EXIT WHEN c_publisher_books%NOTFOUND;

      v_count := v_count + 1;
      DBMS_OUTPUT.PUT_LINE(
         'Title: ' || RPAD(v_title, 32, ' ') || 
         ' | Price: ' || TO_CHAR(v_price, '9990.00')
      );
   END LOOP;
   IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('No books found for publisher: ' || v_pub_name);
   END IF;

   -- Close the cursor handle
   IF c_publisher_books%ISOPEN THEN
      CLOSE c_publisher_books;
   END IF;
END;
/