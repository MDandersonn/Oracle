drop table trainee;
drop table lesson;
drop table student;

create table student(
	no number,
	sd_num number primary key,
	sd_name varchar(30),
	s_num number,
	sd_email varchar(30)
);

create table lesson(
	no number,
	l_abbre varchar(30) primary key,
	l_name varchar(30)
);




create table trainee(
	no number primary key,
	sd_num number,
	l_abbre varchar(30),
	t_section varchar(30),
	t_date date,
	foreign key (sd_num) references student(sd_num)
	on delete cascade,
	foreign key (l_abbre) references lesson(l_abbre)
	on delete cascade
)

insert into student values(1,100, 'Kim',01,'kim');
insert into student values(2,101, 'Ksdm',02,'kfdim');
insert into student values(3,102, 'Kam',02,'kissm');
insert into student values(4,103, 'Kddm',03,'kiaam');

insert into lesson values(1,'dm','descrete math');
insert into lesson values(2,'db','database');
insert into lesson values(3,'ds','data structure');

insert into trainee values(1,100,'dm',null,'2008-12-15');
insert into trainee values(2,101,'dm',null,'2008-12-16');
insert into trainee values(3,100,'db',null,'2008-12-15');
insert into trainee values(4,102,'ds',null,'2008-12-15');
insert into trainee values(5,103,'ds',null,'2008-12-15');

SELECT sd_name 학생명, l_name 과목명, to_char(t_date, 'YYYY.MM.DD') 수강신청일
FROM trainee tr, student st, lesson le 
WHERE tr.l_abbre = le.l_abbre;

SELECT  l_name 과목명, to_char(t_date, 'YYYY.MM.DD') 수강신청일
FROM trainee tr, lesson le 
WHERE tr.l_abbre = le.l_abbre;


SELECT sd_name 학생명, l_name 과목명, to_char(t_date, 'YYYY.MM.DD') 수강신청일
FROM student st join trainee tr on st.sd_num=tr.sd_num
	join lesson le on le.l_abbre=tr.l_abbre;

