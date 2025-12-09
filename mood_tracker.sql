-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 09, 2025 at 10:52 AM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `mood_tracker`
--

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `version` varchar(255) NOT NULL,
  `class` varchar(255) NOT NULL,
  `group` varchar(255) NOT NULL,
  `namespace` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `batch` int(11) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `migrations`
--

INSERT INTO `migrations` (`id`, `version`, `class`, `group`, `namespace`, `time`, `batch`) VALUES
(5, '2025-12-08-042343', 'App\\Database\\Migrations\\CreateUsersTable', 'default', 'App', 1765174821, 1),
(6, '2025-12-08-042403', 'App\\Database\\Migrations\\CreateMoodsTable', 'default', 'App', 1765174822, 1);

-- --------------------------------------------------------

--
-- Table structure for table `moods`
--

CREATE TABLE `moods` (
  `mood_id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `date` date NOT NULL,
  `color` varchar(10) NOT NULL,
  `mood` varchar(50) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `moods`
--

INSERT INTO `moods` (`mood_id`, `user_id`, `date`, `color`, `mood`, `note`, `created_at`, `updated_at`, `deleted_at`) VALUES
('7d4154c3-8f9a-4fb7-b733-6f5a54fbd30a', '0e8caac3-922e-4260-a400-f647c3622276', '2025-12-08', '#FF9800', 'Sedih', 'ggggggg', '2025-12-08 08:41:18', '2025-12-08 09:01:48', NULL),
('8874d6e6-924b-414a-a24c-d4d9eddf47e1', '0e8caac3-922e-4260-a400-f647c3622276', '2025-12-09', '#FFC107', 'Biasa Saja', 'Uhuyywkwkwkwk', '2025-12-09 03:00:29', '2025-12-09 03:00:43', NULL),
('914bab77-32d9-4ec0-9628-d349e49f2234', '0e8caac3-922e-4260-a400-f647c3622276', '2025-12-12', '#4CAF50', 'Sangat Senang', 'Dapet Kerjaan', '2025-12-12 04:31:57', '2025-12-12 04:31:57', NULL),
('9e3f3343-0225-45c4-8eea-daec7675e73d', '0e8caac3-922e-4260-a400-f647c3622276', '2025-12-11', '#4CAF50', 'Sangat Senang', 'Dapet Kerjaan', '2025-12-11 04:31:54', '2025-12-11 04:31:54', NULL),
('c5d5875b-3334-4e82-874e-6ba0f6e7bfff', '0e8caac3-922e-4260-a400-f647c3622276', '2025-12-13', '#F44336', 'Sangat Sedih', 'Ditolak Kerjaan', '2025-12-13 04:32:17', '2025-12-13 04:32:17', NULL),
('d9654c29-9b21-4a01-aa2a-bdea9fb7280f', '0e8caac3-922e-4260-a400-f647c3622276', '2025-12-10', '#4CAF50', 'Sangat Senang', 'Dapet Kerjaan', '2025-12-10 04:31:36', '2025-12-10 04:31:36', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `user_id` char(36) NOT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user_id`, `name`, `email`, `password`, `created_at`, `updated_at`, `deleted_at`) VALUES
('', 'Dystian', 'tian@gmail.com', '$2y$10$QiwtkH6c20WFkHZ3OCA8Q.90r.T0L2/aPcnbffg46prYGIdrJzLiK', '2025-12-08 06:21:15', '2025-12-08 06:21:15', NULL),
('0e8caac3-922e-4260-a400-f647c3622276', 'Adis', 'adis@gmail.com', '$2y$10$eml11ABmAyomgHWpIR6dGuaQBbQ1lpc7mNH2G3jzn5XOrWkaJbvT.', '2025-12-08 08:00:37', '2025-12-08 08:00:37', NULL),
('29bd903a-7cd1-45c2-836d-10643e0d1c08', 'Uhuy', 'uhuy@gmail.com', '$2y$10$WwMdPVyvxvtLbFZT.yoxCOJTy1pobCOX7M06xuil6viHSnJ.sHq36', '2025-12-08 06:32:00', '2025-12-08 06:32:00', NULL),
('80f9f2b1-8b59-4f85-a62a-28431f5fd81f', 'Uhuyy', 'uhuyy@gmail.com', '$2y$10$mlRwBbjJZ0/PJ/OuAD4sketYZu0eH1wTHZwU9GM137v0ltR1.NIWu', '2025-12-09 01:59:30', '2025-12-09 01:59:30', NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `moods`
--
ALTER TABLE `moods`
  ADD PRIMARY KEY (`mood_id`),
  ADD UNIQUE KEY `unique_user_date` (`user_id`,`date`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`user_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `moods`
--
ALTER TABLE `moods`
  ADD CONSTRAINT `moods_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
