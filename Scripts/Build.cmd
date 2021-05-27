
del "01 - F1 - Install.sql"
del "01 - F3 - Rollback.sql"
type "F1\Install\*.sql" > "01 - F1 - Install.sqlInstall"
type "F3\Rollback\*.sql" > "01 - F3 - Rollback.sqlRollback"

del "02 - F2 - Install.sql"
del "02 - F2 - Rollback.sql"
type "F2\Install\*.sql" > "02 - F2 - Install.sqlInstall"
type "F2\Rollback\*.sql" > "02 - F2 - Rollback.sqlRollback"

del "03 - F3 - Install.sql"
del "03 - F1 - Rollback.sql"
type "F3\Install\*.sql" > "03 - F3 - Install.sqlInstall"
type "F1\Rollback\*.sql" > "03 - F1 - Rollback.sqlRollback"

del "2020 06 01 - agCadPr - Install.sql"
del "2020 06 01 - agCadPr - Rollback.sql"

type *.sqlInstall > "2020 06 01 - agCadPr - Install.sql"
type *.sqlRollback > "2020 06 01 - agCadPr - Rollback.sql"

Rename *.sqlInstall *.sql
Rename *.sqlRollback *.sql