
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Provincia                                                                                              //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Provincia

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ProvinciaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ProvinciaById(idArg VARCHAR(36)) RETURNS massoftware.Provincia AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_ProvinciaById('xxx');

-- SELECT * FROM massoftware.f_ProvinciaById((SELECT Provincia.id FROM massoftware.Provincia LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ProvinciaById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ProvinciaById_1(idArg VARCHAR(36)) RETURNS massoftware.type_Provincia_level_1 AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_ProvinciaById_1('xxx');

-- SELECT * FROM massoftware.f_ProvinciaById_1((SELECT Provincia.id FROM massoftware.Provincia LIMIT 1)::VARCHAR);