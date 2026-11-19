-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema transportes
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `transportes` ;

-- -----------------------------------------------------
-- Schema transportes
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `transportes` DEFAULT CHARACTER SET utf8mb4 ;
USE `transportes` ;

-- -----------------------------------------------------
-- Table `transportes`.`PAISES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`PAISES` ;

CREATE TABLE IF NOT EXISTS `transportes`.`PAISES` (
  `pais` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`pais`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`PROVINCIAS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`PROVINCIAS` ;

CREATE TABLE IF NOT EXISTS `transportes`.`PROVINCIAS` (
  `provincia` VARCHAR(45) NOT NULL,
  `Paises_pais` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`provincia`, `Paises_pais`),
  INDEX `consistenciaPaises` (`Paises_pais` ASC) VISIBLE,
  CONSTRAINT `consistenciaPaises`
    FOREIGN KEY (`Paises_pais`)
    REFERENCES `transportes`.`PAISES` (`pais`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`LOCALIDADES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`LOCALIDADES` ;

CREATE TABLE IF NOT EXISTS `transportes`.`LOCALIDADES` (
  `localidad` VARCHAR(50) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`localidad`, `provincia`, `pais`),
  INDEX `fk_LOCALIDADES_PROVINCIAS1_idx` (`provincia` ASC, `pais` ASC) VISIBLE,
  CONSTRAINT `fk_LOCALIDADES_PROVINCIAS1`
    FOREIGN KEY (`provincia` , `pais`)
    REFERENCES `transportes`.`PROVINCIAS` (`provincia` , `Paises_pais`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`CODIGOS_POSTALES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`CODIGOS_POSTALES` ;

CREATE TABLE IF NOT EXISTS `transportes`.`CODIGOS_POSTALES` (
  `cp` INT(11) NOT NULL,
  `localidad` VARCHAR(50) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`localidad`, `provincia`, `pais`, `cp`),
  CONSTRAINT `FK_contraLocalidades`
    FOREIGN KEY (`localidad` , `provincia` , `pais`)
    REFERENCES `transportes`.`LOCALIDADES` (`localidad` , `provincia` , `pais`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`EMPRESAS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`EMPRESAS` ;

CREATE TABLE IF NOT EXISTS `transportes`.`EMPRESAS` (
  `cif` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(120) NOT NULL,
  `domicilio` VARCHAR(200) NOT NULL,
  `localidad` VARCHAR(50) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(20) NOT NULL,
  `cp` INT(11) NOT NULL,
  `correo` VARCHAR(45) NULL DEFAULT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  `persona_contacto` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`cif`),
  INDEX `fk_EMPRESAS_CODIGOS_POSTALES1_idx` (`localidad` ASC, `provincia` ASC, `pais` ASC, `cp` ASC) VISIBLE,
  CONSTRAINT `FK_Empresa_contra_CP`
    FOREIGN KEY (`localidad` , `provincia` , `pais` , `cp`)
    REFERENCES `transportes`.`CODIGOS_POSTALES` (`localidad` , `provincia` , `pais` , `cp`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`TIPO_DE_BULTO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`TIPO_DE_BULTO` ;

CREATE TABLE IF NOT EXISTS `transportes`.`TIPO_DE_BULTO` (
  `cod_tipo_bulto` INT(11) NOT NULL,
  `nombre_bulto` VARCHAR(45) NOT NULL,
  `imagen_bulto` MEDIUMBLOB NULL DEFAULT NULL,
  PRIMARY KEY (`cod_tipo_bulto`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`CARGA_Y_ENTREGA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`CARGA_Y_ENTREGA` ;

CREATE TABLE IF NOT EXISTS `transportes`.`CARGA_Y_ENTREGA` (
  `cod_carga` INT(11) NOT NULL AUTO_INCREMENT,
  `franja_horario_recogida` DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
  `franja_horario_entrega` DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
  `dimension_l` DECIMAL(10,0) UNSIGNED ZEROFILL NOT NULL DEFAULT 0000000000,
  `dimension_a` DECIMAL(10,0) UNSIGNED ZEROFILL NOT NULL DEFAULT 0000000000,
  `dimension_h` DECIMAL(10,0) UNSIGNED ZEROFILL NOT NULL DEFAULT 0000000000,
  `peso_unitario` DECIMAL(8,0) NULL DEFAULT NULL,
  `manipulacion_carga_bool` TINYINT(1) NULL DEFAULT NULL,
  `remontable` TINYINT(1) NULL DEFAULT 0,
  `es_naturaleza_peligrosa` TINYINT(1) NULL DEFAULT NULL,
  `doble_conductor` TINYINT(1) NULL DEFAULT NULL,
  `ambito_de_carga` VARCHAR(20) NULL DEFAULT NULL,
  `carga_completa_o_grupaje` TINYINT(1) NULL DEFAULT NULL,
  `necesita_rampa` TINYINT(1) NULL DEFAULT NULL,
  `cod_naturaleza_peligrosa` FLOAT NULL DEFAULT 1,
  `localidad_origen` VARCHAR(50) NULL DEFAULT 'Vitoria',
  `provincia_origen` VARCHAR(45) NULL DEFAULT 'Álava',
  `pais_origen` VARCHAR(20) NULL DEFAULT 'España',
  `cp_origen` INT(11) NULL DEFAULT 1005,
  `localidad_destino` VARCHAR(50) NULL DEFAULT 'Vitoria',
  `provincia_destino` VARCHAR(45) NULL DEFAULT 'Álava',
  `pais_destino` VARCHAR(20) NULL DEFAULT 'España',
  `cp_destino` INT(11) NULL DEFAULT 1005,
  `instrucciones` VARCHAR(45) NULL DEFAULT NULL,
  `reembolso_cantidad` VARCHAR(45) NULL DEFAULT '0',
  `con_vuelta` TINYINT(1) NULL DEFAULT NULL,
  `precio` VARCHAR(45) NULL DEFAULT '0',
  `seguro` VARCHAR(45) NULL DEFAULT '0',
  `es_adr` TINYINT(1) NULL DEFAULT NULL,
  `es_atp` TINYINT(1) NULL DEFAULT NULL,
  `ya_reservado` TINYINT(1) NULL DEFAULT 0,
  `cantidad_bultos` DECIMAL(8,0) NOT NULL DEFAULT 1,
  `fecha_creaccion` DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
  `empresa` VARCHAR(20) NOT NULL,
  `tipo_bulto` INT(11) NOT NULL,
  PRIMARY KEY (`cod_carga`, `empresa`, `tipo_bulto`),
  UNIQUE INDEX `cod_carga_UNIQUE` (`cod_carga` ASC) VISIBLE,
  INDEX `fk_CARGA_Y_ENTREGA_NATURALEZAS_PELIGROSAS1_idx` (`cod_naturaleza_peligrosa` ASC) VISIBLE,
  INDEX `fk_CARGA_Y_ENTREGA_CODIGOS_POSTALES2_idx` (`localidad_destino` ASC, `provincia_destino` ASC, `pais_destino` ASC, `cp_destino` ASC) VISIBLE,
  INDEX `fk_CARGA_Y_ENTREGA_TIPO_DE_BULTO1_idx` (`tipo_bulto` ASC) VISIBLE,
  INDEX `fk_origenes` (`localidad_origen` ASC, `provincia_origen` ASC, `pais_origen` ASC, `cp_origen` ASC) VISIBLE,
  INDEX `fk_CARGA_Y_ENTREGA_EMPRESAS1_idx` (`empresa` ASC) VISIBLE,
  CONSTRAINT `fk_CARGA_Y_ENTREGA_EMPRESAS1`
    FOREIGN KEY (`empresa`)
    REFERENCES `transportes`.`EMPRESAS` (`cif`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CARGA_Y_ENTREGA_TIPO_DE_BULTO1`
    FOREIGN KEY (`tipo_bulto`)
    REFERENCES `transportes`.`TIPO_DE_BULTO` (`cod_tipo_bulto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 7805
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`TIPO_DE_CARNET`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`TIPO_DE_CARNET` ;

CREATE TABLE IF NOT EXISTS `transportes`.`TIPO_DE_CARNET` (
  `TipoDeCarnet` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`TipoDeCarnet`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`CONDUCTOR`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`CONDUCTOR` ;

CREATE TABLE IF NOT EXISTS `transportes`.`CONDUCTOR` (
  `dni` VARCHAR(20) NOT NULL,
  `nombre` VARCHAR(40) NULL DEFAULT NULL,
  `apellido` VARCHAR(20) NULL DEFAULT NULL,
  `contacto_recogida` VARCHAR(20) NULL DEFAULT NULL,
  `correo_electronico` VARCHAR(60) NULL DEFAULT NULL,
  `foto_humano` MEDIUMBLOB NULL DEFAULT NULL,
  `es_internacional` TINYINT(4) NULL DEFAULT NULL,
  `tipo_de_carnet` VARCHAR(45) NULL DEFAULT NULL,
  `telefono` VARCHAR(45) NULL DEFAULT NULL,
  `localidad` VARCHAR(50) NOT NULL,
  `provincia` VARCHAR(45) NOT NULL,
  `pais` VARCHAR(20) NOT NULL,
  `codigo_postal` INT(11) NOT NULL,
  `motivo_lista_negra` VARCHAR(250) NULL DEFAULT NULL,
  `nacionalidad` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`dni`),
  INDEX `RestriccionCarnet` (`tipo_de_carnet` ASC) VISIBLE,
  INDEX `fk_CONDUCTOR_CODIGOS_POSTALES1_idx` (`localidad` ASC, `provincia` ASC, `pais` ASC, `codigo_postal` ASC) VISIBLE,
  INDEX `fk_CONDUCTOR_PAISES1_idx` (`nacionalidad` ASC) VISIBLE,
  INDEX `fk_logins` (`nombre` ASC) VISIBLE,
  CONSTRAINT `FK_conductor_contr_CP`
    FOREIGN KEY (`localidad` , `provincia` , `pais` , `codigo_postal`)
    REFERENCES `transportes`.`CODIGOS_POSTALES` (`localidad` , `provincia` , `pais` , `cp`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `RestriccionCarnet`
    FOREIGN KEY (`tipo_de_carnet`)
    REFERENCES `transportes`.`TIPO_DE_CARNET` (`TipoDeCarnet`)
    ON DELETE SET NULL
    ON UPDATE CASCADE,
  CONSTRAINT `fk_CONDUCTOR_PAISES1`
    FOREIGN KEY (`nacionalidad`)
    REFERENCES `transportes`.`PAISES` (`pais`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`NATURALEZAS_PELIGROSAS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`NATURALEZAS_PELIGROSAS` ;

CREATE TABLE IF NOT EXISTS `transportes`.`NATURALEZAS_PELIGROSAS` (
  `cod_naturaleza_peligrosa` FLOAT NOT NULL,
  `descripcion_natu_peligrosa` VARCHAR(90) NOT NULL,
  PRIMARY KEY (`cod_naturaleza_peligrosa`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`DOCUMENTO_CAPACITACION`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`DOCUMENTO_CAPACITACION` ;

CREATE TABLE IF NOT EXISTS `transportes`.`DOCUMENTO_CAPACITACION` (
  `cod_capacitacion` VARCHAR(20) NOT NULL,
  `foto_en_vigor` MEDIUMBLOB NULL DEFAULT NULL,
  `NATURALEZAS_PELIGROSAS_cod_naturaleza_peligrosa` FLOAT NOT NULL,
  PRIMARY KEY (`cod_capacitacion`, `NATURALEZAS_PELIGROSAS_cod_naturaleza_peligrosa`),
  INDEX `fk_DOCUMENTO_CAPACITACION_NATURALEZAS_PELIGROSAS1_idx` (`NATURALEZAS_PELIGROSAS_cod_naturaleza_peligrosa` ASC) VISIBLE,
  CONSTRAINT `fk_DOCUMENTO_CAPACITACION_NATURALEZAS_PELIGROSAS1`
    FOREIGN KEY (`NATURALEZAS_PELIGROSAS_cod_naturaleza_peligrosa`)
    REFERENCES `transportes`.`NATURALEZAS_PELIGROSAS` (`cod_naturaleza_peligrosa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`CONDUCTOR_has_DOCUMENTO_CAPACITACION`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`CONDUCTOR_has_DOCUMENTO_CAPACITACION` ;

CREATE TABLE IF NOT EXISTS `transportes`.`CONDUCTOR_has_DOCUMENTO_CAPACITACION` (
  `CONDUCTOR_dni` VARCHAR(20) NOT NULL,
  `DOCUMENTO_CAPACITACION_cod_capacitacion` VARCHAR(20) NOT NULL,
  `Doc_Capa_cod_naturaleza_peligorsa` FLOAT NOT NULL,
  PRIMARY KEY (`CONDUCTOR_dni`, `DOCUMENTO_CAPACITACION_cod_capacitacion`, `Doc_Capa_cod_naturaleza_peligorsa`),
  INDEX `fk_CONDUCTOR_has_DOCUMENTO_CAPACITACION_DOCUMENTO_CAPACITAC_idx` (`DOCUMENTO_CAPACITACION_cod_capacitacion` ASC, `Doc_Capa_cod_naturaleza_peligorsa` ASC) VISIBLE,
  INDEX `fk_CONDUCTOR_has_DOCUMENTO_CAPACITACION_CONDUCTOR1_idx` (`CONDUCTOR_dni` ASC) VISIBLE,
  CONSTRAINT `fk_CONDUCTOR_has_DOCUMENTO_CAPACITACION_CONDUCTOR1`
    FOREIGN KEY (`CONDUCTOR_dni`)
    REFERENCES `transportes`.`CONDUCTOR` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CONDUCTOR_has_DOCUMENTO_CAPACITACION_DOCUMENTO_CAPACITACION1`
    FOREIGN KEY (`DOCUMENTO_CAPACITACION_cod_capacitacion` , `Doc_Capa_cod_naturaleza_peligorsa`)
    REFERENCES `transportes`.`DOCUMENTO_CAPACITACION` (`cod_capacitacion` , `NATURALEZAS_PELIGROSAS_cod_naturaleza_peligrosa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`CONDUCTOR_has_EMPRESAS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`CONDUCTOR_has_EMPRESAS` ;

CREATE TABLE IF NOT EXISTS `transportes`.`CONDUCTOR_has_EMPRESAS` (
  `CONDUCTOR_dni` VARCHAR(20) NOT NULL,
  `EMPRESAS_cif` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`CONDUCTOR_dni`, `EMPRESAS_cif`),
  INDEX `fk_CONDUCTOR_has_EMPRESAS_EMPRESAS1_idx` (`EMPRESAS_cif` ASC) VISIBLE,
  INDEX `fk_CONDUCTOR_has_EMPRESAS_CONDUCTOR1_idx` (`CONDUCTOR_dni` ASC) VISIBLE,
  CONSTRAINT `fk_CONDUCTOR_has_EMPRESAS_CONDUCTOR1`
    FOREIGN KEY (`CONDUCTOR_dni`)
    REFERENCES `transportes`.`CONDUCTOR` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CONDUCTOR_has_EMPRESAS_EMPRESAS1`
    FOREIGN KEY (`EMPRESAS_cif`)
    REFERENCES `transportes`.`EMPRESAS` (`cif`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`SISTEMA_DE_CARGA_DE_VEHICULO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`SISTEMA_DE_CARGA_DE_VEHICULO` ;

CREATE TABLE IF NOT EXISTS `transportes`.`SISTEMA_DE_CARGA_DE_VEHICULO` (
  `cod_sistema_carga` INT(11) NOT NULL,
  `descripcion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`cod_sistema_carga`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`TIPO_DE_VEHICULO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`TIPO_DE_VEHICULO` ;

CREATE TABLE IF NOT EXISTS `transportes`.`TIPO_DE_VEHICULO` (
  `cod_tipo_vehiculo` VARCHAR(10) NOT NULL,
  `SISTEMAEDCARGAVEHICULO_cod_sistem_carga` INT(11) NOT NULL,
  `estipulacion` VARCHAR(45) NOT NULL,
  `instrucciones` VARCHAR(45) NOT NULL,
  `foto` MEDIUMBLOB NULL DEFAULT NULL,
  `tiene_rampa` TINYINT(1) NOT NULL,
  `puede_adr` TINYINT(1) NOT NULL,
  `puede_atp` TINYINT(1) NOT NULL,
  PRIMARY KEY (`cod_tipo_vehiculo`),
  INDEX `fk_TIPO_DE_VEHICULO_SISTEMAEDCARGAVEHICULO1_idx` (`SISTEMAEDCARGAVEHICULO_cod_sistem_carga` ASC) VISIBLE,
  CONSTRAINT `fk_TIPO_DE_VEHICULO_SISTEMAEDCARGAVEHICULO1`
    FOREIGN KEY (`SISTEMAEDCARGAVEHICULO_cod_sistem_carga`)
    REFERENCES `transportes`.`SISTEMA_DE_CARGA_DE_VEHICULO` (`cod_sistema_carga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`VEHICULOS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`VEHICULOS` ;

CREATE TABLE IF NOT EXISTS `transportes`.`VEHICULOS` (
  `cod_vehiculo` VARCHAR(20) NOT NULL,
  `MMA` DECIMAL(10,4) NOT NULL DEFAULT 0.0000,
  `dimension_A` DECIMAL(10,4) NOT NULL DEFAULT 0.0000,
  `dimension_L` DECIMAL(10,4) NOT NULL DEFAULT 0.0000,
  `dimension_H` DECIMAL(10,4) NOT NULL DEFAULT 0.0000,
  `carga_util` DECIMAL(10,4) NOT NULL DEFAULT 0.0000,
  `cod_tipo_vehiculo` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`cod_vehiculo`),
  INDEX `fk_VEHICULOS_TIPO_DE_VEHICULO1_idx` (`cod_tipo_vehiculo` ASC) VISIBLE,
  CONSTRAINT `fk_VEHICULOS_TIPO_DE_VEHICULO1`
    FOREIGN KEY (`cod_tipo_vehiculo`)
    REFERENCES `transportes`.`TIPO_DE_VEHICULO` (`cod_tipo_vehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`CONDUCTOR_has_VEHICULOS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`CONDUCTOR_has_VEHICULOS` ;

CREATE TABLE IF NOT EXISTS `transportes`.`CONDUCTOR_has_VEHICULOS` (
  `conductor_dni` VARCHAR(20) NOT NULL,
  `vehiculos_cod_vehiculo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`conductor_dni`, `vehiculos_cod_vehiculo`),
  INDEX `fk_CONDUCTOR_has_VEHICULOS_VEHICULOS1_idx` (`vehiculos_cod_vehiculo` ASC) VISIBLE,
  INDEX `fk_CONDUCTOR_has_VEHICULOS_CONDUCTOR1_idx` (`conductor_dni` ASC) VISIBLE,
  CONSTRAINT `fk_CONDUCTOR_has_VEHICULOS_CONDUCTOR1`
    FOREIGN KEY (`conductor_dni`)
    REFERENCES `transportes`.`CONDUCTOR` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_CONDUCTOR_has_VEHICULOS_VEHICULOS1`
    FOREIGN KEY (`vehiculos_cod_vehiculo`)
    REFERENCES `transportes`.`VEHICULOS` (`cod_vehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`ENVIO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`ENVIO` ;

CREATE TABLE IF NOT EXISTS `transportes`.`ENVIO` (
  `cod_tracking` VARCHAR(10) NOT NULL,
  `cod_conductor` VARCHAR(100) NOT NULL,
  `cod_vehiculo` VARCHAR(20) NOT NULL,
  `cod_carga_entrega` INT(11) NOT NULL,
  PRIMARY KEY (`cod_tracking`),
  UNIQUE INDEX `tracking_UNIQUE` (`cod_tracking` ASC) VISIBLE,
  INDEX `fk_ENVIO_VEHICULOS1_idx` (`cod_vehiculo` ASC) VISIBLE,
  INDEX `fk_CONDUCTOR` (`cod_conductor` ASC) VISIBLE,
  INDEX `fk_ENVIO_CARGA_Y_ENTREGA1_idx` (`cod_carga_entrega` ASC) VISIBLE,
  CONSTRAINT `fk_CONDUCTOR`
    FOREIGN KEY (`cod_conductor`)
    REFERENCES `transportes`.`CONDUCTOR` (`dni`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `fk_ENVIO_CARGA_Y_ENTREGA1`
    FOREIGN KEY (`cod_carga_entrega`)
    REFERENCES `transportes`.`CARGA_Y_ENTREGA` (`cod_carga`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_ENVIO_VEHICULOS1`
    FOREIGN KEY (`cod_vehiculo`)
    REFERENCES `transportes`.`VEHICULOS` (`cod_vehiculo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`ESPERANDO`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`ESPERANDO` ;

CREATE TABLE IF NOT EXISTS `transportes`.`ESPERANDO` (
  `cod_carga` INT(11) NOT NULL DEFAULT 0,
  `franja_horario_recogida` DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
  `franja_horario_entrega` DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
  `dimension_l` DECIMAL(10,0) UNSIGNED ZEROFILL NOT NULL DEFAULT 0000000000,
  `dimension_a` DECIMAL(10,0) UNSIGNED ZEROFILL NOT NULL DEFAULT 0000000000,
  `dimension_h` DECIMAL(10,0) UNSIGNED ZEROFILL NOT NULL DEFAULT 0000000000,
  `peso_unitario` DECIMAL(8,0) UNSIGNED ZEROFILL NULL DEFAULT 00000000,
  `manipulacion_carga_bool` TINYINT(1) NULL DEFAULT NULL,
  `remontable` TINYINT(1) NULL DEFAULT 0,
  `es_naturaleza_peligrosa` TINYINT(1) NULL DEFAULT NULL,
  `doble_conductor` TINYINT(1) NULL DEFAULT NULL,
  `ambito_de_carga` VARCHAR(20) NULL DEFAULT NULL,
  `carga_completa_o_grupaje` TINYINT(1) NULL DEFAULT NULL,
  `necesita_rampa` TINYINT(1) NULL DEFAULT NULL,
  `cod_naturaleza_peligrosa` FLOAT NULL DEFAULT 1,
  `localidad_origen` VARCHAR(50) NULL DEFAULT 'Vitoria',
  `provincia_origen` VARCHAR(45) NULL DEFAULT 'Álava',
  `pais_origen` VARCHAR(20) NULL DEFAULT 'España',
  `cp_origen` INT(11) NULL DEFAULT 1005,
  `localidad_destino` VARCHAR(50) NULL DEFAULT 'Vitoria',
  `provincia_destino` VARCHAR(45) NULL DEFAULT 'Álava',
  `pais_destino` VARCHAR(20) NULL DEFAULT 'España',
  `cp_destino` INT(11) NULL DEFAULT 1005,
  `instrucciones` VARCHAR(45) NULL DEFAULT NULL,
  `reembolso_cantidad` VARCHAR(45) NULL DEFAULT '0',
  `con_vuelta` TINYINT(1) NULL DEFAULT NULL,
  `precio` VARCHAR(45) NULL DEFAULT '0',
  `seguro` VARCHAR(45) NULL DEFAULT '0',
  `es_adr` TINYINT(1) NULL DEFAULT NULL,
  `es_atp` TINYINT(1) NULL DEFAULT NULL,
  `ya_reservado` TINYINT(1) NULL DEFAULT 0,
  `cantidad_bultos` DECIMAL(8,0) NOT NULL DEFAULT 1,
  `fecha_creaccion` DATETIME NULL DEFAULT CURRENT_TIMESTAMP(),
  `empresa` VARCHAR(20) NOT NULL,
  `tipo_bulto` INT(11) NOT NULL)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`LOGINS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`LOGINS` ;

CREATE TABLE IF NOT EXISTS `transportes`.`LOGINS` (
  `pass` VARCHAR(45) NOT NULL,
  `rol` VARCHAR(45) NOT NULL,
  `user` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`pass`, `rol`, `user`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


-- -----------------------------------------------------
-- Table `transportes`.`TIPO_DE_VEHICULO_has_CARGAYENTREGA`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`TIPO_DE_VEHICULO_has_CARGAYENTREGA` ;

CREATE TABLE IF NOT EXISTS `transportes`.`TIPO_DE_VEHICULO_has_CARGAYENTREGA` (
  `cod_tipo_vehiculo` VARCHAR(10) NOT NULL,
  `motivo` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`cod_tipo_vehiculo`),
  CONSTRAINT `CARGAENTREGAVEHICULO`
    FOREIGN KEY (`cod_tipo_vehiculo`)
    REFERENCES `transportes`.`TIPO_DE_VEHICULO` (`cod_tipo_vehiculo`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

USE `transportes` ;

-- -----------------------------------------------------
-- Placeholder table for view `transportes`.`20UltimasCargasCreadas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transportes`.`20UltimasCargasCreadas` (`cod_carga` INT, `peso_unitario` INT, `cantidad_bultos` INT, `dimension_l` INT, `dimension_h` INT, `dimension_a` INT, `localidad_origen` INT, `provincia_origen` INT, `pais_origen` INT, `cp_origen` INT, `localidad_destino` INT, `provincia_destino` INT, `pais_destino` INT, `cp_destino` INT, `cif_empresa` INT, `nombreEmpresa` INT, `ya_reservado` INT, `cod_empresa` INT, `fecha_creaccion` INT);

-- -----------------------------------------------------
-- Placeholder table for view `transportes`.`AsignacionDeCargasACondcutor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transportes`.`AsignacionDeCargasACondcutor` (`cod_conductor` INT, `cod_tracking` INT, `cod_carga_entrega` INT, `cod_carga` INT, `peso_unitario` INT);

-- -----------------------------------------------------
-- Placeholder table for view `transportes`.`CargasPorDestino`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transportes`.`CargasPorDestino` (`cod_carga` INT, `peso_total` INT, `pais_origen` INT, `provincia_origen` INT, `localidad_origen` INT, `cp_origen` INT, `pais_destino` INT, `provincia_destino` INT, `localidad_destino` INT, `cp_destino` INT, `fecha_creaccion` INT, `metroscubicos` INT);

-- -----------------------------------------------------
-- Placeholder table for view `transportes`.`CargasPorOrigen`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transportes`.`CargasPorOrigen` (`cod_carga` INT, `peso_total` INT, `pais_origen` INT, `provincia_origen` INT, `localidad_origen` INT, `cp_origen` INT, `pais_destino` INT, `provincia_destino` INT, `localidad_destino` INT, `cp_destino` INT, `fecha_creaccion` INT, `metroscubicos` INT);

-- -----------------------------------------------------
-- Placeholder table for view `transportes`.`PedidosParaTab`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transportes`.`PedidosParaTab` (`peso_unitario` INT, `carga_completa_o_grupaje` INT, `cod_carga` INT, `cantidad_bultos` INT, `dimension_l` INT, `dimension_h` INT, `dimension_a` INT, `pais_origen` INT, `pais_destino` INT, `provincia_origen` INT, `provincia_destino` INT, `ya_reservado` INT, `fecha_creaccion` INT, `tipo_bulto` INT, `codigo_bulto` INT, `nombre_bulto` INT);

-- -----------------------------------------------------
-- Placeholder table for view `transportes`.`TiposDeVehiculosYSistemaCarga`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `transportes`.`TiposDeVehiculosYSistemaCarga` (`cod_tipo_vehiculo` INT, `SISTEMAEDCARGAVEHICULO_cod_sistem_carga` INT, `estipulacion` INT, `instrucciones` INT, `foto` INT, `tiene_rampa` INT, `puede_adr` INT, `puede_atp` INT, `cod_sistema_carga` INT, `descripcion` INT);

-- -----------------------------------------------------
-- View `transportes`.`20UltimasCargasCreadas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`20UltimasCargasCreadas`;
DROP VIEW IF EXISTS `transportes`.`20UltimasCargasCreadas` ;
USE `transportes`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`usuarioTransport`@`%` SQL SECURITY DEFINER VIEW `transportes`.`20UltimasCargasCreadas` AS select `transportes`.`CARGA_Y_ENTREGA`.`cod_carga` AS `cod_carga`,`transportes`.`CARGA_Y_ENTREGA`.`peso_unitario` AS `peso_unitario`,`transportes`.`CARGA_Y_ENTREGA`.`cantidad_bultos` AS `cantidad_bultos`,`transportes`.`CARGA_Y_ENTREGA`.`dimension_l` AS `dimension_l`,`transportes`.`CARGA_Y_ENTREGA`.`dimension_h` AS `dimension_h`,`transportes`.`CARGA_Y_ENTREGA`.`dimension_a` AS `dimension_a`,`transportes`.`CARGA_Y_ENTREGA`.`localidad_origen` AS `localidad_origen`,`transportes`.`CARGA_Y_ENTREGA`.`provincia_origen` AS `provincia_origen`,`transportes`.`CARGA_Y_ENTREGA`.`pais_origen` AS `pais_origen`,`transportes`.`CARGA_Y_ENTREGA`.`cp_origen` AS `cp_origen`,`transportes`.`CARGA_Y_ENTREGA`.`localidad_destino` AS `localidad_destino`,`transportes`.`CARGA_Y_ENTREGA`.`provincia_destino` AS `provincia_destino`,`transportes`.`CARGA_Y_ENTREGA`.`pais_destino` AS `pais_destino`,`transportes`.`CARGA_Y_ENTREGA`.`cp_destino` AS `cp_destino`,`transportes`.`EMPRESAS`.`cif` AS `cif_empresa`,`transportes`.`EMPRESAS`.`nombre` AS `nombreEmpresa`,`transportes`.`CARGA_Y_ENTREGA`.`ya_reservado` AS `ya_reservado`,`transportes`.`CARGA_Y_ENTREGA`.`empresa` AS `cod_empresa`,`transportes`.`CARGA_Y_ENTREGA`.`fecha_creaccion` AS `fecha_creaccion` from (`transportes`.`CARGA_Y_ENTREGA` join `transportes`.`EMPRESAS`) where `transportes`.`EMPRESAS`.`cif` = `transportes`.`CARGA_Y_ENTREGA`.`empresa` order by `transportes`.`CARGA_Y_ENTREGA`.`cod_carga` limit 20;

-- -----------------------------------------------------
-- View `transportes`.`AsignacionDeCargasACondcutor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`AsignacionDeCargasACondcutor`;
DROP VIEW IF EXISTS `transportes`.`AsignacionDeCargasACondcutor` ;
USE `transportes`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`usuarioTransport`@`%` SQL SECURITY DEFINER VIEW `transportes`.`AsignacionDeCargasACondcutor` AS select `transportes`.`ENVIO`.`cod_conductor` AS `cod_conductor`,`transportes`.`ENVIO`.`cod_tracking` AS `cod_tracking`,`transportes`.`ENVIO`.`cod_carga_entrega` AS `cod_carga_entrega`,`transportes`.`CARGA_Y_ENTREGA`.`cod_carga` AS `cod_carga`,`transportes`.`CARGA_Y_ENTREGA`.`peso_unitario` AS `peso_unitario` from (`transportes`.`ENVIO` join `transportes`.`CARGA_Y_ENTREGA`) where `transportes`.`ENVIO`.`cod_carga_entrega` = `transportes`.`CARGA_Y_ENTREGA`.`cod_carga`;

-- -----------------------------------------------------
-- View `transportes`.`CargasPorDestino`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`CargasPorDestino`;
DROP VIEW IF EXISTS `transportes`.`CargasPorDestino` ;
USE `transportes`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`usuarioTransport`@`%` SQL SECURITY DEFINER VIEW `transportes`.`CargasPorDestino` AS select `transportes`.`CARGA_Y_ENTREGA`.`cod_carga` AS `cod_carga`,`transportes`.`CARGA_Y_ENTREGA`.`peso_unitario` * `transportes`.`CARGA_Y_ENTREGA`.`cantidad_bultos` AS `peso_total`,`transportes`.`CARGA_Y_ENTREGA`.`pais_origen` AS `pais_origen`,`transportes`.`CARGA_Y_ENTREGA`.`provincia_origen` AS `provincia_origen`,`transportes`.`CARGA_Y_ENTREGA`.`localidad_origen` AS `localidad_origen`,`transportes`.`CARGA_Y_ENTREGA`.`cp_origen` AS `cp_origen`,`transportes`.`CARGA_Y_ENTREGA`.`pais_destino` AS `pais_destino`,`transportes`.`CARGA_Y_ENTREGA`.`provincia_destino` AS `provincia_destino`,`transportes`.`CARGA_Y_ENTREGA`.`localidad_destino` AS `localidad_destino`,`transportes`.`CARGA_Y_ENTREGA`.`cp_destino` AS `cp_destino`,`transportes`.`CARGA_Y_ENTREGA`.`fecha_creaccion` AS `fecha_creaccion`,`transportes`.`CARGA_Y_ENTREGA`.`dimension_l` * `transportes`.`CARGA_Y_ENTREGA`.`dimension_a` * `transportes`.`CARGA_Y_ENTREGA`.`dimension_h` * `transportes`.`CARGA_Y_ENTREGA`.`cantidad_bultos` / 1000000 AS `metroscubicos` from `transportes`.`CARGA_Y_ENTREGA` order by `transportes`.`CARGA_Y_ENTREGA`.`pais_origen`;

-- -----------------------------------------------------
-- View `transportes`.`CargasPorOrigen`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`CargasPorOrigen`;
DROP VIEW IF EXISTS `transportes`.`CargasPorOrigen` ;
USE `transportes`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`usuarioTransport`@`%` SQL SECURITY DEFINER VIEW `transportes`.`CargasPorOrigen` AS select `transportes`.`CARGA_Y_ENTREGA`.`cod_carga` AS `cod_carga`,`transportes`.`CARGA_Y_ENTREGA`.`peso_unitario` * `transportes`.`CARGA_Y_ENTREGA`.`cantidad_bultos` AS `peso_total`,`transportes`.`CARGA_Y_ENTREGA`.`pais_origen` AS `pais_origen`,`transportes`.`CARGA_Y_ENTREGA`.`provincia_origen` AS `provincia_origen`,`transportes`.`CARGA_Y_ENTREGA`.`localidad_origen` AS `localidad_origen`,`transportes`.`CARGA_Y_ENTREGA`.`cp_origen` AS `cp_origen`,`transportes`.`CARGA_Y_ENTREGA`.`pais_destino` AS `pais_destino`,`transportes`.`CARGA_Y_ENTREGA`.`provincia_destino` AS `provincia_destino`,`transportes`.`CARGA_Y_ENTREGA`.`localidad_destino` AS `localidad_destino`,`transportes`.`CARGA_Y_ENTREGA`.`cp_destino` AS `cp_destino`,`transportes`.`CARGA_Y_ENTREGA`.`fecha_creaccion` AS `fecha_creaccion`,`transportes`.`CARGA_Y_ENTREGA`.`dimension_l` * `transportes`.`CARGA_Y_ENTREGA`.`dimension_a` * `transportes`.`CARGA_Y_ENTREGA`.`dimension_h` * `transportes`.`CARGA_Y_ENTREGA`.`cantidad_bultos` / 1000000 AS `metroscubicos` from `transportes`.`CARGA_Y_ENTREGA` order by `transportes`.`CARGA_Y_ENTREGA`.`pais_origen`;

-- -----------------------------------------------------
-- View `transportes`.`PedidosParaTab`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`PedidosParaTab`;
DROP VIEW IF EXISTS `transportes`.`PedidosParaTab` ;
USE `transportes`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`usuarioTransport`@`%` SQL SECURITY DEFINER VIEW `transportes`.`PedidosParaTab` AS select `transportes`.`CARGA_Y_ENTREGA`.`peso_unitario` AS `peso_unitario`,`transportes`.`CARGA_Y_ENTREGA`.`carga_completa_o_grupaje` AS `carga_completa_o_grupaje`,`transportes`.`CARGA_Y_ENTREGA`.`cod_carga` AS `cod_carga`,`transportes`.`CARGA_Y_ENTREGA`.`cantidad_bultos` AS `cantidad_bultos`,`transportes`.`CARGA_Y_ENTREGA`.`dimension_l` AS `dimension_l`,`transportes`.`CARGA_Y_ENTREGA`.`dimension_h` AS `dimension_h`,`transportes`.`CARGA_Y_ENTREGA`.`dimension_a` AS `dimension_a`,`transportes`.`CARGA_Y_ENTREGA`.`pais_origen` AS `pais_origen`,`transportes`.`CARGA_Y_ENTREGA`.`pais_destino` AS `pais_destino`,`transportes`.`CARGA_Y_ENTREGA`.`provincia_origen` AS `provincia_origen`,`transportes`.`CARGA_Y_ENTREGA`.`provincia_destino` AS `provincia_destino`,`transportes`.`CARGA_Y_ENTREGA`.`ya_reservado` AS `ya_reservado`,`transportes`.`CARGA_Y_ENTREGA`.`fecha_creaccion` AS `fecha_creaccion`,`transportes`.`CARGA_Y_ENTREGA`.`tipo_bulto` AS `tipo_bulto`,`transportes`.`TIPO_DE_BULTO`.`cod_tipo_bulto` AS `codigo_bulto`,`transportes`.`TIPO_DE_BULTO`.`nombre_bulto` AS `nombre_bulto` from (`transportes`.`CARGA_Y_ENTREGA` left join `transportes`.`TIPO_DE_BULTO` on(`transportes`.`CARGA_Y_ENTREGA`.`tipo_bulto` = `transportes`.`TIPO_DE_BULTO`.`cod_tipo_bulto`)) where `transportes`.`CARGA_Y_ENTREGA`.`ya_reservado` = 0 order by `transportes`.`CARGA_Y_ENTREGA`.`fecha_creaccion`;

-- -----------------------------------------------------
-- View `transportes`.`TiposDeVehiculosYSistemaCarga`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `transportes`.`TiposDeVehiculosYSistemaCarga`;
DROP VIEW IF EXISTS `transportes`.`TiposDeVehiculosYSistemaCarga` ;
USE `transportes`;
CREATE  OR REPLACE ALGORITHM=UNDEFINED DEFINER=`usuarioTransport`@`%` SQL SECURITY DEFINER VIEW `transportes`.`TiposDeVehiculosYSistemaCarga` AS select `transportes`.`TIPO_DE_VEHICULO`.`cod_tipo_vehiculo` AS `cod_tipo_vehiculo`,`transportes`.`TIPO_DE_VEHICULO`.`SISTEMAEDCARGAVEHICULO_cod_sistem_carga` AS `SISTEMAEDCARGAVEHICULO_cod_sistem_carga`,`transportes`.`TIPO_DE_VEHICULO`.`estipulacion` AS `estipulacion`,`transportes`.`TIPO_DE_VEHICULO`.`instrucciones` AS `instrucciones`,`transportes`.`TIPO_DE_VEHICULO`.`foto` AS `foto`,`transportes`.`TIPO_DE_VEHICULO`.`tiene_rampa` AS `tiene_rampa`,`transportes`.`TIPO_DE_VEHICULO`.`puede_adr` AS `puede_adr`,`transportes`.`TIPO_DE_VEHICULO`.`puede_atp` AS `puede_atp`,`transportes`.`SISTEMA_DE_CARGA_DE_VEHICULO`.`cod_sistema_carga` AS `cod_sistema_carga`,`transportes`.`SISTEMA_DE_CARGA_DE_VEHICULO`.`descripcion` AS `descripcion` from (`transportes`.`TIPO_DE_VEHICULO` left join `transportes`.`SISTEMA_DE_CARGA_DE_VEHICULO` on(`transportes`.`TIPO_DE_VEHICULO`.`SISTEMAEDCARGAVEHICULO_cod_sistem_carga` = `transportes`.`SISTEMA_DE_CARGA_DE_VEHICULO`.`cod_sistema_carga`));
USE `transportes`;

DELIMITER $$

USE `transportes`$$
DROP TRIGGER IF EXISTS `transportes`.`after_empresa_insert` $$
USE `transportes`$$
CREATE
DEFINER=`usuarioTransport`@`%`
TRIGGER `transportes`.`after_empresa_insert`
AFTER INSERT ON `transportes`.`EMPRESAS`
FOR EACH ROW
BEGIN   
    INSERT INTO LOGINS (user, rol, pass)
    VALUES (NEW.cif, 'gerente', NEW.nombre);
END$$


USE `transportes`$$
DROP TRIGGER IF EXISTS `transportes`.`after_conductor_insert` $$
USE `transportes`$$
CREATE
DEFINER=`usuarioTransport`@`%`
TRIGGER `transportes`.`after_conductor_insert`
AFTER INSERT ON `transportes`.`CONDUCTOR`
FOR EACH ROW
BEGIN
    INSERT INTO LOGINS (user, pass, rol)
    VALUES (NEW.dni, NEW.nombre , 'conductor');
END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
