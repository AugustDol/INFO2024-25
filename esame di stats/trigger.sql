-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: activity_reservation
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table activities
--

DROP TABLE IF EXISTS activities;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE activities (
  id int NOT NULL,
  name varchar(255) NOT NULL,
  date_time_start datetime NOT NULL,
  date_time_end datetime NOT NULL,
  n int NOT NULL,
  n_max int NOT NULL,
  PRIMARY KEY (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table activities
--

LOCK TABLES activities WRITE;
/*!40000 ALTER TABLE activities DISABLE KEYS */;
INSERT INTO activities VALUES (0,'Yoga Class','2024-02-10 09:00:00','2024-02-10 10:00:00',0,20),(1,'Cooking Workshop','2024-02-12 15:00:00','2024-02-12 18:00:00',1,15),(2,'Dance Class','2024-02-14 18:00:00','2024-02-14 19:30:00',0,10);
/*!40000 ALTER TABLE activities ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table reservations
--

DROP TABLE IF EXISTS reservations;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE reservations (
  id int NOT NULL,
  subscriber int DEFAULT NULL,
  id_activity int NOT NULL,
  PRIMARY KEY (id),
  KEY id_activity (id_activity),
  CONSTRAINT reservations_ibfk_1 FOREIGN KEY (id_activity) REFERENCES activities (id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table reservations
--

LOCK TABLES reservations WRITE;
/*!40000 ALTER TABLE reservations DISABLE KEYS */;
INSERT INTO reservations VALUES (0,0,1);
/*!40000 ALTER TABLE reservations ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/!50003 CREATE/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER increment_n_before_insert BEFORE INSERT ON reservations FOR EACH ROW BEGIN
    
    DECLARE current_max INT;
    DECLARE current_n INT;
    
    SELECT n_max, n INTO current_max, current_n
    FROM activities
    WHERE id = NEW.id_activity;

    
    IF current_n < current_max THEN
        UPDATE activities
        SET n = n + 1
        WHERE id = NEW.id_activity;
    ELSE
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Maximum reservations reached for this activity';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = cp850 */ ;
/*!50003 SET character_set_results = cp850 */ ;
/*!50003 SET collation_connection  = cp850_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/!50003 CREATE/ /*!50017 DEFINER=root@localhost*/ /*!50003 TRIGGER decrement_n_after_delete AFTER DELETE ON reservations FOR EACH ROW BEGIN
    
    UPDATE activities
    SET n = n - 1
    WHERE id = OLD.id_activity;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-02-04 12:57:10