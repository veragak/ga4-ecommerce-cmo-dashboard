SELECT
  FORMAT_DATE('%A', PARSE_DATE('%Y%m%d', event_date)) AS day_of_week,
  CAST(FORMAT_DATE('%u', PARSE_DATE('%Y%m%d', event_date)) AS INT64) AS day_order,
  COUNT(DISTINCT user_pseudo_id) AS users,
  COUNTIF(event_name = 'session_start') AS sessions,
  COUNTIF(event_name = 'purchase') AS transactions,
  ROUND(SUM(IF(event_name = 'purchase', event_value_in_usd, 0)), 2) AS total_revenue
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
GROUP BY day_of_week, day_order
ORDER BY day_order;
