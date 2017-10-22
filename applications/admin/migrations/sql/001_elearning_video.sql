CREATE TABLE IF NOT EXISTS `elearning_video` (
  `idElearningVideo` int(11) NOT NULL AUTO_INCREMENT,
  `judulVideo` varchar(100) NOT NULL,
  `deskripsiVideo` tinytext NOT NULL,
  `linkVideo` varchar(255) NOT NULL,
  `dateVideo` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `statusVideo` enum('0','1','') NOT NULL DEFAULT '1',
  PRIMARY KEY (`idElearningVideo`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;