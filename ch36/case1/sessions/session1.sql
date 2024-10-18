DROP TABLE IF EXISTS t;
CREATE TEMPORARY TABLE t(c INT) ENGINE = myisam;
SHOW CREATE TABLE t;
# create table of temporary table
SHOW TABLES ;
# shows nothing
# switch to session 2
CREATE TABLE t(id INT PRIMARY KEY ) ENGINE = innodb;
SHOW CREATE TABLE t;
# create table of temporary table
SHOW TABLES ;
# shows normal table t only
# switch to session 2
SELECT * FROM t;
# select from temporary table t, nothing
SELECT @@tmpdir;