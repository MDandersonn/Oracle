
create table VISIT_T(
   id number primary key,
   context varchar2(500 char),
   nickname varchar2(25 char)
);

insert into visit_t values(1,'context','nickname');
insert into visit_t values(2,'context','nickname');
insert into visit_t values(3,'context','nickname');
select * from visit_t;


drop table visit_t;
delete from visit_t;


create sequence visit_s;
select visit_s.nextval from dual;

commit;

----------------------------------------------------------

create table bookmark_T(
   id number primary key,
   url varchar2(50 char),
   name varchar2(25 char)
);


insert into BOOKMARK_T values(1,'https://naver.com','네이버');
insert into BOOKMARK_T values(2,'https://google.com','구글');
insert into BOOKMARK_T values(3,'https://nate.com','네이트');


commit;

delete from BOOKMARK_T ;
drop table BOOKMARK_T ;

select * from BOOKMARK_T ;
commit;

select max(id) from BOOKMARK_T;


create sequence BOOKMARK_S;
select BOOKMARK_S.NEXTVAL from dual;
drop sequence bookmark_S;

----------------------------------------------------------

create table user_T(
   USERID varchar2(20) primary key,
   password varchar2(20),
   email varchar2(100)

);
select * from user_t;
commit;


--개인별 북마크 구현--------------------------------------------------------

drop table bookmark_T;

create table bookmark_T(
   id number primary key,
   USERID varchar2(20) references USER_T(USERID),
   url varchar2(50 char),
   name varchar2(25 char)
);

select * from BOOKMARK_T;
commit;

------------------------------pro07프로젝트----------------------------

create table t_member(
	id varchar2(20) primary key,
	pwd varchar2(10),
	name varchar2(50),
	email varchar2(50),
	joinDate date default sysdate
);
insert into t_member values('hong','1212','홍길동','hong@gmail.com',sysdate);
insert into t_member values('lee','1212','이순신','lee@gmail.com',sysdate);
insert into t_member values('kim','1212','김유신','kim@gmail.com',sysdate);
commit;
select * from t_member;

update T_MEMBER 
set pwd='123';
commit;
-------------------------visit 페이징---------------------------------

select * from visit_t order by id;
select rownum as num, id,nickname,context
			from (select * from visit_t order by id);
		
		
select *
	from(select rownum as num,id,nickname,context
			from (select * from visit_t order by id)
		)
where num between 1 and 6;


---------------------Board---------------------

/**
 * 공지사항이 있는 게시판
 * btype 이 N 인 경우 공지사항 입니다.
 * btype 이 B 인 경우 일반 게시글 입니다.
 * 회원만 글작성 가능.   
 * viewCnt: 조회수
 */

CREATE TABLE BOARD_T(
       id NUMBER PRIMARY KEY
     , btype VARCHAR2(1) CHECK(btype IN ('N', 'B'))
     , title VARCHAR2(500) NOT NULL
     , writer VARCHAR2(20) REFERENCES USER_T(userId)
     , context VARCHAR2(4000)
     , createDate DATE DEFAULT(SYSDATE)
     , updateDate DATE DEFAULT(SYSDATE)
     , viewCnt NUMBER DEFAULT(0)
);

CREATE SEQUENCE BOARD_S;

select * from user_t;
insert into user_t values('abcd',123,'abcd@naver.com');
insert into user_t values('aaaa',123,'aaaa@naver.com');

INSERT INTO BOARD_T VALUES(BOARD_S.NEXTVAL, 'B', '일반 게시글 테스트 1', 'abcd', '게시글 테스트 중 입니다. 1'
                         , DEFAULT, DEFAULT, DEFAULT);
INSERT INTO BOARD_T VALUES(BOARD_S.NEXTVAL, 'B', '일반 게시글 테스트 2', 'abcd', '게시글 테스트 중 입니다. 2'
                         , DEFAULT, DEFAULT, DEFAULT);
INSERT INTO BOARD_T VALUES(BOARD_S.NEXTVAL, 'B', '일반 게시글 테스트 3', 'abcd', '게시글 테스트 중 입니다. 3'
                         , DEFAULT, DEFAULT, DEFAULT);
INSERT INTO BOARD_T VALUES(BOARD_S.NEXTVAL, 'B', '일반 게시글 테스트 4', 'abcd', '게시글 테스트 중 입니다. 4'
                         , DEFAULT, DEFAULT, DEFAULT);
INSERT INTO BOARD_T VALUES(BOARD_S.NEXTVAL, 'N', '공지글 테스트 1', 'abcd', '공지글 테스트 중 입니다. 1'
                         , DEFAULT, DEFAULT, DEFAULT);
INSERT INTO BOARD_T VALUES(BOARD_S.NEXTVAL, 'N', '공지글 테스트 2', 'abcd', '공지글 테스트 중 입니다. 2'
                         , DEFAULT, DEFAULT, DEFAULT);
INSERT INTO BOARD_T VALUES(BOARD_S.NEXTVAL, 'N', '공지글 테스트 3', 'abcd', '공지글 테스트 중 입니다. 3'
                         , DEFAULT, DEFAULT, DEFAULT);
INSERT INTO BOARD_T VALUES(BOARD_S.NEXTVAL, 'B', '일반 게시글 테스트 5', 'abcd', '게시글 테스트 중 입니다. 5'
                         , DEFAULT, DEFAULT, DEFAULT);
INSERT INTO BOARD_T VALUES(BOARD_S.NEXTVAL, 'B', '일반 게시글 테스트 6', 'abcd', '게시글 테스트 중 입니다. 6'
                         , DEFAULT, DEFAULT, DEFAULT);
INSERT INTO BOARD_T VALUES(BOARD_S.NEXTVAL, 'B', '일반 게시글 테스트 7', 'abcd', '게시글 테스트 중 입니다. 7'
                         , DEFAULT, DEFAULT, DEFAULT);
INSERT INTO BOARD_T VALUES(BOARD_S.NEXTVAL, 'B', '일반 게시글 테스트 8', 'abcd', '게시글 테스트 중 입니다. 8'
                         , DEFAULT, DEFAULT, DEFAULT);
INSERT INTO BOARD_T VALUES(BOARD_S.NEXTVAL, 'B', '일반 게시글 테스트 9', 'abcd', '게시글 테스트 중 입니다. 9'
                         , DEFAULT, DEFAULT, DEFAULT);
INSERT INTO BOARD_T VALUES(BOARD_S.NEXTVAL, 'B', '일반 게시글 테스트 10', 'abcd', '게시글 테스트 중 입니다. 10'
                         , DEFAULT, DEFAULT, DEFAULT);
INSERT INTO BOARD_T VALUES(BOARD_S.NEXTVAL, 'B', '일반 게시글 테스트 11', 'abcd', '게시글 테스트 중 입니다. 11'
                         , DEFAULT, DEFAULT, DEFAULT);
INSERT INTO BOARD_T VALUES(BOARD_S.NEXTVAL, 'B', '일반 게시글 테스트 12', 'abcd', '게시글 테스트 중 입니다. 12'
                         , DEFAULT, DEFAULT, DEFAULT);
                        
select * from board_t;
commit;



---Board_T에서 페이징--------------------

SELECT id, btype, title, writer, createDate, viewCnt
  FROM(SELECT ROWNUM AS NUM
            , id, btype, title, writer, createDate, viewCnt
         FROM (SELECT *
                 FROM BOARD_T
                ORDER BY BTYPE DESC, ID DESC)
  )
 WHERE NUM BETWEEN 16 AND 30;
 commit;

--------------------------------------------------

drop table Role_T;
CREATE TABLE ROLE_T(
       ID NUMBER PRIMARY KEY
     , USERID VARCHAR2(20) REFERENCES USER_T(USERID)
     , RTYPE VARCHAR2(50) CHECK(RTYPE IN ('ADMIN', 'STAFF', 'USER'))
);
CREATE SEQUENCE ROLE_S NOCACHE;


INSERT INTO ROLE_T VALUES(ROLE_S.NEXTVAL, 'abcd', 'ADMIN');
INSERT INTO ROLE_T VALUES(ROLE_S.NEXTVAL, 'aaaa', 'USER');
select * from user_T;
INSERT INTO USER_T VALUES('staff_a', '123', 'staff_a@example.com');
INSERT INTO ROLE_T VALUES(ROLE_S.NEXTVAL, 'staff_a', 'STAFF');

SELECT * FROM ROLE_T;

commit;

-------------이미지파일경로추가---------------------------------------------------------


ALTER TABLE USER_T ADD pImg VARCHAR2(250) DEFAULT '/static/img/profile/default.png';

SELECT * FROM USER_T;

UPDATE USER_T
   SET pImg = '/static/img/profile/images.jfif'
 WHERE userId = 'abcd';

commit;

-------------------board게시판 추천/비추천 추가--------------------------------------------------

ALTER TABLE BOARD_T ADD recCnt NUMBER DEFAULT 0;
ALTER TABLE BOARD_T ADD nrecCnt NUMBER DEFAULT 0;
commit;           
select * from board_t;


--------------------게시판 이미지기능--------------------------------------------



drop table board_img_T;

CREATE TABLE BOARD_IMG_T(
       id NUMBER PRIMARY KEY
     , boardId NUMBER REFERENCES BOARD_T(id)
     , path VARCHAR2(500)
     , name VARCHAR2(250)
     , uuid VARCHAR2(36)
);
CREATE SEQUENCE BOARD_IMG_S NOCACHE;

SELECT * FROM BOARD_IMG_T;
commit;

-------------------------exam볼때...---------------------------------------

drop table board;
CREATE TABLE board(
    boardnum NUMBER,
    boardwriter VARCHAR2(20) NOT NULL,
    boardtitle VARCHAR2(50) NOT NULL,
    boardcontent VARCHAR2(2000) NOT NULL,
    boarddate DATE DEFAULT SYSDATE,
    CONSTRAINT board_pk PRIMARY KEY(boardnum)
);


commit;

select * from board;


---------------role배정안된 user 배정해줘야함---------------

select * from user_t;
select * from ROLE_T;
insert into role_t values(ROLE_S.NEXTVAL,'kaka' ,'USER');
insert into role_t values(ROLE_S.NEXTVAL,'dada' ,'USER');
insert into role_t values(ROLE_S.NEXTVAL,'jaja' ,'USER');


select * from dual;


-------------------


create table t_Board(
	articleNO number(10) primary key,
	parentNO number(10) default 0,
	title varchar2(500) not null,
	content varchar2(4000),
	imageFileName varchar2(30),
	writedate date default sysdate not null,
	id varchar2(10),
	constraint fk_id foreign key(id) references t_member(id)
);

select * from t_member;
insert into t_board values(1,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'hong');
insert into t_board values(2,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'hong');
insert into t_board values(3,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'lee');
insert into t_board values(4,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'hong');
insert into t_board values(5,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'kim');
insert into t_board values(6,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'hong');
insert into t_board values(7,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'hong');
insert into t_board values(8,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'hong');
insert into t_board values(9,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'hong');
insert into t_board values(10,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'hong');
insert into t_board values(11,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'hong');
insert into t_board values(12,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'hong');
insert into t_board values(13,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'hong');
insert into t_board values(14,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'hong');
insert into t_board values(15,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'hong');
insert into t_board values(16,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'hong');
insert into t_board values(17,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'hong');
insert into t_board values(18,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'hong');
insert into t_board values(19,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'hong');
insert into t_board values(seq_t_board.nextval,0,'테스트글 입니다','테스트글입니다.',null,sysdate,'hong');
create sequence seq_t_board;
select seq_t_board.nextval from dual;
commit;


select ROWNUM,articleno,parentno,title,content,imagefilename,writedate,ID 
		from(select * from t_board order by articleNO desc);
	
select articleno,parentno,title,content,imagefilename,writedate,ID
from(select rownum as num,articleno,parentno,title,content,imagefilename,writedate,ID 
		from(select * from t_board order by articleNO desc)
	)
where num between 2 and 7;
--주의 as num 이렇게 명칭 안바꿔주고 rownum으로하면 between 2 and 7 했을때 하나도안나온다.

---------------------------------------------------



select* from t_board;

ALTER TABLE t_board ADD recUP NUMBER DEFAULT 0;
ALTER TABLE t_board ADD recDOWN NUMBER DEFAULT 0;
ALTER TABLE t_board ADD viewCNT NUMBER DEFAULT 0;
commit;
select * from board_T;
select * from user_T;

------------------------------------------------------------

CREATE TABLE t_BOARD_IMG(
       id NUMBER PRIMARY KEY
     , boardNO NUMBER REFERENCES t_BOARD(articleNO)
     , path VARCHAR2(500)
     , name VARCHAR2(250)
     , uuid VARCHAR2(36)
);
CREATE SEQUENCE s_BOARD_IMG NOCACHE;



SELECT * FROM BOARD_IMG_T;