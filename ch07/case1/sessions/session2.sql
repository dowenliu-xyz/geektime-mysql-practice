BEGIN ;
UPDATE t SET k = k + 2 WHERE id = 1;
# 空表 OK
# 非空， blocked。switch back to session 1
