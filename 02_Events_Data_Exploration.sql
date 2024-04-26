-- Data Exploration

-- COMMAND --
-- column names and their data types
SHOW COLUMNS
FROM events_combined_data

-- COMMAND --
-- checking for NULL values in all columns
SELECT 
	COUNT(*) - COUNT(event_id) AS event_id,
	COUNT(*) - COUNT(store_id) AS store_id,
	COUNT(*) - COUNT(city) AS city,
    COUNT(*) - COUNT(campaign_id) AS campaign_name,
	COUNT(*) - COUNT(start_date) AS start_date,
	COUNT(*) - COUNT(end_date) AS end_date,
    COUNT(*) - COUNT(product_code) AS product_code,
	COUNT(*) - COUNT(product_name) AS product_name,
	COUNT(*) - COUNT(category) AS category,
    COUNT(*) - COUNT(base_price) AS base_price,
	COUNT(*) - COUNT(promo_type) AS promo_type,
	COUNT(*) - COUNT(quantity_sold_before_promo) AS quantity_sold_before_promo,
    COUNT(*) - COUNT(quantity_sold_after_promo) AS quantity_sold_after_promo
FROM events_combined_data

-- COMMAND --
-- checking for Duplicates
SELECT 
	COUNT(event_id) - COUNT(DISTINCT(event_id)) AS num_duplicate_rows
FROM events_combined_data                                                                             -- there are no Duplicates

-- COMMAND --
-- checking for outliers - any sales not within the campaign periods
SELECT *
FROM events_combined_data
WHERE 
    (campaign_name = 'Diwali' AND (start_date NOT BETWEEN '2023-11-12' AND '2023-11-18' OR end_date NOT BETWEEN '2023-11-12' AND '2023-11-18'))
    OR 
    (campaign_name = 'Sankranti' AND (start_date NOT BETWEEN '2024-01-10' AND '2024-01-16' OR end_date NOT BETWEEN '2024-01-10' AND '2024-01-16'))
    
-- COMMAND --
-- promo_type - the 5 unique types of promotions applied
SELECT 
	promo_type, COUNT(promo_type) AS no_of_promo_type
FROM events_combined_data
GROUP BY promo_type
ORDER BY no_of_promo_type DESC

-- COMMAND --
-- campaign duration
SELECT 
	DISTINCT(campaign_id), 
    campaign_name, 
    end_date - start_date AS campaign_duration
FROM events_combined_data

-- COMMAND --
-- number of stores in each city
SELECT 
	city, 
    COUNT(DISTINCT store_id) AS store_count
FROM events_combined_data
GROUP BY city
ORDER BY store_count DESC

