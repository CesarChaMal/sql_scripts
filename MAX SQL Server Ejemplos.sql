/*
select * into ##student from (
			select 1 as id, 'John Deo' as name, 'Four' as class, 75 as mark
			union all
			select 2 as id, 'Max Ruin' as name, 'Three' as class, 85 as mark
			union all
			select 3 as id, 'Arnold' as name, 'Three' as class, 55 as mark
			union all
			select 4 as id, 'Krish Star' as name, 'Four' as class, 60 as mark
			union all
			select 5 as id, 'John Mike' as name, 'Four' as class, 60 as mark
			union all
			select 6 as id, 'Alex John' as name, 'Four' as class, 55 as mark
		  ) a;
*/
-- drop table ##student;

select a.id, a.name, a.class, a.mark from ##student a;


SELECT 
	MAX(mark) 
FROM 
	##student;

SELECT 
	MAX(mark) as max_mark 
FROM 
	##student;

-- mal
/*
SELECT 
	id,name,class,MAX(mark) as max_mark 
FROM 
	##student
*/

SELECT 
	* 
FROM 
	##student 
WHERE 
	mark = (select MAX(mark) from ##student);

SELECT 
	class, MAX( mark ) as max_mark 
FROM 
	##student 
GROUP BY 
	class;

SELECT 
	MAX(mark) as maximu_mark, class 
FROM 
	##student 
WHERE 
	class ='Four' 
GROUP BY 
	class; 
