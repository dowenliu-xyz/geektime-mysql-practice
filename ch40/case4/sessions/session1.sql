INSERT INTO t VALUES (10, 10, 10);
BEGIN ;
INSERT INTO t VALUES (11, 10, 10);
# switch to session 2
ROLLBACK ;
# this unblocks session 2
