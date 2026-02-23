CREATE TABLE customers (
    customer_id BIGINT PRIMARY KEY,
    customer_username VARCHAR(50) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    email VARCHAR(100) NOT NULL UNIQUE,
    address VARCHAR(200),
    phone_number VARCHAR(15),
    city VARCHAR(50)
);

ALTER TABLE customers
drop column join_date;

CREATE TABLE products (
    product_id BIGINT PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    description VARCHAR(300),
    price DECIMAL(10,2) NOT NULL,
    rating DECIMAL(2,1),
    model_year INT,
    created_at DATETIME2 DEFAULT SYSDATETIME(),
    product_address VARCHAR(200)
);


CREATE TABLE orders (
    order_id BIGINT PRIMARY KEY,
    product_id BIGINT NOT NULL,
    customer_id BIGINT NOT NULL,
    order_placed_time DATETIME2 DEFAULT SYSDATETIME(),
    expected_delivery_date DATE,

    CONSTRAINT FK_orders_product
        FOREIGN KEY (product_id) REFERENCES products(product_id),

    CONSTRAINT FK_orders_customer
        FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

INSERT INTO customers VALUES
(1000000001, 'arjun_k', 'Arjun', 'Kumar', 'arjun.kumar@gmail.com', 'MG Road', '9876543211', 'Bengaluru'),
(1000000002, 'priya_s', 'Priya', 'Sharma', 'priya.sharma@gmail.com', 'Sector 18', '9876543212', 'Noida'),
(1000000003, 'rahul_m', 'Rahul', 'Mehta', 'rahul.mehta@gmail.com', 'Andheri East', '9876543213', 'Mumbai'),
(1000000004, 'neha_r', 'Neha', 'Reddy', 'neha.reddy@gmail.com', 'Hitech City', '9876543214', 'Hyderabad'),
(1000000005, 'vikram_p', 'Vikram', 'Patel', 'vikram.patel@gmail.com', 'Navrangpura', '9876543215', 'Ahmedabad'),
(1000000006, 'ananya_i', 'Ananya', 'Iyer', 'ananya.iyer@gmail.com', 'T Nagar', '9876543216', 'Chennai'),
(1000000007, 'rohit_s', 'Rohit', 'Singh', 'rohit.singh@gmail.com', 'Rajouri Garden', '9876543217', 'Delhi'),
(1000000008, 'kavya_n', 'Kavya', 'Nair', 'kavya.nair@gmail.com', 'Kakkanad', '9876543218', 'Kochi'),
(1000000009, 'suresh_g', 'Suresh', 'Gupta', 'suresh.gupta@gmail.com', 'Alambagh', '9876543219', 'Lucknow'),
(1000000010, 'pooja_d', 'Pooja', 'Desai', 'pooja.desai@gmail.com', 'FC Road', '9876543220', 'Pune');

INSERT INTO customers VALUES
(1000000011, 'arya_k', 'Arjun', 'Kumar', 'arju.kumar@gmail.com', 'MG Road', '9876540211', 'Bengaluru', '2023-06-08'),
(1000000012, 'prithvi_s', 'Priya', 'Sharma', 'piya.sharma@gmail.com', 'Sector 18', '89076543212', 'Noida','2022-07-19'),
(1000000013, 'raghu_m', 'Rahul', 'Mehta', 'ragu.mehta@gmail.com', 'Andheri East', '9870543213', 'Mumbai','2020-03-18');

ALTER TABLE customers
add join_date date;


UPDATE customers SET join_date = '2019-03-15' WHERE customer_id = 1000000001;
UPDATE customers SET join_date = '2020-07-22' WHERE customer_id = 1000000002;
UPDATE customers SET join_date = '2021-01-10' WHERE customer_id = 1000000003;
UPDATE customers SET join_date = '2018-11-05' WHERE customer_id = 1000000004;
UPDATE customers SET join_date = '2022-06-18' WHERE customer_id = 1000000005;
UPDATE customers SET join_date = '2023-02-09' WHERE customer_id = 1000000006;
UPDATE customers SET join_date = '2020-09-27' WHERE customer_id = 1000000007;
UPDATE customers SET join_date = '2021-12-14' WHERE customer_id = 1000000008;
UPDATE customers SET join_date = '2019-05-08' WHERE customer_id = 1000000009;
UPDATE customers SET join_date = '2024-01-20' WHERE customer_id = 1000000010;

INSERT INTO products 
(product_id, product_name, description, price, rating, model_year, created_at, product_address)
VALUES
(2000000001, 'Laptop', 'Business laptop', 72000.00, 4.5, 2023, '2021-03-12 10:15:00', 'Delhi Warehouse'),
(2000000002, 'Smartphone', '5G Android phone', 42000.00, 4.4, 2024, '2022-07-25 11:30:00', 'Mumbai Warehouse'),
(2000000003, 'Smartwatch', 'Fitness smartwatch', 18000.00, 4.3, 2023, '2023-01-18 09:45:00', 'Bengaluru Warehouse'),
(2000000004, 'Headphones', 'Noise cancelling', 12000.00, 4.2, 2022, '2020-11-05 14:20:00', 'Chennai Warehouse'),
(2000000005, 'Tablet', 'Android tablet', 35000.00, 4.1, 2021, '2019-06-22 16:10:00', 'Hyderabad Warehouse'),
(2000000006, 'Keyboard', 'Mechanical keyboard', 6500.00, 4.0, 2023, '2024-02-10 10:00:00', 'Pune Warehouse'),
(2000000007, 'Mouse', 'Wireless mouse', 2500.00, 4.3, 2024, '2021-09-30 11:40:00', 'Noida Warehouse'),
(2000000008, 'Monitor', '27-inch monitor', 28000.00, 4.4, 2023, '2022-12-14 15:30:00', 'Kolkata Warehouse'),
(2000000009, 'Printer', 'Laser printer', 22000.00, 4.1, 2022, '2023-05-08 09:50:00', 'Indore Warehouse'),
(2000000010, 'Router', 'WiFi 6 router', 9000.00, 4.2, 2024, '2020-08-19 13:15:00', 'Jaipur Warehouse');




INSERT INTO orders
(order_id, product_id, customer_id, order_placed_time, expected_delivery_date)
VALUES
(3000000001, 2000000001, 1000000001, '2020-01-15 10:30:00', '2020-01-20'),
(3000000002, 2000000002, 1000000002, '2021-04-22 11:15:00', '2021-04-27'),
(3000000003, 2000000003, 1000000003, '2022-07-09 09:45:00', '2022-07-14'),
(3000000004, 2000000004, 1000000004, '2019-10-03 14:10:00', '2019-10-08'),
(3000000005, 2000000005, 1000000005, '2023-02-18 16:20:00', '2023-02-23'),
(3000000006, 2000000006, 1000000006, '2024-06-11 10:05:00', '2024-06-16'),
(3000000007, 2000000007, 1000000007, '2021-09-27 11:50:00', '2021-10-02'),
(3000000008, 2000000008, 1000000008, '2022-12-05 15:35:00', '2022-12-10'),
(3000000009, 2000000009, 1000000009, '2020-05-14 09:55:00', '2020-05-19'),
(3000000010, 2000000010, 1000000010, '2023-08-29 13:25:00', '2023-09-03');



select * from customers;
select * from products;
select * from orders;

delete customers where customer_id = 1000000010;

-------------INNER JOIN Tasks-------------------------------------------



-----------Customers with their orders
select * from customers c left join orders o on c.customer_id = o.customer_id;


--------Orders with customer name and city
select o.order_id,c.customer_id, c.first_name,c.last_name,c.city from customers c left join orders o on c.customer_id = o.customer_id;

----------Orders with products (3-table join)
select p.product_name, c.first_name,c.last_name, o.expected_delivery_date from orders o join customers c on c.customer_id = o.customer_id join products p on p.product_id = o.product_id;

-------Filter joined rows using WHERE amount > X
select p.product_name,p.price, c.first_name,c.last_name, o.expected_delivery_date from orders o join customers c on c.customer_id = o.customer_id join products p on p.product_id = o.product_id where p.price >= 10000 order by p.price desc;


-------------LEFT JOIN Tasks---------------------------------------------

-------All customers with orders including NULLs
select * from customers c left join orders o on c.customer_id = o.customer_id;

--------Customers without orders
select * from customers c left join orders o on c.customer_id = o.customer_id where o.order_id is null;

INSERT INTO products 
(product_id, product_name, description, price, rating, model_year, created_at, product_address)
VALUES 
(2000000011, 'Webcam', 'HD webcam for video calls', 4500.00, 4.0, 2023, '2021-04-11 10:25:00', 'Gurugram Warehouse'),
(2000000012, 'External Hard Drive', '1TB USB 3.0 storage', 5200.00, 4.3, 2022, '2019-10-17 14:40:00', 'Faridabad Warehouse'),
(2000000013, 'Bluetooth Speaker', 'Portable Bluetooth speaker', 3800.00, 4.4, 2024, '2023-07-06 16:05:00', 'Surat Warehouse');

-----------Products not ordered
select p.product_id, product_name, description, price, rating, model_year, created_at, product_address from products p left join orders o on p.product_id = o.product_id where order_id is null;


-------------LEFT JOIN with WHERE filter and with like filter
select p.product_id, product_name, description, price, rating, model_year, created_at, product_address 
from products p left join orders o on p.product_id = o.product_id 
where 
o.order_id is not null
and
rating > 4.0 and
product_name like 'Smart%'
;

------------RIGHT JOIN Tasks---------------------------------------

---------All orders with customer info
select * from customers c right join orders o on o.customer_id =  c.customer_id;


----------FULL OUTER JOIN Tasks-------------------------------------

---------Combine all customers and orders
select * from orders o full outer join customers c  on c.customer_id = o.customer_id;

---------Show matched and unmatched rows
select * from orders o full outer join customers c  on c.customer_id = o.customer_id;

--------------CROSS JOIN Tasks----------------------------------------
select * from customers c cross join products p;


----------------------JOIN + GROUP BY Tasks---------------------------------

-------------Order count per customer
select count(*) as no_of_ordersplaced, o.customer_id from customers c right join orders o on o.customer_id = c.customer_id group by o.customer_id;


---------Total order amount per customer
select sum(p.price) as total_amount_for_orders, o.customer_id from customers c right join orders o on o.customer_id = c.customer_id join products p on o.product_id = p.product_id  group by o.customer_id;

-------------------------JOIN + HAVING Tasks------------------------------------------


------------------Customers with more than 3 orders
select count(*) as no_of_ordersplaced, o.customer_id from customers c right join orders o on o.customer_id = c.customer_id group by o.customer_id having count(*) >=1 ;

------------------Customers with total order value > X
select sum(p.price) as Total_order_value_of_customer, c.customer_id from customers c join orders o on o.customer_id = c.customer_id join products p on p.product_id = o.product_id group by c.customer_id having sum(p.price) > 20000;


-------------------------JOIN + COUNT Tasks--------------------------------------------

-----------------Count orders per city
select count(*) as orders_for_city, c.city from orders o join customers c on c.customer_id = o.customer_id group by c.city;


--------------------------JOIN + WHERE Tasks-------------------------------------------

-------------Orders after certain date with customer data
select * from orders o join customers c on c.customer_id = o.customer_id where o.order_placed_time < '2022-02-02' ;


----------------Customers from specific city with orders
select * from orders o join customers c on c.customer_id = o.customer_id where c.city = 'delhi';

-------------Products above certain price in orders
select * from customers c join orders o on o.customer_id = c.customer_id join products p on p.product_id = o.product_id where p.price > 20000;


----------------Customers starting with ‘A’ with orders
select * from orders o join customers c on c.customer_id = o.customer_id where c.first_name like 'A%';


----------------Products LIKE filter with order data
select * from orders o left join products p on p.product_id = o.product_id where p.product_name like '%smart%';


-------------------JOIN + Subquery Tasks (IN / NOT IN / EXISTS / NOT EXISTS)--------------------------------

select * from customers where customer_id in (select customer_id from orders);


select * from customers where customer_id not in (select customer_id from orders);


select * from products where product_id not in (select product_id from orders);


select * from orders o join products p on p.product_id = o.product_id 
where p.price > (select avg(price) from products);


select * from customers where customer_id not in (select customer_id from orders);

select * from customers where customer_id in (select customer_id from orders);

select * from customers where exists (select customer_id from orders);

select * from customers where not exists (select customer_id from orders);

select * from products where price >= (select avg(price) from products);

select order_id,agg.* from orders o join 
(select product_id, product_name ,round(price/2,0) as discounted_price from products) agg on
agg.product_id = o.product_id;

update orders set expected_delivery_date = '2026-02-13' where order_id in (3000000001,3000000004,3000000006,3000000009);

select * from orders;

use ecom_db;

select Datediff(day,order_placed_time, getdate()) as no_of_days_passed,
case when expected_delivery_date <= GETDATE() then 'Delivered' else 'Yet to be Delivered' end as Delivery_status, 
order_id from orders;











