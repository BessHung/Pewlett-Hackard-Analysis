-- 7.3.1
-- Retirement eligibility
select first_name, last_name
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31' );

-- Number of employees retiring
select count(first_name)
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31' );

-- Save as new table
select first_name, last_name
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31' );

-- 7.3.2 Recreate the retirement_info Table with the emp_no Column
DROP TABLE retirement_info;
-- Create new table for retiring employees
select emp_no, first_name, last_name
into retirement_info
from employees
where (birth_date between '1952-01-01' and '1955-12-31')
and (hire_date between '1985-01-01' and '1988-12-31' );
-- Check the table
select * from retirement_info;

-- 7.3.3 Join
-- join dept_manager and department table
select departments.dept_name,
dept_manager.emp_no,
dept_manager.from_date,
dept_manager.to_date
from departments
inner join dept_manager
on departments.dept_no = dept_manager.dept_no;

-- join retirement_info and dept_emp
select ri.emp_no,
	ri.first_name,
	ri.last_name,
	de.to_date
into current_empo
from retirement_info as ri
left join dept_emp as de
on ri.emp_no = de.emp_no
where de.to_date = '9999-01-01';

-- 7.3.4 GROUP BY, ORDER BY, COUNT
-- Employee count by department number
select count(ce.emp_no), de.dept_no
into retirement_by_dept
from current_empo as ce
Left join dept_emp as de
on ce.emp_no = de.emp_no
group by de.dept_no
Order by de.dept_no;

-- Employee Information
Select * from salaries
order by to_date DESC;

Drop table emp_info CASCADE;

SELECT e.emp_no, e.first_name, e.last_name, e.gender, s.salary, de.to_date
INTO emp_info
FROM employees as e
inner join salaries as s
on e.emp_no = s.emp_no
inner join dept_emp as de
on e.emp_no = de.emp_no
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
AND (de.to_date = '9999-01-01');

-- Management info
Select * from current_empo

Select dm.dept_no,
	d.dept_name,
	dm.emp_no,
	ce.first_name,
	ce.last_name,
	dm.from_date,
	dm.to_date
into manager_info
from dept_manager as dm
	inner join departments as d
		on dm.dept_no = d.dept_no
	inner join current_empo as ce
		on dm.emp_no = ce.emp_no;
		
-- Department retirees
select ce.emp_no, 
	ce.first_name,
	ce.last_name,
	d.dept_name
into dept_info
from current_empo as ce
	inner join dept_emp as de
		on ce.emp_no = de.emp_no
	inner join departments as d
		on d.dept_no = de.dept_no;
		
-- 7.3.6 
--d007 Sales, d005 Development

-- sales team info
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
into sales_info
from current_empo as ce
	left join dept_emp as de
		on ce.emp_no = de.emp_no
	left join departments as d
		on d.dept_no = de.dept_no
where d.dept_no = 'd007'
and de.to_date='9999-01-01'
order by ce.emp_no;

-- sales and development teams info
select ce.emp_no,
	ce.first_name,
	ce.last_name,
	d.dept_name
into sales_development_info
from current_empo as ce
	left join dept_emp as de
		on ce.emp_no = de.emp_no
	left join departments as d
		on d.dept_no = de.dept_no
where d.dept_no in('d007','d005')
and de.to_date='9999-01-01'
order by ce.emp_no;

Select * from sales_info


