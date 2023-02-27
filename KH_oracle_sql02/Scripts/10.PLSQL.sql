/*
 * 옵션-> SQL실행 -> clear ~체크하면 실행하기전에 다 깔끔하게 지워줌
 * 
 * sqlplus dev01/dev01@localhost:1521/XEPDB1
*/


declare
	num number;
	num2 number := 10;
	
BEGIN
	num := 5;
	DBMS_output.put_line(num2 +5);
	DBMS_output.put_line(NUM +5);
	DBMS_output.put_line('hihi');
end;
-- / 있어야함 디비버에선 빼야함.
--cmd에서는 set serveroutput on; 해야함 디비버에선 안해도됨

declare
	pID number;
	pNAME varchar2(50);
BEGIN
	select employee_id, first_name || ' '|| last_name
	into pID, pNAME
	from EMPLOYEES e 
	where employee_iD=:id; 

	DBMS_output.put_line(pID || ','|| pNAME);
end;

-- 반드시 1개행이어야함
--plsql에선 사용자입력은 &id 로 입력함
--디비버에선 사용자입력은 :id 로입력


/*
 * if문 사용하기
 * 
 */
DECLARE
	num NUMBER;
begin
	num := :num;
	if(num>10) then
		DBMS_output.put_line('num값은 10보다 크다');
	elsif(num=10) then
		DBMS_output.put_line('num값은 10이다');
	else
		DBMS_output.put_line('num값은 10보다 작다');
	end if;
end;

/*
 * 
 * 반복
 * 
 */

begin
	for n in 1..5 loop
		DBMS_output.put_line(n);
	end loop;
end;

declare
	cnt number :=0;
begin
	loop
		DBMS_output.put_line(cnt);
		cnt:= cnt+1;
		if (cnt>5) then
			exit;
		end if;
	end loop;
end;



declare
	cnt number :=1;
begin
	while cnt<=5 loop
		DBMS_output.put_line(cnt);
		cnt:= cnt+1;
	end loop;
end;


declare
	st_id number :=100;
	ed_id number :=109;
	id number;
	name varchar(50);
begin
	for c_id in st_id..ed_id loop
		SELECT employee_ID,concat(first_name,' ' || last_name)
		into id,name
		from EMPLOYEES
		where employee_id=c_id;
		dbms_output.put_line(id || ',' || name);
	end loop;
end;

/*insert문
 * 
 * 
*/
create table test1(
	id number primary key,
	name varchar2(30),
	age number
);

begin 
	insert into test1 values(:id, :name, :age);
end;

-- 입력할땐 '문자열 '써야함
select * from test1;
commit;

/* sqlplus일떄
 * 
begin 
	insert into test1 values(&id, '&name', &age);
end;
 * 
 */ 
create table test2(
	id number primary key,
	name varchar2(30),
	age number
);
--역시 DDL은 커밋 되는구나

declare
	cname varchar2(30);
	cage number;
	sid number;

begin 
	sid := :select_id;
	cname := :change_name;
	cage := :change_age;
	update test1
	set name=cname
		,age=cage
	where id=sid ;
end;

select * from test1;

begin 
	update test1
	set name= :change_name
		,age= :change_age
	where id= :change_id ;
end;

--참조무결성 확인
declare
	VID number;
	VNAME varchar2(30);
	vage number;
	cnt number;
begin
	vid := :id;
	vname := :name;
	vage := :age;
	
	select count(id)
	into cnt
	from test1
	where id = vid;
	
	if( cnt >0) then
		DBMS_output.put_line('동일한 id가 존재합니다');
		update test1
		set name =vname,
			age=vage
		where id=vid;
		dbms_output.put_line('데이터를 수정하였습니다.');
	else
		insert into test1 values(vid,vname,vage);
		dbms_output.put_line('데이터를 추가하였습니다.');
	end if;
end;


select id
	from test1
	where id = 5;

select * from test1;



--exception구문활용
/*
 * insert구문을 실행해보고 에러나면 exception구문 실행
 */
declare
	VID number;
	VNAME varchar2(30);
	vage number;
begin
	vid := :id;
	vname := :name;
	vage := :age;

	insert into test1 values(vid,vname,vage);
	dbms_output.put_line('데이터를 추가하였습니다.');

exception
	when dup_val_on_index then
		update test1
		set name =vname,
			age=vage
		where id=vid;
		dbms_output.put_line('데이터를 수정하였습니다.');
end;

select * from test1;


--예외처리이름은 오라클사이트가서 
/*oracle 21c exception handling 으로 검색
 * 첫번째링ㅋ Error handling에서 왼쪽메뉴에 12.4 predefined exceptions 클릭
 * 
 * 
*/