select 
       m.idminuta, m.foliominuta,m.temaminuta,d.descripcion,m.fechaminuta,m.horainiciominuta,horafinminuta,
       concat(ne.nombre,' ',ne.paterno) as ejecutivo
from 
     national_minutas as m 
inner join 
      national_departamentos as d on m.iddepartamento=d.iddepartamento 
inner join 
      national_ejecutivos as ne on m.idejecutivo=ne.idejecutivo 
      

select descripcion from national_minutaobjetivos where idminuta = 4
      
SET @idminuta = '4'; 
SET @retvalue = ''
SELECT @retvalue

SET @idminuta = '4'; 
SELECT @idminuta:='11'
SELECT @idminuta


SELECT 
       x.resultado AS registro 
FROM 
       (SELECT 
            @retvalue := CONCAT(@retvalue,tmp_tbl.descripcion) AS resultado
        FROM 
          (SELECT descripcion FROM national_minutaobjetivos AS s WHERE s.idminuta = @idminuta) as tmp_tbl
        ) AS x  
ORDER BY
      x.resultado DESC LIMIT 1	
      
      
      
SELECT
       @idminuta:= m.idminuta as idminuta, m.foliominuta,m.temaminuta,d.descripcion,m.fechaminuta,m.horainiciominuta,horafinminuta,
       CONCAT(ne.nombre,' ',ne.paterno) as ejecutivo
--       ,(SELECT @idminuta FROM national_minutaobjetivos AS s WHERE s.idminuta = @idminuta LIMIT 1)
--       ,(SELECT descripcion FROM national_minutaobjetivos AS s WHERE s.idminuta = @idminuta LIMIT 1)
       
       ,(
         SELECT @idminuta:= m.idminuta
         FROM
         (SELECT descripcion,@idminuta as idminutav FROM national_minutaobjetivos AS s WHERE s.idminuta = @idminuta) as x
         LIMIT 1
       )

/*       
        ,(       
        SELECT 
               x.resultado AS registro 
        FROM 
               (SELECT 
                    @retvalue := CONCAT(@retvalue,tmp_tbl.descripcion) AS resultado
                FROM 
                  (SELECT descripcion FROM national_minutaobjetivos AS s WHERE s.idminuta = @idminuta) as tmp_tbl
                ) AS x  
        ORDER BY
              x.resultado DESC LIMIT 1	
        ) as temp
*/
from 
     national_minutas as m 
inner join 
      national_departamentos as d on m.iddepartamento=d.iddepartamento 
inner join 
      national_ejecutivos as ne on m.idejecutivo=ne.idejecutivo 
      