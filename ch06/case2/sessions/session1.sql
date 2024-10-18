BEGIN ;
SELECT * FROM t LIMIT 1;
# switch to session 2
ROLLBACK ; ## unblock session 3 and session 4