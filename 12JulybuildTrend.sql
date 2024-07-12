-- MySQL dump 10.13  Distrib 8.0.36, for Linux (x86_64)
--
-- Host: localhost    Database: BuildTrend
-- ------------------------------------------------------
-- Server version	8.0.37-0ubuntu0.20.04.3

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
-- Table structure for table `chat_group`
--

DROP TABLE IF EXISTS `chat_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `chat_group` (
  `chat_group_id` int NOT NULL AUTO_INCREMENT,
  `owner_id` int NOT NULL,
  `job_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`chat_group_id`),
  KEY `owner_id` (`owner_id`),
  KEY `job_id` (`job_id`),
  CONSTRAINT `chat_group_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE,
  CONSTRAINT `chat_group_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `chat_group`
--

LOCK TABLES `chat_group` WRITE;
/*!40000 ALTER TABLE `chat_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `chat_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `comments`
--

DROP TABLE IF EXISTS `comments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `comments` (
  `comment_id` int NOT NULL AUTO_INCREMENT,
  `work_proof_id` int NOT NULL,
  `comment` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `work_image_id` int NOT NULL,
  PRIMARY KEY (`comment_id`),
  KEY `work_proof_id` (`work_proof_id`),
  KEY `fk_comments_1_idx` (`work_image_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`work_proof_id`) REFERENCES `work_proofs` (`work_proof_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_comments_1` FOREIGN KEY (`work_image_id`) REFERENCES `work_proof_images` (`work_image_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,2,'xfcvbbn  ','2024-07-12 12:09:03',NULL,0,9),(2,3,'sdfgdfghfgh','2024-07-12 14:01:29',NULL,0,13);
/*!40000 ALTER TABLE `comments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contractor_state`
--

DROP TABLE IF EXISTS `contractor_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contractor_state` (
  `contractor_state_id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `state` tinyint NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  `contractor_id` int NOT NULL,
  PRIMARY KEY (`contractor_state_id`),
  KEY `job_id` (`job_id`),
  KEY `fk_contractor_state_1_idx` (`contractor_id`),
  CONSTRAINT `contractor_state_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_contractor_state_1` FOREIGN KEY (`contractor_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contractor_state`
--

LOCK TABLES `contractor_state` WRITE;
/*!40000 ALTER TABLE `contractor_state` DISABLE KEYS */;
INSERT INTO `contractor_state` VALUES (1,16,0,'2024-07-10 13:09:49','2024-07-12 09:40:01',1,3),(2,17,0,'2024-07-10 13:18:32','2024-07-12 12:57:59',1,3),(3,16,2,'2024-07-10 13:19:41','2024-07-12 09:40:01',1,2),(4,17,2,'2024-07-12 09:59:40','2024-07-12 12:57:59',1,2),(5,17,0,'2024-07-12 10:37:39','2024-07-12 12:57:59',1,4),(6,17,0,'2024-07-12 10:41:18','2024-07-12 12:57:59',1,3),(7,18,2,'2024-07-12 11:56:33',NULL,0,2),(9,20,2,'2024-07-12 13:56:12','2024-07-12 14:02:50',1,5),(10,20,0,'2024-07-12 13:57:15','2024-07-12 14:02:50',1,2);
/*!40000 ALTER TABLE `contractor_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estimates`
--

DROP TABLE IF EXISTS `estimates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estimates` (
  `estimate_id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `contractor_id` int NOT NULL,
  `cost` decimal(10,0) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`estimate_id`),
  KEY `job_id` (`job_id`),
  KEY `contractor_id` (`contractor_id`),
  CONSTRAINT `estimates_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`) ON DELETE CASCADE,
  CONSTRAINT `estimates_ibfk_2` FOREIGN KEY (`contractor_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estimates`
--

LOCK TABLES `estimates` WRITE;
/*!40000 ALTER TABLE `estimates` DISABLE KEYS */;
INSERT INTO `estimates` VALUES (1,16,3,500000,'2024-07-10 13:09:49','2024-07-10 13:55:17',1),(2,17,3,300000,'2024-07-10 13:18:32','2024-07-12 10:43:44',1),(3,16,2,700000,'2024-07-10 13:19:41',NULL,0),(4,17,2,2000,'2024-07-12 09:59:40',NULL,0),(5,17,4,5000,'2024-07-12 10:37:39','2024-07-12 10:43:44',1),(6,17,3,4000,'2024-07-12 10:41:18','2024-07-12 10:43:44',1),(7,18,4,50000,'2024-07-12 11:56:33',NULL,0),(8,18,2,800000,'2024-07-12 11:58:19','2024-07-12 11:58:39',1),(9,20,5,20000,'2024-07-12 13:56:12',NULL,0),(10,20,2,50000,'2024-07-12 13:57:15','2024-07-12 13:58:34',1);
/*!40000 ALTER TABLE `estimates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_members`
--

DROP TABLE IF EXISTS `group_members`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `group_members` (
  `group_member_id` int NOT NULL AUTO_INCREMENT,
  `chat_group_id` int NOT NULL,
  `contractor_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `isDeleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`group_member_id`),
  KEY `chat_group_id` (`chat_group_id`),
  KEY `contractor_id` (`contractor_id`),
  CONSTRAINT `group_members_ibfk_1` FOREIGN KEY (`chat_group_id`) REFERENCES `chat_group` (`chat_group_id`) ON DELETE CASCADE,
  CONSTRAINT `group_members_ibfk_2` FOREIGN KEY (`contractor_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_members`
--

LOCK TABLES `group_members` WRITE;
/*!40000 ALTER TABLE `group_members` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_members` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_category_images`
--

DROP TABLE IF EXISTS `job_category_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_category_images` (
  `image_id` int NOT NULL AUTO_INCREMENT,
  `job_category_id` int NOT NULL,
  `image` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`image_id`),
  KEY `job_category_images_ibfk_1` (`job_category_id`),
  CONSTRAINT `job_category_images_ibfk_1` FOREIGN KEY (`job_category_id`) REFERENCES `jobs_categories` (`job_category_id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=33 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_category_images`
--

LOCK TABLES `job_category_images` WRITE;
/*!40000 ALTER TABLE `job_category_images` DISABLE KEYS */;
INSERT INTO `job_category_images` VALUES (1,1,'/uploads/files-1720611832316-684940168-1','2024-07-10 11:43:52','2024-07-12 09:40:01',1),(2,1,'/uploads/files-1720611832323-760206782-1','2024-07-10 11:43:52','2024-07-12 09:40:01',1),(3,1,'/uploads/files-1720611832329-939770414-1','2024-07-10 11:43:52','2024-07-12 09:40:01',1),(4,1,'/uploads/files-1720611832330-906512481-1','2024-07-10 11:43:52','2024-07-12 09:40:01',1),(5,1,'/uploads/files-1720611832349-158848666-1','2024-07-10 11:43:52','2024-07-12 09:40:01',1),(6,2,'/uploads/files-1720611832351-743458211-2','2024-07-10 11:43:52','2024-07-12 09:40:01',1),(7,2,'/uploads/files-1720611832353-239059051-2','2024-07-10 11:43:52','2024-07-12 09:40:01',1),(8,2,'/uploads/files-1720611832355-320164063-2','2024-07-10 11:43:52','2024-07-12 09:40:01',1),(9,2,'/uploads/files-1720611832356-438345088-2','2024-07-10 11:43:52','2024-07-12 09:40:01',1),(10,2,'/uploads/files-1720611832356-247921958-2','2024-07-10 11:43:52','2024-07-12 09:40:01',1),(11,2,'/uploads/files-1720611832357-41336688-2','2024-07-10 11:43:52','2024-07-12 09:40:01',1),(12,2,'/uploads/files-1720611832361-130508909-2','2024-07-10 11:43:52','2024-07-12 09:40:01',1),(13,3,'/uploads/files-1720615217584-142330535-1','2024-07-10 12:40:17','2024-07-12 12:57:59',1),(14,3,'/uploads/files-1720615217591-308801332-1','2024-07-10 12:40:17','2024-07-12 12:57:59',1),(15,3,'/uploads/files-1720615217592-731738307-1','2024-07-10 12:40:17','2024-07-12 12:57:59',1),(16,3,'/uploads/files-1720615217596-517255955-1','2024-07-10 12:40:17','2024-07-12 12:57:59',1),(17,4,'/uploads/files-1720615339972-95823163-1','2024-07-10 12:42:20',NULL,0),(18,4,'/uploads/files-1720615339977-670547209-1','2024-07-10 12:42:20',NULL,0),(19,4,'/uploads/files-1720615339978-455747816-1','2024-07-10 12:42:20',NULL,0),(20,4,'/uploads/files-1720615339982-783910524-1','2024-07-10 12:42:20',NULL,0),(21,4,'/uploads/files-1720615339983-324927918-1','2024-07-10 12:42:20',NULL,0),(22,5,'/uploads/files-1720792229942-873527889-1','2024-07-12 13:50:29',NULL,0),(23,5,'/uploads/files-1720792229943-591355661-1','2024-07-12 13:50:29',NULL,0),(24,5,'/uploads/files-1720792229943-858718821-1','2024-07-12 13:50:29',NULL,0),(25,6,'/uploads/files-1720792423510-425230995-1','2024-07-12 13:53:43','2024-07-12 14:02:50',1),(26,6,'/uploads/files-1720792423510-742872242-1','2024-07-12 13:53:43','2024-07-12 14:02:50',1),(27,6,'/uploads/files-1720792423511-628405386-1','2024-07-12 13:53:43','2024-07-12 14:02:50',1),(28,6,'/uploads/files-1720792423511-493056223-1','2024-07-12 13:53:43','2024-07-12 14:02:50',1),(29,7,'/uploads/files-1720792423511-904966023-2','2024-07-12 13:53:43','2024-07-12 14:02:50',1),(30,7,'/uploads/files-1720792423512-354279132-2','2024-07-12 13:53:43','2024-07-12 14:02:50',1),(31,7,'/uploads/files-1720792423516-231148782-2','2024-07-12 13:53:43','2024-07-12 14:02:50',1),(32,7,'/uploads/files-1720792423517-943737336-2','2024-07-12 13:53:43','2024-07-12 14:02:50',1);
/*!40000 ALTER TABLE `job_category_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `job_id` int NOT NULL AUTO_INCREMENT,
  `property_id` int NOT NULL,
  `contractor_id` int DEFAULT NULL,
  `owner_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`job_id`),
  KEY `contractor_id` (`contractor_id`),
  KEY `owner_id` (`owner_id`),
  KEY `property_id` (`property_id`),
  CONSTRAINT `jobs_ibfk_1` FOREIGN KEY (`contractor_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE,
  CONSTRAINT `jobs_ibfk_2` FOREIGN KEY (`owner_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE,
  CONSTRAINT `jobs_ibfk_3` FOREIGN KEY (`property_id`) REFERENCES `properties` (`property_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` VALUES (16,1,2,1,'2024-07-10 11:43:52','2024-07-12 09:40:01',1),(17,2,2,1,'2024-07-10 12:40:17','2024-07-12 12:57:59',1),(18,3,4,1,'2024-07-10 12:42:20',NULL,0),(19,1,NULL,1,'2024-07-12 13:50:29',NULL,0),(20,4,5,6,'2024-07-12 13:53:43','2024-07-12 14:02:50',1);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs_categories`
--

DROP TABLE IF EXISTS `jobs_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs_categories` (
  `job_category_id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`job_category_id`),
  KEY `job_id` (`job_id`),
  CONSTRAINT `jobs_categories_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs_categories`
--

LOCK TABLES `jobs_categories` WRITE;
/*!40000 ALTER TABLE `jobs_categories` DISABLE KEYS */;
INSERT INTO `jobs_categories` VALUES (1,16,'Flooring','I want to do flooring on all the 12 floors','2024-07-10 11:43:52','2024-07-12 09:40:01',1),(2,16,'Electricity','Electricity Work to be done in each flat , lift and floor','2024-07-10 11:43:52','2024-07-12 09:40:01',1),(3,17,'fbghdfhbfghb','zdxfgdhfghnghn','2024-07-10 12:40:17','2024-07-12 12:57:59',1),(4,18,'dfgfdghfgh','xfbhgvxbn ghgfhgf gthghngf','2024-07-10 12:42:20',NULL,0),(5,19,'Painting','I want to do painting work in the entire building','2024-07-12 13:50:29',NULL,0),(6,20,'Flooring','sdvfdfv fbgfhfghn ','2024-07-12 13:53:43','2024-07-12 14:02:50',1),(7,20,'Electricity','xcvvhbfg ghjhukujhk','2024-07-12 13:53:43','2024-07-12 14:02:50',1);
/*!40000 ALTER TABLE `jobs_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `messages` (
  `message_id` int NOT NULL AUTO_INCREMENT,
  `sender_id` int NOT NULL,
  `receiver_id` int NOT NULL,
  `job_id` int NOT NULL,
  `message` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`message_id`),
  KEY `sender_id` (`sender_id`),
  KEY `receiver_id` (`receiver_id`),
  KEY `job_id` (`job_id`),
  CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE,
  CONSTRAINT `messages_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE,
  CONSTRAINT `messages_ibfk_3` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,2,1,18,'I Kajal I want to know more details about the property','2024-07-11 08:22:48',NULL,0),(2,2,1,18,'hey!','2024-07-11 08:30:11',NULL,0),(3,2,1,18,'Answe please so that Ican proceed','2024-07-11 08:30:59',NULL,0),(4,2,1,18,'please answer','2024-07-11 08:32:01',NULL,0),(5,2,1,18,'sdfvsdvdf','2024-07-11 08:33:06',NULL,0),(6,3,1,18,'Hii Kajal whatsup','2024-07-11 08:35:13',NULL,0),(7,3,1,18,'Hii what\'s going on','2024-07-11 08:35:58',NULL,0),(8,4,1,17,'Hii kajal',NULL,'2024-07-12 12:57:59',1),(9,4,1,17,'How are you?','2024-07-11 09:00:11','2024-07-12 12:57:59',1),(10,4,1,18,'dxvvbffbcvb','2024-07-11 09:02:48',NULL,0),(11,1,2,18,'Suvarna I don\'t want to work with you','2024-07-11 10:43:01',NULL,0),(12,2,1,18,'shadsdhkaskh','2024-07-11 10:44:20',NULL,0),(13,1,2,18,'HII','2024-07-11 12:21:21',NULL,0),(14,1,2,18,'Heelo','2024-07-11 12:25:59',NULL,0),(15,2,1,18,'I am good what about you','2024-07-11 12:47:59',NULL,0),(16,1,2,18,'Fine','2024-07-11 12:49:15',NULL,0),(17,1,2,18,'hii nhfgjh','2024-07-11 12:54:37',NULL,0),(18,1,2,18,'dfgbnghmjkmjhm kajal','2024-07-11 13:08:03',NULL,0),(19,2,1,18,'xcvghnbghfjnghkmjh,k,l suvarna','2024-07-11 13:09:32',NULL,0),(20,1,2,18,'jiiiiiiiiiiiiiiiiiiiiiiiiii','2024-07-11 13:14:59',NULL,0),(21,1,2,18,'herrgdfgb','2024-07-11 13:16:43',NULL,0),(22,1,2,18,'dfgdfhbfgbnhbg ','2024-07-11 13:36:44',NULL,0),(23,1,4,17,'dfgdfgdfgdfbgdf','2024-07-11 13:42:35','2024-07-12 12:57:59',1),(24,1,4,17,'vbcb dfgfg ','2024-07-11 13:42:57','2024-07-12 12:57:59',1),(25,4,1,17,'I am fine','2024-07-11 13:45:24','2024-07-12 12:57:59',1),(26,1,4,17,'dxfvfgdfgfgfb','2024-07-11 13:46:55','2024-07-12 12:57:59',1),(27,4,1,17,'cfgfhhjhgj','2024-07-11 13:51:17','2024-07-12 12:57:59',1),(28,1,4,17,'dfghdfhfgjbhn','2024-07-12 05:14:22','2024-07-12 12:57:59',1),(29,2,1,17,'Hello Kajal','2024-07-12 09:47:49','2024-07-12 12:57:59',1),(30,1,2,17,'hii suvarna','2024-07-12 09:50:17','2024-07-12 12:57:59',1),(31,2,1,17,'How are you','2024-07-12 09:55:09','2024-07-12 12:57:59',1),(32,2,1,17,'I am fine what about you','2024-07-12 09:55:55','2024-07-12 12:57:59',1),(33,5,6,20,'hii visha','2024-07-12 13:55:33','2024-07-12 14:02:50',1),(34,6,5,20,'hello','2024-07-12 13:55:55','2024-07-12 14:02:50',1);
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `owner_state`
--

DROP TABLE IF EXISTS `owner_state`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `owner_state` (
  `owner_state_id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `owner_id` int NOT NULL,
  `state` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`owner_state_id`),
  KEY `job_id` (`job_id`),
  KEY `owner_id` (`owner_id`),
  CONSTRAINT `owner_state_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`) ON DELETE CASCADE,
  CONSTRAINT `owner_state_ibfk_2` FOREIGN KEY (`owner_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owner_state`
--

LOCK TABLES `owner_state` WRITE;
/*!40000 ALTER TABLE `owner_state` DISABLE KEYS */;
INSERT INTO `owner_state` VALUES (1,16,1,1,'2024-07-10 11:43:52','2024-07-12 09:40:01',1),(2,17,1,1,'2024-07-10 12:40:17','2024-07-12 12:57:59',1),(3,18,1,1,'2024-07-10 12:42:20',NULL,0),(4,19,1,0,'2024-07-12 13:50:29',NULL,0),(5,20,6,1,'2024-07-12 13:53:43','2024-07-12 14:02:50',1);
/*!40000 ALTER TABLE `owner_state` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payments`
--

DROP TABLE IF EXISTS `payments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `payments` (
  `payment_id` int NOT NULL AUTO_INCREMENT,
  `job_id` int NOT NULL,
  `session_id` varchar(255) NOT NULL,
  `amount` double NOT NULL,
  `status` tinyint(1) DEFAULT '0',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`payment_id`),
  KEY `job_id` (`job_id`),
  CONSTRAINT `payments_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payments`
--

LOCK TABLES `payments` WRITE;
/*!40000 ALTER TABLE `payments` DISABLE KEYS */;
INSERT INTO `payments` VALUES (5,16,'cs_test_a1NTSf8aRW30KIkYpdOAwcBHJHBUOzRsUDsAmF2H96epkCs7f1X8dm3Vob',700000,1,'2024-07-12 09:39:08',NULL,0),(6,17,'cs_test_a1LuzuK4cxqB17QD8dhuGZjqc3EJY5VNMOqVqypMF7MSEbxJxfZgPfWVLh',2000,1,'2024-07-12 12:56:55',NULL,0),(7,20,'cs_test_a1PIqNvapFNGrgi81ffTQj8hDZDf9s4RvDF84cUg5vmSGZ4QJKD1O70gj8',20000,1,'2024-07-12 14:02:01',NULL,0);
/*!40000 ALTER TABLE `payments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `properties`
--

DROP TABLE IF EXISTS `properties`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `properties` (
  `property_id` int NOT NULL AUTO_INCREMENT,
  `property_name` varchar(255) NOT NULL,
  `property_address` varchar(255) NOT NULL,
  `owner_id` int NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`property_id`),
  KEY `owner_id` (`owner_id`),
  CONSTRAINT `properties_ibfk_1` FOREIGN KEY (`owner_id`) REFERENCES `users` (`u_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `properties`
--

LOCK TABLES `properties` WRITE;
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` VALUES (1,'Silver radiance','Ahmedabad science city',1,'2024-07-10 11:42:17',NULL,0),(2,'dcvgfgbbv','fdghbfhbgnh',1,'2024-07-10 12:40:03',NULL,0),(3,'dfghbfhfgh','cvgbnvnvbnb',1,'2024-07-10 12:42:02',NULL,0),(4,'SILVER rADIANCE','CXVBCBNVB VBNVGHKMJHBN ',6,'2024-07-12 13:52:31',NULL,0);
/*!40000 ALTER TABLE `properties` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `u_id` int NOT NULL AUTO_INCREMENT,
  `u_name` varchar(255) DEFAULT NULL,
  `u_email` varchar(255) DEFAULT NULL,
  `u_contact` bigint DEFAULT NULL,
  `u_address` text,
  `u_password` varchar(255) DEFAULT NULL,
  `u_role` tinyint(1) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Kajal','kajal@gmail.com',1234567890,'asdfv fdgf fdgdfg','$2b$10$yq9s7sqGth.GRxkyfsWVeOspeLaCk5VnOl31v5jE.SohmrV.viOPG',0,'2024-07-05 08:38:05',NULL,0),(2,'Suvarna','suvarna@gmail.com',1234567890,'xdgtgh hyjhy j hj','$2b$10$VBM0cPYuJGdHxlWeLqMSDuXIeX4WGWg5FQzoYCG0T2Bnf7kHDy3ya',1,'2024-07-06 11:20:00',NULL,0),(3,'Karishma','karishma@gmail.com',1234567890,'Star city','$2b$10$s6XusvDVSk019mHR6KfLZeut1RLH8uvpKTGlqo.uOxrI8qoRHfKRq',1,'2024-07-10 12:45:33',NULL,0),(4,'Abhay','abhay@gmail.com',1234567890,'asfsdfg fghj yhjyhj jmjmj','$2b$10$dFE1ITx2OMvRwmGpjrz5vuTun1rYOVDKDSO5snLQghn30YoejK772',1,'2024-07-11 08:36:57',NULL,0),(5,'Harshika','harshi@gmail.com',1234567890,'sdgfg njhhjk hjkkj','$2b$10$SyvznEWQ/3Nx2h26RLDsk.ZY6yCJNefuiK7PsSiPYzIhgHNmg.eWq',1,'2024-07-12 13:11:57',NULL,0),(6,'Visha','visha@gmail.com',1234567890,'sdfgfhnghm','$2b$10$DRZ1PqtjHyGm7noQI7lLQenAq.ZXPMGzkUiYr2C1Ylsb9sRtijKuW',0,'2024-07-12 13:51:52',NULL,0);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_proof_images`
--

DROP TABLE IF EXISTS `work_proof_images`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_proof_images` (
  `work_image_id` int NOT NULL AUTO_INCREMENT,
  `work_proof_id` int NOT NULL,
  `image` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`work_image_id`),
  KEY `work_proof_id` (`work_proof_id`),
  CONSTRAINT `work_proof_images_ibfk_1` FOREIGN KEY (`work_proof_id`) REFERENCES `work_proofs` (`work_proof_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_proof_images`
--

LOCK TABLES `work_proof_images` WRITE;
/*!40000 ALTER TABLE `work_proof_images` DISABLE KEYS */;
INSERT INTO `work_proof_images` VALUES (1,1,'/uploads/files-1720679258484-960678371-testimonials-img.png','2024-07-11 06:27:38','2024-07-12 09:40:01',1),(2,1,'/uploads/files-1720679258488-840373317-Line 4.png','2024-07-11 06:27:38','2024-07-12 09:40:01',1),(3,1,'/uploads/files-1720679258488-652014555-image-fBLQvAFN1-transformed 1.png','2024-07-11 06:27:38','2024-07-12 09:40:01',1),(4,1,'/uploads/files-1720679258489-791610328-image 6 (Traced).png','2024-07-11 06:27:38','2024-07-12 09:40:01',1),(5,1,'/uploads/files-1720679258489-695407136-image 2 (Traced).png','2024-07-11 06:27:38','2024-07-12 09:40:01',1),(6,1,'/uploads/files-1720679258490-184659284-image 1 (Traced).png','2024-07-11 06:27:38','2024-07-12 09:40:01',1),(7,1,'/uploads/files-1720679258490-779423637-HireX_black.png','2024-07-11 06:27:38','2024-07-12 09:40:01',1),(8,1,'/uploads/files-1720679258490-27304760-Group 59.png','2024-07-11 06:27:38','2024-07-12 09:40:01',1),(9,2,'/uploads/files-1720785686674-375588021-arrow-left-2.png','2024-07-12 12:01:26','2024-07-12 12:57:59',1),(10,2,'/uploads/files-1720785686675-43386168-Fortnite_Two Color 1.png','2024-07-12 12:01:26','2024-07-12 12:57:59',1),(11,2,'/uploads/files-1720785686675-137909804-Group 6.png','2024-07-12 12:01:26','2024-07-12 12:57:59',1),(12,2,'/uploads/files-1720785686675-993539433-Group 59.png','2024-07-12 12:01:26','2024-07-12 12:57:59',1),(13,3,'/uploads/files-1720792799132-976662301-arrow-left-2.png','2024-07-12 13:59:59','2024-07-12 14:02:50',1),(14,3,'/uploads/files-1720792799132-797475908-Screenshot from 2024-04-19 18-54-00.png','2024-07-12 13:59:59','2024-07-12 14:02:50',1),(15,3,'/uploads/files-1720792799139-994499181-Screenshot from 2024-04-19 18-54-06.png','2024-07-12 13:59:59','2024-07-12 14:02:50',1),(16,4,'/uploads/files-1720792820524-444417150-arrow-left-2.png','2024-07-12 14:00:20','2024-07-12 14:02:50',1),(17,4,'/uploads/files-1720792820524-999133282-Group 59.png','2024-07-12 14:00:20','2024-07-12 14:02:50',1),(18,4,'/uploads/files-1720792820525-963189777-HireX_black.png','2024-07-12 14:00:20','2024-07-12 14:02:50',1);
/*!40000 ALTER TABLE `work_proof_images` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `work_proofs`
--

DROP TABLE IF EXISTS `work_proofs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `work_proofs` (
  `work_proof_id` int NOT NULL AUTO_INCREMENT,
  `job_category_id` int DEFAULT NULL,
  `job_id` int NOT NULL,
  `description` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `isDeleted` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`work_proof_id`),
  KEY `job_category_id` (`job_category_id`),
  KEY `job_id` (`job_id`),
  CONSTRAINT `work_proofs_ibfk_1` FOREIGN KEY (`job_category_id`) REFERENCES `jobs_categories` (`job_category_id`) ON DELETE CASCADE,
  CONSTRAINT `work_proofs_ibfk_2` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_proofs`
--

LOCK TABLES `work_proofs` WRITE;
/*!40000 ALTER TABLE `work_proofs` DISABLE KEYS */;
INSERT INTO `work_proofs` VALUES (1,1,16,'xcvxcv fdgfdg dfg','2024-07-11 06:27:38','2024-07-12 09:40:01',1),(2,3,17,'sdgdfhfghngfhnfghn','2024-07-12 12:01:26','2024-07-12 12:57:59',1),(3,6,20,'sdfdsfdfgdfg','2024-07-12 13:59:59','2024-07-12 14:02:50',1),(4,7,20,'cvbcvbc','2024-07-12 14:00:20','2024-07-12 14:02:50',1);
/*!40000 ALTER TABLE `work_proofs` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-12 19:47:59
