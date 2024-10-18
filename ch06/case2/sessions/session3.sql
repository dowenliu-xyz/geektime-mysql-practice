ALTER TABLE t
    ADD f INT;
## blocked
## switch to session 4

--

## MariaDB: NOWAIT / WAIT n
## MySQL 8.0.39 还是没有这个语法
# ALTER TABLE t NOWAIT ADD f INT;
# ALTER TABLE t WAIT 5 ADD f INT;