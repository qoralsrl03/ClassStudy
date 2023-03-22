select table_name 
from user_tables;
--현재 DB에서 테이블명 조회


select * from channels where channel_total_id is not null;
-- select 조회 순서 : from > where > group by > having > select > order by


select job_id as "hello name", job_title as 이름 --한글을 ""로 사용하는거 추천, 띄어쓰기가 가능해짐, 별칭 지정시에만 가능함
from jobs A
where job_id is not null;

select emp_name, salary
from employees
where salary >= 5000
and salary < 10000
order by 2 desc, 1 desc;
/*정렬 시 select 문에 쓰인 순서대로 입력도 가능함, 1 = emp_name / 2 = salary */ 

select emp_name, department_id
from employees
where department_id=60 
or department_id = 70
order by emp_name;


-- select ~ from ~ where ~ order by ~ (ASC/DESC)
select emp_name, hire_date, salary, department_name
from employees a, departments b
where job_id = 'SA_REP'
and salary >= 9000
and a.department_id = b.department_id
order by salary desc;

--insert into ~ values(~)
insert into ex2_1 values(1, '팽수'); --전체입력
insert into ex2_1(emp_id) values(2); --부분입력
insert into ex2_1 (select employee_id, emp_name from employees where department_id = 10);
-- select문을 insert 할 때에는 넣는 속성들의 자료형을 일치시켜줄것

commit; 
rollback;

--update ~ set ~ where ~
update ex2_1 set emp_id=100 where emp_id=2; 

select * from ex2_2;

desc ex2_1;

--delete ~ where ~
delete ex2_1
where emp_id = 100;

-- primary key = 중복 불가, Not Null
-- Unique key = 중복 불가, Null 가능
-- foreign key = 기본키를 참조, 참조 컬럼과 외래 컬럼은 범위가 같아야 함
-- Check = 컬럼에 특정 조건에 맞는 데이터만 입력 받고 그렇지 않으면 오류를 리턴 (ex y/n, M/F)
-- Default = 제약조건에는 포함되지는 않음, 레코드를 입력 시 필드값을 전달하지 않으면, 자동으로 설정된 기본값을 저장

-- DATE : 년월일 시분초 
-- TIMESTAMP : 년월일 시분초. 밀리세컨드
drop table ex2_2;
desc ex2_2;

create table ex2_2(
dt1 date,
dt2 TIMESTAMP,
constraint uq_2_3 unique (dt1) -- dt1 속성을 유니크로 선언하고 uq_2_3 이라는 이름으로 유니크 키를 지정
);

select *
from user_constraints
where constraint_name like '%UQ%';

-- sysdate, systimestamp <-- 현재 시간
insert into ex2_2 values(sysdate, systimestamp);
select * 
from ex2_2;

-- DEFAULT 값이 들어오지 않으면 NULL 대신 디폴트값 삽입
Create table ex2_6(
col1 number default 0,
col2 date default sysdate,
col3 varchar2(100)
);

insert into ex2_6(col3) values('팽수');
insert into ex2_6 values(1,'2023.03.01','되냐');
insert into ex2_6(col1) values(2);
select * from ex2_6;

--primary key / foreign key
create table dep(
deptno number(3) primary key,
depname varchar2(100),
floor number(5)
);
drop table emp;
create table emp(
empno number,
emp_name varchar2(100),
dno number(10) constraint emp_fk references dep(deptno) 
--dno의 제약조건 이름 은 emp_fk이고 dep테이블의 deptno를 참조
--참조하고 있는 기본키의 범위 내 값만 허용 가능 
);

insert into dep values(1, '영업', 2);
insert into dep values(2, '기획', 5);
insert into emp values(3, '마케팅', 4); --dep 테이블의 deptno 내 값은 1,2뿐이라서 4는 들어갈수없음

-- 숫자 데이터타입 number(p, s) p: 최대 유효숫자(자릿수), s: 소수점 자리수
create table ex2_7(
co1 number, --디폴트 32
col2 number(3,2), -- 1.23   3이 전체 길이, 소수점 둘째자리 까지 표기 나머지는 반올림
col3 number(5,-2) -- 음수일경우 소수점 자리수만큼 왼쪽(양수) 값을 반올림(최대길이 7)
--23456.12 > 23500
);

insert into ex2_7(col2) values(1.666);
insert into ex2_7(col2) values(9.996); -- 오류 최대 자리 3(소수점 포함)
select * from ex2_7;

insert into ex2_7(col3) values(99999);
insert into ex2_7(col3) values(9.1); -- (5,-2) 10의 자리까지 반올림
insert into ex2_7(col3) values(23456.12);

create table TB_INFO (
INFO_NO number(3) primary key,
PC_NO varchar2(10) not null,
NM varchar2(20),
EMAIL varchar2(100),
HOBBY varchar2(1000),
UPDATE_DT DATE Default SYSDATE
);
commit;
drop table TB_INFO;
desc TB_INFO;
select * from TB_INFO;
