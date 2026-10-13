
# Advanced Data Analysis Results

## 1. Overview

### Objective
This document presents the results of advanced data analysis performed using SQL. The analysis focuses on identifying business trends, evaluating performance, understanding metric contributions, and segmenting data to generate meaningful insights.

### Analysis Process
The analysis consists of five stages:

1. Changes Over Time Analysis
2. Cumulative Analysis
3. Performance Analysis
4. Part-to-Whole Analysis
5. Data Segmentation

---

## 2. Changes Over Time Analysis

### Objective
Analyze how business metrics change over time to identify trends, fluctuations, and periods of significant growth or decline.

### Analytical Questions
- How do sales change over time?
- Which periods show the highest and lowest performance?
- Are there notable increases or decreases in the selected metrics?

### Analysis Results

By Year

| order_year | total_sales | total_customers | total_quantity |
| --- | --- | --- | --- |
| 2010 | 43,419 | 14 | 14 |
| 2011 | 7,075,088 | 2,216 | 2,216 |
| 2012 | 5,842,231 | 3,255 | 3,397 |
| 2013 | 16,344,878 | 17,427 | 52,807 |
| 2014 | 4,5642 | 834 | 1,970 |

### Key Findings
- The highest increase in sales occurred between 2012 and 2013, rising **15-fold**.
- Sales peaked in 2013, whilst they were at their lowest in 2010.
- There was a significant decline of **96%** between 2013 and 2014.

By Month

| order_year | order_month | total_sales | total_customers | total_quantity |
| --- | --- | --- | --- | --- |
| 2010 | 12 | 43,419 | 14 | 14 |
| 2011 | 1 | 469,795 | 144 | 144 |
| 2011 | 2 | 466,307 | 144 | 144 |
| 2011 | 3 | 485,165 | 150 | 150 |
| … | … | … | … | … |

### Key Findings
- The data for 2010 and 2014 do not cover the entire month, resulting in distortions that skew the comparison.
- For the complete sales data from 2011 to 2013, sales tended to rise in the fourth quarter, between October and December.

### Interpretation
Sales performance improved as the fourth quarter began and declined again as the first quarter of the following year began.

---

## 3. Cumulative Analysis

### Objective
Calculate running totals over time to understand how a business metric accumulates throughout the selected period.

### Analytical Questions
- How does cumulative sales grow over time?
- When does cumulative performance increase most significantly?
- How much does each period contribute to the running total?

### Analysis Results

Monthly sales performance

| order_date | total_sales |
| --- | --- |
| 2010-12-01 | 43,419 |
| 2011-01-01 | 469,795 |
| 2011-02-01 | 466,307 |
| 2011-03-01 | 485,165 |
| … | … |

### Key Findings
- In 2011, sales rose by +$176,146 in June, before falling again by -$141,083 in July.
- In 2012, a decline of -$133,514 occurred in March, whilst the sharpest rise took place towards the end of 2012 and into early 2013. Sales rose by +$233,304 before eventually falling again in July by -$271,353.
- The sharpest decline occurred between December 2013 and January 2014, with sales falling to -$1,828,486.

Cumulative total sales over time

| order_date | total_sales | running_total |
| --- | --- | --- |
| 2010-12-01 | 43,419 | 43,419 |
| 2011-01-01 | 7,075,088 | 7,118,507 |
| 2012-01-01 | 5,842,231 | 12,960,738 |
| 2013-01-01 | 16,344,878 | 29,305,616 |
| 2014-01-01 | 45642 | 29,351,258 |

### Key Findings
- Sales increased significantly between 2010 and 2013, but in 2014 the growth was not particularly significant.

The moving average of a product's price over time

| order_date | total_sales | avg_price | running_total_sales | moving_avg_price |
| --- | --- | --- | --- | --- |
| 2010-12-01 | 43,419 | 3,101 | 43,419 | 3,101 |
| 2011-01-01 | 7,075,088 | 3,192 | 7,118,507 | 3,146 |
| 2012-01-01 | 5,842,231 | 1,719 | 12,960,738 | 2,670 |
| 2013-01-01 | 16,344,878 | 309 | 29,305,616 | 2,080 |
| 2014-01-01 | 45642 | 23 | 29,351,258 | 1,668 |

### Key Findings
- Average prices tended to fall between 2011 and 2014.

### Interpretation
Sales performance peaked between late 2012 and early 2013; although there was a steady annual decline in product prices, revenue increased significantly this year due to a sharp rise in sales volumes. However, from late 2013 into early 2014, sales fell sharply. This was because the 2014 data only covered sales figures for January, meaning the results may be biased.

---

## 4. Performance Analysis

### Objective
Evaluate business performance by comparing the selected metric against a reference point, such as previous performance or another relevant period.

### Analytical Questions
- Which products or customers perform best?
- How does current performance compare with previous performance?
- Which entities show improvement or decline?

### Analysis Results

An annual analysis of product performance, comparing sales figures with average sales and performance in the previous year.

| order_year | product_name | current_sales | avg_sales | diff_avg | avg_change | prev_year_sales | diff_prev_year | prev_year_change |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| 2012 | All-Purpose Bike Stand | 159 | 13,197 | -13,038 | Below Avg | NULL | NULL | No Change |
| 2013 | All-Purpose Bike Stand | 37,683 | 13,197 | 24,486 | Above Avg | 159 | 37,524 | Increase |
| 2014 | All-Purpose Bike Stand | 1,749 | 13,197 | -11,448 | Below Avg | 37,683 | -35,934 | Decrease |
| 2012 | AWC Logo Cap | 72 | 6,570 | -6,498 | Below Avg | NULL | NULL | No Change |
| … | … | … | … | … | … | … | … | … |

### Key Findings
Sales of the Mountain-200 Black-42 recorded the highest average sales figure, at around $681,564, with the best performance in 2013. Most products also saw an increase or remained stable in 2013. 

### Interpretation
2013 was the company’s best-performing year due to high revenue levels, as sales volumes for the majority of products increased and remained stable.

---

## 5. Part-to-Whole Analysis

### Objective
Determine how individual categories or entities contribute to the overall total and identify the largest contributors.

### Analytical Questions
- Which categories contribute the most to total sales?
- What percentage of the total comes from each category?
- Is the total contribution concentrated in a small number of categories?

### Analysis Results

The product categories that contribute significantly to total sales

| category | total_sales | overall_sales | perc_of_total |
| --- | --- | --- | --- |
| Bikes | 28,316,272 | 29,356,250 | 96.46% |
| Accessories | 700,262 | 29,356,250 | 2.39% |
| Clothing | 339,716 | 29,356,250 | 1.16% |

### Key Findings
The Bike product category made the largest contribution to total sales, contributing 96.46%.

### Interpretation
The majority of the company’s revenue comes from products in the bike category, whilst there is still a segment of customers who purchase other products.

---

## 6. Data Segmentation

### Objective
Divide data into meaningful groups based on selected attributes or business rules to identify differences between segments.

### Analytical Questions
- How can customers or products be grouped?
- Which segments have the highest or lowest values?
- How does performance differ between segments?

### Analysis Results

Product groups by price range, along with information on the number of products in each group

| cost_range | total_products |
| --- | --- |
| Below 100 | 110 |
| 100 - 500 | 101 |
| 500 - 1000 | 45 |
| Above 1000 | 39 |

### Key Findings
Products priced under $100 are the most numerous among all price ranges. Meanwhile, there are 39 types of products priced above $1,000, which is the fewest number.

Customer groups based on their purchasing habits
Notes:
1. VIP: customers with a membership history of at least 12 months and total spending of more than $5,000.
2. Regular: customers with a membership history of at least 12 months, but total spending of $5,000 or less.
3. New: customers with a membership period of less than 12 months.

| customer_segment | total_customer |
| --- | --- |
| New | 14,631 |
| Regular | 2,198 |
| VIP | 1,655 |

### Key Findings
It turns out that more customers in the ‘New’ category have been members for less than 12 months.

### Interpretation
There are more products priced under $100 than those priced over $1,000. And there are more customers in the ‘New’ category who have only just registered, this means there are factors driving this increase in the number of new customers.

---

## 7. Overall Findings

### Key Takeaways

1. **Changes Over Time:** Sales performance improved as the fourth quarter began and declined again as the first quarter of the following year began.
2. **Cumulative Analysis:** Sales performance peaked between late 2012 and early 2013; however, from late 2013 to early 2014, sales fell sharply.
3. **Performance Analysis:** 2013 was the company’s best-performing year due to high revenue levels, as sales volumes for the majority of products increased and remained stable.
4. **Part-to-Whole Analysis:** The majority of the company’s revenue comes from products in the bike category.
5. **Data Segmentation:** There are more customers in the ‘New’ category who have only just registered.

### Conclusion

The advanced data analysis process provides a deeper understanding of business performance by examining changes over time, cumulative trends, relative performance, category contributions, and differences across segments.

These findings help identify areas that may require further investigation and provide a foundation for translating SQL analysis into business reports and performance dashboards.

### Next Step

The next stage is to communicate the analytical findings through a structured business report and an interactive Power BI performance dashboard.
