-- D1 additional table
Select count(e.emp_no),
	t.title
from employees as e
	inner join titles as t
		on e.emp_no = t.emp_no
where e.birth_date between '1952-01-01' and '1955-12-31'
and t.to_date = '9999-01-01'
group by t.title
order by count(e.emp_no) desc;

-- D2 additional table
Select count(emp_no), title
FROM mentorship_eligibilty
GROUP BY title
ORDER BY count(emp_no) DESC;
