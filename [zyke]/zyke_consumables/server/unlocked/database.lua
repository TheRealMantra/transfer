QueriesExecuted = false

local queries = {
	[[
		CREATE TABLE IF NOT EXISTS `zyke_consumables` (
			`itemId` VARCHAR(20) PRIMARY KEY,
			`data` TEXT
		);
	]],
	[[
		CREATE TABLE IF NOT EXISTS `zyke_consumables_ingredients` (
			`name` VARCHAR(20) PRIMARY KEY,
			`amount` INT(11) NOT NULL DEFAULT 0,
			`consumption_rewards` MEDIUMTEXT NOT NULL DEFAULT "[]"
		);
	]],
	[[
		CREATE TABLE IF NOT EXISTS `zyke_consumables_items` (
			`idx` INT(11) NOT NULL AUTO_INCREMENT,
			`item_id` VARCHAR(20) NOT NULL,
			`item_name` VARCHAR(20) NOT NULL,
			`label` TINYTEXT NOT NULL DEFAULT "MISSING LABEL",
			`amount` INT(11) NOT NULL DEFAULT 0,
			`type` TINYTEXT NOT NULL DEFAULT "food",
			`props` TEXT NOT NULL DEFAULT "{}",
			`anim` TEXT NOT NULL DEFAULT "{}",
			`consumption_rewards` MEDIUMTEXT NOT NULL DEFAULT "{}",
			`ingredients` MEDIUMTEXT NOT NULL DEFAULT "{}",
			`discard` TINYINT(1) NOT NULL DEFAULT 0,
			`infinite` TINYINT(1) NOT NULL DEFAULT 0,
			`image` TEXT DEFAULT NULL,
			`job` TINYTEXT DEFAULT NULL,
			`reward_type` TINYTEXT NOT NULL DEFAULT "consumptionRewards",
			PRIMARY KEY (`item_id`),
			UNIQUE KEY `idx` (`idx`),
			KEY `item_name_key` (`item_name`)
		);
	]]
}

for i = 1, #queries do
	MySQL.query.await(queries[i])
end

QueriesExecuted = true