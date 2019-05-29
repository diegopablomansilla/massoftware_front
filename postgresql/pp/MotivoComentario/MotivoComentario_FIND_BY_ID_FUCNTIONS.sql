
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoComentario                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoComentario

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentarioById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentarioById(idArg VARCHAR(36)) RETURNS massoftware.MotivoComentario AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoComentario.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_MotivoComentarioById('xxx');

-- SELECT * FROM massoftware.f_MotivoComentarioById((SELECT MotivoComentario.id FROM massoftware.MotivoComentario LIMIT 1)::VARCHAR);