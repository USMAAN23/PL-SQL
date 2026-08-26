DECLARE
   CURSOR c_expensive_books IS
      SELECT book_id, title, price
      FROM book
      WHERE price > 500;
   r_book c_expensive_books%ROWTYPE;
BEGIN
   OPEN c_expensive_books;
   
   LOOP
      FETCH c_expensive_books INTO r_book;
      EXIT WHEN c_expensive_books%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(c_expensive_books%ROWCOUNT || '. ' ||
                           'Book ID: ' || r_book.book_id || 
                           ' | Title: ' || r_book.title || 
                           ' | Price: $' || r_book.price);
   END LOOP;
   IF c_expensive_books%ROWCOUNT = 0 THEN
      DBMS_OUTPUT.PUT_LINE('No books found with price greater than 500.');
   END IF; 
   CLOSE c_expensive_books;
END;
/