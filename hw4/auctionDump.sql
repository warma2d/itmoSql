-- MySQL dump 10.13  Distrib 8.0.16, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: auction
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

CREATE DATABASE `auction2` CHARACTER SET utf8 COLLATE utf8_general_ci;
USE auction2;

--
-- Table structure for table `auction`
--

DROP TABLE IF EXISTS `auction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `auction` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `datetime` datetime NOT NULL,
  `specifics` text NOT NULL,
  `place_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_auction_place_idx` (`place_id`),
  CONSTRAINT `fk_auction_place` FOREIGN KEY (`place_id`) REFERENCES `place` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auction`
--

LOCK TABLES `auction` WRITE;
/*!40000 ALTER TABLE `auction` DISABLE KEYS */;
INSERT INTO `auction` VALUES (1,'2019-05-23 18:40:00','Выставляются на продажу картины великих мировых художников',1),(2,'2019-05-10 12:00:00','Московский аукцион',2),(3,'2019-06-25 13:00:00','Июньский аукцион',2);
/*!40000 ALTER TABLE `auction` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item`
--

DROP TABLE IF EXISTS `item`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `description` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item`
--

LOCK TABLES `item` WRITE;
/*!40000 ALTER TABLE `item` DISABLE KEYS */;
INSERT INTO `item` VALUES (1,'«Мона Лиза».  Леонардо да Винчи 1503–1506'),(2,'«Рождение Венеры».  Сандро Боттичелли 1482 — 1486'),(3,'«Сотворение Адама». Микеланджело 1511'),(4,'«Утро в сосновом лесу». Иван Шишкин, Константин Савицкий 1889'),(5,'«Девочка на шаре». Пабло Пикассо 1905'),(6,'Системный блок'),(7,'Мышь'),(8,'Клавиатура'),(9,'Гантель 10кг');
/*!40000 ALTER TABLE `item` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lot`
--

DROP TABLE IF EXISTS `lot`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `lot` (
  `seller_id` int(11) NOT NULL,
  `start_price` decimal(12,2) NOT NULL,
  `final_price` decimal(12,2) NOT NULL DEFAULT '0.00',
  `customer_id` int(11) DEFAULT '0',
  `item_id` int(11) NOT NULL,
  `auction_id` int(11) NOT NULL,
  `lot_id` int(11) NOT NULL,
  UNIQUE KEY `composite` (`auction_id`,`lot_id`),
  KEY `fk_lot_auction1_idx` (`auction_id`),
  KEY `fk_lot_item1_idx` (`item_id`),
  KEY `fk_lot_man1_idx` (`seller_id`),
  KEY `fk_lot_man2_idx` (`customer_id`) /*!80000 INVISIBLE */,
  CONSTRAINT `fk_lot_auction1` FOREIGN KEY (`auction_id`) REFERENCES `auction` (`id`),
  CONSTRAINT `fk_lot_item1` FOREIGN KEY (`item_id`) REFERENCES `item` (`id`),
  CONSTRAINT `fk_lot_man1` FOREIGN KEY (`seller_id`) REFERENCES `man` (`id`),
  CONSTRAINT `fk_lot_man2` FOREIGN KEY (`customer_id`) REFERENCES `man` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lot`
--

LOCK TABLES `lot` WRITE;
/*!40000 ALTER TABLE `lot` DISABLE KEYS */;
INSERT INTO `lot` VALUES (1,30000.00,0.00,0,1,1,1),(1,40000.00,0.00,0,2,1,2),(1,70000.00,0.00,0,3,1,3),(2,10000.00,0.00,0,4,1,4),(2,20000.00,0.00,0,5,1,5),(2,500.00,70000.00,1,6,2,1),(2,1.00,50.00,1,7,2,2),(2,3.00,0.00,0,8,2,3),(2,20.00,0.00,0,9,2,4);
/*!40000 ALTER TABLE `lot` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `man`
--

DROP TABLE IF EXISTS `man`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `man` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `firstname` varchar(200) NOT NULL,
  `lastname` varchar(200) NOT NULL,
  `patronymic` varchar(200) NOT NULL,
  `role_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_man_role1_idx` (`role_id`),
  CONSTRAINT `fk_man_role1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `man`
--

LOCK TABLES `man` WRITE;
/*!40000 ALTER TABLE `man` DISABLE KEYS */;
INSERT INTO `man` VALUES (0,'Неопределенный человек','Неопределенный человек','Неопределенный человек',1),(1,'Василий','Продажник','Петрович',1),(2,'Куст','Покупакин','Игорьевич',2);
/*!40000 ALTER TABLE `man` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `place`
--

DROP TABLE IF EXISTS `place`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `place` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `place`
--

LOCK TABLES `place` WRITE;
/*!40000 ALTER TABLE `place` DISABLE KEYS */;
INSERT INTO `place` VALUES (1,'Санкт-Петербург'),(2,'Москва');
/*!40000 ALTER TABLE `place` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(200) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES (1,'Продавец'),(2,'Покупатель');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-05-23 14:21:12
