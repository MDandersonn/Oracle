select * from DEPARTMENTS d ;

with a as
	(select DEPARTMENT_ID ,count(*) as 사원수
	from EMPLOYEES e 
	group by DEPARTMENT_ID)
select *
from DEPARTMENTS d  join a on d.DEPARTMENT_ID =a.department_id;


alter table DEPARTMENTS add TOTAL number;

update
	(select *
	from DEPARTMENTS d inner join (select DEPARTMENT_ID ,count(*) as 사원수
									from EMPLOYEES e 
									group by DEPARTMENT_ID) a 
									on d.DEPARTMENT_ID =a.department_id)
set TOTAL=사원수;


select * from user_constraints where table_name='employees';
select * from EMPLOYEES e ;

select max(e.EMPLOYEE_ID) +1
from EMPLOYEES e ;

-------

create or replace procedure proc_add_employee(id in number , lastName in varchar2,
	eMail varchar2, hireDate date, jobId varchar2, departmentId number)
IS 
	Cid number;
	CjobID number;
	CdepartmentID number;
BEGIN
	
	select count(*)
	into Cid
	FROM EMPLOYEES e 
	where EMPLOYEE_ID =id;

	select count(*) 
	into CjobID
	FROM jobs
	where job_Id=jobID;

	select count(*)
	into CdepartmentID
	from DEPARTMENTS d 
	where DEPARTMENT_ID =departmentID;
	
	if (cjobID > 0 and CdepartmentID >0) then
		if(Cid=0) then
			insert into EMPLOYEES (EMPLOYEE_ID , LAST_NAME, eMail, HIRE_DATE, JOB_ID, DEPARTMENT_ID) values (id,lastName , eMail, hireDate, jobID, departmentID);
			update DEPARTMENTS 
			set TOTAL =TOTAL+1
			where DEPARTMENT_ID =departmentID;
		else
			dbms_output.put_line('아이디가 이미 존재합니다.');
		end if ;
	else
		dbms_output.put_line('잡아이디나 부서아이디가 없습니다.');
	end if;
end;

----

select * from EMPLOYEES e order by EMPLOYEE_ID;

begin
	proc_add_employee(13,'YeongJIn','kimasdbs','2022-11-29','IT_ITRN',290);
end;

----

select * from user_errors;

insert into EMPLOYEES (EMPLOYEE_ID , LAST_NAME, eMail, HIRE_DATE, JOB_ID) 
	values(12,'YeongJIn','kimsss','2022-11-29','IT_ITRN');

select * from DEPARTMENTS d ;
select * from EMPLOYEES e ;
delete from EMPLOYEES e where EMPLOYEE_ID =11;

----
create or replace procedure proc_delete_employee(id in number)
IS 
BEGIN 
	
	update DEPARTMENTS 
	set TOTAL =TOTAL-1
	where DEPARTMENT_ID = (select DEPARTMENT_ID from employees e where e.EMPLOYEE_ID =id) ;
	
	delete from EMPLOYEES where EMPLOYEE_ID =id;
end;

---


select * from user_errors;
select * from DEPARTMENTS d ;
select * from EMPLOYEES e ;

----
begin
	proc_delete_employee(12);
end;

----

create or replace procedure proc_modify_employee(ID in number,VSalary in number ,Vjob_id in varchar2, VdepartmentID in number)
IS 
BEGIN 
	update DEPARTMENTS 
	set TOTAL =TOTAL-1
	where DEPARTMENT_ID = (select DEPARTMENT_ID from employees e where e.EMPLOYEE_ID =ID);
	update EMPLOYEES  
	set Salary= Vsalary, job_id= Vjob_id, DEPARTMENT_ID =VdepartmentID
	where EMPLOYEE_ID  =ID;

	update DEPARTMENTS 
	set TOTAL =TOTAL+1
	where DEPARTMENT_ID =VdepartmentID;
end;


------
begin
	proc_modify_employee(11,2900,'IT_ITRN',280);
end;


select * from user_errors;
select * from DEPARTMENTS d ;
select * from EMPLOYEES e where DEPARTMENT_ID =290;


------------------------------------------------------

create or replace procedure proc_modify_salary(per in number, VjobID in varchar2)
IS
 cnt number;
BEGIN

	UPDATE EMPLOYEES 
	set SALARY= salary*(1+(per*0.01))
	where JOB_ID =VjobID;
	
	select count(*)
	into cnt
	from EMPLOYEES e 
	where job_id=VjobID;
	
	update JOBS 
	set (MIN_SALARY,MAX_SALARY) =
		(select  min(salary),max(salary)
		from EMPLOYEES e 
		group by JOB_ID
		having JOB_ID =VjobID)
	where JOB_ID = VjobID;
	
	dbms_output.put_line(cnt||'개 행이 변경되었습니다.');
END;

-------------------------------
begin
	proc_modify_salary(5,'IT_ITRN');
end;

-----------------------
select * from EMPLOYEES e where JOB_ID ='IT_ITRN';
select * from jobs;

select * from JOBS j ;

update JOBS 
set (MIN_SALARY,MAX_SALARY) =
	(select  min(salary),max(salary)
	from EMPLOYEES e 
	group by JOB_ID
	having JOB_ID ='IT_ITRN')
where JOB_ID ='IT_ITRN';