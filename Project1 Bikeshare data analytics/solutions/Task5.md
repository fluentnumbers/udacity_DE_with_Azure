# [Task 5: LOAD the data into external tables in the data warehouse](../Project%20Instructions.md#task-5--load-the-data-into-external-tables-in-the-data-warehouse)

## Evaluation criteria
<img src="../assets/2023-08-12 14_51_16-.png" width="700"/>

## Guide

After the [Task 4](./Task4.md#extract-data-from-postgres-into-the-blob-storage) your Synapse workspace should contain blob storage and uploaded files.

Due to restrictions set by Udacity (???) on student accounts, it can occur that the files only visible in the blob storage section but not in the Data Lake Gen2 storage, you can upload them manually. This will help to use templated SQL scripts for EXTERNAL table creation. 
<img src="../assets/2023-08-12 15_32_25-.png" width="400"/>

### Create an SQL database
<img src="../assets/2023-08-12 15_07_19-.png" width="400"/>


### Create external tables
Select **New SQL script**>>**Create external** table menu on the menu bar.

Either use template for creating an external table or create those from scratch using the example below. It creates a `[dbo].[staging_trip]` table setting all columns to `VARCHAR` type. 

> If you find a way to make Synapse drop the first row with column names, than custom types will work without parsing errors.


```SQL
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

CREATE EXTERNAL TABLE [dbo].[staging_trip] (
	[trip_id] nvarchar(4000),
	[rideable_type] nvarchar(4000),
	[start_at] varchar(50),
	[ended_at] varchar(50),
	[start_station_id] nvarchar(4000),
	[end_station_id] nvarchar(4000),
	[rider_id] varchar(50)
	)
	WITH (
	LOCATION = 'bikeshare/publictrip.txt',
	DATA_SOURCE = [bikesharestoragefilesystem_bikesharestorage_dfs_core_windows_net],
	FILE_FORMAT = [SynapseDelimitedTextFormat]
	)
GO


SELECT TOP 100 * FROM [dbo].[staging_trip]
GO

```

> With serverless SQL pool (not dedicated) you will encounter all kinds of problems with not being able to remove the header row and because of that having to parse all columns as `VARCHAR` ---> One work around is to upload into datalake modified txt files without headers. More on this issue: https://knowledge.udacity.com/questions/1002043

## Deliverable

SQL scripts to create staging tables in [../src/task5](../src/task5/)

# [Task 4](./Task4.md) | [Task 6](./Task6.md)