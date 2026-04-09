USE hotel_db;

-- Q1: Last booked room per user
SELECT u.user_id, b.room_no
FROM users u
JOIN bookings b ON u.user_id = b.user_id
WHERE b.booking_date = (
    SELECT MAX(b2.booking_date)
    FROM bookings b2
    WHERE b2.user_id = u.user_id
);

-- Q2: Booking and total billing in November 2021
SELECT bc.booking_id,
    SUM(bc.item_quantity * i.item_rate) AS total_billing_amount
FROM bookings b
JOIN booking_commercials bc ON b.booking_id = bc.booking_id
JOIN items i ON bc.item_id = i.item_id
WHERE YEAR(b.booking_date) = 2021 AND MONTH(b.booking_date) = 11
GROUP BY bc.booking_id;

-- Q3: Bills in October 2021 with amount > 1000
SELECT bc.bill_id,
    SUM(bc.item_quantity * i.item_rate) AS bill_amount
FROM booking_commercials bc
JOIN items i ON bc.item_id = i.item_id
WHERE YEAR(bc.bill_date) = 2021 AND MONTH(bc.bill_date) = 10
GROUP BY bc.bill_id
HAVING SUM(bc.item_quantity * i.item_rate) > 1000;

-- Q4: Most and least ordered item per month
WITH monthly AS (
    SELECT MONTH(bc.bill_date) AS month,
        bc.item_id, i.item_name,
        SUM(bc.item_quantity) AS total_ordered
    FROM booking_commercials bc
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY MONTH(bc.bill_date), bc.item_id, i.item_name
),
ranked AS (
    SELECT *,
        RANK() OVER (PARTITION BY month ORDER BY total_ordered DESC) AS most_rank,
        RANK() OVER (PARTITION BY month ORDER BY total_ordered ASC) AS least_rank
    FROM monthly
)
SELECT month,
    MAX(CASE WHEN most_rank=1 THEN item_name END) AS most_ordered,
    MAX(CASE WHEN least_rank=1 THEN item_name END) AS least_ordered
FROM ranked GROUP BY month;

-- Q5: Second highest bill per month
WITH bill_totals AS (
    SELECT b.user_id, MONTH(bc.bill_date) AS month,
        SUM(bc.item_quantity * i.item_rate) AS bill_amount
    FROM booking_commercials bc
    JOIN bookings b ON bc.booking_id = b.booking_id
    JOIN items i ON bc.item_id = i.item_id
    WHERE YEAR(bc.bill_date) = 2021
    GROUP BY b.user_id, MONTH(bc.bill_date)
),
ranked AS (
    SELECT *, DENSE_RANK() OVER (PARTITION BY month ORDER BY bill_amount DESC) AS rnk
    FROM bill_totals
)
SELECT month, user_id, bill_amount
FROM ranked WHERE rnk = 2;
