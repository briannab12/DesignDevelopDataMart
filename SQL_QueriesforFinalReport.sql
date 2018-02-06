--Final Project, Team 3 --

#Question: The percentage of invoice that are COD.
CREATE INDEX payment_method_idx ON sale_details(payment_method(2));
SELECT sale_details_sk, 
	(SELECT COUNT(payment_method) 
		FROM sale_details 
		WHERE payment_method='cod')*100/(COUNT(payment_method)) AS COD_percentage 
		FROM sale_details;

#Question: The sales by supplier state to customer state. This would be useful to see if suppliers should ship directly to customers
CREATE INDEX state_idx ON customer(state(2));
SELECT sales_fact.amount AS Sales, 
	customer.state AS 'Customer State', 
	supplier.state AS 'Supplier State' 
FROM customer 
	JOIN sales_fact ON customer.customersk=sales_fact.customersk_fk 
	JOIN supplier ON supplier.suppliersk=sales_fact.suppliersk_fk 
GROUP BY 2,3;

#Question: Show the total cost of products for each supplier.
CREATE INDEX cost_idx ON supplier(name(4));
SELECT supplier.name AS 'Supplier Name', 
	product.name AS 'Product Name', 
	SUM(price1) AS 'Total cost of products' 
FROM supplier 
	JOIN sales_fact ON supplier.supplierSK = sales_fact.supplierSK_FK 
	JOIN product ON product.productSK = sales_fact.supplierSK_FK 
WHERE supplier.name IS NOT null 
GROUP BY 1;
