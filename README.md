📊 Google Ads Campaign Performance Analysis
📌 Project Overview

This project focuses on analyzing Google Ads Campaign Performance to extract actionable insights and optimize ad spending. The goal was to understand campaign performance, track KPIs, identify trends, and build an interactive dashboard for data-driven decision-making.

I followed an end-to-end data workflow:

Data Cleaning & Preprocessing using Python (Pandas)

Database Management & Querying with PostgreSQL

Exploratory Data Analysis (EDA) & KPI Analysis

Visualization & Storytelling through Power BI

🗂️ Dataset

Source: Simulated/collected campaign performance dataset

Columns include:

campaign_name

amount_spent

impressions

reach

engagement

CTR (Click-Through Rate)

CPC (Cost Per Click)

objective

date

⚙️ Tools & Technologies

Python (Pandas, NumPy, Matplotlib, Seaborn) – Data cleaning & preprocessing

PostgreSQL – Database management, table creation, EDA queries, KPI analysis

Power BI – Dashboard design and visualization

GitHub – Version control and project showcase

🔑 Key Steps
1. Data Cleaning (Python)

Removed duplicates and null values

Standardized column formats

Converted data types (date, numeric fields)

Handled outliers and anomalies

2. Database Creation (PostgreSQL)

Created tables with appropriate schema

Imported cleaned data

Wrote SQL scripts for:

Basic EDA checks

KPI analysis (CTR, CPC, engagement rates, total spend)

Performance trends & objective analysis

3. KPI Analysis

Total Spend

Total Impressions

Total Reach

CTR %

CPC

Top Performing Campaigns

Spend vs Objective vs Engagement

4. Power BI Dashboard

Designed an interactive dashboard to visualize:

Campaign-level performance

CTR & CPC trend over time

Spend vs Engagement

Spend vs Objective distribution

Top 10 performing campaigns

Key KPIs in a single view

📊 Dashboard Preview

<img width="1117" height="627" alt="image" src="https://github.com/user-attachments/assets/1036dd92-6ec7-4c7b-9f5f-d3f49f2e3de5" />


🚀 Insights & Outcomes

Identified top-performing campaigns with highest engagement

Analyzed CTR and CPC trends to suggest optimization strategies

Compared spend allocation across objectives (Engagement, Reach, Messages)

Highlighted opportunities for budget reallocation to maximize ROI

📈 Business Impact

Helps marketing teams optimize ad spend

Provides clear visibility into campaign effectiveness

Supports data-driven decision making for future campaigns

📂 Repository Structure
├── data/                 # Raw & cleaned datasets
├── sql/                  # PostgreSQL scripts
│   ├── table_creation.sql
│   ├── eda_queries.sql
│   ├── kpi_analysis.sql
│   └── trend_objective_analysis.sql
├── notebooks/            # Python scripts & notebooks
│   ├── data_cleaning.ipynb
│   └── eda.ipynb
├── dashboard/            # Power BI file (.pbix)
├── images/               # Dashboard screenshots
│   └── dashboard.png
└── README.md             # Project documentation

📌 Future Improvements

Automating ETL pipeline (Python + PostgreSQL)

Deploying dashboard with Power BI Service for real-time monitoring

Adding predictive modeling for CTR & engagement forecasting

🙌 Acknowledgements

Special thanks to the open-source community and resources that inspired this project.

🔗 Connect With Me

💼 LinkedIn

📂 GitHub
