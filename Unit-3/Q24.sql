DECLARE
   CURSOR c_members_by_letter (p_letter VARCHAR2) IS
      SELECT member_id, member_name, course, semester
      FROM lib_member
      WHERE UPPER(member_name) LIKE UPPER(p_letter) || '%'
      ORDER BY member_name ASC;
   v_input_letter VARCHAR2(10) := '&input_letter';
   v_clean_letter CHAR(1);
   v_found        BOOLEAN := FALSE;
BEGIN
   v_clean_letter := UPPER(SUBSTR(TRIM(v_input_letter), 1, 1));

   DBMS_OUTPUT.PUT_LINE('=== Members with names starting with ''' || v_clean_letter || ''' ===');

   FOR r_mem IN c_members_by_letter(v_clean_letter) LOOP
      v_found := TRUE;
      DBMS_OUTPUT.PUT_LINE('ID: ' || r_mem.member_id || 
                           ' | Name: ' || r_mem.member_name || 
                           ' | Course: ' || r_mem.course || 
                           ' | Sem: ' || r_mem.semester);
   END LOOP;

   IF NOT v_found THEN
      DBMS_OUTPUT.PUT_LINE('No members found starting with letter ''' || v_clean_letter || '''.');
   END IF;
END;
/