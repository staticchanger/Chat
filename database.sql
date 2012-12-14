DROP TABLE IF EXISTS `items`;
DROP TABLE IF EXISTS `item_types`;
DROP TABLE IF EXISTS `users`;
DROP TABLE IF EXISTS `monsters`;
DROP TABLE IF EXISTS `attacks`;
DROP TABLE IF EXISTS `attack_types`;
DROP TABLE IF EXISTS `attack_elements`;
DROP TABLE IF EXISTS `experience`;
DROP TABLE IF EXISTS `experience_groups`;

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
-- Table structure for table `item_types`
--

CREATE TABLE IF NOT EXISTS `item_types` (
  `id` smallint(6) NOT NULL,
  /* Reduce VARCHAR after data entry. */
  `name` varchar(15) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

--
-- Table structure for table `items`
--

CREATE TABLE IF NOT EXISTS `items` (
  `id` smallint(6) UNSIGNED NOT NULL AUTO_INCREMENT,
  /* Reduce VARCHAR after data entry. */
  `name` varchar(20) NOT NULL,
  /* Reduce VARCHAR after data entry. */
  `description` varchar(140) NOT NULL,
  `type_id` smallint(6) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`type_id`) REFERENCES item_types(`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

--
-- Table structure for table `attack_elements`
--

CREATE TABLE IF NOT EXISTS `attack_elements` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(8) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8 AUTO_INCREMENT=18 ;

--
-- Dumping data for table `attack_elements`
--

INSERT INTO `attack_elements` (`id`, `name`) VALUES(1, 'bug');
INSERT INTO `attack_elements` (`id`, `name`) VALUES(2, 'dark');
INSERT INTO `attack_elements` (`id`, `name`) VALUES(3, 'dragon');
INSERT INTO `attack_elements` (`id`, `name`) VALUES(4, 'electric');
INSERT INTO `attack_elements` (`id`, `name`) VALUES(5, 'fighting');
INSERT INTO `attack_elements` (`id`, `name`) VALUES(6, 'fire');
INSERT INTO `attack_elements` (`id`, `name`) VALUES(7, 'flying');
INSERT INTO `attack_elements` (`id`, `name`) VALUES(8, 'ghost');
INSERT INTO `attack_elements` (`id`, `name`) VALUES(9, 'grass');
INSERT INTO `attack_elements` (`id`, `name`) VALUES(10, 'ground');
INSERT INTO `attack_elements` (`id`, `name`) VALUES(11, 'ice');
INSERT INTO `attack_elements` (`id`, `name`) VALUES(12, 'normal');
INSERT INTO `attack_elements` (`id`, `name`) VALUES(13, 'poison');
INSERT INTO `attack_elements` (`id`, `name`) VALUES(14, 'psychic');
INSERT INTO `attack_elements` (`id`, `name`) VALUES(15, 'rock');
INSERT INTO `attack_elements` (`id`, `name`) VALUES(16, 'steel');
INSERT INTO `attack_elements` (`id`, `name`) VALUES(17, 'water');

--
-- Table structure for table `experience_groups`
--

CREATE TABLE IF NOT EXISTS `experience_groups` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8 COMMENT='Experience Groups' AUTO_INCREMENT=7 ;

--
-- Dumping data for table `experience_groups`
--

INSERT INTO `experience_groups` (`id`, `name`) VALUES(1, 'erratic');
INSERT INTO `experience_groups` (`id`, `name`) VALUES(2, 'fast');
INSERT INTO `experience_groups` (`id`, `name`) VALUES(3, 'fluctuating');
INSERT INTO `experience_groups` (`id`, `name`) VALUES(4, 'medium_fast');
INSERT INTO `experience_groups` (`id`, `name`) VALUES(5, 'medium_slow');
INSERT INTO `experience_groups` (`id`, `name`) VALUES(6, 'slow');

--
-- Table structure for table `experience`
--

CREATE TABLE IF NOT EXISTS `experience` (
  `level` tinyint(4) NOT NULL,
  `group_id` tinyint(4) NOT NULL,
  `next_level` mediumint(9) NOT NULL,
  `total` mediumint(9) NOT NULL,
  FOREIGN KEY (`group_id`) REFERENCES experience_groups(`id`),
  UNIQUE KEY `no_duplicates` (`level`,`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8 COMMENT='Experience Table';

--
-- Dumping data for table `experience`
--

INSERT INTO `experience` (`level`, `group_id`, `next_level`, `total`) VALUES
(1, 1, 15, 0),
(1, 2, 6, 0),
(1, 3, 4, 0),
(1, 4, 8, 0),
(1, 5, 9, 0),
(1, 6, 10, 0),
(2, 1, 37, 15),
(2, 2, 15, 6),
(2, 3, 9, 4),
(2, 4, 19, 8),
(2, 5, 48, 9),
(2, 6, 23, 10),
(3, 1, 70, 52),
(3, 2, 30, 21),
(3, 3, 19, 13),
(3, 4, 37, 27),
(3, 5, 39, 57),
(3, 6, 47, 33),
(4, 1, 115, 122),
(4, 2, 49, 51),
(4, 3, 33, 32),
(4, 4, 61, 64),
(4, 5, 39, 96),
(4, 6, 76, 80),
(5, 1, 169, 237),
(5, 2, 72, 100),
(5, 3, 47, 65),
(5, 4, 91, 125),
(5, 5, 44, 135),
(5, 6, 114, 156),
(6, 1, 231, 406),
(6, 2, 102, 172),
(6, 3, 66, 112),
(6, 4, 127, 216),
(6, 5, 57, 179),
(6, 6, 158, 270),
(7, 1, 305, 637),
(7, 2, 135, 274),
(7, 3, 98, 178),
(7, 4, 169, 343),
(7, 5, 78, 236),
(7, 6, 212, 428),
(8, 1, 384, 942),
(8, 2, 174, 409),
(8, 3, 117, 276),
(8, 4, 217, 512),
(8, 5, 105, 314),
(8, 6, 271, 640),
(9, 1, 474, 1326),
(9, 2, 217, 583),
(9, 3, 147, 393),
(9, 4, 271, 729),
(9, 5, 141, 419),
(9, 6, 339, 911),
(10, 1, 569, 1800),
(10, 2, 264, 800),
(10, 3, 205, 540),
(10, 4, 331, 1000),
(10, 5, 182, 560),
(10, 6, 413, 1250),
(11, 1, 672, 2369),
(11, 2, 318, 1064),
(11, 3, 222, 745),
(11, 4, 397, 1331),
(11, 5, 231, 742),
(11, 6, 497, 1663),
(12, 1, 781, 3041),
(12, 2, 375, 1382),
(12, 3, 263, 967),
(12, 4, 469, 1728),
(12, 5, 288, 973),
(12, 6, 586, 2160),
(13, 1, 897, 3822),
(13, 2, 438, 1757),
(13, 3, 361, 1230),
(13, 4, 547, 2197),
(13, 5, 351, 1261),
(13, 6, 684, 2746),
(14, 1, 1018, 4719),
(14, 2, 505, 2195),
(14, 3, 366, 1591),
(14, 4, 631, 2744),
(14, 5, 423, 1612),
(14, 6, 788, 3430),
(15, 1, 1144, 5737),
(15, 2, 576, 2700),
(15, 3, 500, 1957),
(15, 4, 721, 3375),
(15, 5, 500, 2035),
(15, 6, 902, 4218),
(16, 1, 1274, 6881),
(16, 2, 654, 3276),
(16, 3, 589, 2457),
(16, 4, 817, 4096),
(16, 5, 585, 2535),
(16, 6, 1021, 5120),
(17, 1, 1409, 8155),
(17, 2, 735, 3930),
(17, 3, 686, 3046),
(17, 4, 919, 4913),
(17, 5, 678, 3120),
(17, 6, 1149, 6141),
(18, 1, 1547, 9564),
(18, 2, 822, 4665),
(18, 3, 794, 3732),
(18, 4, 1027, 5832),
(18, 5, 777, 3798),
(18, 6, 1283, 7290),
(19, 1, 1689, 11111),
(19, 2, 913, 5487),
(19, 3, 914, 4526),
(19, 4, 1141, 6859),
(19, 5, 885, 4575),
(19, 6, 1427, 8573),
(20, 1, 1832, 12800),
(20, 2, 1008, 6400),
(20, 3, 1042, 5440),
(20, 4, 1261, 8000),
(20, 5, 998, 5460),
(20, 6, 1576, 10000),
(21, 1, 1978, 14632),
(21, 2, 1110, 7408),
(21, 3, 1184, 6482),
(21, 4, 1387, 9261),
(21, 5, 1119, 6458),
(21, 6, 1734, 11576),
(22, 1, 2127, 16610),
(22, 2, 1215, 8518),
(22, 3, 1337, 7666),
(22, 4, 1519, 10648),
(22, 5, 1248, 7577),
(22, 6, 1898, 13310),
(23, 1, 2275, 18737),
(23, 2, 1326, 9733),
(23, 3, 1503, 9003),
(23, 4, 1657, 12167),
(23, 5, 1383, 8825),
(23, 6, 2072, 15208),
(24, 1, 2425, 21012),
(24, 2, 1441, 11059),
(24, 3, 1681, 10506),
(24, 4, 1801, 13824),
(24, 5, 1527, 10208),
(24, 6, 2251, 17280),
(25, 1, 2575, 23437),
(25, 2, 1560, 12500),
(25, 3, 1873, 12187),
(25, 4, 1951, 15625),
(25, 5, 1676, 11735),
(25, 6, 2439, 19531),
(26, 1, 2725, 26012),
(26, 2, 1686, 14060),
(26, 3, 2080, 14060),
(26, 4, 2107, 17576),
(26, 5, 1833, 13411),
(26, 6, 2633, 21970),
(27, 1, 2873, 28737),
(27, 2, 1815, 15746),
(27, 3, 2299, 16140),
(27, 4, 2269, 19683),
(27, 5, 1998, 15244),
(27, 6, 2837, 24603),
(28, 1, 3022, 31610),
(28, 2, 1950, 17561),
(28, 3, 2535, 18439),
(28, 4, 2437, 21952),
(28, 5, 2169, 17242),
(28, 6, 3046, 27440),
(29, 1, 3168, 34632),
(29, 2, 2089, 19511),
(29, 3, 2786, 20974),
(29, 4, 2611, 24389),
(29, 5, 2349, 19411),
(29, 6, 3264, 30486),
(30, 1, 3311, 37800),
(30, 2, 2232, 21600),
(30, 3, 3051, 23760),
(30, 4, 2791, 27000),
(30, 5, 2534, 21760),
(30, 6, 3488, 33750),
(31, 1, 3453, 41111),
(31, 2, 2382, 23832),
(31, 3, 3335, 26811),
(31, 4, 2977, 29791),
(31, 5, 2727, 24294),
(31, 6, 3722, 37238),
(32, 1, 3591, 44564),
(32, 2, 2535, 26214),
(32, 3, 3634, 30146),
(32, 4, 3169, 32768),
(32, 5, 2928, 27021),
(32, 6, 3961, 40960),
(33, 1, 3726, 48155),
(33, 2, 2694, 28749),
(33, 3, 3951, 33780),
(33, 4, 3367, 35937),
(33, 5, 3135, 29949),
(33, 6, 4209, 44921),
(34, 1, 3856, 51881),
(34, 2, 2857, 31443),
(34, 3, 4286, 37731),
(34, 4, 3571, 39304),
(34, 5, 3351, 33084),
(34, 6, 4463, 49130),
(35, 1, 3982, 55737),
(35, 2, 3024, 34300),
(35, 3, 4639, 42017),
(35, 4, 3781, 42875),
(35, 5, 3572, 36435),
(35, 6, 4727, 53593),
(36, 1, 4103, 59719),
(36, 2, 3198, 37324),
(36, 3, 3997, 46656),
(36, 4, 3997, 46656),
(36, 5, 3801, 40007),
(36, 6, 4996, 58320),
(37, 1, 4219, 63822),
(37, 2, 3375, 40522),
(37, 3, 5316, 50653),
(37, 4, 4219, 50653),
(37, 5, 4038, 43808),
(37, 6, 5274, 63316),
(38, 1, 4328, 68041),
(38, 2, 3558, 43897),
(38, 3, 4536, 55969),
(38, 4, 4447, 54872),
(38, 5, 4281, 47846),
(38, 6, 5558, 68590),
(39, 1, 4431, 72369),
(39, 2, 3745, 47455),
(39, 3, 6055, 60505),
(39, 4, 4681, 59319),
(39, 5, 4533, 52127),
(39, 6, 5852, 74148),
(40, 1, 4526, 76800),
(40, 2, 3936, 51200),
(40, 3, 5117, 66560),
(40, 4, 4921, 64000),
(40, 5, 4790, 56660),
(40, 6, 6151, 80000),
(41, 1, 4616, 81326),
(41, 2, 4134, 55136),
(41, 3, 6856, 71677),
(41, 4, 5167, 68921),
(41, 5, 5055, 61450),
(41, 6, 6459, 86151),
(42, 1, 4695, 85942),
(42, 2, 4335, 59270),
(42, 3, 5744, 78533),
(42, 4, 5419, 74088),
(42, 5, 5328, 66505),
(42, 6, 6773, 92610),
(43, 1, 4769, 90637),
(43, 2, 4542, 63605),
(43, 3, 7721, 84277),
(43, 4, 5677, 79507),
(43, 5, 5607, 71833),
(43, 6, 7097, 99383),
(44, 1, 4831, 95406),
(44, 2, 4753, 68147),
(44, 3, 6417, 91998),
(44, 4, 5941, 85184),
(44, 5, 5895, 77440),
(44, 6, 7426, 106480),
(45, 1, 4885, 100237),
(45, 2, 4968, 72900),
(45, 3, 8654, 98415),
(45, 4, 6211, 91125),
(45, 5, 6188, 83335),
(45, 6, 7764, 113906),
(46, 1, 4930, 105122),
(46, 2, 5190, 77868),
(46, 3, 7136, 107069),
(46, 4, 6487, 97336),
(46, 5, 6489, 89523),
(46, 6, 8108, 121670),
(47, 1, 4963, 110052),
(47, 2, 5415, 83058),
(47, 3, 9658, 114205),
(47, 4, 6769, 103823),
(47, 5, 6798, 96012),
(47, 6, 8462, 129778),
(48, 1, 4986, 115015),
(48, 2, 5646, 88473),
(48, 3, 7903, 123863),
(48, 4, 7057, 110592),
(48, 5, 7113, 102810),
(48, 6, 8821, 138240),
(49, 1, 4999, 120001),
(49, 2, 5881, 94119),
(49, 3, 10734, 131766),
(49, 4, 7351, 117649),
(49, 5, 7437, 109923),
(49, 6, 9189, 147061),
(50, 1, 6324, 125000),
(50, 2, 6120, 100000),
(50, 3, 8722, 142500),
(50, 4, 7651, 125000),
(50, 5, 7766, 117360),
(50, 6, 9563, 156250),
(51, 1, 6471, 131324),
(51, 2, 6366, 106120),
(51, 3, 11883, 151222),
(51, 4, 7957, 132651),
(51, 5, 8103, 125126),
(51, 6, 9947, 165813),
(52, 1, 6615, 137795),
(52, 2, 6615, 112486),
(52, 3, 9592, 163105),
(52, 4, 8269, 140608),
(52, 5, 8448, 133229),
(52, 6, 10336, 175760),
(53, 1, 6755, 144410),
(53, 2, 6870, 119101),
(53, 3, 13110, 172697),
(53, 4, 8587, 148877),
(53, 5, 8799, 141677),
(53, 6, 10734, 186096),
(54, 1, 6891, 151165),
(54, 2, 7129, 125971),
(54, 3, 10515, 185807),
(54, 4, 8911, 157464),
(54, 5, 9159, 150476),
(54, 6, 11138, 196830),
(55, 1, 7023, 158056),
(55, 2, 7392, 133100),
(55, 3, 14417, 196322),
(55, 4, 9241, 166375),
(55, 5, 9524, 159635),
(55, 6, 11552, 207968),
(56, 1, 7150, 165079),
(56, 2, 7662, 140492),
(56, 3, 11492, 210739),
(56, 4, 9577, 175616),
(56, 5, 9897, 169159),
(56, 6, 11971, 219520),
(57, 1, 7274, 172229),
(57, 2, 7935, 148154),
(57, 3, 15805, 222231),
(57, 4, 9919, 185193),
(57, 5, 10278, 179056),
(57, 6, 12399, 231491),
(58, 1, 7391, 179503),
(58, 2, 8214, 156089),
(58, 3, 12526, 238036),
(58, 4, 10267, 195112),
(58, 5, 10665, 189334),
(58, 6, 12833, 243890),
(59, 1, 7506, 186894),
(59, 2, 8497, 164303),
(59, 3, 17278, 250562),
(59, 4, 10621, 205379),
(59, 5, 11061, 199999),
(59, 6, 13277, 256723),
(60, 1, 7613, 194400),
(60, 2, 8784, 172800),
(60, 3, 13616, 267840),
(60, 4, 10981, 216000),
(60, 5, 11462, 211060),
(60, 6, 13726, 270000),
(61, 1, 7715, 202013),
(61, 2, 9078, 181584),
(61, 3, 18837, 281456),
(61, 4, 11347, 226981),
(61, 5, 11871, 222522),
(61, 6, 14184, 283726),
(62, 1, 7812, 209728),
(62, 2, 9375, 190662),
(62, 3, 14766, 300293),
(62, 4, 11719, 238328),
(62, 5, 12288, 234393),
(62, 6, 14648, 297910),
(63, 1, 7903, 217540),
(63, 2, 9678, 200037),
(63, 3, 20485, 315059),
(63, 4, 12097, 250047),
(63, 5, 12711, 246681),
(63, 6, 15122, 312558),
(64, 1, 7988, 225443),
(64, 2, 9985, 209715),
(64, 3, 15976, 335544),
(64, 4, 12481, 262144),
(64, 5, 13143, 259392),
(64, 6, 15601, 327680),
(65, 1, 8065, 233431),
(65, 2, 10296, 219700),
(65, 3, 22224, 351520),
(65, 4, 12871, 274625),
(65, 5, 13580, 272535),
(65, 6, 16089, 343281),
(66, 1, 8137, 241496),
(66, 2, 10614, 229996),
(66, 3, 17247, 373744),
(66, 4, 13267, 287496),
(66, 5, 14025, 286115),
(66, 6, 16583, 359370),
(67, 1, 8201, 249633),
(67, 2, 10935, 240610),
(67, 3, 24059, 390991),
(67, 4, 13669, 300763),
(67, 5, 14478, 300140),
(67, 6, 17087, 375953),
(68, 1, 9572, 257834),
(68, 2, 11262, 251545),
(68, 3, 18581, 415050),
(68, 4, 14077, 314432),
(68, 5, 14937, 314618),
(68, 6, 17596, 393040),
(69, 1, 9052, 267406),
(69, 2, 11593, 262807),
(69, 3, 25989, 433631),
(69, 4, 14491, 328509),
(69, 5, 15405, 329555),
(69, 6, 18114, 410636),
(70, 1, 9870, 276458),
(70, 2, 11928, 274400),
(70, 3, 19980, 459620),
(70, 4, 14911, 343000),
(70, 5, 15878, 344960),
(70, 6, 18638, 428750),
(71, 1, 10030, 286328),
(71, 2, 12270, 286328),
(71, 3, 28017, 479600),
(71, 4, 15337, 357911),
(71, 5, 16359, 360838),
(71, 6, 19172, 447388),
(72, 1, 9409, 296358),
(72, 2, 12615, 298598),
(72, 3, 21446, 507617),
(72, 4, 15769, 373248),
(72, 5, 16848, 377197),
(72, 6, 19711, 466560),
(73, 1, 10307, 305767),
(73, 2, 12966, 311213),
(73, 3, 30146, 529063),
(73, 4, 16207, 389017),
(73, 5, 17343, 394045),
(73, 6, 20259, 486271),
(74, 1, 10457, 316074),
(74, 2, 13321, 324179),
(74, 3, 22978, 559209),
(74, 4, 16651, 405224),
(74, 5, 17847, 411388),
(74, 6, 20813, 506530),
(75, 1, 9724, 326531),
(75, 2, 13680, 337500),
(75, 3, 32379, 582187),
(75, 4, 17101, 421875),
(75, 5, 18356, 429235),
(75, 6, 21377, 527343),
(76, 1, 10710, 336255),
(76, 2, 14046, 351180),
(76, 3, 24580, 614566),
(76, 4, 17557, 438976),
(76, 5, 18873, 447591),
(76, 6, 21946, 548720),
(77, 1, 10847, 346965),
(77, 2, 14415, 365226),
(77, 3, 34717, 639146),
(77, 4, 18019, 456533),
(77, 5, 19398, 466464),
(77, 6, 22524, 570666),
(78, 1, 9995, 357812),
(78, 2, 14790, 379641),
(78, 3, 26252, 673863),
(78, 4, 18487, 474552),
(78, 5, 19929, 485862),
(78, 6, 23108, 593190),
(79, 1, 11073, 367807),
(79, 2, 15169, 394431),
(79, 3, 37165, 700115),
(79, 4, 18961, 493039),
(79, 5, 20469, 505791),
(79, 6, 23702, 616298),
(80, 1, 11197, 378880),
(80, 2, 15552, 409600),
(80, 3, 27995, 737280),
(80, 4, 19441, 512000),
(80, 5, 21014, 526260),
(80, 6, 24301, 640000),
(81, 1, 10216, 390077),
(81, 2, 15942, 425152),
(81, 3, 39722, 765275),
(81, 4, 19927, 531441),
(81, 5, 21567, 547274),
(81, 6, 24909, 664301),
(82, 1, 11393, 400293),
(82, 2, 16335, 441094),
(82, 3, 29812, 804997),
(82, 4, 20419, 551368),
(82, 5, 22128, 568841),
(82, 6, 25523, 689210),
(83, 1, 11504, 411686),
(83, 2, 16734, 457429),
(83, 3, 42392, 834809),
(83, 4, 20917, 571787),
(83, 5, 22695, 590969),
(83, 6, 26147, 714733),
(84, 1, 10382, 423190),
(84, 2, 17137, 474163),
(84, 3, 31704, 877201),
(84, 4, 21421, 592704),
(84, 5, 23271, 613664),
(84, 6, 26776, 740880),
(85, 1, 11667, 433572),
(85, 2, 17544, 491300),
(85, 3, 45179, 908905),
(85, 4, 21931, 614125),
(85, 5, 23852, 636935),
(85, 6, 27414, 767656),
(86, 1, 11762, 445239),
(86, 2, 17958, 508844),
(86, 3, 33670, 954084),
(86, 4, 22447, 636056),
(86, 5, 24441, 660787),
(86, 6, 28058, 795070),
(87, 1, 10488, 457001),
(87, 2, 18375, 526802),
(87, 3, 48083, 987754),
(87, 4, 22969, 658503),
(87, 5, 25038, 685228),
(87, 6, 28712, 823128),
(88, 1, 11889, 467489),
(88, 2, 18798, 545177),
(88, 3, 35715, 1035837),
(88, 4, 23497, 681472),
(88, 5, 25641, 710266),
(88, 6, 29371, 851840),
(89, 1, 11968, 479378),
(89, 2, 19225, 563975),
(89, 3, 51108, 1071552),
(89, 4, 24031, 704969),
(89, 5, 26253, 735907),
(89, 6, 30039, 881211),
(90, 1, 10532, 491346),
(90, 2, 19656, 583200),
(90, 3, 37839, 1122660),
(90, 4, 24571, 729000),
(90, 5, 26870, 762160),
(90, 6, 30713, 911250),
(91, 1, 12056, 501878),
(91, 2, 20094, 602856),
(91, 3, 54254, 1160499),
(91, 4, 25117, 753571),
(91, 5, 27495, 789030),
(91, 6, 31397, 941963),
(92, 1, 12115, 513934),
(92, 2, 20535, 622950),
(92, 3, 40043, 1214753),
(92, 4, 25669, 778688),
(92, 5, 28128, 816525),
(92, 6, 32086, 973360),
(93, 1, 10508, 526049),
(93, 2, 20982, 643485),
(93, 3, 57526, 1254796),
(93, 4, 26227, 804357),
(93, 5, 28767, 844653),
(93, 6, 32784, 1005446),
(94, 1, 12163, 536557),
(94, 2, 21433, 664467),
(94, 3, 42330, 1312322),
(94, 4, 26791, 830584),
(94, 5, 29415, 873420),
(94, 6, 33488, 1038230),
(95, 1, 12202, 548720),
(95, 2, 21888, 685900),
(95, 3, 60925, 1354652),
(95, 4, 27361, 857375),
(95, 5, 30068, 902835),
(95, 6, 34202, 1071718),
(96, 1, 10411, 560922),
(96, 2, 22350, 707788),
(96, 3, 44699, 1415577),
(96, 4, 27937, 884736),
(96, 5, 30729, 932903),
(96, 6, 34921, 1105920),
(97, 1, 12206, 571333),
(97, 2, 22815, 730138),
(97, 3, 64455, 1460276),
(97, 4, 28519, 912673),
(97, 5, 31398, 963632),
(97, 6, 35649, 1140841),
(98, 1, 8343, 583539),
(98, 2, 23286, 752953),
(98, 3, 47153, 1524731),
(98, 4, 29107, 941192),
(98, 5, 32073, 995030),
(98, 6, 36383, 1176490),
(99, 1, 8118, 591882),
(99, 2, 23761, 776239),
(99, 3, 68116, 1571884),
(99, 4, 29701, 970299),
(99, 5, 32757, 1027103),
(99, 6, 37127, 1212873),
(100, 1, 0, 600000),
(100, 2, 0, 800000),
(100, 3, 0, 1640000),
(100, 4, 0, 1000000),
(100, 5, 0, 1059860),
(100, 6, 0, 1250000);

--
-- Table structure for table `attack_types`
--

CREATE TABLE IF NOT EXISTS `attack_types` (
  `id` tinyint(4) NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=UTF8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `attack_types`
--

INSERT INTO `attack_types` (`id`, `name`) VALUES
(0, 'physical'),
(1, 'special'),
(2, 'status');

--
-- Table structure for table `attacks`
--

CREATE TABLE IF NOT EXISTS `attacks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(12) NOT NULL,
  `element_id` tinyint(4) NOT NULL,
  `type_id` tinyint(4) NOT NULL COMMENT 'Effect Category',
  `power` tinyint(4) DEFAULT NULL,
  `accuracy` tinyint(4) DEFAULT NULL,
  `pp` tinyint(4) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`element_id`) REFERENCES attack_elements(`id`),
  FOREIGN KEY (`type_id`) REFERENCES attack_types(`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8 AUTO_INCREMENT=104 ;

--
-- Dumping data for table `attacks`
--

INSERT INTO `attacks` (`id`, `name`, `element_id`, `type_id`, `power`, `accuracy`, `pp`) VALUES
(1, 'Aerial Ace', 7, 3, 60, -1, 20),
(2, 'Air Cutter', 7, 1, 55, 95, 25),
(3, 'Arm Thrust', 5, 3, 15, 100, 20),
(4, 'Aromatherapy', 9, 2, NULL, NULL, 5),
(5, 'Assist', 12, 2, NULL, NULL, 20),
(6, 'Astonish', 8, 3, 30, 100, 15),
(7, 'Blast Burn', 6, 1, 127, 90, 5),
(8, 'Blaze Kick', 6, 3, 85, 90, 10),
(9, 'Block', 12, 2, NULL, NULL, 5),
(10, 'Bounce', 7, 3, 85, 85, 5),
(11, 'Brick Break', 5, 3, 75, 100, 30),
(12, 'Bulk Up', 5, 2, NULL, NULL, 20),
(13, 'Bullet Seed', 9, 3, 25, 100, 30),
(14, 'Calm Mind', 14, 2, NULL, NULL, 20),
(15, 'Camouflage', 12, 2, NULL, NULL, 20),
(16, 'Charge', 4, 2, NULL, NULL, 20),
(17, 'Cosmic Power', 14, 2, NULL, NULL, 20),
(18, 'Covet', 12, 3, 60, 100, 40),
(19, 'Crush Claw', 12, 3, 75, 95, 10),
(20, 'Dive', 17, 3, 80, 100, 10),
(21, 'Doom Desire', 16, 1, 127, 100, 5),
(22, 'Dragon Claw', 3, 3, 80, 100, 15),
(23, 'Dragon Dance', 3, 2, NULL, NULL, 20),
(24, 'Endeavor', 12, 3, NULL, 100, 5),
(25, 'Eruption', 6, 1, 127, 100, 5),
(26, 'Extrasensory', 14, 1, 80, 100, 30),
(27, 'Facade', 12, 3, 70, 100, 20),
(28, 'Fake Out', 12, 3, 40, 100, 10),
(29, 'Fake Tears', 2, 2, NULL, 100, 20),
(30, 'FeatherDance', 7, 2, NULL, 100, 15),
(31, 'Flatter', 2, 2, NULL, 100, 15),
(32, 'Focus Punch', 5, 3, 127, 100, 20),
(33, 'Follow Me', 12, 2, NULL, NULL, 20),
(34, 'Frenzy Plant', 9, 1, 127, 90, 5),
(35, 'GrassWhistle', 9, 2, NULL, 55, 15),
(36, 'Grudge', 8, 2, NULL, NULL, 5),
(37, 'Hail', 11, 2, NULL, NULL, 10),
(38, 'Heat Wave', 6, 1, 100, 90, 10),
(39, 'Helping Hand', 12, 2, NULL, NULL, 20),
(40, 'Howl', 12, 2, NULL, NULL, 40),
(41, 'Hydro Cannon', 17, 1, 127, 90, 5),
(42, 'Hyper Voice', 12, 1, 90, 100, 10),
(43, 'Ice Ball', 11, 3, 30, 90, 20),
(44, 'Icicle Spear', 11, 3, 25, 100, 30),
(45, 'Imprison', 14, 2, NULL, NULL, 10),
(46, 'Ingrain', 9, 2, NULL, NULL, 20),
(47, 'Iron Defense', 16, 2, NULL, NULL, 15),
(48, 'Knock Off', 2, 3, 20, 100, 20),
(49, 'Leaf Blade', 9, 3, 90, 100, 15),
(50, 'Luster Purge', 14, 1, 70, 100, 5),
(51, 'Magic Coat', 14, 2, NULL, NULL, 15),
(52, 'Magical Leaf', 9, 1, 60, -1, 20),
(53, 'Memento', 2, 2, NULL, 100, 10),
(54, 'Metal Sound', 16, 2, NULL, 85, 40),
(55, 'Meteor Mash', 16, 3, 100, 85, 10),
(56, 'Mist Ball', 14, 1, 70, 100, 5),
(57, 'Mud Shot', 10, 1, 55, 95, 15),
(58, 'Mud Sport', 10, 2, NULL, NULL, 15),
(59, 'Muddy Water', 17, 1, 95, 85, 10),
(60, 'Nature Power', 12, 2, NULL, NULL, 20),
(61, 'Needle Arm', 9, 3, 60, 100, 15),
(62, 'Odor Sleuth', 12, 2, NULL, NULL, 40),
(63, 'Overheat', 6, 1, 127, 90, 5),
(64, 'Poison Fang', 13, 3, 50, 100, 15),
(65, 'Poison Tail', 13, 3, 50, 100, 25),
(66, 'Psycho Boost', 14, 1, 127, 90, 5),
(67, 'Recycle', 12, 2, NULL, NULL, 10),
(68, 'Refresh', 12, 2, NULL, NULL, 20),
(69, 'Revenge', 5, 3, 60, 100, 10),
(70, 'Rock Blast', 15, 3, 25, 90, 10),
(71, 'Rock Tomb', 15, 3, 50, 80, 10),
(72, 'Role Play', 14, 2, NULL, NULL, 15),
(73, 'Sand Tomb', 10, 3, 35, 85, 15),
(74, 'Secret Power', 12, 3, 70, 100, 20),
(75, 'Shadow Punch', 8, 3, 60, -1, 20),
(76, 'Sheer Cold', 11, 1, NULL, NULL, 5),
(77, 'Shock Wave', 4, 1, 60, -1, 20),
(78, 'Signal Beam', 1, 1, 75, 100, 15),
(79, 'Silver Wind', 1, 1, 60, 100, 5),
(80, 'Skill Swap', 14, 2, NULL, NULL, 10),
(81, 'Sky Uppercut', 5, 3, 85, 90, 15),
(82, 'Slack Off', 12, 2, NULL, NULL, 10),
(83, 'SmellingSalt', 12, 3, 60, 100, 10),
(84, 'Snatch', 2, 2, NULL, NULL, 10),
(85, 'Spit Up', 12, 1, NULL, 100, 10),
(86, 'Stockpile', 12, 2, NULL, NULL, 20),
(87, 'Superpower', 5, 3, 120, 100, 5),
(88, 'Swallow', 12, 2, NULL, NULL, 10),
(89, 'Tail Glow', 1, 2, NULL, NULL, 20),
(90, 'Taunt', 2, 2, NULL, 100, 20),
(91, 'Teeter Dance', 12, 2, NULL, 100, 20),
(92, 'Tickle', 12, 2, NULL, 100, 20),
(93, 'Torment', 2, 2, NULL, 100, 15),
(94, 'Trick', 14, 2, NULL, 100, 10),
(95, 'Uproar', 12, 1, 90, 100, 10),
(96, 'Volt Tackle', 4, 3, 120, 100, 15),
(97, 'Water Pulse', 17, 1, 60, 100, 20),
(98, 'Water Sport', 17, 2, NULL, NULL, 15),
(99, 'Water Spout', 17, 1, 127, 100, 5),
(100, 'Weather Ball', 12, 1, 50, 100, 10),
(101, 'Will-O-Wisp', 6, 2, NULL, 75, 15),
(102, 'Wish', 12, 2, NULL, NULL, 10),
(103, 'Yawn', 12, 2, NULL, NULL, 10);

--
-- Table structure for table `monsters`
--

CREATE TABLE IF NOT EXISTS `monsters` (
  `id` smallint(6) NOT NULL COMMENT 'National Number',
  `hoenn_id` smallint(6) NOT NULL COMMENT 'Hoenn Number',
  `name` varchar(15) NOT NULL,
  `percent_male` float NOT NULL,
  `percent_female` float NOT NULL,
  `class` varchar(20) NOT NULL COMMENT 'Classification',
  `type_1` tinyint(4) NOT NULL COMMENT 'Primary Attack Type',
  `type_2` tinyint(4) COMMENT 'Secondary Attack Type',
  `height` varchar(15) NOT NULL,
  `weight` varchar(15) NOT NULL,
  `colour` varchar(15) NOT NULL COMMENT 'Colour Category',
  `base_hp` int(11) NOT NULL COMMENT 'Base Hit Points',
  `base_atk` int(11) NOT NULL COMMENT 'Base Attack',
  `base_def` int(11) NOT NULL COMMENT 'Base Defense',
  `base_sp_atk` int(11) NOT NULL COMMENT 'Base Special Attack',
  `base_sp_def` int(11) NOT NULL COMMENT 'Base Special Defense',
  `base_spd` int(11) NOT NULL COMMENT 'Base Speed',
  `exp_group` tinyint(4) NOT NULL COMMENT 'Experience Rate Group',
  PRIMARY KEY (`id`),
  FOREIGN KEY (`type_1`) REFERENCES attack_elements(`id`),
  FOREIGN KEY (`type_2`) REFERENCES attack_elements(`id`),
  FOREIGN KEY (`exp_group`) REFERENCES experience_groups(`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `hoenn_id` (`hoenn_id`)
) ENGINE=InnoDB DEFAULT CHARSET=UTF8;

--
-- Dumping data for table `monsters`
--

INSERT INTO `monsters` (`id`, `hoenn_id`, `name`, `percent_male`, `percent_female`, `class`, `type_1`, `type_2`, `height`, `weight`, `colour`, `base_hp`, `base_atk`, `base_def`, `base_sp_atk`, `base_sp_def`, `base_spd`, `exp_group`) VALUES
(25, 156, 'Pikachu', 50, 50, 'Mouse Pokémon', 4, NULL, '1''04"', '13.0 lbs', 'Yellow', 35, 55, 30, 50, 40, 90, 4);