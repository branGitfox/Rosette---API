DROP TABLE IF EXISTS `acs`;
CREATE TABLE `acs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `annee` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `debut` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `acs` VALUES("1","2025-2026","2026-03-27 20:48:13","2026-03-27 20:48:13","Janvier");



DROP TABLE IF EXISTS `admissions`;
CREATE TABLE `admissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `note` varchar(255) NOT NULL,
  `ac_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `admissions_ac_id_foreign` (`ac_id`),
  CONSTRAINT `admissions_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `admissions` VALUES("1","12","1","2026-03-27 20:51:36","2026-03-27 20:51:36");



DROP TABLE IF EXISTS `ajouts`;
CREATE TABLE `ajouts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `motif` varchar(255) NOT NULL,
  `ecolage` int(11) NOT NULL DEFAULT 0,
  `droit` int(11) NOT NULL DEFAULT 0,
  `kermesse` int(11) NOT NULL DEFAULT 0,
  `ac_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ajouts_ac_id_foreign` (`ac_id`),
  CONSTRAINT `ajouts_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `ajouts` VALUES("1","credit","15000","0","0","1","2026-03-27 21:28:34","2026-03-27 21:28:34");
INSERT INTO `ajouts` VALUES("2","test","1000","0","0","1","2026-03-27 22:46:59","2026-03-27 22:46:59");
INSERT INTO `ajouts` VALUES("3","ddd","100000000","0","0","1","2026-03-28 23:51:53","2026-03-28 23:51:53");



DROP TABLE IF EXISTS `archconges`;
CREATE TABLE `archconges` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `debut` varchar(255) NOT NULL,
  `fin` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `ac_id` bigint(20) unsigned NOT NULL,
  `w_id` bigint(20) unsigned NOT NULL,
  `motif` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `archconges_ac_id_foreign` (`ac_id`),
  KEY `archconges_w_id_foreign` (`w_id`),
  CONSTRAINT `archconges_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `archconges_w_id_foreign` FOREIGN KEY (`w_id`) REFERENCES `workers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `archconges` VALUES("2","2026-03-29","2026-03-29","0","1","1","gfggf","2026-03-29 00:00:59","2026-03-29 00:01:31");



DROP TABLE IF EXISTS `archsals`;
CREATE TABLE `archsals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `montant` int(11) NOT NULL,
  `mois` varchar(255) NOT NULL,
  `type` tinyint(1) NOT NULL,
  `ac_id` bigint(20) unsigned NOT NULL,
  `w_id` bigint(20) unsigned NOT NULL,
  `motif` text NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `archsals_ac_id_foreign` (`ac_id`),
  KEY `archsals_w_id_foreign` (`w_id`),
  CONSTRAINT `archsals_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `archsals_w_id_foreign` FOREIGN KEY (`w_id`) REFERENCES `workers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `archsals` VALUES("1","80000000","Janvier","0","1","1"," ","2026-03-28 23:52:29","2026-03-28 23:52:29");



DROP TABLE IF EXISTS `audits`;
CREATE TABLE `audits` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `details` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `audits_user_id_foreign` (`user_id`),
  CONSTRAINT `audits_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `audits` VALUES("25","Étudiants","Suspension d\'un etudiant  ","1","2026-03-28 20:36:12","2026-03-28 20:36:12");
INSERT INTO `audits` VALUES("26","Étudiants","Lever la suspension d\'un etudiant","1","2026-03-28 20:37:06","2026-03-28 20:37:06");
INSERT INTO `audits` VALUES("27","Étudiants","Suspension d\'un etudiant Ravomanana Nolane Fidel","1","2026-03-28 20:37:10","2026-03-28 20:37:10");
INSERT INTO `audits` VALUES("28","Étudiants","Lever la suspension d\'un etudiant Ravomanana Nolane Fidel","1","2026-03-28 20:38:41","2026-03-28 20:38:41");
INSERT INTO `audits` VALUES("29","Financier","Paiement de droit de scolarité pour Ravomanana Nolane Fidel","1","2026-03-28 20:48:20","2026-03-28 20:48:20");
INSERT INTO `audits` VALUES("30","Financier","Paiement de Kermesse par un parent commun pour Ravomanana Nolane Fidel","1","2026-03-28 20:59:36","2026-03-28 20:59:36");
INSERT INTO `audits` VALUES("31","Financier","Annulation de Kermesse par un parent commun pour Ravomanana Nolane Fidel","1","2026-03-28 20:59:49","2026-03-28 20:59:49");
INSERT INTO `audits` VALUES("32","Etudiants","historique de droit supprimé pour Ravomanana Nolane Fidel","1","2026-03-28 21:37:47","2026-03-28 21:37:47");
INSERT INTO `audits` VALUES("33","Etudiants","historique de droit supprimé pour Ravomanana Nolane Fidel","1","2026-03-28 21:38:09","2026-03-28 21:38:09");
INSERT INTO `audits` VALUES("34","Etudiants","historique d\'ecolage supprimé pour Ravomanana Nolane Fidel","1","2026-03-28 21:43:13","2026-03-28 21:43:13");
INSERT INTO `audits` VALUES("35","Paramètres","Creation d\'une profession","1","2026-03-28 23:48:48","2026-03-28 23:48:48");
INSERT INTO `audits` VALUES("36","Paramètres","Création d\'une matiere","1","2026-03-28 23:49:02","2026-03-28 23:49:02");
INSERT INTO `audits` VALUES("37","Employé","Création d\'un employé fdfdf fdfdf","1","2026-03-28 23:50:34","2026-03-28 23:50:34");
INSERT INTO `audits` VALUES("38","Financier","Depot d\'argent","1","2026-03-28 23:51:53","2026-03-28 23:51:53");
INSERT INTO `audits` VALUES("39","Financier","Paiement d\'un employé fdfdf fdfdf pour mois deJanvier","1","2026-03-28 23:52:29","2026-03-28 23:52:29");
INSERT INTO `audits` VALUES("40","Employé","Congé d\'un employé fdfdf fdfdf de 2026-03-29 à 2026-03-29","1","2026-03-28 23:58:01","2026-03-28 23:58:01");
INSERT INTO `audits` VALUES("41","Employé","Annulation d\'un Congé pour fdfdf fdfdf","1","2026-03-29 00:00:31","2026-03-29 00:00:31");
INSERT INTO `audits` VALUES("42","Employé","Congé d\'un employé fdfdf fdfdf de 2026-03-29 à 2026-03-29 de motif: gfggf\'","1","2026-03-29 00:00:59","2026-03-29 00:00:59");
INSERT INTO `audits` VALUES("43","Paramètres","Creation du NIF","1","2026-03-29 00:56:10","2026-03-29 00:56:10");
INSERT INTO `audits` VALUES("44","Paramètres","Creation du Stat","1","2026-03-29 00:56:18","2026-03-29 00:56:18");



DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




DROP TABLE IF EXISTS `classes`;
CREATE TABLE `classes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nom_classe` varchar(255) NOT NULL,
  `ecolage` int(11) NOT NULL,
  `ac_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `droit` int(11) NOT NULL,
  `kermesse` int(11) NOT NULL,
  `droit_ancien` int(11) NOT NULL DEFAULT 0,
  `kermesse_ancien` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `classes_ac_id_foreign` (`ac_id`),
  CONSTRAINT `classes_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `classes` VALUES("1","CM1","15000","1","2026-03-27 20:49:57","2026-03-27 20:49:57","10000","7000","8000","6000");
INSERT INTO `classes` VALUES("2","CM2","20000","1","2026-03-27 20:51:16","2026-03-27 20:51:16","15000","10000","12000","8000");



DROP TABLE IF EXISTS `depenses`;
CREATE TABLE `depenses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `solde` int(11) NOT NULL DEFAULT 0,
  `ac_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `depenses_ac_id_foreign` (`ac_id`),
  CONSTRAINT `depenses_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




DROP TABLE IF EXISTS `depensesparmois`;
CREATE TABLE `depensesparmois` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `solde` int(11) NOT NULL DEFAULT 0,
  `ac_id` bigint(20) unsigned NOT NULL,
  `mois` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `depensesparmois_ac_id_foreign` (`ac_id`),
  CONSTRAINT `depensesparmois_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `depensesparmois` VALUES("1","80075000","1","26-03-27","2026-03-27 21:28:08","2026-03-28 23:52:29");



DROP TABLE IF EXISTS `domaines`;
CREATE TABLE `domaines` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `domaines` VALUES("1","test 1","2026-03-28 23:49:02","2026-03-28 23:49:02");



DROP TABLE IF EXISTS `droithistos`;
CREATE TABLE `droithistos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `montant` int(11) NOT NULL DEFAULT 0,
  `dr_id` bigint(20) unsigned NOT NULL,
  `type` enum('complet','avance','rembourse') NOT NULL DEFAULT 'complet',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `reste` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `droithistos_dr_id_foreign` (`dr_id`),
  CONSTRAINT `droithistos_dr_id_foreign` FOREIGN KEY (`dr_id`) REFERENCES `studentdroits` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `droithistos` VALUES("1","10000","3","complet","2026-03-27 21:31:54","2026-03-27 21:31:54","0");
INSERT INTO `droithistos` VALUES("2","10000","3","rembourse","2026-03-27 21:32:53","2026-03-27 21:32:53","10000");
INSERT INTO `droithistos` VALUES("3","10000","3","complet","2026-03-27 21:33:40","2026-03-27 21:33:40","0");
INSERT INTO `droithistos` VALUES("4","10000","3","rembourse","2026-03-27 21:33:54","2026-03-27 21:33:54","10000");
INSERT INTO `droithistos` VALUES("5","10000","3","complet","2026-03-27 21:34:04","2026-03-27 21:34:04","0");
INSERT INTO `droithistos` VALUES("6","10000","3","complet","2026-03-27 21:59:30","2026-03-27 21:59:30","0");
INSERT INTO `droithistos` VALUES("7","10000","3","rembourse","2026-03-27 21:59:57","2026-03-27 21:59:57","10000");
INSERT INTO `droithistos` VALUES("8","10000","3","complet","2026-03-27 22:01:59","2026-03-27 22:01:59","0");
INSERT INTO `droithistos` VALUES("9","10000","3","rembourse","2026-03-27 22:03:39","2026-03-27 22:03:39","10000");
INSERT INTO `droithistos` VALUES("10","10000","3","complet","2026-03-27 22:03:55","2026-03-27 22:03:55","0");
INSERT INTO `droithistos` VALUES("11","10000","3","rembourse","2026-03-27 22:04:09","2026-03-27 22:04:09","10000");
INSERT INTO `droithistos` VALUES("12","5000","3","avance","2026-03-27 22:04:25","2026-03-27 22:04:25","5000");
INSERT INTO `droithistos` VALUES("14","10000","3","complet","2026-03-28 20:48:20","2026-03-28 20:48:20","0");



DROP TABLE IF EXISTS `droits`;
CREATE TABLE `droits` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `solde` int(11) NOT NULL DEFAULT 0,
  `ac_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `droits_ac_id_foreign` (`ac_id`),
  CONSTRAINT `droits_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `droits` VALUES("1","20000","1","2026-03-27 21:28:34","2026-03-28 23:51:53");



DROP TABLE IF EXISTS `ecohistos`;
CREATE TABLE `ecohistos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `montant` int(11) NOT NULL DEFAULT 0,
  `ec_id` bigint(20) unsigned NOT NULL,
  `type` enum('complet','avance','rembourse') NOT NULL DEFAULT 'complet',
  `reste` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ecohistos_ec_id_foreign` (`ec_id`),
  CONSTRAINT `ecohistos_ec_id_foreign` FOREIGN KEY (`ec_id`) REFERENCES `moisecolages` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `ecohistos` VALUES("2","15000","25","rembourse","15000","2026-03-27 21:28:08","2026-03-27 21:28:08");
INSERT INTO `ecohistos` VALUES("3","15000","25","complet","0","2026-03-27 21:28:49","2026-03-27 21:28:49");
INSERT INTO `ecohistos` VALUES("4","20000","13","complet","0","2026-03-27 21:30:56","2026-03-27 21:30:56");
INSERT INTO `ecohistos` VALUES("5","20000","1","complet","0","2026-03-27 21:31:18","2026-03-27 21:31:18");
INSERT INTO `ecohistos` VALUES("6","15000","26","complet","0","2026-03-27 21:52:58","2026-03-27 21:52:58");
INSERT INTO `ecohistos` VALUES("7","15000","26","rembourse","15000","2026-03-27 21:53:14","2026-03-27 21:53:14");
INSERT INTO `ecohistos` VALUES("8","7000","26","avance","8000","2026-03-27 21:53:43","2026-03-27 21:53:43");
INSERT INTO `ecohistos` VALUES("9","7000","26","rembourse","15000","2026-03-27 21:54:13","2026-03-27 21:54:13");



DROP TABLE IF EXISTS `ecolages`;
CREATE TABLE `ecolages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `solde` int(11) NOT NULL DEFAULT 0,
  `ac_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ecolages_ac_id_foreign` (`ac_id`),
  CONSTRAINT `ecolages_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `ecolages` VALUES("1","20055000","1","2026-03-27 21:26:17","2026-03-28 23:52:29");



DROP TABLE IF EXISTS `etudiants`;
CREATE TABLE `etudiants` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `sexe` tinyint(1) NOT NULL,
  `dateNaissance` varchar(255) NOT NULL,
  `lieuNaissance` varchar(255) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `nomPere` varchar(255) DEFAULT '',
  `nomMere` varchar(255) DEFAULT '',
  `telephonePere` varchar(255) DEFAULT '',
  `telephoneMere` varchar(255) DEFAULT '',
  `prenomMere` varchar(255) DEFAULT '',
  `prenomPere` varchar(255) DEFAULT '',
  `nomTuteur` varchar(255) DEFAULT '',
  `prenomTuteur` varchar(255) DEFAULT '',
  `telephoneTuteur` varchar(255) DEFAULT '',
  `matricule` varchar(255) NOT NULL DEFAULT '',
  `ecole` varchar(255) DEFAULT '',
  `photo` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `enfantProf` tinyint(1) NOT NULL,
  `ac_id` bigint(20) unsigned NOT NULL,
  `quit` tinyint(1) NOT NULL DEFAULT 0,
  `fired` tinyint(1) NOT NULL DEFAULT 0,
  `quit_at` datetime DEFAULT NULL,
  `fired_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `etudiants_ac_id_foreign` (`ac_id`),
  CONSTRAINT `etudiants_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `etudiants` VALUES("1","Ravomanana","Brandon Fidelin","1","2026-03-27","Brickaville","Antananrivo","Ravomanana","Soazaraniaina","0349247593","0346302875","Marie Paula","Barthélemy Fidel",NULL,NULL,NULL,"ROS26-0","","default.png","2026-03-27 21:00:42","2026-03-27 21:00:42","0","1","0","0",NULL,NULL);
INSERT INTO `etudiants` VALUES("2","Ravomanana","Jayson Luciano","1","2026-03-28","Mananara-Nord","Analanjahana","Ravomanana","soazaraniaina","0349247593","0346302875","Marie Paula","Barthélemy Fidel",NULL,NULL,NULL,"ROS26-1","","default.png","2026-03-27 21:20:18","2026-03-27 21:20:18","0","1","0","0",NULL,NULL);
INSERT INTO `etudiants` VALUES("3","Ravomanana","Nolane Fidel","1","2026-03-28","Mananara-Nord","Mananara-Nord","Ravomanana","Soazaraniaina","0349247593","0346302875","Marie Paula","Barthélemy Fidel",NULL,NULL,NULL,"ROS26-2","","default.png","2026-03-27 21:25:01","2026-03-27 21:25:01","0","1","0","0",NULL,NULL);



DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




DROP TABLE IF EXISTS `identifys`;
CREATE TABLE `identifys` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ident` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `identifys` VALUES("1","aaaaaaaaaaaaa","2026-03-29 00:56:18","2026-03-29 00:56:18");



DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




DROP TABLE IF EXISTS `kermessehistos`;
CREATE TABLE `kermessehistos` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `montant` int(11) NOT NULL DEFAULT 0,
  `kr_id` bigint(20) unsigned NOT NULL,
  `type` enum('complet','avance','rembourse') NOT NULL DEFAULT 'complet',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `reste` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `kermessehistos_kr_id_foreign` (`kr_id`),
  CONSTRAINT `kermessehistos_kr_id_foreign` FOREIGN KEY (`kr_id`) REFERENCES `studentkermesses` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `kermessehistos` VALUES("1","7000","3","complet","2026-03-27 22:24:34","2026-03-27 22:24:34","0");
INSERT INTO `kermessehistos` VALUES("2","7000","3","complet","2026-03-27 22:36:52","2026-03-27 22:36:52","0");
INSERT INTO `kermessehistos` VALUES("3","7000","3","rembourse","2026-03-27 22:37:11","2026-03-27 22:37:11","7000");
INSERT INTO `kermessehistos` VALUES("4","5000","3","avance","2026-03-27 22:42:11","2026-03-27 22:42:11","2000");



DROP TABLE IF EXISTS `kermesses`;
CREATE TABLE `kermesses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `solde` int(11) NOT NULL DEFAULT 0,
  `ac_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `kermesses_ac_id_foreign` (`ac_id`),
  CONSTRAINT `kermesses_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `kermesses` VALUES("1","0","1","2026-03-27 21:28:34","2026-03-28 23:51:53");



DROP TABLE IF EXISTS `macs`;
CREATE TABLE `macs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `mois` varchar(255) NOT NULL,
  `id_ac` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `macs` VALUES("1","Janvier","2025-2026","2026-03-27 20:48:13","2026-03-27 20:48:13");
INSERT INTO `macs` VALUES("2","Février","2025-2026","2026-03-27 20:48:13","2026-03-27 20:48:13");
INSERT INTO `macs` VALUES("3","Mars","2025-2026","2026-03-27 20:48:13","2026-03-27 20:48:13");
INSERT INTO `macs` VALUES("4","Avril","2025-2026","2026-03-27 20:48:13","2026-03-27 20:48:13");
INSERT INTO `macs` VALUES("5","Mai","2025-2026","2026-03-27 20:48:13","2026-03-27 20:48:13");
INSERT INTO `macs` VALUES("6","Juin","2025-2026","2026-03-27 20:48:13","2026-03-27 20:48:13");
INSERT INTO `macs` VALUES("7","Juillet","2025-2026","2026-03-27 20:48:13","2026-03-27 20:48:13");
INSERT INTO `macs` VALUES("8","Août","2025-2026","2026-03-27 20:48:13","2026-03-27 20:48:13");
INSERT INTO `macs` VALUES("9","Septembre","2025-2026","2026-03-27 20:48:13","2026-03-27 20:48:13");
INSERT INTO `macs` VALUES("10","Octobre","2025-2026","2026-03-27 20:48:13","2026-03-27 20:48:13");
INSERT INTO `macs` VALUES("11","Novembre","2025-2026","2026-03-27 20:48:13","2026-03-27 20:48:13");
INSERT INTO `macs` VALUES("12","Décembre","2025-2026","2026-03-27 20:48:13","2026-03-27 20:48:13");



DROP TABLE IF EXISTS `matieres`;
CREATE TABLE `matieres` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `w_id` bigint(20) unsigned NOT NULL,
  `matiere` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `salle` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `matieres_w_id_foreign` (`w_id`),
  CONSTRAINT `matieres_w_id_foreign` FOREIGN KEY (`w_id`) REFERENCES `workers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `matieres` VALUES("1","1","test 1","2026-03-28 23:50:34","2026-03-28 23:50:34","CM1");



DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` VALUES("1","0001_01_01_000000_create_users_table","1");
INSERT INTO `migrations` VALUES("2","0001_01_01_000001_create_cache_table","1");
INSERT INTO `migrations` VALUES("3","0001_01_01_000002_create_jobs_table","1");
INSERT INTO `migrations` VALUES("4","2025_08_08_153309_create_personal_access_tokens_table","1");
INSERT INTO `migrations` VALUES("5","2025_08_08_153821_add_softdelete_users","1");
INSERT INTO `migrations` VALUES("6","2025_08_08_154405_add_role_to_users","1");
INSERT INTO `migrations` VALUES("7","2025_08_12_180437_add_firstname_users","1");
INSERT INTO `migrations` VALUES("8","2025_08_21_062738_annee_scolaire","1");
INSERT INTO `migrations` VALUES("9","2025_08_21_063725_add_mois_annee_scolaire","1");
INSERT INTO `migrations` VALUES("10","2025_08_23_081236_classes","1");
INSERT INTO `migrations` VALUES("11","2025_08_26_065357_salles","1");
INSERT INTO `migrations` VALUES("12","2025_08_27_085225_admissions","1");
INSERT INTO `migrations` VALUES("13","2025_09_02_115005_ajout_kermesse_et_droit","1");
INSERT INTO `migrations` VALUES("14","2025_09_02_122740_etudiant","1");
INSERT INTO `migrations` VALUES("15","2025_09_02_131714_sous_etudiants","1");
INSERT INTO `migrations` VALUES("16","2025_09_06_174214_ecolages","1");
INSERT INTO `migrations` VALUES("17","2025_09_06_200955_droits","1");
INSERT INTO `migrations` VALUES("18","2025_09_07_170116_kermesse","1");
INSERT INTO `migrations` VALUES("19","2025_09_07_171826_moisecolages","1");
INSERT INTO `migrations` VALUES("20","2025_09_08_174136_ajout_status_admission","1");
INSERT INTO `migrations` VALUES("21","2025_09_10_101752_ajout_ac_id_etudiant","1");
INSERT INTO `migrations` VALUES("22","2025_09_15_183236_notetotal","1");
INSERT INTO `migrations` VALUES("23","2025_09_18_105330_ajout_transfert","1");
INSERT INTO `migrations` VALUES("24","2025_09_22_181734_workers","1");
INSERT INTO `migrations` VALUES("25","2025_09_22_192718_professions","1");
INSERT INTO `migrations` VALUES("26","2025_09_22_193054_ajout_relation_workers_profession","1");
INSERT INTO `migrations` VALUES("27","2025_09_22_193505_ajout_relation_workers_acs","1");
INSERT INTO `migrations` VALUES("28","2025_09_22_194518_moissalaires","1");
INSERT INTO `migrations` VALUES("29","2025_09_22_195225_ajout_status_workers","1");
INSERT INTO `migrations` VALUES("30","2025_09_22_200524_matieres","1");
INSERT INTO `migrations` VALUES("31","2025_09_22_202452_ajout_time_stamps_profession","1");
INSERT INTO `migrations` VALUES("32","2025_09_22_202547_ajout_timestamps_workers","1");
INSERT INTO `migrations` VALUES("33","2025_09_22_202730_ajout_timestamps_moissalaires","1");
INSERT INTO `migrations` VALUES("34","2025_09_22_202831_ajout_timestamps_matiere","1");
INSERT INTO `migrations` VALUES("35","2025_09_23_122048_ajout_salle_matiere","1");
INSERT INTO `migrations` VALUES("36","2025_09_23_125503_ajout_telephone_et_photo_workers","1");
INSERT INTO `migrations` VALUES("37","2025_09_28_111205_depenses","1");
INSERT INTO `migrations` VALUES("38","2025_09_28_123723_depensesparmois","1");
INSERT INTO `migrations` VALUES("39","2025_09_28_124923_revenusparmois","1");
INSERT INTO `migrations` VALUES("40","2025_09_28_125329_revenus","1");
INSERT INTO `migrations` VALUES("41","2025_09_30_063220_nifs","1");
INSERT INTO `migrations` VALUES("42","2025_09_30_063630_identifys","1");
INSERT INTO `migrations` VALUES("43","2025_09_30_071213_times_nifs","1");
INSERT INTO `migrations` VALUES("44","2025_09_30_071244_times_ident","1");
INSERT INTO `migrations` VALUES("45","2025_09_30_081715_domaines","1");
INSERT INTO `migrations` VALUES("46","2025_10_01_061437_ajout_reste_moissalaires","1");
INSERT INTO `migrations` VALUES("47","2025_10_01_073457_archsals","1");
INSERT INTO `migrations` VALUES("48","2025_10_02_063308_archconges","1");
INSERT INTO `migrations` VALUES("49","2025_10_02_200341_ajout_debut_acs","1");
INSERT INTO `migrations` VALUES("50","2025_10_04_110641_ajouts","1");
INSERT INTO `migrations` VALUES("51","2025_10_04_112131_moins","1");
INSERT INTO `migrations` VALUES("52","2025_10_04_184305_audits","1");
INSERT INTO `migrations` VALUES("53","2025_10_10_170456_recues","1");
INSERT INTO `migrations` VALUES("54","2025_11_21_113517_school","1");
INSERT INTO `migrations` VALUES("55","2025_11_28_205024_pages","1");
INSERT INTO `migrations` VALUES("56","2025_11_28_212133_roles","1");
INSERT INTO `migrations` VALUES("57","2025_11_28_212510_roles_pages","1");
INSERT INTO `migrations` VALUES("58","2025_12_17_083547_role_id","1");
INSERT INTO `migrations` VALUES("59","2026_02_24_141755_ajout_isquit_etudiant","1");
INSERT INTO `migrations` VALUES("60","2026_03_06_135737_student_droit","1");
INSERT INTO `migrations` VALUES("61","2026_03_07_114949_droithisto","1");
INSERT INTO `migrations` VALUES("62","2026_03_07_130718_ajout_reste_droithistos","1");
INSERT INTO `migrations` VALUES("63","2026_03_08_214057_ajout_droitkermesse_ancien","1");
INSERT INTO `migrations` VALUES("64","2026_03_12_122608_ajout_partielecolage","1");
INSERT INTO `migrations` VALUES("65","2026_03_14_124306_ecohistos","1");
INSERT INTO `migrations` VALUES("66","2026_03_15_191723_studentkermesses","1");
INSERT INTO `migrations` VALUES("67","2026_03_15_192637_kermessehistos","1");



DROP TABLE IF EXISTS `moins`;
CREATE TABLE `moins` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `motif` varchar(255) NOT NULL,
  `ecolage` int(11) NOT NULL DEFAULT 0,
  `droit` int(11) NOT NULL DEFAULT 0,
  `kermesse` int(11) NOT NULL DEFAULT 0,
  `ac_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `moins_ac_id_foreign` (`ac_id`),
  CONSTRAINT `moins_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `moins` VALUES("1","test","1000","0","0","1","2026-03-27 22:46:41","2026-03-27 22:46:41");



DROP TABLE IF EXISTS `moisecolages`;
CREATE TABLE `moisecolages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `mois` varchar(255) NOT NULL,
  `payé` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `et_id` bigint(20) unsigned NOT NULL,
  `ac_id` bigint(20) unsigned NOT NULL,
  `paid` int(11) NOT NULL DEFAULT 0,
  `reste` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `moisecolages_et_id_foreign` (`et_id`),
  KEY `moisecolages_ac_id_foreign` (`ac_id`),
  CONSTRAINT `moisecolages_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `moisecolages_et_id_foreign` FOREIGN KEY (`et_id`) REFERENCES `sousetudiants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `moisecolages` VALUES("1","Janvier","1","2026-03-27 21:00:42","2026-03-27 21:31:18","1","1","20000","0");
INSERT INTO `moisecolages` VALUES("2","Février","0","2026-03-27 21:00:42","2026-03-27 21:00:42","1","1","0","20000");
INSERT INTO `moisecolages` VALUES("3","Mars","0","2026-03-27 21:00:42","2026-03-27 21:00:42","1","1","0","20000");
INSERT INTO `moisecolages` VALUES("4","Avril","0","2026-03-27 21:00:42","2026-03-27 21:00:42","1","1","0","20000");
INSERT INTO `moisecolages` VALUES("5","Mai","0","2026-03-27 21:00:42","2026-03-27 21:00:42","1","1","0","20000");
INSERT INTO `moisecolages` VALUES("6","Juin","0","2026-03-27 21:00:42","2026-03-27 21:00:42","1","1","0","20000");
INSERT INTO `moisecolages` VALUES("7","Juillet","0","2026-03-27 21:00:42","2026-03-27 21:00:42","1","1","0","20000");
INSERT INTO `moisecolages` VALUES("8","Août","0","2026-03-27 21:00:42","2026-03-27 21:00:42","1","1","0","20000");
INSERT INTO `moisecolages` VALUES("9","Septembre","0","2026-03-27 21:00:42","2026-03-27 21:00:42","1","1","0","20000");
INSERT INTO `moisecolages` VALUES("10","Octobre","0","2026-03-27 21:00:42","2026-03-27 21:00:42","1","1","0","20000");
INSERT INTO `moisecolages` VALUES("11","Novembre","0","2026-03-27 21:00:42","2026-03-27 21:00:42","1","1","0","20000");
INSERT INTO `moisecolages` VALUES("12","Décembre","0","2026-03-27 21:00:42","2026-03-27 21:00:42","1","1","0","20000");
INSERT INTO `moisecolages` VALUES("13","Janvier","1","2026-03-27 21:20:19","2026-03-27 21:30:56","2","1","20000","0");
INSERT INTO `moisecolages` VALUES("14","Février","0","2026-03-27 21:20:19","2026-03-27 21:20:19","2","1","0","20000");
INSERT INTO `moisecolages` VALUES("15","Mars","0","2026-03-27 21:20:19","2026-03-27 21:20:19","2","1","0","20000");
INSERT INTO `moisecolages` VALUES("16","Avril","0","2026-03-27 21:20:19","2026-03-27 21:20:19","2","1","0","20000");
INSERT INTO `moisecolages` VALUES("17","Mai","0","2026-03-27 21:20:19","2026-03-27 21:20:19","2","1","0","20000");
INSERT INTO `moisecolages` VALUES("18","Juin","0","2026-03-27 21:20:19","2026-03-27 21:20:19","2","1","0","20000");
INSERT INTO `moisecolages` VALUES("19","Juillet","0","2026-03-27 21:20:19","2026-03-27 21:20:19","2","1","0","20000");
INSERT INTO `moisecolages` VALUES("20","Août","0","2026-03-27 21:20:19","2026-03-27 21:20:19","2","1","0","20000");
INSERT INTO `moisecolages` VALUES("21","Septembre","0","2026-03-27 21:20:19","2026-03-27 21:20:19","2","1","0","20000");
INSERT INTO `moisecolages` VALUES("22","Octobre","0","2026-03-27 21:20:19","2026-03-27 21:20:19","2","1","0","20000");
INSERT INTO `moisecolages` VALUES("23","Novembre","0","2026-03-27 21:20:19","2026-03-27 21:20:19","2","1","0","20000");
INSERT INTO `moisecolages` VALUES("24","Décembre","0","2026-03-27 21:20:19","2026-03-27 21:20:19","2","1","0","20000");
INSERT INTO `moisecolages` VALUES("25","Janvier","1","2026-03-27 21:25:01","2026-03-27 21:28:49","3","1","15000","0");
INSERT INTO `moisecolages` VALUES("26","Février","0","2026-03-27 21:25:01","2026-03-27 21:54:13","3","1","0","15000");
INSERT INTO `moisecolages` VALUES("27","Mars","0","2026-03-27 21:25:01","2026-03-27 21:25:01","3","1","0","15000");
INSERT INTO `moisecolages` VALUES("28","Avril","0","2026-03-27 21:25:01","2026-03-27 21:25:01","3","1","0","15000");
INSERT INTO `moisecolages` VALUES("29","Mai","0","2026-03-27 21:25:01","2026-03-27 21:25:01","3","1","0","15000");
INSERT INTO `moisecolages` VALUES("30","Juin","0","2026-03-27 21:25:01","2026-03-27 21:25:01","3","1","0","15000");
INSERT INTO `moisecolages` VALUES("31","Juillet","0","2026-03-27 21:25:01","2026-03-27 21:25:01","3","1","0","15000");
INSERT INTO `moisecolages` VALUES("32","Août","0","2026-03-27 21:25:01","2026-03-27 21:25:01","3","1","0","15000");
INSERT INTO `moisecolages` VALUES("33","Septembre","0","2026-03-27 21:25:01","2026-03-27 21:25:01","3","1","0","15000");
INSERT INTO `moisecolages` VALUES("34","Octobre","0","2026-03-27 21:25:01","2026-03-27 21:25:01","3","1","0","15000");
INSERT INTO `moisecolages` VALUES("35","Novembre","0","2026-03-27 21:25:01","2026-03-27 21:25:01","3","1","0","15000");
INSERT INTO `moisecolages` VALUES("36","Décembre","0","2026-03-27 21:25:01","2026-03-27 21:25:01","3","1","0","15000");



DROP TABLE IF EXISTS `moissalaires`;
CREATE TABLE `moissalaires` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `mois` varchar(255) NOT NULL,
  `ac_id` bigint(20) unsigned NOT NULL,
  `payé` tinyint(1) NOT NULL DEFAULT 0,
  `w_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `reste` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `moissalaires_w_id_foreign` (`w_id`),
  KEY `moissalaires_ac_id_foreign` (`ac_id`),
  CONSTRAINT `moissalaires_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `moissalaires_w_id_foreign` FOREIGN KEY (`w_id`) REFERENCES `workers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `moissalaires` VALUES("1","Janvier","1","0","1","2026-03-28 23:50:34","2026-03-28 23:52:29","10000000");
INSERT INTO `moissalaires` VALUES("2","Février","1","0","1","2026-03-28 23:50:34","2026-03-28 23:50:34","90000000");
INSERT INTO `moissalaires` VALUES("3","Mars","1","0","1","2026-03-28 23:50:34","2026-03-28 23:50:34","90000000");
INSERT INTO `moissalaires` VALUES("4","Avril","1","0","1","2026-03-28 23:50:34","2026-03-28 23:50:34","90000000");
INSERT INTO `moissalaires` VALUES("5","Mai","1","0","1","2026-03-28 23:50:34","2026-03-28 23:50:34","90000000");
INSERT INTO `moissalaires` VALUES("6","Juin","1","0","1","2026-03-28 23:50:34","2026-03-28 23:50:34","90000000");
INSERT INTO `moissalaires` VALUES("7","Juillet","1","0","1","2026-03-28 23:50:34","2026-03-28 23:50:34","90000000");
INSERT INTO `moissalaires` VALUES("8","Août","1","0","1","2026-03-28 23:50:34","2026-03-28 23:50:34","90000000");
INSERT INTO `moissalaires` VALUES("9","Septembre","1","0","1","2026-03-28 23:50:34","2026-03-28 23:50:34","90000000");
INSERT INTO `moissalaires` VALUES("10","Octobre","1","0","1","2026-03-28 23:50:34","2026-03-28 23:50:34","90000000");
INSERT INTO `moissalaires` VALUES("11","Novembre","1","0","1","2026-03-28 23:50:34","2026-03-28 23:50:34","90000000");
INSERT INTO `moissalaires` VALUES("12","Décembre","1","0","1","2026-03-28 23:50:34","2026-03-28 23:50:34","90000000");



DROP TABLE IF EXISTS `nifs`;
CREATE TABLE `nifs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nif` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `nifs` VALUES("1","fdfdfdfdfdf","2026-03-29 00:56:10","2026-03-29 00:56:10");



DROP TABLE IF EXISTS `pages`;
CREATE TABLE `pages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `page_name` varchar(255) NOT NULL,
  `page_path` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `pages` VALUES("1","Gestion Droits","/home/StudentsDroit",NULL,NULL);
INSERT INTO `pages` VALUES("2","Gestion Ecolages","/home/ecolagestudents",NULL,NULL);
INSERT INTO `pages` VALUES("3","Gestion Notes","/home/notemanagements",NULL,NULL);
INSERT INTO `pages` VALUES("4","information Etudiants","/home/StudentsInfo",NULL,NULL);
INSERT INTO `pages` VALUES("5","Dashboard","/home",NULL,NULL);
INSERT INTO `pages` VALUES("6","Gestion Kermesses","/home/StudentsKermess",NULL,NULL);
INSERT INTO `pages` VALUES("7","Etudiants inactifs","/home/studentsInactif",NULL,NULL);
INSERT INTO `pages` VALUES("8","Paramètres","/home/parametre",NULL,NULL);
INSERT INTO `pages` VALUES("9","Information Employés","/home/EmployeInfo",NULL,NULL);
INSERT INTO `pages` VALUES("10","Suivi Employés","/home/Employersuivi",NULL,NULL);
INSERT INTO `pages` VALUES("11","Historiques D\'activités","/home/Historique",NULL,NULL);



DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




DROP TABLE IF EXISTS `personal_access_tokens`;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` text NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`),
  KEY `personal_access_tokens_expires_at_index` (`expires_at`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `personal_access_tokens` VALUES("4","App\\Models\\User","1","email","c52020af7d6071d8bf4047058950cc8e15aab4719958266888f47a9b2e8e08c6","[\"*\"]","2026-03-29 01:05:24",NULL,"2026-03-28 23:24:17","2026-03-29 01:05:24");



DROP TABLE IF EXISTS `professions`;
CREATE TABLE `professions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `profession` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `professions` VALUES("1","Professeur","2026-03-28 23:48:48","2026-03-28 23:48:48");



DROP TABLE IF EXISTS `recues`;
CREATE TABLE `recues` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `num` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




DROP TABLE IF EXISTS `revenus`;
CREATE TABLE `revenus` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `solde` int(11) NOT NULL DEFAULT 0,
  `ac_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `revenus_ac_id_foreign` (`ac_id`),
  CONSTRAINT `revenus_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




DROP TABLE IF EXISTS `revenusparmois`;
CREATE TABLE `revenusparmois` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `solde` int(11) NOT NULL DEFAULT 0,
  `ac_id` bigint(20) unsigned NOT NULL,
  `mois` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `revenusparmois_ac_id_foreign` (`ac_id`),
  CONSTRAINT `revenusparmois_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `revenusparmois` VALUES("1","100152000","1","26-03-27","2026-03-27 21:26:17","2026-03-28 23:51:53");



DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `roles` VALUES("1","Admin",NULL,NULL);



DROP TABLE IF EXISTS `roles_pages`;
CREATE TABLE `roles_pages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) unsigned NOT NULL,
  `page_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `roles_pages_role_id_foreign` (`role_id`),
  KEY `roles_pages_page_id_foreign` (`page_id`),
  CONSTRAINT `roles_pages_page_id_foreign` FOREIGN KEY (`page_id`) REFERENCES `pages` (`id`) ON DELETE CASCADE,
  CONSTRAINT `roles_pages_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `roles_pages` VALUES("11","1","1","2026-03-27 20:42:48","2026-03-27 20:42:48");
INSERT INTO `roles_pages` VALUES("12","1","2","2026-03-27 20:42:48","2026-03-27 20:42:48");
INSERT INTO `roles_pages` VALUES("13","1","4","2026-03-27 20:42:48","2026-03-27 20:42:48");
INSERT INTO `roles_pages` VALUES("14","1","5","2026-03-27 20:42:48","2026-03-27 20:42:48");
INSERT INTO `roles_pages` VALUES("15","1","6","2026-03-27 20:42:48","2026-03-27 20:42:48");
INSERT INTO `roles_pages` VALUES("16","1","7","2026-03-27 20:42:48","2026-03-27 20:42:48");
INSERT INTO `roles_pages` VALUES("17","1","8","2026-03-27 20:42:48","2026-03-27 20:42:48");
INSERT INTO `roles_pages` VALUES("18","1","9","2026-03-27 20:42:48","2026-03-27 20:42:48");
INSERT INTO `roles_pages` VALUES("19","1","10","2026-03-27 20:42:48","2026-03-27 20:42:48");
INSERT INTO `roles_pages` VALUES("20","1","11","2026-03-27 20:42:48","2026-03-27 20:42:48");
INSERT INTO `roles_pages` VALUES("21","1","3","2026-03-27 20:42:48","2026-03-27 20:42:48");



DROP TABLE IF EXISTS `salles`;
CREATE TABLE `salles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nom_salle` varchar(255) NOT NULL,
  `effectif` int(11) NOT NULL,
  `cl_id` bigint(20) unsigned NOT NULL,
  `ac_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `salles_cl_id_foreign` (`cl_id`),
  KEY `salles_ac_id_foreign` (`ac_id`),
  CONSTRAINT `salles_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `salles_cl_id_foreign` FOREIGN KEY (`cl_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `salles` VALUES("1","CM1 A","3","1","1","2026-03-27 20:54:36","2026-03-27 20:54:36");
INSERT INTO `salles` VALUES("2","CM1 B","3","1","1","2026-03-27 20:54:51","2026-03-27 20:54:51");
INSERT INTO `salles` VALUES("3","CM2 A","3","2","1","2026-03-27 20:55:07","2026-03-27 20:55:13");
INSERT INTO `salles` VALUES("4","CM2 B","3","2","1","2026-03-27 20:55:25","2026-03-27 20:55:25");



DROP TABLE IF EXISTS `schools`;
CREATE TABLE `schools` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `schools` VALUES("1","rosette 3","2026-03-29 00:56:25","2026-03-29 00:56:25");



DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




DROP TABLE IF EXISTS `sousetudiants`;
CREATE TABLE `sousetudiants` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `cl_id` bigint(20) unsigned NOT NULL,
  `sa_id` bigint(20) unsigned DEFAULT NULL,
  `ac_id` bigint(20) unsigned NOT NULL,
  `et_id` bigint(20) unsigned NOT NULL,
  `note1` decimal(8,2) NOT NULL DEFAULT 0.00,
  `note2` decimal(8,2) NOT NULL DEFAULT 0.00,
  `note3` decimal(8,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status_admissions` enum('admis','cours','redoublé','suspendu') NOT NULL DEFAULT 'cours',
  `noteTotal` decimal(8,2) NOT NULL DEFAULT 0.00,
  `transfert` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `sousetudiants_cl_id_foreign` (`cl_id`),
  KEY `sousetudiants_et_id_foreign` (`et_id`),
  KEY `sousetudiants_sa_id_foreign` (`sa_id`),
  KEY `sousetudiants_ac_id_foreign` (`ac_id`),
  CONSTRAINT `sousetudiants_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sousetudiants_cl_id_foreign` FOREIGN KEY (`cl_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sousetudiants_et_id_foreign` FOREIGN KEY (`et_id`) REFERENCES `etudiants` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sousetudiants_sa_id_foreign` FOREIGN KEY (`sa_id`) REFERENCES `salles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `sousetudiants` VALUES("1","2","3","1","1","0.00","0.00","0.00","2026-03-27 21:00:42","2026-03-27 21:00:42","cours","0.00","0");
INSERT INTO `sousetudiants` VALUES("2","2","4","1","2","0.00","0.00","0.00","2026-03-27 21:20:18","2026-03-27 21:20:18","cours","0.00","0");
INSERT INTO `sousetudiants` VALUES("3","1","1","1","3","0.00","0.00","0.00","2026-03-27 21:25:01","2026-03-28 20:38:41","redoublé","0.00","0");



DROP TABLE IF EXISTS `studentdroits`;
CREATE TABLE `studentdroits` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `se_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `reste` int(11) NOT NULL DEFAULT 0,
  `payed` tinyint(1) NOT NULL DEFAULT 0,
  `paid` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `studentdroits_se_id_foreign` (`se_id`),
  CONSTRAINT `studentdroits_se_id_foreign` FOREIGN KEY (`se_id`) REFERENCES `sousetudiants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `studentdroits` VALUES("1","1","2026-03-27 21:00:42","2026-03-27 21:00:42","15000","0","0");
INSERT INTO `studentdroits` VALUES("2","2","2026-03-27 21:20:18","2026-03-27 21:20:18","15000","0","0");
INSERT INTO `studentdroits` VALUES("3","3","2026-03-27 21:25:01","2026-03-28 20:48:20","0","1","10000");



DROP TABLE IF EXISTS `studentkermesses`;
CREATE TABLE `studentkermesses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `se_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `reste` int(11) NOT NULL DEFAULT 0,
  `payed` tinyint(1) NOT NULL DEFAULT 0,
  `paid` int(11) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  KEY `studentkermesses_se_id_foreign` (`se_id`),
  CONSTRAINT `studentkermesses_se_id_foreign` FOREIGN KEY (`se_id`) REFERENCES `sousetudiants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `studentkermesses` VALUES("1","1","2026-03-27 21:00:42","2026-03-27 21:00:42","10000","0","0");
INSERT INTO `studentkermesses` VALUES("2","2","2026-03-27 21:20:19","2026-03-27 21:20:19","10000","0","0");
INSERT INTO `studentkermesses` VALUES("3","3","2026-03-27 21:25:01","2026-03-28 20:59:49","7000","0","0");



DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `firstname` varchar(255) DEFAULT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` VALUES("1","Rosette","rosette@gmail.com",NULL,"$2y$12$oFhzpTltn7qxJ9FcLRxdke6h6EPeUlb9tT0hjcr6XRI0SDn4mgtOe",NULL,"2026-03-27 20:42:02","2026-03-27 20:42:02",NULL,"Rosette","1");



DROP TABLE IF EXISTS `workers`;
CREATE TABLE `workers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `email` varchar(255) DEFAULT NULL,
  `sexe` tinyint(1) NOT NULL,
  `adresse` varchar(255) NOT NULL,
  `salaire_base` int(11) NOT NULL,
  `p_id` bigint(20) unsigned NOT NULL,
  `ac_id` bigint(20) unsigned NOT NULL,
  `status` enum('actif','congé','suspendu') NOT NULL DEFAULT 'actif',
  `sa_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `photo` text NOT NULL,
  `telephone` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `workers_p_id_foreign` (`p_id`),
  KEY `workers_ac_id_foreign` (`ac_id`),
  CONSTRAINT `workers_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `workers_p_id_foreign` FOREIGN KEY (`p_id`) REFERENCES `professions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `workers` VALUES("1","fdfdf","fdfdf",NULL,"1","test","90000000","1","1","actif",NULL,"2026-03-28 23:50:34","2026-03-29 00:01:31","default.png","343434");



