BEGIN ;
SELECT * FROM t LIMIT 1;
# switch to session 2
INSERT INTO t VALUES (NULL);
# switch to session 2