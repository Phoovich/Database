# Banking

## Create Table: branch

```sql
CREATE TABLE branch (
  branch_name varchar(20) NOT NULL,
  branch_city varchar(45) DEFAULT NULL,
  assets numeric(10,2) DEFAULT NULL,
  PRIMARY KEY (branch_name)
);
```

## Create Table: customer

```sql
CREATE TABLE customer (
  customer_name varchar(40) NOT NULL,
  customer_street varchar(45) DEFAULT NULL,
  customer_only varchar(1) DEFAULT NULL,
  PRIMARY KEY (customer_name)
);
```

## Create Table: account

```sql
CREATE TABLE account (
  account_number varchar(2) NOT NULL,
  branch_name varchar(45) DEFAULT NULL,
  balance numeric(10,2) DEFAULT NULL,
  PRIMARY KEY (account_number)
);
```

## Create Table: loan

```sql
CREATE TABLE loan (
  loan_number varchar(2) NOT NULL,
  branch_name varchar(45) DEFAULT NULL,
  amount numeric(10,2) DEFAULT NULL,
  PRIMARY KEY (loan_number)
);
```

## Create Table: borrower

```sql
CREATE TABLE borrower (
  customer_name varchar(45) NOT NULL,
  loan_number varchar(2) NOT NULL,
  PRIMARY KEY (customer_name, loan_number)
);

```

## Create Table: depositor

```sql
CREATE TABLE depositor (
  customer_name varchar(45) NOT NULL,
  account_number varchar(2) NOT NULL,
  PRIMARY KEY (customer_name,account_number)
);
```

---

## Insert Data for Table: account

```sql
INSERT INTO  account (account_number, branch_name, balance) VALUES ('1', 'B', 100.00);
INSERT INTO  account (account_number, branch_name, balance) VALUES ('2', 'A', 50.00);
INSERT INTO  account (account_number, branch_name, balance) VALUES ('3', 'A', 30.00);
INSERT INTO  account (account_number, branch_name, balance) VALUES ('4', 'F', 120.00);
INSERT INTO  account (account_number, branch_name, balance) VALUES ('5', 'A', 500.00);
INSERT INTO  account (account_number, branch_name, balance) VALUES ('6', 'B', 324.00);

```

## Insert Data for Table: boorower

```sql
INSERT INTO  borrower (customer_name, loan_number) VALUES ('Jason', '2');
INSERT INTO  borrower (customer_name, loan_number) VALUES ('Joe', '1');
INSERT INTO  borrower (customer_name, loan_number) VALUES ('Joe', '3');
INSERT INTO  borrower (customer_name, loan_number) VALUES ('Joe', '6');
INSERT INTO  borrower (customer_name, loan_number) VALUES ('Keith', '4');
INSERT INTO  borrower (customer_name, loan_number) VALUES ('Mary', '5');
```

## Insert Data for Table: boorower

```sql
INSERT INTO  branch (branch_name, branch_city, assets) VALUES ('A', 'Riverside', 100000.00);
INSERT INTO  branch (branch_name, branch_city, assets) VALUES ('B', 'LA', 20000.00);
INSERT INTO  branch (branch_name, branch_city, assets) VALUES ('C', 'Long Beach', 15000.00);
INSERT INTO  branch (branch_name, branch_city, assets) VALUES ('D', 'Irvine', 12000.00);
INSERT INTO  branch (branch_name, branch_city, assets) VALUES ('E', 'Pomona', 7000.00);
INSERT INTO  branch (branch_name, branch_city, assets) VALUES ('F', 'San Jose', 18000.00);
```

## Insert Data for Table: boorower

```sql
INSERT INTO  customer (customer_name, customer_street, customer_only) VALUES ('Alan', 'Mary_street', 'Y');
INSERT INTO  customer (customer_name, customer_street, customer_only) VALUES ('Jason', 'Jason_street', 'N');
INSERT INTO  customer (customer_name, customer_street, customer_only) VALUES ('Joe', 'Joe_street', 'Y');
INSERT INTO  customer (customer_name, customer_street, customer_only) VALUES ('Keith', 'Keith_street', 'N');
INSERT INTO  customer (customer_name, customer_street, customer_only) VALUES ('Mary', 'Mary_street', 'N');
INSERT INTO  customer (customer_name, customer_street, customer_only) VALUES ('Mike', 'Mary_street', 'Y');
```

## Insert Data for Table: boorower

```sql
INSERT INTO  depositor (customer_name, account_number) VALUES ('Joe', '1');
INSERT INTO  depositor (customer_name, account_number) VALUES ('Joe', '2');
INSERT INTO  depositor (customer_name, account_number) VALUES ('Joe', '3');
INSERT INTO  depositor (customer_name, account_number) VALUES ('Keith', '4');
INSERT INTO  depositor (customer_name, account_number) VALUES ('Keith', '6');
INSERT INTO  depositor (customer_name, account_number) VALUES ('Mary', '2');
INSERT INTO  depositor (customer_name, account_number) VALUES ('Mike', '5');
```

## Insert Data for Table: boorower

```sql
INSERT INTO  loan (loan_number, branch_name, amount) VALUES ('1', 'B', 100.00);
INSERT INTO  loan (loan_number, branch_name, amount) VALUES ('2', 'E', 27.00);
INSERT INTO  loan (loan_number, branch_name, amount) VALUES ('3', 'F', 543.00);
INSERT INTO  loan (loan_number, branch_name, amount) VALUES ('4', 'A', 129.00);
INSERT INTO  loan (loan_number, branch_name, amount) VALUES ('5', 'A', 26.00);
INSERT INTO  loan (loan_number, branch_name, amount) VALUES ('6', 'B', 67.00);
```
