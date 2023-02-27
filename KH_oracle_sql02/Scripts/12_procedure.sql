/*
프로시저객체
plsql구문을 사용하여 만든 객체
함수와 비슷하게 프로시저를 호출(exec명령어 사용) 언제든 사용할수있다.
함수처럼 프로시저내부에 값을 전달하거나 외부로 값을 내보낼 수 있다.
값을 내보낼 때의 작업은 반환 작업이 아니다.
*/

create or replace procedure proc_sample1
IS
BEGIN 
	dbms_output.put_line('프로시저실행');
END;

--에러가있는지없는지 확인
select * from USER_ERRORS;


begin
	proc_sample1;
end;
/*
 * sqlplus에서는 set serveroutput on;하고
 * exec proc_sample1; 해야함
 *
 */

/*
 * 프로시저에서 사용할 변수 정의
 * is랑 begin 사이에 만든다.
 */
create or replace procedure proc_sample2
IS
	var number := 10 ;
BEGIN 
	DBMS_output.put_line('프로시저실행!!!' || var);
END;

--위아래 주석이있으면 오류난다 범위지정해주고실행하자

begin
	proc_sample2;
end;



--------
select * from USER_ERRORS;

------------매개변수받기
create or replace procedure proc_sample3( x in number, y in varchar2)
IS
BEGIN 
	dbms_output.put_line('프로시저실행');
	dbms_output.put_line(x);
	dbms_output.put_line(y);
END;


begin
	proc_sample3(10,'문자열');
end;


---프로시저외부로값보내기

create or replace procedure proc_sample4(x out number )
IS
BEGIN 
	x := 10;
	dbms_output.put_line('내보낼 값을 성정하였습니다.');
END;


declare
	y number;
begin
	proc_sample4(y);
	dbms_output.put_line(y ||'값을받았습니다.');
end;

select * from USER_ERRORS;



create or replace procedure proc_sample5(num1 in number, num2 in number, res out NUMBER)
IS
BEGIN
	res := num1 +num2;
	dbms_output.put_line('더하기 계산이 완료되었습니다.');
end;

declare
	y number;
begin
	proc_sample5(10,20,Y);
	dbms_output.put_line(Y);
end;





/*sqlplus 에서할때는
 * variable y number;
 * exec proc_sample5(10,20,:Y); 해야함
 */


*/