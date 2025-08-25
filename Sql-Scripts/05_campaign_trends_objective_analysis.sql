=
--Trend & Aggregation Analysis


/* 
1. Trend of CTR over time (How has engagement changed by date?)
*/
SELECT 
    report_date,
    ROUND(AVG(ctr)::numeric, 3) AS avg_ctr
FROM campaigns
GROUP BY report_date
ORDER BY report_date;

/* 
2. Trend of CPC over time (Are campaigns becoming cheaper or costlier?)
*/
SELECT 
    report_date,
    ROUND(AVG(cpc)::numeric, 2) AS avg_cpc
FROM campaigns
GROUP BY report_date
ORDER BY report_date;

/* 
3. Total amount spent by date (Daily campaign spend)
*/
SELECT 
    report_date,
    SUM(amount_spent) AS total_spent
FROM campaigns
GROUP BY report_date
ORDER BY report_date;

/* 
4. KPI summary by campaign objective 
   (Which objective performs best overall?)
*/
SELECT 
    objective,
    COUNT(*) AS num_campaigns,
    ROUND(AVG(ctr)::numeric, 3) AS avg_ctr,
    ROUND(AVG(cpc)::numeric, 2) AS avg_cpc,
    ROUND(AVG(cpm)::numeric, 2) AS avg_cpm,
    ROUND(SUM(link_clicks)::numeric, 0) AS total_clicks,
    ROUND(SUM(messaging_conversations)::numeric, 0) AS total_conversations,
    ROUND(SUM(amount_spent)::numeric, 0) AS total_spent
FROM campaigns
GROUP BY objective
ORDER BY avg_ctr DESC;

/* 
5. Daily spend vs engagement (Are we getting more clicks when spending more?)
*/
SELECT 
    report_date,
    SUM(amount_spent) AS total_spent,
    SUM(link_clicks + messaging_conversations) AS total_engagement
FROM campaigns
GROUP BY report_date
ORDER BY report_date;

/* 
6. Objective-level cost efficiency 
   (Which campaign objective gives the most reach per VND?)
*/
SELECT 
    objective,
    ROUND((SUM(reach) / NULLIF(SUM(amount_spent),0))::numeric, 2) AS reach_per_vnd
FROM campaigns
WHERE amount_spent > 0
GROUP BY objective
ORDER BY reach_per_vnd DESC;