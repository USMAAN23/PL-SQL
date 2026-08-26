DECLARE
   CURSOR c_books_by_price (
      p_min_price NUMBER,
      p_max_price NUMBER
   ) IS
      SELECT book_id, title, category, price
      FROM book
      WHERE price BETWEEN p_min_price AND p_max_price
      ORDER BY price ASC;
BEGIN
   DBMS_OUTPUT.PUT_LINE('--- Books Priced Between $300 and $700 ---');
   FOR r_book IN c_books_by_price(300, 700) LOOP
      DBMS_OUTPUT.PUT_LINE('ID: ' || r_book.book_id || 
                           ' | Title: ' || r_book.title || 
                           ' | Category: ' || r_book.category || 
                           ' | Price: $' || r_book.price);
   END LOOP;
END;
/