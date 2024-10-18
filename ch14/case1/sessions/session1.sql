CALL idata();

BEGIN ;

SELECT count(*) FROM t; # 100000

# switch to session 2

SELECT count(*) FROM t; # 100000

# switch to session 2
