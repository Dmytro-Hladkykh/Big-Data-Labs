USE flightsdb;

INSERT OVERWRITE TABLE top_airlines
SELECT a.AIRLINE_CODE, b.AIRLINE_NAME, AVG(a.DEPARTURE_DELAY) AS avg_departure_delay
FROM flights a
JOIN airlines b
ON a.AIRLINE_CODE = b.IATA_CODE
GROUP BY a.AIRLINE_CODE, b.AIRLINE_NAME
ORDER BY avg_departure_delay DESC
LIMIT 5;

SELECT * FROM top_airlines;
