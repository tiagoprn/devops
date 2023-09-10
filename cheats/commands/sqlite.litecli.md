# SQLite Database Cheatsheet for litecli

- Show all tables:
    ```SQL

    .tables

    ```

- List fields on table:
    ```SQL

    PRAGMA table_info('your_table_name');

    ```

- Show the DDL that can be used to recreate a table, including FOREIGN KEYS and INDEXES:
    ```SQL

    .schema 'your_table_name'

    ```

- See all indexes on a table:
    ```SQL

    PRAGMA index_list('your_table_name');

    ```

- Show PRIMARY KEYS on a table:
    ```SQL

    PRAGMA table_info('your_table_name');

    ```
    (Note: Look for the column where "pk" is set to 1)

- Show FOREIGN KEYS on a table:
    ```SQL

    PRAGMA foreign_key_list('your_table_name');

    ```

- Show UNIQUE constraints on table:
    (Note: UNIQUE constraints are typically visible in the DDL of the table itself)
    ```SQL

    .schema 'your_table_name'

    ```

- Create a new table with primary key, indexes, a UNIQUE clause for 2 columns, and foreign keys:
    ```SQL

    CREATE TABLE 'new_table_name' (
        'column1' DATA_TYPE PRIMARY KEY,
        'column2' DATA_TYPE,
        'column3' DATA_TYPE,
        ...,
        UNIQUE('column2', 'column3'),
        FOREIGN KEY ('column3') REFERENCES 'other_table'('columnX')
    );

    CREATE INDEX 'index_name' ON 'new_table_name'('column2');

    ```

- Create a new table with the same structure and data from an existing table:
    ```SQL

    CREATE TABLE 'copy_table_name' AS SELECT * FROM 'existing_table_name';

    ```

- Turn a field into the primary key of a table:

    - Step 1: Create a new table with the desired primary key structure:
        ```SQL

        CREATE TABLE 'temp_table_name' ('desired_pk_field' DATA_TYPE PRIMARY KEY, ...other columns...);

        ```

    - Step 2: Copy all the data from the old table to the new table:
        ```SQL

        INSERT INTO 'temp_table_name' SELECT * FROM 'your_table_name';

        ```

    - Step 3: Drop the old table:
        ```SQL

        DROP TABLE 'your_table_name';

        ```

    - Step 4: Rename the new table to the original table's name:
        ```SQL

        ALTER TABLE 'temp_table_name' RENAME TO 'your_table_name';

        ```

Replace placeholders with actual values. Always backup your database before making changes.

