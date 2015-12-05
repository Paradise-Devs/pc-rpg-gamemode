-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: Jul 01, 2015 at 05:56 PM
-- Server version: 5.6.24
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
-- Table structure for table `business`
--

CREATE TABLE IF NOT EXISTS `business` (
  `ID` int(11) NOT NULL,
  `Name` varchar(64) DEFAULT NULL,
  `Owner` varchar(25) DEFAULT NULL,
  `EnterX` float DEFAULT NULL,
  `EnterY` float DEFAULT NULL,
  `EnterZ` float DEFAULT NULL,
  `EnterA` float DEFAULT NULL,
  `ExitX` float DEFAULT NULL,
  `ExitY` float DEFAULT NULL,
  `ExitZ` float DEFAULT NULL,
  `ExitA` float DEFAULT NULL,
  `EnterWorld` int(10) DEFAULT NULL,
  `EnterInt` int(10) DEFAULT NULL,
  `ExitInt` int(10) DEFAULT NULL,
  `Owned` int(10) DEFAULT NULL,
  `Locked` int(10) DEFAULT NULL,
  `Price` int(10) DEFAULT NULL,
  `Till` int(10) DEFAULT NULL,
  `Products` int(10) DEFAULT NULL,
  `Type` int(10) DEFAULT NULL,
  `ProductPrice` int(10) DEFAULT NULL,
  `Location` varchar(28) DEFAULT NULL
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `business`
--

INSERT INTO `business` (`ID`, `Name`, `Owner`, `EnterX`, `EnterY`, `EnterZ`, `EnterA`, `ExitX`, `ExitY`, `ExitZ`, `ExitA`, `EnterWorld`, `EnterInt`, `ExitInt`, `Owned`, `Locked`, `Price`, `Till`, `Products`, `Type`, `ProductPrice`, `Location`) VALUES
(1, 'Mercadinho', 'Ninguem', 1352.37, -1758.95, 13.5, 359.54, -27.28, -57.49, 1003.54, 358.24, 0, 0, 6, 0, 0, 350000, 9030, 2476, 1, 10, 'Commerce'),
(2, 'LS Celulares', 'Ninguem', 1411.95, -1699.88, 13.53, 231.31, 2161.49, 1602.58, 999.981, 269.615, 0, 0, 1, 0, 0, 425000, 50586, 2494, 2, 10, 'Commerce'),
(3, 'Armas Nation', 'Ninguem', 1367.97, -1279.8, 13.54, 88.5, 315.85, -143.44, 999.6, 358.24, 0, 0, 7, 0, 0, 1000000, 0, 2500, 4, 10, 'Market'),
(4, 'Prato feito', 'Ninguem', 1498.48, -1581.82, 13.54, 180, 458.6, -88, 999.55, 89.8, 0, 0, 4, 0, 0, 520000, 240, 2490, 3, 10, 'Pershing Square'),
(5, 'Gasolina', 'Ninguem', 1929.21, -1776.31, 13.54, 271.47, 0, 0, 0, 0, 0, 0, 0, 0, 0, 725000, 0, 2500, 6, 10, 'Idlewood'),
(6, 'Folha de Los Santos', 'Ninguem', 1419.74, -1623.84, 13.54, 267.73, 221.81, 115.6, 1003.21, 180.64, 0, 0, 10, 0, 0, 460000, 5740, 2500, 7, 10, 'Commerce'),
(7, 'Roupas Fashion', 'Ninguem', 2244.49, -1665.12, 15.47, 345.13, 207.67, -110.51, 1005.13, 358.38, 0, 0, 15, 0, 0, 495000, 800, 2492, 5, 10, 'Ganton'),
(8, 'Burger King', 'Ninguem', 1199.46, -918.68, 43.11, 185.67, 363.13, -74.89, 1001.5, 323.98, 0, 0, 10, 0, 0, 450000, 310, 2487, 10, 0, 'Temple'),
(9, 'Lojinha 1,99', 'Ninguem', 1833.45, -1842.58, 13.57, 84.72, -25.99, -141.13, 1003.54, 6.56, 0, 0, 16, 0, 0, 365000, 750, 2498, 1, 0, 'Idlewood'),
(10, 'Alhambra', 'Ninguem', 1836.2, -1682.5, 13.35, 94.04, 493.14, -24.26, 1000.68, 356.98, 0, 0, 17, 0, 0, 700000, 2155, 2439, 8, 0, 'Idlewood'),
(11, 'Rabbits Pizzas', 'Ninguem', 2104.8, -1806.5, 13.55, 94.6, 372.38, -133.33, 1001.49, 357.08, 0, 0, 5, 0, 0, 685000, 175, 2493, 12, 0, 'Idlewood'),
(12, 'Ten Green Bottles', 'Ninguem', 2309.9, -1643.51, 14.82, 133.93, 501.99, -67.94, 998.75, 183.98, 0, 0, 11, 0, 0, 550000, 440, 2490, 8, 0, 'Ganton'),
(13, 'Frango Frito', 'Ninguem', 2397.79, -1898.96, 13.54, 2.77, 364.88, -10.98, 1001.85, 0.78, 0, 0, 9, 0, 0, 600000, 0, 2500, 11, 0, 'Willowfield'),
(14, 'Armamentos Jack', 'Ninguem', 2400.49, -1981.58, 13.54, 358.78, 285.7, -86.08, 1001.52, 2.68, 0, 0, 4, 0, 0, 950000, 0, 2500, 4, 0, 'Willowfield'),
(15, 'Nuggets do Jim', 'Ninguem', 1038.17, -1340.5, 13.74, 5.3, 377.08, -193.3, 1000.63, 0.11, 0, 0, 17, 0, 0, 425000, 165, 2496, 3, 0, 'Market'),
(16, 'Frango Assado', 'Ninguem', 928.9, -1352.97, 13.34, 93.45, 364.95, -11.08, 1001.85, 354.26, 0, 0, 9, 0, 0, 650000, 160, 2491, 11, 0, 'Market'),
(17, 'Mc donald', 'Ninguem', 810.71, -1616.21, 13.54, 270.01, 363.17, -74.89, 1001.5, 311.88, 0, 0, 10, 0, 0, 675000, 0, 2500, 10, 0, 'Marina'),
(18, 'ProLaps', 'Ninguem', 499.78, -1360.17, 16.32, 341.41, 207.1, -139.98, 1003.5, 356.61, 0, 0, 3, 0, 0, 750000, 0, 2500, 5, 0, 'Rodeo'),
(19, 'Lojinha', 'Ninguem', 1315.56, -897.91, 39.57, 185.79, -27.22, -31.61, 1003.55, 6.55, 0, 0, 4, 0, 0, 495000, 300, 2499, 1, 0, 'Mulholland'),
(20, 'Cluckin Frango', 'Ninguem', 2420.16, -1508.91, 24, 274.03, 364.92, -11.46, 1001.85, 11.05, 0, 0, 9, 0, 0, 485000, 0, 2500, 11, 0, 'San Andreas'),
(21, 'ZIP', 'Ninguem', 1457.09, -1137.21, 23.95, 221.03, 161.43, -96.89, 1001.8, 2.82, 0, 0, 18, 0, 0, 658000, 500, 2495, 5, 0, 'San Andreas'),
(22, 'Victim', 'Ninguem', 461.3, -1500.97, 31.05, 105.13, 227.18, -8.06, 1002.21, 92.66, 0, 0, 5, 0, 0, 765000, 0, 2500, 5, 0, 'Rodeo'),
(23, 'SubUrban', 'Ninguem', 2112.84, -1211.46, 23.96, 181.94, 203.81, -50.65, 1001.8, 2.6, 0, 0, 1, 0, 0, 475000, 100, 2499, 5, 0, 'Jefferson'),
(24, 'Gasosa norte', 'Ninguem', 1000.24, -919.9, 42.32, 98.24, 0, 0, 0, 0, 0, 0, 0, 0, 0, 750000, 0, 2500, 6, 0, 'Mulholland'),
(25, 'Loja de Conveniencia', 'Ninguem', 1976.49, -2036.55, 13.54, 87.35, -30.91, -92.01, 1003.54, 2, 0, 0, 18, 0, 0, 375000, 0, 2500, 1, 0, 'Willowfield'),
(26, 'Super Mercado Bobo', 'Ninguem', 822.67, -1757.3, 13.65, 135.97, -26.01, -188.25, 1003.54, 357.67, 0, 0, 17, 0, 0, 500000, 0, 25000, 1, 0, 'Marina'),
(27, 'Loja 24-7', 'Ninguem', 331.97, -1337.51, 14.5, 206.96, -27.3, -58.26, 1003.54, 1.82, 0, 0, 6, 0, 0, 450000, 0, 2500, 1, 0, 'Richman'),
(28, 'Ideal Homies Store', 'Ninguem', 2352.01, -1412.15, 23.99, 85.55, 6.03, -31.62, 1003.54, 1.56, 0, 0, 10, 0, 0, 495000, 0, 2500, 1, 0, 'East Los Santos'),
(29, 'Papercuts', 'Ninguem', 1081.22, -1696.99, 13.54, 181.58, 221.81, 115.6, 1003.21, 180.64, 0, 0, 10, 0, 0, 640000, 300, 2500, 7, 0, 'Verona Beach'),
(30, 'Interglobal Television', 'Ninguem', 648.9, -1357.3, 13.56, 90.71, 221.81, 115.6, 1003.21, 180.64, 0, 0, 10, 0, 0, 675000, 320, 2500, 7, 0, 'Vinewood'),
(31, 'Liquor bar', 'Ninguem', 2348.54, -1372.86, 24.39, 182.85, 681.62, -451.31, -25.61, 170.3, 0, 0, 1, 0, 0, 500000, 0, 25000, 8, 0, 'East Los Santos');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `business`
--
ALTER TABLE `business`
  ADD PRIMARY KEY (`ID`), ADD KEY `ID` (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `business`
--
ALTER TABLE `business`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=32;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
