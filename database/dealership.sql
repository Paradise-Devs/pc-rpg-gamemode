-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 02-Ago-2015 às 16:58
-- Versão do servidor: 5.6.24
-- PHP Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `pcrpg`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `dealership`
--

CREATE TABLE IF NOT EXISTS `dealership` (
  `ID` int(11) NOT NULL,
  `Owner` varchar(25) DEFAULT NULL,
  `OwnerID` int(11) DEFAULT NULL,
  `Model` int(11) DEFAULT NULL,
  `X` float DEFAULT NULL,
  `Y` float DEFAULT NULL,
  `Z` float DEFAULT NULL,
  `A` float DEFAULT NULL,
  `World` int(11) DEFAULT NULL,
  `Interior` int(11) DEFAULT NULL,
  `Color1` int(11) DEFAULT NULL,
  `Color2` int(11) DEFAULT NULL,
  `Paintjob` int(11) DEFAULT NULL,
  `Health` float DEFAULT NULL,
  `Fuel` float DEFAULT NULL,
  `Fines` int(11) DEFAULT NULL,
  `Mod1` int(11) DEFAULT NULL,
  `Mod2` int(11) DEFAULT NULL,
  `Mod3` int(11) DEFAULT NULL,
  `Mod4` int(11) DEFAULT NULL,
  `Mod5` int(11) DEFAULT NULL,
  `Mod6` int(11) DEFAULT NULL,
  `Mod7` int(11) DEFAULT NULL,
  `Mod8` int(11) DEFAULT NULL,
  `Mod9` int(11) DEFAULT NULL,
  `Mod10` int(11) DEFAULT NULL,
  `Mod11` int(11) DEFAULT NULL,
  `Mod12` int(11) DEFAULT NULL,
  `Mod13` int(11) DEFAULT NULL,
  `Mod14` int(11) DEFAULT NULL,
  `Mod15` int(11) DEFAULT NULL,
  `Mod16` int(11) DEFAULT NULL,
  `Mod17` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `dealership`
--
ALTER TABLE `dealership`
  ADD PRIMARY KEY (`ID`), ADD KEY `ID` (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `dealership`
--
ALTER TABLE `dealership`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
