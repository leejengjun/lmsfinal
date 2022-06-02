show user;
-- USER이(가) "FINALORAUSER3"입니다.

select *
from tab;

select *
from TBL_STDSTATE;

show recyclebin;

purge recyclebin; -- 휴지통 비우기
----------------------------------------------------------------

drop table tbl_test_professor PURGE;

select *
from TBL_GRADE_RESULT;

update tbl_student set stdstateid = 1
		where stdid = 202277777;

commit;
select *
from TBL_SUBJECT;

select stdid, status, stdmajorid, dmajorid, minorid, stdstateid, scholarcode, gyowonid, stdname, stdemail, stdnameeng
				, stdnation, stdbirthday, entday, entstate, stdjumin, enttype, examnum, stdpostcode, stdaddress, stdmobile
				, schoolfrom1, graddate1, schoolfrom2, graddate2
                , completesemester
		from tbl_student
		where stdid = '202200001';



select stdid, status, majorid, dmajorid, minorid, stdstateid, scolarcode, gyowonid, stdname, stdemail, stdnameeng
				, stdnation, stdbirthday, entday, entstate, stdjumin, enttype, examnum, stdpostcode, stdaddress, stdmobile
				, schoolfrom1, graddate1, schoolfrom2, graddate2
		from tbl_student
		where stdid = #{userid} and stdpwd = #{pwd}


select gyowonid, status, gyoemail, gyomajorid, gyoname, gyonameeng, gyobirthday
				, gyojumin, gyonation, gyoaddress, gyopostcode, gyomobile, position, appointmentdt
				, workstatus, degree, career1, careerTime1, career2, careerTime2
		from tbl_gyowon
		where gyowonid = 10001


select *
from tbl_subject;

select userid, status
		from tbl_admin
		where userid = 'admin1'
        
---------------------------------------------------------------------------------------------
-- 강의평가 테스트 데이터 입력
insert into tbl_course(courseno, stdid, appsemester, evaluwhether, subjectid, majorid, gyowonid)
values(seq_courseno.nextval, 202200001, 1, 0, 11001, 11, 10001);

insert into tbl_course(courseno, stdid, appsemester, evaluwhether, subjectid, majorid, gyowonid)
values(seq_courseno.nextval, 202200001, 1, 0, 12001, 12, 10001);

insert into tbl_course(courseno, stdid, appsemester, evaluwhether, subjectid, majorid, gyowonid)
values(seq_courseno.nextval, 202200001, 1, 0, 11002, 11, 10001);

insert into tbl_course(courseno, stdid, appsemester, evaluwhether, subjectid, majorid, gyowonid)
values(seq_courseno.nextval, 202200001, 1, 1, 13001, 13, 10001);

insert into tbl_course(courseno, stdid, appsemester, evaluwhether, subjectid, majorid, gyowonid)
values(seq_courseno.nextval, 202200001, 2, 0, 11003, 11, 10001);

insert into tbl_course(courseno, stdid, appsemester, evaluwhether, subjectid, majorid, gyowonid)
values(seq_courseno.nextval, 202200001, 2, 0, 11006, 11, 10001);

---------------------

insert into tbl_course(courseno, stdid, appsemester, evaluwhether, subjectid, majorid, gyowonid)
values(seq_courseno.nextval, 202277777, 1, 0, 11001, 11, 10001);

insert into tbl_course(courseno, stdid, appsemester, evaluwhether, subjectid, majorid, gyowonid)
values(seq_courseno.nextval, 202277777, 1, 0, 12001, 12, 10001);

insert into tbl_course(courseno, stdid, appsemester, evaluwhether, subjectid, majorid, gyowonid)
values(seq_courseno.nextval, 202277777, 1, 0, 11002, 11, 10001);

insert into tbl_course(courseno, stdid, appsemester, evaluwhether, subjectid, majorid, gyowonid)
values(seq_courseno.nextval, 202277777, 1, 1, 13001, 13, 10001);

insert into tbl_course(courseno, stdid, appsemester, evaluwhether, subjectid, majorid, gyowonid)
values(seq_courseno.nextval, 202277777, 2, 0, 11003, 11, 10001);

insert into tbl_course(courseno, stdid, appsemester, evaluwhether, subjectid, majorid, gyowonid)
values(seq_courseno.nextval, 202277777, 2, 0, 11006, 11, 10001);

commit;

delete from tbl_course

commit;

select courseno
from tbl_course
where stdid = 202200001 and subjectid = 11012

select *
from tbl_course
order by stdid;

select  distinct appsemester
from tbl_course
where stdid = 202200001
order by appsemester desc;


select  distinct appsemester
		from tbl_course
		order by appsemester desc

select *
from tbl_subject;

select *
from tbl_gyowon;


select c.courseno, c.appsemester ,S.classname , C.subjectid, G.gyoname, C.evaluwhether
from tbl_course C JOIN tbl_subject S
ON C.subjectid = S.subjectid
JOIN tbl_gyowon G
ON S.gyowonid = G.gyowonid
where appsemester = 1 and stdid = 202200001
order by c.courseno;



------------------------------------------------------------------------------------
select *
from tab;

select *
from tbl_course;

select *
    from user_cons_columns
    where table_name = 'tbl_course';

update tbl_course set evaluwhether = 1
where courseno = 668

select *
from tbl_lecture_evalucomplete;
drop table TBL_LECTURE_EVALUATION purge;

select count(approve)
from TBL_LEAVE_SCHOOL
where stdid = '202200001' and approve = '승인전'


delete from tbl_course
where courseno = 14;
commit;

rollback;


-- 강의평가완료
ALTER TABLE tbl_lecture_evalucomplete
	DROP CONSTRAINT FK_course_TO_evalucomplete; -- 수강 -> 강의평가완료

-- 강의평가완료
ALTER TABLE tbl_lecture_evalucomplete
	DROP CONSTRAINT PK_tbl_lecture_evalucomplete; -- 강의평가완료 기본키

-- 강의평가완료
DROP TABLE tbl_lecture_evalucomplete;

-- 강의평가완료
CREATE TABLE tbl_lecture_evalucomplete (
	evalucode NUMBER        NOT NULL, -- 강의평가코드
	courseno  NUMBER        NOT NULL, -- 수강코드
	firstans  VARCHAR2(100) NULL,     -- 평가문항1답변
	secondans VARCHAR2(100) NULL,     -- 평가문항2답변
	thirdans  VARCHAR2(100) NULL,     -- 평가문항3답변
	fourans   VARCHAR2(100) NULL,     -- 평가문항4답변
	fiveans   VARCHAR2(100) NULL,     -- 평가문항5답변
	sixans    VARCHAR2(100) NULL,     -- 평가문항6답변
	sevenans  VARCHAR2(100) NULL,     -- 평가문항7답변
	eightans  VARCHAR2(100) NULL,     -- 평가문항8답변
	regaate   DATE          DEFAULT sysdate, -- 평가일자
	etcans    VARCHAR2(300) NULL,     -- 비고문항답변
	checktype VARCHAR2(100) NULL      -- 평가종류
);

-- 강의평가완료 기본키
CREATE UNIQUE INDEX PK_tbl_lecture_evalucomplete
	ON tbl_lecture_evalucomplete ( -- 강의평가완료
		evalucode ASC, -- 강의평가코드
		courseno  ASC  -- 수강코드
	);

-- 강의평가완료
ALTER TABLE tbl_lecture_evalucomplete
	ADD
		CONSTRAINT PK_tbl_lecture_evalucomplete -- 강의평가완료 기본키
		PRIMARY KEY (
			evalucode, -- 강의평가코드
			courseno   -- 수강코드
		);

-- 강의평가완료
ALTER TABLE tbl_lecture_evalucomplete
	ADD
		CONSTRAINT FK_course_TO_evalucomplete -- 수강 -> 강의평가완료
		FOREIGN KEY (
			courseno -- 수강코드
		)
		REFERENCES tbl_course ( -- 수강
			courseno -- 수강코드
		)
		ON DELETE cascade;
   
select  C.courseno, S.classname, G.gyoname
		from tbl_course C JOIN tbl_subject S
		ON C.subjectid = S.subjectid
		JOIN tbl_gyowon G
		ON S.gyowonid = G.gyowonid
		JOIN tbl_lecture_evalucomplete L
		on C.courseno = L.courseno
		where L.courseno = 650


insert into tbl_lecture_evalucomplete(evalucode, courseno)
values(seq_evalucode.nextval, 650)

commit;     


select L.evalucode, c.courseno, S.classname, G.gyoname
     , firstqs, secondqs, thirdqs, fourqs, fiveqs, sixqs, sevenqs, eightqs, etc
from tbl_course C JOIN tbl_subject S
ON C.subjectid = S.subjectid
JOIN tbl_gyowon G
ON S.gyowonid = G.gyowonid
JOIN tbl_lecture_evaluation L
on C.courseno = L.courseno
where l.courseno = 8;

----------------------------------------------------------------------------------
----------- 휴학 관련 sql문-------------------------------------
select *
from tab;

select *
from TBL_DAYOFWEEK;

-- 휴학
ALTER TABLE tbl_leave_school
	DROP CONSTRAINT FK_tbl_student_TO_tbl_leave_school; -- 학생 -> 휴학

-- 휴학
ALTER TABLE tbl_leave_school
	DROP CONSTRAINT PK_tbl_leave_school; -- 휴학 기본키

-- 휴학
DROP TABLE tbl_leave_school;

-- 휴학
CREATE TABLE tbl_leave_school (
	leaveno        NUMBER        NOT NULL, -- 휴학번호
	stdid          NUMBER        NULL,     -- 학번
	startsemester  VARCHAR2(100) NULL,     -- 시작학기
	endsemester    VARCHAR2(100) NULL,     -- 종료학기
	filename       VARCHAR2(255) NULL,     -- 파일이름
	orgfilename    VARCHAR2(255) NULL,     -- 진짜파일이름
	filesize       NUMBER        NULL,     -- 파일크기
	regdate        DATE             DEFAULT sysdate, -- 신청일자
	approve        VARCHAR2(100) NULL,     -- 신청결과
	noreason       VARCHAR2(300) NULL,     -- 반려이유
	returnsemester VARCHAR2(100) NULL,     -- 복학예정학기
	leavetype      VARCHAR2(100) NULL,     -- 휴학종류
	leavereason    VARCHAR2(300) NULL,     -- 휴학사유
	returnschool   NUMBER(1)     NULL,     -- 복학여부
	armytype       VARCHAR2(100) NULL,     -- 병종
	armystartdate  VARCHAR2(100) NULL,     -- 군시작일자
	armyenddate    VARCHAR2(100) NULL      -- 군종료일자
);

-- 휴학 기본키
CREATE UNIQUE INDEX PK_tbl_leave_school
	ON tbl_leave_school ( -- 휴학
		leaveno ASC -- 휴학번호
	);

-- 휴학
ALTER TABLE tbl_leave_school
	ADD
		CONSTRAINT PK_tbl_leave_school -- 휴학 기본키
		PRIMARY KEY (
			leaveno -- 휴학번호
		);

-- 휴학
ALTER TABLE tbl_leave_school
	ADD
		CONSTRAINT FK_student_TO_leave_school -- 학생 -> 휴학
		FOREIGN KEY (
			stdid -- 학번
		)
		REFERENCES tbl_student ( -- 학생
			stdid -- 학번
		)
		ON DELETE cascade;

-- 학생정보 가져오기
select stdid, stdname, d.deptname , statename, to_char(stdbirthday, 'yyyy-mm-dd') AS stdbirthday
     , stdmobile, stdemail, completesemester, stdpostcode, stdaddress
from tbl_student S JOIN tbl_stdstate STS
on S.stdstateid = sts.stdstateid
JOIN tbl_department D
on d.majorid = s.stdmajorid
where stdid = 202200001;

select stdid, stdstateid
from tbl_student

select *
from TBL_STDSTATE;

update tbl_student set stdstateid = 7
where stdid = 202200006;

update tbl_student set stdstateid = 7
where stdid = 202200007;

update tbl_student set stdstateid = 7
where stdid = 202200008;

update tbl_student set stdstateid = 7
where stdid = 202200009;

update tbl_student set stdstateid = 7
where stdid = 202200010;

commit;

select *
from TBL_LEAVE_SCHOOL;
drop table TBL_LEAVE_SCHOOL purge;

select leaveno, stdid, startsemester, endsemester, filename, orgfilename, filesize
     , to_char(regdate, 'yyyy-mm-dd') AS regdate, approve, noreason, returnsemester
     , leavetype, leavereason, returnschool, armytype, armystartdate, armyenddate
from TBL_LEAVE_SCHOOL
where stdid = '202200001'

update tbl_leave_school set approve = '승인완료'
where leaveno = 50

delete from TBL_LEAVE_SCHOOL
where leaveno = 49;

rollback;

commit;

select leaveno, stdid, startsemester , endsemester, filename, orgfilename, filesize
		     , to_char(regdate, 'yyyy-mm-dd') AS regdate, approve, noreason, returnsemester
		     , leavetype, leavereason, returnschool, armytype, armystartdate, armyenddate
		from TBL_LEAVE_SCHOOL
		where leaveno = 28


DROP TABLE tbl_leave_school purge;



-- 복학 파트 시작----------------------

select stdid, stdname, d.deptname , statename, to_char(stdbirthday, 'yyyy-mm-dd') AS stdbirthday
     , stdmobile, stdemail, completesemester, stdpostcode, stdaddress
from tbl_student S JOIN tbl_stdstate STS
on S.stdstateid = sts.stdstateid
JOIN tbl_department D
on d.majorid = s.stdmajorid
where stdid = 2022

insert into tbl_leave_school(leaveno, stdid, startsemester , endsemester
		     , approve, returnsemester, leavetype, leavereason)
values(seq_leaveno.nextval, 202277777, '2020 / 1학기', '2022 / 1학기'
     , '승인완료', '2022 / 2학기', '일반휴학', '코딩공부');

update tbl_leave_school set returnsemester = '2022 / 2학기'
where stdid = 202200001;

update tbl_return_school set approve = '승인전'
where stdid = 202200001;

commit;
 

select leaveno, stdid, startsemester, endsemester, filename, orgfilename, filesize
     , to_char(regdate, 'yyyy-mm-dd') AS regdate, approve, noreason, returnsemester
     , leavetype, leavereason, returnschool, armytype, armystartdate, armyenddate
from TBL_LEAVE_SCHOOL
where stdid = '202277777' and returnsemester = '2022 / 2학기';

update tbl_leave_school set approve = '승인완료'
where leaveno = 29

update tbl_return_school set regdate = sysdate;
commit;

delete from tbl_return_school


select count(approve)
from tbl_return_school
where stdid = 202200001 and approve = '승인전'

select *
from tbl_return_school;

select returnseq, returnsemester, to_char(regdate, 'yyyy-mm-dd') AS regdate, returntype, approve
from tbl_return_school
where stdid = 202277777 and returnsemester = '2022 / 2학기';


select returnseq, returnsemester, to_char(regdate, 'yyyy-mm-dd') AS regdate, returntype, approve, orgfilename, filename
from tbl_return_school

select filename, orgfilename, filesize
from tbl_return_school
where returnseq = #{returnseq}

----------------------------------------------------------------------------------------------
-- 장학 관련 ----------------------------------------------------------------------------------
select *
from tab;

select *
from TBL_SCHOLARSHIP;

-- 장학금지급내역
create sequence seq_scholarcode
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 장학금테이블시퀀스
create sequence seq_scholarcode2
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

drop sequence seq_scholarcode2

----------장학금 데이터 인서트---------------
delete from TBL_SCHOLARSHIP;

commit;

insert into TBL_SCHOLARSHIP(scholarcode, scholarshipnm, sortname, scholarshipamt)
values(seq_scholarcode2.nextval, '성적우수A', '성적우수장학', '2000000');

insert into TBL_SCHOLARSHIP(scholarcode, scholarshipnm, sortname, scholarshipamt)
values(seq_scholarcode2.nextval, '성적우수B', '성적우수장학', '1000000');

insert into TBL_SCHOLARSHIP(scholarcode, scholarshipnm, sortname, scholarshipamt)
values(seq_scholarcode2.nextval, '입학성적우수A', '입학성적우수장학', '2000000');

insert into TBL_SCHOLARSHIP(scholarcode, scholarshipnm, sortname, scholarshipamt)
values(seq_scholarcode2.nextval, '입학성적우수B', '입학성적우수장학', '1000000');

insert into TBL_SCHOLARSHIP(scholarcode, scholarshipnm, sortname, scholarshipamt)
values(seq_scholarcode2.nextval, '대외활동A', '대회활동장학', '1500000');

insert into TBL_SCHOLARSHIP(scholarcode, scholarshipnm, sortname, scholarshipamt)
values(seq_scholarcode2.nextval, '대외활동B', '대외활동장학', '750000');

insert into TBL_SCHOLARSHIP(scholarcode, scholarshipnm, sortname, scholarshipamt)
values(seq_scholarcode2.nextval, '보훈', '국가보훈장학', '2000000');

commit;
-------------------------

drop table TBL_SCHOLARSHIPPAY purge;

-- 장학금지급내역
ALTER TABLE tbl_scholarshippay
	DROP CONSTRAINT FK_tbl_student_TO_tbl_scholarshippay; -- 학생 -> 장학금지급내역

-- 장학금지급내역
ALTER TABLE tbl_scholarshippay
	DROP CONSTRAINT FK_tbl_scholarship_TO_tbl_scholarshippay; -- 장학금 -> 장학금지급내역

-- 장학금지급내역
ALTER TABLE tbl_scholarshippay
	DROP CONSTRAINT PK_tbl_scholarshippay; -- 장학금지급내역 기본키

-- 장학금지급내역
DROP TABLE tbl_scholarshippay;

-- 장학금지급내역
CREATE TABLE tbl_scholarshippay (
	scholarpaycode NUMBER        NOT NULL, -- 장학지급코드
	stdid          NUMBER        NULL,     -- 학번
	scholarcode    NUMBER        NULL,     -- 장학코드
	paydate        DATE          DEFAULT sysdate, -- 지급날짜
	paysemester    VARCHAR2(100) NULL      -- 지급학기
);

-- 장학금지급내역 기본키
CREATE UNIQUE INDEX PK_tbl_scholarshippay
	ON tbl_scholarshippay ( -- 장학금지급내역
		scholarpaycode ASC -- 장학지급코드
	);

-- 장학금지급내역
ALTER TABLE tbl_scholarshippay
	ADD
		CONSTRAINT PK_tbl_scholarshippay -- 장학금지급내역 기본키
		PRIMARY KEY (
			scholarpaycode -- 장학지급코드
		);

-- 장학금지급내역
ALTER TABLE tbl_scholarshippay
	ADD
		CONSTRAINT FK_student_TO_scholarshippay -- 학생 -> 장학금지급내역
		FOREIGN KEY (
			stdid -- 학번
		)
		REFERENCES tbl_student ( -- 학생
			stdid -- 학번
		)

-- 장학금지급내역
ALTER TABLE tbl_scholarshippay
	ADD
		CONSTRAINT FK_scholarship_scholarshippay -- 장학금 -> 장학금지급내역
		FOREIGN KEY (
			scholarcode -- 장학코드
		)
		REFERENCES tbl_scholarship ( -- 장학금
			scholarcode -- 장학코드
		)


select *
from TBL_SCHOLARSHIPPAY;

----------------------------------------------------------------
--장학지급 테이블 테스트 데이터 인서트-----------
insert into TBL_SCHOLARSHIPPAY(scholarpaycode, stdid, scholarcode, paydate, paysemester)
values(seq_scholarcode.nextval, 202200001, 3, sysdate, '2022 / 1학기');

insert into TBL_SCHOLARSHIPPAY(scholarpaycode, stdid, scholarcode, paydate, paysemester)
values(seq_scholarcode.nextval, 202200001, 4, sysdate, '2022 / 1학기');

insert into TBL_SCHOLARSHIPPAY(scholarpaycode, stdid, scholarcode, paydate, paysemester)
values(seq_scholarcode.nextval, 202200001, 1, sysdate, '2022 / 2학기');

insert into TBL_SCHOLARSHIPPAY(scholarpaycode, stdid, scholarcode, paydate, paysemester)
values(seq_scholarcode.nextval, 202200001, 5, sysdate, '2022 / 2학기');

insert into TBL_SCHOLARSHIPPAY(scholarpaycode, stdid, scholarcode, paydate, paysemester)
values(seq_scholarcode.nextval, 202200001, 2, sysdate, '2023 / 1학기');

insert into TBL_SCHOLARSHIPPAY(scholarpaycode, stdid, scholarcode, paydate, paysemester)
values(seq_scholarcode.nextval, 202200001, 6, sysdate, '2023 / 1학기');

insert into TBL_SCHOLARSHIPPAY(scholarpaycode, stdid, scholarcode, paydate, paysemester)
values(seq_scholarcode.nextval, 202200001, 7, sysdate, '2023 / 2학기');

insert into TBL_SCHOLARSHIPPAY(scholarpaycode, stdid, scholarcode, paydate, paysemester)
values(seq_scholarcode.nextval, 202200001, 1, sysdate, '2023 / 2학기');

commit;


select scholarpaycode, SP.scholarcode, stdid, paysemester, to_char(paydate, 'yyyy-mm-dd')
     , sortname, scholarshipnm, scholarshipamt
from TBL_SCHOLARSHIPPAY SP join tbl_scholarship SS
on SP.scholarcode = SS.scholarcode
where stdid = 202277777
order by sp.paysemester



---------------------------------
-- 테스트인서트VO

create table tbl_test_insert
(
    courseno       NUMBER        NOT NULL, 
	content    VARCHAR2(100) NULL      
)

CREATE UNIQUE INDEX PK_tbl_test_insert
	ON tbl_test_insert ( 
		courseno ASC
	);


ALTER TABLE tbl_test_insert
	ADD
		CONSTRAINT PK_tbl_test_insert
		PRIMARY KEY (
			courseno 
		);
        
        
create sequence seq_test_insert
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from tbl_test_insert


----------------------------------------------------------------------------------------------
-- 학생성적확인 관련 ----------------------------------------------------------------------------------
select *
from tab;

select *
from TBL_course
where stdid = 202200001

delete from TBL_course
where courseno = 14;

delete from tbl_attendance
where courseno = 14;


commit;

select *
from tbl_grade_result;

-- 해당 학생이 이수한 학기 조회
select distinct(appsemester)
from tbl_course
where stdid = 202200001
order by appsemester desc;

-- 학생이 이수한 학기별 수강한 과목에 대한 성적정보 조회
select c.courseno, s.classname, c.appsemester
     , s.credit, s.courseclfc, nvl(g.grade, '미입력') AS grade, c.evaluwhether
from tbl_course C left join tbl_grade_result G
on C.courseno = G.courseno
join tbl_subject S
on C.subjectid = S.subjectid
where stdid = 202277777 and appsemester = 1


