select * from EMPLOYEES e where EMPLOYEE_ID =100;

update EMPLOYEES 
set manager_id=200
where EMPLOYEE_ID =100;

rollback;

/*디비버에서 100으로 수정을하고 커밋안한상태에서 cmd에서 null로 업데이트 하면 반응이 없음. 락걸림
 *디비버에서 커밋을하면 락풀림(커밋을 할 때까지 계속 락걸림)
 *
 * 
 * 
 * 
 * 
 * 
*/
