--Q.1
--employees 테이블
--직원의 고용년도별 사원수, 총급여를 출력하시오
SELECT
    to_char(to_date(hire_date), 'YYYY') AS 년도,
    COUNT(*) AS 사원수,
    SUM(salary) AS 총급여
FROM
    employees
GROUP BY
    to_char(to_date(hire_date), 'YYYY')
ORDER BY
    COUNT(*) DESC;
    
--Q.2
--3월에 고용된 직원의 수

SELECT
    COUNT(*)
FROM
    employees
WHERE
    to_char(hire_date, 'MM') LIKE '%03%';
    
--Q.3
--Customers 테이블에서
--cust_marital_status 별 고객수를 출력하시오
--cust_marital_status 널 제외

SELECT
    cust_marital_status,
    COUNT(cust_marital_status) AS 고객수
FROM
    customers
WHERE
    cust_marital_status IS NOT NULL
GROUP BY
    cust_marital_status
ORDER BY
    2 DESC;

--Q.4
-- Products를 활용하여 카테고리, 서브카테고리별 상품수를 출력하시오
-- 상품수 3개 이상만 출력( 정렬 : 카테고리 오름차순 )

SELECT
    prod_category,
    prod_subcategory,
    COUNT(prod_subcategory) AS 상품수
FROM
    products
GROUP BY
    prod_category,
    prod_subcategory
HAVING
    COUNT(prod_subcategory) >= 3
ORDER BY
    prod_category;