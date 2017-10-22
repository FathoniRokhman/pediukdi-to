CREATE TABLE IF NOT EXISTS `kelompok_soal` (
  `id_kelompok_soal` int(11) NOT NULL AUTO_INCREMENT,
  `nama_kelompok` varchar(200) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id_kelompok_soal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
