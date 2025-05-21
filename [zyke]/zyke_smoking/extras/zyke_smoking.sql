CREATE TABLE IF NOT EXISTS `zyke_smoking` (
  `identifier` tinytext DEFAULT NULL,
  `item` tinytext DEFAULT NULL,
  `data` text DEFAULT NULL,
  UNIQUE KEY `identifier` (`identifier`) USING HASH
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;