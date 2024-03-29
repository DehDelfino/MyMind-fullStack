-- MySQL Script generated by MySQL Workbench
-- Sun May  8 11:11:52 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema mymind
-- -----------------------------------------------------
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`telefone` (
  `id_telefone` VARCHAR(45) NOT NULL,
  `telefone_paciente` VARCHAR(14) NOT NULL,
  PRIMARY KEY (`id_telefone`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`paciente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`paciente` (
  `idPaciente` INT NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `sobrenome` VARCHAR(100) NOT NULL,
  `dataNascimento` DATE NOT NULL,
  `email` VARCHAR(95) NOT NULL,
  `genero` VARCHAR(10) NOT NULL,
  `cpf` VARCHAR(15) NOT NULL,
  `usuario` VARCHAR(10) NOT NULL,
  `senha` VARCHAR(40) NOT NULL,
  `resposta` VARCHAR(20) NOT NULL,
  `tempoDeAcompanhamento` VARCHAR(45) NOT NULL,
  `telefone_id_telefone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPaciente`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  UNIQUE INDEX `usuario_UNIQUE` (`usuario` ASC) VISIBLE,
  CONSTRAINT `fk_paciente_telefone1`
    FOREIGN KEY (`telefone_id_telefone`)
    REFERENCES `mydb`.`telefone` (`id_telefone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`psicologo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`psicologo` (
  `idpsicologo` INT NULL,
  `nome` VARCHAR(100) NOT NULL,
  `sobrenome` VARCHAR(100) NOT NULL,
  `dataNascimento` VARCHAR(10) NOT NULL,
  `email` VARCHAR(256) NOT NULL,
  `genero` VARCHAR(12) NOT NULL,
  `cpf` VARCHAR(11) NOT NULL,
  `usuario` VARCHAR(25) NOT NULL,
  `senha` VARCHAR(40) NOT NULL,
  `resposta` TINYINT NOT NULL,
  `crp` VARCHAR(15) NOT NULL,
  `link-epsi` VARCHAR(90) NOT NULL,
  `AnoDeFormacao` INT(4) NOT NULL,
  `telefone_id_telefone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idpsicologo`),
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  CONSTRAINT `fk_psicologo_telefone1`
    FOREIGN KEY (`telefone_id_telefone`)
    REFERENCES `mydb`.`telefone` (`id_telefone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Endereço`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Endereço` (
  `idEndereço` INT NOT NULL,
  `psicologo_idpsicologo` INT NOT NULL,
  `rua` VARCHAR(256) NOT NULL,
  `numero` INT NOT NULL,
  `complemento` VARCHAR(20) NOT NULL,
  `cep` VARCHAR(11) NOT NULL,
  `tipo` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idEndereço`),
  CONSTRAINT `fk_Endereço_psicologo1`
    FOREIGN KEY (`psicologo_idpsicologo`)
    REFERENCES `mydb`.`psicologo` (`idpsicologo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`universidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`universidade` (
  `iduniversidade` INT NOT NULL,
  `nome` VARCHAR(50) NOT NULL,
  `cnpj` VARCHAR(18) NOT NULL,
  `email` VARCHAR(256) NOT NULL,
  `representanteLegal` VARCHAR(50) NOT NULL,
  `Endereço_idEndereço` INT NOT NULL,
  `telefone_paciente_id_telefone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`iduniversidade`),
  UNIQUE INDEX `cnpj_UNIQUE` (`cnpj` ASC) VISIBLE,
  CONSTRAINT `fk_universidade_Endereço1`
    FOREIGN KEY (`Endereço_idEndereço`)
    REFERENCES `mydb`.`Endereço` (`idEndereço`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_universidade_telefone_paciente1`
    FOREIGN KEY (`telefone_paciente_id_telefone`)
    REFERENCES `mydb`.`telefone` (`id_telefone`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`artigo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`artigo` (
  `idartigo` INT NOT NULL,
  `nomeArtigo` VARCHAR(200) NOT NULL,
  `dataPublicacao` DATE NOT NULL,
  `genero` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`idartigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`evento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`evento` (
  `ideventro` INT NULL,
  `nomeEvento` VARCHAR(50) NOT NULL,
  `dataEvento` DATE NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `descricaoEvento` VARCHAR(100) GENERATED ALWAYS AS () VIRTUAL,
  `linkEvento` MEDIUMTEXT NOT NULL,
  `psicologo_idpsicologo` INT NOT NULL,
  PRIMARY KEY (`ideventro`),
  CONSTRAINT `fk_evento_psicologo1`
    FOREIGN KEY (`psicologo_idpsicologo`)
    REFERENCES `mydb`.`psicologo` (`idpsicologo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`publicacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`publicacao` (
  `idpublicacao` INT NOT NULL,
  `texto` CHAR NOT NULL,
  `imagem` MEDIUMBLOB NOT NULL,
  `likes` INT NOT NULL,
  `psicologo_idpsicologo` INT NOT NULL,
  PRIMARY KEY (`idpublicacao`),
  CONSTRAINT `fk_publicacao_psicologo1`
    FOREIGN KEY (`psicologo_idpsicologo`)
    REFERENCES `mydb`.`psicologo` (`idpsicologo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`artigo_has_universidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`artigo_has_universidade` (
  `artigo_idartigo` INT NOT NULL,
  `universidade_iduniversidade` INT NOT NULL,
  PRIMARY KEY (`artigo_idartigo`, `universidade_iduniversidade`),
  CONSTRAINT `fk_artigo_has_universidade_artigo1`
    FOREIGN KEY (`artigo_idartigo`)
    REFERENCES `mydb`.`artigo` (`idartigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_artigo_has_universidade_universidade1`
    FOREIGN KEY (`universidade_iduniversidade`)
    REFERENCES `mydb`.`universidade` (`iduniversidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
