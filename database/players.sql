-- phpMyAdmin SQL Dump
-- version 4.3.11
-- http://www.phpmyadmin.net
--
-- Host: 127.0.0.1
-- Generation Time: 03-Ago-2015 às 05:04
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
-- Estrutura da tabela `players`
--

CREATE TABLE IF NOT EXISTS `players` (
  `ID` int(11) unsigned NOT NULL,
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
  `xp` int(10) unsigned NOT NULL DEFAULT '0',
  `level` int(10) unsigned NOT NULL DEFAULT '1',
  `ftime` int(10) unsigned NOT NULL DEFAULT '0',
  `hunger` float unsigned NOT NULL DEFAULT '100',
  `thirst` float unsigned NOT NULL DEFAULT '100',
  `sleep` float unsigned NOT NULL DEFAULT '100',
  `addiction` float unsigned NOT NULL DEFAULT '100',
  `phone_number` int(10) unsigned NOT NULL DEFAULT '0',
  `phone_network` int(10) unsigned NOT NULL DEFAULT '0',
  `phone_credits` int(10) unsigned NOT NULL DEFAULT '0',
  `phone_state` int(10) unsigned NOT NULL DEFAULT '0'
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

--
-- Extraindo dados da tabela `players`
--

INSERT INTO `players` (`ID`, `username`, `password`, `ip`, `email`, `x`, `y`, `z`, `a`, `interior`, `virtual_world`, `health`, `armour`, `skin`, `rank`, `faction`, `faction_rank`, `last_login`, `regdate`, `gender`, `money`, `hospital`, `achievements`, `ticket`, `jobid`, `jobxp`, `joblv`, `xp`, `level`, `ftime`, `hunger`, `thirst`, `sleep`, `addiction`, `phone_number`, `phone_network`, `phone_credits`, `phone_state`) VALUES
(1, 'Los', '784612', '127.0.0.1', NULL, 0, 0, 0, 0, 0, 0, 100, 0, 299, 0, 0, 0, 0, 1438570084, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 100, 100, 100, 100, 0, 0, 0, 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `players`
--
ALTER TABLE `players`
  ADD PRIMARY KEY (`ID`), ADD KEY `ID` (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `players`
--
ALTER TABLE `players`
  MODIFY `ID` int(11) unsigned NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=2;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
