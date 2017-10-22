CREATE TABLE IF NOT EXISTS `form_soal` (
  `id_form_soal` int(11) NOT NULL AUTO_INCREMENT,
  `nama_form` varchar(200) NOT NULL,
  `nilai_kkm` int(11) NOT NULL DEFAULT '0',
  `waktu_pengerjaan` int(11) NOT NULL DEFAULT '0' COMMENT 'satuan menit',
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id_form_soal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
