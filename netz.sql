-- MySQL dump 10.13  Distrib 5.5.43, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: online_examination
-- ------------------------------------------------------
-- Server version	5.5.43-0ubuntu0.14.04.1

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
-- Table structure for table `academic_student`
--

DROP TABLE IF EXISTS `academic_student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `academic_student` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_name` varchar(200) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `source` varchar(200) DEFAULT NULL,
  `is_curently_logged_in` tinyint(1) NOT NULL,
  `student_password` varchar(200) DEFAULT NULL,
  `registration_no` varchar(200) DEFAULT NULL,
  `hall_ticket_no` varchar(200) DEFAULT NULL,
  `address` varchar(200) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `specialization` varchar(200) DEFAULT NULL,
  `semester_id` int(11) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `age` varchar(200) DEFAULT NULL,
  `permanent_address` varchar(200) DEFAULT NULL,
  `mobile_number` varchar(200) DEFAULT NULL,
  `email` varchar(200) DEFAULT NULL,
  `photo` varchar(100) DEFAULT NULL,
  `father_name` varchar(200) DEFAULT NULL,
  `guardian_mobile_number` varchar(200) DEFAULT NULL,
  `pass_out_year` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `academic_student_6340c63c` (`user_id`),
  KEY `academic_student_6234103b` (`course_id`),
  KEY `academic_student_7ce38e1e` (`semester_id`),
  CONSTRAINT `course_id_refs_id_dd854d16` FOREIGN KEY (`course_id`) REFERENCES `college_course` (`id`),
  CONSTRAINT `semester_id_refs_id_6766ad79` FOREIGN KEY (`semester_id`) REFERENCES `college_semester` (`id`),
  CONSTRAINT `user_id_refs_id_eb706d01` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `academic_student`
--

LOCK TABLES `academic_student` WRITE;
/*!40000 ALTER TABLE `academic_student` DISABLE KEYS */;
INSERT INTO `academic_student` VALUES (3,'kichu',2,'Newspaper',0,'password','1','1','koodanthody house ',1,'eng',1,'2005-06-04','10','koodanthody house ','11111111','jj@gg.bb','uploads/photos/1045112_152350784958550_1302685152_n.jpg','nil','',''),(4,'Sudhi',3,'Newspaper',1,'kJ3CeGwl','2','2','koodanthodi house',2,'computer',NULL,'1992-08-08','24','koodanthodi house','1234567890','kkk@ww.bo','','Krishnan kutty','1234567892','2015');
/*!40000 ALTER TABLE `academic_student` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `group_id` (`group_id`,`permission_id`),
  KEY `auth_group_permissions_5f412f9a` (`group_id`),
  KEY `auth_group_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `group_id_refs_id_f4b32aac` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `permission_id_refs_id_6ba0f519` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_type_id` (`content_type_id`,`codename`),
  KEY `auth_permission_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_d043b34a` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can add group',2,'add_group'),(5,'Can change group',2,'change_group'),(6,'Can delete group',2,'delete_group'),(7,'Can add user',3,'add_user'),(8,'Can change user',3,'change_user'),(9,'Can delete user',3,'delete_user'),(10,'Can add content type',4,'add_contenttype'),(11,'Can change content type',4,'change_contenttype'),(12,'Can delete content type',4,'delete_contenttype'),(13,'Can add session',5,'add_session'),(14,'Can change session',5,'change_session'),(15,'Can delete session',5,'delete_session'),(16,'Can add site',6,'add_site'),(17,'Can change site',6,'change_site'),(18,'Can delete site',6,'delete_site'),(19,'Can add log entry',7,'add_logentry'),(20,'Can change log entry',7,'change_logentry'),(21,'Can delete log entry',7,'delete_logentry'),(22,'Can add migration history',8,'add_migrationhistory'),(23,'Can change migration history',8,'change_migrationhistory'),(24,'Can delete migration history',8,'delete_migrationhistory'),(25,'Can add Semester',9,'add_semester'),(26,'Can change Semester',9,'change_semester'),(27,'Can delete Semester',9,'delete_semester'),(28,'Can add Course',10,'add_course'),(29,'Can change Course',10,'change_course'),(30,'Can delete Course',10,'delete_course'),(31,'Can add Student',11,'add_student'),(32,'Can change Student',11,'change_student'),(33,'Can delete Student',11,'delete_student'),(34,'Can add Subject',12,'add_subject'),(35,'Can change Subject',12,'change_subject'),(36,'Can delete Subject',12,'delete_subject'),(37,'Can add Exam',13,'add_exam'),(38,'Can change Exam',13,'change_exam'),(39,'Can delete Exam',13,'delete_exam'),(40,'Can add Choice',14,'add_choice'),(41,'Can change Choice',14,'change_choice'),(42,'Can delete Choice',14,'delete_choice'),(43,'Can add Question',15,'add_question'),(44,'Can change Question',15,'change_question'),(45,'Can delete Question',15,'delete_question'),(46,'Can add StudentAnswer',16,'add_studentanswer'),(47,'Can change StudentAnswer',16,'change_studentanswer'),(48,'Can delete StudentAnswer',16,'delete_studentanswer'),(49,'Can add AnswerSheet',17,'add_answersheet'),(50,'Can change AnswerSheet',17,'change_answersheet'),(51,'Can delete AnswerSheet',17,'delete_answersheet');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime NOT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(30) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(30) NOT NULL,
  `email` varchar(75) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$10000$NAKBw8FGox3p$HxwYIG3eH51oL+veck073XVQAZy3IAETu00oFEQJP5c=','2015-06-05 04:13:30',1,'kishore','','','kishorekdty@gmail.com',1,1,'2015-06-04 14:12:29'),(2,'pbkdf2_sha256$10000$C09Wj3SS38jQ$EY+0MjqxbeF+1/0OR3c5SHcisHYWa4WeHgLvf6orPK8=','2015-06-04 14:14:44',0,'student','','','',0,1,'2015-06-04 14:14:44'),(3,'pbkdf2_sha256$10000$SNWz4MBSd6aP$zF0tBMRmI+ixvgQmXNQBTFeu9XSYnvaaz+7XwTb9POs=','2015-06-05 04:15:09',0,'22','','','kkk@ww.bo',0,1,'2015-06-04 15:12:32');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`group_id`),
  KEY `auth_user_groups_6340c63c` (`user_id`),
  KEY `auth_user_groups_5f412f9a` (`group_id`),
  CONSTRAINT `group_id_refs_id_274b862c` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `user_id_refs_id_40c41112` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_id` (`user_id`,`permission_id`),
  KEY `auth_user_user_permissions_6340c63c` (`user_id`),
  KEY `auth_user_user_permissions_83d7f98b` (`permission_id`),
  CONSTRAINT `permission_id_refs_id_35d9ac25` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `user_id_refs_id_4dc23c39` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `college_course`
--

DROP TABLE IF EXISTS `college_course`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `college_course` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course` (`course`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `college_course`
--

LOCK TABLES `college_course` WRITE;
/*!40000 ALTER TABLE `college_course` DISABLE KEYS */;
INSERT INTO `college_course` VALUES (2,'BArch'),(1,'Btech');
/*!40000 ALTER TABLE `college_course` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `college_course_semester`
--

DROP TABLE IF EXISTS `college_course_semester`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `college_course_semester` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `course_id` int(11) NOT NULL,
  `semester_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `course_id` (`course_id`,`semester_id`),
  KEY `college_course_semester_6234103b` (`course_id`),
  KEY `college_course_semester_7ce38e1e` (`semester_id`),
  CONSTRAINT `course_id_refs_id_b1702c74` FOREIGN KEY (`course_id`) REFERENCES `college_course` (`id`),
  CONSTRAINT `semester_id_refs_id_820e6b24` FOREIGN KEY (`semester_id`) REFERENCES `college_semester` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `college_course_semester`
--

LOCK TABLES `college_course_semester` WRITE;
/*!40000 ALTER TABLE `college_course_semester` DISABLE KEYS */;
INSERT INTO `college_course_semester` VALUES (1,2,2);
/*!40000 ALTER TABLE `college_course_semester` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `college_semester`
--

DROP TABLE IF EXISTS `college_semester`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `college_semester` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `semester` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `college_semester`
--

LOCK TABLES `college_semester` WRITE;
/*!40000 ALTER TABLE `college_semester` DISABLE KEYS */;
INSERT INTO `college_semester` VALUES (1,'8'),(2,'7'),(3,'6'),(4,'5'),(5,'4');
/*!40000 ALTER TABLE `college_semester` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime NOT NULL,
  `user_id` int(11) NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_6340c63c` (`user_id`),
  KEY `django_admin_log_37ef4eb4` (`content_type_id`),
  CONSTRAINT `content_type_id_refs_id_93d2d1f8` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `user_id_refs_id_c0d12874` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2015-06-04 14:13:53',1,9,'1','8',1,''),(2,'2015-06-04 14:14:08',1,10,'1','Btech',1,''),(3,'2015-06-04 14:14:44',1,3,'2','student',1,''),(4,'2015-06-04 14:14:50',1,3,'2','student',2,'Changed password.'),(6,'2015-06-04 14:20:07',1,11,'2','',1,''),(7,'2015-06-04 14:20:34',1,11,'2','',3,''),(8,'2015-06-04 14:23:07',1,11,'3','kichu',1,''),(10,'2015-06-04 14:25:23',1,12,'2','jjjjjjjjjjjjjjjj',1,''),(11,'2015-06-04 14:26:04',1,13,'1','kkkkkkkk',1,''),(12,'2015-06-04 14:26:56',1,9,'2','7',1,''),(13,'2015-06-05 04:14:13',1,17,'2','Sudhi',3,''),(14,'2015-06-05 04:14:13',1,17,'1','Sudhi',3,'');
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_label` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'permission','auth','permission'),(2,'group','auth','group'),(3,'user','auth','user'),(4,'content type','contenttypes','contenttype'),(5,'session','sessions','session'),(6,'site','sites','site'),(7,'log entry','admin','logentry'),(8,'migration history','south','migrationhistory'),(9,'Semester','college','semester'),(10,'Course','college','course'),(11,'Student','academic','student'),(12,'Subject','exam','subject'),(13,'Exam','exam','exam'),(14,'Choice','exam','choice'),(15,'Question','exam','question'),(16,'StudentAnswer','exam','studentanswer'),(17,'AnswerSheet','exam','answersheet');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_b7b81f0c` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('lqhw9521llja3gxweumcby59embpf3o7','OWU0NWU1ODgwODU3ZWE2YTlhNDYwNTA3N2JmZTZjOTdjZTdjZGJjMjqAAn1xAShVEl9hdXRoX3VzZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHEDVQ1fYXV0aF91c2VyX2lkcQSKAQN1Lg==','2015-06-19 04:15:09'),('ltevrm0ubjaozvhlmfegn8czqkomo7oh','OTljNGMzYzY1MWVlNmE0ZjcxZjUyN2Y1NjdmYTlhMWU5ZTc5ZWE2YTqAAn1xAShVEl9hdXRoX3VzZXJfYmFja2VuZHECVSlkamFuZ28uY29udHJpYi5hdXRoLmJhY2tlbmRzLk1vZGVsQmFja2VuZHEDVQ1fYXV0aF91c2VyX2lkcQSKAQF1Lg==','2015-06-19 03:56:33');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` VALUES (1,'example.com','example.com');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_answersheet`
--

DROP TABLE IF EXISTS `exam_answersheet`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_answersheet` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `is_attempted` tinyint(1) NOT NULL,
  `student_id` int(11) DEFAULT NULL,
  `exam_id` int(11) DEFAULT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `is_completed` tinyint(1) NOT NULL,
  `total_mark` decimal(14,2) NOT NULL,
  `status` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exam_answersheet_94741166` (`student_id`),
  KEY `exam_answersheet_57ed41d1` (`exam_id`),
  KEY `exam_answersheet_56bb4187` (`subject_id`),
  CONSTRAINT `exam_id_refs_id_681d15da` FOREIGN KEY (`exam_id`) REFERENCES `exam_exam` (`id`),
  CONSTRAINT `student_id_refs_id_a536802f` FOREIGN KEY (`student_id`) REFERENCES `academic_student` (`id`),
  CONSTRAINT `subject_id_refs_id_31a92393` FOREIGN KEY (`subject_id`) REFERENCES `exam_subject` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_answersheet`
--

LOCK TABLES `exam_answersheet` WRITE;
/*!40000 ALTER TABLE `exam_answersheet` DISABLE KEYS */;
INSERT INTO `exam_answersheet` VALUES (3,1,4,2,4,0,0.00,NULL);
/*!40000 ALTER TABLE `exam_answersheet` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_answersheet_student_answers`
--

DROP TABLE IF EXISTS `exam_answersheet_student_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_answersheet_student_answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answersheet_id` int(11) NOT NULL,
  `studentanswer_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `answersheet_id` (`answersheet_id`,`studentanswer_id`),
  KEY `exam_answersheet_student_answers_a1e13e00` (`answersheet_id`),
  KEY `exam_answersheet_student_answers_a6a8fa5c` (`studentanswer_id`),
  CONSTRAINT `answersheet_id_refs_id_88ce7f82` FOREIGN KEY (`answersheet_id`) REFERENCES `exam_answersheet` (`id`),
  CONSTRAINT `studentanswer_id_refs_id_f2727798` FOREIGN KEY (`studentanswer_id`) REFERENCES `exam_studentanswer` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_answersheet_student_answers`
--

LOCK TABLES `exam_answersheet_student_answers` WRITE;
/*!40000 ALTER TABLE `exam_answersheet_student_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_answersheet_student_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_choice`
--

DROP TABLE IF EXISTS `exam_choice`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_choice` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `choice` varchar(200) DEFAULT NULL,
  `correct_answer` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_choice`
--

LOCK TABLES `exam_choice` WRITE;
/*!40000 ALTER TABLE `exam_choice` DISABLE KEYS */;
INSERT INTO `exam_choice` VALUES (1,'I\'m kishore.',1),(2,'hi',1),(3,'hello',0),(4,'you',0),(5,'me',0),(6,'hi',0),(7,'hello',0),(8,'you',0),(9,'me',0),(10,'hi',0),(11,'hello',0),(12,'you',0),(13,'me',0),(14,'hi',0),(15,'hello',0),(16,'hi',0),(17,'you',0),(18,'hello',0),(19,'hi',0),(20,'me',0),(21,'hi',0),(22,'you',0),(23,'hello',0),(24,'hello',0),(25,'me',0),(26,'you',0),(27,'you',0),(28,'me',0),(29,'me',0),(30,'hi',1),(31,'hello',0),(32,'you',0),(33,'me',0),(34,'hi',1),(35,'hello',0),(36,'you',0),(37,'me',0),(38,'hi',0),(39,'hello',1),(40,'you',0),(41,'me',0),(42,'hi',0),(43,'hello',0),(44,'you',1),(45,'me',0),(46,'hi',0),(47,'hello',0),(48,'you',1),(49,'me',0),(50,'hi',0),(51,'hello',1),(52,'you',0),(53,'me',1),(54,'hi',0),(55,'hello',1),(56,'you',0),(57,'me',0),(58,'hi',0),(59,'hello',0),(60,'you',1),(61,'me',0),(62,'hi',1),(63,'hello',0),(64,'you',0),(65,'me',1);
/*!40000 ALTER TABLE `exam_choice` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_exam`
--

DROP TABLE IF EXISTS `exam_exam`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_exam` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `student_id` int(11) DEFAULT NULL,
  `exam_name` varchar(200) DEFAULT NULL,
  `course_id` int(11) DEFAULT NULL,
  `semester_id` int(11) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `no_subjects` int(11) NOT NULL,
  `exam_total` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `exam_exam_94741166` (`student_id`),
  KEY `exam_exam_6234103b` (`course_id`),
  KEY `exam_exam_7ce38e1e` (`semester_id`),
  CONSTRAINT `course_id_refs_id_5f44f5a7` FOREIGN KEY (`course_id`) REFERENCES `college_course` (`id`),
  CONSTRAINT `semester_id_refs_id_822c682c` FOREIGN KEY (`semester_id`) REFERENCES `college_semester` (`id`),
  CONSTRAINT `student_id_refs_id_257a2502` FOREIGN KEY (`student_id`) REFERENCES `academic_student` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_exam`
--

LOCK TABLES `exam_exam` WRITE;
/*!40000 ALTER TABLE `exam_exam` DISABLE KEYS */;
INSERT INTO `exam_exam` VALUES (1,3,'kkkkkkkk',1,1,'2015-06-04','2016-06-04',6,6),(2,4,'BArch-7',2,2,'2015-06-05','2015-06-30',6,600);
/*!40000 ALTER TABLE `exam_exam` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_exam_subjects`
--

DROP TABLE IF EXISTS `exam_exam_subjects`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_exam_subjects` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `exam_id` (`exam_id`,`subject_id`),
  KEY `exam_exam_subjects_57ed41d1` (`exam_id`),
  KEY `exam_exam_subjects_56bb4187` (`subject_id`),
  CONSTRAINT `exam_id_refs_id_b82842a5` FOREIGN KEY (`exam_id`) REFERENCES `exam_exam` (`id`),
  CONSTRAINT `subject_id_refs_id_60488b91` FOREIGN KEY (`subject_id`) REFERENCES `exam_subject` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_exam_subjects`
--

LOCK TABLES `exam_exam_subjects` WRITE;
/*!40000 ALTER TABLE `exam_exam_subjects` DISABLE KEYS */;
INSERT INTO `exam_exam_subjects` VALUES (1,1,2),(2,2,3),(3,2,4),(4,2,5),(5,2,6),(6,2,7),(7,2,8);
/*!40000 ALTER TABLE `exam_exam_subjects` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_question`
--

DROP TABLE IF EXISTS `exam_question`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_question` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `exam_id` int(11) DEFAULT NULL,
  `question` longtext,
  `subject_id` int(11) DEFAULT NULL,
  `mark` decimal(14,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `exam_question_57ed41d1` (`exam_id`),
  KEY `exam_question_56bb4187` (`subject_id`),
  CONSTRAINT `exam_id_refs_id_b7c81486` FOREIGN KEY (`exam_id`) REFERENCES `exam_exam` (`id`),
  CONSTRAINT `subject_id_refs_id_6cf76106` FOREIGN KEY (`subject_id`) REFERENCES `exam_subject` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_question`
--

LOCK TABLES `exam_question` WRITE;
/*!40000 ALTER TABLE `exam_question` DISABLE KEYS */;
INSERT INTO `exam_question` VALUES (1,2,'Who are you?',3,100.00),(2,2,'how are you/',4,40.00),(3,2,'2222222222222222',4,40.00),(4,2,'3333333',4,10.00),(5,2,'444444444',4,70.00),(6,2,'55555555555',4,25.00),(7,2,'66666666',4,55.00),(8,2,'7777777',4,70.00),(9,2,'88888888',4,88.00);
/*!40000 ALTER TABLE `exam_question` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_question_choices`
--

DROP TABLE IF EXISTS `exam_question_choices`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_question_choices` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) NOT NULL,
  `choice_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `question_id` (`question_id`,`choice_id`),
  KEY `exam_question_choices_25110688` (`question_id`),
  KEY `exam_question_choices_a57b5718` (`choice_id`),
  CONSTRAINT `choice_id_refs_id_4fa23127` FOREIGN KEY (`choice_id`) REFERENCES `exam_choice` (`id`),
  CONSTRAINT `question_id_refs_id_460e5e03` FOREIGN KEY (`question_id`) REFERENCES `exam_question` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=66 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_question_choices`
--

LOCK TABLES `exam_question_choices` WRITE;
/*!40000 ALTER TABLE `exam_question_choices` DISABLE KEYS */;
INSERT INTO `exam_question_choices` VALUES (1,1,1),(2,2,2),(3,2,3),(4,2,4),(5,2,5),(34,2,34),(35,2,35),(36,2,36),(37,2,37),(6,3,6),(7,3,7),(8,3,8),(9,3,9),(38,3,38),(39,3,39),(40,3,40),(41,3,41),(10,4,10),(11,4,11),(12,4,12),(13,4,13),(42,4,42),(43,4,43),(44,4,44),(45,4,45),(14,5,14),(15,5,15),(17,5,17),(20,5,20),(46,5,46),(47,5,47),(48,5,48),(49,5,49),(16,6,16),(18,6,18),(22,6,22),(25,6,25),(50,6,50),(51,6,51),(52,6,52),(53,6,53),(19,7,19),(23,7,23),(26,7,26),(28,7,28),(54,7,54),(55,7,55),(56,7,56),(57,7,57),(21,8,21),(24,8,24),(27,8,27),(29,8,29),(58,8,58),(59,8,59),(60,8,60),(61,8,61),(30,9,30),(31,9,31),(32,9,32),(33,9,33),(62,9,62),(63,9,63),(64,9,64),(65,9,65);
/*!40000 ALTER TABLE `exam_question_choices` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_studentanswer`
--

DROP TABLE IF EXISTS `exam_studentanswer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_studentanswer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `question_id` int(11) DEFAULT NULL,
  `choosen_choice_id` int(11) DEFAULT NULL,
  `is_correct` tinyint(1) NOT NULL,
  `mark` decimal(14,2) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `exam_studentanswer_25110688` (`question_id`),
  KEY `exam_studentanswer_5440aba8` (`choosen_choice_id`),
  CONSTRAINT `choosen_choice_id_refs_id_c7513511` FOREIGN KEY (`choosen_choice_id`) REFERENCES `exam_choice` (`id`),
  CONSTRAINT `question_id_refs_id_48101e0b` FOREIGN KEY (`question_id`) REFERENCES `exam_question` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_studentanswer`
--

LOCK TABLES `exam_studentanswer` WRITE;
/*!40000 ALTER TABLE `exam_studentanswer` DISABLE KEYS */;
/*!40000 ALTER TABLE `exam_studentanswer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exam_subject`
--

DROP TABLE IF EXISTS `exam_subject`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `exam_subject` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `subject_name` varchar(200) DEFAULT NULL,
  `duration` varchar(200) DEFAULT NULL,
  `duration_parameter` varchar(200) DEFAULT NULL,
  `total_mark` varchar(200) DEFAULT NULL,
  `pass_mark` decimal(14,2) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exam_subject`
--

LOCK TABLES `exam_subject` WRITE;
/*!40000 ALTER TABLE `exam_subject` DISABLE KEYS */;
INSERT INTO `exam_subject` VALUES (2,'jjjjjjjjjjjjjjjj','ll','j','100',40.00),(3,'a','2','Hours','100',40.00),(4,'b','2','Hours','100',40.00),(5,'c','2','Minutes','100',40.00),(6,'d','2','Hours','100',40.00),(7,'e','2','Hours','100',40.00),(8,'f','2','Hours','100',40.00);
/*!40000 ALTER TABLE `exam_subject` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `south_migrationhistory`
--

DROP TABLE IF EXISTS `south_migrationhistory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `south_migrationhistory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_name` varchar(255) NOT NULL,
  `migration` varchar(255) NOT NULL,
  `applied` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `south_migrationhistory`
--

LOCK TABLES `south_migrationhistory` WRITE;
/*!40000 ALTER TABLE `south_migrationhistory` DISABLE KEYS */;
/*!40000 ALTER TABLE `south_migrationhistory` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2015-06-05 10:47:59
