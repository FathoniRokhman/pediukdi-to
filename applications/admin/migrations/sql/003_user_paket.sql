CREATE TABLE IF NOT EXISTS `user_paket` (
`id_user_paket`  int NOT NULL AUTO_INCREMENT ,
`id_user`  int NOT NULL ,
`id_periode_paket`  int NOT NULL ,
`created`  datetime NOT NULL ,
`updated`  datetime NULL ,
PRIMARY KEY (`id_user_paket`),
FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`),
FOREIGN KEY (`id_periode_paket`) REFERENCES `periode_paket` (`id_periode_paket`)
) ENGINE=InnoDB;