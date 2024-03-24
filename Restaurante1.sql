-- Tabela Pedido
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `idPedido` INT NOT NULL AUTO_INCREMENT,
  `Inicio` DATETIME NULL,
  `Segundos` INT NULL,
  `Fim` DATETIME NULL,
  PRIMARY KEY (`idPedido`)
) ENGINE = InnoDB;

-- Tabela ItemPedido
CREATE TABLE IF NOT EXISTS `mydb`.`ItemPedido` (
  `idItemPedido` INT NOT NULL AUTO_INCREMENT,
  `Pedido_idPedido` INT NOT NULL,
  `Tipo` ENUM('Prato', 'Bebida') NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Preco` FLOAT NOT NULL,
  PRIMARY KEY (`idItemPedido`),
  INDEX `fk_ItemPedido_Pedido1_idx` (`Pedido_idPedido` ASC),
  CONSTRAINT `fk_ItemPedido_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;

-- Tabela Atendente
CREATE TABLE IF NOT EXISTS `mydb`.`Atendente` (
  `Matricula` INT(3) NOT NULL,
  `Nome` VARCHAR(45) NOT NULL,
  `Salario` DECIMAL(10, 2) NOT NULL,
  `Telefone` VARCHAR(20) NOT NULL, -- Assumindo que o telefone é uma string
  PRIMARY KEY (`Matricula`)
) ENGINE = InnoDB;

-- Tabela Cliente
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `CPF` VARCHAR(11) NOT NULL,
  `Nome` VARCHAR(100) NOT NULL, -- Aumentei o tamanho do campo nome
  `Endereco` VARCHAR(255) NULL,
  `Mesa_idMesa` INT(2) NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`idCliente`, `Mesa_idMesa`, `Pedido_idPedido`),
  INDEX `fk_Cliente_Mesa1_idx` (`Mesa_idMesa` ASC) VISIBLE,
  INDEX `fk_Cliente_Pedido1_idx` (`Pedido_idPedido` ASC) VISIBLE,
  CONSTRAINT `fk_Cliente_Mesa1`
    FOREIGN KEY (`Mesa_idMesa`)
    REFERENCES `mydb`.`Mesa` (`idMesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cliente_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `mydb`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION
) ENGINE = InnoDB;
