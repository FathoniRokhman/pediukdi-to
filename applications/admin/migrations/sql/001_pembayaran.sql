CREATE TABLE IF NOT EXISTS `pembayaran` (
  `id_pembayaran` int(11) NOT NULL AUTO_INCREMENT,
  `id_jadwal_test` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `tanggal_bayar` date NOT NULL,
  `is_aktif` int(1) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id_pembayaran`),
  KEY `id_user` (`id_user`),
  KEY `id_jadwal_test` (`id_jadwal_test`) USING BTREE,
  CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_jadwal_test`) REFERENCES `jadwal_test` (`id_jadwal_test`),
  CONSTRAINT `pembayaran_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
