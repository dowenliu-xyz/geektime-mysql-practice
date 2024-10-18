CREATE USER 'ua'@'%' IDENTIFIED BY 'pa';
# open session 2
DELETE FROM mysql.user WHERE user = 'ua';
# open session 3
FLUSH PRIVILEGES;
# open session 4
