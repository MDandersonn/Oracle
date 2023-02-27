select * from EMPLOYEES e ;

select HIRE_DATE + INTERVAL '10' YEAR as 십년뒤
from EMPLOYEES e ;

/*
 * EMPLOYEES의 HIRE_DATE 열의 값을 +10 년 하여 수정한다.
 */
update EMPLOYEES 
set hire_date =HIRE_DATE + INTERVAL '10' YEAR;

/*
 * LOCATIONS 테이블에 학원 주소 정보를 추가하세요.
 */
select * from LOCATIONS l ;
SELECT * FROM COUNTRIES c ;
SELECT * FROM REGIONS r ;
INSERT INTO COUNTRIES VALUES('KR','KOREA',3);
INSERT INTO LOCATIONS VALUES(3300,'TEHERANRO','11K','SEOUL','GANGNAMGU','KR');

select * from EMPLOYEES e ;
/*
 * DEPARTMENTS의 IT 부서에 대한 LOCATION_ID 를 학원 주소로 수정하세요.
 */
SELECT * FROM DEPARTMENTS d ;
UPDATE DEPARTMENTS 
SET LOCATION_ID =(SELECT LOCATION_ID FROM LOCATIONS l WHERE LOCATION_ID =3300) 
WHERE DEPARTMENT_NAME='IT';


/*
 * EMPLOYEES 에서 COMMISSION_PCT 가 NULL 인 경우 0으로 수정하세요.
 */
UPDATE EMPLOYEES 
SET COMMISSION_PCT =0
WHERE COMMISSION_PCT IS NULL;

/*
 * EMPLOYEES 에서 MANAGER_ID 가 NULL 인 사원은 DEPARTMENTS 테이블의 MANAGER_ID 로
 * 수정하세요. 
 */
SELECT * FROM EMPLOYEES e WHERE MANAGER_ID IS NULL;
SELECT * FROM DEPARTMENTS d ;

SELECT MANAGER_ID  
FROM DEPARTMENTS d 
WHERE DEPARTMENT_ID = (SELECT DEPARTMENT_ID  FROM EMPLOYEES e WHERE MANAGER_ID IS NULL);

--풀이
UPDATE EMPLOYEES 
SET MANAGER_ID =(SELECT MANAGER_ID  
	FROM DEPARTMENTS d 
	WHERE DEPARTMENT_ID = 
		(SELECT DEPARTMENT_ID  FROM EMPLOYEES e WHERE MANAGER_ID IS NULL)
	) 
WHERE MANAGER_ID IS NULL;

--모범답안 

UPDATE EMPLOYEES E1
   SET DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                          FROM EMPLOYEES E2
                         WHERE EMPLOYEE_ID = E1.MANAGER_ID)
 WHERE DEPARTMENT_ID IS NULL;



SELECT * FROM EMPLOYEES e ;

/*
 * EMPLOYEES 에서 DEPARTMENT_ID 가 NULL 인 사원은 MANAGER_ID 의 값을 활용하여 해당 manager의 해당 MANAGER_ID 와
 * 동일한 DEPARTMENT_ID 값을 가지도록 수정하세요.
 * (MANAGER_ID 는 EMPLOYEE_ID 와 외래키 관계입니다.)
 */
select MANAGER_ID  from EMPLOYEES e where DEPARTMENT_ID is null;
select * from DEPARTMENTS d ;
select * from EMPLOYEES e where EMPLOYEE_ID =149;
select * from EMPLOYEES e2  where manager_id=149;
select DEPARTMENT_ID  from EMPLOYEES e where EMPLOYEE_ID =(select MANAGER_ID  from EMPLOYEES e where DEPARTMENT_ID is null);
--insert into DEPARTMENTS values(149,'none',null,null,null);
update EMPLOYEES 
set DEPARTMENT_ID = (select DEPARTMENT_ID  from EMPLOYEES e 
	where EMPLOYEE_ID =(select MANAGER_ID  from EMPLOYEES e where DEPARTMENT_ID is null))
where DEPARTMENT_ID is null;

select * from EMPLOYEES e ;


--모범답안

UPDATE EMPLOYEES E1
   SET DEPARTMENT_ID = (SELECT DEPARTMENT_ID
                          FROM EMPLOYEES E2
                         WHERE EMPLOYEE_ID = E1.MANAGER_ID)
 WHERE DEPARTMENT_ID IS NULL;
 

/*
 * DEPARTMENTS 에서 MANAGER_ID 가 NULL 인 데이터는 삭제하세요.
 */

select * from DEPARTMENTS d2 ;
select * from EMPLOYEES e where DEPARTMENT_ID =149;
update EMPLOYEES 
set MANAGER_ID =NULL 
where MANAGER_ID =149;

update EMPLOYEES 
set MANAGER_ID =149 
where EMPLOYEE_ID  =178;

update EMPLOYEES 
set DEPARTMENT_ID  = null 
where EMPLOYEE_ID  =178;

delete from DEPARTMENTS d 
where MANAGER_ID is null;

select * from EMPLOYEES e2 ;

select * from EMPLOYEES e 
where DEPARTMENT_ID >=120;

select * from user_constraints where table_name='DEPARTMENTS';
select * from user_constraints where constraint_name='COUNTRY_C_ID_PK';

--모범답안
DELETE FROM DEPARTMENTS
 WHERE MANAGER_ID IS NULL;


/*
 * JOBS 테이블과 동일한 구조의 KJOBS 테이블을 만들고 JOB_TITLE 열의 값을
 * 한글로 번역하여 수정한다.
 * 단, MIN_SALARY, MAX_SALARY 컬럼은 만들 필요 없음.
 */

CREATE TABLE KJOBS
	AS SELECT * FROM JOBS;
	
SELECT * FROM KJOBS;

UPDATE KJOBS 
SET JOB_TITLE= '대통령'
WHERE JOB_TITLE='President';

/*
 * DEPARTMENTS 테이블에 DEPARMENT_NAME_KR 컬럼을 추가 후 DEPARTMENT_NAME 을
 * 한글로 변역한 데이터가 수정되게 한다.
 */
SELECT * FROM DEPARTMENTS d ;
ALTER TABLE DEPARTMENTS ADD DEPARTMENT_NAME_KR VARCHAR2(10);

UPDATE DEPARTMENTS 
SET DEPARTMENT_NAME_KR= '아이티'
WHERE DEPARTMENT_NAME ='IT';
/*
 * KJOBS 테이블에 한글로 번역한 직무 타이틀을 JOBS 테이블에 JOB_TITLE_KR 컬럼을
 * 추가후 수정이 되도록 한다.(DEPARTMENTS 테이블 처럼 하나의 테이블에 영문/한글이
 * 모두 들어가게 한다.) 모든 작업을 완료 후 KJOBS 테이블은 제거 한다.
 */
SELECT * FROM all_tab_columns where table_name='JOBS';


ALTER TABLE JOBS  ADD JOB_TITLE_KR VARCHAR2(35);
	SELECT * FROM KJOBS;
	SELECT * FROM JOBS;

UPDATE JOBS a
SET JOB_TITLE_KR= (SELECT JOB_TITLE FROM KJOBS b WHERE a.job_id=b.JOB_ID);


/*
UPDATE JOBS b 
SET JOB_TITLE_KR= (SELECT JOB_TITLE FROM KJOBS a)
WHERE a.job_id = b.JOB_ID;
*/


select * from jobs;
SELECT * FROM KJOBS;
/*
 * JOBS 테이블에 다음의 데이터를 추가 한다.(JOB_TITLE_KR 도 추가되어 있어야 함)
 *     JOB_ID    JOB_TITLE           MIN_SALARY    MAX_SALARY
 *     IT_ITRN   Intern Programmer   3200          3800
 *     SV_MGR    Server Manager      4000          10000
 *     SV_ENG    Server Engineer     6000          12000
 *     NT_MGR    Network Manager     5000          11000
 *     NT_ENG    Network Engineer    7000          13000
 */
insert into jobs values('IT_ITRN','Intern Programmer','3200','3800','인턴 프로그래머');
insert into jobs values('SV_MGR','Server Manager','4000','10000','서버 매니저');
insert into jobs values('SV_ENG','Server Engineer','6000','12000','서버 엔지니어');
insert into jobs values('NT_MGR','Network Manager','5000','11000','네트워크 매니저');
insert into jobs values('NT_ENG','Network Engineer','7000','13000','네트워크 엔지니어');

select * from jobs;
/*
 * DEPARTMENTS 테이블에 다음의 데이터를 추가 한다.(DEPARTMENT_NAME_KR 도 추가되어 있어야 함)
 *     DEPARTMENT_ID    DEPARTMENT_NAME    MANAGER_ID    LOCATION_ID
 *     280              Server             NULL          (학원주소에 해당하는 ID)
 *     290              Network            NULL          (학원주소에 해당하는 ID)
 */
select* from LOCATIONS l ;
select * from DEPARTMENTS d ;
insert into DEPARTMENTS values(280,'Server',null,3300,null);
insert into DEPARTMENTS values(290,'Network',null,3300,null);

/*
 * 새로 신설된 Server, Network 부서를 위한 인력을 충원하고 있는 것으로 가정하여 각 부서마다
 * 3명의 인원을 EMPLOYEES 에 추가한다.(Manager 직무 1명, Engineer 직무 2명)
 *     - 초기에 모든 인원은 JOBS 테이블의 MIN_SALARY 의 급여를 받는 것으로 한다.
 *     - Server, Network 부서에 인원을 추가 할 때 반드시 1명의 부서장이 필요하기 때문에 인원 중 1명을
 *       부서장으로 만든다.(DEPARTMENTS 테이블의 MANAGER_ID 를 설정한다.)
 *     - 부서장으로 선택된 인원은 JOBS 테이블의 MIN_SALARY 급여에서 +2000 상승된 급여로 받을 수 있게
 *       데이터를 수정한다.
 */
select * from EMPLOYEES e2 ;
select * from EMPLOYEES e where DEPARTMENT_ID =50;
select * from jobs;
select * from DEPARTMENTS d ;
insert into EMPLOYEES values(207,'YJ','Kim','kim', '515.123.1207' , sysdate, 'SV_MGR',
	(select MIN_SALARY from jobs where job_id='SV_MGR'), 0,  100, 280);

insert into EMPLOYEES values(208,'YU','Park','park', '515.123.1287' , sysdate, 'SV_ENG',
	(select MIN_SALARY from jobs where job_id='SV_ENG'), 0,  207, 280);

insert into EMPLOYEES values(209,'YK','Lee','lee', '515.123.1209' , sysdate, 'IT_ITRN',
	(select MIN_SALARY from jobs where job_id='IT_ITRN'), 0,  207, 280);

insert into EMPLOYEES values(210,'RK','SA','sa', '515.123.1213' , sysdate, 'NT_MGR',
	(select MIN_SALARY from jobs where job_id='NT_MGR'), 0,  100, 290);
insert into EMPLOYEES values(211,'RO','SANG','sang', '515.123.1212' , sysdate, 'NT_ENG',
	(select MIN_SALARY from jobs where job_id='NT_ENG'), 0,  210, 290);

insert into EMPLOYEES values(212,'RU','JUNG','jung', '515.123.1211' , sysdate, 'NT_ENG',
	(select MIN_SALARY from jobs where job_id='NT_ENG'), 0,  210, 290);

select MIN_SALARY from jobs where job_id='SV_ENG';

update DEPARTMENTS 
set MANAGER_ID =207
where DEPARTMENT_ID =280;

update DEPARTMENTS 
set MANAGER_ID =210
where DEPARTMENT_ID =290;

select MANAGER_ID 
	from departments
	where DEPARTMENT_ID =280;



UPDATE EMPLOYEES 
set SALARY = salary+2000
where EMPLOYEE_ID =(
	select MANAGER_ID 
	from departments
	where DEPARTMENT_ID =280);


UPDATE EMPLOYEES 
set SALARY = salary+2000
where EMPLOYEE_ID =(
	select MANAGER_ID 
	from departments
	where DEPARTMENT_ID =290);

/*모범답안 --     이런식으로 한번에 처리할수있따.
 * UPDATE EMPLOYEES
   SET SALARY = SALARY + 2000
 WHERE EMPLOYEE_ID IN (SELECT MANAGER_ID
                         FROM DEPARTMENTS
                        WHERE DEPARTMENT_ID IN (120, 130));
                      
 */

/*
 * 모든 급여 정보를 수정하려고 한다.
 * JOBS 테이블과 EMPLOYEES 테이블의 모든 급여 정보를 기존보다 5% ~ 10% 상승 시키도록 한다.
 *     - 급여가 4000 미만인 경우 10% 상승
 *     - 급여가 4000 이상 8000 미만인 경우 8% 상승
 *     - 급여가 8000 이상 12000 미만인 경우 6% 상승
 *     - 급여가 12000 이상인 경우 5% 상승
 *     - 정수 1번째 자리에서 절삭할 것. 예) 4333.333 은 4330 으로 절삭.
 */

select * from jobs;
select * from EMPLOYEES e where JOB_ID ='IT_ITRN';

UPDATE EMPLOYEES 
set salary = case when salary >4000 then round(salary*1.1,1)
	when salary >=4000 and salary<8000 then round(salary*1.08,1)
	when salary>=8000 and  salary<12000 then round(salary*1.06,1)
	when salary>=12000 then round(salary*1.05,1)
	end;


select JOB_ID , min(salary),max(salary)
from employees
group by job_id;

delete from jobs where job_id='JOB_ID';

select * from jobs;

------풀었다!!!!!!!!!!!!!!!!!!!!
UPDATE jobs a
set (MIN_SALARY,MAX_SALARY) = (
			select nn.최저, nn.최대
			from (select JOB_ID , min(salary) 최저,max(salary) 최대
				from employees b
				group by b.job_id) nn 
			where nn.job_ID= a.job_ID );



select JOB_ID , min(salary),max(salary)
	from employees b
	group by b.job_id;

select a.JOB_ID ,min(salary),max(salary)
	from employees b ,jobs a
	where b.JOB_ID =a.JOB_ID 
	group by b.job_id;
	
