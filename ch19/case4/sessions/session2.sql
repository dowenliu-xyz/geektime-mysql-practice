DELIMITER ;;
CREATE PROCEDURE addc(IN times INT, IN in_id INT)
BEGIN
    DECLARE i INT;
    SET i = 1;
    WHILE(i <= times)
        DO
            UPDATE t SET c = c + 1 WHERE id = in_id;
            SET i = i + 1;
        END WHILE;
END;;
DELIMITER ;
CALL addc(1000000, 1);