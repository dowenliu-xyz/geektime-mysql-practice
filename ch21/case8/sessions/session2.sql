UPDATE t SET d = d + 1 WHERE c = 10;
# blocked
# switch to session 1
# [40001][1213] Deadlock found when trying to get lock; try restarting transaction