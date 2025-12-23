CREATE TABLE IF NOT EXISTS `phone_crypto` (
  `identifier` varchar(50) NOT NULL,
  `coin_name` varchar(10) DEFAULT 'ADI',
  `amount` float DEFAULT 0,
  PRIMARY KEY (`identifier`)
);

CREATE TABLE IF NOT EXISTS `phone_social_posts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `author` varchar(50) DEFAULT NULL,
  `image_url` text DEFAULT NULL,
  `caption` text DEFAULT NULL,
  `likes` int(11) DEFAULT 0,
  PRIMARY KEY (`id`)
);
