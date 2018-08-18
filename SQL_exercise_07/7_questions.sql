-- https://en.wikibooks.org/wiki/SQL_Exercises/Planet_Express 
-- 7.1 Who receieved a 1.5kg package?
    -- The result is "Al Gore's Head".
SELECT client.name
FROM client join package
ON client.accountNumber = package.recipient
WHERE package.weight = 1.5;


-- 7.2 What is the total weight of all the packages that he sent?
SELECT SUM(weight)
FROM client join package ON client.accountNumber = package.recipient AND client.name = 'Al Gore's Head';