/*
 * 사내 공지를 위한 게시판 기능을 추가하려 한다. 다음의 요구사항에 맞추어 테이블을 생성하고
 * 첫번째 공지를 작성하도록 한다.(첫번째 공지는 모든 부서가 열람할 수 있게 한다.)
 *     - 공지 게시판은 부서별 공지와 전체 공지로 나누어져 운영돼야 한다.
 *     - 전체 공지는 모든 부서가 확인할 수 있는 공지이며 부서별 공지는 지정한 부서에 소속된
 *       사원만 볼수 있는 공지이다.
 *     - 공지를 작성할 때 다음의 정보가 저장되어야 한다.
 *         번호, 제목, 내용, 작성일자, 부서ID
 */

drop table board;
create table BOARD(
	ID number primary key,
	TITLE varchar2(50),
	CONTENT varchar2(70),
	WRITE_DATE DATE,
	DEPARTMENT_ID number(22),
	foreign key (DEPARTMENT_ID) REFERENCES DEPARTMENTS(DEPARTMENT_ID)
	on delete cascade
);
select * from DEPARTMENTS d ;

SELECT * FROM all_tab_columns where table_name='DEPARTMENTS';
SELECT * FROM all_tab_columns where table_name='BOARD';

/*
 * 사내 공지 게시판 테이블을 생성 후에 다음의 공지를 추가로 작성한다.
 *     - 모든 부서마다 'xxx 부서만 확인할 수 있는 공지 입니다.' 라는 메시지를 추가한다.
 */
delete from board;
select * from board;
insert into BOARD (ID,TITLE,CONTENT,WRITE_DATE) values (001, '모두 확인할 수있는 공지입니다','내용무',sysdate);
insert into BOARD  values (002, '10만 확인할 수있는 공지입니다','내용무',sysdate,10);

insert into BOARD  values (003, '20만 확인할 수있는 공지입니다','내용무',sysdate,20);
insert into BOARD  values (004, '30만 확인할 수있는 공지입니다','내용무',sysdate,30);
insert into BOARD  values (005, '40만 확인할 수있는 공지입니다','내용무',sysdate,40);
insert into BOARD values (006, '50만확인할 수있는 공지입니다','내용무',sysdate,50);
insert into BOARD  values (007, '60만 확인할 수있는 공지입니다','내용무',sysdate,60);
insert into BOARD  values (008, '70만 확인할 수있는 공지입니다','내용무',sysdate,70);
insert into BOARD  values (009, '80만 확인할 수있는 공지입니다','내용무',sysdate,80);
insert into BOARD  values (010, '90만 확인할 수있는 공지입니다','내용무',sysdate,90);
insert into BOARD  values (011, '100만 확인할 수있는 공지입니다','내용무',sysdate,100);
insert into BOARD  values (012, '110만 확인할 수있는 공지입니다','내용무',sysdate,110);
/*insert into BOARD (ID,TITLE,CONTENT,WRITE_DATE) values (001, '모두 확인할 수있는 공지입니다','내용무',sysdate);
 * 100 번 사원이 공지를 열람한다는 가정하에 100 번 사원이 소속된 부서의 공지와 전체 공지가
 * 보일수 있는 SELECT 쿼리문을 작성하세요.
 */

select *
from BOARD 
where department_id =(
	select department_id
	from EMPLOYEES e 
	where e.employee_id=100) or department_id is null;

-- 모범답안

SELECT N.ID
     , N.TITLE
     , N.CONTENT
     , N.WRITE_DATE
     , N.DEPartment_ID
     , NVL((SELECT DEPARTMENT_NAME_KR FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = N.DEPartment_ID), '전체') AS DEPT_NAME
  FROM Board N LEFT OUTER JOIN EMPLOYEES E ON N.DEPartment_ID = E.DEPARTMENT_ID
 WHERE E.EMPLOYEE_ID = 100
    OR N.DEPartment_ID = 0;

   create or replace view v1
	   as SELECT 
	   		N.ID,
	   		E.EMPLOYEE_ID 
	     , N.TITLE
	     , N.CONTENT
	     , N.WRITE_DATE
	     , N.DEPartment_ID
	     , NVL((SELECT DEPARTMENT_NAME_KR FROM DEPARTMENTS D WHERE D.DEPARTMENT_ID = N.DEPartment_ID), '전체') AS DEPT_NAME
	  FROM Board N LEFT OUTER JOIN EMPLOYEES E ON N.DEPartment_ID = E.DEPARTMENT_ID
   ;

 drop view v1;

 
 
 select * 
from v1
where employee_id=100;
 


/*
 * 공지 게시판에 중요도 기능을 추가하여 가장 중요한 공지가 가장 먼저 조회될 수 있도록 테이블을
 * 수정하도록 한다.
 *     - 중요도는 1 ~ 5 까지 사용할 수 있게 한다.
 *     - 중요도를 설정하지 않으면 기본 3으로 저장되게 한다.
 *     - 전체 공지용으로 중요도 1 ~ 5 까지 총 5개의 공지 데이터를 추가한다.
 *     - 추가한 공지 데이터를 조회할 때 중요도 순으로 조회가 될 수 있도록
 *       SELECT 구문을 작성한다.
 */


alter table BOARD add IMPORTANCE number default 3;
//alter table BOARD add constraint importance_ck check(importance between 1 and 5);
alter table BOARD add constraint importance_ck check(importance in (1,2,3,4,5));
alter table board drop column importance;

insert into BOARD (ID,TITLE,CONTENT,WRITE_DATE,importance) values (013, '모두 확인할 수있는 공지입니다','내용무',sysdate,1);
insert into BOARD (ID,TITLE,CONTENT,WRITE_DATE,importance) values (014, '모두 확인할 수있는 공지입니다','내용무',sysdate,2);
insert into BOARD (ID,TITLE,CONTENT,WRITE_DATE,importance) values (015, '모두 확인할 수있는 공지입니다','내용무',sysdate,3);
insert into BOARD (ID,TITLE,CONTENT,WRITE_DATE,importance) values (016, '모두 확인할 수있는 공지입니다','내용무',sysdate,4);
insert into BOARD (ID,TITLE,CONTENT,WRITE_DATE,importance) values (017, '모두 확인할 수있는 공지입니다','내용무',sysdate,5);

select *
from BOARD 
where department_id is null
order by importance desc;
