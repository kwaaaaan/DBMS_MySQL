-- 현재 존재하는 데이터베이스를 확인하는 명령어
SHOW DATABASES;
-- 데이터 조회 '*'은 모든 정보를 조회
SELECT * FROM customer;
SELECT * FROM orders;
-- custid 속성만
SELECT custid FROM customer;
-- 모든 고객의 고객아이디와 생년월일을 검색, 검색 순서에따라 테이블의 순서가 바뀜
SELECT custid, birth FROM customer;
SELECT birth, custid FROM customer;
-- 모든 고객의 아이디, 주소, 전화번호, 이름, 생년월일 검색
SELECT custid, addr phone, custname, birth FROM customer;
-- (와일드카드 사용 '*(모든것을 의미)') 모든 고객의 아이디, 이름, 주소, 전화번호, 생년월일 검색
SELECT * FROM customer;
-- ------------
-- ------------
-- 고객 테이블에 있는 모든 주소를 검색(중복 포함 결과)
SELECT addr FROM customer;
-- 고객 테이블에 있는 주소 검색(중복 제외)
SELECT DISTINCT addr FROM customer;
-- -------------------------------------------------------
-- < WHERE 절 >
-- 비교 : = / > / < / =< / >=
-- 고객 이름이 강해린인 고객을 검색
SELECT custid, custname FROM customer WHERE custname = '강해린';
SELECT * FROM customer WHERE custname = '강해린';

-- 제품 가격이 4000원 이상인 주문 내역을 검색
SELECT prodname, price FROM orders WHERE price >= 4000;
SELECT * FROM orders WHERE price >= 4000;

-- 범위검색* 범위 : BETWEEN a AND b
-- 1995년 이상 2000년 이하 출생 고객 검색
SELECT * FROM customer WHERE birth BETWEEN '1995-01-01' AND '2000-12-31';
SELECT * FROM customer WHERE birth >= '1995-01-01' AND birth <= '2000-12-31';

-- 집합 관련
-- 주소가 서울 혹은 런던인 고객 검색
SELECT * FROM customer WHERE addr IN ('대한민국 서울', '영국 런던');
SELECT * FROM customer WHERE addr = '대한민국 서울' OR addr = '영국 런던';
SELECT * FROM customer WHERE addr LIKE '대한민국 서울' OR addr LIKE '영국 런던';
-- 주소가 서울 혹은 런던이 아닌 고객 검색
SELECT * FROM customer WHERE addr NOT IN ('대한민국 서울', '영국 런던');
SELECT * FROM customer WHERE addr != '대한민국 서울' OR addr != '영국 런던';

-- 패턴 (LIKE) : 특정 패턴을 포함하는 데이터를 검색할때 사용
-- 주소가 '미국 로스앤젤레스'인 고객 검색
SELECT * FROM customer WHERE addr LIKE '미국 로스앤젤레스';
SELECT * FROM customer WHERE addr = '미국 로스앤젤레스';
-- 주소에 '미국'이 포함되어있는 고객 검색
-- % : 0개 이상의 문자를 의미, _ : 1개 이상의 단일문자
-- 검출 가능한 케이스 예시 : '미국', '미국 ', '미국 워싱턴', '미국 로스엔젤레스', ...
-- 검출할 떄에는 'LIKE'만 사용 가능함!
SELECT * FROM customer WHERE addr LIKE '미국%';
SELECT * FROM customer WHERE addr LIKE '미국_'; -- 검출 가능한 케이스 : '미국 ', '미국땅' 등 3글자만 검출가능함
SELECT * FROM customer WHERE addr LIKE '_미국_'; -- 검출 가능한 케이스 : '진미국밥 ', '난미국인' 등 중간에 미국이 들어간 경우만 검출가능함
-- 고객 이름 두번째 글자가 '지'인 고객 검색
SELECT * FROM customer WHERE custname LIKE '_지_'; -- 이름이 3글자인 경우만 가능
SELECT * FROM customer WHERE custname LIKE '_지%'; -- 모두 가능
SELECT * FROM customer WHERE custname LIKE '%지%'; -- 그냥 이름에 '지'가 들어간 경우
SELECT * FROM customer WHERE custname LIKE '%지_'; -- 뒤에서 두번째가 '지'인 사람
-- 고객 이름 세번째 글자가 '수'인 고객 검색
SELECT * FROM customer WHERE custname LIKE '__수';
SELECT * FROM customer WHERE custname LIKE '__수%';
-- 복합조건 (AND, OR, NOT)
-- 주소지가 대한민국이고, 2000년 이후 출생 고객 검색
SELECT * FROM customer WHERE addr LIKE '대한민국%' AND birth >= '2000-01-01';
-- 주소지가 미국이거나 영국인 고객 검색
SELECT * FROM customer WHERE addr LIKE '미국%' OR addr LIKE '%영국%';
-- 휴대폰 번호 마지막 자리가 4가 아닌 고객 검색
SELECT * FROM customer WHERE phone NOT LIKE '%4' ;

-- < ORDER BY >
-- ORDER BY절을 사용하지 않는경우, PK를 기준으로 정렬함
SELECT * FROM customer;
-- ORDER BY를 사용하는 경우 custname속성 기준으로 기본적으로'오름차순'정렬 함
SELECT * FROM customer ORDER BY custname; -- 아래의 표에 있는 custname을 눌러도 custname을 기준으로 정렬 가능
SELECT * FROM customer ORDER BY custname DESC; -- 내림차순으로 정렬할때 명령어


-- WHERE절이 있는 OREDER BY
-- 에러뜸! --> SELECT * FROM customer ORDER BY  addr DESC WHERE birth >= '2000-01-01';
-- 2000년 이후 출생자 중 주소를 기준으로 내림차순 정렬
SELECT * FROM customer WHERE birth >= '2000-01-01' ORDER BY  addr DESC;
-- 2000년 이후 출생자 중 주소를 기준으로 내림차순 정렬 만약, 주소가 같다면, custid로 내림차순 정렬
SELECT * FROM customer WHERE birth >= '2000-01-01' ORDER BY  addr DESC, custid DESC;

-- <LIMIT>
-- 고객 테이블 전체 정보를 조회하는데, 앞의 2건만 조회하고 싶은 경우, LIMIT은 제일 뒤에 씁니다~
-- LIMIT 형식 : LIMIT 시작, 개수 == LIMIT 개수 OFFSET 시작 --> EX) LIMIT 2 == LIMIT 0,2 == LIMIT 2 OFFSET 0
SELECT * FROM customer LIMIT 2;
-- 고객 테이블 전체 정보를 조회하는데, 두번째부터 여섯번째 행만 조회하고 싶은 경우
SELECT * FROM customer LIMIT 1, 5; -- 주의! LIMIT에서의 시작 숫자는 1이 아니라 0임!
SELECT * FROM customer LIMIT 5 OFFSET 1; -- 주의! LIMIT에서의 시작 숫자는 1이 아니라 0임!

-- 2000년 이후 출생 고객 중에서 앞의 2건만 조회하고 싶은 경우
SELECT * FROM customer WHERE birth >= '2000-01-01' LIMIT 2;
-- 2000년 이후 출생 고객 중에서 뒤의 2건만 조회하고 싶은 경우
SELECT * FROM customer WHERE birth >= '2000-01-01' ORDER BY custid DESC LIMIT 2;

-- <IS NULL>
SELECT * FROM customer WHERE phone IS NULL; -- customer table에서 phone에 null값인 애들 조회
SELECT * FROM customer WHERE phone IS NOT NULL; -- customer table에서 phone에 null값이 아닌애들 조회
DESC customer; -- customer의 정보를 볼 수 있는 명령어
