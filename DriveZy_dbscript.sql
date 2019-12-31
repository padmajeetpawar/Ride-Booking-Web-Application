-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Server version:               5.7.27-log - MySQL Community Server (GPL)
-- Server OS:                    Win64
-- HeidiSQL Version:             10.2.0.5599
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for drivezy
DROP DATABASE IF EXISTS `drivezy`;
CREATE DATABASE IF NOT EXISTS `drivezy` /*!40100 DEFAULT CHARACTER SET latin1 */;
USE `drivezy`;

-- Dumping structure for table drivezy.driver
DROP TABLE IF EXISTS `driver`;
CREATE TABLE IF NOT EXISTS `driver` (
  `driverId` int(11) NOT NULL AUTO_INCREMENT,
  `driverName` varchar(200) NOT NULL,
  `driverEmail` varchar(200) NOT NULL,
  `driverPassword` varchar(200) NOT NULL,
  `driverMobile` varchar(17) NOT NULL,
  `userType` varchar(17) NOT NULL DEFAULT 'Driver',
  `vehicleNumber` varchar(50) NOT NULL DEFAULT '',
  `vehicleModel` varchar(50) NOT NULL DEFAULT '',
  `driverRating` int(11) NOT NULL DEFAULT '0' COMMENT '1 / 2 / 3 / 4 / 5',
  PRIMARY KEY (`driverId`),
  UNIQUE KEY `driverEmail` (`driverEmail`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- Dumping data for table drivezy.driver: ~1 rows (approximately)
DELETE FROM `driver`;
/*!40000 ALTER TABLE `driver` DISABLE KEYS */;
INSERT INTO `driver` (`driverId`, `driverName`, `driverEmail`, `driverPassword`, `driverMobile`, `userType`, `vehicleNumber`, `vehicleModel`, `driverRating`) VALUES
	(1, 'Ashutosh Driver', 'wadhvekar.ashutosh@gmail.com', 'Zcpl@123', '+1 (312) 567-1234', 'Driver', 'MH12 LY 4334', 'Honda Unicorn', 4),
	(2, 'Padmajeet Driver', 'ppawar2@gmail.com', 'DriveZy@123', '+1 (124) 356-8790', 'Driver', 'MH 12 AD 2526', 'Honda Amaze', 3);
/*!40000 ALTER TABLE `driver` ENABLE KEYS */;

-- Dumping structure for table drivezy.rides
DROP TABLE IF EXISTS `rides`;
CREATE TABLE IF NOT EXISTS `rides` (
  `rideId` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `driverId` int(11) NOT NULL,
  `source` varchar(500) NOT NULL DEFAULT '',
  `sourceZipcode` varchar(10) DEFAULT '',
  `destination` varchar(500) NOT NULL DEFAULT '',
  `rideDate` date DEFAULT NULL,
  `rideTime` time DEFAULT NULL,
  `estimatedArrivalTime` varchar(50) DEFAULT '',
  `rideDistance` varchar(50) DEFAULT '',
  `rideType` varchar(10) DEFAULT '',
  `rideReview` text,
  `rideRating` varchar(2) NOT NULL DEFAULT '0',
  `paymentAmount` float DEFAULT NULL,
  `paymentCardNumber` varchar(50) DEFAULT '',
  `paymentAddress` varchar(50) DEFAULT '',
  `paymentDate` date DEFAULT NULL,
  `paymentTime` time DEFAULT NULL,
  PRIMARY KEY (`rideId`),
  KEY `FK_rides_user` (`userId`),
  KEY `FK_rides_driver` (`driverId`),
  CONSTRAINT `FK_rides_driver` FOREIGN KEY (`driverId`) REFERENCES `driver` (`driverId`),
  CONSTRAINT `FK_rides_user` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`)
) ENGINE=InnoDB AUTO_INCREMENT=48 DEFAULT CHARSET=latin1;

-- Dumping data for table drivezy.rides: ~34 rows (approximately)
DELETE FROM `rides`;
/*!40000 ALTER TABLE `rides` DISABLE KEYS */;
INSERT INTO `rides` (`rideId`, `userId`, `driverId`, `source`, `sourceZipcode`, `destination`, `rideDate`, `rideTime`, `estimatedArrivalTime`, `rideDistance`, `rideType`, `rideReview`, `rideRating`, `paymentAmount`, `paymentCardNumber`, `paymentAddress`, `paymentDate`, `paymentTime`) VALUES
	(1, 1, 1, '10 West 31st Street, Chicago, IL, USA', '', '500 East 33rd Street, Chicago, IL, USA', '2019-11-16', '16:30:00', NULL, '', '', NULL, '0', 22.45, '1234567890123456', '', NULL, NULL),
	(2, 1, 1, '10 West 31st Street, Chicago, IL, USA', '', '500 East 33rd Street, Chicago, IL, USA', '2019-11-16', '16:30:00', NULL, '', '', NULL, '2', 22.45, '1234567890123456', '', NULL, NULL),
	(3, 1, 1, '10 West 31st Street, Chicago, IL, USA', '', '500 East 33rd Street, Chicago, IL, USA', '2019-11-16', '16:30:00', NULL, '', '', NULL, '3', 22.45, '1234567890123456', '', NULL, NULL),
	(4, 1, 1, '10 West 35th Street, Chicago, IL, USA', '', 'Union Station, South Canal Street, Chicago, IL, USA', '2019-11-16', '13:30:00', NULL, '', '', NULL, '1', 22.45, '1234567890123456', '', NULL, NULL),
	(5, 1, 1, '10 West 35th Street, Chicago, IL, USA', '', 'Union Station, South Canal Street, Chicago, IL, USA', '2019-11-16', '13:30:00', NULL, '', '', NULL, '4', 22.45, '1234567890123456', '', NULL, NULL),
	(6, 1, 1, '10 West 35th Street, Chicago, IL, USA', '60616', 'Union Station, South Canal Street, Chicago, IL, USA', '2019-11-16', '13:30:00', NULL, '', '', NULL, '2', 22.45, '1234567890123456', '', NULL, NULL),
	(7, 1, 1, '10 West 35th Street, Chicago, IL, USA', '60616', 'Union Station, South Canal Street, Chicago, IL, USA', '2019-11-16', '13:30:00', NULL, '', '', NULL, '1', 22.45, '1234567890123456', '', NULL, NULL),
	(8, 1, 1, '10 West 35th Street, Chicago, IL, USA', '60616', 'Union Station, South Canal Street, Chicago, IL, USA', '2019-11-16', '13:30:00', NULL, '', '', NULL, '2', 22.45, '1234567890123456', '', NULL, NULL),
	(9, 1, 1, 'ISKCON, West Lunt Avenue, Chicago, IL, USA', '60626', 'Stuart Building, Chicago, IL, USA', '2019-11-18', '11:30:00', NULL, '', '', NULL, '3', 22.45, '1234567890123456', '', NULL, NULL),
	(10, 1, 1, 'baps near Chicago, IL, USA', '60626', 'Chicago iskcon, South Artesian Avenue, Chicago, IL, USA', '2019-11-20', '14:30:00', NULL, '', '', NULL, '4', 22.45, '1234567890123456', '', NULL, NULL),
	(11, 5, 1, '2951 South King Drive, Chicago, IL, USA', '60616', 'Millennium Park, East Randolph Street, Chicago, IL, USA', '2019-11-20', '06:30:00', NULL, '', '', 'Awesome Ride!!!', '5', 22.45, '1234567890123456', '', NULL, NULL),
	(12, 1, 1, '200 West Adams Street, Chicago, IL, USA', '60616', '500 East 33rd Street, Chicago, IL, USA', '2019-11-17', '18:30:00', NULL, '', '', NULL, '4', 22.45, '1234567890123456', '', NULL, NULL),
	(13, 1, 1, '500 East 33rd Street, Chicago, IL, USA', '60616', 'which wich near Chicago River, Illinois, USA', '2019-11-16', '19:30:00', NULL, '', '', NULL, '1', 22.45, '1234567890123456', '', NULL, NULL),
	(14, 1, 1, 'Chicago Public Library, West Division Street, Chicago, IL, USA', '60626', 'O\'Hare International Airport (ORD), West O\'Hare Avenue, Chicago, IL, USA', '2019-11-17', '19:00:00', '27 mins', '15.0 mi', '', NULL, '2', 22.45, '1234567890123456', '', NULL, NULL),
	(15, 1, 1, 'Midway International Airport Terminal, South Cicero Avenue, Chicago, IL, USA', '60653', 'O\'Hare International Airport (ORD), West O\'Hare Avenue, Chicago, IL, USA', '2019-11-17', '19:30:00', '42 mins', '31.3 mi', '', NULL, '3', 22.45, '1234567890123456', '', NULL, NULL),
	(16, 1, 1, '500 East 33rd Street, Chicago, IL, USA', '60616', '1333 S Wabash, South Wabash Avenue, Chicago, IL, USA', '2019-11-17', '19:29:00', '12 mins', '2.8 mi', '', NULL, '4', 22.45, '1234567890123456', '', NULL, NULL),
	(17, 1, 1, '500 East 33rd Street, Chicago, IL, USA', '60616', 'Millennium Park, Chicago, IL, USA', '2019-11-18', '22:00:00', '11 mins', '4.0 mi', '', NULL, '5', 22.45, '1234567890123456', '', NULL, NULL),
	(18, 1, 1, '500 East 33rd Street, Chicago, IL, USA', '60616', 'Millennium Park, Chicago, IL, USA', '2019-11-22', '13:00:00', '11 mins', '4.0 mi', '', NULL, '2', 14.98, '1234567890123456', '', NULL, NULL),
	(19, 1, 2, 'Stuart Building, Chicago, IL, USA', '60616', 'Union Station, Illinois 50, Chicago, IL, USA', '2019-11-22', '13:30:00', '11 mins', '7.8 mi', '', NULL, '1', 23.77, '1234567890123456', '', NULL, NULL),
	(20, 1, 1, '500 East 33rd Street, Chicago, IL, USA', '60616', 'Millennium Park, East Randolph Street, Chicago, IL, USA', '2019-11-22', '14:45:00', '11 mins', '3.7 mi', '', NULL, '2', 13.25, '1234567890123456', '', NULL, NULL),
	(21, 1, 2, '500 East 33rd Street, Chicago, IL, USA', '60616', 'Millennium Park, East Randolph Street, Chicago, IL, USA', '2019-11-23', '10:00:00', '11 mins', '3.7 mi', '', NULL, '3', 13.32, '1234567890123456', '', NULL, NULL),
	(22, 1, 2, 'Stuart Building, Chicago, IL, USA', '60616', 'Union Station, West Monroe Street, Chicago, IL, USA', '2019-11-25', '10:00:00', '12 mins', '4.2 mi', '', NULL, '4', 18.71, '1234567890123456', '', NULL, NULL),
	(23, 1, 2, 'Union Station, West Monroe Street, Chicago, IL, USA', '60601', 'Stuart Building, Chicago, IL, USA', '2019-11-25', '10:00:00', '11 mins', '4.3 mi', '', NULL, '4', 13.61, '1234567890123456', '', NULL, NULL),
	(24, 1, 2, 'Stuart Building, Chicago, IL, USA', '60616', 'Millennium Park, Chicago, IL, USA', '2019-11-23', '20:00:00', '13 mins', '4.9 mi', '', NULL, '4', 16.38, '1234567890123456', '', NULL, NULL),
	(25, 1, 1, 'Millennium Park, Chicago, IL, USA', '60601', 'Stuart Building, Chicago, IL, USA', '2019-11-27', '20:00:00', '11 mins', '4.4 mi', '', 'Awesome Ride!! Driver was friendly.', '4', 13.98, '1234567890123456', '', NULL, NULL),
	(26, 1, 1, 'Stuart Building, Chicago, IL, USA', '60616', 'Apple Michigan Avenue, North Michigan Avenue, Chicago, IL, USA', '2019-11-22', '16:30:00', '14 mins', '5.7 mi', '', NULL, '1', 23.69, '1234567890123456', '', NULL, NULL),
	(27, 1, 1, 'Millennium Park Plaza, North Michigan Avenue, Chicago, IL, USA', '60601', '500 East 33rd Street, Chicago, IL, USA', '2019-11-23', '19:00:00', '12 mins', '4.8 mi', '', NULL, '2', 15.8, '1234567890123456', '', NULL, NULL),
	(28, 1, 2, 'costco wholesale near Chicago, IL, USA', '60608', '500 East 33rd Street, Chicago, IL, USA', '2019-11-23', '18:40:00', '17 mins', '5.4 mi', '', NULL, '3', 13.03, '1234567890123456', '', NULL, NULL),
	(29, 6, 2, '500 East 33rd Street, Chicago, IL, USA', '60616', 'Union Station, Illinois 50, Chicago, IL, USA', '2019-11-28', '16:00:00', '28 mins', '8.3 mi', '', 'Nice Ride!! Driver was good', '4', 30.05, '1234567890123456', '', NULL, NULL),
	(30, 6, 2, 'Stuart Building, Chicago, IL, USA', '60616', 'Millennium Park, Chicago, IL, USA', '2019-12-02', '07:30:00', '15 mins', '3.4 mi', '', NULL, '0', 14.77, '1234567890123456', '', NULL, NULL),
	(31, 6, 1, 'Millennium Park Plaza, North Michigan Avenue, Chicago, IL, USA', '60601', 'Stuart Building, Chicago, IL, USA', '2019-12-02', '07:30:00', '17 mins', '5.2 mi', '', NULL, '0', 18.37, '1234567890123456', '', NULL, NULL),
	(32, 6, 1, '10 West 35th Street, Chicago, IL, USA', '60616', 'Navy Pier, East Grand Avenue, Chicago, IL, USA', '2019-12-02', '16:03:00', '13 mins', '5.6 mi', '', NULL, '0', 18.35, '1234567890123456', '', NULL, NULL),
	(33, 6, 1, '10 West 35th Street, Chicago, IL, USA', '60616', 'Navy Pier, East Grand Avenue, Chicago, IL, USA', '2019-12-02', '16:04:00', '13 mins', '5.6 mi', '', NULL, '0', 14.64, '1234567890123456', '', NULL, NULL),
	(34, 6, 2, '2951 South King Drive, Chicago, IL, USA', '60616', 'O\'Hare International Airport (ORD), West O\'Hare Avenue, Chicago, IL, USA', '2019-12-02', '12:00:00', '46 mins', '21.0 mi', 'private', NULL, '0', 59.54, '1234567890123456', '', NULL, NULL),
	(35, 6, 1, 'Millennium Park Plaza, North Michigan Avenue, Chicago, IL, USA', '60601', 'Stuart Building, Chicago, IL, USA', '2019-12-02', '18:26:00', '12 mins', '4.9 mi', 'private', NULL, '0', 18.1, '1234567890123456', '', NULL, NULL),
	(36, 8, 2, '500 East 33rd Street, Chicago, IL, USA', '60616', 'Union Station, Illinois 50, Chicago, IL, USA', '2019-11-24', '17:00:00', '27 mins', '8.3 mi', 'private', 'Ride was Awesome!!', '4', 24.4, '1234567890123456', '', NULL, NULL),
	(37, 8, 1, 'Stuart Building, Chicago, IL, USA', '60616', 'Millennium Park Plaza, North Michigan Avenue, Chicago, IL, USA', '2019-11-25', '09:00:00', '12 mins', '4.4 mi', 'private', NULL, '0', 17.9, '1234567890123456', '', NULL, NULL),
	(38, 8, 1, 'Millennium Park Plaza, North Michigan Avenue, Chicago, IL, USA', '60601', 'Stuart Building, Chicago, IL, USA', '2019-11-25', '09:00:00', '14 mins', '5.2 mi', 'private', NULL, '0', 17.68, '1234567890123456', '', NULL, NULL),
	(39, 8, 2, 'Millennium Park Plaza, North Michigan Avenue, Chicago, IL, USA', '60601', 'Stuart Building, Chicago, IL, USA', '2019-11-25', '18:00:00', '14 mins', '5.2 mi', 'private', NULL, '0', 23.75, '1234567890123456', '', NULL, NULL),
	(40, 8, 1, '10 West 35th Street, Chicago, IL, USA', '60616', 'Navy Pier, East Grand Avenue, Chicago, IL, USA', '2019-11-25', '16:58:00', '13 mins', '5.6 mi', 'private', NULL, '0', 18.61, '1234567890123456', '', NULL, NULL),
	(41, 8, 1, '10 West 35th Street, Chicago, IL, USA', '60616', 'Navy Pier, East Grand Avenue, Chicago, IL, USA', '2019-11-25', '16:59:00', '13 mins', '5.6 mi', 'share', NULL, '0', 13.13, '1234567890123456', '', NULL, NULL),
	(42, 10, 1, '500 East 33rd Street, Chicago, IL, USA', '60616', 'Union Station, Illinois 50, Chicago, IL, USA', '2019-11-25', '08:00:00', '15 mins', '9.5 mi', 'private', NULL, '0', 27.93, '1234567890123456', '', NULL, NULL),
	(43, 10, 1, 'Stuart Building, Chicago, IL, USA', '60616', 'Millennium Park Plaza, North Michigan Avenue, Chicago, IL, USA', '2019-11-25', '08:22:00', '12 mins', '4.4 mi', 'private', NULL, '0', 17.84, '1234567890123456', '', NULL, NULL),
	(44, 10, 1, 'Millennium Park Plaza, North Michigan Avenue, Chicago, IL, USA', '60601', 'Stuart Building, Chicago, IL, USA', '2019-11-25', '08:23:00', '12 mins', '4.4 mi', 'private', NULL, '0', 12.79, '1234567890123456', '', NULL, NULL),
	(45, 10, 1, '10 West 35th Street, Chicago, IL, USA', '60616', 'Navy Pier, East Grand Avenue, Chicago, IL, USA', '2019-11-26', '17:23:00', '13 mins', '5.6 mi', 'private', NULL, '0', 19.41, '1234567890123456', '', NULL, NULL),
	(46, 10, 2, '10 West 35th Street, Chicago, IL, USA', '60616', 'Navy Pier, East Grand Avenue, Chicago, IL, USA', '2019-11-26', '17:24:00', '13 mins', '5.6 mi', 'share', 'It was awesome ride!!', '4', 12.63, '1234567890123456', '', NULL, NULL),
	(47, 8, 2, 'Millennium Park Plaza, North Michigan Avenue, Chicago, IL, USA', '60601', '500 East 33rd Street, Chicago, IL, USA', '2019-11-25', '17:42:00', '12 mins', '4.8 mi', 'private', 'Awesome Ride!!', '5', 19.98, '1234567890123456', '', NULL, NULL);
/*!40000 ALTER TABLE `rides` ENABLE KEYS */;

-- Dumping structure for table drivezy.user
DROP TABLE IF EXISTS `user`;
CREATE TABLE IF NOT EXISTS `user` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL DEFAULT '',
  `email` varchar(200) NOT NULL DEFAULT '',
  `password` varchar(200) NOT NULL DEFAULT '',
  `mobile` varchar(17) NOT NULL DEFAULT '',
  `userType` varchar(15) NOT NULL DEFAULT 'Customer' COMMENT 'Customer / Driver / Super Admin',
  PRIMARY KEY (`userId`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `mobile` (`mobile`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- Dumping data for table drivezy.user: ~7 rows (approximately)
DELETE FROM `user`;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`userId`, `name`, `email`, `password`, `mobile`, `userType`) VALUES
	(1, 'Ashutosh Wadhvekar', 'awadhvekar@gmail.com', 'DriveZy@123', '+1 312 843 7477', 'Super Admin'),
	(2, 'Ashutosh Customer', 'awadhvekar@hawk.iit.edu', 'Zcpl@123', '+1 779 852 6612', 'Customer'),
	(3, 'Rohit', 'rohit.jagadale@gmail.com', 'Drivezy@123', '1234567890', 'Customer'),
	(4, 'Akash Tangade', 'akashtangade007@gmail.com', 'Akash@123', '+1 (312) 566-7869', 'Customer'),
	(5, 'Padmajeet Pawar', 'ppawar2@hawk.iit.edu', 'DriveZy@123', '+1 (123) 456-7890', 'Customer'),
	(6, 'Customer2', 'Customer2@gmail.com', 'Customer2', '+1 (234) 516-7890', 'Customer'),
	(7, 'customer3', 'customer3@gmail.com', '12345', '+1 (312) 973-9220', 'Customer'),
	(8, 'Customer1', 'Customer1@gmail.com', 'Customer1', '+1 (231) 432-5678', 'Customer'),
	(10, 'Customer5', 'Customer5@gmail.com', 'Customer5', '+1 (234) 567-8091', 'Customer');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
