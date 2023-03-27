SELECT * FROM orders;
SELECT * FROM customer;

SELECT COUNT(*) FROM customer;
SELECT COUNT(*) FROM orders;

-- WHERE절이 없는 경우
SELECT * FROM customer, orders;

-- A고객이 orders의 19개 행과 결합, B고객이 orders의 19개 행과 결함, ... --> 구조가 이상함
-- *참고. [테이블이름.테이블명] 표기 : 특정 테이블의 열을 가르킴
-- [테이블이름.테이블명]이 조인조건임
SELECT * FROM customer, orders WHERE customer.custid = orders.custid;
SELECT * FROM customer INNER JOIN orders ON customer.custid = orders.custid;
SELECT * FROM customer  JOIN orders ON customer.custid = orders.custid; -- JOIN의 디폴트값은 INNER임

-- 
SELECT *
		FROM customer, orders
		WHERE customer.custid = orders.custid
        ORDER BY customer.custid;
SELECT *
		FROM customer INNER JOIN orders
        ON customer.custid = orders.custid
        ORDER BY customer.custid;

-- 고객별로 주문한 제품 총 구매액을 고갞별로 정렬
-- (고객이름, 총 구매액)
SELECT custname, sum(amount*price) AS 'total_price'
		FROM customer, orders
		WHERE customer.custid = orders.custid
        GROUP BY custname
        ORDER BY custname;
        
SELECT custname, sum(amount*price) AS 'total_price'
		FROM customer INNER JOIN orders
		ON customer.custid = orders.custid
        GROUP BY custname
		ORDER BY custname;
        
SELECT custname, amount*price
		FROM customer, orders
		WHERE customer.custid = orders.custid
        GROUP BY custname
        ORDER BY customer.custid;
        
-- 서브 쿼리, 부속 질의 --> SQL문 내에 또 다른 SQL문 작성, SELECT문의 WHERE절에 또 다른 테이블 경과를 이용해 다시 SELECT문을 괄호로 묶음
-- SELECT ~ FROM ~ WHERE (SELECT ~ FROM ~~);

-- STEP 1. 주문 금액이 가장 큰 주문 내역은 무엇인가?
SELECT max(price*amount) FROM orders;
-- STEP 2. 주문 금액이 가장 큰 내역의 주문아이디, 고객아이디, 상품명 조회
SELECT orderid, custid, prodname FROM orders WHERE pirce * amount = 10000;

-- STEP 3. STEP 1,2를 한번에alter
SELECT orderid, custid, prodname FROM orders 
	WHERE price * amount = (SELECT MAX(price * amount) FROM orders);

SELECT orderid, custid, prodname FROM orders 
	WHERE price * amount < (SELECT AVG(price * amount) FROM orders);

