BEGIN ;

INSERT INTO t (a, b) VALUES (1, 1);

# switch to session 1

SELECT count(*) FROM t; # 100002