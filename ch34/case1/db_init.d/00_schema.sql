CREATE TABLE `t2` (
    `id` BIGINT NOT NULL,
    `a` INT DEFAULT NULL,
    `b` INT DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `a` (`a`)
) ENGINE = InnoDB;

DROP PROCEDURE IF EXISTS idata;

DELIMITER ;;
CREATE PROCEDURE idata()
BEGIN
    DECLARE i INT;
    SET i = 1;
    WHILE i <= 1000 DO
        INSERT INTO t2 VALUES (i, i, i);
        SET i = i + 1;
    END WHILE;
END ;;
DELIMITER ;
CALL idata();

CREATE TABLE t1 LIKE t2;
INSERT INTO t1 (SELECT * FROM t2 WHERE id <= 100);