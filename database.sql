DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `monsters`;
DROP TABLE IF EXISTS `monster_types`;
DROP TABLE IF EXISTS `monster_exp`;
DROP TABLE IF EXISTS `monster_exp_groups`;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user` varchar(12) NOT NULL COMMENT 'in-game name',
  `x` int(11) NOT NULL DEFAULT '0' COMMENT 'last recorded x position',
  `y` int(11) NOT NULL DEFAULT '0' COMMENT 'last recorded y position',
  `facing` varchar(5) NOT NULL DEFAULT 'down' COMMENT 'direction player faces',
  `skin` varchar(20) NOT NULL,
  `state` varchar(20) NOT NULL,
  `map` varchar(30) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE (`user`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`user`, `x`, `y`, `facing`, `skin`, `state`, `map`) VALUES
('Jake', 416, 2960, 'up', 'boy', 'idle', 'RsWorld'),
('Joncom', 416, 2960, 'up', 'girl', 'idle', 'RsWorld'),
('kitti', 256, 224, 'right', 'boy', 'idle', 'RsBattleTower');

--
-- Table structure for table `monster_types`
--

CREATE TABLE IF NOT EXISTS `monster_types` (
  `id` varchar(8) NOT NULL COMMENT 'Type Name',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

--
-- Dumping data for table `monster_types`
--

INSERT INTO `monster_types` (`id`) VALUES('bug');
INSERT INTO `monster_types` (`id`) VALUES('dark');
INSERT INTO `monster_types` (`id`) VALUES('dragon');
INSERT INTO `monster_types` (`id`) VALUES('electric');
INSERT INTO `monster_types` (`id`) VALUES('fighting');
INSERT INTO `monster_types` (`id`) VALUES('fire');
INSERT INTO `monster_types` (`id`) VALUES('flying');
INSERT INTO `monster_types` (`id`) VALUES('ghost');
INSERT INTO `monster_types` (`id`) VALUES('grass');
INSERT INTO `monster_types` (`id`) VALUES('ground');
INSERT INTO `monster_types` (`id`) VALUES('ice');
INSERT INTO `monster_types` (`id`) VALUES('normal');
INSERT INTO `monster_types` (`id`) VALUES('poison');
INSERT INTO `monster_types` (`id`) VALUES('psychic');
INSERT INTO `monster_types` (`id`) VALUES('rock');
INSERT INTO `monster_types` (`id`) VALUES('steel');
INSERT INTO `monster_types` (`id`) VALUES('water');

--
-- Table structure for table `monster_exp_groups`
--

CREATE TABLE IF NOT EXISTS `monster_exp_groups` (
  `group` varchar(15) NOT NULL,
  PRIMARY KEY (`group`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8 COMMENT='Experience Groups';

--
-- Dumping data for table `monster_exp_groups`
--

INSERT INTO `monster_exp_groups` (`group`) VALUES('erratic');
INSERT INTO `monster_exp_groups` (`group`) VALUES('fast');
INSERT INTO `monster_exp_groups` (`group`) VALUES('fluctuating');
INSERT INTO `monster_exp_groups` (`group`) VALUES('medium_fast');
INSERT INTO `monster_exp_groups` (`group`) VALUES('medium_slow');
INSERT INTO `monster_exp_groups` (`group`) VALUES('slow');

--
-- Table structure for table `monster_exp`
--

CREATE TABLE IF NOT EXISTS `monster_exp` (
  `level` tinyint(4) NOT NULL,
  `group` varchar(11) NOT NULL,
  `next_level` mediumint(9) NOT NULL,
  `total` mediumint(9) NOT NULL,
  FOREIGN KEY (`group`) REFERENCES monster_exp_groups(`group`),
  UNIQUE KEY `no_duplicates` (`level`,`group`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8 COMMENT='Experience Table';

--
-- Table structure for table `monsters`
--

CREATE TABLE IF NOT EXISTS `monsters` (
  `id` smallint(6) NOT NULL COMMENT 'National Number',
  `hoenn_id` smallint(6) NOT NULL COMMENT 'Hoenn Number',
  `name` varchar(15) NOT NULL,
  `percent_male` float NOT NULL,
  `percent_female` float NOT NULL,
  `class` int(11) NOT NULL COMMENT 'Classification',
  `type_1` varchar(8) NOT NULL,
  `type_2` varchar(8),
  `height` varchar(15) NOT NULL,
  `weight` varchar(15) NOT NULL,
  `colour` varchar(15) NOT NULL COMMENT 'Colour Category',
  `base_hp` int(11) NOT NULL COMMENT 'Base Hit Points',
  `base_atk` int(11) NOT NULL COMMENT 'Base Attack',
  `base_def` int(11) NOT NULL COMMENT 'Base Defense',
  `base_sp_atk` int(11) NOT NULL COMMENT 'Base Special Attack',
  `base_sp_def` int(11) NOT NULL COMMENT 'Base Special Defense',
  `base_spd` int(11) NOT NULL COMMENT 'Base Speed',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`type_1`) REFERENCES monster_types(`id`),
  FOREIGN KEY (`type_2`) REFERENCES monster_types(`id`),
  UNIQUE KEY `hoenn_id` (`hoenn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;
