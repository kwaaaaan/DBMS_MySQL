USE smartfactory_ddl;
SELECT * FROM new_customer;
-- 현재 root 사용자만 존재~
-- => 새로운 사용자(우저, 계정) 추가 (codee)
-- CREATE USER [계정명]@[접속경로] IDENTIDIED BY [비밀먼호];
CREATE USER 'codee2'@'localhost' IDENTIFIED BY '1234';
CREATE USER 'lucky'@'localhost' IDENTIFIED BY '1234';
CREATE USER 'happy'@'localhost' IDENTIFIED BY '1234';

-- 참고) MySQL 사용자 비밀번호 변경
ALTER USER 'codee2'@'localhost' IDENTIFIED WITH mysql_native_password BY '4321';
FLUSH PRIVILEGES;

-- 새로 생성한 사용자 확인
SELECT user FROM mysql.user; -- mysql.user : mysql db의 user table을 의미
-- < GRANT(권한부여) >
-- GRANT [권한 유형] ON [데이터베이스 이름].[테이블 이름] TO [계정명@접속경로] [WIHT GRANT OPTION];

-- EX. codee2 사용자에게 모든 데이터베이스의 모든 테이블에 모든 권한 부여
-- 모든 데이터베이스의 모든 테이블 : *.*
-- 모든 권한부여 : GRANT ALL PRIVILEGES
-- WITH GRANT OPTION : 권한을 다른 사용자한테 부여할 수 있는 기능
GRANT ALL PRIVILEGES ON *.* TO 'codee2'@'localhost' WITH GRANT OPTION;

	-- root -> codee2 -> ?
GRANT ALL PRIVILEGES ON *.* TO 'codee2'@'localhost' WITH GRANT OPTION;

-- GRANT [권한 유형] ON [데이터베이스이름].[테이블이름] 
-- GRANT ALL PRIVILEGES ON [데이터베이스이름].*

-- => 특정 데이터베이스의 모든 테이블에 / 모든 권한 부여 
-- GRANT ALL PRIVILEGES ON [데이터베이스이름].[테이블이름] 
-- => 특정 데이터베이스의 특정 테이블에 / 모든 권한 부여

-- GRANT SELECT ON [데이터베이스이름].[테이블이름] 
-- => 특정 데이터베이스의 특정 테이블에 / SELECT 권한 부여

-- GRANT SELECT, INSERT ON [데이터베이스이름].[테이블이름]
-- => 특정 데이터베이스의 특정 테이블에 / SELECT, INSERT 권한 부여 

-- 계정 삭제
drop user 'codee'@'localhost';
flush privileges;

-- <REVOKE(권한 박탈)>
-- REVOKE [권한 유형] ON [데이터베이스 이름].[테이블 이름] FROM [계쩡명@접속경로];
REVOKE DELETE ON *.* FROM 'codee2'@'localhost';
REVOKE ALL ON *.* FROM 'codee2'@'localhost';