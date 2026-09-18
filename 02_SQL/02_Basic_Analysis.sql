01 -- How many employees are currently active, and how does the workforce break down by employment status?
use hr_analytics;

SELECT 
    employment_status, COUNT(*) AS employee_count
FROM
    employees
GROUP BY employment_status
ORDER BY employee_count DESC;

02 --  Which employees have taken the most approved leave days?

SELECT
    e.employee_id,
    e.employee_name,
    SUM(l.leave_days) AS total_approved_leave_days
FROM employees e
JOIN leaves l
    ON e.employee_id = l.employee_id
WHERE l.leave_status = 'Approved'
GROUP BY
    e.employee_id,
    e.employee_name
ORDER BY total_approved_leave_days DESC;

03 -- What is the employee distribution by gender and education level?

SELECT 
    gender,
    education_level,
    COUNT(employee_id) AS employee_distribution
FROM
    employees
GROUP BY gender , education_level
order by gender , education_level ;

04 -- How many employees are there in each job role, and which job titles have the highest headcount?
SELECT 
    j.job_title, COUNT(employee_id) AS total_headcount
FROM
    employees e
        JOIN
    jobs j ON e.job_id = j.job_id
GROUP BY job_title
ORDER BY total_headcount DESC ;

05 --  What is the average annual salary by department and by job title?

SELECT 
    d.department_name,
    j.job_title,
    AVG(annual_salary_inr) AS average_annual_salary
FROM
    salaries s
        JOIN
    jobs j ON s.job_id = j.job_id
        JOIN
    departments d ON j.department_id = d.department_id
GROUP BY department_name , job_title;

06 -- Which cities have the highest number of employees?
SELECT 
    work_city, COUNT(employee_id) AS highest_employee_city
FROM
    employees
GROUP BY work_city
ORDER BY highest_employee_city DESC
LIMIT 1;

07 --  What is the average working hours and attendance-status distribution across the organization?

SELECT 
    attendance_status,
    COUNT(*) AS attendance_count,
    ROUND(AVG(working_hours), 2) AS average_working_hours
FROM
    attendance
GROUP BY attendance_status
ORDER BY attendance_count DESC;
    

08 
























