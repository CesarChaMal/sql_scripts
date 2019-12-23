/*
CREATE TABLE employee SELECT * FROM (
			select 1 as id, 'Marcos' as name, 6 as boss
			union all
			select 2 as id, 'Lucas' as name, 1 as boss
			union all
			select 3 as id, 'Ana' as name, 2 as boss
			union all
			select 4 as id, 'Eva' as name, 1 as boss
			union all
			select 5 as id, 'Juan' as name, 6 as boss
			union all
			select 6 as id, 'Antonio' as name, NULL as boss
) a;
*/

-- DROP TABLE employee;

SELECT 
       e.name, b.name 
FROM 
     employee e, employee b
WHERE 
      e.boss = b.id;      


SELECT 
       e.name, b.name 
FROM 
     employee e
LEFT OUTER JOIN
     employee b
ON
      e.boss = b.id;      

            
