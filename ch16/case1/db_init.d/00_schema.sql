CREATE TABLE `t`
(
    `id`   INT(11)     NOT NULL,
    `city` VARCHAR(16) NOT NULL,
    `name` VARCHAR(16) NOT NULL,
    `age`  INT(11)     NOT NULL,
    `addr` VARCHAR(128) DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `city` (`city`)
) ENGINE = InnoDB;

DELIMITER //

CREATE PROCEDURE InsertTestData(IN num_rows INT)
BEGIN
    DECLARE i INT DEFAULT 0;

    WHILE i < num_rows DO
        INSERT INTO `t` (`id`, `city`, `name`, `age`, `addr`)
        VALUES (
            i + 1,
                CASE FLOOR(RAND() * 4)
                    WHEN 0 THEN '杭州'
                    WHEN 1 THEN '北京'
                    WHEN 2 THEN '上海'
                    ELSE '广州'
                END,
                concat('Name ', i + 1),
            FLOOR(RAND() * 100) + 1,
            CONCAT('Address ', i + 1)
        );
        SET i = i + 1;
    END WHILE;
END //

DELIMITER ;