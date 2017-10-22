CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(40) NOT NULL COMMENT 'SHA1 Function',
  `nama` varchar(100) NOT NULL,
  `institusi` varchar(100) DEFAULT NULL,
  `file_foto` varchar(44) DEFAULT NULL COMMENT 'sha1 email + .jpg',
  `no_hp` varchar(50) NOT NULL,
  `last_rotasi_klinik` int(4) DEFAULT NULL COMMENT 'tahun terakhir rotasi klinik',
  `is_verified` int(1) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
