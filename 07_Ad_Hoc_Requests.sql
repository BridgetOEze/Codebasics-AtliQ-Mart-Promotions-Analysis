-- Addressing Specified Business Questions 


-- COMMAND --
-- No.1
-- Identify hihg-value products that are currently being heavily discounted
-- products with a base price >500 and are featured in the BOGOF promo type
SELECT
	DISTINCT product_code,
    product_name,
    base_price AS 'base_price_>500',
    promo_type
FROM events_summary_data
WHERE base_price > 500 AND promo_type = 'BOGOF'

	
-- COMMAND --
-- No.2
-- Identify the cities with the highest store presence
-- overview of the number of stores in each city
SELECT 
	city,
	COUNT(DISTINCT store_id) AS store_count
FROM events_summary_data
GROUP BY city
ORDER BY store_count DESC

	
-- COMMAND --
-- No.3
-- Evaluating the financial impact of the promotional campaigns
-- total revenue generated before and after each campaign
SELECT 
	campaign_name,
	FORMAT ((SUM(revenue_before_promo)), 2) AS total_revenue_before_promo,
	FORMAT ((SUM(revenue_after_promo)), 2) AS total_revenue_after_promo,
    FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue
FROM events_summary_data
GROUP BY campaign_name
ORDER BY total_incremental_revenue DESC

	
-- COMMAND --
-- No.4
-- Assessing the category-wise success and impact of the Diwali campaign on incremental sales
-- incremental sold unit percentage (ISU%) for each category during the Diwali campaign
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
-- No.5
-- Identify the most successful products in terms of incremental revenue across both campaigns
-- top 5 products, ranked by incremental revenue percentage (IR%) across all campaigns
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
