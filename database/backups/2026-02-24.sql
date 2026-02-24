DROP TABLE IF EXISTS `acs`;
CREATE TABLE `acs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `annee` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `debut` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `acs` VALUES("1","devbrandon","2026-02-24 12:31:32","2026-02-24 12:31:32","Janvier");



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

INSERT INTO `admissions` VALUES("1","12","1","2026-02-24 12:32:11","2026-02-24 12:32:11");



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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




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

INSERT INTO `archsals` VALUES("1","24","Janvier,Février","1","1","1"," ","2026-02-24 12:37:51","2026-02-24 12:37:51");



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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `audits` VALUES("1","Paramètres","Creation d\'une Annee scolaire","1","2026-02-24 12:31:32","2026-02-24 12:31:32");
INSERT INTO `audits` VALUES("2","Paramètres","Creation d\'une classe","1","2026-02-24 12:32:05","2026-02-24 12:32:05");
INSERT INTO `audits` VALUES("3","Paramètres","Creation d\'une Admission","1","2026-02-24 12:32:11","2026-02-24 12:32:11");
INSERT INTO `audits` VALUES("4","Paramètres","Creation d\'une Salle de classe","1","2026-02-24 12:32:18","2026-02-24 12:32:18");
INSERT INTO `audits` VALUES("5","Paramètres","Création d\'une matiere","1","2026-02-24 12:32:33","2026-02-24 12:32:33");
INSERT INTO `audits` VALUES("6","Étudiants","Inscription d\'un etudiant","1","2026-02-24 12:33:13","2026-02-24 12:33:13");
INSERT INTO `audits` VALUES("7","Étudiants","Modification note d\'un etudiant","1","2026-02-24 12:34:35","2026-02-24 12:34:35");
INSERT INTO `audits` VALUES("8","Financier","Paiement ecolage","1","2026-02-24 12:35:12","2026-02-24 12:35:12");
INSERT INTO `audits` VALUES("9","Paramètres","Creation d\'une profession","1","2026-02-24 12:36:11","2026-02-24 12:36:11");
INSERT INTO `audits` VALUES("10","Employé","Création d\'un employé","1","2026-02-24 12:37:03","2026-02-24 12:37:03");



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

INSERT INTO `classes` VALUES("1","Cm@","122","1","2026-02-24 12:32:05","2026-02-24 12:32:05","1121","1212");



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

INSERT INTO `depensesparmois` VALUES("1","24","1","26-02-24","2026-02-24 12:37:51","2026-02-24 12:37:51");



DROP TABLE IF EXISTS `domaines`;
CREATE TABLE `domaines` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nom` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `domaines` VALUES("1","test","2026-02-24 12:32:33","2026-02-24 12:32:33");



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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




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

INSERT INTO `ecolages` VALUES("1","37","1","2026-02-24 12:35:12","2026-02-24 12:37:51");



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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `etudiants` VALUES("1","efefefef","fefefef","1","2026-02-24","fefefe","fefefef",NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,"ROS26-1","","default.png","2026-02-24 12:33:13","2026-02-24 12:33:13","1","1");



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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




DROP TABLE IF EXISTS `macs`;
CREATE TABLE `macs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `mois` varchar(255) NOT NULL,
  `id_ac` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `macs` VALUES("1","Janvier","devbrandon","2026-02-24 12:31:32","2026-02-24 12:31:32");
INSERT INTO `macs` VALUES("2","Février","devbrandon","2026-02-24 12:31:32","2026-02-24 12:31:32");
INSERT INTO `macs` VALUES("3","Mars","devbrandon","2026-02-24 12:31:32","2026-02-24 12:31:32");
INSERT INTO `macs` VALUES("4","Avril","devbrandon","2026-02-24 12:31:32","2026-02-24 12:31:32");
INSERT INTO `macs` VALUES("5","Mai","devbrandon","2026-02-24 12:31:32","2026-02-24 12:31:32");
INSERT INTO `macs` VALUES("6","Juin","devbrandon","2026-02-24 12:31:32","2026-02-24 12:31:32");
INSERT INTO `macs` VALUES("7","Juillet","devbrandon","2026-02-24 12:31:32","2026-02-24 12:31:32");
INSERT INTO `macs` VALUES("8","Août","devbrandon","2026-02-24 12:31:32","2026-02-24 12:31:32");
INSERT INTO `macs` VALUES("9","Septembre","devbrandon","2026-02-24 12:31:32","2026-02-24 12:31:32");
INSERT INTO `macs` VALUES("10","Octobre","devbrandon","2026-02-24 12:31:32","2026-02-24 12:31:32");
INSERT INTO `macs` VALUES("11","Novembre","devbrandon","2026-02-24 12:31:32","2026-02-24 12:31:32");



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

INSERT INTO `matieres` VALUES("1","1","test","2026-02-24 12:37:03","2026-02-24 12:37:03","dfdfdfd");



DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=59 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `moisecolages` VALUES("1","Janvier","1","2026-02-24 12:33:13","2026-02-24 12:35:12","1","1");
INSERT INTO `moisecolages` VALUES("2","Février","0","2026-02-24 12:33:13","2026-02-24 12:33:13","1","1");
INSERT INTO `moisecolages` VALUES("3","Mars","0","2026-02-24 12:33:13","2026-02-24 12:33:13","1","1");
INSERT INTO `moisecolages` VALUES("4","Avril","0","2026-02-24 12:33:13","2026-02-24 12:33:13","1","1");
INSERT INTO `moisecolages` VALUES("5","Mai","0","2026-02-24 12:33:13","2026-02-24 12:33:13","1","1");
INSERT INTO `moisecolages` VALUES("6","Juin","0","2026-02-24 12:33:13","2026-02-24 12:33:13","1","1");
INSERT INTO `moisecolages` VALUES("7","Juillet","0","2026-02-24 12:33:13","2026-02-24 12:33:13","1","1");
INSERT INTO `moisecolages` VALUES("8","Août","0","2026-02-24 12:33:13","2026-02-24 12:33:13","1","1");
INSERT INTO `moisecolages` VALUES("9","Septembre","0","2026-02-24 12:33:13","2026-02-24 12:33:13","1","1");
INSERT INTO `moisecolages` VALUES("10","Octobre","0","2026-02-24 12:33:13","2026-02-24 12:33:13","1","1");
INSERT INTO `moisecolages` VALUES("11","Novembre","0","2026-02-24 12:33:13","2026-02-24 12:33:13","1","1");



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
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `moissalaires` VALUES("1","Janvier","1","1","1","2026-02-24 12:37:03","2026-02-24 12:37:51","0");
INSERT INTO `moissalaires` VALUES("2","Février","1","1","1","2026-02-24 12:37:03","2026-02-24 12:37:51","0");
INSERT INTO `moissalaires` VALUES("3","Mars","1","0","1","2026-02-24 12:37:03","2026-02-24 12:37:03","12");
INSERT INTO `moissalaires` VALUES("4","Avril","1","0","1","2026-02-24 12:37:03","2026-02-24 12:37:03","12");
INSERT INTO `moissalaires` VALUES("5","Mai","1","0","1","2026-02-24 12:37:03","2026-02-24 12:37:03","12");
INSERT INTO `moissalaires` VALUES("6","Juin","1","0","1","2026-02-24 12:37:03","2026-02-24 12:37:03","12");
INSERT INTO `moissalaires` VALUES("7","Juillet","1","0","1","2026-02-24 12:37:03","2026-02-24 12:37:03","12");
INSERT INTO `moissalaires` VALUES("8","Août","1","0","1","2026-02-24 12:37:03","2026-02-24 12:37:03","12");
INSERT INTO `moissalaires` VALUES("9","Septembre","1","0","1","2026-02-24 12:37:03","2026-02-24 12:37:03","12");
INSERT INTO `moissalaires` VALUES("10","Octobre","1","0","1","2026-02-24 12:37:03","2026-02-24 12:37:03","12");
INSERT INTO `moissalaires` VALUES("11","Novembre","1","0","1","2026-02-24 12:37:03","2026-02-24 12:37:03","12");



DROP TABLE IF EXISTS `nifs`;
CREATE TABLE `nifs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `nif` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




DROP TABLE IF EXISTS `pages`;
CREATE TABLE `pages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `page_name` varchar(255) NOT NULL,
  `page_path` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `pages` VALUES("1","Dr. Karina O\'Reilly I","http://rogahn.info/et-id-quisquam-sequi-molestiae-quis-soluta.html","2026-01-05 13:08:15","2026-01-05 13:08:15");
INSERT INTO `pages` VALUES("2","Amari Gaylord","https://www.mohr.com/hic-nesciunt-beatae-consequatur-minus-accusamus-ea-voluptate","2026-01-05 13:08:15","2026-01-05 13:08:15");
INSERT INTO `pages` VALUES("3","Dr. Lucius Baumbach","http://www.stanton.com/et-cum-eum-voluptas-praesentium-dicta-voluptate-veniam","2026-01-05 13:08:15","2026-01-05 13:08:15");
INSERT INTO `pages` VALUES("4","Victor Kilback","http://www.rutherford.org/minus-sed-doloremque-voluptatem-tenetur-non-nam-aut.html","2026-01-05 13:08:15","2026-01-05 13:08:15");
INSERT INTO `pages` VALUES("5","Mrs. Mckayla Cummerata","http://kohler.net/","2026-01-05 13:08:15","2026-01-05 13:08:15");



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

INSERT INTO `personal_access_tokens` VALUES("1","App\\Models\\User","1","email","988904699eba042846f968048b69a7969b38b867d0a036cbe16ece19c25e3d05","[\"*\"]","2026-01-05 13:23:40",NULL,"2026-01-05 13:09:12","2026-01-05 13:23:40");
INSERT INTO `personal_access_tokens` VALUES("2","App\\Models\\User","1","email","4e8e2697a0e2df65e8dc0f6d47aa62a0600fe8307406dfc0610f0f7f98d318d2","[\"*\"]","2026-01-05 13:24:56",NULL,"2026-01-05 13:20:45","2026-01-05 13:24:56");
INSERT INTO `personal_access_tokens` VALUES("3","App\\Models\\User","1","email","9add7d9ab58baabd6e34b758b1d95d0a862935fa059badf4fee938dcc0e04f8f","[\"*\"]","2026-01-05 13:24:56",NULL,"2026-01-05 13:24:18","2026-01-05 13:24:56");
INSERT INTO `personal_access_tokens` VALUES("4","App\\Models\\User","1","email","6816618bf569e1f9a476e2efe636915440f3d4c4d89a947c43aef8214ad3eab1","[\"*\"]","2026-01-08 07:04:35",NULL,"2026-01-05 13:25:30","2026-01-08 07:04:35");
INSERT INTO `personal_access_tokens` VALUES("5","App\\Models\\User","1","email","5d928777aa96b315fe1a7de1218abf19c41673a67b2f36c503f9ac28a68e164b","[\"*\"]","2026-02-22 19:23:43",NULL,"2026-01-08 07:04:45","2026-02-22 19:23:43");
INSERT INTO `personal_access_tokens` VALUES("6","App\\Models\\User","1","email","83963f88ff428ef852835b894d9e10c5fd798cc9c20ba6e5e76647e1a1ee5b2d","[\"*\"]","2026-02-24 12:30:28",NULL,"2026-02-22 19:24:06","2026-02-24 12:30:28");
INSERT INTO `personal_access_tokens` VALUES("7","App\\Models\\User","1","email","e065ea2034f77e81da88edc17976c9ed855c73414fa40a9c645c3af1b460bec8","[\"*\"]","2026-02-24 12:39:20",NULL,"2026-02-24 12:30:45","2026-02-24 12:39:20");



DROP TABLE IF EXISTS `professions`;
CREATE TABLE `professions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `profession` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `professions` VALUES("1","test","2026-02-24 12:36:11","2026-02-24 12:36:11");



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

INSERT INTO `revenusparmois` VALUES("1","61","1","Janvier","2026-02-24 12:35:12","2026-02-24 12:35:12");



DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `role_name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `roles` VALUES("1","admin","2026-01-05 13:08:15","2026-01-05 13:08:15");
INSERT INTO `roles` VALUES("2","admin","2026-01-05 13:08:15","2026-01-05 13:08:15");



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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `roles_pages` VALUES("1","2","4","2026-01-05 13:08:15","2026-01-05 13:08:15");
INSERT INTO `roles_pages` VALUES("2","2","2","2026-01-05 13:08:15","2026-01-05 13:08:15");



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

INSERT INTO `salles` VALUES("1","dsdsd","12","1","1","2026-02-24 12:32:18","2026-02-24 12:32:18");



DROP TABLE IF EXISTS `schools`;
CREATE TABLE `schools` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;




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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `sousetudiants` VALUES("1","1","1","1","1","12.00","12.00","12.00","2026-02-24 12:33:13","2026-02-24 12:34:35","admis","12.00","0");



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

INSERT INTO `users` VALUES("1","Rosette","rosette@gmail.com",NULL,"$2y$12$I4IX2Xmmcuj3UW/EVMZhd.BSsT0SYfdSK0wBQOR.LGKtsJiKa4PFm",NULL,"2026-01-05 13:09:03","2026-01-05 13:09:03",NULL,"Rosette","1");



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

INSERT INTO `workers` VALUES("1","ssaasa","asasa",NULL,"1","sdsdsd","12","1","1","actif",NULL,"2026-02-24 12:37:03","2026-02-24 12:37:03","default.png","45454545");



