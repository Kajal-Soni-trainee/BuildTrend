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
  PRIMARY KEY (`comment_id`),
  KEY `work_proof_id` (`work_proof_id`),
  CONSTRAINT `comments_ibfk_1` FOREIGN KEY (`work_proof_id`) REFERENCES `work_proofs` (`work_proof_id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `comments`
--

LOCK TABLES `comments` WRITE;
/*!40000 ALTER TABLE `comments` DISABLE KEYS */;
INSERT INTO `comments` VALUES (1,1,'I am not satisfied by your work','2024-07-09 12:23:56',NULL,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contractor_state`
--

LOCK TABLES `contractor_state` WRITE;
/*!40000 ALTER TABLE `contractor_state` DISABLE KEYS */;
INSERT INTO `contractor_state` VALUES (1,8,0,'2024-07-08 12:22:08',NULL,0,0),(2,9,2,'2024-07-08 12:38:38',NULL,0,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estimates`
--

LOCK TABLES `estimates` WRITE;
/*!40000 ALTER TABLE `estimates` DISABLE KEYS */;
INSERT INTO `estimates` VALUES (1,8,2,200000,'2024-07-08 05:42:40',NULL,0),(2,9,2,30000,'2024-07-08 12:37:26',NULL,0);
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
  KEY `job_category_id` (`job_category_id`),
  CONSTRAINT `job_category_images_ibfk_1` FOREIGN KEY (`job_category_id`) REFERENCES `jobs_categories` (`job_category_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_category_images`
--

LOCK TABLES `job_category_images` WRITE;
/*!40000 ALTER TABLE `job_category_images` DISABLE KEYS */;
INSERT INTO `job_category_images` VALUES (1,1,'/uploads/files-1720261086582-877597464-1','2024-07-06 10:18:06',NULL,0),(2,2,'/uploads/files-1720442135565-703106011-1','2024-07-08 12:35:35',NULL,0),(3,3,'/uploads/files-1720442135572-161155321-2','2024-07-08 12:35:35',NULL,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` VALUES (8,2,2,1,'2024-07-06 10:18:06',NULL,0),(9,2,2,1,'2024-07-08 12:35:35',NULL,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs_categories`
--

LOCK TABLES `jobs_categories` WRITE;
/*!40000 ALTER TABLE `jobs_categories` DISABLE KEYS */;
INSERT INTO `jobs_categories` VALUES (1,8,'vbncvgbn','cvbcvcvb','2024-07-06 10:18:06',NULL,0),(2,9,'sdgdfbhfgb','dxfdggbh','2024-07-08 12:35:35',NULL,0),(3,9,'xcbdfbg','dfgdfgfghb','2024-07-08 12:35:35',NULL,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
INSERT INTO `messages` VALUES (1,2,1,8,'By when are expecting it to complete','2024-07-08 07:22:37',NULL,0),(2,2,1,9,'Hii can we set a meeting','2024-07-08 12:54:46',NULL,0),(3,2,1,9,'xcgbgnhm ','2024-07-08 12:57:04',NULL,0),(4,2,1,9,'xcvgcvbhgnbghnghn','2024-07-08 13:04:06',NULL,0),(5,1,2,8,'xcvcbvbnbgn ','2024-07-09 05:36:15',NULL,0),(6,1,2,8,'dfhfgjgjkj ','2024-07-09 06:05:15',NULL,0);
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
  CONSTRAINT `owner_state_ibfk_1` FOREIGN KEY (`job_id`) REFERENCES `jobs` (`job_id`),
  CONSTRAINT `owner_state_ibfk_2` FOREIGN KEY (`owner_id`) REFERENCES `users` (`u_id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `owner_state`
--

LOCK TABLES `owner_state` WRITE;
/*!40000 ALTER TABLE `owner_state` DISABLE KEYS */;
INSERT INTO `owner_state` VALUES (7,8,1,2,'2024-07-06 10:18:06',NULL,0),(8,9,1,2,'2024-07-08 12:35:35',NULL,0);
/*!40000 ALTER TABLE `owner_state` ENABLE KEYS */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `properties`
--

LOCK TABLES `properties` WRITE;
/*!40000 ALTER TABLE `properties` DISABLE KEYS */;
INSERT INTO `properties` VALUES (2,'City Center 2','Science City Approach ,  near shukan mall ,Ahmedabad',1,'2024-07-05 12:15:14',NULL,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Kajal','kajal@gmail.com',1234567890,'asdfv fdgf fdgdfg','$2b$10$yq9s7sqGth.GRxkyfsWVeOspeLaCk5VnOl31v5jE.SohmrV.viOPG',0,'2024-07-05 08:38:05',NULL,0),(2,'Suvarna','suvarna@gmail.com',1234567890,'xdgtgh hyjhy j hj','$2b$10$VBM0cPYuJGdHxlWeLqMSDuXIeX4WGWg5FQzoYCG0T2Bnf7kHDy3ya',1,'2024-07-06 11:20:00',NULL,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_proof_images`
--

LOCK TABLES `work_proof_images` WRITE;
/*!40000 ALTER TABLE `work_proof_images` DISABLE KEYS */;
INSERT INTO `work_proof_images` VALUES (1,1,'/uploads/files-1720522294096-892481883-testimonials-img.png','2024-07-09 10:51:34',NULL,0);
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `work_proofs`
--

LOCK TABLES `work_proofs` WRITE;
/*!40000 ALTER TABLE `work_proofs` DISABLE KEYS */;
INSERT INTO `work_proofs` VALUES (1,1,9,'fgdfgdfgbn g hbv','2024-07-09 10:51:34',NULL,0);
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

-- Dump completed on 2024-07-09 19:16:51
