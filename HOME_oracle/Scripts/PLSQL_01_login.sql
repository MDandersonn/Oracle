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

declare
	Vusername varchar(20);
	Vpassword varchar(20);
	Vcnt number;
	Vtry_cnt number;
	Vlogin_lock char(1);
begin
	Vusername := :username;
	Vpassword := :password;
	select count(*)
	into Vcnt
	from login
	where usernames  = Vusername and password = Vpassword;
	
	SELECT LOGIN_LOCK 
		into Vlogin_lock
		from LOGIN
		where usernames  = Vusername ;
	if (Vlogin_lock ='o') then
		DBMS_OUTPUT.PUT_LINE('잠겼습니다.');
	end if;

	if(Vcnt<=0 and Vlogin_lock ='x') then
		update login
		set try_cnt = try_cnt+1
		where usernames = Vusername;
	
		SELECT TRY_CNT
		into Vtry_cnt
		from LOGIN
		where usernames  = Vusername ;
		DBMS_OUTPUT.PUT_LINE(3-(Vtry_cnt) ||'회 남았습니다.');
	end if;

	if(Vtry_cnt=3 and Vlogin_lock ='x') then
		update login
		set login_lock = 'o',
			lock_date = sysdate
		where usernames = Vusername;
		DBMS_OUTPUT.PUT_LINE('잠겼습니다.');
	end if;

end;

declare
begin
	DBMS_OUTPUT.PUT_LINE('d잠겼습니다.');
	
end;


select * from login;

update LOGIN 
set try_cnt= 0
where usernames='kim';


