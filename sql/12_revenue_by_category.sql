SELECT item.item_category, ROUND(SUM(item.item_revenue_in_usd), 2) AS revenue,
  ROUND(SUM(item.item_revenue_in_usd) * 100 / SUM(SUM(item.item_revenue_in_usd)) OVER (), 1) AS share_pct
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`, UNNEST(items) AS item
WHERE event_name = 'purchase'
GROUP BY item.item_category
ORDER BY revenue DESC;
