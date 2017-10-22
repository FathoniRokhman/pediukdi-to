CREATE TABLE IF NOT EXISTS `premium_fiture` (
  `idPremiunFiture` int(11) NOT NULL AUTO_INCREMENT,
  `idUser` int(11) NOT NULL,
  `paketPremium` enum('1','2','3','') NOT NULL,
  `activatedDate` date NOT NULL,
  PRIMARY KEY (`idPremiunFiture`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
