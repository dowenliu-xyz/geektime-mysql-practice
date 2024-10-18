INSERT INTO t (a, b) VALUES (1, 1);

# switch to session 3

SELECT count(*) FROM t; # 100001

# switch to session 3