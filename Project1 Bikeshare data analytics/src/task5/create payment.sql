IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
	WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
	       FORMAT_OPTIONS (
			 FIELD_TERMINATOR = ',',
			 USE_TYPE_DEFAULT = FALSE
			))
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'bikesharestoragefilesystem_bikesharestorage_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [bikesharestoragefilesystem_bikesharestorage_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://bikesharestoragefilesystem@bikesharestorage.dfs.core.windows.net'
	)
GO

CREATE EXTERNAL TABLE [dbo].[staging_payment] (
	[payment_id] BIGINT,
	[date] DATETIME2,
	[amount] MONEY,
	[rider_id] BIGINT
	)
	WITH (
	LOCATION = 'bikeshare/publicpayment.txt',
	DATA_SOURCE = [bikesharestoragefilesystem_bikesharestorage_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO




SELECT TOP 100 * FROM [dbo].[staging_payment]
GO