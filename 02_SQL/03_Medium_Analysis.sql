01 
WITH department_workforce AS (
    SELECT
        d.department_name,
        COUNT(*) AS employee_count
    FROM employees e
    JOIN departments d
        ON e.department_id = d.department_id
    GROUP BY d.department_name
)
SELECT
    department_name,
    employee_count,
    CASE
        WHEN employee_count = (SELECT MAX(employee_count)
                               FROM department_workforce)
            THEN 'Largest Workforce'
        WHEN employee_count = (SELECT MIN(employee_count)
                               FROM department_workforce)
            THEN 'Smallest Workforce'
        ELSE 'Normal'
    END AS workforce_category
FROM department_workforce
ORDER BY employee_count DESC;

02 --  Which departments have the highest total salary cost and average salary?

SELECT 
    d.department_name,
    SUM(annual_salary_inr) AS total_annual_salary,
    AVG(annual_salary_inr) AS average_annual_salary
FROM
    salaries s
        JOIN
    employees e ON s.employee_id = e.employee_id
        JOIN
    departments d ON e.department_id = d.department_id
GROUP BY department_name
ORDER BY total_annual_salary , average_annual_salary DESC;

03 -- Which job roles have the highest average base salary and highest average actual salary?

SELECT 
    j.job_title,
    AVG(j.base_salary_inr) AS average_base_salary,
    AVG(annual_salary_inr) AS average_actual_salary
FROM
    salaries s
        JOIN
    jobs j ON s.job_id = j.job_id
GROUP BY job_title
ORDER BY average_base_salary DESC,
         average_actual_salary DESC;

04 -- What is the average salary by education level, and does higher education correspond to higher pay?

SELECT 
    e.education_level, AVG(annual_salary_inr) AS average_salary
FROM
    salaries s
        JOIN
    employees e ON s.employee_id = e.employee_id
GROUP BY education_level
ORDER BY average_salary;

-- "The average salary does not consistently increase with education level."

05 -- What is the employee attrition pattern by department, job role, city, and employment status?

WITH attrited_employees AS (
    
    SELECT 
        e.employee_id,
        e.department_id,
        e.job_id,
        e.work_city,
        e.employment_status
    FROM employees e
    WHERE e.employment_status IN ('terminated', 'Resigned')
)

-- Attrition by Department
SELECT 
    'Department' AS analysis_dimension,
    d.department_name AS category,
    COUNT(*) AS attrition_count
FROM attrited_employees ae
JOIN departments d
    ON ae.department_id = d.department_id
GROUP BY d.department_name

UNION ALL

-- Attrition by Job Role
SELECT 
    'Job Role' AS analysis_dimension,
    j.job_title AS category,
    COUNT(*) AS attrition_count
FROM attrited_employees ae
JOIN jobs j
    ON ae.job_id = j.job_id
GROUP BY j.job_title

UNION ALL

-- Attrition by Work City
SELECT 
    'Work City' AS analysis_dimension,
    ae.work_city AS category,
    COUNT(*) AS attrition_count
FROM attrited_employees ae
GROUP BY ae.work_city

UNION ALL

-- Attrition by Employment Status
SELECT 
    'Employment Status' AS analysis_dimension,
    ae.employment_status AS category,
    COUNT(*) AS attrition_count
FROM attrited_employees ae
GROUP BY ae.employment_status

ORDER BY 
    analysis_dimension,
    attrition_count DESC;

06 -- What percentage of employees are active in each department?

SELECT 
    d.department_name,
    COUNT(e.employee_id) AS total_employees,
    SUM(CASE
        WHEN e.employment_status = 'Active' THEN 1
        ELSE 0
    END) AS active_employees,
    ROUND(SUM(CASE
                WHEN e.employment_status = 'Active' THEN 1
                ELSE 0
            END) * 100 / COUNT(e.employee_id),
            2) AS active_employees_percenatge
FROM
    employees e
        JOIN
    departments d ON e.department_id = d.department_id
GROUP BY d.department_name;

07 -- Which departments have the highest average performance rating?

SELECT 
    d.department_name,
    AVG(performance_rating) AS average_performance_rating
FROM
    performance p
        JOIN
    employees e ON p.employee_id = e.employee_id
        JOIN
    departments d ON e.department_id = d.department_id
GROUP BY d.department_id
ORDER BY average_performance_rating DESC;

08 -- How does performance rating relate to bonus band and goal status?

SELECT
    p.performance_rating,
    p.bonus_band,
    p.goal_status,
    COUNT(*) AS review_count
FROM performance p
GROUP BY
    p.performance_rating,
    p.bonus_band,
    p.goal_status
ORDER BY
    p.performance_rating,
    review_count DESC;

09 --  Which employees have strong performance ratings but comparatively low salaries?

SELECT 
    e.employee_id,
    e.employee_name, 
    j.base_salary_inr,
    p.performance_rating
FROM
    employees e
        JOIN
    jobs j ON e.job_id = j.job_id
        JOIN
    performance p ON e.employee_id = p.employee_id
WHERE
    p.performance_rating >= 4
        AND j.base_salary_inr < (SELECT 
            AVG(base_salary_inr)
        FROM
            jobs)
ORDER BY p.performance_rating DESC , j.base_salary_inr ASC;

10 -- Which departments have the highest absenteeism and leave usage?

SELECT 
    d.department_name,
    COUNT(DISTINCT l.employee_id) AS employees_on_leave,
    COUNT(l.leave_id) AS total_leaves_records
FROM
    leaves l
        JOIN
    employees e ON l.employee_id = e.employee_id
        JOIN
    departments d ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY total_leaves_records DESC;
