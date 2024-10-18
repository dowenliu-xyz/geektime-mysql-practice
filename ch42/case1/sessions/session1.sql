CREATE USER 'ua'@'%' IDENTIFIED BY 'pa';
SELECT * FROM mysql.user WHERE user = 'ua';

GRANT ALL PRIVILEGES ON *.* TO 'ua'@'%' WITH GRANT OPTION;
SELECT * FROM mysql.user WHERE user = 'ua';

REVOKE ALL PRIVILEGES ON *.* FROM 'ua'@'%';
SELECT * FROM mysql.user WHERE user = 'ua';

GRANT ALL PRIVILEGES ON db1.* TO 'ua'@'%' WITH GRANT OPTION;
SELECT * FROM mysql.db WHERE user = 'ua';
