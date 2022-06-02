show user;

select no, name, to_char(writeday, 'yyyy-mm-dd hh24:mi:ss') AS writeday
from spring_test
order by writeday desc;

select * from tab; 

select * from user_sequences;

select *
from TBL_STUDENT;

select *
from TBL_GYOWON;


select *
from TBL_NOTICE;

delete from TBL_GYOWON
where gyowonid IN(10003);
commit;

update TBL_GYOWON set gyopwd = '9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382'
where gyowonid = 10005;

select count(*)
from tbl_notice
where nstatus = 1
and  lower(searchType) like '%'|| lower(searchWord) ||'%';



ALTER TABLE tbl_notice MODIFY ncontent VARCHAR2(4000);







