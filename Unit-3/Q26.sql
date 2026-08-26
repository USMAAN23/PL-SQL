DECLARE
   CURSOR c_mem (p_course VARCHAR2) IS
      SELECT member_name FROM lib_member WHERE course = p_course;
BEGIN
   FOR r IN c_mem('MCA') LOOP
      DBMS_OUTPUT.PUT_LINE(r.member_name);
   END LOOP;
END;
/