![Mô hình ERD](ERD-1.png)

## Tạo Cơ sở dữ liệu
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
        (5, 14, 5);
    SET IDENTITY_INSERT product_rating OFF


## Truy vấn
1 Xuất ra danh sách nhân viên và mức lương thực nhận của nhân viên đó (Công thức Lương thực = salary +(salary * role_allowance) +role_bonus)

    SELECT employee.*,
            salary +(salary * role_allowance) +role_bonus as Luong_thuc
    FROM employee, employee_role


2 Xuất ra phòng ban có mức lương thực nhận cao nhất

    SELECT S.department_id, S.department_name, S.Tong_luong_thuc
    FROM(
        SELECT employee.department_id, department.department_name,
                SUM (salary +(salary * role_allowance) +role_bonus) as Tong_luong_thuc
        FROM employee, department , employee_role
        WHERE  employee.department_id = department.department_id
        GROUP BY employee.department_id, department.department_name
        ) as S
    WHERE Tong_luong_thuc = 
                            (SELECT MAX(S.Tong_luong_thuc)
                            FROM(
                                    SELECT employee.department_id, department.department_name,
                                            SUM (salary +(salary * role_allowance) +role_bonus) as Tong_luong_thuc
                                    FROM employee, department , employee_role
                                    WHERE  employee.department_id = department.department_id
                                    GROUP BY employee.department_id, department.department_name
                                    )as S
                            )

3 Xuất ra phòng ban có mức lương thực nhận thấp nhất

    SELECT S.department_id, S.department_name, S.Tong_luong_thuc
    FROM(
        SELECT employee.department_id, department.department_name,
                SUM (salary +(salary * role_allowance) +role_bonus) as Tong_luong_thuc
        FROM employee, department , employee_role
        WHERE  employee.department_id = department.department_id
        GROUP BY employee.department_id, department.department_name
        ) as S
    WHERE Tong_luong_thuc = 
                            (SELECT MIN(S.Tong_luong_thuc)
                            FROM(
                                    SELECT employee.department_id, department.department_name,
                                            SUM (salary +(salary * role_allowance) +role_bonus) as Tong_luong_thuc
                                    FROM employee, department , employee_role
                                    WHERE  employee.department_id = department.department_id
                                    GROUP BY employee.department_id, department.department_name
                                    )as S
                            )


4 Xuất ra chi nhánh(branch) chốt được nhiều nhất số lượng đơn hàng mà đơn hàng đó không dùng voucher

    SELECT branch.*,  count (orders.order_id) Donkhongvoucher
    FROM  orders, branch
    WHERE orders.branch_id = branch.branch_id
    GROUP BY branch.branch_id,  branch.location_id, branch.branch_code, branch.branch_name, branch.address
    HAVING count (orders.voucher_id) = 0


5 Xuất ra product_catagory nào có số product bị áp số lượng voucher nhiều nhất

    SELECT  S.*
    FROM (
        SELECT  product_category.*, count(product.product_id) as So_Voucher_Ap_dung
        FROM orders, order_detail, product, product_category
        WHERE orders.order_id = order_detail.order_id 
            and order_detail.product_id = product.product_id 
            and product.product_category_id = product_category.product_category_id
            and orders.voucher_id >=1
        GROUP BY product_category.product_category_id, product_category.product_category_code, product_category.product_category_name
        ) AS S
    WHERE S.So_Voucher_Ap_dung = (
                                SELECT  MAX (S.So_Voucher_Ap_dung)
                                FROM (
                                    SELECT  product_category.*, count(product.product_id) as So_Voucher_Ap_dung
                                    FROM orders, order_detail, product, product_category
                                    WHERE orders.order_id = order_detail.order_id 
                                        and order_detail.product_id = product.product_id 
                                        and product.product_category_id = product_category.product_category_id
                                        and orders.voucher_id >=1
                                    GROUP BY product_category.product_category_id, product_category.product_category_code, product_category.product_category_name
                                    ) AS S)

6 Tìm tất cả các phòng ban (department) có chứa nhân viên có mức lương lớn hơn hoặc bằng mức lương trung bình của phòng kế toán

    SELECT DISTINCT S.department_id, S.department_name,S.description
    FROM (
        SELECT department.*
        FROM employee, department
        WHERE employee.department_id = department.department_id
            and employee.salary >= ( 
                                SELECT AVG(employee.salary) as LuongTB_ke_toan
                                FROM employee, department
                                WHERE employee.department_id = department.department_id
                                GROUP BY department.department_name
                                HAVING department.department_name = 'Phong ke toan' )) AS S   

7 Tìm tất cả product có tồn tại khách hàng đánh giá mà không mua sản phẩm
    
    select product.*
    from product_rating  join product on product.product_id = product_rating.product_id
            left join order_detail on product.product_id = order_detail.product_id
    where order_detail.product_id is null


8 Xuất ra chi nhánh(branch) chốt được nhiều nhất số lượng đơn hàng trong 2023

    SELECT S.*
    FROM (
        SELECT branch.*, count(orders.order_id) as Don2023
        FROM  orders, branch
        WHERE order_date between '1-1-2023' and '12-31-2023'
            and branch.branch_id = orders.branch_id
        GROUP BY branch.branch_id,  branch.location_id, branch.branch_code, branch.branch_name, branch.address
        ) AS S
    WHERE S.Don2023 = (
                    SELECT MAX (S.Don2023)
                    FROM (
                        SELECT branch.*, count(orders.order_id) as Don2023
                        FROM  orders, branch
                        WHERE order_date between '1-1-2023' and '12-31-2023'
                            and branch.branch_id = orders.branch_id
                        GROUP BY branch.branch_id,  branch.location_id, branch.branch_code, branch.branch_name, branch.address
                        ) AS S
                    )

9 Chi nhánh nào chốt được nhiều loại mặt hàng nhất

    SELECT S.*
    FROM (
        SELECT br.*, count(distinct product.product_category_id) AS max_category
        FROM branch as br join orders on br.branch_id = orders.branch_id
            join order_detail on orders.order_id = order_detail.order_id
            join product on product.product_id = order_detail.product_id
        GROUP BY br.branch_id, br.location_id, br.branch_code, branch_name, br.address
        ) AS S
    WHERE S.max_category= (
                        SELECT MAX(S.max_category)
                        FROM (
                            SELECT br.*, count(distinct product.product_category_id) AS max_category
                            FROM branch as br join orders on br.branch_id = orders.branch_id
                                join order_detail on orders.order_id = order_detail.order_id
                                join product on product.product_id = order_detail.product_id
                            GROUP BY br.branch_id, br.location_id, br.branch_code, branch_name, br.address
                            ) AS S)


10 Chi nhánh nào chốt được đơn hàng có giá trị cao nhất

    SELECT br.*, max(S.tong_bill) as tong_bill
    FROM (
        SELECT orders.order_id, orders.branch_id, SUM(S.Thanh_tien) as tong_bill
        FROM (
            SELECT order_detail.order_id, product.price * order_detail.amount as Thanh_tien
            FROM product join order_detail on product.product_id = order_detail.product_id
            ) AS S join orders on orders.order_id = s.order_id
        GROUP BY orders.order_id, orders.branch_id
        ) AS S join branch br on S.branch_id = br.branch_id
    WHERE S.tong_bill = (
                    SELECT max(S.tong_bill) as tong_bill
                    FROM (
                        SELECT orders.order_id, orders.branch_id, SUM(S.Thanh_tien) as tong_bill
                        FROM (
                            SELECT order_detail.order_id, product.price * order_detail.amount as Thanh_tien
                            FROM product join order_detail on product.product_id = order_detail.product_id
                            ) AS S join orders on orders.order_id = s.order_id
                        GROUP BY orders.order_id, orders.branch_id
                        ) AS S join branch br on S.branch_id = br.branch_id
                    )
    GROUP BY br.branch_id, br.location_id, br.branch_code, br.branch_name, br.address
        
11 Xuất ra tất cả số tháng trong năm 2022, 2023 và số đơn hàng chốt được theo từng tháng, sắp xếp theo thứ tự giảm dần của số đơn hàng

    SELECT format(order_date, 'yyyy-MM') as date, COUNT (order_id) as So_Don
    FROM orders
    GROUP BY format(order_date, 'yyyy-MM') 
    ORDER BY COUNT(order_id) DESC

12 Tìm ra đơn hàng có tổng giá trị cao nhất (Không áp dụng mã khuyến mãi)

    SELECT S.*
    FROM (
        SELECT ord.* , SUM(T.Thanh_tien) as tong_bill
        FROM (
            SELECT order_detail.order_id, product.price * order_detail.amount as Thanh_tien
            FROM product join order_detail on product.product_id = order_detail.product_id
            ) AS T join orders ord on ord.order_id = T.order_id
        WHERE ord.voucher_id is NULL
        GROUP BY ord.order_id, ord.branch_id, ord.customer_id, ord.voucher_id, ord.order_date, ord.payment_method 
        ) AS S 
    WHERE S.tong_bill = (
                        SELECT MAX(tong_bill)
                        FROM (
                            SELECT  SUM(T.Thanh_tien) as tong_bill
                            FROM (
                                SELECT order_detail.order_id, product.price * order_detail.amount as Thanh_tien
                                FROM product join order_detail on product.product_id = order_detail.product_id
                                ) AS T join orders ord on ord.order_id = T.order_id
                            WHERE ord.voucher_id is NULL
                            GROUP BY ord.order_id
                            ) AS S
                        )

13 Tìm ra đơn hàng có tổng giá trị cao nhất (Áp dụng mã khuyến mãi)

    SELECT S.*
    FROM (
        SELECT ord.order_id, ord.branch_id, ord.customer_id, ord.voucher_id, ord.order_date, ord.payment_method , SUM(T.Thanh_tien) as tong_bill
        FROM (
            SELECT order_detail.order_id, product.price * order_detail.amount as Thanh_tien
            FROM product join order_detail on product.product_id = order_detail.product_id
            ) AS T join orders ord on ord.order_id = T.order_id
        WHERE ord.voucher_id is not NULL
        GROUP BY ord.order_id, ord.branch_id, ord.customer_id, ord.voucher_id, ord.order_date, ord.payment_method 
        ) AS S 
    WHERE S.tong_bill = (
                        SELECT MAX(tong_bill)
                        FROM (
                            SELECT  SUM(T.Thanh_tien) as tong_bill
                            FROM (
                                SELECT order_detail.order_id, product.price * order_detail.amount as Thanh_tien
                                FROM product join order_detail on product.product_id = order_detail.product_id
                                ) AS T join orders ord on ord.order_id = T.order_id
                            WHERE ord.voucher_id is not NULL
                            GROUP BY ord.order_id
                            ) AS S
                        )

14 Tìm ra mặt hàng nào chưa có khách hàng mua

    SELECT product.*
    FROM order_detail right join product on product.product_id = order_detail.product_id
    WHERE order_detail.order_detail_id  is NULL

15 Tìm ra mặt hàng nào có nhiều khách hàng mua nhất

    SELECT product.*, S.Tong
    FROM (
        SELECT product_id, sum(amount) as Tong
        FROM order_detail 
        GROUP BY product_id
        ) AS S join product on S.product_id = product.product_id
    WHERE S.Tong = (
                    SELECT max(S.Tong)
                    FROM (
                        SELECT product_id, sum(amount) as Tong
                        FROM order_detail 
                        GROUP BY product_id
                        ) AS S join product on S.product_id = product.product_id
                    )


16 Tìm ra loại mặt hàng nào bán được nhiều tiền nhất

    SELECT *
    FROM (
        SELECT product.*, S.Tong,
                S.Tong * product.price as ThanhTien
        FROM (
            SELECT product_id, sum(amount) as Tong
            FROM order_detail 
            GROUP BY product_id
            ) as S join product on S.product_id = product.product_id
        ) AS S
    WHERE S.ThanhTien = (
                        SELECT MAX(S.ThanhTien)
                        FROM (
                            SELECT product.*, S.Tong,
                                    S.Tong * product.price as ThanhTien
                            FROM (
                                SELECT product_id, sum(amount) as Tong
                                FROM order_detail 
                                GROUP BY product_id
                                ) as S join product on S.product_id = product.product_id
                            ) AS S
                        )

17 Xuất ra thông tin của các loại mặt hàng và trung bình rating của từng loại		

    SELECT product.*, AVG(product_rating.rating) as AVG_rating
    FROM product, product_rating
    WHERE product.product_id = product_rating.product_id
    GROUP BY product.product_id, product.product_category_id, product.product_name, product.price


18 Xuất ra các order mà có các sản phẩm thuộc product_catagory là DO_UONG

    SELECT orders.*, S.product_category_name
    FROM(
        SELECT product.product_id, product_category.product_category_name
        FROM product join product_category on product.product_category_id = product_category.product_category_id
        WHERE product_category.product_category_code = 'DO_UONG') AS S
        JOIN order_detail on order_detail.product_id = S.product_id
        join orders on orders.order_id = order_detail.order_id


19 Xuất ra các order mà có sản phẩm thuộc duy nhất 1 product catagory

    SELECT orders.*
    FROM product join order_detail on product.product_id = order_detail.product_id
        join orders on orders.order_id = order_detail.order_id
    GROUP BY orders.order_id, orders.branch_id, orders.customer_id, orders.order_date, orders.voucher_id, orders.payment_method
    HAVING count (distinct product.product_category_id) =1


20 Xuất ra các order mà có sản phẩm thuộc toàn bộ product catagory (3 loại)

    SELECT orders.*
    FROM product join order_detail on product.product_id = order_detail.product_id
        join orders on orders.order_id = order_detail.order_id
    GROUP BY orders.order_id, orders.branch_id, orders.customer_id, orders.order_date, orders.voucher_id, orders.payment_method
    HAVING count (distinct product.product_category_id) =3

