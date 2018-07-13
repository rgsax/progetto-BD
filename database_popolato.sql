-- MySQL dump 10.13  Distrib 5.7.22, for Linux (x86_64)
--
-- Host: localhost    Database: centro_commerciale
-- ------------------------------------------------------
-- Server version	5.7.22-0ubuntu0.17.10.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ACQUISTI`
--

DROP TABLE IF EXISTS `ACQUISTI`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ACQUISTI` (
  `scontrino` int(11) NOT NULL,
  `prodotto` int(11) NOT NULL,
  `quantita` int(10) unsigned NOT NULL,
  PRIMARY KEY (`scontrino`,`prodotto`),
  KEY `fk_SCONTRINO_has_PRODOTTO_PRODOTTO1_idx` (`prodotto`),
  KEY `fk_SCONTRINO_has_PRODOTTO_SCONTRINO1_idx` (`scontrino`),
  CONSTRAINT `fk_SCONTRINO_has_PRODOTTO_PRODOTTO1` FOREIGN KEY (`prodotto`) REFERENCES `PRODOTTO` (`codice_a_barre`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_SCONTRINO_has_PRODOTTO_SCONTRINO1` FOREIGN KEY (`scontrino`) REFERENCES `SCONTRINO` (`codice_scontrino`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ACQUISTI`
--

LOCK TABLES `ACQUISTI` WRITE;
/*!40000 ALTER TABLE `ACQUISTI` DISABLE KEYS */;
INSERT INTO `ACQUISTI` VALUES (4,192,5),(5,43,5),(14,182,1),(14,183,1);
/*!40000 ALTER TABLE `ACQUISTI` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger insert_check_acquisti
before insert on ACQUISTI
for each row
begin

if(NEW.prodotto not in (select prodotto
						from (IN_VENDITA inner join REPARTO on IN_VENDITA.reparto = REPARTO.codice_reparto), SCONTRINO
                        where SCONTRINO.codice_scontrino = NEW.scontrino and SCONTRINO.negozio = REPARTO.negozio)) then
	signal sqlstate '45000' set MESSAGE_TEXT = 'prodotto non in vendita nel reparto';
end if;

if(NEW.quantita > (select quantita_esposta 
					from (IN_VENDITA inner join REPARTO on IN_VENDITA.reparto = codice_reparto) inner join SCONTRINO on REPARTO.negozio = SCONTRINO.negozio
                    where codice_scontrino = NEW.scontrino and NEW.prodotto = IN_VENDITA.prodotto)) then
	signal sqlstate '45000' set MESSAGE_TEXT = 'quantita\' richiesta non disponibile';
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `CAMPAGNA_PROMOZIONALE`
--

DROP TABLE IF EXISTS `CAMPAGNA_PROMOZIONALE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CAMPAGNA_PROMOZIONALE` (
  `codice_campagna_promozionale` int(11) NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(45) NOT NULL,
  `data_inizio` date NOT NULL,
  `data_fine` date NOT NULL,
  `negozio` int(11) NOT NULL,
  PRIMARY KEY (`codice_campagna_promozionale`,`negozio`),
  KEY `fk_CAMPAGNA PROMOZIONALE_NEGOZIO1_idx` (`negozio`),
  CONSTRAINT `fk_CAMPAGNA PROMOZIONALE_NEGOZIO1` FOREIGN KEY (`negozio`) REFERENCES `NEGOZIO` (`P_IVA`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CAMPAGNA_PROMOZIONALE`
--

LOCK TABLES `CAMPAGNA_PROMOZIONALE` WRITE;
/*!40000 ALTER TABLE `CAMPAGNA_PROMOZIONALE` DISABLE KEYS */;
INSERT INTO `CAMPAGNA_PROMOZIONALE` VALUES (5,'black friday','2018-07-04','2018-08-01',123456);
/*!40000 ALTER TABLE `CAMPAGNA_PROMOZIONALE` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger insert_check_campagna_promozionale
before insert on CAMPAGNA_PROMOZIONALE
for each row
begin

if(datediff(NEW.data_inizio, NEW.data_fine) > 0) then
	signal sqlstate '45000' set MESSAGE_TEXT = 'data_inizio > data_fine';
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger rimuovi_campagna_promozionale
before delete on CAMPAGNA_PROMOZIONALE
for each row
begin

delete from PRODOTTI_SCONTATI
where campagna_promozionale = OLD.codice_campagna_promozionale;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `CATEGORIA`
--

DROP TABLE IF EXISTS `CATEGORIA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CATEGORIA` (
  `codice_categoria` int(11) NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codice_categoria`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CATEGORIA`
--

LOCK TABLES `CATEGORIA` WRITE;
/*!40000 ALTER TABLE `CATEGORIA` DISABLE KEYS */;
INSERT INTO `CATEGORIA` VALUES (1,'ABBIGLIAMENTO'),(2,'ALIMENTARI'),(3,'LUDICO'),(4,'CALZATURE');
/*!40000 ALTER TABLE `CATEGORIA` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger rimuovi_categoria
before delete on CATEGORIA
for each row
begin

delete from PUO_FORNIRE
where categoria_prodotto = OLD.codice_categoria;

delete from FORNITURA
where categoria_prodotto = OLD.codice_categoria;

delete from SUBCATEGORIA
where categoria_prodotto = OLD.codice_categoria;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `CLIENTE FEDELE`
--

DROP TABLE IF EXISTS `CLIENTE FEDELE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `CLIENTE FEDELE` (
  `codice_fiscale` varchar(16) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `cognome` varchar(45) NOT NULL,
  `eta` int(10) unsigned NOT NULL,
  `sesso` enum('M','F') NOT NULL,
  `numero_figli` int(10) unsigned NOT NULL,
  `stato_civile` enum('CELIBE','NUBILE','SPOSATO','DIVORZIATO') NOT NULL,
  `indirizzo_residenza` varchar(45) NOT NULL,
  `telefono` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`codice_fiscale`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CLIENTE FEDELE`
--

LOCK TABLES `CLIENTE FEDELE` WRITE;
/*!40000 ALTER TABLE `CLIENTE FEDELE` DISABLE KEYS */;
INSERT INTO `CLIENTE FEDELE` VALUES ('FHXYNG51D44B549M','Giovanni','Bruno',28,'M',2,'SPOSATO','via delle azioni 15','3277508982'),('grdrcr97h22c710v','Riccardo','Giordano',21,'M',0,'CELIBE','via indirizzo 10','090337497'),('pnzlbt63e68h519e','Elisabetta','Pinizzotto',50,'F',2,'SPOSATO','via indirizzo 10','090337497'),('TSVMTV45T66G592P','Annarita','Levi',50,'F',3,'DIVORZIATO','via delle gardenie 1','3283332630'),('VJTBPD34H13G575L','Claudio','La Rosa',21,'M',0,'CELIBE','via torregrotta 49','3243211234');
/*!40000 ALTER TABLE `CLIENTE FEDELE` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger rimuovi_cliente_fedele
before delete on `CLIENTE FEDELE`
for each row
begin

delete from `FIDELITY CARD`
where cliente = OLD.codice_fiscale;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `COLLOCAMENTO`
--

DROP TABLE IF EXISTS `COLLOCAMENTO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `COLLOCAMENTO` (
  `prodotto` int(11) NOT NULL,
  `ripiano` int(11) NOT NULL,
  `quantita` double unsigned NOT NULL,
  `soglia` double unsigned NOT NULL,
  PRIMARY KEY (`prodotto`,`ripiano`),
  KEY `fk_COLLOCAMENTO_PRODOTTO_idx` (`prodotto`),
  KEY `fk_COLLOCAMENTO_RIPIANO_idx` (`ripiano`),
  CONSTRAINT `fk_COLLOCAMENTO_PRODOTTO` FOREIGN KEY (`prodotto`) REFERENCES `PRODOTTO` (`codice_a_barre`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_COLLOCAMENTO_RIPIANO` FOREIGN KEY (`ripiano`) REFERENCES `RIPIANO` (`codice_ripiano`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `COLLOCAMENTO`
--

LOCK TABLES `COLLOCAMENTO` WRITE;
/*!40000 ALTER TABLE `COLLOCAMENTO` DISABLE KEYS */;
INSERT INTO `COLLOCAMENTO` VALUES (6,1,3,5),(43,1,10,5),(182,2,30,5),(183,2,15,2),(192,1,10,5);
/*!40000 ALTER TABLE `COLLOCAMENTO` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger insert_check_collocamento
before insert on COLLOCAMENTO
for each row 
if(NEW.quantita < NEW.soglia) then
	signal sqlstate '45000' set MESSAGE_TEXT = 'quantita\' inferiore alla soglia specificata';
end if */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger sotto_soglia
before update on COLLOCAMENTO
for each row
begin
declare N double;
declare F int;
if(NEW.quantita < NEW.soglia)
then
select negozio into N from IN_VENDITA inner join REPARTO on reparto = codice_reparto  where prodotto = NEW.prodotto;

select FORNITORE.P_IVA into F 
from (FORNITURA inner join FORNITORE on FORNITURA.fornitore = FORNITORE.P_IVA),
	(MAGAZZINO inner join SCAFFALE on SCAFFALE.codice_magazzino = MAGAZZINO.codice_magazzino) inner join RIPIANO on scaffale = codice_scaffale
where FORNITURA.negozio = MAGAZZINO.negozio and codice_ripiano = NEW.ripiano;

insert into ORDINE(negozio, data_ordine, prodotto, quantita, fornitore)
values(N, curdate(), NEW.prodotto, NEW.soglia, F);

end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `DIPENDENTE`
--

DROP TABLE IF EXISTS `DIPENDENTE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `DIPENDENTE` (
  `matricola` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `cognome` varchar(45) NOT NULL,
  `eta` int(10) unsigned NOT NULL,
  `sesso` enum('M','F') NOT NULL,
  `numero_figli` int(10) unsigned NOT NULL,
  `stato_civile` enum('CELIBE','NUBILE','SPOSATO','DIVORZIATO') NOT NULL,
  `indirizzo_residenza` varchar(45) NOT NULL,
  `telefono` varchar(10) DEFAULT NULL,
  `codice_fiscale` varchar(16) NOT NULL,
  PRIMARY KEY (`matricola`)
) ENGINE=InnoDB AUTO_INCREMENT=12347 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DIPENDENTE`
--

LOCK TABLES `DIPENDENTE` WRITE;
/*!40000 ALTER TABLE `DIPENDENTE` DISABLE KEYS */;
INSERT INTO `DIPENDENTE` VALUES (37,'Maria Catena','Mazzullo',22,'F',0,'NUBILE','via I maggio 11','098124765','FXDZQS29P51H560L'),(45,'Aldo Giovanni','Baglio',54,'M',2,'SPOSATO','via dello scherzo 123','1234567890','RGMTOA84B22F754Y'),(87,'Annarita','La Tiranna',44,'F',2,'SPOSATO','via Mario 23','3488765432','MPNSZJ32T61G508O'),(153,'Giorgia','Cognome Originale',56,'F',10,'SPOSATO','via stanca 1','3451237890','LNSFFN75L02A776A'),(180,'Arturo','Gervasi',40,'M',4,'DIVORZIATO','via delle incertezze 12','090235467','XFXTDN80T29A107L'),(186,'Armando','La Rosa',30,'M',0,'SPOSATO','via delle vie 90','098446783','DWSNPN51D55C848X'),(232,'Giovanni','Rombolano',23,'M',0,'CELIBE','via qualcosa 3','3431237651','NJRNZM84C61E610K'),(249,'Francesco','Salvo',34,'M',0,'CELIBE','via forse 3','098456123','DHSWLH48E17F899B'),(12345,'Gino','Cartelli',40,'M',0,'CELIBE','via indirizzo residenza 20','090337642','grdrcr97h22c710v'),(12346,'Armando','Locatelli',30,'M',2,'SPOSATO','via indirizzo residenza 20','090337642','grdrcr99h22c710v');
/*!40000 ALTER TABLE `DIPENDENTE` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger rimuovi_dipendente
before delete on DIPENDENTE
for each row
begin

delete from LAVORA
where dipendente = OLD.matricola;

delete from RESPONSABILE
where dipendente = OLD.matricola;

delete from MANAGER
where dipendente = OLD.matricola;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `FIDELITY CARD`
--

DROP TABLE IF EXISTS `FIDELITY CARD`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FIDELITY CARD` (
  `codice_carta` int(11) NOT NULL AUTO_INCREMENT,
  `data_emissione` date NOT NULL,
  `data_scadenza` date NOT NULL,
  `negozio` int(11) NOT NULL,
  `cliente` varchar(16) NOT NULL,
  PRIMARY KEY (`codice_carta`,`negozio`,`cliente`),
  KEY `fk_FIDELITY CARD_NEGOZIO1_idx` (`negozio`),
  KEY `fk_FIDELITY CARD_PERSONA_idx` (`cliente`),
  CONSTRAINT `fk_FIDELITY CARD_NEGOZIO1` FOREIGN KEY (`negozio`) REFERENCES `NEGOZIO` (`P_IVA`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_FIDELITY CARD_PERSONA` FOREIGN KEY (`cliente`) REFERENCES `CLIENTE FEDELE` (`codice_fiscale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FIDELITY CARD`
--

LOCK TABLES `FIDELITY CARD` WRITE;
/*!40000 ALTER TABLE `FIDELITY CARD` DISABLE KEYS */;
INSERT INTO `FIDELITY CARD` VALUES (1,'2018-05-10','2019-05-10',123456,'grdrcr97h22c710v'),(2,'2018-07-05','2019-07-05',123457,'pnzlbt63e68h519e'),(3,'2018-02-10','2019-02-10',123457,'grdrcr97h22c710v'),(4,'2017-09-10','2018-09-10',123457,'FHXYNG51D44B549M'),(5,'2018-05-01','2019-05-01',123458,'grdrcr97h22c710v'),(6,'2018-07-07','2019-07-07',123456,'FHXYNG51D44B549M');
/*!40000 ALTER TABLE `FIDELITY CARD` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger insert_check_fidelity_card
before insert on `FIDELITY CARD`
for each row
begin

if(datediff(NEW.data_emissione, NEW.data_scadenza) > 0) then
	signal sqlstate '45000' set MESSAGE_TEXT = 'data_emissione > data_scadenza';
end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `FORNITORE`
--

DROP TABLE IF EXISTS `FORNITORE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FORNITORE` (
  `P_IVA` int(11) NOT NULL,
  `ragione_sociale` varchar(45) NOT NULL,
  `indirizzo` varchar(45) NOT NULL,
  PRIMARY KEY (`P_IVA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FORNITORE`
--

LOCK TABLES `FORNITORE` WRITE;
/*!40000 ALTER TABLE `FORNITORE` DISABLE KEYS */;
INSERT INTO `FORNITORE` VALUES (125,'ragione 3','via vies 2'),(127,'ragione 4','via cosa 4'),(123456,'ragione sociale del fornitore','via del fornitore 5'),(123457,'ragione 2','via delle vie 8');
/*!40000 ALTER TABLE `FORNITORE` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger rimuovi_fornitore
before delete on FORNITORE
for each row
begin

delete from PUO_FORNIRE
where fornitore = OLD.P_IVA;

delete from FORNITURA
where fornitore = OLD.P_IVA;

delete from ORDINE
where fornitore = OLD.P_IVA;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `FORNITURA`
--

DROP TABLE IF EXISTS `FORNITURA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FORNITURA` (
  `negozio` int(11) NOT NULL,
  `fornitore` int(11) NOT NULL,
  `categoria_prodotto` int(11) NOT NULL,
  PRIMARY KEY (`negozio`,`categoria_prodotto`,`fornitore`),
  KEY `fk_FORNITURA_1_idx` (`fornitore`),
  KEY `fk_FORNITURA_3_idx` (`categoria_prodotto`),
  CONSTRAINT `fk_FORNITURA_1` FOREIGN KEY (`fornitore`) REFERENCES `FORNITORE` (`P_IVA`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_FORNITURA_2` FOREIGN KEY (`negozio`) REFERENCES `NEGOZIO` (`P_IVA`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_FORNITURA_3` FOREIGN KEY (`categoria_prodotto`) REFERENCES `CATEGORIA` (`codice_categoria`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FORNITURA`
--

LOCK TABLES `FORNITURA` WRITE;
/*!40000 ALTER TABLE `FORNITURA` DISABLE KEYS */;
INSERT INTO `FORNITURA` VALUES (123458,127,3),(123456,123456,2),(123457,123457,1);
/*!40000 ALTER TABLE `FORNITURA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `FRANCHISING`
--

DROP TABLE IF EXISTS `FRANCHISING`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `FRANCHISING` (
  `codice_franchising` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  PRIMARY KEY (`codice_franchising`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `FRANCHISING`
--

LOCK TABLES `FRANCHISING` WRITE;
/*!40000 ALTER TABLE `FRANCHISING` DISABLE KEYS */;
/*!40000 ALTER TABLE `FRANCHISING` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `IN_VENDITA`
--

DROP TABLE IF EXISTS `IN_VENDITA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `IN_VENDITA` (
  `prodotto` int(11) NOT NULL,
  `reparto` int(11) NOT NULL,
  `prezzo_base` double unsigned NOT NULL,
  `quantita_esposta` int(10) unsigned NOT NULL,
  PRIMARY KEY (`prodotto`,`reparto`),
  KEY `fk_PRODOTTO_has_REPARTO_REPARTO1_idx` (`reparto`),
  KEY `fk_PRODOTTO_has_REPARTO_PRODOTTO1_idx` (`prodotto`),
  CONSTRAINT `fk_PRODOTTO_has_REPARTO_PRODOTTO1` FOREIGN KEY (`prodotto`) REFERENCES `PRODOTTO` (`codice_a_barre`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODOTTO_has_REPARTO_REPARTO1` FOREIGN KEY (`reparto`) REFERENCES `REPARTO` (`codice_reparto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `IN_VENDITA`
--

LOCK TABLES `IN_VENDITA` WRITE;
/*!40000 ALTER TABLE `IN_VENDITA` DISABLE KEYS */;
INSERT INTO `IN_VENDITA` VALUES (6,5344,3.5,30),(43,5344,10,5),(182,1234,10,30),(183,1234,10,20),(192,5344,2,20);
/*!40000 ALTER TABLE `IN_VENDITA` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger insert_check_in_vendita
before insert on IN_VENDITA
for each row
BEGIN
declare C int;
declare NC int;

select categoria into C from REPARTO where codice_reparto = NEW.reparto;
select categoria_prodotto into NC from SUBCATEGORIA inner join PRODOTTO on subcategoria = codice_subcategoria where NEW.prodotto = codice_a_barre;
if(not(C = NC)) then
	signal sqlstate '45000' set MESSAGE_TEXT = 'categoria non corrispondente a quella in vendita dal negozio';
end if;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `LAVORA`
--

DROP TABLE IF EXISTS `LAVORA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LAVORA` (
  `dipendente` int(11) NOT NULL,
  `reparto` int(11) NOT NULL,
  `data_inizio` date NOT NULL,
  `data_fine` date DEFAULT NULL,
  `stipendio` double unsigned DEFAULT NULL,
  PRIMARY KEY (`dipendente`,`reparto`,`data_inizio`),
  KEY `fk_DIPENDENTE_has_REPARTO_REPARTO1_idx` (`reparto`),
  KEY `fk_DIPENDENTE_has_REPARTO_DIPENDENTE1_idx` (`dipendente`),
  CONSTRAINT `fk_DIPENDENTE_has_REPARTO_DIPENDENTE1` FOREIGN KEY (`dipendente`) REFERENCES `DIPENDENTE` (`matricola`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_DIPENDENTE_has_REPARTO_REPARTO1` FOREIGN KEY (`reparto`) REFERENCES `REPARTO` (`codice_reparto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LAVORA`
--

LOCK TABLES `LAVORA` WRITE;
/*!40000 ALTER TABLE `LAVORA` DISABLE KEYS */;
INSERT INTO `LAVORA` VALUES (87,1234,'2018-07-07',NULL,500),(186,1342,'2018-07-07',NULL,800),(12345,5344,'2018-07-07',NULL,600);
/*!40000 ALTER TABLE `LAVORA` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger insert_check_lavora
before insert on LAVORA
for each row
begin

call check_assunzione(NEW.dipendente, NEW.data_inizio, NEW.data_fine);

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `LOCALE`
--

DROP TABLE IF EXISTS `LOCALE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `LOCALE` (
  `codice_locale` int(11) NOT NULL AUTO_INCREMENT,
  `superficie` double NOT NULL,
  `negozio` int(11) DEFAULT NULL,
  `affitto` double unsigned DEFAULT NULL,
  PRIMARY KEY (`codice_locale`),
  KEY `fk_LOCALE_NEGOZIO1_idx` (`negozio`),
  CONSTRAINT `fk_LOCALE_NEGOZIO1` FOREIGN KEY (`negozio`) REFERENCES `NEGOZIO` (`P_IVA`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LOCALE`
--

LOCK TABLES `LOCALE` WRITE;
/*!40000 ALTER TABLE `LOCALE` DISABLE KEYS */;
INSERT INTO `LOCALE` VALUES (1,100.7,123457,10000),(2,50,123456,12000),(3,40,123458,80009),(4,20,123456,5000);
/*!40000 ALTER TABLE `LOCALE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MAGAZZINO`
--

DROP TABLE IF EXISTS `MAGAZZINO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MAGAZZINO` (
  `codice_magazzino` int(11) NOT NULL AUTO_INCREMENT,
  `negozio` int(11) NOT NULL,
  PRIMARY KEY (`codice_magazzino`,`negozio`),
  KEY `fk_MAGAZZINO_NEGOZIO1_idx` (`negozio`),
  CONSTRAINT `fk_MAGAZZINO_NEGOZIO1` FOREIGN KEY (`negozio`) REFERENCES `NEGOZIO` (`P_IVA`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MAGAZZINO`
--

LOCK TABLES `MAGAZZINO` WRITE;
/*!40000 ALTER TABLE `MAGAZZINO` DISABLE KEYS */;
INSERT INTO `MAGAZZINO` VALUES (1,123456),(2,123457),(3,123458);
/*!40000 ALTER TABLE `MAGAZZINO` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger rimuovi_magazzino
before delete on MAGAZZINO
for each row
begin

delete from SCAFFALE
where SCAFFALE.codice_magazzino = OLD.codice_magazzino;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `MANAGER`
--

DROP TABLE IF EXISTS `MANAGER`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MANAGER` (
  `dipendente` int(11) NOT NULL,
  `negozio` int(11) NOT NULL,
  `data_inizio` date NOT NULL,
  `data_fine` date DEFAULT NULL,
  `stipendio` double unsigned DEFAULT NULL,
  PRIMARY KEY (`dipendente`,`negozio`,`data_inizio`),
  KEY `fk_DIPENDENTE_has_NEGOZIO_NEGOZIO1_idx` (`negozio`),
  KEY `fk_DIPENDENTE_has_NEGOZIO_DIPENDENTE1_idx` (`dipendente`),
  CONSTRAINT `fk_DIPENDENTE_has_NEGOZIO_DIPENDENTE1` FOREIGN KEY (`dipendente`) REFERENCES `DIPENDENTE` (`matricola`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_DIPENDENTE_has_NEGOZIO_NEGOZIO1` FOREIGN KEY (`negozio`) REFERENCES `NEGOZIO` (`P_IVA`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MANAGER`
--

LOCK TABLES `MANAGER` WRITE;
/*!40000 ALTER TABLE `MANAGER` DISABLE KEYS */;
INSERT INTO `MANAGER` VALUES (45,123456,'2018-07-07',NULL,2000),(180,123457,'2018-07-07',NULL,2500),(232,123458,'2018-07-07',NULL,2300);
/*!40000 ALTER TABLE `MANAGER` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger insert_check_manager
before insert on MANAGER
for each row
begin

call check_assunzione(NEW.dipendente, NEW.data_inizio, NEW.data_fine);

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `NEGOZIO`
--

DROP TABLE IF EXISTS `NEGOZIO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `NEGOZIO` (
  `P_IVA` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `num_telefono` int(10) unsigned NOT NULL,
  `ragione_sociale` varchar(45) NOT NULL,
  `indirizzo_sede_fisica` varchar(45) NOT NULL,
  `indirizzo_sede_legale` varchar(45) NOT NULL,
  `franchising` int(11) DEFAULT NULL,
  PRIMARY KEY (`P_IVA`),
  KEY `fk_NEGOZIO_1_idx` (`franchising`),
  CONSTRAINT `fk_NEGOZIO_1` FOREIGN KEY (`franchising`) REFERENCES `FRANCHISING` (`codice_franchising`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NEGOZIO`
--

LOCK TABLES `NEGOZIO` WRITE;
/*!40000 ALTER TABLE `NEGOZIO` DISABLE KEYS */;
INSERT INTO `NEGOZIO` VALUES (123456,'negozio 1',90337654,'ragione sociale','via sede fisica 10','via sede legale 11',NULL),(123457,'negozio 2',90123456,'la mia ragione sociale','indirizzo A 1','indirizzo B 2',NULL),(123458,'negozio 3',90333332,'altra ragione sociale','via B 3','via C 4',NULL);
/*!40000 ALTER TABLE `NEGOZIO` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger rimuovi_negozio
before delete on NEGOZIO
for each row
begin

delete from CAMPAGNA_PROMOZIONALE
where negozio = OLD.P_IVA;

delete from SCONTRINO
where negozio = OLD.P_IVA;

delete from `FIDELITY CARD`
where negozio = OLD.P_IVA;

delete from REPARTO
where negozio = OLD.P_IVA;

delete from MANAGER
where negozio = OLD.P_IVA;

delete from MAGAZZINO
where negozio = OLD.P_IVA;

delete from ORDINE
where negozio = OLD.P_IVA;

delete from FORNITURA
where negozio = OLD.P_IVA;

update LOCALE
set negozio = null
where negozio = OLD.P_IVA;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ORDINE`
--

DROP TABLE IF EXISTS `ORDINE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ORDINE` (
  `codice_ordine` int(11) NOT NULL AUTO_INCREMENT,
  `negozio` int(11) NOT NULL,
  `data_ordine` date NOT NULL,
  `prodotto` int(11) NOT NULL,
  `quantita` double unsigned NOT NULL,
  `fornitore` int(11) NOT NULL,
  PRIMARY KEY (`codice_ordine`,`negozio`,`prodotto`,`fornitore`),
  KEY `fk_ORDINE_NEGOZIO1_idx` (`negozio`),
  KEY `fk_ORDINE_PRODOTTO1_idx` (`prodotto`),
  KEY `fk_ORDINE_FORNITORE1_idx` (`fornitore`),
  CONSTRAINT `fk_ORDINE_FORNITORE1` FOREIGN KEY (`fornitore`) REFERENCES `FORNITORE` (`P_IVA`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORDINE_NEGOZIO1` FOREIGN KEY (`negozio`) REFERENCES `NEGOZIO` (`P_IVA`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ORDINE_PRODOTTO1` FOREIGN KEY (`prodotto`) REFERENCES `PRODOTTO` (`codice_a_barre`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ORDINE`
--

LOCK TABLES `ORDINE` WRITE;
/*!40000 ALTER TABLE `ORDINE` DISABLE KEYS */;
INSERT INTO `ORDINE` VALUES (1,123456,'2018-07-07',6,5,123456);
/*!40000 ALTER TABLE `ORDINE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODOTTI_SCONTATI`
--

DROP TABLE IF EXISTS `PRODOTTI_SCONTATI`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRODOTTI_SCONTATI` (
  `prodotto` int(11) NOT NULL,
  `campagna_promozionale` int(11) NOT NULL,
  `sconto` double unsigned DEFAULT NULL,
  PRIMARY KEY (`prodotto`,`campagna_promozionale`),
  KEY `fk_PRODOTTO_has_CAMPAGNA PROMOZIONALE_CAMPAGNA PROMOZIONALE_idx` (`campagna_promozionale`),
  KEY `fk_PRODOTTO_has_CAMPAGNA PROMOZIONALE_PRODOTTO1_idx` (`prodotto`),
  CONSTRAINT `fk_PRODOTTO_has_CAMPAGNA PROMOZIONALE_CAMPAGNA PROMOZIONALE1` FOREIGN KEY (`campagna_promozionale`) REFERENCES `CAMPAGNA_PROMOZIONALE` (`codice_campagna_promozionale`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODOTTO_has_CAMPAGNA PROMOZIONALE_PRODOTTO1` FOREIGN KEY (`prodotto`) REFERENCES `PRODOTTO` (`codice_a_barre`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODOTTI_SCONTATI`
--

LOCK TABLES `PRODOTTI_SCONTATI` WRITE;
/*!40000 ALTER TABLE `PRODOTTI_SCONTATI` DISABLE KEYS */;
INSERT INTO `PRODOTTI_SCONTATI` VALUES (43,5,100);
/*!40000 ALTER TABLE `PRODOTTI_SCONTATI` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PRODOTTO`
--

DROP TABLE IF EXISTS `PRODOTTO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PRODOTTO` (
  `codice_a_barre` int(11) NOT NULL,
  `nome` varchar(45) NOT NULL,
  `descrizione` varchar(45) DEFAULT NULL,
  `eta_minima` int(10) unsigned DEFAULT NULL,
  `taglia` int(10) unsigned DEFAULT NULL,
  `materiale` varchar(45) DEFAULT NULL,
  `subcategoria` int(11) NOT NULL,
  PRIMARY KEY (`codice_a_barre`,`subcategoria`),
  KEY `subcategoria_idx` (`subcategoria`),
  CONSTRAINT `fk_PRODOTTO_1` FOREIGN KEY (`subcategoria`) REFERENCES `SUBCATEGORIA` (`codice_subcategoria`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PRODOTTO`
--

LOCK TABLES `PRODOTTO` WRITE;
/*!40000 ALTER TABLE `PRODOTTO` DISABLE KEYS */;
INSERT INTO `PRODOTTO` VALUES (6,'farina di platano',NULL,NULL,NULL,NULL,8),(43,'tofu',NULL,NULL,NULL,NULL,8),(49,'mocassini',NULL,NULL,40,NULL,4),(182,'t-shirt',NULL,NULL,38,'poliestere',1),(183,'t-shirt',NULL,NULL,38,'poliestere',2),(192,'patate',NULL,NULL,NULL,NULL,9);
/*!40000 ALTER TABLE `PRODOTTO` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger rimuovi_prodotto
before delete on PRODOTTO
for each row
begin

delete from COLLOCAMENTO
where prodotto = OLD.codice_a_barre;

delete from IN_VENDITA
where prodotto = OLD.codice_a_barre;

delete from PRODOTTI_SCONTATI
where prodotto = OLD.codice_a_barre;

delete from ACQUISTI
where prodotto = OLD.codice_a_barre;

delete from ORDINE
where prodotto = OLD.codice_a_barre;

delete from TABELLA_VALORI_NUTRIZIONALI
where prodotto = OLD.codice_a_barre;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `PUO_FORNIRE`
--

DROP TABLE IF EXISTS `PUO_FORNIRE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `PUO_FORNIRE` (
  `categoria_prodotto` int(11) NOT NULL,
  `fornitore` int(11) NOT NULL,
  PRIMARY KEY (`categoria_prodotto`,`fornitore`),
  KEY `fk_CATEGORIA_has_FORNITORE_FORNITORE1_idx` (`fornitore`),
  KEY `fk_CATEGORIA_has_FORNITORE_CATEGORIA1_idx` (`categoria_prodotto`),
  CONSTRAINT `fk_CATEGORIA_has_FORNITORE_CATEGORIA1` FOREIGN KEY (`categoria_prodotto`) REFERENCES `CATEGORIA` (`codice_categoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CATEGORIA_has_FORNITORE_FORNITORE1` FOREIGN KEY (`fornitore`) REFERENCES `FORNITORE` (`P_IVA`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PUO_FORNIRE`
--

LOCK TABLES `PUO_FORNIRE` WRITE;
/*!40000 ALTER TABLE `PUO_FORNIRE` DISABLE KEYS */;
INSERT INTO `PUO_FORNIRE` VALUES (4,125),(3,127),(2,123456),(1,123457),(2,123457);
/*!40000 ALTER TABLE `PUO_FORNIRE` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `REPARTO`
--

DROP TABLE IF EXISTS `REPARTO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `REPARTO` (
  `codice_reparto` int(11) NOT NULL AUTO_INCREMENT,
  `negozio` int(11) NOT NULL,
  `categoria` int(11) NOT NULL,
  PRIMARY KEY (`codice_reparto`),
  KEY `fk_REPARTO_NEGOZIO1_idx` (`negozio`),
  KEY `fk_REPARTO_1_idx` (`categoria`),
  CONSTRAINT `fk_REPARTO_1` FOREIGN KEY (`categoria`) REFERENCES `CATEGORIA` (`codice_categoria`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_REPARTO_NEGOZIO1` FOREIGN KEY (`negozio`) REFERENCES `NEGOZIO` (`P_IVA`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5345 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `REPARTO`
--

LOCK TABLES `REPARTO` WRITE;
/*!40000 ALTER TABLE `REPARTO` DISABLE KEYS */;
INSERT INTO `REPARTO` VALUES (1234,123457,1),(1342,123458,3),(5344,123456,2);
/*!40000 ALTER TABLE `REPARTO` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger rimuovi_reparto
before delete on REPARTO
for each row
begin

delete from LAVORA
where reparto = OLD.codice_reparto;

delete from RESPONSABILE
where reparto = OLD.codice_reparto;

delete from IN_VENDITA
where reparto = OLD.codice_reparto;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `RESPONSABILE`
--

DROP TABLE IF EXISTS `RESPONSABILE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RESPONSABILE` (
  `dipendente` int(11) NOT NULL,
  `reparto` int(11) NOT NULL,
  `data_inizio` date NOT NULL,
  `data_fine` date DEFAULT NULL,
  `stipendio` double unsigned DEFAULT NULL,
  PRIMARY KEY (`dipendente`,`reparto`,`data_inizio`),
  KEY `fk_DIPENDENTE_has_REPARTO_REPARTO2_idx` (`reparto`),
  KEY `fk_DIPENDENTE_has_REPARTO_DIPENDENTE2_idx` (`dipendente`),
  CONSTRAINT `fk_DIPENDENTE_has_REPARTO_DIPENDENTE2` FOREIGN KEY (`dipendente`) REFERENCES `DIPENDENTE` (`matricola`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_DIPENDENTE_has_REPARTO_REPARTO2` FOREIGN KEY (`reparto`) REFERENCES `REPARTO` (`codice_reparto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RESPONSABILE`
--

LOCK TABLES `RESPONSABILE` WRITE;
/*!40000 ALTER TABLE `RESPONSABILE` DISABLE KEYS */;
INSERT INTO `RESPONSABILE` VALUES (37,1234,'2017-01-20','2018-06-01',800),(37,5344,'2018-07-07',NULL,1000),(153,1234,'2018-07-07',NULL,1000),(249,1342,'2018-07-07',NULL,1800);
/*!40000 ALTER TABLE `RESPONSABILE` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger insert_check_responsabile
before insert on RESPONSABILE
for each row
begin

call check_assunzione(NEW.dipendente, NEW.data_inizio, NEW.data_fine);

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `RIPIANO`
--

DROP TABLE IF EXISTS `RIPIANO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `RIPIANO` (
  `codice_ripiano` int(11) NOT NULL AUTO_INCREMENT,
  `scaffale` int(11) NOT NULL,
  PRIMARY KEY (`codice_ripiano`,`scaffale`),
  KEY `fk_RIPIANO_SCAFFALE1_idx` (`scaffale`),
  CONSTRAINT `fk_RIPIANO_SCAFFALE1` FOREIGN KEY (`scaffale`) REFERENCES `SCAFFALE` (`codice_scaffale`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `RIPIANO`
--

LOCK TABLES `RIPIANO` WRITE;
/*!40000 ALTER TABLE `RIPIANO` DISABLE KEYS */;
INSERT INTO `RIPIANO` VALUES (1,1),(2,2),(3,3);
/*!40000 ALTER TABLE `RIPIANO` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger rimuovi_ripiano
before delete on RIPIANO
for each row
begin

delete from COLLOCAMENTO
where ripiano = OLD.codice_ripiano;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `SCAFFALE`
--

DROP TABLE IF EXISTS `SCAFFALE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCAFFALE` (
  `codice_scaffale` int(11) NOT NULL AUTO_INCREMENT,
  `codice_magazzino` int(11) NOT NULL,
  PRIMARY KEY (`codice_scaffale`,`codice_magazzino`),
  KEY `magazzino` (`codice_magazzino`),
  CONSTRAINT `fk_SCAFFALE_MAGAZZINO1` FOREIGN KEY (`codice_magazzino`) REFERENCES `MAGAZZINO` (`codice_magazzino`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SCAFFALE`
--

LOCK TABLES `SCAFFALE` WRITE;
/*!40000 ALTER TABLE `SCAFFALE` DISABLE KEYS */;
INSERT INTO `SCAFFALE` VALUES (1,1),(2,2),(3,3);
/*!40000 ALTER TABLE `SCAFFALE` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger rimuovi_scaffale
before delete on SCAFFALE
for each row
begin

delete from RIPIANO
where scaffale = OLD.codice_scaffale;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `SCONTRINO`
--

DROP TABLE IF EXISTS `SCONTRINO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SCONTRINO` (
  `codice_scontrino` int(11) NOT NULL AUTO_INCREMENT,
  `data_emissione` date NOT NULL,
  `negozio` int(11) NOT NULL,
  `fidelity_card` int(11) DEFAULT NULL,
  PRIMARY KEY (`codice_scontrino`,`negozio`),
  KEY `fk_SCONTRINO_NEGOZIO1_idx` (`negozio`),
  KEY `fk_SCONTRINO_FIDELITY CARD1_idx` (`fidelity_card`),
  CONSTRAINT `fk_SCONTRINO_NEGOZIO1` FOREIGN KEY (`negozio`) REFERENCES `NEGOZIO` (`P_IVA`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SCONTRINO`
--

LOCK TABLES `SCONTRINO` WRITE;
/*!40000 ALTER TABLE `SCONTRINO` DISABLE KEYS */;
INSERT INTO `SCONTRINO` VALUES (4,'2018-07-06',123456,NULL),(5,'2018-07-06',123456,1),(14,'2018-07-07',123457,4);
/*!40000 ALTER TABLE `SCONTRINO` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger rimuovi_scontrino
before delete on SCONTRINO
for each row
begin

delete from ACQUISTI
where scontrino = OLD.codice_scontrino;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `SUBCATEGORIA`
--

DROP TABLE IF EXISTS `SUBCATEGORIA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `SUBCATEGORIA` (
  `codice_subcategoria` int(11) NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(45) DEFAULT NULL,
  `categoria_prodotto` int(11) NOT NULL,
  PRIMARY KEY (`codice_subcategoria`,`categoria_prodotto`),
  KEY `fk_SUB-CATEGORIA_CATEGORIA1_idx` (`categoria_prodotto`),
  CONSTRAINT `fk_SUB-CATEGORIA_CATEGORIA1` FOREIGN KEY (`categoria_prodotto`) REFERENCES `CATEGORIA` (`codice_categoria`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SUBCATEGORIA`
--

LOCK TABLES `SUBCATEGORIA` WRITE;
/*!40000 ALTER TABLE `SUBCATEGORIA` DISABLE KEYS */;
INSERT INTO `SUBCATEGORIA` VALUES (1,'UOMO',1),(2,'DONNA',1),(3,'BAMBINO',1),(4,'CALZATURE',4),(5,'LUDICO',3),(6,'SENZA GRASSI',2),(7,'SENZA GLUTINE',2),(8,'VEGANO',2),(9,'ORTAGGI',2),(10,'FRUTTA',2);
/*!40000 ALTER TABLE `SUBCATEGORIA` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger rimuovi_subcategoria
before delete on SUBCATEGORIA
for each row
begin

delete from PRODOTTO
where subcategoria = OLD.codice_subcategoria;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `TABELLA_VALORI_NUTRIZIONALI`
--

DROP TABLE IF EXISTS `TABELLA_VALORI_NUTRIZIONALI`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `TABELLA_VALORI_NUTRIZIONALI` (
  `prodotto` int(11) NOT NULL,
  `valore` int(11) NOT NULL,
  `quantita` double unsigned NOT NULL,
  `unita_di_misura` varchar(45) NOT NULL,
  PRIMARY KEY (`prodotto`,`valore`),
  KEY `fk_PRODOTTO_has_VALORE NUTRIZIONALE_VALORE NUTRIZIONALE1_idx` (`valore`),
  KEY `fk_PRODOTTO_has_VALORE NUTRIZIONALE_PRODOTTO1_idx` (`prodotto`),
  CONSTRAINT `fk_PRODOTTO_has_VALORE NUTRIZIONALE_PRODOTTO1` FOREIGN KEY (`prodotto`) REFERENCES `PRODOTTO` (`codice_a_barre`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_PRODOTTO_has_VALORE NUTRIZIONALE_VALORE NUTRIZIONALE1` FOREIGN KEY (`valore`) REFERENCES `VALORE NUTRIZIONALE` (`codice_valore`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TABELLA_VALORI_NUTRIZIONALI`
--

LOCK TABLES `TABELLA_VALORI_NUTRIZIONALI` WRITE;
/*!40000 ALTER TABLE `TABELLA_VALORI_NUTRIZIONALI` DISABLE KEYS */;
INSERT INTO `TABELLA_VALORI_NUTRIZIONALI` VALUES (192,3,7,'g');
/*!40000 ALTER TABLE `TABELLA_VALORI_NUTRIZIONALI` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `VALORE NUTRIZIONALE`
--

DROP TABLE IF EXISTS `VALORE NUTRIZIONALE`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `VALORE NUTRIZIONALE` (
  `codice_valore` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) NOT NULL,
  `descrizione` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`codice_valore`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VALORE NUTRIZIONALE`
--

LOCK TABLES `VALORE NUTRIZIONALE` WRITE;
/*!40000 ALTER TABLE `VALORE NUTRIZIONALE` DISABLE KEYS */;
INSERT INTO `VALORE NUTRIZIONALE` VALUES (1,'grassi',NULL),(2,'carboidrati',NULL),(3,'proteine',NULL),(4,'sali minerali',NULL);
/*!40000 ALTER TABLE `VALORE NUTRIZIONALE` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger rimuovi_valore_nutrizionale
before delete on `VALORE NUTRIZIONALE`
for each row
begin

delete from TABELLA_VALORI_NUTRIZIONALI
where valore = OLD.codice_valore;

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Temporary table structure for view `fid_totali`
--

DROP TABLE IF EXISTS `fid_totali`;
/*!50001 DROP VIEW IF EXISTS `fid_totali`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `fid_totali` AS SELECT 
 1 AS `negozio`,
 1 AS `num_fid`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `reparti_amministrati`
--

DROP TABLE IF EXISTS `reparti_amministrati`;
/*!50001 DROP VIEW IF EXISTS `reparti_amministrati`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `reparti_amministrati` AS SELECT 
 1 AS `dipendente`,
 1 AS `num_reparti`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `spesa_totale`
--

DROP TABLE IF EXISTS `spesa_totale`;
/*!50001 DROP VIEW IF EXISTS `spesa_totale`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE VIEW `spesa_totale` AS SELECT 
 1 AS `cliente`,
 1 AS `spesa`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `fid_totali`
--

/*!50001 DROP VIEW IF EXISTS `fid_totali`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `fid_totali` AS select `FIDELITY CARD`.`negozio` AS `negozio`,count(0) AS `num_fid` from `FIDELITY CARD` group by `FIDELITY CARD`.`negozio` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `reparti_amministrati`
--

/*!50001 DROP VIEW IF EXISTS `reparti_amministrati`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `reparti_amministrati` AS select `RESPONSABILE`.`dipendente` AS `dipendente`,count(distinct `RESPONSABILE`.`reparto`) AS `num_reparti` from `RESPONSABILE` group by `RESPONSABILE`.`dipendente` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `spesa_totale`
--

/*!50001 DROP VIEW IF EXISTS `spesa_totale`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `spesa_totale` AS select `CLIENTE FEDELE`.`codice_fiscale` AS `cliente`,sum(((`IN_VENDITA`.`prezzo_base` - `calcola_sconto`(`SCONTRINO`.`negozio`,`ACQUISTI`.`prodotto`,`SCONTRINO`.`data_emissione`)) * `ACQUISTI`.`quantita`)) AS `spesa` from (((`SCONTRINO` join (`ACQUISTI` join `IN_VENDITA` on((`ACQUISTI`.`prodotto` = `IN_VENDITA`.`prodotto`))) on((`SCONTRINO`.`codice_scontrino` = `ACQUISTI`.`scontrino`))) join `PRODOTTO` on((`PRODOTTO`.`codice_a_barre` = `ACQUISTI`.`prodotto`))) join (`FIDELITY CARD` join `CLIENTE FEDELE` on((`CLIENTE FEDELE`.`codice_fiscale` = `FIDELITY CARD`.`cliente`))) on((`FIDELITY CARD`.`codice_carta` = `SCONTRINO`.`fidelity_card`))) group by `CLIENTE FEDELE`.`codice_fiscale` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2018-07-13 23:49:40
