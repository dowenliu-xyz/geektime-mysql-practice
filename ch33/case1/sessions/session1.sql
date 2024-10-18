BEGIN ;
SELECT * FROM t WHERE id=1 FOR UPDATE;
-- switch to session 2

# --------------------

SHOW ENGINE innodb STATUS ;
