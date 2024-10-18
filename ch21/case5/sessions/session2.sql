UPDATE t set d = d + 1 WHERE id = 20;
# OK
# switch to session 3
--
UPDATE t SET d = d + 1 WHERE u = 20;
# blocked
# switch to session 3