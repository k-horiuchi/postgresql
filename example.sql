-- CREATE DATABASE
CREATE DATABASE example_db;

-- CREATE SCHEMA 
CREATE SCHEMA example_schema;

-- CREATE TABLE
CREATE TABLE IF NOT EXISTS example_schema.test
(
    id INTEGER,
    name VARCHAR(10) NOT NULL UNIQUE,
    PRIMARY KEY (id)
);

-- CREATE INDEX
CREATE INDEX example_index ON example_schema.test (name ASC);
SELECT * FROM name = 'test1';

-- CREATE VIEW
CREATE VIEW id_1_5 AS SELECT * FROM test WHERE id BETWEEN 1 AND 5;
INSERT INTO example_schema.test (id, name) VALUES ('1', 'test1');
INSERT INTO example_schema.test (id, name) VALUES ('2', 'test2');
INSERT INTO example_schema.test (id, name) VALUES ('3', 'test3');
INSERT INTO example_schema.test (id, name) VALUES ('4', 'test4');
INSERT INTO example_schema.test (id, name) VALUES ('5', 'test5');
INSERT INTO example_schema.test (id, name) VALUES ('6', 'test6');
SELECT * FROM id_1_5;

-- NOT NULL制約違反
INSERT INTO example_schema.test (id, name) VALUES ('1', null);
-- UNIQUE制約違反
INSERT INTO example_schema.test (id, name) VALUES ('1', 'test2');
-- PRIMARY KEY制約違反
INSERT INTO example_schema.test (id, name) VALUES ('1', 'test7');
-- 結果を確認
SELECT * FROM example_schema.test;

-- UPDATE文サンプル
UPDATE FROM example_schema.test SET id = 10 , name = '更新データ' WHERE id = 1;
-- DELETE文サンプル
DELETE FROM example_schema.test WHERE id = 2;
-- 結果を確認
SELECT * FROM example_schema.test;

-- TRUNCATE
TRUNCATE test;

-- ALTER
ALTER TABLE test RENAME TO test2;
ALTER TABLE test2 RENAME name TO name2;
ALTER TABLE test2 SET SCHEMA public;
ALTER TABLE test2 ADD new_row INTEGER;
ALTER TABLE test2 DROP new_row;

-- DROP
DROP INDEX IF EXISTS example_index;
DROP VIEW IF EXISTS id_1_5;
DROP TABLE IF EXISTS test2;
DROP SCHEMA IF EXISTS example_schema;
DROP DATABASE IF EXISTS example_db;


-- EXAMPLE1
SET TIME ZONE 'Asia/Tokyo';

CREATE TABLE IF NOT EXISTS contract_types
(
    id SERIAL,
    name VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    del_flg INTEGER DEFAULT 0 NOT NULL,
    PRIMARY KEY (id)
);
INSERT INTO contract_types (id, name) VALUES (1, 'フルタイム正社員');
INSERT INTO contract_types (id, name) VALUES (2, '短時間正社員');
INSERT INTO contract_types (id, name) VALUES (3, '非正規社員');
INSERT INTO contract_types (id, name) VALUES (4, '派遣労働者');
INSERT INTO contract_types (id, name) VALUES (5, '契約社員');
INSERT INTO contract_types (id, name) VALUES (6, 'パートタイム労働者');

CREATE TABLE IF NOT EXISTS genders
(
    id SERIAL,
    name VARCHAR(10) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    del_flg INTEGER DEFAULT 0 NOT NULL,
    PRIMARY KEY (id)
);
INSERT INTO genders (id, name) VALUES (1, '女性');
INSERT INTO genders (id, name) VALUES (2, '男性');
INSERT INTO genders (id, name) VALUES (3, 'その他');

CREATE TABLE IF NOT EXISTS employees
(
    id SERIAL,
    name VARCHAR(10) NOT NULL,
    age INTEGER NOT NULL,
    gender INTEGER NOT NULL,
    birth_date TIMESTAMP NOT NULL,
    address VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    hire_date TIMESTAMP default CURRENT_TIMESTAMP NOT NULL,
    contract_type INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP NOT NULL,
    del_flg INTEGER DEFAULT 0 NOT NULL,
    PRIMARY KEY (id),
    FOREIGN KEY (gender)
        REFERENCES genders(id),
    FOREIGN KEY (contract_type)
        REFERENCES contract_types(id)
);
INSERT INTO employees (name, age, gender, birth_date, address, email, hire_date, contract_type) VALUES ('正社員社畜太郎', 25, 1, '1995-11-11 21:00:00.000000', '東京都千代田区千代田１−１', 'hoge@gmail.com', '2020-04-01 00:00:00.000000', 1);
INSERT INTO employees (name, age, gender, birth_date, address, email, hire_date, contract_type) VALUES ('非正規社畜次郎', 35, 2, '1985-07-06 15:00:00.000000', '東京都墨田区押上１丁目１−２', 'huga@gmail.com', '2015-06-01 00:00:00.000000', 3);
INSERT INTO employees (name, age, gender, birth_date, address, email, hire_date, contract_type) VALUES ('アルバイト酒太郎', 18, 3, '2003-03-06 05:00:00.000000', '千葉県浦安市舞浜１−１', 'foo@gmail.com', '2021-01-01 00:00:00.000000', 6);
INSERT INTO employees (name, age, gender, birth_date, address, email, hire_date, contract_type) VALUES ('退職し太郎', 55, 1, '1966-02-15 09:00:00.000000', '東京都千代田区千代田１−１', 'bar@gmail.com', '2010-12-31 00:00:00.000000', 1);

-- ANSWER1
SELECT 
    employees.name AS 名前,
    age || '歳' AS 年齢,
    genders.name AS 性別,
    TO_CHAR(birth_date, 'YYYY/MM/DD') AS 誕生日,
    address AS 住所,
    email AS メールアドレス,
    contract_types.name AS 雇用形態
FROM employees
LEFT OUTER JOIN genders
    ON employees.gender = genders.id
LEFT OUTER JOIN contract_types
    ON employees.contract_type = contract_types.id;

-- ANSWER2
SELECT name AS 名前 FROM employees WHERE age < 30;

-- ANSWER3
SELECT name AS 名前 FROM employees WHERE hire_date BETWEEN '2015-01-01'::TIMESTAMP AND '2020-12-31'::TIMESTAMP;


