CREATE TABLE IF NOT EXISTS `periode_soal` (
`id_periode_soal`  int NOT NULL AUTO_INCREMENT,
`id_periode`  int NOT NULL ,
`id_form_soal`  int NOT NULL ,
`tgl_mulai` date NOT NULL ,
`created`  datetime NOT NULL ,
PRIMARY KEY (`id_periode_soal`),
FOREIGN KEY (`id_periode`) REFERENCES `periode` (`id_periode`),
FOREIGN KEY (`id_form_soal`) REFERENCES `form_soal` (`id_form_soal`)
) ENGINE=InnoDB;

