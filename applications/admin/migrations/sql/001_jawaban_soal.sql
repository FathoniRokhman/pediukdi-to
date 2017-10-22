CREATE TABLE IF NOT EXISTS `jawaban_soal` (
  `id_jawaban_soal` int(11) NOT NULL AUTO_INCREMENT,
  `id_soal` int(11) NOT NULL,
  `huruf` varchar(1) NOT NULL COMMENT 'A,B,C,D,E',
  `jawaban` text,
  `is_kunci` int(1) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id_jawaban_soal`),
  KEY `id_soal` (`id_soal`),
  CONSTRAINT `jawaban_soal_ibfk_1` FOREIGN KEY (`id_soal`) REFERENCES `soal` (`id_soal`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
