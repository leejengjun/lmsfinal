show user;
--USER이(가) "FINALORAUSER3"입니다.
select *
from spring_test;


------------------------------------
--휴학 복학 학생 테이블 조인--
------------------------------------


-- 복학
CREATE TABLE tbl_return_school (
	returnseq      NUMBER        NOT NULL, -- 복학번호
	stdid          NUMBER        NULL,     -- 학번
	returnsemester VARCHAR2(100) NULL,     -- 복학학기
	returntype     VARCHAR2(100) NULL,     -- 복학종류
	regdate        DATE          NULL,     -- 신청일자
	approvedate    DATE          NULL,     -- 승인일자
	approve        VARCHAR2(100) NULL,     -- 승인여부
	filename       VARCHAR2(255) NULL,     -- 파일이름
	orgfilename    VARCHAR2(255) NULL,     -- 진짜파일이름
	filesize       NUMBER        NULL      -- 파일크기
);

returnseq,stdid,returnsemester,returntype,regdate,approvedate
,approve,filename,orgfilename,filesize 

--휴학
CREATE TABLE tbl_leave_school (
	leaveno        NUMBER        NOT NULL, -- 휴학번호
	stdid          NUMBER        NULL,     -- 학번
	startsemester  VARCHAR2(100) NULL,     -- 시작학기
	endsemester    VARCHAR2(100) NULL,     -- 종료학기
	filename       VARCHAR2(255) NULL,     -- 파일이름
	orgfilename    VARCHAR2(255) NULL,     -- 진짜파일이름
	filesize       NUMBER        NULL,     -- 파일크기
	regdate        DATE          DEFAULT sysdate, -- 신청일자
	approve        VARCHAR2(100) NULL,     -- 신청결과
	noreason       VARCHAR2(300) NULL,     -- 반려이유
	returnsemester VARCHAR2(100) NULL,     -- 복학예정학기
	leavetype      VARCHAR2(100) NULL,     -- 휴학종류
	leavereason    VARCHAR2(300) NULL,     -- 휴학사유
	returnschool   NUMBER(1)     NULL,     -- 복학여부
	armytype       VARCHAR2(100) NULL,     -- 병종
	armystartdate  VARCHAR2(100)          NULL,     -- 군시작일자
	armyenddate    VARCHAR2(100)        NULL      -- 군종료일자
);

leaveno, stdid,startsemester,endsemester,filename,orgfilename,filesize,regdate,approve,noreason,returnsemester
 ,leavetype,leavereason,returnschool,armytype,armystartdate,armyenddate 
 
 
-- 학생
CREATE TABLE tbl_student (
	stdid       NUMBER        NOT NULL, -- 학번
	stdmajorid  NUMBER        NULL,     -- 학과코드
	dmajorid    NUMBER        NULL,     -- 복수전공코드
	minorid     NUMBER        NULL,     -- 부전공코드
	stdstateid  NUMBER        NULL,     -- 학적상태코드  (1: 제학중)
	scholarcode NUMBER        NULL,     -- 장학코드
	gyowonid    NUMBER        NULL,     -- 교원번호
	stdpwd      VARCHAR2(100) NOT NULL, -- 비밀번호
	stdname     VARCHAR2(100) NOT NULL, -- 이름(한글)
	stdemail    VARCHAR2(100) NOT NULL, -- 이메일
	status      NUMBER(1)     DEFAULT 1, -- 계정상태
	stdnameeng  VARCHAR2(100) NULL,     -- 학생이름(영문)
	stdnation   VARCHAR2(100) NULL,     -- 국적
	stdbirthday DATE          NULL,     -- 생년월일
	entday      DATE          NULL,     -- 입학일자
	entstate    VARCHAR2(100) NULL,     -- 입학구분
	stdjumin    VARCHAR2(100) NULL,     -- 주민등록번호
	enttype     VARCHAR2(100) NULL,     -- 입학전형
	examnum     VARCHAR2(100) NULL,     -- 수험번호
	stdpostcode VARCHAR2(100) NULL,     -- 우편번호
	stdaddress  VARCHAR2(100) NULL,     -- 주소
	stdmobile   VARCHAR2(100) NULL,     -- 연락처
	schoolfrom1 VARCHAR2(100) NULL,     -- 출신학교1
	graddate1   DATE          NULL,     -- 출신학교졸업년도1
	schoolfrom2 VARCHAR2(100) NULL,     -- 출신학교2
	graddate2   DATE          NULL      -- 출신학교졸업년도2
);
stdid, stdmajorid, dmajorid,stdstateid ,scholarcode,
            gyowonid,stdpwd,stdname,stdemail,status,stdnameeng,stdnation,stdbirthday,entday
            ,entstate,stdjumin,enttype,examnum,stdpostcode
            ,stdaddress,stdmobile,schoolfrom1,graddate1,schoolfrom2, graddate2  AS Student 
            
       
 -----강의 조회 3개 테이블 조인--
select S.stdname, S.stdid, S.stdmajorid, S.stdstateid, L.approve, R.approve
from tbl_student  S 
JOIN tbl_leave_school  L 
ON S.stdid = L.stdid
JOIN tbl_return_school R
ON S.stdid = R.stdid


select *
from tbl_leave_school

select *
from tbl_student

  -----강의 조회 3개 테이블 조인--
select S.stdid, L.approve, R.approve
from tbl_student  S 
JOIN tbl_leave_school  L 
ON S.stdid = L.stdid
JOIN tbl_return_school R
ON S.stdid = R.stdid   
       

 update tbl_student set stdstateid = 2
 where stdid = 202211111
     
 commit;
     
update tbl_leave_school set approve = '승인전'
where stdid = 202211111  

select *
from tbl_student
     
update tbl_leave_school set approve = '승인완료'
where stdid = 학번 and approve='승인전' 

--휴학신청 2개 조인 결과        
select S.stdname, S.stdid, S.stdmajorid, S.stdstateid, L.approve
from tbl_student  S 
JOIN tbl_leave_school  L 
ON S.stdid = L.stdid

select *
from tbl_return_school

select S.stdname, S.stdid, S.stdmajorid, S.stdstateid, R.approve
from tbl_student  S 
JOIN tbl_return_school R
ON S.stdid = R.stdid
-------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------
-- 학적상태
CREATE TABLE tbl_stdstate (
	stdstateid NUMBER        NOT NULL, -- 학적상태코드
	statename  VARCHAR2(100) NULL      -- 상태명
);

insert into tbl_stdstate(stdstateid, statename) values(6 ,'휴학신청');
insert into tbl_stdstate(stdstateid, statename) values(7 ,'복학신청');
insert into tbl_stdstate(stdstateid, statename) values(8 ,'신청반려');
commit;

-- 학적상태 기본키
CREATE UNIQUE INDEX PK_tbl_stdstate
	ON tbl_stdstate ( -- 학적상태
		stdstateid ASC -- 학적상태코드
	);

-- 학적상태
ALTER TABLE tbl_stdstate
	ADD
		CONSTRAINT PK_tbl_stdstate -- 학적상태 기본키
		PRIMARY KEY (
			stdstateid -- 학적상태코드
		);
        
 select *
from tbl_stdstate;
 
 

        
 -- 관리자
CREATE TABLE tbl_admin (
	userid VARCHAR2(100) NOT NULL, -- 아이디
	pwd    VARCHAR2(100) NULL,     -- 비밀번호
	status NUMBER(1)     NULL      -- 계정상태
);
insert into tbl_admin(userid, pwd, status) values('admin','qwer1234$','1');
commit;

select *
from tbl_admin;

-- 관리자 기본키
CREATE UNIQUE INDEX PK_tbl_admin
	ON tbl_admin ( -- 관리자
		userid ASC -- 아이디
	);

-- 관리자
ALTER TABLE tbl_admin
	ADD
		CONSTRAINT PK_tbl_admin -- 관리자 기본키
		PRIMARY KEY (
			userid -- 아이디
		);
        
            
 select *
from tbl_return_school;   
-- 복학
CREATE TABLE tbl_return_school (
	returnseq      NUMBER        NOT NULL, -- 복학번호
	stdid          NUMBER        NULL,     -- 학번
	returnsemester VARCHAR2(100) NULL,     -- 복학학기
	returntype     VARCHAR2(100) NULL,     -- 복학종류
	regdate        DATE          NULL,     -- 신청일자
	approvedate    DATE          NULL,     -- 승인일자
	approve        VARCHAR2(100) NULL,     -- 승인여부
	filename       VARCHAR2(255) NULL,     -- 파일이름
	orgfilename    VARCHAR2(255) NULL,     -- 진짜파일이름
	filesize       NUMBER        NULL      -- 파일크기
);

-- 복학 기본키
CREATE UNIQUE INDEX PK_tbl_return_school
	ON tbl_return_school ( -- 복학
		returnseq ASC -- 복학번호
	);

-- 복학
ALTER TABLE tbl_return_school
	ADD
		CONSTRAINT PK_tbl_return_school -- 복학 기본키
		PRIMARY KEY (
			returnseq -- 복학번호
		);

-- 휴학
CREATE TABLE tbl_leave_school (
	leaveno        NUMBER        NOT NULL, -- 휴학번호
	stdid          NUMBER        NULL,     -- 학번
	startsemester  VARCHAR2(100) NULL,     -- 시작학기
	endsemester    VARCHAR2(100) NULL,     -- 종료학기
	filename       VARCHAR2(255) NULL,     -- 파일이름
	orgfilename    VARCHAR2(255) NULL,     -- 진짜파일이름
	filesize       NUMBER        NULL,     -- 파일크기
	regdate        DATE          DEFAULT sysdate, -- 신청일자
	approve        VARCHAR2(100) NULL,     -- 신청결과
	noreason       VARCHAR2(300) NULL,     -- 반려이유
	returnsemester VARCHAR2(100) NULL,     -- 복학예정학기
	leavetype      VARCHAR2(100) NULL,     -- 휴학종류
	leavereason    VARCHAR2(300) NULL,     -- 휴학사유
	returnschool   NUMBER(1)     NULL,     -- 복학여부
	armytype       VARCHAR2(100) NULL,     -- 병종
	armystartdate  DATE          NULL,     -- 군시작일자
	armyenddate    DATE          NULL      -- 군종료일자
);
select *
from tbl_leave_school;


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

-- 장학금
CREATE TABLE tbl_scholarship (
	scholarcode    NUMBER        NOT NULL, -- 장학코드
	scholarshipnm  VARCHAR2(100) NULL,     -- 장학명
	sortname       VARCHAR2(100) NULL,     -- 분류명
	scholarshipamt VARCHAR2(100) NULL      -- 장학금액
);

-- 장학금 기본키
CREATE UNIQUE INDEX PK_tbl_scholarship
	ON tbl_scholarship ( -- 장학금
		scholarcode ASC -- 장학코드
	);

-- 장학금
ALTER TABLE tbl_scholarship
	ADD
		CONSTRAINT PK_tbl_scholarship -- 장학금 기본키
		PRIMARY KEY (
			scholarcode -- 장학코드
		);
        
        
-- 건물
CREATE TABLE tbl_building (
	buildno   NUMBER       NOT NULL, -- 건물번호
	buildname VARCHAR2(20) NULL      -- 건물명
);

-- 건물 기본키
CREATE UNIQUE INDEX PK_tbl_building
	ON tbl_building ( -- 건물
		buildno ASC -- 건물번호
	);

-- 건물
ALTER TABLE tbl_building
	ADD
		CONSTRAINT PK_tbl_building -- 건물 기본키
		PRIMARY KEY (
			buildno -- 건물번호
		);



-- 강의
CREATE TABLE tbl_subject (
	subjectid    NUMBER        NOT NULL, -- 강의코드
	majorid      NUMBER        NOT NULL, -- 학과코드
	gyowonid     NUMBER        NOT NULL, -- 교원번호
	classname    VARCHAR2(100) NULL,     -- 강의명
	credit       NUMBER(2)     NULL,     -- 학점
	opensemester NUMBER(2)     NULL,     -- 개설학기
	courseclfc   VARCHAR2(100) NULL,     -- 이수구분
	applyperson  NUMBER        NULL,     -- 수강신청인원
	totalperson  NUMBER        NULL,     -- 정원
	applydate    DATE          NULL,     -- 신청일자
	applystate   VARCHAR2(100) NULL,     -- 신청상태
	lctrid       NUMBER        NULL,     -- 강의실번호
	periodid     NUMBER        NULL,     -- 교시코드
	dayid        NUMBER        NULL      -- 요일코드
);

select *
from tbl_department


select majorid, deptname 
		from tbl_department
		--<if test='searchType == "" or searchWord == ""'>
		where majorid > 0
		--</if>
		--<if test='searchType != "" and searchWord != ""'>
		--where lower(${searchType}) like '%'||lower(#{searchWord})||'%'
		--</if>
		order by majorid asc
        
        
        
--학과코드랑 학과이름 같이 보이게 조인한것        
select S.stdname, S.stdid, S.stdmajorid, D.majorid, D.deptname, S.stdstateid 
        from tbl_student  S 
        JOIN tbl_department D 
        ON S.stdmajorid = D.majorid      
where status = 2        

--  

    select S.stdname, S.stdid, S.stdmajorid, D.majorid, D.deptname, S.stdstateid 
			from
			(select rownum AS rno
	         ,S.stdname, S.stdid, S.stdmajorid, D.majorid, D.deptname, S.stdstateid 
             from tbl_student  S 
             JOIN tbl_department D 
             ON S.stdmajorid = D.majorid      
		) V
        where rno between '1'  and '5';
   
----            
       select  stdname, stdid, stdmajorid, stdstateid
			from
			(select rownum AS rno, 
	          stdname, stdid, stdmajorid, stdstateid
	   from tbl_student
	   where status = 2  
		) V
        where rno between '1'  and '5';
             
     
     
        
-- 강의 기본키
CREATE UNIQUE INDEX PK_tbl_subject
	ON tbl_subject ( -- 강의
		subjectid ASC, -- 강의코드
		majorid   ASC, -- 학과코드
		gyowonid  ASC  -- 교원번호
	);

-- 강의
ALTER TABLE tbl_subject
	ADD
		CONSTRAINT PK_tbl_subject -- 강의 기본키
		PRIMARY KEY (
			subjectid, -- 강의코드
			majorid,   -- 학과코드
			gyowonid   -- 교원번호
		);



-- 요일
CREATE TABLE tbl_dayofweek (
	dayid   NUMBER        NOT NULL, -- 요일코드
	dayname VARCHAR2(100) NULL,     -- 요일이름
	abvat   VARCHAR2(100) NULL      -- 약어
);

-- DAY_OF_THE_WEEK_PK
CREATE UNIQUE INDEX DAY_OF_THE_WEEK_PK
	ON tbl_dayofweek ( -- 요일
		dayid ASC -- 요일코드
	);



-- 요일
ALTER TABLE tbl_dayofweek
	ADD
		CONSTRAINT table2_PK -- 요일의 식별 그룹
		PRIMARY KEY (
			dayid -- 요일코드
		);

-- 교원
CREATE TABLE tbl_gyowon (
	gyowonid      NUMBER        NOT NULL, -- 교원번호
	gyopwd        VARCHAR2(100) NOT NULL, -- 비밀번호
	gyoemail      VARCHAR2(100) NOT NULL, -- 이메일
	gyomajorid    NUMBER        NULL,     -- 학과코드
	gyoname       VARCHAR2(100) NULL,     -- 교원이름
	gyonameeng    VARCHAR2(100) NULL,     -- 교원이름(영문)
	gyobirthday   DATE          NULL,     -- 생년월일
	gyojumin      VARCHAR2(100) NULL,     -- 주민번호
	gyonation     VARCHAR2(100) NULL,     -- 국적
	gyoaddress    VARCHAR2(100) NULL,     -- 주소
	gyopostcode   VARCHAR2(100) NULL,     -- 우편번호
	gyomobile     VARCHAR2(100) NULL,     -- 연락처
	position      VARCHAR2(100) NULL,     -- 직위
	appointmentdt DATE          NULL,     -- 임용일자
	workstatus    NUMBER        NULL,     -- 근로상태코드
	degree        VARCHAR2(100) NULL,     -- 최종학력
	career1       VARCHAR2(100) NULL,     -- 경력학교1
	careerTime1   VARCHAR2(100) NULL,     -- 경력기간1
	career2       VARCHAR2(100) NULL,     -- 경력학교2
	careerTime2   VARCHAR2(100) NULL,     -- 경력기간2
	status        NUMBER(1)     DEFAULT 1 -- 계정상태
);
insert into tbl_gyowon(gyowonid, gyopwd, gyoname, gyoemail, position, gyomajorid) values('999901001','19680123', '김교수', 'kgs@abc.efg','학과장','01');                          ----------------------
commit;
delete from tbl_gyowon where gyowonid = '999901001';

select *
from tbl_gyowon ;


 select count(*)
			 from tbl_gyowon
			 where status = 3    
             

-- FACULTY_PK
CREATE UNIQUE INDEX FACULTY_PK
	ON tbl_gyowon ( -- 교원
		gyowonid ASC -- 교원번호
	);

-- 교원 유니크 인덱스
CREATE UNIQUE INDEX UIX_tbl_gyowon
	ON tbl_gyowon ( -- 교원
		gyoemail ASC -- 이메일
	);

-- 교원
ALTER TABLE tbl_gyowon
	ADD
		CONSTRAINT EMP_PK -- 교원의 식별 그룹
		PRIMARY KEY (
			gyowonid -- 교원번호
		);

-- 교원
ALTER TABLE tbl_gyowon
	ADD
		CONSTRAINT UK_tbl_gyowon -- 교원 유니크 제약
		UNIQUE (
			gyoemail -- 이메일
		);

-- 교원
ALTER TABLE tbl_gyowon
	ADD
		CONSTRAINT CK_tbl_gyowon -- 근로상태코드 체크 제약
		CHECK (workstatus in (0,1));

-- 학과
CREATE TABLE tbl_department (
	majorid  NUMBER        NOT NULL, -- 학과코드                                                                          
	deptname VARCHAR2(100) NULL      -- 학과이름
);

insert into tbl_student(stdid, stdpwd, stdname, stdemail, stdmajorid, stdstateid)
select deptname
from tbl_department;

select *
from tbl_department;


-- DEPARTMENT_PK
CREATE UNIQUE INDEX DEPARTMENT_PK
	ON tbl_department ( -- 학과
		majorid ASC -- 학과코드
	);
insert into tbl_department(majorid , deptname) values('01','컴퓨터공학과');                                                               ----------------------------------------------------
commit;
delete from tbl_department where majorid = '01';


select *
from tbl_department;

-- 학과
ALTER TABLE tbl_department
	ADD
		CONSTRAINT table3_PK -- 학과의 식별 그룹
		PRIMARY KEY (
			majorid -- 학과코드
		);

-- 교시
CREATE TABLE tbl_period (
	periodid  NUMBER NOT NULL, -- 교시코드
	starttime DATE   NULL,     -- 시작시간
	endtime   DATE   NULL      -- 종료시간
);

-- PERIOD_PK
CREATE UNIQUE INDEX PERIOD_PK
	ON tbl_period ( -- 교시
		periodid ASC -- 교시코드
	);

-- 교시
ALTER TABLE tbl_period
	ADD
		CONSTRAINT PERIOD_PK -- 교시의 식별 그룹
		PRIMARY KEY (
			periodid -- 교시코드
		);

-- 강의실
CREATE TABLE tbl_lecture_room (
	lctrid   NUMBER NOT NULL, -- 강의실번호
	periodid NUMBER NOT NULL, -- 교시코드
	dayid    NUMBER NOT NULL, -- 요일코드
	buildno  NUMBER NULL      -- 건물번호
);

-- LECTURE_ROOM_ASSIGN_PK
CREATE UNIQUE INDEX LECTURE_ROOM_ASSIGN_PK
	ON tbl_lecture_room ( -- 강의실
		lctrid   ASC, -- 강의실번호
		periodid ASC, -- 교시코드
		dayid    ASC  -- 요일코드
	);

-- 강의실
ALTER TABLE tbl_lecture_room
	ADD
		CONSTRAINT LECTURE_ROOM_ASSIGN_PK -- 강의실배정의 식별 그룹
		PRIMARY KEY (
			lctrid,   -- 강의실번호
			periodid, -- 교시코드
			dayid     -- 요일코드
		);

-- 학생
CREATE TABLE tbl_student (
	stdid       NUMBER        NOT NULL, -- 학번
	stdmajorid  NUMBER        NULL,     -- 학과코드
	dmajorid    NUMBER        NULL,     -- 복수전공코드
	minorid     NUMBER        NULL,     -- 부전공코드
	stdstateid  NUMBER        NULL,     -- 학적상태코드  (1: 제학중)
	scholarcode NUMBER        NULL,     -- 장학코드
	gyowonid    NUMBER        NULL,     -- 교원번호
	stdpwd      VARCHAR2(100) NOT NULL, -- 비밀번호
	stdname     VARCHAR2(100) NOT NULL, -- 이름(한글)
	stdemail    VARCHAR2(100) NOT NULL, -- 이메일
	status      NUMBER(1)     DEFAULT 1, -- 계정상태
	stdnameeng  VARCHAR2(100) NULL,     -- 학생이름(영문)
	stdnation   VARCHAR2(100) NULL,     -- 국적
	stdbirthday DATE          NULL,     -- 생년월일
	entday      DATE          NULL,     -- 입학일자
	entstate    VARCHAR2(100) NULL,     -- 입학구분
	stdjumin    VARCHAR2(100) NULL,     -- 주민등록번호
	enttype     VARCHAR2(100) NULL,     -- 입학전형
	examnum     VARCHAR2(100) NULL,     -- 수험번호
	stdpostcode VARCHAR2(100) NULL,     -- 우편번호
	stdaddress  VARCHAR2(100) NULL,     -- 주소
	stdmobile   VARCHAR2(100) NULL,     -- 연락처
	schoolfrom1 VARCHAR2(100) NULL,     -- 출신학교1
	graddate1   DATE          NULL,     -- 출신학교졸업년도1
	schoolfrom2 VARCHAR2(100) NULL,     -- 출신학교2
	graddate2   DATE          NULL      -- 출신학교졸업년도2
);

select *
from tbl_student;
insert into tbl_student(stdid, stdpwd, stdname, stdemail, stdmajorid, stdstateid) values('202211118','19930104','테스트2','test2@abc.efg', '11','2' );
commit;

update tbl_student set stdstateid = (select stdstateid from tbl_student where stdstateid = 2)
where stdid = '202200001';

update tbl_student set stdstateid = 1 where(stdstateid is null);

commit;

rollback;

 update tbl_student set stdstateid = 6
		where stdid = 202211111;
        
        
        

-- 학생 1명
  select  stdid, stdmajorid, dmajorid, stdstateid, gyowonid, stdpwd, stdname, stdemail, status, stdnameeng, stdnation
		       , stdbirthday , entday, entstate ,stdjumin, enttype, examnum, stdpostcode, stdaddress, stdmobile
		       , schoolfrom1, graddate1 , schoolfrom2, graddate2
		    from tbl_student
		    where stdname = '나쌍용'
		    <if test='searchType_1 != "" and searchWord_1 != "" '>
		    and lower(${searchType_1}) like '%' || lower(#{searchWord_1}) || '%'
		    </if>


--- 학생회원조회 시작 
 select  stdname, stdid, stdmajorid, stdstateid
	   from
  	   (
	   select
	          stdname, stdid, stdmajorid, stdstateid
	   from tbl_student
	   where status = 2  
	   <if test='searchType_1 != "" and searchWord_1 != ""'>
	   and lower(${searchType_1}) like '%' || lower(#{searchWord_1}) || '%'  
	   </if>
	   ) V
       
--- 학생회원조회 끝      
       
       
select count(*) from tbl_student
where stdid = 202200002;

select *
from tbl_student
where stdid = 202200002;

  select * from tbl_student full outer join Btable on Atable.aidx = Btable.bidx;                        
                          
-- STD_PK
CREATE UNIQUE INDEX STD_PK
	ON tbl_student ( -- 학생
		stdid ASC -- 학번
	);

-- 학생 유니크 인덱스
CREATE UNIQUE INDEX UIX_tbl_student
	ON tbl_student ( -- 학생
		stdemail ASC -- 이메일
	);

-- 학생
ALTER TABLE tbl_student
	ADD
		CONSTRAINT STUDENT_PK -- 학생의 식별 그룹
		PRIMARY KEY (
			stdid -- 학번
		);
        
        
  -- 학생회원전체조회 --     
  select  stdname, stdid, stdmajorid, stdstateid
			from
			(select rownum AS rno, 
	          stdname, stdid, stdmajorid, stdstateid
	   from tbl_student
	   where status = 2  
		) V
        where rno between '1'  and '10';
        
        
        
-- 학생
ALTER TABLE tbl_student
	ADD
		CONSTRAINT UK_tbl_student -- 학생 유니크 제약
		UNIQUE (
			stdemail -- 이메일
		);

-- 수강
CREATE TABLE tbl_course (
	courseno     NUMBER    NOT NULL, -- 수강코드
	stdid        NUMBER    NULL,     -- 학번
	appsemester  NUMBER(2) NULL,     -- 신청학기
	evaluwhether NUMBER(1) NULL,     -- 강의평가여부
	subjectid    NUMBER    NULL,     -- 강의코드
	majorid      NUMBER    NULL,     -- 학과코드
	gyowonid     NUMBER    NULL      -- 교원번호
);

-- COURSE_APP_PK
CREATE UNIQUE INDEX COURSE_APP_PK
	ON tbl_course ( -- 수강
		courseno ASC -- 수강코드
	);

-- 수강
ALTER TABLE tbl_course
	ADD
		CONSTRAINT table3_PK1 -- 수강신청의 식별 그룹
		PRIMARY KEY (
			courseno -- 수강코드
		);
-- 복학
ALTER TABLE tbl_return_school
	ADD
		CONSTRAINT FK_student_TO_return_school -- 학생 -> 복학
		FOREIGN KEY (
			stdid -- 학번
		)
		REFERENCES tbl_student ( -- 학생
			stdid -- 학번
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
		);
        
        
-- 강의
ALTER TABLE tbl_subject
	ADD
		CONSTRAINT FK_lec_room_TO_tbl_subject -- 강의실 -> 강의
		FOREIGN KEY (
			lctrid,   -- 강의실번호
			periodid, -- 교시코드
			dayid     -- 요일코드
		)
		REFERENCES tbl_lecture_room ( -- 강의실
			lctrid,   -- 강의실번호
			periodid, -- 교시코드
			dayid     -- 요일코드
		);

-- 강의
ALTER TABLE tbl_subject
	ADD
		CONSTRAINT FK_dep_TO_subject -- 학과 -> 강의
		FOREIGN KEY (
			majorid -- 학과코드
		)
		REFERENCES tbl_department ( -- 학과
			majorid -- 학과코드
		);

-- 강의
ALTER TABLE tbl_subject
	ADD
		CONSTRAINT FK_gyowon_TO_subject -- 교원 -> 강의
		FOREIGN KEY (
			gyowonid -- 교원번호
		)
		REFERENCES tbl_gyowon ( -- 교원
			gyowonid -- 교원번호
		);

select *
from tbl_subject;

-- 교원
ALTER TABLE tbl_gyowon
	ADD
		CONSTRAINT FK_department_TO_gyowon -- 학과 -> 교원
		FOREIGN KEY (
			gyomajorid -- 학과코드
		)
		REFERENCES tbl_department ( -- 학과
			majorid -- 학과코드
		);

-- 강의실
ALTER TABLE tbl_lecture_room
	ADD
		CONSTRAINT PERIOD_TO_LEC_ROOM_ASSIGN_FK -- 교시 -> 강의실배정1
		FOREIGN KEY (
			periodid -- 교시코드
		)
		REFERENCES tbl_period ( -- 교시
			periodid -- 교시코드
		);

-- 강의실
ALTER TABLE tbl_lecture_room
	ADD
		CONSTRAINT DAY_WEEK_TO_LEC_ROOM_ASSIGN_FK -- 요일 -> 강의실배정
		FOREIGN KEY (
			dayid -- 요일코드
		)
		REFERENCES tbl_dayofweek ( -- 요일
			dayid -- 요일코드
		);

-- 강의실
ALTER TABLE tbl_lecture_room
	ADD
		CONSTRAINT FK_building_TO_lecture_room -- 건물 -> 강의실
		FOREIGN KEY (
			buildno -- 건물번호
		)
		REFERENCES tbl_building ( -- 건물
			buildno -- 건물번호
		);

-- 학생
ALTER TABLE tbl_student
	ADD
		CONSTRAINT FK_department_TO_student -- 학과 -> 학생
		FOREIGN KEY (
			stdmajorid -- 학과코드
		)
		REFERENCES tbl_department ( -- 학과
			majorid -- 학과코드
		);

-- 학생
ALTER TABLE tbl_student
	ADD
		CONSTRAINT FK_stdstate_TO_student -- 학적상태 -> 학생
		FOREIGN KEY (
			stdstateid -- 학적상태코드
		)
		REFERENCES tbl_stdstate ( -- 학적상태
			stdstateid -- 학적상태코드
		);

-- 학생
ALTER TABLE tbl_student
	ADD
		CONSTRAINT FK_department_TO_student2 -- 학과 -> 학생2
		FOREIGN KEY (
			dmajorid -- 복수전공코드
		)
		REFERENCES tbl_department ( -- 학과
			majorid -- 학과코드
		);

-- 학생
ALTER TABLE tbl_student
	ADD
		CONSTRAINT FK_department_TO_student3 -- 학과 -> 학생3
		FOREIGN KEY (
			minorid -- 부전공코드
		)
		REFERENCES tbl_department ( -- 학과
			majorid -- 학과코드
		);

-- 학생
ALTER TABLE tbl_student
	ADD
		CONSTRAINT FK_scholarship_TO_student -- 장학금 -> 학생
		FOREIGN KEY (
			scholarcode -- 장학코드
		)
		REFERENCES tbl_scholarship ( -- 장학금
			scholarcode -- 장학코드
		);

-- 학생
ALTER TABLE tbl_student
	ADD
		CONSTRAINT FK_gyowon_TO_student -- 교원 -> 학생
		FOREIGN KEY (
			gyowonid -- 교원번호
		)
		REFERENCES tbl_gyowon ( -- 교원
			gyowonid -- 교원번호
		);

-- 수강
ALTER TABLE tbl_course
	ADD
		CONSTRAINT FK_student_TO_course -- 학생 -> 수강
		FOREIGN KEY (
			stdid -- 학번
		)
		REFERENCES tbl_student ( -- 학생
			stdid -- 학번
		);

-- 수강
ALTER TABLE tbl_course
	ADD
		CONSTRAINT FK_subject_TO_course -- 강의 -> 수강
		FOREIGN KEY (
			subjectid, -- 강의코드
			majorid,   -- 학과코드
			gyowonid   -- 교원번호
		)
		REFERENCES tbl_subject ( -- 강의
			subjectid, -- 강의코드
			majorid,   -- 학과코드
			gyowonid   -- 교원번호
		);
        
        
-- 학적상태
create sequence seq_stdstateid
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;



-- 복학
create sequence seq_returnseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 휴학
create sequence seq_leaveno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 장학금
create sequence seq_scholarcode
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;



-- 건물
create sequence seq_buildno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 강의
create sequence seq_subjectid
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 요일
create sequence seq_dayid
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 학과
create sequence seq_majorid
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 교시
create sequence seq_periodid
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 강의실
create sequence seq_lctrid
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 수강
create sequence seq_courseno
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;






---------------------------------------------------------------------------------------------------------------
--1. 관리자 테이블

drop table tbl_admin purge;


create table tbl_admin
(userid             varchar2(50)   not null  -- 관리자 아이디
,pwd                varchar2(200)  not null  -- 비밀번호 (SHA-256 암호화 대상)
,constraint PK_tbl_admin_userid primary key(userid)
);
---Table TBL_ADMIN이(가) 생성되었습니다.

commit;
--커밋 완료.

insert into tbl_admin(userid, pwd) values('admin','qwer1234$');

select *
from tbl_admin;





select *
from tab;


  --학생 1명조회 --
   select A.stdid, A.stdpwd, A.stdname, A.stdemail, A.stdmajorid, A.stdstateid, B.deptname, B.majorid, scholarcode,
            gyowonid,status,stdnameeng,stdnation,stdbirthday,entday
            ,entstate,stdjumin,enttype,examnum,stdpostcode
            ,stdaddress,stdmobile,schoolfrom1,graddate1,schoolfrom2, graddate2 
    from
    ( select  stdid, stdmajorid, dmajorid,stdstateid ,scholarcode,
            gyowonid,stdpwd,stdname,stdemail,status,stdnameeng,stdnation,stdbirthday,entday
            ,entstate,stdjumin,enttype,examnum,stdpostcode
            ,stdaddress,stdmobile,schoolfrom1,graddate1,schoolfrom2, graddate2 
		from tbl_student) A
		JOIN 
		(select majorid, deptname
		from tbl_department) B
		ON A.stdmajorid = B.majorid 
          where stdname = '김쌍용';
   
   
   --학생전체조회
    select count(*)
    from (
    select A.stdname, A.stdid, A.stdmajorid, A.stdstateid, B.deptname
    from
    ( select   stdid, stdmajorid, dmajorid,stdstateid ,scholarcode,
            gyowonid,stdpwd,stdname,stdemail,status,stdnameeng,stdnation,stdbirthday,entday
            ,entstate,stdjumin,enttype,examnum,stdpostcode
            ,stdaddress,stdmobile,schoolfrom1,graddate1,schoolfrom2, graddate2 
		from tbl_student) A
		JOIN 
		(select majorid, deptname
		from tbl_department) B
		ON A.stdmajorid = B.majorid 
       and lower(deptname) like '%'|| lower('컴퓨터공학과')||'%' 
       ) V
  -------------------------------------------
  
      select A.stdname, A.stdid, A.stdmajorid, A.stdstateid, B.deptname
        from
          ( select rownum AS rno, stdid, stdmajorid, dmajorid,stdstateid ,scholarcode,
                   gyowonid,stdpwd,stdname,stdemail,status,stdnameeng,stdnation,stdbirthday,entday
                  ,entstate,stdjumin,enttype,examnum,stdpostcode
                  ,stdaddress,stdmobile,schoolfrom1,graddate1,schoolfrom2, graddate2 
		from tbl_student) A
		JOIN 
		(select majorid, deptname
		from tbl_department) B
		ON A.stdmajorid = B.majorid
	   	<if test='searchType_1 != "" and searchWord_1 != ""'>
		and lower(${searchType_1}) like '%'||lower(#{searchWord_1})||'%'
		</if>
		where rno between #{startRno} and #{endRno}
	   </select>   
---------------------------------------------------------------------------------------------전꺼---------------------       
   
       
         --교원 전체조회 --
     
    select A.gyoname, A.gyowonid, A.gyomajorid, A.workstatus, B.deptname
    from
    ( select  rownum AS rno, gyowonid, gyopwd, gyoname, gyoemail, gyomajorid, workstatus, 
            gyonameeng, gyobirthday,gyojumin,gyonation,gyoaddress, gyopostcode, gyomobile, position, appointmentdt, degree,career1,careerTime1
            ,career2, careerTime2, status
		from tbl_gyowon) A
		JOIN 
		(select majorid, deptname
		from tbl_department) B
		ON A.gyomajorid = B.majorid 
        and lower(deptname) like '%'|| lower('컴퓨터공학과')||'%'
        where rno between 1 and 3;
        
        
       --교원 카운트
   
     select count(*)
	 from (   
        select A.gyoname, A.gyowonid, A.gyomajorid, A.workstatus, B.deptname
        from
        ( select  gyowonid, gyopwd, gyoname, gyoemail, gyomajorid, workstatus, 
                gyonameeng, gyobirthday,gyojumin,gyonation,gyoaddress, gyopostcode, gyomobile, position, appointmentdt, degree,career1,careerTime1
                ,career2, careerTime2, status
            from tbl_gyowon) A
            JOIN 
            (select majorid, deptname
            from tbl_department) B
            ON A.gyomajorid = B.majorid 
            and lower(deptname) like '%'|| lower('컴퓨터공학과')||'%' 
          )
        
  
        
     --교원 1명조회 --
     
    select A.gyowonid, A.gyopwd, A.gyoname, A.gyoemail, A.gyomajorid, A.workstatus, B.deptname, B.majorid,
            gyonameeng, gyobirthday,gyojumin,gyonation,gyoaddress, gyopostcode, gyomobile, position, appointmentdt, degree,career1,careerTime1
            ,career2, careerTime2, status
    from
    ( select  gyowonid, gyopwd, gyoname, gyoemail, gyomajorid, workstatus, 
            gyonameeng, gyobirthday,gyojumin,gyonation,gyoaddress, gyopostcode, gyomobile, position, appointmentdt, degree,career1,careerTime1
            ,career2, careerTime2, status
		from tbl_gyowon) A
		JOIN 
		(select majorid, deptname
		from tbl_department) B
		ON A.gyomajorid = B.majorid 
        where gyoname = '김영희';
     
     
     
     
       
       

--토탈페이지

 select count(*)
      from (select majorid, deptname
      from tbl_department) A
      JOIN 
      (select majorid, subjectid, gyowonid, classname, credit, 
              opensemester, applyperson, totalperson,
              applystate, applydate
      from tbl_subject
       where applystate='승인대기중' OR applystate= '등록완료' OR applystate= '신청반려'    
      ) B
      ON A.majorid = B.majorid
      ORDER BY DECODE(applystate, '승인대기중', 1) ASC    
      and lower(deptname) like '%'|| lower('정보보안학과') ||'%'
 
 

--전체 교수 강의  페이지(카운트)
 
      
      -------------------
   select count(*)
        from
        (
        select row_number() over(order by applydate desc) AS rno, deptname, subjectid, classname, credit
      , opensemester, applystate, applydate, totalperson
      , dayid, lctrid, seq_lectureplan
       from
       (
       select distinct A.deptname, B.subjectid, B.classname, B.credit
      , B.opensemester, B.applystate, B.applydate, nvl(B.totalperson, NULL) as totalperson
      , nvl(F.abvat, NULL) || ' ' || nvl(H.periodlist, NULL) AS dayid
      , nvl(E.buildname,NULL) || ' ' ||  nvl(D.lctrid,NULL) AS lctrid
                  , nvl(I.seq_lectureplan, NULL) AS seq_lectureplan
      from
      (select majorid, deptname
      from tbl_department) A
      JOIN 
      (select majorid, subjectid, gyowonid, classname, credit, 
              opensemester, applyperson, totalperson,
              applystate, applydate
      from tbl_subject
      ) B
      ON A.majorid = B.majorid
      lEFT JOIN 
      (select subjectid, periodid, dayid, seq_lctrid
      from tbl_lectureroom_assign
      ) C
      ON B.subjectid = C.subjectid
      lEFT JOIN 
      (
      select buildno, lctrid, seq_lctrid
      from tbl_lectureroom
      )D
      ON C.seq_lctrid = D.seq_lctrid
      lEFT JOIN 
      (select buildno, buildname
      from tbl_building
      )E
      on D.buildno = E.buildno
      lEFT JOIN 
      (select dayid, abvat
      from tbl_dayofweek
      )F
      on C.dayid = F.dayid
      lEFT JOIN 
      (select seq_lectureplan, subjectid
      from tbl_lectureplan) G
      on B.subjectid = G.subjectid
      lEFT JOIN 
      (select subjectid, LISTAGG(periodid,',') WITHIN GROUP (ORDER BY periodid) AS periodlist
      from (select subjectid, dayid, periodid, seq_lctrid
      from tbl_lectureroom_assign)
      group by subjectid
      order by subjectid) H
      on B.subjectid = H.subjectid
        lEFT JOIN 
        (select seq_lectureplan, subjectid
        from tbl_lectureplan) I
        on B.subjectid = I.subjectid
        where applystate='승인대기중' OR applystate= '등록완료' OR applystate= '신청반려'     
        ) V 
        --<if test='searchType_1 != "" and searchWord_1 != ""'>
         where lower(deptname) like '%'|| lower('컴퓨터공학과') ||'%' 
       -- </if>
       -- <if test="applystate != ''">
		where lower(applystate) like '%'||lower('승인대기중')||'%'  
		--</if>
		)    
        
 --교수강의 신청목록보기
  select rno, deptname, subjectid, classname, credit
      , opensemester, applystate, applydate, totalperson
      , dayid, lctrid, seq_lectureplan
        from
        (
        select row_number() over(order by applydate desc) AS rno, deptname, subjectid, classname, credit
      , opensemester, applystate, applydate, totalperson
      , dayid, lctrid, seq_lectureplan
       from
       (
       select distinct A.deptname, B.subjectid, B.classname, B.credit
      , B.opensemester, B.applystate, B.applydate, nvl(B.totalperson, NULL) as totalperson
      , nvl(F.abvat, NULL) || ' ' || nvl(H.periodlist, NULL) AS dayid
      , nvl(E.buildname,NULL) || ' ' ||  nvl(D.lctrid,NULL) AS lctrid
                  , nvl(I.seq_lectureplan, NULL) AS seq_lectureplan
      from
      (select majorid, deptname
      from tbl_department) A
      JOIN 
      (select majorid, subjectid, gyowonid, classname, credit, 
              opensemester, applyperson, totalperson,
              applystate, applydate
      from tbl_subject
      ) B
      ON A.majorid = B.majorid
      lEFT JOIN 
      (select subjectid, periodid, dayid, seq_lctrid
      from tbl_lectureroom_assign
      ) C
      ON B.subjectid = C.subjectid
      lEFT JOIN 
      (
      select buildno, lctrid, seq_lctrid
      from tbl_lectureroom
      )D
      ON C.seq_lctrid = D.seq_lctrid
      lEFT JOIN 
      (select buildno, buildname
      from tbl_building
      )E
      on D.buildno = E.buildno
      lEFT JOIN 
      (select dayid, abvat
      from tbl_dayofweek
      )F
      on C.dayid = F.dayid
      lEFT JOIN 
      (select seq_lectureplan, subjectid
      from tbl_lectureplan) G
      on B.subjectid = G.subjectid
      lEFT JOIN 
      (select subjectid, LISTAGG(periodid,',') WITHIN GROUP (ORDER BY periodid) AS periodlist
      from (select subjectid, dayid, periodid, seq_lctrid
      from tbl_lectureroom_assign)
      group by subjectid
      order by subjectid) H
      on B.subjectid = H.subjectid
        lEFT JOIN 
        (select seq_lectureplan, subjectid
        from tbl_lectureplan) I
        on B.subjectid = I.subjectid
        where applystate='승인대기중' OR applystate= '등록완료' OR applystate= '신청반려'     
        ) V 
        --<if test='searchType_1 != "" and searchWord_1 != ""'>
        -- where  lower(deptname) like '%'|| lower('컴퓨터공학과') ||'%' 
       -- </if>
       -- <if test="applystate != ''">
		where lower(applystate) like '%'||lower('승인대기중')||'%'  
		--</if>
		)
      where rno between 1 and 7
        
--학생 리스트 카운트
 select count(*)
	    from (
	    select A.stdname, A.stdid, A.stdmajorid, A.stdstateid, B.deptname
	    from
	    ( select stdid, stdmajorid, dmajorid,stdstateid ,scholarcode,
	            gyowonid,stdpwd,stdname,stdemail,status,stdnameeng,stdnation,stdbirthday,entday
	            ,entstate,stdjumin,enttype,examnum,stdpostcode
	            ,stdaddress,stdmobile,schoolfrom1,graddate1,schoolfrom2, graddate2 
			from tbl_student) A
		JOIN 
		(select majorid, deptname
		from tbl_department) B
		ON A.stdmajorid = B.majorid 
		 -- <if test='searchType_1 != ""'>
		 and lower(deptname) like '%'|| lower('컴퓨터공학과') ||'%' 
         --   </if>  
          --  <if test='stdstateid != null'>
		and lower(stdstateid) like '%'||lower(1)||'%'  
		--</if>
        ) V
        
--학생리스트 조회

	     select rno, stdname, stdid, stdmajorid, stdstateid, deptname
          from 
          (
          select rownum AS rno, A.stdname, A.stdid, A.stdmajorid, A.stdstateid, B.deptname
          from
          ( 
          select stdid, stdmajorid, dmajorid,stdstateid ,scholarcode,
                 gyowonid,stdpwd,stdname,stdemail,status,stdnameeng,stdnation,stdbirthday,entday
                ,entstate,stdjumin,enttype,examnum,stdpostcode
                ,stdaddress,stdmobile,schoolfrom1,graddate1,schoolfrom2, graddate2 
	      from tbl_student) A
	      JOIN 
	      (select majorid, deptname
	      from tbl_department) B
	      ON A.stdmajorid = B.majorid
	  -- 	 <if test='searchType_1 != "" and searchWord_1 != ""'>
		 and lower(deptname) like '%'|| lower('컴퓨터공학과') ||'%' 
		-- </if>
		-- <if test='stdstateid != null'>
		 and lower(stdstateid) like '%'||lower(1)||'%'  
		 --</if>
		  )Z
		 where rno between 1 and 7
	
        
        
        
 