
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
  `eventCategoryId` INT NOT NULL,
  `eventCategoryName` VARCHAR(100) COLLATE utf8mb4_general_ci NOT NULL,
  `eventCategoryDescription` VARCHAR(500) COLLATE utf8mb4_general_ci NULL,
  `eventDuration` INT NOT NULL,
  PRIMARY KEY (`eventCategoryId`),
  UNIQUE INDEX `eventCatagoryName_UNIQUE` (`eventCategoryName` ASC) VISIBLE)
ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;



DROP TABLE IF EXISTS `clinic`.`event` ;

CREATE TABLE IF NOT EXISTS `clinic`.`event` (
  `eventId` INT NOT NULL,
  `bookingName` VARCHAR(100) COLLATE utf8mb4_general_ci NOT NULL,
  `bookingEmail` VARCHAR(255) COLLATE utf8mb4_general_ci NOT NULL,
  `eventStartTime` DATETIME NOT NULL,
  `eventDuration` INT NOT NULL,
  `eventNotes` VARCHAR(500) COLLATE utf8mb4_general_ci NULL,
  `eventCategoryId` INT NOT NULL,
  PRIMARY KEY (`eventId`),
  INDEX `fk_event_event-catagory_idx` (`eventCategoryId` ASC) VISIBLE,
  CONSTRAINT `fk_event_event-catagory`
    FOREIGN KEY (`eventCategoryId`)
    REFERENCES `clinic`.`event_category` (`eventCategoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

INSERT INTO `event_category` (`eventCategoryId`, `eventCategoryName`, `eventCategoryDescription`, `eventDuration`) VALUES
(1, 'Project Management Clinic', 'ตารางนัดหมายนี้ใช้สำหรับนัดหมาย project management clinic ในวิชา INT221 integrated project I ให้นักศึกษาเตรียมเอกสารที่เกี่ยวข้องเพื่อแสดงระหว่างขอคําปรึกษา', 30),
(2, 'DevOps/Infra Clinic', 'Use this event category for DevOps/Infra clinic.', 20),
(3, 'Database Clinic', 'ตารางนัดหมายนี้ใช้สําหรับนัดหมาย database clinic ในวิชา INT221 integrated project I', 15),
(4, 'Client-side Clinic', 'ตารางนัดหมายนี้ใช้สําหรับนัดหมาย client-side clinic ในวิชา INT221 integrated project I', 30),
(5, 'Server-side Clinic', NULL, 30);

INSERT INTO `event` (`eventId`, `bookingName`, `bookingEmail`, `eventStartTime`, `eventDuration`, `eventNotes`, `eventCategoryId`) VALUES
(1, 'Somchai Jaidee(OR-7)', 'somchai.jai@mail.kmutt.ac.th', '2022-05-23 13:30:00', 30, NULL, 2),
(2, 'SomsriRakdee(SJ-3)', 'somsri.rak@mail.kmutt.ac.th', '2022-05-27 09:30:00', 30, 'ขอปรึกษาปัญหาเพื่อนไม่ช่วยงาน', 1),
(3, 'สมเกียรติ ขยันเรียน กลุ่ม TT-4', 'somkiat.kay@kmutt.ac.th', '2022-05-23 16:30:00', 15, NULL, 3),
(4, 'หิวข้าวงับ', 'eiei.za@kmutt.ac.th', '2022-05-29 08:30:00', 15, NULL, 1),
(5, 'test', 'test.test@kmutt.ac.th', '2022-05-30 01:30:00', 20, NULL, 2),
(6, 'อิอิ haha', 'test.test@kmutt.ac.th', '2022-04-19 04:30:00', 20, 'Hello World', 2),
(7, 'Peter Parker', 'peter.parker@kmutt.ac.th', '2022-01-19 04:30:00', 20, 'NONONO', 2),
(8, 'อิอิ haha', 'test.test@kmutt.ac.th', '2022-03-22 05:43:00', 20, NULL, 5);

create user 'root'@'%' identified by '%kBLfS@XZfQ_@p7JHq*+X+bCdvdSw^' ;
grant all privileges on *.* to 'root'@'%' ;
flush privileges;