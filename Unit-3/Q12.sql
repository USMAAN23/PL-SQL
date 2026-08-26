DECLARE
   CURSOR c_db_books IS
      SELECT book_id, title, stock
      FROM book
      WHERE category = 'Database'
      FOR UPDATE OF stock;

   v_rec c_db_books%ROWTYPE;
   v_old_stock NUMBER;
   v_new_stock NUMBER;
BEGIN
   IF NOT c_db_books%ISOPEN THEN
      OPEN c_db_books;
   END IF;
   LOOP
      FETCH c_db_books INTO v_rec;
      EXIT WHEN c_db_books%NOTFOUND;

      v_old_stock := v_rec.stock;
      v_new_stock := v_old_stock + 10;
      UPDATE book
      SET stock = v_new_stock
      WHERE CURRENT OF c_db_books;
      DBMS_OUTPUT.PUT_LINE(
         'ID: ' || v_rec.book_id || 
         ' | Title: ' || RPAD(v_rec.title, 26, ' ') || 
         ' | Old Stock: ' || LPAD(v_old_stock, 2, ' ') || 
         ' -> New Stock: ' || v_new_stock
      );
   END LOOP;
   IF c_db_books%ISOPEN THEN
      CLOSE c_db_books;
   END IF;
   COMMIT;
   DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
   DBMS_OUTPUT.PUT_LINE('Stock updated and transaction committed successfully.');
END;
/