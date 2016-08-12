

SELECT CHAR(9) + CHAR(9)  + [name] + ', ' FROM sys.columns WHERE [object_id] = OBJECT_ID(N'dbo.dimProduct') ORDER BY column_id;