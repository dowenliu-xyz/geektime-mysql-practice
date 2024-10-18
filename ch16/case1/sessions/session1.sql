CALL InsertTestData(100000);
--
EXPLAIN SELECT city, name, age FROM t WHERE city = '杭州' ORDER BY name LIMIT 1000;
# Extra: Using filesort 需要排序
--
SELECT @@optimizer_trace_offset, @@optimizer_trace_limit;
SET OPTIMIZER_TRACE_OFFSET = -10, OPTIMIZER_TRACE_LIMIT = 10;
SELECT @@optimizer_trace_offset, @@optimizer_trace_limit;
/* 打开optimizer_trace，只对本线程有效 */
SET optimizer_trace = 'enabled=on';
/* @a保存Innodb_rows_read的初始值 */
SELECT VARIABLE_VALUE INTO @a FROM performance_schema.session_status WHERE variable_name = 'Innodb_rows_read';
/* 执行语句 */
SELECT city, name, age FROM t WHERE city = '杭州' ORDER BY name LIMIT 1000;
/* 查看 OPTIMIZER_TRACE 输出 */
SELECT * FROM `information_schema`.`OPTIMIZER_TRACE` WHERE QUERY LIKE '%SELECT city, name, age%';
/*
            "filesort_summary": {
              "memory_available": 262144,
              "key_size": 264,
              "row_size": 402,
              "max_rows_per_buffer": 652, ## memory_available / row_size = 262144 / 402 = 652
              "num_rows_estimate": 43788,
              "num_rows_found": 25150, ## examined_rows
              "num_initial_chunks_spilled_to_disk": 7, ## number_of_tmp_files
              "peak_memory_used": 294912,
              "sort_algorithm": "std::sort",
              "sort_mode": "<varlen_sort_key, packed_additional_fields>"
            }
*/
/* @b保存Innodb_rows_read的当前值 */
SELECT VARIABLE_VALUE INTO @b FROM performance_schema.session_status WHERE variable_name = 'Innodb_rows_read';
/* 计算Innodb_rows_read差值 */
SELECT @b - @a; # 25160
--
SELECT @@max_length_for_sort_data; # 4096
SET max_length_for_sort_data = 16;
# 无意义。8.0.20 弃用该参数，不生产任何效果。
--
ALTER TABLE t ADD INDEX city_user (city, name);
EXPLAIN SELECT city, name, age FROM t WHERE city = '杭州' ORDER BY name LIMIT 1000;
ALTER TABLE t DROP INDEX city_user;
--
ALTER TABLE t ADD INDEX city_user_age (city, name, age);
EXPLAIN SELECT city, name, age FROM t WHERE city = '杭州' ORDER BY name LIMIT 1000;
ALTER TABLE t DROP INDEX city_user_age;