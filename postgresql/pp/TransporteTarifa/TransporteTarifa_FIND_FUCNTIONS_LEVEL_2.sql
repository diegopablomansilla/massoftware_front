
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TransporteTarifa                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TransporteTarifa

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.carga ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.carga DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.carga ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.carga DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.ciudad ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.ciudad DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.ciudad ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.ciudad DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.precioFlete ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.precioFlete DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.precioFlete ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.precioFlete DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.precioUnidadFacturacion ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.precioUnidadFacturacion DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.precioUnidadFacturacion ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.precioUnidadFacturacion DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.precioUnidadStock ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.precioUnidadStock DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.precioUnidadStock ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.precioUnidadStock DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.precioBultos ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.precioBultos DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.precioBultos ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.precioBultos DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.importeMinimoEntrega ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.importeMinimoEntrega DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.importeMinimoEntrega ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.importeMinimoEntrega DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.importeMinimoCarga ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_2(
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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.importeMinimoCarga DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.importeMinimoCarga ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_2(

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
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
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

	ORDER BY TransporteTarifa.importeMinimoCarga DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_2(
);

*/