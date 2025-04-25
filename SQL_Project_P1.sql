CREATE TABLE Retail_Sales(
	transactions_id INT PRIMARY KEY,
	sale_date DATE,
	sale_time TIME,
	customer_id	INT,
	gender VARCHAR(15),
	age	INT,
	category VARCHAR(15),
	quantiy	INT,
	price_per_unit FLOAT,
	cogs FLOAT,	
	total_sale FLOAT
);

SELECT * FROM Retail_Sales;

--Data Cleaning
DELETE FROM Retail_Sales
WHERE Transactions_ID IS NULL
OR
Sale_Date IS NULL
OR
sale_time IS NULL
OR
gender IS NULL
OR
category IS NULL
OR
quantiy	IS NULL
OR
cogs IS NULL
OR
total_sale IS NULL;

--Data Exploration
SELECT * FROM Retail_Sales;

--How many Sales we have?
SELECT COUNT(*) AS Total_Sales FROM Retail_Sales;

--How many Unique customers we have?
SELECT COUNT(DISTINCT Customer_ID) AS Total_Unique_Customers FROM Retail_Sales;

/*Data Analysis * Business Key Problems*/
--Q.1 Write a query to retreive all columns for sales made on '2022-11-05'
SELECT * FROM Retail_Sales 
Where Sale_Date = '2022-11-05';

--Q.2 Write a query to retreive all transactions where category is clothing & quantity sold more than equal to 4 in month of NOV 2022.
SELECT * FROM Retail_Sales 
Where Category = 'Clothing'
AND 
TO_CHAR (Sale_Date, 'YYYY-MM')= '2022-11'
AND 
Quantity >=4;

--Q.3 Write a query to calculate the total sales for each category.
SELECT DISTINCT Category, SUM(Total_Sale) AS Total_Sales
FROM Retail_Sales 
GROUP BY Category;

--Q.4 Write a query to find average age of customers who purchased items from 'beauty' category.
SELECT ROUND(AVG(age), 2) AS Avg_Age
FROM Retail_Sales 
Where Category = 'Beauty';

--Q.5 Write a query to find all transactions where the total_sales is greater than 1000.
SELECT Transactions_id
FROM Retail_Sales 
Where Total_Sale > 1000;

--Q.6 Write a query to find total no of transactions(transaction_id) made by each gender in each category.**
SELECT Gender, Category, COUNT(Transactions_id) AS Total_Transactions
FROM Retail_Sales 
GROUP BY Gender, Category;

--Q.7 Write a query to calculate the average sale of each month. Find best selling month in each year.**
SELECT YEARS, Months, Avg_Sales FROM
(
	SELECT
	EXTRACT(YEAR FROM Sale_Date) AS Years,
	EXTRACT(MONTH FROM Sale_Date) AS months,
	ROUND(AVG(Total_Sale)::numeric, 2) AS Avg_Sales,
	RANK() OVER(Partition BY EXTRACT(YEAR FROM Sale_Date) ORDER BY AVG(Total_Sale) DESC) AS RANKK
	FROM Retail_Sales 
	GROUP BY Years, Months
	ORDER BY 1,3
) AS t1
WHERE RANKK =1;

--Q.8 Write a query to find the top 5 customers based on the highest total_sales
SELECT Customer_id, SUM(Total_Sale) AS Total_Sales FROM Retail_Sales
GROUP BY Customer_id
ORDER BY Total_Sales DESC
LIMIT 5

--Q.9 Write a query to find no of unique customers who purchased items in each category.
SELECT COUNT(DISTINCT Customer_id) AS Purchased_Items, Category FROM Retail_Sales
GROUP BY Category
	
SELECT * FROM Retail_Sales


--Q.10 Write a query to create each shift and no of orders(EX: Morning<=12, Afternoon beyween 12 & 17, Evening>1.
WITH Hourly_Sales AS
(
SELECT *,
	CASE 
		WHEN EXTRACT(Hour FROM Sale_Time) < 12 THEN 'Morning Shift'
		WHEN EXTRACT(Hour FROM Sale_Time) BETWEEN 12 AND 17 THEN 'Afternoon Shift'
		ELSE 'Evening Shift'
	END AS Shift
FROM Retail_Sales
)
SELECT Shift, COUNT(*) AS Total_Orders FROM Hourly_Sales
GROUP BY Shift;

SELECT EXTRACT(Hour FROM Current_Time)



















































