/*
SELECT
                        usuario_item.usuario_item_id,
-- Datos de item
                        item.item_id,
                        item.item_nombre,
                        item.item_marca,
                        item.item_comentario,

-- datos de usuario_item
                        usuario_item.usuario_id,
                        usuario_item.usuario_item_comentario,
                        usuario_item.usuario_item_publico,

-- Datos de redes sociales
                        usuario_item_red_social.red_social_id,
                        red_social.red_social_nombre,
-- Datos de las lista
                        lista_usuario_item.lista_usuario_item_id,
                        lista_usuario_item.lista_id,
                        lista.lista_nombre
                   FROM
                        usuario_item
                  JOIN
                        item ON usuario_item.item_id=item.item_id
                  LEFT JOIN
                       usuario_item_red_social ON usuario_item.usuario_item_id=usuario_item_red_social.usuario_item_id
                  LEFT JOIN
                       red_social ON usuario_item_red_social.red_social_id=red_social.red_social_id
                  LEFT JOIN
                       lista_usuario_item ON lista_usuario_item.usuario_item_id=usuario_item.usuario_item_id
                  LEFT JOIN
                       lista ON lista_usuario_item.lista_id=lista.lista_id

                  WHERE
                        usuario_item.usuario_item_id =134

                  GROUP BY
                        usuario_item_id
                  ORDER BY
                        usuario_item.usuario_item_id DESC
*/


SELECT
                        usuario_item.usuario_item_id,
-- Datos de item
                        item.item_id,
                        item.item_nombre,
                        item.item_marca,
                        item.item_comentario,

-- datos de usuario_item
                        usuario_item.usuario_id,
                        usuario_item.usuario_item_comentario,
                        usuario_item.usuario_item_publico,

-- Datos de redes sociales
			GROUP_CONCAT(DISTINCT
                              CONCAT(
                                     -- usuario_item_red_social.red_social_id,
                                     red_social.red_social_nombre, '<br />'
                                     )SEPARATOR ' '
                        ) AS redes,

-- Datos de las lista
		GROUP_CONCAT(DISTINCT
                              CONCAT(
                                     -- lista_usuario_item.lista_id,
                                     -- lista_usuario_item.lista_usuario_item_id,
                                     lista.lista_nombre, '<br />'
                              )SEPARATOR ' '
                        ) AS listas
                   FROM
                        usuario_item
                  JOIN
                        item ON usuario_item.item_id=item.item_id
                  LEFT JOIN
                       usuario_item_red_social ON usuario_item.usuario_item_id=usuario_item_red_social.usuario_item_id

                  LEFT JOIN
                       red_social ON usuario_item_red_social.red_social_id=red_social.red_social_id
                  LEFT JOIN
                       lista_usuario_item ON lista_usuario_item.usuario_item_id=usuario_item.usuario_item_id
                  LEFT JOIN
                       lista ON lista_usuario_item.lista_id=lista.lista_id
                  WHERE
                        usuario_item.usuario_item_id =134

                    GROUP BY usuario_item_id
                    ORDER BY
                        usuario_item.usuario_item_id DESC

