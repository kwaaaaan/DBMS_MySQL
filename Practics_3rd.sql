USE practics_3rd;
DESC employees;
DESC jobs;
DESC departments;
SELECT * FROM jobs;
SELECT * FROM employees;
SELECT * FROM departments;
CREATE TABLE employees (
	employee_id INT NOT NULL PRIMARY KEY,
	frist_name VARCHAR(50),
	last_name VARCHAR(50),
	emali VARCHAR(100),
	phone_number VARCHAR(20),
	hire_date DATE,
	job_id INT,
    salary DECIMAL(8,2),
    commission_pct DECIMAL(4,2),
    manager_id INT,
    department_id INT
);

CREATE TABLE jobs (
	job_id INT NOT NULL PRIMARY KEY, 
    job_title VARCHAR(50), 
    min_salary DECIMAL(8,2), 
    max_salary DECIMAL(8,2)
);


ALTER TABLE jobs ADD FOREIGN KEY (job_id) REFERENCES employees (employee_id);
ALTER TABLE employees RENAME COLUMN frist_name TO first_name;
ALTER TABLE departments ADD FOREIGN KEY (department_id) REFERENCES jobs (job_id)
ON DELETE CASCADE ON UPDATE CASCADE;

CREATE TABLE departments (
	department_id INT NOT NULL PRIMARY KEY,
    department_name VARCHAR(50),
    manager_id INT,
    location_id VARCHAR(50)
);

ALTER DATABASE practics_3rd CHARACTER SET = utf8mb4 COLLATE = utf8mb4_unicode_ci;
USE practics_3rd;

DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS jobs;
DROP TABLE IF EXISTS departments;

-- create employees table

INSERT INTO employees VALUES
  (1, 'John', 'Doe', 'johndoe@example.com', '555-1234', '2021-01-01', 1, 100000.00, 0.05, 3, 1),
  (2, 'Jane', 'Smith', 'janesmith@example.com', '555-5678', '2021-02-01', 2, 80000.00, NULL, 3, 1),
  (3, 'Bob', 'Johnson', 'bobjohnson@example.com', '555-9012', '2021-03-01', 1, 90000.00, 0.02, 5, 2),
  (4, 'Alice', 'Williams', 'alicewilliams@example.com', '555-3456', '2021-04-01', 3, 70000.00, NULL, 5, 2),
  (5, 'Mike', 'Brown', 'mikebrown@example.com', '555-7890', '2021-05-01', 4, 120000.00, 0.08, NULL, 3),
  (6, 'Sara', 'Lee', 'saralee@example.com', '555-2345', '2021-06-01', 4, 75000.00, NULL, 7, 4),
  (7, 'Tom', 'Jackson', 'tomjackson@example.com', '555-6789', '2021-07-01', 5, 110000.00, 0.03, NULL, 4),
  (8, 'Karen', 'Davis', 'karendavis@example.com', '555-1234', '2021-08-01', 5, 95000.00, NULL, 7, 4),
  (9, 'David', 'Miller', 'davidmiller@example.com', '555-5678', '2021-09-01', 2, 85000.00, NULL, 10, 5),
  (10, 'Lisa', 'Wilson', 'lisawilson@example.com', '555-9012', '2021-10-01', 1, 110000.00, 0.06, NULL, 5);

DROP TABLE IF EXISTS jobs;
-- create jobs table

INSERT INTO jobs VALUES
  (1, 'Manager', 80000.00, 120000.00),
  (2, 'Developer', 60000.00, 100000.00),
  (3, 'Designer', 50000.00, 90000.00),
  (4, 'Salesperson', 40000.00, 80000.00),
  (5, 'Accountant', 50000.00, 100000.00);

DROP TABLE IF EXISTS departments;
-- create departments table

INSERT INTO departments VALUES
(1, 'Engineering', 3, 'New York'),
(2, 'Sales', 5, 'Los Angeles'),
(3, 'Marketing', 7, 'Chicago'),
(4, 'Accounting', 8, 'Houston'),
(5, 'IT', 10, 'San Francisco');


-- < 실습 문제 >
-- 1. IT 부서에서 일하는 모든 직원을 반환하는 쿼리를 작성합니다.
SELECT *
	FROM employees JOIN departments
    ON departments.department_id = employees.department_id
	GROUP BY employee_id
    ORDER BY employee_id;

-- 2. 각 부서의 총 직원 수를 반환하는 쿼리를 작성합니다.
SELECT department_id, COUNT(employee_id) AS 'total_employee' FROM employees GROUP BY department_id;

-- 3. $80,000 이상의 급여를 받는 모든 직원의 이름을 반환하는 쿼리를 작성합니다.
SELECT first_name, last_name, salary FROM employees WHERE salary >= 80000;

-- 4. 영업부에서 근무하며 $50,000 이상의 급여를 받는 모든 직원의 이름과 급여를 반환하는 쿼리를 작성합니다.
SELECT first_name, last_name, salary FROM employees WHERE salary >= 50000 AND job_id = 4;

-- 5. 직책과 직책별 평균 급여를 반환하는 조회를 작성합니다.
SELECT job_title, AVG(salary) FROM employees JOIN jobs ON;

-- 6. 모든 작업에 대한 직책과 최대 급여를 반환하는 조회를 작성합니다.
SELECT * FROM departments;
SELECT * FROM employees;
SELECT * FROM jobs;



-- 7. 가장 높은 연봉을 받는 직원 상위 10명의 이름과 급여를 반환하는 쿼리를 작성합니다.



-- 8. 최저임금을 받는 하위 5명의 직원들의 이름과 급여를 반환하는 쿼리를 작성하세요.



-- 9. 관리자와 동일한 직함을 가진 모든 직원의 이름을 반환하는 쿼리를 작성합니다.



-- 10. 2021년에 채용된 모든 직원의 이름을 반환하는 쿼리를 작성합니다.



-- 11. 수수료를 받는 모든 직원의 이름과 급여를 반환하는 쿼리를 작성합니다.



-- 12. 수수료를 받지 않는 모든 직원의 이름과 급여를 반환하는 쿼리를 작성합니다.


