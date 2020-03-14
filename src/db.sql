CREATE DATABASE  IF NOT EXISTS `giinrummy` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `giinrummy`;
-- MySQL dump 10.13  Distrib 8.0.19, for Win64 (x86_64)
--
-- Host: localhost    Database: giinrummy
-- ------------------------------------------------------
-- Server version	8.0.19

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
-- Table structure for table `gamerun_targets`
--

DROP TABLE IF EXISTS `gamerun_targets`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gamerun_targets` (
  `run` int NOT NULL,
  `target` varchar(100) NOT NULL,
  PRIMARY KEY (`run`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `gameruns`
--

DROP TABLE IF EXISTS `gameruns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `gameruns` (
  `id` int NOT NULL AUTO_INCREMENT,
  `game` int NOT NULL,
  `run` int NOT NULL,
  `date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_index` (`game`,`run`) /*!80000 INVISIBLE */,
  CONSTRAINT `fk_game_id` FOREIGN KEY (`game`) REFERENCES `ginrummygames` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ginrummygame_players`
--

DROP TABLE IF EXISTS `ginrummygame_players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ginrummygame_players` (
  `game_id` int NOT NULL,
  `player_id` int NOT NULL,
  `player_order` int NOT NULL,
  `total_score` int NOT NULL DEFAULT '0',
  UNIQUE KEY `unique_index2` (`game_id`,`player_order`),
  KEY `fk_player_id_idx` (`player_id`),
  CONSTRAINT `fk_player_id` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `ginrummygames`
--

DROP TABLE IF EXISTS `ginrummygames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ginrummygames` (
  `id` int NOT NULL AUTO_INCREMENT,
  `game_start_date` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `finished` tinyint NOT NULL DEFAULT '0',
  `finished_date` datetime DEFAULT NULL,
  `winner` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `players`
--

DROP TABLE IF EXISTS `players`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `players` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(24) NOT NULL,
  `wins` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name_UNIQUE` (`name`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  KEY `idx_players_name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `purchases`
--

DROP TABLE IF EXISTS `purchases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `purchases` (
  `gamerun_id` int NOT NULL,
  `player_id` int NOT NULL,
  `purchases` int NOT NULL DEFAULT '0',
  UNIQUE KEY `unique_purchases` (`gamerun_id`,`player_id`),
  KEY `fk_scores_player_id_idx` (`player_id`),
  CONSTRAINT `fk_purchases_gamerun_id` FOREIGN KEY (`gamerun_id`) REFERENCES `gameruns` (`id`),
  CONSTRAINT `fk_purchases_player_id` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scores`
--

DROP TABLE IF EXISTS `scores`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `scores` (
  `id` int NOT NULL AUTO_INCREMENT,
  `gamerun_id` int NOT NULL,
  `game_id` int NOT NULL,
  `player_id` int NOT NULL,
  `score` int NOT NULL,
  `total_score` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`),
  UNIQUE KEY `unique_score` (`gamerun_id`,`game_id`,`player_id`),
  KEY `fk_scores_player_id_idx` (`player_id`),
  KEY `fk_scores_game_id_idx` (`game_id`),
  CONSTRAINT `fk_scores_game_id` FOREIGN KEY (`game_id`) REFERENCES `ginrummygames` (`id`),
  CONSTRAINT `fk_scores_player_id` FOREIGN KEY (`player_id`) REFERENCES `players` (`id`),
  CONSTRAINT `scores_ibfk_1` FOREIGN KEY (`gamerun_id`) REFERENCES `gameruns` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping routines for database 'giinrummy'
--
/*!50003 DROP PROCEDURE IF EXISTS `add_new_player` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_new_player`(
IN player_name VARCHAR(24),
OUT player_id INT
)
BEGIN
	INSERT INTO players (name) values (player_name);
	SELECT id
    INTO player_id
    FROM players
    WHERE name=player_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_player_to_game` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_player_to_game`(IN player_id_ INT, IN game_id_ INT)
BEGIN
	SELECT 
		COUNT(*)+1
	INTO @inc_order
    FROM 
		ginrummygame_players
    WHERE 
		game_id=game_id_;
        
	INSERT INTO ginrummygame_players(game_id, player_id, player_order) VALUES (game_id_, player_id_, @inc_order);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_purchase_to_gamerun` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_purchase_to_gamerun`(IN gamerun_id_ INT, IN game_id_ INT, IN player_id_ INT)
BEGIN
	CALL validate_arguments(gamerun_id_, game_id_, player_id_);
    
    UPDATE purchases SET purchases = purchases + 1
    WHERE gamerun_id=gamerun_id_ AND player_id=player_id_;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_score_to_gamerun` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_score_to_gamerun`(IN gamerun_id_ INT, IN game_id_ INT, IN player_id_ INT, IN score_ INT)
BEGIN
	CALL validate_arguments(gamerun_id_, game_id_, player_id_);

	SET @old_total_score = 0;
    SELECT total_score
    INTO @old_total_score
    FROM ginrummygame_players
    WHERE game_id=game_id_ AND player_id=player_id_;
    SET @new_total_score = @old_total_score + score_;
    INSERT INTO scores(gamerun_id, game_id, player_id, score, total_score) VALUES (gamerun_id_, game_id_, player_id_, score_, @new_total_score);
    UPDATE ginrummygame_players SET total_score = @new_total_score
    WHERE game_id=game_id_ AND player_id=player_id_;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_new_game` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_new_game`(
OUT game_id INT)
BEGIN
	INSERT INTO ginrummygames VALUES ();
    SELECT id
    INTO game_id
    FROM ginrummygames ORDER BY id DESC LIMIT 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_new_game_run` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_new_game_run`(IN game_id_ INT, OUT run_id INT)
BEGIN
	SELECT 
		COUNT(*)+1
	INTO @inc_run
    FROM 
		gameruns
    WHERE 
		game=game_id_;

	INSERT INTO gameruns (game, run)
	VALUES (game_id_, @inc_run);
    
	SELECT LAST_INSERT_ID()
	INTO run_id;

	INSERT INTO purchases (gamerun_id,player_id)
	SELECT run_id, player_id FROM ginrummygame_players WHERE game_id=game_id_;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `finish_game` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `finish_game`(
	IN game_id_ INT, 
    OUT winner_id_ INT, 
    OUT winner_name_ VARCHAR(24))
BEGIN
	IF NOT EXISTS(SELECT id FROM ginrummygames WHERE id=game_id_) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Game does not exist!';
	END IF;

	SELECT 
		player_id
	INTO
		winner_id_
	FROM 
		scores 
	WHERE 
		gamerun_id = (SELECT MAX(gamerun_id) FROM scores WHERE game_id=game_id_)
	ORDER BY 
		total_score ASC
	LIMIT 1;
    
	UPDATE players SET wins = wins+1 WHERE id=winner_id_;
    UPDATE ginrummygames 
    SET 
		finished = 1,
        finished_date = CURRENT_TIMESTAMP,
        winner = winner_id_
	WHERE
		id = game_id_;
    
	SELECT players.name
    INTO winner_name_
    FROM ginrummygames
    INNER JOIN players
    ON ginrummygames.winner = players.id
    WHERE ginrummygames.winner = winner_id_ AND ginrummygames.finished = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_players` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_players`()
BEGIN
	SELECT 
		id, name, wins
	FROM
		players;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_all_targets` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_all_targets`()
BEGIN
	SELECT * FROM gamerun_targets;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_game_score` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_game_score`(IN game_id_ INT)
BEGIN
	CREATE TEMPORARY TABLE scores_with_player_name
SELECT scores.*, players.name, ginrummygame_players.player_order
	FROM scores
	INNER JOIN players ON scores.player_id = players.id
    INNER JOIN ginrummygame_players ON scores.player_id = ginrummygame_players.player_id AND scores.game_id = ginrummygame_players.game_id
    WHERE scores.game_id = game_id_ AND scores.player_id IN (SELECT player_id FROM ginrummygame_players WHERE ginrummygame_players.game_id=game_id_)
    ORDER BY ginrummygame_players.player_order ASC;
    
	SET @sql = NULL;
	SELECT
	  GROUP_CONCAT(DISTINCT
		CONCAT(
		  'max(case when player_order = ''',
		  player_order,
		  ''' then total_score else 0 end) AS ''O',
		  player_order, '''' ))
		INTO @sql
	FROM ginrummygame_players
    WHERE ginrummygame_players.game_id = game_id_;

	SET @sql = CONCAT('SELECT gameruns.run, ', @sql, '
		FROM scores_with_player_name 
        INNER JOIN gameruns 
        ON scores_with_player_name.gamerun_id = gameruns.id 
        WHERE scores_with_player_name.game_id=', game_id_, '
        GROUP BY scores_with_player_name.gamerun_id');

	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
    DROP TABLE scores_with_player_name;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_list_of_games` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_list_of_games`()
BEGIN
	
	CREATE TEMPORARY TABLE modified_ginrummygame_players
	SELECT 
		ginrummygame_players.game_id, 
		ginrummygame_players.player_order,
		players.name
	FROM ginrummygame_players
	INNER JOIN players
	ON ginrummygame_players.player_id = players.id
	ORDER BY ginrummygame_players.game_id, ginrummygame_players.player_order ASC;
	
	CREATE TEMPORARY TABLE players_per_game
	SELECT 
		game_id, 
		GROUP_CONCAT(modified_ginrummygame_players.name SEPARATOR ' ') AS Players
	FROM modified_ginrummygame_players
	GROUP BY game_id;

	SELECT 
			ginrummygames.id,
            players_per_game.Players,
			ginrummygames.game_start_date,
			ginrummygames.finished_date,
			ginrummygames.finished,
			players.name
		FROM 
			ginrummygames
		LEFT JOIN players
			ON ginrummygames.winner = players.id
		INNER JOIN players_per_game
			ON ginrummygames.id = players_per_game.game_id
	ORDER BY game_start_date;

	DROP TABLE modified_ginrummygame_players;
    DROP TABLE players_per_game;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_players_in_game` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_players_in_game`(IN game_id_ INT)
BEGIN
	SELECT 
		ginrummygame_players.player_order,
		players.name,
        players.id
	FROM ginrummygame_players
	INNER JOIN players
	ON ginrummygame_players.player_id = players.id
    WHERE ginrummygame_players.game_id = game_id_
	ORDER BY ginrummygame_players.game_id, ginrummygame_players.player_order ASC;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `populate_gamerun_targets` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `populate_gamerun_targets`()
BEGIN
	INSERT INTO gamerun_targets VALUES (1, '2st tretal');
    INSERT INTO gamerun_targets VALUES (2, '1st straight flush på minst 4 kort');
    INSERT INTO gamerun_targets VALUES (3, '2st fyrtal');
    INSERT INTO gamerun_targets VALUES (4, '2st straight flush på minst 4 kort');
    INSERT INTO gamerun_targets VALUES (5, '2st tretal 1st straight flusch på minst 4 kort');
    INSERT INTO gamerun_targets VALUES (6, '1st fyrtal 1st straight flusch på minst 5 kort');
    INSERT INTO gamerun_targets VALUES (7, '2st femtal');
    INSERT INTO gamerun_targets VALUES (8, '2st straight flusch på minst 5 kort');
    INSERT INTO gamerun_targets VALUES (9, '4st tretal');
    INSERT INTO gamerun_targets VALUES (10, '3st straight flusch på minst 4 kort');
    INSERT INTO gamerun_targets VALUES (11, '3st fyrtal');
    INSERT INTO gamerun_targets VALUES (12, '5st straight flusch på minst 3 kort');
    INSERT INTO gamerun_targets VALUES (13, '5st tretal');
    INSERT INTO gamerun_targets VALUES (14, '1st femtal 1st straight flusch på minst 5 kort 1st par som inte får
byggas på');
	INSERT INTO gamerun_targets VALUES (15, '2st tretal resten straight flusch och inga kort på bordet.');
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `test_ginrummy` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `test_ginrummy`()
BEGIN
	CALL truncate_all_tables();
    
    CALL populate_gamerun_targets();

	SET @player1 = 'Otto';
	SET @player2 = 'Victor';
    SET @player3 = 'Anna';
    SET @player4 = 'Mikaela';

	CALL add_new_player(@player1,@player1_id);
	CALL add_new_player(@player2,@player2_id);

	CALL create_new_game(@game_id);
	CALL add_player_to_game(@player1_id,@game_id);
	CALL add_player_to_game(@player2_id,@game_id);
    CALL create_new_game_run(@game_id,@game_run_id1);
    
    CALL add_purchase_to_gamerun(@game_run_id1,@game_id,@player1_id);
    CALL add_purchase_to_gamerun(@game_run_id1,@game_id,@player1_id);
    
    CALL add_score_to_gamerun(@game_run_id1,@game_id,@player1_id,10);
    CALL add_score_to_gamerun(@game_run_id1,@game_id,@player2_id,0);
    
    CALL create_new_game_run(@game_id,@game_run_id2);
    
    CALL add_purchase_to_gamerun(@game_run_id2,@game_id,@player2_id);
    CALL add_purchase_to_gamerun(@game_run_id2,@game_id,@player1_id);
    CALL add_purchase_to_gamerun(@game_run_id2,@game_id,@player1_id);
    CALL add_purchase_to_gamerun(@game_run_id2,@game_id,@player1_id);
    
    CALL add_score_to_gamerun(@game_run_id2,@game_id,@player1_id,120);
    CALL add_score_to_gamerun(@game_run_id2,@game_id,@player2_id,10);
    
    
    CALL add_new_player(@player3,@player3_id);
	CALL add_new_player(@player4,@player4_id);
    
    CALL create_new_game(@game_id);
	CALL add_player_to_game(@player1_id,@game_id);
	CALL add_player_to_game(@player2_id,@game_id);
    CALL add_player_to_game(@player3_id,@game_id);
    CALL add_player_to_game(@player4_id,@game_id);
    CALL create_new_game_run(@game_id,@game_run_id1);
    
    CALL add_purchase_to_gamerun(@game_run_id1,@game_id,@player1_id);
    CALL add_purchase_to_gamerun(@game_run_id1,@game_id,@player2_id);
    CALL add_purchase_to_gamerun(@game_run_id1,@game_id,@player3_id);
    
    CALL add_score_to_gamerun(@game_run_id1,@game_id,@player1_id,10);
    CALL add_score_to_gamerun(@game_run_id1,@game_id,@player2_id,0);
    CALL add_score_to_gamerun(@game_run_id1,@game_id,@player3_id,50);
    CALL add_score_to_gamerun(@game_run_id1,@game_id,@player4_id,25);
    
    CALL create_new_game_run(@game_id,@game_run_id2);
    
    CALL add_purchase_to_gamerun(@game_run_id2,@game_id,@player3_id);
    CALL add_purchase_to_gamerun(@game_run_id2,@game_id,@player1_id);
    CALL add_purchase_to_gamerun(@game_run_id2,@game_id,@player1_id);
    
    CALL add_score_to_gamerun(@game_run_id2,@game_id,@player1_id,100);
    CALL add_score_to_gamerun(@game_run_id2,@game_id,@player2_id,40);
    CALL add_score_to_gamerun(@game_run_id2,@game_id,@player3_id,35);
    CALL add_score_to_gamerun(@game_run_id2,@game_id,@player4_id,20);
    
    CALL create_new_game_run(@game_id,@game_run_id);
    
    CALL add_purchase_to_gamerun(@game_run_id,@game_id,@player4_id);
    CALL add_purchase_to_gamerun(@game_run_id,@game_id,@player4_id);
    CALL add_purchase_to_gamerun(@game_run_id,@game_id,@player3_id);
    
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player1_id,125);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player2_id,210);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player3_id,40);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player4_id,50);
    
    # CALL finish_game(@game_id);
    
    CALL create_new_game(@game_id);
	
    CALL add_player_to_game(@player3_id,@game_id);
    CALL add_player_to_game(@player4_id,@game_id);
    CALL add_player_to_game(@player2_id,@game_id);
    CALL create_new_game_run(@game_id,@game_run_id);
    
    CALL add_purchase_to_gamerun(@game_run_id,@game_id,@player2_id);
    CALL add_purchase_to_gamerun(@game_run_id,@game_id,@player3_id);
    CALL add_purchase_to_gamerun(@game_run_id,@game_id,@player3_id);
    
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player3_id,10);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player2_id,20);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player4_id,30);
    
    CALL create_new_game_run(@game_id,@game_run_id);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player3_id,20);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player2_id,40);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player4_id,60);
    
    CALL create_new_game_run(@game_id,@game_run_id);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player3_id,30);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player2_id,60);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player4_id,90);
    
    CALL create_new_game_run(@game_id,@game_run_id);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player3_id,40);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player2_id,80);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player4_id,120);
    
    CALL create_new_game_run(@game_id,@game_run_id);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player3_id,50);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player2_id,100);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player4_id,150);
    
    CALL create_new_game_run(@game_id,@game_run_id);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player3_id,60);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player2_id,120);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player4_id,150);
    
    CALL create_new_game_run(@game_id,@game_run_id);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player3_id,70);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player2_id,120);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player4_id,180);
    
    CALL create_new_game_run(@game_id,@game_run_id);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player3_id,80);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player2_id,150);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player4_id,210);
    
    CALL create_new_game_run(@game_id,@game_run_id);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player3_id,90);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player2_id,170);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player4_id,240);
    
    CALL create_new_game_run(@game_id,@game_run_id);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player3_id,100);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player2_id,190);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player4_id,270);
    
    CALL create_new_game_run(@game_id,@game_run_id);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player3_id,110);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player2_id,210);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player4_id,300);
    
    CALL create_new_game_run(@game_id,@game_run_id);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player3_id,120);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player2_id,210);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player4_id,330);
    
    CALL create_new_game_run(@game_id,@game_run_id);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player3_id,130);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player2_id,240);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player4_id,360);
    
    CALL create_new_game_run(@game_id,@game_run_id);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player3_id,140);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player2_id,260);
    CALL add_score_to_gamerun(@game_run_id,@game_id,@player4_id,390);
    
    # CALL finish_game(@game_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `truncate_all_tables` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `truncate_all_tables`()
BEGIN
	SET FOREIGN_KEY_CHECKS = 0; 
	TRUNCATE TABLE players;
	TRUNCATE TABLE ginrummygames;
	TRUNCATE TABLE ginrummygame_players;
    TRUNCATE TABLE gameruns;
    TRUNCATE TABLE scores;
    TRUNCATE TABLE purchases;
    TRUNCATE TABLE gamerun_targets;
	SET FOREIGN_KEY_CHECKS = 1;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `validate_arguments` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `validate_arguments`(IN gamerun_id_ INT, IN game_id_ INT, IN player_id_ INT)
BEGIN
	IF NOT EXISTS(SELECT player_id FROM ginrummygame_players WHERE player_id=player_id_ AND game_id=game_id_) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Player is not in this game!';
	END IF;
    IF NOT EXISTS(SELECT id FROM gameruns WHERE id=gamerun_id_ AND game=game_id_) THEN
		SIGNAL SQLSTATE '45000'
		SET MESSAGE_TEXT = 'Game run does not exist in this game!';
	END IF;
END ;;
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

-- Dump completed on 2020-03-15  0:45:43
