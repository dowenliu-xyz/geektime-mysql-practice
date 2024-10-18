CREATE TABLE `t` (
    `id` BIGINT NOT NULL,
    `c`  INT DEFAULT NULL,
    PRIMARY KEY (`id`)
)
    ENGINE = InnoDB;

CREATE TABLE `health_check` (
    `server_uuid` CHAR(36) NOT NULL,
    `t_modify`    DATETIME NOT NULL,
    PRIMARY KEY (`server_uuid`)
)
    ENGINE = InnoDB;