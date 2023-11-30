-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:4306
-- Generation Time: Nov 30, 2023 at 09:45 AM
-- Server version: 10.4.28-MariaDB
-- PHP Version: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `forensic`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`` PROCEDURE `viewLabAndTech` ()   BEGIN
    -- Fetch Lab and Lab Tech details using LEFT JOIN
    SELECT 
        l.LAB_ID, l.SPECIALIST, l.ADDRESS, 
        lt.TECH_ID, lt.NAME, lt.DESIGNATION
    FROM LAB l
    left JOIN LAB_TECHS lt ON l.TECH_ID = lt.TECH_ID;
END$$

CREATE DEFINER=`` PROCEDURE `viewOfficer` ()   BEGIN
    SELECT * FROM officer; -- You can modify this query based on your requirements
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `accesslogs`
--

CREATE TABLE `accesslogs` (
  `ID` int(9) NOT NULL,
  `USER` varchar(30) DEFAULT NULL,
  `LOGGEDIN` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `accesslogs`
--

INSERT INTO `accesslogs` (`ID`, `USER`, `LOGGEDIN`) VALUES
(1, '100', '2023-11-22 07:13:08'),
(2, '100', '2023-11-22 07:43:08'),
(3, '7', '2023-11-22 07:44:03'),
(4, '1000', '2023-11-22 07:45:45'),
(5, '7', '2023-11-22 07:50:18'),
(6, '1000', '2023-11-22 07:51:12'),
(7, '7', '2023-11-22 07:54:07'),
(8, '1000', '2023-11-22 08:07:56'),
(9, '100', '2023-11-22 08:27:54'),
(10, '7', '2023-11-22 08:35:41'),
(11, '1000', '2023-11-22 08:42:56'),
(12, '100', '2023-11-24 14:32:11'),
(13, '7', '2023-11-24 14:35:02'),
(14, '1000', '2023-11-24 14:38:18'),
(15, '1000', '2023-11-24 14:49:21'),
(16, '100', '2023-11-24 14:49:47'),
(17, '1000', '2023-11-24 14:50:57'),
(18, '7', '2023-11-24 15:20:18');

-- --------------------------------------------------------

--
-- Table structure for table `cases`
--

CREATE TABLE `cases` (
  `CASE_ID` int(6) NOT NULL,
  `OFFICER_ID` int(4) DEFAULT NULL,
  `DATE` date NOT NULL,
  `STATUS` varchar(10) DEFAULT NULL,
  `ADDRESS` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cases`
--

INSERT INTO `cases` (`CASE_ID`, `OFFICER_ID`, `DATE`, `STATUS`, `ADDRESS`) VALUES
(111111, 1000, '2019-10-10', 'Closed', 'BANGALORE'),
(111129, NULL, '2023-11-22', 'Opened', 'Kolkata'),
(333333, 1000, '2019-03-03', 'OPENED', 'BANGALORE'),
(111128, NULL, '2023-06-22', 'Opened', 'Kolkata'),
(555555, 1000, '2019-05-05', 'PENDING', 'KOCHI'),
(666666, NULL, '2019-06-06', 'OPENED', 'DELHI'),
(777777, 1000, '2019-07-07', 'PENDING', 'CHENNAI'),
(111120, NULL, '2023-11-08', 'Opened', 'Mumbai'),
(999999, 9000, '2019-09-09', 'PENDING', 'MYSORE'),
(22222, 3200, '2023-11-22', 'Opened', 'bbb');

--
-- Triggers `cases`
--
DELIMITER $$
CREATE TRIGGER `insertLog` AFTER INSERT ON `cases` FOR EACH ROW INSERT INTO writelogs VALUES(null, NEW.CASE_ID, NOW())
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `evidence`
--

CREATE TABLE `evidence` (
  `LAB_ID` int(3) DEFAULT NULL,
  `CASE_ID` int(6) DEFAULT NULL,
  `PROCESSING_METHOD` varchar(40) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `evidence`
--

INSERT INTO `evidence` (`LAB_ID`, `CASE_ID`, `PROCESSING_METHOD`) VALUES
(100, 111111, 'RESTORATION'),
(102, 333333, 'IMAGE SEGMENTATION'),
(104, 555555, 'PROJECTION TOMOGRAPHY'),
(105, 666666, 'IMAGE SEGMENTATION'),
(106, 777777, 'DIFFUSION'),
(109, 999999, 'FILTERATION'),
(101, 666666, 'DIFFUSION');

-- --------------------------------------------------------

--
-- Table structure for table `forensic_evidence`
--

CREATE TABLE `forensic_evidence` (
  `EVIDENCE_ID` int(4) NOT NULL,
  `COLLECTING_OFFICER` int(4) DEFAULT NULL,
  `LAB_ID` int(3) DEFAULT NULL,
  `CASE_ID` int(6) DEFAULT NULL,
  `RECEIVING_METHOD` varchar(20) DEFAULT NULL,
  `LOCATION_FOUND` varchar(40) DEFAULT NULL,
  `ADDRESS` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `forensic_evidence`
--

INSERT INTO `forensic_evidence` (`EVIDENCE_ID`, `COLLECTING_OFFICER`, `LAB_ID`, `CASE_ID`, `RECEIVING_METHOD`, `LOCATION_FOUND`, `ADDRESS`) VALUES
(10, 1000, 100, 111111, 'DNA', 'KEMPEGOWDA INTERNATIONAL AIRPORT', 'BANGALORE'),
(30, 3000, 300, 333333, 'BODY FLUIDS', 'CHAMUNDI HILLS', 'MYSORE'),
(50, 4000, 500, 555555, 'FOOTWEAR IMPRESSIONS', 'VIVEKANANDA FALLS', 'CHINTAMANI'),
(60, 5000, 600, 666666, 'FINGERPRINT', 'TURAHALLI FOREST', 'BANGALORE'),
(70, 4000, 700, 777777, 'DOCUMENTS', 'NIJAGUNA RESORTS', 'MYSORE'),
(90, 6000, 900, 999999, 'DNA', 'RAILWAY STATION', 'SHIVAMOGGA');

-- --------------------------------------------------------

--
-- Table structure for table `known_forensics`
--

CREATE TABLE `known_forensics` (
  `KNOWN_ID` int(4) NOT NULL,
  `CASE_ID` int(6) NOT NULL,
  `DNA_RESULT` varchar(20) DEFAULT NULL,
  `DRUG_TEST_RESULT` varchar(20) DEFAULT NULL,
  `BALLISTICS_RESULT` varchar(20) DEFAULT NULL,
  `BLOOD_GROUP` varchar(10) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `known_forensics`
--

INSERT INTO `known_forensics` (`KNOWN_ID`, `CASE_ID`, `DNA_RESULT`, `DRUG_TEST_RESULT`, `BALLISTICS_RESULT`, `BLOOD_GROUP`) VALUES
(1, 111111, 'MATCH NOT FOUND', 'MATCH FOUND', 'MATCH FOUND', 'AB+'),
(3, 333333, 'MATCH NOT FOUND', 'MATCH NOT FOUND', 'MATCH  NOT FOUND', 'A+'),
(5, 555555, 'MATCH FOUND', 'MATCH  FOUND', 'MATCH  NOT FOUND', 'O+'),
(6, 666666, 'MATCH FOUND', 'MATCH  FOUND', 'MATCH FOUND', 'AB+'),
(7, 777777, 'MATCH  NOT FOUND', 'MATCH NOT FOUND', 'MATCH FOUND', 'B+'),
(9, 999999, 'MATCH NOT FOUND', 'MATCH  FOUND', 'MATCH FOUND', 'A+');

-- --------------------------------------------------------

--
-- Table structure for table `lab`
--

CREATE TABLE `lab` (
  `LAB_ID` int(3) NOT NULL,
  `TECH_ID` int(6) DEFAULT NULL,
  `SPECIALIST` varchar(20) DEFAULT NULL,
  `ADDRESS` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lab`
--

INSERT INTO `lab` (`LAB_ID`, `TECH_ID`, `SPECIALIST`, `ADDRESS`) VALUES
(100, 200012, 'CRIMINALOGY', 'BANGALORE'),
(101, 199923, 'PATHOLOGY', 'BANGALORE'),
(102, 200912, 'CRIMINALOGY', 'MYSORE'),
(103, 201521, 'TOXICOLOGY', 'KOLAR'),
(104, 200111, 'CRIMINALOGY', 'TIUMKUR'),
(105, 199812, 'CRIMINALOGY', 'BANGALORE'),
(106, 201012, 'PATHOLOGY', 'MYSORE'),
(107, 200712, 'CRIMINALOGY', 'DHARAWAD'),
(108, 199209, 'PATHOLOGY', 'SHIVAMOGGA');

-- --------------------------------------------------------

--
-- Table structure for table `lab_techs`
--

CREATE TABLE `lab_techs` (
  `TECH_ID` int(6) NOT NULL,
  `NAME` varchar(20) DEFAULT NULL,
  `DESIGNATION` varchar(30) DEFAULT NULL,
  `DEPARTMENT` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `lab_techs`
--

INSERT INTO `lab_techs` (`TECH_ID`, `NAME`, `DESIGNATION`, `DEPARTMENT`) VALUES
(200012, 'HEMANTH', 'CATH LAB TECHNICIAN', 'PATHOLOGY'),
(199923, 'RAMAPPA', 'AQUA LAB TECHNICIAN', 'CRIMINALOGY'),
(200912, 'ISHIKA', 'COLOUR MATCH LAB TECHNICIAN', 'TOXICOLOGY'),
(201521, 'VANI SHANKAR', 'MEDICAL LAB TECHNICIAN', 'BALLISTICALOGY'),
(200111, 'VINAYARYA', 'COLOUR MATCH LAB TECHNICIAN', 'COMPUTER FORENSICS'),
(100912, 'GURURAJ', 'CATH LAB TECHNICIAN', 'CRIMINALOGY'),
(201012, 'SHIVARAMAKRISHNA', 'CATH LAB TECHNICIAN', 'PATHOLOGY'),
(200712, 'HARSHAVARDHAN', 'MEDICAL LAB TECHNICIAN', 'PATHOLOGY'),
(199209, 'RUTVIKA', 'COLOUR MATCH LAB TECHNICIAN', 'CRIMINALOGY');

-- --------------------------------------------------------

--
-- Table structure for table `officer`
--

CREATE TABLE `officer` (
  `OFFICER_ID` int(4) NOT NULL,
  `NAME` varchar(20) DEFAULT NULL,
  `DESIGNATION` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `officer`
--

INSERT INTO `officer` (`OFFICER_ID`, `NAME`, `DESIGNATION`) VALUES
(1000, 'RAMAKRISHNA', 'INSPECTOR'),
(2000, 'ANJALI', 'DGP'),
(3000, 'MALLIKARJUNA', 'ADDI.DGP'),
(4000, 'ANJANAREDDY', 'SP'),
(5000, 'SOWMYASETTY', 'DSP'),
(6000, 'KADHAR ALI', 'ACP'),
(7000, 'SUNEEL KUMAR', 'SSP'),
(8000, 'BHASKAR RAO', 'SI'),
(9000, 'NELAMANI', 'INSPECTOR');

-- --------------------------------------------------------

--
-- Table structure for table `suspects`
--

CREATE TABLE `suspects` (
  `SUSPECT_ID` int(6) NOT NULL,
  `CASE_ID` int(6) DEFAULT NULL,
  `NAME` varchar(20) DEFAULT NULL,
  `ADDRESS` varchar(20) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `suspects`
--

INSERT INTO `suspects` (`SUSPECT_ID`, `CASE_ID`, `NAME`, `ADDRESS`) VALUES
(201912, 111111, 'VINAY', 'MUMBAI'),
(201501, 66666, 'RAMYA', 'BANGALORE'),
(200010, 333333, 'KEERTHAN', 'DEHLI'),
(201323, 555555, 'AMRUTHA', 'DHAKA'),
(200913, 555555, 'SYED ALI', 'SINGAPORE'),
(201956, 999999, 'SUMANUSHA', 'BIHAR'),
(201202, 111111, 'RIRIKESH', 'KOLKATTA'),
(201325, 555555, 'NARAAYANA', 'LAHORE');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(6) NOT NULL,
  `name` varchar(30) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `contact` varchar(30) NOT NULL,
  `city` varchar(30) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `contact`, `city`) VALUES
(100, 'Dheeraj', 'dheeraj@fds.com', 'abcd', '9988776655', 'Bangalore'),
(2000, 'officer2', 'officer22000@fds.com', 'abcd123', '4433221100', 'Bangalore'),
(7, 'Divya', 'divya7@fds.com', 'divya', '7896321745', 'Mumbai'),
(1000, 'RAMAKRISHNA', 'RAMAKRISHNA1000@fds.com', '123', '9638527417', 'Goa');

-- --------------------------------------------------------

--
-- Table structure for table `writelogs`
--

CREATE TABLE `writelogs` (
  `ID` int(6) NOT NULL,
  `CASE_ID` int(6) NOT NULL,
  `DATE` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `writelogs`
--

INSERT INTO `writelogs` (`ID`, `CASE_ID`, `DATE`) VALUES
(19, 22222, '2023-11-22 08:39:28'),
(18, 111129, '2023-11-22 08:38:07'),
(17, 111128, '2023-11-22 07:54:51'),
(16, 111120, '2023-11-22 07:54:24');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `accesslogs`
--
ALTER TABLE `accesslogs`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `cases`
--
ALTER TABLE `cases`
  ADD PRIMARY KEY (`CASE_ID`);

--
-- Indexes for table `evidence`
--
ALTER TABLE `evidence`
  ADD KEY `FK_6` (`LAB_ID`),
  ADD KEY `FK_7` (`CASE_ID`);

--
-- Indexes for table `forensic_evidence`
--
ALTER TABLE `forensic_evidence`
  ADD PRIMARY KEY (`EVIDENCE_ID`),
  ADD KEY `FK_2` (`COLLECTING_OFFICER`),
  ADD KEY `FK_3` (`LAB_ID`),
  ADD KEY `FK_4` (`CASE_ID`);

--
-- Indexes for table `known_forensics`
--
ALTER TABLE `known_forensics`
  ADD PRIMARY KEY (`KNOWN_ID`);

--
-- Indexes for table `lab`
--
ALTER TABLE `lab`
  ADD PRIMARY KEY (`LAB_ID`),
  ADD KEY `FK_11` (`TECH_ID`);

--
-- Indexes for table `lab_techs`
--
ALTER TABLE `lab_techs`
  ADD PRIMARY KEY (`TECH_ID`);

--
-- Indexes for table `officer`
--
ALTER TABLE `officer`
  ADD PRIMARY KEY (`OFFICER_ID`);

--
-- Indexes for table `suspects`
--
ALTER TABLE `suspects`
  ADD PRIMARY KEY (`SUSPECT_ID`),
  ADD KEY `FK_7` (`CASE_ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `writelogs`
--
ALTER TABLE `writelogs`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `accesslogs`
--
ALTER TABLE `accesslogs`
  MODIFY `ID` int(9) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT for table `known_forensics`
--
ALTER TABLE `known_forensics`
  MODIFY `KNOWN_ID` int(4) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1006;

--
-- AUTO_INCREMENT for table `suspects`
--
ALTER TABLE `suspects`
  MODIFY `SUSPECT_ID` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201965;

--
-- AUTO_INCREMENT for table `writelogs`
--
ALTER TABLE `writelogs`
  MODIFY `ID` int(6) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
