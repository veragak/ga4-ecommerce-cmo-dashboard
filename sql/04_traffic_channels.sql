SELECT
  IFNULL(traffic_source.medium, '(none)') AS medium,
  IFNULL(traffic_source.source, '(direct)') AS source,
  COUNT(DISTINCT user_pseudo_id) AS users,
  COUNTIF(event_name = 'session_start') AS sessions
FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
GROUP BY medium, source
ORDER BY sessions DESC;
