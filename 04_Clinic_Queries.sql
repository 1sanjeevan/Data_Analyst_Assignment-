USE clinic_db;

-- Q1: Revenue by sales channel
SELECT sales_channel, SUM(amount) AS total_revenue
FROM clinic_sales
WHERE YEAR(datetime) = 2021
GROUP BY sales_channel;

-- Q2: Top 10 most valuable customers
SELECT cs.uid, c.name, SUM(cs.amount) AS total_spent
FROM clinic_sales cs
JOIN customer c ON cs.uid = c.uid
WHERE YEAR(cs.datetime) = 2021
GROUP BY cs.uid, c.name
ORDER BY total_spent DESC LIMIT 10;

-- Q3: Month wise revenue, expense, profit
WITH rev AS (
    SELECT MONTH(datetime) AS month, SUM(amount) AS revenue
    FROM clinic_sales WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
),
exp AS (
    SELECT MONTH(datetime) AS month, SUM(amount) AS expense
    FROM expenses WHERE YEAR(datetime) = 2021
    GROUP BY MONTH(datetime)
)
SELECT r.month,
    COALESCE(r.revenue,0) AS revenue,
    COALESCE(e.expense,0) AS expense,
    COALESCE(r.revenue,0) - COALESCE(e.expense,0) AS profit,
    CASE WHEN COALESCE(r.revenue,0) - COALESCE(e.expense,0) > 0
    THEN 'Profitable' ELSE 'Not-Profitable' END AS status
FROM rev r LEFT JOIN exp e ON r.month = e.month;

-- Q4: Most profitable clinic per city per month
WITH profit AS (
    SELECT cl.cid, cl.clinic_name, cl.city,
        COALESCE(SUM(cs.amount),0) - COALESCE(SUM(e.amount),0) AS profit
    FROM clinics cl
    LEFT JOIN clinic_sales cs ON cl.cid=cs.cid AND YEAR(cs.datetime)=2021 AND MONTH(cs.datetime)=9
    LEFT JOIN expenses e ON cl.cid=e.cid AND YEAR(e.datetime)=2021 AND MONTH(e.datetime)=9
    GROUP BY cl.cid, cl.clinic_name, cl.city
),
ranked AS (
    SELECT *, RANK() OVER (PARTITION BY city ORDER BY profit DESC) AS rnk
    FROM profit
)
SELECT city, clinic_name, profit FROM ranked WHERE rnk=1;

-- Q5: Second least profitable clinic per state
WITH profit AS (
    SELECT cl.cid, cl.clinic_name, cl.state,
        COALESCE(SUM(cs.amount),0) - COALESCE(SUM(e.amount),0) AS profit
    FROM clinics cl
    LEFT JOIN clinic_sales cs ON cl.cid=cs.cid AND YEAR(cs.datetime)=2021 AND MONTH(cs.datetime)=9
    LEFT JOIN expenses e ON cl.cid=e.cid AND YEAR(e.datetime)=2021 AND MONTH(e.datetime)=9
    GROUP BY cl.cid, cl.clinic_name, cl.state
),
ranked AS (
    SELECT *, DENSE_RANK() OVER (PARTITION BY state ORDER BY profit ASC) AS rnk
    FROM profit
)
SELECT state, clinic_name, profit FROM ranked WHERE rnk=2;