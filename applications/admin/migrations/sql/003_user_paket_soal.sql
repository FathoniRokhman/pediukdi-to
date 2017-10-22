CREATE TABLE IF NOT EXISTS `user_paket_soal` (
`id_user_paket_soal`  int NOT NULL AUTO_INCREMENT ,
`id_user_paket`  int NOT NULL ,
`id_periode_soal`  int NOT NULL ,
`start_time` datetime NULL ,
`is_finished` int(1) NOT NULL DEFAULT 0,
`email_sent` datetime NULL ,
`created`  datetime NOT NULL ,
PRIMARY KEY (`id_user_paket_soal`),
FOREIGN KEY (`id_user_paket`) REFERENCES `user_paket` (`id_user_paket`),
FOREIGN KEY (`id_periode_soal`) REFERENCES `periode_soal` (`id_periode_soal`)
) ENGINE=InnoDB;

