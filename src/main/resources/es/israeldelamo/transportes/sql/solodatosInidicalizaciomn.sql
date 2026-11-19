/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: transportes
-- ------------------------------------------------------
-- Server version	10.11.14-MariaDB-0+deb12u2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `transportes`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `transportes` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */;

USE `transportes`;

--
-- Temporary table structure for view `20UltimasCargasCreadas`
--

DROP TABLE IF EXISTS `20UltimasCargasCreadas`;
/*!50001 DROP VIEW IF EXISTS `20UltimasCargasCreadas`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `20UltimasCargasCreadas` AS SELECT
 1 AS `cod_carga`,
  1 AS `peso_unitario`,
  1 AS `cantidad_bultos`,
  1 AS `dimension_l`,
  1 AS `dimension_h`,
  1 AS `dimension_a`,
  1 AS `localidad_origen`,
  1 AS `provincia_origen`,
  1 AS `pais_origen`,
  1 AS `cp_origen`,
  1 AS `localidad_destino`,
  1 AS `provincia_destino`,
  1 AS `pais_destino`,
  1 AS `cp_destino`,
  1 AS `cif_empresa`,
  1 AS `nombreEmpresa`,
  1 AS `ya_reservado`,
  1 AS `cod_empresa`,
  1 AS `fecha_creaccion` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `AsignacionDeCargasACondcutor`
--

DROP TABLE IF EXISTS `AsignacionDeCargasACondcutor`;
/*!50001 DROP VIEW IF EXISTS `AsignacionDeCargasACondcutor`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `AsignacionDeCargasACondcutor` AS SELECT
 1 AS `cod_conductor`,
  1 AS `cod_tracking`,
  1 AS `cod_carga_entrega`,
  1 AS `cod_carga`,
  1 AS `peso_unitario` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `CARGA_Y_ENTREGA`
--

DROP TABLE IF EXISTS `CARGA_Y_ENTREGA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `CARGA_Y_ENTREGA` (
  `cod_carga` int(11) NOT NULL AUTO_INCREMENT,
  `franja_horario_recogida` datetime DEFAULT current_timestamp(),
  `franja_horario_entrega` datetime DEFAULT current_timestamp(),
  `dimension_l` decimal(10,0) unsigned zerofill NOT NULL DEFAULT 0000000000,
  `dimension_a` decimal(10,0) unsigned zerofill NOT NULL DEFAULT 0000000000,
  `dimension_h` decimal(10,0) unsigned zerofill NOT NULL DEFAULT 0000000000,
  `peso_unitario` decimal(8,0) DEFAULT NULL,
  `manipulacion_carga_bool` tinyint(1) DEFAULT NULL,
  `remontable` tinyint(1) DEFAULT 0,
  `es_naturaleza_peligrosa` tinyint(1) DEFAULT NULL,
  `doble_conductor` tinyint(1) DEFAULT NULL,
  `ambito_de_carga` varchar(20) DEFAULT NULL,
  `carga_completa_o_grupaje` tinyint(1) DEFAULT NULL,
  `necesita_rampa` tinyint(1) DEFAULT NULL,
  `cod_naturaleza_peligrosa` float DEFAULT 1,
  `localidad_origen` varchar(50) DEFAULT 'Vitoria',
  `provincia_origen` varchar(45) DEFAULT 'Álava',
  `pais_origen` varchar(20) DEFAULT 'España',
  `cp_origen` int(11) DEFAULT 1005,
  `localidad_destino` varchar(50) DEFAULT 'Vitoria',
  `provincia_destino` varchar(45) DEFAULT 'Álava',
  `pais_destino` varchar(20) DEFAULT 'España',
  `cp_destino` int(11) DEFAULT 1005,
  `instrucciones` varchar(45) DEFAULT NULL,
  `reembolso_cantidad` varchar(45) DEFAULT '0',
  `con_vuelta` tinyint(1) DEFAULT NULL,
  `precio` varchar(45) DEFAULT '0',
  `seguro` varchar(45) DEFAULT '0',
  `es_adr` tinyint(1) DEFAULT NULL,
  `es_atp` tinyint(1) DEFAULT NULL,
  `ya_reservado` tinyint(1) DEFAULT 0,
  `cantidad_bultos` decimal(8,0) NOT NULL DEFAULT 1,
  `fecha_creaccion` datetime DEFAULT current_timestamp(),
  `empresa` varchar(20) NOT NULL,
  `tipo_bulto` int(11) NOT NULL,
  PRIMARY KEY (`cod_carga`,`empresa`,`tipo_bulto`),
  UNIQUE KEY `cod_carga_UNIQUE` (`cod_carga`),
  KEY `fk_CARGA_Y_ENTREGA_NATURALEZAS_PELIGROSAS1_idx` (`cod_naturaleza_peligrosa`),
  KEY `fk_CARGA_Y_ENTREGA_CODIGOS_POSTALES2_idx` (`localidad_destino`,`provincia_destino`,`pais_destino`,`cp_destino`),
  KEY `fk_CARGA_Y_ENTREGA_TIPO_DE_BULTO1_idx` (`tipo_bulto`),
  KEY `fk_origenes` (`localidad_origen`,`provincia_origen`,`pais_origen`,`cp_origen`),
  KEY `fk_CARGA_Y_ENTREGA_EMPRESAS1_idx` (`empresa`),
  CONSTRAINT `fk_CARGA_Y_ENTREGA_EMPRESAS1` FOREIGN KEY (`empresa`) REFERENCES `EMPRESAS` (`cif`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CARGA_Y_ENTREGA_TIPO_DE_BULTO1` FOREIGN KEY (`tipo_bulto`) REFERENCES `TIPO_DE_BULTO` (`cod_tipo_bulto`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=7805 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CARGA_Y_ENTREGA`
--

LOCK TABLES `CARGA_Y_ENTREGA` WRITE;
/*!40000 ALTER TABLE `CARGA_Y_ENTREGA` DISABLE KEYS */;
/*!40000 ALTER TABLE `CARGA_Y_ENTREGA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CODIGOS_POSTALES`
--

DROP TABLE IF EXISTS `CODIGOS_POSTALES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `CODIGOS_POSTALES` (
  `cp` int(11) NOT NULL,
  `localidad` varchar(50) NOT NULL,
  `provincia` varchar(45) NOT NULL,
  `pais` varchar(20) NOT NULL,
  PRIMARY KEY (`localidad`,`provincia`,`pais`,`cp`),
  CONSTRAINT `FK_contraLocalidades` FOREIGN KEY (`localidad`, `provincia`, `pais`) REFERENCES `LOCALIDADES` (`localidad`, `provincia`, `pais`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CODIGOS_POSTALES`
--

LOCK TABLES `CODIGOS_POSTALES` WRITE;
/*!40000 ALTER TABLE `CODIGOS_POSTALES` DISABLE KEYS */;
INSERT INTO `CODIGOS_POSTALES` VALUES
(9300,'Aalst','Flandes Oriental','Bélgica'),
(1000,'Adana','Adana','Turquía'),
(92100,'Agrigento','Agrigento','Italia'),
(15100,'Alessandria','Alessandria','Italia'),
(12345,'Altstadt (Casco Antiguo)','Colonia','Alemania'),
(2000,'Amberes','Amberes','Bélgica'),
(60100,'Ancona','Ancona','Italia'),
(1070,'Anderlecht','Bruselas','Bélgica'),
(6000,'Ankara','Ankara','Turquía'),
(11100,'Aosta','Aosta','Italia'),
(52100,'Arezzo','Arezzo','Italia'),
(63100,'Ascoli Piceno','Ascoli Piceno','Italia'),
(23456,'Augsburg','Baviera (Bayern)','Alemania'),
(3800,'Aveiro','Aveiro','Portugal'),
(8002,'Barcelona','Barcelona','España'),
(8003,'Barcelona','Barcelona','España'),
(8027,'Barcelona','Barcelona','España'),
(8030,'Barcelona','Barcelona','España'),
(8034,'Barcelona','Barcelona','España'),
(8041,'Barcelona','Barcelona','España'),
(70100,'Bari','Bari','Italia'),
(34567,'Berlín','Berlín','Alemania'),
(40100,'Bologna','Bologna','Italia'),
(4700,'Braga','Braga','Portugal'),
(45678,'Bremen','Bremen','Alemania'),
(8000,'Brujas','Flandes Occidental','Bélgica'),
(1000,'Bruselas','Bruselas','Bélgica'),
(9100,'Cagliari','Cagliari','Italia'),
(95100,'Catania','Catania','Italia'),
(6000,'Charleroi','Valonia','Bélgica'),
(3000,'Coímbra','Coímbra','Portugal'),
(56789,'Colonia','Baden-Württemberg','Alemania'),
(7000,'Évora','Évora','Portugal'),
(8000,'Faro','Faro','Portugal'),
(34000,'Fatih','Estambul (Istanbul)','Turquía'),
(50100,'Florencia','Florencia','Italia'),
(9000,'Funchal','Funchal','Portugal'),
(9000,'Gante','Flandes Oriental','Bélgica'),
(6969,'Gaza','Gaza','Israel'),
(3600,'Genk','Limburgo','Bélgica'),
(16100,'Génova','Génova','Italia'),
(8044,'Gerona','Gerona','España'),
(3500,'Hasselt','Limburgo','Bélgica'),
(38000,'Kocasinan','Kayseri','Turquía'),
(35200,'Konak','Esmirna (Izmir)','Turquía'),
(2400,'Leiría','Leiría','Portugal'),
(1,'Li Ze Township','Chang Tai','China'),
(4000,'Lieja','Valonia','Bélgica'),
(1000,'Lisboa','Lisboa','Portugal'),
(28027,'Madrid','Madrid','España'),
(2800,'Mechelen','Amberes','Bélgica'),
(20100,'Milán','Milán','Italia'),
(7000,'Muratpaşa','Antalya','Turquía'),
(5000,'Namur','Valonia','Bélgica'),
(80100,'Nápoles','Nápoles','Italia'),
(3360,'Novelda','Alicante','España'),
(61000,'Ortahisar','Trabzon','Turquía'),
(16000,'Osmangazi','Bursa','Turquía'),
(8400,'Ostende','Flandes Occidental','Bélgica'),
(90100,'Palermo','Palermo','Italia'),
(4000,'Porto','Porto','Portugal'),
(12,'Roma','Roma','Italia'),
(100,'Roma','Roma','Italia'),
(27000,'Şahinbey','Gaziantep','Turquía'),
(42000,'Selçuklu','Konya','Turquía'),
(2900,'Setúbal','Setúbal','Portugal'),
(10100,'Turín','Turín','Italia'),
(30100,'Venecia','Venecia','Italia'),
(37100,'Verona','Verona','Italia'),
(1003,'Vitoria','Álava','España'),
(1004,'Vitoria','Álava','España'),
(1005,'Vitoria','Álava','España'),
(1006,'Vitoria','Álava','España'),
(1020,'Vitoria','Álava','España'),
(1111,'Vitoria','Álava','España');
/*!40000 ALTER TABLE `CODIGOS_POSTALES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CONDUCTOR`
--

DROP TABLE IF EXISTS `CONDUCTOR`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `CONDUCTOR` (
  `dni` varchar(20) NOT NULL,
  `nombre` varchar(40) DEFAULT NULL,
  `apellido` varchar(20) DEFAULT NULL,
  `contacto_recogida` varchar(20) DEFAULT NULL,
  `correo_electronico` varchar(60) DEFAULT NULL,
  `foto_humano` mediumblob DEFAULT NULL,
  `es_internacional` tinyint(4) DEFAULT NULL,
  `tipo_de_carnet` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `localidad` varchar(50) NOT NULL,
  `provincia` varchar(45) NOT NULL,
  `pais` varchar(20) NOT NULL,
  `codigo_postal` int(11) NOT NULL,
  `motivo_lista_negra` varchar(250) DEFAULT NULL,
  `nacionalidad` varchar(20) NOT NULL,
  PRIMARY KEY (`dni`),
  KEY `RestriccionCarnet` (`tipo_de_carnet`),
  KEY `fk_CONDUCTOR_CODIGOS_POSTALES1_idx` (`localidad`,`provincia`,`pais`,`codigo_postal`),
  KEY `fk_CONDUCTOR_PAISES1_idx` (`nacionalidad`),
  KEY `fk_logins` (`nombre`),
  CONSTRAINT `FK_conductor_contr_CP` FOREIGN KEY (`localidad`, `provincia`, `pais`, `codigo_postal`) REFERENCES `CODIGOS_POSTALES` (`localidad`, `provincia`, `pais`, `cp`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `RestriccionCarnet` FOREIGN KEY (`tipo_de_carnet`) REFERENCES `TIPO_DE_CARNET` (`TipoDeCarnet`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_CONDUCTOR_PAISES1` FOREIGN KEY (`nacionalidad`) REFERENCES `PAISES` (`pais`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONDUCTOR`
--

LOCK TABLES `CONDUCTOR` WRITE;
/*!40000 ALTER TABLE `CONDUCTOR` DISABLE KEYS */;
/*!40000 ALTER TABLE `CONDUCTOR` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`usuarioTransport`@`%`*/ /*!50003 TRIGGER `transportes`.`after_conductor_insert`
AFTER INSERT ON `transportes`.`CONDUCTOR`
FOR EACH ROW
BEGIN
    INSERT INTO LOGINS (user, pass, rol)
    VALUES (NEW.dni, NEW.nombre , 'conductor');
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `CONDUCTOR_has_DOCUMENTO_CAPACITACION`
--

DROP TABLE IF EXISTS `CONDUCTOR_has_DOCUMENTO_CAPACITACION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `CONDUCTOR_has_DOCUMENTO_CAPACITACION` (
  `CONDUCTOR_dni` varchar(20) NOT NULL,
  `DOCUMENTO_CAPACITACION_cod_capacitacion` varchar(20) NOT NULL,
  `Doc_Capa_cod_naturaleza_peligorsa` float NOT NULL,
  PRIMARY KEY (`CONDUCTOR_dni`,`DOCUMENTO_CAPACITACION_cod_capacitacion`,`Doc_Capa_cod_naturaleza_peligorsa`),
  KEY `fk_CONDUCTOR_has_DOCUMENTO_CAPACITACION_DOCUMENTO_CAPACITAC_idx` (`DOCUMENTO_CAPACITACION_cod_capacitacion`,`Doc_Capa_cod_naturaleza_peligorsa`),
  KEY `fk_CONDUCTOR_has_DOCUMENTO_CAPACITACION_CONDUCTOR1_idx` (`CONDUCTOR_dni`),
  CONSTRAINT `fk_CONDUCTOR_has_DOCUMENTO_CAPACITACION_CONDUCTOR1` FOREIGN KEY (`CONDUCTOR_dni`) REFERENCES `CONDUCTOR` (`dni`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CONDUCTOR_has_DOCUMENTO_CAPACITACION_DOCUMENTO_CAPACITACION1` FOREIGN KEY (`DOCUMENTO_CAPACITACION_cod_capacitacion`, `Doc_Capa_cod_naturaleza_peligorsa`) REFERENCES `DOCUMENTO_CAPACITACION` (`cod_capacitacion`, `NATURALEZAS_PELIGROSAS_cod_naturaleza_peligrosa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONDUCTOR_has_DOCUMENTO_CAPACITACION`
--

LOCK TABLES `CONDUCTOR_has_DOCUMENTO_CAPACITACION` WRITE;
/*!40000 ALTER TABLE `CONDUCTOR_has_DOCUMENTO_CAPACITACION` DISABLE KEYS */;
/*!40000 ALTER TABLE `CONDUCTOR_has_DOCUMENTO_CAPACITACION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CONDUCTOR_has_EMPRESAS`
--

DROP TABLE IF EXISTS `CONDUCTOR_has_EMPRESAS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `CONDUCTOR_has_EMPRESAS` (
  `CONDUCTOR_dni` varchar(20) NOT NULL,
  `EMPRESAS_cif` varchar(20) NOT NULL,
  PRIMARY KEY (`CONDUCTOR_dni`,`EMPRESAS_cif`),
  KEY `fk_CONDUCTOR_has_EMPRESAS_EMPRESAS1_idx` (`EMPRESAS_cif`),
  KEY `fk_CONDUCTOR_has_EMPRESAS_CONDUCTOR1_idx` (`CONDUCTOR_dni`),
  CONSTRAINT `fk_CONDUCTOR_has_EMPRESAS_CONDUCTOR1` FOREIGN KEY (`CONDUCTOR_dni`) REFERENCES `CONDUCTOR` (`dni`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CONDUCTOR_has_EMPRESAS_EMPRESAS1` FOREIGN KEY (`EMPRESAS_cif`) REFERENCES `EMPRESAS` (`cif`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONDUCTOR_has_EMPRESAS`
--

LOCK TABLES `CONDUCTOR_has_EMPRESAS` WRITE;
/*!40000 ALTER TABLE `CONDUCTOR_has_EMPRESAS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CONDUCTOR_has_EMPRESAS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `CONDUCTOR_has_VEHICULOS`
--

DROP TABLE IF EXISTS `CONDUCTOR_has_VEHICULOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `CONDUCTOR_has_VEHICULOS` (
  `conductor_dni` varchar(20) NOT NULL,
  `vehiculos_cod_vehiculo` varchar(20) NOT NULL,
  PRIMARY KEY (`conductor_dni`,`vehiculos_cod_vehiculo`),
  KEY `fk_CONDUCTOR_has_VEHICULOS_VEHICULOS1_idx` (`vehiculos_cod_vehiculo`),
  KEY `fk_CONDUCTOR_has_VEHICULOS_CONDUCTOR1_idx` (`conductor_dni`),
  CONSTRAINT `fk_CONDUCTOR_has_VEHICULOS_CONDUCTOR1` FOREIGN KEY (`conductor_dni`) REFERENCES `CONDUCTOR` (`dni`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_CONDUCTOR_has_VEHICULOS_VEHICULOS1` FOREIGN KEY (`vehiculos_cod_vehiculo`) REFERENCES `VEHICULOS` (`cod_vehiculo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `CONDUCTOR_has_VEHICULOS`
--

LOCK TABLES `CONDUCTOR_has_VEHICULOS` WRITE;
/*!40000 ALTER TABLE `CONDUCTOR_has_VEHICULOS` DISABLE KEYS */;
/*!40000 ALTER TABLE `CONDUCTOR_has_VEHICULOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `CargasPorDestino`
--

DROP TABLE IF EXISTS `CargasPorDestino`;
/*!50001 DROP VIEW IF EXISTS `CargasPorDestino`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `CargasPorDestino` AS SELECT
 1 AS `cod_carga`,
  1 AS `peso_total`,
  1 AS `pais_origen`,
  1 AS `provincia_origen`,
  1 AS `localidad_origen`,
  1 AS `cp_origen`,
  1 AS `pais_destino`,
  1 AS `provincia_destino`,
  1 AS `localidad_destino`,
  1 AS `cp_destino`,
  1 AS `fecha_creaccion`,
  1 AS `metroscubicos` */;
SET character_set_client = @saved_cs_client;

--
-- Temporary table structure for view `CargasPorOrigen`
--

DROP TABLE IF EXISTS `CargasPorOrigen`;
/*!50001 DROP VIEW IF EXISTS `CargasPorOrigen`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `CargasPorOrigen` AS SELECT
 1 AS `cod_carga`,
  1 AS `peso_total`,
  1 AS `pais_origen`,
  1 AS `provincia_origen`,
  1 AS `localidad_origen`,
  1 AS `cp_origen`,
  1 AS `pais_destino`,
  1 AS `provincia_destino`,
  1 AS `localidad_destino`,
  1 AS `cp_destino`,
  1 AS `fecha_creaccion`,
  1 AS `metroscubicos` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `DOCUMENTO_CAPACITACION`
--

DROP TABLE IF EXISTS `DOCUMENTO_CAPACITACION`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `DOCUMENTO_CAPACITACION` (
  `cod_capacitacion` varchar(20) NOT NULL,
  `foto_en_vigor` mediumblob DEFAULT NULL,
  `NATURALEZAS_PELIGROSAS_cod_naturaleza_peligrosa` float NOT NULL,
  PRIMARY KEY (`cod_capacitacion`,`NATURALEZAS_PELIGROSAS_cod_naturaleza_peligrosa`),
  KEY `fk_DOCUMENTO_CAPACITACION_NATURALEZAS_PELIGROSAS1_idx` (`NATURALEZAS_PELIGROSAS_cod_naturaleza_peligrosa`),
  CONSTRAINT `fk_DOCUMENTO_CAPACITACION_NATURALEZAS_PELIGROSAS1` FOREIGN KEY (`NATURALEZAS_PELIGROSAS_cod_naturaleza_peligrosa`) REFERENCES `NATURALEZAS_PELIGROSAS` (`cod_naturaleza_peligrosa`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `DOCUMENTO_CAPACITACION`
--

LOCK TABLES `DOCUMENTO_CAPACITACION` WRITE;
/*!40000 ALTER TABLE `DOCUMENTO_CAPACITACION` DISABLE KEYS */;
/*!40000 ALTER TABLE `DOCUMENTO_CAPACITACION` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `EMPRESAS`
--

DROP TABLE IF EXISTS `EMPRESAS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `EMPRESAS` (
  `cif` varchar(20) NOT NULL,
  `nombre` varchar(120) NOT NULL,
  `domicilio` varchar(200) NOT NULL,
  `localidad` varchar(50) NOT NULL,
  `provincia` varchar(45) NOT NULL,
  `pais` varchar(20) NOT NULL,
  `cp` int(11) NOT NULL,
  `correo` varchar(45) DEFAULT NULL,
  `telefono` varchar(45) DEFAULT NULL,
  `persona_contacto` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cif`),
  KEY `fk_EMPRESAS_CODIGOS_POSTALES1_idx` (`localidad`,`provincia`,`pais`,`cp`),
  CONSTRAINT `FK_Empresa_contra_CP` FOREIGN KEY (`localidad`, `provincia`, `pais`, `cp`) REFERENCES `CODIGOS_POSTALES` (`localidad`, `provincia`, `pais`, `cp`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `EMPRESAS`
--

LOCK TABLES `EMPRESAS` WRITE;
/*!40000 ALTER TABLE `EMPRESAS` DISABLE KEYS */;
/*!40000 ALTER TABLE `EMPRESAS` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`usuarioTransport`@`%`*/ /*!50003 TRIGGER `transportes`.`after_empresa_insert`
AFTER INSERT ON `transportes`.`EMPRESAS`
FOR EACH ROW
BEGIN   
    INSERT INTO LOGINS (user, rol, pass)
    VALUES (NEW.cif, 'gerente', NEW.nombre);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ENVIO`
--

DROP TABLE IF EXISTS `ENVIO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ENVIO` (
  `cod_tracking` varchar(10) NOT NULL,
  `cod_conductor` varchar(100) NOT NULL,
  `cod_vehiculo` varchar(20) NOT NULL,
  `cod_carga_entrega` int(11) NOT NULL,
  PRIMARY KEY (`cod_tracking`),
  UNIQUE KEY `tracking_UNIQUE` (`cod_tracking`),
  KEY `fk_ENVIO_VEHICULOS1_idx` (`cod_vehiculo`),
  KEY `fk_CONDUCTOR` (`cod_conductor`),
  KEY `fk_ENVIO_CARGA_Y_ENTREGA1_idx` (`cod_carga_entrega`),
  CONSTRAINT `fk_CONDUCTOR` FOREIGN KEY (`cod_conductor`) REFERENCES `CONDUCTOR` (`dni`) ON DELETE NO ACTION ON UPDATE CASCADE,
  CONSTRAINT `fk_ENVIO_CARGA_Y_ENTREGA1` FOREIGN KEY (`cod_carga_entrega`) REFERENCES `CARGA_Y_ENTREGA` (`cod_carga`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_ENVIO_VEHICULOS1` FOREIGN KEY (`cod_vehiculo`) REFERENCES `VEHICULOS` (`cod_vehiculo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ENVIO`
--

LOCK TABLES `ENVIO` WRITE;
/*!40000 ALTER TABLE `ENVIO` DISABLE KEYS */;
/*!40000 ALTER TABLE `ENVIO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ESPERANDO`
--

DROP TABLE IF EXISTS `ESPERANDO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ESPERANDO` (
  `cod_carga` int(11) NOT NULL DEFAULT 0,
  `franja_horario_recogida` datetime DEFAULT current_timestamp(),
  `franja_horario_entrega` datetime DEFAULT current_timestamp(),
  `dimension_l` decimal(10,0) unsigned zerofill NOT NULL DEFAULT 0000000000,
  `dimension_a` decimal(10,0) unsigned zerofill NOT NULL DEFAULT 0000000000,
  `dimension_h` decimal(10,0) unsigned zerofill NOT NULL DEFAULT 0000000000,
  `peso_unitario` decimal(8,0) unsigned zerofill DEFAULT 00000000,
  `manipulacion_carga_bool` tinyint(1) DEFAULT NULL,
  `remontable` tinyint(1) DEFAULT 0,
  `es_naturaleza_peligrosa` tinyint(1) DEFAULT NULL,
  `doble_conductor` tinyint(1) DEFAULT NULL,
  `ambito_de_carga` varchar(20) DEFAULT NULL,
  `carga_completa_o_grupaje` tinyint(1) DEFAULT NULL,
  `necesita_rampa` tinyint(1) DEFAULT NULL,
  `cod_naturaleza_peligrosa` float DEFAULT 1,
  `localidad_origen` varchar(50) DEFAULT 'Vitoria',
  `provincia_origen` varchar(45) DEFAULT 'Álava',
  `pais_origen` varchar(20) DEFAULT 'España',
  `cp_origen` int(11) DEFAULT 1005,
  `localidad_destino` varchar(50) DEFAULT 'Vitoria',
  `provincia_destino` varchar(45) DEFAULT 'Álava',
  `pais_destino` varchar(20) DEFAULT 'España',
  `cp_destino` int(11) DEFAULT 1005,
  `instrucciones` varchar(45) DEFAULT NULL,
  `reembolso_cantidad` varchar(45) DEFAULT '0',
  `con_vuelta` tinyint(1) DEFAULT NULL,
  `precio` varchar(45) DEFAULT '0',
  `seguro` varchar(45) DEFAULT '0',
  `es_adr` tinyint(1) DEFAULT NULL,
  `es_atp` tinyint(1) DEFAULT NULL,
  `ya_reservado` tinyint(1) DEFAULT 0,
  `cantidad_bultos` decimal(8,0) NOT NULL DEFAULT 1,
  `fecha_creaccion` datetime DEFAULT current_timestamp(),
  `empresa` varchar(20) NOT NULL,
  `tipo_bulto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ESPERANDO`
--

LOCK TABLES `ESPERANDO` WRITE;
/*!40000 ALTER TABLE `ESPERANDO` DISABLE KEYS */;
/*!40000 ALTER TABLE `ESPERANDO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LOCALIDADES`
--

DROP TABLE IF EXISTS `LOCALIDADES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `LOCALIDADES` (
  `localidad` varchar(50) NOT NULL,
  `provincia` varchar(45) NOT NULL,
  `pais` varchar(20) NOT NULL,
  PRIMARY KEY (`localidad`,`provincia`,`pais`),
  KEY `fk_LOCALIDADES_PROVINCIAS1_idx` (`provincia`,`pais`),
  CONSTRAINT `fk_LOCALIDADES_PROVINCIAS1` FOREIGN KEY (`provincia`, `pais`) REFERENCES `PROVINCIAS` (`provincia`, `Paises_pais`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LOCALIDADES`
--

LOCK TABLES `LOCALIDADES` WRITE;
/*!40000 ALTER TABLE `LOCALIDADES` DISABLE KEYS */;
INSERT INTO `LOCALIDADES` VALUES
('Aalst','Flandes Oriental','Bélgica'),
('Abbey Wood','Londres','Reino Unido'),
('Acton','Londres','Reino Unido'),
('Adana','Adana','Turquía'),
('Agrigento','Agrigento','Italia'),
('Aldgate','Londres','Reino Unido'),
('Alessandria','Alessandria','Italia'),
('Altstadt (Casco Antiguo)','Colonia','Alemania'),
('Amberes','Amberes','Bélgica'),
('Amurrio','Álava','España'),
('Ancona','Ancona','Italia'),
('Anderlecht','Bruselas','Bélgica'),
('Ankara','Ankara','Turquía'),
('Aosta','Aosta','Italia'),
('Arezzo','Arezzo','Italia'),
('Ascoli Piceno','Ascoli Piceno','Italia'),
('Augsburg','Baviera (Bayern)','Alemania'),
('Aveiro','Aveiro','Portugal'),
('Baracaldo','Vizcaya','España'),
('Barcelona','Barcelona','España'),
('Bari','Bari','Italia'),
('Berlín','Berlín','Alemania'),
('Bethnal Green','Londres','Reino Unido'),
('Bilbao','Vizcaya','España'),
('Blackheath','Londres','Reino Unido'),
('Bloomsbury','Londres','Reino Unido'),
('Bologna','Bologna','Italia'),
('Bow','Londres','Reino Unido'),
('Braga','Braga','Portugal'),
('Bremen','Bremen','Alemania'),
('Brixton','Londres','Reino Unido'),
('Brujas','Flandes Occidental','Bélgica'),
('Bruselas','Bruselas','Bélgica'),
('Cagliari','Cagliari','Italia'),
('Camden Town','Londres','Reino Unido'),
('Catania','Catania','Italia'),
('Charleroi','Valonia','Bélgica'),
('Chelsea','Londres','Reino Unido'),
('Clerkenwell','Londres','Reino Unido'),
('Coímbra','Coímbra','Portugal'),
('Colonia','Baden-Württemberg','Alemania'),
('Colonia','North Rhine-Westphalia','Alemania'),
('Cottbus','Brandenburg','Alemania'),
('Cricklewood','Londres','Reino Unido'),
('Deutz','Colonia','Alemania'),
('Dortmund','North Rhine-Westphalia','Alemania'),
('Dresde','Sajonia (sachsen)','Alemania'),
('Düsseldorf','North Rhine-Westphalia','Alemania'),
('East Finchley','Londres','Reino Unido'),
('Ehrenfeld','Colonia','Alemania'),
('Erfurt','Turingia','Alemania'),
('Évora','Évora','Portugal'),
('Faro','Faro','Portugal'),
('Fatih','Estambul (Istanbul)','Turquía'),
('Finchley Central','Londres','Reino Unido'),
('Fleet Street','Londres','Reino Unido'),
('Florencia','Florencia','Italia'),
('Frankfurt am Main','Hesse','Alemania'),
('Funchal','Funchal','Portugal'),
('Gante','Flandes Oriental','Bélgica'),
('Gaza','Gaza','Israel'),
('Genk','Limburgo','Bélgica'),
('Génova','Génova','Italia'),
('Gerona','Gerona','España'),
('Halle (Saale)','Sajonia-Anhalt (Sachsen-Anhalt)','Alemania'),
('Hamburgo','Hamburg','Alemania'),
('Hampstead','Londres','Reino Unido'),
('Hasselt','Limburgo','Bélgica'),
('Holborn','Londres','Reino Unido'),
('Islington','Londres','Reino Unido'),
('Jena','Turingia','Alemania'),
('Kalk','Colonia','Alemania'),
('Karlsruhe','Baden-Württemberg','Alemania'),
('Kiel','Schleswig-Holstein','Alemania'),
('Kocasinan','Kayseri','Turquía'),
('Köln','Colonia','Alemania'),
('Konak','Esmirna (Izmir)','Turquía'),
('Leipzig','Sajonia (sachsen)','Alemania'),
('Leiría','Leiría','Portugal'),
('Li Ze Township','Chang Tai','China'),
('Lieja','Valonia','Bélgica'),
('Lindenthal','Colonia','Alemania'),
('Lisboa','Lisboa','Portugal'),
('Llodio','Álava','España'),
('Lübeck','Schleswig-Holstein','Alemania'),
('Ludwigshafen am Rhein','Renania-Palatinado (Rheinland-Pfalz)','Alemania'),
('Madrid','Madrid','España'),
('Magdeburgo','Sajonia-Anhalt (Sachsen-Anhalt)','Alemania'),
('Mainz','Renania-Palatinado (Rheinland-Pfalz)','Alemania'),
('Mannheim','Baden-Württemberg','Alemania'),
('Marquinez','Álava','España'),
('Mayfair','Londres','Reino Unido'),
('Mechelen','Amberes','Bélgica'),
('Milán','Milán','Italia'),
('Moorgate','Londres','Reino Unido'),
('Mülheim','Colonia','Alemania'),
('Múnich','Baviera (Bayern)','Alemania'),
('Muratpaşa','Antalya','Turquía'),
('Namur','Valonia','Bélgica'),
('Nápoles','Nápoles','Italia'),
('Neustadt-Nord','Colonia','Alemania'),
('Neustadt-Süd','Colonia','Alemania'),
('Nippes','Colonia','Alemania'),
('Novelda','Alicante','España'),
('Nuremberg','Baviera (Bayern)','Alemania'),
('Ortahisar','Trabzon','Turquía'),
('Osmangazi','Bursa','Turquía'),
('Ossendorf','Colonia','Alemania'),
('Ostende','Flandes Occidental','Bélgica'),
('Paddington','Londres','Reino Unido'),
('Palermo','Palermo','Italia'),
('Porto','Porto','Portugal'),
('Potsdam','Brandenburg','Alemania'),
('PRUEBA','Poitou-Charentes','Francia'),
('Rodenkirchen','Colonia','Alemania'),
('Roma','Roma','Italia'),
('Rostock','Mecklenburg-Vorpommern','Alemania'),
('Şahinbey','Gaziantep','Turquía'),
('Salvatierra','Álava','España'),
('Schwerin','Mecklenburg-Vorpommern','Alemania'),
('Selçuklu','Konya','Turquía'),
('Setúbal','Setúbal','Portugal'),
('Southwark','Londres','Reino Unido'),
('Stuttgart','Baden-Württemberg','Alemania'),
('Sülz','Colonia','Alemania'),
('Turín','Turín','Italia'),
('Venecia','Venecia','Italia'),
('Verona','Verona','Italia'),
('Vitoria','Álava','España'),
('Weiden','Colonia','Alemania'),
('Westminster','Londres','Reino Unido'),
('Whitechapel','Londres','Reino Unido'),
('Wiesbaden','Hesse','Alemania');
/*!40000 ALTER TABLE `LOCALIDADES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `LOGINS`
--

DROP TABLE IF EXISTS `LOGINS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `LOGINS` (
  `pass` varchar(45) NOT NULL,
  `rol` varchar(45) NOT NULL,
  `user` varchar(20) NOT NULL,
  PRIMARY KEY (`pass`,`rol`,`user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `LOGINS`
--

LOCK TABLES `LOGINS` WRITE;
/*!40000 ALTER TABLE `LOGINS` DISABLE KEYS */;
INSERT INTO `LOGINS` VALUES
('1','administrador','1'),
('1','conductor','1'),
('1','gestor','1'),
('ACME.SA','gestor','1234444'),
('Albert LLano','conductor','72735843'),
('Antonio Perez','conductor','123123445'),
('CANTERAS ALIQUEX, S.L.  ','gestor','1234'),
('Carmen Nuestra','conductor','12345678A'),
('CIUDAD JARDIN','gestor','1'),
('Elias del Monte','conductor','16357453'),
('Empresa22','gerente','22'),
('Ernesto Garcia','conductor','13424589'),
('Feli','conductor','1234345'),
('israel','conductor','72735843'),
('JORGE FDZ CERAMICAS','gestor','23'),
('Juan Carlos Arnaiz','conductor','123123445'),
('Juan Garcia','conductor','123123445'),
('M Victori Villarrea','conductor','600000000'),
('MOBILAR SA','gestor','56774889S'),
('nom','conductor','22'),
('Osakidetza','conductor','68686985'),
('PAPRIMUR SA','gestor','56774889S'),
('Pepito Perez','conductor','1234567899J'),
('Peter Frias','conductor','76678430'),
('SAYIA Co. Inc.','gestor','56774889S'),
('SEUR','gestor','654654'),
('Txomin Artola','conductor','16345543c'),
('Usuario1','administrador','1234345'),
('Usuario1','conductor','1234345'),
('XINGSON, LTD','gestor','12345'),
('Zuriñe Calvo','conductor','72728933');
/*!40000 ALTER TABLE `LOGINS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `NATURALEZAS_PELIGROSAS`
--

DROP TABLE IF EXISTS `NATURALEZAS_PELIGROSAS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `NATURALEZAS_PELIGROSAS` (
  `cod_naturaleza_peligrosa` float NOT NULL,
  `descripcion_natu_peligrosa` varchar(90) NOT NULL,
  PRIMARY KEY (`cod_naturaleza_peligrosa`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `NATURALEZAS_PELIGROSAS`
--

LOCK TABLES `NATURALEZAS_PELIGROSAS` WRITE;
/*!40000 ALTER TABLE `NATURALEZAS_PELIGROSAS` DISABLE KEYS */;
INSERT INTO `NATURALEZAS_PELIGROSAS` VALUES
(1,'Explosivos'),
(2,'Gases'),
(3,'Liquido Inflamable'),
(4.01,'Solidos Inflamables'),
(4.1,'Inflamación expontanea'),
(4.2,'Al contacto con el agua despiden gases inflamables.'),
(5,'Oxidantes y peróxidos'),
(5.1,'Material comburente'),
(5.2,'Peróxido orgánico'),
(6,'Tóxicas e infecciosas.'),
(6.1,'Tóxicas'),
(6.2,'Infecciosas'),
(7,'Radiactivas'),
(8,'Corrosivas'),
(9.1,'Materias y objetos peligrosos diversos.'),
(10,'Carga seca');
/*!40000 ALTER TABLE `NATURALEZAS_PELIGROSAS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PAISES`
--

DROP TABLE IF EXISTS `PAISES`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `PAISES` (
  `pais` varchar(20) NOT NULL,
  PRIMARY KEY (`pais`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PAISES`
--

LOCK TABLES `PAISES` WRITE;
/*!40000 ALTER TABLE `PAISES` DISABLE KEYS */;
INSERT INTO `PAISES` VALUES
('Afganistan'),
('Alemania'),
('Austria'),
('Bélgica'),
('Bulgaria'),
('China'),
('Chipre'),
('Croacia'),
('Dinamarca'),
('Eslovaquia'),
('Eslovenia'),
('España'),
('Estonia'),
('Finlandia'),
('Francia'),
('Grecia'),
('Hungría'),
('Irlanda'),
('Israel'),
('Italia'),
('Letonia'),
('Lituania'),
('Luxemburgo'),
('Malta'),
('Países Bajos'),
('Polonia'),
('Portugal'),
('Reino Unido'),
('República Checa'),
('Rumanía'),
('Suecia'),
('Turquía');
/*!40000 ALTER TABLE `PAISES` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `PROVINCIAS`
--

DROP TABLE IF EXISTS `PROVINCIAS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `PROVINCIAS` (
  `provincia` varchar(45) NOT NULL,
  `Paises_pais` varchar(20) NOT NULL,
  PRIMARY KEY (`provincia`,`Paises_pais`),
  KEY `consistenciaPaises` (`Paises_pais`),
  CONSTRAINT `consistenciaPaises` FOREIGN KEY (`Paises_pais`) REFERENCES `PAISES` (`pais`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `PROVINCIAS`
--

LOCK TABLES `PROVINCIAS` WRITE;
/*!40000 ALTER TABLE `PROVINCIAS` DISABLE KEYS */;
INSERT INTO `PROVINCIAS` VALUES
('Aberdeen City','Reino Unido'),
('Aberdeenshire','Reino Unido'),
('Abruzos','Italia'),
('Adana','Turquía'),
('Agrigento','Italia'),
('Álava','España'),
('Alessandria','Italia'),
('Alicante','España'),
('Almería','España'),
('Alpez y Costa Azúl','Francia'),
('Amberes','Bélgica'),
('Ancona','Italia'),
('Angus','Reino Unido'),
('Ankara','Turquía'),
('Antalya','Turquía'),
('Antrim and Newtownabbey','Reino Unido'),
('Aosta','Italia'),
('Apulia','Italia'),
('Ards and North Down','Reino Unido'),
('Arezzo','Italia'),
('Argyll and Bute','Reino Unido'),
('Armagh City, Banbridge and Craigavon','Reino Unido'),
('Ascoli Piceno','Italia'),
('Asturias','España'),
('Aveiro','Portugal'),
('Ávila','España'),
('Azukeka','España'),
('Badajoz','España'),
('Baden-Württemberg','Alemania'),
('Baja Silesia','Polonia'),
('Baja Voivodina','Polonia'),
('Báltico','Polonia'),
('Barcelona','España'),
('Bari','Italia'),
('Basilicata','Italia'),
('Baviera (Bayern)','Alemania'),
('Bayern','Alemania'),
('Bedfordshire','Reino Unido'),
('Belfast','Reino Unido'),
('Berkshire','Reino Unido'),
('Berlín','Alemania'),
('Blaenau Gwent','Reino Unido'),
('Bologna','Italia'),
('Bourgogne-Franche-Comté','Francia'),
('Braga','Portugal'),
('Brandenburg','Alemania'),
('Bremen','Alemania'),
('Bretaña','Francia'),
('Bridgend','Reino Unido'),
('Bristol','Reino Unido'),
('Bruselas','Bélgica'),
('Brussels Capital Region','Bélgica'),
('Buckinghamshire','Reino Unido'),
('Burgos','España'),
('Bursa','Turquía'),
('Cáceres','España'),
('Cádiz','España'),
('Caerphilly','Reino Unido'),
('Cagliari','Italia'),
('Calabria','Italia'),
('Cambridgeshire','Reino Unido'),
('Campania','Italia'),
('Cantabria','España'),
('Cardiff','Reino Unido'),
('Carmarthenshire','Reino Unido'),
('Castellón','España'),
('Catania','Italia'),
('Causeway Coast and Glens','Reino Unido'),
('Ceredigion','Reino Unido'),
('Chang tai','China'),
('Cheshire','Reino Unido'),
('City of London','Reino Unido'),
('Ciudad Real','España'),
('Clackmannanshire','Reino Unido'),
('Coímbra','Portugal'),
('Colonia','Alemania'),
('Conwy','Reino Unido'),
('Córcega','Francia'),
('Córdoba','España'),
('Cornwall','Reino Unido'),
('County Durham','Reino Unido'),
('Cracovia','Polonia'),
('Cuenca','España'),
('Cumbria','Reino Unido'),
('Denbighshire','Reino Unido'),
('Derbyshire','Reino Unido'),
('Derry and Strabane','Reino Unido'),
('Devon','Reino Unido'),
('Dorset','Reino Unido'),
('Dumfries and Galloway','Reino Unido'),
('Dundee City','Reino Unido'),
('East Ayrshire','Reino Unido'),
('East Dunbartonshire','Reino Unido'),
('East Lothian','Reino Unido'),
('East Renfrewshire','Reino Unido'),
('East Riding of Yorkshire','Reino Unido'),
('East Sussex','Reino Unido'),
('Edinburgh','Reino Unido'),
('Emilia-Romaña','Italia'),
('Esmirna (Izmir)','Turquía'),
('Essex','Reino Unido'),
('Estambul (Istanbul)','Turquía'),
('Évora','Portugal'),
('Falkirk','Reino Unido'),
('Faro','Portugal'),
('Fermanagh and Omagh','Reino Unido'),
('Fife','Reino Unido'),
('Flanders','Bélgica'),
('Flandes Occidental','Bélgica'),
('Flandes Oriental','Bélgica'),
('Flintshire','Reino Unido'),
('Florencia','Italia'),
('Friuli-Venecia Julia','Italia'),
('Funchal','Portugal'),
('Gaza','Israel'),
('Gaziantep','Turquía'),
('Gdansk','Polonia'),
('Génova','Italia'),
('Gerona','España'),
('Glasgow City','Reino Unido'),
('Gloucestershire','Reino Unido'),
('Gran Este','Francia'),
('Gran París','Francia'),
('Granada','España'),
('Greater London','Reino Unido'),
('Greater Manchester','Reino Unido'),
('Guadalajara','España'),
('Guadalupe','Francia'),
('Guipúzcoa','España'),
('Gwynedd','Reino Unido'),
('Hamburg','Alemania'),
('Hampshire','Reino Unido'),
('Herefordshire','Reino Unido'),
('Hertfordshire','Reino Unido'),
('Hesse','Alemania'),
('Highland','Reino Unido'),
('Huelva','España'),
('Huesca','España'),
('Inverclyde','Reino Unido'),
('Islas Balears','España'),
('Isle of Anglesey','Reino Unido'),
('Isle of Wight','Reino Unido'),
('Jaén','España'),
('Kayseri','Turquía'),
('Kent','Reino Unido'),
('Konya','Turquía'),
('Koszalin-Kołobrzeg','Polonia'),
('La Coruña','España'),
('La Rioja','España'),
('Lacio','Italia'),
('Lancashire','Reino Unido'),
('Languedoc','Francia'),
('Las Palmas','España'),
('Leicestershire','Reino Unido'),
('Leiría','Portugal'),
('León','España'),
('Lérida','España'),
('Liguria','Italia'),
('Limburgo','Bélgica'),
('Lincolnshire','Reino Unido'),
('Lisboa','Portugal'),
('Lisburn and Castlereagh','Reino Unido'),
('Lódz','Polonia'),
('Lombardía','Italia'),
('Londres','Reino Unido'),
('Lower Saxony','Alemania'),
('Lubiniec','Polonia'),
('Lugo','España'),
('Madrid','España'),
('Málaga','España'),
('Marcas','Italia'),
('Mazovie','Polonia'),
('Mecklenburg-Vorpommern','Alemania'),
('Merseyside','Reino Unido'),
('Merthyr Tydfil','Reino Unido'),
('Mid and East Antrim','Reino Unido'),
('Mid Ulster','Reino Unido'),
('Midi-Pirineos','Francia'),
('Midlothian','Reino Unido'),
('Milán','Italia'),
('Molise','Italia'),
('Monmouthshire','Reino Unido'),
('Moray','Reino Unido'),
('Murcia','España'),
('Na h-Eileanan Siar','Reino Unido'),
('Nápoles','Italia'),
('narnila','España'),
('Navarra','España'),
('Neath Port Talbot','Reino Unido'),
('Newport','Reino Unido'),
('Newry, Mourne and Down','Reino Unido'),
('Noexisto','Italia'),
('Norfolk','Reino Unido'),
('Normandía','Francia'),
('North Ayrshire','Reino Unido'),
('North Lanarkshire','Reino Unido'),
('North Rhine-Westphalia','Alemania'),
('North Yorkshire','Reino Unido'),
('Northamptonshire','Reino Unido'),
('Northumberland','Reino Unido'),
('Nottinghamshire','Reino Unido'),
('Nueva Aquitania','Francia'),
('Olsztyn','Polonia'),
('Orense','España'),
('Orkney Islands','Reino Unido'),
('Oxfordshire','Reino Unido'),
('Palencia','España'),
('Palermo','Italia'),
('Pays de la Loire','Francia'),
('Pembrokeshire','Reino Unido'),
('Perigordo','Francia'),
('Perth and Kinross','Reino Unido'),
('Piamonte','Italia'),
('Poitou-Charentes','Francia'),
('Pomerania','Polonia'),
('Pontevedra','España'),
('Porto','Portugal'),
('Powys','Reino Unido'),
('Poznań','Polonia'),
('Rafah','Israel'),
('Renania-Palatinado (Rheinland-Pfalz)','Alemania'),
('Renfrewshire','Reino Unido'),
('Reunión y Santa María','Francia'),
('Rhineland-Palatinate','Alemania'),
('Rhondda Cynon Taf','Reino Unido'),
('Roma','Italia'),
('Rutland','Reino Unido'),
('Rzeszów','Polonia'),
('Saarland','Alemania'),
('Sajonia (sachsen)','Alemania'),
('Sajonia-Anhalt (Sachsen-Anhalt)','Alemania'),
('Salamanca','España'),
('Santa Cruz de Tenerife','España'),
('Sardegna','Italia'),
('Schleswig-Holstein','Alemania'),
('Scottish Borders','Reino Unido'),
('Segovia','España'),
('Setúbal','Portugal'),
('Sevilla','España'),
('Shetland Islands','Reino Unido'),
('Shropshire','Reino Unido'),
('Sicilia','Italia'),
('Siedlce','Polonia'),
('Silesia-Saxony-Anhalt','Alemania'),
('Śląsk','Polonia'),
('Somerset','Reino Unido'),
('Soria','España'),
('South Ayrshire','Reino Unido'),
('South Lanarkshire','Reino Unido'),
('South Yorkshire','Reino Unido'),
('Staffordshire','Reino Unido'),
('Stirling','Reino Unido'),
('Suffolk','Reino Unido'),
('Surrey','Reino Unido'),
('Swansea','Reino Unido'),
('Tarragona','España'),
('Te-Avit','Israel'),
('Teruel','España'),
('Toledo','España'),
('Torfaen','Reino Unido'),
('Toruń-Kujawy','Polonia'),
('Toscana','Italia'),
('Trabzon','Turquía'),
('Trentino-Alto Adigio','Italia'),
('Turín','Italia'),
('Turingia','Alemania'),
('Tyne and Wear','Reino Unido'),
('Umbría','Italia'),
('Upper Saxony','Alemania'),
('Vale of Glamorgan','Reino Unido'),
('Valencia','España'),
('Valladolid','España'),
('Valonia','Bélgica'),
('Váneto','Italia'),
('Varmia-Masovia','Polonia'),
('Venecia','Italia'),
('Verona','Italia'),
('Vizcaya','España'),
('Wallonia','Bélgica'),
('Warwickshire','Reino Unido'),
('West Dunbartonshire','Reino Unido'),
('West Lothian','Reino Unido'),
('West Midlands','Reino Unido'),
('West Sussex','Reino Unido'),
('West Yorkshire','Reino Unido'),
('Wiltshire','Reino Unido'),
('Worcestershire','Reino Unido'),
('Wrexham','Reino Unido'),
('Zamora','España'),
('Zaragoza','España'),
('Zazuela','España');
/*!40000 ALTER TABLE `PROVINCIAS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `PedidosParaTab`
--

DROP TABLE IF EXISTS `PedidosParaTab`;
/*!50001 DROP VIEW IF EXISTS `PedidosParaTab`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `PedidosParaTab` AS SELECT
 1 AS `peso_unitario`,
  1 AS `carga_completa_o_grupaje`,
  1 AS `cod_carga`,
  1 AS `cantidad_bultos`,
  1 AS `dimension_l`,
  1 AS `dimension_h`,
  1 AS `dimension_a`,
  1 AS `pais_origen`,
  1 AS `pais_destino`,
  1 AS `provincia_origen`,
  1 AS `provincia_destino`,
  1 AS `ya_reservado`,
  1 AS `fecha_creaccion`,
  1 AS `tipo_bulto`,
  1 AS `codigo_bulto`,
  1 AS `nombre_bulto` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `SISTEMA_DE_CARGA_DE_VEHICULO`
--

DROP TABLE IF EXISTS `SISTEMA_DE_CARGA_DE_VEHICULO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `SISTEMA_DE_CARGA_DE_VEHICULO` (
  `cod_sistema_carga` int(11) NOT NULL,
  `descripcion` varchar(45) NOT NULL,
  PRIMARY KEY (`cod_sistema_carga`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `SISTEMA_DE_CARGA_DE_VEHICULO`
--

LOCK TABLES `SISTEMA_DE_CARGA_DE_VEHICULO` WRITE;
/*!40000 ALTER TABLE `SISTEMA_DE_CARGA_DE_VEHICULO` DISABLE KEYS */;
INSERT INTO `SISTEMA_DE_CARGA_DE_VEHICULO` VALUES
(1,'RORO (Rodante)'),
(2,'LOLO (Grua)'),
(3,'Carga lateral'),
(4,'Carga trasera');
/*!40000 ALTER TABLE `SISTEMA_DE_CARGA_DE_VEHICULO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TIPO_DE_BULTO`
--

DROP TABLE IF EXISTS `TIPO_DE_BULTO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `TIPO_DE_BULTO` (
  `cod_tipo_bulto` int(11) NOT NULL,
  `nombre_bulto` varchar(45) NOT NULL,
  `imagen_bulto` mediumblob DEFAULT NULL,
  PRIMARY KEY (`cod_tipo_bulto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TIPO_DE_BULTO`
--

LOCK TABLES `TIPO_DE_BULTO` WRITE;
/*!40000 ALTER TABLE `TIPO_DE_BULTO` DISABLE KEYS */;
INSERT INTO `TIPO_DE_BULTO` VALUES
(1,'TAMBOR',NULL),
(3,'CAJA-CARTÓN',NULL),
(6,'TUBO',NULL),
(7,'PIEZA SUELTA',NULL),
(8,'EUROPALET 1.2 X 0.8 X 0.145',NULL),
(9,'ISOPALET 1.2 X 1 X 0.15',NULL),
(10,'EUROPALET',NULL),
(12,'TEU',NULL),
(13,'FEU',NULL),
(14,'CONTENEDOR 30\" ',NULL);
/*!40000 ALTER TABLE `TIPO_DE_BULTO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TIPO_DE_CARNET`
--

DROP TABLE IF EXISTS `TIPO_DE_CARNET`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `TIPO_DE_CARNET` (
  `TipoDeCarnet` varchar(45) NOT NULL,
  PRIMARY KEY (`TipoDeCarnet`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TIPO_DE_CARNET`
--

LOCK TABLES `TIPO_DE_CARNET` WRITE;
/*!40000 ALTER TABLE `TIPO_DE_CARNET` DISABLE KEYS */;
INSERT INTO `TIPO_DE_CARNET` VALUES
('A1'),
('A2'),
('AM'),
('B'),
('B.T.P'),
('B1'),
('BE'),
('C'),
('C1'),
('C1E'),
('CE'),
('D'),
('D1');
/*!40000 ALTER TABLE `TIPO_DE_CARNET` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TIPO_DE_VEHICULO`
--

DROP TABLE IF EXISTS `TIPO_DE_VEHICULO`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `TIPO_DE_VEHICULO` (
  `cod_tipo_vehiculo` varchar(10) NOT NULL,
  `SISTEMAEDCARGAVEHICULO_cod_sistem_carga` int(11) NOT NULL,
  `estipulacion` varchar(45) NOT NULL,
  `instrucciones` varchar(45) NOT NULL,
  `foto` mediumblob DEFAULT NULL,
  `tiene_rampa` tinyint(1) NOT NULL,
  `puede_adr` tinyint(1) NOT NULL,
  `puede_atp` tinyint(1) NOT NULL,
  PRIMARY KEY (`cod_tipo_vehiculo`),
  KEY `fk_TIPO_DE_VEHICULO_SISTEMAEDCARGAVEHICULO1_idx` (`SISTEMAEDCARGAVEHICULO_cod_sistem_carga`),
  CONSTRAINT `fk_TIPO_DE_VEHICULO_SISTEMAEDCARGAVEHICULO1` FOREIGN KEY (`SISTEMAEDCARGAVEHICULO_cod_sistem_carga`) REFERENCES `SISTEMA_DE_CARGA_DE_VEHICULO` (`cod_sistema_carga`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TIPO_DE_VEHICULO`
--

LOCK TABLES `TIPO_DE_VEHICULO` WRITE;
/*!40000 ALTER TABLE `TIPO_DE_VEHICULO` DISABLE KEYS */;
INSERT INTO `TIPO_DE_VEHICULO` VALUES
('1',4,'2D','Camión 2 ejes pequeño',NULL,1,0,1),
('10',2,'T2','Bolqueta  camión 2 ejes',NULL,0,0,0),
('11',2,'T3','Bolqueta  camión 3 ejes',NULL,0,0,0),
('12',2,'S2','Semiremolque de 2 ejes',NULL,0,0,0),
('13',4,'S3','Semiremolque de 3 ejes',NULL,0,0,0),
('14',4,'R2','Remollque 2 ejes',NULL,0,0,0),
('15',4,'R3','Remollque 3 ejes',NULL,0,0,0),
('2',4,'2DA','Camión 2 ejes mediano',NULL,0,0,0),
('3',4,'2Db','Camión 2 ejes grande',NULL,0,0,0),
('4',1,'3A','Camión 3 ejsçes',NULL,0,0,0),
('5',1,'4C','Camión 4 ejes',NULL,0,0,0),
('6',1,'4O','Camión e ejes con tandem',NULL,0,0,0),
('7',2,'V2DB','Bolqueta de 2 ejes',NULL,0,0,0),
('8',2,'V3A','Bolqueta de 3 ejes',NULL,0,0,0),
('9',2,'VXS','Bolqueta ZX de 3 ejes',NULL,0,0,0);
/*!40000 ALTER TABLE `TIPO_DE_VEHICULO` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `TIPO_DE_VEHICULO_has_CARGAYENTREGA`
--

DROP TABLE IF EXISTS `TIPO_DE_VEHICULO_has_CARGAYENTREGA`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `TIPO_DE_VEHICULO_has_CARGAYENTREGA` (
  `cod_tipo_vehiculo` varchar(10) NOT NULL,
  `motivo` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`cod_tipo_vehiculo`),
  CONSTRAINT `CARGAENTREGAVEHICULO` FOREIGN KEY (`cod_tipo_vehiculo`) REFERENCES `TIPO_DE_VEHICULO` (`cod_tipo_vehiculo`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `TIPO_DE_VEHICULO_has_CARGAYENTREGA`
--

LOCK TABLES `TIPO_DE_VEHICULO_has_CARGAYENTREGA` WRITE;
/*!40000 ALTER TABLE `TIPO_DE_VEHICULO_has_CARGAYENTREGA` DISABLE KEYS */;
/*!40000 ALTER TABLE `TIPO_DE_VEHICULO_has_CARGAYENTREGA` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary table structure for view `TiposDeVehiculosYSistemaCarga`
--

DROP TABLE IF EXISTS `TiposDeVehiculosYSistemaCarga`;
/*!50001 DROP VIEW IF EXISTS `TiposDeVehiculosYSistemaCarga`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8mb4;
/*!50001 CREATE VIEW `TiposDeVehiculosYSistemaCarga` AS SELECT
 1 AS `cod_tipo_vehiculo`,
  1 AS `SISTEMAEDCARGAVEHICULO_cod_sistem_carga`,
  1 AS `estipulacion`,
  1 AS `instrucciones`,
  1 AS `foto`,
  1 AS `tiene_rampa`,
  1 AS `puede_adr`,
  1 AS `puede_atp`,
  1 AS `cod_sistema_carga`,
  1 AS `descripcion` */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `VEHICULOS`
--

DROP TABLE IF EXISTS `VEHICULOS`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `VEHICULOS` (
  `cod_vehiculo` varchar(20) NOT NULL,
  `MMA` decimal(10,4) NOT NULL DEFAULT 0.0000,
  `dimension_A` decimal(10,4) NOT NULL DEFAULT 0.0000,
  `dimension_L` decimal(10,4) NOT NULL DEFAULT 0.0000,
  `dimension_H` decimal(10,4) NOT NULL DEFAULT 0.0000,
  `carga_util` decimal(10,4) NOT NULL DEFAULT 0.0000,
  `cod_tipo_vehiculo` varchar(10) NOT NULL,
  PRIMARY KEY (`cod_vehiculo`),
  KEY `fk_VEHICULOS_TIPO_DE_VEHICULO1_idx` (`cod_tipo_vehiculo`),
  CONSTRAINT `fk_VEHICULOS_TIPO_DE_VEHICULO1` FOREIGN KEY (`cod_tipo_vehiculo`) REFERENCES `TIPO_DE_VEHICULO` (`cod_tipo_vehiculo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `VEHICULOS`
--

LOCK TABLES `VEHICULOS` WRITE;
/*!40000 ALTER TABLE `VEHICULOS` DISABLE KEYS */;
INSERT INTO `VEHICULOS` VALUES
('2343JTF',24000.0000,1300.0000,260.0000,410.0000,24000.0000,'15'),
('2343KLP',20000.0000,1300.0000,260.0000,410.0000,20000.0000,'14'),
('2388HHL',24000.0000,1300.0000,260.0000,410.0000,22000.0000,'13'),
('4045JKL',24000.0000,1300.0000,260.0000,410.0000,24000.0000,'15'),
('4055LTL',24000.0000,1300.0000,260.0000,410.0000,22000.0000,'13'),
('4252JSL',3500.0000,3000.0000,2100.0000,9055.0000,4523.0000,'1'),
('4722LTP',20000.0000,1300.0000,260.0000,410.0000,18500.0000,'12'),
('4845GHJ',27000.0000,1220.0000,260.0000,410.0000,24000.0000,'13'),
('5677GTJ',24000.0000,1300.0000,260.0000,410.0000,24000.0000,'15'),
('8860KLK',27000.0000,1220.0000,260.0000,410.0000,24000.0000,'13'),
('9800KLP',20000.0000,1220.0000,260.0000,410.0000,20000.0000,'4'),
('9890LLP',20000.0000,1220.0000,260.0000,410.0000,20000.0000,'4'),
('9899KLP',20000.0000,1300.0000,260.0000,410.0000,20000.0000,'14');
/*!40000 ALTER TABLE `VEHICULOS` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Current Database: `transportes`
--

USE `transportes`;

--
-- Final view structure for view `20UltimasCargasCreadas`
--

/*!50001 DROP VIEW IF EXISTS `20UltimasCargasCreadas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`usuarioTransport`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `20UltimasCargasCreadas` AS select `CARGA_Y_ENTREGA`.`cod_carga` AS `cod_carga`,`CARGA_Y_ENTREGA`.`peso_unitario` AS `peso_unitario`,`CARGA_Y_ENTREGA`.`cantidad_bultos` AS `cantidad_bultos`,`CARGA_Y_ENTREGA`.`dimension_l` AS `dimension_l`,`CARGA_Y_ENTREGA`.`dimension_h` AS `dimension_h`,`CARGA_Y_ENTREGA`.`dimension_a` AS `dimension_a`,`CARGA_Y_ENTREGA`.`localidad_origen` AS `localidad_origen`,`CARGA_Y_ENTREGA`.`provincia_origen` AS `provincia_origen`,`CARGA_Y_ENTREGA`.`pais_origen` AS `pais_origen`,`CARGA_Y_ENTREGA`.`cp_origen` AS `cp_origen`,`CARGA_Y_ENTREGA`.`localidad_destino` AS `localidad_destino`,`CARGA_Y_ENTREGA`.`provincia_destino` AS `provincia_destino`,`CARGA_Y_ENTREGA`.`pais_destino` AS `pais_destino`,`CARGA_Y_ENTREGA`.`cp_destino` AS `cp_destino`,`EMPRESAS`.`cif` AS `cif_empresa`,`EMPRESAS`.`nombre` AS `nombreEmpresa`,`CARGA_Y_ENTREGA`.`ya_reservado` AS `ya_reservado`,`CARGA_Y_ENTREGA`.`empresa` AS `cod_empresa`,`CARGA_Y_ENTREGA`.`fecha_creaccion` AS `fecha_creaccion` from (`CARGA_Y_ENTREGA` join `EMPRESAS`) where `EMPRESAS`.`cif` = `CARGA_Y_ENTREGA`.`empresa` order by `CARGA_Y_ENTREGA`.`cod_carga` limit 20 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `AsignacionDeCargasACondcutor`
--

/*!50001 DROP VIEW IF EXISTS `AsignacionDeCargasACondcutor`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`usuarioTransport`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `AsignacionDeCargasACondcutor` AS select `ENVIO`.`cod_conductor` AS `cod_conductor`,`ENVIO`.`cod_tracking` AS `cod_tracking`,`ENVIO`.`cod_carga_entrega` AS `cod_carga_entrega`,`CARGA_Y_ENTREGA`.`cod_carga` AS `cod_carga`,`CARGA_Y_ENTREGA`.`peso_unitario` AS `peso_unitario` from (`ENVIO` join `CARGA_Y_ENTREGA`) where `ENVIO`.`cod_carga_entrega` = `CARGA_Y_ENTREGA`.`cod_carga` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `CargasPorDestino`
--

/*!50001 DROP VIEW IF EXISTS `CargasPorDestino`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`usuarioTransport`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `CargasPorDestino` AS select `CARGA_Y_ENTREGA`.`cod_carga` AS `cod_carga`,`CARGA_Y_ENTREGA`.`peso_unitario` * `CARGA_Y_ENTREGA`.`cantidad_bultos` AS `peso_total`,`CARGA_Y_ENTREGA`.`pais_origen` AS `pais_origen`,`CARGA_Y_ENTREGA`.`provincia_origen` AS `provincia_origen`,`CARGA_Y_ENTREGA`.`localidad_origen` AS `localidad_origen`,`CARGA_Y_ENTREGA`.`cp_origen` AS `cp_origen`,`CARGA_Y_ENTREGA`.`pais_destino` AS `pais_destino`,`CARGA_Y_ENTREGA`.`provincia_destino` AS `provincia_destino`,`CARGA_Y_ENTREGA`.`localidad_destino` AS `localidad_destino`,`CARGA_Y_ENTREGA`.`cp_destino` AS `cp_destino`,`CARGA_Y_ENTREGA`.`fecha_creaccion` AS `fecha_creaccion`,`CARGA_Y_ENTREGA`.`dimension_l` * `CARGA_Y_ENTREGA`.`dimension_a` * `CARGA_Y_ENTREGA`.`dimension_h` * `CARGA_Y_ENTREGA`.`cantidad_bultos` / 1000000 AS `metroscubicos` from `CARGA_Y_ENTREGA` order by `CARGA_Y_ENTREGA`.`pais_origen` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `CargasPorOrigen`
--

/*!50001 DROP VIEW IF EXISTS `CargasPorOrigen`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`usuarioTransport`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `CargasPorOrigen` AS select `CARGA_Y_ENTREGA`.`cod_carga` AS `cod_carga`,`CARGA_Y_ENTREGA`.`peso_unitario` * `CARGA_Y_ENTREGA`.`cantidad_bultos` AS `peso_total`,`CARGA_Y_ENTREGA`.`pais_origen` AS `pais_origen`,`CARGA_Y_ENTREGA`.`provincia_origen` AS `provincia_origen`,`CARGA_Y_ENTREGA`.`localidad_origen` AS `localidad_origen`,`CARGA_Y_ENTREGA`.`cp_origen` AS `cp_origen`,`CARGA_Y_ENTREGA`.`pais_destino` AS `pais_destino`,`CARGA_Y_ENTREGA`.`provincia_destino` AS `provincia_destino`,`CARGA_Y_ENTREGA`.`localidad_destino` AS `localidad_destino`,`CARGA_Y_ENTREGA`.`cp_destino` AS `cp_destino`,`CARGA_Y_ENTREGA`.`fecha_creaccion` AS `fecha_creaccion`,`CARGA_Y_ENTREGA`.`dimension_l` * `CARGA_Y_ENTREGA`.`dimension_a` * `CARGA_Y_ENTREGA`.`dimension_h` * `CARGA_Y_ENTREGA`.`cantidad_bultos` / 1000000 AS `metroscubicos` from `CARGA_Y_ENTREGA` order by `CARGA_Y_ENTREGA`.`pais_origen` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `PedidosParaTab`
--

/*!50001 DROP VIEW IF EXISTS `PedidosParaTab`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`usuarioTransport`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `PedidosParaTab` AS select `CARGA_Y_ENTREGA`.`peso_unitario` AS `peso_unitario`,`CARGA_Y_ENTREGA`.`carga_completa_o_grupaje` AS `carga_completa_o_grupaje`,`CARGA_Y_ENTREGA`.`cod_carga` AS `cod_carga`,`CARGA_Y_ENTREGA`.`cantidad_bultos` AS `cantidad_bultos`,`CARGA_Y_ENTREGA`.`dimension_l` AS `dimension_l`,`CARGA_Y_ENTREGA`.`dimension_h` AS `dimension_h`,`CARGA_Y_ENTREGA`.`dimension_a` AS `dimension_a`,`CARGA_Y_ENTREGA`.`pais_origen` AS `pais_origen`,`CARGA_Y_ENTREGA`.`pais_destino` AS `pais_destino`,`CARGA_Y_ENTREGA`.`provincia_origen` AS `provincia_origen`,`CARGA_Y_ENTREGA`.`provincia_destino` AS `provincia_destino`,`CARGA_Y_ENTREGA`.`ya_reservado` AS `ya_reservado`,`CARGA_Y_ENTREGA`.`fecha_creaccion` AS `fecha_creaccion`,`CARGA_Y_ENTREGA`.`tipo_bulto` AS `tipo_bulto`,`TIPO_DE_BULTO`.`cod_tipo_bulto` AS `codigo_bulto`,`TIPO_DE_BULTO`.`nombre_bulto` AS `nombre_bulto` from (`CARGA_Y_ENTREGA` left join `TIPO_DE_BULTO` on(`CARGA_Y_ENTREGA`.`tipo_bulto` = `TIPO_DE_BULTO`.`cod_tipo_bulto`)) where `CARGA_Y_ENTREGA`.`ya_reservado` = 0 order by `CARGA_Y_ENTREGA`.`fecha_creaccion` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `TiposDeVehiculosYSistemaCarga`
--

/*!50001 DROP VIEW IF EXISTS `TiposDeVehiculosYSistemaCarga`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`usuarioTransport`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `TiposDeVehiculosYSistemaCarga` AS select `TIPO_DE_VEHICULO`.`cod_tipo_vehiculo` AS `cod_tipo_vehiculo`,`TIPO_DE_VEHICULO`.`SISTEMAEDCARGAVEHICULO_cod_sistem_carga` AS `SISTEMAEDCARGAVEHICULO_cod_sistem_carga`,`TIPO_DE_VEHICULO`.`estipulacion` AS `estipulacion`,`TIPO_DE_VEHICULO`.`instrucciones` AS `instrucciones`,`TIPO_DE_VEHICULO`.`foto` AS `foto`,`TIPO_DE_VEHICULO`.`tiene_rampa` AS `tiene_rampa`,`TIPO_DE_VEHICULO`.`puede_adr` AS `puede_adr`,`TIPO_DE_VEHICULO`.`puede_atp` AS `puede_atp`,`SISTEMA_DE_CARGA_DE_VEHICULO`.`cod_sistema_carga` AS `cod_sistema_carga`,`SISTEMA_DE_CARGA_DE_VEHICULO`.`descripcion` AS `descripcion` from (`TIPO_DE_VEHICULO` left join `SISTEMA_DE_CARGA_DE_VEHICULO` on(`TIPO_DE_VEHICULO`.`SISTEMAEDCARGAVEHICULO_cod_sistem_carga` = `SISTEMA_DE_CARGA_DE_VEHICULO`.`cod_sistema_carga`)) */;
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

-- Dump completed on 2026-06-11 16:47:36
