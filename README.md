# AtliQ Mart Promotions Analysis: Analyze Promotions and Provide Tangible Insights to Sales Director
Case Study: [Codebasics Resume Project Challenge #9](https://codebasics.io/challenge/codebasics-resume-project-challenge)

Hey there! Welcome to my very first data analytics project. As someone who's just stepped into the world of data analytics, completing the **Google Data Analytics Professional Certificate** felt like crossing a major milestone. Sure, the journey had its ups and downs, but it was mostly an interesting ride filled with fascinating discoveries. Now, I'm thrilled to share my first project with you and gather your feedback whether you're a seasoned pro or just curious about data. Let's dive in and learn from each other, maybe even connect on [LinkedIn](www.linkedin.com/in/bridgetoeze/) along the way and explore this exciting realm together. I can't wait to hear what you think! 

## Introduction
In this project, we're looking into a major sales event at AtliQ Mart. The store is keen to identify which deals were hits and which missed the mark during their last promotions. This insight is crucial for planning more effective sales strategies in the future. The mission is to deep dive into the sales data, extract valuable insights, and present these findings in a way that's easy to understand. This will help AtliQ Mart make informed decisions on what sales promotions to run moving forward. 
I’ll be stepping into Peter Pandey's shoes: a data analyst at AtliQ Mart who has been tasked with this challenge. Using the following data analysis process: [Ask](), [Prepare](), [Process](), [Analyze](), [Share](), and [Act](), I performed real-life data analyst tasks to reach the following conclusions that:
-	For sales Impact, the promotional events significantly increased the quantity of products sold from about 139 units to 290 units on average per event. This highlights the effectiveness of these promotions in driving higher product sales.
-	For revenue Impact, the promotions had a positive effect on revenue as well. On average, revenue increased by approximately $71,522 per event after the promotion, despite some promotions leading to a loss in revenue, there was an overall increase in revenue generated.
-	For performance variation, the dataset shows a wide range of outcomes with some promotions more successful than others, which emphasizes on the importance of tailoring promotional strategies to specific products, stores, and market conditions to maximize their effectiveness.
Ready to dive in? Let’s go!

## Scenario
Analyze Promotions and Provide Tangible Insights to Sales Director
Domain: FMCG Function: Sales / Promotions 

AtliQ Mart is a retail giant with over 50 supermarkets in the southern region of India. All their 50 stores ran a massive promotion during the Diwali 2023 and Sankranti 2024 (festive time in India) on their AtliQ branded products. Now the sales director wants to understand which promotions did well and which did not so that they can make informed decisions for their next promotional period. 

Sales director Bruce Haryali wanted this immediately, but the analytics manager Tony is engaged on another critical project. Tony decided to give this work to Peter Pandey, who is the curious data analyst of AtliQ Mart. Since these insights will be directly reported to the sales director, Tony also provided some notes to Peter to support his work.

## Ask
**Business Task:** Analyze the effectiveness of the sales promotions conducted by AtliQ Mart on its branded products during the festive seasons of Diwali 2023 and Sankranti 2024. The objective of this analysis is to determine which promotional strategies were successful and which were not during the specified festive periods. This involves analyzing sales data to identify trends, patterns, and correlations between different promotions and sales outcomes. 

**Key Stakeholders:** Bruce Haryali (Sales Director), Tony Sharma (Analytics Manager), AtliQ’s Senior Executives, Peter Pandey (Data Analyst), and AtliQ’s Customers.

## Prepare
**Data Sources:** For this analysis, the primary data source used is the AtliQ Mart’s sales data which includes detailed records of sales transactions during the promotional periods of Diwali 2023 and Sankranti 2024. The data has been provided by Codebasics in its Resume Project Challenge #9 dataset download. This data is publicly available and accessible. 

**Data Organization:** I downloaded the zip file C9_Input_Files containing AtliQ’s promotions sales data for Diwali 2023 and Sankranti 2024. The content of the zip file includes: a Dataset folder containing **4 .csv** files **(dim_campaigns, dim_products, dim_stores,** and **fact_events)** and a **SQL text** file **(retail_events_db)**, a Problem Statement .pdf file (that provides the scenario, overview of the problem, and the business task), a Recommended Insights .pdf file (that provides a few recommendations from Data Analytics manager Tony Sharma), an Ad-hoc Request .pdf file (that provides important business questions posed by AtliQ’s Senior Executives, requiring SQL based report generation), and a Metadata .txt file (that provides additional information about the dataset). After downloading the files, I saved them into a new folder named AtliQ Mart Promotions Data.

**Metadata:** A Metadata of the  dataset was provided in the zip file. This file contains all the meta information regarding the columns described in the 4 CSV files.  It fosters deeper understanding of the data and makes it easier to reuse the data. 

**Data Format:** The AtliQ promotions sales dataset is both a primary and an internal data. It is structured data organized in rows and columns. 

- **dim_campaigns**
  | Column Names | Data Types |
  |----------|----------|
  | campaign_id | STRING |
  | campaign_name | STRING |
  | start_date | DATE |
  |end_date | DATE |

- **dim_products**
  | Column Names | Data Types |
  |----------|----------|
  | product_code | STRING |
  | product_name | STRING |
  | category | STRING |

- **dim_stores**
  | Column Names | Data Types |
  |----------|----------|
  | store_id | STRING |
  | city | STRING |

- **fact_events**
  | Column Names | Data Types |
  |----------|----------|
  | event_id | STRING |
  | store_id | STRING |
  | campaign_id | STRING |
  | product_code | STRING |
  | base_price | INT |
  | promo_type | STRING |
  | quantity_sold_before_promo | INT |
  | quantity_sold_after_promo | INT |

**Credibility and Bias:** The promotions sales data being a primary data and an internal data of AtliQ Mart makes it highly credible: it’s reliable, original, and cited. The dataset is comprehensive as it contains all critical information needed to answer the business task and the dataset is equally current and relevant to the task. For the case of bias, the data collected from all records of sales transactions during the promotion periods across all 50 stores, limits the chances of bias and unfairness.

**Data Ethics:** The data is publicly available and accessible. It has been provided by **Codebasics** in its **Resume Project Challenge #9** [dataset download](https://codebasics.io/challenge/codebasics-resume-project-challenge). For data privacy and security, all personally identifiable information has been excluded from the sales dataset to protect AtliQ Mart’s customers’ personal data. 

## Process
**Tools Used: SQL** – to combine, check for errors, aggregate, and manipulate the data. **Tableau** – to analyze and visualize the data and create a dashboard. 

**Combining The Data:** I imported the **retail_events_db** database into **MySQL Workbench**. This database contains 4 tables: **dim_campaigns** – the campaigns table, **dim_products** – the products table, **dim_stores** – the stores table, and **fact_events** – the table for all the sales events during the promotions. I combined the data from all 4 tables into a new table I created named **‘events_combined_data’**. 
**SQL Query** – [Data Combining]()

**Data Exploration:** I familiarized myself with the problem statement and the dataset to better understand the structure and context of the data before cleaning the data and diving into my analysis. 
**SQL Query** – [Data Exploration]() 
- **Column names and their datatypes** – The event_id column is the primary key
- **Null values** – There are no null values in the promotions sales dataset.
- **Duplicates** – I used the event_id column to check for duplicates. There are no duplicate entries in the dataset.
- **Outliers** – Checking for any sales event not within the Diwali or Sankranti promotions period. Non where found.
- **Campaign Duration** – The Sankranti and Diwali campaigns both lasted for 6 days each.
- **Unique Promo Types** – There are 5 unique types of promotions applied during the campaign periods.
- **Number of Stores in each City** – Bengaluru has the most stores and Vijayawada has the least stores.
- **Scope of Data** - The dataset covers 1,500 promotional events across 50 stores in 10 cities, focusing on 15 different products belonging to 5 categories. 5 types of promotions were utilized during 2 major campaigns: Diwali and Sankranti.

**Data Aggregation:** Still on SQL, I created a new table named **‘events_summarized_data’** with aggregated data from the events_combined_data table. The **‘events_summarized_data’** table includes additional columns calculating the following for each sales event: **incremental sold units, ISU%**(incremental sold unit percentage), **revenue before promo, revenue after promo, incremental revenue generated, and IR%**(incremental revenue generated percentage). 
**SQL Query** – [Data Aggregation]() 









