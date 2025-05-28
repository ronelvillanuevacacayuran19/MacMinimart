-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 15, 2025 at 07:04 AM
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
-- Database: `macminimart`
--

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `type` varchar(100) NOT NULL,
  `price` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`id`, `name`, `type`, `price`) VALUES
(1, 'Piatos', 'JunkFoods', 15.00),
(2, 'Lean n green Coffee', 'Fat Burners', 35.00),
(3, 'Cobra', 'Drinks', 20.00),
(4, 'Gardenia', 'Bread', 20.00),
(5, 'Bear Brand', 'Milk', 30.00),
(6, 'Pepsi', 'Drinks', 12.00),
(7, 'Downy', 'Fabcon', 10.00),
(8, 'Buldak', 'Korean Noodles', 80.00),
(9, 'Alaska Evaporada', 'Milk', 50.00),
(10, 'Magic Sarap', 'Food Seasonings', 5.00),
(11, 'Marlboro Blue', 'Cigarette', 10.00),
(12, 'Rebisco', 'Crackers', 8.00),
(13, 'Zonrox', 'Bleach', 25.00),
(14, 'Coco Mama', 'Gata', 30.00),
(15, 'Gatorade', 'Energy Drink', 18.00),
(16, 'Vitamilk', 'Milk', 45.00),
(17, 'Chicharon ni Mang Juan', 'Junk foods', 10.00),
(18, 'Cream O', 'Cookies', 12.00),
(19, 'Watataps', 'Cupcake', 9.00),
(20, 'Red Horse', 'Liquor', 70.00),
(21, 'Mountain Dew', 'Soft Drinks', 15.00),
(22, 'Cream Line IceDrop', 'Ice Cream', 20.00),
(23, 'Sinigang Mix', 'For Fish', 10.00),
(24, 'San Mig Light', 'Beer', 60.00),
(25, 'Fortune Green', 'Cigarette', 9.00),
(26, 'Tender Juicy', 'Hotdogs', 55.00),
(27, 'Pampanga\'s Best', 'Tocino', 60.00),
(28, 'Cube Ice', 'Ice', 15.00),
(29, 'Shoe Glue', 'Pandikit', 15.00),
(30, 'Colgate', 'Toothpaste', 12.00),
(31, 'Chucky', 'Drinks', 25.00),
(32, 'Biggy', 'Juice', 15.00),
(33, 'Uling', 'For Cooking', 35.00),
(34, 'Milo', 'Chocolate Drink', 12.00),
(35, 'Tang', 'Juice', 25.00);

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` int(11) NOT NULL,
  `transaction_time` datetime DEFAULT current_timestamp(),
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transactions`
--

INSERT INTO `transactions` (`id`, `transaction_time`, `user_id`) VALUES
(1, '2025-05-14 19:36:49', 0),
(2, '2025-05-14 20:42:35', 0),
(3, '2025-05-14 21:23:41', 0),
(4, '2025-05-15 10:02:17', 0),
(5, '2025-05-15 10:03:58', 0),
(6, '2025-05-15 10:04:58', 0),
(7, '2025-05-15 10:20:00', 0),
(8, '2025-05-15 10:24:22', 0),
(9, '2025-05-15 10:30:33', 0),
(10, '2025-05-15 10:48:37', 0),
(11, '2025-05-15 10:54:15', 0),
(12, '2025-05-15 11:10:49', 3);

-- --------------------------------------------------------

--
-- Table structure for table `transaction_items`
--

CREATE TABLE `transaction_items` (
  `id` int(11) NOT NULL,
  `transaction_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `transaction_items`
--

INSERT INTO `transaction_items` (`id`, `transaction_id`, `product_id`) VALUES
(1, 1, 5),
(2, 1, 5),
(3, 1, 4),
(4, 1, 33),
(5, 1, 1),
(6, 1, 1),
(7, 1, 1),
(8, 1, 1),
(9, 2, 1),
(10, 2, 33),
(11, 3, 16),
(12, 4, 16),
(13, 5, 2),
(14, 5, 32),
(15, 6, 5),
(16, 6, 7),
(17, 6, 8),
(18, 7, 35),
(19, 8, 24),
(20, 9, 33),
(21, 10, 1),
(22, 11, 31),
(23, 11, 35),
(24, 12, 1),
(25, 12, 10);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`) VALUES
(1, 'Ronelkupal', 'scrypt:32768:8:1$82cabEb96JfZb5KF$47e8f2e1a586181c620b36049034ea1d4101033d1c7dd8f4206ec8f9729c46537bce6b8ea83ea78476f33d28e28fd8b43459a596af9f5e22187838e15cc01228'),
(2, 'Terizla12345', 'scrypt:32768:8:1$cdGsiOMTiBqvRi4r$d55c4f52a494881835135b3efbec9fc5fdcf011fbb4680cf4266a130387193b427ce54a8fac00555c6231eaf7725bfe66a7e978bedd73de2cffc5ddd665c2b9d'),
(3, 'AlexanderAturdido', 'scrypt:32768:8:1$NfEe8DVAO2vJxoIL$bf31b4e2a569c6facf4919c73ddb8c02832b16d63998dc168df1398dac509306c9f004be6eedd11f81c0e675ab5ee76a17a08c6c68615145d66f9d5e475b6a65');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction_items`
--
ALTER TABLE `transaction_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transaction_id` (`transaction_id`),
  ADD KEY `product_id` (`product_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `transaction_items`
--
ALTER TABLE `transaction_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `transaction_items`
--
ALTER TABLE `transaction_items`
  ADD CONSTRAINT `transaction_items_ibfk_1` FOREIGN KEY (`transaction_id`) REFERENCES `transactions` (`id`),
  ADD CONSTRAINT `transaction_items_ibfk_2` FOREIGN KEY (`product_id`) REFERENCES `products` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
