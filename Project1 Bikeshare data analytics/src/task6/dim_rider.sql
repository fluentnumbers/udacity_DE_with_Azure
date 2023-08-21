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



CREATE EXTERNAL TABLE dbo.dim_rider
WITH (
    LOCATION     = 'dim_rider',
    DATA_SOURCE = [bikesharestoragefilesystem_bikesharestorage_dfs_core_windows_net],
    FILE_FORMAT = [SynapseDelimitedTextFormat]
)  
AS
SELECT 
staging_rider.rider_id,
[address],
[first],
[last],
birthday,
DATEDIFF(YEAR, birthday, account_start_date) as age_start_account,
account_start_date,
account_end_date,
is_member,
SUM(payment.amount) as total_payed,
SUM(DATEDIFF(MINUTE, trip.start_at,trip.ended_at)) as total_duration
FROM [dbo].[staging_rider]
JOIN staging_payment as payment ON staging_rider.rider_id=payment.rider_id
JOIN staging_trip as trip ON staging_rider.rider_id=trip.rider_id
GROUP BY 
    staging_rider.rider_id,
    [address],
    [first],
    [last],
    birthday,
    account_start_date,
    account_end_date,
    is_member
GO

SELECT TOP 100 * FROM dbo.dim_rider
GO
