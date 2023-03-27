
-- DML : SELECT, INSERT, UPDATE, DELETE

SHOW DATABASES;
USE smartfactory_ddl;
DESC new_customer;
SELECT * FROM new_customer;
SELECT * FROM new_orders;

-- 기존에 있던 테이블에 데이터 추가
-- CASE 1
INSERT INTO new_customer (custid, custname, addr, phone, birth)
	VALUES('lucky', '강해원', '미국 뉴욕', '01022223333', '2002-03-05');
INSERT INTO new_customer (birth, custid, custname, addr, phone)
	VALUES('2007-04-28', 'wow', '이지은', '대한민국 부산', '01098765432');
    
-- CASE 2
INSERT INTO new_customer VALUES ('happy', '최시은', '일본 오키나와', '01033331234', '1970-10-31');

-- 여러명을 추가
-- CASE 1
INSERT INTO new_customer VALUES ('happy', '최시은', '일본 오키나와', '01033331234', '1970-10-31');
INSERT INTO new_customer VALUES ('happy', '최시은', '일본 오키나와', '01033331234', '1970-10-31');
INSERT INTO new_customer VALUES ('happy', '최시은', '일본 오키나와', '01033331234', '1970-10-31');
INSERT INTO new_customer VALUES ('happy', '최시은', '일본 오키나와', '01033331234', '1970-10-31');

-- CASE 2
INSERT INTO new_customer VALUES
	('asdf', '강세희', '대한민국 부산', '01033331235', '2004-11-11'),
	('sdfg', '윤지성', '일본 도쿄', '01033331236', '1995-02-15'),
    ('dfgh', '이재은', '미국 뉴욕', '01033331237', '2004-06-07');
    
-- < UPDATE >
UPDATE new_customer SET addr = '대한민국 서울' WHERE custid = 'apple';
-- 밑의 경우를 사용할 시 설정 필요!!
SET sql_safe_updates = 0; -- 너무 많이 바뀌는 경우 --> 안전장치 해제코드 SET sql_safe_updates = 0;
UPDATE new_customer SET addr = '대한민국 서울' WHERE custid LIKE '%y';

-- < DELETE >
-- FK되어있는 경우 연쇄삭제!
DELETE FROM new_customer WHERE custid = ' ';
DELETE FROM new_customer WHERE custid = 'kiwi';
