# 👥 HR Analytics — SQL & Excel Project

## 📌 Project Overview

The **HR Analytics — SQL & Excel Project** is an end-to-end data analytics project focused on analyzing employee, department, job, salary, attendance, leave, and performance data.

The project demonstrates how raw HR data can be organized, validated, analyzed using **MySQL**, and transformed into meaningful business insights and an interactive **Excel dashboard**.

The analysis covers **23 business questions**, ranging from basic workforce analysis to advanced HR analytics involving salary history, employee performance, attendance, leave patterns, attrition, and manager-level analysis.

---

## 📁 Dataset

The project uses a relational HR dataset containing multiple connected tables.

### Main Tables

- **employees** — Employee details, demographics, department, job, employment status, city, education, and manager information.
- **departments** — Department names, locations, and annual budgets.
- **jobs** — Job titles, departments, and base salary information.
- **attendance** — Employee attendance dates, attendance status, and working hours.
- **leaves** — Leave type, leave dates, leave days, and leave status.
- **performance** — Employee performance ratings, bonus bands, and goal status.
- **salaries** — Employee salary history, effective dates, annual salary, and bonus targets.

The dataset contains **5,000 employees**, along with supporting attendance, leave, performance, job, department, and historical salary records.

---

## 🔗 Database Relationships

The HR dataset follows a relational structure where employee records connect with other HR entities through primary and foreign keys.

### Key Relationships

- `employees.department_id` → `departments.department_id`
- `employees.job_id` → `jobs.job_id`
- `employees.manager_id` → `employees.employee_id`
- `attendance.employee_id` → `employees.employee_id`
- `leaves.employee_id` → `employees.employee_id`
- `performance.employee_id` → `employees.employee_id`
- `salaries.employee_id` → `employees.employee_id`
- `salaries.job_id` → `jobs.job_id`

The `employees` table also uses a **self-referencing relationship** through `manager_id` to analyze reporting structures and manager teams.

---

## ❓ Business Questions

The SQL analysis contains **23 business questions**, covering:

### Basic Analysis
- Employee counts and employment status
- Department-wise employee distribution
- Attendance and working-hour analysis
- Leave analysis
- Salary analysis
- Education-wise salary comparison

### Intermediate Analysis
- Attrition analysis by department, job, city, and employment status
- Active employee percentage by department
- Performance and bonus analysis
- Goal-status analysis
- Absenteeism and leave patterns
- Top salary analysis
- Manager team analysis
- Employee tenure analysis

### Advanced Analysis
- Employees with multiple salary records
- Salary growth analysis
- High-salary employees with low performance
- Employee 360° profiles
- Manager-level team and performance analysis

---

## 🛠️ SQL Skills Demonstrated

This project demonstrates practical MySQL skills including:

- `SELECT`
- `WHERE`
- `GROUP BY`
- `ORDER BY`
- `Aggregate functions`
- `COUNT()`
- `SUM()`
- `AVG()`
- `MIN()`
- `MAX()`
- `CASE`
- `HAVING`
- `Inner and Left Joins`
-` Self Joins`
-` Subqueries`
-` Conditional aggregation`
-` Percentage calculations`
-` Date functions`
-` Tenure calculations`
-` Salary growth calculations`
-` Employee-level profiling`
- `Data validation and quality checks`
- `Relational database analysis`

---

## 📊 Key Business Metrics

The analysis produced several important HR metrics:

| Metric | Value |
|---|---:|
| Total Employees | 5,000 |
| Active Employees | 3,883 |
| Inactive Employees | 1,117 |
| Female Employees | 2,205 |
| Male Employees | 2,795 |
| Average Salary | ₹82,647.92 |
| Highest Salary | ₹165,000 |
| Average Performance Rating | 3.40 |
| High Performers | 2,015 |
| Total Leave Days | 7,889 |
| Total Leave Records | 4,000 |
| Average Working Hours | 7.04 |
| Total Departments | 8 |
| Total Job Roles | 17 |

> **Note:** Salary KPIs in this project are based on the available historical salary records rather than only the latest salary record for each employee.

---

## 📊 Excel Dashboard & Analysis

The Excel phase converts the analyzed HR data into a management-friendly dashboard and supporting analysis.

### Dashboard KPIs

The Excel dashboard highlights:

- Total Employees
- Active Employees
- Inactive Employees
- Female Employees
- Male Employees
- Average Salary
- Highest Salary
- Average Performance Rating
- High Performers
- Total Leave Days

### Excel Visualizations

The dashboard includes visual analysis for:

- Employees by Department
- Employees by Gender
- Employees by Employment Status
- Leave Status
- Performance Rating Distribution
- Average Annual Salary by Job Title

The Excel analysis also uses **Pivot Tables** and **XLOOKUP** to connect and summarize related HR information.

---

## 🔄 Project Workflow

```text
Raw CSV Dataset
       ↓
Data Preparation & Validation
       ↓
MySQL Database
       ↓
SQL Analysis — 23 Business Questions
       ↓
Excel Data Analysis
       ↓
Pivot Tables & XLOOKUP
       ↓
Excel Dashboard
       ↓
Business Insights
```

---

## 📂 Project Structure

```text
HR Analytics/
│
├── 01_Data/
│   └── CSV Dataset
│
├── 02_SQL_Queries/
│   └── Basic to Advanced — 23 Business Questions & Queries
│
├── 03_Excel/
│   └── Excel Workbook
│
├── 04_Screenshots/
│   ├── SQL/
│   └── Excel/
│
├── 05_Documentation/
│   └── 23 Business Questions
│
└── README.md
```

---

## 📸 Screenshots

Screenshots are organized into separate folders for better project presentation.

### SQL Screenshots

The SQL folder contains screenshots of MySQL queries and analysis results from the 23 business questions.

### Excel Screenshots

The Excel folder contains screenshots of Pivot Tables, analysis sheets, charts, KPIs, and the final HR Dashboard.

---

## 🧰 Tools & Technologies

### Database & SQL
- **MySQL**
- MySQL Workbench

### Spreadsheet Analytics
- **Microsoft Excel**
- Excel Tables
- Pivot Tables
- XLOOKUP
- Excel Charts
- Dashboard Design

### Data Format
- CSV
- XLSX

---

## 🎯 Project Objective

The main objective of this project is to demonstrate practical HR data analytics skills by:

- Analyzing employee workforce data
- Understanding employee distribution across departments and jobs
- Studying salary and compensation patterns
- Analyzing attendance and leave behavior
- Evaluating employee performance
- Understanding attrition and workforce status
- Analyzing manager teams and reporting structures
- Creating business-focused Excel dashboards
- Converting raw HR data into actionable insights

---

## ⭐ Project Highlights

- End-to-end **SQL + Excel HR Analytics project**
- Relational HR dataset with multiple connected tables
- **23 business questions** from basic to advanced level
- Practical MySQL joins and analytical queries
- Self-join analysis for manager hierarchy
- Salary history and salary-growth analysis
- Employee performance and compensation analysis
- Attendance and leave analysis
- Excel Pivot Tables and XLOOKUP
- Professional Excel HR Dashboard
- KPI-driven business reporting
- Organized project documentation and screenshots

---

## 🔍 Key Business Insights

The analysis provides several useful workforce insights:

1. The organization has **5,000 employees**, with **3,883 active employees** and **1,117 inactive employees**, providing a clear view of the current workforce structure.

2. The workforce consists of **2,795 male employees and 2,205 female employees**, allowing gender distribution to be evaluated at an organizational level.

3. The recorded salary data has an **average annual salary of approximately ₹82,648**, while the highest recorded annual salary is **₹165,000**.

4. The overall **average performance rating is approximately 3.40 out of 5**, indicating a moderate overall performance level across the available performance records.

5. **2,015 performance records meet the high-performer threshold of 4 or above**, providing a useful population for studying strong performance and compensation patterns.

6. Employees have **7,889 recorded leave days across 4,000 leave records**, making leave utilization an important area for workforce planning and absence analysis.

7. The organization operates across **8 departments and 17 job roles**, enabling department- and role-level comparison of workforce, salary, and performance patterns.

8. Combining SQL analysis with Excel visualization makes it easier to move from **raw HR records → analytical findings → management-level reporting**.

9. The project demonstrates how HR data can be used to investigate relationships between **workforce structure, compensation, attendance, leave, performance, and employee status**.

---

## 👤 About

This project was created as part of a **Data Analytics portfolio** to demonstrate practical skills in SQL, Excel, relational data analysis, business problem solving, and dashboard creation.

The project focuses on applying data analytics concepts to a realistic HR business scenario and presenting the results in a clear, professional, and decision-oriented format.
