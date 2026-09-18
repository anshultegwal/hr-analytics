-- Table Creation Script 

-- 1. departments 
CREATE TABLE departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100),
    location VARCHAR(100),
    annual_budget_inr DECIMAL(15,2)
);

-- 2. Jobs
CREATE TABLE jobs (
    job_id INT PRIMARY KEY,
    job_title VARCHAR(100),
    department_id INT,
    base_salary_inr DECIMAL(12,2),
    
    FOREIGN KEY (department_id)
        REFERENCES departments(department_id)
);


-- 3. Employees
CREATE TABLE employees (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    gender VARCHAR(20),
    date_of_birth DATE,
    department_id INT,
    job_id INT,
    hire_date DATE,
    employment_status VARCHAR(100),
    work_city VARCHAR(100),
    education_level VARCHAR(100),
    manager_id INT,

    FOREIGN KEY (department_id)
        REFERENCES departments(department_id),

    FOREIGN KEY (job_id)
        REFERENCES jobs(job_id),

    FOREIGN KEY (manager_id)
        REFERENCES employees(employee_id)
);

-- 4. Salaries
CREATE TABLE salaries (
    salary_id INT PRIMARY KEY,
    employee_id INT,
    job_id INT,
    effective_from DATE,
    effective_to DATE,
    annual_salary_inr DECIMAL(12,2),
    annual_bonus_target_inr DECIMAL(12,2),

    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id),

    FOREIGN KEY (job_id)
        REFERENCES jobs(job_id)
);

-- 5. Attendance
CREATE TABLE attendance (
    attendance_id INT PRIMARY KEY,
    employee_id INT,
    attendance_date DATE,
    attendance_status VARCHAR(30),
    working_hours DECIMAL(5,2),

    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);

-- 6. Leaves
CREATE TABLE leaves (
    leave_id INT PRIMARY KEY,
    employee_id INT,
    leave_type VARCHAR(50),
    start_date DATE,
    leave_days INT,
    leave_status VARCHAR(30),

    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);

-- 7. Performance
CREATE TABLE performance (
    review_id INT PRIMARY KEY,
    employee_id INT,
    review_year YEAR,
    performance_rating DECIMAL(3,1),
    bonus_band VARCHAR(30),
    goal_status VARCHAR(30),

    FOREIGN KEY (employee_id)
        REFERENCES employees(employee_id)
);
