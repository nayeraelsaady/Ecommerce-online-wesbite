drop database if exists NUElectronics; 
create database NUElectronics; 
use NUElectronics; 


/*creating tables*/
/*Table 1 customer*/
create table Customers (
	ID int not null AUTO_INCREMENT, FirstName char(25) not null, LastName char(25) not null,
	EmailAddress Varchar(25) not null, Password Char(16) not null, Country char(56) not null,
	PhoneNumber char(12) not null, Gender char(6) not null, BirthDate date, Address Varchar(100) not null,
	Primary Key (ID)
    );
 
/*Table 2 Admins*/
create table Admins (
	ID int not null AUTO_INCREMENT, FirstName char(25) not null, LastName char(25) not null,
	EmailAddress Varchar(25) not null, Password Char(16) not null, PhoneNumber char(12) not null,
	Primary Key (ID)
    );

/*Table 3 Categories*/
create table Categories (
	ID int not null AUTO_INCREMENT, CategoryName char(50) not null,
	Primary Key (ID)
    );
    
/*Table 4 Sub-Categories*/
create table SubCategories (
	ID int not null AUTO_INCREMENT, SubCategoryName char(50) not null,
	Primary Key (ID)
    );
    
/*Table 5 Brands*/
create table Brands (
	ID int not null AUTO_INCREMENT, BrandName char(50) not null,
	Primary Key (ID)
    );
    
/*Table 6 Payment Methods*/
create table PaymentMethods (
	ID int not null AUTO_INCREMENT, PaymentMethod_Type char(15) not null,
	Primary Key (ID)
    );


/*Table 7 Products*/
create table Products (
	ID int not null AUTO_INCREMENT, ProductName char(50) not null,
	State boolean not null /*True = New, False = Refurbished*/,
	TechnicalSpecs MediumText not null, Price decimal(7,2) not null, 
	Availability boolean not null /*True = In Stock, False = Out of Stock*/,  
	Quantity int not null, Discount int not null default 0,
	DateAdded datetime not null DEFAULT current_timestamp,
	Primary key (ID)
	);

/*Table 8 Cart */
create table Cart (
	ID int not null AUTO_INCREMENT, Customer_ID int not null,
	TotalQuantity int not null, SubTotal decimal(10,2) not null,
	Primary Key (ID),
	CONSTRAINT cartCustomer_FK Foreign Key (Customer_ID) References Customers(ID)
	);

/*Table 9 Cart items*/
create table CartItems(
	ID int not null AUTO_INCREMENT, Customer_ID int not null, Product_ID int not null,
	Cart_ID int not null, Quantity int not null, Itemdate datetime not null DEFAULT current_timestamp,
	TotalPrice decimal(10,2) not null,
	Primary Key (ID),
	CONSTRAINT itemCustomer_FK Foreign Key (Customer_ID) References Customers(ID),
	CONSTRAINT itemProduct_FK Foreign Key (Product_ID) References Products(ID),
	CONSTRAINT itemCart_FK Foreign Key (Cart_ID) References Cart(ID)
    );
 
/*Table 10 Orders */
create table Invoices (
	ID int not null AUTO_INCREMENT, Customer_ID int not null, Cart_ID int not null,
	SubTotal decimal(10,2) not null, Taxes decimal(7,2) not null default 0,
	DeliveryFees decimal(7,2) not null default 0, Voucher char(10), Total decimal(10,2) not null,
	InvoiceDate datetime not null DEFAULT current_timestamp, Payment_ID int not null,
	Primary Key (ID),
	CONSTRAINT invoiceCustomer_FK Foreign Key (Customer_ID) References Customers (ID),
	CONSTRAINT invoiceCart_FK Foreign Key (Cart_ID) References Cart (ID),
	CONSTRAINT invoicePayMethod_FK Foreign Key (Payment_ID) References PaymentMethods (ID)
	);
    
/*Table 11 Installments  */
create table Installments (
	ID int not null AUTO_INCREMENT, Customer_ID int not null,
	Invoice_ID int not null, MonthlyValue decimal(7,2) not null,
	Primary Key (ID), 
	CONSTRAINT instalCustomer_FK Foreign Key (Customer_ID) References Customers (ID),
	CONSTRAINT instalOrder_FK Foreign Key (Invoice_ID) References Invoices (ID)
	);  
    
/*Table 12 Customer Orders Associative Entity */
create table CustomerOrders (
	Customer_ID int not null, Invoice_ID int not null,
	Invoice_total decimal(10,2) not null, OrderStatus char(50) not null,
	CONSTRAINT CustomerOrders_PK Primary Key (Customer_ID, Invoice_ID), 
	CONSTRAINT CustomerOrders1_FK Foreign Key (Customer_ID) References Customers (ID),
	CONSTRAINT CustomerOrders2_FK Foreign Key (Invoice_ID) References Invoices (ID)
	);  
    
/*Table 13 Product's Categories Associative Entity */
create table ProductCategory (
	Product_ID int not null, Categories_ID int not null, SubCategories_ID int not null,
	Brands_ID int not null,
	Primary Key (product_ID, Categories_ID),
	CONSTRAINT Product_FK Foreign Key (Product_ID) References Products (ID),
	CONSTRAINT Category_FK Foreign Key (Categories_ID) References Categories (ID),
	CONSTRAINT Subcategory_FK Foreign Key (SubCategories_ID) References SubCategories (ID),
	CONSTRAINT Brand_FK Foreign Key (Brands_ID) References Brands (ID)
	);
 
 /*The inserted categories are chosen based on researching the most used categorizes
 in Electronics OnlineStores.
 Sub-categorization was also done based on research. Both could be rearranged or regrouped based
 on preference*/
 
insert into Categories (CategoryName) values
('Camera & Photo Products'), 
('Car & Vehicle Electronics'),
('Computers, Components & Accessories'),
('eBook Readers & Accessories'),
('Headphones, Earbuds & Accessories'),
('Home Audio & Theatercategoriescategories Products'),
('Home Theater, TV & Video Products'),
('Household Batteries & Chargers') ,
('Mobile Phones & Communication Products') ,
('Portable Sound & Vision Products') ,
('Electrical Power Accessories'),
('GPS & Navigation Equipment') ,
('Computer Tablets') ,
('Telephones, VoIP & Accessories') ,
('Wearable Technology' );


insert into SubCategories (SubCategoryName) values
('Security Cameras'), ('Digital Cameras'), ('Mirrorless Cameras'), ('Point & Shoot Cameras'),
('Instant Cameras'), ('Tripods/Monopods'), ('Gimbals'), ('Binoculars, Telescopes and Optics'), ('Lenses'), ('Flashes, Lightning and Studio'), 
('Storage'), ('Accessories'),
('Laptops'), /*notebook, Ultrabook, Chromebook, MacBook, convertible, gaming*/
('Desktop/PC'), ('PlayStations'), ('Games'),
('Printers'), /*Inkjet printers, laser printer, solid ink printers, LED printers, continuous ink printers*/
('Storage'), ('Accessories'), ('Gaming Accessories'), ('Wired Headphones'), ('Wireless/Bluetooth Headphones'),
('Wired Earphones/Earbuds'), ('Wireless Earphones/Earbuds'), ('Accessories'),
('Sound Bars'), ('All-in-One Systems'), ('Home Theater/Audio Systems'), ('Wireless Speakers'),
('Subwoofers'), ('Receivers & Amplifiers'), ('Accessories'),
('Display (Screens/TVs)'), ('Projectors'), ('DVD and Blu-ray Players'), ('Streaming'),
('Remote Control Systems'), ('Accessories'), ('Alkaline Batteries'), ('Lithium Batteries'),
('Rechargeable Batteries'), ('Special Batteries'), ('Phone Chargers'), ('Portable Chargers'),
('Wall Chargers'), ('Wireless Chargers'), ('Power Adapters'), ('Android'), ('IOS'), ('Accessories'), 
('Portable Speakers'), ('Gaming/VR Sets'), ('Digital Media Players'), ('Radio'), ('Accessories'),
('Vehicle GPS'), ('Handheld GPS'), ('GPS tracker'), ('Item Finders'), ('Accessories'),
('Cordless Telephones'), ('Corded Telephones'), ('VoIP'), ('Telephone Accessories'), ('Smart Watches'),
('Smart Bands'),('Fitness Trackers');

/*test brands were used, but are not limited to only these*/

insert into Brands (BrandName) values 
('Apple'), ('HP'), ('Lenovo'), ('Dell'), ('Acer'), ('Asus'), ('Huawei'), ('Microsoft'), ('Razer'),
('Samsung'), ('MSI'), ('Alienware'), ('Intel'), ('LG'), ('Toshiba'),
('Samsung'), ('Realme'), ('Oppo'), ('Xaiomi'), ('Infinix'), ('Nokia'), ('Honor'), ('Google'), ('Sony'), 
('Kingston'), ('SanDisk'), ('Seagate'), ('Western Digital'), ('ADATA');

/*customers without pass view*/
create view CustomersView as
select (ID, concat(FirstName, " ",LastName), emailaddress, country, phonenumber, gender)
from Customers;