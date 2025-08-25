-- Google Ads Campaign Performance Analysis with Optimization Flags

/* 
Step 1: Calculate overall averages (for benchmarks)
*/
WITH benchmarks AS (
    SELECT 
        AVG(ctr) AS avg_ctr,
        AVG(cpc) AS avg_cpc
    FROM campaigns
),

/* 
Step 2: Calculate campaign-level KPIs with optimization flags
*/
performance AS (
    SELECT 
        c.campaign_name,
        c.reach,
        c.impressions,
        ROUND(c.ctr::numeric, 3) AS ctr,
        ROUND(c.cpc::numeric, 2) AS cpc,
        ROUND(c.cpm::numeric, 2) AS cpm,
        c.link_clicks,
        ROUND((c.amount_spent / NULLIF(c.link_clicks, 0))::numeric, 2) AS calculated_cost_per_click,
        ROUND((c.ctr * c.link_clicks)::numeric, 2) AS engagement_score,
        CASE 
            WHEN c.ctr < (SELECT avg_ctr FROM benchmarks) 
                 AND c.cpc > (SELECT avg_cpc FROM benchmarks)
            THEN 'Needs Optimization'
            ELSE 'Good Performance'
        END AS performance_flag
    FROM campaigns c
)

/* 
Step 3: Add ranking based on engagement score
*/
SELECT 
    campaign_name,
    reach,
    impressions,
    ctr,
    cpc,
    cpm,
    link_clicks,
    calculated_cost_per_click,
    engagement_score,
    RANK() OVER (ORDER BY engagement_score DESC) AS engagement_rank,
    performance_flag
FROM performance
ORDER BY engagement_rank;

-- Create a view for Google Ads Campaign KPI Analysis with Ranking & Optimization Flags

CREATE OR REPLACE VIEW campaign_performance_analysis AS
WITH benchmarks AS (
    SELECT 
        AVG(ctr) AS avg_ctr,
        AVG(cpc) AS avg_cpc
    FROM campaigns
),
performance AS (
    SELECT 
        c.campaign_name,
        c.reach,
        c.impressions,
        ROUND(c.ctr::numeric, 3) AS ctr,
        ROUND(c.cpc::numeric, 2) AS cpc,
        ROUND(c.cpm::numeric, 2) AS cpm,
        c.link_clicks,
        ROUND((c.amount_spent / NULLIF(c.link_clicks, 0))::numeric, 2) AS calculated_cost_per_click,
        ROUND((c.ctr * c.link_clicks)::numeric, 2) AS engagement_score,
        CASE 
            WHEN c.ctr < (SELECT avg_ctr FROM benchmarks) 
                 AND c.cpc > (SELECT avg_cpc FROM benchmarks)
            THEN 'Needs Optimization'
            ELSE 'Good Performance'
        END AS performance_flag
    FROM campaigns c
)
SELECT 
    campaign_name,
    reach,
    impressions,
    ctr,
    cpc,
    cpm,
    link_clicks,
    calculated_cost_per_click,
    engagement_score,
    RANK() OVER (ORDER BY engagement_score DESC) AS engagement_rank,
    performance_flag
FROM performance
ORDER BY engagement_rank;

/*
The campaigns which needs optimization?
*/
SELECT * FROM campaign_performance_analysis WHERE performance_flag = 'Needs Optimization';

