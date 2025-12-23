CREATE TABLE IF NOT EXISTS `phone_settings` (
    `citizenid` VARCHAR(50) PRIMARY KEY,
    `background` TEXT DEFAULT 'default.jpg',
    `ringtone` VARCHAR(255) DEFAULT 'standard.mp3',
    `dark_mode` TINYINT(1) DEFAULT 1,
    `airplane_mode` TINYINT(1) DEFAULT 0,
    `encryption` TINYINT(1) DEFAULT 0
);

ALTER TABLE `phone_settings` ADD COLUMN `biometric_enabled` TINYINT(1) DEFAULT 0;
