INSERT INTO category (name) VALUES
('Beverages'),
('Snacks'),
('Dairy'),
('Fruits'),
('Vegetables');

INSERT INTO products (name, price, category_id) VALUES
('Orange Juice', 5.99, 1),
('Chocolate Bar', 2.50, 2),
('Milk', 3.20, 3),
('Apple', 1.50, 4),
('Carrot', 0.99, 5),
('Coca Cola', 1.50, 1),    -- Beverages
('Pepsi', 1.40, 1),        -- Beverages
('Water Bottle', 0.99, 1), -- Beverages
('Orange Soda', 1.70, 1),  -- Beverages
('Iced Tea', 2.00, 1),     -- Beverages
('Potato Chips', 1.80, 2),   -- Snacks
('Pretzels', 2.20, 2),       -- Snacks
('Popcorn', 1.99, 2),        -- Snacks
('Granola Bar', 1.50, 2),    -- Snacks
('Cookies', 3.00, 2),        -- Snacks
('Cheese', 4.50, 3),      -- Dairy
('Yogurt', 1.25, 3),      -- Dairy
('Butter', 3.75, 3),      -- Dairy
('Cream Cheese', 2.50, 3),-- Dairy
('Ice Cream', 5.00, 3),   -- Dairy
('Banana', 1.20, 4),      -- Fruits
('Grapes', 2.99, 4),      -- Fruits
('Mango', 1.75, 4),       -- Fruits
('Pineapple', 3.00, 4),   -- Fruits
('Strawberries', 2.80, 4);-- Fruits


INSERT INTO nutritions (product_id, name, calories, fats, sugar) VALUES
(1, 'Orange Juice', 120, 0.2, 20),
(2, 'Chocolate Bar', 220, 12, 18),
(3, 'Milk', 150, 8, 12),
(4, 'Apple', 95, 0.3, 19),
(5, 'Carrot', 41, 0.1, 5),
(6, 'Coca Cola', 140, 0, 39),      -- Coca Cola
(7, 'Pepsi', 150, 0, 41),          -- Pepsi
(8, 'Water Bottle', 0, 0, 0),      -- Water Bottle
(9, 'Orange Soda', 160, 0, 44),    -- Orange Soda
(10, 'Iced Tea', 90, 0, 23),       -- Iced Tea
(11, 'Potato Chips', 160, 10, 1),  -- Potato Chips
(12, 'Pretzels', 110, 1, 1),       -- Pretzels
(13, 'Popcorn', 120, 5, 0),        -- Popcorn
(14, 'Granola Bar', 150, 6, 7),    -- Granola Bar
(15, 'Cookies', 250, 12, 18),      -- Cookies
(16, 'Cheese', 113, 9, 1),         -- Cheese
(17, 'Yogurt', 80, 1.5, 11),       -- Yogurt
(18, 'Butter', 100, 11, 0),        -- Butter
(19, 'Cream Cheese', 99, 10, 1),   -- Cream Cheese
(20, 'Ice Cream', 270, 14, 28),    -- Ice Cream
(21, 'Banana', 105, 0.3, 14),      -- Banana
(22, 'Grapes', 62, 0.3, 15),       -- Grapes
(23, 'Mango', 99, 0.6, 23),        -- Mango
(24, 'Pineapple', 50, 0.1, 10),    -- Pineapple
(25, 'Strawberries', 53, 0.5, 8);  -- Strawberries

INSERT INTO orders (date_time, address, customer_name, customer_ph, total_price) VALUES
('2024-09-17 10:30', '123 Main St', 'John Doe', '555-1234', 30.08),
('2024-09-17 11:45', '456 Oak St', 'Jane Smith', '555-5678', 20.13),
('2024-09-17 12:15', '789 Pine St', 'Emily Davis', '555-8765', 22.22),
('2024-09-17 13:00', '321 Elm St', 'Michael Johnson', '555-4321', 15.15),
('2024-09-17 13:30', '654 Maple St', 'Sarah Wilson', '555-6789', 30.99);

INSERT INTO products_orders (order_id, product_id, amount) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 3, 1),
(3, 4, 3),
(4, 5, 5),
(5, 1, 1),
(5, 3, 2),
(5, 4, 2),
(1, 6, 3),     -- Coca Cola
(1, 11, 1),    -- Potato Chips
(2, 7, 2),     -- Pepsi
(2, 12, 2),    -- Pretzels
(3, 8, 1),     -- Water Bottle
(3, 13, 2),    -- Popcorn
(4, 9, 1),     -- Orange Soda
(4, 14, 2),    -- Granola Bar
(5, 10, 1),    -- Iced Tea
(5, 15, 1),    -- Cookies
(1, 16, 1),    -- Cheese
(2, 17, 3),    -- Yogurt
(3, 18, 2),    -- Butter
(4, 19, 1),    -- Cream Cheese
(5, 20, 1),    -- Ice Cream
(1, 21, 4),    -- Banana
(2, 22, 2),    -- Grapes
(3, 23, 3),    -- Mango
(4, 24, 1),    -- Pineapple
(5, 25, 2);    -- Strawberries
