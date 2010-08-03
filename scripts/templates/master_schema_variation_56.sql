CREATE TABLE `allele` (
  `allele_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `variation_id` int(10) unsigned NOT NULL,
  `subsnp_id` int(15) unsigned DEFAULT NULL,
  `allele` varchar(255) DEFAULT NULL,
  `frequency` float DEFAULT NULL,
  `sample_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`allele_id`),
  KEY `variation_idx` (`variation_id`,`allele`(10)),
  KEY `subsnp_idx` (`subsnp_id`)
) ENGINE=MyISAM AUTO_INCREMENT=4488069 DEFAULT CHARSET=latin1;

CREATE TABLE `allele_group` (
  `allele_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `variation_group_id` int(10) unsigned NOT NULL,
  `sample_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `source_id` int(10) unsigned DEFAULT NULL,
  `frequency` float DEFAULT NULL,
  PRIMARY KEY (`allele_group_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `allele_group_allele` (
  `allele_group_id` int(10) unsigned NOT NULL,
  `allele` varchar(255) NOT NULL,
  `variation_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `allele_group_id` (`allele_group_id`,`variation_id`),
  KEY `allele_idx` (`variation_id`,`allele_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `compressed_genotype_single_bp` (
  `sample_id` int(10) unsigned NOT NULL,
  `seq_region_id` int(10) unsigned NOT NULL,
  `seq_region_start` int(11) NOT NULL,
  `seq_region_end` int(11) NOT NULL,
  `seq_region_strand` tinyint(4) NOT NULL,
  `genotypes` blob,
  KEY `pos_idx` (`seq_region_id`,`seq_region_start`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 MAX_ROWS=100000000;

CREATE TABLE `failed_description` (
  `failed_description_id` int(10) unsigned NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`failed_description_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `failed_variation` (
  `variation_id` int(10) unsigned NOT NULL,
  `failed_description_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`variation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `flanking_sequence` (
  `variation_id` int(10) unsigned NOT NULL,
  `up_seq` text,
  `down_seq` text,
  `up_seq_region_start` int(11) DEFAULT NULL,
  `up_seq_region_end` int(11) DEFAULT NULL,
  `down_seq_region_start` int(11) DEFAULT NULL,
  `down_seq_region_end` int(11) DEFAULT NULL,
  `seq_region_id` int(10) unsigned DEFAULT NULL,
  `seq_region_strand` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`variation_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 MAX_ROWS=100000000;

CREATE TABLE `httag` (
  `httag_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `variation_group_id` int(10) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `source_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`httag_id`),
  KEY `variation_group_idx` (`variation_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `individual` (
  `sample_id` int(10) unsigned NOT NULL,
  `gender` enum('Male','Female','Unknown') NOT NULL DEFAULT 'Unknown',
  `father_individual_sample_id` int(10) unsigned DEFAULT NULL,
  `mother_individual_sample_id` int(10) unsigned DEFAULT NULL,
  `individual_type_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sample_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `individual_genotype_multiple_bp` (
  `variation_id` int(10) unsigned NOT NULL,
  `subsnp_id` int(15) unsigned DEFAULT NULL,
  `allele_1` varchar(255) DEFAULT NULL,
  `allele_2` varchar(255) DEFAULT NULL,
  `sample_id` int(10) unsigned DEFAULT NULL,
  KEY `variation_idx` (`variation_id`),
  KEY `sample_idx` (`sample_id`),
  KEY `subsnp_idx` (`subsnp_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `individual_population` (
  `individual_sample_id` int(10) unsigned NOT NULL,
  `population_sample_id` int(10) unsigned NOT NULL,
  KEY `individual_sample_idx` (`individual_sample_id`),
  KEY `population_sample_idx` (`population_sample_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `individual_type` (
  `individual_type_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` text,
  PRIMARY KEY (`individual_type_id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;

CREATE TABLE `meta` (
  `meta_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `species_id` int(10) unsigned DEFAULT '1',
  `meta_key` varchar(40) NOT NULL,
  `meta_value` varchar(255) NOT NULL,
  PRIMARY KEY (`meta_id`),
  UNIQUE KEY `species_key_value_idx` (`species_id`,`meta_key`,`meta_value`),
  KEY `species_value_idx` (`species_id`,`meta_value`)
) ENGINE=MyISAM AUTO_INCREMENT=23 DEFAULT CHARSET=latin1;

CREATE TABLE `meta_coord` (
  `table_name` varchar(40) NOT NULL,
  `coord_system_id` int(10) unsigned NOT NULL,
  `max_length` int(11) DEFAULT NULL,
  UNIQUE KEY `table_name` (`table_name`,`coord_system_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `phenotype` (
  `phenotype_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`phenotype_id`),
  UNIQUE KEY `name_idx` (`name`),
  UNIQUE KEY `description` (`description`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `population` (
  `sample_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`sample_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `population_genotype` (
  `population_genotype_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `variation_id` int(10) unsigned NOT NULL,
  `subsnp_id` int(15) unsigned DEFAULT NULL,
  `allele_1` varchar(255) DEFAULT NULL,
  `allele_2` varchar(255) DEFAULT NULL,
  `frequency` float DEFAULT NULL,
  `sample_id` int(10) unsigned DEFAULT NULL,
  PRIMARY KEY (`population_genotype_id`),
  KEY `variation_idx` (`variation_id`),
  KEY `sample_idx` (`sample_id`),
  KEY `subsnp_idx` (`subsnp_id`)
) ENGINE=MyISAM AUTO_INCREMENT=75672 DEFAULT CHARSET=latin1;

CREATE TABLE `population_structure` (
  `super_population_sample_id` int(10) unsigned NOT NULL,
  `sub_population_sample_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `super_population_sample_id` (`super_population_sample_id`,`sub_population_sample_id`),
  KEY `sub_pop_sample_idx` (`sub_population_sample_id`,`super_population_sample_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `read_coverage` (
  `seq_region_id` int(10) unsigned NOT NULL,
  `seq_region_start` int(11) NOT NULL,
  `seq_region_end` int(11) NOT NULL,
  `level` tinyint(4) NOT NULL,
  `sample_id` int(10) unsigned NOT NULL,
  KEY `seq_region_idx` (`seq_region_id`,`seq_region_start`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `sample` (
  `sample_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `size` int(11) DEFAULT NULL,
  `description` text,
  `display` enum('REFERENCE','DEFAULT','DISPLAYABLE','UNDISPLAYABLE') DEFAULT 'UNDISPLAYABLE',
  PRIMARY KEY (`sample_id`),
  KEY `name_idx` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=654 DEFAULT CHARSET=latin1;

CREATE TABLE `sample_synonym` (
  `sample_synonym_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sample_id` int(10) unsigned NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`sample_synonym_id`),
  KEY `sample_idx` (`sample_id`),
  KEY `name` (`name`,`source_id`)
) ENGINE=MyISAM AUTO_INCREMENT=641 DEFAULT CHARSET=latin1;

CREATE TABLE `seq_region` (
  `seq_region_id` int(10) unsigned NOT NULL,
  `name` varchar(40) NOT NULL,
  PRIMARY KEY (`seq_region_id`),
  UNIQUE KEY `name_idx` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `source` (
  `source_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `version` int(11) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`source_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

CREATE TABLE `subsnp_handle` (
  `subsnp_id` int(11) unsigned NOT NULL,
  `handle` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`subsnp_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `tagged_variation_feature` (
  `variation_feature_id` int(10) unsigned NOT NULL,
  `sample_id` int(10) unsigned NOT NULL,
  PRIMARY KEY (`variation_feature_id`,`sample_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `tmp_individual_genotype_single_bp` (
  `variation_id` int(11) NOT NULL,
  `subsnp_id` int(15) unsigned DEFAULT NULL,
  `allele_1` varchar(255) DEFAULT NULL,
  `allele_2` varchar(255) DEFAULT NULL,
  `sample_id` int(11) DEFAULT NULL,
  KEY `variation_idx` (`variation_id`),
  KEY `sample_idx` (`sample_id`),
  KEY `subsnp_idx` (`subsnp_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 MAX_ROWS=100000000;

CREATE TABLE `transcript_variation` (
  `transcript_variation_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `transcript_id` int(10) unsigned NOT NULL,
  `variation_feature_id` int(10) unsigned NOT NULL,
  `cdna_start` int(11) DEFAULT NULL,
  `cdna_end` int(11) DEFAULT NULL,
  `translation_start` int(11) DEFAULT NULL,
  `translation_end` int(11) DEFAULT NULL,
  `peptide_allele_string` varchar(255) DEFAULT NULL,
  `consequence_type` set('ESSENTIAL_SPLICE_SITE','STOP_GAINED','STOP_LOST','COMPLEX_INDEL','FRAMESHIFT_CODING','NON_SYNONYMOUS_CODING','SPLICE_SITE','SYNONYMOUS_CODING','REGULATORY_REGION','WITHIN_MATURE_miRNA','5PRIME_UTR','3PRIME_UTR','INTRONIC','UPSTREAM','DOWNSTREAM','WITHIN_NON_CODING_GENE') NOT NULL,
  PRIMARY KEY (`transcript_variation_id`),
  KEY `variation_idx` (`variation_feature_id`),
  KEY `transcript_idx` (`transcript_id`),
  KEY `consequence_type_idx` (`consequence_type`)
) ENGINE=MyISAM AUTO_INCREMENT=3451490 DEFAULT CHARSET=latin1;

CREATE TABLE `variation` (
  `variation_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `source_id` int(10) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `validation_status` set('cluster','freq','submitter','doublehit','hapmap','failed') DEFAULT NULL,
  `ancestral_allele` text,
  PRIMARY KEY (`variation_id`),
  UNIQUE KEY `name` (`name`),
  KEY `source_idx` (`source_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2223034 DEFAULT CHARSET=latin1;

CREATE TABLE `variation_annotation` (
  `variation_annotation_id` int(10) NOT NULL AUTO_INCREMENT,
  `variation_id` int(10) unsigned NOT NULL,
  `phenotype_id` int(10) unsigned NOT NULL,
  `source_id` int(10) unsigned NOT NULL,
  `study` varchar(30) DEFAULT NULL,
  `study_type` set('GWAS') DEFAULT NULL,
  `local_stable_id` varchar(255) DEFAULT NULL,
  `associated_gene` varchar(255) DEFAULT NULL,
  `associated_variant_risk_allele` varchar(255) DEFAULT NULL,
  `variation_names` varchar(255) DEFAULT NULL,
  `risk_allele_freq_in_controls` varchar(30) DEFAULT NULL,
  `p_value` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`variation_annotation_id`),
  KEY `variation_idx` (`variation_id`),
  KEY `phenotype_idx` (`phenotype_id`),
  KEY `source_idx` (`source_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `variation_feature` (
  `variation_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `seq_region_id` int(10) unsigned NOT NULL,
  `seq_region_start` int(11) NOT NULL,
  `seq_region_end` int(11) NOT NULL,
  `seq_region_strand` tinyint(4) NOT NULL,
  `variation_id` int(10) unsigned NOT NULL,
  `allele_string` text,
  `variation_name` varchar(255) DEFAULT NULL,
  `map_weight` int(11) NOT NULL,
  `flags` set('genotyped') DEFAULT NULL,
  `source_id` int(10) unsigned NOT NULL,
  `validation_status` set('cluster','freq','submitter','doublehit','hapmap') DEFAULT NULL,
  `consequence_type` set('ESSENTIAL_SPLICE_SITE','STOP_GAINED','STOP_LOST','COMPLEX_INDEL','FRAMESHIFT_CODING','NON_SYNONYMOUS_CODING','SPLICE_SITE','SYNONYMOUS_CODING','REGULATORY_REGION','WITHIN_MATURE_miRNA','5PRIME_UTR','3PRIME_UTR','INTRONIC','UPSTREAM','DOWNSTREAM','WITHIN_NON_CODING_GENE','NO_CONSEQUENCE','INTERGENIC') DEFAULT 'INTERGENIC',
  PRIMARY KEY (`variation_feature_id`),
  KEY `pos_idx` (`seq_region_id`,`seq_region_start`),
  KEY `variation_idx` (`variation_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2347627 DEFAULT CHARSET=latin1;

CREATE TABLE `variation_group` (
  `variation_group_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `source_id` int(10) unsigned NOT NULL,
  `type` enum('haplotype','tag') DEFAULT NULL,
  PRIMARY KEY (`variation_group_id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `variation_group_feature` (
  `variation_group_feature_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `seq_region_id` int(10) unsigned NOT NULL,
  `seq_region_start` int(11) NOT NULL,
  `seq_region_end` int(11) NOT NULL,
  `seq_region_strand` tinyint(4) NOT NULL,
  `variation_group_id` int(10) unsigned NOT NULL,
  `variation_group_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`variation_group_feature_id`),
  KEY `pos_idx` (`seq_region_id`,`seq_region_start`),
  KEY `variation_group_idx` (`variation_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `variation_group_variation` (
  `variation_id` int(10) unsigned NOT NULL,
  `variation_group_id` int(10) unsigned NOT NULL,
  UNIQUE KEY `variation_group_id` (`variation_group_id`,`variation_id`),
  KEY `variation_idx` (`variation_id`,`variation_group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

CREATE TABLE `variation_synonym` (
  `variation_synonym_id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `variation_id` int(10) unsigned NOT NULL,
  `subsnp_id` int(15) unsigned DEFAULT NULL,
  `source_id` int(10) unsigned NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `moltype` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`variation_synonym_id`),
  UNIQUE KEY `name` (`name`,`source_id`),
  KEY `variation_idx` (`variation_id`),
  KEY `source_idx` (`source_id`),
  KEY `subsnp_idx` (`subsnp_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

