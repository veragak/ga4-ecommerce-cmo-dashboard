SELECT item.item_name, ROUND(SUM(item.item_revenue_in_usd), 2) AS revenue
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`, UNNEST(items) AS item
WHERE event_name = 'purchase'
GROUP BY item.item_name
ORDER BY revenue DESC
LIMIT 10;
