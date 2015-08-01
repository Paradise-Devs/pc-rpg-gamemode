-- phpMyAdmin SQL Dump
-- version 4.4.12
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jul 28, 2015 at 11:47
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
-- Table structure for table `players`
--

CREATE TABLE IF NOT EXISTS `players` (
  `ID` int(11) NOT NULL,
  `username` varchar(25) DEFAULT '0',
  `password` varchar(32) DEFAULT NULL,
  `ip` varchar(16) DEFAULT NULL,
  `email` varchar(128) DEFAULT NULL,
  `x` float DEFAULT '0',
  `y` float DEFAULT '0',
  `z` float DEFAULT '0',
  `a` float DEFAULT '0',
  `interior` int(11) DEFAULT '0',
  `virtual_world` int(11) DEFAULT '0',
  `health` float DEFAULT '100',
  `armour` float DEFAULT '0',
  `skin` int(11) DEFAULT '299',
  `rank` int(10) unsigned NOT NULL DEFAULT '0',
  `faction` int(11) NOT NULL DEFAULT '0',
  `faction_rank` int(11) NOT NULL DEFAULT '0',
  `last_login` int(11) DEFAULT '0',
  `regdate` int(11) DEFAULT '0',
  `gender` tinyint(1) DEFAULT '0',
  `money` int(11) NOT NULL DEFAULT '0',
  `hospital` int(11) NOT NULL DEFAULT '0',
  `achievements` int(11) NOT NULL DEFAULT '0',
  `ticket` int(11) NOT NULL DEFAULT '0',
  `jobid` int(10) unsigned NOT NULL DEFAULT '0',
  `jobxp` int(10) unsigned NOT NULL DEFAULT '0',
  `joblv` int(10) unsigned NOT NULL DEFAULT '1',
  `ftime` int(10) unsigned NOT NULL DEFAULT '0',
  `hunger` float unsigned NOT NULL DEFAULT '100.0',
  `thirst` float unsigned NOT NULL DEFAULT '100.0',
  `sleep` float unsigned NOT NULL DEFAULT '100.0',
  `addiction` float unsigned NOT NULL DEFAULT '100.0',
  `phone_number` int(10) unsigned NOT NULL DEFAULT '0',
  `phone_network` int(10) unsigned NOT NULL DEFAULT '0',
  `phone_credits` int(10) unsigned NOT NULL DEFAULT '0',
  `phone_state` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- AUTO_INCREMENT for table `factions`
--
ALTER TABLE `players`
  MODIFY `ID` int(11) unsigned NOT NULL AUTO_INCREMENT;
