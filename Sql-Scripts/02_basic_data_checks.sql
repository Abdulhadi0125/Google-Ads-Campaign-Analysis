--BASIC EDA--

SELECT COUNT(*) FROM campaigns; --1304

SELECT column_name, data_type
FROM information_schema.columns
WHERE table_name = 'campaigns';

SELECT 
  COUNT(*) AS total_rows,
  COUNT(report_date) AS report_date_not_null,
  COUNT(campaign_name) AS campaign_name_not_null,
  COUNT(objective) AS objective_not_null,
  COUNT(reach) AS reach_not_null,
  COUNT(impressions) AS impressions_not_null,
  COUNT(frequency) AS frequency_not_null,
  COUNT(amount_spent) AS amount_spent_not_null,
  COUNT(ctr) AS ctr_not_null,
  COUNT(cpc) AS cpc_not_null,
  COUNT(cpm) AS cpm_not_null,
  COUNT(cost_per_1000_reach) AS cost_per_1000_reach_not_null,
  COUNT(conversions) AS conversions_not_null,
  COUNT(conversion_value) AS conversion_value_not_null,
  COUNT(cost_per_conversion) AS cost_per_conversion_not_null,
  COUNT(post_comments) AS post_comments_not_null,
  COUNT(link_clicks) AS link_clicks_not_null,
  COUNT(messaging_conversations) AS messaging_conversations_not_null
FROM campaigns; --for confirmation of null values


-- Unique campaigns
SELECT DISTINCT campaign_name AS unique_campaigns FROM campaigns; --17


-- Unique objectives
SELECT DISTINCT objective FROM campaigns;


-- Duplicate combinations (if any)
SELECT report_date, campaign_name, COUNT(*) 
FROM campaigns
GROUP BY report_date, campaign_name
HAVING COUNT(*) > 1;

SELECT MIN(report_date) AS start_date, MAX(report_date) AS end_date
FROM campaigns; -- April to May

SELECT 
  MIN(amount_spent) AS min_spent,
  MAX(amount_spent) AS max_spent,
  AVG(amount_spent) AS avg_spent,

  MIN(ctr) AS min_ctr,
  MAX(ctr) AS max_ctr,
  AVG(ctr) AS avg_ctr,

  MIN(cpc) AS min_cpc,
  MAX(cpc) AS max_cpc,
  AVG(cpc) AS avg_cpc,

  MIN(conversions) AS min_conversions,
  MAX(conversions) AS max_conversions,
  AVG(conversions) AS avg_conversions,

  MIN(frequency) AS min_frequency,
  MAX(frequency) AS max_frequency,
  AVG(frequency) AS avg_frequency
FROM campaigns;

-- High CPC or CTR
SELECT campaign_name, cpc, ctr
FROM campaigns
WHERE cpc > 20000 OR ctr > 0.2
ORDER BY cpc DESC, ctr DESC;


-- Top 5 by CTR
SELECT campaign_name, ctr
FROM campaigns
ORDER BY ctr DESC
LIMIT 5;

-- Bottom 5 by CTR
SELECT campaign_name, ctr
FROM campaigns
ORDER BY ctr ASC
LIMIT 5;

-- Top 5 by Conversions
SELECT campaign_name, conversions
FROM campaigns
ORDER BY conversions DESC
LIMIT 5;

-- Top 5 by Amount Spent
SELECT campaign_name, amount_spent
FROM campaigns
ORDER BY amount_spent DESC
LIMIT 5;










