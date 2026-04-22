/*
SCRIPT PURPOSE:
  This script will create a new database named 'Datawarehouse'. If it exists, the DB is dropped and recreated.
  Additionally, three schemas are also made within the same DB named: bronze, silver, and gold

WARNING:
  Running this script will erase everything within the database, including the data. Better proceed with this script only when an adequate backup is present.
*/

USE master;
GO

-- Drop and recreate the 'DataWarehouse' database
IF EXISTS(SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	DROP DATABASE DataWarehouse;
END;
GO

-- Create the 'DataWarehouse' database
CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO

-- Create Schemas
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
