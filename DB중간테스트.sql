select*from address;
/*
 STUDY 계정에 create_table 스크립트를 실해하여 
 테이블 생성후 1~ 5 데이터를 임포트한 뒤 
 아래 문제를 출력하시오 
 (문제에 대한 출력물은 이미지 참고)
 모든 문제 풀이 시작시간과 종료시간을 작성해 주세요 
*/
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 시작시간 FROM DUAL;
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS') as 종료시간 FROM DUAL;
-----------1번 문제 ---------------------------------------------------
--1988년 이후 출생자의 직업이 의사,자영업 고객을 출력하시오 (어린 고객부터 출력)
--시작시간 : 2023-03-31 14:02:41
--종료시간 : 2023-03-31 14:06:45

/* 작성 쿼리 */
select *
from customer
where (job = '의사' or job = '자영업') and substr(birth,1,4)>=1988
order by birth desc;

---------------------------------------------------------------------
-----------2번 문제 ---------------------------------------------------
--강남구에 사는 고객의 이름, 전화번호를 출력하시오 
--시작시간 : 2023-03-31 14:06:57
--종료시간 : 2023-03-31 14:10:34

/* 작성 쿼리 */
select customer_name, phone_number
from address a, customer b
where a.zip_code = b.zip_code
and a.address_detail = '강남구';

---------------------------------------------------------------------
----------3번 문제 ---------------------------------------------------
--CUSTOMER에 있는 회원의 직업별 회원의 수를 출력하시오 (직업 NULL은 제외)
--시작시간 : 2023-03-31 14:10:42
--종료시간 : 2023-03-31 14:13:11

/* 작성 쿼리 */
select job, count(job) as CNT
from customer
where job is not null
group by job
order by count(*) desc;
---------------------------------------------------------------------
----------4-1번 문제 ---------------------------------------------------
-- 가장 많이 가입(처음등록)한 요일과 건수를 출력하시오 
--시작시간 : 2023-03-31 14:13:19
--종료시간 : 2023-03-31 14:19:26

/* 작성 쿼리 */
select *
from    (select to_char(first_reg_date, 'day') as 요일, count(to_char(first_reg_date, 'day')) as 건수
    from customer
    group by to_char(first_reg_date, 'day')
    order by 건수 desc)
where rownum =1;
---------------------------------------------------------------------
----------4-2번 문제 ---------------------------------------------------
-- 남녀 인원수를 출력하시오 
--시작시간 : 2023-03-31 14:19:47
--종료시간 : 2023-03-31 14:32:43

/* 작성 쿼리 */
        select nvl(decode(sex_code,'M','남자','F','여자',null,'미등록'),'합계') as GENDER,
        count(decode(sex_code,'M','남자','F','여자',null,'미등록')) as CNT
        from customer
        group by rollup(decode(sex_code,'M','남자','F','여자',null,'미등록'))
        order by count(decode(sex_code,'M','남자','F','여자',null,'미등록'));
    
---------------------------------------------------------------------
----------5번 문제 ---------------------------------------------------
--월별 예약 취소 건수를 출력하시오 (많은 달 부터 출력)
--시작시간 : 2023-03-31 14:32:52
--종료시간 : 2023-03-31 14:38:20

/* 작성 쿼리 */
select * from reservation;

select substr(reserv_date,5,2) as 월,count(cancel) as 취소건수
from reservation
where cancel = 'Y'
group by substr(reserv_date,5,2)
order by count(cancel) desc;
---------------------------------------------------------------------
----------6번 문제 ---------------------------------------------------
 -- 전체 상품별 '상품이름', '상품매출' 을 내림차순으로 구하시오
--시작시간 : 2023-03-31 14:38:28
--종료시간 : 2023-03-31 14:45:23

/* 작성 쿼리 */
select * from item;
select * from order_info;
desc order_info;

select a.product_name as 상품이름, sum(sales) as 상품매출
from item a, order_info b
where a.item_id = b.item_id
group by product_name
order by sum(sales) desc;


-----------------------------------------------------------------------------
---------- 7번 문제 ---------------------------------------------------
-- 모든상품의 월별 매출액을 구하시오 
-- 매출월, SPECIAL_SET, PASTA, PIZZA, SEA_FOOD, STEAK, SALAD_BAR, SALAD, SANDWICH, WINE, JUICE
--시작시간 : 2023-03-31 14:45:38
--종료시간 : 2023-03-31 15:04:10

/* 작성 쿼리 */
    select  substr(reserv_no,1,6) as 매출월,
        sum(decode(product_name,'SPECIAL_SET',SALES)) as special_set, 
        sum(decode(product_name,'PASTA',SALES)) as PASTA,
        nvl(sum(decode(product_name,'PIZZA',SALES)),0) as PIZZA,
        nvl( sum(decode(product_name,'SEA_FOOD',SALES)),0) as SEA_FOOD,
        sum(decode(product_name,'STEAK',SALES)) as STEAK,
        nvl(sum(decode(product_name,'SALAD_BAR',SALES)),0) as SALAD_BAR,
        nvl(sum(decode(product_name,'SALAD',SALES)),0) as SALAD,
        sum(decode(product_name,'SANDWICH',SALES)) as SANDWICH,
        nvl(sum(decode(product_name,'WINE',SALES)),0) as WINE,
        sum(decode(product_name,'JUICE',SALES)) as JUICE
    from item a, order_info b
    where a.item_id = b.item_id
    group by substr(reserv_no,1,6)
    order by substr(reserv_no,1,6);
----------------------------------------------------------------------------
---------- 8번 문제 ---------------------------------------------------
-- 월별 온라인_전용 상품 매출액을 일요일부터 월요일까지 구분해 출력하시오 
-- 날짜, 상품명, 일요일, 월요일, 화요일, 수요일, 목요일, 금요일, 토요일의 매출을 구하시오 
--시작시간 : 2023-03-31 15:04:21
--종료시간 : 2023-03-31 15:26:33

/* 작성 쿼리 */
select to_char(달력,'YYYYMM') as 날짜
       ,nvl(sum(decode(요일,'일요일',돈)),0) as 일요일
       ,nvl(sum(decode(요일,'월요일',돈)),0) as 월요일
       ,nvl(sum(decode(요일,'화요일',돈)),0) as 화요일
       ,nvl(sum(decode(요일,'수요일',돈)),0) as 수요일
       ,nvl(sum(decode(요일,'목요일',돈)),0) as 목요일
       ,nvl(sum(decode(요일,'금요일',돈)),0) as 금요일
       ,nvl(sum(decode(요일,'토요일',돈)),0) as 토요일
from  ( select to_date(reserv_no,'YYYYMMDDHH') as 달력,to_char(to_date(reserv_no,'YYYYMMDDHH'),'day') as 요일,
            sum(b.sales) as 돈
         from item a, order_info b
        where a.item_id = b.item_id
        and a.product_name = 'SPECIAL_SET'
        group by to_date(reserv_no,'YYYYMMDDHH'), reserv_no, 'YYYYMMDDHH', to_char(to_date(reserv_no,'YYYYMMDDHH'),'day')
      )
group by to_char(달력,'YYYYMM')
order by to_char(달력,'YYYYMM');
----------------------------------------------------------------------------
---------- 9번 문제 ----------------------------------------------------
-- 고객수, 남자인원수, 여자인원수, 평균나이, 평균거래기간(월기준)을 구하시오 
-- (성별 NULL 제외, 생일 NULL  제외, MONTHS_BETWEEN, AVG, ROUND 사용(소수점 1자리 까지) 나이계산 
--시작시간 : 2023-03-31 15:26:42
--종료시간 : 2023-03-31 16:25:45

/* 작성 쿼리 */

select 고객수, 남자, 여자, 평균나이, 평균거래기간_년
from   (
        select (round(avg(to_char(sysdate,'yyyy') - substr(a.birth,1,4)),1)) as 평균나이,
          (round(avg(months_between(sysdate,to_date(substr(c.reserv_no,1,8),'yyyymmdd')))/12,1)) as 평균거래기간_년
            from customer a, reservation b, order_info c 
            where a.customer_id = b.customer_id
            and b.reserv_no = c.reserv_no
         ),
         (
            select sum(count(decode(sex_code,'M','남자','F','여자',null,'미등록'))) as 고객수,
            sum(count(decode(sex_code,'M','남자',1,0))) as 남자,
            sum(count(decode(sex_code,'F','여자',1,0))) as 여자
            from customer
            where sex_code is not null
            and birth is not null
            group by sex_code
);


----------------------------------------------------------------------------
---------- 10번 문제 ----------------------------------------------------
--매출이력이 있는 고객의 주소, 우편번호, 해당지역 고객수를 출력하시오
--시작시간 : 2023-03-31 16:26:01
--종료시간 : 2023-03-31 17:25:46

/* 작성 쿼리 */

select a.address_detail, count(a.address_detail)
from address a, 
    (
        select zip_code
        from customer a,
        (
        select distinct customer_id as id
        from reservation a, order_info b
        where a.reserv_no = b.reserv_no
        )b
        where a.customer_id = id 
    ) b
where a.zip_code = b.zip_code
group by a.address_detail
order by count(a.address_detail) desc;

    -----------------------------------------------------------