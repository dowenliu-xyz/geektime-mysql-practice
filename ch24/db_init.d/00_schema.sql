CREATE TABLE `t` (
    `id` INT NOT NULL,
    `a` INT DEFAULT NULL,
    `t_modified` TIMESTAMP NOT NULL DEFAULT current_timestamp,
    PRIMARY KEY (`id`),
    KEY `a` (`a`),
    KEY `t_modified` (`t_modified`)
) ENGINE=InnoDB;
