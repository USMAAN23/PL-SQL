DECLARE
   CURSOR c_book IS
      SELECT book_id, title, price
      FROM book;
BEGIN
   FOR r_book IN c_book LOOP
      DBMS_OUTPUT.PUT_LINE('Book ID: ' || r_book.book_id || 
                           ' | Title: ' || r_book.title || 
                           ' | Price: $' || r_book.price);
   END LOOP;
END;
/