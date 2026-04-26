CREATE DATABASE High_cloud_Airlines;
USE High_cloud_Airlines;
SELECT * FROM maindata;

-- KPI-1
SELECT 
	`Year`,
	`month` AS Month_No,
	Month_full_name,
	Quarter_name,
	YearMonth,
    Weekday_no,
    Weekday_name,
    Financial_month,
    Financial_Quarter
FROM maindata;

-- KPI-2
-- Year wise Load factor percentage
SELECT `year`,
CONCAT(ROUND((SUM(transported_passengers)/SUM(available_seats)*100),2),'%') AS Load_factor_percentage
FROM maindata
GROUP BY `year`
ORDER BY Load_factor_percentage DESC;

-- Quarter wise Load factor percentage
SELECT Quarter_name,
CONCAT(ROUND((SUM(transported_passengers)/SUM(available_seats)*100),2),'%') AS Load_factor_percentage
FROM maindata
GROUP BY Quarter_name
ORDER BY Load_factor_percentage DESC;

-- Month wise Load factor percentage
SELECT month_full_name,
CONCAT(ROUND((SUM(transported_passengers)/SUM(available_seats)*100),2),'%') AS Load_factor_percentage
FROM maindata
GROUP BY month_full_name
ORDER BY Load_factor_percentage DESC;

-- KPI-3 (load Factor percentage on a Carrier Name basis)
SELECT Carrier_name,
CONCAT(ROUND((SUM(transported_passengers)/SUM(available_seats)*100),2),'%') AS Load_factor_percentage
FROM maindata
GROUP BY carrier_name
ORDER BY Load_factor_percentage DESC;

-- KPI-4 (Top 10 Carrier Names based on passengers preference)
SELECT Carrier_name,
CONCAT(ROUND(SUM(transported_passengers)/1000000,1),"M") AS Passengers_preference
FROM maindata
GROUP BY carrier_name
ORDER BY SUM(transported_passengers) DESC
LIMIT 10;

-- KPI-5 (Top Routes 'from-to City' based on Number of Flights)
SELECT from_to_city,COUNT(*) AS Number_of_flights
FROM maindata
GROUP BY from_to_city
ORDER BY Number_of_flights DESC
LIMIT 10;

-- KPI-6 (load factor is occupied on Weekend vs Weekdays)
SELECT 
	CASE
		WHEN weekday_no IN (6,7) THEN 'Weekend'
        ELSE 'Weekday'
	END AS Weekend_vs_Weekdays,
    CONCAT(ROUND(SUM(transported_passengers)/SUM(available_seats)*100,2),'%') AS Load_factor_percentage
FROM maindata
GROUP BY Weekend_vs_Weekdays;

-- KPI-7 (number of flights based on Distance group)
SELECT d.distance_interval AS Distance_Groups,CONCAT(ROUND(SUM(m.departures_performed)/1000),"K") AS Number_of_flights
FROM maindata m JOIN distance_groups d
ON m.distance_group_ID=d.distance_group_ID
GROUP BY Distance_groups
ORDER BY SUM(m.departures_performed) DESC;