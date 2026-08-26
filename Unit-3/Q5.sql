DECLARE
   CURSOR c_member IS
      SELECT member_name, course, semester
      FROM lib_member;
   r_mem c_member%ROWTYPE;
BEGIN
   OPEN c_member;
   
   LOOP
      FETCH c_member INTO r_mem;
      EXIT WHEN c_member%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(c_member%ROWCOUNT || '. ' || 
                           UPPER(r_mem.member_name) || 
                           ' (' || r_mem.course || ' - Sem ' || r_mem.semester || ')');
   END LOOP;
   
   CLOSE c_member;
END;
/