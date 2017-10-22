CREATE TABLE IF NOT EXISTS `test_session` (
  `id_test_session` int(11) NOT NULL AUTO_INCREMENT,
  `id_jadwal_test` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `is_finished` int(1) NOT NULL DEFAULT '0' COMMENT 'Set 1 utk paksa selesai',
  `email_sent` datetime DEFAULT NULL COMMENT 'Waktu email hasil test dikirim',
  PRIMARY KEY (`id_test_session`),
  KEY `jadwal_test_fk` (`id_jadwal_test`),
  KEY `user_fk` (`id_user`),
  CONSTRAINT `test_session_ibfk_1` FOREIGN KEY (`id_jadwal_test`) REFERENCES `jadwal_test` (`id_jadwal_test`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `test_session_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
