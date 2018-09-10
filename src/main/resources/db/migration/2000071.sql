# 2.0.71

DELETE FROM `DbMigration` WHERE `version` = 2000071;

ALTER TABLE `Project_AppCategory` DROP FOREIGN KEY IF EXISTS `FK_adqa65g6o4ti2ct3oqw0uw1bj`;
ALTER TABLE `Project_AppCategory` DROP INDEX IF EXISTS `UK_adqa65g6o4ti2ct3oqw0uw1bj`;

ALTER TABLE `AppCategory_AppGroup` DROP FOREIGN KEY IF EXISTS `FK_dtopf8r1vkfb4peq5n3le4lj8`;
ALTER TABLE `AppCategory_AppGroup` DROP INDEX IF EXISTS `UK_dtopf8r1vkfb4peq5n3le4lj8`;

ALTER TABLE `AppGroup_Application` DROP FOREIGN KEY IF EXISTS `FK_4j5x3dru9r3lv2s3jigi6ryrn`;
ALTER TABLE `AppGroup_Application` DROP INDEX IF EXISTS `UK_4j5x3dru9r3lv2s3jigi6ryrn`;


