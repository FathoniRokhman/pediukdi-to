-- phpMyAdmin SQL Dump
-- version 4.0.10.14
-- http://www.phpmyadmin.net
--
-- Host: localhost:3306
-- Generation Time: Jan 04, 2017 at 04:12 AM
-- Server version: 5.5.52-cll
-- PHP Version: 5.6.20

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `k9342953_pediukdi`
--

-- --------------------------------------------------------

--
-- Table structure for table `ci_sessions`
--

CREATE TABLE IF NOT EXISTS `ci_sessions` (
  `id` varchar(128) NOT NULL,
  `ip_address` varchar(45) CHARACTER SET latin1 NOT NULL,
  `timestamp` int(10) unsigned NOT NULL DEFAULT '0',
  `data` blob NOT NULL,
  KEY `ci_sessions_timestamp` (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `form_soal`
--

CREATE TABLE IF NOT EXISTS `form_soal` (
  `id_form_soal` int(11) NOT NULL AUTO_INCREMENT,
  `nama_form` varchar(200) NOT NULL,
  `waktu_pengerjaan` int(11) NOT NULL DEFAULT '0' COMMENT 'satuan menit',
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id_form_soal`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- Table structure for table `guest_session`
--

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
  KEY `id_form_soal` (`id_form_soal`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=1081 ;

-- --------------------------------------------------------

--
-- Table structure for table `jadwal_test`
--

CREATE TABLE IF NOT EXISTS `jadwal_test` (
  `id_jadwal_test` int(11) NOT NULL AUTO_INCREMENT,
  `tanggal_test` date NOT NULL,
  `id_form_soal` int(11) NOT NULL,
  `biaya` int(11) NOT NULL DEFAULT '0',
  `email_sent` datetime DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id_jadwal_test`),
  KEY `id_form_soal` (`id_form_soal`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

-- --------------------------------------------------------

--
-- Table structure for table `jawaban_guest`
--

CREATE TABLE IF NOT EXISTS `jawaban_guest` (
  `id_jawaban_guest` int(11) NOT NULL AUTO_INCREMENT,
  `id_guest_session` int(11) NOT NULL,
  `id_form_soal` int(11) NOT NULL,
  `id_soal` int(11) NOT NULL,
  `id_jawaban_soal` int(11) DEFAULT NULL,
  `waktu_jawab` datetime NOT NULL,
  `is_ragu` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_jawaban_guest`),
  KEY `id_form_soal` (`id_form_soal`),
  KEY `id_soal` (`id_soal`),
  KEY `id_jawaban` (`id_jawaban_soal`),
  KEY `id_guest_session` (`id_guest_session`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6432 ;

-- --------------------------------------------------------

--
-- Table structure for table `jawaban_soal`
--

CREATE TABLE IF NOT EXISTS `jawaban_soal` (
  `id_jawaban_soal` int(11) NOT NULL AUTO_INCREMENT,
  `id_soal` int(11) NOT NULL,
  `huruf` varchar(1) NOT NULL COMMENT 'A,B,C,D,E',
  `jawaban` text,
  `is_kunci` int(1) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id_jawaban_soal`),
  KEY `id_soal` (`id_soal`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4171 ;

-- --------------------------------------------------------

--
-- Table structure for table `jawaban_user`
--

CREATE TABLE IF NOT EXISTS `jawaban_user` (
  `id_jawaban_user` int(11) NOT NULL AUTO_INCREMENT,
  `id_user` int(11) NOT NULL,
  `id_jadwal_test` int(11) NOT NULL,
  `id_form_soal` int(11) NOT NULL,
  `id_soal` int(11) NOT NULL,
  `id_jawaban_soal` int(11) DEFAULT NULL,
  `waktu_jawab` datetime NOT NULL,
  `is_ragu` int(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id_jawaban_user`),
  KEY `id_jadwal_test` (`id_jadwal_test`),
  KEY `id_form_soal` (`id_form_soal`),
  KEY `id_soal` (`id_soal`),
  KEY `id_jawaban` (`id_jawaban_soal`),
  KEY `id_user` (`id_user`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=37154 ;

-- --------------------------------------------------------

--
-- Table structure for table `kelompok_soal`
--

CREATE TABLE IF NOT EXISTS `kelompok_soal` (
  `id_kelompok_soal` int(11) NOT NULL AUTO_INCREMENT,
  `nama_kelompok` varchar(200) NOT NULL,
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id_kelompok_soal`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran`
--

CREATE TABLE IF NOT EXISTS `pembayaran` (
  `id_pembayaran` int(11) NOT NULL AUTO_INCREMENT,
  `id_jadwal_test` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `tanggal_bayar` date NOT NULL,
  `is_aktif` int(1) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id_pembayaran`),
  KEY `id_user` (`id_user`),
  KEY `id_jadwal_test` (`id_jadwal_test`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=376 ;

-- --------------------------------------------------------

--
-- Table structure for table `setting`
--

CREATE TABLE IF NOT EXISTS `setting` (
  `key` varchar(50) NOT NULL,
  `value` text NOT NULL,
  `value_type` varchar(7) NOT NULL COMMENT 'string,integer,double,boolean',
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Table structure for table `soal`
--

CREATE TABLE IF NOT EXISTS `soal` (
  `id_soal` int(11) NOT NULL AUTO_INCREMENT,
  `id_form_soal` int(11) NOT NULL,
  `no_soal` int(11) NOT NULL,
  `isi_soal` text NOT NULL,
  `id_kelompok_soal` int(11) DEFAULT NULL,
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id_soal`),
  KEY `id_form_soal` (`id_form_soal`),
  KEY `id_kelompok_soal` (`id_kelompok_soal`),
  KEY `no_soal` (`id_form_soal`,`no_soal`) USING BTREE
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=843 ;

-- --------------------------------------------------------

--
-- Table structure for table `test_session`
--

CREATE TABLE IF NOT EXISTS `test_session` (
  `id_test_session` int(11) NOT NULL AUTO_INCREMENT,
  `id_jadwal_test` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `start_time` datetime NOT NULL,
  `is_finished` int(1) NOT NULL DEFAULT '0' COMMENT 'Set 1 utk paksa selesai',
  `email_sent` datetime DEFAULT NULL COMMENT 'Waktu email hasil test dikirim',
  PRIMARY KEY (`id_test_session`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 AUTO_INCREMENT=269 ;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE IF NOT EXISTS `user` (
  `id_user` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(100) NOT NULL,
  `password_hash` varchar(40) NOT NULL COMMENT 'SHA1 Function',
  `nama` varchar(100) NOT NULL,
  `institusi` varchar(100) DEFAULT NULL,
  `file_foto` varchar(44) DEFAULT NULL COMMENT 'sha1 email + .jpg',
  `no_hp` varchar(50) NOT NULL,
  `last_rotasi_klinik` int(4) DEFAULT NULL COMMENT 'tahun terakhir rotasi klinik',
  `is_verified` int(1) NOT NULL DEFAULT '0',
  `created` datetime NOT NULL,
  `updated` datetime DEFAULT NULL,
  PRIMARY KEY (`id_user`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=521 ;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `guest_session`
--
ALTER TABLE `guest_session`
  ADD CONSTRAINT `guest_session_ibfk_1` FOREIGN KEY (`id_form_soal`) REFERENCES `form_soal` (`id_form_soal`);

--
-- Constraints for table `jadwal_test`
--
ALTER TABLE `jadwal_test`
  ADD CONSTRAINT `jadwal_test_ibfk_1` FOREIGN KEY (`id_form_soal`) REFERENCES `form_soal` (`id_form_soal`);

--
-- Constraints for table `jawaban_guest`
--
ALTER TABLE `jawaban_guest`
  ADD CONSTRAINT `jawaban_guest_ibfk_1` FOREIGN KEY (`id_guest_session`) REFERENCES `guest_session` (`id_guest_session`),
  ADD CONSTRAINT `jawaban_guest_ibfk_2` FOREIGN KEY (`id_form_soal`) REFERENCES `form_soal` (`id_form_soal`),
  ADD CONSTRAINT `jawaban_guest_ibfk_3` FOREIGN KEY (`id_soal`) REFERENCES `soal` (`id_soal`),
  ADD CONSTRAINT `jawaban_guest_ibfk_4` FOREIGN KEY (`id_jawaban_soal`) REFERENCES `jawaban_soal` (`id_jawaban_soal`);

--
-- Constraints for table `jawaban_soal`
--
ALTER TABLE `jawaban_soal`
  ADD CONSTRAINT `jawaban_soal_ibfk_1` FOREIGN KEY (`id_soal`) REFERENCES `soal` (`id_soal`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `jawaban_user`
--
ALTER TABLE `jawaban_user`
  ADD CONSTRAINT `jawaban_user_ibfk_1` FOREIGN KEY (`id_jadwal_test`) REFERENCES `jadwal_test` (`id_jadwal_test`),
  ADD CONSTRAINT `jawaban_user_ibfk_2` FOREIGN KEY (`id_form_soal`) REFERENCES `form_soal` (`id_form_soal`),
  ADD CONSTRAINT `jawaban_user_ibfk_3` FOREIGN KEY (`id_soal`) REFERENCES `soal` (`id_soal`),
  ADD CONSTRAINT `jawaban_user_ibfk_4` FOREIGN KEY (`id_jawaban_soal`) REFERENCES `jawaban_soal` (`id_jawaban_soal`),
  ADD CONSTRAINT `jawaban_user_ibfk_5` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `pembayaran`
--
ALTER TABLE `pembayaran`
  ADD CONSTRAINT `pembayaran_ibfk_1` FOREIGN KEY (`id_jadwal_test`) REFERENCES `jadwal_test` (`id_jadwal_test`),
  ADD CONSTRAINT `pembayaran_ibfk_2` FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`);

--
-- Constraints for table `soal`
--
ALTER TABLE `soal`
  ADD CONSTRAINT `soal_ibfk_1` FOREIGN KEY (`id_form_soal`) REFERENCES `form_soal` (`id_form_soal`),
  ADD CONSTRAINT `soal_ibfk_2` FOREIGN KEY (`id_kelompok_soal`) REFERENCES `kelompok_soal` (`id_kelompok_soal`) ON DELETE SET NULL ON UPDATE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
