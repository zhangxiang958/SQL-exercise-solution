-- LINK: https://en.wikibooks.org/wiki/SQL_Exercises/The_computer_store
-- 1.1 Select the names of all the products in the store.
SELECT name FROM Products;
-- 1.2 Select the names and the prices of all the products in the store.
SELECT name, prices FROM Products;
-- 1.3 Select the name of the products with a price less than or equal to $200.
SELECT name FROM Products WHERE prices <= 200;
-- 1.4 Select all the products with a price between $60 and $120.
SELECT * FROM Products WHERE prices BETWEEN 60 AND 120;
-- 1.5 Select the name and price in cents (i.e., the price must be multiplied by 100).
SELECT name, price * 100 FROM Products;
-- 1.6 Compute the average price of all the products.
SELECT AVG(price) as avg_prices FROM Products;
-- 1.7 Compute the average price of all products with manufacturer code equal to 2.
SELECT AVG(price) as avg_prices FROM Products WHERE Manufacturer = 2;
-- 1.8 Compute the number of products with a price larger than or equal to $180.
SELECT COUNT(*) as pruducts_count FROM Products WHERE price >= 180;
-- 1.9 Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).
SELECT name, price FROM Products WHERE price >= 180 ORDER BY price, name;
-- 1.10 Select all the data from the products, including all the data for each product's manufacturer.
SELECT * FROM Products p LEFT JOIN Manufacturer m ON p.manufacturer = m.code;
-- 1.11 Select the product name, price, and manufacturer name of all the products.
SELECT p.name as name, p.price as price, m.name as manufactturer FROM Products p left join Manufacturer m ON p.manufactturer = m.code;
-- 1.12 Select the average price of each manufacturer's products, showing only the manufacturer's code.
SELECT AVG(price), manufactturer FROM Products GROUP BY manufactturer;
-- 1.13 Select the average price of each manufacturer's products, showing the manufacturer's name.
SELECT AVG(price), m.name FROM Products p LEFT JOIN manufactturer m ON p.manufacttrurer = m.code GROUP BY m.name;
-- 1.14 Select the names of manufacturer whose products have an average price larger than or equal to $150.
SELECT m.name FROM Products p LEFT JOIN manufacttrurer m ON p.manufactturer = manufactturer.code GROUP BY m.name HAVING AVG(p.price) >= 150;
-- 1.15 Select the name and price of the cheapest product.
SELECT name, price FROM Products WHERE price = (SELECT MIN(price) FROM Products);
-- 1.16 Select the name of each manufacturer along with the name and price of its most expensive product.
SELECT name, price, m.name as mname FROM Products p LEFT JOIN manufacttrurrer m ON p.manufacttrurer = m.code 
WHERE price = ( SELECT MAX(price) FROM Products GROUP BY manufacttrurer);
-- 1.17 Add a new product: Loudspeakers, $70, manufacturer 2.
INSERT Louspeakers  
-- 1.18 Update the name of product 8 to "Laser Printer".
-- 1.19 Apply a 10% discount to all products.
-- 1.20 Apply a 10% discount to all products with a price larger than or equal to $120.
