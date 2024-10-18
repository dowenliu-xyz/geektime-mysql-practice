BEGIN ;
SELECT * FROM t WHERE d = 5 for UPDATE ;
# result: (5, 5, 5)
# switch to session 2
SELECT * FROM t WHERE d = 5 for UPDATE ;
# result: (5, 5, 5)
# switch to session 3
SELECT * FROM t WHERE d = 5 for UPDATE ;
# result: (5, 5, 5)
COMMIT ;
# session 2, 3 unblocked
SELECT * FROM t WHERE d = 5 ;