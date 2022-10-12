
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


SET GLOBAL character_set_server = utf8mb4;
SET GLOBAL character_set_database = utf8mb4;
SET GLOBAL collation_server = utf8mb4_general_ci;
SET GLOBAL character_set_client = utf8mb4;
SET GLOBAL character_set_connection = utf8mb4;
SET GLOBAL character_set_results = utf8mb4;

DROP SCHEMA IF EXISTS `clinic` ;


CREATE SCHEMA IF NOT EXISTS `clinic` DEFAULT CHARACTER SET utf8mb4 ;
USE `clinic` ;


DROP TABLE IF EXISTS `clinic`.`event_category` ;

CREATE TABLE IF NOT EXISTS `clinic`.`event_category` (
  `eventCategoryId` INT NOT NULL AUTO_INCREMENT,
  `eventCategoryName` VARCHAR(100) COLLATE utf8mb4_general_ci NOT NULL,
  `eventCategoryDescription` VARCHAR(500) COLLATE utf8mb4_general_ci NULL,
  `eventDuration` INT NOT NULL,
  `createdOn` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedOn` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`eventCategoryId`),
  UNIQUE INDEX `eventCatagoryName_UNIQUE` (`eventCategoryName` ASC) VISIBLE)
ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



DROP TABLE IF EXISTS `clinic`.`event` ;

CREATE TABLE IF NOT EXISTS `clinic`.`event` (
  `eventId` INT NOT NULL AUTO_INCREMENT,
  `bookingName` VARCHAR(100) COLLATE utf8mb4_general_ci NOT NULL,
  `bookingEmail` VARCHAR(255) COLLATE utf8mb4_general_ci NOT NULL,
  `eventStartTime` DATETIME NOT NULL,
  `eventDuration` INT NOT NULL,
  `eventNotes` VARCHAR(500) COLLATE utf8mb4_general_ci NULL,
  `eventCategoryId` INT NOT NULL,
  `createdOn` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedOn` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`eventId`),
  INDEX `fk_event_event-catagory_idx` (`eventCategoryId` ASC) VISIBLE,
  CONSTRAINT `fk_event_event-catagory`
    FOREIGN KEY (`eventCategoryId`)
    REFERENCES `clinic`.`event_category` (`eventCategoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


DROP TABLE IF EXISTS `clinic`.`user` ;

CREATE TABLE IF NOT EXISTS `clinic`.`user` (
  `userId` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email` VARCHAR(50) COLLATE utf8mb4_general_ci NOT NULL,
  `password` VARCHAR(100) COLLATE utf8mb4_general_ci NOT NULL,
  `role` ENUM('ADMIN', 'LECTURER', 'STUDENT') COLLATE utf8mb4_general_ci NOT NULL,
  `createdOn` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedOn` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`userId`))
ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

CREATE UNIQUE INDEX `name_UNIQUE` ON `clinic`.`user` (`name` ASC) VISIBLE;

CREATE UNIQUE INDEX `email_UNIQUE` ON `clinic`.`user` (`email` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `clinic`.`event_category_has_user`
-- -----------------------------------------------------DROP TABLE IF EXISTS `clinic`.`event_category_has_user` ;
DROP TABLE IF EXISTS `clinic`.`event_category_has_user` ;
CREATE TABLE IF NOT EXISTS `clinic`.`event_category_has_user` (
  `eventCategoryId` INT NOT NULL,
  `userId` INT NOT NULL,
  PRIMARY KEY (`eventCategoryId`, `userId`),
  INDEX `fk_event_category_has_user_user1_idx` (`userId` ASC) VISIBLE,
  INDEX `fk_event_category_has_user_event_category1_idx` (`eventCategoryId` ASC) VISIBLE,
  CONSTRAINT `fk_event_category_has_user_event_category1`
    FOREIGN KEY (`eventCategoryId`)
    REFERENCES `clinic`.`event_category` (`eventCategoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_event_category_has_user_user1`
    FOREIGN KEY (`userId`)
    REFERENCES `clinic`.`user` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `user` (`userId`, `name`, `email`, `password`, `role`) VALUES
(1,'OASIP ADMIN','oasip.admin@kmutt.ac.th','$argon2id$v=19$m=4096,t=3,p=1$/Zr119a3b++ddZI1BBOKtQ$7EpYrNP3k3BaZ1Zx8A8CPpXTzR6Yqg9IRRxkBnuo05Q','ADMIN'),
(2,'Olarn Rojanapornpun','olarn.roj@kmutt.ac.th','$argon2id$v=19$m=4096,t=3,p=1$32OE6yOH+00cX6vgd8Gsuw$QSbkLwH1fA4kO6gH/nxBbGsu/g5ByKEPXISgCEWQvwo','LECTURER'),
(3,'Pichet Limvachiranan','pichet.limv@kmutt.ac.th','$argon2id$v=19$m=4096,t=3,p=1$BDxMEM9uBKdJ+wQhkRcjyQ$pNmWj/K3bAUGZSj5W4SsTYvOy0hmhnO2MUKG2b4lfKU','LECTURER'),
(4,'Umaporn Supasitthimethee','umaporn.sup@kmutt.ac.th','$argon2id$v=19$m=4096,t=3,p=1$gop3+cxi9jvPpQ+Vldiw3g$LSvqM4O9OUorEuHIwQKLrFBQ4rReqLYZMnCjKto1uc4','LECTURER'),
(5,'Siam Yamsaengsung','siam.yam@kmutt.ac.th','$argon2id$v=19$m=4096,t=3,p=1$WE0zq8ky55f613WBJg+Qbg$EZo6ionM4IQ0DKnmV63harTXlL8v6rbB4+ci09ouN8c','LECTURER'),
(6,'Sunisa Sathapornvajana','sunisa.sat@kmutt.ac.th','$argon2id$v=19$m=4096,t=3,p=1$t1BIIAAwxTLB8D6/2uzBpA$7ekSXwL5fGqiy7OYiKZ54ISOH+FgXyJafvxLo+BrYyo','LECTURER'),
(7,'Somchai Jaidee','somchai.jai@kmutt.ac.th','$argon2id$v=19$m=4096,t=3,p=1$haAyDm8SRS8tntCuNS+IPg$YBxume1YCkQXFhtOUqxel2hDI/HmysbNWCT1uQe4akQ','STUDENT'),
(8,'Komkrid Rakdee','komkrid.rak@mail.kmutt.ac.th','$argon2id$v=19$m=4096,t=3,p=1$N6tSpTC+BTmXmb7JoML1PQ$ROGpoUAZSALBU062csLzNdeoJNoBAWI+5FuHOJDwxbo','STUDENT'),
(9,'สมเกียรติ ขยันเรียน','somkiat.kay@kmutt.ac.th','$argon2id$v=19$m=4096,t=3,p=1$7minHCP3LfqmBnI8e6VCyg$i1CqAWv5xpe+4fAAFTeSLXHbwX75/Sd/iEWyE0fXoTA','STUDENT');

INSERT INTO `event_category` (`eventCategoryId`, `eventCategoryName`, `eventCategoryDescription`, `eventDuration`) VALUES
(1,'Project Management Clinic','ตารางนัดหมายนี้ใช้สำหรับนัดหมาย project management clinic ในวิชา INT221 integrated project I ให้นักศึกษาเตรียมเอกสารที่เกี่ยวข้องเพื่อแสดงระหว่างขอคําปรึกษา',30),
(2,'DevOps/Infra Clinic','Use this event category for DevOps/Infra clinic.',20),
(3,'Database Clinic','ตารางนัดหมายนี้ใช้สําหรับนัดหมาย database clinic ในวิชา INT221 integrated project I',15),
(4,'Client-side Clinic','ตารางนัดหมายนี้ใช้สําหรับนัดหมาย client-side clinic ในวิชา INT221 integrated project I',30),
(5,'Server-side Clinic',NULL,30);

INSERT INTO `event` (`eventId`, `bookingName`, `bookingEmail`, `eventStartTime`, `eventDuration`, `eventNotes`, `eventCategoryId`) VALUES
(1, 'Somchai Jaidee(OR-7)', 'somchai.jai@mail.kmutt.ac.th', '2022-05-23 06:30:00', 30, NULL, 2),
(2, 'SomsriRakdee(SJ-3)', 'somsri.rak@mail.kmutt.ac.th', '2022-05-27 02:30:00', 30, 'ขอปรึกษาปัญหาเพื่อนไม่ช่วยงาน', 1),
(3, 'สมเกียรติ ขยันเรียน กลุ่ม TT-4', 'somkiat.kay@kmutt.ac.th', '2022-05-23 09:30:00', 15, NULL, 3);

INSERT INTO `event_category_has_user` (`eventCategoryId`, `userId`) VALUES
(1,2),
(2,2),
(5,2),
(5,3),
(4,4),
(2,5),
(3,6);


create user 'root'@'%' identified by '%kBLfS@XZfQ_@p7JHq*+X+bCdvdSw^' ;
grant all privileges on *.* to 'root'@'%' ;
flush privileges;