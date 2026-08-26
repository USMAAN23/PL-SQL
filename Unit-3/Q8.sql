DECLARE
   CURSOR c_unreturned_books IS
      SELECT issue_id, book_id, issue_date
      FROM issue
      WHERE return_date IS NULL;
      
   v_rec c_unreturned_books%ROWTYPE;
   v_count NUMBER := 0;
BEGIN
   IF NOT c_unreturned_books%ISOPEN THEN
      OPEN c_unreturned_books;
   END IF;
   LOOP
      FETCH c_unreturned_books INTO v_rec;
      EXIT WHEN c_unreturned_books%NOTFOUND;
      
      v_count := v_count + 1;
      DBMS_OUTPUT.PUT_LINE('Issue ID: ' || v_rec.issue_id || 
                           ' | Book ID: ' || v_rec.book_id || 
                           ' | Issue Date: ' || TO_CHAR(v_rec.issue_date, 'YYYY-MM-DD'));
   END LOOP;
   IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('All books returned');
   END IF;
   IF c_unreturned_books%ISOPEN THEN
      CLOSE c_unreturned_books;
   END IF;
END;
/