UPDATE t SET c = 1 WHERE c = 5;
# OK
UPDATE t SET c = 5 WHERE c = 1;
# blocked
# switch back to session 1