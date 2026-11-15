# MicroSDSQLite Test Report

This file records the development test coverage used before packaging the library.

## Device

- Samsung SM-A166U
- Android 16 / SDK 36
- Removable microSD storage

## Direct Mode Paths Tested

Direct Mode was tested with real filesystem paths on removable storage.

The tested path shapes were:

[CODE=text]
/storage/<volume-id>/Download/<database>.db
/storage/<volume-id>/testdb/<database>.db
/storage/<volume-id>/<database>.db
/storage/<volume-id>/Android/data/<package>/files/<folder>/<database>.db
[/CODE]

The public/shared paths required Android to allow direct file access for the app. The app-specific removable path did not require all-files special access in testing.

## SAF Mode Tested

SAF Mode was tested with Android's folder picker.

The test selected an allowed folder on the SD card, opened the database through a SAF document file descriptor, and passed a `/proc/self/fd/<fd>` path to SQLite.

## Database Function Test

The destructive database-function test was run against a disposable SQLite database on removable storage.

Summary:

[CODE=text]
total=44
failed=0
[/CODE]

The completed checks were:

1. `foreign_keys_enabled` - enabled foreign-key enforcement and read it back.
2. `quick_check_before` - `PRAGMA quick_check` returned ok before the test objects were created.
3. `journal_mode_wal_result` - entered WAL journal mode in Direct Mode.
4. `pragma_synchronous_read` - read the synchronous setting successfully.
5. `schema_object_count` - created the expected test tables, index, view, and trigger.
6. `insert_parameterized_parent` - inserted a row with `ExecNonQuery2` parameters.
7. `blob_round_trip_length` - read back the expected BLOB length.
8. `blob_round_trip_values` - read back the expected BLOB byte values.
9. `real_type` - confirmed the REAL column stored as real.
10. `real_value` - read back the expected REAL value.
11. `transaction_commit_completed` - completed a committed transaction.
12. `transaction_commit_rows` - confirmed committed rows persisted.
13. `trigger_after_insert_rows` - confirmed the insert trigger wrote audit rows.
14. `transaction_rollback_rows` - confirmed an uncommitted transaction rolled back.
15. `savepoint_rollback` - confirmed `SAVEPOINT` rollback behavior.
16. `unique_constraint` - confirmed a UNIQUE constraint failure is raised.
17. `check_constraint` - confirmed a CHECK constraint failure is raised.
18. `foreign_key_constraint` - confirmed a foreign-key constraint failure is raised.
19. `constraint_rows_stable` - confirmed failed constraint writes did not add rows.
20. `update_qty` - updated a row and read back the new value.
21. `exec_query2_count` - queried with `ExecQuery2` parameters.
22. `join_count` - ran an INNER JOIN query.
23. `view_alpha_child_count` - queried through the created view.
24. `reindex_completed` - completed `REINDEX` on the test index.
25. `alter_table_default` - used `ALTER TABLE ADD COLUMN` with a default value.
26. `temp_table_query` - created, inserted into, queried, and dropped a temp table.
27. `attach_file_prepared_before_attach` - confirmed the caller-supplied attach DB existed.
28. `attach_lock_count_before` - confirmed no attached DB locks before attach.
29. `attach_manager_attach` - attached the second DB through the library manager.
30. `attach_lock_count_after_attach` - confirmed one attached DB lock after attach.
31. `attach_schema_name` - confirmed the attached schema name was aux.
32. `attach_query_existing` - read an existing row from the attached DB.
33. `attach_write_count` - wrote to the attached DB and counted the rows.
34. `attach_manager_detach` - detached the attached DB through the library manager.
35. `attach_lock_count_after_detach` - confirmed attached DB locks were released.
36. `attach_file_exists_after_detach` - confirmed detach did not delete the attached DB.
37. `attach_file_deleted` - confirmed test cleanup deleted the disposable attach DB.
38. `delete_parent` - deleted a parent row.
39. `cascade_child_delete` - confirmed `ON DELETE CASCADE` removed child rows.
40. `delete_remaining_test_rows` - removed the remaining test rows.
41. `drop_cleanup_objects` - dropped the test schema objects.
42. `journal_mode_delete_result` - returned the database to DELETE journal mode.
43. `vacuum_covered_by_small_sd_db` - confirmed `VACUUM` coverage on a small SD-card DB fixture instead of rewriting the large main DB.
44. `quick_check_after` - `PRAGMA quick_check` returned ok after cleanup.

## Notes

- `ATTACH` was tested with a developer-supplied second database path.
- The library does not create an attach database during normal opens.
- SQLite creates and manages normal sidecar files in Direct Mode.
- SAF Mode intentionally does not support WAL.
