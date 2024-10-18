CALL idata();
--
EXPLAIN SELECT word FROM words ORDER BY RAND() LIMIT 3;
# type: ALL !!!
# Extra: Using temporary; Using filesort
SET GLOBAL SLOW_QUERY_LOG = 'ON';
SET LONG_QUERY_TIME = 0;
SHOW VARIABLES LIKE '%slow_query_log%';
SELECT word FROM words ORDER BY RAND() LIMIT 3;
--
SET tmp_table_size = 1024;
SET sort_buffer_size = 32768;
SET max_length_for_sort_data = 16;
SELECT @@optimizer_trace_offset, @@optimizer_trace_limit;
SET OPTIMIZER_TRACE_OFFSET = -10, OPTIMIZER_TRACE_LIMIT = 10;
SELECT @@optimizer_trace_offset, @@optimizer_trace_limit;
/* 打开 optimizer_trace，只对本线程有效 */
SET optimizer_trace='enabled=on';
/* 执行语句 */
select word from words order by rand() limit 3;
/* 查看 OPTIMIZER_TRACE 输出 */
SELECT *
FROM `information_schema`.`OPTIMIZER_TRACE`
WHERE QUERY LIKE '%select word from words order by rand() limit 3%';
/*
            "sorting_table": "<temporary>",
            "filesort_information": [
              {
                "direction": "asc",
                "expression": "`rand()`"
              }
            ],
            "filesort_priority_queue_optimization": {
              "limit": 3,
              "chosen": true <-- 优先队列
            },
            "filesort_execution": [
            ],
            "filesort_summary": {
              "memory_available": 32768,
              "key_size": 8,
              "row_size": 275,
              "max_rows_per_buffer": 4,
              "num_rows_estimate": 9980,
              "num_rows_found": 10000,
              "num_initial_chunks_spilled_to_disk": 0,
              "peak_memory_used": 1132,
              "sort_algorithm": "std::sort",
              "unpacked_addon_fields": "using_priority_queue", <-- 优先队列
              "sort_mode": "<fixed_sort_key, additional_fields>"
            }
 */
