CREATE TABLE `t1` (
    `id` BIGINT PRIMARY KEY,
    `a`  INT,
    `b`  INT,
    INDEX (`a`)
)
    ENGINE = InnoDB;
CREATE TABLE `t2` LIKE t1;
DROP PROCEDURE IF EXISTS idata;
DELIMITER ;;
CREATE PROCEDURE idata()
BEGIN
    DECLARE i INT;
    SET i = 1;
    WHILE i <= 1000
        DO
            INSERT INTO t1 VALUES (i, 1001 - i, i);
            SET i = i + 1;
        END WHILE;

    SET i = 1;
    WHILE i <= 1000000
        DO
        INSERT INTO t2 VALUES (i, i, i);
        SET i = i + 1;
        END WHILE;
END ;;
DELIMITER ;
CALL idata();