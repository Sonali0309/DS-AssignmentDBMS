use airportdb;

select * from flight ;

select * 
from flight 
where `from` = 9084 and 
`to` = 2658;

select * from airport;

select * from booking;

SELECT AVG(price)
FROM booking
WHERE flight_id = 3863;

select * from passenger;
select * from booking;

SELECT DISTINCT a.airlinename
FROM booking b
JOIN flight f ON b.flight_id = f.flight_id
JOIN airline a ON f.airline_id = a.airline_id
WHERE b.passenger_id = 16678;

select * from weatherdata;

SELECT COUNT(DISTINCT log_date)
FROM weatherdata
WHERE airpressure > 1015 AND humidity >= 98;

SELECT DISTINCT log_date
FROM weatherdata
WHERE airpressure > 1015 AND humidity >= 98 order by log_date;


SELECT a.airlinename, SUM(b.price) AS revenue
FROM booking b
JOIN flight f ON b.flight_id = f.flight_id
JOIN airline a ON f.airline_id = a.airline_id
GROUP BY a.airlinename
ORDER BY revenue DESC
LIMIT 20;






