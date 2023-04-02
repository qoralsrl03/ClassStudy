SELECT
    *
FROM
    member;

SELECT
    mem_id,
    mem_name,
    mem_mail,
    ( mem_add1
      || ' '
      || mem_add2 ) AS address,
    CASE
        WHEN substr(mem_regno2, 1, 1) = 1 THEN
            '남자'
        ELSE
            '여자'
    END AS gender
FROM
    member
WHERE
    mem_add1 LIKE '대전%'
    AND mem_add1 LIKE '%서구%';

-- 1. 숫자함수
/* ROUND(반올림), TRUNC(올림)*/
-- 2. 날짜 함수
/* SYSDATE, SYSTIMESTAMP, ADD_MONTHS(date,integer) */

SELECT
    round(10.5904, 2) AS first-- 소수점 둘째자리까지 표기하며 나머지 반올림
    ,
    round(10.5904, 1) -- 소수점 첫째자리까지 표기하며 나머지 반올림
    ,
    round(10.4) -- 소수점 이하 반올림 
    ,
    round(16.5904, - 1) -- 소수점 기준 왼쪽 반올림(여기서는 일의자리 6을 반올림하고 10단위 아래를 없앰)
    ,
    trunc(10.5994, 2) -- 소수점 아래 둘째자리까지만 표기하고 나머지 아래는 버림
    ,
    mod(4, 2) -- 4를 2로나눈 나머지 값
    ,
    mod(5, 2)
FROM
    dual;

SELECT
    sysdate,
    systimestamp,
    sysdate + 1 --날짜 하루 추가
FROM
    dual;

SELECT
    add_months(sysdate, 1) -- 다음달 날짜 반환
    ,
    add_months(sysdate, - 1) -- 전달 날짜 반환
    ,
    last_day(sysdate)       ---- 해당월의 마지막 날짜 반환
FROM
    dual;
    
--이번달이 몇일 남았는지 출력하시오

SELECT
    ( last_day(sysdate) - sysdate
      || '일 남음...' )
FROM
    dual;

--NEXT_DAY

SELECT
    next_day(sysdate, '목요일') -- 다음 목요일 가져옴
    ,
    next_day(sysdate, '금요일') -- 다음 금요일 가져옴
FROM
    dual;

--현재 나이 구하기

SELECT
    mem_name,
    mem_bir,
    sysdate - mem_bir,
    round((round(sysdate) - mem_bir) / 365) AS 나이
FROM
    member
ORDER BY
    3;

SELECT
    round(sysdate, 'month') --일수 반올림
    ,
    round(sysdate, 'year') -- 월수 이하 반올림
    ,
    trunc(sysdate, 'month') -- 일수 버림
    ,
    trunc(sysdate, 'year') -- 월수 이하 버림
FROM
    dual;

/*--------------- 변환 함수----------------*/
--day, MM, YYYY 등등 기준 문자열로 바꿀 수 있음 // to_char('123456', '999,999');
--TO_NUMBER = 숫자타입으로 변환
--To_DATE = 날짜타입으로 변환

SELECT
    to_char(sysdate, 'day'),
    to_char(123456, '999,999'),
    to_char(sysdate, 'yyyy-mm-dd hh12:mi:ss')
FROM
    dual;

SELECT
    TO_DATE('2022*01*01', 'yyyy*mm*dd')
FROM
    dual;

CREATE TABLE ex4_1 (
    col1 VARCHAR2(1000)
);

INSERT INTO ex4_1 VALUES ( '111' );

INSERT INTO ex4_1 VALUES ( '99' );

INSERT INTO ex4_1 VALUES ( '1111' );
--문자열로 선언 시 정렬하면 99가 1111보다 크게 노출되어 to_number로 문자열을 숫자열로 재변환

SELECT
    *
FROM
    ex4_1
ORDER BY
    to_number(col1) DESC;

--데이 계산

CREATE TABLE tb_myday (
    mem_id    VARCHAR2(100),
    d_title   VARCHAR2(1000),
    d_day     VARCHAR2(8)
);

INSERT INTO tb_myday VALUES (
    'a001',
    '연인이 된날',
    '20170815'
);

INSERT INTO tb_myday VALUES (
    'a001',
    '과정 시작일',
    '20230320'
);
-- 1. a001 회원의 과정 시작일로부터 100일의 날짜
-- 2. 1번의 결과 일자까지 몇일 남았는지
-- 3. 과정시작일 부터 몇일이 지났는지 출력하세요(네이버 dday기준)

--1. 

SELECT
    to_char(to_date(d_day) + 99, 'yyyy.mm.dd'),
    to_date(d_day) + 99 - round(sysdate),
    round(sysdate) - to_date(d_day)
FROM
    tb_myday
WHERE
    d_title = '과정 시작일';

/*NULL 관련 함수 NVL*/
-- NULL 값을 0으로 바꿀 수 있음 NVL(컬럼명, 바꿀 값)

SELECT
    emp_name,
    salary,
    commission_pct,
    salary * nvl(commission_pct, 0) AS "이번 상여금"
FROM
    employees;

SELECT
    emp_name,
    nvl(commission_pct, 0)
FROM
    employees
WHERE
    nvl(commission_pct, 0) < 0.2;

/*=============기본 집계 함수 =============*/
--select에서 조회하는 값은 group by에서 묶은 그룹 안에 속해야한다.   
--HAVING = GROUP BY의 조건 
/*종류: AVG, MIN, MAX, SUM, COUNT */

SELECT
    COUNT(*), --NULL 포함
    COUNT(department_id), --default ALL
    COUNT(ALL department_id), -- null 제외, 하지만 중복은 포함
    COUNT(DISTINCT department_id) -- 중복 제외
FROM
    employees;

SELECT
    SUM(salary),
    round(AVG(salary), 2),
    MIN(salary),
    MAX(salary)
FROM
    employees;
    
-- member 테이블을 활용하여 회원의 수와 평균 마일리지를 출력하시오

SELECT
    *
FROM
    member;

SELECT
    COUNT(mem_name),
    round(AVG(mem_mileage), 2)
FROM
    member;

DESC employees;

SELECT
    department_id,
    COUNT(*) AS 사원수
FROM
    employees
WHERE
    department_id IS NOT NULL
GROUP BY
    department_id --일단 department_id 리스트를 펼치고 생각한다고 여기면 편함
HAVING
    COUNT(department_id) > 5
ORDER BY
    사원수; --order by는 제일 마지막에 실행되기 때문에 select에서 선언한 alias를 사용 가능함

/*이중 그룹*/

SELECT
    department_id,
    job_id,
    COUNT(*) AS 사원수  -- 집계함수를 제외한
FROM
    employees
GROUP BY
    department_id,
    job_id
ORDER BY
    1;

--member 회원의 직업별 회원수와, 평균 마일리지를 그룹별 3명 이상인 직군의 평균 마일리지 내림차순으로 정렬 후 출력하시오

SELECT
    mem_job,
    COUNT(*),
    round(AVG(mem_mileage), 2) AS "평균 마일리지"
FROM
    member
GROUP BY
    mem_job  -- 하나의 키워드 ex. 학생 이라는 키워드로 중복되는 애들은 나머지 테이블을 하나로 묶음
HAVING
    COUNT(mem_job) >= 3
ORDER BY
    "평균 마일리지" DESC;
    
-- 년도별 대출합계

SELECT
    substr(period, 1, 4) AS 년도,
    SUM(loan_jan_amt) AS 대출합계
FROM
    kor_loan_status
GROUP BY
    substr(period, 1, 4)
ORDER BY
    1;
    
-- 2013년도 지역별 대출의 합계

SELECT
    *
FROM
    kor_loan_status;

SELECT
    region,
    SUM(loan_jan_amt)
FROM
    kor_loan_status
WHERE
    period LIKE ( '2013%' )
GROUP BY
    region
ORDER BY
    2 DESC;
    
--employees 테이블
--직원의 고용년도별 사원수, 총급여를 출력하시오
select to_date(hire_date) from employees;

SELECT
    to_char(to_date(hire_date), 'YYYY') as 년도,
    COUNT(*) as 사원수,
    SUM(salary) as 총급여
FROM
    employees
GROUP BY
    to_char(    (hire_date), 'YYYY')
ORDER BY
    COUNT(*) DESC;
    