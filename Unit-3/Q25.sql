DECLARE
   CURSOR c_book (p_cat VARCHAR2) IS
      SELECT book_id, title FROM book WHERE category = p_cat;
      
   v_found BOOLEAN := FALSE;
BEGIN
   FOR r IN c_book('Database') LOOP
      DBMS_OUTPUT.PUT_LINE(r.book_id || ' - ' || r.title);
   END LOOP;
   IF NOT v_found THEN
      DBMS_OUTPUT.PUT_LINE('No books found');
   END IF;
END;
/