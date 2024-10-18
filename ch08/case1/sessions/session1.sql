START TRANSACTION WITH CONSISTENT SNAPSHOT ;
# switch to session 2
SELECT k FROM t WHERE id = 1; # 1
COMMIT ;
# switch to session 2

--

SELECT @@transaction_isolation; # REPEATABLE-READ as default