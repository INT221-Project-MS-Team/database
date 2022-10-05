
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


DROP TABLE IF EXISTS `clinic`.`user_has_event_category` ;

CREATE TABLE IF NOT EXISTS `clinic`.`user_has_event_category` (
  `userHasEventCategoryId` INT NOT NULL AUTO_INCREMENT,
  `userId` INT NOT NULL,
  `eventCategoryId` INT NOT NULL,
  `createdOn` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `updatedOn` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`userHasEventCategoryId`, `userId`, `eventCategoryId`),
  INDEX `fk_user_has_event_category_event_category1_idx` (`eventCategoryId` ASC) VISIBLE,
  INDEX `fk_user_has_event_category_user1_idx` (`userId` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_event_category_user1`
    FOREIGN KEY (`userId`)
    REFERENCES `clinic`.`user` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_has_event_category_event_category1`
    FOREIGN KEY (`eventCategoryId`)
    REFERENCES `clinic`.`event_category` (`eventCategoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `user` (`userId`, `name`, `email`, `password`, `role`) VALUES
(1,'OASIP ADMIN','oasip.admin@kmutt.ac.th', '$argon2id$v=19$m=4096,t=3,p=1$qzPNwlVKGLEi0sW8+91THw$4LWq4qOLZKZR3E5eLTIVMVLojgIN8Gveqlbo0jVi6QE', 'ADMIN'),
(2,'Somchai Jaidee','somchai.jai@kmutt.ac.th', '$argon2id$v=19$m=4096,t=3,p=1$/Qyhp40vwOKDD0GfcGMxUg$XP4JQkHXP8VNx6UBA51EfNBV7AoU/QCi1toZLuPPXrs', 'LECTURER'),
(3,'Komkrid Rakdee','komkrid.rak@mail.kmutt.ac.th', '$argon2id$v=19$m=4096,t=3,p=1$uHVIqes1FEASJfuVh/7OWw$AB6Ub+PNwTe46LOvnIoOW0UAXohjvo7FLy/So7BO8uE', 'STUDENT'),
(4,'สมเกียรติ ขยันเรียน','somkiat.kay@kmutt.ac.th', '$argon2id$v=19$m=4096,t=3,p=1$Pb8JElWpILgqaQyh1MLlSg$bUP1VQ5qI7v6qIqqO2Le6zuV/m4Rr54rKiDk3ge9AKU', 'STUDENT'),
(5,'Somsuk','somsuk@kmutt.ac.th', '$argon2id$v=19$m=4096,t=3,p=1$/Qyhp40vwOKDD0GfcGMxUg$XP4JQkHXP8VNx6UBA51EfNBV7AoU/QCi1toZLuPPXrs', 'LECTURER'),
(6,'Somying','somying@kmutt.ac.th', '$argon2id$v=19$m=4096,t=3,p=1$/Qyhp40vwOKDD0GfcGMxUg$XP4JQkHXP8VNx6UBA51EfNBV7AoU/QCi1toZLuPPXrs', 'LECTURER');


INSERT INTO `event_category` (`eventCategoryId`, `eventCategoryName`, `eventCategoryDescription`, `eventDuration`) VALUES
(1, 'Project Management Clinic', 'ตารางนัดหมายนี้ใช้สำหรับนัดหมาย project management clinic ในวิชา INT221 integrated project I ให้นักศึกษาเตรียมเอกสารที่เกี่ยวข้องเพื่อแสดงระหว่างขอคําปรึกษา', 30),
(2, 'DevOps/Infra Clinic', 'Use this event category for DevOps/Infra clinic.', 20),
(3, 'Database Clinic', 'ตารางนัดหมายนี้ใช้สําหรับนัดหมาย database clinic ในวิชา INT221 integrated project I', 15),
(4, 'Client-side Clinic', 'ตารางนัดหมายนี้ใช้สําหรับนัดหมาย client-side clinic ในวิชา INT221 integrated project I', 30),
(5, 'Server-side Clinic', NULL, 30);

INSERT INTO `event` (`eventId`, `bookingName`, `bookingEmail`, `eventStartTime`, `eventDuration`, `eventNotes`, `eventCategoryId`) VALUES
(1, 'Somchai Jaidee(OR-7)', 'somchai.jai@mail.kmutt.ac.th', '2022-05-23 06:30:00', 30, NULL, 2),
(2, 'SomsriRakdee(SJ-3)', 'somsri.rak@mail.kmutt.ac.th', '2022-05-27 02:30:00', 30, 'ขอปรึกษาปัญหาเพื่อนไม่ช่วยงาน', 1),
(3, 'สมเกียรติ ขยันเรียน กลุ่ม TT-4', 'somkiat.kay@kmutt.ac.th', '2022-05-23 09:30:00', 15, NULL, 3);

INSERT INTO `user_has_event_category` (`userHasEventCategoryId`, `userId`, `eventCategoryId`) VALUES
(1, 1, 2),
(2, 1, 5),
(3, 2, 5),
(4, 3, 2);

create user 'root'@'%' identified by '%kBLfS@XZfQ_@p7JHq*+X+bCdvdSw^' ;
grant all privileges on *.* to 'root'@'%' ;
flush privileges;