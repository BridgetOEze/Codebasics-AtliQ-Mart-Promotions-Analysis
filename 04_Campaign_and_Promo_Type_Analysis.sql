-- Promotion Type and Campaign Analysis


-- Promotion Type Performance Analysis
-- COMMAND --
-- Promotion type performance ranking based on incremental revenue generated
SELECT
	RANK() OVER (ORDER BY (SUM(incremental_revenue_generated)) DESC) AS IR_promo_type_ranking,
	promo_type,
    FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue,
    FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units
FROM events_summary_data
GROUP BY promo_type

-- COMMAND --
-- Promotion type performance ranking based on incremental sold units
SELECT
	RANK() OVER (ORDER BY (SUM(incremental_sold_units)) DESC) AS ISU_promo_type_ranking,
	promo_type,
    FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units,
    FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue
FROM events_summary_data
GROUP BY promo_type

-- COMMAND --
-- Determining if there's a significant difference in the performance of discount-based promotions versus "Buy One Get One Free" (BOGOF) or cashback promotions
SELECT 
	promo_type,
	FORMAT ((AVG(incremental_revenue_generated)), 2) AS avg_incremental_revenue,
    FORMAT ((AVG(incremental_sold_units)), 0) AS avg_incremental_units
FROM events_summary_data
GROUP BY promo_type
ORDER BY avg_incremental_revenue DESC, avg_incremental_units DESC


-- Campaign Performance Analysis
-- COMMAND --
-- Total revenue generated before and after the promotions for each campaign, and the total incremental revenue generated
SELECT 
	campaign_name,
	FORMAT ((SUM(revenue_before_promo)), 2) AS total_revenue_before_promo,
	FORMAT ((SUM(revenue_after_promo)), 2) AS total_revenue_after_promo,
    FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue
FROM events_summary_data
GROUP BY campaign_name
ORDER BY total_incremental_revenue DESC

-- COMMAND --
-- Total units sold before and after the promotions for each campaign, and the total incremental units sold
-- where QSBP = 'quantity sold before promo' and QSAP - 'quantity sold after promo'
SELECT 
	campaign_name,
	FORMAT ((SUM(quantity_sold_before_promo)), 0) AS total_QSBP,
	FORMAT ((SUM(quantity_sold_after_promo)), 0) AS total_QSAP,
	FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units
FROM events_summary_data
GROUP BY campaign_name
ORDER BY total_incremental_units 




