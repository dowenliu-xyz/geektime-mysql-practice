BEGIN ;
UPDATE t SET k = k + 1 WHERE id = 2;
# switch to session 1
UPDATE t SET k = k + 1 WHERE id = 1; # deadlock, and unblock session 1