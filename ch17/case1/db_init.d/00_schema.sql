CREATE TABLE `words`
(
    `id`   INT(11) NOT NULL AUTO_INCREMENT,
    `word` VARCHAR(64) DEFAULT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;

DELIMITER ;;
CREATE PROCEDURE idata()
BEGIN
    DECLARE i INT;
    SET i = 0;
    WHILE i < 10000
        DO
            INSERT INTO words(word)
            VALUES (CONCAT(CHAR(97 + (i DIV 1000)), CHAR(97 + (i % 1000 DIV 100)), CHAR(97 + (i % 100 DIV 10)),
                           CHAR(97 + (i % 10))));
            SET i = i + 1;
        END WHILE;
END;;
DELIMITER ;

