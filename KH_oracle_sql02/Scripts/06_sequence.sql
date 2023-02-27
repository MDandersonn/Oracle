/*
 * sequence 객체
 * 번호발생기객체이다
 * 정수값을 순차적으로 생성하는 객체
 * primary key로 사용하는 번호(ID)등에 사용하여 정수값을 생성하기위한 용도로 많이 사용
 * 
 * 
 * 
*/

create sequence 시퀀스명
	start with 10 --10에서시작 
	increment by 10 --10씩증가
	maxvalue 300 --생성번호의 최대값
	minvalue 10 -- 처음으로돌아갈때 10으로 돌아감 (기본값은 1 임) 음수도 가능
	cycle  -- 처음으로 돌아가는데 그 처음이 minvalue로돌아감.
	nocache -- 몇개까지 미리 생성할것인지
;
drop sequence 시퀀스명;

-- 칠때마다 다음번호
Select 시퀀스명.NEXTVAL from dual; 

-- 현재번호
select 시퀀스명.currval from dual; 

drop table temp;
create table temp(
	ID number primary key
);

insert into temp values(시퀀스명.nextval);
select * from temp;


/*
 * nextval,currval을 사용할수있는명령어
 * 1. select문(서브쿼리제외)
 * 2.insert문의 values절
 * 3.insert문의 select
 * 4. update문의 set절
 * 
 * 사용할수없는명령어
 * 1. view의 select절
 * 2. distinct 키워드가있는 select문
 * 3. group by, having ,order by절이 있는 select
 * 4. select,delete , update의 서브쿼리
 * 5. default 값
 *
*/

create sequence report_seq
	start with 100 --100에서시작 
	increment by 10 --10씩증가
	maxvalue 1000 --생성번호의 최대값
;
drop sequence report_seq;

BEGIN
	FOR i IN 1..5 LOOP
	DBMS_output.put_line(report_seq.NEXTVAL-90);
	END LOOP;
END;




create sequence s1;
begin
	dbms_output.put_line(s1.nextval);
end;

drop sequence s1;

select * from temp;
insert into temp values (s1.nextval);
insert into temp values(5);
select * from user_sequences;

-- nextval 뒤에 () 를 쓰지않음에 주의.


