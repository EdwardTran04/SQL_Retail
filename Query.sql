--1. Xuất ra danh sách nhân viên và mức lương thực nhận của nhân viên đó (Công thức Lương thực = salary +(salary * role_allowance) +role_bonus)
SELECT employee.*,
		salary +(salary * role_allowance) +role_bonus as Luong_thuc
FROM employee, employee_role

--abc
-- 2. Xuất ra phòng ban có mức lương thực nhận cao nhất
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

-- 3. Xuất ra phòng ban có mức lương thực nhận thấp nhất
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


-- 4. Xuất ra chi nhánh(branch) chốt được nhiều nhất số lượng đơn hàng mà đơn hàng đó không dùng voucher
SELECT branch.*,  count (orders.order_id) Donkhongvoucher
FROM  orders, branch
WHERE orders.branch_id = branch.branch_id
GROUP BY branch.branch_id,  branch.location_id, branch.branch_code, branch.branch_name, branch.address
HAVING count (orders.voucher_id) = 0


-- 5. Xuất ra product_catagory nào có số product bị áp số lượng voucher nhiều nhất
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


-- 6. Tìm tất cả các phòng ban (department) có chứa nhân viên có mức lương lớn hơn hoặc bằng mức lương trung bình của phòng kế toán
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


-- 7. Tìm tất cả product có tồn tại khách hàng đánh giá mà không mua sản phẩm
select product.*
from product_rating  join product on product.product_id = product_rating.product_id
           left join order_detail on product.product_id = order_detail.product_id
where order_detail.product_id is null


-- 8. Xuất ra chi nhánh(branch) chốt được nhiều nhất số lượng đơn hàng trong 2023
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


-- 9. Chi nhánh nào chốt được nhiều loại mặt hàng nhất
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


-- 10. Chi nhánh nào chốt được đơn hàng có giá trị cao nhất
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
	

-- 11. Xuất ra tất cả số tháng trong năm 2022, 2023 và số đơn hàng chốt được theo từng tháng, sắp xếp theo thứ tự giảm dần của số đơn hàng
SELECT format(order_date, 'yyyy-MM') as date, COUNT (order_id) as So_Don
FROM orders
GROUP BY format(order_date, 'yyyy-MM') 
ORDER BY COUNT(order_id) DESC


-- 12. Tìm ra đơn hàng có tổng giá trị cao nhất (Không áp dụng mã khuyến mãi)
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


-- 13. Tìm ra đơn hàng có tổng giá trị cao nhất (Áp dụng mã khuyến mãi)
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


-- 14. Tìm ra mặt hàng nào chưa có khách hàng mua
SELECT product.*
FROM order_detail right join product on product.product_id = order_detail.product_id
WHERE order_detail.order_detail_id  is NULL


--15. Tìm ra mặt hàng nào có nhiều khách hàng mua nhất
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


-- 16. Tìm ra loại mặt hàng nào bán được nhiều tiền nhất
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

-- 17. Xuất ra thông tin của các loại mặt hàng và trung bình rating của từng loại						
SELECT product.*, AVG(product_rating.rating) as AVG_rating
FROM product, product_rating
WHERE product.product_id = product_rating.product_id
GROUP BY product.product_id, product.product_category_id, product.product_name, product.price


-- 18. Xuất ra các order mà có các sản phẩm thuộc product_catagory là DO_UONG
SELECT orders.*, S.product_category_name
FROM(
	SELECT product.product_id, product_category.product_category_name
	FROM product join product_category on product.product_category_id = product_category.product_category_id
	WHERE product_category.product_category_code = 'DO_UONG') AS S
	JOIN order_detail on order_detail.product_id = S.product_id
	join orders on orders.order_id = order_detail.order_id


-- 19. Xuất ra các order mà có sản phẩm thuộc duy nhất 1 product catagory
SELECT orders.*
FROM product join order_detail on product.product_id = order_detail.product_id
	join orders on orders.order_id = order_detail.order_id
GROUP BY orders.order_id, orders.branch_id, orders.customer_id, orders.order_date, orders.voucher_id, orders.payment_method
HAVING count (distinct product.product_category_id) =1


-- 20. Xuất ra các order mà có sản phẩm thuộc toàn bộ product catagory (3 loại)
SELECT orders.*
FROM product join order_detail on product.product_id = order_detail.product_id
	join orders on orders.order_id = order_detail.order_id
GROUP BY orders.order_id, orders.branch_id, orders.customer_id, orders.order_date, orders.voucher_id, orders.payment_method
HAVING count (distinct product.product_category_id) =3


-- 21.