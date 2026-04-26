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


 
