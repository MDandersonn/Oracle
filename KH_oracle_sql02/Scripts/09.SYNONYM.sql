--관리자권한으로실행

create user user1 identified by user1;
create user user2 identified by user2;

grant connect,resource to user1;
grant connect,resource to user2;
--동의어생성권한
grant create SYNONYM to user1;

alter user user1 quota 10m on users;
alter user user2 quota 10m on users;


--user1에서 테이블생성
create table SAMPLE(
	ID number primary key,
	name varchar2(50)
);
insert into sample values(1,'sample');
insert into sample values(2,'table');
insert into sample values(3,'data');
 --user2에서 작동되는지 확인
select * from user1.sample;
-- user1에서 권한을 줘야
grant select on sample to user2; 

-- 동의어 for 테이블명
------------비공개동의어------------------------------------------------------
create synonym SAM FOR SAMPLE;  
create synonym SAM1 FOR user1.SAMPLE;  

select * from sam;

--user2로실행
select * from user1.sam;
select * from sam;
select * from user1.SAM1;
select * from SAM1;

--user1에서 테이블생성
create table PUBLIC_SAMPLE(
	ID number primary key,
	name varchar2(50)
);
insert into public_sample values(1,'sample');
insert into public_sample values(2,'table');
insert into public_sample values(3,'data');

--------------------공개동의어 (반드시 관리자 계정으로 접속해서 만들어야함)-----------
create PUBLIC SYNONYM PSAM FOR user1.PUBLIC_SAMPLE;

--사용자스키마명 안들어가도됨 user2로실행
select * from PSAM; 
--유저2입장에선 어떤계정의 무슨 테이블인지 모름

-- 공개동의어로만들어도 권한을 줘야 쓸수있따
--user1으로 sys로하면안됨
grant select on public_sample to user2;  
--사용자스키마명 안들어가도됨 user2로실행
select * from user1.sam; 
select * from sam;
--test
create PUBLIC SYNONYM PSAM1 FOR user1.PUBLIC_SAMPLE;
--user1로접속해서 권한부여 취소시키고
revoke select on public_sample from user2; 
--user1의 테이블이라고 명시하면 관리자로도 권한줄수있음
grant select on user1.public_sample to user2; 
select * from PSAM1;

--권한부여를 비공개동의어한테 줘도된다 
grant select on SAM to user2; --user1로실행


-----------------동의어 생성확인

--접속한계정만볼수있음
select * from user_synonyms;
--모든계정의 동의어 볼수있음
select * from all_synonyms;
--관리자 계정의 동의어 볼수있음
select * from dba_synonyms; 


