select *
from spring_test


select 학번, 비밀번호, 이름, 이메일, 학과이름
from 학생 A join 학과 B
A.학과코드 = B.학과코드

desc tbl_student

select substr(sysdate,0,5)from dual

select substr(stdjumin,0,6) || '-' || substr(stdjumin,7) as stdjumin from tbl_student
select substr(stdmobile,0,3) || '-' || substr(stdmobile,4,4) || '-' || substr(stdmobile,8,4) as stdmobile from tbl_student

select stdid, stdname, stdnameeng, stdbirthday
     , entstate, entday, stdjumin, stdnation, enttype, examnum
     , stdpostcode, stdmobile, stdemail, stdaddress
     , schoolfrom1, graddate1, schoolfrom2, graddate2
     , majorname ,minorname, dmajorname, statename, gyoname, grade
     from
(
select stdid, stdname, stdnameeng, to_char(stdbirthday, 'YYYY-MM-DD') as stdbirthday
     , stdmajorid, stdstateid, entstate
     , nvl(dmajorid, 0) as dmajorid, minorid, to_char(entday, 'YYYY-MM-DD') as entday, substr(stdjumin,0,6) || '-' || substr(stdjumin,7) as stdjumin, stdnation
     , gyowonid, enttype, examnum
     , stdpostcode, substr(stdmobile,0,3) || '-' || substr(stdmobile,4,4) || '-' || substr(stdmobile,8,4) as stdmobile, stdemail, stdaddress
     , schoolfrom1, to_char(graddate1, 'YYYY-MM') as graddate1, schoolfrom2, to_char(graddate2, 'YYYY-MM') as graddate2
     , substr(sysdate,0,2) - substr(entday,0,2) + 1 as grade
from tbl_student
where stdid = '202200001'
) a
join 
(
select deptname as majorname     
     , majorid as majorid     
from tbl_department
)b
on a.stdmajorid = b.majorid
join 
(
select deptname as minorname     
     , majorid as minorid     
from tbl_department
)c
on a.minorid = c.minorid
join 
(
select deptname as dmajorname     
     , majorid as dmajorid     
from tbl_department
)d
on a.dmajorid = d.dmajorid
join
tbl_stdstate e
on a.stdstateid = e.stdstateid
join
tbl_gyowon f
on a.gyowonid = f.gyowonid






select * from tbl_stdstate

select * from tbl_gyowon

select * from tbl_department
insert into tbl_department values(0, '없음')
commit
select to_date(sysdate, 'YYYY-MM-DD') from dual

SELECT TO_CHAR(TO_DATE(sysdate, 'YYYYMMDDHH24MISS'), 'YYYY-MM-DD HH24:MI:SS') AS TO_DATE_형식1 from dual

SELECT TO_DATE(sysdate,'YYYY-MM-DD') AS ONE from dual

update tbl_student set STDPOSTCODE ='04001' 
                   , STDMOBILE = '01026761384'
                   , STDADDRESS = '서울 마포구 월드컵북로 21'
                   where stdid = '202200001'
commit

dex

select * from tbl_subject

select * from tbl_department

update tbl_student set stdpostcode = 12345, stdmobile = 123124, stdaddress = 'dsafd' where stdid = 202200001
rollback

select * from tbl_subject

update tbl_student set stdpostcode = #{stdpostcode}, stdmobile = #{stdmobile}, stdaddress = #{stdaddress}
		where stdid = #{stdid}
        
select * from tbl_lecture_room

-- 개설강좌목록 ( sysdate가 1~6월이면 1학기 개설과목, 7~12월이면 2학기 개설과목)
select subjectid, deptname, classname, grade, totalperson, remaingseat gyoname, credit, dayname, periodid, lctrid, endperiodid from
(select A.subjectid, B.deptname, A.classname,
        case 
            when A.opensemester in (1,2) then 1
            when A.opensemester in (3,4) then 2
            when A.opensemester in (5,6) then 3
            when A.opensemester in (7,8) then 4
        end as grade,
        case
            when A.opensemester in (1,3,5,7) then 1
            when A.opensemester in (2,4,6,8) then 2
        end as semester,
        A.totalperson, (A.totalperson - A.applyperson) as remaingseat, C.gyoname,
        A.credit, D.dayname, A.periodid, A.lctrid,
        (A.periodid + A.credit - 1) AS endperiodid        
from tbl_subject A join tbl_department B
on A.majorid = B.majorid
join tbl_gyowon C
on A.gyowonid = C.gyowonid
join tbl_dayofweek D
on A.dayid = D.dayid
where a.applystate = '등록완료') E
where E.semester = case 
                    when ((select extract(month from sysdate) from dual) < 7 ) then 1
                    else 2
                   end
and grade = '1'
order by subjectid


select extract(month from sysdate) from dual

select * from tbl_student

select *
from tbl_lecture_room a
where a.periodid = (select max(aa.periodid) from tbl_lecture_room aa where a.dayid = aa.dayid)
order by a.dayid

select case 
            when ((select extract(month from sysdate) from dual) between 1 and 6) then (select * from tbl_subject where opensemester in (1,3,5,7))
            else (select * from tbl_subject where opensemester in (2,4,6,8)
        end as semester
        from tbl_subject

-- 학과명 불러오기
select distinct deptname 
from tbl_subject A join tbl_department B on A.majorid = B.majorid 
order by deptname


-- 요일명 불러오기
select dayid, dayname
from tbl_dayofweek
order by dayid

-- 대상학년 알아오기
select distinct case 
            when opensemester in (1,2) then 1
            when opensemester in (3,4) then 2
            when opensemester in (5,6) then 3
            when opensemester in (7,8) then 4
        end as grade, classname
from tbl_subject

-- 강좌명으로 알아오기
select classname, gyoname
from tbl_subject A join tbl_gyowon B on A.gyowonid = B.gyowonid
where classname like '%그래밍%'

SELECT * FROM TBL_GYOWON

update tbl_subject set gyowonid = '10002' where subjectid = '11008'


select substr(stdid, 0, 4) from tbl_student

select *,
(case when (((select extract(year from sysdate) from dual) - (select substr(stdid, 0, 4) from tbl_student) + 1) = 1) and ((select extract(month from sysdate) from dual) < 7) then 1
      when (((select extract(year from sysdate) from dual) - (select substr(stdid, 0, 4) from tbl_student) + 1) = 1) and ((select extract(month from sysdate) from dual) > 6) then 2
      when (((select extract(year from sysdate) from dual) - (select substr(stdid, 0, 4) from tbl_student) + 1) = 2) and ((select extract(month from sysdate) from dual) < 7) then 3
      when (((select extract(year from sysdate) from dual) - (select substr(stdid, 0, 4) from tbl_student) + 1) = 2) and ((select extract(month from sysdate) from dual) > 6) then 4
      when (((select extract(year from sysdate) from dual) - (select substr(stdid, 0, 4) from tbl_student) + 1) = 3) and ((select extract(month from sysdate) from dual) < 7) then 5
      when (((select extract(year from sysdate) from dual) - (select substr(stdid, 0, 4) from tbl_student) + 1) = 3) and ((select extract(month from sysdate) from dual) > 6) then 6
      when (((select extract(year from sysdate) from dual) - (select substr(stdid, 0, 4) from tbl_student) + 1) = 4) and ((select extract(month from sysdate) from dual) < 7) then 7
      else 8
  end) as semester
from tbl_student


select
case 
    when opensemester in (1,2) then 1
    when opensemester in (3,4) then 2
    when opensemester in (5,6) then 3
    when opensemester in (7,8) then 4
end as grade
from tbl_subject


select * from tbl_gyowon

-- 시퀀스 조회
select * from user_sequences


select stdid, stdname
from tbl_student
where lower(stdname) like '%'|| lower('김') ||'%'


select * from tbl_calendar_schedule

select * from tbl_calendar_large_category

select * from tbl_calendar_small_category

insert into tbl_calendar_large_category(lgcatgono, lgcatgoname)
values(1, '내캘린더');

insert into tbl_calendar_large_category(lgcatgono, lgcatgoname)
values(2, '공유캘린더');

commit

-- 일정 상세 보기
select SD.scheduleno
     , to_char(SD.startdate,'yyyy-mm-dd hh24:mi') as startdate
     , to_char(SD.enddate,'yyyy-mm-dd hh24:mi') as enddate  
     , SD.subject
     , SD.color
     , nvl(SD.place,'-') as place
     , nvl(SD.joinuser,'공유자가 없습니다.') as joinuser
     , nvl(SD.content,'') as content
     , SD.fk_smcatgono
     , SD.fk_lgcatgono
     , SD.fk_userid
     , M.stdname
     , SC.smcatgoname
from tbl_calendar_schedule SD 
JOIN tbl_student M
ON SD.fk_userid = M.stdid
JOIN tbl_calendar_small_category SC
ON SD.fk_smcatgono = SC.smcatgono
where SD.scheduleno = 21;


-- 학번, 교번 다 나오게 하는 것
create or replace 
with tab as (
select stdid from tbl_student
union all
select gyowonid from tbl_gyowon)
select * from tab;

-- 학생, 교수 번호 전부 가져오는 뷰 생성
create or replace view tbl_member as
(
select stdid as userid, stdname as name, status from tbl_student
union all
select gyowonid as userid, gyoname as name, status from tbl_gyowon
)

select * from tbl_member


-- 스케줄 상세 불러오기 tbl_Member 에서 userid 불러옴
select SD.scheduleno
     , to_char(SD.startdate,'yyyy-mm-dd hh24:mi') as startdate
     , to_char(SD.enddate,'yyyy-mm-dd hh24:mi') as enddate  
     , SD.subject
     , SD.color
     , nvl(SD.place,'-') as place
     , nvl(SD.joinuser,'공유자가 없습니다.') as joinuser
     , nvl(SD.content,'') as content
     , SD.fk_smcatgono
     , SD.fk_lgcatgono
     , SD.fk_userid
     , M.userid
     , SC.smcatgoname
from tbl_calendar_schedule SD
JOIN tbl_member M
ON SD.fk_userid = M.userid
JOIN tbl_calendar_small_category SC
ON SD.fk_smcatgono = SC.smcatgono
where SD.scheduleno = #{scheduleno}



select * from tbl_student
rollback
commit
acJL1qExdZyHdEO5W1B7FVneNLKXf9aYY996SMIw6QMrW8BQ6ZSxVlupCec0MaI9uJS781dgaE5g5MWIyzGtDV2cCtUaa4Hk2GKo5hZSRqc=

update tbl_student set stdemail = 'u/DP5RDusHHvN8NUuyr6VWZe8gnYYoNM9bMTMVGEDds=' where stdid = 202200001

select * from tbl_course

select stdid, subjectid, deptname, classname, grade, totalperson, remaingseat, gyoname, credit, dayname, periodid, lctrid, endperiodid, majorid, gyowonid, courseno
from
(select A.subjectid, B.deptname, D.classname, A.stdid, A.courseno,
        case 
            when D.opensemester in (1,2) then 1
            when D.opensemester in (3,4) then 2
            when D.opensemester in (5,6) then 3
            when D.opensemester in (7,8) then 4
        end as grade,
        case
            when D.opensemester in (1,3,5,7) then 1
            when D.opensemester in (2,4,6,8) then 2
        end as semester,
        D.totalperson, (D.totalperson - D.applyperson) as remaingseat, C.gyoname,
        D.credit, E.dayname, D.periodid, D.lctrid, A.majorid, A.gyowonid,
        (D.periodid + D.credit - 1) AS endperiodid        
from tbl_course A join tbl_department B
on A.majorid = B.majorid
join tbl_gyowon C
on A.gyowonid = C.gyowonid
join tbl_subject D
on D.subjectid = A.subjectid
join tbl_dayofweek E
on D.dayid = E.dayid
where A.evaluwhether=0)
where 1=1
and stdid = 202200001

select 

delete from tbl_course where courseno = 14
delete from tbl_course where stdid is null
rollback
commit
select * from tbl_lecture_evaluation

update tbl_course set evaluwhether = 1 where courseno = 14

update tbl_subject set applyperson = applyperson + 5 where subjectid = 11002
commit
select * from tbl_subject
select * from tbl_lectureroom_assign
select * from tbl_attendance
select * from tbl_course

insert into tbl_course(courseno, stdid, appsemester, evaluwhether, subjectid, majorid, gyowonid)
select(seq_courseno.nextval, 202200001, 2, default, 13001, 13, 10001) from dual
where not exists(select 1 from tbl_course where stdid=202200001 and evaluwhether=0 and subjectid=13001)

alter table tbl_course add unique ( stdid, evaluwhether, subjectid, majorid)

commit

ALTER TABLE tbl_course
	ADD
		CONSTRAINT UK_tbl_course -- 수강 유니크 제약
		UNIQUE (
			stdid,        -- 학번
			appsemester,  -- 신청학기
			evaluwhether, -- 강의평가여부
			subjectid     -- 강의코드
		);

rollback


-- 해당학기 개설강의 불러오기 ver1
select subjectid, deptname, classname, grade, totalperson, remaingseat, gyoname, credit, dayname, periodid, lctrid, endperiodid, majorid, gyowonid
from
(select A.subjectid, B.deptname, A.classname,
        case 
            when A.opensemester in (1,2) then 1
            when A.opensemester in (3,4) then 2
            when A.opensemester in (5,6) then 3
            when A.opensemester in (7,8) then 4
        end as grade,
        case
            when A.opensemester in (1,3,5,7) then 1
            when A.opensemester in (2,4,6,8) then 2
        end as semester,
        A.totalperson, (A.totalperson - A.applyperson) as remaingseat, C.gyoname,
        A.credit, D.dayname, A.periodid, A.lctrid, A.majorid, A.gyowonid,
        (A.periodid + A.credit - 1) AS endperiodid        
from tbl_subject A join tbl_department B
on A.majorid = B.majorid
join tbl_gyowon C
on A.gyowonid = C.gyowonid
join tbl_dayofweek D
on A.dayid = D.dayid
where a.applystate = '등록완료') E		
where E.semester = case 
                    when ((select extract(month from sysdate) from dual) < 7 ) then 1
                    else 2
                   end 

-- 해당학기 개설강의 불러오기 ver1 끝 --

select * from tbl_subject

select B.subjectid, A.deptname,  B.classname, nvl(B.totalperson, NULL) as totalperson, B.applyperson
      , B.credit, B.opensemester, B.applystate, B.applydate
      , nvl(F.abvat, NULL) || ' ' || nvl(H.periodlist, NULL) AS dayid
      , nvl(E.buildname,NULL) || ' ' ||  nvl(D.lctrid,NULL) AS lctrid
      , nvl(I.seq_lectureplan, NULL) AS seq_lectureplan
from

(
select majorid, deptname
from tbl_department
) A
JOIN 
(
select majorid, subjectid, gyowonid, classname, credit, 
      opensemester, applyperson, totalperson,
      applystate, applydate
from tbl_subject
) B
ON A.majorid = B.majorid

LEFT JOIN 
(
select subjectid, periodid, dayid, seq_lctrid
from tbl_lectureroom_assign
) C
ON B.subjectid = C.subjectid

LEFT JOIN
(
select buildno, lctrid, seq_lctrid
from tbl_lectureroom
)D
ON C.seq_lctrid = D.seq_lctrid

LEFT JOIN
(
select buildno, buildname
from tbl_building
)E
on D.buildno = E.buildno

LEFT JOIN
(
select dayid, abvat
from tbl_dayofweek
)F
on C.dayid = F.dayid

LEFT JOIN
(
select seq_lectureplan, subjectid
from tbl_lectureplan
) G
on B.subjectid = G.subjectid

LEFT JOIN
(
select subjectid, LISTAGG(periodid,',') WITHIN GROUP (ORDER BY periodid) AS periodlist
from (
        select subjectid, dayid, periodid, seq_lctrid
        from tbl_lectureroom_assign
        )
group by subjectid
order by subjectid
) H
on B.subjectid = H.subjectid

LEFT JOIN
(
select seq_lectureplan, subjectid
from tbl_lectureplan
) I
on B.subjectid = I.subjectid

where B.gyowonid = 10001
and applystate = '등록완료'
order by B.applydate asc
      
      
      
      
      select * from tbl_subject
      update tbl_subject set applyperson = 49 where subjectid = 11002
      select * from tbl_course
      delete from tbl_course where courseno = 328

-- 학번별 신청학점 구하기      
select sum(B.credit)  as creditsum
from tbl_course A 
join tbl_subject B 
on A.subjectid = B.subjectid 
where stdid = 202200001 
and evaluwhether = 0 
group by stdid

-- 학번별 신청학점 구하기      
select A.stdid, sum(B.credit) as creditsum
from tbl_course A
join tbl_subject B
on A.subjectid = B.subjectid 
join tbl_student C
on A.stdid = C.stdid
where evaluwhether = 0 
group by A.stdid



-- 해당학기 개설강의 불러오기 ver2 --
select subjectid, deptname, classname, grade, totalperson, remaingseat, gyoname,  
           credit, dayname, lctrid, buildname, majorid, gyowonid, periodid1, periodid2, periodid3, dayid
from
(
    select rownum as rno, subjectid, deptname, classname, grade, totalperson, remaingseat, gyoname,  
           credit, dayname, lctrid, buildname, majorid, gyowonid, periodid1, periodid2, periodid3, dayid
    from
    (
        select distinct subjectid, deptname, classname, grade, totalperson, remaingseat, gyoname,  
               credit, dayname, lctrid, buildname, majorid, gyowonid, periodid1, periodid2, periodid3, dayid
        from
        (select A.subjectid, E.deptname, A.classname, 
                case 
                    when A.opensemester in (1,2) then 1
                    when A.opensemester in (3,4) then 2
                    when A.opensemester in (5,6) then 3
                    when A.opensemester in (7,8) then 4
                end as grade,
                case
                    when A.opensemester in (1,3,5,7) then 1
                    when A.opensemester in (2,4,6,8) then 2
                end as semester,
                A.credit, (A.totalperson - A.applyperson) as remaingseat, G.gyoname,
                A.totalperson, B.periodid, C.lctrid, D.buildname, F.dayname,
                A.majorid, A.gyowonid, H.periodid1, H.periodid2, H.periodid3, B.dayid
        from 
        (
        select subjectid, majorid, gyowonid, classname, credit, opensemester
             , applyperson, totalperson, applystate
        from tbl_subject
        )A
        join 
        ( 
        select periodid, dayid, subjectid, seq_lctrid 
        from tbl_lectureroom_assign 
        ) B
        on A.subjectid = B.subjectid
        join 
        (
        select seq_lctrid, lctrid, buildno
        from tbl_lectureroom
        ) C
        on B.seq_lctrid = C.seq_lctrid
        join tbl_building D
        on C.buildno = D.buildno
        join tbl_department E
        on A.majorid = E.majorid
        join tbl_dayofweek F
        on B.dayid = F.dayid
        join tbl_gyowon G
        on A.gyowonid = G.gyowonid
        join
        (
            select subjectid, dayid,
                   max(decode(rid, 1, periodid)) periodid1,
                   max(decode(rid, 2, periodid)) periodid2,
                   max(decode(rid, 3, periodid)) periodid3
            from
            (
                select subjectid, dayid,
                       row_number() over(partition by subjectid order by periodid) rid,
                       periodid
                from 
                (
                    select subjectid, classname, periodid, dayid from
                    (
                        select A.subjectid, A.classname, B.periodid, B.dayid
                        from tbl_subject A
                        join tbl_lectureroom_assign B
                        on A.subjectid = B.subjectid
                        where A.applystate = '등록완료'
                        order by A.subjectid, B.periodid
                    )
                )
            )
            group by subjectid, dayid
        ) H
        on A.subjectid = H.subjectid
        where A.applystate = '등록완료'
        order by subjectid)
        where semester = case 
                            when ((select extract(month from sysdate) from dual) < 7 ) then 1
                            else 2
                           end 
                           order by subjectid
    )
   
)
where rno between 1 and 10

-- 해당학기 개설강의 불러오기 ver2 끝 --

                   

select *
from tbl_subject A
join tbl_lectureroom_assign B
on A.subjectid = B.subjectid
where A.applystate = '등록완료'
order by A.subjectid, B.periodid


-- 과목별 교시 행에서 열로 변경
select subjectid, classname, dayid,
       max(decode(rid, 1, periodid)) periodid1,
       max(decode(rid, 2, periodid)) periodid2,
       max(decode(rid, 3, periodid)) periodid3
from
(
    select subjectid, classname, dayid,
           row_number() over(partition by subjectid order by periodid) rid,
           periodid
    from 
    (
        select subjectid, classname, periodid, dayid from
        (
            select A.subjectid, A.classname, B.periodid, B.dayid
            from tbl_subject A
            join tbl_lectureroom_assign B
            on A.subjectid = B.subjectid
            where A.applystate = '등록완료'
            order by A.subjectid, B.periodid
        )
    )
)
group by subjectid, classname, dayid


-- 수강신청 완료한 목록
select distinct subjectid, deptname, classname, grade, totalperson, remaingseat, gyoname,  
       credit, dayname, lctrid, buildname, majorid, gyowonid, periodid1, periodid2, periodid3, courseno, dayid
from
(
    select C.subjectid, B.deptname, C.classname,
        case 
            when C.opensemester in (1,2) then 1
            when C.opensemester in (3,4) then 2
            when C.opensemester in (5,6) then 3
            when C.opensemester in (7,8) then 4
        end as grade,
        case
            when C.opensemester in (1,3,5,7) then 1
            when C.opensemester in (2,4,6,8) then 2
        end as semester,
        C.credit, (C.totalperson - C.applyperson) as remaingseat, D.gyoname,
        C.totalperson, E.periodid, G.lctrid, H.buildname, F.dayname,
        C.majorid, C.gyowonid, I.periodid1, I.periodid2, I.periodid3, A.courseno, E.dayid
    from tbl_course A join tbl_department B
    on A.majorid = B.majorid
    join tbl_subject C
    on A.subjectid = C.subjectid
    join tbl_gyowon D
    on C.gyowonid = D.gyowonid
    join tbl_lectureroom_assign E
    on C.subjectid = E.subjectid
    join tbl_dayofweek F
    on E.dayid = F.dayid
    join tbl_lectureroom G
    on E.seq_lctrid = G.seq_lctrid
    join tbl_building H
    on G.buildno = H.buildno
    join
    (
        select subjectid, dayid,
               max(decode(rid, 1, periodid)) periodid1,
               max(decode(rid, 2, periodid)) periodid2,
               max(decode(rid, 3, periodid)) periodid3
        from
        (
            select subjectid, dayid,
                   row_number() over(partition by subjectid order by periodid) rid,
                   periodid
            from 
            (
                select subjectid, classname, periodid, dayid from
                (
                    select A.subjectid, A.classname, B.periodid, B.dayid
                    from tbl_subject A
                    join tbl_lectureroom_assign B
                    on A.subjectid = B.subjectid
                    where A.applystate = '등록완료'
                    order by A.subjectid, B.periodid
                )
            )
        )
        group by subjectid, dayid
    ) I
    on C.subjectid = I.subjectid
    where A.evaluwhether=0
    and A.stdid = 202200001
)
order by courseno desc

select * from tbl_lecture_evaluation
select * from tbl_lecture_evalucomplete

select * from tbl_student

select * from tbl_course

select * from tbl_calendar_schedule

select * from tbl_calendar_large_category

select * from tbl_calendar_small_category

select * from tbl_member

select subject from tbl_course where evaluwhether = 0

select * from tbl_lecture_evalucomplete

insert into tbl_lecture_evalucomplete(evalucode, courseno)
values (seq_evalucode.nextval, 8)

update tbl_lecture_evalucomplete set firstans = 1 where evalucode = 14

delete tbl_course where courseno = 633

alter table tbl_lecture_evalucomplete add constraint foreign key (COURSENO) references tbl_course(courseno) on delete cascade;