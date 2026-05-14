# 🛒 **Hypermarket Sales Dashboard Analysis**

## 📌 Project Overview

This project analyzes hypermarket sales data from January 2012 to March 2013 using Excel, SQL, and Power BI to evaluate sales performance, promotional impact, customer purchasing behavior, and product category trends.

---

## 🎯 Business Problem

The objective is to identify:

* High-performing product categories
* Sales growth trends
* Promotion effectiveness
* Customer purchasing behavior
* Revenue contribution by merchant location

---

## 🛠️ Tools Used

* **MS Excel**
* **SQL**
* **Power BI**
* **Data Visualization**
* **Business Analytics**

---

## 📂 Dataset

* Transactional retail sales dataset
* Sales records from Jan 2012 to Mar 2013
* Includes:

  * Product Categories
  * Merchant Locations
  * Promotions
  * Customer Transactions
  * Sales Amounts

---

## 🔄 Data Cleaning (Excel)

* Removed duplicates
* Handled missing values
* Standardized date formats
* Verified data consistency

---

## 🧠 SQL Analysis

### Key Analysis Performed

* Total Sales by Merchant Location
* Customer Purchase Analysis
* Average Transaction Value
* Month-over-Month Growth
* Product Category Contribution
* Promotion Impact Analysis

### Example SQL Query

```sql
SELECT merchant_location,
SUM(sales_amount) AS total_sales
FROM sales_data
GROUP BY merchant_location
ORDER BY total_sales DESC;
```

---

## 📊 Power BI Dashboard Features

* Total Sales KPI
* Quantity Sold KPI
* Promotion Usage Analysis
* Top 5 Selling Products
* Sales by Product Category
* Sales by Merchant Location
* MoM Growth Visualization
* Interactive Filters & Slicers

---

## 📸 Dashboard Preview

![Power BI Dashboard](screenshots/dashboard.png)

---

## 🔍 Key Insights

* Promotions increased sales in selected categories.
* Some merchant locations generated significantly higher revenue.
* A small number of products contributed major sales volume.
* Sales trends helped identify seasonal growth opportunities.

---

## 🚀 Outcome

This project demonstrates end-to-end retail sales analytics using Excel, SQL, and Power BI for business intelligence and decision-making.

---

## 🏷️ Skills Demonstrated

#Excel #SQL #PowerBI #DataAnalytics #BusinessIntelligence #DashboardDesign #RetailAnalytics #DataVisualization #AnalyticsProject #GitHubPortfolio
