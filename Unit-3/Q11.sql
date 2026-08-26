DECLARE
   CURSOR c_top_priced_books IS
      SELECT book_id, title, price
      FROM book
      ORDER BY price DESC;

   v_rec c_top_priced_books%ROWTYPE;
BEGIN
   IF NOT c_top_priced_books%ISOPEN THEN
      OPEN c_top_priced_books;
   END IF;
   LOOP
      FETCH c_top_priced_books INTO v_rec;
      EXIT WHEN c_top_priced_books%ROWCOUNT = 5 OR c_top_priced_books%NOTFOUND;

      DBMS_OUTPUT.PUT_LINE(
         'Rank ' || c_top_priced_books%ROWCOUNT || 
         ' | ID: ' || v_rec.book_id || 
         ' | Title: ' || RPAD(v_rec.title, 30, ' ') || 
         ' | Price: ' || TO_CHAR(v_rec.price, '9990.00')
      );
   END LOOP;
   IF c_top_priced_books%ISOPEN THEN
      CLOSE c_top_priced_books;
   END IF;
END;
/