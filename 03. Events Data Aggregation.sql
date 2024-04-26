-- Data Aggregation

-- Calculating the incremental sold units, revenue before promo, revenue after promo, and incremental revenue generated
-- Calculating the ISU%(incremental sold unit percent) and the IR%(incremental revenue generated percent)
-- Creating a new table with the summarized/aggregated data: new table - 'events_summary_data'

-- To calculate the revenue before and after promotions, the promo_type needs to be taken account of as it affects the price.
-- The 'revenue before promotions' can be calculated directly just like the 'incremental sold units'
-- For 'revenue after promotions', the promo_type needs to be taken into account.
	-- "33% OFF" means the item is sold at 67% of the base price * quantity_sold_after_promo
	-- "25% OFF" means the item is sold at 75% of the base price * quantity_sold_after_promo
	-- "50% OFF" means the item is sold at 50% of the base price * quantity_sold_after_promo
	-- "BOGOF" means two items are sold for the price of one, effectively making it 50% off if exactly two are bought, the item is sold at the base price * (quantity_sold_after_promo/2)
	-- "500 Cashback" means the item sold at the (base price - 500) * quantity_sold_after_promo


CREATE TABLE events_summary_data AS (
SELECT
	event_id,
    store_id,
    city,
    campaign_id,
    campaign_name,
    start_date,
    end_date,
    product_code,
    product_name,
    category,
    base_price,
    promo_type,
    quantity_sold_before_promo,
    quantity_sold_after_promo,
    quantity_sold_after_promo - quantity_sold_before_promo AS incremental_sold_units,                             -- incremental sold units during the promotions
    ((quantity_sold_after_promo - quantity_sold_before_promo) / quantity_sold_before_promo) * 100 AS 'ISU%',      -- % increase/decrease in quantity sold after promo compared to quantity sold before promo
    quantity_sold_before_promo * base_price AS revenue_before_promo,                                              -- revenue generated before the promotions
    CASE
		WHEN promo_type = '25% OFF' THEN (quantity_sold_after_promo * base_price) * (1 - 0.25)
        WHEN promo_type = '33% OFF' THEN (quantity_sold_after_promo * base_price) * (1 - 0.33)
        WHEN promo_type = '50% OFF' THEN (quantity_sold_after_promo * base_price) * (1 - 0.5)
        WHEN promo_type = '500 Cashback' THEN (base_price - 500) * quantity_sold_after_promo
        ELSE base_price * (quantity_sold_after_promo / 2)
	END AS revenue_after_promo,                                                                                   -- revenue generated after the promotions
    (CASE
		WHEN promo_type = '25% OFF' THEN (quantity_sold_after_promo * base_price) * (1 - 0.25)
        WHEN promo_type = '33% OFF' THEN (quantity_sold_after_promo * base_price) * (1 - 0.33)
        WHEN promo_type = '50% OFF' THEN (quantity_sold_after_promo * base_price) * (1 - 0.5)
        WHEN promo_type = '500 Cashback' THEN (base_price - 500) * quantity_sold_after_promo
        ELSE base_price * (quantity_sold_after_promo / 2)
	END) - (quantity_sold_before_promo * base_price) AS incremental_revenue_generated,                            -- incremental revenue generated from the promotions
	(((CASE
		WHEN promo_type = '25% OFF' THEN (quantity_sold_after_promo * base_price) * (1 - 0.25)
        WHEN promo_type = '33% OFF' THEN (quantity_sold_after_promo * base_price) * (1 - 0.33)
        WHEN promo_type = '50% OFF' THEN (quantity_sold_after_promo * base_price) * (1 - 0.5)
        WHEN promo_type = '500 Cashback' THEN (base_price - 500) * quantity_sold_after_promo
        ELSE base_price * (quantity_sold_after_promo / 2)
	END) - (quantity_sold_before_promo * base_price)) / (quantity_sold_before_promo * base_price)) * 100 AS 'IR%' -- % increase/decrease in the revenue generated after the promo compared to the revenue generated before the promo
FROM events_combined_data
)
