/*
Script purpose :
   This script creates tables in the 'bronze' schema 
   */
   

CREATE TABLE bronze.crm_cust_info(
cst_id INT,
cst_key NVARCHAR(50),
cst_firstname NVARCHAR(50),
cst_lastname NVARCHAR(50),
cst_marital_status NVARCHAR(50),
cst_gndr NVARCHAR(50),
cst_create_date DATE
);

CREATE TABLE bronze.crm_prd_info(
prd_id INT,
prd_key NVARCHAR(50),
prd_name NVARCHAR(50),
prd_cost INT,
prd_line NVARCHAR(50),
prd_start_dt INT,
prd_end_dt DATE
);

CREATE TABLE bronze.crm_sales_details(
sls_ord_num INT,
sls_prd_key NVARCHAR(50),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt INT,
sls_sales INT,
sls_quantity INT,
sls_price INT
);

CREATE TABLE bronze.erp_LOC_A101(
cid NVARCHAR(50),
cntry NVARCHAR(50)
);

CREATE TABLE bronze.erp_CUST_AZ12(
cid NVARCHAR(50),
bdate DATE,
gen NVARCHAR(50)
);

CREATE TABLE bronze.erp_PX_CAT_G1V2(
id NVARCHAR(50),
cat NVARCHAR(50),
subcat NVARCHAR(50),
maintenance NVARCHAR(50)
);
