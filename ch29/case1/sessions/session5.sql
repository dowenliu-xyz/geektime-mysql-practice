SELECT * FROM health_check;
INSERT INTO `health_check` (`server_uuid`, `t_modify`)
VALUES (@@server_uuid, NOW())
ON DUPLICATE KEY UPDATE t_modify = NOW();