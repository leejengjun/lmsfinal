SHOW USER;


SELECT *
FROM TAB;

select *
from tbl_gyowon;

select *
from tbl_subject;

desc tbl_gyowon;

insert into tbl_gyowon(GYOWONID, GYOPWD, GYOEMAIL, GYOMAJORID, GYONAME, GYONAMEENG, GYOBIRTHDAY,GYOJUMIN, GYONATION, GYOADDRESS, GYOPOSTCODE, GYOMOBILE, POSITION, APPOINTMENTDT, WORKSTATUS, DEGREE, CAREER1, CAREERTIME1, CAREER2, CAREERTIME2, STATUS) 
values('00001','','','','','','','','','','','','','','','','','','','','')

insert into tbl_subject(subjectid, majorid, gyowonid, classname, credit, opensemester,courseclfc, applyperson,  totalperson,applydate,  applystate, lctrid, periodid, dayid)
values( null, null, null)

------------- 건물 테이블 데이터 삽입하기 -------------
select *
from tbl_building;

insert into tbl_building(buildno, buildname)
values(1, '공학관');

insert into tbl_building(buildno, buildname)
values(2, '자연과학관');

insert into tbl_building(buildno, buildname)
values(3, '사회과학관');

insert into tbl_building(buildno, buildname)
values(4, '경영관');

insert into tbl_building(buildno, buildname)
values(5, '인문관');

insert into tbl_building(buildno, buildname)
values(6, '예술관');

select *
from tbl_building;

commit;

------------- 요일 테이블 데이터 삽입하기 -------------
select *
from tbl_dayofweek;

insert into tbl_dayofweek(dayid, dayname, abvat) 
values(1, '월요일', '월')

insert into tbl_dayofweek(dayid, dayname, abvat) 
values(2, '화요일', '화')

insert into tbl_dayofweek(dayid, dayname, abvat) 
values(3, '수요일', '수')

insert into tbl_dayofweek(dayid, dayname, abvat) 
values(4, '목요일', '목')

insert into tbl_dayofweek(dayid, dayname, abvat) 
values(5, '금요일', '금')

select *
from tbl_dayofweek;

commit;
--------------------------------------------------------------------
------------- 교시 테이블 데이터 삽입하기 -------------
select *
from tbl_period;

alter session set nls_date_format = 'yyyy-MM-dd hh24:mi:ss'

update tbl_period set starttime=to_date('1900-01-01 09:00', 'yyyy-mm-01 hh24:mi') where periodid=1
update tbl_period set endtime=to_date('09:50', 'hh24:mi') where periodid=1



select to_char('20211212171000', 'yyyymmddhh24miss') 
from dual

insert into tbl_period(periodid, starttime, endtime)
values(1, to_date('1900-01-01 09:00', 'yyyy-mm-dd hh24:mi'), to_date('1900-01-01 09:50','yyyy-mm-dd hh24:mi'))

insert into tbl_period(periodid, starttime, endtime)
values(2, to_date('10:00', 'hh24:mi'), to_date('10:50','hh24:mi'))

insert into tbl_period(periodid, starttime, endtime)
values(3, to_date('11:00', 'hh24:mi'), to_date('11:50','hh24:mi'))

insert into tbl_period(periodid, starttime, endtime)
values(4, to_date('13:00', 'hh24:mi'), to_date('13:50','hh24:mi'))

insert into tbl_period(periodid, starttime, endtime)
values(5, to_date('14:00', 'hh24:mi'), to_date('14:50','hh24:mi'))

insert into tbl_period(periodid, starttime, endtime)
values(6, to_date('15:00', 'hh24:mi'), to_date('15:50','hh24:mi'))

insert into tbl_period(periodid, starttime, endtime)
values(7, to_date('16:00', 'hh24:mi'), to_date('16:50','hh24:mi'))

insert into tbl_period(periodid, starttime, endtime)
values(8, to_date('17:00', 'hh24:mi'), to_date('17:50','hh24:mi'))
-- to_char(SD.startdate,'yyyy-mm-dd hh24:mi')


------------- 강의실 테이블 데이터 삽입하기 -------------

select *
from tbl_lecture_room
order by periodid asc;

alter table tbl_lecture_room add emptystate NUMBER

update tbl_lecture_room set emptystate=null where lctrid=101 and periodid=8


insert into tbl_lecture_room(lctrid, periodid, dayid, buildno)
values(101, 8, 5, 1)

begin
    for i in 1..5 loop
        insert into tbl_lecture_room(lctrid, periodid, dayid, buildno)
        values(201, i, i, 1)
    end loop;
end;

begin
    for i in 1..8 loop
        insert into tbl_lecture_room(lctrid, periodid, dayid, buildno)
        values(102, i, 1, 1)
    end loop;
end;

-----------------------------------------------------

select *
from tbl_subject;

desc tbl_subject;

insert into tbl_subject(subjectid, majorid, gyowonid, classname, credit, opensemester, courseclfc, applyperson, totalperson, applydate, applystate, lctrid, periodid, dayid)
values(11001, 11, 10001, '컴퓨터공학 개론', 3, 1, '전공필수', 0, 50, sysdate, '등록완료', 101, 1, 1)

-- seq_subjectid

func_opensemester

select D.deptname, S.subjectid, S.classname, S.credit
, S.opensemester, S.applyperson, S.totalperson
from tbl_department D, 
     tbl_subject S,
     tbl_lecture_room L, 
     tbl_building B
where D.majorid = S.majorid 

    
select *
from tbl_lecture_room

select D.deptname, S.subjectid, S.classname, S.credit
, S.opensemester, S.applyperson, S.totalperson, S.lctrid, S.lctrtime
from
(select majorid, deptname
from tbl_department) D
JOIN 
(select majorid, gyowonid, subjectid, classname, credit, 
    opensemester, applyperson, totalperson,
    lctrid, dayid ||' '|| periodid as lctrtime
from tbl_subject) S
ON D.majorid = S.majorid
where S.gyowonid = 10001




select  buildname, lctrid
from
(select buildno, lctrid
from tbl_lecture_room) R
JOIN
(select buildno, buildname
from tbl_building)B
ON R.buildno = R.buildno





row_number() over() as rnum,

func_opensemester

func_opensemester(opensemester) AS opensemester

create or replace function func_opensemester
   (p_jubun  IN  varchar2)   
   return number           
   is
      v_result  number(3);
   begin
        select extract(year from sysdate) - ( to_number(substr( p_jubun, 1, 2)) + case when substr(p_jubun,7,1) in('1','2') then 1900 else 2000 end ) + 1
               INTO
               v_result
        from dual;
        return v_result;
   end func_opensemester;

from tbl_subject
where gyowonid = 10001
order by subjectid desc


