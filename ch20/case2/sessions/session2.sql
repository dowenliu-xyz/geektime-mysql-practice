BEGIN ;
SELECT * FROM t WHERE c = 7 FOR UPDATE ; # won't be blocked
COMMIT ;