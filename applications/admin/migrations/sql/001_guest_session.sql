CREATE TABLE IF NOT EXISTS `guest_session` (
  `id_guest_session` int(11) NOT NULL AUTO_INCREMENT,
  `session_id` varchar(40) NOT NULL,
  `ip_address` varchar(45) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `id_form_soal` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `is_finished` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_guest_session`),
  KEY `id_form_soal` (`id_form_soal`),
  CONSTRAINT `guest_session_ibfk_1` FOREIGN KEY (`id_form_soal`) REFERENCES `form_soal` (`id_form_soal`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;