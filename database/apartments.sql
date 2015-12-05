-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 17-Jul-2015 às 21:44
-- Versão do servidor: 5.6.24
-- PHP Version: 5.6.8

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `server`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `apartments`
--

CREATE TABLE IF NOT EXISTS `apartments` (
  `ID` int(11) NOT NULL,
  `Owner` varchar(25) DEFAULT NULL,
  `Location` varchar(32) DEFAULT NULL,
  `EnterX` float DEFAULT NULL,
  `EnterY` float DEFAULT NULL,
  `EnterZ` float DEFAULT NULL,
  `EnterA` float DEFAULT NULL,
  `DoorModel` int(11) DEFAULT NULL,
  `DoorX` float DEFAULT NULL,
  `DoorY` float DEFAULT NULL,
  `DoorZ` float DEFAULT NULL,
  `DoorA` float DEFAULT NULL,
  `Owned` tinyint(1) DEFAULT NULL,
  `Locked` tinyint(1) DEFAULT NULL,
  `Price` int(11) DEFAULT NULL,
  `ObjsAmount` int(11) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `apartments`
--

INSERT INTO `apartments` (`ID`, `Owner`, `Location`, `EnterX`, `EnterY`, `EnterZ`, `EnterA`, `DoorModel`, `DoorX`, `DoorY`, `DoorZ`, `DoorA`, `Owned`, `Locked`, `Price`, `ObjsAmount`) VALUES
(1, 'Ninguem', 'Rodeo', 294.73, -1623.54, 47, 80.75, 1504, 295.3, -1624.5, 46.01, 80, 0, 1, 275000, 0),
(2, 'Ninguem', 'Rodeo', 276.63, -1620.47, 47, 261.5, 1504, 275.51, -1621.02, 46.01, 80, 0, 1, 275000, 0),
(3, 'Ninguem', 'Rodeo', 294.58, -1623.64, 51.5, 81.83, 1504, 295.3, -1624.5, 50.5, 80, 0, 1, 275000, 0),
(4, 'Ninguem', 'Rodeo', 276.61, -1620.5, 51.5, 260.85, 1504, 275.51, -1621.02, 50.5, 80, 0, 1, 275000, 0),
(5, 'Ninguem', 'Rodeo', 294.98, -1623.72, 56, 80.33, 1504, 295.3, -1624.5, 54.99, 80, 0, 1, 275000, 0),
(6, 'Ninguem', 'Rodeo', 276.56, -1620.35, 56, 260.54, 1504, 275.51, -1621.02, 55.02, 80, 0, 1, 275000, 0),
(7, 'Ninguem', 'Rodeo', 294.89, -1623.64, 60.5, 76.35, 1504, 295.3, -1624.5, 59.51, 80, 0, 1, 275000, 0),
(8, 'Ninguem', 'Rodeo', 276.83, -1620.42, 60.5, 258.37, 1504, 275.51, -1621.02, 59.51, 80, 0, 1, 275000, 0),
(9, 'Ninguem', 'Rodeo', 294.73, -1623.62, 65, 80.11, 1504, 295.3, -1624.5, 63.99, 80, 0, 1, 275000, 0),
(10, 'Ninguem', 'Rodeo', 276.54, -1620.55, 65, 263.02, 1504, 275.51, -1621.02, 64.02, 80, 0, 1, 275000, 0),
(11, 'Ninguem', 'Rodeo', 294.98, -1623.77, 69.5, 76.17, 1504, 295.3, -1624.5, 68.49, 80, 0, 1, 275000, 0),
(12, 'Ninguem', 'Rodeo', 276.56, -1620.52, 69.5, 258.9, 1504, 275.51, -1621.02, 68.52, 80, 0, 1, 275000, 0),
(13, 'Ninguem', 'Rodeo', 294.98, -1623.72, 74, 84.23, 1504, 295.3, -1624.5, 73.01, 80, 0, 1, 290000, 0),
(14, 'Ninguem', 'Rodeo', 276.55, -1620.48, 74, 257, 1504, 275.51, -1621.02, 73.01, 80, 0, 1, 290000, 0),
(15, 'Ninguem', 'Rodeo', 294.85, -1623.63, 78.5, 80.84, 1504, 295.3, -1624.5, 77.51, 80, 0, 1, 290000, 0),
(16, 'Ninguem', 'Rodeo', 276.42, -1620.42, 78.5, 259.12, 1504, 275.51, -1621.02, 77.51, 80, 0, 1, 290000, 0),
(17, 'Ninguem', 'Rodeo', 295.08, -1623.59, 83, 81.6, 1504, 295.3, -1624.5, 82.01, 80, 0, 1, 290000, 0),
(18, 'Ninguem', 'Rodeo', 276.63, -1620.37, 83, 263.51, 1504, 275.51, -1621.02, 82.01, 80, 0, 1, 290000, 0),
(19, 'Ninguem', 'Rodeo', 294.97, -1623.75, 87.5, 85.54, 1504, 295.3, -1624.5, 86.49, 80, 0, 1, 290000, 0),
(20, 'Ninguem', 'Rodeo', 276.55, -1620.49, 87.5, 262.86, 1504, 275.51, -1621.02, 86.52, 80, 0, 1, 290000, 0),
(21, 'Ninguem', 'Rodeo', 294.87, -1623.62, 92, 79.34, 1504, 295.3, -1624.5, 91.01, 80, 0, 1, 320000, 0),
(22, 'Ninguem', 'Rodeo', 276.5, -1620.42, 92, 259.7, 1504, 275.51, -1621.02, 91.02, 80, 0, 1, 320000, 0),
(23, 'Ninguem', 'Rodeo', 294.85, -1623.71, 96.5, 80.47, 1504, 295.3, -1624.5, 95.49, 80, 0, 1, 320000, 0),
(24, 'Ninguem', 'Rodeo', 276.54, -1620.43, 96.5, 262.5, 1504, 275.51, -1621.02, 95.52, 80, 0, 1, 320000, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apartments`
--
ALTER TABLE `apartments`
  ADD PRIMARY KEY (`ID`), ADD KEY `ID` (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `apartments`
--
ALTER TABLE `apartments`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=25;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
