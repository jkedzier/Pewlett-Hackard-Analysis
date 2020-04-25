--Create query for retirement eligible employees by title
SELECT e.emp_no,
	e.first_name,
e.last_name,
t.title,
t.from_date,
	s.salary
	INTO emp_title_info
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no) 
inner join titles as t
on (e.emp_no=t.emp_no)
WHERE (e.birth_date BETWEEN '1952-01-01' AND '1955-12-31')
     AND (e.hire_date BETWEEN '1985-01-01' AND '1988-12-31')
	 AND (de.to_date = '9999-01-01')
	 AND (t.to_date = '9999-01-01')
ORDER BY de.dept_no;

--Create a summary count table of the number of retirees by title
select title, count(*) as num_retirees 
into title_retiree_count 
from emp_title_info
group by title
order by title;

--Create a list of all employees with their current title
SELECT e.emp_no,
	e.first_name,
e.last_name,
t.title,
t.from_date,
	s.salary
	INTO emp_title_join
FROM employees as e
INNER JOIN salaries as s
ON (e.emp_no = s.emp_no)
INNER JOIN dept_emp as de
ON (e.emp_no = de.emp_no) 
inner join titles as t
on (e.emp_no=t.emp_no)
WHERE 
     (de.to_date = '9999-01-01')
	 AND (t.to_date = '9999-01-01');
	 
--Summarized count of all employees by current title	
select
title,
count(*)
into total_emp_by_title
from
emp_title_join
group by title;


--Query to identify candidates for mentorship
SELECT e.emp_no,
	e.first_name,
e.last_name,
t.title,
t.from_date,
	t.to_date
	INTO mentor_eligibility
FROM employees as e
inner join titles as t
on (e.emp_no=t.emp_no)
WHERE (e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
     	 AND (t.to_date = '9999-01-01');
		 
		 
select count(*) from  mentor_eligibility;