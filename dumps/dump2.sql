-- MySQL dump 10.13  Distrib 5.5.47, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: scorepoint
-- ------------------------------------------------------
-- Server version	5.5.47-0ubuntu0.14.04.1

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

DROP DATABASE IF EXISTS scorepoint;
CREATE DATABASE scorepoint;

use scorepoint;

--
-- Table structure for table `ACL`
--

DROP TABLE IF EXISTS `ACL`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACL` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `model` varchar(512) DEFAULT NULL,
  `property` varchar(512) DEFAULT NULL,
  `accessType` varchar(512) DEFAULT NULL,
  `permission` varchar(512) DEFAULT NULL,
  `principalType` varchar(512) DEFAULT NULL,
  `principalId` varchar(512) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACL`
--

LOCK TABLES `ACL` WRITE;
/*!40000 ALTER TABLE `ACL` DISABLE KEYS */;
/*!40000 ALTER TABLE `ACL` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Role`
--

DROP TABLE IF EXISTS `Role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(512) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Role`
--

LOCK TABLES `Role` WRITE;
/*!40000 ALTER TABLE `Role` DISABLE KEYS */;
/*!40000 ALTER TABLE `Role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `RoleMapping`
--

DROP TABLE IF EXISTS `RoleMapping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RoleMapping` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `principalType` varchar(512) DEFAULT NULL,
  `principalId` varchar(512) DEFAULT NULL,
  `roleId` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_RoleMapping_Role1_idx` (`roleId`),
  CONSTRAINT `fk_RoleMapping_Role1` FOREIGN KEY (`roleId`) REFERENCES `Role` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RoleMapping`
--

LOCK TABLES `RoleMapping` WRITE;
/*!40000 ALTER TABLE `RoleMapping` DISABLE KEYS */;
/*!40000 ALTER TABLE `RoleMapping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accessToken`
--

DROP TABLE IF EXISTS `accessToken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `accessToken` (
  `id` varchar(255) NOT NULL,
  `ttl` int(11) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `userid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_accessToken_user1_idx` (`userid`),
  CONSTRAINT `fk_accessToken_user1` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accessToken`
--

LOCK TABLES `accessToken` WRITE;
/*!40000 ALTER TABLE `accessToken` DISABLE KEYS */;
INSERT INTO `accessToken` VALUES ('2v18M1YN1bGGLggemljwrESG5xLYzraTirFH5YQUgLcGIKTzHPD7pLFr4UBirHO2',1209600,'2016-05-13 00:14:01',1),('NqvQJDbDCMVqhSLdh88T8omoCPASbJo8LGqWUK7ZXesI9rpuQJdmrbDyDQyTIF1p',1209600,'2016-05-13 01:00:48',2),('QTDWSaJrT0qakksfaQmrSCeqGebgOzMecziz0asluFEggyu8K2orD9Gi7ieOROZc',1209600,'2016-05-19 21:59:08',3);
/*!40000 ALTER TABLE `accessToken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `challenge_request`
--

DROP TABLE IF EXISTS `challenge_request`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `challenge_request` (
  `challenge_requestid` int(11) NOT NULL AUTO_INCREMENT,
  `challenger_id` int(11) NOT NULL COMMENT 'The team who is challenging to other ',
  `victim_id` int(11) NOT NULL COMMENT 'the victim will be destroyed',
  PRIMARY KEY (`challenge_requestid`),
  KEY `fk_challenge_request_team1_idx` (`challenger_id`),
  KEY `fk_challenge_request_team2_idx` (`victim_id`),
  CONSTRAINT `fk_challenge_request_team1` FOREIGN KEY (`challenger_id`) REFERENCES `team` (`idTeam`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_challenge_request_team2` FOREIGN KEY (`victim_id`) REFERENCES `team` (`idTeam`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `challenge_request`
--

LOCK TABLES `challenge_request` WRITE;
/*!40000 ALTER TABLE `challenge_request` DISABLE KEYS */;
INSERT INTO `challenge_request` VALUES (1,1,2);
/*!40000 ALTER TABLE `challenge_request` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `game`
--

DROP TABLE IF EXISTS `game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `game` (
  `gameId` int(11) NOT NULL AUTO_INCREMENT,
  `order` int(11) DEFAULT NULL,
  `idmatch` int(11) NOT NULL,
  `teamWinnerId` int(11) DEFAULT NULL,
  PRIMARY KEY (`gameId`),
  KEY `fk_set_match1_idx` (`idmatch`),
  KEY `fk_set_team1_idx` (`teamWinnerId`),
  CONSTRAINT `fk_set_match1` FOREIGN KEY (`idmatch`) REFERENCES `match` (`idmatch`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_set_team1` FOREIGN KEY (`teamWinnerId`) REFERENCES `team` (`idTeam`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `game`
--

LOCK TABLES `game` WRITE;
/*!40000 ALTER TABLE `game` DISABLE KEYS */;
INSERT INTO `game` VALUES (1,1,1,1),(2,2,1,2),(3,3,1,1);
/*!40000 ALTER TABLE `game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lobby`
--

DROP TABLE IF EXISTS `lobby`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lobby` (
  `lobbyId` int(11) NOT NULL AUTO_INCREMENT,
  `active` bit(1) NOT NULL DEFAULT b'1' COMMENT 'The User Team table enable to support a team',
  `created` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `tournament_tournamentId` int(11) DEFAULT NULL,
  PRIMARY KEY (`lobbyId`),
  KEY `fk_game_tournament1_idx` (`tournament_tournamentId`),
  CONSTRAINT `fk_game_tournament1` FOREIGN KEY (`tournament_tournamentId`) REFERENCES `tournament` (`tournamentId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lobby`
--

LOCK TABLES `lobby` WRITE;
/*!40000 ALTER TABLE `lobby` DISABLE KEYS */;
INSERT INTO `lobby` VALUES (1,'\0','0000-00-00 00:00:00',1),(2,'','2016-05-13 01:03:26',1),(3,'\0','2016-05-19 17:16:00',1);
/*!40000 ALTER TABLE `lobby` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `match`
--

DROP TABLE IF EXISTS `match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `match` (
  `idmatch` int(11) NOT NULL AUTO_INCREMENT,
  `started` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `Lobby_lobbyId` int(11) NOT NULL,
  PRIMARY KEY (`idmatch`),
  KEY `fk_match_Lobby1_idx` (`Lobby_lobbyId`),
  CONSTRAINT `fk_match_Lobby1` FOREIGN KEY (`Lobby_lobbyId`) REFERENCES `lobby` (`lobbyId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `match`
--

LOCK TABLES `match` WRITE;
/*!40000 ALTER TABLE `match` DISABLE KEYS */;
INSERT INTO `match` VALUES (1,'0000-00-00 00:00:00',1),(2,'2016-05-19 15:50:26',1);
/*!40000 ALTER TABLE `match` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team`
--

DROP TABLE IF EXISTS `team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team` (
  `idTeam` int(11) NOT NULL AUTO_INCREMENT,
  `pair` bit(1) NOT NULL DEFAULT b'0' COMMENT 'the teams is of two people?',
  `active` bit(1) NOT NULL DEFAULT b'1',
  `lobbyId` int(11) NOT NULL,
  PRIMARY KEY (`idTeam`),
  KEY `fk_team_game1_idx` (`lobbyId`),
  CONSTRAINT `fk_team_game1` FOREIGN KEY (`lobbyId`) REFERENCES `lobby` (`lobbyId`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team`
--

LOCK TABLES `team` WRITE;
/*!40000 ALTER TABLE `team` DISABLE KEYS */;
INSERT INTO `team` VALUES (1,'\0','',1),(2,'\0','',1);
/*!40000 ALTER TABLE `team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teamRequest`
--

DROP TABLE IF EXISTS `teamRequest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teamRequest` (
  `idteamRequest` int(11) NOT NULL,
  `user_emiter` int(11) NOT NULL,
  `user_receptor` int(11) NOT NULL,
  `datetime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`idteamRequest`),
  KEY `fk_teamRequest_user1_idx` (`user_emiter`),
  KEY `fk_teamRequest_user2_idx` (`user_receptor`),
  CONSTRAINT `fk_teamRequest_user1` FOREIGN KEY (`user_emiter`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_teamRequest_user2` FOREIGN KEY (`user_receptor`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teamRequest`
--

LOCK TABLES `teamRequest` WRITE;
/*!40000 ALTER TABLE `teamRequest` DISABLE KEYS */;
/*!40000 ALTER TABLE `teamRequest` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `teamSetScore`
--

DROP TABLE IF EXISTS `teamSetScore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `teamSetScore` (
  `playerSetScroreId` int(11) NOT NULL AUTO_INCREMENT,
  `score` int(11) NOT NULL DEFAULT '0',
  `set_setId` int(11) NOT NULL,
  `team_idTeam` int(11) NOT NULL,
  PRIMARY KEY (`playerSetScroreId`),
  KEY `fk_teamSetScore_set1_idx` (`set_setId`),
  KEY `fk_teamSetScore_team1_idx` (`team_idTeam`),
  CONSTRAINT `fk_teamSetScore_set1` FOREIGN KEY (`set_setId`) REFERENCES `game` (`gameId`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_teamSetScore_team1` FOREIGN KEY (`team_idTeam`) REFERENCES `team` (`idTeam`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `teamSetScore`
--

LOCK TABLES `teamSetScore` WRITE;
/*!40000 ALTER TABLE `teamSetScore` DISABLE KEYS */;
INSERT INTO `teamSetScore` VALUES (1,11,1,1),(2,8,1,2),(3,5,2,1),(4,11,2,2),(5,13,3,1),(6,11,3,2);
/*!40000 ALTER TABLE `teamSetScore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `team_has_match`
--

DROP TABLE IF EXISTS `team_has_match`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `team_has_match` (
  `idTeam` int(11) NOT NULL,
  `idmatch` int(11) NOT NULL,
  PRIMARY KEY (`idTeam`,`idmatch`),
  KEY `fk_team_has_match_match1_idx` (`idmatch`),
  KEY `fk_team_has_match_team1_idx` (`idTeam`),
  CONSTRAINT `fk_team_has_match_match1` FOREIGN KEY (`idmatch`) REFERENCES `match` (`idmatch`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_team_has_match_team1` FOREIGN KEY (`idTeam`) REFERENCES `team` (`idTeam`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `team_has_match`
--

LOCK TABLES `team_has_match` WRITE;
/*!40000 ALTER TABLE `team_has_match` DISABLE KEYS */;
INSERT INTO `team_has_match` VALUES (1,1),(2,1);
/*!40000 ALTER TABLE `team_has_match` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tournament`
--

DROP TABLE IF EXISTS `tournament`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `tournament` (
  `tournamentId` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `startDate` date NOT NULL,
  `endDate` date DEFAULT NULL,
  `pointValue` int(11) NOT NULL,
  PRIMARY KEY (`tournamentId`),
  UNIQUE KEY `name_UNIQUE` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tournament`
--

LOCK TABLES `tournament` WRITE;
/*!40000 ALTER TABLE `tournament` DISABLE KEYS */;
INSERT INTO `tournament` VALUES (1,'test','0000-00-00','0000-00-00',0),(2,'','0000-00-00',NULL,0);
/*!40000 ALTER TABLE `tournament` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `realm` varchar(512) DEFAULT NULL,
  `username` varchar(512) DEFAULT NULL,
  `password` varchar(512) NOT NULL,
  `credentials` text,
  `challenges` text,
  `email` varchar(512) NOT NULL,
  `emailVerified` tinyint(1) DEFAULT NULL,
  `verificationToken` varchar(512) DEFAULT NULL,
  `status` varchar(512) DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  `lastUpdated` datetime DEFAULT NULL,
  `initialRank` int(11) DEFAULT '0',
  `imageUrl` varchar(255) DEFAULT NULL,
  `firstName` varchar(2555) DEFAULT NULL,
  `lastName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,NULL,'google-login.101574628529006305177','$2a$10$3L3GVBOleoJUsvbM3BzMi.uzDm1crlK9ltkDO0w3aTEwg7lSoxVum',NULL,NULL,'oscar.barba@ipointsystems.com',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(2,NULL,'google-login.109236467434292587693','$2a$10$RSZQkIDWPC/WmkVI7WmK2uBaGU8TQzIgzFf40OjDR7DJTlp.6XNb6',NULL,NULL,'adriana.gonzalez@ipointsystems.com',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL),(3,NULL,'google-login.108458095585172569466','$2a$10$3mAT8XsE9jHMucEBhHukb.yWJHuxJBn1oORrlpadr8DPA4vkZeVre',NULL,NULL,'oscarbarbaa@gmail.com',NULL,NULL,NULL,NULL,NULL,0,NULL,NULL,NULL);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userCredential`
--

DROP TABLE IF EXISTS `userCredential`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userCredential` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(512) DEFAULT NULL,
  `authScheme` varchar(512) DEFAULT NULL,
  `externalId` varchar(512) DEFAULT NULL,
  `profile` text,
  `credentials` text,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `userid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_userCredential_user1_idx` (`userid`),
  CONSTRAINT `fk_userCredential_user1` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userCredential`
--

LOCK TABLES `userCredential` WRITE;
/*!40000 ALTER TABLE `userCredential` DISABLE KEYS */;
/*!40000 ALTER TABLE `userCredential` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userIdentity`
--

DROP TABLE IF EXISTS `userIdentity`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userIdentity` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `provider` varchar(512) DEFAULT NULL,
  `authScheme` varchar(512) DEFAULT NULL,
  `externalId` varchar(512) DEFAULT NULL,
  `profile` text,
  `credentials` text,
  `created` datetime DEFAULT NULL,
  `modified` datetime DEFAULT NULL,
  `userid` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_userIdentity_user1_idx` (`userid`),
  CONSTRAINT `fk_userIdentity_user1` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userIdentity`
--

LOCK TABLES `userIdentity` WRITE;
/*!40000 ALTER TABLE `userIdentity` DISABLE KEYS */;
INSERT INTO `userIdentity` VALUES (1,'google-login','oAuth 2.0','101574628529006305177','{\"provider\":\"google\",\"id\":\"101574628529006305177\",\"displayName\":\"Oscar Barba\",\"name\":{\"familyName\":\"Barba\",\"givenName\":\"Oscar\"},\"emails\":[{\"value\":\"oscar.barba@ipointsystems.com\"}],\"_raw\":\"{\\n \\\"id\\\": \\\"101574628529006305177\\\",\\n \\\"email\\\": \\\"oscar.barba@ipointsystems.com\\\",\\n \\\"verified_email\\\": true,\\n \\\"name\\\": \\\"Oscar Barba\\\",\\n \\\"given_name\\\": \\\"Oscar\\\",\\n \\\"family_name\\\": \\\"Barba\\\",\\n \\\"link\\\": \\\"https://plus.google.com/101574628529006305177\\\",\\n \\\"picture\\\": \\\"https://lh3.googleusercontent.com/-rdkCUSH9Aig/AAAAAAAAAAI/AAAAAAAAAV8/Y8vEJVmQHhI/photo.jpg\\\",\\n \\\"gender\\\": \\\"male\\\",\\n \\\"locale\\\": \\\"es\\\",\\n \\\"hd\\\": \\\"ipointsystems.com\\\"\\n}\\n\",\"_json\":{\"id\":\"101574628529006305177\",\"email\":\"oscar.barba@ipointsystems.com\",\"verified_email\":true,\"name\":\"Oscar Barba\",\"given_name\":\"Oscar\",\"family_name\":\"Barba\",\"link\":\"https://plus.google.com/101574628529006305177\",\"picture\":\"https://lh3.googleusercontent.com/-rdkCUSH9Aig/AAAAAAAAAAI/AAAAAAAAAV8/Y8vEJVmQHhI/photo.jpg\",\"gender\":\"male\",\"locale\":\"es\",\"hd\":\"ipointsystems.com\"}}','{\"accessToken\":\"ya29.CjPhAo0OhNiW-mkjLTNqnYw8MKT6FoplsA6YtEKLeVJxa8qLWfSCAPDY4-r_bufrUXfLMt0\"}','2016-05-13 00:14:01','2016-05-13 00:14:01',1),(2,'google-login','oAuth 2.0','109236467434292587693','{\"provider\":\"google\",\"id\":\"109236467434292587693\",\"displayName\":\"Adriana Gonzalez\",\"name\":{\"familyName\":\"Gonzalez\",\"givenName\":\"Adriana\"},\"emails\":[{\"value\":\"adriana.gonzalez@ipointsystems.com\"}],\"_raw\":\"{\\n \\\"id\\\": \\\"109236467434292587693\\\",\\n \\\"email\\\": \\\"adriana.gonzalez@ipointsystems.com\\\",\\n \\\"verified_email\\\": true,\\n \\\"name\\\": \\\"Adriana Gonzalez\\\",\\n \\\"given_name\\\": \\\"Adriana\\\",\\n \\\"family_name\\\": \\\"Gonzalez\\\",\\n \\\"picture\\\": \\\"https://lh5.googleusercontent.com/-emPtSDA2bCM/AAAAAAAAAAI/AAAAAAAAADc/inPMCeQkAjU/photo.jpg\\\",\\n \\\"locale\\\": \\\"es\\\",\\n \\\"hd\\\": \\\"ipointsystems.com\\\"\\n}\\n\",\"_json\":{\"id\":\"109236467434292587693\",\"email\":\"adriana.gonzalez@ipointsystems.com\",\"verified_email\":true,\"name\":\"Adriana Gonzalez\",\"given_name\":\"Adriana\",\"family_name\":\"Gonzalez\",\"picture\":\"https://lh5.googleusercontent.com/-emPtSDA2bCM/AAAAAAAAAAI/AAAAAAAAADc/inPMCeQkAjU/photo.jpg\",\"locale\":\"es\",\"hd\":\"ipointsystems.com\"}}','{\"accessToken\":\"ya29.CjHhAt_5InoTnekZHmjDTCpyuN3LsNuEi1bm6Kpt5miJB5JGCnaokfjmt7URDL30AtQz\"}','2016-05-13 01:00:48','2016-05-13 01:00:48',2),(3,'google-login','oAuth 2.0','108458095585172569466','{\"provider\":\"google\",\"id\":\"108458095585172569466\",\"displayName\":\"Oscar Barba\",\"name\":{\"familyName\":\"Barba\",\"givenName\":\"Oscar\"},\"emails\":[{\"value\":\"oscarbarbaa@gmail.com\"}],\"_raw\":\"{\\n \\\"id\\\": \\\"108458095585172569466\\\",\\n \\\"email\\\": \\\"oscarbarbaa@gmail.com\\\",\\n \\\"verified_email\\\": true,\\n \\\"name\\\": \\\"Oscar Barba\\\",\\n \\\"given_name\\\": \\\"Oscar\\\",\\n \\\"family_name\\\": \\\"Barba\\\",\\n \\\"link\\\": \\\"https://plus.google.com/+OscarBarba88\\\",\\n \\\"picture\\\": \\\"https://lh5.googleusercontent.com/-b5K8Xs4An7s/AAAAAAAAAAI/AAAAAAAABfg/lcxiWwIYzcM/photo.jpg\\\",\\n \\\"gender\\\": \\\"male\\\",\\n \\\"locale\\\": \\\"es-419\\\"\\n}\\n\",\"_json\":{\"id\":\"108458095585172569466\",\"email\":\"oscarbarbaa@gmail.com\",\"verified_email\":true,\"name\":\"Oscar Barba\",\"given_name\":\"Oscar\",\"family_name\":\"Barba\",\"link\":\"https://plus.google.com/+OscarBarba88\",\"picture\":\"https://lh5.googleusercontent.com/-b5K8Xs4An7s/AAAAAAAAAAI/AAAAAAAABfg/lcxiWwIYzcM/photo.jpg\",\"gender\":\"male\",\"locale\":\"es-419\"}}','{\"accessToken\":\"ya29.CjLnAtEAbkQ7uugQ62uiBQJkkuJIf6L9Jtlon0559lTdcD-Vg0jxpbZ2JdG8bNO4vABoEA\"}','2016-05-19 21:59:08','2016-05-19 21:59:08',3);
/*!40000 ALTER TABLE `userIdentity` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_has_team`
--

DROP TABLE IF EXISTS `user_has_team`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_has_team` (
  `userid` int(11) NOT NULL,
  `idTeam` int(11) NOT NULL,
  PRIMARY KEY (`userid`,`idTeam`),
  KEY `fk_user_has_team_team1_idx` (`idTeam`),
  KEY `fk_user_has_team_user1_idx` (`userid`),
  CONSTRAINT `fk_user_has_team_team1` FOREIGN KEY (`idTeam`) REFERENCES `team` (`idTeam`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_team_user1` FOREIGN KEY (`userid`) REFERENCES `user` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_has_team`
--

LOCK TABLES `user_has_team` WRITE;
/*!40000 ALTER TABLE `user_has_team` DISABLE KEYS */;
INSERT INTO `user_has_team` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `user_has_team` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `user_stats`
--

DROP TABLE IF EXISTS `user_stats`;
/*!50001 DROP VIEW IF EXISTS `user_stats`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `user_stats` (
  `id` tinyint NOT NULL,
  `username` tinyint NOT NULL,
  `total_games` tinyint NOT NULL,
  `wins` tinyint NOT NULL
) ENGINE = InnoDB */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `user_stats`
--

/*!50001 DROP TABLE IF EXISTS `user_stats`*/;
/*!50001 DROP VIEW IF EXISTS `user_stats`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `user_stats` AS select `u`.`id` AS `id`,`u`.`username` AS `username`,count(`g`.`gameId`) AS `total_games`,sum(if((`g`.`teamWinnerId` = `t`.`idTeam`),1,0)) AS `wins` from (((((`user` `u` join `user_has_team` `ut` on((`ut`.`userid` = `u`.`id`))) join `team` `t` on((`ut`.`idTeam` = `t`.`idTeam`))) join `lobby` `l` on((`l`.`lobbyId` = `t`.`lobbyId`))) join `match` `m` on((`m`.`Lobby_lobbyId` = `l`.`lobbyId`))) join `game` `g` on((`g`.`idmatch` = `m`.`idmatch`))) group by `u`.`id` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-05-20  1:19:53
