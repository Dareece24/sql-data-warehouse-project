/* 
Script Purpose :
   The stored procedure loads data into the 'bronze' schema from external CSV files.
It perfomes the following procedure:
- Truncates the bronze tables before loading data
- Uses BULK INSERT command to laod data from csv files to bronze tables.
  */

EXEC bronze.load_bronze
USE DataWarehouse;
GO

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN

DECLARE @start_time DATETIME, @end_time DATETIME;
BEGIN TRY
PRINT'=========================================================';
PRINT'Loading Bronze Layer';
PRINT'=========================================================';

PRINT'---------------------------------------------------------';
PRINT'Loading CRM tables';
PRINT'---------------------------------------------------------';

SET @start_time = GETDATE();
PRINT'>>Truncating The Table: bronze.crm_cust_info';
TRUNCATE TABLE bronze.crm_cust_info;
PRINT'>>Inserting The Data into : bronze.crm_cust_info';
BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\HP\Downloads\sql-data-warehouse-project (2)\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH (
FIRSTROW = 2,
FIELDTERMINATOR = ',',
TABLOCK
);

SET @end_time = GETDATE();
PRINT'>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT'>>-----------------';

SELECT * FROM bronze.crm_cust_info;

SET @start_time = GETDATE();
PRINT'>>Truncating The Table: bronze.crm_prd_info';
TRUNCATE TABLE bronze.crm_prd_info;
PRINT'>>Inserting The Data into : bronze.crm_prd_info';
BULK INSERT bronze.crm_prd_info
FROM 'C:\Users\HP\Downloads\sql-data-warehouse-project (2)\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
SET @end_time = GETDATE();
PRINT'>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT'>>-----------------';

SELECT * FROM bronze.crm_prd_info;


DROP TABLE IF EXISTS bronze.crm_sales_details;

SET @start_time = GETDATE();
PRINT'>>Creating The Table: bronze.crm_sales_details';
CREATE TABLE bronze.crm_sales_details (
    sls_ord_num   NVARCHAR(50),
    sls_prd_key   NVARCHAR(50),
    sls_cust_id   INT,
    sls_order_dt  INT,
    sls_ship_dt   INT,
    sls_due_dt    INT,
    sls_sales     INT,
    sls_quantity  INT,
    sls_price     INT
);

PRINT'>>Inserting The Data into : bronze.crm_sales_details';
BULK INSERT bronze.crm_sales_details
FROM 'C:\Users\HP\Downloads\sql-data-warehouse-project (2)\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

SET @end_time = GETDATE();
PRINT'>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT'>>-----------------';

SELECT * FROM bronze.crm_sales_details;


PRINT'---------------------------------------------------------';
PRINT'Loading ERP tables';
PRINT'---------------------------------------------------------';
SET @start_time = GETDATE();
PRINT'>>Truncating The Table: bronze.erp_CUST_AZ12';
TRUNCATE TABLE bronze.erp_CUST_AZ12;
PRINT'>>Inserting The Data into : bronze.erp_CUST_AZ12';
BULK INSERT bronze.erp_CUST_AZ12
FROM 'C:\Users\HP\Downloads\sql-data-warehouse-project (2)\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
SET @end_time = GETDATE();
PRINT'>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT'>>-----------------';

SELECT * FROM bronze.erp_CUST_AZ12;
SET @start_time = GETDATE();
PRINT'>>Truncating The Table: bronze.erp_LOC_A101';
TRUNCATE TABLE bronze.erp_LOC_A101;
PRINT'>>Inserting The Data into : bronze.erp_LOC_A101';
BULK INSERT bronze.erp_LOC_A101
FROM 'C:\Users\HP\Downloads\sql-data-warehouse-project (2)\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
SET @end_time = GETDATE();
PRINT'>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT'>>-----------------';

SELECT * FROM bronze.erp_LOC_A101;

SET @start_time = GETDATE();
PRINT'>>Truncating The Table: bronze.erp_PX_CAT_G1V2';
TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
PRINT'>>Inserting The Data into : bronze.erp_PX_CAT_G1V2';
BULK INSERT bronze.erp_PX_CAT_G1V2
FROM 'C:\Users\HP\Downloads\sql-data-warehouse-project (2)\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);

SET @end_time = GETDATE();
PRINT'>>Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds';
PRINT'>>-----------------';

END TRY
BEGIN CATCH
PRINT'=========================================='
PRINT'ERROR OCCURED DURING BRONZE LAYER'
PRINT'Error Messege' + ERROR_MESSAGE();
PRINT'Error Messege' + CAST (ERROR_NUMBER() AS NVARCHAR);
PRINT'Error Messege' + CAST (ERROR_STATE() AS NVARCHAR);
PRINT'=========================================='
END CATCH

END;
GO
