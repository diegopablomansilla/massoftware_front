
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
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteById('xxx');

-- SELECT * FROM massoftware.f_TransporteById((SELECT Transporte.id FROM massoftware.Transporte LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteById_1(idArg VARCHAR(36)) RETURNS massoftware.type_Transporte_level_1 AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

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
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

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
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteById_3('xxx');

-- SELECT * FROM massoftware.f_TransporteById_3((SELECT Transporte.id FROM massoftware.Transporte LIMIT 1)::VARCHAR);