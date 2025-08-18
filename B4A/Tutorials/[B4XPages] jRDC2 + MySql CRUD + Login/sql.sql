-- --------------------------------------------------------
-- Host:                         localhost
-- Versión del servidor:         5.7.24 - MySQL Community Server (GPL)
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.1.0.6116
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para b4x
CREATE DATABASE IF NOT EXISTS `b4x` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `b4x`;

-- Volcando estructura para tabla b4x.events
CREATE TABLE IF NOT EXISTS `events` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `month` varchar(50) NOT NULL COMMENT 'change to type date',
  `event_type` varchar(25) NOT NULL,
  `description` varchar(100) NOT NULL,
  `value` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=88 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla b4x.events: ~49 rows (aproximadamente)
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` (`id`, `id_user`, `month`, `event_type`, `description`, `value`) VALUES
	(6, 1, 'February', 'party', 'Description user: 1; month: February; type: party', 3),
	(7, 1, 'February', 'holiday', 'Description user: 1; month: February; type: holiday', 6),
	(9, 1, 'February', 'work', 'Description user: 1; month: February; type: work', 3),
	(10, 1, 'February', 'party', 'Description user: 1; month: February; type: party', 2),
	(15, 1, 'March', 'holiday', 'Description user: 1; month: March; type: holiday', 7),
	(16, 1, 'March', 'work', 'Description user: 1; month: March; type: work', 5),
	(17, 1, 'March', 'work', 'Description user: 1; month: March; type: work', 3),
	(19, 2, 'January', 'work', 'Description user: 2; month: January; type: work', 3),
	(20, 2, 'January', 'party', 'Description user: 2; month: January; type: party', 5),
	(21, 2, 'January', 'holiday', 'Description user: 2; month: January; type: holiday', 67),
	(22, 2, 'January', 'work', 'Description user: 2; month: January; type: work', 7),
	(23, 2, 'February', 'work', 'Description user: 2; month: February; type: work', 3),
	(24, 2, 'February', 'party', 'Description user: 2; month: February; type: party', 4),
	(25, 2, 'February', 'holiday', 'Description user: 2; month: February; type: holiday', 2),
	(26, 2, 'February', 'work', 'Description user: 2; month: February; type: work', 1),
	(27, 2, 'February', 'work', 'Description user: 2; month: February; type: work', 3),
	(28, 2, 'February', 'party', 'Description user: 2; month: February; type: party', 4),
	(29, 2, 'March', 'holiday', 'Description user: 2; month: March; type: holiday', 6),
	(30, 2, 'March', 'work', 'Description user: 2; month: March; type: work', 7),
	(31, 2, 'March', 'work', 'Description user: 2; month: March; type: work', 4),
	(32, 2, 'March', 'party', 'Description user: 2; month: March; type: party', 2),
	(33, 2, 'March', 'holiday', 'Description user: 2; month: March; type: holiday', 3),
	(34, 2, 'March', 'work', 'Description user: 2; month: March; type: work', 3),
	(35, 2, 'March', 'work', 'Description user: 2; month: March; type: work', 5),
	(36, 2, 'March', 'party', 'Description user: 2; month: March; type: party', 6),
	(37, 3, 'January', 'work', 'Description user: 3; month: January; type: work', 7),
	(38, 3, 'January', 'party', 'Description user: 3; month: January; type: party', 8),
	(39, 3, 'January', 'holiday', 'Description user: 3; month: January; type: holiday', 3),
	(40, 3, 'January', 'work', 'Description user: 3; month: January; type: work', 2),
	(41, 3, 'February', 'work', 'Description user: 3; month: February; type: work', 3),
	(42, 3, 'February', 'party', 'Description user: 3; month: February; type: party', 3),
	(43, 3, 'February', 'holiday', 'Description user: 3; month: February; type: holiday', 1),
	(44, 3, 'February', 'work', 'Description user: 3; month: February; type: work', 2),
	(45, 3, 'February', 'work', 'Description user: 3; month: February; type: work', 5),
	(46, 3, 'February', 'party', 'Description user: 3; month: February; type: party', 2),
	(47, 3, 'March', 'holiday', 'Description user: 3; month: March; type: holiday', 5),
	(48, 3, 'March', 'work', 'Description user: 3; month: March; type: work', 1),
	(49, 3, 'March', 'party', 'Description user: 3; month: March; type: party', 6),
	(50, 3, 'March', 'holiday', 'Description user: 3; month: March; type: holiday', 7),
	(51, 3, 'March', 'work', 'Description user: 3; month: March; type: work', 8),
	(52, 3, 'March', 'work', 'Description user: 3; month: March; type: work', 9),
	(53, 3, 'March', 'party', 'Description user: 3; month: March; type: party', 0),
	(80, 1, 'January', 'party', 'Description user: 1; month: January; type: party', 3),
	(81, 1, 'January', 'holiday', 'Description user: 1; month: January; type: holiday', 6),
	(82, 1, 'January', 'work', 'Description user: 1; month: January; type: work', 3),
	(83, 1, 'January', 'party', 'Description user: 1; month: January; type: party', 2),
	(86, 1, 'January', 'holiday', 'Description user: 1; month: January; type: holiday', 100),
	(87, 1, 'March', 'holiday', 'Description user: 1; month: March; type: holiday', 1);
/*!40000 ALTER TABLE `events` ENABLE KEYS */;

-- Volcando estructura para tabla b4x.users
CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` text NOT NULL,
  `password` text NOT NULL,
  `name` varchar(50) NOT NULL,
  `surname` varchar(50) NOT NULL,
  `level` int(11) NOT NULL,
  `active` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla b4x.users: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` (`id`, `username`, `password`, `name`, `surname`, `level`, `active`) VALUES
	(1, 'jose@spain.es', md5('1234'), 'Jose J.', 'Aguilar', 1, 1),
	(2, 'user@b4x.com', md5('1234'), 'User', 'Surname', 1, 1),
	(3, 'user@gmail.com', md5('1234'), 'User', 'Gmail', 1, 1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
