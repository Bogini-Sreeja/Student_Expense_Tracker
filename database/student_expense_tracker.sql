-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 29, 2026 at 04:14 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `student_expense_tracker`
--

-- --------------------------------------------------------

--
-- Table structure for table `budget`
--

CREATE TABLE `budget` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `budget`
--

INSERT INTO `budget` (`id`, `user_id`, `amount`) VALUES
(4, 5, 1000.00);

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `id` int(11) NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `amount` decimal(10,2) DEFAULT NULL,
  `category` varchar(100) DEFAULT NULL,
  `expense_date` date DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`id`, `user_id`, `title`, `amount`, `category`, `expense_date`, `created_at`) VALUES
(2, 1, 'dinner', 80.00, 'food', '2026-05-22', '2026-05-22 12:53:48'),
(3, 1, 'dinner', 100.00, 'food', '2026-05-22', '2026-05-22 12:54:00'),
(4, 1, 'tea', 10.00, 'drink', '2026-05-22', '2026-05-22 12:54:15'),
(5, 1, 'clothes', 2000.00, 'shopping', '2026-05-22', '2026-05-22 13:13:00'),
(6, 5, 'milk', 20.00, 'drink', '2026-05-22', '2026-05-22 13:30:00'),
(7, 4, 'milk', 20.00, 'drink', '2026-05-22', '2026-05-22 13:30:31'),
(8, 4, 'lunch', 20.00, 'food', '2026-05-22', '2026-05-22 13:30:56'),
(9, 5, 'cofee', 20.00, 'food', '2026-05-22', '2026-05-23 16:43:27'),
(10, 5, 'dresses', 2000.00, 'shopping', '2026-05-22', '2026-05-29 13:27:01');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `created_at`) VALUES
(1, 'Indira', 'ikavvampalli@gmail.com', '$2b$10$HjlwkNMlKORDXs4uJV4eVOz1bEENAcjEbBWmh4rIfj8QrVBvlr1nG', '2026-05-21 03:13:30'),
(3, 'Ramesh', 'test@gmail.com', '$2b$10$Cd7wGBBKd0RWfqXhWFTHlu5nyVzWl/AghKt/rwH7zTa7bvGvf1nym', '2026-05-21 03:37:13'),
(4, 'Abhi', 'abhi@gmail.com', '$2b$10$niaDdkWbV9hASBfVQP4IE.MNJVpaaBALoqQ8WEQBOLanQP7BaxfTG', '2026-05-22 09:47:44'),
(5, 'laxmi', 'laxmi@gmail.com', '$2b$10$3CElGFCbsobITnjLtuLTyeCwEmQKYX3hVDkZ4BhIXC3nFZt.HyApO', '2026-05-22 13:12:09');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `budget`
--
ALTER TABLE `budget`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `budget`
--
ALTER TABLE `budget`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
