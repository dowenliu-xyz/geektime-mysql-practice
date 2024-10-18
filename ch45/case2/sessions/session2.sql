SELECT trx_id, trx_mysql_thread_id FROM information_schema.innodb_trx;
# +---------------+-------------------+
# |trx_id         |trx_mysql_thread_id|
# +---------------+-------------------+
# |562948489612504|10                 |
# +---------------+-------------------+
# 这里 trx_id 只是显示用,实际为 0
# switch to session 1
SELECT trx_id, trx_mysql_thread_id FROM information_schema.innodb_trx;
# +------+-------------------+
# |trx_id|trx_mysql_thread_id|
# +------+-------------------+
# |2321  |10                 |
# +------+-------------------+