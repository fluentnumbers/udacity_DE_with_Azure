-- Use the same file format as used for creating the External Tables during the LOAD step.
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseDelimitedTextFormat') 
    CREATE EXTERNAL FILE FORMAT [SynapseDelimitedTextFormat] 
    WITH ( FORMAT_TYPE = DELIMITEDTEXT ,
           FORMAT_OPTIONS (
             FIELD_TERMINATOR = ',',
             USE_TYPE_DEFAULT = FALSE
            ))
GO

-- Use the same data source as used for creating the External Tables during the LOAD step.
-- Storage path where the result set will persist
IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'bikesharestoragefilesystem_bikesharestorage_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [bikesharestoragefilesystem_bikesharestorage_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://bikesharestoragefilesystem@bikesharestorage.dfs.core.windows.net' 
	)
GO


CREATE EXTERNAL TABLE dbo.fact_payment
WITH (
    LOCATION     = 'fact_payment',
    DATA_SOURCE = [bikesharestoragefilesystem_bikesharestorage_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT [payment_id], [rider_id], hashbytes('md5',CONVERT(VARCHAR(100),[date],126)) as date_id, [amount]
FROM [dbo].[staging_payment]
GO

SELECT TOP 100 * FROM dbo.fact_payment
GO

