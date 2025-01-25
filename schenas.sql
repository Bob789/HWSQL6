-- HWSQLprep1_15_01_2025.db
-- Solution a

CREATE TABLE category (
    category_id SERIAL PRIMARY KEY, -- serial AI
    name VARCHAR(255) NOT NULL
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY, -- serial AI
    name VARCHAR(255) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    category_id INT NOT NULL,
    FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE CASCADE
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    date_time TIMESTAMP NOT NULL,
    address VARCHAR(255) NOT NULL,
    customer_name VARCHAR(100) NOT NULL,
    customer_ph VARCHAR(20) NOT NULL,
    total_price DECIMAL(10, 2) NOT NULL
);

CREATE TABLE nutritions (
    nutrition_id SERIAL PRIMARY KEY,
    product_id INT NOT NULL,
    name VARCHAR(100) NOT NULL,
    calories INT NOT NULL,
    fats DECIMAL(10, 2) NOT NULL,
    sugar DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);

CREATE TABLE products_orders (
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    amount INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders(order_id) ON DELETE CASCADE,
    FOREIGN KEY (product_id) REFERENCES products(product_id) ON DELETE CASCADE
);
