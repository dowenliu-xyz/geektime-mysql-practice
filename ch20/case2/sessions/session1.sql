BEGIN ;
SELECT * FROM t WHERE c = 7 LOCK IN SHARE MODE ;
# switch to session 2
COMMIT ;