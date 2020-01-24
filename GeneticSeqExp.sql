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
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Gene`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Gene` (
  `idGene` INT NOT NULL,
  `GeneName` VARCHAR(45) NULL,
  `Chromosome` VARCHAR(2) NULL,
  `GeneDescription` VARCHAR(45) NULL,
  PRIMARY KEY (`idGene`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Syndrome`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Syndrome` (
  `idSyndrome` INT NOT NULL,
  `SyndromeName` VARCHAR(20) NULL,
  `SyndromeDescription` VARCHAR(150) NULL,
  `LinkedGene` INT NULL,
  PRIMARY KEY (`idSyndrome`),
  INDEX `fk_Syndrome_Gene1_idx` (`LinkedGene` ASC) VISIBLE,
  CONSTRAINT `fk_Syndrome_Gene1`
    FOREIGN KEY (`LinkedGene`)
    REFERENCES `mydb`.`Gene` (`idGene`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Patient`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Patient` (
  `idPatient` INT NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Gender` ENUM('M', 'F', 'X') NOT NULL,
  `Syndrome_id` INT NULL,
  `AgeAtDiagnosis` INT NOT NULL,
  PRIMARY KEY (`idPatient`),
  INDEX `fk_patient_syndrome_idx` (`Syndrome_id` ASC) VISIBLE,
  CONSTRAINT `fk_patient_syndrome`
    FOREIGN KEY (`Syndrome_id`)
    REFERENCES `mydb`.`Syndrome` (`idSyndrome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mutation`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mutation` (
  `idMutation` INT NOT NULL,
  `start_position` INT NOT NULL,
  `end_position` INT NOT NULL,
  `Syndrome_id` INT NULL,
  `Gene_id` INT NULL,
  `Patient_id` INT NOT NULL,
  PRIMARY KEY (`idMutation`),
  INDEX `fk_Mutation_Patient1_idx` (`Patient_id` ASC) VISIBLE,
  INDEX `fk_Mutation_Syndrome_idx` (`Syndrome_id` ASC) VISIBLE,
  INDEX `fk_Mutation_Gene_idx` (`Gene_id` ASC) VISIBLE,
  CONSTRAINT `fk_Mutation_Patient`
    FOREIGN KEY (`Patient_id`)
    REFERENCES `mydb`.`Patient` (`idPatient`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mutation_Syndrome`
    FOREIGN KEY (`Syndrome_id`)
    REFERENCES `mydb`.`Syndrome` (`idSyndrome`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Mutation_Gene`
    FOREIGN KEY (`Gene_id`)
    REFERENCES `mydb`.`Gene` (`idGene`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
