## SQL Schema and Data Management

### Creating Tables

#### Branch Table

```sql
CREATE TABLE branch (
  branch_name varchar(20) NOT NULL,
  branch_city varchar(45) DEFAULT NULL,
  assets numeric(10,2) DEFAULT NULL,
  PRIMARY KEY (branch_name)
);
```

#### Customer Table

```sql
CREATE TABLE customer (
  customer_name varchar(40) NOT NULL,
  customer_street varchar(45) DEFAULT NULL,
  customer_only varchar(1) DEFAULT NULL,
  PRIMARY KEY (customer_name)
);
```

#### Account Table

```sql
CREATE TABLE account (
  account_number varchar(2) NOT NULL,
  branch_name varchar(45) DEFAULT NULL,
  balance numeric(10,2) DEFAULT NULL,
  PRIMARY KEY (account_number)
);
```

#### Loan Table

```sql
CREATE TABLE loan (
  loan_number varchar(2) NOT NULL,
  branch_name varchar(45) DEFAULT NULL,
  amount numeric(10,2) DEFAULT NULL,
  PRIMARY KEY (loan_number)
);
```

#### Borrower Table

```sql
CREATE TABLE borrower (
  customer_name varchar(45) NOT NULL,
  loan_number varchar(2) NOT NULL,
  PRIMARY KEY (customer_name, loan_number)
);
```

#### Depositor Table

```sql
CREATE TABLE depositor (
  customer_name varchar(45) NOT NULL,
  account_number varchar(2) NOT NULL,
  PRIMARY KEY (customer_name, account_number)
);
```

---

### Inserting Data

#### Insert into Account Table

```sql
INSERT INTO account (account_number, branch_name, balance) VALUES
('1', 'B', 100.00),
('2', 'A', 50.00),
('3', 'A', 30.00),
('4', 'F', 120.00),
('5', 'A', 500.00),
('6', 'B', 324.00);
```

#### Insert into Borrower Table

```sql
INSERT INTO borrower (customer_name, loan_number) VALUES
('Jason', '2'),
('Joe', '1'),
('Joe', '3'),
('Joe', '6'),
('Keith', '4'),
('Mary', '5');
```

#### Insert into Branch Table

```sql
INSERT INTO branch (branch_name, branch_city, assets) VALUES
('A', 'Riverside', 100000.00),
('B', 'LA', 20000.00),
('C', 'Long Beach', 15000.00),
('D', 'Irvine', 12000.00),
('E', 'Pomona', 7000.00),
('F', 'San Jose', 18000.00);
```

#### Insert into Customer Table

```sql
INSERT INTO customer (customer_name, customer_street, customer_only) VALUES
('Alan', 'Mary_street', 'Y'),
('Jason', 'Jason_street', 'N'),
('Joe', 'Joe_street', 'Y'),
('Keith', 'Keith_street', 'N'),
('Mary', 'Mary_street', 'N'),
('Mike', 'Mary_street', 'Y');
```

#### Insert into Depositor Table

```sql
INSERT INTO depositor (customer_name, account_number) VALUES
('Joe', '1'),
('Joe', '2'),
('Joe', '3'),
('Keith', '4'),
('Keith', '6'),
('Mary', '2'),
('Mike', '5');
```

#### Insert into Loan Table

```sql
INSERT INTO loan (loan_number, branch_name, amount) VALUES
('1', 'B', 100.00),
('2', 'E', 27.00),
('3', 'F', 543.00),
('4', 'A', 129.00),
('5', 'A', 26.00),
('6', 'B', 67.00);
```

---

### Queries

#### Accounts in Riverside

```sql
SELECT account_number
FROM account a, branch b
WHERE a.branch_name = b.branch_name AND b.branch_city = 'Riverside';
```

#### Accounts in Branch A and B

```sql
SELECT account_number
FROM account
WHERE branch_name IN ('A', 'B');
```

#### Using EXISTS

```sql
SELECT account_number
FROM account a
WHERE EXISTS (
  SELECT * FROM branch b
  WHERE b.branch_name = a.branch_name AND b.branch_city = 'Riverside'
);
```

#### Accounts Not in Riverside

```sql
SELECT account_number
FROM account a
WHERE NOT EXISTS (
  SELECT * FROM branch b
  WHERE b.branch_name = a.branch_name AND b.branch_city = 'Riverside'
);
```

#### Minimum Balance Account

```sql
SELECT account_number
FROM account
WHERE balance <= ALL (SELECT balance FROM account);
```

#### Using Aggregate Functions

```sql
SELECT COUNT(*) FROM account;
SELECT COUNT(account_number) FROM account;
```

#### Grouping Data

```sql
SELECT branch_name, COUNT(*) FROM account GROUP BY branch_name;
SELECT branch_name, SUM(balance) FROM account GROUP BY branch_name;
```

#### Filtering with HAVING

```sql
SELECT c.customer_name, SUM(balance)
FROM account a, depositor d, customer c
WHERE a.account_number = d.account_number AND c.customer_name = d.customer_name
GROUP BY c.customer_name HAVING SUM(a.balance) > 100;
```

#### Ordering Data

```sql
SELECT c.customer_name, SUM(balance) AS sum_balance
FROM account a, depositor d, customer c
WHERE a.account_number = d.account_number AND c.customer_name = d.customer_name
GROUP BY c.customer_name HAVING COUNT(*) > 1
ORDER BY sum_balance DESC;
```

#### Joins

```sql
SELECT * FROM account a JOIN branch b ON a.branch_name = b.branch_name;
SELECT * FROM account a NATURAL JOIN branch b;
SELECT * FROM account a LEFT JOIN branch b ON a.branch_name = b.branch_name;
SELECT * FROM account a RIGHT JOIN branch b ON a.branch_name = b.branch_name;
SELECT * FROM account a FULL OUTER JOIN branch b ON a.branch_name = b.branch_name ORDER BY a.account_number NULLS FIRST;
```

#### String Functions

```sql
SELECT CONCAT(customer_name, ' ', customer_only) AS customer_full_info FROM customer;
SELECT customer_name || ' ' || customer_only AS customer_full_info FROM customer;
SELECT customer_name, LENGTH(customer_name) AS name_length FROM customer;
```

---
