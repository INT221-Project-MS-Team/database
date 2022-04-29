
SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';


DROP SCHEMA IF EXISTS `clinic` ;


CREATE SCHEMA IF NOT EXISTS `clinic` DEFAULT CHARACTER SET utf8 ;
USE `clinic` ;


DROP TABLE IF EXISTS `clinic`.`event_category` ;

CREATE TABLE IF NOT EXISTS `clinic`.`event_category` (
  `eventCategoryId` INT NOT NULL,
  `eventCategoryName` VARCHAR(100) NOT NULL,
  `eventCategoryDescription` VARCHAR(500) NULL,
  `eventDuration` INT NOT NULL,
  PRIMARY KEY (`eventCategoryId`),
  UNIQUE INDEX `eventCatagoryName_UNIQUE` (`eventCategoryName` ASC) VISIBLE)
ENGINE = InnoDB;



DROP TABLE IF EXISTS `clinic`.`event` ;

CREATE TABLE IF NOT EXISTS `clinic`.`event` (
  `eventId` INT NOT NULL,
  `bookingName` VARCHAR(100) NOT NULL,
  `bookingEmail` VARCHAR(255) NOT NULL,
  `eventStartTime` DATETIME NOT NULL,
  `eventDuration` INT NOT NULL,
  `eventNotes` VARCHAR(500) NULL,
  `eventCategoryId` INT NOT NULL,
  PRIMARY KEY (`eventId`),
  INDEX `fk_event_event-catagory_idx` (`eventCategoryId` ASC) VISIBLE,
  CONSTRAINT `fk_event_event-catagory`
    FOREIGN KEY (`eventCategoryId`)
    REFERENCES `clinic`.`event_category` (`eventCategoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

insert into event_category (eventCategoryId,eventCategoryName,eventCategoryDescription,eventDuration)
values (1,'Project Management Clinic','ตารางนัดหมายนี้ใช้สำหรับนัดหมาย project management clinic ในวิชา INT221 integrated project I ให้นักศึกษาเตรียมเอกสารที่เกี่ยวข้องเพื่อแสดงระหว่างขอคําปรึกษา',30);
insert into event_category (eventCategoryId,eventCategoryName,eventCategoryDescription,eventDuration)
values (2,'DevOps/Infra Clinic','Use this event category for DevOps/Infra clinic.',20);
insert into event_category (eventCategoryId,eventCategoryName,eventCategoryDescription,eventDuration)
values (3,'Database Clinic','ตารางนัดหมายนี้ใช้สําหรับนัดหมาย database clinic ในวิชา INT221 integrated project I',15);
insert into event_category (eventCategoryId,eventCategoryName,eventCategoryDescription,eventDuration)
values (4,'Client-side Clinic','ตารางนัดหมายนี้ใช้สําหรับนัดหมาย client-side clinic ในวิชา INT221 integrated project I',30);
insert into event_category (eventCategoryId,eventCategoryName,eventDuration)
values (5,'Server-side Clinic',30);


insert into event (eventId,bookingName,bookingEmail,eventStartTime,eventDuration,eventCategoryId)
values (1,'Somchai Jaidee(OR-7)','somchai.jai@mail.kmutt.ac.th','2022-05-23 13:30:00',30,2);
insert into event (eventId,bookingName,bookingEmail,eventStartTime,eventDuration,eventNotes,eventCategoryId)
values (2,'SomsriRakdee(SJ-3)','somsri.rak@mail.kmutt.ac.th','2022-05-27 9:30:00',30,'ขอปรึกษาปัญหาเพื่อนไม่ช่วยงาน',1);
insert into event (eventId,bookingName,bookingEmail,eventStartTime,eventDuration,eventCategoryId)
values (3,'สมเกียรติ ขยันเรียน กลุ่ม TT-4','somkiat.kay@kmutt.ac.th','2022-05-23 16:30:00',15,3);
insert into event (eventId,bookingName,bookingEmail,eventStartTime,eventDuration,eventCategoryId)
values (4,'หิวข้าวงับ','eiei.za@kmutt.ac.th','2022-05-29 8:30:00',15,1);
insert into event (eventId,bookingName,bookingEmail,eventStartTime,eventDuration,eventCategoryId)
values (5,'test','test.test@kmutt.ac.th','2022-05-30 01:30:00',20,2);
