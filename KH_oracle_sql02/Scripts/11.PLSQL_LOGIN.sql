drop table login;
create table login(
   usernames number primary key,
   password varchar(20),
   try_cnt number,
   login_lock char(1),
   lock_date date
)

alter table login modify usernames varchar(20);
insert into login values('kim',1234,0,'x',null);
insert into login values('lee',1334,0,'x',null);
insert into login values('park',1434,0,'x',null);

select * from login;

-----

declare
   Vusername varchar(20);
   Vpassword varchar(20);
  Cusername varchar(20);
   Cpassword varchar(20);
   Vcnt number;
   Vtry_cnt number;
   Vlogin_lock char(1);
 	Vlock_date date;
begin
   Cusername := :계정명;
   Cpassword := :비밀번호;
   select count(*)
   into Vcnt
   from login
   where usernames  = Cusername;
  
  if(Vcnt=0) then
  	DBMS_OUTPUT.PUT_LINE('계정정보가 없습니다.');
  else
  	--계정정보가 있을때,
  
	   SELECT LOGIN_LOCK ,lock_date,password
	      into Vlogin_lock, Vlock_date , Vpassword
	      from LOGIN
	      where usernames  = Cusername;
	     --잠겨있을때
	   if (Vlogin_lock ='o' and (sysdate <= (Vlock_date + interval '5' minute)) ) then
	      DBMS_OUTPUT.PUT_LINE('잠겨있습니다.' || TO_CHAR((Vlock_date + INTERVAL '5' MINUTE), 'YYYY.MM.DD HH24:MI:SS') ||'후에 접속하세요');
	     
	     --잠겨있지않을때
	   else
	   		--비번 맞을때
		   	if(Cpassword = Vpassword ) then
		   		DBMS_OUTPUT.PUT_LINE('로그인 되었습니다.');
		   		UPDATE LOGIN
	            SET TRY_CNT = 0 , LOGIN_LOCK = 'x', lock_date=null
	            WHERE USERNAMEs = CUSERNAME;
		   		--비번틀렸을때
		   	else
		      update login
		      set try_cnt = try_cnt + 1
		      where usernames = Cusername;
		   
		      SELECT TRY_CNT
		      into Vtry_cnt
		      from LOGIN
		      where usernames  = Cusername ;
		    	if (Vtry_cnt <=3) then
		      	DBMS_OUTPUT.PUT_LINE(3-(Vtry_cnt) ||'회 남았습니다.');
		   	  	end if;
		
		   		if(Vtry_cnt>=3) then
			      	update login
			      	set login_lock = 'o',
			         lock_date = sysdate
			      	where usernames = Cusername;
			      	DBMS_OUTPUT.PUT_LINE('잠겼습니다.');
			   
		   		end if;
	   		
	   
			end if;
	end if;
end if;
end;




------------------------------
declare
begin
   DBMS_OUTPUT.PUT_LINE('d잠겼습니다.');
   

   
end;


select * from login;

update LOGIN 
set try_cnt= 0
where usernames='kim';

