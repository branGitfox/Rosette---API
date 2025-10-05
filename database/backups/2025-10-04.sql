DROP TABLE IF EXISTS `acs`;
CREATE TABLE `acs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `annee` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `debut` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `acs` VALUES("1","2026","2025-09-30 09:12:24","2025-09-30 09:12:24","");



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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `admissions` VALUES("2","2","1","2025-09-30 11:01:39","2025-09-30 11:01:39");



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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `ajouts` VALUES("1","bonus","400000","0","0","1","2025-10-04 14:19:58","2025-10-04 14:19:58");
INSERT INTO `ajouts` VALUES("2","droit","0","4000","0","1","2025-10-04 14:44:17","2025-10-04 14:44:17");



DROP TABLE IF EXISTS `archconges`;
CREATE TABLE `archconges` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `debut` varchar(255) NOT NULL,
  `fin` varchar(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `ac_id` bigint(20) unsigned NOT NULL,
  `w_id` bigint(20) unsigned NOT NULL,
  `motif` text NOT NULL DEFAULT 'Droit de congé',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `archconges_ac_id_foreign` (`ac_id`),
  KEY `archconges_w_id_foreign` (`w_id`),
  CONSTRAINT `archconges_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `archconges_w_id_foreign` FOREIGN KEY (`w_id`) REFERENCES `workers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `archconges` VALUES("4","2025-10-02","2025-10-03","0","1","1","testeer","2025-10-02 09:06:12","2025-10-02 09:56:15");
INSERT INTO `archconges` VALUES("5","2025-10-03","2025-10-04","0","1","1","test de test","2025-10-02 09:57:35","2025-10-04 10:28:26");



DROP TABLE IF EXISTS `archsals`;
CREATE TABLE `archsals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `montant` int(11) NOT NULL,
  `mois` varchar(255) NOT NULL,
  `type` tinyint(1) NOT NULL,
  `ac_id` bigint(20) unsigned NOT NULL,
  `w_id` bigint(20) unsigned NOT NULL,
  `motif` text NOT NULL DEFAULT 'Paiement salaire',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `archsals_ac_id_foreign` (`ac_id`),
  KEY `archsals_w_id_foreign` (`w_id`),
  CONSTRAINT `archsals_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `archsals_w_id_foreign` FOREIGN KEY (`w_id`) REFERENCES `workers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `archsals` VALUES("1","119999","Mars","1","1","1","test deedd salaire","2025-10-01 09:34:31","2025-10-01 09:34:31");
INSERT INTO `archsals` VALUES("2","3703689","Janvier,Février,Mars","1","1","2","test de salaire complet","2025-10-01 09:49:41","2025-10-01 09:49:41");



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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




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
  PRIMARY KEY (`id`),
  KEY `classes_ac_id_foreign` (`ac_id`),
  CONSTRAINT `classes_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `classes` VALUES("1","test1","12000","1","2025-09-30 10:48:36","2025-09-30 10:48:36","12000","12000");



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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `depensesparmois` VALUES("1","3823688","1","25-10-01","2025-10-01 09:34:31","2025-10-01 09:49:41");
INSERT INTO `depensesparmois` VALUES("2","48000","1","25-10-04","2025-10-04 13:20:51","2025-10-04 13:39:44");



DROP TABLE IF EXISTS `domaines`;
CREATE TABLE `domaines` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `domaines` VALUES("1","Math","2025-09-30 08:26:59","2025-09-30 08:26:59");
INSERT INTO `domaines` VALUES("3","sdsdssd","2025-09-30 08:27:36","2025-09-30 08:27:36");



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

INSERT INTO `droits` VALUES("1","4000","1","2025-09-30 10:49:47","2025-10-04 14:44:17");



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

INSERT INTO `ecolages` VALUES("1","-1039691","1","2025-09-30 10:49:47","2025-10-04 21:23:34");



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
  PRIMARY KEY (`id`),
  KEY `etudiants_ac_id_foreign` (`ac_id`),
  CONSTRAINT `etudiants_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `etudiants` VALUES("1","test","test","1","2025-09-24","etst","test","est","erer","erer","123254","erer","erere","sdsd","sdsd","12324","ROS25-0","","default.png","2025-09-30 10:49:46","2025-09-30 10:49:46","1","1");
INSERT INTO `etudiants` VALUES("2","sdsdsd","sdsdsd","1","2025-09-26","dsdsdsd","sdsdsd","sdsdsdsd","sdsd","sdsdsd","sdsdd","sdsdsd","sdsdsd","dsdsd","sdsds","dsd","ROS25-1","","default.png","2025-09-30 10:56:19","2025-09-30 10:56:19","1","1");



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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `identifys` VALUES("2","dssd","2025-09-30 07:59:02","2025-09-30 07:59:02");



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

INSERT INTO `kermesses` VALUES("1","0","1","2025-09-30 10:49:47","2025-10-04 14:44:17");



DROP TABLE IF EXISTS `macs`;
CREATE TABLE `macs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `mois` varchar(255) NOT NULL,
  `id_ac` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `macs` VALUES("1","Janvier","2026","2025-09-30 09:12:24","2025-09-30 09:12:24");
INSERT INTO `macs` VALUES("2","Février","2026","2025-09-30 09:12:24","2025-09-30 09:12:24");
INSERT INTO `macs` VALUES("3","Mars","2026","2025-09-30 09:12:24","2025-09-30 09:12:24");



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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `matieres` VALUES("1","1","Math","2025-09-30 09:14:32","2025-09-30 09:14:32","wewewwe");
INSERT INTO `matieres` VALUES("2","2","sdsdssd","2025-09-30 09:19:32","2025-09-30 09:19:32","23232");



DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
INSERT INTO `migrations` VALUES("41","2025_09_30_063220_nifs","2");
INSERT INTO `migrations` VALUES("42","2025_09_30_063630_identifys","3");
INSERT INTO `migrations` VALUES("43","2025_09_30_071213_times_nifs","4");
INSERT INTO `migrations` VALUES("44","2025_09_30_071244_times_ident","4");
INSERT INTO `migrations` VALUES("45","2025_09_30_081715_domaines","5");
INSERT INTO `migrations` VALUES("46","2025_10_01_061437_ajout_reste_moissalaires","6");
INSERT INTO `migrations` VALUES("47","2025_10_01_073326_archsals","7");
INSERT INTO `migrations` VALUES("48","2025_10_01_073457_archsals","8");
INSERT INTO `migrations` VALUES("49","2025_10_02_063308_archconges","9");
INSERT INTO `migrations` VALUES("50","2025_10_02_200341_ajout_debut_acs","10");
INSERT INTO `migrations` VALUES("51","2025_10_04_110641_plus","10");
INSERT INTO `migrations` VALUES("52","2025_10_04_112131_moins","10");
INSERT INTO `migrations` VALUES("53","2025_10_04_110641_ajouts","11");
INSERT INTO `migrations` VALUES("54","2025_10_04_184305_audits","12");



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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `moins` VALUES("1","tes de retirement","0","0","0","1","2025-10-04 13:20:51","2025-10-04 13:20:51");
INSERT INTO `moins` VALUES("2","teter","0","24000","0","1","2025-10-04 13:33:23","2025-10-04 13:33:23");
INSERT INTO `moins` VALUES("3","tyty","0","0","24000","1","2025-10-04 13:39:44","2025-10-04 13:39:44");



DROP TABLE IF EXISTS `moisecolages`;
CREATE TABLE `moisecolages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `mois` varchar(255) NOT NULL,
  `payé` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `et_id` bigint(20) unsigned NOT NULL,
  `ac_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `moisecolages_et_id_foreign` (`et_id`),
  KEY `moisecolages_ac_id_foreign` (`ac_id`),
  CONSTRAINT `moisecolages_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE,
  CONSTRAINT `moisecolages_et_id_foreign` FOREIGN KEY (`et_id`) REFERENCES `sousetudiants` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `moisecolages` VALUES("1","Janvier","1","2025-09-30 10:49:47","2025-09-30 10:49:47","1","1");
INSERT INTO `moisecolages` VALUES("2","Février","1","2025-09-30 10:49:47","2025-10-02 08:04:25","1","1");
INSERT INTO `moisecolages` VALUES("3","Mars","0","2025-09-30 10:49:47","2025-09-30 10:49:47","1","1");
INSERT INTO `moisecolages` VALUES("4","Janvier","1","2025-09-30 10:56:19","2025-09-30 10:56:19","2","1");
INSERT INTO `moisecolages` VALUES("5","Février","1","2025-09-30 10:56:19","2025-10-04 21:23:34","2","1");
INSERT INTO `moisecolages` VALUES("6","Mars","0","2025-09-30 10:56:19","2025-09-30 10:56:19","2","1");



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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `moissalaires` VALUES("1","Janvier","1","1","1","2025-09-30 09:13:00","2025-09-30 09:13:00","0");
INSERT INTO `moissalaires` VALUES("2","Février","1","0","1","2025-09-30 09:13:00","2025-09-30 09:13:00","0");
INSERT INTO `moissalaires` VALUES("3","Mars","1","1","1","2025-09-30 09:13:00","2025-10-01 09:34:31","0");
INSERT INTO `moissalaires` VALUES("4","Janvier","1","1","2","2025-09-30 09:19:32","2025-10-01 09:49:41","0");
INSERT INTO `moissalaires` VALUES("5","Février","1","1","2","2025-09-30 09:19:32","2025-10-01 09:49:41","0");
INSERT INTO `moissalaires` VALUES("6","Mars","1","1","2","2025-09-30 09:19:32","2025-10-01 09:49:41","0");



DROP TABLE IF EXISTS `nifs`;
CREATE TABLE `nifs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nif` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `nifs` VALUES("2","tessdsd","2025-09-30 07:51:29","2025-09-30 07:51:29");



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
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `personal_access_tokens` VALUES("1","App\\Models\\User","2","email","783b2fb69c0c4d748ee03fbb8bc3989ceac922cdbdf44b0d7f3e97b954375481","[\"*\"]",NULL,NULL,"2025-09-30 07:07:41","2025-09-30 07:07:41");
INSERT INTO `personal_access_tokens` VALUES("2","App\\Models\\User","2","email","b862488aac3ba0a8eecab61dc92bd33de7985b5794b2e566cdd472aef27a707a","[\"*\"]",NULL,NULL,"2025-09-30 07:45:28","2025-09-30 07:45:28");
INSERT INTO `personal_access_tokens` VALUES("3","App\\Models\\User","2","email","5769584596ffef4e60c1d98debe6d11939f62d07432119c94ecc51583a02c04d","[\"*\"]",NULL,NULL,"2025-09-30 10:33:43","2025-09-30 10:33:43");
INSERT INTO `personal_access_tokens` VALUES("4","App\\Models\\User","2","email","81e29def0221de47d2d31d91fe0e47b7d1cefe41dcfb3d309e86609ffb16e89c","[\"*\"]",NULL,NULL,"2025-09-30 20:08:08","2025-09-30 20:08:08");
INSERT INTO `personal_access_tokens` VALUES("5","App\\Models\\User","2","email","948d7a2f482528ed94964a43539398e32fb040037fddbec854afc15cc74f8021","[\"*\"]",NULL,NULL,"2025-10-02 06:04:47","2025-10-02 06:04:47");
INSERT INTO `personal_access_tokens` VALUES("7","App\\Models\\User","3","email","48f6b48aaf57d1ed4c463097afabb6037cb449b4c104d14d6a23b0d479ee43d0","[\"*\"]","2025-10-04 21:51:31",NULL,"2025-10-04 21:00:12","2025-10-04 21:51:31");



DROP TABLE IF EXISTS `plus`;
CREATE TABLE `plus` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `motif` varchar(255) NOT NULL,
  `ecolage` int(11) NOT NULL DEFAULT 0,
  `droit` int(11) NOT NULL DEFAULT 0,
  `kermesse` int(11) NOT NULL DEFAULT 0,
  `ac_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `plus_ac_id_foreign` (`ac_id`),
  CONSTRAINT `plus_ac_id_foreign` FOREIGN KEY (`ac_id`) REFERENCES `acs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




DROP TABLE IF EXISTS `professions`;
CREATE TABLE `professions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `profession` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `professions` VALUES("1","Professeurs","2025-09-30 09:09:31","2025-09-30 09:09:31");



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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `revenusparmois` VALUES("1","404000","1","25-10-04","2025-10-04 14:19:58","2025-10-04 14:44:17");
INSERT INTO `revenusparmois` VALUES("2","6000","1","Février","2025-10-04 21:23:34","2025-10-04 21:23:34");



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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `salles` VALUES("1","test1","2","1","1","2025-09-30 10:48:48","2025-09-30 10:48:48");



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
  `sa_id` bigint(20) unsigned NOT NULL,
  `ac_id` bigint(20) unsigned NOT NULL,
  `et_id` bigint(20) unsigned NOT NULL,
  `note1` decimal(8,2) DEFAULT NULL,
  `note2` decimal(8,2) DEFAULT NULL,
  `note3` decimal(8,2) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `status_admissions` enum('admis','cours','redoublé','suspendu') NOT NULL DEFAULT 'cours',
  `noteTotal` int(11) DEFAULT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `sousetudiants` VALUES("1","1","1","1","1",NULL,NULL,NULL,"2025-09-30 10:49:46","2025-09-30 10:49:46","cours",NULL,"0");
INSERT INTO `sousetudiants` VALUES("2","1","1","1","2",NULL,NULL,NULL,"2025-09-30 10:56:19","2025-09-30 10:56:19","cours",NULL,"0");



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
  `role` enum('directeur','secretaire') NOT NULL DEFAULT 'secretaire',
  `firstname` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` VALUES("2","Brandon","v@gmail.com",NULL,"$2y$12$frLtATnZ3.wMBg7AdUMUTOYYGDuai1f8SBKOe6g3jWrUA4bgVwEoG",NULL,"2025-09-30 07:07:33","2025-09-30 07:07:33",NULL,"directeur","Ravomanana");
INSERT INTO `users` VALUES("3","Rosette","rosette@gmail.com",NULL,"$2y$12$/Mze5lu5QJPufFD5Uf5JVudTLAdwZ8z69aaoDyEIVCLlzfWxLpJt.",NULL,"2025-10-04 10:27:38","2025-10-04 10:27:38",NULL,"directeur","Rosette");
INSERT INTO `users` VALUES("4","Ravomanana","vb@gmail.com",NULL,"$2y$12$u0Q0F.ouc5Qhm0CJt/2JbuRvJAm9Di2l4oNcQ.WZYWPwO7rMES3.q",NULL,"2025-10-04 19:03:24","2025-10-04 19:03:24",NULL,"directeur","Brandon Fidelin");



DROP TABLE IF EXISTS `workers`;
CREATE TABLE `workers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `workers` VALUES("1","dfdf","dfdf","fd@gmail.com","1","dsddsds","119999","1","1","actif",NULL,"2025-09-30 09:13:00","2025-10-04 10:28:26","mDyfygWK8zrneIj8bzEpiZYMLw2u1jmMSbTlUvRZ.png","0389411835");
INSERT INTO `workers` VALUES("2","dfdfd","sdsdsd","f@gmail.com","1","sdsd","1234563","1","1","actif",NULL,"2025-09-30 09:19:32","2025-09-30 09:19:32","fsE5eOJlbBLuAejbxB74tLDfbNVL9UhM2hzxgZ1K.png","564645654");



