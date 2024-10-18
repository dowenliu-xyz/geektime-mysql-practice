FLUSH TABLES WITH READ LOCK ;

CREATE TABLE test (i INT) ENGINE = InnoDB;
# [HY000][1223] Can't execute the query because you have a conflicting read lock

UNLOCK TABLES ;

CREATE TABLE test (i INT) ENGINE = InnoDB; # OK
DROP TABLE test; # cleanup

--

LOCK TABLES t1 READ, t2 WRITE ;
SELECT * FROM t2; # OK
SELECT * FROM t1; # OK
SELECT * FROM t3; # [HY000][1100] Table 't3' was not locked with LOCK TABLES
INSERT INTO t1 (i) VALUES (1); # [HY000][1099] Table 't1' was locked with a READ lock and can't be updated
INSERT INTO t2 (i) VALUES (1); # OK
INSERT INTO t3 (i) VALUES (1); # [HY000][1100] Table 't3' was not locked with LOCK TABLES
UNLOCK TABLES ;
