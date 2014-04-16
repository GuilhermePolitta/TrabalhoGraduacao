CREATE TABLE orders (
    customer_id INT,
    amount DOUBLE
);

CREATE TABLE things (
    order_id INT,
    amount DOUBLE,
    FOREIGN KEY (order_id) REFERENCES orders(customer_id)
);