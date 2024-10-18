CREATE TABLE t
(
    a INT NOT NULL
) ENGINE InnoDB;

DELIMITER ;;
CREATE PROCEDURE idata()
BEGIN
    DECLARE i INT;
    SET i = 1;
    WHILE i <= 1000 DO
        INSERT INTO t VALUES (rand() * 100);
        SET i = i + 1;
    END WHILE;
END ;;
DELIMITER ;
CALL idata();