SHOW CREATE TABLE t;
# CREATE TABLE `t` (
#   `id` int unsigned NOT NULL AUTO_INCREMENT,
#   PRIMARY KEY (`id`)
# ) ENGINE=InnoDB AUTO_INCREMENT=4294967295 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
INSERT INTO t VALUES (NULL);
# OK
SHOW CREATE TABLE t;
# CREATE TABLE `t` (
#   `id` int unsigned NOT NULL AUTO_INCREMENT,
#   PRIMARY KEY (`id`)
# ) ENGINE=InnoDB AUTO_INCREMENT=4294967295 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci
INSERT INTO t VALUES (NULL);
# [23000][1062] Duplicate entry '4294967295' for key 't.PRIMARY'
# 如果有可能就应该使用 bigint 作为主键
