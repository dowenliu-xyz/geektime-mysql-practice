INSERT INTO tradelog
VALUES (1, 'aaaaaaaa', 1000, NOW());
INSERT INTO tradelog
VALUES (2, 'aaaaaaab', 1000, NOW());
INSERT INTO tradelog
VALUES (3, 'aaaaaaac', 1000, NOW());

INSERT INTO trade_detail
VALUES (1, 'aaaaaaaa', 1, 'add');
INSERT INTO trade_detail
VALUES (2, 'aaaaaaaa', 2, 'update');
INSERT INTO trade_detail
VALUES (3, 'aaaaaaaa', 3, 'commit');
INSERT INTO trade_detail
VALUES (4, 'aaaaaaab', 1, 'add');
INSERT INTO trade_detail
VALUES (5, 'aaaaaaab', 2, 'update');
INSERT INTO trade_detail
VALUES (6, 'aaaaaaab', 3, 'update again');
INSERT INTO trade_detail
VALUES (7, 'aaaaaaab', 4, 'commit');
INSERT INTO trade_detail
VALUES (8, 'aaaaaaac', 1, 'add');
INSERT INTO trade_detail
VALUES (9, 'aaaaaaac', 2, 'update');
INSERT INTO trade_detail
VALUES (10, 'aaaaaaac', 3, 'update again');
INSERT INTO trade_detail
VALUES (11, 'aaaaaaac', 4, 'commit');