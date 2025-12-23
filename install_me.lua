-- ADI-INFINITY OS: AUTO-INSTALLER
-- Place this in your server's server-side script folder

MySQL.ready(function()
    print("^4[Adi-Infinity]^7 Checking Database Integrity...")

    -- 1. Create Cloud Sync Table
    MySQL.query([[
        CREATE TABLE IF NOT EXISTS `adi_phone_cloud` (
            `identifier` VARCHAR(60) NOT NULL,
            `phone_data` LONGTEXT DEFAULT '{}',
            `settings` LONGTEXT DEFAULT '{}',
            PRIMARY KEY (`identifier`)
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]])

    -- 2. Create Bank Transactions Table
    MySQL.query([[
        CREATE TABLE IF NOT EXISTS `adi_bank_history` (
            `id` INT AUTO_INCREMENT PRIMARY KEY,
            `sender` VARCHAR(60),
            `receiver` VARCHAR(60),
            `amount` INT,
            `note` VARCHAR(255),
            `date` TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]])

    -- 3. Create Government Treasury Table
    MySQL.query([[
        CREATE TABLE IF NOT EXISTS `adi_gov_data` (
            `key` VARCHAR(50) PRIMARY KEY,
            `value` LONGTEXT
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]])

    -- 4. Create Dark-Web Bounty Table
    MySQL.query([[
        CREATE TABLE IF NOT EXISTS `adi_darkweb_bounties` (
            `target_id` VARCHAR(60) PRIMARY KEY,
            `reward` INT,
            `status` VARCHAR(20) DEFAULT 'active'
        ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
    ]])

    print("^2[Adi-Infinity]^7 Database Setup Complete. System is READY.")
end)
