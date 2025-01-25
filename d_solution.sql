-- D.1 Display all items and their nutritional value + their category.
SELECT
    p.name AS product_name,
    c.name AS category_name,
    n.calories,
    n.fats,
    n.sugar
FROM products p
JOIN category c ON c.category_id = p.category_id
LEFT JOIN nutritions n ON n.product_id = p.product_id;


-- D.2 Display all orders, and for each order, show all product details.
SELECT
    o.order_id,
    o.date_time,
    o.address,
    o.customer_name,
    o.customer_ph,
    o.total_price,
    p.name AS product_name,
    p.price,
    c.name AS category_name,
    po.amount
FROM orders o
JOIN products_orders po ON po.order_id = o.order_id
JOIN products p ON p.product_id = po.product_id
JOIN category c ON c.category_id = p.category_id
ORDER BY o.order_id;


-- D.3 Add an additional product to each order using INSERT
INSERT INTO products_orders (order_id, product_id, amount)
SELECT
    order_id,   --  for each order_id
    6,          --  (6) Coca Cola
    2           --  Qty 2
FROM orders
ON CONFLICT (order_id, product_id)
DO NOTHING;

-- OR
INSERT INTO products_orders (order_id, product_id, amount)
SELECT
    o.order_id,   -- For each order_id
    (SELECT product_id FROM products WHERE name = 'COCA COLA' LIMIT 1),  -- Find Product ID (6) Coca Cola
    2  -- Adding 2 more bottles
FROM orders o
ON CONFLICT (order_id, product_id)
DO UPDATE
SET amount = products_orders.amount + EXCLUDED.amount;

--For checking How many Coca Cola update/insert
--select
--	o.order_id,
--	p.name,
--	o.customer_name,
--  po.amount
--from orders o
--join products_orders po on po.order_id = o.order_id
--join products p on p.product_id = po.product_id
--where po.product_id = 6
--order by o.order_id;

-- D.4 Update the total cost of all orders (quantity × product price), using UPDATE
UPDATE orders o
SET total_price =
    (SELECT SUM(po.amount * p.price)
     FROM products_orders po
     JOIN products p ON p.product_id = po.product_id
     WHERE po.order_id = o.order_id
    );

--  For checking total price
--  select
--	o.order_id,
--	o.total_price,
--	p.name,
--	o.customer_name,
--    po.amount
--from orders o
--join products_orders po on po.order_id = o.order_id
--join products p on p.product_id = po.product_id
--order by o.order_id;

--D.5 What is the most expensive order? The cheapest order? And what is the average order?
(SELECT
    'expensive_order' AS order_type,
    o.order_id,
    o.customer_name,
    o.total_price
FROM
    orders o
ORDER BY o.total_price DESC
LIMIT 1)
UNION ALL
(SELECT
    'cheapest_order' AS order_type,
    o.order_id,
    o.customer_name,
    o.total_price
FROM
    orders o
ORDER BY o.total_price ASC
LIMIT 1)
UNION ALL
(SELECT
    'average_order' AS order_type,
    NULL AS order_id,
    NULL AS customer_name,
    AVG(total_price) AS total_price
FROM orders);

--OR
(SELECT
    'expensive_order' AS order_type,
    o.order_id,
    o.customer_name,
    o.total_price
FROM
    orders o
WHERE o.total_price = (SELECT MAX(total_price) FROM orders))
UNION ALL
(SELECT
    'cheapest_order' AS order_type,
    o.order_id,
    o.customer_name,
    o.total_price
FROM
    orders o
WHERE o.total_price = (SELECT MIN(total_price) FROM orders))
UNION ALL
(SELECT
    'average_order' AS order_type,
    NULL AS order_id,
    NULL AS customer_name,
    AVG(total_price) AS total_price
FROM orders);

--D.6 Who is the customer who has ordered the most times?
SELECT customer_name, COUNT(*) AS order_count
FROM orders
GROUP BY customer_name;

-- New Data
--INSERT INTO orders (date_time, address, customer_name, customer_ph, total_price)
--VALUES ('2025-02-01 12:30:00', '123 Main St', 'John Doe', '555-1234', 15.00)
--RETURNING order_id;
--
--INSERT INTO products_orders (order_id, product_id, amount)
--VALUES (RETURNING order_id, 6, 10);

-- D.7 Which product was sold the most, the least, and the average?
(SELECT -- TOP_SELLING
    P.PRODUCT_ID,
    P.NAME,
    SUM(PO.AMOUNT) AS TOTAL_SALES,
    'TOP_SELLING' AS SELL_TYPE
FROM PRODUCTS P
JOIN PRODUCTS_ORDERS PO ON PO.PRODUCT_ID = P.PRODUCT_ID
GROUP BY P.PRODUCT_ID, P.NAME
ORDER BY TOTAL_SALES DESC
LIMIT 1)
UNION ALL
(SELECT -- LOWEST_SOLD
    P.PRODUCT_ID,
    P.NAME,
    SUM(PO.AMOUNT) AS TOTAL_SALES,
    'LOWEST_SOLD' AS SELL_TYPE
FROM PRODUCTS P
JOIN PRODUCTS_ORDERS PO ON PO.PRODUCT_ID = P.PRODUCT_ID
GROUP BY P.PRODUCT_ID, P.NAME
ORDER BY TOTAL_SALES ASC
LIMIT 1)
UNION ALL
(SELECT -- THE AVERAGE
      NULL AS PRODUCT_ID,
      NULL AS NAME,
      AVG(PO.AMOUNT) AS TOTAL_SALES,
      'AVERAGE_SELLING' AS SELL_TYPE
    FROM PRODUCTS_ORDERS PO);

--D.8 Which product category is sold the most? Which is sold the least?
  (SELECT -- sold the most
    c.name AS category_name,
    SUM(po.amount) AS total_sold,
    'most_selling' AS sale_type
  FROM category c
  JOIN products p ON c.category_id = p.category_id
  JOIN products_orders po ON p.product_id = po.product_id
  GROUP BY c.name
  ORDER BY total_sold DESC
  LIMIT 1)
  UNION all
    (SELECT -- sold the most
    c.name AS category_name,
    SUM(po.amount) AS total_sold,
    'least_selling' AS sale_type
  FROM category c
  JOIN products p ON c.category_id = p.category_id
  JOIN products_orders po ON p.product_id = po.product_id
  GROUP BY c.name
  ORDER BY total_sold ASC
  LIMIT 1);

  -- D.9 Which product appears in the most different orders?
  SELECT
    p.product_id,
    p.name AS product_name,
    COUNT(DISTINCT po.order_id) AS order_count
FROM products p
JOIN products_orders po ON po.product_id = p.product_id
GROUP BY p.product_id, p.name
ORDER BY order_count DESC
LIMIT 1;


