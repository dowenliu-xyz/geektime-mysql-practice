BEGIN ;
INSERT INTO t VALUES (6, 6, 6);
# blocked
# switch to session 1
ROLLBACK ;
