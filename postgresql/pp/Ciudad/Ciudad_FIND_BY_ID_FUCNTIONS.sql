
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Ciudad                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Ciudad

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CiudadById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CiudadById(idArg VARCHAR(36)) RETURNS massoftware.Ciudad AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ciudad.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CiudadById('xxx');

-- SELECT * FROM massoftware.f_CiudadById((SELECT Ciudad.id FROM massoftware.Ciudad LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CiudadById_level_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CiudadById_level_1(idArg VARCHAR(36)) RETURNS massoftware.Ciudad_level_1 AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ciudad.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CiudadById_level_1('xxx');

-- SELECT * FROM massoftware.f_CiudadById_level_1((SELECT Ciudad.id FROM massoftware.Ciudad LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CiudadById_level_2(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CiudadById_level_2(idArg VARCHAR(36)) RETURNS massoftware.Ciudad_level_2 AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ciudad.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CiudadById_level_2('xxx');

-- SELECT * FROM massoftware.f_CiudadById_level_2((SELECT Ciudad.id FROM massoftware.Ciudad LIMIT 1)::VARCHAR);