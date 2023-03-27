USE practics_2nd;
SELECT * FROM authors;
SELECT * FROM books;
SELECT * FROM orders;
DESC authors;
DESC books;
DESC orders;
DROP TABLE IF EXISTS authors;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS orders;


CREATE TABLE authors (
	author_id INT NOT NULL PRIMARY KEY,
	first_name VARCHAR(50),
	last_name VARCHAR(50),
	email VARCHAR(50)
);

CREATE TABLE books (
	book_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	title VARCHAR(100),
	author_id INT,
	publication_date DATE,
	FOREIGN KEY(author_id) REFERENCES authors(author_id) ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE orders (
	order_id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	book_id INT,
	customer_name VARCHAR(50),
	order_date DATE,
    FOREIGN KEY(book_id) REFERENCES books(book_id) ON UPDATE CASCADE ON DELETE CASCADE
);

INSERT INTO authors VALUES
	(1, 'J.K.', 'Rowling', 'jkrowling@gmail.com'),
	(2, 'George R.R.', 'Martin', 'grmartin@yahoo.com'),
    (3, 'Stephen', 'King', 'sking@hotmail.com');
    
INSERT INTO books VALUES
	(1, 'Harry Potter and the ~~.', 1, '1997-06-26'),
	(2, 'A Game of Thrones', 2, '1996-08-06'),
    (3, 'The Shining', 3, '1977-01-28');
    
INSERT INTO orders VALUES
	(1, 1, 'John Smith', '2022-02-15'),
	(2, 2, 'Jane Doe', '2022-02-16'),
    (3, 3, 'Bob Johnson', '2022-02-17');
    
-- 1. author_id가 1인 작성자의 이메일을 jkrowling@yahoo.com으로 업데이트하는 SQL 문을 작성합니다.

UPDATE authors SET email = 'jkrowling@yahoo.com' WHERE author_id = 1;

-- 2. books 테이블에서 book_id 2인 책을 삭제하는 SQL 문을 작성합니다.

DELETE FROM books WHERE book_id = 2;

-- 3. 다음 세부 정보가 포함된 새 책을 삽입하는 SQL 문을 작성합니다.
-- 책 ID: 4
-- 제목: 스탠드
-- 저자 ID: 3
-- 발행일자 : 1978-01-01

INSERT INTO books VALUES ('4', '스탠드', '3', '1978-01-01');

-- 4. book_id 1인 책의 출판 날짜를 1997-06-30으로 업데이트하는 SQL 문을 작성하십시오.

UPDATE books SET publication_date = '1997-06-30' WHERE book_id = 1;

-- 5. 022-02-17 이전에 접수된 모든 주문을 삭제하는 SQL 문을 작성합니다.

DELETE FROM orders WHERE order_date < '2022-02-17';
SET sql_safe_updates=0;

-- 6. 다음 세부 정보와 함께 새 주문을 삽입하는 SQL 문을 작성합니다.
-- 주문 ID: 4
-- 책 ID: 1
-- 고객 이름: 사라 존슨
-- 주문일자 : 2022-02-18

INSERT INTO orders VALUES ('4','1','사라존슨','2022-02-18');

-- 7. order_id가 1인 주문의 고객 이름을 Jack Smith로 업데이트하는 SQL 문을 작성합니다.

UPDATE orders SET customer_name = Jack_Smith WHERE order_id = 1;

-- 8. 다음 세부 정보와 함께 새 작성자를 삽입하는 SQL 문을 작성합니다.
-- 저자 ID: 4
-- 이름: 아가사
-- 성: 크리스티
-- 이메일: agatha.christie@example.com

INSERT INTO authors VALUES ('4','크리스티','아가사','agatha.christie@example.com');

-- 9. author_id 2인 작성자의 성을 Martinez로 업데이트하는 SQL 문을 작성합니다.

UPDATE authors SET last_name = 'Martinez' WHERE author_id = 2;

-- 10. author_id 3인 저자가 쓴 모든 책을 삭제하는 SQL 문을 작성합니다.

DELETE FROM authors WHERE author_id = 3;

-- < 추가 실습 >

SELECT custname, sum(amount*price) AS 'total_price'
		FROM customer INNER JOIN orders
		ON customer.custid = orders.custid
        GROUP BY custname
		ORDER BY custname;
        
SELECT * FROM authors;
SELECT * FROM books;
SELECT * FROM orders;
-- 11. Stephen King이 쓴 모든 책의 제목과 발행일을 표시합니다.
SELECT title, publication_date FROM books
	WHERE author_id = 3;
    
SELECT title, publication_date
	FROM authors JOIN books
    ON authors.author_id = books.author_id AND last_name = 'King' AND first_name = 'Stephen';

SELECT title, publication_date
		WHERE author_id = (SELECT suthor_id FROM authors WHERE last_name = 'King' AND first_name = 'Stephen');

-- 12. 책을 쓴 저자의 이름을 표시합니다.
SELECT first_name, last_name 
	FROM authors INNER JOIN books
	ON authors.author_id = books.author_id;

-- 13. 각 저자가 쓴 책의 수를 표시합니다.
SELECT first_name, last_name, count(book_id) AS 'num_books'
	FROM authors JOIN books
    ON  authors.author_id = books.author_id
    GROUP BY book_id;
    
-- 14. 2022년 2월 16일 이후에 발생한 모든 주문에 대한 책 제목과 고객 이름을 표시합니다.
SELECT title, customer_name
	FROM orders JOIN books
    ON books.book_id = orders.book_id AND order_date >= '2022-02-16';
    