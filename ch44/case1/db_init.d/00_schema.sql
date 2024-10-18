CREATE TABLE a
(
    f1 INT,
    f2 INT,
    INDEX (f1)
) ENGINE = innodb;
CREATE TABLE b
(
    f1 INT,
    f2 INT
) ENGINE = innodb;
INSERT INTO a
VALUES (1, 1),
       (2, 2),
       (3, 3),
       (4, 4),
       (5, 5),
       (6, 6);
INSERT INTO b
VALUES (3, 3),
       (4, 4),
       (5, 5),
       (6, 6),
       (7, 7),
       (8, 8);