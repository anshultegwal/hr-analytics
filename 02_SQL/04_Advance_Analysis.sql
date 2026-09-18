01 --  Who are the top 10 employees by annual salary, and how do their roles and departments compare?

SELECT 
    e.employee_id,
    e.employee_name,
    j.job_title,
    d.department_name,
    s.annual_salary_inr
FROM
    employees e
        JOIN
    salaries s ON e.employee_id = s.employee_id
        JOIN
    jobs j ON e.job_id = j.job_id
        JOIN
    departments d ON e.department_id = d.department_id
ORDER BY s.annual_salary_inr DESC
LIMIT 10;

02 -- Which managers have the largest teams, and what is the average performance rating of their direct reports?

SELECT 
    m.employee_id AS manager_id,
    m.employee_name AS manager_name,
    COUNT(e.employee_id) AS team_size,
    ROUND(AVG(p.performance_rating), 2) AS average_performance_rating
FROM
    employees m
        JOIN
    employees e ON e.manager_id = m.manager_id
        JOIN
    performance p ON e.employee_id = p.employee_id
GROUP BY m.employee_id , m.employee_name
ORDER BY team_size DESC , average_performance_rating DESC;

03 -- How does employee tenure vary across departments, and which departments have the longest-tenured workforce?

SELECT 
    d.department_name,
    COUNT(e.employee_id) AS employee_count,
    ROUND(AVG(TIMESTAMPDIFF(YEAR,
                e.hire_date,
                CURDATE())),
            2) AS avg_tenure_years
FROM
    employees e
        JOIN
    departments d ON e.department_id = d.department_id
WHERE
    e.hire_date IS NOT NULL
GROUP BY d.department_id , d.department_name
ORDER BY avg_tenure_years DESC;

04 -- Which employees have received multiple salary records, and how has their salary changed over time?


WITH salary_history AS (
  SELECT
       e.employee_id, 
       e.employee_name, 
       s.effective_from,
       s.effective_to,
       s.annual_salary_inr,

LAG(s.annual_salary_inr) OVER(  
PARTITION BY s.employee_id 
ORDER BY s.effective_from
)AS previous_salary

FROM employees e 
JOIN salaries s 
       ON e.employee_id = s.employee_id
), 

multiple_salary_employee AS (
SELECT employee_id 
FROM salaries 
GROUP BY employee_id
HAVING count(*) > 1 
)

SELECT 
    sh.employee_id,
    sh.employee_name,
    sh.effective_from,
    sh.effecTive_to,
    sh.annual_salary_inr,
    sh.previous_salary,
    sh.annual_salary_inr - sh.previous_salary AS salary_change
FROM
    salary_history sh
        JOIN
    multiple_salary_employee mse ON sh.employee_id = mse.employee_id
ORDER BY sh.employee_id, 
         sh.effective_from;

05 -- What is the salary growth percentage for employees with multiple salary records?
WITH ranked_salaries AS (
SELECT 
    e.employee_id,
    e.employee_name,
    s.effective_from,
    s.annual_salary_inr,
    ROW_NUMBER() OVER (PARTITION BY s.employee_id
    ORDER BY s.effective_from
    ) AS first_salary,
    ROW_NUMBER() OVER (PARTITION BY s.employee_id
    ORDER BY s.effective_from DESC
    ) AS latest_salary
    FROM employees e
    join salaries s 
    on e.employee_id = s.employee_id 
    ),
    
    salary_growth AS(
    SELECT 
        employee_id,
        employee_name,
        MAX(CASE WHEN first_salary = 1 
        THEN annual_salary_inr END) AS starting_salary,
        MAX(CASE WHEN latest_salary = 1
        THEN annual_salary_inr END) AS latest_salary
	    FROM ranked_salaries 
        GROUP BY 
               employee_id,
               employee_name 
        )
        
        SELECT
              employee_id,
              employee_name,
              starting_salary,
              latest_salary,
              ROUND(
                      (latest_salary - starting_salary)
                      / starting_salary * 100, 2
				) AS salary_growth_percentage
		FROM salary_growth
        WHERE starting_salary <> latest_salary
        ORDER BY salary_growth_percentage DESC ;

06 -- Create a consolidated employee 360° profile combining employee details, department, job, 
-- latest salary, attendance, leave, and performance metrics.

WITH latest_salary AS (
    SELECT
        employee_id,
        annual_salary_inr
    FROM (
        SELECT
            employee_id,
            annual_salary_inr,
            ROW_NUMBER() OVER (
			PARTITION BY employee_id
			ORDER BY effective_from DESC ) AS rn
            FROM salaries) s WHERE rn = 1
),

attendance_metrics AS (
    SELECT
        employee_id,
        ROUND(SUM(CASE
		WHEN attendance_status = 'Present' THEN 1 ELSE 0 END
            ) * 100.0 / COUNT(attendance_id), 2) AS attendance_percentage,
        ROUND(AVG(working_hours), 2) AS avg_working_hours
    FROM attendance
    GROUP BY employee_id
),

leave_metrics AS (
    SELECT
        employee_id,
        COUNT(leave_id) AS total_leaves
    FROM leaves
    GROUP BY employee_id
),

performance_metrics AS (
    SELECT
        employee_id,
        ROUND(AVG(performance_rating), 2) AS avg_performance
    FROM performance
    GROUP BY employee_id
)

SELECT
    e.employee_id,
    e.employee_name,
    e.gender,
    e.hire_date,
    e.employment_status,
    e.work_city,
    e.education_level,

    d.department_name,

    j.job_title,

    ls.annual_salary_inr AS latest_salary,

    am.attendance_percentage,
    am.avg_working_hours,

    COALESCE(lm.total_leaves, 0) AS total_leaves,

    pm.avg_performance

FROM employees e

JOIN departments d
ON e.department_id = d.department_id

JOIN jobs j
ON e.job_id = j.job_id

LEFT JOIN latest_salary ls
ON e.employee_id = ls.employee_id

LEFT JOIN attendance_metrics am
ON e.employee_id = am.employee_id

LEFT JOIN leave_metrics lm
ON e.employee_id = lm.employee_id

LEFT JOIN performance_metrics pm
ON e.employee_id = pm.employee_id

ORDER BY e.employee_id;