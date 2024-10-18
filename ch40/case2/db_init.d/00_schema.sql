CREATE TABLE `t` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `c`  INT DEFAULT NULL,
    `d`  INT DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `c` (`c`)
)
    ENGINE = InnoDB;

INSERT INTO t VALUES (NULL, 1, 1);
INSERT INTO t VALUES (NULL, 2, 2);
INSERT INTO t VALUES (NULL, 3, 3);
INSERT INTO t VALUES (NULL, 4, 4);

CREATE TABLE t2 LIKE t;