CREATE TABLE employees
  (
     employee_id    INT PRIMARY KEY,
     first_name     VARCHAR(20),
     last_name      VARCHAR(25),
     email          VARCHAR(25),
     phone_number   VARCHAR(20),
     hire_date      DATE,
     job_id         VARCHAR(10),
     salary         INT,
     commission_pct INT,
     manager_id     INT,
     department_id  INT
  )

CREATE TABLE departments
  (
     department_id   INT,
     department_name VARCHAR(20),
     manager_id      INT,
     location_id     INT
  )

CREATE TABLE jobs
  (
     job_id     VARCHAR(20),
     job_title  VARCHAR(20),
     min_salary INT,
     max_salary INT
  ); 

select * from employees
select * from departments
select * from jobs

--1. Given SQL query will execute successfully: TRUE/FALSE SELECT last_name, job_id, salary AS Sal FROM employees;
SELECT last_name, job_id, salary AS Sal FROM employees;

--2. Identity errors in the following statement: SELECT employee_id, last_name, sal*12 ANNUAL SALARY FROM employees;
SELECT employee_id, last_name, salary*12 as [ANNUAL SALARY] FROM employees;

--3. Write a query to determine the structure of the table 'DEPARTMENTS'
exec sp_help departments

--4. Write a query to determine the unique Job IDs from the EMPLOYEES table.
select distinct job_id from employees

--5. Write a query to display the employee number, lastname, salary (oldsalary), salary increased by 15.5% name it has NewSalary and subtract the (NewSalary from OldSalary) name the column as Increment.
select employee_id, last_name, salary as oldsalary, salary + (salary * 0.155) as NewSalary, (salary + (salary * 0.155)) - salary  as Increment from employees 

--6. Write a query to display the minimum, maximum, sum and average salary for each job type.
select min(salary) as minimum, max(salary) as maximum, avg(salary) as TotalAvg, sum(salary) as Total, job_id from employees
group by job_id

select * from employees where MANAGER_ID = 100

--7. The HR department needs to find the names and hire dates of all employees who were hired before their managers, along with their managers’ names and hire dates.
select first_name, hire_date from employees
select a.EMPLOYEE_ID, a.FIRST_NAME, a.LAST_NAME, a.HIRE_DATE, a.MANAGER_ID,  b.EMPLOYEE_ID, b.FIRST_NAME, b.LAST_NAME, b.HIRE_DATE, b.MANAGER_ID from employees a, employees b
where a.employee_id = b.manager_id and a.HIRE_DATE > b.HIRE_DATE

--8. Create a report for the HR department that displays employee last names, department numbers, and all the employees who work in the same department as a given employee.
select e.LAST_NAME, e.EMPLOYEE_ID, d.department_name from employees e
inner join departments d on e.DEPARTMENT_ID = d.department_id

--9. Find the highest, lowest, sum, and average salary of all employees. Label the columns Maximum, Minimum, Sum, and Average, respectively. Round your results to the nearest whole number.
select ROUND(max(SALARY),0) as maximum,
	   ROUND(min(SALARY),0) as Minimum,
	   ROUND(sum(SALARY),0) as Total,
	   ROUND(avg(SALARY),0) as Average
	   from employees

--10. Create a report that displays list of employees whose salary is more than the salary of any employee from department 60.
select * from employees 
where SALARY > any (select salary from employees where DEPARTMENT_ID = 60)

--11. Create a report that displays last name and salary of every employee who reports to King(Use any manager name instead of King).
select * from employees
where MANAGER_ID in (select EMPLOYEE_ID  from employees
where LAST_NAME = 'king');

--12. Write a query to display the list of department IDs for departments that do not contain the job Id ST_CLERK(Add this job ST_CLERK to Job table). Use SET Operator for this query
select distinct DEPARTMENT_ID from employees
where DEPARTMENT_ID != (select distinct DEPARTMENT_ID from employees where JOB_ID = 'ST_CLERK')

select distinct DEPARTMENT_ID from employees
except
select distinct DEPARTMENT_ID from employees
where JOB_ID = 'st_clerk'

--13. Write a query to display the list of employees who work in department 50 and 80. Show employee Id, job Id and department Id by using set operators. - Add 50 and 80 department Id to department table
select * from employees
where DEPARTMENT_ID in (50,80)

select * from employees
except
select * from employees where DEPARTMENT_ID not in (50,80)

