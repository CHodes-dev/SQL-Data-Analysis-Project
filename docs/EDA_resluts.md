# Exploratory Data Analysis (EDA) Results

## 1. Overview

### Objective

This document presents the results of the Exploratory Data Analysis (EDA) process performed using SQL. The analysis aims to understand the dataset structure, explore dimensions and measures, identify patterns, and generate initial insights.

### EDA Process

The analysis consists of the following stages:
1. Database Exploration
2. Dimension Exploration
3. Date Exploration
4. Measure Exploration
5. Magnitude Analysis
6. Ranking Analysis

---

## 2. Database Exploration

### Objective
Understand the database structure, available tables, data types, and the overall characteristics of the dataset.

### Analysis Results
- There are three different schemas: bronze, silver and gold. The bronze and silver schemas each contain six tables, whilst the gold schema contains three views.

![Database Structure](https://github.com/CHodes-dev/SQL-Data-Analysis-Project/blob/main/docs/db_structure.png)

- Through more detailed data exploration down to table level, not only do the database, schema and table names appear, but so do the column names for each table. Furthermore, the data types, character lengths and NULL rules for each table can be identified.

![Database Structure 2](https://github.com/CHodes-dev/SQL-Data-Analysis-Project/blob/main/docs/db_structure_2.png)

Once we know which tables and data columns are contained in the database, we can distinguish between dimension and measure columns. We can then proceed to explore the dimension tables.

## 3. Dimension Explorartion

### Objective
Identify the available dimensions, unique values, and categories that can be used to segment the data.

### Analysis Results
- Table **dim_customers** contains data on customers’ countries of origin; there are a total of 6 different countries (Germany, United States, Australia, United Kingdom, Canada, and France).
- Table **dim_products** has three interrelated columns: category, subcategory and product name. This allows us to see how the data can be grouped. If grouped by **category**, there will be **four data groups**; if grouped by **subcategory**, there will be **36 data groups**; and if grouped by **product**, there will be **295 data groups**.

## 4. Date Exploration

### Objective
Understand the time range of the dataset and identify relevant temporal patterns.

### Analysis Results
- It turns out that the first booking was made on **29 December 2010**, whilst the last booking was made on The product sells best in the United States and Australia, followed by Canada and other countries..
- Once the difference between the first and last dates on which orders were placed is known, it can be determined that the available sales data covers a period of four years.
- The oldest customer is **110 years old**; they were born on 10 February 1916. Meanwhile, the youngest customer is **40 years** old and was born on 26 June 1986.
  
## 5. Measure Exploration

### Objective
Understand the characteristics of numerical measures using aggregate functions such as SUM, AVG, MIN, and MAX.

## Analysis Results
- Total revenue from product sales over the four-year period was **$29,356,250**.
- The company’s average daily revenue over the four-year period was **$486**.
- There were **60,398** orders placed over the four-year period. However, this figure comprises orders from the same customers who purchased different products during their transactions.
- There were **27,659** instances where customers placed orders, and in each transaction, they could purchase one or more products.
- The number of products available to customers is **295** different items.
- There are **18,484** customers recorded in the system; however, there are indications that some customers have registered but have not yet placed an order.
- It turns out that the result is the same as the previous customer count, namely **18,484** people, all of whom have registered and placed an order.

## 6. Magnitude Analysis

### Objective
Measure and compare the size or contribution of different categories or entities based on selected metrics.

### Analysis
- The majority of customers are from the United States, accounting for almost half of the total number of registered customers. However, there are still 337 customers whose country of origin is not recorded, indicated as ‘n/a’.

| country | total_customers |
| --- | --- |
| United States	 | 7,482 |
| Australia | 3,591 |
| United Kingdom | 1,913 |
| France | 1,810 |
| Germany | 1,780 |
| Canada | 1,571 |
| n/a	 | 337 |

- The gender breakdown of customers is almost identical, and the proportion of customers whose gender is not recorded is also relatively small.
| gender | total_customers |
| --- | --- |
| Male | 9,341 |
| Female | 9,128 |
| n/a | 15 |

- There are more products in the ‘Components’ and ‘Bikes’ categories, whilst there are fewer in the ‘Clothing’ and ‘Accessories’ categories. There are also products that do not fall into any category.
| category | total_products |
| --- | --- |
| Components | 127 |
| Bikes | 97 |
| Clothing | 35 |
| Accessories | 29 |
| NULL | 7 |

- Products in the bicycles category account for the highest costs, at almost five times that of the components category. The costs for the accessories and unclassified items categories are significantly lower than those of the top two product categories.
| category | avg_costs |
| --- | --- |
| Bikes | 949 |
| Components | 264 |
| NULL | 28 |
| Clothing | 24 |
| Accessories | 13 |

- Almost 100% of the company’s revenue comes from sales of products in the cycling category.
| category | total_revenue |
| --- | --- |
| Bikes | 28,316,272 |
| Accessories | 700,262 |
| Clothing | 339,716 |
| Components | NULL |
| NULL | NULL |

- The top nine customers spent approximately $13,000 on products.

- The product sells best in the United States and Australia, followed by Canada and other countries.
| country | total_sold_item |
| --- | --- |
| United States	 | 20,481 |
| Australia | 13,346 |
| Canada | 7,630 |
| United Kingdom | 6,910 |
| Germany | 5,626 |
| France | 5,559 |
| n/a	 | 871 |

## 7. Ranking Analysis

### Objective
Rank entities based on a selected measure to identify the highest-performing and lowest-performing entities.

### Analysis Results
- The top five products that contribute most to the company’s revenue are from the bicycle category. Each accounts for nearly 5% of the company’s revenue.
| product_name | total_revenue | rank_products |
| --- | --- | --- |
| Mountain-200 Black- 46 | 1,373,454 | 1 |
| Mountain-200 Black- 42 | 1,363,128 | 2 |
| Mountain-200 Silver- 38 | 1,339,394 | 3 |
| Mountain-200 Silver- 46 | 1,301,029 | 4 |
| Mountain-200 Black- 38 | 1,294,854 | 5 |

- The two products with the lowest sales were racing socks in various sizes, accounting for less than 0.01% of the company’s revenue.
| product_name | total_revenue |
| --- | --- |
| Racing Socks- L | 2430 |
| Racing Socks- M	 | 2682 |
| Patch Kit/8 Patches | 6382 |
| Bike Wash - Dissolver | 7272 |
| Touring Tire Tube | 7440 |

- This data can be used to offer incentives to these customers, such as discounts or special items as a bonus.
| customer_key | first_name | last_name | total_revenue |
| --- | --- | --- | --- |
| 1302 | Nichole | Nara | 13,294 |
| 1133 | Kaitlyn | Henderson | 13,294 |
| 1309 | Margaret | He | 13,268 |
| 1132 | Randall | Dominguez | 13,265 |
| 1301 | Adriana | Gonzalez | 13,242 |
| 1322 | Rosa | Hu | 13,215 |
| 1125 | Brandi | Gill | 13,195 |
| 1308 | Brad | She | 13,172 |
| 1297 | Francisco | Sara | 13,164 |
| 434 | Maurice | Shan | 12,914 |

- This data can also be used to prioritise advertising targets in order to increase the number of customer purchases.
| customer_id | first_name | last_name | total_orders |
| --- | --- | --- | --- |
| 11015 | Chloe | Young | 1 |
| 11016 | Wyatt | Hill | 1 |
| 11020 | Jordan | King | 1 |

## 8. Overall EDA Summary

### Key Takeaways
1. **Database Structure:**
2. **Dimension:**
3. **Date Exploration:**
4. **Measure:**
5. **Magnitude Analysis:**
6. **Ranking Analysis:**

### Conclusion
The EDA process provided an initial understanding of the dataset's structure, dimensions, measures, and key patterns. These findings establish a foundation for further analysis by identifying relevant areas to investigate and questions that may require deeper exploration.

### Next Step
The next stage is to perform more focused SQL analysis to investigate business-related questions, examine patterns in greater detail, and translate the findings into actionable insights.
