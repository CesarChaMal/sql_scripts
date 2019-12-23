CREATE FUNCTION dbo.concatena (@numero varchar(10))
RETURNS varchar(5000) AS
BEGIN
    DECLARE @retvalue varchar(5000)
    SET @retvalue=''

    SELECT 
           @retvalue = @retvalue +LTRIM(RTRIM(ISNULL(NOMBRE,'')))+','
    FROM 
         (SELECT nombre FROM TABLA_ORIGEN AS s WHERE s.numero = @numero) AS tmp_tbl
RETURN SUBSTRING(@retvalue,1,LEN(@retvalue)-1)


DROP FUNCTION IF EXISTS sucursales;
CREATE FUNCTION sucursales(rfcToFind varchar(50))
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
     DECLARE retvalue VARCHAR(255);
     SET @retvalue = '';     
     
     IF rfcToFind IS NULL THEN
          SET rfcToFind = '';
     END IF;
     
     SELECT 
            @retvalue := CONCAT(@retvalue, IF( tmp_tbl.Descripcion IS NULL ,'',LTRIM(RTRIM(CAST(tmp_tbl.Descripcion AS CHAR)))),', ')
     FROM 
          (SELECT Descripcion FROM sucursales AS s WHERE s.rfc = rfc) as tmp_tbl
     
     RETURN @retvalue;
END

DROP PROCEDURE IF EXISTS sucursales;
CREATE PROCEDURE sucursales(id varchar(50),fieldToCompare varchar(50),fieldToShow varchar(50),tabla varchar(50),OUT salida varchar(500))
BEGIN
     DECLARE retvalue VARCHAR(255);
     SET @retvalue = '';     
     
     IF id IS NULL THEN
          SET id = '';
     END IF;

     SET @sql='';
     SET @sql = CONCAT(@sql,'SELECT @retvalue := CONCAT(@retvalue, IF( tmp_tbl.',CAST(fieldToShow AS char),' IS NULL ,\'\',LTRIM(RTRIM(CAST(tmp_tbl.',CAST(fieldToShow AS char),' AS CHAR)))),\', \') ',
     'FROM (SELECT ',CAST(fieldToShow AS char),' FROM ',CAST(tabla AS char),' AS s WHERE s.',CAST(fieldToCompare AS char),' = \'',CAST(id AS char),'\') as tmp_tbl');

--     SELECT @sql;
--     SELECT @retvalue;

     PREPARE s1 FROM @sql;
     EXECUTE s1;
     DEALLOCATE PREPARE s1;

     SELECT SUBSTRING( @retvalue, 1, CHAR_LENGTH( @retvalue )-2) AS sucursales;
     SET salida = SUBSTRING( @retvalue, 1, CHAR_LENGTH( @retvalue )-2);
END


/*
SET @rfc = 'FRE-050106-H11'; 
SET @rfc = ''; 
SET @rfc = NULL; 

SELECT sucursales(@rfc)

SELECT 
       sucursales(@rfc) AS sucursales,restaurantes.* 
FROM 
     restaurantes
*/

SET @idToFind = 'FRE-050106-H11'; 
SET @idToFind = 'JIZG-850923-DG9'; 

SET @fieldToCompare = 'rfc'; 
SET @fieldToShow = 'Descripcion'; 

SET @tabla = 'regiones'; 
SET @tabla = 'zonas'; 
SET @tabla = 'sucursales'; 

SET @salida = ''; 


SET @idToFind = '29'; 
SET @fieldToCompare = 'numsucursalglobal'; 
SET @fieldToShow = 'idmes'; 
SET @tabla = 'detallerentaspersonalizado'; 


CALL sucursales(@idToFind,@fieldToCompare,@fieldToShow,@tabla,@salida);

SELECT @salida AS sucursales; 

SET @rfc = 'FRE-050106-H11'; 
SET @retvalue = ''

SELECT 
    @retvalue := CONCAT(@retvalue, IF( tmp_tbl.Descripcion IS NULL ,'',LTRIM(RTRIM(CAST(tmp_tbl.Descripcion AS CHAR)))),', ')
FROM 
  (SELECT Descripcion FROM sucursales AS s WHERE s.rfc = @rfc) as tmp_tbl


SELECT 
       SUBSTRING(x.resultado, 1, CHAR_LENGTH( x.resultado )-2) AS sucursales 
FROM 
       (SELECT 
            @retvalue := CONCAT(@retvalue, IF( tmp_tbl.Descripcion IS NULL ,'',LTRIM(RTRIM(CAST(tmp_tbl.Descripcion AS CHAR)))),', ') AS resultado
        FROM 
          (SELECT Descripcion FROM sucursales AS s WHERE s.rfc = 'JIZG-850923-DG9') as tmp_tbl
        ) AS x  
ORDER BY
      x.resultado DESC LIMIT 1	