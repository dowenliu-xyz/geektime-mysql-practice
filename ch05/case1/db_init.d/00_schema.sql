CREATE TABLE T
(
    ID INT PRIMARY KEY,
    k  INT         NOT NULL DEFAULT 0,
    s  VARCHAR(16) NOT NULL DEFAULT '',
    INDEX k (k)
) ENGINE = InnoDB;

CREATE TABLE `tuser`
(
    `id`      INT(11) NOT NULL,
    `id_card` VARCHAR(32) DEFAULT NULL,
    `name`    VARCHAR(32) DEFAULT NULL,
    `age`     INT(11)     DEFAULT NULL,
    `ismale`  TINYINT(1)  DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `id_card` (`id_card`),
    KEY `name_age` (`name`, `age`)
) ENGINE = InnoDB;
