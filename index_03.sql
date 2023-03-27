USE smartfactory_ddl;
-- CREATE 문
-- 데이터베이스 생성 + 한글 인코딩
CREATE DATABASE ddl_1st DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
-- 테이블 생성
-- 테이블명 = 속성명, 테이블이름 = 속성이름
/* CREATE TABLE 데이블명(
속성이름1, 데이터타입 PRIMARY KEY,
속성이름2, 데이터타입, 
FOREIGN KEY 속성명 REFERENCES 테이블이름(속성이름)
); */
-- ALTER 문
-- 1. 속성을 새로 추가하는 경우
-- ALTER TABLE 테이블명 ADD 속성이름 데이터타입;

-- 2. 기존 속성 삭제하는 경우
-- ALTER TABLE 테이블명 DROP COLUMN 속성이름;

-- 3. 기존 속성을 수정하는 경우
-- ALTER TABLE 테이블명 MODIFY 속성이름 데이터타입

-- DROP 문
-- 테이블 구조와 데이터 모두 삭제 --> 그냥 테이블 삭제할 경우에 씀(잘 안씀)

-- --------------------------------------------------------------------------
-- <CREATE>
-- 데이터베이스 생성 + 한글 인코딩
-- 한글 인코딩 : 프로그래밍 언어는 영어 기반이므로, 한글을 사용할 수 있도록 만들어주는 명령어
CREATE DATABASE SMARTFACTORY_DDL DEFAULT CHARACTER SET utf8 DEFAULT COLLATE utf8_general_ci;
CREATE DATABASE new_smartfactory CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;

-- 테이블 생성
-- new_customer 테이블
-- custid(고객번호) CHAR(10), NOT NULL 제약조건, PK
-- custname(고객이름) VARCHAR(10), NOT NULL 제약조건
-- addr (주소) CHAR(10), NOT NULL 제약조건
-- phone (연락처) CHAR(11)
-- birth (생년월일) DATE

-- 1. 기본키 제약조건 --> 키본키는 중복불가, NULL 불가
CREATE TABLE new_customer (
	custid char(10) NOT NULL PRIMARY KEY, -- PRIMARY KEY를 사용하면 굳이 NOT NULL을 쓸필요는 없지만 그냥 씀
	custname varchar(10) NOT NULL,
	addr char(10) NOT NULL,
	phone char(11),
	birth date
);
DESC new_customer;
SELECT * FROM new_customer;

-- 외래키 제약조건
-- 두 테이블 사이의 관계를 맺어줌 --> 다른 테이블의 기본키를 현재 테이블의 외래키로 연결함
-- 기본키를 갖는 테이블 : "기준" 테이블
-- 외래키를 갖는 테이블 : "참조" 테이블
-- 형식 : FOREIGN KEY(열_이름) REFERENCES 기준_테이블(열_이름)

-- CASCADE
-- ON UPDATE CASCADE : 기준 테이블의 데이터 변경 --> 참조테이블 데이터도 변경
-- ON DELETE CASCADE : 기준 테이블의 데이터 삭제 --> 참조테이블 데이터도 삭제
-- 두개의 관계는 독립적임
CREATE TABLE new_orders (
	orderid INT NOT NULL PRIMARY KEY AUTO_INCREMENT, -- PRIMARY KEY를 사용하면 굳이 NOT NULL을 쓸필요는 없지만 그냥 씀
	custid CHAR(10) NOT NULL,
	prodname CHAR(6) NOT NULL,
	price INT NOT NULL,
	amount SMALLINT NOT NULL,
    FOREIGN KEY(custid) REFERENCES new_customer(custid) ON UPDATE CASCADE ON DELETE CASCADE
);
DESC new_orders;
DROP TABLE new_orders;

INSERT INTO new_customer VALUES ('kiwi', '김키위', '대한민국 서울', '01012341234', '1990-03-17');
INSERT INTO new_customer VALUES ('apple', '이사과', '대한민국 포항', '01012344321', '1992-06-17');
INSERT INTO new_orders VALUES (NULL, 'kiwi', '프링글스', '3000', 5);
INSERT INTO new_orders VALUES (NULL, 'apple', '프링글스', '3000', 1);
INSERT INTO new_orders VALUES (NULL, 'kiwi', '홈런볼', '2000', 3);

SELECT * FROM new_orders;
DESC new_customer;

-- <ALTER>
-- 새로운 속성 추가 --> 고객 테이블에 'nickname'추가
ALTER TABLE new_customer ADD nickname VARCHAR(10);

-- 속성 수정
-- 1) 데이터 타입 수정
ALTER TABLE new_customer MODIFY nickname INT;
-- 2) 속성명 변경
ALTER TABLE new_customer CHANGE nickname n_name VARCHAR(10);

-- 기존 속성 삭제
ALTER TABLE new_customer DROP n_name;
USE smartfactory_ddl;
-- <DROP>
-- '기준테이블'은 '참조테이블'이 삭제되어 있지 않으면, 삭제할 수 없습니다.
-- '기준테이블'을 삭제하고 싶다면 무조건 '참조테이블' 먼저 삭제해야 합니다.
DROP TABLE new_customer;
DROP TABLE new_orders;

CREATE TABLE new_user (
	id VARCHAR(10) NOT NULL PRIMARY KEY,
    pw VARCHAR(20) NOT NULL,
    name VARCHAR(5) NOT NULL,
    gender CHAR(1),
    birthday DATE NOT NULL,
    age INT NOT NULL
);
DESC new_user;

CREATE TABLE member_1(
	id VARCHAR(20) NOT NULL PRIMARY KEY,
	name VARCHAR(5) NOT NULL,
	age INT(5),
    gender VARCHAR(2) NOT NULL,
    email VARCHAR(50),
    promotion VARCHAR(2) DEFAULT 'X'
);
DESC member_1;

ALTER TABLE member MODIFY id VARCHAR(20);
ALTER TABLE member DROP age;
ALTER TABLE member ADD interest VARCHAR(100);
