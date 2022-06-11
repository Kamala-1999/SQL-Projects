--------------------------------------------------------------------------------
-- TABLES
--------------------------------------------------------------------------------
select * from countries;
select * from departments;
select * from employees;
select * from jobs;
select * from locations;
select * from job_history;
select * from regions;

--------------------------------------------------------------------------------
--1.SQL query to find the salaries of all employees
--------------------------------------------------------------------------------

select EMPLOYEE_ID,first_name,last_name,salary 
from employees 
order by FIRST_NAME;

--------------------------------------------------------------------------------
--2.SQL query to find the unique designations of the employees. Return job name
--------------------------------------------------------------------------------

select distinct job_id,job_title 
from jobs 
order by job_title;

--------------------------------------------------------------------------------
--3.SQL query to list the employees’ name, increased their salary by 15%, and expressed as number of Dollars.
--------------------------------------------------------------------------------

select concat(first_name,' ',last_name),concat('$ ',salary*1.15) as Salary 
from employees 
order by first_name;

--------------------------------------------------------------------------------
--4.SQL query to list the employee's name and job name as a format of "Employee & Job"
--------------------------------------------------------------------------------

select concat(first_name,' ',last_name,' &',' ',job_title) as "Employee & Job" 
from employees,jobs 
where employees.job_id=jobs.job_id;

--------------------------------------------------------------------------------
--5.SQL query to find those employees with hire date in the format like February 22, 1991. Return employee ID, employee name, salary, hire date
--------------------------------------------------------------------------------

select employee_id,first_name,last_name,salary,date_format(hire_date,'%M %d, %Y') as hire_date 
from employees 
order by hire_date;

--------------------------------------------------------------------------------
--6.SQL query to count the number of characters except the spaces for each employee name. Return employee name length
--------------------------------------------------------------------------------

select first_name,last_name,(length(first_name)-(length(first_name)-length(replace(first_name,' ',''))))
+(length(last_name)-(length(last_name)-length(replace(last_name,' ','')))) as length 
from employees 
order by length;

--------------------------------------------------------------------------------
--7.SQL query to find the employee ID, salary, and commission of all the employees
--------------------------------------------------------------------------------

select employee_id,salary,commission_pct*salary as commission 
from employees 
order by commission_pct desc;

--------------------------------------------------------------------------------
--8.SQL query to find the unique department name with job name. Return department ID, Job name
--------------------------------------------------------------------------------

select department_name,job_title,departments.department_id,jobs.job_id 
from departments,employees,jobs 
where departments.department_id=employees.department_id 
and employees.job_id=jobs.job_id;

--------------------------------------------------------------------------------
--9.SQL query to find those employees who joined before 1991. Return complete information about the employees
--------------------------------------------------------------------------------

select * from employees,departments,countries,regions,locations 
where hire_date<'1991-01-01'
and employees.department_id=departments.department_id
and departments.location_id = locations.location_id 
and locations.country_id = countries.country_id
and countries.region_id = regions.region_id ;

--------------------------------------------------------------------------------
--10.SQL query to compute the average salary of those employees who work as ‘ANALYST’. Return average salary
--------------------------------------------------------------------------------

select avg(salary),jobs.job_id from employees,jobs 
where employees.job_id=jobs.job_id and jobs.job_title='ANALYST';
-------------------------------------------------------------------------------------

-------------------------------------------------------------------------------------
select count(COUNTRY_NAME) from countries natural join regions
where REGION_NAME like 'asia%';
--------------------------------------------------------------------

select country_name,region_name from countries natural join regions;
-------------------------------------------------------------------------

select * from employees
where EMPLOYEE_ID = (select MANAGER_ID from employees where FIRST_NAME = 'neena');
-------------------
----------------or-----------------
--------------------
select e1.first_name,e1.last_name 
 from employees e
 join employees e1 on e1.employee_id=e.manager_id
 where e.first_name='Neena';

-------------------------------------------------------------------------------

 select e2.* from employees e2 join employees e1
 on e1.employee_ID = e2.manager_ID
 where e1.FIRST_NAME like 'Steven%'
 and e2.salary > 10000;
 ---------------------------------------------------------------------------
-- DISPLAY THE NUMBER OF EMPLOYEES WORKING IN ROME

select count(*) from employees join departments join locations
on employees.department_id=departments.department_id
and departments.location_id=locations.location_id
where city like '%seattle%';

--------------------------------------------------------------------------------
-- DISPLAY ALL EMPLOYEES WHOSE SALARY IS GREATER THAN David Austin

select count(*) from employees e1 join employees e2 
where e1.SALARY > e2.SALARY
and e2.LAST_NAME like '%Austin%'
and e2.FIRST_NAME like '%David%';
-----------------------or----------------------------------------------------------
select count(*) from employees
where salary>(select salary from employees  where  first_name='david' and last_name='austin');

--------------------------------------------------------------------------------

--DISPLAY ALL MANAGERS NAME WHO HAVE MORE THAN 3 EMPLOYEES UNDER THEM
SELECT e1.FIRST_NAME,count(*) as N from employees e1 join employees e2
on e1.employee_id=e2.manager_id
GROUP BY e1.employee_id
having count(*)>3;

------------------------------------------------------------------------------------
select FIRST_NAME,LAST_NAME,count(SALARY),SALARY,
case 
when SALARY > 10000 then "A" 
when SALARY > 5000 then "B" 
else 'C'
end as CATEGORY
from employees
group BY CATEGORY;

------------------------------------------------------------------------------------

-- display the employees which are worked for more than 2 years
SELECT concat(FIRST_NAME, ' ',LAST_NAME) as Name FROM employees join job_history
on employees.employee_id=job_history.employee_id
WHERE YEAR(end_DATE)-YEAR(start_DATE)>2;

----------------------or-----------------------------------

SELECT concat(FIRST_NAME, ' ',LAST_NAME) as Name FROM employees join job_history
on employees.employee_id=job_history.employee_id
where datediff(end_date,start_date)/365>2;