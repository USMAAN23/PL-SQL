DECLARE
   CURSOR c_book (p_cat VARCHAR2 DEFAULT 'Database') IS
      SELECT book_id, title, category, price
      FROM book
      WHERE UPPER(category) = UPPER(p_cat);
BEGIN
   DBMS_OUTPUT.PUT_LINE('=== CALL 1: Default Parameter (Database) ===');
   FOR r_book IN c_book LOOP
      DBMS_OUTPUT.PUT_LINE('ID: ' || r_book.book_id || 
                           ' | Title: ' || r_book.title || 
                           ' | Category: ' || r_book.category || 
                           ' | Price: $' || r_book.price);
   END LOOP;

   DBMS_OUTPUT.PUT_LINE(CHR(10)); 
   DBMS_OUTPUT.PUT_LINE('=== CALL 2: Explicit Argument (Networking) ===');
   FOR r_book IN c_book('Networking') LOOP
      DBMS_OUTPUT.PUT_LINE('ID: ' || r_book.book_id || 
                           ' | Title: ' || r_book.title || 
                           ' | Category: ' || r_book.category || 
                           ' | Price: $' || r_book.price);
   END LOOP;
END;
/