-- Store and City Analysis


-- Store Performance Analysis
-- COMMAND --
-- Top 10 stores in terms of incremental revenue generated
SELECT 
	store_id,
	FORMAT ((SUM(revenue_before_promo)), 2) AS total_rbp,
    FORMAT ((SUM(revenue_after_promo)), 2) AS total_rap,
    FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue
FROM events_summary_data
GROUP BY store_id
ORDER BY total_incremental_revenue DESC
LIMIT 10                                                                          

	
-- COMMAND --
-- Top 10 stores in terms of incremental sold units
SELECT 
	store_id,
	FORMAT ((SUM(quantity_sold_before_promo)), 0) AS total_qsbp,
    FORMAT ((SUM(quantity_sold_after_promo)), 0) AS total_qsap,
	FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units
FROM events_summary_data
GROUP BY store_id
ORDER BY total_incremental_units DESC
LIMIT 10

	
-- COMMAND --
-- High performance stores common in the top 10 lists for incremental revenue generated and incremental sold units, and their locations (cities).
WITH 
	RevenueTopStores AS (
	SELECT 
		store_id,
		FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue
	FROM events_summary_data
	GROUP BY store_id
	ORDER BY total_incremental_revenue DESC
	LIMIT 10
	),
	UnitsTopStores AS (
	SELECT 
		store_id,
        FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units
	FROM events_summary_data
	GROUP BY store_id
	ORDER BY total_incremental_units DESC
	LIMIT 10
	),
	TopStores AS (
	SELECT DISTINCT store_id 
    FROM RevenueTopStores
	UNION
	SELECT DISTINCT store_id 
    FROM UnitsTopStores
	)
SELECT DISTINCT ts.store_id,
       esd.city,
       rts.total_incremental_revenue,
       uts.total_incremental_units
FROM TopStores AS ts
JOIN RevenueTopStores AS rts ON ts.store_id = rts.store_id
JOIN UnitsTopStores AS uts ON ts.store_id = uts.store_id
JOIN events_summary_data AS esd ON ts.store_id = esd.store_id
GROUP BY ts.store_id, esd.city, rts.total_incremental_revenue, uts.total_incremental_units
ORDER BY rts.total_incremental_revenue DESC, uts.total_incremental_units DESC

	
-- COMMAND --
-- Bottom 10 stores in terms of incremental revenue generated
SELECT 
	store_id,
	FORMAT ((SUM(revenue_before_promo)), 2) AS total_rbp,
    FORMAT ((SUM(revenue_after_promo)), 2) AS total_rap,
    FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue
FROM events_summary_data
GROUP BY store_id
ORDER BY total_incremental_revenue ASC
LIMIT 10    

	
-- COMMAND --
-- Bottom 10 stores in terms of incremental sold units
SELECT 
	store_id,
	FORMAT ((SUM(quantity_sold_before_promo)), 0) AS total_qsbp,
    FORMAT ((SUM(quantity_sold_after_promo)), 0) AS total_qsap,
	FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units
FROM events_summary_data
GROUP BY store_id
ORDER BY total_incremental_units ASC
LIMIT 10

	
-- COMMAND --
-- Low performance stores common in the bottom 10 lists for incremental revenue generated and incremental sold units, and their locations (cities).
WITH 
	RevenueBottomStores AS (
	SELECT 
		store_id,
		FORMAT ((SUM(incremental_revenue_generated)), 2) AS total_incremental_revenue
	FROM events_summary_data
	GROUP BY store_id
	ORDER BY total_incremental_revenue ASC
	LIMIT 10
	),
	UnitsBottomStores AS (
	SELECT 
		store_id,
        FORMAT ((SUM(incremental_sold_units)), 0) AS total_incremental_units
	FROM events_summary_data
	GROUP BY store_id
	ORDER BY total_incremental_units ASC
	LIMIT 10
	),
	BottomStores AS (
	SELECT DISTINCT store_id 
    FROM RevenueBottomStores
	UNION
	SELECT DISTINCT store_id 
    FROM UnitsBottomStores
	)
SELECT DISTINCT bs.store_id,
       esd.city,
       rbs.total_incremental_revenue,
       ubs.total_incremental_units
FROM BottomStores AS bs
JOIN RevenueBottomStores AS rbs ON bs.store_id = rbs.store_id
JOIN UnitsBottomStores AS ubs ON bs.store_id = ubs.store_id
JOIN events_summary_data AS esd ON bs.store_id = esd.store_id
GROUP BY bs.store_id, esd.city, rbs.total_incremental_revenue, ubs.total_incremental_units
ORDER BY rbs.total_incremental_revenue ASC, ubs.total_incremental_units ASC


-- City Performance Analysis
-- COMMAND --
-- Store count in each city 
SELECT 
	city,
	COUNT(DISTINCT store_id) AS store_count
FROM events_summary_data
GROUP BY city
ORDER BY store_count DESC

	
-- COMMAND --
-- Average performance by city ranked based on incremental revenue generated and incremental sold units
SELECT 
	RANK() OVER(ORDER BY (AVG(incremental_revenue_generated)) DESC, (AVG(incremental_sold_units)) DESC) AS city_performance_ranking,
	city,
    COUNT(DISTINCT store_id) AS store_count,
	FORMAT ((AVG(incremental_revenue_generated)), 2) AS avg_incremental_revenue,
	FORMAT ((AVG(incremental_sold_units)), 0) AS avg_incremental_units
FROM events_summary_data
GROUP BY city

	
-- COMMAND --
-- Identifying cities with the top performing stores
-- (to spot common location characteristics among top-performing stores and how these could be leveraged across other stores)
WITH 
	TopStores AS (
    SELECT 
		store_id
    FROM events_summary_data
    GROUP BY store_id
    ORDER BY SUM(incremental_revenue_generated) DESC
	LIMIT 10
    )
SELECT 
	ts.store_id,
	esd.city,
    FORMAT ((AVG(esd.incremental_revenue_generated)), 2) AS avg_incremental_revenue,
    FORMAT ((AVG(esd.incremental_sold_units)), 0) AS avg_incremental_units
FROM TopStores AS ts
JOIN events_summary_data AS esd ON ts.store_id = esd.store_id
GROUP BY ts.store_id, esd.city
ORDER BY avg_incremental_revenue DESC, avg_incremental_units DESC

	
-- COMMAND --
-- Identifying cities with bottom-performing stores to pinpoint how they can leverage the common characteristics among top-performing stores 
WITH 
	BottomStores AS (
    SELECT 
		store_id
    FROM events_summary_data
    GROUP BY store_id
    ORDER BY SUM(incremental_revenue_generated) ASC
    LIMIT 10
    )
SELECT 
	bs.store_id,
	esd.city,
    FORMAT ((AVG(esd.incremental_revenue_generated)), 2) AS avg_incremental_revenue,
    FORMAT ((AVG(esd.incremental_sold_units)), 0) AS avg_incremental_units
FROM BottomStores AS bs
JOIN events_summary_data AS esd ON bs.store_id = esd.store_id
GROUP BY bs.store_id, esd.city
ORDER BY avg_incremental_revenue ASC, avg_incremental_units ASC                
