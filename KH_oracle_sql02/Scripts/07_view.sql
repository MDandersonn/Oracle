/*
 * VIEW 객체
 *     - SELECT 문의 실행 결과를 저장한 가상 테이블
 *     - 테이블과 다르게 실제 데이터를 저장하고 있지는 않으나 실제 테이블을
 *       사용하는 것과 동일하게 사용 가능
 *     - 복잡한 SELECT 구문을 VIEW 로 만들어 간단하게 사용할 수 있다.
 */
CREATE OR REPLACE VIEW V_EMP
AS
SELECT EMPLOYEE_ID AS EMP_ID
     , FIRST_NAME || ' ' || LAST_NAME AS EMP_NAME
     , EMAIL || '@emp.co.kr' AS EMAIL
     , SALARY
     , MANAGER_ID
     , DEPARTMENT_ID
  FROM EMPLOYEES
 WHERE MANAGER_ID BETWEEN 200 AND 220
  /* WITH CHECK OPTION; */
  WITH READ ONLY;

SELECT * FROM V_EMP;

/*
 * VIEW 를 사용하여 INSERT, UPDATE, DELETE 작업을 할 수 있지만 다음의 경우에는
 * 사용할 수 없다.
 *     1. VIEW 에 포함되지 않은 컬럼을 사용하는 경우
 *     2. VIEW 에 포함되지 않은 컬럼중 NOT NULL 제약조건이 있는 경우
 *     3. 산술 표현식으로 정의된 경우
 *     4. 그룹함수나 GROUP BY 절이 포함된 경우
 *     5. DISTINCT 키워가 있는 경우
 *     6. JOIN 을 사용하여 여러 테이블이 결합된 경우
 */
UPDATE V_EMP
   SET MANAGER_ID = 190
 WHERE DEPARTMENT_ID = 120;

SELECT * FROM EMPLOYEES WHERE DEPARTMENT_ID = 120;




create or replace view v2
as 
	select e.EMPLOYEE_ID ,e.FIRST_NAME ,e.LAST_NAME ,e.EMAIL ,e.PHONE_NUMBER ,e.HIRE_DATE , JOB_TITLE as JOB_ID ,
			e.SALARY ,e.COMMISSION_PCT , e2.first_name ||' '|| e2.LAST_name as MANAGER_ID, department_name as DEPARTMENT_ID   
	from employees e join DEPARTMENTS d on e.DEPARTMENT_ID =d.DEPARTMENT_ID 
		join jobs j on e.JOB_ID =j.JOB_ID
		join employees e2 on e.manager_ID = e2.employee_ID;	
--test

select * from EMPLOYEES ;

select e.EMPLOYEE_ID ,e.FIRST_NAME ,e.LAST_NAME ,e.EMAIL ,e.PHONE_NUMBER ,e.HIRE_DATE , JOB_TITLE as JOB_ID ,
			e.SALARY ,e.COMMISSION_PCT , e2.first_name ||' '|| e2.LAST_name as MANAGER_ID, department_name as DEPARTMENT_ID   
	from employees e join DEPARTMENTS d on e.DEPARTMENT_ID =d.DEPARTMENT_ID 
		join jobs j on e.JOB_ID =j.JOB_ID
		join employees e2 on e.manager_ID = e2.employee_ID;	
	
select * from v2;









