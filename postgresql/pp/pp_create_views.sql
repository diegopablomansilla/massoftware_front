








-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Provincia                                                                                              //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Provincia

-- ---------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS massoftware.v_Provincia_1 CASCADE;

CREATE OR REPLACE VIEW massoftware.v_Provincia_1 AS

	SELECT
			  Provincia.id AS Provincia_id                                   		-- 0
			, Provincia.numero AS Provincia_numero                           		-- 1
			, Provincia.nombre AS Provincia_nombre                           		-- 2
			, Provincia.abreviatura AS Provincia_abreviatura                 		-- 3
			, Provincia.numeroAFIP AS Provincia_numeroAFIP                   		-- 4
			, Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos		-- 5
			, Provincia.numeroRENATEA AS Provincia_numeroRENATEA             		-- 6
			, Pais.id AS Pais_id                                             		-- 7
			, Pais.numero AS Pais_numero                                     		-- 8
			, Pais.nombre AS Pais_nombre                                     		-- 9
			, Pais.abreviatura AS Pais_abreviatura                           		-- 10
	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7
	; -- END VIEW

-- SELECT * FROM massoftware.v_Provincia_1 LIMIT 100 OFFSET 0;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Ciudad                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Ciudad

-- ---------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS massoftware.v_Ciudad_1 CASCADE;

CREATE OR REPLACE VIEW massoftware.v_Ciudad_1 AS

	SELECT
			  Ciudad.id AS Ciudad_id                                         		-- 0
			, Ciudad.numero AS Ciudad_numero                                 		-- 1
			, Ciudad.nombre AS Ciudad_nombre                                 		-- 2
			, Ciudad.departamento AS Ciudad_departamento                     		-- 3
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         		-- 4
			, Provincia.id AS Provincia_id                                   		-- 5
			, Provincia.numero AS Provincia_numero                           		-- 6
			, Provincia.nombre AS Provincia_nombre                           		-- 7
			, Provincia.abreviatura AS Provincia_abreviatura                 		-- 8
			, Provincia.numeroAFIP AS Provincia_numeroAFIP                   		-- 9
			, Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos		-- 10
			, Provincia.numeroRENATEA AS Provincia_numeroRENATEA             		-- 11
			, Provincia.pais AS Provincia_pais                               		-- 12
	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
	; -- END VIEW

-- SELECT * FROM massoftware.v_Ciudad_1 LIMIT 100 OFFSET 0;

-- ---------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS massoftware.v_Ciudad_2 CASCADE;

CREATE OR REPLACE VIEW massoftware.v_Ciudad_2 AS

	SELECT
			  Ciudad.id AS Ciudad_id                                         		-- 0
			, Ciudad.numero AS Ciudad_numero                                 		-- 1
			, Ciudad.nombre AS Ciudad_nombre                                 		-- 2
			, Ciudad.departamento AS Ciudad_departamento                     		-- 3
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         		-- 4
			, Provincia.id AS Provincia_id                                   		-- 5
			, Provincia.numero AS Provincia_numero                           		-- 6
			, Provincia.nombre AS Provincia_nombre                           		-- 7
			, Provincia.abreviatura AS Provincia_abreviatura                 		-- 8
			, Provincia.numeroAFIP AS Provincia_numeroAFIP                   		-- 9
			, Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos		-- 10
			, Provincia.numeroRENATEA AS Provincia_numeroRENATEA             		-- 11
			, Pais.id AS Pais_id                                             		-- 12
			, Pais.numero AS Pais_numero                                     		-- 13
			, Pais.nombre AS Pais_nombre                                     		-- 14
			, Pais.abreviatura AS Pais_abreviatura                           		-- 15
	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12
	; -- END VIEW

-- SELECT * FROM massoftware.v_Ciudad_2 LIMIT 100 OFFSET 0;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CodigoPostal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CodigoPostal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS massoftware.v_CodigoPostal_1 CASCADE;

CREATE OR REPLACE VIEW massoftware.v_CodigoPostal_1 AS

	SELECT
			  CodigoPostal.id AS CodigoPostal_id                 		-- 0
			, CodigoPostal.codigo AS CodigoPostal_codigo         		-- 1
			, CodigoPostal.numero AS CodigoPostal_numero         		-- 2
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle		-- 3
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle		-- 4
			, Ciudad.id AS Ciudad_id                             		-- 5
			, Ciudad.numero AS Ciudad_numero                     		-- 6
			, Ciudad.nombre AS Ciudad_nombre                     		-- 7
			, Ciudad.departamento AS Ciudad_departamento         		-- 8
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP             		-- 9
			, Ciudad.provincia AS Ciudad_provincia               		-- 10
	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5
	; -- END VIEW

-- SELECT * FROM massoftware.v_CodigoPostal_1 LIMIT 100 OFFSET 0;

-- ---------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS massoftware.v_CodigoPostal_2 CASCADE;

CREATE OR REPLACE VIEW massoftware.v_CodigoPostal_2 AS

	SELECT
			  CodigoPostal.id AS CodigoPostal_id                             		-- 0
			, CodigoPostal.codigo AS CodigoPostal_codigo                     		-- 1
			, CodigoPostal.numero AS CodigoPostal_numero                     		-- 2
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           		-- 3
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           		-- 4
			, Ciudad.id AS Ciudad_id                                         		-- 5
			, Ciudad.numero AS Ciudad_numero                                 		-- 6
			, Ciudad.nombre AS Ciudad_nombre                                 		-- 7
			, Ciudad.departamento AS Ciudad_departamento                     		-- 8
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         		-- 9
			, Provincia.id AS Provincia_id                                   		-- 10
			, Provincia.numero AS Provincia_numero                           		-- 11
			, Provincia.nombre AS Provincia_nombre                           		-- 12
			, Provincia.abreviatura AS Provincia_abreviatura                 		-- 13
			, Provincia.numeroAFIP AS Provincia_numeroAFIP                   		-- 14
			, Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos		-- 15
			, Provincia.numeroRENATEA AS Provincia_numeroRENATEA             		-- 16
			, Provincia.pais AS Provincia_pais                               		-- 17
	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
	; -- END VIEW

-- SELECT * FROM massoftware.v_CodigoPostal_2 LIMIT 100 OFFSET 0;

-- ---------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS massoftware.v_CodigoPostal_3 CASCADE;

CREATE OR REPLACE VIEW massoftware.v_CodigoPostal_3 AS

	SELECT
			  CodigoPostal.id AS CodigoPostal_id                             		-- 0
			, CodigoPostal.codigo AS CodigoPostal_codigo                     		-- 1
			, CodigoPostal.numero AS CodigoPostal_numero                     		-- 2
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           		-- 3
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           		-- 4
			, Ciudad.id AS Ciudad_id                                         		-- 5
			, Ciudad.numero AS Ciudad_numero                                 		-- 6
			, Ciudad.nombre AS Ciudad_nombre                                 		-- 7
			, Ciudad.departamento AS Ciudad_departamento                     		-- 8
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         		-- 9
			, Provincia.id AS Provincia_id                                   		-- 10
			, Provincia.numero AS Provincia_numero                           		-- 11
			, Provincia.nombre AS Provincia_nombre                           		-- 12
			, Provincia.abreviatura AS Provincia_abreviatura                 		-- 13
			, Provincia.numeroAFIP AS Provincia_numeroAFIP                   		-- 14
			, Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos		-- 15
			, Provincia.numeroRENATEA AS Provincia_numeroRENATEA             		-- 16
			, Pais.id AS Pais_id                                             		-- 17
			, Pais.numero AS Pais_numero                                     		-- 18
			, Pais.nombre AS Pais_nombre                                     		-- 19
			, Pais.abreviatura AS Pais_abreviatura                           		-- 20
	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17
	; -- END VIEW

-- SELECT * FROM massoftware.v_CodigoPostal_3 LIMIT 100 OFFSET 0;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Transporte                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Transporte

-- ---------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS massoftware.v_Transporte_1 CASCADE;

CREATE OR REPLACE VIEW massoftware.v_Transporte_1 AS

	SELECT
			  Transporte.id AS Transporte_id                       		-- 0
			, Transporte.numero AS Transporte_numero               		-- 1
			, Transporte.nombre AS Transporte_nombre               		-- 2
			, Transporte.cuit AS Transporte_cuit                   		-- 3
			, Transporte.ingresosBrutos AS Transporte_ingresosBrutos		-- 4
			, Transporte.telefono AS Transporte_telefono           		-- 5
			, Transporte.fax AS Transporte_fax                     		-- 6
			, CodigoPostal.id AS CodigoPostal_id                   		-- 7
			, CodigoPostal.codigo AS CodigoPostal_codigo           		-- 8
			, CodigoPostal.numero AS CodigoPostal_numero           		-- 9
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 		-- 10
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 		-- 11
			, CodigoPostal.ciudad AS CodigoPostal_ciudad           		-- 12
			, Transporte.domicilio AS Transporte_domicilio         		-- 13
			, Transporte.comentario AS Transporte_comentario       		-- 14
	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
	; -- END VIEW

-- SELECT * FROM massoftware.v_Transporte_1 LIMIT 100 OFFSET 0;

-- ---------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS massoftware.v_Transporte_2 CASCADE;

CREATE OR REPLACE VIEW massoftware.v_Transporte_2 AS

	SELECT
			  Transporte.id AS Transporte_id                       		-- 0
			, Transporte.numero AS Transporte_numero               		-- 1
			, Transporte.nombre AS Transporte_nombre               		-- 2
			, Transporte.cuit AS Transporte_cuit                   		-- 3
			, Transporte.ingresosBrutos AS Transporte_ingresosBrutos		-- 4
			, Transporte.telefono AS Transporte_telefono           		-- 5
			, Transporte.fax AS Transporte_fax                     		-- 6
			, CodigoPostal.id AS CodigoPostal_id                   		-- 7
			, CodigoPostal.codigo AS CodigoPostal_codigo           		-- 8
			, CodigoPostal.numero AS CodigoPostal_numero           		-- 9
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 		-- 10
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 		-- 11
			, Ciudad.id AS Ciudad_id                               		-- 12
			, Ciudad.numero AS Ciudad_numero                       		-- 13
			, Ciudad.nombre AS Ciudad_nombre                       		-- 14
			, Ciudad.departamento AS Ciudad_departamento           		-- 15
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP               		-- 16
			, Ciudad.provincia AS Ciudad_provincia                 		-- 17
			, Transporte.domicilio AS Transporte_domicilio         		-- 18
			, Transporte.comentario AS Transporte_comentario       		-- 19
	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
	; -- END VIEW

-- SELECT * FROM massoftware.v_Transporte_2 LIMIT 100 OFFSET 0;

-- ---------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS massoftware.v_Transporte_3 CASCADE;

CREATE OR REPLACE VIEW massoftware.v_Transporte_3 AS

	SELECT
			  Transporte.id AS Transporte_id                                 		-- 0
			, Transporte.numero AS Transporte_numero                         		-- 1
			, Transporte.nombre AS Transporte_nombre                         		-- 2
			, Transporte.cuit AS Transporte_cuit                             		-- 3
			, Transporte.ingresosBrutos AS Transporte_ingresosBrutos         		-- 4
			, Transporte.telefono AS Transporte_telefono                     		-- 5
			, Transporte.fax AS Transporte_fax                               		-- 6
			, CodigoPostal.id AS CodigoPostal_id                             		-- 7
			, CodigoPostal.codigo AS CodigoPostal_codigo                     		-- 8
			, CodigoPostal.numero AS CodigoPostal_numero                     		-- 9
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           		-- 10
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           		-- 11
			, Ciudad.id AS Ciudad_id                                         		-- 12
			, Ciudad.numero AS Ciudad_numero                                 		-- 13
			, Ciudad.nombre AS Ciudad_nombre                                 		-- 14
			, Ciudad.departamento AS Ciudad_departamento                     		-- 15
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         		-- 16
			, Provincia.id AS Provincia_id                                   		-- 17
			, Provincia.numero AS Provincia_numero                           		-- 18
			, Provincia.nombre AS Provincia_nombre                           		-- 19
			, Provincia.abreviatura AS Provincia_abreviatura                 		-- 20
			, Provincia.numeroAFIP AS Provincia_numeroAFIP                   		-- 21
			, Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos		-- 22
			, Provincia.numeroRENATEA AS Provincia_numeroRENATEA             		-- 23
			, Provincia.pais AS Provincia_pais                               		-- 24
			, Transporte.domicilio AS Transporte_domicilio                   		-- 25
			, Transporte.comentario AS Transporte_comentario                 		-- 26
	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17
	; -- END VIEW

-- SELECT * FROM massoftware.v_Transporte_3 LIMIT 100 OFFSET 0;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Carga                                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Carga

-- ---------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS massoftware.v_Carga_1 CASCADE;

CREATE OR REPLACE VIEW massoftware.v_Carga_1 AS

	SELECT
			  Carga.id AS Carga_id                                 		-- 0
			, Carga.numero AS Carga_numero                         		-- 1
			, Carga.nombre AS Carga_nombre                         		-- 2
			, Transporte.id AS Transporte_id                       		-- 3
			, Transporte.numero AS Transporte_numero               		-- 4
			, Transporte.nombre AS Transporte_nombre               		-- 5
			, Transporte.cuit AS Transporte_cuit                   		-- 6
			, Transporte.ingresosBrutos AS Transporte_ingresosBrutos		-- 7
			, Transporte.telefono AS Transporte_telefono           		-- 8
			, Transporte.fax AS Transporte_fax                     		-- 9
			, Transporte.codigoPostal AS Transporte_codigoPostal   		-- 10
			, Transporte.domicilio AS Transporte_domicilio         		-- 11
			, Transporte.comentario AS Transporte_comentario       		-- 12
	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3
	; -- END VIEW

-- SELECT * FROM massoftware.v_Carga_1 LIMIT 100 OFFSET 0;

-- ---------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS massoftware.v_Carga_2 CASCADE;

CREATE OR REPLACE VIEW massoftware.v_Carga_2 AS

	SELECT
			  Carga.id AS Carga_id                                 		-- 0
			, Carga.numero AS Carga_numero                         		-- 1
			, Carga.nombre AS Carga_nombre                         		-- 2
			, Transporte.id AS Transporte_id                       		-- 3
			, Transporte.numero AS Transporte_numero               		-- 4
			, Transporte.nombre AS Transporte_nombre               		-- 5
			, Transporte.cuit AS Transporte_cuit                   		-- 6
			, Transporte.ingresosBrutos AS Transporte_ingresosBrutos		-- 7
			, Transporte.telefono AS Transporte_telefono           		-- 8
			, Transporte.fax AS Transporte_fax                     		-- 9
			, CodigoPostal.id AS CodigoPostal_id                   		-- 10
			, CodigoPostal.codigo AS CodigoPostal_codigo           		-- 11
			, CodigoPostal.numero AS CodigoPostal_numero           		-- 12
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 		-- 13
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 		-- 14
			, CodigoPostal.ciudad AS CodigoPostal_ciudad           		-- 15
			, Transporte.domicilio AS Transporte_domicilio         		-- 16
			, Transporte.comentario AS Transporte_comentario       		-- 17
	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
	; -- END VIEW

-- SELECT * FROM massoftware.v_Carga_2 LIMIT 100 OFFSET 0;

-- ---------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS massoftware.v_Carga_3 CASCADE;

CREATE OR REPLACE VIEW massoftware.v_Carga_3 AS

	SELECT
			  Carga.id AS Carga_id                                 		-- 0
			, Carga.numero AS Carga_numero                         		-- 1
			, Carga.nombre AS Carga_nombre                         		-- 2
			, Transporte.id AS Transporte_id                       		-- 3
			, Transporte.numero AS Transporte_numero               		-- 4
			, Transporte.nombre AS Transporte_nombre               		-- 5
			, Transporte.cuit AS Transporte_cuit                   		-- 6
			, Transporte.ingresosBrutos AS Transporte_ingresosBrutos		-- 7
			, Transporte.telefono AS Transporte_telefono           		-- 8
			, Transporte.fax AS Transporte_fax                     		-- 9
			, CodigoPostal.id AS CodigoPostal_id                   		-- 10
			, CodigoPostal.codigo AS CodigoPostal_codigo           		-- 11
			, CodigoPostal.numero AS CodigoPostal_numero           		-- 12
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 		-- 13
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 		-- 14
			, Ciudad.id AS Ciudad_id                               		-- 15
			, Ciudad.numero AS Ciudad_numero                       		-- 16
			, Ciudad.nombre AS Ciudad_nombre                       		-- 17
			, Ciudad.departamento AS Ciudad_departamento           		-- 18
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP               		-- 19
			, Ciudad.provincia AS Ciudad_provincia                 		-- 20
			, Transporte.domicilio AS Transporte_domicilio         		-- 21
			, Transporte.comentario AS Transporte_comentario       		-- 22
	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 15
	; -- END VIEW

-- SELECT * FROM massoftware.v_Carga_3 LIMIT 100 OFFSET 0;


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TransporteTarifa                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TransporteTarifa

-- ---------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS massoftware.v_TransporteTarifa_1 CASCADE;

CREATE OR REPLACE VIEW massoftware.v_TransporteTarifa_1 AS

	SELECT
			  TransporteTarifa.id AS TransporteTarifa_id                                         		-- 0
			, TransporteTarifa.numero AS TransporteTarifa_numero                                 		-- 1
			, Carga.id AS Carga_id                                                               		-- 2
			, Carga.numero AS Carga_numero                                                       		-- 3
			, Carga.nombre AS Carga_nombre                                                       		-- 4
			, Carga.transporte AS Carga_transporte                                               		-- 5
			, Ciudad.id AS Ciudad_id                                                             		-- 6
			, Ciudad.numero AS Ciudad_numero                                                     		-- 7
			, Ciudad.nombre AS Ciudad_nombre                                                     		-- 8
			, Ciudad.departamento AS Ciudad_departamento                                         		-- 9
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             		-- 10
			, Ciudad.provincia AS Ciudad_provincia                                               		-- 11
			, TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       		-- 12
			, TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion		-- 13
			, TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           		-- 14
			, TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     		-- 15
			, TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     		-- 16
			, TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         		-- 17
	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5
	; -- END VIEW

-- SELECT * FROM massoftware.v_TransporteTarifa_1 LIMIT 100 OFFSET 0;

-- ---------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS massoftware.v_TransporteTarifa_2 CASCADE;

CREATE OR REPLACE VIEW massoftware.v_TransporteTarifa_2 AS

	SELECT
			  TransporteTarifa.id AS TransporteTarifa_id                                         		-- 0
			, TransporteTarifa.numero AS TransporteTarifa_numero                                 		-- 1
			, Carga.id AS Carga_id                                                               		-- 2
			, Carga.numero AS Carga_numero                                                       		-- 3
			, Carga.nombre AS Carga_nombre                                                       		-- 4
			, Transporte.id AS Transporte_id                                                     		-- 5
			, Transporte.numero AS Transporte_numero                                             		-- 6
			, Transporte.nombre AS Transporte_nombre                                             		-- 7
			, Transporte.cuit AS Transporte_cuit                                                 		-- 8
			, Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             		-- 9
			, Transporte.telefono AS Transporte_telefono                                         		-- 10
			, Transporte.fax AS Transporte_fax                                                   		-- 11
			, Transporte.codigoPostal AS Transporte_codigoPostal                                 		-- 12
			, Transporte.domicilio AS Transporte_domicilio                                       		-- 13
			, Transporte.comentario AS Transporte_comentario                                     		-- 14
			, Ciudad.id AS Ciudad_id                                                             		-- 15
			, Ciudad.numero AS Ciudad_numero                                                     		-- 16
			, Ciudad.nombre AS Ciudad_nombre                                                     		-- 17
			, Ciudad.departamento AS Ciudad_departamento                                         		-- 18
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             		-- 19
			, Provincia.id AS Provincia_id                                                       		-- 20
			, Provincia.numero AS Provincia_numero                                               		-- 21
			, Provincia.nombre AS Provincia_nombre                                               		-- 22
			, Provincia.abreviatura AS Provincia_abreviatura                                     		-- 23
			, Provincia.numeroAFIP AS Provincia_numeroAFIP                                       		-- 24
			, Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   		-- 25
			, Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 		-- 26
			, Provincia.pais AS Provincia_pais                                                   		-- 27
			, TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       		-- 28
			, TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion		-- 29
			, TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           		-- 30
			, TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     		-- 31
			, TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     		-- 32
			, TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         		-- 33
	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19
	; -- END VIEW

-- SELECT * FROM massoftware.v_TransporteTarifa_2 LIMIT 100 OFFSET 0;

-- ---------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS massoftware.v_TransporteTarifa_3 CASCADE;

CREATE OR REPLACE VIEW massoftware.v_TransporteTarifa_3 AS

	SELECT
			  TransporteTarifa.id AS TransporteTarifa_id                                         		-- 0
			, TransporteTarifa.numero AS TransporteTarifa_numero                                 		-- 1
			, Carga.id AS Carga_id                                                               		-- 2
			, Carga.numero AS Carga_numero                                                       		-- 3
			, Carga.nombre AS Carga_nombre                                                       		-- 4
			, Transporte.id AS Transporte_id                                                     		-- 5
			, Transporte.numero AS Transporte_numero                                             		-- 6
			, Transporte.nombre AS Transporte_nombre                                             		-- 7
			, Transporte.cuit AS Transporte_cuit                                                 		-- 8
			, Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             		-- 9
			, Transporte.telefono AS Transporte_telefono                                         		-- 10
			, Transporte.fax AS Transporte_fax                                                   		-- 11
			, CodigoPostal.id AS CodigoPostal_id                                                 		-- 12
			, CodigoPostal.codigo AS CodigoPostal_codigo                                         		-- 13
			, CodigoPostal.numero AS CodigoPostal_numero                                         		-- 14
			, CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               		-- 15
			, CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               		-- 16
			, CodigoPostal.ciudad AS CodigoPostal_ciudad                                         		-- 17
			, Transporte.domicilio AS Transporte_domicilio                                       		-- 18
			, Transporte.comentario AS Transporte_comentario                                     		-- 19
			, Ciudad.id AS Ciudad_id                                                             		-- 20
			, Ciudad.numero AS Ciudad_numero                                                     		-- 21
			, Ciudad.nombre AS Ciudad_nombre                                                     		-- 22
			, Ciudad.departamento AS Ciudad_departamento                                         		-- 23
			, Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             		-- 24
			, Provincia.id AS Provincia_id                                                       		-- 25
			, Provincia.numero AS Provincia_numero                                               		-- 26
			, Provincia.nombre AS Provincia_nombre                                               		-- 27
			, Provincia.abreviatura AS Provincia_abreviatura                                     		-- 28
			, Provincia.numeroAFIP AS Provincia_numeroAFIP                                       		-- 29
			, Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   		-- 30
			, Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 		-- 31
			, Pais.id AS Pais_id                                                                 		-- 32
			, Pais.numero AS Pais_numero                                                         		-- 33
			, Pais.nombre AS Pais_nombre                                                         		-- 34
			, Pais.abreviatura AS Pais_abreviatura                                               		-- 35
			, TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       		-- 36
			, TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion		-- 37
			, TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           		-- 38
			, TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     		-- 39
			, TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     		-- 40
			, TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         		-- 41
	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31
	; -- END VIEW

-- SELECT * FROM massoftware.v_TransporteTarifa_3 LIMIT 100 OFFSET 0;






-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Moneda                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Moneda

-- ---------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS massoftware.v_Moneda_1 CASCADE;

CREATE OR REPLACE VIEW massoftware.v_Moneda_1 AS

	SELECT
			  Moneda.id AS Moneda_id                                   		-- 0
			, Moneda.numero AS Moneda_numero                           		-- 1
			, Moneda.nombre AS Moneda_nombre                           		-- 2
			, Moneda.abreviatura AS Moneda_abreviatura                 		-- 3
			, Moneda.cotizacion AS Moneda_cotizacion                   		-- 4
			, Moneda.cotizacionFecha AS Moneda_cotizacionFecha         		-- 5
			, Moneda.controlActualizacion AS Moneda_controlActualizacion		-- 6
			, MonedaAFIP.id AS MonedaAFIP_id                           		-- 7
			, MonedaAFIP.codigo AS MonedaAFIP_codigo                   		-- 8
			, MonedaAFIP.nombre AS MonedaAFIP_nombre                   		-- 9
	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7
	; -- END VIEW

-- SELECT * FROM massoftware.v_Moneda_1 LIMIT 100 OFFSET 0;










-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoBloqueoCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoBloqueoCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP VIEW IF EXISTS massoftware.v_MotivoBloqueoCliente_1 CASCADE;

CREATE OR REPLACE VIEW massoftware.v_MotivoBloqueoCliente_1 AS

	SELECT
			  MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       		-- 0
			, MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero		-- 1
			, MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre		-- 2
			, ClasificacionCliente.id AS ClasificacionCliente_id       		-- 3
			, ClasificacionCliente.numero AS ClasificacionCliente_numero		-- 4
			, ClasificacionCliente.nombre AS ClasificacionCliente_nombre		-- 5
			, ClasificacionCliente.color AS ClasificacionCliente_color 		-- 6
	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3
	; -- END VIEW

-- SELECT * FROM massoftware.v_MotivoBloqueoCliente_1 LIMIT 100 OFFSET 0;