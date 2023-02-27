select *
from DEPARTMENTS d ;

select * from LOCATIONS l ;

select DEPARTMENT_ID ,DEPARTMENT_NAME , d.LOCATION_ID,city
from DEPARTMENTS d join LOCATIONS l on d.LOCATION_ID =l.LOCATION_ID ;



select d.LOCATION_ID, count(DEPARTMENT_ID)
from DEPARTMENTS d join LOCATIONS l on d.LOCATION_ID =l.LOCATION_ID
where MANAGER_ID is not null
group by d.LOCATION_ID;


select * from EMPLOYEES e ;

select d.LOCATION_ID, count(EMPLOYEE_ID)
from EMPLOYEES e join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
	join LOCATIONS l on d.LOCATION_ID =l.LOCATION_ID
	group by d.LOCATION_ID ;
	

select LOCATION_ID ,CITY,사원수  
from LOCATIONS l join
	(select d.LOCATION_ID, count(EMPLOYEE_ID) as 사원수
	from EMPLOYEES e join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID
	join LOCATIONS l on d.LOCATION_ID =l.LOCATION_ID
	group by d.LOCATION_ID ) kk using (LOCATION_ID);
	

select * from DEPARTMENTS d ;
select * from LOCATIONS l ;
select * from COUNTRIES c ;


select d.DEPARTMENT_ID ,d.DEPARTMENT_NAME ,c.COUNTRY_NAME 
from DEPARTMENTS d join LOCATIONS l on d.LOCATION_ID =l.LOCATION_ID 
join COUNTRIES c on l.COUNTRY_ID =c.COUNTRY_ID ;

select * from EMPLOYEES e ;

select * 
from (select job_id, count(*) 수
	from EMPLOYEES e 
	group by JOB_ID
	order by 수 desc) nn
where rownum<=3;
-- as 는 select문에서만 가능.

select * from jobs;
select * from EMPLOYEES e ;
select * from DEPARTMENTS d  ;
--가장 많이 부여된 직무 상위 3개가 어떤부서에 소속되었는지 부서명조회 부서명


select e.JOB_ID ,e.DEPARTMENT_ID ,count(*)
	from EMPLOYEES e join DEPARTMENTS d  on e.DEPARTMENT_ID =d.DEPARTMENT_ID
	group by e.JOB_ID ,e.DEPARTMENT_ID ;

select * from EMPLOYEES e3 ;



select nn.job_id ,  d2.department_name,수
from (select e.JOB_ID ,e.DEPARTMENT_ID ,count(*) 수
	from EMPLOYEES e join DEPARTMENTS d  on e.DEPARTMENT_ID =d.DEPARTMENT_ID
	group by e.JOB_ID ,e.DEPARTMENT_ID ) nn 
	join DEPARTMENTS d2 on nn.department_id =d2.DEPARTMENT_ID
order by 수 desc;

-----------답안-----------
SELECT DISTINCT E.DEPARTMENT_ID
     , D.DEPARTMENT_NAME
  FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
 WHERE E.JOB_ID IN (SELECT JOB_ID
                      FROM (SELECT COUNT(*) AS 직원수
                                 , JOB_ID
                              FROM EMPLOYEES
                             GROUP BY JOB_ID
                             ORDER BY 1 DESC)
                     WHERE ROWNUM <= 3);

select *                    
FROM EMPLOYEES E JOIN DEPARTMENTS D ON E.DEPARTMENT_ID = D.DEPARTMENT_ID
 WHERE E.JOB_ID IN (SELECT JOB_ID
                      FROM (SELECT COUNT(*) AS 직원수
                                 , JOB_ID
                              FROM EMPLOYEES
                             GROUP BY JOB_ID
                             ORDER BY 1 DESC)
                     WHERE ROWNUM <= 3);

SELECT JOB_ID
 FROM (SELECT COUNT(*) AS 직원수, JOB_ID
            FROM EMPLOYEES
          GROUP BY JOB_ID
          ORDER BY 1 DESC)
   WHERE ROWNUM <= 3;

  SELECT COUNT(*) AS 직원수, JOB_ID
            FROM EMPLOYEES
          GROUP BY JOB_ID
          ORDER BY 1 DESC;
---test
select * 
from (select job_id, count(*) 수
	from EMPLOYEES e 
	group by JOB_ID 
	) n left  join EMPLOYEES e2 on n.job_id=e2.JOB_ID 
	join DEPARTMENTS d on d.DEPARTMENT_ID =e2.DEPARTMENT_ID
order by 수 desc;



-- 급여 탑5명 직원의 어떤국가에서 일하는지국가명을 조회

select * from EMPLOYEES e ;

select employee_ID, salary,country_name
from (
	select *
	from EMPLOYEES e join DEPARTMENTS d on e.department_id = d.DEPARTMENT_ID 
		join LOCATIONS l on d.LOCATION_ID =l.LOCATION_ID 
		join COUNTRIES c on l.COUNTRY_ID =c.COUNTRY_ID 
	order by SALARY desc)
where rownum<=5;

--가장 최근에 입사한 사원 5명이 소속되어있는 부서를 찾아 조회하시오


select *
from EMPLOYEES e 
order by hire_date desc;

select employee_id, department_name, hire_date
from (
	select *
	from EMPLOYEES e 
	order by hire_date desc) n join DEPARTMENTS d  on n.department_id= d.DEPARTMENT_ID 
where rownum <=5;



select e.EMPLOYEE_ID ,e.DEPARTMENT_ID ,d.DEPARTMENT_ID 
from EMPLOYEES e join DEPARTMENTS d on e.department_id= d.DEPARTMENT_ID ;

select * from EMPLOYEES e ;
select * from DEPARTMENTS d ;
