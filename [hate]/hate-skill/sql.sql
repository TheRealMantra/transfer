CREATE TABLE IF NOT EXISTS `player_skills` (
  `identifier` varchar(255) NOT NULL,
  `charid` varchar(60) NOT NULL DEFAULT '1',
  `level` int(11) NOT NULL DEFAULT 1,
  `xp` int(11) NOT NULL DEFAULT 0,
  `points` int(11) NOT NULL DEFAULT 0,
  `skills` longtext DEFAULT NULL,
  PRIMARY KEY (`identifier`, `charid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
