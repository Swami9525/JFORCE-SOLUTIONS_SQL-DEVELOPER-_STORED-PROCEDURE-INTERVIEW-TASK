													--JFORCE SOLUTIONS--
										--SQL DEVELOPER – STORED PROCEDURE INTERVIEW TASK--

1.--Objective--

--Create and demonstrate SQL Stored Procedures for an Employee Management and Payroll database. 


2.-- Database Setup--

--Create a DataBase--
	
CREATE DATABASE EMP_MANAGMENT;

--Create a table--

CREATE TABLE EMPLOYEES ( 
	employee_id INT PRIMARY KEY,
		employee_name VARCHAR(50), 
			department VARCHAR(50), 
			designation VARCHAR(50),
		basic_salary NUMERIC(10,2),
	joining_date DATE,
status VARCHAR(50)
);

--Insert the Values in Tabele employees--

INSERT INTO EMPLOYEES VALUES 
(101,'SAI','IT','Developer',35000,'2026-11-2','Active');

INSERT INTO EMPLOYEES VALUES 
	(102,'Raj','HR','Sr.Hr','40000','2026-11-16','Inactive'),
	(103,'Tushar','Civil','Jr.Engineer',30000,'2026-09-04','Active'),
	(104,'Shubham','Civil','Sr.Engineer',60000,'2025-01-06','Active'),
	(105,'Rakesh','Finance','Associate Planner Lead',70000,'2025-01-10','Active'),
	(106,'Rahul','Finance','Associate Planner',35000,'2026-12-01','Inactive'),
	(107,'Rohan','IT','SQL Developer',45000,'2025-02-07','Active'),
	(108,'Mayur','HR','Jr.Hr',30000,'2025-05-01','Active'),
	(109,'Om','IT', 'Developer',Null,'2026-10-2','Inactive'),
	(110,'Nidhi','IT','Java Developer',55000,'2025-01-03','Active');


-- Database exploration--

	select * from employees;

-- What is store procedure--
	--A stored procedure is a group of SQL statements stored permanently in a database that we can execute whenever required.
    -- Advantages:
	      --Code Reusability,
             --Time Saving,			  
                  --Maintainability,
              		 --Automation

					   
3. --Task 1 – Employee Salary Report Procedure--

-- Create a store procedure named GetEmployeeSalaryReport --
--It must accept Department Name and minimum_salary as input parameters.
--Output: Employee ID, Employee Name, Department, Designation, Basic Salary, Joining Date.

CREATE OR REPLACE PROCEDURE GetEmployeeSalaryReport(
    IN p_dept_name VARCHAR(50),
    IN p_min_salary NUMERIC(10,2),

    OUT p_employee_name VARCHAR(50),
    OUT p_employee_salary NUMERIC(10,2),
    OUT p_employee_department VARCHAR(50),
    OUT p_designation VARCHAR(50),
    OUT p_joining_date DATE
)
LANGUAGE plpgsql
AS $$
BEGIN

--Retrieves employee records.-- 
    SELECT
        employee_name,
        basic_salary,
        department,
        designation,
        joining_date

    INTO
        p_employee_name,
        p_employee_salary,
        p_employee_department,
        p_designation,
        p_joining_date

    FROM employees
    WHERE department = p_dept_name
      AND basic_salary = p_min_salary
      AND status = 'Active'
    LIMIT 1;

END;
$$;
	
-- Exceute the procedure GetEmployeeSalaryReport--

CALL GetEmployeeSalaryReport('IT',35000,NULL,NULL,NULL,NULL,NULL)



CALL GetEmployeeSalaryReport('IT',35000,NULL,NULL,NULL,NULL,NULL)


4. --Task 2 – Employee Salary Calculation Procedure--

CREATE OR REPLACE PROCEDURE CalculateEmployeeSalary (
    IN P_employee_id INT,
    OUT P_Employee_Name VARCHAR(50),
    OUT p_Basic_Salary NUMERIC(10,2),
    OUT p_HRA_Salary NUMERIC(10,2),
    OUT p_DA_Salary NUMERIC(10,2),
    OUT p_PF_Salary NUMERIC(10,2),
    OUT p_Net_Salary NUMERIC(10,2)
)
LANGUAGE plpgsql
AS $$
BEGIN

--Retrieves employee records--

    SELECT employee_name, basic_salary
    INTO P_Employee_Name, p_Basic_Salary
    FROM employees
    WHERE employee_id = P_employee_id;

--Calculation the basic salary as per the given rules--

    p_HRA_Salary := p_Basic_Salary * 0.20;

    p_DA_Salary := p_Basic_Salary * 0.10;

    p_PF_Salary := p_Basic_Salary * 0.12;

    p_Net_Salary := p_Basic_Salary
                    + p_HRA_Salary
                    + p_DA_Salary
                    - p_PF_Salary;

END;
$$;

-- Exceute the procedure CalculateEmployeeSalary--

call CalculateEmployeeSalary (110,null,null,null,null,null,null);




5. --Task 3 – Salary Grade Procedure--

CREATE OR REPLACE PROCEDURE EmployeeSalaryGrade (

    IN P_employee_id INT,
    OUT P_Employee_NAME VARCHAR(50),
    OUT p_Basic_Salary NUMERIC(10,2),
    OUT Salary_Grade VARCHAR(1)

)
LANGUAGE plpgsql
AS $$
BEGIN

--Retrieves employee records--

    SELECT employee_name, basic_salary
    INTO P_Employee_NAME, p_Basic_Salary
    FROM employees
    WHERE employee_id = P_employee_id;

 -- Giveing the Grade to as per the Given Rules--
 
    IF p_Basic_Salary < 30000 THEN
        Salary_Grade := 'C';

    ELSIF p_Basic_Salary BETWEEN 30000 AND 60000 THEN
        Salary_Grade := 'B';

    ELSE
        Salary_Grade := 'A';
    END IF;

END;
$$;

-- Exceute the procedure EmployeeSalaryGrade--

CALL EmployeeSalaryGrade(101,NULL,NULL,NULL);



6. --Bonus Task – Department Summary--


CREATE OR REPLACE PROCEDURE  GetDepartmentSummary
(
IN P_department_name VARCHAR(50),
OUT P_Basic_salary numeric(10,2),
OUT P_Total_employees NUMERIC(10,2),
OUT p_Average_salary NUMERIC(10,2),
OUT p_Highest_salary NUMERIC(10,2),
OUT p_Lowest_salary NUMERIC(10,2),
OUT p_Total_salary_expenditure NUMERIC(10,2)
)

LANGUAGE PLPGSQL
AS $$ BEGIN

--Retrieves employee records--

SELECT 
basic_salary 
into 
P_Basic_salary 
FROM EMPLOYEES 
where P_department_name = department;

-- Error handling where requested department does not exist and displaying an appropriate message--

if not found then 
raise exception 'department name % dose not exist',
P_department_name;
end if;

P_Total_employees:= count(*);
p_Average_salary := avg(P_Basic_salary);
p_Highest_salary:= max(P_Basic_salary);
p_Lowest_salary:= min(P_Basic_salary);
p_Total_salary_expenditure:= sum(P_Basic_salary);

end; $$;

-- Exceute the procedure GetDepartmentSummary--

call GetDepartmentSummary ('IT',null,null,null,null,null,null);


--CREATE OR REPLACE PROCEDURE : Creates the procedure.
--BEGIN: Starts the procedure body.
--SELECT: Retrieves employee records.
--END: Ends the procedure.
--CALL: Executes the procedur
--IN: Takes input from the user
--OUT:Returns output
--INOUT:Takes input and returns modified output
-- ":="" : It is assigment operater use in Pl/pgsql

