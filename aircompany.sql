-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Erstellungszeit: 08. Jul 2020 um 12:11
-- Server-Version: 10.4.11-MariaDB
-- PHP-Version: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `aircompany`
--
CREATE DATABASE IF NOT EXISTS `aircompany` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `aircompany`;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `arriving_airport`
--

CREATE TABLE `arriving_airport` (
  `ar_airport_id` int(11) NOT NULL,
  `town` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `departing_airport`
--

CREATE TABLE `departing_airport` (
  `d_airport_id` int(11) NOT NULL,
  `town` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `flight_destination`
--

CREATE TABLE `flight_destination` (
  `flight_destination_id` int(11) NOT NULL,
  `fk_d_airport_id` int(11) DEFAULT NULL,
  `fk_ar_airport_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `flight_info`
--

CREATE TABLE `flight_info` (
  `flight_id` int(11) NOT NULL,
  `date` date DEFAULT NULL,
  `fk_flight_destination_id` int(11) DEFAULT NULL,
  `fk_plane_id` int(11) DEFAULT NULL,
  `fk_passenger_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `passengers`
--

CREATE TABLE `passengers` (
  `passenger_id` int(11) NOT NULL,
  `f_name` varchar(255) DEFAULT NULL,
  `l_name` varchar(255) DEFAULT NULL,
  `b_day` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `passenger_count`
--

CREATE TABLE `passenger_count` (
  `fk_flight_info` int(11) DEFAULT NULL,
  `fk_passenger_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `plane_info`
--

CREATE TABLE `plane_info` (
  `plane_id` int(11) NOT NULL,
  `model` varchar(255) DEFAULT NULL,
  `manufacturer` varchar(255) DEFAULT NULL,
  `capacity` int(3) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `arriving_airport`
--
ALTER TABLE `arriving_airport`
  ADD PRIMARY KEY (`ar_airport_id`);

--
-- Indizes für die Tabelle `departing_airport`
--
ALTER TABLE `departing_airport`
  ADD PRIMARY KEY (`d_airport_id`);

--
-- Indizes für die Tabelle `flight_destination`
--
ALTER TABLE `flight_destination`
  ADD PRIMARY KEY (`flight_destination_id`),
  ADD KEY `fk_d_airport_id` (`fk_d_airport_id`,`fk_ar_airport_id`),
  ADD KEY `fk_ar_airport_id` (`fk_ar_airport_id`);

--
-- Indizes für die Tabelle `flight_info`
--
ALTER TABLE `flight_info`
  ADD PRIMARY KEY (`flight_id`),
  ADD KEY `fk_flight_destination_id` (`fk_flight_destination_id`,`fk_plane_id`,`fk_passenger_id`),
  ADD KEY `fk_plane_id` (`fk_plane_id`),
  ADD KEY `fk_passenger_id` (`fk_passenger_id`);

--
-- Indizes für die Tabelle `passengers`
--
ALTER TABLE `passengers`
  ADD PRIMARY KEY (`passenger_id`);

--
-- Indizes für die Tabelle `passenger_count`
--
ALTER TABLE `passenger_count`
  ADD KEY `fk_flight_info` (`fk_flight_info`),
  ADD KEY `fk_passenger_id` (`fk_passenger_id`);

--
-- Indizes für die Tabelle `plane_info`
--
ALTER TABLE `plane_info`
  ADD PRIMARY KEY (`plane_id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `arriving_airport`
--
ALTER TABLE `arriving_airport`
  MODIFY `ar_airport_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `departing_airport`
--
ALTER TABLE `departing_airport`
  MODIFY `d_airport_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `flight_destination`
--
ALTER TABLE `flight_destination`
  MODIFY `flight_destination_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `flight_info`
--
ALTER TABLE `flight_info`
  MODIFY `flight_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `passengers`
--
ALTER TABLE `passengers`
  MODIFY `passenger_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `plane_info`
--
ALTER TABLE `plane_info`
  MODIFY `plane_id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `flight_destination`
--
ALTER TABLE `flight_destination`
  ADD CONSTRAINT `flight_destination_ibfk_1` FOREIGN KEY (`fk_d_airport_id`) REFERENCES `departing_airport` (`d_airport_id`),
  ADD CONSTRAINT `flight_destination_ibfk_2` FOREIGN KEY (`fk_ar_airport_id`) REFERENCES `arriving_airport` (`ar_airport_id`);

--
-- Constraints der Tabelle `flight_info`
--
ALTER TABLE `flight_info`
  ADD CONSTRAINT `flight_info_ibfk_1` FOREIGN KEY (`fk_plane_id`) REFERENCES `plane_info` (`plane_id`),
  ADD CONSTRAINT `flight_info_ibfk_3` FOREIGN KEY (`fk_flight_destination_id`) REFERENCES `flight_destination` (`flight_destination_id`);

--
-- Constraints der Tabelle `passenger_count`
--
ALTER TABLE `passenger_count`
  ADD CONSTRAINT `passenger_count_ibfk_1` FOREIGN KEY (`fk_flight_info`) REFERENCES `flight_info` (`flight_id`),
  ADD CONSTRAINT `passenger_count_ibfk_2` FOREIGN KEY (`fk_passenger_id`) REFERENCES `passengers` (`passenger_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
