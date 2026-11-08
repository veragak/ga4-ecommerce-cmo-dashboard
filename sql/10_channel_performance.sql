WITH ev AS (
  SELECT event_name, event_value_in_usd,
    CASE
      WHEN traffic_source.medium = 'organic'  THEN 'Organic Search'
      WHEN traffic_source.medium = 'cpc'      THEN 'Paid Search'
      WHEN traffic_source.medium = 'referral' THEN 'Referral'
      WHEN traffic_source.medium = '(none)'   THEN 'Direct'
      ELSE 'Other / Unattributed'
    END AS channel
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
)
SELECT channel,
  COUNTIF(event_name = 'purchase') AS transactions,
  ROUND(SUM(IF(event_name = 'purchase', event_value_in_usd, 0)), 2) AS total_revenue,
  COUNTIF(event_name = 'session_start') AS sessions,
  ROUND(COUNTIF(event_name = 'purchase') * 100.0 / NULLIF(COUNTIF(event_name = 'session_start'), 0), 2) AS conversion_rate_pct
FROM ev
GROUP BY channel
ORDER BY total_revenue DESC;
