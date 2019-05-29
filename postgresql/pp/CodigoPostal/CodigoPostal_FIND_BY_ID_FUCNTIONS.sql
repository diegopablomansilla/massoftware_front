
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CodigoPostal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CodigoPostal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostalById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostalById(idArg VARCHAR(36)) RETURNS massoftware.CodigoPostal AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CodigoPostalById('xxx');

-- SELECT * FROM massoftware.f_CodigoPostalById((SELECT CodigoPostal.id FROM massoftware.CodigoPostal LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostalById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostalById_1(idArg VARCHAR(36)) RETURNS massoftware.type_CodigoPostal_level_1 AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CodigoPostalById_1('xxx');

-- SELECT * FROM massoftware.f_CodigoPostalById_1((SELECT CodigoPostal.id FROM massoftware.CodigoPostal LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostalById_2(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostalById_2(idArg VARCHAR(36)) RETURNS massoftware.type_CodigoPostal_level_2 AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CodigoPostalById_2('xxx');

-- SELECT * FROM massoftware.f_CodigoPostalById_2((SELECT CodigoPostal.id FROM massoftware.CodigoPostal LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostalById_3(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostalById_3(idArg VARCHAR(36)) RETURNS massoftware.type_CodigoPostal_level_3 AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CodigoPostalById_3('xxx');

-- SELECT * FROM massoftware.f_CodigoPostalById_3((SELECT CodigoPostal.id FROM massoftware.CodigoPostal LIMIT 1)::VARCHAR);