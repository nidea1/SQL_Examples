# SQL Examples

I will implement functions, transactions, triggers, views, stored procedures and other Advanced SQL Topics in this repo.

Database [sample](https://github.com/microsoft/sql-server-samples/blob/master/samples/databases/northwind-pubs/instnwnd.sql) used for in this repo examples.

## What is SQL?

Structured Query Language (**SQL**) is programming language for storing and processing data in a relational database.

## Using DB Sample

```sql

-- Firstly create a new database
CREATE DATABASE ExampleDatabase
GO
-- After use new database for db sample
USE ExampleDatabase
GO

-- Now copy database sample here ↓

/*
** Copyright Microsoft, Inc. 1994 - 2000
** All Rights Reserved.
*/

-- This script does not create a database.
-- Run this script in the database you want the objects to be created.
-- Default schema is dbo.

SET NOCOUNT ON
GO

set quoted_identifier on
GO
.
.
.
```
