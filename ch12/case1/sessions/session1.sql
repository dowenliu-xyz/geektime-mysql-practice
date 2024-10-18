SELECT VARIABLE_VALUE
INTO @a
FROM performance_schema.global_status
WHERE VARIABLE_NAME = 'Innodb_buffer_pool_pages_dirty';
SELECT VARIABLE_VALUE
INTO @b
FROM performance_schema.global_status
WHERE VARIABLE_NAME = 'Innodb_buffer_pool_pages_total';
SELECT @a / @b, @a, @b;

SELECT @@innodb_flush_neighbors;

SELECT @@innodb_file_per_table;