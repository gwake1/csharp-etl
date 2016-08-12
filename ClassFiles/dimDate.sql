
-- Delete any pre-existing occurrence of this table

IF EXISTS(	SELECT * FROM sys.tables
			WHERE ([object_id] = OBJECT_ID(N'dbo.dimDate')) 
	) DROP TABLE dbo.dimDate
GO

-- dimDate Dimension Table

-- Creation, Modification, Maintenance History
---------------	--------------	----------------------------------------------
-- VERSION		PROGRAMMER		DESCRIPTION OF WORK ACCOMPLISHED
---------------	--------------	----------------------------------------------
-- 2007.01.22	Jeffrey Schenk	Original creation of this dimension table

BEGIN TRY

	CREATE TABLE dbo.dimDate
	(
	intDate_KEY					int					NOT NULL,	-- should be integer that is representative of the date, for example 20070122

	-- Source System Meta Data --

	intDataSource_KEY			int					NOT NULL,	-- for system synchronization use (not end user presented)
	intDataSourceNumber			int					NOT NULL,	-- for end user presentation
	strDataSourceName			nvarchar(30)		NOT NULL,	-- denormalized display attribute (doing what dim tables do)

	-- Unique Dimension Attributes --

	dteCalendarDate				date				NOT NULL,
	intYearNumber				smallint			NOT NULL,
	intSeasonNumber				tinyint				NOT NULL,
	strSeasonName				nvarchar(6)			NOT NULL,
	intQuarterNumber			tinyint				NOT NULL,
	strQuarterYearName			nvarchar(7)			NOT NULL,
	strQuarterName				nchar(2)			NOT NULL,
	intMonthNumber				tinyint				NOT NULL,
	strMonthYearName			nvarchar(8)			NOT NULL,
	strMonthName				nvarchar(9)			NOT NULL,
	strMonthDayName				nvarchar(6)			NOT NULL,
	intWeekNumberOfYear			tinyint				NOT NULL,
	intDayNumberOfBogusSales	int					NOT NULL,
	intDayNumberOfYear			smallint			NOT NULL,
	intDayNumberOfMonth			tinyint				NOT NULL,
	intDayNumberOfWeek			tinyint				NOT NULL,
	strDayNameOfWeek			nvarchar(9)			NOT NULL,
	intOrdinalDay				smallint			NOT NULL, 
	blnWorkDay					bit					NOT NULL, 
	strCalendarDayName			nvarchar(26)		NULL,

	-- Standard Dimension Table fare --

	dteFromDate					date				NOT NULL	CONSTRAINT DF_dbo_Date_FromDate DEFAULT (CURRENT_TIMESTAMP),
	dteThruDate					date				NULL,
	bitCurrentFlag				bit					NOT NULL	CONSTRAINT DF_dbo_Date_CurrentFlag DEFAULT(1),

	-- Audit / Meta Data --

	binHashSCDType1				varbinary(20)		NOT NULL	CONSTRAINT DF_dbo_Date_HashSCDType1 DEFAULT(0x0),
	binHashSCDType2				varbinary(20)		NOT NULL	CONSTRAINT DF_dbo_Date_HashSCDType2 DEFAULT(0x0),
	binHashSCDType3				varbinary(20)		NOT NULL	CONSTRAINT DF_dbo_Date_HashSCDType3 DEFAULT(0x0),

	dteUpdatedDate				date				NOT NULL	CONSTRAINT DF_dbo_Date_UpdatedDate DEFAULT (CURRENT_TIMESTAMP),
	uidDate_GUID				uniqueidentifier	NOT NULL	ROWGUIDCOL CONSTRAINT DF_dbo_Date_Date_GUID DEFAULT (NEWSEQUENTIALID()),
	binRowVersion				rowversion			NOT NULL
	) ON [DEFAULT]
	WITH
	(
	DATA_COMPRESSION = NONE
	);

	PRINT 'Created table dbo.dimDate';

END TRY
BEGIN CATCH

	PRINT 'ERROR: Could not create table dbo.dimDate: ' + ERROR_MESSAGE();

END CATCH

GO


