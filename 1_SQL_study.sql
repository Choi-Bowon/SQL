-- 1번
-- Q. 고객(Customers)의 이름과 국가를 조회
SELECT CustomerName, Country FROM Customers

-- 2번
-- Q. 고객(Customers)의 정보 전체 조회
SELECT * FROM Customers

-- 3번
-- Q. 고객(Customers)의 국가(Country) 목록 조회 (중복 X)
SELECT DISTINCT Country FROM Customers

-- 4번
-- Q. 국가(Country)가 France인 고객(Customers) 조회
SELECT * FROM Customers WHERE Country='France'

-- 5번
-- Q. 이름(ContactName) 이 ‘Mar’로 시작하는 직원 조회 
SELECT * FROM Customers WHERE ContactName LIKE 'Mar%'

-- 6번
-- Q. 이름(ContactName) 이 ‘et’로 끝나는 직원 조회
SELECT * FROM Customers WHERE ContactName LIKE '%et'

-- 7번
-- Q. 국가(Country)가 France이고 이름(ContactName)이 ‘La’로 시작하는 고객(Customers) 조회
select * from Customers where Country='France' and ContactName like 'La%'

-- 8번
-- Q. 국가(Country)가 France이거나 이름(ContactName) 이 ‘La’로 시작하는 고객(Customers) 조회
select * from Customers where Country='France' or ContactName like 'La%'

-- 9번
-- Q. 국가(Country)가 France가 아닌 고객(Customers) 조회
select * from Customers where not Country='France'
select * from Customers where Country != 'France'

-- 10번
-- Q. 국가(Country)가 France 혹은 Spain에 사는 고객(Customers) 조회
select * from Customers where Country in ('France', 'Spain')

-- 11번
-- Q. 가격(Price)이 15에서 20사이인 상품(Products) 조회
select * from Products where Price between 15 and 20

-- 12번
-- Q. 우편번호(PostalCode)가 NULL인 고객(Customers) 조회
select PostalCode from Customers where PostalCode is NULL

-- 우편번호가 공백인 고객을 NULL로 수정 후 다시 조회
update Customers
set PostalCode=NULL
where PostalCode='';

-- 13번
-- Q. 우편번호(PostalCode)가 NULL이 아닌 고객 (Customers) 조회
select PostalCode from Customers where PostalCode is not NULL

-- 14번
-- Q. 고객이름(CustomerName) 오름차순 조회
select * from Customers order by CustomerName asc

-- 15번
-- 상품가격(Price) 내림차순 조회
select * from Products order by Price desc

-- 16번
-- Q. 10명만 조회
select * from Customers limit 10

-- 17번
-- Q. 그 다음 10명 조회
select * from Customers limit 10 offset 10
-- -- limit 활용
select * from Customers limit 10, 10

-- 18번
-- Q. 상품가격(Price)이 30 미만이면 ‘저‘, 30~50이면 ‘중‘, 50 초과는 ‘고’로 조회
SELECT
    CASE
        WHEN Price<30 THEN '저'
        WHEN Price<=50 THEN '중'
        ELSE '고'
    END
FROM Products

-- 19번
--  Q. 위 조회한 CASE의 이름을 ‘Level’으로 바꿔주세요
SELECT Price,
    CASE
        WHEN Price<30 THEN '저'
        WHEN Price<=50 THEN '중'
        ELSE '고'
    END
FROM Products

-- 20번
-- Q. 국가(Country)가 France에 사는 고객(Customers)수 조회
select Country, count(*) from Customers where Country='France'

-- 21번 
-- Q. 전체 상품(Products)의 평균 가격(Price) 계산
select avg(Price) from Products

-- 22번
-- Q. 주문상품 수량(Quantity) 합계 계산
select sum(Quantity) from OrderDetails;

-- 23번
-- Q. 가격(Price) 최소값 조회
select min(Price) from Products;

-- 24번
-- Q. 가격(Price) 최대값 조회
select max(Price) from Products;

-- 25번
-- Q. 국가(Country)별 고객수 조회 (고객수 기준 오름차순)
select Country, count(*) as TotalCustomer
from Customers 
group by Country 
order by TotalCustomer asc;


-- 26번
-- Q. 국가(Country)별, 도시(City)별 고객수 조회 (고객수 기준 내림차순)
select Country, City, count(*) as TotalCustomer
from Customers 
group by Country, City 
order by TotalCustomer desc;

-- 27번
-- Q. 국가(Country)별 고객수를 조회하고 그 중 5명 초과인 국가만 조회 (고객수 기준 내림차순)
select Country, count(*) as TotalCustomer 
from Customers 
group by Country
having TotalCustomer>5 
order by TotalCustomer desc;

------------------- 실습 --------------------

-- 28번
-- Q. 직원(Employees)중 이름(LastName)이 ‘King’인 직원의 이름과 생일(BirthDate)과 노트(Notes)를 조회해주세요.
select LastName, BirthDate, Notes 
from Employees 
where LastName='King';

-- 29번
-- Q. 상품(Products)중 상품명(ProductName)이 ‘C’로 시작하고 가격(Price)이 20보다 큰 상품의 상품명과 가격을 가격이 비싼순으로 조회해주세요.
select ProductName, Price 
from Products 
where ProductName like 'C%' and Price>20 
order by price desc;

-- 30번
-- Q. 상품(Products)의 카테고리아이디(CategoryID) 별로 상품가격의 합, 가장 비싼 상품 가격, 가장 저렴한 상품 가격을 구하세요.
select CategoryID, sum(price), max(Price), min(Price) 
from Products 
group by CategoryID;

-- 31번
-- Q. 상품(Products)의 카테고리아이디(CategoryID) 별로 상품개수와 상품개수가 10개가 넘을경우 많음
-- 아니면 적음이 표시되어있는 칼럼을 하나 추가하고 상품수가 많은 순서대로 조회해주세요.
select CategoryID, count(ProductID) as Quantity,
    case 
        when count(ProductID) > 10 then '많음'
        else '적음'
    end as 'Quantity level'
from Products 
group by CategoryID 
order by Quantity desc;

-- 32번
-- Q. 고객(Customers)의 국가(Country)별 고객수와 백분위 (국가별고객수 / 전체고객수 * 100)을 구하세요
select Country, count(CustomerID) as CountryCustomer, 
        -- 전체 고객수를 구하는 서브쿼리
        (select count(CustomerID) from Customers) as TotalCustomer,
        -- 백분위를 구하는 곳 (국가별고객수 *100 / 전체고객수)
        (count(CustomerID)*100 / (select count(CustomerID) from Customers)) as Percentile

from Customers
group by Country;

--  33번 (join)
-- Q. 주문이력이 있는 고객명(CustomerName)과 주문일 (OrderDate)를 조회해주세요
select CustomerName, OrderDate
from Customers
inner join Orders
on Customers.CustomerID=Orders.CustomerID;

------- 실습2 --------

-- 34번 (1번)
-- Q. Tokyo에 위치한 공급자(Supplier)가 생산한 상품(Products) 목록 조회
select *
from Products
full outer join Suppliers
on Products.SupplierID=Suppliers.SupplierID
where City='Tokyo';

-- 35번 (2번)
-- Q. 분류(CategoryName)가 Seafood인 상품명(ProductName) 조회
select ProductName
from Products
inner join Categories
on Products.CategoryID=Categories.CategoryID
where CategoryName='Seafood'

-- 36번 (3번)
-- Q. 공급자(Supplier)가 공급한 상품의 공급자 국가(Country),상품 카테고리(ProductName)의 상품건수와 평균가격 조회
-- 문제 해결 순서
1. 테이블을 join 한다. - 멀티 테이블 조인
2. 공급자 국가별로 묶는다.
3. 집계 함수를 사용해 최종 결과를 얻는다.

select count(*), avg(Price)
from Products
full outer join Categories, Suppliers
on Products.CategoryID=Categories.CategoryID and Suppliers.SupplierID=Suppliers.SupplierID
group by Suppliers.Country, Categories.CategoryID;

-- 37번 (4번)
-- Q. 주문별 주문자명(CustomerName), 직원명(LastName), 배송자명(ShipperName), 주문상세갯수
select Orders.OrderID, CustomerName, LastName, ShipperName, Quantity
from Orders
full outer join Customers, Employees,  Shippers, OrderDetails
on Customers.CustomerID=Orders.CustomerID and
Employees.EmployeeID=Orders.EmployeeID and
Shippers.ShipperID=Orders.ShipperID and
OrderDetails.OrderID=Orders.OrderID
group by Orders.OrderID

-- 38번 (5번)
-- Q. 판매량(Quantity) 상위 TOP 3 공급자(supplier) 목록 조회
select *
from Suppliers
full outer join Products, OrderDetails
on OrderDetails.ProductID=Products.ProductID and
Products.SupplierID=Suppliers.SupplierID
where Quantity
group by Suppliers.SupplierID
order by Quantity desc
limit 3;

-- 39번 (6번)
-- Q. 상품분류(Category)별, 고객지역별(City) 판매량(Quantity) 많은 순 정렬
-- Table: Order, OrderDetails, Customers, Categories, Products
select *
from Orders
full outer join Customers, OrderDetails, Products, Categories
on Orders.CustomerID=Customers.CustomerID 
    and Orders.OrderID=OrderDetails.OrderID
    and OrderDetails.ProductID=Products.ProductID
    and Products.CategoryID=Categories.CategoryID
group by Categories.CategoryID and Customers.City
Order by Quantity desc;

-- 40번 (7번)
-- Q. 고객국가(Country)가 USA이고, 상품별 판매량(Quantity)의 합이 많은순으로 정렬
-- Table: Customers, Products, Orders, OrderDetails
select *
from Customers
right join Orders, OrderDetails, Products
on Customers.CustomerID=Orders.CustomerID 
	and Orders.OrderID=OrderDetails.OrderID
    and OrderDetails.ProductID=Products.ProductID
where Customers.Country='USA'
group by OrderDetails.ProductID
order by sum(OrderDetails.Quantity) desc;


