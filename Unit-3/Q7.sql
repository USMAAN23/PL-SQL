DECLARE
   CURSOR c_book IS
      SELECT book_id, title, price, stock
      FROM book;
   v_item_value  NUMBER(12, 2) := 0;
   v_grand_total NUMBER(14, 2) := 0;
BEGIN
   FOR r_book IN c_book LOOP
      v_item_value := r_book.price * r_book.stock;
      v_grand_total := v_grand_total + v_item_value;
      DBMS_OUTPUT.PUT_LINE('ID: ' || r_book.book_id || 
                           ' | Title: ' || r_book.title || 
                           ' | Price: $' || r_book.price || 
                           ' | Stock: ' || r_book.stock || 
                           ' | Stock Value: $' || v_item_value);
   END LOOP;
   DBMS_OUTPUT.PUT_LINE('--------------------------------------------------');
   DBMS_OUTPUT.PUT_LINE('Grand Total Stock Value: $' || v_grand_total);
END;
/