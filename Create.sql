
USE supermartket_mgnt;
-- Init table Customer
DROP TABLE IF EXISTS customer;
CREATE TABLE customer(
	customer_id bigint IDENTITY(1,1) PRIMARY KEY,
    first_name varchar(255),
    last_name varchar(255),
    email varchar(255),
    phone varchar(255),
    gender tinyint
);

SET IDENTITY_INSERT customer ON
INSERT INTO customer(customer_id,first_name,last_name,email,phone,gender)
VALUES
	(1, 'Nguyen Van', 'An', 'an@gmail.com', '4352336668', 0),
    (2, 'Nguyen Thi', 'Binh', 'binh@gmail.com', '123456789', 1),
    (3, 'Tran Van', 'Cuong', 'cuong@gmail.com', '125546-6565', 0),
    (4, 'Pham Quynh', 'Anh', 'pqa@gmail.com', '123423', 1),
    (5, 'Tran Thi', 'Hao', 'hao@gmail.com', '1234789', 1)
;
SET IDENTITY_INSERT customer OFF

-- Init table Voucher
DROP TABLE IF EXISTS voucher;
CREATE TABLE voucher (
	voucher_id bigint IDENTITY(1,1) PRIMARY KEY,
    voucher_code varchar(100),
    voucher_name varchar(255),
    discount decimal(19,2)
);

SET IDENTITY_INSERT voucher ON
INSERT INTO voucher(voucher_id,voucher_code,voucher_name,discount)
VALUES 
	(1, 'VC_01', 'Voucher giam gia 10%', 10),
    (2, 'VC_02', 'Voucher giam gia 20%', 20),
    (3, 'VC_03', 'Voucher giam gia 50%', 50)
;
SET IDENTITY_INSERT voucher OFF

-- Init table Area
DROP TABLE IF EXISTS area;
CREATE TABLE area (
	area_id bigint IDENTITY(1,1) PRIMARY KEY,
    area_code varchar(100),
    area_name varchar(255)
);

SET IDENTITY_INSERT area ON
INSERT INTO area(area_id,area_code,area_name)
VALUES 
	(1, 'MIEN_BAC', 'Mien bac'),
    (2, 'MIEN_TRUNG', 'Mien Trung'),
    (3, 'MIEN_NAM', 'Mien Nam'),
    (4, 'NUOC_NGOAI', 'Nuoc Ngoai')
;
SET IDENTITY_INSERT area OFF

-- Init table Location
DROP TABLE IF EXISTS location;
CREATE TABLE location (
	location_id bigint IDENTITY(1,1) PRIMARY KEY,
    area_id bigint,
    location_code varchar(100),
    location_name varchar(255),
    city varchar(255),
    country varchar(255)
);

SET IDENTITY_INSERT location ON
INSERT INTO location(location_id,area_id,location_code,location_name,city,country)
VALUES 
	(1, 1, 'HANOI_1', 'Ha Noi 1', 'Ha Noi', 'Viet Nam'),
    (2, 2, 'DANANG_1', 'Da Nang 1', 'Da Nang', 'Viet Nam'),
    (3, 3, 'TPHCM_1', 'TP Ho Chi Minh 1', 'TP HCM', 'Viet Nam'),
    (4, 3, 'TPHCM_2', 'TP Ho Chi Minh 2', 'TP HCM', 'Viet Nam'),
    (5, 4, 'TOKYO', 'Tokyo', 'Tokyo', 'Japan')
;
SET IDENTITY_INSERT location OFF

-- Init table Department
DROP TABLE IF EXISTS department;
CREATE TABLE department (
	department_id bigint IDENTITY(1,1) PRIMARY KEY,
    department_name varchar(255),
    description varchar(500)
);

SET IDENTITY_INSERT department ON
INSERT INTO department(department_id,department_name,description)
VALUES 
	(1, 'Phong quan ly', ''),
    (2, 'Phong ke toan', ''),
    (3, 'Phong ban hang', ''),
    (4, 'Phong ky thuat', '')
;
SET IDENTITY_INSERT department OFF

-- Init table Branch
DROP TABLE IF EXISTS branch;
CREATE TABLE branch (
	branch_id bigint IDENTITY(1,1) PRIMARY KEY,
    location_id bigint,
    branch_code varchar(100),
    branch_name varchar(255),
    address varchar(255)
);

SET IDENTITY_INSERT branch ON
INSERT INTO branch(branch_id,location_id,branch_code,branch_name,address)
VALUES 
	(1, 1, 'CN_1 ', 'Sieu Thi Long Bien', 'Long Bien, Ha Noi'),
    (2, 1, 'CN_2 ', 'Sieu Thi Cau Giay', 'Cau Giay, Ha Noi'),
    (3, 3, 'CN_3 ', 'Sieu Thi Tan Binh', 'Tan Binh, TPHCM'),
    (4, 3, 'CN_4 ', 'Sieu Thi Binh Tan', 'Binh Tan, TPHCM'),
    (5, 4, 'CN_5 ', 'Sieu Thi Binh Chanh', 'Binh Chanh, TPHCM'),
    (6, 5, 'CN_6 ', 'Sieu Thi Tokyo', 'Tokyo')
;
SET IDENTITY_INSERT branch OFF

-- Init table Employee Role
DROP TABLE IF EXISTS employee_role;
CREATE TABLE employee_role (
	role_id bigint IDENTITY(1,1) PRIMARY KEY,
    role_code varchar(100),
    role_name varchar(255),
    role_allowance decimal(5,2),
    role_bonus decimal(19,2)
);

SET IDENTITY_INSERT employee_role ON
INSERT INTO employee_role(role_id,role_code,role_name,role_allowance,role_bonus)
VALUES 
	(1, 'GIAM_DOC', 'Giam doc ', 0.5, 2000),
    (2, 'QL_1', 'Quan ly cap 1 ', 0.3, 1000),
    (3, 'QL_2', 'Quan ly cap 2 ', 0.15, 500),
    (4, 'NV', 'Nhan vien', 0, 0)
;
SET IDENTITY_INSERT employee_role OFF

-- Init table Employee
DROP TABLE IF EXISTS employee;
CREATE TABLE employee (
	employee_id bigint IDENTITY(1,1) PRIMARY KEY,
    role_id bigint,
    department_id bigint,
    join_date date,
    first_name varchar(255),
    last_name varchar(255),
    birth_date date,
    gender tinyint,
    salary decimal(19,2),
    employer_id bigint
);

SET IDENTITY_INSERT employee ON
INSERT INTO employee(employee_id,role_id,department_id,join_date,first_name,last_name,birth_date,gender,salary,employer_id)
VALUES 
	(1, 1, 1, '2012-01-01', 'Nguyen Tran Van', 'Anh', '1980-12-12', 0, 3000, null),
    (2, 2, 1, '2015-03-31', 'Nguyen Anh', 'Khoa', '1986-01-12', 0, 1850, 1),
    (3, 4, 1, '2022-06-25', 'Tran Thi', 'Thao', '1998-03-12', 1, 700, 2),
    (4, 2, 2, '2013-02-28', 'Pham Quynh', 'Nha', '1992-11-10', 1, 2000, null),
    (5, 4, 2, '2019-07-20', 'Tran Viet', 'Thang', '1994-10-06', 0, 1000, 4),
    (6, 3, 3, '2018-06-10', 'Pham Viet', 'Dung', '1995-03-23', 0, 1500, 1),
    (7, 4, 3, '2019-06-10', 'Dao Khoa', 'Tuan', '1990-03-01', 0, 1500, 6),
    (8, 4, 3, '2023-06-10', 'Tran', 'Anh', '1995-08-25', 0, 300, 6),
    (9, 4, 3, '2020-12-10', 'Vo Van Phuong', 'Yen', '1983-03-23', 1, 400, 6),
    (10, 4, 3, '2021-04-28', 'Tran Tuong', 'Vy', '1987-05-30', 0, 450, 6),
    (11, 4, 3, '2021-03-10', 'Nguyen Ngoc', 'Binh', '2005-04-04', 0, 250, 6),
    (12, 4, 4, '2020-01-10', 'Tran Thanh', 'Cuong', '1995-03-23', 0, 900, 1)
;
SET IDENTITY_INSERT employee OFF

-- Init table employee_branch
DROP TABLE IF EXISTS employee_branch;
CREATE TABLE employee_branch (
	employee_branch_id bigint IDENTITY(1,1) PRIMARY KEY,
    employee_id bigint,
	branch_id bigint,
    is_manager bit
);

SET IDENTITY_INSERT employee_branch ON
INSERT INTO employee_branch(employee_branch_id,employee_id,branch_id,is_manager)
VALUES 
	(1, 6, 1, 1),
    (2, 6, 2, 0),
    (3, 6, 3, 0),
    (4, 6, 4, 0),
    (5, 7, 2, 1),
    (6, 7, 5, 1),
    (7, 7, 6, 0),
    (8, 8, 4, 1),
    (9, 8, 5, 0),
    (10, 8, 2, 0),
    (11, 9, 1, 0),
    (12, 9, 3, 1),
    (13, 9, 4, 0),
    (14, 10, 6, 1),
    (15, 11, 4, 0),
    (16, 11, 6, 0)
;
SET IDENTITY_INSERT employee_branch OFF

-- Init table Product Category
DROP TABLE IF EXISTS product_category;
CREATE TABLE product_category (
	product_category_id bigint IDENTITY(1,1) PRIMARY KEY,
    product_category_code varchar(100),
    product_category_name varchar(255)
);

SET IDENTITY_INSERT product_category ON
INSERT INTO product_category(product_category_id,product_category_code,product_category_name)
VALUES 
	(1, 'THUC_PHAM_TUOI', 'Thuc pham tuoi song'),
    (2, 'DO_UONG', 'Do Uong'),
    (3, 'AN_LIEN', 'Thuc Pham An Lien')
;
SET IDENTITY_INSERT product_category OFF

-- Init table Product
DROP TABLE IF EXISTS product;
CREATE TABLE product (
	product_id bigint IDENTITY(1,1) PRIMARY KEY,
    product_category_id bigint,
    product_name varchar(255),
    price decimal(19,2)
);

SET IDENTITY_INSERT product ON
INSERT INTO product(product_id,product_category_id, product_name, price)
VALUES 
	(1, 1,'Sashimi ca hoi', 15.45),
    (2, 1,'Sashimi ca ngu', 10.15),
    (3, 1,'Sushi tong hop', 7.5),
    (4, 1,'Ba chi bo my 500g', 9.95),
    (5, 1,'Muc tuoi 1kg', 12.75),
    (6, 1,'Tom su bien 1kg', 20.99),
    (7, 1,'Bach tuoc 1kg', 19.95),
    (8, 2,'Coca cola thung 24 lon', 6.85),
    (9, 2,'Coca cola thung 12 lon', 3.99),
    (10, 2,'Cafe sua Coffehouse 6 lon', 5.50),
    (11, 2,'Nuoc ep tao', 3.45),
    (12, 3,'Mi an lien Hao Hao thung 24 goi', 4.50),
    (13, 3,'Mien an lien phu huong 12 goi', 5.50),
    (14, 3,'Xuc xich an lien', 2.50)
;
SET IDENTITY_INSERT product OFF

-- Init table Order
DROP TABLE IF EXISTS orders;
CREATE TABLE orders (
	order_id bigint IDENTITY(1,1) PRIMARY KEY,
    branch_id bigint,
    customer_id bigint,
    voucher_id bigint,
    order_date date,
    payment_method varchar(20)
);

SET IDENTITY_INSERT orders ON
INSERT INTO orders(order_id, branch_id, customer_id, voucher_id, order_date, payment_method)
VALUES
	(1, 1, 1, null, '2022-01-30', 'CREDIT_CARD'),
    (2, 4, 1, null, '2022-02-16', 'CASH'),
    (3, 4, 2, 1, '2023-12-06', 'CASH'),
    (4, 6, 4, null, '2021-05-20', 'CREDIT_CARD'),
    (5, 3, 5, 2, '2019-03-15', 'CREDIT_CARD'),
    (6, 2, 1, 3, '2023-11-20', 'CASH'),
    (7, 1, 1, null, '2023-11-20', 'CREDIT_CARD'),
    (8, 3, 2, 3, '2023-12-03', 'CREDIT_CARD'),
    (9, 4, 3, null, '2023-05-20', 'CASH'),
    (10, 4, 5, null, '2023-04-19', 'CASH'),
    (11, 3, 5, 1, '2022-05-21', 'CREDIT_CARD'),
    (12, 6, 5, null, '2022-07-19', 'CASH'),
    (13, 1, 1, null, '2023-06-20', 'CREDIT_CARD'),
    (14, 2, 1, null, '2023-05-20', 'CREDIT_CARD'),
	(15, 6, 5, null, '2023-01-12', 'CREDIT_CARD')
;
SET IDENTITY_INSERT orders OFF

-- Init table Order Detail
DROP TABLE IF EXISTS order_detail;
CREATE TABLE order_detail (
	order_detail_id bigint IDENTITY(1,1) PRIMARY KEY,
    order_id bigint,
    product_id bigint,
    amount int
);

SET IDENTITY_INSERT order_detail ON
INSERT INTO order_detail(order_id, product_id, amount)
VALUES 
	(1,1,3),
    (1,5,1),
    (1,2,2),
    (2,5,4),
    (3,1,1),
    (3,4,1),
    (3,5,3),
    (3,8,4),
    (3,12,1),
    (3,13,1),
    (4,1,1),
    (4,3,1),
    (4,4,1),
    (4,6,5),
    (4,8,10),
    (4,13,1),
    (5,2,5),
    (5,6,2),
    (5,10,8),
    (6,2,1),
    (7,1,9),
    (7,11,9),
    (8,3,1),
    (8,12,1),
    (9,6,5),
    (10,3,1),
    (10,5,2),
    (10,7,12),
    (11,1,1),
    (11,2,1),
    (11,3,1),
    (11,4,1),
    (11,5,1),
    (11,6,1),
    (11,7,1),
    (11,8,1),
    (11,9,1),
    (11,10,1),
    (11,11,1),
    (11,12,1),
    (11,13,1),
    (11,14,1),
    (12,2,1),
    (12,3,1),
    (13,2,1),
    (14,12,4),
    (14,13,1),
    (14,14,7),
    (15,1,1),
    (15,11,3),
    (15,14,7)
;
SET IDENTITY_INSERT order_detail OFF

-- Init table Product Rating
DROP TABLE IF EXISTS product_rating;
CREATE TABLE product_rating (
	product_rating_id bigint IDENTITY(1,1) PRIMARY KEY,
	customer_id bigint,
    product_id bigint,
    rating bigint
);

SET IDENTITY_INSERT product_rating ON
INSERT INTO product_rating(customer_id, product_id, rating)
VALUES 
	(1, 1, 5),
    (1, 2, 4),
    (1, 4, 3),
    (1, 5, 3),
    (1, 8, 2),
    (1, 12, 2),
    (1, 13, 5),
    (1, 14, 1),

    (2, 1, 5),
    (2, 2, 4),
    (2, 3, 3),
    (2, 4, 3),
    (2, 5, 4),
    (2, 6, 5),
    (2, 7, 2),
    (2, 8, 1),
    (2, 9, 1),
    (2, 10, 3),
    (2, 11, 4),
    (2, 12, 5),
    (2, 13, 2),
	(2, 14, 4),
    
	(3, 4, 4),
    (3, 5, 5),
    (3, 7, 5),
    (3, 10, 5),
    (3, 11, 4),
    (3, 12, 5),
    (3, 13, 4),
    
    (4, 1, 4),
    (4, 2, 5),
    (4, 3, 3),
    (4, 4, 3),
    (4, 5, 1),
    
    (5, 3, 5),
    (5, 4, 5),
    (5, 6, 3),
    (5, 7, 3),
    (5, 8, 4),
    (5, 9, 2),
    (5, 12, 1),
    (5, 14, 5)
;
SET IDENTITY_INSERT product_rating OFF


