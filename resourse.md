Here’s the updated markdown with the additional content seamlessly integrated:

# Resources for Preparation

## Slides

[1.\_Overview.pdf](./Slides/1._Overview.pdf)

## YouTube

(Add links or details here)

## Books

- **Relational Database Design** (Add author or publication details here)

---

# Test 1

## Breakdown of Topics and Percentages

### 9%

- Overview
- Relational Algebra

### 15%

- ER and Relational Model

### 6%

- Schema Refinement

---

## Lessons and Topics to Focus on for Exam 1 (January 28, 2568)

### Covered Topics:

1. **Overview of Database Systems**:

   - Evolution of database systems.
   - Components and architecture (Three-schema architecture, data independence).

2. **Relational Algebra**:

   - Operations like selection, projection, union, set difference, Cartesian product, and join.
   - Examples and problem-solving.

3. **Entity-Relationship (ER) Model**:

   - ER diagrams: Entities, attributes, and relationships.
   - Keys (primary, foreign) and constraints.
   - UML Class Diagrams (as part of database modeling).

4. **Relational Model**:

   - Mapping ER diagrams to relational schemas.
   - Referential integrity.
   - Schema design and optimization.

5. **Schema Refinement**:
   - Functional dependencies.
   - Normalization (1NF, 2NF, 3NF, and BCNF).

---

## Key Takeaways from the “Relational Model” Slides:

1. **Introduction to the Relational Model**:

   - **Proposed by**: Dr. E.F. Codd in 1970.
   - **Concept**: Data is structured in relations (tables), which are mathematical representations based on set theory.
   - **Informal Definitions**:
     - **Relation (Table)**: Contains rows (tuples) and columns (attributes).
     - **Key**: A unique identifier for each row in a relation.

2. **Formal Definitions**:

   - **Schema**: The structure of a relation, including its name and attributes.
     - Example: `STUDENT(Name, SSN, GPA)`.
   - **Domain**: The set of permissible values for an attribute (e.g., GPA = 0 to 4).
   - **Tuple**: An ordered set of values (a single row in a table).
   - **Degree**: Number of attributes in a relation.

3. **Characteristics of Relations**:

   - **Ordering**:
     - Tuples (rows) in a relation are unordered.
     - Attributes (columns) in a schema are considered ordered.
   - **Atomicity**:
     - Values in a tuple are indivisible (atomic).
   - **Null Values**:
     - Represent missing or inapplicable information.

4. **Relational Database Constraints**:

   - **Domain Constraints**: Values of an attribute must belong to its domain.
   - **Key Constraints**:
     - Superkey: A set of attributes that uniquely identifies a tuple.
     - Candidate Key: A minimal superkey (no subset is a superkey).
     - Primary Key: A chosen candidate key to uniquely identify tuples.
   - **Entity Integrity**:
     - Primary key attributes cannot have null values.
   - **Referential Integrity**:
     - Foreign keys in a relation must reference valid primary keys in another relation or be null.

5. **Operations on Relations**:

   - **Insert**: Adds new tuples, ensuring constraints are not violated.
   - **Delete**: Removes tuples, potentially violating referential integrity.
   - **Update**: Modifies attribute values while preserving constraints.

6. **Relational Mapping from ER Models**:

   - Steps to Map ER to Relational Schema:
     1. Map regular (strong) entity types to relations.
     2. Map weak entity types to relations, including foreign keys from owner entities.
     3. Map 1:1 relationships using foreign keys or merged relations.
     4. Map 1:N relationships by adding foreign keys to the “N-side” relation.
     5. Map M:N relationships by creating a new relation with foreign keys referencing participating entities.
     6. Map multivalued attributes as separate relations.
     7. Map n-ary relationships as new relations with foreign keys from all participating entities.
   - **Specialization and Generalization**:
     - Multiple options for mapping superclass/subclass relationships:
       - Separate tables for superclass and subclasses.
       - A single table with a “type” attribute to distinguish subclasses.

7. **Example: COMPANY Database**:

   - **Entities**: EMPLOYEE, DEPARTMENT, PROJECT.
   - **Relationships**: WORKS_FOR, MANAGES, WORKS_ON.
   - **Mapping**:
     - EMPLOYEE and DEPARTMENT are separate relations.
     - Foreign keys in EMPLOYEE reference DEPARTMENT (e.g., DNUMBER → DNO).
     - M:N relationship (WORKS_ON) becomes a new relation with foreign keys referencing EMPLOYEE and PROJECT.

8. **Summary of ER-to-Relational Mapping**:
   - Entity Type → Relation.
   - 1:1 and 1:N Relationships → Foreign Keys.
   - M:N Relationships → New Relation with Foreign Keys.
   - Attributes → Columns.
   - Keys → Primary/Foreign Keys.

---

## Key Takeaways from the Slides on Schema Refinement and Normal Forms:

1. **The Evils of Redundancy**:

   - Problems caused by redundancy:
     - Increased storage requirements.
     - Anomalies in data:
       - **Insert Anomaly**: Inserting data may require redundant information.
       - **Delete Anomaly**: Deleting data may result in unintended loss of information.
       - **Update Anomaly**: Changes need to be made at multiple places.
   - **Solution**: Use decomposition to break relations into smaller ones without losing information.

2. **Functional Dependencies (FDs)**:

   - **Definition**: A set of attributes X determines a set of attributes Y if the value of X uniquely identifies Y (denoted as `X → Y`).
   - **Keys**:
     - **Candidate Key**: A minimal set of attributes that uniquely identifies a tuple.
     - **Superkey**: A set of attributes containing a candidate key.
     - **Prime Attributes**: Attributes that are part of a candidate key.
   - **FD Inference**:
     - Armstrong’s Axioms (Rules for deriving FDs):
       - **Reflexivity**: If `Y ⊆ X`, then `X → Y`.
       - **Augmentation**: If `X → Y`, then `XZ → YZ` (for any Z).
       - **Transitivity**: If `X → Y` and `Y → Z`, then `X → Z`.

3. **Properties of Decompositions**:

   - **Lossless-Join Decomposition**:
     - Ensures that decomposing a schema does not lose information when the smaller relations are joined back.
     - A decomposition is lossless if the intersection of the smaller relations is a superkey for at least one relation.
   - **Dependency Preservation**:
     - Ensures all FDs are preserved in the decomposed schema.
   - **Trade-offs**:
     - Decompositions may make some queries more expensive or require joining relations to enforce constraints.

4. **Normalization**:

   - **Normalization Process**: Decomposes relations into smaller relations to reduce redundancy and avoid anomalies.
   - **Normal Forms**:
     1. **First Normal Form (1NF)**:
        - Attributes must have atomic values (no multi-valued or composite attributes).
     2. **Second Normal Form (2NF)**:
        - A relation is in 2NF if it is in 1NF and every non-prime attribute is fully functionally dependent on the primary key.
     3. **Third Normal Form (3NF)**:
        - A relation is in 3NF if it is in 2NF and no non-prime attribute is transitively dependent on the primary key.
     4. **Boyce-Codd Normal Form (BCNF)**:
        - A stricter version of 3NF: For every FD `X → Y`, `X` must be a superkey.

5. **Examples of Anomalies and Refinements**:

   - **HOURLY_EMPS Example**:
     - Issues with redundancy when `rating → hourly_wages`.
     - **Solution**: Decompose into smaller tables while preserving FDs and ensuring lossless joins.
   - **TEACH Example**:
     - Demonstrates decomposition to achieve BCNF while potentially sacrificing dependency preservation.

6. **Denormalization**:
   - **Definition**: Combining smaller relations into a larger one for performance improvements.
   - **Use Cases**:
     - Reporting, data warehousing, and exporting data to other formats.
   - **Caution**: While it reduces query complexity, it may reintroduce redundancy and anomalies.

---

## Key Takeaways from the Slides on Relational Algebra:

1. **Importance of Relational Algebra**:

   - Developed by Edgar F. Codd as the theoretical foundation for the relational model.
   - Based on set theory, it provides the basis for query languages like SQL.
   - Offers procedural techniques for manipulating and retrieving data from databases.

2. **Relational Algebra Operators**:

   **Basic Operators**:

   1. **Selection (σ)**:
      - Filters rows based on a condition.
      - Example: `σ(condition)(Relation)`.
   2. **Projection (π)**:
      - Retrieves specific columns from a relation.
      - Example: `π(attributes)(Relation)`.
   3. **Union (∪)**:
      - Combines tuples from two relations, removing duplicates.
      - Relations must be union-compatible.
   4. **Set-Difference (−)**:
      - Returns tuples in one relation but not in the other.
      - Example: `Relation1 − Relation2`.
   5. **Cross-Product (×)**:
      - Combines every tuple in one relation with every tuple in another.

   **Additional Operators**:

   1. **Intersection (∩)**:
      - Returns tuples common to both relations.
   2. **Join (⨝)**:
      - Combines relations based on a condition:
        - **Theta Join**: Arbitrary condition.
        - **Equijoin**: Equality condition.
        - **Natural Join**: Matches tuples with the same attribute values.
   3. **Division (/ or ÷)**:
      - Finds tuples in one relation that match all tuples in another relation.

3. **Extended Operators**:

   1. **Aggregate Functions**:
      - Perform operations like `SUM`, `AVG`, `MIN`, `MAX`, and `COUNT`.
   2. **Outer Join**:
      - Retains unmatched tuples using `NULL` values:
        - Left Outer Join (⨝)
        - Right Outer Join (⨝)
        - Full Outer Join (⨝)

4. **Composition of Operations**:

   - Relational algebra operations can be combined to create complex queries.
   - Example:
     - `π(attribute)(σ(condition)(Relation1 × Relation2))` filters rows after a cross-product.

5. **Practical Use Cases**:

   - Example schemas:
     - **STUDENT**: Contains student details.
     - **RESERVE**: Tracks reservations by students.
     - **BOAT**: Describes boats and their details.
   - Relational algebra helps answer complex questions like:
     - “Which students reserved a specific boat on a given day?”

6. **Relational Calculus (Comparison)**:

   - **Relational Algebra**:
     - Procedural: Specifies how to retrieve data.
   - **Relational Calculus**:
     - Declarative: Specifies what data to retrieve.

7. **Summary**:
   - Relational algebra provides a robust foundation for relational query languages.
   - Efficient query execution depends on optimizing algebraic expressions.
   - Relational algebra and calculus are logically equivalent but differ in syntax and focus.

---
