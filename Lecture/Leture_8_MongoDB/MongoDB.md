# Mongosh CDM

## ZSH Command

- **`ps aux | grep mongod`** — > see port to use run mongod
- **`sudo killall mongod`** —> ปิดทุกโปรเซสของ mongod
- **`sudo kill -9 <PID>`** —>ปิดโปรเซสเฉพาะ แทน <PID> ด้วยเลข Process ID ที่ได้จาก ps aux
- **`lsof -i :<PID>`** —> ตรวจสอบว่าโปรเซสไหนกำลังใช้พอร์ต
- **`mongo --port <PID>`** —> รัน MongoDB บนพอร์ตอื่น

## Shell Command

- `cls` → ล้างหน้าจอ
- `.editor` -> open text buint in editor
- `edit` -> command with an external editor.
- `config.set("editor", "<text editor>")` --> set default editor
- `EDITOR=<text editor> mongosh` --> use text editor onec time
- `globalThis.config` --> see all config
- `config.get("<config>")` -- > see specific config

## Database Commands

| Command             | Description                                                        |
| ------------------- | ------------------------------------------------------------------ |
| `show dbs`          | แสดงรายการฐานข้อมูลทั้งหมดใน MongoDB                               |
| `use DATABASE_NAME` | สลับไปใช้ฐานข้อมูลที่ต้องการ (ถ้ายังไม่มีระบบจะสร้างใหม่อัตโนมัติ) |
| `db.dropDatabase()` | ลบฐานข้อมูลที่ใช้งานอยู่ในปัจจุบัน                                 |

## Collection Commands

| Command                                                          | Description                                          |
| ---------------------------------------------------------------- | ---------------------------------------------------- |
| `show collections`                                               | แสดงรายชื่อ Collections ที่มีอยู่ในฐานข้อมูลปัจจุบัน |
| `db.OLD_COLLECTION_NAME.renameCollection("NEW_COLLECTION_NAME")` | เปลี่ยนชื่อ Collection                               |
| `db.COLLECTION_NAME.find().count()`                              | นับจำนวน Document ทั้งหมดที่อยู่ใน Collection        |

## MongoDB - Create Collection

- `db.createCollection("COLLECTION_NAME")`

```javascript
db.createCollection("customers");
```

- `db.createCollection("COLLECTION_NAME", {OPT_1, OPT_2, OPT3})`

  - **OPT Example**
    - `capped`: (Capped Collection) เมื่อข้อมูลเต็ม จะลบข้อมูลเก่าโดยอัตโนมัติ (First In First Out)
    - `size`: กำหนดขนาดสูงสุดของ Collection
    - `max`: กำหนดจำนวน Document สูงสุดใน Collection

```javascript
db.createCollection("post_w_options)", {
  capped: true,
  size: 6142800,
  max: 100000,
});
```

- `db.createCollection.insert({"KEY": "Value"})`

```javascript
db.post1.insert({ owner_name: "lionking" });
```

| Command                     | Description                  |
| --------------------------- | ---------------------------- |
| `db.COLLECTION_NAME.find()` | ดูข้อมูลทั้งหมดใน Collection |
| `db.COLLECTION_NAME.drop()` | ลบ Collection                |

## MongoDB - Insert Document

- **insertOne** : `db.collection.insertOne({ key: "value" })`

```javascript
db.customers.insertOne({
  customer_id: 10001,
  customer_name: "John Doe",
  customer_zipcode: "10200",
});
```

- **insertMany** : `db.collection.insertMany([{ key1: "value1" }, { key2: "value2" }])`

```javascript
db.customers.insertMany([
  {
    customer_id: 10002,
    customer_name: "Jane Smith",
    customer_zipcode: "50000",
  },
  {
    customer_id: 10003,
    customer_name: "Mike Brown",
    customer_zipcode: "10150",
  },
]);
```

- **insert**
  - `db.collection.insert({ key: "value" })` ---> Single document
  - `db.collection.insert([{ key1: "value1" }, { key2: "value2" }])` ---> Multiple documents

## MongoDB - query document

### Syntax:`db.COLLECTION_NAME.find()`

### MongoDB Query Document: RDBMS vs MongoDB

| Operation             | Syntax               | Example                             | RDBMS Equivalent           |
| --------------------- | -------------------- | ----------------------------------- | -------------------------- |
| Equality              | `{key:value}`        | `db.post.find({owner: "lionking"})` | `WHERE owner = "lionking"` |
| Less than             | `{key:{$lt:value}}`  | `db.post.find({likes: {$lt:100}})`  | `WHERE likes < 100`        |
| Less than or equal    | `{key:{$lte:value}}` | `db.post.find({likes: {$lte:100}})` | `WHERE likes <= 100`       |
| Greater than          | `{key:{$gt:value}}`  | `db.post.find({likes: {$gt:100}})`  | `WHERE likes > 100`        |
| Greater than or equal | `{key:{$gte:value}}` | `db.post.find({likes: {$gte:100}})` | `WHERE likes >= 100`       |
| Not equal             | `{key:{$ne:value}}`  | `db.post.find({likes: {$ne:100}})`  | `WHERE likes != 100`       |

#### Equality

> Finds all documents where the likes field is **exactly 50**.

```javascript
db.post.find({ likes: 50 });
```

#### Less Than `$lt`

> Finds all documents where the likes field is **less than 50**.

```javascript
db.post.find({ likes: { $lt: 50 } });
```

#### Less Than or Equal `$lte`

> Finds all documents where the likes field is **less than or equal 50**.

```javascript
db.post.find({ likes: { $lte: 50 } });
```

#### Greater Than `$gt`

> Finds all documents where the likes field is **greater than 50**.

```javascript
db.post.find({ likes: { $gt: 50 } });
```

#### Greater Than or Equal `$gte`

> Finds all documents where the likes field is **greater than or equal 50**.

```javascript
db.post.find({ likes: { $gte: 50 } });
```

#### Not Equal `$ne`

> Finds all documents where the likes field is **not equal 50**.

```javascript
db.post.find({ likes: { $ne: 50 } });
```

#### And `{CONDITION_1,CONDITION_2}`

> Finds all documents where the likes field is **greater than 50 And owner = "Hikaru"**.

```javascript
db.post.find({ likes: { $gt: 50 }, owner: "Hikaru" });
```

#### OR `$or[{CONDITION_1,CONDITION_2}]`

> Finds all documents where the likes field is **greater than 50 OR owner = "Hikaru"**.

```javascript
db.post`.find($or[{ likes: { $gt: 50 }, owner: "Hikaru" }]);
```

## MongoDB - update document

### Syntax : `db.COLLECTION_NAME.updateOne(SELECTION_CRITERIA, UPDATED_DATA)`

```javascript
db.post.updateOne(
  { title: "MongoDB 101" },
  { $set: { title: "MongoDB HelloWorld" } },
);
```

## MongoDB - delete document

### Syntax :

- `remove` -- old version

  - `db.COLLECTION_NAME.remove(DELETION_CRITERIA)` <br><br>

  ```javascript
  db.post.remove({ title: "MongoDB Overview" });
  ```

- `deleteOne`

  - ใช้สำหรับ ลบเอกสารเพียง 1 รายการแรก ที่ตรงกับเงื่อนไขที่ระบุ
  - แม้ว่าจะมีหลายเอกสารที่ตรงกัน ก็จะลบแค่ 1 รายการแรกเท่านั้น
  - `db.COLLECTION_NAME.deleteOne(DELETION_CRITERIA)`<br><br>

  ```javascript
  db.post.deleteOne({ title: "MongoDB Overview" });
  ```

- `deleteMany`

  - ใช้สำหรับ ลบเอกสารทั้งหมดที่ตรงกับเงื่อนไข
  - `db.COLLECTION_NAME.deleteMany(DELETION_CRITERIA)`<br><br>

  ```javascript
  db.post.deleteMany({ title: "MongoDB Overview" });
  ```

## MongoDB projection Select only some columns

### Syntax : `db.COLLECTION_NAME.find({},{KEY:1})`

- 1 to show
- 0 to not show

```javascript
db.post.find({}, { title: 1, _id: 0 }); // show only title
```

### `$all` (must have both)

```javascript
db.post.find(
  { tags: { $all: ["mongodb", "database"] } },
  { title: 1, _id: 0, tags: 1 },
);
```

### `$in` (just have)

```javascript
db.post.find(
  { tags: { $in: ["compass", "database"] } },
  { title: 1, _id: 0, tags: 1 },
);
```

## MongoDB - Limit / Skip records

### Syntax : `db.COLLECTION_NAME.find().limit(NUMBER).skip(NUMBER)`

#### `limit`

```javascript
db.post.find({}, { title: 1, _id: 0 }).limit(3);
```

#### `limit + skip`

```javascript
db.post.find({}, { title: 1, _id: 0 }).limit(3).skip(2);
```

## MongoDB - sort document

### Syntax : `db.COLLECTION_NAME.find().sort({KEY:1})`

- 1 is **ACS** เรียงน้อยไปมาก by default
- -1 is **DESC** เรียงจากมากไปน้อย

```javascript
db.post.find({}, { title: 1, id: 0 }).sort({ title: -1 });
```

## MongoDB - indexing

| คำสั่ง          | สถานะ                   | ใช้ทำอะไร?                             |
| --------------- | ----------------------- | -------------------------------------- |
| `ensureIndex()` | ❌ Deprecated (เลิกใช้) | สร้างดัชนี (MongoDB 3.0 เลิกใช้แล้ว)   |
| `createIndex()` | ✅ ปัจจุบันใช้แทน       | สร้างดัชนีเพื่อเพิ่มความเร็วในการค้นหา |

- **Single-Field Index**

```javascript
db.customers.createIndex({ customer_name: 1 });
```

- **Compounnd Index**

```javascript
db.orders.createIndex({ customer_id: 1, order_date: -1 });
```

- **Check Index in collection**

```javascript
db.customers.getIndexes();
```

## MongoDB - aggregation

### Syntax : `db.COLLECTION_NAME.aggregate(AGGREGATION PIPELINE)`

#### Example : `db.<<CollectionName>>.aggregate([ <<stage1>>, <<stage2>> ])`

```javascript
db.orders.aggregate(
    [
    $match stage --> { $match: {status: "A"} },
    $group stage --> { $group: {_id: "$cust_id",total: {$sum: "$amount"}}}
    ])

db.orders.aggregate([{$match: {status: "A"}, {$group : {_id: "$cust_id",total: {$sum: "$amount"}}}}])
```

---

### aggregate functions: `sum`, `avg`

```javascript
db.post.aggregate([
  {
    $group: {
      _id: "$owner",
      num_content: { $sum: 1 }, // นับจำนวนโพสต์ในแต่ละกลุ่ม
    },
  },
]);
```

---

### aggregation with **sorting**

```javascript
db.post.aggregate([
  {
    $group: {
      _id: "owner",
      total_like: { $sum: "$like" }
    }
  }
    {$sort : {total_like:1}}
]);
```

#### Ex collection

```javascript
[
  { post_id: 1, owner: "Alice", like: 10 },
  { post_id: 2, owner: "Bob", like: 5 },
  { post_id: 3, owner: "Alice", like: 8 },
  { post_id: 4, owner: "Bob", like: 7 },
  { post_id: 5, owner: "Alice", like: 2 },
];
```

#### Out put

```javascript
[
  { _id: "Bob", total_like: 12 },
  { _id: "Alice", total_like: 20 },
];
```

---

### aggregate function `$push`

```javascript
db.post.aggregate([
  {
    $group: {
      _id: "$owner",
      urls: { $push: "Surl" },
    },
  },
]);
```

#### Ex collection

```javascript
[
  { post_id: 1, owner: "Alice", url: "url1" },
  { post_id: 2, owner: "Bob", url: "url2" },
  { post_id: 3, owner: "Alice", url: "url3" },
  { post_id: 4, owner: "Bob", url: "url4" },
  { post_id: 5, owner: "Alice", url: "url5" },
];
```

#### Out put

```javascript
[
  { _id: "Alice", urls: ["Surl", "Surl", "Surl"] },
  { _id: "Bob", urls: ["Surl", "Surl"] },
];
```

⚠ หมายเหตุ: Surl เป็นค่าคงที่

👉 urls: { $push: "Surl" } ไม่ได้ดึงค่าจากฐานข้อมูล <br>
👉 "Surl" เป็น ค่าคงที่ ที่ถูกเพิ่มเข้าไป ทุกครั้งที่เอกสารตรงกับกลุ่มที่จัดไว้

#### ถ้าต้องการเก็บค่า url ของแต่ละโพสต์จริง ๆ ให้ใช้:

```javascript
db.post.aggregate([
  {
    $group: {
      _id: "$owner",
      urls: { $push: "$url" }, // ดึงค่า `url` จากแต่ละโพสต์
    },
  },
]);
```

#### Output

```javascript
[
  { _id: "Alice", urls: ["url1", "url3", "url5"] },
  { _id: "Bob", urls: ["url2", "url4"] },
];
```

👉 urls จะเก็บ ค่าของ URL จริง ๆ จากเอกสารที่ตรงกัน

🔍 สรุป
|คำสั่ง| ใช้ทำอะไร?|
|----|-----------|
|`id: "$owner"`| จัดกลุ่มตาม owner|
|`$push: "Surl"` |เพิ่ม "Surl" เข้าไปในอาร์เรย์ urls ทุกครั้งที่พบโพสต์ของเจ้าของคนนั้น|
|`$push: "$url"` |(ทางเลือกที่ถูกต้อง) ดึงค่า url ของแต่ละโพสต์เข้าอาร์เรย์ urls|

❌ `$push: "Surl"` → ไม่ได้ดึงค่า URL จริง ๆ แค่เพิ่ม "Surl" ซ้ำ ๆ

✅ `$push: "$url"` → ดึงค่า URL ของแต่ละโพสต์และเก็บลงในอาร์เรย์

📌 ถ้าต้องการเก็บค่าจริงของ URL ให้ใช้ `$push: "$url"` แทน `$push: "Surl"`

---

### aggregate function `$addToSet`

```javascript
db.post.aggregate([
    {
        $group:{
            _id:"$owner"
            urls:$addToSet : "$url"
        }
    }
])
```

**`urls: { $addToSet: "$url" }`**

- ใช้ `$addToSet` เพื่อ เพิ่มค่าฟิลด์ url ลงในอาร์เรย์ urls
- 📌 ข้อแตกต่างระหว่าง `$addToSet` กับ`$push`
  - `$addToSet` → ✅ เก็บค่าแบบไม่ซ้ำกัน
  - `$push` → ❌ เก็บค่าทั้งหมด (แม้ว่าจะซ้ำกัน)

---

### aggregate function $last

```javascript
db.post.aggregate([
    {
        $group:{
            _id:"$owner"
            urls:$last : "$url"
        }
    }
])
```

- จัดกลุ่ม `($group)` ข้อมูลในคอลเลกชัน `post` ตาม `owner` และ ดึงค่า <u>ล่าสุด</u> ของฟิลด์ url สำหรับแต่ละกลุ่มโดยใช้ `$last`

#### Example Collection

```javascript
[
  { post_id: 1, owner: "Alice", url: "url1" },
  { post_id: 2, owner: "Bob", url: "url2" },
  { post_id: 3, owner: "Alice", url: "url3" },
  { post_id: 4, owner: "Bob", url: "url4" },
  { post_id: 5, owner: "Alice", url: "url5" },
];
```

#### Out put

```javascript
[
  { _id: "Alice", urls: "url5" },
  { _id: "Bob", urls: "url4" },
];
```

- Alice มีโพสต์ 3 ครั้ง → ค่า url ล่าสุดคือ "url5"
- Bob มีโพสต์ 2 ครั้ง → ค่า url ล่าสุดคือ "url4"

⚠ หมายเหตุ: `$last` ใช้ตามลำดับที่ MongoDB เก็บข้อมูล

- MongoDB จะ คืนค่าเอกสารสุดท้าย ตาม Insertion Order
- หากต้องการให้ MongoDB คืนค่าจากการเรียงลำดับอื่น เช่น วันที่ (createdAt) ต้องใช้ $sort ก่อน $group

🔹 หากต้องการดึง URL ล่าสุดตาม createdAt ให้ทำแบบนี้:

```javascript
db.post.aggregate([
  { $sort: { createdAt: 1 } }, // เรียงจากเก่าสุดไปล่าสุด
  {
    $group: {
      _id: "$owner",
      urls: { $last: "$url" },
    },
  },
]);
```

- MongoDB จะคืนค่า url ล่าสุดโดยดูจากฟิลด์ createdAt ไม่ใช่เพียงแค่ลำดับการเพิ่มข้อมูล

🔍 เปรียบเทียบ `$last` กับ `$first`
|คำสั่ง|ทำอะไร?|
|---|----|
|`$last: "$url"`| ดึง url จาก เอกสารสุดท้าย ของแต่ละ owner|
|`$first: "$url"`| ดึง url จาก เอกสารแรก ของแต่ละ owner|

🔹 ถ้าใช้ `$first` แทน `$last:`

```javascript
db.post.aggregate([
  {
    $group: {
      _id: "$owner",
      urls: { $first: "$url" },
    },
  },
]);
```

#### Output

```javascript
[
  { _id: "Alice", urls: "url1" },
  { _id: "Bob", urls: "url2" },
];
```

📌 `$first` ใช้คืนค่าแรกสุดของแต่ละกลุ่ม ในขณะที่ `$last` คืนค่าล่าสุด
|คำสั่ง| ใช้ทำอะไร?|
|----|-----------|
|`_id: "$owner"`| จัดกลุ่มตาม owner|
|`$last: "$url"`| ดึงค่า url ล่าสุดของแต่ละ owner|
|`$first: "$url"` |ดึงค่า url แรกสุดของแต่ละ owner|
|`$sort: { createdAt: 1 }`|ใช้เรียงลำดับตาม createdAt ก่อน $group|

📌 ถ้าต้องการดึงโพสต์ล่าสุดตามลำดับที่เพิ่ม ใช้ `$last` <br>
📌 ถ้าต้องการดึงโพสต์แรกสุดของเจ้าของ ใช้ `$first` <br>
📌 ถ้าต้องการให้แน่ใจว่าข้อมูลล่าสุดจริง ๆ ให้ใช้ `$sort` ด้วย

❌ `urls: { $last: "$url" }` → ดึงค่า url ล่าสุดแต่ไม่เรียงตาม createdAt <br>
✅ `urls: { $last: "$url" } + $sort: { createdAt: 1 }` → ✅ ดึงค่า url ล่าสุดตามวันที่สร้าง

---

### MongoDB – having

- ใน MongoDB ไม่มีคำสั่ง `HAVING` โดยตรงเหมือนใน SQL แต่เราสามารถจำลองพฤติกรรมของ HAVING ได้โดยใช้ Aggregation Framework โดยเฉพาะ `$match` และ `$group`

#### 🔍 HAVING ใน SQL คืออะไร?

- ใน SQL, `HAVING` ใช้เพื่อกรองข้อมูลที่ถูกจัดกลุ่มแล้ว `(GROUP BY)` โดยมักใช้ร่วมกับฟังก์ชัน Aggregate เช่น COUNT(), SUM(), AVG(), ฯลฯ

🔹 ตัวอย่าง `HAVING` ใน SQL

```sql
SELECT owner, COUNT(*) AS total_posts
FROM post
GROUP BY owner
HAVING total_posts > 2;
```

อธิบาย:

- นับจำนวนโพสต์ `(COUNT(*))` ของแต่ละ owner
- กรองเฉพาะเจ้าของ `(owner)` ที่มี โพสต์มากกว่า 2

#### 🔍 วิธีใช้ HAVING ใน MongoDB (ใช้ $match หลัง $group)

```javascript
db.post.aggregate([
  {
    $group: {
      _id: "$owner",
      total_posts: { $sum: 1 }, // นับจำนวนโพสต์ของแต่ละ owner
    },
  },
  {
    $match: { total_posts: { $gt: 2 } }, // กรองเฉพาะ owner ที่มีโพสต์มากกว่า 2
  },
]);
```

#### 📌 คำอธิบาย

1. `$group` → จัดกลุ่ม `(GROUP BY)` ตาม owner และนับจำนวนโพสต์ `($sum: 1)`
2. `$match` → ทำหน้าที่เหมือน `HAVING` โดยกรองเฉพาะกลุ่มที่มี total_posts > 2

#### Example Collection

```javascript
[
  { post_id: 1, owner: "Alice", content: "Hello World" },
  { post_id: 2, owner: "Bob", content: "MongoDB is great" },
  { post_id: 3, owner: "Alice", content: "Aggregation is powerful" },
  { post_id: 4, owner: "Bob", content: "Learning MongoDB" },
  { post_id: 5, owner: "Alice", content: "Another post" },
];
```

#### Output

```javascript
[{ _id: "Alice", total_posts: 3 }];
```

- Alice มี 3 โพสต์ → ผ่านเงื่อนไข `total_posts > 2`
- Bob มี 2 โพสต์ → ไม่ผ่านเงื่อนไข `total_posts > 2`

---

#### 🔍 กรณีอื่น ๆ ที่ใช้ HAVING

##### `SUM()` in sql

```sql
SELECT owner, SUM(likes) AS total_likes
FROM post
GROUP BY owner
HAVING total_likes > 10;
```

##### `SUM()` in MongoDB

```javascript
db.post.aggregate([
  {
    $group: {
      _id: "$owner",
      total_likes: { $sum: "$likes" },
    },
  },
  {
    $match: { total_likes: { $gt: 10 } }, // กรองเฉพาะ owner ที่มีไลก์รวมมากกว่า 10
  },
]);
```

##### `AVG()` in sql

```sql
SELECT owner, SUM(likes) AS total_likes
FROM post
GROUP BY owner
HAVING total_likes > 10;
```

##### `AVG()` in MongoDB

```javascript
db.post.aggregate([
  {
    $group: {
      _id: "$owner",
      avg_likes: { $avg: "$likes" },
    },
  },
  {
    $match: { avg_likes: { $gt: 5 } }, // กรองเฉพาะ owner ที่มีค่าเฉลี่ยไลก์มากกว่า 5
  },
]);
```

---

## MongoDB – `$lookup`

**`$lookup`** เป็น **Aggregation Stage** ใน MongoDB ที่ใช้สำหรับ **ทำการ Join** ข้อมูลระหว่าง **2 คอลเลกชัน** (เหมือน `JOIN` ใน SQL)

### Syntax : `$lookup`

```javascript
db.collection.aggregate([
  {
    $lookup: {
      from: "target_collection", // คอลเลกชันที่ต้องการ Join
      localField: "field_in_main", // ฟิลด์ในคอลเลกชันหลัก
      foreignField: "field_in_target", // ฟิลด์ในคอลเลกชันเป้าหมาย
      as: "output_field", // ชื่อฟิลด์ที่เก็บข้อมูลที่ Join มา
    },
  },
]);
```

### Example Collections

#### Collection `orders`

````json
[
  { "_id": 1, "customer_id": 101, "product": "Laptop" },
  { "_id": 2, "customer_id": 102, "product": "Phone" },
  { "_id": 3, "customer_id": 101, "product": "Tablet" } ] ``` #### ** Collections `customers`**

```json
[
  { "customer_id": 101, "name": "Alice", "city": "Bangkok" },
  { "customer_id": 102, "name": "Bob", "city": "Chiang Mai" }
]
````

#### ต้องการ Join customers กับ orders

```javascript
db.orders.aggregate([
  {
    $lookup: {
      from: "customers", // คอลเลกชันเป้าหมาย (customers)
      localField: "customer_id", // ฟิลด์ใน orders
      foreignField: "customer_id", // ฟิลด์ใน customers
      as: "customer_info", // ผลลัพธ์จะเก็บในฟิลด์นี้
    },
  },
]);
```

#### Output

```json
[
  {
    "_id": 1,
    "customer_id": 101,
    "product": "Laptop",
    "customer_info": [
      { "customer_id": 101, "name": "Alice", "city": "Bangkok" }
    ]
  },
  {
    "_id": 2,
    "customer_id": 102,
    "product": "Phone",
    "customer_info": [
      { "customer_id": 102, "name": "Bob", "city": "Chiang Mai" }
    ]
  },
  {
    "_id": 3,
    "customer_id": 101,
    "product": "Tablet",
    "customer_info": [
      { "customer_id": 101, "name": "Alice", "city": "Bangkok" }
    ]
  }
]
```

- **สังเกตว่า** `customer_info` จะถูกเพิ่มเข้าไปเป็นอาร์เรย์ที่มีข้อมูลลูกค้า

### **สรุป**

- **`$lookup` ใช้สำหรับ JOIN คอลเลกชัน** ใน MongoDB
- ใช้ **`localField`** และ **`foreignField`** เพื่อเชื่อมโยงข้อมูล
- ผลลัพธ์จะ **เก็บเป็นอาร์เรย์ของเอกสาร** ในฟิลด์ที่กำหนด (`as: "output_field"`)

---

## MongoDB – `$unwind`

- **`$unwind`** เป็น **Aggregation Stage** ใน MongoDB ที่ใช้ **แยก (Deconstruct) อาร์เรย์ออกเป็นเอกสารหลายรายการ** โดยเอกสารแต่ละรายการจะมี **ค่าจากอาร์เรย์เพียงค่าเดียว**
- คล้ายกับการ **"แตกข้อมูลจากอาร์เรย์ออกเป็นหลายแถว"** เหมือน `JOIN` กับ Table อื่นใน SQL

### Syntax: `$unwind`

```javascript
db.collection.aggregate([{ $unwind: "$array_field" }]);
```

#### Example Collection

### **collection `orders` **

```javascript
[
  { _id: 1, customer: "Alice", items: ["Laptop", "Mouse", "Keyboard"] },
  { _id: 2, customer: "Bob", items: ["Phone", "Charger"] },
  { _id: 3, customer: "Charlie", items: [] },
];
```

---

- **ฟิลด์ `items` เป็นอาร์เรย์** ที่มีสินค้ามากกว่าหนึ่งรายการในแต่ละออเดอร์

### 🔹 ใช้ `$unwind` เพื่อนำแต่ละ `item` ออกมาเป็นเอกสารแยกกัน

```javascript
db.orders.aggregate([{ $unwind: "$items" }]);
```

### Output

```javascript
[
  { _id: 1, customer: "Alice", items: "Laptop" },
  { _id: 1, customer: "Alice", items: "Mouse" },
  { _id: 1, customer: "Alice", items: "Keyboard" },
  { _id: 2, customer: "Bob", items: "Phone" },
  { _id: 2, customer: "Bob", items: "Charger" },
];
```

- **MongoDB ได้แยก `items` ที่เป็นอาร์เรย์ออกเป็นหลายแถว**
- **ออเดอร์ `_id: 1` ของ Alice ถูกแยกออกเป็น 3 เอกสาร**

### ** ป้องกันการลบเอกสารที่มีอาร์เรย์ว่างเปล่า**

- ถ้าต้องการให้เอกสารที่มีอาร์เรย์ว่าง (`[]`) ยังคงอยู่ ให้ใช้ `{ preserveNullAndEmptyArrays: true }`

```javascript
db.orders.aggregate([
  { $unwind: { path: "$items", preserveNullAndEmptyArrays: true } },
]);
```

### **Output**

```json
[
  { "_id": 1, "customer": "Alice", "items": "Laptop" },
  { "_id": 1, "customer": "Alice", "items": "Mouse" },
  { "_id": 1, "customer": "Alice", "items": "Keyboard" },
  { "_id": 2, "customer": "Bob", "items": "Phone" },
  { "_id": 2, "customer": "Bob", "items": "Charger" },
  { "_id": 3, "customer": "Charlie", "items": null }
]
```

- **`Charlie` ไม่ถูกลบออกไป และ `items` แสดงเป็น `null`**

---

### ใช้ `$unwind` ร่วมกับ `$group` เพื่อนับจำนวนรายการสินค้า

- ถ้าต้องการนับจำนวนสินค้าที่ถูกสั่งซื้อในแต่ละออเดอร์:

```javascript
db.orders.aggregate([
  { $unwind: "$items" },
  {
    $group: {
      _id: "$items",
      count: { $sum: 1 },
    },
  },
]);
```

### **🔹 ผลลัพธ์ที่ได้**

```json
[
  { "_id": "Laptop", "count": 1 },
  { "_id": "Mouse", "count": 1 },
  { "_id": "Keyboard", "count": 1 },
  { "_id": "Phone", "count": 1 },
  { "_id": "Charger", "count": 1 }
]
```

- **แสดงจำนวนครั้งที่สินค้าถูกสั่งซื้อในทุกออเดอร์**

### **สรุป**

| คำสั่ง                                                                | ใช้ทำอะไร?                          |
| --------------------------------------------------------------------- | ----------------------------------- |
| `$unwind: "$array_field"`                                             | แยกค่าในอาร์เรย์ออกเป็นหลายเอกสาร   |
| `$unwind: { path: "$array_field", preserveNullAndEmptyArrays: true }` | ไม่ลบเอกสารที่มีอาร์เรย์ว่าง        |
| `$unwind` + `$group`                                                  | ใช้นับจำนวนค่าที่เกิดขึ้นในอาร์เรย์ |

- **ถ้าต้องการแยกค่าจากอาร์เรย์ใน MongoDB ให้ใช้ `$unwind`**
- **ถ้าไม่ต้องการให้ลบเอกสารที่มีอาร์เรย์ว่าง ให้ใช้ `preserveNullAndEmptyArrays: true`**
