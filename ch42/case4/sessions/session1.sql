CREATE USER 'ua'@'%' IDENTIFIED BY 'pa';
DELETE FROM mysql.user WHERE user = 'ua';
GRANT SUPER ON *.* TO 'ua'@'%' WITH GRANT OPTION ;
# 5.0.43: [42000][1133] Can't find any matching row in the user table
# 8.0.39: [42000][1410] You are not allowed to create a user with GRANT
CREATE USER 'ua'@'%' IDENTIFIED BY 'pa';
# 5.0.43: [HY000][1396] Operation CREATE USER failed for 'ua'@'%'
# 8.0.39: OK