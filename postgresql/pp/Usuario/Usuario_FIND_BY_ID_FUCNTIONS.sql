
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Usuario                                                                                                //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Usuario

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_UsuarioById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_UsuarioById(idArg VARCHAR(36)) RETURNS massoftware.Usuario AS $$

	SELECT
		 Usuario.id AS Usuario_id       	-- 0
		,Usuario.numero AS Usuario_numero	-- 1
		,Usuario.nombre AS Usuario_nombre	-- 2

	FROM	massoftware.Usuario

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Usuario.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_UsuarioById('xxx');

-- SELECT * FROM massoftware.f_UsuarioById((SELECT Usuario.id FROM massoftware.Usuario LIMIT 1)::VARCHAR);