-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jan 11, 2016 at 01:33 AM
-- Server version: 10.1.8-MariaDB
-- PHP Version: 5.6.14

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pc-rpg`
--

-- --------------------------------------------------------

--
-- Table structure for table `launcher`
--

CREATE TABLE `launcher` (
  `version` varchar(8) NOT NULL,
  `ip` varchar(16) NOT NULL,
  `port` varchar(4) NOT NULL,
  `website` varchar(32) NOT NULL,
  `frontpage` varchar(32) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `launcher`
--

INSERT INTO `launcher` (`version`, `ip`, `port`, `website`, `frontpage`) VALUES
('0.1.0', '127.0.0.1', '7777', 'www.pc-rpg.com', 'www.pc-rpg.com/launcher');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
