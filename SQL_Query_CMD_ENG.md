## DDL (Data Definition Language Commands)

### CREATE Database

Used to create a new database.

```sql
CREATE DATABASE bongo;
```

---

### DROP Database

Used to delete a database.

```sql
DROP DATABASE bongo;
```

---

### CREATE Table

Used to create a new table.

- **SERIAL**: Auto-increment constraint.
- **DEFAULT**:
  ```sql
  price DECIMAL DEFAULT 9.99 -- Default price is 9.99
  ```
- **CHECK**: Ensures a column meets a specific condition.
- **UNIQUE**: Ensures unique column values.
- **PRIMARY KEY**: Defines a unique identifier for a table.
- **FOREIGN KEY**: Ensures data in one table matches values in another.
- **NOT NULL**: Column cannot store NULL values.
- **Empty String**: `'' != NULL`

#### Example

**Create table `boat`**

```sql
CREATE TABLE boat(
  bid VARCHAR(3) NOT NULL,
  bname VARCHAR(45) DEFAULT NULL,
  color VARCHAR(45) DEFAULT NULL,
  PRIMARY KEY (bid)
);
```

**Create table `sailor`**

```sql
CREATE TABLE sailor (
  sid VARCHAR(2) NOT NULL,
  sname VARCHAR(45) DEFAULT NULL,
  rating INTEGER DEFAULT NULL,
  age NUMERIC(10,2) DEFAULT NULL,
  PRIMARY KEY (sid)
);
```

**Create table `reserve`**

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

### INSERT: Add Data into a Table

**Insert data into `sailor`**

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

**Insert data into `boat`**

```sql
INSERT INTO boat VALUES
('101','Interlake','Blue'),
('102','Interlake','Red'),
('103','Clipper','Green'),
('104','Marine','Red');
```

**Insert data into `reserve`**

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

### ALTER Table

**Modify table structure**

```sql
-- Add column
ALTER TABLE FoodCart ADD COLUMN sold INT;

-- Drop column
ALTER TABLE FoodCart DROP COLUMN profit;

-- Change datatype or constraint
ALTER TABLE {table_name} ALTER COLUMN {column_name} TYPE {new_data_type};

-- Rename a column
ALTER TABLE {table_name} RENAME COLUMN {old_name} TO {new_name};

-- Rename a table
ALTER TABLE {old_table_name} RENAME TO {new_table_name};
```

---

### DROP TABLE: Delete a Table

```sql
DROP TABLE {table_name};
-- Example:
DROP TABLE FoodCart;
```

---

## DML (Data Manipulation Language Commands)

### SELECT Queries

#### 1. Display all sailors' names and ages

```sql
SELECT sname, age FROM sailor;
```

#### 2. Display unique sailors' names and ages

```sql
SELECT DISTINCT sname, age FROM sailor;
```

#### 3. Display names of sailors who reserved boat `103`

```sql
SELECT s.sname
FROM sailor s, reserve r
WHERE s.sid = r.sid AND r.bid = '103';
```

#### 4. Display sailor IDs who reserved a red boat (duplicates included)

```sql
SELECT r.sid
FROM boat b, reserve r
WHERE b.color = 'Red' AND r.bid = b.bid;
```

#### 4.1 Remove duplicates

```sql
-- Use DISTINCT
SELECT DISTINCT r.sid
FROM reserve r, boat b
WHERE b.color = 'Red' AND r.bid = b.bid;
```

#### 5. Display boat colors reserved by `Lubber`

```sql
SELECT DISTINCT b.color
FROM reserve r, boat b, sailor s
WHERE s.sname = 'Lubber' AND s.sid = r.sid AND b.bid = r.bid;
```

---

### SQL Query Modifications

#### Change column name using `AS`

```sql
SELECT s.sname, s.age, s.age -1 AS age1, 2 * s.age AS age2
FROM sailor s
WHERE s.sname LIKE 'B__' OR s.sname LIKE 'B___';
```

#### Using `LIKE`

```sql
SELECT s.sname FROM sailor s WHERE s.sname LIKE '%y';
```

#### Find boats with 'er' in the name

```sql
SELECT b.bname FROM boat b WHERE b.bname LIKE '%er%';
```

---

### Limiting Results

#### Limit Results

```sql
SELECT s.sname, s.age FROM sailor s LIMIT 5;
```

#### Offset Results

```sql
SELECT s.sname, s.age FROM sailor s OFFSET 5;
```

#### Offset + Limit

```sql
SELECT s.sname, s.age FROM sailor s OFFSET 5 LIMIT 3;
```

---

### SQL Query: UNION, INTERSECT, EXCEPT

- These are **operators** that work between **compatible** tables.
- **MySQL** does not support `INTERSECT` and `EXCEPT`, but **PostgreSQL** does.

#### Example 1: Show all sailors who have reserved either a green or red boat (UNION)

```sql
SELECT DISTINCT s.sid, s.sname
FROM boat b, reserve r, sailor s
WHERE s.sid = r.sid AND b.bid = r.bid AND (b.color = 'Red' OR b.color = 'Green');
```

##### Using `UNION`

```sql
SELECT s.sid, s.sname
FROM boat b, reserve r, sailor s
WHERE s.sid = r.sid AND b.bid = r.bid AND b.color = 'Red'
UNION
SELECT s.sid, s.sname
FROM boat b, reserve r, sailor s
WHERE s.sid = r.sid AND b.bid = r.bid AND b.color = 'Green';
```

---

#### Example 2: Show all sailors who have reserved both a green and a red boat (INTERSECT)

```sql
SELECT s.sid, s.sname
FROM boat b, reserve r, sailor s
WHERE s.sid = r.sid AND b.bid = r.bid AND (b.color = 'Red' AND b.color = 'Green');
-- Output: No results
```

##### Using `INTERSECT`

```sql
SELECT s.sid, s.sname
FROM boat b, reserve r, sailor s
WHERE s.sid = r.sid AND b.bid = r.bid AND b.color = 'Red'
INTERSECT
SELECT s.sid, s.sname
FROM boat b, reserve r, sailor s
WHERE s.sid = r.sid AND b.bid = r.bid AND b.color = 'Green';
```

---

### SQL Query: Nested Query and `IN`

#### Example 1: Using `IN`

```sql
SELECT s.sid, s.sname
FROM sailor s, boat b, reserve r
WHERE s.sid = r.sid AND b.bid = r.bid AND b.color = 'Red'
AND s.sid IN (
  SELECT s.sid
  FROM sailor s, boat b, reserve r
  WHERE s.sid = r.sid AND b.bid = r.bid AND b.color = 'Green'
);
```

#### Example 2: Show all sailors who have reserved a green boat but never a red boat

- **Idea**: Find sailors in green reservations but exclude them from red reservations.
- Uses **nested queries** and `NOT IN`.

##### Using `NOT IN`

```sql
SELECT s.sid, s.sname
FROM sailor s, boat b, reserve r
WHERE s.sid = r.sid AND b.bid = r.bid AND b.color = 'Green'
AND s.sid NOT IN (
  SELECT s.sid
  FROM sailor s, boat b, reserve r
  WHERE s.sid = r.sid AND b.bid = r.bid AND b.color = 'Red'
);
```

##### Using `EXCEPT`

```sql
SELECT s.sid, s.sname
FROM sailor s, boat b, reserve r
WHERE s.sid = r.sid AND b.bid = r.bid AND b.color = 'Green'
EXCEPT
SELECT s.sid, s.sname
FROM sailor s, boat b, reserve r
WHERE s.sid = r.sid AND b.bid = r.bid AND b.color = 'Red';
```

---

### Aggregate Operators

- `COUNT(A)`: Counts the number of values in column `A`.
- `SUM(A)`: Computes the sum of all values in column `A`.
- `AVG(A)`: Computes the average of all values in column `A`.
- `MAX(A)`: Finds the maximum value in column `A`.
- `MIN(A)`: Finds the minimum value in column `A`.

#### 10. Count the number of sailors

```sql
SELECT COUNT(*) FROM sailor;
```

- Using `DISTINCT` to count unique sailor names

```sql
SELECT COUNT(DISTINCT s.sname) FROM sailor s;
```

#### 11. Sum of sailors' ages where `rating = 10`

```sql
SELECT SUM(s.age) FROM sailor s WHERE s.rating = 10;
```

#### 12. Average age of sailors where `rating = 10`

```sql
SELECT ROUND(AVG(s.age), 2) FROM sailor s WHERE s.rating = 10;
```

---

### SQL Query: Finding Min/Max Values

#### 13. Find the sailor with the highest age

```sql
SELECT s.sname, s.age
FROM sailor s
WHERE s.age = (SELECT MAX(s2.age) FROM sailor s2);
```

#### 14. Update Brutus's age to `63.5`

```sql
UPDATE sailor
SET age = 63.5
WHERE sid = '29';
```

#### 15. Find the sailor with the lowest age

```sql
SELECT s.sname, s.age
FROM sailor s
WHERE s.age = (SELECT MIN(s2.age) FROM sailor s2);
```

---

### BETWEEN and AND (Inclusive)

- `BETWEEN` and `AND` are used to specify a range.
- They work with **numbers, text, and dates**.

#### 16. Restore Brutus's age to `33.0`

```sql
UPDATE sailor
SET age = 33.0
WHERE sid = '29';
```

#### 17. Find sailors aged between 25 and 35

```sql
SELECT sid, sname
FROM sailor
WHERE age BETWEEN 25 AND 35;
```

#### 18. NOT BETWEEN

```sql
SELECT *
FROM sailor
WHERE sname NOT BETWEEN 'Hansen' AND 'Pettersen';
```

#### 19. Find sailors whose names start with 'A'

```sql
SELECT *
FROM sailor
WHERE sname LIKE 'A%';
```

---
