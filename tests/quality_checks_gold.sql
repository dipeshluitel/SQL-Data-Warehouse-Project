/*
Script Purpose:
  This script performs various quality checks for data consistency and accuracy  within the 'Gold' Layer
    - Check for Duplicate
	- Check for Foreign Key Integrity (Dimensions)
*/


/*
-----------------------------------------
Checkin 'gold.dim_customers'
-----------------------------------------
*/
--Check Unique Rows (Duplicates)
--Expec: No Result
SELECT 
	customer_key, 
	COUNT(*) 
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

--Check For valid Data Integration (Note: Integrated GENDER data from crm_cust_info and erp_cust_az12, crm_cust_info is the Master Table for gender data so checking if all the data are valid after Using CASE)
SELECT 
	DISTINCT gender 
FROM gold.dim_customers;

/*
-----------------------------------------
Checkin 'gold.dim_products'
-----------------------------------------
*/
--Check Unique Rows (Duplicates)
--Expec: No Result
SELECT 
	product_key, 
	COUNT(*) 
FROM gold.dim_products
GROUP BY product_key
HAVING COUNT(*) > 1;

/*
-----------------------------------------
Checkin 'gold.fact_sales'
-----------------------------------------
*/
-- Foreign Key Integrity (Dimensions)
--Expec: No Result
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON f.customer_key = c.customer_key
LEFT JOIN gold.dim_products p
ON f.product_key = p.product_key
WHERE c.customer_key IS NULL OR p.product_key IS NULL
