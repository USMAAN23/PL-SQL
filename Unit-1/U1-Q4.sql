CREATE TABLE employee(
  emp_id NUMBER,
  emp_fname VARCHAR2(50),
  emp_salary NUMBER
);
INSERT INTO employee VALUES(101,'JATIN',50000);
INSERT INTO employee VALUES(102,'GOYAM',40000);
INSERT INTO employee VALUES(103,'DEV',11000);
INSERT INTO employee VALUES(104,'HARSH',12000);
INSERT INTO employee VALUES(105,'RAJ',10500);
INSERT INTO employee VALUES(106,'JITUU',12000);
COMMIT;
DECLARE
  v_fname employee.emp_fname%TYPE;
  v_sal employee.emp_salary%TYPE;
  v_emp_id employee.emp_id%TYPE := 103;
BEGIN
  SELECT emp_fname, emp_salary
  INTO v_fname, v_sal
  FROM employee
  WHERE emp_id = v_emp_id;
  DBMS_OUTPUT.PUT_LINE('Employee Name: ' || v_fname);
  DBMS_OUTPUT.PUT_LINE('Earns Rs. ' || v_sal || ' Per Month');
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Employee not found please check employee id');
END;
/
