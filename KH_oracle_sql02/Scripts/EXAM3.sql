SELECT * FROM USER_ERRORS;



CREATE OR REPLACE FUNCTION GETDNAME(vdepartment_id IN departments.department_id%TYPE)
RETURN departments.department_name%TYPE
IS
  vdepartment_name departments.department_name%TYPE;
 	vcount number;
BEGIN
	SELECT count(*) INTO vcount 
    FROM departments
    WHERE department_id = vdepartment_id;
	
   	IF (vcount=0) THEN
   		DBMS_OUTPUT.PUT_LINE('해당 부서 없음');
   		RETURN '해당 부서 없음';
   	ELSE 
	    SELECT department_name INTO vdepartment_name 
	    FROM departments
	    WHERE department_id = vdepartment_id; 
	   	RETURN vdepartment_name;
	END IF;
END;


CREATE OR REPLACE FUNCTION GETDNAME2(vdepartment_id IN departments.department_id%TYPE)
RETURN departments.department_name%TYPE
IS
  vdepartment_name departments.department_name%TYPE;
 
BEGIN
    SELECT department_name INTO vdepartment_name 
    FROM departments
    WHERE department_id = vdepartment_id; 
   	RETURN vdepartment_name;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('해당부서없다..');
		return '해당 부 서없 음';
END;
SELECT * FROM USER_ERRORS;


SELECT GETDNAME(1000) FROM DUAL;

SELECT GETDNAME2(1000) FROM DUAL;



CREATE OR REPLACE FUNCTION GETDNAME(vdepartment_id IN departments.department_id%TYPE)
IS
  vdepartment_name departments.department_name%TYPE;
BEGIN
    SELECT department_name INTO vdepartment_name FROM departments
    WHERE department_id = vdepartment_id;
    RETURN vdepartment_name;
END;