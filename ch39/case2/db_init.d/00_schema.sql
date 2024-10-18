CREATE TABLE `t` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `c`  INT DEFAULT NULL,
    `d`  INT DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `c` (`c`)
)
    ENGINE = InnoDB;