CREATE TABLE IF NOT EXISTS `phone_settings` (
    `citizenid` VARCHAR(50) PRIMARY KEY,
    `background` TEXT DEFAULT 'default.jpg',
    `ringtone` VARCHAR(255) DEFAULT 'standard.mp3',
    `dark_mode` TINYINT(1) DEFAULT 1,
    `airplane_mode` TINYINT(1) DEFAULT 0,
    `encryption` TINYINT(1) DEFAULT 0
);

ALTER TABLE `phone_settings` ADD COLUMN `biometric_enabled` TINYINT(1) DEFAULT 0;

ALTER TABLE `phone_settings` ADD COLUMN `passcode` VARCHAR(4) DEFAULT '0000';

CREATE TABLE IF NOT EXISTS `phone_notes` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `citizenid` VARCHAR(50),
    `content` TEXT,
    `timestamp` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS `phone_alarms` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `citizenid` VARCHAR(50),
    `alarm_time` VARCHAR(10),
    `label` VARCHAR(255)
);
