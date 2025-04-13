CREATE DATABASE  IF NOT EXISTS `incidentmanagementdb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `incidentmanagementdb`;
-- MySQL dump 10.13  Distrib 8.0.41, for Win64 (x86_64)
--
-- Host: localhost    Database: incidentmanagementdb
-- ------------------------------------------------------
-- Server version	8.0.41

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `comment`
--

DROP TABLE IF EXISTS `comment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comment` (
  `comment_id` int DEFAULT NULL,
  `comment` varchar(255) DEFAULT NULL,
  `incident_id` int NOT NULL,
  `user_id` int NOT NULL,
  KEY `user_id` (`user_id`),
  KEY `fk_incident_id` (`incident_id`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`incident_id`) REFERENCES `incident` (`incident_id`),
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `fk_incident_id` FOREIGN KEY (`incident_id`) REFERENCES `incident` (`incident_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comment`
--

LOCK TABLES `comment` WRITE;
/*!40000 ALTER TABLE `comment` DISABLE KEYS */;
/*!40000 ALTER TABLE `comment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `feedback`
--

DROP TABLE IF EXISTS `feedback`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `feedback` (
  `feedback_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `message` text NOT NULL,
  `rate` enum('1','2','3','4','5') DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `resolution_id` int NOT NULL,
  PRIMARY KEY (`feedback_id`),
  KEY `fk_resolution_id` (`resolution_id`),
  KEY `fk_user_id` (`user_id`),
  CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_resolution_id` FOREIGN KEY (`resolution_id`) REFERENCES `incident_resolution` (`resolution_id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `feedback`
--

LOCK TABLES `feedback` WRITE;
/*!40000 ALTER TABLE `feedback` DISABLE KEYS */;
/*!40000 ALTER TABLE `feedback` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incident`
--

DROP TABLE IF EXISTS `incident`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incident` (
  `incident_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `category` enum('Building Maintenance','Road and Pavements','Water and Sewage Systems','Public Transportation','Parks and Recreational Facilities') DEFAULT NULL,
  `description` text NOT NULL,
  `geolocation` varchar(255) DEFAULT NULL,
  `evidence` text,
  `reported_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `status` enum('pending','in-progress','complete') DEFAULT NULL,
  `ticket_id` varchar(225) DEFAULT NULL,
  PRIMARY KEY (`incident_id`),
  KEY `fk_incident_user` (`user_id`),
  CONSTRAINT `fk_incident_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `incident_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incident`
--

LOCK TABLES `incident` WRITE;
/*!40000 ALTER TABLE `incident` DISABLE KEYS */;
INSERT INTO `incident` VALUES (1,1,NULL,'sdfklsdjflkjdslfjsdfksjdhfjksahkjhdslfjlsh',NULL,NULL,'2025-03-28 21:21:24',NULL,NULL);
/*!40000 ALTER TABLE `incident` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incident_resolution`
--

DROP TABLE IF EXISTS `incident_resolution`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `incident_resolution` (
  `resolution_id` int NOT NULL AUTO_INCREMENT,
  `resolution_location` varchar(255) DEFAULT NULL,
  `resolution_timestamp` datetime DEFAULT NULL,
  `resolution_evidence` text,
  `maintenance_id` int NOT NULL,
  `incident_id` int DEFAULT NULL,
  PRIMARY KEY (`resolution_id`),
  KEY `fk_maintenance_id` (`maintenance_id`),
  CONSTRAINT `fk_maintenance_id` FOREIGN KEY (`maintenance_id`) REFERENCES `maintenanceteam` (`maintenance_id`),
  CONSTRAINT `incident_resolution_ibfk_1` FOREIGN KEY (`resolution_id`) REFERENCES `ticket` (`ticket_id`) ON DELETE CASCADE,
  CONSTRAINT `incident_resolution_ibfk_2` FOREIGN KEY (`maintenance_id`) REFERENCES `maintenanceteam` (`maintenance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incident_resolution`
--

LOCK TABLES `incident_resolution` WRITE;
/*!40000 ALTER TABLE `incident_resolution` DISABLE KEYS */;
INSERT INTO `incident_resolution` VALUES (1,NULL,NULL,NULL,1,NULL);
/*!40000 ALTER TABLE `incident_resolution` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `maintenanceteam`
--

DROP TABLE IF EXISTS `maintenanceteam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `maintenanceteam` (
  `maintenance_id` int NOT NULL AUTO_INCREMENT,
  `specialization` varchar(50) NOT NULL,
  `availability` enum('Available','On leave','Relieved') DEFAULT 'Available',
  PRIMARY KEY (`maintenance_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `maintenanceteam`
--

LOCK TABLES `maintenanceteam` WRITE;
/*!40000 ALTER TABLE `maintenanceteam` DISABLE KEYS */;
INSERT INTO `maintenanceteam` VALUES (1,'s','Available');
/*!40000 ALTER TABLE `maintenanceteam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notification`
--

DROP TABLE IF EXISTS `notification`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notification` (
  `notification_id` int NOT NULL AUTO_INCREMENT,
  `user_id` int DEFAULT NULL,
  `notification_type` varchar(50) NOT NULL,
  `status` enum('Read','Unread') DEFAULT 'Unread',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `team_id` int DEFAULT NULL,
  PRIMARY KEY (`notification_id`),
  KEY `team_id` (`team_id`),
  KEY `fk_notification_id` (`user_id`),
  CONSTRAINT `fk_notification_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`),
  CONSTRAINT `notification_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`user_id`) ON DELETE CASCADE,
  CONSTRAINT `notification_ibfk_2` FOREIGN KEY (`team_id`) REFERENCES `maintenanceteam` (`maintenance_id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notification`
--

LOCK TABLES `notification` WRITE;
/*!40000 ALTER TABLE `notification` DISABLE KEYS */;
/*!40000 ALTER TABLE `notification` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket`
--

DROP TABLE IF EXISTS `ticket`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket` (
  `ticket_id` int NOT NULL AUTO_INCREMENT,
  `incident_id` int DEFAULT NULL,
  `priority_level` enum('Low','Medium','High') DEFAULT 'Medium',
  `status_id` enum('Pending','In Progress','Completed') DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`ticket_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket`
--

LOCK TABLES `ticket` WRITE;
/*!40000 ALTER TABLE `ticket` DISABLE KEYS */;
INSERT INTO `ticket` VALUES (1,1,'Medium',NULL,'2025-03-28 21:27:17');
/*!40000 ALTER TABLE `ticket` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `firstname` varchar(50) NOT NULL,
  `lastname` varchar(100) DEFAULT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(50) DEFAULT NULL,
  `phone_number` varchar(10) DEFAULT NULL,
  `role` enum('Resident','Maintenance','Authority','Guest') DEFAULT 'Resident',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'Lizz Modu',NULL,'test1234','lizz@gmail.com','0125443210','Resident'),(2,'sdfsdfdsfsfsfs',NULL,'sdfsdfsd',NULL,NULL,'Resident'),(3,'Khomo','Mapo','secure123','kmo@example.com','1234567890','Resident');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-13 15:46:19
