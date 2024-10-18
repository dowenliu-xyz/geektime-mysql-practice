BEGIN ;
INSERT INTO `t` (`id`, `c`) VALUES (1, 1);
SELECT @@GLOBAL.gtid_executed;
COMMIT ;
SELECT @@GLOBAL.gtid_executed;
BEGIN ;
UPDATE `t` SET `c` = 1 WHERE `id` = 1;
SELECT @@GLOBAL.gtid_executed;
COMMIT ;
