DECLARE
   CURSOR c_books_to_update (p_category book.category%TYPE) IS
      SELECT title, price
      FROM book
      WHERE UPPER(category) = UPPER(p_category)
      FOR UPDATE OF price;

   v_target_category book.category%TYPE := 'Database';
   v_old_price       book.price%TYPE;
   v_new_price       book.price%TYPE;
   v_found           BOOLEAN := FALSE;
BEGIN
   DBMS_OUTPUT.PUT_LINE('=== PRICE UPDATE (10% INCREASE) FOR CATEGORY: ' || UPPER(v_target_category) || ' ===');
   FOR r_book IN c_books_to_update(v_target_category) LOOP
      v_found     := TRUE;
      v_old_price := r_book.price;
      v_new_price := r_book.price * 1.10;
      UPDATE book
      SET price = v_new_price
      WHERE CURRENT OF c_books_to_update;

      -- Display old and new prices
      DBMS_OUTPUT.PUT_LINE('Title: ' || r_book.title || 
                           ' | Old Price: $' || TO_CHAR(v_old_price, '9990.00') || 
                           ' | New Price: $' || TO_CHAR(v_new_price, '9990.00'));
   END LOOP;
   IF NOT v_found THEN
      DBMS_OUTPUT.PUT_LINE('No books found in category: ' || v_target_category);
   ELSE
      COMMIT;
      DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
      DBMS_OUTPUT.PUT_LINE('Price updates committed successfully.');
   END IF;
END;
/