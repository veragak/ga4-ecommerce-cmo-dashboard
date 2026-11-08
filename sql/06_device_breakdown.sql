SELECT
  device.category AS device_type,
  COUNT(DISTINCT user_pseudo_id) AS users,
  COUNTIF(event_name = 'session_start') AS sessions,
  COUNTIF(event_name = 'purchase') AS transactions,
  ROUND(SUM(IF(event_name = 'purchase', event_value_in_usd, 0)), 2) AS total_revenue
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
GROUP BY device_type
ORDER BY sessions DESC;
