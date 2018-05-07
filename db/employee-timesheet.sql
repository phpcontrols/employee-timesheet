# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: localhost (MySQL 5.6.35-log)
# Database: ZB_employee_timesheet
# Generation Time: 2018-05-07 04:47:14 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table account
# ------------------------------------------------------------

DROP TABLE IF EXISTS `account`;

CREATE TABLE `account` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `role_id` int(11) unsigned DEFAULT NULL,
  `status` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_account_role` (`role_id`),
  CONSTRAINT `fk_account_role` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `account` WRITE;
/*!40000 ALTER TABLE `account` DISABLE KEYS */;

INSERT INTO `account` (`id`, `title`, `first_name`, `last_name`, `email`, `password`, `role_id`, `status`)
VALUES
	(1,'','James','Chocolatey','employee@test.com','*********',1,'active'),
	(2,'','Boss','Truman','supervisor@test.com','*********',2,'active'),
	(3,'','Joe','Thyme','employee2@test.com','*********',1,'active');

/*!40000 ALTER TABLE `account` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table activity
# ------------------------------------------------------------

DROP TABLE IF EXISTS `activity`;

CREATE TABLE `activity` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `code` varchar(255) DEFAULT NULL,
  `project_id` int(11) unsigned DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_activity_project` (`project_id`),
  CONSTRAINT `fk_activity_project` FOREIGN KEY (`project_id`) REFERENCES `project` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `activity` WRITE;
/*!40000 ALTER TABLE `activity` DISABLE KEYS */;

INSERT INTO `activity` (`id`, `code`, `project_id`, `start_date`, `end_date`, `other_details`)
VALUES
	(1,'Planning',1,'2018-01-02','2018-01-31',''),
	(2,'Development',1,'2017-11-01','2017-12-31',''),
	(3,'Planning',2,'2017-06-01','2017-12-01','');

/*!40000 ALTER TABLE `activity` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table cost_center
# ------------------------------------------------------------

DROP TABLE IF EXISTS `cost_center`;

CREATE TABLE `cost_center` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `order_details` varchar(255) DEFAULT NULL,
  `owner_id` int(11) unsigned DEFAULT NULL,
  `date_created` datetime DEFAULT NULL,
  `date_modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_cc_account` (`owner_id`),
  CONSTRAINT `fk_cc_account` FOREIGN KEY (`owner_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `cost_center` WRITE;
/*!40000 ALTER TABLE `cost_center` DISABLE KEYS */;

INSERT INTO `cost_center` (`id`, `name`, `description`, `order_details`, `owner_id`, `date_created`, `date_modified`)
VALUES
	(1,'First Center','Testing Department','',2,'2010-08-13 21:22:37','2010-08-13 21:27:41'),
	(2,'Second Center','Research and Development department','',2,'2010-08-13 21:22:52','2010-08-13 21:27:28');

/*!40000 ALTER TABLE `cost_center` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table project
# ------------------------------------------------------------

DROP TABLE IF EXISTS `project`;

CREATE TABLE `project` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `project_code` varchar(255) DEFAULT '',
  `name` varchar(255) DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `manager_id` int(11) unsigned DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `other_details` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_project_manager` (`manager_id`),
  CONSTRAINT `fk_project_manager` FOREIGN KEY (`manager_id`) REFERENCES `account` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `project` WRITE;
/*!40000 ALTER TABLE `project` DISABLE KEYS */;

INSERT INTO `project` (`id`, `project_code`, `name`, `location`, `manager_id`, `start_date`, `end_date`, `other_details`)
VALUES
	(1,'P100813-1','Renewal Flight Schedule System','Airport',2,'2010-08-22','2010-08-30',''),
	(2,'P100813-2','Booking system','Train Station',2,'2010-08-13','2010-08-25','');

/*!40000 ALTER TABLE `project` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table role
# ------------------------------------------------------------

DROP TABLE IF EXISTS `role`;

CREATE TABLE `role` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `role` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;

INSERT INTO `role` (`id`, `role`)
VALUES
	(1,'Employee'),
	(2,'Supervisor');

/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table timesheet
# ------------------------------------------------------------

DROP TABLE IF EXISTS `timesheet`;

CREATE TABLE `timesheet` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `employee_id` int(11) unsigned DEFAULT NULL,
  `date` date DEFAULT NULL,
  `time_from` time DEFAULT NULL,
  `time_to` time DEFAULT NULL,
  `comments` varchar(255) DEFAULT NULL,
  `activity_id` int(11) unsigned DEFAULT NULL,
  `date_submitted` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_hour_account` (`employee_id`),
  KEY `fk_ts_activity_id` (`activity_id`),
  CONSTRAINT `fk_hour_account` FOREIGN KEY (`employee_id`) REFERENCES `account` (`id`),
  CONSTRAINT `fk_ts_activity_id` FOREIGN KEY (`activity_id`) REFERENCES `activity` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `timesheet` WRITE;
/*!40000 ALTER TABLE `timesheet` DISABLE KEYS */;

INSERT INTO `timesheet` (`id`, `employee_id`, `date`, `time_from`, `time_to`, `comments`, `activity_id`, `date_submitted`)
VALUES
	(1,1,'2018-01-10','09:00:00','16:00:00','',1,'2018-01-13'),
	(2,1,'2018-01-11','01:46:00','05:38:00','over time!!',2,'2018-01-11'),
	(3,1,'2018-01-12','12:30:00','22:12:00','party time',3,'2018-01-13'),
	(4,3,'2018-01-10','12:00:00','18:22:00',NULL,1,'2018-01-11'),
	(5,3,'2018-01-11','14:12:00','16:23:00','meeting',2,'2018-01-12'),
	(6,3,'2018-01-12','08:00:00','17:00:00','Cinco de Mayo!',2,'2018-01-14');

/*!40000 ALTER TABLE `timesheet` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
