-- MySQL dump 10.13  Distrib 5.6.46, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: bank
-- ------------------------------------------------------
-- Server version	5.6.46

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `additionals`
--

DROP TABLE IF EXISTS `additionals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `additionals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountBalanceHistory` varchar(20000) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0,0',
  `incomingTransfersSum` decimal(13,2) NOT NULL DEFAULT '0.00',
  `outgoingTransfersSum` decimal(13,2) NOT NULL DEFAULT '0.00',
  `notificationStatus` tinyint(4) NOT NULL DEFAULT '0',
  `notificationCount` int(11) NOT NULL DEFAULT '0',
  `messageStatus` tinyint(4) NOT NULL DEFAULT '0',
  `messageCount` int(11) NOT NULL DEFAULT '0',
  `userId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_395a712f49f282606dbf0248b41` (`userId`),
  CONSTRAINT `FK_395a712f49f282606dbf0248b41` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `bills` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `accountBill` varchar(26) COLLATE utf8_unicode_ci NOT NULL,
  `availableFunds` decimal(13,2) NOT NULL DEFAULT '0.00',
  `userId` int(11) NOT NULL,
  `currencyId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_92b523430784927e27123e1eb2` (`accountBill`),
  KEY `FK_dd941796f5112bc83a7bf499f86` (`userId`),
  KEY `FK_55d8af4f7e9e151110493f1c132` (`currencyId`),
  CONSTRAINT `FK_55d8af4f7e9e151110493f1c132` FOREIGN KEY (`currencyId`) REFERENCES `currency` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_dd941796f5112bc83a7bf499f86` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `config`
--

DROP TABLE IF EXISTS `config`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `config` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `currency`
--

DROP TABLE IF EXISTS `currency`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `currency` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `exchangeRate` double NOT NULL DEFAULT '1',
  `exchangeRateSyncDate` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `main` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `languages`
--

DROP TABLE IF EXISTS `languages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `languages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `code` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_7397752718d1c9eb873722ec9b` (`code`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createdDate` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `nameId` int(11) NOT NULL,
  `senderId` int(11) NOT NULL,
  `recipientId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_7ea999ff2512853502817f5f55b` (`nameId`),
  KEY `FK_2db9cf2b3ca111742793f6c37ce` (`senderId`),
  KEY `FK_f548818d46a1315d4e1d5e62da5` (`recipientId`),
  CONSTRAINT `FK_2db9cf2b3ca111742793f6c37ce` FOREIGN KEY (`senderId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_7ea999ff2512853502817f5f55b` FOREIGN KEY (`nameId`) REFERENCES `config` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_f548818d46a1315d4e1d5e62da5` FOREIGN KEY (`recipientId`) REFERENCES `users` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `templates`
--

DROP TABLE IF EXISTS `templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `content` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `actions` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `nameId` int(11) NOT NULL,
  `languageId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_783c1f23cec96c8227c5773e317` (`nameId`),
  KEY `FK_e5a78c3c1886d60cc7905a044a1` (`languageId`),
  CONSTRAINT `FK_783c1f23cec96c8227c5773e317` FOREIGN KEY (`nameId`) REFERENCES `config` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_e5a78c3c1886d60cc7905a044a1` FOREIGN KEY (`languageId`) REFERENCES `languages` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `transactions`
--

DROP TABLE IF EXISTS `transactions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transactions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `createdDate` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `amountMoney` decimal(13,2) NOT NULL DEFAULT '0.00',
  `transferTitle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `authorizationKey` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `authorizationStatus` tinyint(4) NOT NULL DEFAULT '0',
  `senderId` int(11) NOT NULL,
  `recipientId` int(11) NOT NULL,
  `currencyId` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_3ba3c7d2c3c63436e2ccceef807` (`senderId`),
  KEY `FK_027bc0e7f0e511822fd3019859f` (`recipientId`),
  KEY `FK_89de751d3265e411a089b8e407f` (`currencyId`),
  CONSTRAINT `FK_027bc0e7f0e511822fd3019859f` FOREIGN KEY (`recipientId`) REFERENCES `bills` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_3ba3c7d2c3c63436e2ccceef807` FOREIGN KEY (`senderId`) REFERENCES `bills` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_89de751d3265e411a089b8e407f` FOREIGN KEY (`currencyId`) REFERENCES `currency` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `surname` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `login` bigint(20) NOT NULL,
  `password` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `createdDate` datetime(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
  `lastPresentLoggedDate` datetime DEFAULT NULL,
  `lastSuccessfulLoggedDate` datetime DEFAULT NULL,
  `lastFailedLoggedDate` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `IDX_4d217bc91b1ecf421818520ca1` (`email`,`login`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

