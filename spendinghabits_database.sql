-- Create database

CREATE DATABASE studentexpenses;

-- Choose the database studentexpenses

USE studentexpenses;

-- CREATE TABLE

CREATE TABLE major(
major_id INT AUTO_INCREMENT PRIMARY KEY,
major_name VARCHAR(50)
);

CREATE TABLE student (
student_id INT AUTO_INCREMENT PRIMARY KEY,
age INT NOT NULL,
gender ENUM('Male', 'Female', 'Non-binary') NOT NULL,
year_in_school VARCHAR(20) NOT NULL,
major_id INT,
FOREIGN KEY (major_id) REFERENCES major(major_id)
);

CREATE TABLE income (
income_id INT AUTO_INCREMENT PRIMARY KEY,
monthly_income INT NOT NULL,
financial_aid INT NOT NULL,
student_id INT,
FOREIGN KEY (student_id) REFERENCES student(student_id)
);

CREATE TABLE expenses (
expense_id INT AUTO_INCREMENT PRIMARY KEY,
tuition INT NOT NULL,
housing INT NOT NULL,
food INT NOT NULL,
transportation INT NULL,
books_supplies INT NULL,
entertainment INT NULL,
personal_care INT NULL,
technology INT NULL,
health_wellness INT NULL,
miscellaneous INT NULL,
preferred_payment_method VARCHAR (50) NOT NULL,
student_id INT,
FOREIGN KEY (student_id) REFERENCES student(student_id)
);

-- Rename column

ALTER TABLE student
RENAME COLUMN student_id TO id;

ALTER TABLE expenses
RENAME COLUMN preferred_payment_method TO payment_preference;


-- Updating columns

UPDATE student
SET major_id = (SELECT major_id FROM major WHERE major.major_id = student.id);

UPDATE income
SET student_id = (SELECT id FROM student WHERE student.id = income.income_id);

UPDATE expenses
SET student_id = (SELECT id FROM student WHERE student.id = expenses.expense_id);

-- Adding column

ALTER TABLE expenses
ADD monthly_tuition_fees INT AFTER tuition;

UPDATE expenses
SET monthly_tuition_fees = ROUND((tuition / 12),0);

ALTER TABLE expenses
ADD total_expenses INT AFTER miscellaneous;

UPDATE expenses
SET total_expenses = monthly_tuition_fees + housing + food + transportation + books_supplies + entertainment + personal_care + 
					technology + health_wellness + miscellaneous ;
                    
ALTER TABLE income
ADD total_income INT AFTER financial_aid;

UPDATE income
SET total_income = monthly_income + financial_aid ;











