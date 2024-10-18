BEGIN ;
INSERT INTO t VALUES (11, 11, 11);
# blocked
# switch to session 3
ROLLBACK ;