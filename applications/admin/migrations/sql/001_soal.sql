CREATE TABLE IF NOT EXISTS `soal` (
  `id_soal` int(11) NOT NULL AUTO_INCREMENT,
  `id_form_soal` int(11) NOT NULL,
  `no_soal` int(11) NOT NULL,
  `isi_soal` text NOT NULL,
  `pembahasan_soal` text,
  `id_kelompok_soal` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id_soal`),
  KEY `id_form_soal` (`id_form_soal`),
  KEY `id_kelompok_soal` (`id_kelompok_soal`),
  KEY `no_soal` (`id_form_soal`,`no_soal`) USING BTREE,
  CONSTRAINT `soal_ibfk_1` FOREIGN KEY (`id_form_soal`) REFERENCES `form_soal` (`id_form_soal`),
  CONSTRAINT `soal_ibfk_2` FOREIGN KEY (`id_kelompok_soal`) REFERENCES `kelompok_soal` (`id_kelompok_soal`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
