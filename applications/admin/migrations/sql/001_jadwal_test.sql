CREATE TABLE IF NOT EXISTS `jadwal_test` (
  `id_jadwal_test` int(11) NOT NULL AUTO_INCREMENT,
  `tanggal_test` date NOT NULL,
  `id_form_soal` int(11) NOT NULL,
  `biaya` int(11) NOT NULL DEFAULT '0',
  `email_sent` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id_jadwal_test`),
  KEY `id_form_soal` (`id_form_soal`),
  CONSTRAINT `jadwal_test_ibfk_1` FOREIGN KEY (`id_form_soal`) REFERENCES `form_soal` (`id_form_soal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
