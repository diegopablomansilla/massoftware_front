
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
		 Carga.id AS Carga_id       	-- 0
		,Carga.numero AS Carga_numero	-- 1
		,Carga.nombre AS Carga_nombre	-- 2

	FROM	massoftware.Carga

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CargaById('xxx');

-- SELECT * FROM massoftware.f_CargaById((SELECT Carga.id FROM massoftware.Carga LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CargaById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CargaById_1(idArg VARCHAR(36)) RETURNS massoftware.type_Carga_level_1 AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

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
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Transporte.domicilio AS Transporte_domicilio         	-- 15
		,Transporte.comentario AS Transporte_comentario       	-- 16

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
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Ciudad.id AS Ciudad_id                               	-- 15
		,Ciudad.numero AS Ciudad_numero                       	-- 16
		,Ciudad.nombre AS Ciudad_nombre                       	-- 17
		,Ciudad.departamento AS Ciudad_departamento           	-- 18
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 19
		,Transporte.domicilio AS Transporte_domicilio         	-- 20
		,Transporte.comentario AS Transporte_comentario       	-- 21

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 15

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CargaById_3('xxx');

-- SELECT * FROM massoftware.f_CargaById_3((SELECT Carga.id FROM massoftware.Carga LIMIT 1)::VARCHAR);