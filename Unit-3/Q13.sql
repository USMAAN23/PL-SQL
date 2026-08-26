DECLARE
   CURSOR c_books_by_category (p_category book.category%TYPE) IS
      SELECT book_id, title, price, stock
      FROM book
      WHERE UPPER(category) = UPPER(p_category);

   v_rec c_books_by_category%ROWTYPE;
   v_count NUMBER := 0;
   -- Accept input using substitution variable
   v_input_cat book.category%TYPE := '&user_category';
BEGIN
   IF NOT c_books_by_category%ISOPEN THEN
      OPEN c_books_by_category(v_input_cat);
   END IF;

   DBMS_OUTPUT.PUT_LINE('--- Books in Category: ' || UPPER(v_input_cat) || ' ---');
   LOOP
      FETCH c_books_by_category INTO v_rec;
      EXIT WHEN c_books_by_category%NOTFOUND;

      v_count := v_count + 1;
      DBMS_OUTPUT.PUT_LINE(
         'ID: ' || v_rec.book_id || 
         ' | Title: ' || RPAD(v_rec.title, 28, ' ') || 
         ' | Price: ' || TO_CHAR(v_rec.price, '9990.00') || 
         ' | Stock: ' || v_rec.stock
      );
   END LOOP;
   IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('No books found for category: ' || v_input_cat);
   END IF;

   -- Clean up cursor handle
   IF c_books_by_category%ISOPEN THEN
      CLOSE c_books_by_category;
   END IF;
END;
/