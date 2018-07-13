-- -----------------------------------------------------
-- centro_commerciale
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `centro_commerciale` DEFAULT CHARACTER SET utf8 ;
USE `centro_commerciale` ;

-- -----------------------------------------------------
-- CATEGORIA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CATEGORIA` (
  `codice_categoria` INT NOT NULL AUTO_INCREMENT,
  `descrizione` VARCHAR(45) NULL,
  PRIMARY KEY (`codice_categoria`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `SUBCATEGORIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SUBCATEGORIA` (
  `codice_subcategoria` INT NOT NULL AUTO_INCREMENT,
  `descrizione` VARCHAR(45) NULL,
  `categoria_prodotto` INT NOT NULL,
  PRIMARY KEY (`codice_subcategoria`, `categoria_prodotto`),
  INDEX `fk_SUB-CATEGORIA_CATEGORIA1_idx` (`categoria_prodotto` ASC),
  CONSTRAINT `fk_SUB-CATEGORIA_CATEGORIA1`
    FOREIGN KEY (`categoria_prodotto`)
    REFERENCES `CATEGORIA` (`codice_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- PRODOTTO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PRODOTTO` (
  `codice_a_barre` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `descrizione` VARCHAR(45) NULL,
  `eta_minima` INT UNSIGNED NULL,
  `taglia` INT UNSIGNED NULL,
  `materiale` VARCHAR(45) NULL,
  `subcategoria` INT NOT NULL,
  PRIMARY KEY (`codice_a_barre`, `subcategoria`),
  INDEX `subcategoria_idx` (`subcategoria` ASC),
  CONSTRAINT `subcategoria`
    FOREIGN KEY (`subcategoria`)
    REFERENCES `SUBCATEGORIA` (`codice_subcategoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- VALORE NUTRIZIONALE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `VALORE NUTRIZIONALE` (
  `codice_valore` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `descrizione` VARCHAR(45) NULL,
  PRIMARY KEY (`codice_valore`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- NEGOZIO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NEGOZIO` (
  `P_IVA` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `num_telefono` INT UNSIGNED NOT NULL,
  `ragione_sociale` VARCHAR(45) NOT NULL,
  `indirizzo_sede_fisica` VARCHAR(45) NOT NULL,
  `indirizzo_sede_legale` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`P_IVA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- FORNITORE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FORNITORE` (
  `P_IVA` INT NOT NULL,
  `ragione_sociale` VARCHAR(45) NOT NULL,
  `indirizzo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`P_IVA`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- ORDINE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ORDINE` (
  `codice_ordine` INT NOT NULL AUTO_INCREMENT,
  `negozio` INT NOT NULL,
  `data_ordine` DATE NOT NULL,
  `prodotto` INT NOT NULL,
  `quantita` DOUBLE UNSIGNED NOT NULL,
  `fornitore` INT NOT NULL,
  PRIMARY KEY (`codice_ordine`, `negozio`, `prodotto`, `fornitore`),
  INDEX `fk_ORDINE_NEGOZIO1_idx` (`negozio` ASC),
  INDEX `fk_ORDINE_PRODOTTO1_idx` (`prodotto` ASC),
  INDEX `fk_ORDINE_FORNITORE1_idx` (`fornitore` ASC),
  CONSTRAINT `fk_ORDINE_NEGOZIO1`
    FOREIGN KEY (`negozio`)
    REFERENCES `NEGOZIO` (`P_IVA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORDINE_PRODOTTO1`
    FOREIGN KEY (`prodotto`)
    REFERENCES `PRODOTTO` (`codice_a_barre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORDINE_FORNITORE1`
    FOREIGN KEY (`fornitore`)
    REFERENCES `FORNITORE` (`P_IVA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- CLIENTE FEDELE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CLIENTE FEDELE` (
  `codice_fiscale` VARCHAR(16) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `cognome` VARCHAR(45) NOT NULL,
  `eta` INT UNSIGNED NOT NULL,
  `sesso` VARCHAR(45) NOT NULL,
  `numero_figli` INT UNSIGNED NOT NULL,
  `stato_civile` ENUM('CELIBE', 'NUBILE', 'SPOSATO', 'DIVORZIATO') NOT NULL,
  `indirizzo_residenza` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(10) NULL,
  PRIMARY KEY (`codice_fiscale`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- FIDELITY CARD
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FIDELITY CARD` (
  `codice_carta` INT NOT NULL AUTO_INCREMENT,
  `data_emissione` DATE NOT NULL,
  `data_scadenza` DATE NOT NULL,
  `negozio` INT NOT NULL,
  `cliente` VARCHAR(16) NOT NULL,
  PRIMARY KEY (`codice_carta`, `negozio`, `cliente`),
  INDEX `fk_FIDELITY CARD_NEGOZIO1_idx` (`negozio` ASC),
  INDEX `fk_FIDELITY CARD_PERSONA_idx` (`cliente` ASC),
  CONSTRAINT `fk_FIDELITY CARD_NEGOZIO1`
    FOREIGN KEY (`negozio`)
    REFERENCES `NEGOZIO` (`P_IVA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FIDELITY CARD_PERSONA`
    FOREIGN KEY (`cliente`)
    REFERENCES `CLIENTE FEDELE` (`codice_fiscale`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- CAMPAGNA_PROMOZIONALE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `CAMPAGNA_PROMOZIONALE` (
  `codice_campagna_promozionale` INT NOT NULL AUTO_INCREMENT,
  `descrizione` VARCHAR(45) NOT NULL,
  `data_inizio` DATE NOT NULL,
  `data_fine` DATE NOT NULL,
  `negozio` INT NOT NULL,
  PRIMARY KEY (`codice_campagna_promozionale`, `negozio`),
  INDEX `fk_CAMPAGNA PROMOZIONALE_NEGOZIO1_idx` (`negozio` ASC),
  CONSTRAINT `fk_CAMPAGNA PROMOZIONALE_NEGOZIO1`
    FOREIGN KEY (`negozio`)
    REFERENCES `NEGOZIO` (`P_IVA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- SCONTRINO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SCONTRINO` (
  `codice_scontrino` INT NOT NULL AUTO_INCREMENT,
  `data_emissione` DATE NOT NULL,
  `negozio` INT NOT NULL,
  `fidelity_card` INT NULL,
  PRIMARY KEY (`codice_scontrino`, `negozio`),
  INDEX `fk_SCONTRINO_NEGOZIO1_idx` (`negozio` ASC),
  INDEX `fk_SCONTRINO_FIDELITY CARD1_idx` (`fidelity_card` ASC),
  CONSTRAINT `fk_SCONTRINO_NEGOZIO1`
    FOREIGN KEY (`negozio`)
    REFERENCES `NEGOZIO` (`P_IVA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SCONTRINO_FIDELITY CARD1`
    FOREIGN KEY (`fidelity_card`)
    REFERENCES `FIDELITY CARD` (`codice_carta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- LOCALE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LOCALE` (
  `codice_locale` INT NOT NULL AUTO_INCREMENT,
  `superficie` DOUBLE NOT NULL,
  `negozio` INT NULL,
  `affitto` DOUBLE UNSIGNED NULL,
  PRIMARY KEY (`codice_locale`),
  INDEX `fk_LOCALE_NEGOZIO1_idx` (`negozio` ASC),
  CONSTRAINT `fk_LOCALE_NEGOZIO1`
    FOREIGN KEY (`negozio`)
    REFERENCES `NEGOZIO` (`P_IVA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- MAGAZZINO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MAGAZZINO` (
  `codice_magazzino` INT NOT NULL AUTO_INCREMENT,
  `negozio` INT NOT NULL,
  PRIMARY KEY (`codice_magazzino`, `negozio`),
  INDEX `fk_MAGAZZINO_NEGOZIO1_idx` (`negozio` ASC),
  CONSTRAINT `fk_MAGAZZINO_NEGOZIO1`
    FOREIGN KEY (`negozio`)
    REFERENCES `NEGOZIO` (`P_IVA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- SCAFFALE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `SCAFFALE` (
  `codice_scaffale` INT NOT NULL AUTO_INCREMENT,
  `codice_magazzino` INT NOT NULL,
  PRIMARY KEY (`codice_scaffale`, `codice_magazzino`),
  INDEX `magazzino` (`codice_magazzino` ASC),
  CONSTRAINT `fk_SCAFFALE_MAGAZZINO1`
    FOREIGN KEY (`codice_magazzino`)
    REFERENCES `MAGAZZINO` (`codice_magazzino`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- RIPIANO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RIPIANO` (
  `codice_ripiano` INT NOT NULL AUTO_INCREMENT,
  `scaffale` INT NOT NULL,
  PRIMARY KEY (`codice_ripiano`, `scaffale`),
  INDEX `fk_RIPIANO_SCAFFALE1_idx` (`scaffale` ASC),
  CONSTRAINT `fk_RIPIANO_SCAFFALE1`
    FOREIGN KEY (`scaffale`)
    REFERENCES `SCAFFALE` (`codice_scaffale`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- REPARTO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `REPARTO` (
  `codice_reparto` INT NOT NULL AUTO_INCREMENT,
  `negozio` INT NOT NULL,
  `categoria` INT NOT NULL,
  PRIMARY KEY (`codice_reparto`),
  INDEX `fk_REPARTO_NEGOZIO1_idx` (`negozio` ASC),
  INDEX `fk_REPARTO_1_idx` (`categoria` ASC),
  CONSTRAINT `fk_REPARTO_NEGOZIO1`
    FOREIGN KEY (`negozio`)
    REFERENCES `NEGOZIO` (`P_IVA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_REPARTO_1`
    FOREIGN KEY (`categoria`)
    REFERENCES `CATEGORIA` (`codice_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `DIPENDENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DIPENDENTE` (
  `matricola` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(45) NOT NULL,
  `cognome` VARCHAR(45) NOT NULL,
  `eta` INT UNSIGNED NOT NULL,
  `sesso` VARCHAR(45) NOT NULL,
  `numero_figli` INT UNSIGNED NOT NULL,
  `stato_civile` ENUM('CELIBE', 'NUBILE', 'SPOSATO', 'DIVORZIATO') NOT NULL,
  `indirizzo_residenza` VARCHAR(45) NOT NULL,
  `codice_fiscale` VARCHAR(16) NOT NULL,
  `telefono` VARCHAR(10) NULL,
  PRIMARY KEY (`matricola`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- LAVORA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `LAVORA` (
  `dipendente` INT NOT NULL,
  `reparto` INT NOT NULL,
  `data_inizio` DATE NOT NULL,
  `data_fine` DATE NULL,
  `stipendio` DOUBLE UNSIGNED NULL,
  PRIMARY KEY (`dipendente`, `reparto`, `data_inizio`),
  INDEX `fk_DIPENDENTE_has_REPARTO_REPARTO1_idx` (`reparto` ASC),
  INDEX `fk_DIPENDENTE_has_REPARTO_DIPENDENTE1_idx` (`dipendente` ASC),
  CONSTRAINT `fk_DIPENDENTE_has_REPARTO_DIPENDENTE1`
    FOREIGN KEY (`dipendente`)
    REFERENCES `DIPENDENTE` (`matricola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DIPENDENTE_has_REPARTO_REPARTO1`
    FOREIGN KEY (`reparto`)
    REFERENCES `REPARTO` (`codice_reparto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- MANAGER
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MANAGER` (
  `dipendente` INT NOT NULL,
  `negozio` INT NOT NULL,
  `data_inizio` DATE NOT NULL,
  `data_fine` DATE NULL,
  `stipendio` DOUBLE UNSIGNED NULL,
  PRIMARY KEY (`dipendente`, `negozio`, `data_inizio`),
  INDEX `fk_DIPENDENTE_has_NEGOZIO_NEGOZIO1_idx` (`negozio` ASC),
  INDEX `fk_DIPENDENTE_has_NEGOZIO_DIPENDENTE1_idx` (`dipendente` ASC),
  CONSTRAINT `fk_DIPENDENTE_has_NEGOZIO_DIPENDENTE1`
    FOREIGN KEY (`dipendente`)
    REFERENCES `DIPENDENTE` (`matricola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DIPENDENTE_has_NEGOZIO_NEGOZIO1`
    FOREIGN KEY (`negozio`)
    REFERENCES `NEGOZIO` (`P_IVA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- RESPONSABILE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `RESPONSABILE` (
  `dipendente` INT NOT NULL,
  `reparto` INT NOT NULL,
  `data_inizio` DATE NOT NULL,
  `data_fine` DATE NULL,
  `stipendio` DOUBLE UNSIGNED NULL,
  PRIMARY KEY (`dipendente`, `reparto`, `data_inizio`),
  INDEX `fk_DIPENDENTE_has_REPARTO_REPARTO2_idx` (`reparto` ASC),
  INDEX `fk_DIPENDENTE_has_REPARTO_DIPENDENTE2_idx` (`dipendente` ASC),
  CONSTRAINT `fk_DIPENDENTE_has_REPARTO_DIPENDENTE2`
    FOREIGN KEY (`dipendente`)
    REFERENCES `DIPENDENTE` (`matricola`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_DIPENDENTE_has_REPARTO_REPARTO2`
    FOREIGN KEY (`reparto`)
    REFERENCES `REPARTO` (`codice_reparto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- IN_VENDITA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `IN_VENDITA` (
  `prodotto` INT NOT NULL,
  `reparto` INT NOT NULL,
  `prezzo_base` DOUBLE UNSIGNED NOT NULL,
  `quantita_esposta` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`prodotto`, `reparto`),
  INDEX `fk_PRODOTTO_has_REPARTO_REPARTO1_idx` (`reparto` ASC),
  INDEX `fk_PRODOTTO_has_REPARTO_PRODOTTO1_idx` (`prodotto` ASC),
  CONSTRAINT `fk_PRODOTTO_has_REPARTO_PRODOTTO1`
    FOREIGN KEY (`prodotto`)
    REFERENCES `PRODOTTO` (`codice_a_barre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODOTTO_has_REPARTO_REPARTO1`
    FOREIGN KEY (`reparto`)
    REFERENCES `REPARTO` (`codice_reparto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- FORNITURA
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `FORNITURA` (
  `negozio` INT NOT NULL,
  `fornitore` INT NOT NULL,
  `categoria_prodotto` INT NOT NULL,
  PRIMARY KEY (`negozio`, `categoria_prodotto`, `fornitore`),
  INDEX `fk_FORNITURA_1_idx` (`fornitore` ASC),
  INDEX `fk_FORNITURA_3_idx` (`categoria_prodotto` ASC),
  CONSTRAINT `fk_FORNITURA_1`
    FOREIGN KEY (`fornitore`)
    REFERENCES `FORNITORE` (`P_IVA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FORNITURA_2`
    FOREIGN KEY (`negozio`)
    REFERENCES `NEGOZIO` (`P_IVA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_FORNITURA_3`
    FOREIGN KEY (`categoria_prodotto`)
    REFERENCES `CATEGORIA` (`codice_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- ACQUISTI
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ACQUISTI` (
  `scontrino` INT NOT NULL,
  `prodotto` INT NOT NULL,
  `quantita` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`scontrino`, `prodotto`),
  INDEX `fk_SCONTRINO_has_PRODOTTO_PRODOTTO1_idx` (`prodotto` ASC),
  INDEX `fk_SCONTRINO_has_PRODOTTO_SCONTRINO1_idx` (`scontrino` ASC),
  CONSTRAINT `fk_SCONTRINO_has_PRODOTTO_SCONTRINO1`
    FOREIGN KEY (`scontrino`)
    REFERENCES `SCONTRINO` (`codice_scontrino`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SCONTRINO_has_PRODOTTO_PRODOTTO1`
    FOREIGN KEY (`prodotto`)
    REFERENCES `PRODOTTO` (`codice_a_barre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- PRODOTTI_SCONTATI
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PRODOTTI_SCONTATI` (
  `prodotto` INT NOT NULL,
  `campagna_promozionale` INT NOT NULL,
  `sconto` DOUBLE UNSIGNED NULL,
  PRIMARY KEY (`prodotto`, `campagna_promozionale`),
  INDEX `fk_PRODOTTO_has_CAMPAGNA PROMOZIONALE_CAMPAGNA PROMOZIONALE_idx` (`campagna_promozionale` ASC),
  INDEX `fk_PRODOTTO_has_CAMPAGNA PROMOZIONALE_PRODOTTO1_idx` (`prodotto` ASC),
  CONSTRAINT `fk_PRODOTTO_has_CAMPAGNA PROMOZIONALE_PRODOTTO1`
    FOREIGN KEY (`prodotto`)
    REFERENCES `PRODOTTO` (`codice_a_barre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODOTTO_has_CAMPAGNA PROMOZIONALE_CAMPAGNA PROMOZIONALE1`
    FOREIGN KEY (`campagna_promozionale`)
    REFERENCES `CAMPAGNA_PROMOZIONALE` (`codice_campagna_promozionale`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- TABELLA_VALORI_NUTRIZIONALI
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TABELLA_VALORI_NUTRIZIONALI` (
  `prodotto` INT NOT NULL,
  `valore` INT NOT NULL,
  `quantita` DOUBLE UNSIGNED NOT NULL,
  `unita_di_misura` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`prodotto`, `valore`),
  INDEX `fk_PRODOTTO_has_VALORE NUTRIZIONALE_VALORE NUTRIZIONALE1_idx` (`valore` ASC),
  INDEX `fk_PRODOTTO_has_VALORE NUTRIZIONALE_PRODOTTO1_idx` (`prodotto` ASC),
  CONSTRAINT `fk_PRODOTTO_has_VALORE NUTRIZIONALE_PRODOTTO1`
    FOREIGN KEY (`prodotto`)
    REFERENCES `PRODOTTO` (`codice_a_barre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODOTTO_has_VALORE NUTRIZIONALE_VALORE NUTRIZIONALE1`
    FOREIGN KEY (`valore`)
    REFERENCES `VALORE NUTRIZIONALE` (`codice_valore`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- PUO_FORNIRE
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `PUO_FORNIRE` (
  `categoria_prodotto` INT NOT NULL,
  `fornitore` INT NOT NULL,
  PRIMARY KEY (`categoria_prodotto`, `fornitore`),
  INDEX `fk_CATEGORIA_has_FORNITORE_FORNITORE1_idx` (`fornitore` ASC),
  INDEX `fk_CATEGORIA_has_FORNITORE_CATEGORIA1_idx` (`categoria_prodotto` ASC),
  CONSTRAINT `fk_CATEGORIA_has_FORNITORE_CATEGORIA1`
    FOREIGN KEY (`categoria_prodotto`)
    REFERENCES `CATEGORIA` (`codice_categoria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CATEGORIA_has_FORNITORE_FORNITORE1`
    FOREIGN KEY (`fornitore`)
    REFERENCES `FORNITORE` (`P_IVA`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- COLLOCAMENTO
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `COLLOCAMENTO` (
  `prodotto` INT NOT NULL,
  `ripiano` INT NOT NULL,
  `quantita` DOUBLE UNSIGNED NOT NULL,
  `soglia` DOUBLE UNSIGNED NOT NULL,
  PRIMARY KEY (`prodotto`, `ripiano`),
  INDEX `fk_COLLOCAMENTO_PRODOTTO_idx` (`prodotto` ASC),
  INDEX `fk_COLLOCAMENTO_RIPIANO_idx` (`ripiano` ASC),
  CONSTRAINT `fk_COLLOCAMENTO_PRODOTTO`
    FOREIGN KEY (`prodotto`)
    REFERENCES `PRODOTTO` (`codice_a_barre`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_COLLOCAMENTO_RIPIANO`
    FOREIGN KEY (`ripiano`)
    REFERENCES `RIPIANO` (`codice_ripiano`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;
