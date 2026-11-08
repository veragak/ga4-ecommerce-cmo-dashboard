-- Unique users per funnel step, counted per day and summed (as in the dashboard)
WITH daily AS (
  SELECT event_date,
    COUNT(DISTINCT IF(event_name = 'view_item',      user_pseudo_id, NULL)) AS viewed_product,
    COUNT(DISTINCT IF(event_name = 'add_to_cart',    user_pseudo_id, NULL)) AS added_to_cart,
    COUNT(DISTINCT IF(event_name = 'begin_checkout', user_pseudo_id, NULL)) AS started_checkout,
    COUNT(DISTINCT IF(event_name = 'purchase',       user_pseudo_id, NULL)) AS purchased
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  GROUP BY event_date
)
SELECT SUM(viewed_product) AS viewed_product, SUM(added_to_cart) AS added_to_cart,
       SUM(started_checkout) AS started_checkout, SUM(purchased) AS purchased
FROM daily;
