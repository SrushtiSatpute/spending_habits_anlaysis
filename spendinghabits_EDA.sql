-- EDA

-- 1) Student Analysis

-- Find the total no of students

SELECT
COUNT(id) AS total_students
FROM student;


-- How many students are enrolled in each year of school?
 
SELECT
COUNT(id) AS student_count,
year_in_school
FROM student
GROUP BY year_in_school
ORDER BY student_count DESC;
 
 
 -- Distribution of students by gender
 
 SELECT
 gender,
 ROUND(AVG(age),0) AS avg_age,
 COUNT(*) AS count,
 ROUND(COUNT(*) / (SELECT COUNT(*) FROM student) * 100) AS 'percent'
 FROM student
 GROUP BY gender;
 
 
 -- Distribution of students by age
 
 -- a) Min and Max age of student
 
 SELECT
 MIN(age),
 MAX(age)
 FROM student;
 
 -- b)  Find the student's average age
 
 SELECT
 ROUND(AVG(age),2) AS average_age
 FROM student;
 
 
 -- 2) Budget allocation
 
 
 -- Find the total income information for each gender category, including the average, maximum, and minimum.
 
 
 WITH CTE_example(gender,avg_monthly_income,max_monthly_income,min_monthly_income,count_income) AS
(
  SELECT
  gender,
  ROUND(AVG(monthly_income),2),
  MAX(monthly_income),
  MIN(monthly_income),
  COUNT(monthly_income)
  FROM student
  JOIN income
  ON student.id = income.student_id
  GROUP BY gender
  )
  SELECT *
  FROM CTE_example
  ;
 
 
 
 -- Calculate the average amount spent.
 
 SELECT 
 ROUND(AVG(total_expenses),2) AS avg_spending
 FROM expenses;
 
 
 -- What is average monthly spending on housing,food, and transportation?
 
 
 WITH CTE_example2 AS
 (
 SELECT
 ROUND(AVG(housing),2) AS avg_housing,
 ROUND(AVG(food),2) AS avg_food,
 ROUND(AVG(transportation),2) AS avg_transportation
 FROM expenses
 )
 SELECT *
 FROM CTE_example2;
 
 
 -- How does spending on books_supplies vary across different majors?
 
 SELECT 
 m.major_name,
 ROUND(AVG(e.books_supplies),2) AS avg_books_supplies
 FROM major m
 JOIN student s
 ON m.major_id = s.major_id
 JOIN expenses e
 ON e.student_id = s.id
 GROUP BY m.major_name
 ORDER BY avg_books_supplies DESC;
 
 
 
 -- Which five student IDs with highest overall percentage,considering entertainment, personal care, and miscellaneous expenses as a proportion of their total income? 
 
SELECT
s.id,
s.year_in_school,
ROUND(((e.entertainment + e.personal_care + e.miscellaneous) / total_income) * 100 ,2) AS expense_percent
FROM expenses e
JOIN student s
ON e.student_id = s.id
JOIN income i
ON i.student_id = s.id
ORDER BY expense_percent DESC
LIMIT 5;


-- Which major has the highest tuition fees?

SELECT
m.major_name,
MAX(e.tuition) AS max_tuition_fees
FROM major m
JOIN student s
ON m.major_id = s.major_id
JOIN expenses e
ON e.student_id = s.id
GROUP BY m.major_name
ORDER BY max_tuition_fees DESC;


-- What is the most frequently used payment method among students?

SELECT
payment_preference,
COUNT(*) AS preference_count
FROM student
JOIN expenses
on student.id = expenses.student_id
GROUP BY payment_preference
ORDER BY payment_preference DESC
LIMIT 1;





 
 
 
 
 
 
 