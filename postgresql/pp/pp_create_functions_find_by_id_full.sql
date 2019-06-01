


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
			  Usuario.id AS Usuario_id       			-- 0
			, Usuario.numero AS Usuario_numero			-- 1
			, Usuario.nombre AS Usuario_nombre			-- 2
	FROM	massoftware.Usuario
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Usuario.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_UsuarioById('xxx');
-- SELECT * FROM massoftware.f_UsuarioById((SELECT Usuario.id FROM massoftware.Usuario LIMIT 1)::VARCHAR);


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
			  Zona.id AS Zona_id                   			-- 0
			, Zona.codigo AS Zona_codigo           			-- 1
			, Zona.nombre AS Zona_nombre           			-- 2
			, Zona.bonificacion AS Zona_bonificacion			-- 3
			, Zona.recargo AS Zona_recargo         			-- 4
	FROM	massoftware.Zona
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Zona.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_ZonaById('xxx');
-- SELECT * FROM massoftware.f_ZonaById((SELECT Zona.id FROM massoftware.Zona LIMIT 1)::VARCHAR);


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
			  Pais.id AS Pais_id                 			-- 0
			, Pais.numero AS Pais_numero         			-- 1
			, Pais.nombre AS Pais_nombre         			-- 2
			, Pais.abreviatura AS Pais_abreviatura			-- 3
	FROM	massoftware.Pais
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Pais.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_PaisById('xxx');
-- SELECT * FROM massoftware.f_PaisById((SELECT Pais.id FROM massoftware.Pais LIMIT 1)::VARCHAR);


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
			  Provincia.id AS Provincia_id                                   			-- 0
			, Provincia.numero AS Provincia_numero                           			-- 1
			, Provincia.nombre AS Provincia_nombre                           			-- 2
			, Provincia.abreviatura AS Provincia_abreviatura                 			-- 3
			, Provincia.numeroAFIP AS Provincia_numeroAFIP                   			-- 4
			, Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos			-- 5
			, Provincia.numeroRENATEA AS Provincia_numeroRENATEA             			-- 6
			, Provincia.pais AS Provincia_pais                               			-- 7
	FROM	massoftware.Provincia
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_ProvinciaById('xxx');
-- SELECT * FROM massoftware.f_ProvinciaById((SELECT Provincia.id FROM massoftware.Provincia LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ProvinciaById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ProvinciaById_1(idArg VARCHAR(36)) RETURNS massoftware.type_Provincia_level_1 AS $$

	SELECT
			  Provincia.id AS Provincia_id                                   			-- 0
			, Provincia.numero AS Provincia_numero                           			-- 1
			, Provincia.nombre AS Provincia_nombre                           			-- 2
			, Provincia.abreviatura AS Provincia_abreviatura                 			-- 3
			, Provincia.numeroAFIP AS Provincia_numeroAFIP                   			-- 4
			, Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos			-- 5
			, Provincia.numeroRENATEA AS Provincia_numeroRENATEA             			-- 6
			, Pais.id AS Pais_id                                             			-- 7
			, Pais.numero AS Pais_numero                                     			-- 8
			, Pais.nombre AS Pais_nombre                                     			-- 9
			, Pais.abreviatura AS Pais_abreviatura                           			-- 10
	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_ProvinciaById_1('xxx');
-- SELECT * FROM massoftware.f_ProvinciaById_1((SELECT Provincia.id FROM massoftware.Provincia LIMIT 1)::VARCHAR);


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
			  Ciudad.id AS Ciudad_id                   			-- 0
			, Ciudad.numero AS Ciudad_numero           			-- 1
			, Ciudad.nombre AS Ciudad_nombre           			-- 2
			, Ciudad.departamento AS Ciudad_departamento			-- 3
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP   			-- 4
			, Ciudad.provincia AS Ciudad_provincia     			-- 5
	FROM	massoftware.Ciudad
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ciudad.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CiudadById('xxx');
-- SELECT * FROM massoftware.f_CiudadById((SELECT Ciudad.id FROM massoftware.Ciudad LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CiudadById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CiudadById_1(idArg VARCHAR(36)) RETURNS massoftware.type_Ciudad_level_1 AS $$

	SELECT
			  Ciudad.id AS Ciudad_id                                         			-- 0
			, Ciudad.numero AS Ciudad_numero                                 			-- 1
			, Ciudad.nombre AS Ciudad_nombre                                 			-- 2
			, Ciudad.departamento AS Ciudad_departamento                     			-- 3
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         			-- 4
			, Provincia.id AS Provincia_id                                   			-- 5
			, Provincia.numero AS Provincia_numero                           			-- 6
			, Provincia.nombre AS Provincia_nombre                           			-- 7
			, Provincia.abreviatura AS Provincia_abreviatura                 			-- 8
			, Provincia.numeroAFIP AS Provincia_numeroAFIP                   			-- 9
			, Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos			-- 10
			, Provincia.numeroRENATEA AS Provincia_numeroRENATEA             			-- 11
			, Provincia.pais AS Provincia_pais                               			-- 12
	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ciudad.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CiudadById_1('xxx');
-- SELECT * FROM massoftware.f_CiudadById_1((SELECT Ciudad.id FROM massoftware.Ciudad LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CiudadById_2(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CiudadById_2(idArg VARCHAR(36)) RETURNS massoftware.type_Ciudad_level_2 AS $$

	SELECT
			  Ciudad.id AS Ciudad_id                                         			-- 0
			, Ciudad.numero AS Ciudad_numero                                 			-- 1
			, Ciudad.nombre AS Ciudad_nombre                                 			-- 2
			, Ciudad.departamento AS Ciudad_departamento                     			-- 3
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         			-- 4
			, Provincia.id AS Provincia_id                                   			-- 5
			, Provincia.numero AS Provincia_numero                           			-- 6
			, Provincia.nombre AS Provincia_nombre                           			-- 7
			, Provincia.abreviatura AS Provincia_abreviatura                 			-- 8
			, Provincia.numeroAFIP AS Provincia_numeroAFIP                   			-- 9
			, Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos			-- 10
			, Provincia.numeroRENATEA AS Provincia_numeroRENATEA             			-- 11
			, Pais.id AS Pais_id                                             			-- 12
			, Pais.numero AS Pais_numero                                     			-- 13
			, Pais.nombre AS Pais_nombre                                     			-- 14
			, Pais.abreviatura AS Pais_abreviatura                           			-- 15
	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ciudad.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CiudadById_2('xxx');
-- SELECT * FROM massoftware.f_CiudadById_2((SELECT Ciudad.id FROM massoftware.Ciudad LIMIT 1)::VARCHAR);


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
			  CodigoPostal.id AS CodigoPostal_id                 			-- 0
			, CodigoPostal.codigo AS CodigoPostal_codigo         			-- 1
			, CodigoPostal.numero AS CodigoPostal_numero         			-- 2
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle			-- 3
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle			-- 4
			, CodigoPostal.ciudad AS CodigoPostal_ciudad         			-- 5
	FROM	massoftware.CodigoPostal
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CodigoPostalById('xxx');
-- SELECT * FROM massoftware.f_CodigoPostalById((SELECT CodigoPostal.id FROM massoftware.CodigoPostal LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostalById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostalById_1(idArg VARCHAR(36)) RETURNS massoftware.type_CodigoPostal_level_1 AS $$

	SELECT
			  CodigoPostal.id AS CodigoPostal_id                 			-- 0
			, CodigoPostal.codigo AS CodigoPostal_codigo         			-- 1
			, CodigoPostal.numero AS CodigoPostal_numero         			-- 2
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle			-- 3
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle			-- 4
			, Ciudad.id AS Ciudad_id                             			-- 5
			, Ciudad.numero AS Ciudad_numero                     			-- 6
			, Ciudad.nombre AS Ciudad_nombre                     			-- 7
			, Ciudad.departamento AS Ciudad_departamento         			-- 8
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP             			-- 9
			, Ciudad.provincia AS Ciudad_provincia               			-- 10
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
			  CodigoPostal.id AS CodigoPostal_id                             			-- 0
			, CodigoPostal.codigo AS CodigoPostal_codigo                     			-- 1
			, CodigoPostal.numero AS CodigoPostal_numero                     			-- 2
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           			-- 3
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           			-- 4
			, Ciudad.id AS Ciudad_id                                         			-- 5
			, Ciudad.numero AS Ciudad_numero                                 			-- 6
			, Ciudad.nombre AS Ciudad_nombre                                 			-- 7
			, Ciudad.departamento AS Ciudad_departamento                     			-- 8
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         			-- 9
			, Provincia.id AS Provincia_id                                   			-- 10
			, Provincia.numero AS Provincia_numero                           			-- 11
			, Provincia.nombre AS Provincia_nombre                           			-- 12
			, Provincia.abreviatura AS Provincia_abreviatura                 			-- 13
			, Provincia.numeroAFIP AS Provincia_numeroAFIP                   			-- 14
			, Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos			-- 15
			, Provincia.numeroRENATEA AS Provincia_numeroRENATEA             			-- 16
			, Provincia.pais AS Provincia_pais                               			-- 17
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
			  CodigoPostal.id AS CodigoPostal_id                             			-- 0
			, CodigoPostal.codigo AS CodigoPostal_codigo                     			-- 1
			, CodigoPostal.numero AS CodigoPostal_numero                     			-- 2
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           			-- 3
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           			-- 4
			, Ciudad.id AS Ciudad_id                                         			-- 5
			, Ciudad.numero AS Ciudad_numero                                 			-- 6
			, Ciudad.nombre AS Ciudad_nombre                                 			-- 7
			, Ciudad.departamento AS Ciudad_departamento                     			-- 8
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         			-- 9
			, Provincia.id AS Provincia_id                                   			-- 10
			, Provincia.numero AS Provincia_numero                           			-- 11
			, Provincia.nombre AS Provincia_nombre                           			-- 12
			, Provincia.abreviatura AS Provincia_abreviatura                 			-- 13
			, Provincia.numeroAFIP AS Provincia_numeroAFIP                   			-- 14
			, Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos			-- 15
			, Provincia.numeroRENATEA AS Provincia_numeroRENATEA             			-- 16
			, Pais.id AS Pais_id                                             			-- 17
			, Pais.numero AS Pais_numero                                     			-- 18
			, Pais.nombre AS Pais_nombre                                     			-- 19
			, Pais.abreviatura AS Pais_abreviatura                           			-- 20
	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CodigoPostalById_3('xxx');
-- SELECT * FROM massoftware.f_CodigoPostalById_3((SELECT CodigoPostal.id FROM massoftware.CodigoPostal LIMIT 1)::VARCHAR);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Transporte                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Transporte

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteById(idArg VARCHAR(36)) RETURNS massoftware.Transporte AS $$

	SELECT
			  Transporte.id AS Transporte_id                       			-- 0
			, Transporte.numero AS Transporte_numero               			-- 1
			, Transporte.nombre AS Transporte_nombre               			-- 2
			, Transporte.cuit AS Transporte_cuit                   			-- 3
			, Transporte.ingresosBrutos AS Transporte_ingresosBrutos			-- 4
			, Transporte.telefono AS Transporte_telefono           			-- 5
			, Transporte.fax AS Transporte_fax                     			-- 6
			, Transporte.codigoPostal AS Transporte_codigoPostal   			-- 7
			, Transporte.domicilio AS Transporte_domicilio         			-- 8
			, Transporte.comentario AS Transporte_comentario       			-- 9
	FROM	massoftware.Transporte
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteById('xxx');
-- SELECT * FROM massoftware.f_TransporteById((SELECT Transporte.id FROM massoftware.Transporte LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteById_1(idArg VARCHAR(36)) RETURNS massoftware.type_Transporte_level_1 AS $$

	SELECT
			  Transporte.id AS Transporte_id                       			-- 0
			, Transporte.numero AS Transporte_numero               			-- 1
			, Transporte.nombre AS Transporte_nombre               			-- 2
			, Transporte.cuit AS Transporte_cuit                   			-- 3
			, Transporte.ingresosBrutos AS Transporte_ingresosBrutos			-- 4
			, Transporte.telefono AS Transporte_telefono           			-- 5
			, Transporte.fax AS Transporte_fax                     			-- 6
			, CodigoPostal.id AS CodigoPostal_id                   			-- 7
			, CodigoPostal.codigo AS CodigoPostal_codigo           			-- 8
			, CodigoPostal.numero AS CodigoPostal_numero           			-- 9
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 			-- 10
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 			-- 11
			, CodigoPostal.ciudad AS CodigoPostal_ciudad           			-- 12
			, Transporte.domicilio AS Transporte_domicilio         			-- 13
			, Transporte.comentario AS Transporte_comentario       			-- 14
	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteById_1('xxx');
-- SELECT * FROM massoftware.f_TransporteById_1((SELECT Transporte.id FROM massoftware.Transporte LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteById_2(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteById_2(idArg VARCHAR(36)) RETURNS massoftware.type_Transporte_level_2 AS $$

	SELECT
			  Transporte.id AS Transporte_id                       			-- 0
			, Transporte.numero AS Transporte_numero               			-- 1
			, Transporte.nombre AS Transporte_nombre               			-- 2
			, Transporte.cuit AS Transporte_cuit                   			-- 3
			, Transporte.ingresosBrutos AS Transporte_ingresosBrutos			-- 4
			, Transporte.telefono AS Transporte_telefono           			-- 5
			, Transporte.fax AS Transporte_fax                     			-- 6
			, CodigoPostal.id AS CodigoPostal_id                   			-- 7
			, CodigoPostal.codigo AS CodigoPostal_codigo           			-- 8
			, CodigoPostal.numero AS CodigoPostal_numero           			-- 9
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 			-- 10
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 			-- 11
			, Ciudad.id AS Ciudad_id                               			-- 12
			, Ciudad.numero AS Ciudad_numero                       			-- 13
			, Ciudad.nombre AS Ciudad_nombre                       			-- 14
			, Ciudad.departamento AS Ciudad_departamento           			-- 15
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP               			-- 16
			, Ciudad.provincia AS Ciudad_provincia                 			-- 17
			, Transporte.domicilio AS Transporte_domicilio         			-- 18
			, Transporte.comentario AS Transporte_comentario       			-- 19
	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteById_2('xxx');
-- SELECT * FROM massoftware.f_TransporteById_2((SELECT Transporte.id FROM massoftware.Transporte LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteById_3(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteById_3(idArg VARCHAR(36)) RETURNS massoftware.type_Transporte_level_3 AS $$

	SELECT
			  Transporte.id AS Transporte_id                                 			-- 0
			, Transporte.numero AS Transporte_numero                         			-- 1
			, Transporte.nombre AS Transporte_nombre                         			-- 2
			, Transporte.cuit AS Transporte_cuit                             			-- 3
			, Transporte.ingresosBrutos AS Transporte_ingresosBrutos         			-- 4
			, Transporte.telefono AS Transporte_telefono                     			-- 5
			, Transporte.fax AS Transporte_fax                               			-- 6
			, CodigoPostal.id AS CodigoPostal_id                             			-- 7
			, CodigoPostal.codigo AS CodigoPostal_codigo                     			-- 8
			, CodigoPostal.numero AS CodigoPostal_numero                     			-- 9
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           			-- 10
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           			-- 11
			, Ciudad.id AS Ciudad_id                                         			-- 12
			, Ciudad.numero AS Ciudad_numero                                 			-- 13
			, Ciudad.nombre AS Ciudad_nombre                                 			-- 14
			, Ciudad.departamento AS Ciudad_departamento                     			-- 15
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         			-- 16
			, Provincia.id AS Provincia_id                                   			-- 17
			, Provincia.numero AS Provincia_numero                           			-- 18
			, Provincia.nombre AS Provincia_nombre                           			-- 19
			, Provincia.abreviatura AS Provincia_abreviatura                 			-- 20
			, Provincia.numeroAFIP AS Provincia_numeroAFIP                   			-- 21
			, Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos			-- 22
			, Provincia.numeroRENATEA AS Provincia_numeroRENATEA             			-- 23
			, Provincia.pais AS Provincia_pais                               			-- 24
			, Transporte.domicilio AS Transporte_domicilio                   			-- 25
			, Transporte.comentario AS Transporte_comentario                 			-- 26
	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteById_3('xxx');
-- SELECT * FROM massoftware.f_TransporteById_3((SELECT Transporte.id FROM massoftware.Transporte LIMIT 1)::VARCHAR);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Carga                                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Carga

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CargaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CargaById(idArg VARCHAR(36)) RETURNS massoftware.Carga AS $$

	SELECT
			  Carga.id AS Carga_id               			-- 0
			, Carga.numero AS Carga_numero       			-- 1
			, Carga.nombre AS Carga_nombre       			-- 2
			, Carga.transporte AS Carga_transporte			-- 3
	FROM	massoftware.Carga
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CargaById('xxx');
-- SELECT * FROM massoftware.f_CargaById((SELECT Carga.id FROM massoftware.Carga LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CargaById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CargaById_1(idArg VARCHAR(36)) RETURNS massoftware.type_Carga_level_1 AS $$

	SELECT
			  Carga.id AS Carga_id                                 			-- 0
			, Carga.numero AS Carga_numero                         			-- 1
			, Carga.nombre AS Carga_nombre                         			-- 2
			, Transporte.id AS Transporte_id                       			-- 3
			, Transporte.numero AS Transporte_numero               			-- 4
			, Transporte.nombre AS Transporte_nombre               			-- 5
			, Transporte.cuit AS Transporte_cuit                   			-- 6
			, Transporte.ingresosBrutos AS Transporte_ingresosBrutos			-- 7
			, Transporte.telefono AS Transporte_telefono           			-- 8
			, Transporte.fax AS Transporte_fax                     			-- 9
			, Transporte.codigoPostal AS Transporte_codigoPostal   			-- 10
			, Transporte.domicilio AS Transporte_domicilio         			-- 11
			, Transporte.comentario AS Transporte_comentario       			-- 12
	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CargaById_1('xxx');
-- SELECT * FROM massoftware.f_CargaById_1((SELECT Carga.id FROM massoftware.Carga LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CargaById_2(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CargaById_2(idArg VARCHAR(36)) RETURNS massoftware.type_Carga_level_2 AS $$

	SELECT
			  Carga.id AS Carga_id                                 			-- 0
			, Carga.numero AS Carga_numero                         			-- 1
			, Carga.nombre AS Carga_nombre                         			-- 2
			, Transporte.id AS Transporte_id                       			-- 3
			, Transporte.numero AS Transporte_numero               			-- 4
			, Transporte.nombre AS Transporte_nombre               			-- 5
			, Transporte.cuit AS Transporte_cuit                   			-- 6
			, Transporte.ingresosBrutos AS Transporte_ingresosBrutos			-- 7
			, Transporte.telefono AS Transporte_telefono           			-- 8
			, Transporte.fax AS Transporte_fax                     			-- 9
			, CodigoPostal.id AS CodigoPostal_id                   			-- 10
			, CodigoPostal.codigo AS CodigoPostal_codigo           			-- 11
			, CodigoPostal.numero AS CodigoPostal_numero           			-- 12
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 			-- 13
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 			-- 14
			, CodigoPostal.ciudad AS CodigoPostal_ciudad           			-- 15
			, Transporte.domicilio AS Transporte_domicilio         			-- 16
			, Transporte.comentario AS Transporte_comentario       			-- 17
	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CargaById_2('xxx');
-- SELECT * FROM massoftware.f_CargaById_2((SELECT Carga.id FROM massoftware.Carga LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CargaById_3(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CargaById_3(idArg VARCHAR(36)) RETURNS massoftware.type_Carga_level_3 AS $$

	SELECT
			  Carga.id AS Carga_id                                 			-- 0
			, Carga.numero AS Carga_numero                         			-- 1
			, Carga.nombre AS Carga_nombre                         			-- 2
			, Transporte.id AS Transporte_id                       			-- 3
			, Transporte.numero AS Transporte_numero               			-- 4
			, Transporte.nombre AS Transporte_nombre               			-- 5
			, Transporte.cuit AS Transporte_cuit                   			-- 6
			, Transporte.ingresosBrutos AS Transporte_ingresosBrutos			-- 7
			, Transporte.telefono AS Transporte_telefono           			-- 8
			, Transporte.fax AS Transporte_fax                     			-- 9
			, CodigoPostal.id AS CodigoPostal_id                   			-- 10
			, CodigoPostal.codigo AS CodigoPostal_codigo           			-- 11
			, CodigoPostal.numero AS CodigoPostal_numero           			-- 12
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 			-- 13
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 			-- 14
			, Ciudad.id AS Ciudad_id                               			-- 15
			, Ciudad.numero AS Ciudad_numero                       			-- 16
			, Ciudad.nombre AS Ciudad_nombre                       			-- 17
			, Ciudad.departamento AS Ciudad_departamento           			-- 18
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP               			-- 19
			, Ciudad.provincia AS Ciudad_provincia                 			-- 20
			, Transporte.domicilio AS Transporte_domicilio         			-- 21
			, Transporte.comentario AS Transporte_comentario       			-- 22
	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 15
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CargaById_3('xxx');
-- SELECT * FROM massoftware.f_CargaById_3((SELECT Carga.id FROM massoftware.Carga LIMIT 1)::VARCHAR);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TransporteTarifa                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TransporteTarifa

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById(idArg VARCHAR(36)) RETURNS massoftware.TransporteTarifa AS $$

	SELECT
			  TransporteTarifa.id AS TransporteTarifa_id                                         			-- 0
			, TransporteTarifa.numero AS TransporteTarifa_numero                                 			-- 1
			, TransporteTarifa.carga AS TransporteTarifa_carga                                   			-- 2
			, TransporteTarifa.ciudad AS TransporteTarifa_ciudad                                 			-- 3
			, TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       			-- 4
			, TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion			-- 5
			, TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           			-- 6
			, TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     			-- 7
			, TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     			-- 8
			, TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         			-- 9
	FROM	massoftware.TransporteTarifa
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteTarifaById('xxx');
-- SELECT * FROM massoftware.f_TransporteTarifaById((SELECT TransporteTarifa.id FROM massoftware.TransporteTarifa LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById_1(idArg VARCHAR(36)) RETURNS massoftware.type_TransporteTarifa_level_1 AS $$

	SELECT
			  TransporteTarifa.id AS TransporteTarifa_id                                         			-- 0
			, TransporteTarifa.numero AS TransporteTarifa_numero                                 			-- 1
			, Carga.id AS Carga_id                                                               			-- 2
			, Carga.numero AS Carga_numero                                                       			-- 3
			, Carga.nombre AS Carga_nombre                                                       			-- 4
			, Carga.transporte AS Carga_transporte                                               			-- 5
			, Ciudad.id AS Ciudad_id                                                             			-- 6
			, Ciudad.numero AS Ciudad_numero                                                     			-- 7
			, Ciudad.nombre AS Ciudad_nombre                                                     			-- 8
			, Ciudad.departamento AS Ciudad_departamento                                         			-- 9
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             			-- 10
			, Ciudad.provincia AS Ciudad_provincia                                               			-- 11
			, TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       			-- 12
			, TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion			-- 13
			, TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           			-- 14
			, TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     			-- 15
			, TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     			-- 16
			, TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         			-- 17
	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteTarifaById_1('xxx');
-- SELECT * FROM massoftware.f_TransporteTarifaById_1((SELECT TransporteTarifa.id FROM massoftware.TransporteTarifa LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById_2(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById_2(idArg VARCHAR(36)) RETURNS massoftware.type_TransporteTarifa_level_2 AS $$

	SELECT
			  TransporteTarifa.id AS TransporteTarifa_id                                         			-- 0
			, TransporteTarifa.numero AS TransporteTarifa_numero                                 			-- 1
			, Carga.id AS Carga_id                                                               			-- 2
			, Carga.numero AS Carga_numero                                                       			-- 3
			, Carga.nombre AS Carga_nombre                                                       			-- 4
			, Transporte.id AS Transporte_id                                                     			-- 5
			, Transporte.numero AS Transporte_numero                                             			-- 6
			, Transporte.nombre AS Transporte_nombre                                             			-- 7
			, Transporte.cuit AS Transporte_cuit                                                 			-- 8
			, Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             			-- 9
			, Transporte.telefono AS Transporte_telefono                                         			-- 10
			, Transporte.fax AS Transporte_fax                                                   			-- 11
			, Transporte.codigoPostal AS Transporte_codigoPostal                                 			-- 12
			, Transporte.domicilio AS Transporte_domicilio                                       			-- 13
			, Transporte.comentario AS Transporte_comentario                                     			-- 14
			, Ciudad.id AS Ciudad_id                                                             			-- 15
			, Ciudad.numero AS Ciudad_numero                                                     			-- 16
			, Ciudad.nombre AS Ciudad_nombre                                                     			-- 17
			, Ciudad.departamento AS Ciudad_departamento                                         			-- 18
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             			-- 19
			, Provincia.id AS Provincia_id                                                       			-- 20
			, Provincia.numero AS Provincia_numero                                               			-- 21
			, Provincia.nombre AS Provincia_nombre                                               			-- 22
			, Provincia.abreviatura AS Provincia_abreviatura                                     			-- 23
			, Provincia.numeroAFIP AS Provincia_numeroAFIP                                       			-- 24
			, Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   			-- 25
			, Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 			-- 26
			, Provincia.pais AS Provincia_pais                                                   			-- 27
			, TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       			-- 28
			, TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion			-- 29
			, TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           			-- 30
			, TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     			-- 31
			, TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     			-- 32
			, TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         			-- 33
	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteTarifaById_2('xxx');
-- SELECT * FROM massoftware.f_TransporteTarifaById_2((SELECT TransporteTarifa.id FROM massoftware.TransporteTarifa LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById_3(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById_3(idArg VARCHAR(36)) RETURNS massoftware.type_TransporteTarifa_level_3 AS $$

	SELECT
			  TransporteTarifa.id AS TransporteTarifa_id                                         			-- 0
			, TransporteTarifa.numero AS TransporteTarifa_numero                                 			-- 1
			, Carga.id AS Carga_id                                                               			-- 2
			, Carga.numero AS Carga_numero                                                       			-- 3
			, Carga.nombre AS Carga_nombre                                                       			-- 4
			, Transporte.id AS Transporte_id                                                     			-- 5
			, Transporte.numero AS Transporte_numero                                             			-- 6
			, Transporte.nombre AS Transporte_nombre                                             			-- 7
			, Transporte.cuit AS Transporte_cuit                                                 			-- 8
			, Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             			-- 9
			, Transporte.telefono AS Transporte_telefono                                         			-- 10
			, Transporte.fax AS Transporte_fax                                                   			-- 11
			, CodigoPostal.id AS CodigoPostal_id                                                 			-- 12
			, CodigoPostal.codigo AS CodigoPostal_codigo                                         			-- 13
			, CodigoPostal.numero AS CodigoPostal_numero                                         			-- 14
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               			-- 15
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               			-- 16
			, CodigoPostal.ciudad AS CodigoPostal_ciudad                                         			-- 17
			, Transporte.domicilio AS Transporte_domicilio                                       			-- 18
			, Transporte.comentario AS Transporte_comentario                                     			-- 19
			, Ciudad.id AS Ciudad_id                                                             			-- 20
			, Ciudad.numero AS Ciudad_numero                                                     			-- 21
			, Ciudad.nombre AS Ciudad_nombre                                                     			-- 22
			, Ciudad.departamento AS Ciudad_departamento                                         			-- 23
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             			-- 24
			, Provincia.id AS Provincia_id                                                       			-- 25
			, Provincia.numero AS Provincia_numero                                               			-- 26
			, Provincia.nombre AS Provincia_nombre                                               			-- 27
			, Provincia.abreviatura AS Provincia_abreviatura                                     			-- 28
			, Provincia.numeroAFIP AS Provincia_numeroAFIP                                       			-- 29
			, Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   			-- 30
			, Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 			-- 31
			, Pais.id AS Pais_id                                                                 			-- 32
			, Pais.numero AS Pais_numero                                                         			-- 33
			, Pais.nombre AS Pais_nombre                                                         			-- 34
			, Pais.abreviatura AS Pais_abreviatura                                               			-- 35
			, TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       			-- 36
			, TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion			-- 37
			, TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           			-- 38
			, TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     			-- 39
			, TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     			-- 40
			, TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         			-- 41
	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteTarifaById_3('xxx');
-- SELECT * FROM massoftware.f_TransporteTarifaById_3((SELECT TransporteTarifa.id FROM massoftware.TransporteTarifa LIMIT 1)::VARCHAR);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoDocumentoAFIP                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoDocumentoAFIP

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TipoDocumentoAFIPById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoDocumentoAFIPById(idArg VARCHAR(36)) RETURNS massoftware.TipoDocumentoAFIP AS $$

	SELECT
			  TipoDocumentoAFIP.id AS TipoDocumentoAFIP_id       			-- 0
			, TipoDocumentoAFIP.numero AS TipoDocumentoAFIP_numero			-- 1
			, TipoDocumentoAFIP.nombre AS TipoDocumentoAFIP_nombre			-- 2
	FROM	massoftware.TipoDocumentoAFIP
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoDocumentoAFIP.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TipoDocumentoAFIPById('xxx');
-- SELECT * FROM massoftware.f_TipoDocumentoAFIPById((SELECT TipoDocumentoAFIP.id FROM massoftware.TipoDocumentoAFIP LIMIT 1)::VARCHAR);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MonedaAFIP                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MonedaAFIP

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIPById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIPById(idArg VARCHAR(36)) RETURNS massoftware.MonedaAFIP AS $$

	SELECT
			  MonedaAFIP.id AS MonedaAFIP_id       			-- 0
			, MonedaAFIP.codigo AS MonedaAFIP_codigo			-- 1
			, MonedaAFIP.nombre AS MonedaAFIP_nombre			-- 2
	FROM	massoftware.MonedaAFIP
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaAFIP.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_MonedaAFIPById('xxx');
-- SELECT * FROM massoftware.f_MonedaAFIPById((SELECT MonedaAFIP.id FROM massoftware.MonedaAFIP LIMIT 1)::VARCHAR);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Moneda                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Moneda

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaById(idArg VARCHAR(36)) RETURNS massoftware.Moneda AS $$

	SELECT
			  Moneda.id AS Moneda_id                                   			-- 0
			, Moneda.numero AS Moneda_numero                           			-- 1
			, Moneda.nombre AS Moneda_nombre                           			-- 2
			, Moneda.abreviatura AS Moneda_abreviatura                 			-- 3
			, Moneda.cotizacion AS Moneda_cotizacion                   			-- 4
			, Moneda.cotizacionFecha AS Moneda_cotizacionFecha         			-- 5
			, Moneda.controlActualizacion AS Moneda_controlActualizacion			-- 6
			, Moneda.monedaAFIP AS Moneda_monedaAFIP                   			-- 7
	FROM	massoftware.Moneda
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Moneda.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_MonedaById('xxx');
-- SELECT * FROM massoftware.f_MonedaById((SELECT Moneda.id FROM massoftware.Moneda LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaById_1(idArg VARCHAR(36)) RETURNS massoftware.type_Moneda_level_1 AS $$

	SELECT
			  Moneda.id AS Moneda_id                                   			-- 0
			, Moneda.numero AS Moneda_numero                           			-- 1
			, Moneda.nombre AS Moneda_nombre                           			-- 2
			, Moneda.abreviatura AS Moneda_abreviatura                 			-- 3
			, Moneda.cotizacion AS Moneda_cotizacion                   			-- 4
			, Moneda.cotizacionFecha AS Moneda_cotizacionFecha         			-- 5
			, Moneda.controlActualizacion AS Moneda_controlActualizacion			-- 6
			, MonedaAFIP.id AS MonedaAFIP_id                           			-- 7
			, MonedaAFIP.codigo AS MonedaAFIP_codigo                   			-- 8
			, MonedaAFIP.nombre AS MonedaAFIP_nombre                   			-- 9
	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Moneda.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_MonedaById_1('xxx');
-- SELECT * FROM massoftware.f_MonedaById_1((SELECT Moneda.id FROM massoftware.Moneda LIMIT 1)::VARCHAR);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: NotaCreditoMotivo                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.NotaCreditoMotivo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_NotaCreditoMotivoById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_NotaCreditoMotivoById(idArg VARCHAR(36)) RETURNS massoftware.NotaCreditoMotivo AS $$

	SELECT
			  NotaCreditoMotivo.id AS NotaCreditoMotivo_id       			-- 0
			, NotaCreditoMotivo.numero AS NotaCreditoMotivo_numero			-- 1
			, NotaCreditoMotivo.nombre AS NotaCreditoMotivo_nombre			-- 2
	FROM	massoftware.NotaCreditoMotivo
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND NotaCreditoMotivo.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_NotaCreditoMotivoById('xxx');
-- SELECT * FROM massoftware.f_NotaCreditoMotivoById((SELECT NotaCreditoMotivo.id FROM massoftware.NotaCreditoMotivo LIMIT 1)::VARCHAR);


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
			  MotivoComentario.id AS MotivoComentario_id       			-- 0
			, MotivoComentario.numero AS MotivoComentario_numero			-- 1
			, MotivoComentario.nombre AS MotivoComentario_nombre			-- 2
	FROM	massoftware.MotivoComentario
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoComentario.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_MotivoComentarioById('xxx');
-- SELECT * FROM massoftware.f_MotivoComentarioById((SELECT MotivoComentario.id FROM massoftware.MotivoComentario LIMIT 1)::VARCHAR);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoCliente                                                                                            //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TipoClienteById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoClienteById(idArg VARCHAR(36)) RETURNS massoftware.TipoCliente AS $$

	SELECT
			  TipoCliente.id AS TipoCliente_id       			-- 0
			, TipoCliente.numero AS TipoCliente_numero			-- 1
			, TipoCliente.nombre AS TipoCliente_nombre			-- 2
	FROM	massoftware.TipoCliente
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoCliente.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TipoClienteById('xxx');
-- SELECT * FROM massoftware.f_TipoClienteById((SELECT TipoCliente.id FROM massoftware.TipoCliente LIMIT 1)::VARCHAR);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ClasificacionCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ClasificacionCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionClienteById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionClienteById(idArg VARCHAR(36)) RETURNS massoftware.ClasificacionCliente AS $$

	SELECT
			  ClasificacionCliente.id AS ClasificacionCliente_id       			-- 0
			, ClasificacionCliente.numero AS ClasificacionCliente_numero			-- 1
			, ClasificacionCliente.nombre AS ClasificacionCliente_nombre			-- 2
			, ClasificacionCliente.color AS ClasificacionCliente_color 			-- 3
	FROM	massoftware.ClasificacionCliente
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ClasificacionCliente.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_ClasificacionClienteById('xxx');
-- SELECT * FROM massoftware.f_ClasificacionClienteById((SELECT ClasificacionCliente.id FROM massoftware.ClasificacionCliente LIMIT 1)::VARCHAR);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoBloqueoCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoBloqueoCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoClienteById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoClienteById(idArg VARCHAR(36)) RETURNS massoftware.MotivoBloqueoCliente AS $$

	SELECT
			  MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id                                   			-- 0
			, MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero                           			-- 1
			, MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre                           			-- 2
			, MotivoBloqueoCliente.clasificacionCliente AS MotivoBloqueoCliente_clasificacionCliente			-- 3
	FROM	massoftware.MotivoBloqueoCliente
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_MotivoBloqueoClienteById('xxx');
-- SELECT * FROM massoftware.f_MotivoBloqueoClienteById((SELECT MotivoBloqueoCliente.id FROM massoftware.MotivoBloqueoCliente LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoClienteById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoClienteById_1(idArg VARCHAR(36)) RETURNS massoftware.type_MotivoBloqueoCliente_level_1 AS $$

	SELECT
			  MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       			-- 0
			, MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero			-- 1
			, MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre			-- 2
			, ClasificacionCliente.id AS ClasificacionCliente_id       			-- 3
			, ClasificacionCliente.numero AS ClasificacionCliente_numero			-- 4
			, ClasificacionCliente.nombre AS ClasificacionCliente_nombre			-- 5
			, ClasificacionCliente.color AS ClasificacionCliente_color 			-- 6
	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3
	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_MotivoBloqueoClienteById_1('xxx');
-- SELECT * FROM massoftware.f_MotivoBloqueoClienteById_1((SELECT MotivoBloqueoCliente.id FROM massoftware.MotivoBloqueoCliente LIMIT 1)::VARCHAR);