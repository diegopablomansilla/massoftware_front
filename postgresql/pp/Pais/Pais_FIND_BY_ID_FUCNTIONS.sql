
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Pais                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Pais

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_PaisById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_PaisById(idArg VARCHAR(36)) RETURNS massoftware.Pais AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Pais.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_PaisById('xxx');

-- SELECT * FROM massoftware.f_PaisById((SELECT Pais.id FROM massoftware.Pais LIMIT 1)::VARCHAR);