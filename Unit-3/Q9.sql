DECLARE
   CURSOR c_unreturned IS
      SELECT issue_id, book_id, issue_date
      FROM book_issue
      WHERE return_date IS NULL;

   v_rec c_unreturned%ROWTYPE;
   v_count NUMBER := 0;
BEGIN
   IF NOT c_unreturned%ISOPEN THEN
      OPEN c_unreturned;
   END IF;

   -- Fetch and print details
   LOOP
      FETCH c_unreturned INTO v_rec;
      EXIT WHEN c_unreturned%NOTFOUND;
      
      v_count := v_count + 1;
      DBMS_OUTPUT.PUT_LINE(
         'Issue ID: ' || v_rec.issue_id || 
         ' | Book ID: ' || v_rec.book_id || 
         ' | Issue Date: ' || TO_CHAR(v_rec.issue_date, 'YYYY-MM-DD')
      );
   END LOOP;
   IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('All books returned');
   END IF;
   IF c_unreturned%ISOPEN THEN
      CLOSE c_unreturned;
   END IF;
END;
/