/*
================================
CHECKING 'silver.crm_cust_info'
================================
*/
--check for Nulls or Duplicates in Primary Key
--Expectation: No Result
SELECT 
cst_id,
COUNT(*) 
FROM silver.crm_cust_info
GROUP BY cst_id 
HAVING COUNT(*) > 1 OR cst_id IS NULL;


--check for unwanted spaces(WhiteSpaces)
--Expectation: No Result
SELECT 
cst_firstname
FROM silver.crm_cust_info WHERE TRIM(cst_firstname) != cst_firstname;

SELECT 
cst_lastname
FROM silver.crm_cust_info WHERE TRIM(cst_lastname) != cst_lastname;

-- Data Standarization and Consistency
SELECT DISTINCT cst_gndr 
FROM silver.crm_cust_info

SELECT DISTINCT cst_marital_status 
FROM silver.crm_cust_info

-- Final Overview of Whole Table
SELECT * FROM silver.crm_cust_info


/*
================================
CHECKING 'silver.crm_prd_info'
================================
*/

-- CHECKS for nulls or Duplicates in Primary Keys
--Expectations: No Result
SELECT 
prd_id,
COUNT(*)
FROM silver.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id is NULL


--CHECK FOR UNWANTED SPACES
--EXPEC: NO RESULT
SELECT prd_nm FROM silver.crm_prd_info WHERE prd_nm != TRIM(prd_nm);

--CHECK FOR NULLS OR NEGATIVE NUMBERS
--EXPEC: NO RESULT
SELECT  prd_cost FROM silver.crm_prd_info WHERE prd_cost  < 0 OR prd_cost IS NULL;

--Data Standarization and Normalization
SELECT DISTINCT prd_line FROM silver.crm_prd_info

--Check for Invalid Date Orders
SELECT * 
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt 
  
-- Final Overview of Whole Table
SELECT * FROM silver.crm_prd_info


/*
================================
CHECKING 'silver.crm_sales_details'
================================
*/

--Check For Invalid Dates
--Expectation: No Result
SELECT
NULLIF(sls_order_dt,0) sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0		--Checks For zero or Negative dates
OR LEN(sls_order_dt) != 8	--Checks for incorrect date length
OR sls_order_dt > 20261231	--Checks for Outlier
OR sls_order_dt < 20021208	--Checks for Outlier
  
SELECT
NULLIF(sls_ship_dt,0) sls_ship_dt
FROM bronze.crm_sales_details
WHERE sls_ship_dt <= 0		--Checks For zero or Negative dates
OR LEN(sls_ship_dt) != 8	--Checks for incorrect date length
OR sls_ship_dt > 20261231	--Checks for Outlier
OR sls_ship_dt < 20021208	--Checks for Outlier

SELECT
NULLIF(sls_due_dt,0) sls_due_dt
FROM bronze.crm_sales_details
WHERE sls_due_dt <= 0		--Checks For zero or Negative dates
OR LEN(sls_due_dt) != 8	--Checks for incorrect date length
OR sls_due_dt > 20261231	--Checks for Outlier
OR sls_due_dt < 20021208	--Checks for Outlier

-- The above tests can only be performed in the Bronze schema due to casting reasons

--Check for invalid Date Orders
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_due_dt OR sls_order_dt > sls_ship_dt

--Check Data Consistency: Between sales,quantity and Price
-- Sales = Quantity * Price
-- Values must not be Null, Zero or Negative

SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity*sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <=0 OR sls_price <=0
ORDER BY sls_sales, sls_quantity, sls_price

-- Final Overview of Whole Table
SELECT * FROM silver.crm_sales_details

  
/*
================================
CHECKING 'silver.erp_cust_az12'
================================
*/

--Checks For Invalid(out of range) Dates
SELECT 
bdate FROM silver.erp_cust_az12 
WHERE bdate > GETDATE()

--Data Standarization and Consistency (For Low cardinality Gender)
SELECT 
DISTINCT gen 
FROM silver.erp_cust_az12 

-- Final Overview of Whole Table
SELECT * FROM silver.erp_cust_az12


/*
================================
CHECKING 'silver.erp_loc_a101'
================================
*/

--Data Standarization and Consistency (For Low cardinality/null in country)
SELECT 
DISTINCT cntry
FROM silver.erp_loc_a101

-- Final Overview of Whole Table
SELECT * FROM silver.erp_loc_a101
