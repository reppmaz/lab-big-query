-- Exercise 1: Count the number of trips in January 2023
SELECT COUNT(*) AS total_trips
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2023`
WHERE EXTRACT(YEAR FROM pickup_datetime) = 2023
  AND EXTRACT(MONTH FROM pickup_datetime) = 1;

-- Exercise 2: Calculate the total revenue generated by taxi trips in 2023
SELECT SUM(total_amount) AS total_revenue
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2023`
WHERE EXTRACT(YEAR FROM pickup_datetime) = 2023;

-- Exercise 3: Find the most popular pickup location
SELECT pickup_location_id, COUNT(*) AS trip_count
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2023`
GROUP BY pickup_location_id
ORDER BY trip_count DESC
LIMIT 1;

-- Exercise 4: Analyze the number of trips per hour of the day
SELECT EXTRACT(HOUR FROM pickup_datetime) AS hour_of_day, COUNT(*) AS trip_count
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2023`
GROUP BY hour_of_day
ORDER BY hour_of_day;

-- Exercise 5: Calculate the average trip distance
SELECT AVG(trip_distance) AS average_distance
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2023`;

-- Exercise 6: Find the longest trip by distance
SELECT *
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2023`
ORDER BY trip_distance DESC
LIMIT 1;

-- Exercise 7: Calculate the total number of passengers by payment type
SELECT payment_type, SUM(passenger_count) AS total_passengers
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2023`
GROUP BY payment_type;

-- Exercise 8: Find the most common drop-off location for trips paid by credit card
SELECT dropoff_location_id, COUNT(*) AS trip_count
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2023`
WHERE payment_type = 1 -- 1 indicates credit card payment
GROUP BY dropoff_location_id
ORDER BY trip_count DESC
LIMIT 1;

-- Exercise 9: Calculate the total number of trips that had more than 4 passengers
SELECT COUNT(*) AS trips_with_more_than_4_passengers
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2023`
WHERE passenger_count > 4;

-- Exercise 10: Subquery - Find the average fare for trips longer than the average trip distance
WITH avg_distance AS (
  SELECT AVG(trip_distance) AS average_distance
  FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2023`
)
SELECT AVG(total_amount) AS average_fare
FROM `bigquery-public-data.new_york_taxi_trips.tlc_yellow_trips_2023`
WHERE trip_distance > (SELECT average_distance FROM avg_distance);

