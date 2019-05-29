
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
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteTarifaById('xxx');

-- SELECT * FROM massoftware.f_TransporteTarifaById((SELECT TransporteTarifa.id FROM massoftware.TransporteTarifa LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById_level_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById_level_1(idArg VARCHAR(36)) RETURNS massoftware.TransporteTarifa_level_1 AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteTarifaById_level_1('xxx');

-- SELECT * FROM massoftware.f_TransporteTarifaById_level_1((SELECT TransporteTarifa.id FROM massoftware.TransporteTarifa LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById_level_2(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById_level_2(idArg VARCHAR(36)) RETURNS massoftware.TransporteTarifa_level_2 AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteTarifaById_level_2('xxx');

-- SELECT * FROM massoftware.f_TransporteTarifaById_level_2((SELECT TransporteTarifa.id FROM massoftware.TransporteTarifa LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById_level_3(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById_level_3(idArg VARCHAR(36)) RETURNS massoftware.TransporteTarifa_level_3 AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteTarifaById_level_3('xxx');

-- SELECT * FROM massoftware.f_TransporteTarifaById_level_3((SELECT TransporteTarifa.id FROM massoftware.TransporteTarifa LIMIT 1)::VARCHAR);