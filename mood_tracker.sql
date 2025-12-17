-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 17, 2025 at 10:40 AM
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
(8, '2025-12-08-042343', 'App\\Database\\Migrations\\CreateUsersTable', 'default', 'App', 1765937231, 1),
(9, '2025-12-08-042403', 'App\\Database\\Migrations\\CreateMoodsTable', 'default', 'App', 1765937231, 1),
(11, '2025-12-17-014608', 'App\\Database\\Migrations\\CreateMoodRecommendations', 'default', 'App', 1765937536, 2);

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
  `score` tinyint(4) NOT NULL DEFAULT 3,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `moods`
--

INSERT INTO `moods` (`mood_id`, `user_id`, `date`, `color`, `mood`, `note`, `score`, `created_at`, `updated_at`, `deleted_at`) VALUES
('07c701ec-28ea-432d-93f9-dc5752acaa82', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-11-10', '#4CAF50', 'Sangat Senang', 'Hari normal', 3, '2025-12-17 09:31:05', '2025-12-17 09:31:05', NULL),
('0abae7fe-2c51-4fcc-bdcf-3d00a0a38776', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-13', '#FFC107', 'Biasa Saja', 'Santai', 3, '2025-12-17 07:59:24', '2025-12-17 07:59:24', NULL),
('0c6d576c-bd30-442a-b0b6-48298483eb9d', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-11-04', '#4CAF50', 'Sangat Senang', 'Sedikit capek', 3, '2025-12-17 09:06:52', '2025-12-17 09:06:52', NULL),
('1419c196-23f0-48fb-a3cb-af06ef9f43d7', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-28', '#F44336', 'Sangat Sedih', 'Refleksi diri', 3, '2025-12-17 08:00:49', '2025-12-17 08:00:49', '2025-12-17 16:27:09'),
('19310b9b-889a-41d6-a66d-ab952b661c88', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-23', '#8BC34A', 'Senang', 'Planning 2026', 3, '2025-12-17 08:00:24', '2025-12-17 08:00:24', '2025-12-17 16:29:15'),
('19a18311-f915-4af5-852e-1859ec20296c', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-02', '#FFC107', 'Biasa Saja', 'Aktivitas rutin', 3, '2025-12-17 07:58:06', '2025-12-17 07:58:06', NULL),
('1f027af5-b29c-4e96-b4c4-a225978b52d4', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-24', '#4CAF50', 'Sangat Senang', 'Malam Natal', 3, '2025-12-17 08:00:30', '2025-12-17 08:00:30', '2025-12-17 16:27:42'),
('21a6710a-3592-4642-80ee-b147f794f8e5', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-17', '#8BC34A', 'Senang', 'Feedback positif', 3, '2025-12-17 07:59:53', '2025-12-17 07:59:53', NULL),
('236c4d14-9c13-4675-9491-a114cfc35249', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-01', '#8BC34A', 'Senang', 'Hari produktif', 3, '2025-12-17 07:57:46', '2025-12-17 07:57:46', NULL),
('2619b1e3-434f-4ef4-9418-facd72506642', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-26', '#8BC34A', 'Senang', 'Family time', 3, '2025-12-17 08:00:39', '2025-12-17 08:00:39', '2025-12-17 16:27:27'),
('3053b367-1d04-4342-9e23-72bb6021f4f9', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-11-08', '#4CAF50', 'Sangat Senang', 'Routine work', 3, '2025-12-17 09:30:51', '2025-12-17 09:30:51', NULL),
('38573237-a6b2-4335-8cf0-e4aa0feda48f', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-11', '#8BC34A', 'Senang', 'Problem solved', 3, '2025-12-17 07:59:12', '2025-12-17 07:59:12', NULL),
('39825765-3b82-4448-8402-46ee7994fe7a', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-19', '#FFC107', 'Biasa Saja', 'Maintenance', 3, '2025-12-17 08:00:06', '2025-12-17 08:00:06', NULL),
('41b89892-4172-4713-8483-c490f9b56979', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-05', '#4CAF50', 'Sangat Senang', 'Target tercapai', 3, '2025-12-17 07:58:26', '2025-12-17 07:58:26', NULL),
('54486eaa-818d-41ee-98c6-82840812c95c', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-14', '#8BC34A', 'Senang', 'Olahraga', 3, '2025-12-17 07:59:30', '2025-12-17 07:59:30', NULL),
('56cd4a3f-9095-48cb-8f13-cfaffb6506b5', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-11-09', '#4CAF50', 'Sangat Senang', 'Kurang fit', 3, '2025-12-17 09:30:57', '2025-12-17 09:30:57', NULL),
('57affd6a-0e26-49e9-af96-ba39a425c98f', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-04', '#FF9800', 'Sedih', 'Sedikit capek', 3, '2025-12-17 07:58:19', '2025-12-17 07:58:19', NULL),
('5c5283be-2639-4fff-8b03-b372f696fe1b', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-03', '#8BC34A', 'Senang', 'Progress kerja bagus', 3, '2025-12-17 07:58:14', '2025-12-17 07:58:14', NULL),
('6119e8d5-a200-4c18-ad70-dd4ef5a11b2f', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-15', '#FF9800', 'Sedih', 'Deadline mepet', 3, '2025-12-17 07:59:35', '2025-12-17 07:59:35', NULL),
('62021574-ab25-41f0-b90d-c5d2e7dac1d0', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-07', '#8BC34A', 'Senang', 'Quality time keluarga', 3, '2025-12-17 07:58:43', '2025-12-17 07:58:43', NULL),
('69f6a23b-0370-4708-8b81-9bd75fb2ae5e', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-16', '#FFC107', 'Biasa Saja', 'Hari normal', 3, '2025-12-17 07:59:41', '2025-12-17 07:59:41', NULL),
('71c31052-d2bb-4c10-a898-20d96d5e41c7', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-29', '#FF9800', 'Sedih', 'Capek', 3, '2025-12-17 08:00:53', '2025-12-17 08:00:53', '2025-12-01 16:26:58'),
('720e526d-76d1-4909-8357-97a86aa16b6b', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-08', '#FFC107', 'Biasa Saja', 'Meeting', 3, '2025-12-17 07:58:49', '2025-12-17 07:58:49', NULL),
('7ac06f87-eb4d-4fb9-97e2-5ab01d31aeea', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-21', '#FF9800', 'Sedih', 'Kurang tidur', 3, '2025-12-17 08:00:15', '2025-12-17 08:00:15', '2025-12-17 16:29:26'),
('7af9b53d-21f0-4b58-9fd0-5f1d6c2b5127', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-27', '#FFC107', 'Biasa Saja', 'Santai', 3, '2025-12-17 08:00:44', '2025-12-17 08:00:44', '2025-12-17 16:27:20'),
('8242ab49-c3d8-44d4-aac8-f7bc4fed9fac', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-11-06', '#4CAF50', 'Sangat Senang', 'Santai', 3, '2025-12-17 09:30:41', '2025-12-17 09:30:41', NULL),
('86ad19c0-fda1-472e-9a0b-44a511f2f3ad', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-11-07', '#8BC34A', 'Senang', 'Meeting lancar', 3, '2025-12-17 09:30:46', '2025-12-17 09:30:46', NULL),
('86c20508-34cc-499d-8a96-3cbbd6dcc469', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-06', '#FFC107', 'Biasa Saja', 'Santai', 3, '2025-12-17 07:58:32', '2025-12-17 07:58:32', NULL),
('8f4ce052-c218-4d3c-a339-2565d64e4e44', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-18', '#4CAF50', 'Sangat Senang', 'Project selesai', 3, '2025-12-17 08:00:01', '2025-12-17 08:00:01', NULL),
('9b92cef5-e3d2-416d-a1ef-8fbaee48826c', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-31', '#4CAF50', 'Sangat Senang', 'Tahun baru', 3, '2025-12-17 08:01:02', '2025-12-17 08:01:02', '2025-12-01 16:26:26'),
('9da00b95-42da-4bb6-9511-6c702e6828f8', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-10', '#FFC107', 'Biasa Saja', 'Ketemu Client Kecil', 3, '2025-12-17 07:59:01', '2025-12-17 07:59:01', NULL),
('9f30b1c6-299d-4be2-81fe-2183f38fd3cd', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-25', '#4CAF50', 'Sangat Senang', 'Libur', 3, '2025-12-17 08:00:35', '2025-12-17 08:00:35', '2025-12-17 16:29:01'),
('aa4efb60-18c1-4976-b2a5-ba35cfe9820f', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-30', '#8BC34A', 'Senang', 'Tutup tahun', 3, '2025-12-17 08:00:58', '2025-12-17 08:00:58', '2025-12-17 16:28:57'),
('c5f83292-1add-4fbc-b018-74c3c9763d7e', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-22', '#FFC107', 'Biasa Saja', 'Routine', 3, '2025-12-17 08:00:20', '2025-12-17 08:00:20', '2025-12-17 16:29:21'),
('c8f58b88-744c-4c31-a550-cfe9f81a37a8', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-20', '#8BC34A', 'Senang', 'Hangout', 3, '2025-12-17 08:00:10', '2025-12-17 08:00:10', NULL),
('d353f2c3-86cd-4901-9dca-823d3af83d34', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-11-01', '#8BC34A', 'Senang', 'Awal bulan', 3, '2025-12-17 09:06:36', '2025-12-17 09:06:36', NULL),
('ed954f2c-1560-479f-95f0-ecb3b5833c13', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-11-05', '#4CAF50', 'Sangat Senang', 'Target tercapai', 3, '2025-12-17 09:30:37', '2025-12-17 09:30:37', NULL),
('faa90617-6e1b-49cd-8089-2b41668bded9', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-12', '#4CAF50', 'Sangat Senang', 'Closing deal', 3, '2025-12-17 07:59:19', '2025-12-17 07:59:19', NULL),
('fafc53f3-e45d-4baa-98fd-bd9556ec16db', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-11-03', '#8BC34A', 'Senang', 'Produktif', 3, '2025-12-17 09:06:46', '2025-12-17 09:06:46', NULL),
('fd6d3f7a-3bad-44fa-9353-e5442872a52d', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-12-09', '#FF9800', 'Sedih', 'Kurang fit', 3, '2025-12-17 07:58:55', '2025-12-17 07:58:55', NULL),
('ff11d0d2-c0bd-4fad-940a-6107627ec82c', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', '2025-11-02', '#FFC107', 'Biasa Saja', 'Aktivitas rutin', 3, '2025-12-17 09:06:42', '2025-12-17 09:06:42', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `mood_recommendations`
--

CREATE TABLE `mood_recommendations` (
  `recommendation_id` char(36) NOT NULL,
  `user_id` char(36) NOT NULL,
  `month` tinyint(4) NOT NULL,
  `year` smallint(6) NOT NULL,
  `average_mood` decimal(3,1) NOT NULL,
  `low_mood_days` int(11) NOT NULL,
  `level` enum('good','neutral','bad') NOT NULL,
  `recommendation` text NOT NULL,
  `source` enum('rule','ai') NOT NULL DEFAULT 'ai',
  `prompt_version` varchar(20) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `mood_recommendations`
--

INSERT INTO `mood_recommendations` (`recommendation_id`, `user_id`, `month`, `year`, `average_mood`, `low_mood_days`, `level`, `recommendation`, `source`, `prompt_version`, `created_at`, `updated_at`, `deleted_at`) VALUES
('3c82645e-1ca4-4d04-94eb-91b4cfe0f343', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', 11, 2025, 4.5, 0, 'good', 'Mood kamu secara umum sangat baik. Pertahankan rutinitas positif yang sudah berjalan.', 'rule', 'v1', '2025-12-17 09:39:42', NULL, NULL),
('bbef5d1d-c60f-4672-83ed-d0a35b21f934', '5e2aaa7d-37ad-4df2-8edb-56d119a773f6', 12, 2025, 3.6, 5, 'neutral', 'Mood kamu cukup stabil. Tetap jaga keseimbangan antara aktivitas dan waktu istirahat.', 'rule', 'v1', '2025-12-17 08:01:11', NULL, NULL);

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
('5e2aaa7d-37ad-4df2-8edb-56d119a773f6', 'adis', 'adis@gmail.com', '$2y$10$pqMnC8iZ/IDV0r1MOrmsVON1nEsS0rwUznqJxyEzMBTT93PSryl0O', '2025-12-17 02:07:29', '2025-12-17 02:07:29', NULL);

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
-- Indexes for table `mood_recommendations`
--
ALTER TABLE `mood_recommendations`
  ADD PRIMARY KEY (`recommendation_id`),
  ADD UNIQUE KEY `user_id_month_year` (`user_id`,`month`,`year`);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `moods`
--
ALTER TABLE `moods`
  ADD CONSTRAINT `moods_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `mood_recommendations`
--
ALTER TABLE `mood_recommendations`
  ADD CONSTRAINT `mood_recommendations_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
