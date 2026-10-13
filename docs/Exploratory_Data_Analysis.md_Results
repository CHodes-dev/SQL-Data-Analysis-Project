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

[Database Structure]

- Through more detailed data exploration down to table level, not only do the database, schema and table names appear, but so do the column names for each table. Furthermore, the data types, character lengths and NULL rules for each table can be identified.

[Database Structure 2]

Once we know which tables and data columns are contained in the database, we can distinguish between dimension and measure columns. We can then proceed to explore the dimension tables.

## 3. Dimension Explorartion

### Objective
Identify the available dimensions, unique values, and categories that can be used to segment the data.

### Analysis Results
- Table **dim_customers** contains data on customers’ countries of origin; there are a total of 6 different countries (Germany, United States, Australia, United Kingdom, Canada, and France).
- Table **dim_products** has three interrelated columns: category, subcategory and product name. This allows us to see how the data can be grouped. If grouped by category, there will be four data groups; if grouped by subcategory, there will be 36 data groups; and if grouped by product, there will be 295 data groups.

## 4. Date Exploration

### Objective
Understand the time range of the dataset and identify relevant temporal patterns.

### Analysis Results
- It turns out that the first booking was made on 29 December 2010, whilst the last booking was made on 28 January 2014.
- Once the difference between the first and last dates on which orders were placed is known, it can be determined that the available sales data covers a period of four years.
- The oldest customer is 110 years old; they were born on 10 February 1916. Meanwhile, the youngest customer is 40 years old and was born on 26 June 1986.

### Interpretation

  
## 5. Measure Exploration

### Objective
