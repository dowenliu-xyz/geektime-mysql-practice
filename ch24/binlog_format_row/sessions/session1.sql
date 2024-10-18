SHOW VARIABLES LIKE '%binlog_format%';
DELETE FROM t /*comment*/ WHERE a >= 4 AND t_modified < '2018-11-10' LIMIT 1;
SHOW BINARY LOGS ;
SHOW BINLOG EVENTS IN 'binlog.000003';
SHOW VARIABLES LIKE '%log_bin%';

SHOW VARIABLES LIKE '%binlog_row_image%';

SHOW VARIABLES LIKE '%log_slave%';