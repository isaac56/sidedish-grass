-- MySQL Script generated by MySQL Workbench
-- Wed Apr 21 02:54:21 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS = @@UNIQUE_CHECKS, UNIQUE_CHECKS = 0;
SET @OLD_FOREIGN_KEY_CHECKS = @@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS = 0;
SET @OLD_SQL_MODE = @@SQL_MODE, SQL_MODE =
        'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema sidedish
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema sidedish
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `sidedish` DEFAULT CHARACTER SET utf8;
USE `sidedish`;

-- -----------------------------------------------------
-- Table `sidedish`.`provider`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sidedish`.`provider`;

CREATE TABLE IF NOT EXISTS `sidedish`.`provider`
(
    `id`                  BIGINT      NOT NULL AUTO_INCREMENT,
    `name`                VARCHAR(45) NOT NULL,
    `delivery_fee`        INT         NOT NULL,
    `delivery_free_price` INT         NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `name_UNIQUE` (`name` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sidedish`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sidedish`.`product`;

CREATE TABLE IF NOT EXISTS `sidedish`.`product`
(
    `id`             BIGINT       NOT NULL AUTO_INCREMENT,
    `provider_id`    BIGINT       NOT NULL,
    `name`           VARCHAR(45)  NOT NULL,
    `description`    VARCHAR(45)  NOT NULL,
    `price_original` INT          NOT NULL,
    `price_discount` INT          NULL,
    `point`          INT          NOT NULL DEFAULT 0,
    `top_image_url`  VARCHAR(512) NULL,
    `stock`          INT          NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_menu_provider_idx` (`provider_id` ASC),
    CONSTRAINT `fk_menu_provider`
        FOREIGN KEY (`provider_id`)
            REFERENCES `sidedish`.`provider` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sidedish`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sidedish`.`category`;

CREATE TABLE IF NOT EXISTS `sidedish`.`category`
(
    `id`      INT         NOT NULL AUTO_INCREMENT,
    `name`    VARCHAR(45) NOT NULL,
    `is_best` TINYINT(1)  NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `name_UNIQUE` (`name` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sidedish`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sidedish`.`user`;

CREATE TABLE IF NOT EXISTS `sidedish`.`user`
(
    `id`       BIGINT      NOT NULL AUTO_INCREMENT,
    `email`    VARCHAR(45) NULL,
    `password` VARCHAR(45) NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sidedish`.`product_image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sidedish`.`product_image`;

CREATE TABLE IF NOT EXISTS `sidedish`.`product_image`
(
    `id`         BIGINT       NOT NULL AUTO_INCREMENT,
    `url`        VARCHAR(512) NOT NULL,
    `product_id` BIGINT       NOT NULL,
    `is_detail`  TINYINT(1)   NOT NULL DEFAULT 0,
    PRIMARY KEY (`id`),
    INDEX `fk_product_image_product1_idx` (`product_id` ASC),
    CONSTRAINT `fk_product_image_product1`
        FOREIGN KEY (`product_id`)
            REFERENCES `sidedish`.`product` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sidedish`.`cart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sidedish`.`cart`;

CREATE TABLE IF NOT EXISTS `sidedish`.`cart`
(
    `id`         BIGINT NOT NULL AUTO_INCREMENT,
    `user_id`    BIGINT NOT NULL,
    `product_id` BIGINT NOT NULL,
    `count`      INT    NOT NULL,
    INDEX `fk_user_has_menu_menu1_idx` (`product_id` ASC),
    INDEX `fk_user_has_menu_user1_idx` (`user_id` ASC),
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_user_has_menu_user1`
        FOREIGN KEY (`user_id`)
            REFERENCES `sidedish`.`user` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION,
    CONSTRAINT `fk_user_has_menu_menu1`
        FOREIGN KEY (`product_id`)
            REFERENCES `sidedish`.`product` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sidedish`.`badge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sidedish`.`badge`;

CREATE TABLE IF NOT EXISTS `sidedish`.`badge`
(
    `id`   INT         NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `name_UNIQUE` (`name` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sidedish`.`product_has_badge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sidedish`.`product_has_badge`;

CREATE TABLE IF NOT EXISTS `sidedish`.`product_has_badge`
(
    `id`         BIGINT NOT NULL AUTO_INCREMENT,
    `product_id` BIGINT NOT NULL,
    `badge_id`   INT    NOT NULL,
    INDEX `fk_product_has_badge_badge1_idx` (`badge_id` ASC),
    INDEX `fk_product_has_badge_product1_idx` (`product_id` ASC),
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_product_has_badge_product1`
        FOREIGN KEY (`product_id`)
            REFERENCES `sidedish`.`product` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_product_has_badge_badge1`
        FOREIGN KEY (`badge_id`)
            REFERENCES `sidedish`.`badge` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sidedish`.`delivery_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sidedish`.`delivery_type`;

CREATE TABLE IF NOT EXISTS `sidedish`.`delivery_type`
(
    `id`   INT         NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(45) NOT NULL,
    PRIMARY KEY (`id`),
    UNIQUE INDEX `name_UNIQUE` (`name` ASC)
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sidedish`.`category_has_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sidedish`.`category_has_product`;

CREATE TABLE IF NOT EXISTS `sidedish`.`category_has_product`
(
    `id`          BIGINT NOT NULL AUTO_INCREMENT,
    `category_id` INT    NOT NULL,
    `product_id`  BIGINT NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_category_has_product_product1_idx` (`product_id` ASC),
    INDEX `fk_category_has_product_category1_idx` (`category_id` ASC),
    CONSTRAINT `fk_category_has_product_category1`
        FOREIGN KEY (`category_id`)
            REFERENCES `sidedish`.`category` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_category_has_product_product1`
        FOREIGN KEY (`product_id`)
            REFERENCES `sidedish`.`product` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sidedish`.`package_has_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sidedish`.`package_has_product`;

CREATE TABLE IF NOT EXISTS `sidedish`.`package_has_product`
(
    `id`         BIGINT NOT NULL AUTO_INCREMENT,
    `package_id` BIGINT NOT NULL,
    `product_id` BIGINT NOT NULL,
    INDEX `fk_product_has_product_product2_idx` (`product_id` ASC),
    INDEX `fk_product_has_product_product1_idx` (`package_id` ASC),
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_product_has_product_product1`
        FOREIGN KEY (`package_id`)
            REFERENCES `sidedish`.`product` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_product_has_product_product2`
        FOREIGN KEY (`product_id`)
            REFERENCES `sidedish`.`product` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sidedish`.`order`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sidedish`.`order`;

CREATE TABLE IF NOT EXISTS `sidedish`.`order`
(
    `id`          BIGINT    NOT NULL AUTO_INCREMENT,
    `user_id`     BIGINT    NOT NULL,
    `create_time` TIMESTAMP NOT NULL,
    PRIMARY KEY (`id`),
    INDEX `fk_order_user1_idx` (`user_id` ASC),
    CONSTRAINT `fk_order_user1`
        FOREIGN KEY (`user_id`)
            REFERENCES `sidedish`.`user` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sidedish`.`order_has_product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sidedish`.`order_has_product`;

CREATE TABLE IF NOT EXISTS `sidedish`.`order_has_product`
(
    `id`         BIGINT NOT NULL AUTO_INCREMENT,
    `order_id`   BIGINT NOT NULL,
    `product_id` BIGINT NOT NULL,
    `count`      INT    NOT NULL,
    INDEX `fk_order_has_product_product1_idx` (`product_id` ASC),
    INDEX `fk_order_has_product_order1_idx` (`order_id` ASC),
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_order_has_product_order1`
        FOREIGN KEY (`order_id`)
            REFERENCES `sidedish`.`order` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_order_has_product_product1`
        FOREIGN KEY (`product_id`)
            REFERENCES `sidedish`.`product` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE
)
    ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `sidedish`.`provider_has_delivery_type`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `sidedish`.`provider_has_delivery_type`;

CREATE TABLE IF NOT EXISTS `sidedish`.`provider_has_delivery_type`
(
    `id`               BIGINT NOT NULL AUTO_INCREMENT,
    `provider_id`      BIGINT NOT NULL,
    `delivery_type_id` INT    NOT NULL,
    INDEX `fk_provider_has_delivery_type_delivery_type1_idx` (`delivery_type_id` ASC),
    INDEX `fk_provider_has_delivery_type_provider1_idx` (`provider_id` ASC),
    PRIMARY KEY (`id`),
    CONSTRAINT `fk_provider_has_delivery_type_provider1`
        FOREIGN KEY (`provider_id`)
            REFERENCES `sidedish`.`provider` (`id`)
            ON DELETE CASCADE
            ON UPDATE CASCADE,
    CONSTRAINT `fk_provider_has_delivery_type_delivery_type1`
        FOREIGN KEY (`delivery_type_id`)
            REFERENCES `sidedish`.`delivery_type` (`id`)
            ON DELETE NO ACTION
            ON UPDATE NO ACTION
)
    ENGINE = InnoDB;


SET SQL_MODE = @OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS = @OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS = @OLD_UNIQUE_CHECKS;
