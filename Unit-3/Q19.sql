DECLARE
   CURSOR c_publisher IS
      SELECT pub_id, pub_name
      FROM publisher
      ORDER BY pub_id;

   CURSOR c_book (p_pub_id publisher.pub_id%TYPE) IS
      SELECT book_id, title, price
      FROM book
      WHERE pub_id = p_pub_id
      ORDER BY title;

   v_book_count NUMBER;
BEGIN
   FOR r_pub IN c_publisher LOOP
      DBMS_OUTPUT.PUT_LINE('Publisher [' || r_pub.pub_id || ']: ' || r_pub.pub_name);
      
      v_book_count := 0;
      FOR r_book IN c_book(r_pub.pub_id) LOOP
         v_book_count := v_book_count + 1;
         
         -- Indented display using tabs/spaces
         DBMS_OUTPUT.PUT_LINE('   -> Book ID: ' || r_book.book_id || 
                              ' | Title: ' || r_book.title || 
                              ' | Price: $' || r_book.price);
      END LOOP;
      IF v_book_count = 0 THEN
         DBMS_OUTPUT.PUT_LINE('   -> (No books found for this publisher)');
      END IF;

      DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
   END LOOP;
END;
/