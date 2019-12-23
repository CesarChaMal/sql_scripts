
SELECT  hab.idhabitacion,hab.idtipohabitacion, 
    IF(fh.adulto=1,'SGL',IF(fh.adulto=2,'DBL',IF(fh.adulto=3,'TPL',IF(fh.adulto=4,'CUA',IF(fh.adulto=5,'QUI',IF(fh.adulto=6,'SEX','7 +')))))) AS ocupacion, 
    CONCAT(hu.nombres,' ',hu.apellidopaterno,' ',hu.apellidomaterno,'            ',IF(mv.precio=0,'** Cortesía **','')) AS huesped, 
	mv.precio AS tarifa,fh.idfoliohuespedes,'OCU' AS estatus,fh.adulto,fh.niños 
    FROM habitaciones AS hab INNER JOIN habitacionesasignadas AS ha ON ha.idhabitacion=hab.idhabitacion 
    INNER JOIN foliohuespedes AS fh ON fh.idfoliohuespedes=ha.idfoliohuespedes 
    INNER JOIN huespedes AS hu ON hu.idhuesped=fh.idhuesped  
    INNER JOIN movtoshotel AS mv ON mv.idfoliohuespedes=fh.idfoliohuespedes AND mv.idhabitacion=hab.idhabitacion 
    WHERE hab.idtipohabitacion!='EXTRA' AND ha.status=1 AND (mv.idcuentacontable='RTA' OR mv.idcuentacontable='CONVE') AND mv.estatus=1 
    AND (hab.statuslimpieza=1 OR hab.statuslimpieza=2) 
	UNION 
	SELECT hab.idhabitacion,hab.idtipohabitacion,' ','** VACIO **',0,0,'LIBRE',0,0 FROM habitaciones AS hab 
    WHERE statusocupacion=1 AND hab.idtipohabitacion!='EXTRA' 
	AND (hab.statuslimpieza=1 OR hab.statuslimpieza=2) 
	UNION 
	SELECT hab.idhabitacion,hab.idtipohabitacion,' ','** BLOQUEADA **',0,0,'BLOQ',0,0 FROM habitaciones AS hab 
    WHERE hab.statuslimpieza=3 AND hab.idtipohabitacion!='EXTRA' 
	GROUP BY hab.idhabitacion ORDER BY idhabitacion
-- AMA DE LLAVES	
SELECT  hab.idhabitacion,hab.idtipohabitacion, 
    fh.idfoliohuespedes,fh.adulto,fh.niños, 
	hab.statusocupacion,hab.statuslimpieza,fh.checkin,fh.checkout,'O' AS stfdesk,IF (statuslimpieza=1,'OL','OS') AS stama
	FROM habitaciones AS hab INNER JOIN habitacionesasignadas AS ha ON ha.idhabitacion=hab.idhabitacion 
	INNER JOIN foliohuespedes AS fh ON fh.idfoliohuespedes=ha.idfoliohuespedes 
	INNER JOIN huespedes AS hu ON hu.idhuesped=fh.idhuesped  
	INNER JOIN movtoshotel AS mv ON mv.idfoliohuespedes=fh.idfoliohuespedes AND mv.idhabitacion=hab.idhabitacion 
	WHERE hab.idtipohabitacion!='EXTRA' AND ha.status=1 AND (mv.idcuentacontable='RTA' OR mv.idcuentacontable='CONVE') AND mv.estatus=1 
	AND (hab.statuslimpieza=1 OR hab.statuslimpieza=2) 
	UNION 
	SELECT hab.idhabitacion,hab.idtipohabitacion,0,0,0,hab.statusocupacion,hab.statuslimpieza,null,null,'V' AS stfdesk,IF(statuslimpieza=1,'VL','VS') AS stama
    FROM habitaciones AS hab 
	WHERE statusocupacion=1 AND hab.idtipohabitacion!='EXTRA' 
	AND (hab.statuslimpieza=1 OR hab.statuslimpieza=2) 
	UNION 
	SELECT hab.idhabitacion,hab.idtipohabitacion,0,0,0,hab.statusocupacion,hab.statuslimpieza,null,null,'FS' AS stfdesk,'FS' AS stama
    FROM habitaciones AS hab 
	WHERE hab.statuslimpieza=3 AND hab.idtipohabitacion!='EXTRA' 
	GROUP BY hab.idhabitacion ORDER BY idhabitacion
	
SET @hab='101'
SET @retvalue=''

SELECT * FROM 

(SELECT 
    @retvalue := CONCAT(@retvalue, IF( tmp_tbl.idcaracthab IS NULL ,'',LTRIM(RTRIM(CAST(tmp_tbl.idcaracthab AS CHAR)))),', ') AS chupala
FROM 
  (SELECT idcaracthab FROM tipohabitaciondetalle AS s WHERE s.idhabitacion = @hab) as tmp_tbl	) AS x  ORDER BY x.chupala DESC LIMIT 1
	

-- BUENOTE
SELECT 
       SUBSTRING(x.chupala, 1, CHAR_LENGTH( x.chupala )-2) AS servicios
FROM 
     (SELECT 
             @retvalue := CONCAT(@retvalue, IF( tmp_tbl.descripcion IS NULL ,'',LTRIM(RTRIM(CAST(tmp_tbl.descripcion AS CHAR)))),', ') AS chupala
      FROM 
          (SELECT ch.descripcion 
                  FROM habitaciones AS h 
          INNER JOIN 
                tipohabitaciondetalle AS td ON td.idhabitacion=h.idhabitacion
          INNER JOIN 
                caracteristicashabitacion AS ch ON ch.idcaracthab=td.idcaracthab 
          WHERE 
                h.idhabitacion = @hab) as tmp_tbl	
     ) AS x  
ORDER 
      BY x.chupala DESC LIMIT 1	
	
SELECT  
        hab.idhabitacion,hab.idtipohabitacion,
        (SELECT 
               SUBSTRING(x.chupala, 1, CHAR_LENGTH( x.chupala )-2) AS servicios
        FROM 
             (SELECT 
                     @retvalue := CONCAT(@retvalue, IF( tmp_tbl.descripcion IS NULL ,'',LTRIM(RTRIM(CAST(tmp_tbl.descripcion AS CHAR)))),', ') AS chupala
              FROM 
                  (SELECT ch.descripcion 
                          FROM habitaciones AS h 
                  INNER JOIN 
                        tipohabitaciondetalle AS td ON td.idhabitacion=h.idhabitacion
                  INNER JOIN 
                        caracteristicashabitacion AS ch ON ch.idcaracthab=td.idcaracthab 
                  WHERE 
                        h.idhabitacion = @hab) as tmp_tbl	
             ) AS x  
        ORDER 
              BY x.chupala DESC LIMIT 1	
     	) AS g   ,
        fh.idfoliohuespedes,fh.adulto,fh.niños,hab.statusocupacion,hab.statuslimpieza,fh.checkin,fh.checkout,'O' AS stfdesk,IF (statuslimpieza=1,'OL','OS') AS stama
FROM 
     habitaciones AS hab 
INNER JOIN habitacionesasignadas AS ha 
      ON ha.idhabitacion=hab.idhabitacion 
INNER JOIN foliohuespedes AS fh 
      ON fh.idfoliohuespedes=ha.idfoliohuespedes 
INNER JOIN huespedes AS hu 
      ON hu.idhuesped=fh.idhuesped  
INNER JOIN movtoshotel AS mv 
      ON mv.idfoliohuespedes=fh.idfoliohuespedes AND mv.idhabitacion=hab.idhabitacion 
WHERE 
      hab.idtipohabitacion!='EXTRA' AND 
      ha.status=1 AND 
      (mv.idcuentacontable='RTA' OR mv.idcuentacontable='CONVE') AND 
      mv.estatus=1 AND 
      (hab.statuslimpieza=1 OR hab.statuslimpieza=2) 	



SET @hab='101'
SET @hab='109'
SET @hab='110'
SET @retvalue=''
SET @hab=''

SELECT  
        @hab:= hb.idhabitacion AS idhabitacion,hb.idtipohabitacion,
        (SELECT 
--               @hab:= ha.idhabitacion AS idhabitacion -- ,
               ha.idhabitacion AS idhabitacion -- ,
 --             SUBSTRING(ha.result, 1, CHAR_LENGTH( ha.result )-2) AS servicios
         FROM 
             (SELECT 
--                  @hab:= h.idhabitacion AS idhabitacion,
                  h.idhabitacion AS idhabitacion,
                  @retvalue := CONCAT(@retvalue, IF( h.descripcion IS NULL ,'',LTRIM(RTRIM(CAST(h.descripcion AS CHAR)))),', ') AS result
              FROM 
                  (SELECT hab.idhabitacion,ch.descripcion
                          FROM habitaciones AS hab 
                   INNER JOIN 
                        tipohabitaciondetalle AS td ON td.idhabitacion=hab.idhabitacion
                   INNER JOIN 
                        caracteristicashabitacion AS ch ON ch.idcaracthab=td.idcaracthab 
                   WHERE 
                        hab.idhabitacion = @hab
                   ) AS h
--                        hab.idhabitacion = h.idhabitacion) as h
             ) AS ha  
         WHERE 
               ha.idhabitacion = hb.idhabitacion 
        ORDER 
              BY ha.result DESC LIMIT 1	
     	) AS servicios ,
        fh.idfoliohuespedes,fh.adulto,fh.niños, 
	    hb.statusocupacion,hb.statuslimpieza,fh.checkin,fh.checkout,'O' AS stfdesk,IF (statuslimpieza=1,'OL','OS') AS stama
FROM 
      habitaciones AS hb
INNER JOIN habitacionesasignadas AS ha 
      ON ha.idhabitacion=hb.idhabitacion 
INNER JOIN foliohuespedes AS fh 
      ON fh.idfoliohuespedes=ha.idfoliohuespedes 
INNER JOIN huespedes AS hu 
      ON hu.idhuesped=fh.idhuesped  
INNER JOIN movtoshotel AS mv 
      ON mv.idfoliohuespedes=fh.idfoliohuespedes AND mv.idhabitacion=hb.idhabitacion 
WHERE 
      hb.idtipohabitacion!='EXTRA' AND 
      ha.status=1 AND 
      (mv.idcuentacontable='RTA' OR mv.idcuentacontable='CONVE') AND 
      mv.estatus=1 AND 
      (hb.statuslimpieza=1 OR hb.statuslimpieza=2) 	



SELECT  
        @hab:= hab.idhabitacion,
--        (SELECT idcaracthab FROM tipohabitaciondetalle AS d WHERE d.idhabitacion = '101') AS jalada
--        (SELECT idcaracthab FROM tipohabitaciondetalle AS d WHERE d.idhabitacion = hab.idhabitacion) AS jalada
--        (SELECT idcaracthab FROM tipohabitaciondetalle AS d WHERE d.idhabitacion = @hab) AS jalada

--        (SELECT idcaracthab FROM tipohabitaciondetalle AS d WHERE d.idhabitacion = '101' GROUP BY d.idhabitacion) AS jalada
--        (SELECT idcaracthab FROM tipohabitaciondetalle AS d WHERE d.idhabitacion = hab.idhabitacion GROUP BY d.idhabitacion) AS jalada
        (SELECT idcaracthab FROM tipohabitaciondetalle AS d WHERE d.idhabitacion = @hab GROUP BY d.idhabitacion) AS jalada
FROM 
     habitaciones AS hab


/*
SELECT  
        *,
        (SELECT ch.descripcion 
                FROM habitaciones AS h 
         INNER JOIN 
              tipohabitaciondetalle AS td ON td.idhabitacion=h.idhabitacion
         INNER JOIN 
              caracteristicashabitacion AS ch ON ch.idcaracthab=td.idcaracthab 
         WHERE 
              h.idhabitacion = hab.idhabitacion
         ORDER BY 
              h.idhabitacion DESC LIMIT 1	
        ) AS g
FROM 
     habitaciones AS hab 
*/


DROP TABLE IF EXISTS table1;
CREATE TEMPORARY TABLE table1 (column1 TINYINT,column2 TINYINT,column3 TINYINT);
INSERT INTO table1 (column1,column2,column3) VALUES (1,2,3);
INSERT INTO table1 (column1,column2,column3) VALUES (4,5,6);

DROP TABLE IF EXISTS table2;
CREATE TEMPORARY TABLE table2 (column1 TINYINT,column2 TINYINT,column3 TINYINT);
INSERT INTO table2 (column1,column2,column3) VALUES (1,2,3);
INSERT INTO table2 (column1,column2,column3) VALUES (2,2,3);
INSERT INTO table2 (column1,column2,column3) VALUES (3,2,3);
INSERT INTO table2 (column1,column2,column3) VALUES (4,2,3);
INSERT INTO table2 (column1,column2,column3) VALUES (5,2,3);

DROP TABLE IF EXISTS table3;
CREATE TEMPORARY TABLE table3 (column1 TINYINT,column2 TINYINT,column3 TINYINT);
INSERT INTO table3 (column1,column2,column3) VALUES (1,2,3);
INSERT INTO table3 (column1,column2,column3) VALUES (2,2,3);
INSERT INTO table3 (column1,column2,column3) VALUES (3,2,3);

SELECT 
       (
        SELECT
              SUM(column1)
        FROM
            table1
        )
FROM 
     table2;

    
SELECT 
     *
FROM
     table1
WHERE
     column1 = (
                SELECT
                     column1
                FROM
                     table2
                WHERE
                     table1.column1 = table2.column1
                )    


SELECT 
       column1 
FROM 
     table1 AS x
WHERE 
      x.column1 IN (SELECT 
                          column1 
                    FROM 
                          table2 AS x
                    WHERE 
                          x.column1 IN (SELECT 
                                              column1 
                                       FROM 
                                            table3
                                       WHERE 
                                             x.column1 = table3.column1
                                      )
                   );
                  
SELECT 
       *
FROM 
     (
      SELECT 
             column1 
      FROM 
           table1 AS x
      WHERE 
          x.column1 NOT IN 
                  (
                   SELECT 
                          column1 
                   FROM 
                          table2 AS x
                   WHERE 
                          x.column1 NOT IN 
                                      (SELECT 
                                              column1 
                                        FROM 
                                            table3
                                        WHERE 
                                             x.column1 = table3.column1
                                      )
                  )
     ) AS x,
   table1 AS x2
                  
                 
SELECT 
       column1
FROM 
       table1
WHERE 
       column1 IN
       (
        SELECT
              column1 
        FROM
              table2
       )

        
SELECT 
       column1
FROM 
       table1
WHERE 
       EXISTS
       (
        SELECT
              column1 
        FROM
              table2
       )

        
SELECT 
       column1
FROM 
       table1
WHERE 
       column1 NOT IN
       (
        SELECT
              column1 
        FROM
              table2
       )

        
SELECT 
       column1
FROM 
       table1
WHERE 
       NOT EXISTS
       (
        SELECT
              column1 
        FROM
              table2
       )

SELECT
      t.column1 
FROM
      (
       SELECT
             column1
       FROM
           table2
      ) AS t

SELECT 
       * 
FROM 
     table1 
WHERE 
      (1, 2) IN (
                 SELECT 
                        column1, column2  
                 FROM 
                        table2
                );
               
 SELECT 
        * 
 FROM 
      table1 
 WHERE 
       ROW(1, 2) IN (
                    SELECT 
                           column1, column2 
                    FROM 
                         table2
                   );

SELECT
      column1,
      column2, 
      column3
 FROM
      table1
 WHERE
      (column1, column2, column3)
 IN
      (
       SELECT
            column1,
            column2,
            column3
       FROM
            table2
      )

SELECT
      table1.column1,
      table1.column2,
      table1.column3
 FROM
      table1,
      table2 
 WHERE
      table1.column1 = table2.column1
 AND
      table1.column2 = table2.column2
 AND
      table1.column3 = table2.column3
      
-- Query comun No optimizado      
SELECT  
        hab.idhabitacion,hab.idtipohabitacion, 
        IF(fh.adulto=1,'SGL',IF(fh.adulto=2,'DBL',IF(fh.adulto=3,'TPL',IF(fh.adulto=4,'CUA',IF(fh.adulto=5,'QUI',IF(fh.adulto=6,'SEX','7 +')))))) AS ocupacion, 
        CONCAT(hu.nombres,' ',hu.apellidopaterno,' ',hu.apellidomaterno,'            ',IF(mv.precio=0,'** Cortesía **','')) AS huesped, 
	    mv.precio AS tarifa,
        fh.idfoliohuespedes,'OCU' AS estatus,fh.adulto,fh.niños 
FROM 
      habitaciones AS hab 
      INNER JOIN 
            habitacionesasignadas AS ha 
      ON 
         ha.idhabitacion=hab.idhabitacion 
      INNER JOIN 
            foliohuespedes AS fh 
      ON 
         fh.idfoliohuespedes=ha.idfoliohuespedes 
      INNER JOIN 
            huespedes AS hu 
      ON 
         hu.idhuesped=fh.idhuesped  
      INNER JOIN 
            movtoshotel AS mv 
      ON 
         mv.idfoliohuespedes=fh.idfoliohuespedes AND mv.idhabitacion=hab.idhabitacion 
      WHERE 
            hab.idtipohabitacion!='EXTRA' AND ha.status=1 
            AND (mv.idcuentacontable='RTA' OR mv.idcuentacontable='CONVE') AND mv.estatus=1 
            AND (hab.statuslimpieza=1 OR hab.statuslimpieza=2) 
UNION 
      SELECT 
             hab.idhabitacion,hab.idtipohabitacion,' ','** VACIO **',0,0,'LIBRE',0,0 
      FROM 
           habitaciones AS hab 
      WHERE 
            statusocupacion=1 AND hab.idtipohabitacion!='EXTRA' 
	        AND (hab.statuslimpieza=1 OR hab.statuslimpieza=2) 
UNION 
      SELECT 
             hab.idhabitacion,hab.idtipohabitacion,' ','** BLOQUEADA **',0,0,'BLOQ',0,0 
      FROM 
           habitaciones AS hab 
      WHERE 
            hab.statuslimpieza=3 AND hab.idtipohabitacion!='EXTRA' 
      GROUP BY 
            hab.idhabitacion 
      ORDER BY 
            idhabitacion


-- Query Optimizado
SELECT
      hab.idhabitacion,hab.idtipohabitacion, 
      IF(fh.adulto=1,'SGL',IF(fh.adulto=2,'DBL',IF(fh.adulto=3,'TPL',IF(fh.adulto=4,'CUA',IF(fh.adulto=5,'QUI',IF(fh.adulto=6,'SEX','7 +')))))) AS ocupacion, 
      CONCAT(hu.nombres,' ',hu.apellidopaterno,' ',hu.apellidomaterno,'            ',IF(mv.precio=0,'** Cortesía **','')) AS huesped, 
      mv.precio AS tarifa,
      fh.idfoliohuespedes,'OCU' AS estatus,fh.adulto,fh.niños 
FROM 
    (SELECT  hab.idhabitacion,hab.idtipohabitacion
    FROM 
             habitaciones AS hab 
    WHERE hab.idtipohabitacion!='EXTRA' AND
        (hab.statuslimpieza=1 OR hab.statuslimpieza=2)) hab
    
    INNER JOIN 
    
    (SELECT  *
     FROM 
             habitacionesasignadas  AS ha 
     WHERE ha.status=1) ha
    
    ON 
       ha.idhabitacion=hab.idhabitacion 
    
    INNER JOIN 
    
    (SELECT
          * 
    FROM 
         foliohuespedes AS fh) fh
    
    ON 
       fh.idfoliohuespedes=ha.idfoliohuespedes 
    
    INNER JOIN 
    
    (SELECT
          * 
    FROM 
         huespedes AS hu) hu
    ON 
       hu.idhuesped=fh.idhuesped  

    INNER JOIN 
    
    (SELECT  
    	idhabitacion,idfoliohuespedes,mv.precio
    FROM 
        movtoshotel AS mv 
    WHERE
         (mv.idcuentacontable='RTA' OR mv.idcuentacontable='CONVE') AND mv.estatus=1) AS mv
    
    ON 
       mv.idfoliohuespedes=fh.idfoliohuespedes AND mv.idhabitacion=hab.idhabitacion
UNION 
      SELECT 
             hab.idhabitacion,hab.idtipohabitacion,' ','** VACIO **',0,0,'LIBRE',0,0 
      FROM 
           habitaciones AS hab 
      WHERE 
            statusocupacion=1 AND hab.idtipohabitacion!='EXTRA' 
	        AND (hab.statuslimpieza=1 OR hab.statuslimpieza=2) 
UNION 
      SELECT 
             hab.idhabitacion,hab.idtipohabitacion,' ','** BLOQUEADA **',0,0,'BLOQ',0,0 
      FROM 
           habitaciones AS hab 
      WHERE 
            hab.statuslimpieza=3 AND hab.idtipohabitacion!='EXTRA' 
      GROUP BY 
            hab.idhabitacion 
      ORDER BY 
            idhabitacion
    
       

 
