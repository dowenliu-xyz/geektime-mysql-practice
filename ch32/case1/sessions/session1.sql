BEGIN ;
UPDATE t SET c = c + 1 WHERE id = 1;
-- switch to session 2