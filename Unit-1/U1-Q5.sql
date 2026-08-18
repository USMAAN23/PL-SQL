CREATE TABLE employees (
    employee_id   NUMBER PRIMARY KEY,
    first_name    VARCHAR2(50),
    last_name     VARCHAR2(50),
    job_id        VARCHAR2(20),
    department_id NUMBER,
    salary        NUMBER(10,2),
    hire_date     DATE
);

INSERT INTO employees VALUES (101, 'Rahul', 'Sharma', 'IT', 60, 85000, TO_DATE('15-JAN-2012', 'DD-MON-YYYY'));
INSERT INTO employees VALUES (102, 'Priya', 'Patel', 'HR', 10, 45000, TO_DATE('10-MAR-2018', 'DD-MON-YYYY'));
INSERT INTO employees VALUES (103, 'Amit', 'Verma', 'FINANCIAL', 20, 62000, TO_DATE('01-JUL-2010', 'DD-MON-YYYY'));
INSERT INTO employees VALUES (104, 'Neha', 'Gupta', 'CLERK', 60, 95000, TO_DATE('20-NOV-2020', 'DD-MON-YYYY'));
INSERT INTO employees VALUES (105, 'Sanjay', 'Mehta', 'SENIOR CLERK', 80, 55000, TO_DATE('05-MAY-2014', 'DD-MON-YYYY'));
INSERT INTO employees VALUES (106, 'Ananya', 'Rao', 'IT', 90, 110000, TO_DATE('12-DEC-2008', 'DD-MON-YYYY'));
INSERT INTO employees VALUES (107, 'Vikram', 'Singh', 'ADVERTISEMENT', 60, 72000, TO_DATE('18-SEP-2016', 'DD-MON-YYYY'));
INSERT INTO employees VALUES (108, 'Pooja', 'Shah', 'HR', 10, 48000, TO_DATE('22-FEB-2022', 'DD-MON-YYYY'));
INSERT INTO employees VALUES (109, 'Karan', 'Joshi', 'MANAGER', 20, 125000, TO_DATE('30-AUG-2011', 'DD-MON-YYYY'));
COMMIT;
DECLARE
   v_roll_no   NUMBER := 1;
   v_target_id NUMBER := 100 + MOD(v_roll_no, 9) + 1;
   v_emp employees%ROWTYPE;
   v_exp_years NUMBER;
BEGIN
   SELECT *
   INTO v_emp
   FROM employees
   WHERE employee_id = v_target_id;
   v_exp_years := TRUNC(MONTHS_BETWEEN(SYSDATE, v_emp.hire_date) / 12);
   DBMS_OUTPUT.PUT_LINE('========================================');
   DBMS_OUTPUT.PUT_LINE('           EMPLOYEE PROFILE CARD        ');
   DBMS_OUTPUT.PUT_LINE('========================================');
   DBMS_OUTPUT.PUT_LINE('ID             : ' || v_emp.employee_id);
   DBMS_OUTPUT.PUT_LINE('Name           : ' || v_emp.first_name || ' ' || v_emp.last_name);
   DBMS_OUTPUT.PUT_LINE('Job ID         : ' || v_emp.job_id);
   DBMS_OUTPUT.PUT_LINE('Department ID  : ' || v_emp.department_id);
   DBMS_OUTPUT.PUT_LINE('Salary         : ' || TRIM(TO_CHAR(v_emp.salary, '"Rs."99,99,990.00')));
   DBMS_OUTPUT.PUT_LINE('Hire Date      : ' || TO_CHAR(v_emp.hire_date, 'DD-MON-YYYY'));
   DBMS_OUTPUT.PUT_LINE('Experience     : ' || v_exp_years || ' Years');
   IF v_exp_years > 10 THEN
      DBMS_OUTPUT.PUT_LINE('Status         : Senior Employee');
   END IF;
   
   DBMS_OUTPUT.PUT_LINE('========================================');

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('No employee found with ID: ' || v_target_id);
END;
/