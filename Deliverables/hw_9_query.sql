-- setting up the tables and loading the data
CREATE TABLE departments (
    dept_no VARCHAR(5)   NOT NULL,
    dept_name VARCHAR(50)   NOT NULL,
    CONSTRAINT pk_departments PRIMARY KEY (
        dept_no)
);

CREATE TABLE employees (
    emp_no INTEGER   NOT NULL,
    emp_title VARCHAR(10)   NOT NULL,
    birth_date date   NOT NULL,
    first_name VARCHAR(150)   NOT NULL,
    last_name VARCHAR(200)   NOT NULL,
    sex VARCHAR(5)   NOT NULL,
    hire_date date   NOT NULL,
    CONSTRAINT pk_employees PRIMARY KEY (
        emp_no,emp_title)
);

CREATE TABLE titles (
    title_id VARCHAR(150)   NOT NULL,
    title VARCHAR(150)   NOT NULL,
    CONSTRAINT pk_titles PRIMARY KEY (
        title_id)
);

CREATE TABLE salaries (
    emp_no INTEGER   NOT NULL,
    salary INTEGER   NOT NULL
);

CREATE TABLE dept_employees (
    emp_no INTEGER   NOT NULL,
    dept_no VARCHAR(5)   NOT NULL
);

CREATE TABLE dept_managers (
    dept_no VARCHAR(5)   NOT NULL,
    emp_no INTEGER   NOT NULL
);

-- starting the queries

-- List the employee number, last name, first name, sex, and salary of each employee DONE
SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e
	JOIN salaries s on e.emp_no = s.emp_no;
	

-- List the first name, last name, and hire date for the employees who were hired in 1986 DONE
SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- List the manager of each department along with their department number, 
-- department name, employee number, last name, and first name
SELECT 
FROM employees e
JOIN dept_employees de on e.emp_no = de.emp_no
JOIN dept_managers dm on de.dept_no = dm.dept_no
JOIN departments d on dm.dept_no = d.dept_no;

-- List the department number for each employee along with that employee’s employee number, 
-- last name, first name, and department name DONE
SELECT d.dept_no, d.dept_name, e.emp_no, e.last_name, e.first_name 
	FROM departments d 
	INNER JOIN dept_employees de ON d.dept_no = de.dept_no 
	INNER JOIN employees e ON de.emp_no = e.emp_no;
	
-- List first name, last name, and sex of each employee whose first name is Hercules and 
-- whose last name begins with the letter B
SELECT e. first_name, e.last_name, e.sex
FROM employees e
	WHERE e.first_name = 'Hercules' AND e.last_name like 'B%'

-- List each employee in the Sales department, including their employee number, last name, and first name DONE
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
	FROM employees e 
	INNER JOIN dept_employees de ON e.emp_no = de.emp_no 
	INNER JOIN departments d ON de.dept_no = d.dept_no 
	WHERE dept_name = 'Sales';

-- List each employee in the Sales and Development departments, including their employee number, 
-- last name, first name, and department name DONE
SELECT e.emp_no, e.last_name, e.first_name, d.dept_name
FROM employees e 
INNER JOIN dept_employees de ON e.emp_no = de.emp_no 
INNER JOIN departments d ON de.dept_no = d.dept_no 
WHERE dept_name IN ('Sales', 'Development');
	

-- List the frequency counts, in descending order, of all the employee last names 
-- (that is, how many employees share each last name) DONE
SELECT last_name, COUNT(last_name) AS "last name count"
FROM employees
GROUP BY last_name
ORDER BY "last name count" DESC;


