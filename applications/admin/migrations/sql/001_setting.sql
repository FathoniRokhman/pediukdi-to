CREATE TABLE IF NOT EXISTS `setting` (
  `key` varchar(50) NOT NULL,
  `value` text NOT NULL,
  `value_type` varchar(7) NOT NULL COMMENT 'string,integer,double,boolean',
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
