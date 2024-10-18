CREATE TABLE `t`
(
    `id` INT(11) NOT NULL,
    `c`  INT(11) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;

DELIMITER ;;
CREATE PROCEDURE idata()
BEGIN
    DECLARE i INT;
    SET i = 1;
    WHILE(i <= 100000)
        DO
            INSERT INTO t VALUES (i, i);
            SET i = i + 1;
        END WHILE;
END;;
DELIMITER ;

