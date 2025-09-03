CREATE DATABASE OLA ;

use ola ;

ALTER TABLE `bookings-100000-rows` RENAME bookings;        
#1. Retrieve all successful bookings:
SELECT SUCCESSFUL_BOOKINGS FROM BOOKINGS;

#2. Find the average ride distance for each vehicle type:
SELECT Distance_for_each_vehicle FROM BOOKINGS;

#3. Get the total number of cancelled rides by customers:
SELECT Cancelled_ride_by_customer FROM BOOKINGS;

#4. List the top 5 customers who booked the highest number of rides:
SELECT top_5_customers FROM BOOKINGS;

#5. Get the number of rides cancelled by drivers due to personal and car-related issues:
SELECT Canceled_Rides_by_Driver_personal FROM BOOKINGS;

#6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
SELECT prime_sedan_raiting_max_min FROM BOOKINGS;

#7. Retrieve all rides where payment was made using UPI:
SELECT Payment_upi FROM BOOKINGS;

#8. Find the average customer rating per vehicle type:
SELECT AVG_rating FROM BOOKINGS;

#9. Calculate the total booking value of rides completed successfully:
SELECT total_booking_value_completed_rides FROM BOOKINGS;

#10. List all incomplete rides along with the reason:
SELECT incomplete_ride_with_reason FROM BOOKINGS;


# 1. Retrieve all successful bookings:
CREATE VIEW SUCCESSFUL_BOOKINGS AS
SELECT * FROM bookings
WHERE booking_status = 'success';

# 2. Find the average ride distance for each vehicle type:

CREATE VIEW Distance_for_each_vehicle AS  
SELECT vehicle_type,
	   ROUND(AVG(ride_distance),2) AS AVG_distance
       FROM bookings
       GROUP BY vehicle_type;
	
       
# 3. Get the total number of cancelled rides by customers:
CREATE VIEW Cancelled_ride_by_customer AS
SELECT COUNT(Canceled_Rides_by_Customer) AS Canceled_by_customer
FROM bookings;

# 4. List the top 5 customers who booked the highest number of rides:
CREATE VIEW top_5_customers AS
SELECT customer_id,
	   COUNT(booking_value) AS total_booking
       FROM bookings
       GROUP BY customer_id
	   ORDER BY total_booking desc LIMIT 5 ;
       
# 5. Get the number of rides cancelled by drivers due to personal and car-related issues:
CREATE VIEW Canceled_Rides_by_Driver_personal AS 
SELECT count(Canceled_Rides_by_Driver)
FROM bookings
WHERE Canceled_Rides_by_Driver = 'personal & car related issue';

# 6. Find the maximum and minimum driver ratings for Prime Sedan bookings:
CREATE VIEW prime_sedan_raiting_max_min AS
SELECT MAX(driver_ratings) AS Max_rating,
	   MIN(driver_ratings) AS Min_rating
       FROM bookings
       WHERE vehicle_type = 'prime sedan';


# 7. Retrieve all rides where payment was made using UPI:
CREATE VIEW Payment_upi AS
SELECT * 
FROM bookings
WHERE payment_method = 'UPI';

# 8. Find the average customer rating per vehicle type:
CREATE VIEW AVG_rating AS 
SELECT vehicle_type,
	  ROUND(AVG(customer_rating),2) AS AVG_rating
      FROM bookings
      GROUP BY vehicle_type;

# 9. Calculate the total booking value of rides completed successfully:
CREATE VIEW total_booking_value_completed_rides AS
SELECT sum(booking_value) as total_booking
FROM bookings
WHERE booking_status = 'success';

# 10. List all incomplete rides along with the reason:
CREATE VIEW incomplete_ride_with_reason AS
SELECT booking_id,
       incomplete_rides_reason
       FROM bookings
       WHERE incomplete_rides ='yes';