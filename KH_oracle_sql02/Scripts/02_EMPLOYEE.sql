select FIRST_NAME as "이 름" -- 띄어쓰기를 쓰려면 " " 로 묶어줌
from employees;

select * from EMPLOYEES e2 ;

select  CASE when e.COMMISSION_PCT is not null then '있음'
		else '없음' 
		
		END as 커미션구분 
from EMPLOYEES e  ;

select e.FIRST_NAME || e.LAST_NAME as 이름  ,e.EMPLOYEE_ID  
		, SUBSTR( e.PHONE_NUMBER ,1,3)|| '*********'||substr( e.PHONE_NUMBER ,13,18)
from EMPLOYEES e 
where e.PHONE_NUMBER like '011%';


select e.FIRST_NAME || e.LAST_NAME as 이름, TO_CHAR(e.HIRE_DATE,'""YYYY"년 "MM"월 "DD"일"') 
from EMPLOYEES e 
where EXTRACT (year from e.HIRE_DATE) =2000;


select e.FIRST_NAME || e.LAST_NAME as 이름, TO_CHAR(e.HIRE_DATE,'YYYY "년" MM "월" DD "일"') as 고용일
	, round(MONTHS_BETWEEN(TO_DATE('1999-12-31', 'YYYY-MM-DD'),e.HIRE_DATE ),2) as 근무개월수
from EMPLOYEES e 
where MONTHS_BETWEEN(TO_DATE('1999-12-31', 'YYYY-MM-DD'),e.HIRE_DATE ) >=60;

select e.HIRE_DATE  FROM EMPLOYEES e 


SELECT TO_CHAR(123456, '999,999,999') AS A
     , TO_CHAR(123456, '000,000,000') AS B
     , TO_CHAR(123456.789, '999,999,999.99999') AS C
     , TO_CHAR(123456.789, '000,000,000.00000') AS D
  FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') AS A
     , TO_CHAR(SYSDATE, 'YYYY/MM/DD') AS B
     , TO_CHAR(SYSDATE, 'YYYY-MM-DD') AS C
     , TO_CHAR(SYSDATE, 'YYYY.MM.DD') AS D
     , TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일"') AS E
  FROM DUAL;

SELECT TO_CHAR(SYSDATE, 'HH:MI:SS') AS A
     , TO_CHAR(SYSDATE, 'HH24:MI:SS') AS B
     , TO_CHAR(SYSDATE, 'HH24"시" MI"분" SS"초"') AS C
  FROM DUAL;

SELECT TO_NUMBER('1234') AS A
     , TO_NUMBER('12.34') AS B
     , TO_NUMBER('1,000', '999,999') AS C
  FROM DUAL;

SELECT TO_DATE(20221111) AS A
     , TO_DATE('20221111') AS B
     , TO_DATE('2022/11/11') AS C
     , TO_DATE('2022-11-11') AS D
     , TO_DATE('2022.11.11') AS E
     , TO_DATE('2022년 11월 11일', 'YYYY"년" MM"월" DD"일"') AS F
  FROM DUAL;

 select * 
from EMPLOYEES e
order by e.hire_date;


with table1 as
	(select e.EMPLOYEE_ID ,case when extract (year from e.HIRE_DATE) between 1980 and 1989 then '80년대'
		when extract (year from e.HIRE_DATE) between 1990 and 1999 then '90년대'
		else '2000년대'
		END as 입사년도
	from EMPLOYEES e)
select 입사년도 , count(*) as 입사자수
from table1 
group by 입사년도
order by 입사년도;

select * from EMPLOYEES e;

select DEPARTMENT_ID, count(substr(PHONE_NUMBER,1,3)) as 회선수
from EMPLOYEES e 
where department_id is not null
group by DEPARTMENT_ID 
having  count(substr(PHONE_NUMBER,1,3)) >1
order by DEPARTMENT_ID ;


create table 지출내역서(
	ID number(10) primary key,
	날짜 date,
	출입구분 varchar2(2) check (출입구분 in ('출','입')),
	금액 number(10),
	비고 varchar2(50)
);

drop table 지출내역서;


create table emps
as select * from EMPLOYEES;


select * from emps;
select * from user_constraints where table_name = 'EMPS';
alter table emps drop constraint SYS_C008257;
alter table emps drop constraint SYS_C008258;
alter table emps drop constraint SYS_C008259;
alter table emps drop constraint SYS_C008260;

insert into emps (EMPLOYEE_ID,first_name,last_name,hire_date, department_id,Salary) values(207,'길동','홍','2022-03-05',80,2800 );
delete from emps where Employee_Id=207;

update EMps
set phone_number= replace(phone_number,'.','-');


update EMPs
set email = email || '@emp.co.kr';

update EMps
set department_id =60
where employee_id=207;


update EMps
set email ='1215kimyj@emp.co.kr'
where employee_id=207;

update EMPs
set salary= salary*0.75
where extract(year from hire_date) < 1990 and salary>=10000;


update EMPs
set salary= salary*1.1
where department_id in (50,60,70);


SELECT CASE WHEN MANAGER_ID =100 THEN SALARY*0.2
	WHEN MANAGER_ID =100 THEN SALARY*0.15
	WHEN MANAGER_ID =100 THEN SALARY*0.1
	ELSE 0
	end BONUS
FROM EMPLOYEES; 

select * from EMPLOYEES e ;


/*DEPT_CODE가 D9이거나 D6이고 SALARY이 300만원 이상이고 BONUS가 있고

남자이고 이메일주소가 _ 앞에 3글자 있는

사원의 EMP_NAME, EMP_NO, DEPT_CODE, SALARY를 조회*/

select * from EMPLOYEES e ;
SELECT * 
FROM EMPLOYEES
WHERE substr(PHONE_NUMBER,7,1)=3 ;

select * 
from EMPLOYEES e 
where job_id like '__#_%' ESCAPE '#';

SELECT EMP_NAME, EMP_NO, DEPT_CODE, SALARY

FROM EMPLOYEE

WHERE (DEPT_CODE='D9' OR DEPT_CODE='D6') 
	AND SALARY >= 3000000
	AND SUBSTR(EMP_NO,8,1) =1
	AND EMAIL LIKE '___#_%' ESCAPE '#'
	AND BONUS IS NOT NULL;


select * from REGIONS r ;
select * from DEPARTMENTS d ;