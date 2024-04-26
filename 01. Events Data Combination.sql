-- Data Combination

-- Combining the data from all 4 tables (fact_events, dim_stores, _dim_products, and dim_campaigns) into a single table 'events_combined_data'


CREATE TABLE events_combined_data AS (
SELECT
	event_id,
    fe.store_id,
    city,
    fe.campaign_id,
    campaign_name,
    start_date,
    end_date,
    fe.product_code,
    product_name,
    category,
    base_price,
    promo_type,
    quantity_sold_before_promo,
    quantity_sold_after_promo
FROM fact_events AS fe
JOIN dim_stores AS ds
	ON fe.store_id = ds.store_id
JOIN dim_campaigns AS dc
	ON fe.campaign_id = dc.campaign_id
JOIN dim_products AS dp
	ON fe.product_code = dp.product_code
    )
