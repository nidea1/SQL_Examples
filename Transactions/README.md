# Transactions

In SQL, a process (transaction) is that grouping one or more sql statements as one statemenet. Transactions ensure that statements are performed correctly and error management.

## 4 Features of Transactions (ACID)
- **Atomicity:** A transaction is completely successes or never successes. If there is a error in any transaction, transaction is not completed and all changes in the database are rolled back.
- **Consistency:** Each transaction is moves the database from one consistent state to another. So a transaction complies with rules of the database before and after.
- **Isolation:** Concurrent processes are isolated from each other. The results of a transaction are not visible to other transactions until the transaction is complete.
- **Durability:** After a transaction is completed, the results of the transaction are permanent and are not lost even in the event of a system failure.

![img1](https://f4n3x6c5.stackpathcdn.com/UploadFile/f0b2ed/transaction-management-in-sql/Images/Transaction%20Control.jpg)
