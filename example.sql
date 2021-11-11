-- CREATE DATABASE
CREATE DATABASE example_db;

-- CREATE SCHEMA 
CREATE SCHEMA example_schema;

-- CREATE TABLE
CREATE TABLE IF NOT EXISTS example_schema.test
(
    id integer,
    name varchar(10) NOT NULL UNIQUE,
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