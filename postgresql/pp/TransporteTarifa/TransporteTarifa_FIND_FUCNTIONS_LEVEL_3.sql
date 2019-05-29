
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TransporteTarifa                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TransporteTarifa

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.carga ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.carga DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.carga ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.carga DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.ciudad ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.ciudad DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.ciudad ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.ciudad DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.precioFlete ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.precioFlete DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.precioFlete ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.precioFlete DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.precioUnidadFacturacion ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.precioUnidadFacturacion DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.precioUnidadFacturacion ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.precioUnidadFacturacion DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.precioUnidadStock ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.precioUnidadStock DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.precioUnidadStock ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.precioUnidadStock DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.precioBultos ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.precioBultos DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.precioBultos ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.precioBultos DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.importeMinimoEntrega ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.importeMinimoEntrega DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.importeMinimoEntrega ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.importeMinimoEntrega DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.importeMinimoCarga ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.importeMinimoCarga DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.importeMinimoCarga ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

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

	ORDER BY TransporteTarifa.importeMinimoCarga DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_3(
);

*/