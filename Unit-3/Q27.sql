DECLARE
CURSOR c IS SELECT title FROM book WHERE price > 600;
v_title book.title%TYPE;
BEGIN
OPEN c;
LOOP
FETCH c INTO v_title;
EXIT WHEN c%NOTFOUND;
DBMS_OUTPUT.PUT_LINE(c%ROWCOUNT || ' : ' || v_title);
END LOOP;
DBMS_OUTPUT.PUT_LINE('Final ROWCOUNT = ' || c%ROWCOUNT);
CLOSE c;
END;
/

/////////////////////////OUTPUT/////////////////////////
1 : Database System Concepts
2 : Operating System Design
3 : Java Complete Reference
4 : Computer Networks
5 : Oracle SQL Handbook
6 : Advanced DBMS
7 : Cloud Computing Essentials
Final ROWCOUNT = 7