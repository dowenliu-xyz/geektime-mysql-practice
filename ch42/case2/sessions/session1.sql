CREATE USER 'ua'@'%' IDENTIFIED BY 'pa';
GRANT SUPER ON *.* TO 'ua'@'%';
GRANT ALL PRIVILEGES ON db1.* TO 'ua'@'%';
DROP TABLE IF EXISTS db1.t;
# switch to session 2
REVOKE SUPER ON *.* FROM 'ua'@'%';
# switch to session 2
REVOKE ALL PRIVILEGES ON db1.* FROM 'ua'@'%';
# switch to session 2
--
CREATE TABLE db1.t1
(
    id INT,
    a  INT
);
GRANT ALL PRIVILEGES ON db1.t1 TO 'ua'@'%' WITH GRANT OPTION;
GRANT SELECT (id), INSERT (id, a) ON mydb.mytbl TO 'ua'@'%' WITH GRANT OPTION;