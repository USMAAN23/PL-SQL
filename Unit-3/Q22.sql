DECLARE
   CURSOR c_overdue_issues (p_days NUMBER) IS
      SELECT issue_id,
             book_id,
             member_id,
             issue_date,
             TRUNC(SYSDATE) - TRUNC(issue_date) AS days_elapsed
      FROM book_issue
      WHERE return_date IS NULL
        AND (TRUNC(SYSDATE) - TRUNC(issue_date)) > p_days
      ORDER BY issue_date ASC;

   v_target_days   NUMBER := 10; 
   v_overdue_days  NUMBER := 0;
   v_current_fine  NUMBER(8,2) := 0;
   v_total_fine    NUMBER(10,2) := 0;
   v_found         BOOLEAN := FALSE;
BEGIN
   DBMS_OUTPUT.PUT_LINE('=== UNRETURNED ISSUES OLDER THAN ' || v_target_days || ' DAYS ===');

   FOR r_issue IN c_overdue_issues(v_target_days) LOOP
      v_found := TRUE;
      v_overdue_days := r_issue.days_elapsed - v_target_days;
      v_current_fine := v_overdue_days * 2;
      v_total_fine := v_total_fine + v_current_fine;

      DBMS_OUTPUT.PUT_LINE('Issue ID: ' || r_issue.issue_id ||
                           ' | Book ID: ' || r_issue.book_id ||
                           ' | Member ID: ' || r_issue.member_id ||
                           ' | Issued On: ' || TO_CHAR(r_issue.issue_date, 'DD-MON-YYYY') ||
                           ' | Overdue Days: ' || v_overdue_days ||
                           ' | Fine: Rs. ' || v_current_fine);
   END LOOP;

   DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------');

   IF NOT v_found THEN
      DBMS_OUTPUT.PUT_LINE('No unreturned issues older than ' || v_target_days || ' days found.');
   ELSE
      DBMS_OUTPUT.PUT_LINE('Total Fine Payable: Rs. ' || v_total_fine);
   END IF;
END;
/