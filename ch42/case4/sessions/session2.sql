SET GLOBAL SYNC_BINLOG = 1;
# OK
CREATE TABLE db1.t (c INT);
# OK
# switch to session 3
SET GLOBAL SYNC_BINLOG = 1;
# OK
ALTER TABLE db1.t ENGINE = InnoDB;
# OK
# switch to session 3
SET GLOBAL SYNC_BINLOG = 1;
# OK
ALTER TABLE db1.t ENGINE = InnoDB;
# [42000][1142] ALTER command denied to user 'ua'@'192.168.107.0' for table 't'
# switch to session 3
