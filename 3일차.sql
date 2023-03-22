select * from TB_INFO;
update TB_INFO set hobby = '스키' where pc_no = 'pc06';
commit;

/* 문자 연산자 || <-- 문자열 붙일때 사용 */
select (emp_name || ':' || employee_id) || '^^끼룩끼룩'
from employees;

/* 수식 연산자 + - * / 숫자 데이터 타입에 사용 가능 */
select employee_id
       ,emp_name
       ,salary /30 as 일당
       ,salary as 월급
       ,salary*12 as 연봉 from employees;

/* 논리 연산자 > < >= <= != <> ^= */
select * from employees where salary = 2600 ; -- 같다
select * from employees where salary <> 2600 ; -- 같지않다
select * from employees where salary != 2600 ; -- 같지않다
select * from employees where salary ^= 2600 ; -- 같지않다
select * from employees where salary < 2600 ; -- 미만
select * from employees where salary > 2600 ; -- 초과
select * from employees where salary <= 2600 ; -- 이하
select * from employees where salary >= 2600 ; -- 이상
--직원 중에 30, 50번 부서가 아닌 직원만 출력하시오
desc employees;

select emp_name,department_id
from employees
where department_id != 30 and department_id != 50
order by 2;

/* In 조건식 */
select *
from employees
where department_id In (30, 50, 60)
order by department_id; -- In = 포함하는

/* NOT 조건식 */
select *
from employees
where department_id NOT IN (30,50,80) -- NOT IN = 미포함
order by department_id;

/*표현식 특정조건일때 표현을 바꾸는*/
-- 5000 이하 'C등급', 5000 초과 15000 이하 'B' 등급
-- 그 밖에는 'A등급'
/*CASE WHEN 조건 THEN 표시될 이름 
       WHEN 조건 THEN 표시될 이름 
       ELSE 조건 
  END AS 케이스이름*/
select employee_id
      , emp_name
      , salary
      , CASE WHEN salary <= 5000 THEN 'C등급'
             WHEN salary >5000 and salary <= 15000 THEN 'B등급'
             Else 'A등급'
        END as grade
from employees;

-- CUSTOMER 테이블에서 성별 정보 F -> '여자', M -> '남자'로
-- 사용하여 출력하시오
select count(cust_gender)
from customers;


select a.*
       ,case when cust_gender = 'M' then '남자'
            when cust_gender = 'F' then '여자'
       else '외계인'
       end as gender
from customers a
order by cust_gender;

/*Like 조건식 (많이 사용함) */
-- %X가 앞에 붙으면 X로 끝나는 값, X% 가 뒤에 붙는 식이면 X로 시작하는 값
-- %X% 앞뒤로 모두 붙이면 X를 포함한 모든 값
select emp_name
from employees
where emp_name like '%e' or emp_name like 'A%'
order by 1;

select emp_name
from employees
where emp_name like '%Al%';

select emp_name
from employees
where emp_name
like '%'||:Test||'%'; --바인드 테스트

create table ex3_1(
    nm varchar2(100)
    );

--Like로 자릿수 검색하기    
insert into ex3_1 values('홍길');
insert into ex3_1 values('홍길동');
insert into ex3_1 values('홍길동님');

select *
from ex3_1;
select *
from ex3_1
where nm like '홍_' or nm like '_길_' or nm like '___님';

select *
from TB_INFO;

select *
from TB_INFO
where nm like '김__' or nm like '김%';

------------------------------------------------------------
/* 문자함수 : 문자 함수는 연산 대상이 문자이며 반환 값은 함수에 따라 문자 or 숫자를 반환*/
--UPPER(char) 대문자로
--LOWER(char) 소문자로
select emp_name
    , Upper(emp_name) as 대문자
    , UPPER('HI') as 하이
    , LOWER(emp_name) as 소문자
from employees;

--검색조건으로 대문자 or 소문자가 들어와도 검색이 되게 하려면?
--모두 대문자나 소문자로 일치시키기 
select emp_name
from employees
where LOWER(emp_name) = LOWER('DOUglas Grant'); --소문자로 바꿔서 바꿔서 검색

select emp_name
from employees
where upper(emp_name) like '%'||UPPER(:nm)||'%'; --emp_name 컬럼의 값을 upper 해주지 않으면 Kim과 같이 첫 대문자로 시작하는 값은 출력되지 않음


--SUBSTR 문자열 자르기
--SUBSTR(char, pos, len) 대상 문자열 char 를 pos 번째 부터 len 길이 만큼 자른뒤 반환
--POS 값으로 0이오면 디폴트 1(첫번째 문자열)
--음수가 오면 뒤에서 부터, len 값 생략시 pos번째 부터 끝까지  

SELECT emp_name
    , SUBSTR(emp_name,1,4)
    , SUBSTR(emp_name,4)
    , SUBSTR(emp_name,-4,1) -- 맨뒤에서 4번째 1길이의 문자열을 가져옴
from employees;

--이름 성의 갯수 조회하기
select SUBSTR(nm,1,1),count(nm)
from TB_INFO
group by SUBSTR(nm,1,1)
order by 1;

/*INSTR 위치 반환
INSTR(char,n,pos,len) char 대상문자열에서 n을 찾음
                      pos부터 len 번째 대상의 시작 위치를 반환
                      pos, len 디폴트 1
*/

SELECT INSTR('abcabc', 'b', 1, 1) as first --'abcabc'의 1번째 글자부터 첫번째 b의 위치를 찾아라
    , INSTR('abcabc', 'b', 1, 2) -- 'abcabc'의 1번째 글자부터 두번째 b의 위치를 찾아라
    , INSTR('abcabc','b')
    , INSTR('abcabc','b',3,1)
FROM DUAL; --테스트 테이블 

--TB_INFO의 EMAIL 컬럼에서 @의 위치를 출력하시오
desc TB_INFO;

select EMAIL,INSTR(EMAIL,'@') as "@의 위치"
from TB_INFO a;

select EMAIL, 
       SUBSTR(EMAIL, 1,INSTR(EMAIL,'@')-1) as ID,
       SUBSTR(EMAIL, INSTR(EMAIL,'@')) as MAIL_TYPE,
       INSTR(EMAIL,'@')
from TB_INFO;

/*REPLACE 치환*/
--'abcd' 문자열에서 'a'는 'A'로 치환해라
--REPLACE(문자열, 바뀔 문자열, 바꿀 문자열)
SELECT REPLACE('abcd', 'ab', 'AB')
from DUAL;

/* TRIM 양쪽공백제거, LTRIM : 왼쪽, RTRIM : 오른쪽 */
select TRIM(' hi ')
       ,LTRIM('  hi   ')
       ,RTRIM('      hi        ')
from DUAL;

/* LPAD:왼쪽채움 RPAD:오른쪽 
   LPAD(char, 5, '0') --> char를 5자리로 만듬('0'을 채워서)
   단 PAD 사용 시 문자열이 지정한 자릿수를 넘기면 자릿수 이후의 문자열도 짤림
*/
SELECT LPAD('a',5,'0') as LPAD --0으로 a가 들어간 1자리를 제외한 4자리를 채움
    , RPAD('ab', 6, '*/') as RPAD
FROM DUAL;

-- LENGTH <-- 문자열 길이 반환
SELECT emp_name
    , LENGTH(emp_name)
FROM employees;

--CUSTOMERS 테이블의 전화번호 컬럼의 데이터를 *로 마스킹 처리하고 뒤 2자리만 출력되게 하시오

SELECT cust_main_phone_number,
LPAD(SUBSTR(cust_main_phone_number,-2), LENGTH(cust_main_phone_number), '*') AS masked_phone_number
FROM customers;