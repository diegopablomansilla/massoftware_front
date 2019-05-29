
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TransporteTarifa                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TransporteTarifa

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_TransporteTarifa_level_1 CASCADE;

CREATE TYPE massoftware.type_TransporteTarifa_level_1(

		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_TransporteTarifa_level_2 CASCADE;

CREATE TYPE massoftware.type_TransporteTarifa_level_2(

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
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_TransporteTarifa_level_3 CASCADE;

CREATE TYPE massoftware.type_TransporteTarifa_level_3(

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
);