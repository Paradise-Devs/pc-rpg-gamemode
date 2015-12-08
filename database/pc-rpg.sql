-- phpMyAdmin SQL Dump
-- version 4.5.1
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 05-Dez-2015 às 01:43
-- Versão do servidor: 10.1.8-MariaDB
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
-- Estrutura da tabela `apartments`
--

CREATE TABLE `apartments` (
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
  `MinX` float DEFAULT NULL,
  `MinY` float DEFAULT NULL,
  `MinZ` float DEFAULT NULL,
  `MaxX` float DEFAULT NULL,
  `MaxY` float DEFAULT NULL,
  `MaxZ` float DEFAULT NULL,
  `Owned` tinyint(1) DEFAULT NULL,
  `Locked` tinyint(1) DEFAULT NULL,
  `Price` int(11) DEFAULT NULL,
  `ObjsAmount` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `apartments`
--

INSERT INTO `apartments` (`ID`, `Owner`, `Location`, `EnterX`, `EnterY`, `EnterZ`, `EnterA`, `DoorModel`, `DoorX`, `DoorY`, `DoorZ`, `DoorA`, `MinX`, `MinY`, `MinZ`, `MaxX`, `MaxY`, `MaxZ`, `Owned`, `Locked`, `Price`, `ObjsAmount`) VALUES
(1, 'Ninguem', 'Rodeo', 294.73, -1623.54, 47, 80.75, 1504, 295.3, -1624.5, 46.01, 80, 290.88, -1625.74, 47.0, 304.26, -1594.51, 50.0, 0, 1, 275000, 0),
(2, 'Ninguem', 'Rodeo', 276.63, -1620.47, 47, 261.5, 1504, 275.51, -1621.02, 46.01, 80, 266.7, -1619.02, 47.0, 289.89, -1594.34, 50.0, 0, 1, 275000, 0),
(3, 'Ninguem', 'Rodeo', 294.58, -1623.64, 51.5, 81.83, 1504, 295.3, -1624.5, 50.5, 80, 290.88, -1625.74, 50.0, 304.26, -1594.51, 53.0, 0, 1, 275000, 0),
(4, 'Ninguem', 'Rodeo', 276.61, -1620.5, 51.5, 260.85, 1504, 275.51, -1621.02, 50.5, 80, 266.7, -1619.02, 50.0, 289.89, -1594.34, 53.0, 0, 1, 275000, 0),
(5, 'Ninguem', 'Rodeo', 294.98, -1623.72, 56, 80.33, 1504, 295.3, -1624.5, 54.99, 80, 290.88, -1625.74, 53.0, 304.26, -1594.51, 56.0, 0, 1, 275000, 0),
(6, 'Ninguem', 'Rodeo', 276.56, -1620.35, 56, 260.54, 1504, 275.51, -1621.02, 55.02, 80, 266.7, -1619.02, 53.0, 289.89, -1594.34, 56.0, 0, 1, 275000, 0),
(7, 'Ninguem', 'Rodeo', 294.89, -1623.64, 60.5, 76.35, 1504, 295.3, -1624.5, 59.51, 80, 290.88, -1625.74, 56.0, 304.26, -1594.51, 59.0, 0, 1, 275000, 0),
(8, 'Ninguem', 'Rodeo', 276.83, -1620.42, 60.5, 258.37, 1504, 275.51, -1621.02, 59.51, 80, 266.7, -1619.02, 56.0, 289.89, -1594.34, 59.0, 0, 1, 275000, 0),
(9, 'Ninguem', 'Rodeo', 294.73, -1623.62, 65, 80.11, 1504, 295.3, -1624.5, 63.99, 80, 290.88, -1625.74, 59.0, 304.26, -1594.51, 62.0, 0, 1, 275000, 0),
(10, 'Ninguem', 'Rodeo', 276.54, -1620.55, 65, 263.02, 1504, 275.51, -1621.02, 64.02, 80, 266.7, -1619.02, 59.0, 289.89, -1594.34, 62.0, 0, 1, 275000, 0),
(11, 'Ninguem', 'Rodeo', 294.98, -1623.77, 69.5, 76.17, 1504, 295.3, -1624.5, 68.49, 80, 290.88, -1625.74, 62.0, 304.26, -1594.51, 65.0, 0, 1, 275000, 0),
(12, 'Ninguem', 'Rodeo', 276.56, -1620.52, 69.5, 258.9, 1504, 275.51, -1621.02, 68.52, 80, 266.7, -1619.02, 62.0, 289.89, -1594.34, 65.0, 0, 1, 275000, 0),
(13, 'Ninguem', 'Rodeo', 294.98, -1623.72, 74, 84.23, 1504, 295.3, -1624.5, 73.01, 80, 290.88, -1625.74, 65.0, 304.26, -1594.51, 68.0, 0, 1, 290000, 0),
(14, 'Ninguem', 'Rodeo', 276.55, -1620.48, 74, 257, 1504, 275.51, -1621.02, 73.01, 80, 266.7, -1619.02, 65.0, 289.89, -1594.34, 68.0, 0, 1, 290000, 0),
(15, 'Ninguem', 'Rodeo', 294.85, -1623.63, 78.5, 80.84, 1504, 295.3, -1624.5, 77.51, 80, 290.88, -1625.74, 68.0, 304.26, -1594.51, 71.0, 0, 1, 290000, 0),
(16, 'Ninguem', 'Rodeo', 276.42, -1620.42, 78.5, 259.12, 1504, 275.51, -1621.02, 77.51, 80, 266.7, -1619.02, 68.0, 289.89, -1594.34, 71.0, 0, 1, 290000, 0),
(17, 'Ninguem', 'Rodeo', 295.08, -1623.59, 83, 81.6, 1504, 295.3, -1624.5, 82.01, 80, 290.88, -1625.74, 71.0, 304.26, -1594.51, 74.0, 0, 1, 290000, 0),
(18, 'Ninguem', 'Rodeo', 276.63, -1620.37, 83, 263.51, 1504, 275.51, -1621.02, 82.01, 80, 266.7, -1619.02, 71.0, 289.89, -1594.34, 74.0, 0, 1, 290000, 0),
(19, 'Ninguem', 'Rodeo', 294.97, -1623.75, 87.5, 85.54, 1504, 295.3, -1624.5, 86.49, 80, 290.88, -1625.74, 74.0, 304.26, -1594.51, 77.0, 0, 1, 290000, 0),
(20, 'Ninguem', 'Rodeo', 276.55, -1620.49, 87.5, 262.86, 1504, 275.51, -1621.02, 86.52, 80, 266.7, -1619.02, 74.0, 289.89, -1594.34, 77.0, 0, 1, 290000, 0),
(21, 'Ninguem', 'Rodeo', 294.87, -1623.62, 92, 79.34, 1504, 295.3, -1624.5, 91.01, 80, 290.88, -1625.74, 77.0, 304.26, -1594.51, 80.0, 0, 1, 320000, 0),
(22, 'Ninguem', 'Rodeo', 276.5, -1620.42, 92, 259.7, 1504, 275.51, -1621.02, 91.02, 80, 266.7, -1619.02, 77.0, 289.89, -1594.34, 80.0, 0, 1, 320000, 0),
(23, 'Ninguem', 'Rodeo', 294.85, -1623.71, 96.5, 80.47, 1504, 295.3, -1624.5, 95.49, 80, 290.88, -1625.74, 80.0, 304.26, -1594.51, 83.0, 0, 1, 320000, 0),
(24, 'Ninguem', 'Rodeo', 276.54, -1620.43, 96.5, 262.5, 1504, 275.51, -1621.02, 95.52, 80, 266.7, -1619.02, 80.0, 289.89, -1594.34, 83.0, 0, 1, 320000, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `apartments_objects`
--

CREATE TABLE `apartments_objects` (
  `ID` int(11) NOT NULL,
  `ApartID` int(11) DEFAULT NULL,
  `Model` int(11) DEFAULT NULL,
  `X` float DEFAULT NULL,
  `Y` float DEFAULT NULL,
  `Z` float DEFAULT NULL,
  `RX` float DEFAULT NULL,
  `RY` float DEFAULT NULL,
  `RZ` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `attachments`
--

CREATE TABLE `attachments` (
  `ID` int(11) NOT NULL,
  `OwnerID` int(11) DEFAULT NULL,
  `Index` int(11) DEFAULT NULL,
  `Model` int(11) DEFAULT NULL,
  `Bone` int(11) DEFAULT NULL,
  `X` float DEFAULT NULL,
  `Y` float DEFAULT NULL,
  `Z` float DEFAULT NULL,
  `RX` float DEFAULT NULL,
  `RY` float DEFAULT NULL,
  `RZ` float DEFAULT NULL,
  `SX` float DEFAULT NULL,
  `SY` float DEFAULT NULL,
  `SZ` float DEFAULT NULL,
  `Col1` int(11) DEFAULT NULL,
  `Col2` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `buildings`
--

CREATE TABLE `buildings` (
  `ID` int(11) NOT NULL,
  `building_out_x` float DEFAULT NULL,
  `building_out_y` float DEFAULT NULL,
  `building_out_z` float DEFAULT NULL,
  `building_out_a` float DEFAULT NULL,
  `building_out_i` int(11) DEFAULT NULL,
  `building_out_v` int(11) DEFAULT NULL,
  `building_in_x` float DEFAULT NULL,
  `building_in_y` float DEFAULT NULL,
  `building_in_z` float DEFAULT NULL,
  `building_in_a` float DEFAULT NULL,
  `building_in_i` int(11) DEFAULT NULL,
  `building_in_v` int(11) DEFAULT NULL,
  `building_locked` tinyint(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `buildings`
--

INSERT INTO `buildings` (`ID`, `building_out_x`, `building_out_y`, `building_out_z`, `building_out_a`, `building_out_i`, `building_out_v`, `building_in_x`, `building_in_y`, `building_in_z`, `building_in_a`, `building_in_i`, `building_in_v`, `building_locked`) VALUES
(1, 1555.08, -1675.65, 15.5, 95.637, 0, 0, 238.661, 138.691, 1002.5, 359.118, 3, 0, 0),
(2, 1480.9, -1771.29, 18.95, 3.996, 0, 0, 389.684, 173.675, 1007.8, 96.25, 3, 0, 0),
(3, 2229.57, -1721.52, 12.8, 132.266, 0, 0, 772.141, -4.392, 999.5, 9.506, 5, 0, 0),
(4, 1631.75, -1172.03, 23.4, 6.502, 0, 0, 834.203, 7.522, 1003.7, 89.34, 3, 0, 0),
(5, 2232.27, -1159.82, 25.19, 87.845, 0, 0, 2215.23, -1150.41, 1025.3, 276.944, 15, 0, 0),
(6, 1699.17, -1668.02, 19.5, 92.388, 0, 0, 1726.92, -1639.19, 19.8, 179.472, 18, 0, 0),
(7, -1603.45, -696.971, 1.2, 178.96, 0, 0, -1603.39, -695.328, 13.6, 0.145, 0, 0, 0),
(8, -1361.09, -697.026, 1.2, 180.658, 0, 0, -1361.12, -695.333, 13.6, 3.457, 0, 0, 0),
(9, -1154.19, -476.654, 1.2, 238.378, 0, 0, -1155.15, -476.197, 13.6, 55.292, 0, 0, 0),
(10, -1081.63, -207.85, 1.2, 300.007, 0, 0, -1083.26, -208.523, 13.6, 118.988, 0, 0, 0),
(11, -1182.59, 60.381, 1.2, 315.57, 0, 0, -1183.52, 59.589, 13.6, 135.042, 0, 0, 0),
(12, -1115.67, 334.999, 1.2, 217.313, 0, 0, -1116.46, 336.014, 13.6, 41.406, 0, 0, 0),
(13, -1164.81, 370.212, 1.2, 42.069, 0, 0, -1163.75, 369.155, 13.6, 224.26, 0, 0, 0),
(14, -1444.44, 90.253, 1.2, 41.86, 0, 0, -1443.72, 89.423, 13.6, 221.561, 0, 0, 0),
(15, -1618.79, -84.056, 1.2, 42.355, 0, 0, -1617.85, -84.898, 13.6, 223.433, 0, 0, 0),
(16, -1736.87, -445.912, 1.2, 87.08, 0, 0, -1734.97, -445.99, 13.6, 272.816, 0, 0, 0),
(17, 1571.29, -1336.76, 15.7, 317.234, 0, 0, 1548.68, -1364.2, 325.8, 182.609, 0, 0, 0),
(18, 914.466, -1004.23, 37.2, 1.379, 0, 0, 1591.41, -1034.93, 23.3, 273.491, 1, 0, 0),
(19, 953.813, -1336.56, 12.8, 1.774, 0, 0, -100.396, -25.031, 1000.2, 3.38, 3, 0, 0),
(20, 2421.54, -1219.52, 24.8, 185.999, 0, 0, 1204.67, -13.543, 1000.4, 350.02, 2, 0, 0),
(21, 2068.9, -1779.84, 12.8, 273.744, 0, 0, -204.447, -27.17, 1001.8, 3.631, 16, 0, 0),
(22, 2071, -1793.85, 12.8, 270.438, 0, 0, 418.75, -84.032, 1001.2, 359.52, 3, 0, 0),
(23, 1940.19, -2115.98, 13, 267.109, 0, 0, -100.396, -25.031, 1000.2, 3.38, 3, 1, 0),
(24, 2657.7, -1588.84, 13.205, 186.08, 0, 0, -959.668, 1956.26, 8.5, 181.145, 17, 0, 0),
(25, 2353.09, -1463.49, 23.3, 96.962, 0, 0, -100.396, -25.031, 1000.3, 3.38, 3, 2, 0),
(26, 1310.11, -1367.23, 13, 184.686, 0, 0, -2026.89, -104.129, 1034.6, 182.764, 3, 0, 0),
(27, 1658.1, -1343.33, 16.9, 86.284, 0, 0, 366.698, 197.228, 1007.8, 1.7, 3, 1, 0),
(28, 850.919, -1587.45, 13, 228.357, 0, 0, -2240.62, 137.119, 1034.9, 273.643, 6, 0, 0),
(29, 823.961, -1588.24, 13, 137.208, 0, 0, 412.007, -54.441, 1001.4, 6.97, 12, 0, 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `business`
--

CREATE TABLE `business` (
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
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `business`
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

-- --------------------------------------------------------

--
-- Estrutura da tabela `dealership`
--

CREATE TABLE `dealership` (
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

-- --------------------------------------------------------

--
-- Estrutura da tabela `factions`
--

CREATE TABLE `factions` (
  `id` int(11) UNSIGNED NOT NULL,
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

-- --------------------------------------------------------

--
-- Estrutura da tabela `houses`
--

CREATE TABLE `houses` (
  `ID` int(11) NOT NULL,
  `Description` varchar(64) DEFAULT NULL,
  `Owner` varchar(25) DEFAULT NULL,
  `EnterX` float DEFAULT NULL,
  `EnterY` float DEFAULT NULL,
  `EnterZ` float DEFAULT NULL,
  `EnterA` float DEFAULT NULL,
  `ExitX` float DEFAULT NULL,
  `ExitY` float DEFAULT NULL,
  `ExitZ` float DEFAULT NULL,
  `ExitA` float DEFAULT NULL,
  `EnterWorld` int(4) DEFAULT NULL,
  `EnterInt` int(4) DEFAULT NULL,
  `ExitInt` int(4) DEFAULT NULL,
  `Owned` int(1) DEFAULT NULL,
  `Locked` int(1) DEFAULT NULL,
  `Price` int(10) DEFAULT NULL,
  `Beds` int(10) DEFAULT NULL,
  `Rooms` int(10) DEFAULT NULL,
  `Garages` int(10) DEFAULT NULL,
  `Rentable` int(1) DEFAULT NULL,
  `RentCost` int(10) DEFAULT NULL,
  `Location` varchar(28) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `houses`
--

INSERT INTO `houses` (`ID`, `Description`, `Owner`, `EnterX`, `EnterY`, `EnterZ`, `EnterA`, `ExitX`, `ExitY`, `ExitZ`, `ExitA`, `EnterWorld`, `EnterInt`, `ExitInt`, `Owned`, `Locked`, `Price`, `Beds`, `Rooms`, `Garages`, `Rentable`, `RentCost`, `Location`) VALUES
(1, '2 andares', 'Ninguem', 1411.12, -921.14, 38.42, 169.06, 2317.85, -1026.65, 1050.21, 359.88, 0, 0, 9, 0, 1, 590000, 0, 0, 0, 0, 0, 'Mulholland'),
(2, '2 andares', 'Ninguem', 1440.57, -926.45, 39.64, 171.58, 2317.81, -1026.49, 1050.21, 6, 0, 0, 9, 0, 1, 590000, 0, 0, 0, 0, 0, 'Mulholland'),
(3, '3 comodos', 'Ninguem', 1421.99, -886.09, 50.68, 356.98, 223.08, 1287.3, 1082.14, 7.7, 0, 0, 1, 0, 1, 450000, 0, 0, 0, 0, 0, 'Mulholland'),
(4, '4 comodos', 'Ninguem', 1468.46, -905.8, 54.83, 3.01, 226.63, 1240, 1082.14, 91.19, 0, 0, 2, 0, 1, 550000, 0, 0, 0, 0, 0, 'Mulholland Section'),
(5, '2 andares', 'Ninguem', 1540.46, -851.46, 64.33, 95.91, 235.29, 1186.68, 1080.25, 358.03, 0, 0, 3, 0, 1, 625000, 0, 0, 0, 0, 0, 'Mulholland Section'),
(6, '1 comodo', 'Ninguem', 1534.81, -800.18, 72.84, 92.7, 2233.74, -1115.26, 1050.88, 357.01, 0, 0, 5, 0, 1, 475000, 0, 0, 0, 0, 0, 'Mulholland Section'),
(7, '4 comodos', 'Ninguem', 1527.65, -772.7, 80.57, 135.58, 260.96, 1284.3, 1080.25, 1.7, 0, 0, 4, 0, 1, 575000, 0, 0, 0, 0, 0, 'Mulholland Section'),
(8, 'Mansao', 'Ninguem', 1497.03, -688.44, 95.41, 180.7, 226.3, 1114.23, 1080.99, 274.15, 0, 0, 5, 0, 1, 1000000, 0, 0, 0, 0, 0, 'Mulholland'),
(9, '5 comodos + garagem', 'Ninguem', 1332.22, -633.46, 109.13, 18.84, 22.8, 1403.32, 1084.43, 8.26, 0, 0, 5, 0, 1, 750000, 0, 0, 0, 0, 0, 'Mulholland'),
(10, 'Mansao Madd Dogg', 'Ninguem', 1298.51, -798.23, 84.14, 188.46, 1260.85, -785.48, 1091.9, 269.32, 0, 0, 5, 0, 1, 10000000, 0, 0, 0, 0, 0, 'Mulholland'),
(11, '4 comodos', 'Ninguem', 1093.88, -806.94, 107.41, 7.82, 260.81, 1237.32, 1084.25, 1.13, 0, 0, 9, 0, 1, 650000, 0, 0, 0, 0, 0, 'Mulholland'),
(12, '4 comodos', 'Ninguem', 1034.63, -813.01, 101.85, 24.64, -42.57, 1405.59, 1084.43, 358.1, 0, 0, 8, 0, 1, 550000, 0, 0, 0, 0, 0, 'Mulholland'),
(13, '5 comodos', 'Ninguem', 989.75, -828.68, 95.46, 25.84, 294.99, 1472.26, 1080.25, 2.03, 0, 0, 15, 0, 1, 750000, 0, 0, 0, 0, 0, 'Mulholland'),
(14, '2 andares + garagem', 'Ninguem', 2495.38, -1690.93, 14.76, 359.13, 2495.92, -1692.18, 1014.74, 185.15, 0, 0, 3, 0, 1, 575000, 0, 0, 0, 0, 0, 'Ganton'),
(15, '3 comodos', 'Ninguem', 2523.12, -1679.19, 15.49, 82.74, 2468.83, -1698.23, 1013.5, 91.35, 0, 0, 2, 0, 1, 385000, 0, 0, 0, 0, 0, 'Ganton'),
(16, '3 comodos', 'Ninguem', 2459.41, -1691.66, 13.54, 354.16, 2468.66, -1698.22, 1013.5, 87.69, 0, 0, 2, 0, 1, 425000, 0, 0, 0, 0, 0, 'Ganton'),
(17, '2 andares', 'Ninguem', 2486.38, -1644.53, 14.07, 180.82, 2496, -1692.31, 1014.74, 182.58, 0, 0, 3, 0, 1, 450000, 0, 0, 0, 0, 0, 'Ganton'),
(18, '1 comodo', 'Ninguem', 2402.57, -1715.76, 14.08, 182.01, 243.72, 305.03, 999.14, 267.67, 0, 0, 1, 0, 1, 275000, 0, 0, 0, 0, 0, 'Ganton'),
(19, '3 comodos', 'Ninguem', 2065.1, -1703.53, 14.14, 272.68, 2259.39, -1135.94, 1050.64, 278.49, 0, 0, 10, 0, 1, 480000, 0, 0, 0, 0, 0, 'Idlewood'),
(20, '2 andares', 'Ninguem', 1112.43, -742.1, 100.13, 89.18, 24.06, 1340.16, 1084.37, 359.37, 0, 0, 10, 0, 1, 575000, 0, 0, 0, 0, 0, 'Mulholland'),
(21, 'Mansao', 'Ninguem', 300.16, -1154.58, 81.32, 136.07, 234.2, 1063.72, 1084.21, 0, 0, 0, 6, 0, 1, 1250000, 0, 0, 0, 0, 0, 'Richman'),
(22, 'Mansao', 'Ninguem', 251.73, -1220.48, 76.02, 216.32, 226.3, 1114.28, 1080.99, 271.35, 0, 0, 5, 0, 1, 1000000, 0, 0, 0, 0, 0, 'Richman'),
(23, 'Mansao + Piscina', 'Ninguem', 219.23, -1249.97, 78.33, 219.19, 234.33, 1063.72, 1084.21, 359.04, 0, 0, 6, 0, 1, 1200000, 0, 0, 0, 0, 0, 'Richman'),
(24, '5 comodos', 'Ninguem', 1111.64, -976.42, 42.76, 357.21, 22.73, 1403.32, 1084.43, 2.65, 0, 0, 5, 0, 1, 575000, 0, 0, 0, 0, 0, 'Temple'),
(25, 'Mansao', 'Ninguem', 253.19, -1270.01, 74.43, 37.59, 140.37, 1365.91, 1083.85, 354.27, 0, 0, 5, 0, 1, 950000, 0, 0, 0, 0, 0, 'Richman'),
(26, 'Casa de Ex-militar', 'Ninguem', 298.87, -1338.32, 53.44, 35.71, 2807.66, -1174.75, 1025.57, 1.75, 0, 0, 8, 0, 1, 650000, 0, 0, 0, 0, 0, 'Richman'),
(27, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(28, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(29, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(30, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(31, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(32, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(33, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(34, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(35, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(36, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(37, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(38, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(39, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(40, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(41, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(42, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(43, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(44, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(45, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(46, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(47, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(48, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(49, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(50, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(51, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(52, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(53, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(54, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(55, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(56, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(57, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(58, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(59, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(60, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(61, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(62, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres'),
(63, 'Nenhum', 'Ninguem', 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 'Blueberry Acres');

-- --------------------------------------------------------

--
-- Estrutura da tabela `lottery`
--

CREATE TABLE `lottery` (
  `ID` int(11) NOT NULL,
  `Jackpot` int(10) DEFAULT NULL,
  `Date` int(10) DEFAULT NULL,
  `LastWinner` varchar(24) DEFAULT NULL,
  `Active` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `lottery`
--

INSERT INTO `lottery` (`ID`, `Jackpot`, `Date`, `LastWinner`, `Active`) VALUES
(1, 7019, 1438138441, 'Ninguem', 0);

-- --------------------------------------------------------

--
-- Estrutura da tabela `pets`
--

CREATE TABLE `pets` (
  `ID` int(11) NOT NULL,
  `Name` varchar(25) DEFAULT NULL,
  `OwnerID` int(11) DEFAULT NULL,
  `Model` int(11) DEFAULT NULL,
  `Size` int(11) DEFAULT NULL,
  `Hunger` float DEFAULT NULL,
  `NextGrowth` float DEFAULT NULL,
  `Food` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `players`
--

CREATE TABLE `players` (
  `ID` int(11) UNSIGNED NOT NULL,
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
  `spawn` int(11) DEFAULT '0',
  `health` float DEFAULT '100',
  `armour` float DEFAULT '0',
  `skin` int(11) DEFAULT '299',
  `rank` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `faction` int(11) NOT NULL DEFAULT '0',
  `faction_rank` int(11) NOT NULL DEFAULT '0',
  `last_login` int(11) DEFAULT '0',
  `played_time` int(11) DEFAULT '0',
  `regdate` int(11) DEFAULT '0',
  `gender` tinyint(1) DEFAULT '0',
  `money` int(11) NOT NULL DEFAULT '0',
  `hospital` int(11) NOT NULL DEFAULT '0',
  `achievements` int(11) NOT NULL DEFAULT '0',
  `ticket` int(11) NOT NULL DEFAULT '0',
  `jobid` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `jobxp` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `joblv` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `xp` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `level` int(10) UNSIGNED NOT NULL DEFAULT '1',
  `ftime` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `hunger` float UNSIGNED NOT NULL DEFAULT '100',
  `thirst` float UNSIGNED NOT NULL DEFAULT '100',
  `sleep` float UNSIGNED NOT NULL DEFAULT '100',
  `addiction` float UNSIGNED NOT NULL DEFAULT '100',
  `phone_number` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `phone_network` int(10) NOT NULL DEFAULT '-1',
  `phone_credits` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `phone_state` int(10) UNSIGNED NOT NULL DEFAULT '0',
  `apartkey` int(10) NOT NULL DEFAULT '-1',
  `housekey` int(10) NOT NULL DEFAULT '-1',
  `businesskey` int(10) NOT NULL DEFAULT '-1',
  `WeaponSkillPistol` int(10) NOT NULL DEFAULT '0',
  `WeaponSkillSilenced` int(10) NOT NULL DEFAULT '0',
  `WeaponSkillDeagle` int(10) NOT NULL DEFAULT '0',
  `WeaponSkillShotgun` int(10) NOT NULL DEFAULT '0',
  `WeaponSkillSawnoff` int(10) NOT NULL DEFAULT '0',
  `WeaponSkillSpas12` int(10) NOT NULL DEFAULT '0',
  `WeaponSkillUzi` int(10) NOT NULL DEFAULT '0',
  `WeaponSkillMP5` int(10) NOT NULL DEFAULT '0',
  `WeaponSkillAK47` int(10) NOT NULL DEFAULT '0',
  `WeaponSkillM4` int(10) NOT NULL DEFAULT '0',
  `WeaponSkillSniper` int(10) NOT NULL DEFAULT '0',
  `agenda` int(10) NOT NULL DEFAULT '0',
  `gps` int(10) NOT NULL DEFAULT '0',
  `lighter` int(10) NOT NULL DEFAULT '0',
  `cigaretts` int(10) NOT NULL DEFAULT '0',
  `walkietalkie` int(10) NOT NULL DEFAULT '0',
  `isOnline` int(10) signed NOT NULL DEFAULT '0',
  `carlic` int(10) signed NOT NULL DEFAULT '0',
  `bikelic` int(10) signed NOT NULL DEFAULT '0',
  `trucklic` int(10) signed NOT NULL DEFAULT '0',
  `helilic` int(10) signed NOT NULL DEFAULT '0',
  `planelic` int(10) signed NOT NULL DEFAULT '0',
  `boatlic` int(10) signed NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `player_weapons`
--

CREATE TABLE `player_weapons` (
  `userid` int(10) UNSIGNED NOT NULL,
  `weaponid` int(10) UNSIGNED NOT NULL,
  `ammo` int(10) UNSIGNED NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vehicles`
--

CREATE TABLE `vehicles` (
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
  `vehicle_locked` int(10) UNSIGNED NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `vehicles`
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

-- --------------------------------------------------------

--
-- Estrutura da tabela `weather`
--

CREATE TABLE `weather` (
  `ID` int(11) NOT NULL,
  `CurrentWeather` int(3) DEFAULT NULL,
  `NextWeather` int(3) DEFAULT NULL,
  `TimeToNextWeather` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `weather`
--

INSERT INTO `weather` (`ID`, `CurrentWeather`, `NextWeather`, `TimeToNextWeather`) VALUES
(1, 2, 4, 1438108820);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apartments`
--
ALTER TABLE `apartments`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `apartments_objects`
--
ALTER TABLE `apartments_objects`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `attachments`
--
ALTER TABLE `attachments`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `buildings`
--
ALTER TABLE `buildings`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `business`
--
ALTER TABLE `business`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `dealership`
--
ALTER TABLE `dealership`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `factions`
--
ALTER TABLE `factions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `houses`
--
ALTER TABLE `houses`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `lottery`
--
ALTER TABLE `lottery`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `pets`
--
ALTER TABLE `pets`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `player_weapons`
--
ALTER TABLE `player_weapons`
  ADD UNIQUE KEY `userid_2` (`userid`,`weaponid`),
  ADD KEY `userid` (`userid`);

--
-- Indexes for table `vehicles`
--
ALTER TABLE `vehicles`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- Indexes for table `weather`
--
ALTER TABLE `weather`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `ID` (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `apartments`
--
ALTER TABLE `apartments`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `apartments_objects`
--
ALTER TABLE `apartments_objects`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `attachments`
--
ALTER TABLE `attachments`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `buildings`
--
ALTER TABLE `buildings`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;
--
-- AUTO_INCREMENT for table `business`
--
ALTER TABLE `business`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;
--
-- AUTO_INCREMENT for table `dealership`
--
ALTER TABLE `dealership`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `factions`
--
ALTER TABLE `factions`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `houses`
--
ALTER TABLE `houses`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;
--
-- AUTO_INCREMENT for table `lottery`
--
ALTER TABLE `lottery`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- AUTO_INCREMENT for table `pets`
--
ALTER TABLE `pets`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `ID` int(11) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `vehicles`
--
ALTER TABLE `vehicles`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;
--
-- AUTO_INCREMENT for table `weather`
--
ALTER TABLE `weather`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
