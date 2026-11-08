SELECT
  PARSE_DATE('%Y%m%d', event_date) AS date,
  COUNT(*) AS transactions,
  ROUND(SUM(event_value_in_usd), 2) AS total_revenue,
  ROUND(SUM(event_value_in_usd) / NULLIF(COUNT(*), 0), 2) AS avg_order_value
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE event_name = 'purchase'
GROUP BY date
ORDER BY date;
