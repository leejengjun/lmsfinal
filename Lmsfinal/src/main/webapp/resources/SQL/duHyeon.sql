show user
-- USER이(가) "FINALORAUSER3"입니다.


drop table tbl_test_round

drop table tbl_test_answers

drop table tbl_test_question


-- 과목별시험회차 테이블
ALTER TABLE tbl_test_round
	DROP CONSTRAINT CK_tbl_test_round; -- 과목별시험회차 테이블 체크 제약

-- 과목별시험회차 테이블
ALTER TABLE tbl_test_round
	DROP CONSTRAINT CK_tbl_test_round2; -- 과목별시험회차 테이블 체크 제약2

-- 과목별시험회차 테이블
ALTER TABLE tbl_test_round
	DROP CONSTRAINT PK_tbl_test_round; -- 과목별시험회차 테이블 기본키

-- 과목별시험회차 테이블

CREATE TABLE tbl_test_round (
	testclfc    NUMBER        NOT NULL, -- 시험구분
	majorid     NUMBER        NOT NULL, -- 학과코드
	gyowonid    NUMBER        NOT NULL, -- 교원번호
	subjectid   NUMBER        NOT NULL, -- 강의코드
	stdid       NUMBER        NOT NULL, -- 학번
	examtitle   varchar2(100) NOT NULL, -- 시험이름
	startdate   DATE          NOT NULL, -- 시작일시
	enddate     DATE          NOT NULL, -- 마감일시
	score       NUMBER     NOT NULL, -- 점수
	questionarr VARCHAR2(100) NULL,     -- 시험문제배열
	checkarr    VARCHAR2(100) NULL,      -- 정답체크배열
    disclosure  NUMBER DEFAULT 0, -- 정답공개여부
	submit      NUMBER DEFAULT 0, -- 제출여부
);



-- 과목별시험회차 테이블 기본키
CREATE UNIQUE INDEX PK_tbl_test_round
	ON tbl_test_round ( -- 과목별시험회차 테이블
		testclfc  ASC, -- 시험구분
		majorid   ASC, -- 학과코드
		gyowonid  ASC, -- 교원번호
		subjectid ASC  -- 강의코드
	);

-- 과목별시험회차 테이블
ALTER TABLE tbl_test_round
	ADD
		CONSTRAINT PK_tbl_test_round -- 과목별시험회차 테이블 기본키
		PRIMARY KEY (
			testclfc,  -- 시험구분
			majorid,   -- 학과코드
			gyowonid,  -- 교원번호
			subjectid  -- 강의코드
		);

-- 과목별시험회차 테이블
ALTER TABLE tbl_test_round
	ADD
		CONSTRAINT CK_tbl_test_round -- 과목별시험회차 테이블 체크 제약
		CHECK (submit in (0,1));

-- 과목별시험회차 테이블
ALTER TABLE tbl_test_round
	ADD
		CONSTRAINT CK_tbl_test_round2 -- 과목별시험회차 테이블 체크 제약2
		CHECK (disclosure in (0,1));

-- 과목별시험회차 테이블
ALTER TABLE tbl_test_round
	ADD
		CONSTRAINT FK_tbl_sub_TO_test_round -- 강의 -> 과목별시험회차 테이블
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

-- 과목별시험회차 테이블
ALTER TABLE tbl_test_round
	ADD
		CONSTRAINT FK_tbl_std_TO_test_round -- 학생 -> 과목별시험회차 테이블
		FOREIGN KEY (
			stdid -- 학번
		)
		REFERENCES tbl_student ( -- 학생
			stdid -- 학번
		);
        
--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

-- 시험문제테이블
ALTER TABLE tbl_test_question
	DROP CONSTRAINT PK_tbl_test_question; -- 시험문제테이블 기본키

-- 시험문제테이블
CREATE TABLE tbl_test_question (
	questionseq NUMBER        NOT NULL, -- 시험문제시퀀스
	subjectid   NUMBER        NOT NULL, -- 강의코드
	majorid     NUMBER        NOT NULL, -- 학과코드
	gyowonid    NUMBER        NOT NULL, -- 교원번호
	testclfc    number        NOT NULL, -- 시험구분
	question    VARCHAR2(200) NOT NULL, -- 시험문제
	correct     NUMBER(1)     NOT NULL  -- 정답번호
);

-- 시험문제테이블 기본키
CREATE UNIQUE INDEX PK_tbl_test_question
	ON tbl_test_question ( -- 시험문제테이블
		questionseq ASC, -- 시험문제시퀀스
		subjectid   ASC, -- 강의코드
		majorid     ASC, -- 학과코드
		gyowonid    ASC, -- 교원번호
		testclfc    ASC  -- 시험구분
	);

-- 시험문제테이블
ALTER TABLE tbl_test_question
	ADD
		CONSTRAINT PK_tbl_test_question -- 시험문제테이블 기본키
		PRIMARY KEY (
			questionseq, -- 시험문제시퀀스
			subjectid,   -- 강의코드
			majorid,     -- 학과코드
			gyowonid,    -- 교원번호
			testclfc     -- 시험구분
		);

-- 시험문제테이블
ALTER TABLE tbl_test_question
	ADD
		CONSTRAINT FK_tbl_test_round_TO_question -- 과목별시험회차 테이블 -> 시험문제테이블
		FOREIGN KEY (
			testclfc,  -- 시험구분
			majorid,   -- 학과코드
			gyowonid,  -- 교원번호
			subjectid  -- 강의코드
		)
		REFERENCES tbl_test_round ( -- 과목별시험회차 테이블
			testclfc,  -- 시험구분
			majorid,   -- 학과코드
			gyowonid,  -- 교원번호
			subjectid  -- 강의코드
		);
        
        


--//////////////////////////////////////////////////////////////////////////////


-- 정답보기 선택테이블
ALTER TABLE tbl_test_answers
	DROP CONSTRAINT PK_tbl_test_answers; -- 정답보기 선택테이블 기본키

-- 정답보기 선택테이블
CREATE TABLE tbl_test_answers (
	answersseq  NUMBER        NOT NULL, -- 보기고유번호
	questionseq NUMBER        NOT NULL, -- 시험문제시퀀스
	testclfc    number        NOT NULL, -- 시험구분
	subjectid   NUMBER        NOT NULL, -- 강의코드
	majorid     NUMBER        NOT NULL, -- 학과코드
	gyowonid    NUMBER        NOT NULL, -- 교원번호
	answer      VARCHAR2(200) NOT NULL  -- 정답보기선택
);

-- 정답보기 선택테이블 기본키
CREATE UNIQUE INDEX PK_tbl_test_answers
	ON tbl_test_answers ( -- 정답보기 선택테이블
		answersseq  ASC, -- 보기고유번호
		questionseq ASC, -- 시험문제시퀀스
		testclfc    ASC, -- 시험구분
		subjectid   ASC, -- 강의코드
		majorid     ASC, -- 학과코드
		gyowonid    ASC  -- 교원번호
	);

-- 정답보기 선택테이블
ALTER TABLE tbl_test_answers
	ADD
		CONSTRAINT PK_tbl_test_answers -- 정답보기 선택테이블 기본키
		PRIMARY KEY (
			answersseq,  -- 보기고유번호
			questionseq, -- 시험문제시퀀스
			testclfc,    -- 시험구분
			subjectid,   -- 강의코드
			majorid,     -- 학과코드
			gyowonid     -- 교원번호
		);

-- 정답보기 선택테이블
ALTER TABLE tbl_test_answers
	ADD
		CONSTRAINT FK_tbl_test_ques_TO__answers -- 시험문제테이블 -> 정답보기 선택테이블
		FOREIGN KEY (
			questionseq, -- 시험문제시퀀스
			subjectid,   -- 강의코드
			majorid,     -- 학과코드
			gyowonid,    -- 교원번호
			testclfc     -- 시험구분
		)
		REFERENCES tbl_test_question ( -- 시험문제테이블
			questionseq, -- 시험문제시퀀스
			subjectid,   -- 강의코드
			majorid,     -- 학과코드
			gyowonid,    -- 교원번호
			testclfc     -- 시험구분
		);


--///////////////  테이블 생성 끝 //////////////////////////////////////////////////////////////////////////////////////////////// 


 --- 시험 회차 시퀀스 입니다. ----
create sequence seq_test_round
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


create sequence seq_answersseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

create sequence seq_questionseq
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

ALTER TABLE tbl_subject_notice MODIFY (snregdate DEFAULT sysdate);

select subjectid
from tbl_lectureplan

select * 
from tbl_gyowon

insert into tbl_subject_notice(SUBNOTICENO,
                               SNSUBJECT,
                               SNCONTENT,
                               SNREGDATE,
                               SNPWD,
                               SNSTATUS,
                               SNORGFILENAME,
                               SNFILENAME,
                               SNFILESIZE,
                               SUBJECTID,
                               MAJORID,
                               GYOWONID)
                         values(9999,
                               '과목 공지사항 테스트입니다.',
                               '과목공지사항 테스트 내용입니다. 내용내용내용',
                               default,
                               '1234',
                               default,
                               null,
                               null,
                               null,
                               11,
                               11,
                               10001)
                               
select to_char(snregDate,'yyyy-mm-dd HH24:mi:ss') as 
from tbl_subject_notice
                               
 select *
 from tbl_department
 
 
 
 
 
 isnert into tbl_test_round (TESTCLFC, MAJORID, GYOWONID, SUBJECTID, EXAMTITLE, DISCLOSURE, STARTDATE, ENDDATE, QUESTIONCNT)
                    values()
 
 select *
 from tbl_test_round
        
       
		select *
		from tbl_test_round
		where subjectid = '11001' and gyowonid = '10001'     
        
        select testclfc, majorid, gyowonid, subjectid, examtitle, disclosure, startdate, enddate, questioncnt
		from tbl_test_round
		where subjectid = #{subjectid} and gyowonid = #{userid}
        
        
        
        select testclfc, majorid, gyowonid, subjectid, examtitle, disclosure
			 , to_char(startdate,'yyyy-MM-dd hh24:mi') AS startdate
			 , to_char(enddate,'yyyy-MM-dd hh24:mi') AS enddate
			 , questioncnt
		from tbl_test_round
		where GYOWONID = '10001' and testclfc = '17'
        
        
        
        
          select T.testclfc, T.majorid, T.gyowonid, S.subjectid, T.examtitle, T.disclosure
			 , to_char(T.startdate,'yyyy-MM-dd hh24:mi') AS startdate
			 , to_char(T.enddate,'yyyy-MM-dd hh24:mi') AS enddate
			 , T.questioncnt
             , S.classname
		from tbl_test_round T join tbl_subject S
        on T.subjectid = S.subjectid
		where T.GYOWONID = '10001' and T.testclfc = '18'
        
-- 학생 테이블에서 한번 보기

select *
from tbl_student


-- test_round와 question을 join 하여 현재 이 testround에 달린 문제의 수와 test_round를 가져올것이다.

select *
from tbl_test_round T join tbl_test_question Q
on T.testclfc = Q.testclfc 
where subjectid = 


 -------------------- 조인없이 가져왔던 것
	select testclfc, majorid, gyowonid, subjectid, examtitle, disclosure
			 , to_char(startdate,'yyyy-mm-dd HH24:mi:ss') as startdate, to_char(enddate,'yyyy-mm-dd HH24:mi:ss') as enddate
			 , questioncnt
		from tbl_test_round
		where GYOWONID = #{userid} and SUBJECTID = #{subjectid}
-------------------------조인해서 현재 출제한 문항의 수까지 받아옴
select T.testclfc, T.majorid, T.gyowonid, T.subjectid, T.examtitle
     , T.disclosure, T.questioncnt, startdate, enddate, nvl(cnt,0)as
from
(
	select testclfc, majorid, gyowonid, subjectid, examtitle, disclosure, questioncnt
     , to_char(startdate,'yyyy-mm-dd HH24:mi:ss') as startdate, to_char(enddate,'yyyy-mm-dd HH24:mi:ss') as enddate
		from tbl_test_round 
) T
full join                           
(
select testclfc, count(*)as cnt
 from tbl_test_question
 group by testclfc
)Q
on T.testclfc = Q.testclfc
where T.GYOWONID = '10001' and T.SUBJECTID = '11001'


--- 조인해서 class name 까지 받아와야할듯
select T.testclfc, T.majorid, T.gyowonid, T.subjectid, T.examtitle
     , T.disclosure, T.questioncnt, startdate, enddate, nvl(cnt,0)as cnt
     , T.classname
from
(
    select T.testclfc as testclfc , T.majorid as majorid, T.gyowonid as gyowonid
             , S.subjectid as subjectid, T.examtitle as examtitle, T.disclosure as disclosure
			 , to_char(T.startdate,'yyyy-MM-dd hh24:mi') AS startdate
			 , to_char(T.enddate,'yyyy-MM-dd hh24:mi') AS enddate
			 , T.questioncnt as questioncnt
             , S.classname as classname
		from tbl_test_round T join tbl_subject S
        on T.subjectid = S.subjectid
		where T.GYOWONID = '10001' and T.SUBJECTID = '11001'
) T
full join                           
(
select testclfc, count(*)as cnt
 from tbl_test_question
 group by testclfc
)Q
on T.testclfc = Q.testclfc
-------------------------------------- test round update 해주는 것------------------------------------------

update tbl_test_round set EXAMTITLE = '수정연습', 
        DISCLOSURE=1, 
        STARTDATE=to_date('202205110235','yyyy-MM-dd hh24:mi:ss'), 
        ENDDATE=to_date('202205110235','yyyy-MM-dd hh24:mi:ss'), 
        QUESTIONCNT='16'
		where TESTCLFC = 17  

select examtitle = #{examtitle}, disclosure=#{disclosure},startdate=to_date(#{startdate},'yyyy-MM-dd hh24:mi')
      , enddate=to_date(#{enddate},'yyyy-MM-dd hh24:mi'), questioncnt=#{questioncnt}
where testclfc = #{testclfc}  
 from tbl_test_round
----------------------------------------- 컴퓨터가 얼어버리는 바람에 notice하던 중앙부분이랑 여러곳 날아가버림 ㅠ 다시 notice 시작-----------------------------------------------------------------


------------------------------------------------------- detail notice를 보여주기 위한 곳-------------------------------------------


select subnoticeno, snsubject, sncontent, snregdate, snpwd, snstatus, nvl(snorgfilename, '없음') as snorgfilename
     , nvl(snfilename, '없음') as snfilename, nvl(snfilesize, 0) as snfilesize, subjectid, majorid, gyowonid
from tbl_subject_notice
where subnoticeno = 1
-------------------------------------------------- 위의 것을 subject 테이블과 조인하여 다시 넣어 줄 것이다.



    select subnoticeno, snsubject, sncontent, to_char(snregdate, 'yyyy-MM-dd HH24:mi:ss') as snregdate, snpwd, snstatus, nvl(snorgfilename, '없음') as snorgfilename
         , nvl(snfilename, '없음') as snfilename, nvl(snfilesize, 0) as snfilesize, N.subjectid, N.majorid, N.gyowonid, S.classname
    from tbl_subject_notice N join tbl_subject S
    ON N.subjectid = S.subjectid
    where subnoticeno = #{subnoticeno}



----------------------------------------------------- 수강 테이블 의 수강 코드를 받아올것 그리고  --------------------------------------------------------------

select A.stdname, A.courseno, A.stdid, A.appsemester, A.evaluwhether,
           A.subjectid, A.majorid, A.gyowonid, attendweek, tardy, attendance, absent
from
(
    select S.stdname, C.courseno, C.stdid, appsemester, evaluwhether,
           C.subjectid, C.majorid, C.gyowonid
    from tbl_course C join tbl_student S
    on C.stdid = S.stdid
    where C.gyowonid = 10001 and C.subjectid=11001 and C.majorid = 11
) A
Full join
(
    select attendweek, courseno, tardy, attendance, absent
    from tbl_attendance
) W
on A.courseno = W.courseno
where W.attendweek = 2

rollback

-------------------------------------------------------------------------------------------------




delete from tbl_attendance
where 
update tbl_attendance set 
		 tardy = 0, attendance=0, absent =1
		where attendweek = 1 and courseno = 14

select *
from tbl_attendance
where courseno = 8 and absent = 1
group by attendance


select count(*) as tardy
from tbl_attendance
where courseno = 14
group by tardy


select count(*) 
from tbl_attendance
where courseno = 8
group by absent, attendance, tardy
order by absent , tardy , attendance


select count(*) 
from tbl_attendance
where courseno = 14
group by absent, attendance, tardy
order by attendance, tardy



select *
from tbl_attendance
where courseno = 8
group by attendance



----------------------------------------- 성적 테이블 생성하기 -------------------------------------
-- 수강코드에 강의코드 학과코드 교원번호가 일치하는 것들의 총집합을 받아오며 수강테이블의 학번과 학생 테이블의 학번이같게 조인을 하고 수강코드와 수강코드로 풀조인 즉 두번 조인을 해줘야 할것같음
select A.stdname, classname, A.courseno, A.stdid, A.appsemester, A.evaluwhether, 
       A.subjectid, A.majorid, A.gyowonid, MIDSCORE, FINALSCORE, ATTSCORE, TASKSCORE, GRADE
from
(
    select C.stdname, C.courseno, C.stdid, appsemester, evaluwhether,
               C.subjectid, C.majorid, C.gyowonid ,D.classname
    from
    (
        select S.stdname, C.courseno, C.stdid, appsemester, evaluwhether,
               C.subjectid, C.majorid, C.gyowonid
        from tbl_course C join tbl_student S
        on C.stdid = S.stdid
    ) C
    JOIN
    (
        select classname, subjectid
        from tbl_subject
        where gyowonid = 10001 and subjectid=11001 
    ) D
    On C.subjectid = D.subjectid
) A
Full join
(
    select COURSENO, MIDSCORE, FINALSCORE, ATTSCORE, TASKSCORE, GRADE
    from tbl_grade_result
) W
on A.courseno = W.courseno
where A.courseno = 8

select A.stdname, classname, A.courseno, A.stdid, A.appsemester, A.evaluwhether, 
       		  A.subjectid, A.majorid, A.gyowonid, midscore, finalscore, attscore, taskscore, grade
		from
		(
		    select C.stdname, C.courseno, C.stdid, appsemester, evaluwhether,
		               C.subjectid, C.majorid, C.gyowonid ,D.classname
		    from
		    (
		        select S.stdname, C.courseno, C.stdid, appsemester, evaluwhether,
		               C.subjectid, C.majorid, C.gyowonid
		        from tbl_course C join tbl_student S
		        on C.stdid = S.stdid
		    ) C
		    JOIN
		    (
		        select classname, subjectid
		        from tbl_subject
		        where gyowonid = 1001 and subjectid=11001 and majorid = 11
		    ) D
		    On C.subjectid = D.subjectid
		) A
		Full join
		(
		    select midscore, finalscore, attscore, taskscore, grade, courseno
		    from tbl_grade_result
		) W
		on A.courseno = W.courseno

---- 과목명 학번 이름

select *
from tbl_test_round



alter table tbl_grade_result modify grade varchar2(2)


select *
from tbl_grade_result

        