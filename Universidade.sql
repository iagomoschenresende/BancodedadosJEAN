-- MySQL Script generated by MySQL Workbench
-- Sun Mar 24 10:41:55 2024
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
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Professor` (
  `Matricula` INT(4) NOT NULL,
  `email` VARCHAR(255) UNIQUE NOT NULL,
  PRIMARY KEY (`Matricula`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Curso` (
  `idCurso` INT NOT NULL,
  `Codigo` VARCHAR(10) NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Carga_Horaria` INT CHECK (Carga_Horaria <= 3600) DEFAULT 3600,
  `Professor_Matricula` INT(4) NOT NULL,
  `Coordenador` VARCHAR(45) NULL,
  PRIMARY KEY (`idCurso`, `Professor_Matricula`),
  INDEX `fk_Curso_Professor1_idx` (`Professor_Matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Curso_Professor1`
    FOREIGN KEY (`Professor_Matricula`)
    REFERENCES `mydb`.`Professor` (`Matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Matérias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Matérias` (
  `idMatérias` INT NOT NULL,
  `Codigo` VARCHAR(10) NOT NULL,
  `Nome` VARCHAR(45) NULL,
  `Carga_Horaria` INT CHECK (Carga_Horaria >= 40) DEFAULT 40,
  PRIMARY KEY (`idMatérias`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Curso_has_Matérias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Curso_has_Matérias` (
  `Curso_idCurso` INT NOT NULL,
  `Matérias_idMatérias` INT NOT NULL,
  PRIMARY KEY (`Curso_idCurso`, `Matérias_idMatérias`),
  INDEX `fk_Curso_has_Matérias_Matérias1_idx` (`Matérias_idMatérias` ASC) VISIBLE,
  INDEX `fk_Curso_has_Matérias_Curso_idx` (`Curso_idCurso` ASC) VISIBLE,
  CONSTRAINT `fk_Curso_has_Matérias_Curso`
    FOREIGN KEY (`Curso_idCurso`)
    REFERENCES `mydb`.`Curso` (`idCurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Curso_has_Matérias_Matérias1`
    FOREIGN KEY (`Matérias_idMatérias`)
    REFERENCES `mydb`.`Matérias` (`idMatérias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Alunos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Alunos` (
  `Matricula` INT NOT NULL,
  `Curso_idCurso` INT NULL,
  PRIMARY KEY (`Matricula`),
  INDEX `fk_Alunos_Curso1_idx` (`Curso_idCurso` ASC) VISIBLE,
  CONSTRAINT `fk_Alunos_Curso1`
    FOREIGN KEY (`Curso_idCurso`)
    REFERENCES `mydb`.`Curso` (`idCurso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Disciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Disciplina` (
  `idDisciplina` INT NOT NULL,
  `Vagas` INT CHECK (Vagas <= 60) DEFAULT 60,
  `Semestre` INT NOT NULL,
  `Matérias_idMatérias` INT NOT NULL,
  `Professor_Matricula` INT(4) NOT NULL,
  PRIMARY KEY (`idDisciplina`),
  INDEX `fk_Disciplina_Matérias1_idx` (`Matérias_idMatérias` ASC) VISIBLE,
  INDEX `fk_Disciplina_Professor1_idx` (`Professor_Matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Disciplina_Matérias1`
    FOREIGN KEY (`Matérias_idMatérias`)
    REFERENCES `mydb`.`Matérias` (`idMatérias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Disciplina_Professor1`
    FOREIGN KEY (`Professor_Matricula`)
    REFERENCES `mydb`.`Professor` (`Matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Email` (
  `email` VARCHAR(255) NOT NULL,
  `Alunos_Matricula` INT NULL,
  PRIMARY KEY (`email`),
  INDEX `fk_Email_Alunos1_idx` (`Alunos_Matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Email_Alunos1`
    FOREIGN KEY (`Alunos_Matricula`)
    REFERENCES `mydb`.`Alunos` (`Matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;