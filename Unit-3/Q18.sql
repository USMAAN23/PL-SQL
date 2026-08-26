DECLARE
   CURSOR c_member_issues (p_member_id lib_member.member_id%TYPE) IS
      SELECT m.member_name,
             b.title,
             bi.issue_date
      FROM book_issue bi
      JOIN book b         ON bi.book_id = b.book_id
      JOIN lib_member m   ON bi.member_id = m.member_id
      WHERE bi.member_id = p_member_id
      ORDER BY bi.issue_date ASC;
      
   v_count NUMBER := 0;
BEGIN
   DBMS_OUTPUT.PUT_LINE('--- Issue History for Member ID: 1 ---');
   
   FOR r_issue IN c_member_issues(1) LOOP
      v_count := v_count + 1;
      DBMS_OUTPUT.PUT_LINE('Member: ' || r_issue.member_name || 
                           ' | Book: ' || r_issue.title || 
                           ' | Issued On: ' || TO_CHAR(r_issue.issue_date, 'DD-MON-YYYY'));
   END LOOP;
   IF v_count = 0 THEN
      DBMS_OUTPUT.PUT_LINE('No issue history found for this member.');
   END IF;
END;
/