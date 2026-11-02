# Employee Management & Payroll – SQL Stored Procedure Assignment

1. Objective

Create and demonstrate SQL Stored Procedures for an Employee Management and Payroll database using PostgreSQL.

This assignment is designed to evaluate practical knowledge of stored procedure creation, parameters, conditional logic, calculations, aggregation, and basic error handling.

2. Database

- Database: PostgreSQL
- Language:PL/pgSQL
- Tool: pgAdmin 4

3. Topics Covered

- Creating and executing Stored Procedures
- IN, OUT and INOUT parameters
- SELECT INTO statements
- IF-ELSE conditional statements
- CASE WHEN expressions
- Salary calculations
- Aggregate functions (COUNT, SUM, AVG, MIN, MAX)
- Employee data retrieval
- Exception handling

4. Assignment Scope

The assignment focuses on performing employee management and payroll-related database operations through stored procedures.

Key operations include:

- Retrieving employee details based on conditions
- Generating employee salary reports
- Calculating salary grades
- Performing department-wise salary analysis
- Calculating payroll-related values
- Applying conditional logic
- Handling invalid inputs and database errors

5. Execution

Stored procedures are created using PL/pgSQL and executed using the PostgreSQL `CALL` statement.

Example:

sql
CALL GetEmp('IT', 50000, NULL, NULL, NULL, NULL, NULL);


6. Purpose

To demonstrate practical SQL development skills and understand how stored procedures help automate employee management and payroll operations.

7. Author

Sairaj Waje

Assignment:Employee Management & Payroll – PostgreSQL Stored Procedures
