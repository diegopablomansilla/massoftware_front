
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Zona                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Zona

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ZonaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ZonaById(idArg VARCHAR(36)) RETURNS massoftware.Zona AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Zona.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_ZonaById('xxx');

-- SELECT * FROM massoftware.f_ZonaById((SELECT Zona.id FROM massoftware.Zona LIMIT 1)::VARCHAR);