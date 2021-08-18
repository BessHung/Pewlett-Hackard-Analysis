-- Deliverable 1: The Number of Retiring Employees by Title
-- raw data for retirement_titles
Select e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
into retirement_titles
from employees as e
	inner join titles as t
		on e.emp_no = t.emp_no
where e.birth_date between '1952-01-01' and '1955-12-31'
order by e.emp_no;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no,
first_name,
last_name,
title
INTO unique_titles
FROM retirement_titles
ORDER BY emp_no, to_date DESC;

-- Number of emp by title
Select count(emp_no), title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY count(emp_no) DESC;


-- Deliverable 2: The Employees Eligible for the Mentorship Program
Select distinct on (e.emp_no) e.emp_no,
	e.first_name,
	e.last_name,
	e.birth_date,
	de.from_date,
	de.to_date,
	t.title
into mentorship_eligibilty
from employees as e
	inner join dept_emp as de
		on e.emp_no = de.emp_no
	inner join titles as t
		on e.emp_no = t.emp_no
where e.birth_date between '1965-01-01' and '1965-12-31'
and t.to_date ='9999-01-01'
and de.to_date = '9999-01-01'
order by e.emp_no;

