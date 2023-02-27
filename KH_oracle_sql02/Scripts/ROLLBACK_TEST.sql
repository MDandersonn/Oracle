select * from REGIONS r ;

select * from COUNTRIES c ;

select * from EMPLOYEES e ;

select * from DEPARTMENTS d ;

select to_char(round(00.0540,1) ,'FM9.9') from dual;
select to_char(1 ,'FM9.9') from dual;
select to_char(0 ,'FM9.9') from dual;

select to_char(1 ,'0.9') from dual;
select to_char(0 ,'FM0.9') from dual;
select * from EMPLOYEES e ;
insert into EMPLOYEES (employee_ID,last_name,email,HIRE_DATE ,JOB_ID ) 
	values (1,'ab','abgmail',sysdate,'IT_ITRN');
	
commit;
insert into EMPLOYEES (employee_ID,last_name,email,HIRE_DATE ,JOB_ID ) 
	values (2,'ab','ab2gmail',sysdate,'IT_ITRN');
	

rollback;

insert into EMPLOYEES (employee_ID,last_name,email,HIRE_DATE ,JOB_ID ) 
	values (3,'ab','ab3gmail',sysdate,'IT_ITRN');
	



create or replace PROCEDURE ra
IS
	vname varchar2(30);
BEGIN 
	DBMS_OUTPUT.PUT_LINE('프로시져 실행!!!');
	insert into EMPLOYEES (employee_ID,last_name,email,HIRE_DATE ,JOB_ID ) 
		values (3,'ab','ab3gmail',sysdate,'IT_ITRN');
	select LAST_NAME  into vname from employees where EMPLOYEE_ID =1000;
	DBMS_OUTPUT.PUT_LINE('두번째 줄 실행!!!');
	commit;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('닉네임 또는 암호가 잘못되었습니다.');
    	rollback;
END;
-- exception에서 롤백을 한다고해서  프로시저 실행전에 커밋안하고 했던작업이 날라가진않는다.

select * from user_errors;

select * from EMPLOYEES e ;
-- exception에서 롤백하면 프로시저내부에서 오류나기전에 실행했던것이 롤백된다.

begin
	ra;
end;
