DECLARE
   CURSOR c_member (
      p_course   lib_member.course%TYPE,
      p_semester lib_member.semester%TYPE
   ) IS
      SELECT member_id, 
             member_name, 
             course, 
             semester, 
             TO_CHAR(join_date, 'DD-MON-YYYY') AS formatted_join_date
      FROM lib_member
      WHERE UPPER(course) = UPPER(p_course)
        AND semester = p_semester;
BEGIN
   DBMS_OUTPUT.PUT_LINE('--- Members in MSc IT (Semester 3) ---');
   FOR r_mem IN c_member('MSc IT', 3) LOOP
      DBMS_OUTPUT.PUT_LINE('ID: ' || r_mem.member_id || 
                           ' | Name: ' || r_mem.member_name || 
                           ' | Course: ' || r_mem.course || 
                           ' | Sem: ' || r_mem.semester || 
                           ' | Join Date: ' || r_mem.formatted_join_date);
   END LOOP;
END;
/