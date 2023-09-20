create table Author (
	Auther_ID varchar(50) primary key,
	Auther_Name varchar(50)
)

create table Books (
	Book_ID varchar(50) primary key,
	Book_Name varchar(50),
	Auther_ID varchar(50) foreign key references Author(Auther_ID),
	Price int,
	Publisher_ID varchar(50) foreign key references Publisher(Publisher_ID)
)

create table Customer (
	Customer_ID varchar(50) primary key,
	Customer_Name varchar(50),
	Street_Address varchar(50),
	City varchar(50),
	Phone_Number varchar(50),
	Credit_Card_Number varchar(50) foreign key references CREDIT_CARD_DETAILS(Credit_Card_Number),
)


create table CREDIT_CARD_DETAILS (
	Credit_Card_Number varchar(50) primary key,
	Credit_Card_Type varchar(50),
	Expiry_Date date
)

create table Order_Details (
	Order_ID int primary key,
	Customer_ID varchar(50) foreign key references Customer(Customer_ID),
	Shipping_Type varchar(50) foreign key references Shipping_Type(Shipping_Type),
	Date_of_Purchase date,
	Shopping_Cart_ID int foreign key references Shopping_Cart(Shopping_Cart_ID)
)

create table Publisher (
	Publisher_ID varchar(50) primary key,
	Publisher_Name varchar(50)
)

create table Purchase_History(
	Customer_ID varchar(50) foreign key references Customer(Customer_ID),
	Order_ID int foreign key references Order_Details(Order_ID)
)

create table Shipping_Type (
	Shipping_Type varchar(50) primary key,
	Shipping_Price varchar(50)
)

create table Shopping_Cart (
	Shopping_Cart_ID int primary key,
	Book_ID varchar(50) foreign key references Books(Book_ID),
	Price int,
	Date Date,
	Quantity int
)

select * from Order_Details

exec sp_help Shopping_Cart

insert into author values(1,'Name1')
insert into author values(2,'Name2')

insert into CREDIT_CARD_DETAILS values('123456789', 'type1', GETDATE())
insert into CREDIT_CARD_DETAILS values('123456780', 'type2', GETDATE())

insert into Publisher values(1,'Publisher1')
insert into Publisher values(2,'Publisher2')

insert into Shipping_Type values('type1', 200)
insert into Shipping_Type values('type2', 300)

insert into books values(1,'book1', 1, 500 ,1)
insert into books values(3,'book1', 2, 300 ,2)

insert into Customer values(1,'name1', 'Address1', 'city1', '1234567890', '123456789')
insert into Customer values(2,'name2', 'Address2', 'city2', '1234567891', '123456780')

insert into Order_Details values(1,1,'type1',GETDATE(),1)
insert into Order_Details values(2,2,'type2',GETDATE(),2)

insert into Shopping_Cart values(1,1,1000,GETDATE(),10)
insert into Shopping_Cart values(2,2,10000,GETDATE(),1)

insert into Purchase_History values(1,1)
insert into Purchase_History values(2,2)

select * from Author;
select * from Books;
select * from Customer;
select * from CREDIT_CARD_DETAILS;
select * from Order_Details;
select * from Publisher;
select * from Purchase_History;
select * from Shipping_Type;
select * from Shopping_Cart;


create view Customer_Details As 
	select Customer_Name, Street_Address + ' ' + city as Customer_Address , Order_ID,customer.Customer_ID, Shipping_Type, Date_of_Purchase, Shopping_Cart_ID
	from Customer
	inner join Order_Details on Customer.Customer_ID = Order_Details.Customer_ID

select * from Customer_Details

select Customer_Name, customer_ID, book_ID, Date_of_Purchase, Shopping_Cart.shopping_cart_ID 
from Customer_Details
inner join Shopping_Cart on Customer_Details.Shopping_Cart_ID = Shopping_Cart.Shopping_Cart_ID





