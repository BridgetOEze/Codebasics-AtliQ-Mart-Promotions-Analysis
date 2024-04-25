# AtliQ Mart Promotions Analysis: Analyze Promotions and Provide Tangible Insights to Sales Director
Case Study: [Codebasics Resume Project Challenge #9](https://codebasics.io/challenge/codebasics-resume-project-challenge)

Hey there! Welcome to my very first data analytics project. As someone who's just stepped into the world of data analytics, completing the [Google Data Analytics Professional Certificate](https://www.coursera.org/professional-certificates/google-data-analytics) felt like crossing a major milestone. Sure, the journey had its ups and downs, but it was mostly an interesting ride filled with fascinating discoveries. Now, I'm thrilled to share my first project with you and gather your feedback whether you're a seasoned pro or just curious about data. Let's dive in and learn from each other, maybe even connect on [LinkedIn]() along the way and explore this exciting realm together. I can't wait to hear what you think! 

## Introduction
In this project, we're looking into a major sales event at AtliQ Mart. The store is keen to identify which deals were hits and which missed the mark during their last promotions. This insight is crucial for planning more effective sales strategies in the future. The mission is to deep dive into the sales data, extract valuable insights, and present these findings in a way that's easy to understand. This will help AtliQ Mart make informed decisions on what sales promotions to run moving forward. 
I’ll be stepping into Peter Pandey's shoes: a data analyst at AtliQ Mart who has been tasked with this challenge. Using the following data analysis process: [Ask](#ask), [Prepare](#prepare), [Process](#process), [Analyze](#analyze-and-share), [Share](#analyze-and-share), and [Act](#act), I performed real-life data analyst tasks to reach the following conclusions that:
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
**Data Sources:** For this analysis, the primary data source used is the AtliQ Mart’s sales data which includes detailed records of sales transactions during the promotional periods of Diwali 2023 and Sankranti 2024. The data has been provided by **Codebasics** in its **Resume Project Challenge #9** [dataset download](https://codebasics.io/challenge/codebasics-resume-project-challenge). This data is publicly available and accessible. 

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

![columns and data types](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/c30c4ad9-5f42-4722-a5bb-31aba98555fe)

- **Null values** – There are no null values in the promotions sales dataset.

![checking for Null](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/232129da-daca-412e-9938-b4748f905192)

- **Duplicates** – I used the event_id column to check for duplicates. There are no duplicate entries in the dataset.

![duplicates result](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/3d6fdb9a-6ac6-412e-bf5b-ddc90228db25)

- **Outliers** – Checking for any sales event not within the Diwali or Sankranti promotions period. Non where found.

![outliers-sales outside campaign period](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/5e765945-11ea-400f-a75b-e8b3d95e1270)

- **Campaign Duration** – The Sankranti and Diwali campaigns both lasted for 6 days each.

![campaign duration](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/40a04222-ecd3-4681-b8f8-ce40abac47df)

- **Unique Promo Types** – There are 5 unique types of promotions applied during the campaign periods.

![unique promo types](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/b491bd9c-5742-4e87-90fd-ce32a57f391c)

- **Scope of Data** - The dataset covers 1,500 promotional events across 50 stores in 10 cities, focusing on 15 different products belonging to 5 categories. 5 types of promotions were utilized during 2 major campaigns: Diwali and Sankranti.

**Data Aggregation:** Still on SQL, I created a new table named **‘events_summarized_data’** with aggregated data from the events_combined_data table. The **‘events_summarized_data’** table includes additional columns calculating the following for each sales event: **incremental sold units, ISU%**(incremental sold unit percentage), **revenue before promo, revenue after promo, incremental revenue generated, and IR%**(incremental revenue generated percentage). 
**SQL Query** – [Data Aggregation]() 

## Analyze and Share
The summarized data is appropriately stored in the **retail_events_db** database and is now ready for analysis. For the analysis, I used multiple relevant queries on the **events_summarized_data** table and visualized them in Tableau.

**SQL Query** –  [Campaign and Promo Type Analysis]() 

**SQL Query** –  [Category and Product Analysis]() 

**SQL Query** –  [City and Store Analysis]() 

**Tableau** – [Data Visualization]()

Analysis question: What is the effectiveness of the sales promotions conducted during the Diwali and Sankranti campaigns? 

### Campaign Performance
![Ad Hoc Request No3 Campaign Total Revenue](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/d05ea375-76dc-4c4c-901d-d9095bba282c)
Ad Hoc Request No3 - Total Revenue Generated 

![Total Revenue Generated per Campaign](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/9505b1ef-6b43-4381-868f-1a8a05377850) 

![Total Units Sold per Campaign](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/f972476a-1dac-4ae0-864a-05d17660bfa5)

In terms of **incremental units sold**, the **Sankranti campaign outperformed** the Diwali campaign. The increase in units sold for the Sankranti campaign is more than double that of the Diwali campaign.

Despite the Sankranti campaign selling more units incrementally, the **Diwali campaign** generated a **higher incremental revenue**.

The higher revenue generated is a result of an increase in the volume of higher-priced items that were sold during the Diwali campaign. It indicates that the most sold category had higher margins with less aggressive promotional discounts, thus retaining more profit per unit. It could also indicate that the Diwali campaign attracted more premium customers.  

### Promo Type Performance
![Promo Type Performance by Revenue](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/f4b1458d-6a1c-43f7-811b-42678ad79c19)

![Promo Type Performance by Units Sold](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/ab0d8408-c6fa-479d-931f-62dffa4d3169)

The **BOGOF** (Buy One Get One Free) promotion has led to the **highest incremental units sold**, indicating it is the most effective promotion type for driving volume sales, likely because customers perceive a higher value in getting an additional product for free, but this doesn't directly translate into higher revenue as seen in the "Promo Type Performance by Revenue" chart.

However, **500 Cashback** generated the **most incremental revenue**, which suggests that while BOGOF moves more units, 500 Cashback excels in generating revenue. This is due to higher transaction values or a customer demographic that responds better to cashback incentives, it is attached to higher-priced items: most likely more premium or higher-margin products. 

The **25% OFF**, **33% OFF**, and **50% OFF** promotions led to a **loss in revenue** post-promotion. The 25% OFF promotion led to a decrease in units sold, while the 33% OFF and 50% OFF promotions performed better than the 25% OFF in terms of units sold, but still significantly behind the BOGOF promotion.

### Category Performance
![Ad Hoc Request No4 Category ISU percentage ranking](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/b851bab6-30e3-4fb5-8046-72bbceae13aa)
Ad Hoc Request No4 - Category performance by ISU% ranking for Diwali campaign

![Category Performance](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/6eff4097-430a-4a69-a498-2795c31f3616)

During the **Diwali campaign: Combo1 category** had the **highest incremental units sold** and **incremental revenue generated**, with significant average increase in revenue and sold units. The Home Appliances category had considerable incremental units sold and the second-highest revenue increase. The **Personal Care category** saw a **loss in revenue** post-promotion, despite a respectable increase in sold units.

For the **Sankranti Campaign: Grocery & Staples category** had **massive incremental units sold**, highest among all categories, with a significant Avg. ISU%. Despite seeing a loss in revenue in the Diwali campaign, it had substantial revenue growth during the Sankranti campaign, although the Avg. IR% is not as high as Combo1(which had considerable increase in revenue and units sold but not as massive as in the Diwali campaign), indicating a lower profit margin per unit or less expensive items. 

The **Home Appliances category** had a **good performance** in both **incremental units and revenue** with high Avg. ISU% and Avg. IR%, which is consistent with its performance in the Diwali campaign. The **Personal Care category** once again had the **lowest incremental units sold** and **negative incremental revenue**, which is also consistent with its performance in the Diwali campaign.

### Product Performance
![Ad Hoc Request No1 High Value Heavy Discount](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/79cc81ab-6e35-4813-999c-f5ea910378e8)
Ad Hoc Request No1 - Heavily discounted high value products

![Ad Hoc Request No5 Product IR ranking](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/f93e8961-4be2-4a03-9acb-8ea08ba3e810)
Ad Hoc Request No5 - Top 5 products by IR% ranking

![Product Performance](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/af175642-655f-479a-bc05-73ebe8d45d1d)

Top products with **high performance** in terms of **incremental revenue** generated includes **Atliq_Home_Essential_8_Product_Combo** with Avg. base price 3,000 which did exceptionally well at an incremental revenue of 91million, **Atliq_waterproof_Immersion_Rod** with Avg. base price 1,020 at an incremental revenue of 5.4million, and **Atliq_Farm_Chakki_Atta (1KG)** with Avg. base price 330 and increase in revenue at 4.5million.

In terms of **incremental sold units**, products like **Atliq_Farm_Chakki_Atta (1KG)**, **Atliq_Suflower_Oil (1L)**, and **Atliq_Home_Essential_8_Product_Combo** did exceedingly well.

Products like Atliq_Home_Essential_8_Product_Combo and Atliq_Farm_Chakki_Atta (1KG) have shown an impressive combination of raking in high volumes and high revenue. Its high Avg. IR% indicates significant profitability on promotion while high Avg. ISU% suggests strong market demand and effective promotion. **Atliq_waterproof_Immersion_Rod** with a lower Avg. base price compared to the Home Essential products, and yet with substantial incremental revenue and sold units indicates that this product is **highly responsive to promotions**.

Some products show negative incremental revenue, indicating that promotions where not as effective or could have been counterproductive for these items in terms of profitability. Products like **Atliq_Masoor_Dal (1KG)** and **Atliq_Sonamasuri_Rice (10KG)** despite having an increase in the number of units sold, these products made a **loss in revenue** post-promotion, implying that the promotion may have eroded the profit margin, or the items were sold at a loss.

**Atliq_waterproof_Immersion_Rod** and **Atliq_Double_Bedsheet_set** are **high-value products** (with base price well above 500) that were **heavily discounted** with **BOGOF** during the promotions and yielded significant **increment in revenue and volume sold**.

### Store and City Performance
![Ad Hoc Request No2 Store count per city sql](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/9c815ad1-839d-4de9-b0be-f87f18fe0ef7)
Ad Hoc Request No2 - Store count per city

![City Performance by Revenue](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/a82f325d-f988-4a4b-8e50-3705a3053140)

![Store Performance](https://github.com/BridgetOEze/Codebasics-AtliQ-Mart-Promotions-Analysis/assets/168002582/2a10d97a-9e1a-40f2-b6a7-7ddbe5cc1b4b)

**Bengaluru** has the **highest number of stores** at 10, suggesting it's a key market. **Chennai follows** with 8 stores, then Hyderabad with 7, indicating these are also significant markets. Cities like **Trivandrum** and **Vijayawada** have the **least number of stores**, which could point to either a smaller market size or less penetration by AtliQ Mart.

**Bengaluru** tops the chart for **incremental revenue** generated and **incremental units sold**, with **Chennai** and **Hyderabad following**, which shows high efficiency and effectiveness of the promotions in increasing both revenue and volume in these cities. The store count seems to correlate with the performance metrics, suggesting that having more stores in a city can contribute to increased sold units and revenue increments. 

While stores in Bengaluru and Chennai dominate the top positions in performance, which correlates with having the highest store count, some stores that generated the most revenue are not from the cities with the most stores, like store **(STMYS-1) in Mysuru** with the **highest incremental revenue** and store **(STMDU-0) in Madurai** which is one of the **top 10** performing stores **in terms of revenue**. This indicates that other factors like store size, location within the city, or local management practices can impact performance significantly.

### Summary
**Campaign** - The Sankranti campaign was effective in moving a higher volume of units, while the Diwali campaign was more effective in generating revenue. This suggests that different campaigns might be optimizing for different objectives (volume vs. revenue). These differences can be due to customer behavior during different times of the year, the nature of the festivals, or the types of products promoted.

Insights from both campaigns can be used to tailor future promotions: leveraging the high-revenue approach of Diwali with the high-volume strategy seen in Sankranti could lead to better results.

**Promo Type** - Discount-based promotions do have a significantly declining performance compared to BOGOF or cashback promotions. They led to a loss in revenue and minimal increase in units sold while BOGOF and cashback promotions led to a significant increase in units sold and revenue, respectively.

While some promotions are efficient in increasing the number of units sold, not all are equally effective in generating revenue. This highlights the need for a balanced approach that considers both volume and profitability. The optimal promotion type depends on the specific goal: volume or revenue, and other factors such as inventory levels, product margins, customer acquisition goals, or overall marketing strategy.

**Category** - Combo1 seem to perform exceptionally well in both Diwali and Sankranti, indicating that bundled offers are very appealing across different campaigns. Groceries and staples, and Home Appliances categories performed exceptionally well during Sankranti, which might be due to the festival's association with harvest and home. The type of festival also has a clear impact on category performance. 

The effectiveness of promotions can vary widely by category and by festival, so It's crucial to tailor promotional strategies to both the category and the nature of the festival. Understanding customer buying behavior during different festivals and events can help maximize effectiveness. 

**Products** - Higher-priced items such as the Home Essential and Immersion Rod seem to have a higher margin to accommodate promotions, resulting in substantial incremental revenue and increased sold units as well. 
Some products have a high volume of sales with promotions but do not necessarily translate to increased revenue, highlighting the importance of balancing discount depth with profitability.

Items from 'Combo1' and 'Home Appliances' are among the top performers, indicating that promotions within these categories are likely to be more successful.

**Store and City** - There seems to be a correlation between the number of stores in a city and the overall performance, as seen with Bengaluru and Chennai, these cities with a higher store count likely have better brand recognition, which can lead to better overall performance. However, it's not a strict rule, as some cities with fewer stores like Mysuru and Madurai also show strong performances, which may be due to local competition, demand, or operational efficiencies. 

## Act
### Recommendations
Here are some recommendations and actions to make informed decisions for the next promotional period:

**Align Promotions with Festivals:** Tailor promotions to the specific demand for each festival period as different campaigns have varied success with different product categories. For instance, groceries and staples perform exceptionally well during Sankranti. Leverage high-performing categories during promotional periods.

**Optimize Promo Types:** 'BOGOF' drives volume, while '500 Cashback' enhances revenue. So, choose the promotion type accordingly depending on the strategic goal—whether to clear inventory or increase revenue.

**Balance Discounts:** Adjust discount levels based on the product’s price elasticity and margin to ensure profitability is maintained while driving sales. This is especially for products and categories that resulted in negative incremental revenue despite increased sales (e.g., Personal Care). 

**Combo Deals and Customization:** Combining high-margin products with other items in 'Combo' deals has proven successful. Create new bundles that include popular items (with low margins) and high-margin items to drive sales and revenue. Customize promotional strategies to match the demographic and consumer behavior during each festival.

**Dynamic Pricing:** Implement dynamic pricing strategies where possible, especially for high-demand items during promotional periods. Setting flexible prices for products based on current market demands would help increase the sales performance of groceries and staples during the Diwali campaign.

**Benchmark and Replicate Success:** Identify the best practices of the top-performing stores (STMYS-1 in Mysuru, STCHE-4 in Chennai, and STBLR-0 in Bengaluru) and benchmark these across the network. This includes sales tactics, store displays, customer service and local marketing initiatives.

**Expand in Under-Penetrated Markets:** In cities like Mysuru and Madurai, where the store count is low, but performance is relatively good, consider expanding the store presence to capture untapped market potential. 
Validate Strategies: Conduct A/B testing for different promotion types to tailor the approach for each specific category. Also, conduct customer surveys and market research in both high and low-performing cities to better understand the consumer behavior and preferences. 

**Validate Strategies:** Conduct A/B testing for different promotion types to tailor the approach for each specific category. Also, conduct customer surveys and market research in both high and low-performing cities to better understand the consumer behavior and preferences. 

## Limitations
The dataset has limited attributes to analyze various aspects of the stores like store size, store layout, staff levels, customer service practices, and local market demographics.

## References
- Somia Nasir’s [Case Study](https://github.com/SomiaNasir/Google-Data-Analytics-Capstone-Cyclistic-Case-Study) on GitHub. 
- W3 Schools MySQL [Tutorial](https://www.w3schools.com/mysql/default.asp)
- MySQL Tutorial for Beginners by [Programming with Mosh](https://www.youtube.com/watch?v=7S_tz1z_5bA&t=5522s) 
- Tableau Public [Learn](https://public.tableau.com/app/learn/how-to-videos) 
- Tableau Tutorial for Beginners by [Alex The Analyst](https://www.youtube.com/playlist?list=PLUaB-1hjhk8GwbqoVmo_5zuhOa0Tcl3xC)
- How to Document Data Analysis Projects on GitHub by [Her Data Project](https://www.youtube.com/watch?v=0N9xekdKCwk&list=PPSV)











