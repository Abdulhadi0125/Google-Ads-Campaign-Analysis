--High-Level EDA & KPI Performance Analysis 
/* 
1. Which campaign had the highest CTR (Click-Through Rate)?
*/
SELECT campaign_name, ctr
FROM campaigns
ORDER BY ctr DESC
LIMIT 1;

-------------------------------------------------------------

/* 
2. Which campaign had the lowest CPC (Cost Per Click)?
*/
SELECT campaign_name, cpc
FROM campaigns
ORDER BY cpc ASC
LIMIT 1;

-------------------------------------------------------------

/* 
3. What is the average CPM and CPC across all campaigns?
*/
SELECT 
    ROUND(AVG(cpm)::numeric, 2) AS avg_cpm,
    ROUND(AVG(cpc)::numeric, 2) AS avg_cpc
FROM campaigns;

-------------------------------------------------------------

/* 
4. Which campaign had the highest cost per 1,000 people reached?
*/
SELECT campaign_name, cost_per_1000_reach
FROM campaigns
ORDER BY cost_per_1000_reach DESC
LIMIT 1;

-------------------------------------------------------------

/* 
5. Which campaign generated the most link clicks and messaging conversations?
*/
SELECT campaign_name, link_clicks, messaging_conversations
FROM campaigns
ORDER BY link_clicks DESC, messaging_conversations DESC;

-------------------------------------------------------------

/* 
6. What is the cost per link click for each campaign?
*/
SELECT 
    campaign_name,
    ROUND((amount_spent / NULLIF(link_clicks, 0))::numeric, 2) AS cost_per_click
FROM campaigns;

-------------------------------------------------------------

/* 
7. Which campaign had the highest frequency (ad repetition per person)?
*/
SELECT campaign_name, frequency
FROM campaigns
ORDER BY frequency DESC
LIMIT 1;

-------------------------------------------------------------

/* 
8. What is the overall engagement score (CTR × Link Clicks) for each campaign?
*/
SELECT 
    campaign_name,
    ROUND((ctr * link_clicks)::numeric, 2) AS engagement_score
FROM campaigns
ORDER BY engagement_score DESC;

-------------------------------------------------------------

/* 
9. Combined Summary: 
   For each campaign, show reach, impressions, CTR, CPC, CPM, cost per click (calculated), link clicks, and engagement score.
*/
SELECT 
    campaign_name,
    reach,
    impressions,
    ROUND(ctr::numeric, 3) AS ctr,
    ROUND(cpc::numeric, 2) AS cpc,
    ROUND(cpm::numeric, 2) AS cpm,
    link_clicks,
    ROUND((amount_spent / NULLIF(link_clicks, 0))::numeric, 2) AS calculated_cost_per_click,
    ROUND((ctr * link_clicks)::numeric, 2) AS engagement_score
FROM campaigns
ORDER BY engagement_score DESC;

/* 
10. Which campaign had the highest cost efficiency (Reach per VND spent)?
*/
SELECT 
    campaign_name,
    ROUND((reach / amount_spent)::numeric, 2) AS reach_per_vnd
FROM campaigns
WHERE amount_spent > 0
ORDER BY reach_per_vnd DESC;
-------------------------------------------------------------

/* 
11. Which campaign had the lowest CPM relative to average (cost-effective impressions)?
*/
SELECT 
    campaign_name,
    cpm,
    CASE 
        WHEN cpm < (SELECT AVG(cpm) FROM campaigns) THEN 'Below Avg (Cost-Efficient)'
        ELSE 'Above Avg (Expensive)'
    END AS cost_efficiency
FROM campaigns
ORDER BY cpm ASC;

-------------------------------------------------------------

/* 
12. Which campaigns are outliers (very high frequency but low CTR)?
*/
SELECT 
    campaign_name,
    frequency,
    ctr,
    CASE 
        WHEN frequency > (SELECT AVG(frequency) FROM campaigns) 
             AND ctr < (SELECT AVG(ctr) FROM campaigns)
        THEN 'Possible Ad Fatigue'
        ELSE 'Normal'
    END AS ad_health
FROM campaigns
ORDER BY frequency DESC, ctr ASC;

-------------------------------------------------------------

/* 
13. Which campaign generated the most engagement per VND spent?
*/
SELECT 
    campaign_name,
    ROUND(((link_clicks + messaging_conversations) / amount_spent)::numeric, 3) AS engagement_per_vnd
FROM campaigns
WHERE amount_spent > 0
ORDER BY engagement_per_vnd DESC;

-------------------------------------------------------------

/* 
14. Which campaigns need optimization (CTR below avg & CPC above avg)?
*/
WITH benchmarks AS (
    SELECT AVG(ctr) AS avg_ctr, AVG(cpc) AS avg_cpc FROM campaigns
)
SELECT 
    campaign_name,
    ctr,
    cpc,
    CASE 
        WHEN ctr < (SELECT avg_ctr FROM benchmarks) AND cpc > (SELECT avg_cpc FROM benchmarks)
        THEN 'Needs Optimization'
        ELSE 'Good Performance'
    END AS performance_flag
FROM campaigns;







