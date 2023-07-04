-- Problem: Placements -> https://www.hackerrank.com/challenges/placements/problem?isFullScreen=false

-- You are given three tables: Students, Friends and Packages. Students contains two columns: ID and Name. Friends contains two columns: ID and Friend_ID (ID of the ONLY best friend). Packages contains two columns: ID and Salary (offered salary in $ thousands per month).
-- Write a query to output the names of those students whose best friends got offered a higher salary than them. Names must be ordered by the salary amount offered to the best friends. It is guaranteed that no two students got same salary offer.

-- Explanation

-- Samantha's best friend got offered a higher salary than her at 11.55
-- Julia's best friend got offered a higher salary than her at 12.12
-- Scarlet's best friend got offered a higher salary than her at 15.2
-- Ashley's best friend did NOT get offered a higher salary than her

-- The name output, when ordered by the salary offered to their friends, will be:
-- Samantha
-- Julia
-- Scarlet

-- My Solution

SELECT Students.Name
FROM ((Students
    INNER JOIN Friends ON Students.ID = Friends.ID)
    INNER JOIN Packages as Friend_Packages ON Friend_Packages.ID = Friends.Friend_ID)
WHERE Friend_Packages.Salary > (
    SELECT Student_Packages.Salary
    FROM Packages as Student_Packages
    WHERE Student_Packages.ID = Students.ID
)
ORDER BY Friend_Packages.Salary;


-- Problem: Symmetric Pairs -> https://www.hackerrank.com/challenges/symmetric-pairs/problem?isFullScreen=false

-- You are given a table, Functions, containing two columns: X and Y.
-- Two pairs (X1, Y1) and (X2, Y2) are said to be symmetric pairs if X1 = Y2 and X2 = Y1.
-- Write a query to output all such symmetric pairs in ascending order by the value of X. List the rows such that X1 ≤ Y1.

-- My Solution

SELECT f1.X, f1.Y
FROM Functions as f1
INNER JOIN Functions as f2
ON f1.X = f2.Y and f2.X = f1.Y
GROUP BY f1.X, f1.Y
HAVING COUNT(f1.X) > 1 or f1.X < f1.Y
ORDER BY f1.X;
