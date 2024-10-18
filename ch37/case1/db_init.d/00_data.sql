CREATE TABLE t1 (
    id INT PRIMARY KEY,
    a  INT,
    b  INT,
    INDEX (a)
)
    ENGINE = InnoDB;

DELIMITER ;;
CREATE PROCEDURE idata()
BEGIN
    DECLARE i INT;
    SET i = 1;
    WHILE i <= 1000 DO
        INSERT INTO t1 VALUES (i, i, i);
        SET i = i + 1;
    END WHILE;
END ;;
DELIMITER ;
CALL idata();