USE master;
GO
-- Must set show advanced options as seperate batch
-- Before actually setting advanced options...

EXEC sp_configure 'show advanced option', '1';
RECONFIGURE;
GO

-- Now set options as desired
EXEC sp_configure 'xp_cmdshell', 1
EXEC sp_configure 'Database Mail XPs', 1;
EXEC sp_configure 'Ad Hoc Distributed Queries', 1; 
EXEC sp_configure 'clr enabled', 1;
EXEC sp_configure 'remote admin connections', 1; --DAC
RECONFIGURE;
GO
 