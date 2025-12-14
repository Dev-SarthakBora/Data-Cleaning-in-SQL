# 📊 SQL Layoffs Data Analysis

An end-to-end **SQL-only data analytics project** focused on data cleaning and exploratory data analysis (EDA) to uncover global layoff trends across companies, industries, countries, and time periods.

---

## 📘 Project Overview

This project analyzes a real-world layoffs dataset using **pure SQL**.  
The primary objective was to transform raw, inconsistent data into a clean, analysis-ready format and then extract meaningful business insights through structured SQL queries.

The project demonstrates strong fundamentals in:
- Data cleaning
- SQL querying
- Analytical thinking
- Insight generation

---

## 📂 Dataset Description

The dataset contains company-level layoff records with the following attributes:

- **company** – Company name  
- **location** – City of operation  
- **industry** – Business sector  
- **total_laid_off** – Number of employees laid off  
- **percentage_laid_off** – Percentage of workforce affected  
- **date** – Layoff announcement date  
- **stage** – Funding or company stage  
- **country** – Country of operation  
- **funds_raised_millions** – Total funding raised (USD millions)

The raw data included duplicates, inconsistent naming, missing values, and incorrect data types, requiring extensive cleaning before analysis.

---

## 🧹 Data Cleaning (SQL)

The following data cleaning steps were performed entirely using SQL:

- Removed duplicate records using `ROW_NUMBER()` and window functions  
- Standardized industry names (e.g., Crypto variations)  
- Filled missing industry values using self-joins  
- Fixed inconsistent country names  
- Converted date column from text to proper `DATE` format  
- Removed records with no layoff information  

A staging-table approach was used to ensure the raw data remained unchanged.

---

## 📊 Exploratory Data Analysis (EDA)

After cleaning, EDA was performed to answer key business questions such as:

- Which companies had the highest total layoffs?
- Which industries were most impacted?
- Which countries experienced the most layoffs?
- How did layoffs vary year by year?

All insights were derived using SQL aggregations, grouping, filtering, and date functions.

---

## 🔍 Key Insights

- Layoffs are concentrated among a relatively small number of companies  
- Technology-driven industries account for the majority of layoffs  
- The United States leads globally in total layoffs  
- Certain years show significant spikes in layoff activity  

These insights highlight the importance of industry and geography in workforce trends.

---

## 🛠 Tools & Technologies Used

- **MySQL**
- **SQL (Window Functions, Joins, Aggregations)**
- **Data Cleaning & EDA**

> No Python, BI tools, or external libraries were used — analysis was performed entirely in SQL.

---

## 🌐 Project Website

This project is also presented as a **static project landing page** hosted on **GitHub Pages**, showcasing:
- Dataset explanation  
- SQL queries in code blocks  
- Query results (via screenshots)  
- Insights in a clean, readable format  

---

## 🚀 How to Use

1. Clone the repository  
2. Import the dataset into a SQL database  
3. Execute the SQL scripts in order  
4. Review insights and results  

---

## 🙌 Author

**Sarthak Bora**  
Data Analyst  

---

## ⭐ Final Note

This project emphasizes **clean SQL design**, **data integrity**, and **analytical reasoning**, making it well-suited for demonstrating SQL proficiency in interviews and portfolio reviews.
