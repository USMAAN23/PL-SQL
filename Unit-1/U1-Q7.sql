<<outer>>
DECLARE
    v_city VARCHAR2(30) := 'Gujarat';
    v_num  NUMBER       := 100;
BEGIN
    DBMS_OUTPUT.PUT_LINE('=== OUTER BLOCK (START) ===');
    DBMS_OUTPUT.PUT_LINE('Outer v_city : ' || v_city);
    DBMS_OUTPUT.PUT_LINE('Outer v_num  : ' || v_num);
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------');

    <<middle>>
    DECLARE
        v_city VARCHAR2(30) := 'Ahmedabad';
        v_num  NUMBER       := 200;       
    BEGIN
        DBMS_OUTPUT.PUT_LINE('=== MIDDLE BLOCK ===');
        DBMS_OUTPUT.PUT_LINE('Middle v_city            : ' || v_city);
        DBMS_OUTPUT.PUT_LINE('Middle v_num             : ' || v_num);
        DBMS_OUTPUT.PUT_LINE('Access Outer via Label   : ' || outer.v_city);
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------');

        <<inner>>
        DECLARE
            v_num NUMBER := 300; 
        BEGIN
            DBMS_OUTPUT.PUT_LINE('=== INNER BLOCK ===');
            DBMS_OUTPUT.PUT_LINE('Current Scope v_city     : ' || v_city);             -- Inherited from middle block
            DBMS_OUTPUT.PUT_LINE('Inner v_num              : ' || v_num);             -- Local to inner block
            DBMS_OUTPUT.PUT_LINE('Access Outer v_city      : ' || outer.v_city);      -- Qualified via outer label
            DBMS_OUTPUT.PUT_LINE('Access Outer v_num       : ' || outer.v_num);       -- Qualified via outer label
            DBMS_OUTPUT.PUT_LINE('Access Middle v_num      : ' || middle.v_num);      -- Qualified via middle label
            DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
        END inner;

    END middle;

    DBMS_OUTPUT.PUT_LINE('=== OUTER BLOCK (AFTER MIDDLE ENDS) ===');
    DBMS_OUTPUT.PUT_LINE('Outer v_city (Restored)  : ' || v_city);
    DBMS_OUTPUT.PUT_LINE('Outer v_num              : ' || v_num);
    DBMS_OUTPUT.PUT_LINE('===========================================');
END outer;
/