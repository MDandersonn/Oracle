/*fuction객체
 * PL/SQL구문을 사용하여 생성할 수 있는 객체
 * 프로시저와 유사하며 일반 프로그래밍 언어의 함수와 같이 값을 리턴한다.
 * function은 procedure와 다르게 sql구문안에서 사용할 수 있다.
 * 
*/

create or replace function fun_sample1(num1 number,	num2 number)
return NUMBER 
IS
BEGIN 
	return num1 +num2;
end;

select fun_sample1(10,20) from dual;


create or replace function get_job_title(f_job_id varchar2)
return varchar2
IS var_job_title varchar(35);
BEGIN 
	select job_title into var_job_title from jobs where job_id =f_job_id;
	return var_job_title;
END;

select Employee_id, get_job_title(job_id) from employees;

