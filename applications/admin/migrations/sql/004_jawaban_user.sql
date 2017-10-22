CREATE TABLE IF NOT EXISTS `jawaban_user` (
`id_jawaban_user`  int NOT NULL AUTO_INCREMENT ,
`id_user`  int NOT NULL ,
`id_user_paket_soal`  int NOT NULL ,
`id_form_soal`  int NOT NULL,
`id_soal`  int NOT NULL,
`id_jawaban_soal` int NULL,
`waktu_jawab`  datetime NOT NULL ,
`is_ragu` int(1) NOT NULL DEFAULT 0,
PRIMARY KEY (`id_jawaban_user`),
FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`),
FOREIGN KEY (`id_user_paket_soal`) REFERENCES `user_paket_soal` (`id_user_paket_soal`),
FOREIGN KEY (`id_form_soal`) REFERENCES `form_soal` (`id_form_soal`),
FOREIGN KEY (`id_soal`) REFERENCES `soal` (`id_soal`),
FOREIGN KEY (`id_jawaban_soal`) REFERENCES `jawaban_soal` (`id_jawaban_soal`)
) ENGINE=InnoDB;