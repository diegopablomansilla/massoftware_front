
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Zona                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Zona

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Zona;

-- SELECT * FROM massoftware.Zona LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Zona;

-- SELECT * FROM massoftware.Zona WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Zona_codigo(codigoArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Zona_codigo(codigoArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.Zona
	WHERE	(codigoArg IS NULL OR (CHAR_LENGTH(TRIM(codigoArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Zona.codigo)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(codigoArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Zona_codigo(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Zona_nombre(nombreArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Zona_nombre(nombreArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.Zona
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Zona.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Zona_nombre(null::VARCHAR);

*/