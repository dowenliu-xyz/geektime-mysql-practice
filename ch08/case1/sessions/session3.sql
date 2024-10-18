UPDATE t
SET k = k + 1
WHERE id = 1;
# switch to session 3

## 注意这个 session 没有显式事务。否则 session2 的 update 会被阻塞
# START TRANSACTION WITH CONSISTENT SNAPSHOT ;
# COMMIT ;