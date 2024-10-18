START TRANSACTION WITH CONSISTENT SNAPSHOT;
# switch to session 3
UPDATE t
SET k = k + 1
WHERE id = 1; # OK 当前读
SELECT k
FROM t
WHERE id = 1;
# 3
# switch to session 1
COMMIT;