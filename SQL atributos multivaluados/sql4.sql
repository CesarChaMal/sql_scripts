-- SELECT r.red_social_nombre FROM red_social r JOIN usuario_item_red_social ur ON r.red_social_id=ur.red_social_id WHERE ur.usuario_item_id = 2

/*
SELECT
    @retvalue := CONCAT(@retvalue, tmp_tbl.red_social_nombre, ', ') AS resultado
FROM
  (SELECT r.red_social_nombre FROM red_social r JOIN usuario_item_red_social ur ON r.red_social_id=ur.red_social_id WHERE ur.usuario_item_id = 2) as tmp_tbl

*/


/*
SELECT
       SUBSTRING(x.resultado, 1, CHAR_LENGTH( x.resultado )-2) AS redes_sociales
FROM
(


SELECT
    @retvalue := CONCAT(@retvalue, tmp_tbl.red_social_nombre, ', ') AS resultado
FROM
  (SELECT r.red_social_nombre FROM red_social r JOIN usuario_item_red_social ur ON r.red_social_id=ur.red_social_id WHERE ur.usuario_item_id = 2) as tmp_tbl

) AS x
ORDER BY
      x.resultado DESC LIMIT 1;
*/

SET @usuario_item_id = '2';
SET @retvalue = '';

/*

SELECT
  ui.*,
  redes.redes_sociales
FROM
  usuario_item ui,
(

SELECT
       SUBSTRING(x.resultado, 1, CHAR_LENGTH( x.resultado )-2) AS redes_sociales
FROM
(


SELECT
    @retvalue := CONCAT(@retvalue, tmp_tbl.red_social_nombre, ', ') AS resultado
FROM
  (SELECT r.red_social_nombre FROM red_social r JOIN usuario_item_red_social ur ON r.red_social_id=ur.red_social_id WHERE ur.usuario_item_id = @usuario_item_id) as tmp_tbl

) AS x
ORDER BY
      x.resultado DESC LIMIT 1

) as redes

WHERE
  ui.usuario_item_id = @usuario_item_id


*/



SET @usuario = '1';
SET @retvalue = '';


/*
SELECT
                        red_social.red_social_nombre,
                        lista.lista_id,
                        lista_usuario_item.lista_usuario_item_id,
                        lista_usuario_item.usuario_item_id,
                        item.item_id,
                        item.item_nombre,
                        item.item_marca,
                        item.item_comentario,
                        usuario_item.usuario_id,
                        usuario_item.usuario_item_comentario,
                        lista_usuario_item.lista_usuario_item_comentario,
                        usuario_item.usuario_item_publico
                    FROM
                        lista_usuario_item
                    JOIN
                        usuario_lista
                    ON
                        usuario_lista.lista_id=lista_usuario_item.lista_id
                    JOIN
                        lista
                    ON
                        usuario_lista.lista_id=lista.lista_id
                    JOIN
                        usuario_item
                    ON
                        lista_usuario_item.usuario_item_id=usuario_item.usuario_item_id
                    JOIN
                        item
                    ON
                        usuario_item.item_id=item.item_id
                    JOIN
                        usuario_item_red_social
                    ON
                      usuario_item.usuario_item_id=usuario_item_red_social.usuario_item_id
                    JOIN
                        red_social
                    ON
                      red_social.red_social_id=usuario_item_red_social.red_social_id
                    WHERE
                        lista_usuario_item.lista_usuario_item_status <>'I'
                        AND usuario_lista.usuario_id=@usuario
                        AND usuario_lista.usuario_lista_status<>'I'

*/


/*
//no funciono
SELECT
                        lista.lista_id,
                        lista_usuario_item.lista_usuario_item_id,
                        lista_usuario_item.usuario_item_id,
                        item.item_id,
                        item.item_nombre,
                        item.item_marca,
                        item.item_comentario,
                        usuario_item.usuario_id,
                        usuario_item.usuario_item_comentario,
                        lista_usuario_item.lista_usuario_item_comentario,
                        usuario_item.usuario_item_publico,
                        redes.redes_sociales
                    FROM
                        lista_usuario_item
                    JOIN
                        usuario_lista
                    ON
                        usuario_lista.lista_id=lista_usuario_item.lista_id
                    JOIN
                        lista
                    ON
                        usuario_lista.lista_id=lista.lista_id
                    JOIN
                        usuario_item
                    ON
                        lista_usuario_item.usuario_item_id=usuario_item.usuario_item_id
                    JOIN
                        item
                    ON
                        usuario_item.item_id=item.item_id
,
(
SELECT
       SUBSTRING(x.resultado, 1, CHAR_LENGTH( x.resultado )-2) AS redes_sociales
FROM
(


SELECT
    @retvalue := CONCAT(@retvalue, tmp_tbl.red_social_nombre, ', ') AS resultado
FROM
  (

SELECT
                        red_social.red_social_nombre,
                        lista.lista_id,
                        lista_usuario_item.lista_usuario_item_id,
                        lista_usuario_item.usuario_item_id,
                        item.item_id,
                        item.item_nombre,
                        item.item_marca,
                        item.item_comentario,
                        usuario_item.usuario_id,
                        usuario_item.usuario_item_comentario,
                        lista_usuario_item.lista_usuario_item_comentario,
                        usuario_item.usuario_item_publico
                    FROM
                        lista_usuario_item
                    JOIN
                        usuario_lista
                    ON
                        usuario_lista.lista_id=lista_usuario_item.lista_id
                    JOIN
                        lista
                    ON
                        usuario_lista.lista_id=lista.lista_id
                    JOIN
                        usuario_item
                    ON
                        lista_usuario_item.usuario_item_id=usuario_item.usuario_item_id
                    JOIN
                        item
                    ON
                        usuario_item.item_id=item.item_id
                    JOIN
                        usuario_item_red_social
                    ON
                      usuario_item.usuario_item_id=usuario_item_red_social.usuario_item_id
                    JOIN
                        red_social
                    ON
                      red_social.red_social_id=usuario_item_red_social.red_social_id
                    WHERE
                        lista_usuario_item.lista_usuario_item_status <>'I'
                        AND usuario_lista.usuario_id=@usuario
                        AND usuario_lista.usuario_lista_status<>'I'
    ) as tmp_tbl

) AS x
ORDER BY
      x.resultado DESC LIMIT 1
) as redes

                    WHERE
                        lista_usuario_item.lista_id=1 AND
                        lista_usuario_item.lista_usuario_item_status <>'I'
                        AND usuario_lista.usuario_id=@usuario
                        AND usuario_lista.usuario_lista_status<>'I'
                    ORDER BY
                        lista_usuario_item.lista_usuario_item_prioridad DESC

*/