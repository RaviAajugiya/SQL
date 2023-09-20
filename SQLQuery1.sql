--SELECT * from customers;
--SELECT DISTINCT city FROM customers;

--select count(distinct city) as Num from customers;

--select * from customers where country = 'Mexico';


--order by

--select * from customers 
--where customerid BETWEEN 10 and 20 
--order by country ASC, customername DESC;


----operator
--select * from customers
--where country = 'spain' AND CustomerName like 'G%'

----Select all Spanish customers that starts with either "G" or "R":
--select * from customers 
--where country = 'spain' and (CustomerName like 'G%' or CustomerName like 'R%')

----Select all customers that either:
----are from Spain and starts with either "G", or
----starts with the letter "R":
--select * from customers
--where country = 'spain' and CustomerName like 'G%' or 
--		CustomerName like 'R%'


--select * from customers
--where City not in('paris','london');

--select * from customers
--where CustomerID !> 10;


--select * from customers 
--where address is null

--SELECT CustomerName, ContactName, Address
--FROM Customers
--WHERE Address IS NOT NULL;

--insert into emp () values ();
--update emp set colname = val where condition
--delete from table where condition;


--select top 9 percent * from customers

--select count(Productid) from products 
--where price > 20;

--select count(distinct price) as [$$$] from products

--update products set productname = null
--where ProductName = 'chang' 

--select sum(productid) from products

--select * from products order by productname

--select * from orders 
--where orderdate between '1996-07-01' AND '1996-08-31' 
--order by OrderDate desc

--select CustomerName as [c name] from customers

select customername, address + '- ' + PostalCode as FA from customers;



