-- MySQL Script generated by MySQL Workbench
-- Tue Dec 13 13:51:50 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_guarda
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_guarda
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_guarda` DEFAULT CHARACTER SET utf8 ;
USE `db_guarda` ;

-- -----------------------------------------------------
-- Table `db_guarda`.`guarda`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_guarda`.`guarda` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(16) NOT NULL,
  `email` VARCHAR(150) NOT NULL,
  `activated` TINYINT NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_guarda`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_guarda`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(16) NOT NULL,
  `password` VARCHAR(150) NOT NULL,
  `activated` TINYINT NOT NULL,
  `guarda_id` INT NOT NULL,
  `tipoUser` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_guarda1_idx` (`guarda_id` ASC),
  CONSTRAINT `fk_user_guarda1`
    FOREIGN KEY (`guarda_id`)
    REFERENCES `db_guarda`.`guarda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_guarda`.`ocorrencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_guarda`.`ocorrencia` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `dataHora` VARCHAR(50) NOT NULL,
  `boletimAtendimento` VARCHAR(250) NOT NULL,
  `boletimOcorrencia` VARCHAR(250) NOT NULL,
  `endereco` VARCHAR(150) NOT NULL,
  `local` VARCHAR(45) NOT NULL,
  `fatos` VARCHAR(45) NOT NULL,
  `orientacaoGuarda` VARCHAR(45) NOT NULL,
  `arquivado` INT NOT NULL,
  `qrcode` LONGTEXT NULL,
  `guarda_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_ocorrencia_guarda1_idx` (`guarda_id` ASC),
  CONSTRAINT `fk_ocorrencia_guarda1`
    FOREIGN KEY (`guarda_id`)
    REFERENCES `db_guarda`.`guarda` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_guarda`.`imagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_guarda`.`imagem` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `ocorrencia_id` INT NOT NULL,
  `nomeImg` TEXT NOT NULL,
  `base64img` LONGTEXT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_imagem_ocorrencia1_idx` (`ocorrencia_id` ASC),
  CONSTRAINT `fk_imagem_ocorrencia1`
    FOREIGN KEY (`ocorrencia_id`)
    REFERENCES `db_guarda`.`ocorrencia` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
