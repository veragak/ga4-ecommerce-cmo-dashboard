SELECT
  PARSE_DATE('%Y%m%d', event_date) AS date,
  COUNT(DISTINCT user_pseudo_id) AS total_users,
  COUNTIF(event_name = 'session_start') AS sessions,
  ROUND(COUNTIF(event_name = 'user_engagement') * 100.0
        / NULLIF(COUNTIF(event_name = 'session_start'), 0), 2) AS engagement_rate_pct
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
GROUP BY date
ORDER BY date;
