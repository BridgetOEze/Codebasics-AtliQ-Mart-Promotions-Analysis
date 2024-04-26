-- Product and Category Analysis

-- Product Performance Analysis
-- COMMAND --
-- Top 5 products in terms of incremental revenue generated
SELECT 
	product_code,
	product_name,
	category,
    promo_type,
    FORMAT ((SUM(revenue_before_promo)), 2) AS total_rbp,
    FORMAT ((SUM(revenue_after_promo)), 2) AS total_rap,
	FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue
FROM events_summary_data
GROUP BY product_code, product_name, category, promo_type  
ORDER BY total_incremental_revenue DESC
LIMIT 5                                              

-- COMMAND --
-- Top 5 products in terms of incremental revenue percentage (IRU%) ranking
SELECT 
	RANK () OVER (ORDER BY (AVG(CASE
		WHEN revenue_before_promo = 0 THEN NULL
		ELSE (incremental_revenue_generated / revenue_before_promo) * 100
		END)) DESC) AS 'IR%_rankig',
	product_name,
    base_price,
	category,
    promo_type,
	FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue,
	CONCAT(ROUND(
    AVG(CASE
		WHEN revenue_before_promo = 0 THEN NULL
		ELSE (incremental_revenue_generated / revenue_before_promo) * 100
		END), 2), '%') AS 'avg_IR%'
FROM events_summary_data
GROUP BY product_name, base_price, category, promo_type  
LIMIT 5                                              

-- COMMAND --
-- Top 5 products in terms of incremental sold units
SELECT 
	product_code,
    product_name,
    category,
    promo_type,
    FORMAT ((SUM(quantity_sold_before_promo)), 0) AS total_qsbp,
    FORMAT ((SUM(quantity_sold_after_promo)), 0) AS total_qsap,
	FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units
FROM events_summary_data
GROUP BY product_code, product_name, category, promo_type
ORDER BY total_incremental_units DESC
LIMIT 5

-- COMMAND --
-- Top 5 products in terms of incremental sold units percentage (ISU%) ranking
SELECT 
	RANK () OVER (ORDER BY (AVG(CASE
		WHEN quantity_sold_before_promo = 0 THEN NULL
        ELSE (incremental_sold_units / quantity_sold_before_promo) * 100
		END)) DESC) AS 'ISU%_rankig',
	product_code,
    product_name,
    category,
    promo_type,
	FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units,
    CONCAT(ROUND(
    AVG(CASE
		WHEN quantity_sold_before_promo = 0 THEN NULL
        ELSE (incremental_sold_units / quantity_sold_before_promo) * 100
        END), 2), '%') AS 'avg_ISU%' 
FROM events_summary_data
GROUP BY product_code, product_name, category, promo_type
LIMIT 5

-- COMMAND --
-- Top products with high performance in both incremental revenue generated and incremental sold units
WITH 
	RevenueTopProducts AS (
	SELECT 
		product_code,
		FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue
	FROM events_summary_data
	GROUP BY product_code
	ORDER BY total_incremental_revenue DESC
	LIMIT 5
	),
	UnitsTopProducts AS (
	SELECT 
		product_code,
        FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units
	FROM events_summary_data
	GROUP BY product_code
	ORDER BY total_incremental_units DESC
	LIMIT 5
	),
	TopProducts AS (
	SELECT DISTINCT product_code 
    FROM RevenueTopProducts
	UNION
	SELECT DISTINCT product_code
    FROM UnitsTopProducts
	)
SELECT DISTINCT tp.product_code,
	esd.product_name,
	esd.category,
	rtp.total_incremental_revenue,
    utp.total_incremental_units
FROM TopProducts AS tp
JOIN RevenueTopProducts AS rtp ON tp.product_code = rtp.product_code
JOIN UnitsTopProducts AS utp ON tp.product_code = utp.product_code
JOIN events_summary_data AS esd ON tp.product_code = esd.product_code
GROUP BY tp.product_code, esd.product_name, esd.category, rtp.total_incremental_revenue, utp.total_incremental_units
ORDER BY rtp.total_incremental_revenue DESC, utp.total_incremental_units DESC

-- COMMAND --
-- Bottom 5 products in terms of incremental revenue generated
SELECT 
	product_code,
	product_name,
	category,
    promo_type,
    FORMAT ((SUM(revenue_before_promo)), 2) AS total_rbp,
	FORMAT ((SUM(revenue_after_promo)), 2) AS total_rap,
	FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue
FROM events_summary_data
GROUP BY product_code, product_name, category, promo_type  
ORDER BY total_incremental_revenue ASC
LIMIT 5                 

-- COMMAND --
-- Bottom 5 products in terms of incremental revenue percentage (IRU%) 
SELECT 
	product_code,
	product_name,
	category,
    promo_type,
	FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue,
    CONCAT(ROUND(
	AVG(CASE
		WHEN revenue_before_promo = 0 THEN NULL
		ELSE (incremental_revenue_generated / revenue_before_promo) * 100
		END), 2), '%') AS 'avg_IR%'
FROM events_summary_data
GROUP BY product_code, product_name, category, promo_type  
ORDER BY 'avg_IR%' 
LIMIT 5                                       

-- COMMAND --
-- Bottom 5 products in terms of incremental sold units
SELECT 
	product_code,
    product_name,
    category,
    promo_type,
    FORMAT ((SUM(quantity_sold_before_promo)), 0) AS total_qsbp,
    FORMAT ((SUM(quantity_sold_after_promo)), 0) AS total_qsap,
	FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units
FROM events_summary_data
GROUP BY product_code, product_name, category, promo_type
ORDER BY total_incremental_units
LIMIT 5

-- COMMAND --
-- Bottom 5 products in terms of incremental sold units percentage (ISU%) 
SELECT 
	product_code,
    product_name,
    category,
    promo_type,
	FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units,
    CONCAT(ROUND(
    AVG(CASE
		WHEN quantity_sold_before_promo = 0 THEN NULL
        ELSE (incremental_sold_units / quantity_sold_before_promo) * 100
        END), 2), '%') AS 'avg_ISU%' 
FROM events_summary_data
GROUP BY product_code, product_name, category, promo_type
ORDER BY 'avg_ISU%'
LIMIT 5

-- COMMAND --
-- Products with low performance in both incremental revenue generated and incremental sold units
WITH 
	RevenueTopProducts AS (
	SELECT 
		product_code,
		FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue
	FROM events_summary_data
	GROUP BY product_code
	ORDER BY total_incremental_revenue ASC
	LIMIT 5
	),
	UnitsTopProducts AS (
	SELECT 
		product_code,
        FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units
	FROM events_summary_data
	GROUP BY product_code
	ORDER BY total_incremental_units ASC
	LIMIT 5
	),
	TopProducts AS (
	SELECT DISTINCT product_code 
    FROM RevenueTopProducts
	UNION
	SELECT DISTINCT product_code
    FROM UnitsTopProducts
	)
SELECT DISTINCT tp.product_code,
	esd.product_name,
	esd.category,
	rtp.total_incremental_revenue,
    utp.total_incremental_units
FROM TopProducts AS tp
JOIN RevenueTopProducts AS rtp ON tp.product_code = rtp.product_code
JOIN UnitsTopProducts AS utp ON tp.product_code = utp.product_code
JOIN events_summary_data AS esd ON tp.product_code = esd.product_code
GROUP BY tp.product_code, esd.product_name, esd.category, rtp.total_incremental_revenue, utp.total_incremental_units
ORDER BY rtp.total_incremental_revenue ASC, utp.total_incremental_units ASC

-- COMMAND --
-- Identifying high-value products with heavy discounts
-- List of products with a base price greater than 500 and are featured in promo type of BOGOF(Buy One Get One Free)
SELECT
	DISTINCT product_code,
    product_name,
    base_price AS 'base_price_>500',
    promo_type
FROM events_summary_data
WHERE base_price > 500 AND promo_type = 'BOGOF'

-- COMMAND --
-- Total number of products sold before and after the promotions, and the totals of the key performance indicators (KPIs)
-- where QSBP = 'quantity sold before promo' and QSAP - 'quantity sold after promo'
SELECT
	FORMAT ((SUM(quantity_sold_before_promo)), 0) AS total_QSBP,
    FORMAT ((SUM(quantity_sold_after_promo)), 0) AS total_QSAP,
    FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units,
    FORMAT ((SUM(revenue_before_promo)), 2) AS total_revenue_before_promo,
    FORMAT ((SUM(revenue_after_promo)), 2) AS total_revenue_after_promo,
    FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue    
FROM events_summary_data
    

-- Category Performance Analysis
-- COMMAND --
-- Category performance based on incremental revenue generated during the Diwali campaign
SELECT 
	RANK() OVER (ORDER BY (SUM(incremental_revenue_generated)) DESC) AS total_IR_ranking,
	category,
    FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue
FROM events_summary_data
WHERE campaign_name = 'Diwali'
GROUP BY category

-- COMMAND --
-- Category performance based on incremental revenue percentage (IR%) during the Diwali campaign
SELECT 
	RANK() OVER (ORDER BY ((SUM(incremental_revenue_generated) / NULLIF(SUM(revenue_before_promo), 0)) * 100) DESC) AS 'IR%_ranking',
    category,
    FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue,
    CONCAT(ROUND(
    ((SUM(incremental_revenue_generated) / NULLIF(SUM(revenue_before_promo), 0)) * 100), 2), '%') AS 'IR%'
FROM events_summary_data
WHERE campaign_name = 'Diwali'
GROUP BY category

-- COMMAND --
-- Category performance based on incremental sold units during the Diwali campaign
SELECT 
	RANK() OVER (ORDER BY (SUM(incremental_sold_units)) DESC) AS total_ISU_ranking,
	category,
    FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units
FROM events_summary_data
WHERE campaign_name = 'Diwali'
GROUP BY category

-- COMMAND --
-- Category performance based on incremental sold unit percentage (ISU%) during the Diwali campaign
SELECT 
	RANK() OVER (ORDER BY ((SUM(incremental_sold_units) / NULLIF(SUM(quantity_sold_before_promo), 0)) * 100) DESC) AS 'ISU%_ranking',
    category,
    FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units,
    CONCAT(ROUND(
    ((SUM(incremental_sold_units) / NULLIF(SUM(quantity_sold_before_promo), 0)) * 100), 2), '%') AS 'ISU%'
FROM events_summary_data
WHERE campaign_name = 'Diwali'
GROUP BY category

-- COMMAND --
-- Category performance based on incremental revenue generated during the Sankranti campaign
SELECT 
	RANK() OVER (ORDER BY (SUM(incremental_revenue_generated)) DESC) AS total_IR_ranking,
	category,
    FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue
FROM events_summary_data
WHERE campaign_name = 'Sankranti'
GROUP BY category

-- COMMAND --
-- Category performance based on incremental revenue percentage (IR%) during the Sankranti campaign
SELECT 
	RANK() OVER (ORDER BY ((SUM(incremental_revenue_generated) / NULLIF(SUM(revenue_before_promo), 0)) * 100) DESC) AS 'IR%_ranking',
    category,
    FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue,
    CONCAT(ROUND(
    ((SUM(incremental_revenue_generated) / NULLIF(SUM(revenue_before_promo), 0)) * 100), 2), '%') AS 'IR%'
FROM events_summary_data
WHERE campaign_name = 'Sankranti'
GROUP BY category

-- COMMAND --
-- Category performance based on incremental sold units during the Sankranti campaign
SELECT 
	RANK() OVER (ORDER BY (SUM(incremental_sold_units)) DESC) AS total_ISU_ranking,
	category,
    FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units
FROM events_summary_data
WHERE campaign_name = 'Sankranti'
GROUP BY category

-- COMMAND --
-- Category performance based on incremental sold unit percentage (ISU%) during the Sankranti campaign
SELECT 
	RANK() OVER (ORDER BY ((SUM(incremental_sold_units) / NULLIF(SUM(quantity_sold_before_promo), 0)) * 100) DESC) AS 'ISU%_ranking',
    category,
    FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units,
    CONCAT(ROUND(
    ((SUM(incremental_sold_units) / NULLIF(SUM(quantity_sold_before_promo), 0)) * 100), 2), '%') AS 'ISU%'
FROM events_summary_data
WHERE campaign_name = 'Sankranti'
GROUP BY category

-- COMMAND --
-- Category performance based on incremental revenue generated during the entire campaign period
SELECT 
	RANK() OVER (ORDER BY (SUM(incremental_revenue_generated)) DESC) AS total_IR_ranking,
	category,
    FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue
FROM events_summary_data
GROUP BY category

-- COMMAND --
-- Category performance based on incremental revenue percentage (IR%) during the entire campaign period
SELECT 
	RANK() OVER (ORDER BY ((SUM(incremental_revenue_generated) / NULLIF(SUM(revenue_before_promo), 0)) * 100) DESC) AS 'IR%_ranking',
    category,
    FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue,
    CONCAT(ROUND(
    ((SUM(incremental_revenue_generated) / NULLIF(SUM(revenue_before_promo), 0)) * 100), 2), '%') AS 'IR%'
FROM events_summary_data
GROUP BY category

-- COMMAND --
-- Category performance based on incremental sold units during the entire campaign period
SELECT 
	RANK() OVER (ORDER BY (SUM(incremental_sold_units)) DESC) AS total_ISU_ranking,
	category,
    FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units
FROM events_summary_data
GROUP BY category

-- COMMAND --
-- Category performance based on incremental sold unit percentage (ISU%) during the entire campaign period
SELECT 
	RANK() OVER (ORDER BY ((SUM(incremental_sold_units) / NULLIF(SUM(quantity_sold_before_promo), 0)) * 100) DESC) AS 'ISU%_ranking',
    category,
    FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units,
    CONCAT(ROUND(
    ((SUM(incremental_sold_units) / NULLIF(SUM(quantity_sold_before_promo), 0)) * 100), 2), '%') AS 'ISU%'
FROM events_summary_data
GROUP BY category

-- COMMAND --
-- Assessing the correlation between product category and promotion type effectiveness
SELECT 
	category, 
    promo_type,
    FORMAT ((AVG(incremental_sold_units)), 0) AS avg_incremental_units,
    FORMAT ((AVG(incremental_revenue_generated)), 2) AS avg_incremental_revenue
FROM events_summary_data
GROUP BY category, promo_type
ORDER BY avg_incremental_revenue DESC

