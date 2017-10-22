CREATE TABLE IF NOT EXISTS `periode` (
`id_periode`  int NOT NULL AUTO_INCREMENT ,
`nama_periode`  varchar(200) NOT NULL ,
`waktu_mulai`  datetime NOT NULL ,
`waktu_selesai`  datetime NOT NULL ,
`is_aktif`  int(1) NOT NULL DEFAULT 1 ,
`created`  datetime NOT NULL ,
`updated`  datetime NULL ,
PRIMARY KEY (`id_periode`)
) ENGINE=InnoDB;