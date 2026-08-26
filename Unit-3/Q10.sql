DECLARE
   CURSOR c_low_stock IS
      SELECT book_id, title, category, price, stock
      FROM book
      WHERE stock < 5;

   v_rec c_low_stock%ROWTYPE;
   v_count NUMBER := 0;
BEGIN
   IF NOT c_low_stock%ISOPEN THEN
      OPEN c_low_stock;
   END IF;
   LOOP
      FETCH c_low_stock INTO v_rec;
      EXIT WHEN c_low_stock%NOTFOUND;

      v_count := v_count + 1;
      DBMS_OUTPUT.PUT_LINE(
         'ID: ' || v_rec.book_id || 
         ' | Title: ' || RPAD(v_rec.title, 30, ' ') || 
         ' | Stock: ' || v_rec.stock || 
         ' --> REORDER'
      );
   END LOOP;
   DBMS_OUTPUT.PUT_LINE('----------------------------------------');
   DBMS_OUTPUT.PUT_LINE('Total books requiring reorder: ' || v_count);

   -- Clean up cursor handle
   IF c_low_stock%ISOPEN THEN
      CLOSE c_low_stock;
   END IF;
END;
/