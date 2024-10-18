BEGIN ;
UPDATE t SET k = k + 1 WHERE id = 1;
# switch to session 2
UPDATE t SET k = k + 1 WHERE id = 2; # blocked, switch to session 2

ROLLBACK ;
