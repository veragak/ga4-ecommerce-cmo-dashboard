SELECT
  IFNULL(traffic_source.medium, '(none)') AS medium,
  IFNULL(traffic_source.source, '(direct)') AS source,
  COUNT(*) AS transactions,
  ROUND(SUM(event_value_in_usd), 2) AS total_revenue,
  ROUND(SUM(event_value_in_usd) / NULLIF(COUNT(*), 0), 2) AS avg_order_value
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE event_name = 'purchase'
GROUP BY medium, source
ORDER BY total_revenue DESC;
