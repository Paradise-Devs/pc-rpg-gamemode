-- phpMyAdmin SQL Dump
-- version 4.4.12
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 26, 2015 at 07:13
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
-- Table structure for table `factions`
--

CREATE TABLE IF NOT EXISTS `factions` (
  `id` int(11) unsigned NOT NULL,
  `spawn_x` float NOT NULL DEFAULT '0',
  `spawn_y` float NOT NULL DEFAULT '0',
  `spawn_z` float NOT NULL DEFAULT '0',
  `spawn_a` float NOT NULL DEFAULT '0',
  `name` varchar(32) NOT NULL,
  `type` int(11) DEFAULT '0',
  `max_ranks` int(11) NOT NULL DEFAULT '2',
  `custom` int(11) NOT NULL DEFAULT '0',
  `color` int(11) NOT NULL DEFAULT '0',
  `rank_name_1` varchar(32) NOT NULL,
  `rank_name_2` varchar(32) NOT NULL,
  `rank_name_3` varchar(32) NOT NULL,
  `rank_name_4` varchar(32) NOT NULL,
  `rank_name_5` varchar(32) NOT NULL,
  `rank_name_6` varchar(32) NOT NULL,
  `rank_name_7` varchar(32) NOT NULL,
  `rank_name_8` varchar(32) NOT NULL,
  `rank_name_9` varchar(32) NOT NULL,
  `rank_name_10` varchar(32) NOT NULL,
  `skin_1` int(11) NOT NULL DEFAULT '0',
  `skin_2` int(11) DEFAULT '0',
  `skin_3` int(11) NOT NULL DEFAULT '0',
  `skin_4` int(11) NOT NULL DEFAULT '0',
  `skin_5` int(11) NOT NULL DEFAULT '0',
  `skin_6` int(11) NOT NULL DEFAULT '0',
  `skin_7` int(11) DEFAULT '0',
  `skin_8` int(11) NOT NULL DEFAULT '0',
  `skin_9` int(11) NOT NULL DEFAULT '0',
  `skin_10` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `factions`
--
ALTER TABLE `factions`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `factions`
--
ALTER TABLE `factions`
  MODIFY `id` int(11) unsigned NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
