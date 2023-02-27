/*trigger객체
 * 
 * pl/sql 구문을 사용하여 생성할 수있는 객체
 * 테이블또는 뷰에 insert update delete문에의한 변경이 발생할 경우
 * 자동으로 실행할 내용을 정의하여 실행하게 하는 객체
 * 변경 전/후를 구분하여 자동으로 실행할 내용을 정의할 수 있따.
 * 
 * 
*/

drop table test1;

create table test1(
	id number,
	name varchar2(10)
);

drop table test2;

create table test2(
	id number,
	name varchar2(10)
);

--before/after 지정 insert/update/delete지정

create or replace trigger tri_sample1
after insert on test1 
BEGIN 
	DBMS_output.put_line('트리거 동작!!!');
END;

select * from user_errors;
insert into test1 values(1,'A');
select * from test1;

create or replace trigger tri_sample2
after insert on test1 for each row
BEGIN 
	insert into test2 values(:NEW.ID,:NEW.NAME);
END;
select * from test2;
insert into test1 values(4,'d');

--for each row는 한번에 insert 하면 각 행마다 begin절이 동작되도록 하는것.
insert into test1 (select 5,'E' from DUAL
					union all
					select 6, 'F' from dual);


/*for each row를 쓰면
 * :NEW.컬럼명    //NEW는 새로추가된값
 * :OLD.컬럼명         //OLD는 이전값
 * 형식을 사용가능
*/

				
create or replace trigger tri_sample3
before update of NAME on test1 for each row
BEGIN 
	update TEST2
	set NAME= :NEW.NAME
	where ID = :NEW.ID;
	DBMS_output.put_line('update트리거 발생!!');
END;

--id를 수정
update TEST1 
set ID= ID*10
where id=1;

insert into test2 values (1,'A');

--name을 수정하면 test2도 네임이 트리거로 변경됨
update TEST1 
set NAME= 'bb'
where id=2;


select * from test1;
select * from test2;


-----------
create or replace trigger tri_insertEMP
after insert on employees for each row
BEGIN
	update DEPARTMENTS 
	set total= total+1
	where department_id = :new.department_id;
END;
drop trigger ha;

select * from DEPARTMENTS d ;
select * from EMPLOYEES e ;
insert into EMPLOYEES values (15,'홍','길둥','GIL3L',null,sysdate,'IT_ITRN',4000,null,null,280);



----
create or replace trigger tri_deleteEMP
before delete on employees for each row
BEGIN
	update DEPARTMENTS 
	set total= total-1
	where department_id = :old.department_id;
	dbms_output.put_line('new작동'||:new.first_name || :new.last_name || :new.department_id);
	dbms_output.put_line('old작동'||:old.first_name || :old.last_name || :old.department_id);
END;
--new는 새로운행 old는 없어진행 을 나올때.
--update는 변경된행은new 변경되기전행은 old

select * from DEPARTMENTS d ;
delete from EMPLOYEES e2 where EMPLOYEE_ID =15;
select * from EMPLOYEES e ;

select * from user_triggers;
--procedure 보기
select * from user_source;


create or replace trigger tri_updateEMP
before update on employees for each row
BEGIN
	update DEPARTMENTS 
	set total= total-1
	where department_id = :old.department_id;
	dbms_output.put_line('new작동'||:new.first_name || :new.last_name || :new.department_id);
	dbms_output.put_line('old작동'||:old.first_name || :old.last_name || :old.department_id);
END;
select * from EMPLOYEES e ;
select * from user_errors;
drop trigger tri_updateEMP;

select * from DEPARTMENTS d ;

UPDATE EMPLOYEES
set first_name='th'
where employee_Id=15;

drop trigger tri_updateEMP;
--update TEST

create or replace trigger tri_mod_emp
after update of department_id on employees for each ROW 
BEGIN
	update DEPARTMENTS 
	set total= total-1
	where department_id = :old.department_id;

	update DEPARTMENTS 
	set total= total+1
	where department_id = :new.department_id;
	dbms_output.put_line('old작동  '||:old.first_name || :old.last_name || :old.department_id);
	dbms_output.put_line('new작동  '||:new.first_name || :new.last_name || :new.department_id);
end;

-- old는 바뀌기전 행  new는 바뀐후의 행  

select * from EMPLOYEES e ;
select * from DEPARTMENTS d ;
UPDATE EMPLOYEES
set DEPARTMENT_ID =280
where employee_Id=15;



select * from user_triggers;

drop trigger tri_sample3;
delete from user_triggers;

/*
 * 같은코드를  트리거를 해놓고 또 프로시저를 쓰면 이중으로 적용될수도있음
 * 하나만쓸것을 추천
*/

