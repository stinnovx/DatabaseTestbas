-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Nov 16, 2024 at 09:11 AM
-- Server version: 8.0.30
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `basystemstest`
--

-- --------------------------------------------------------

--
-- Table structure for table `departments`
--

CREATE TABLE `departments` (
  `dept_id` int NOT NULL,
  `dept_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `departments`
--

INSERT INTO `departments` (`dept_id`, `dept_name`) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Sales');

-- --------------------------------------------------------

--
-- Table structure for table `employees`
--

CREATE TABLE `employees` (
  `emp_id` int NOT NULL,
  `emp_name` varchar(100) NOT NULL,
  `dept_id` int DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `employees`
--

INSERT INTO `employees` (`emp_id`, `emp_name`, `dept_id`, `date_of_birth`) VALUES
(1, 'shanto', 1, '1985-04-12'),
(2, 'st', 2, '1990-08-23'),
(3, 'mr', 3, '1982-11-15'),
(4, 'salauddin', 4, '1995-07-19'),
(5, 'Eve', 1, '1992-03-22'),
(6, 'Frank', 2, '1990-01-10'),
(7, 'Grace', 3, '1988-12-05');

-- --------------------------------------------------------

--
-- Table structure for table `salaries`
--

CREATE TABLE `salaries` (
  `emp_id` int NOT NULL,
  `salary` decimal(10,2) NOT NULL,
  `bonus` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `salaries`
--

INSERT INTO `salaries` (`emp_id`, `salary`, `bonus`) VALUES
(1, '60000.00', '5000.00'),
(2, '56000.00', '8000.00'),
(4, '50000.00', '2000.00'),
(5, '60000.00', '5000.00'),
(6, '80000.00', '8000.00'),
(7, '75000.00', '6000.00');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `departments`
--
ALTER TABLE `departments`
  ADD PRIMARY KEY (`dept_id`);

--
-- Indexes for table `employees`
--
ALTER TABLE `employees`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `dept_id` (`dept_id`);

--
-- Indexes for table `salaries`
--
ALTER TABLE `salaries`
  ADD PRIMARY KEY (`emp_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `departments`
--
ALTER TABLE `departments`
  MODIFY `dept_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `employees`
--
ALTER TABLE `employees`
  MODIFY `emp_id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `employees`
--
ALTER TABLE `employees`
  ADD CONSTRAINT `employees_ibfk_1` FOREIGN KEY (`dept_id`) REFERENCES `departments` (`dept_id`);

--
-- Constraints for table `salaries`
--
ALTER TABLE `salaries`
  ADD CONSTRAINT `salaries_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `employees` (`emp_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;


SELECT e.emp_name, s.salary
FROM employees e
JOIN salaries s ON e.emp_id = s.emp_id
WHERE s.salary > 60000;



SELECT d.dept_name, SUM(s.salary) AS total_salary
FROM departments d
JOIN employees e ON d.dept_id = e.dept_id
JOIN salaries s ON e.emp_id = s.emp_id
GROUP BY d.dept_name
HAVING total_salary > 100000
ORDER BY total_salary DESC
LIMIT 2;



SELECT AVG(salary) AS avg_salary, 
	     MAX(salary) AS max_salary, 
       MIN(salary) AS min_salary 
FROM salaries;



SELECT emp_name 
FROM employees 
WHERE dept_id IN (1, 3)
AND date_of_birth BETWEEN '1985-01-01' AND '1995-12-31' 
AND emp_name LIKE '%a%' ;


SELECT e.emp_name, d.dept_name 
FROM employees e 
INNER JOIN departments d 
ON e.dept_id = d.dept_id;


SELECT e.emp_name, d.dept_name 
FROM employees e 
LEFT JOIN departments d 
ON e.dept_id = d.dept_id;


SELECT e.emp_name, d.dept_name 
FROM employees e 
RIGHT JOIN departments d 
ON e.dept_id = d.dept_id;


SELECT e.emp_name, d.dept_name 
FROM employees e 
CROSS JOIN departments d 
ON e.dept_id = d.dept_id;
