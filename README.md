# Pewlett-Hackard-Analysis

## Project Overview
Pwelett Hackard company is preparing for upcoming employee retirements in next few years. At first, we are using a set of 6 csv files to build an employee database with SQL and find out there are 90,398 employees eligible for the retirement package with a quick query. 

To a take deeper look on those eligible- employee, we will generate two reports below to help managers in each department to make a plan on “silver tsunami”.
-	The number of retiring employees per title
-	The Employees Eligible for the Mentorship Program

## Results

- The [number of retiring employees per titles](https://github.com/BessHung/Pewlett-Hackard-Analysis/blob/20256a6d168ab22657b57be35df4fb98904925d4/Data/retiring_titles.csv) is generated based on the employees title and their age who were born between 1952-01-01 and 1955-12-31.
- In the first analysis, we can clearly know the number of retiring employees in different positions. In the total of 90,398 retiring employees, around 64% are senior staffs and 50% are engineer.
-  The list of [the employees eligible for the Mentorship Program](https://github.com/BessHung/Pewlett-Hackard-Analysis/blob/20256a6d168ab22657b57be35df4fb98904925d4/Data/mentorship_eligibilty.csv) is extracted from current employees who were born in 1965, this list including their name, working periods and title.
-  There are 1,549 employees are eligible for the mentorship program and most of them are with "senior" title.

## Summary

-	How many roles will need to be filled as the "silver tsunami" begins to make an impact?

According to the critiria for the number of retiring employees per title given by the Pwelett Hackard, it didn't exclude the employees who are already resigned. Thus, I create an additional query to add the condition `titles.to_date = '9999-01-01'` to filter out disable employees, and that will be 72,458 roles need to be filled, please see the detail number in the column of **Count of retiring employees** in the summary table below. 

```
Select count(e.emp_no),
	t.title
from employees as e
	inner join titles as t
		on e.emp_no = t.emp_no
where e.birth_date between '1952-01-01' and '1955-12-31'
and t.to_date = '9999-01-01'
group by t.title
order by count(e.emp_no) desc;
```

-	Are there enough qualified, retirement-ready employees in the departments to mentor the next generation of Pewlett Hackard employees?

To summarize the eligible-employee for the Mentorship Program per their title, I create a query to count the eligible-employee by title and the table to sum up the results.
If we assume that all the qualified employees are willing to attend this program and their abilities are all reach out the standard level, on average, there are about 45 new employees will be assigned to 1 mentor. However, that would be another issue to be considered.

```
Select count(emp_no), title
FROM mentorship_eligibilty
GROUP BY title
ORDER BY count(emp_no) DESC;
```

###### Summary of retiring employees and eligible-employee for the Mentorship Program
| Title | Count of retiring employees | Count of eligible-employee for the Mentorship Program | number of new hiring per mentor |
| ------------- | ------------- | ------------- | ------------- |
| Senior Engineer | 25916 | 529 | 49 |
| Senior Staff | 24926| 569 | 44 |
| Engineer | 9285| 190 | 49 |
| Staff | 7636 | 155 | 49 |
| Technique Leader | 3603 | 77 | 47 |
| Assistant Engineer | 1090 | 29 | 38 |
| Manager | 2 | 0 | NA |
| **Total** |**72458** | **1549** |  |
