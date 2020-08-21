--THIS SQL SCRIPT CREATES THE TABLES AND ALL PRIMARY AND FOREIGN KEY CONSTRAINTS FOR THE EMPLOYEE DATABASE
-------------------------------------------------------------------------------------------------------------
--There really are two valid ways of creating the tables and foreign keys in a database: 
--Both are described below, Method 1 is easier than Method 2.

--Method 1) Create all the tables, without specifying FKs (any order) then alter them to add the FKs - this is easier and perfectly valid.
--Method 2) Create the tables with FKs (requires specific order) - this is a bit more challenging and also perfectly valid, but unnecesary. 
--This is the method shown below, and as requested by the assignment.  

-- Data would need to be loaded in an order that closely follows this sequence.  
-- Data load sequence is documented in the readme.md.

--Method 2) 

--A) Create highest level parent tables first - these don't have dependencies on the existance of other tables.

CREATE TABLE IF NOT EXISTS departments
(
    dept_no VARCHAR(4) NOT NULL,
    dept_name VARCHAR(20) NOT NULL,
    PRIMARY KEY(dept_no)
);

CREATE TABLE IF NOT EXISTS titles
(
    title_id VARCHAR(5) NOT NULL,
    title VARCHAR(20) NOT NULL,
    PRIMARY KEY(title_id)
);

-- B) Now, create remaining tables from next highest level parent tables with associated FKs.

CREATE TABLE IF NOT EXISTS employees
(
    emp_no INTEGER NOT NULL,
    emp_title_id VARCHAR(5) NOT NULL,
    birth_date DATE NOT NULL,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    sex VARCHAR(1) NOT NULL,
    hire_date DATE NOT NULL,
    PRIMARY KEY(emp_no),
    FOREIGN KEY (emp_title_id) REFERENCES titles(title_id) MATCH SIMPLE
);

CREATE TABLE IF NOT EXISTS salaries
(
    emp_no INTEGER NOT NULL,
    salary NUMERIC(8, 2) NOT NULL,
    PRIMARY KEY(emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no) MATCH SIMPLE
);

--C) Finally, the junction tables with the most dependencies on other tables.

CREATE TABLE IF NOT EXISTS dept_manager
(
    dept_no VARCHAR(20) NOT NULL,
    emp_no INTEGER NOT NULL UNIQUE,
    PRIMARY KEY(dept_no, emp_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no) MATCH SIMPLE,
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no) MATCH SIMPLE
);
 
CREATE TABLE IF NOT EXISTS dept_emp
(
    emp_no INTEGER NOT NULL,
    dept_no VARCHAR(4) NOT NULL,
    PRIMARY KEY(emp_no, dept_no),
    FOREIGN KEY (emp_no) REFERENCES employees(emp_no) MATCH SIMPLE,
    FOREIGN KEY (dept_no) REFERENCES departments(dept_no) MATCH SIMPLE
);