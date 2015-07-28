-- phpMyAdmin SQL Dump
-- version 4.4.12
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 28, 2015 at 09:33 
-- Server version: 5.6.25
-- PHP Version: 5.6.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pcrpg`
--

-- --------------------------------------------------------

--
-- Table structure for table `vehicles`
--

CREATE TABLE IF NOT EXISTS `vehicles` (
  `ID` int(11) NOT NULL,
  `vehicle_model` smallint(6) DEFAULT '400',
  `vehicle_col1` int(11) DEFAULT '1',
  `vehicle_col2` int(11) DEFAULT '1',
  `vehicle_siren` tinyint(4) DEFAULT '0',
  `vehicle_x` float DEFAULT '0',
  `vehicle_y` float DEFAULT '0',
  `vehicle_z` float DEFAULT '0',
  `vehicle_a` float DEFAULT '0',
  `vehicle_fuel` float DEFAULT '100',
  `vehicle_health` float DEFAULT '1000',
  `vehicle_faction` int(11) DEFAULT '0',
  `vehicle_job` int(11) NOT NULL DEFAULT '0',
  `vehicle_locked` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `vehicles`
--

INSERT INTO `vehicles` (`ID`, `vehicle_model`, `vehicle_col1`, `vehicle_col2`, `vehicle_siren`, `vehicle_x`, `vehicle_y`, `vehicle_z`, `vehicle_a`, `vehicle_fuel`, `vehicle_health`, `vehicle_faction`, `vehicle_job`, `vehicle_locked`) VALUES
(1, 577, 1, 0, 0, 1806.23, -2443.24, 13.5, 129.827, 0, 1000, 0, 0, 1),
(2, 577, 1, 0, 0, 1721.7, -2448.17, 13.4702, 129.976, 0, 1000, 0, 0, 1),
(3, 577, 1, 0, 0, 1645.23, -2444.56, 13.5476, 139.856, 0, 1000, 0, 0, 1),
(4, 577, 1, 0, 0, 1563.84, -2445.95, 13.4713, 143.159, 0, 1000, 0, 0, 1),
(5, 592, 1, 1, 0, 1974.13, -2381.08, 14.7411, 89.5764, 100, 1000, 0, 0, 1),
(6, 592, 1, 1, 0, 1974.13, -2316.77, 14.7432, 89.5764, 0, 1000, 0, 0, 1),
(7, 496, 3, 3, 0, 1325.22, -1379.68, 13.593, 180.28, 0, 1000, 0, 0, 1),
(8, 496, 3, 3, 0, 1294.87, -1379.68, 13.593, 180.28, 0, 1000, 0, 0, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=9;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
