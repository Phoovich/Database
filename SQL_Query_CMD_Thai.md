## DDL (Data Definition Language commands)

#### CREATE database ใช้ในการสร้างฐานข้อมูล

```sql
CREATE DATABASE bongo;
```

---

#### DROP database ใช้ในการลบฐานข้อมูล

```sql
DROP DATABASE bongo;
```

---

#### CREATE table ใช้ในการสร้างตารางใหม่

- **SERIAL**: Auto-Increment constraint.
- **DEFAULT**:
  ```sql
  price DECIMAL DEFAULT 9.99 -- ราคาเริ่มต้นคือ 9.99
  ```
- **CHECK**: Ensures a column must meet a specific condition.

- **UNIQUE**: Ensures column values are unique.

- **PRIMARY KEY**: Defines a unique identifier for a table.

- **FOREIGN KEY**: Ensures data in one table matches values in another table.

- **NOT NULL**: Column cannot store null values.

- **Empty String**: `'' != NULL`

---

#### Example

- create table boat

```sql
CREATE TABLE boat(
bid VARCHAR(3) NOT NULL,
bname VARCHAR(45) DEFAULT NULL,
color VARCHAR(45) DEFAULT NULL,
PRIMARY KEY (bid)
);
```

- create table sailor

```sql
CEATE TABLE sailor (
sid VARCHAR(2) NOT NULL,
sname VARCHAR(45) DEFAULT NULL,
rating INTEGER DEFAULT NULL,
age NUMERIC(10,2) DEFAULT NULL,
PRIMARY KEY (sid)
);
```

- create table reserve

```sql
CREATE TABLE reserve (
sid VARCHAR(2) NOT NULL,
bid VARCHAR(3) NOT NULL,
day DATE DEFAULT NULL,
FOREIGN KEY (sid) REFERENCES sailor(sid),
FOREIGN KEY (bid) REFERENCES boat(bid),
PRIMARY KEY (sid, bid)
);
```

---

#### Insert: add data in table

- Insert data in table sailor

```sql
INSERT INTO sailor VALUES
('22','Dustin',7,45),
('29','Brutus',1,33),
('31','Lubber',8,55.5),
('32','Andy',8,25.5),
('58','Rusty',10,35),
('64','Horatio',7,35),
('71','Zorba',10,16),
('74','Horatio',9,35),
('85','Art',3,25.5),
('95','Bob',3,63.5);
```

- Insert data in table boat

```sql
INSERT INTO boat VALUES
('101','Interlake','Blue'),
('102','Interlake','Red'),
('103','Clipper','Green'),
('104','Marine','Red');
```

- Insert data in table reserve

```sql
INSERT INTO reserve VALUES
('22','101','2010-10-14'),
('22','102','2010-10-14'),
('22','103','2010-08-14'),
('22','104','2010-07-14'),
('31','102','2011-10-14'),
('31','103','2011-06-14'),
('31','104','2011-12-14'),
('64','101','2009-05-14'),
('64','102','2009-08-14'),
('74','103','2009-08-14');
```

---

#### ALTER Table

```sql
-- add column
ALTER TABLE FoodCart ADD COLUMN sold INT;

-- drop column
ALTER TABLE FoodCart DROP COLUMN profit;

-- change datatype or constraint
ALTER TABLE {table_name} ALTER COLUMN {column_name} TYPE {new_data_type};

-- rename a column
ALTER TABLE {table_name} RENAME COLUMN {old_name} TO {new_name};

-- rename a table
ALTER TABLE {old_table_name} RENAME TO {new_table_name};
```

---

#### DROP TABLE: ลบตาราง

```sql
DROP TABLE {table_name};
-- Ex.
DROP TABLE FoodCart;
```

---

## DML (Data Manipulation Language Commands)

> **SELECT, FROM, WHERE**

##### 1. SQL query: แสดงรายชื่อและอายุของกะลาสีทั้งหมดที่อยู่ในตาราง sailor

```sql
select sname, age
from sailor;
```

---

##### 2. SQL query: แสดงรายชื่อและอายุ "ไม่ซ้ำกัน" ของกะลาสีทั้งหมดที่อยู่ในตาราง sailor

```sql
-- use distinct
select distinct sname, age
from sailor;
```

---

##### 3. SQL query: แสดงรายชื่อกะลาสีทังหมดทีเคย จองเรือหมายเลข 103

```sql
select s.sname
from sailor s, reserve r
where s.sid = r.sid and r.bid = '103';
```

---

##### 4. แสดงรหัสของกะลาสีทังหมดที่เคยจองเรือสีแดง (มี row ซ้ำ)

```sql
select r.sid
from boat b,reserve r
where b.color = 'Red' and r.bid = b.bid;
```

###### 4.1 ไม่มี row ซ้ำ

```sql
  select distinct r.sid
  from reserve r, boat b
  where b.color = 'Red' and r.bid = b.bid;
```

---

#### 5. แสดงสีของเรือทังหมดทีเคยถูก จองโดยกะลาสี Lubber

```sql
select distinct b.color
from reserve r, boat b,sailor s
where s.sname = 'Lubber' and s.sid = r.sid and b.bid = r.bid;
```

---

#### 6.แสดงชื่อของกะลาสีทั้งหมดที่เคย มีการจองเรืออย่างน้อย 1 ลํา

```sql
select s.sname,s.sid,r.bid
from reserve r, sailor s
where r.sid = s.sid;
```

---

#### SQL query: "เปลียนชือคอลัมน์ในการแสดงผลผ่าน AS" และ "สืบค้นสตริงผ่าน LIKE"

##### Ex.1

```sql
select s.sname, s.age, s.age -1 as age1, 2\*s.age as age2
from sailor s
where s.sname like 'B__' or s.sname like 'B___';
```

---

##### Ex.2

```sql
-- %a คือ ลงท้ายด้วย a
-- %b คือ ลงท้ายด้ย b
select s.sname, s.age, s.age -1 as age1, 2\*s.age as age2
from sailor s
where s.sname like '%a';
```

---

##### 7.จงแสดงชื่อกะลาสีทังหมดที่ ลงท้ายด้วย y

```sql
select s.sname
from sailor s
where s.sname like '%y';
```

---

##### 8. จงแสดงชื่อเรือทั้งหมดทีมีคําว่า er ในชื่อ

```sql
-- %xxx% มี xxx ในชื่อ
select b.bname
from boat b
where b.bname like '%er%';
```

---

#### SQL query: จํากัดจํานวนรายการทีต้องการ

##### use `limit` ตามด้วย `number`

##### Ex.1 Limit

```sql
select s.sname, s.age
from sailor s
limit 5; -- or
-- fetch first 5 row only;
```

---

##### Ex.2 Offset (เลือนไป) ofset --> เลื่อนไป 5 อันดับ

```sql
select s.sname, s.age
from sailor s
offset 5;
```

---

##### Ex.3 Offset + limit

```sql
select s.sname , s.age
from sailor s
offset 5
limit 3;

--or

select s.sname, s.age
from sailor s
offset 5 fetch first 3 row only;
```

---

#### SQL query: UNION, INTERSECT, EXCEPT

- เป็น **operator** ทําระหว่างตารางที **compatible** กัน
- ใน **MySQL** ไม่มี `INTERSECT` และ `EXCEPT` ให้ใช้ แต่ **PostgreSQL** มี

##### Ex.1 แสดงชือของกะลาสีทังหมดทีเคยจอง เรือสีเขียวหรือแดงก็ได้ (UNION)

```sql
select distinct s.sid,s.sname
from boat b, reserve r, sailor s
where s.sid = r.sid and b.bid = r.bid and (b.color = 'Red' or b.color = 'Green');
```

##### Use Union

```sql
select s.sid, s.sname
from boat b, reserve r, sailor s
where s.sid = r.sid and b.bid = r.bid and b.color = 'Red'
union
select s.sid, s.sname
from boat b, reserve r, sailor s
where s.sid = r.sid and b.bid = r.bid and b.color = 'Green';
```

---

##### Ex.2 แสดงชือของกะลาสีทังหมดทีเคยจอง เรือทังสีเขียวและสีแดง (INTERSECT??)

```sql
select s.sid, s.sname
from sailor s, boat b, reserve r
where s.sid = r.sid and b.bid = r.bid and (b.color = 'Red' and b.color = 'Green');
-- outPut not thing
```

##### Use Intersect

```sql
select s.sid, s.sname
from boat b, reserve r, sailor s
where s.sid = r.sid and b.bid = r.bid and b.color = 'Red'
intersect
select s.sid, s.sname
from boat b, reserve r, sailor s
where s.sid = r.sid and b.bid = r.bid and b.color = 'Green';
```

---

#### SQL query: "Nested Query" และ "IN"

##### Ex.1 "IN"

```sql
-- select distinct s.sid, s.sname
select s.sid, s.sname
from sailor s, boat b, reserve r
where s.sid = r.sid and b.bid = r.bid and b.color = 'Red'
and s.sid in -- use in
(select s.sid
from sailor s,boat b, reserve r
where s.sid = r.sid and b.bid = r.bid and b.color = 'Green');
```

#### 9. แสดงชือของกะลาสีทังหมดทีเคยจองเรือสีเขียวแต่ไม่เคยจองสีแดงเลย

- **idea** มันก็คือ อยู่ในเขียวแต่มันอยู่ในแดง
- มันคือ **keyword** `Nested Query` และ `Not in`

##### Use Not in

```sql
select s.sid, s.sname
from sailor s,boat b,reserve r
where s.sid = r.sid and b.bid = r.bid and b.color = 'Green'
and s.sid not in (
select s.sid -- ใช้แค่ sid อย่างเดี่ยว
from sailor s,boat b,reserve r
where s.sid = r.sid and b.bid = r.bid and b.color = 'Red');
```

##### Use Except

```sql
select s.sid, s.sname
from sailor s,boat b,reserve r
where s.sid = r.sid and b.bid = r.bid and b.color = 'Green'
except
select s.sid,s.sname
from sailor s,boat b, reserve r
where s.sid = r.sid and b.bid = r.bid and b.color = 'Red';
```

---

#### Aggregate operators

    COUNT(A)    : นับ จํานวนของค่าทังหมดในคอลัมน์ A
    SUM(A)      : หาผลรวม ของค่าทังหมดในคอลัมน์ A
    AVG(A)      : หาค่าเฉลีย ของค่าทังหมดในคอลัมน์ A
    MAX(A)      : หาค่าทีมากทีสุด จากค่าทังหมดในคอลัมน์ A
    MIN(A)      : หาค่าทีน้อยทีสุด จากค่าทังหมดในคอลัมน์ A

##### 10. นับจำนวนกะลาสีทั้งหมดในตาราง sailor

```sql
select count(*) -- * หมายถึงนับทั้งหมด
from sailor;
-- count นับซ้ำด้วย
```

- use `distinct`

```sql
select count (distinct s.sname)
from sailor s;
```

---

##### 11.หาค่าอายุรวมของกะลาสีทุกคน ในตาราง sailor ทีมีค่า rating เท่ากับ 10

```sql
select sum(s.age)
from sailor s
where s.rating = 10;
```

---

##### 12.หาค่าอายุเฉลียของกะลาสีทุกคน ในตาราง sailor ทีมีค่า rating เท่ากับ 10

```sql
select avg(s.age)
from sailor s
where s.rating = 10;

select round(avg(s.age),2) ---> ปัดเศษ
from sailor s
where s.rating = 10;
```

---

##### 13. แสดงชือและอายุของกะลาสีทีมีอายุมากทีสุด

###### แบบนี้ error

```sql
select s.sname, max(s.age)
from sailor s;
```

##### fix

```sql
select s.sname, s.age
from sailor s
where s.age = (select max(s2.age) from sailor s2);
```

---

##### 14. เปลี่ยนอายุของ brutus เป็น 63.5

##### use `update`

```sql
update sailor
set age = 63.5
where sid = '29';
```

```sql
select * from sailor;

select s.sname, s.age
from sailor s
where s.age = (select max(s2.age) from sailor s2);
-- find max มีมากกว่า 1 ได้
```

##### จงแสดงชือกะลาสีทีมีอายุน้อยสุด

```sql
select s.sname, s.age
from sailor s
where s.age = (select min(s2.age) from sailor s2);

-- or(not recommend)

select min(s.age)
from sailor s;
-- output 16

select s.sname
from sailor s
where s.age = 16;
```

---

#### BETWEEN and AND (inclusive)

- ทัง `BETWEEN` และ `AND` ใช้ในการระบุช่วงของค่า
- ช่วงของค่าอาจเป็น **ตัวเลข (number)**, **ตัวหนังสือ (text)**, **วันที (Date)** ก็ได้

##### 15. เปลียนอายุของ Brutus เป็น 33.0 เหมือนเดิม

```sql
update sailor
set age = 33.0
where sid = '29'
```

---

##### 16. หาชือกะลาสีทังหมดทีมีอายุระหว่าง 25 ถึง 35 ปี

```sql
select sid, sname
from sailor
where age between 25 and 35;
```

---

##### 17. Not BETWEEN

```sql
SELECT *
FROM sailor
WHERE sname NOT BETWEEN 'Hansen' and 'Pettersen';
```

---

##### 18. Start with A

```sql
SELECT \*
FROM sailor
where sname LIKE 'A%';
```
