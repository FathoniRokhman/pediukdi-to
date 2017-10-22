CREATE TABLE IF NOT EXISTS `periode_paket` (
`id_periode_paket`  int NOT NULL AUTO_INCREMENT ,
`id_periode`  int NOT NULL ,
`nama_paket` varchar(200) NOT NULL,
`jumlah`  int NOT NULL ,
`biaya`  int NOT NULL ,
`created`  datetime NOT NULL ,
`updated`  datetime NULL ,
PRIMARY KEY (`id_periode_paket`),
FOREIGN KEY (`id_periode`) REFERENCES `periode` (`id_periode`)
) ENGINE=InnoDB;
