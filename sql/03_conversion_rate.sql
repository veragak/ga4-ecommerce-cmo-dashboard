WITH sessions AS (
  SELECT PARSE_DATE('%Y%m%d', event_date) AS date,
         COUNTIF(event_name = 'session_start') AS sessions
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  GROUP BY date
),
purchases AS (
  SELECT PARSE_DATE('%Y%m%d', event_date) AS date,
         COUNT(*) AS transactions
  FROM `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
  WHERE event_name = 'purchase'
  GROUP BY date
)
SELECT s.date, s.sessions,
  COALESCE(p.transactions, 0) AS transactions,
  ROUND(COALESCE(p.transactions, 0) * 100.0 / NULLIF(s.sessions, 0), 2) AS conversion_rate_pct
FROM sessions s LEFT JOIN purchases p USING (date)
ORDER BY s.date;
