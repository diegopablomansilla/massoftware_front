


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Provincia                                                                                              //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Provincia

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Provincia_level_1 CASCADE;

CREATE TYPE massoftware.type_Provincia_level_1 AS (

		  Provincia_id VARCHAR(36)             				-- 0
		, Provincia_numero INTEGER             				-- 1
		, Provincia_nombre VARCHAR(50)(50)     				-- 2
		, Provincia_abreviatura VARCHAR(5)(5)  				-- 3
		, Provincia_numeroAFIP INTEGER         				-- 4
		, Provincia_numeroIngresosBrutos INTEGER				-- 5
		, Provincia_numeroRENATEA INTEGER      				-- 6
		, Pais_id VARCHAR(36)                  				-- 7
		, Pais_numero INTEGER                  				-- 8
		, Pais_nombre VARCHAR(50)(50)          				-- 9
		, Pais_abreviatura VARCHAR(5)(5)       				-- 10
);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Ciudad                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Ciudad

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Ciudad_level_1 CASCADE;

CREATE TYPE massoftware.type_Ciudad_level_1 AS (

		  Ciudad_id VARCHAR(36)                				-- 0
		, Ciudad_numero INTEGER                				-- 1
		, Ciudad_nombre VARCHAR(50)(50)        				-- 2
		, Ciudad_departamento VARCHAR(50)(50)  				-- 3
		, Ciudad_numeroAFIP INTEGER            				-- 4
		, Provincia_id VARCHAR(36)             				-- 5
		, Provincia_numero INTEGER             				-- 6
		, Provincia_nombre VARCHAR(50)(50)     				-- 7
		, Provincia_abreviatura VARCHAR(5)(5)  				-- 8
		, Provincia_numeroAFIP INTEGER         				-- 9
		, Provincia_numeroIngresosBrutos INTEGER				-- 10
		, Provincia_numeroRENATEA INTEGER      				-- 11
		, Provincia_pais VARCHAR(36)           				-- 12
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Ciudad_level_2 CASCADE;

CREATE TYPE massoftware.type_Ciudad_level_2 AS (

		  Ciudad_id VARCHAR(36)                				-- 0
		, Ciudad_numero INTEGER                				-- 1
		, Ciudad_nombre VARCHAR(50)(50)        				-- 2
		, Ciudad_departamento VARCHAR(50)(50)  				-- 3
		, Ciudad_numeroAFIP INTEGER            				-- 4
		, Provincia_id VARCHAR(36)             				-- 5
		, Provincia_numero INTEGER             				-- 6
		, Provincia_nombre VARCHAR(50)(50)     				-- 7
		, Provincia_abreviatura VARCHAR(5)(5)  				-- 8
		, Provincia_numeroAFIP INTEGER         				-- 9
		, Provincia_numeroIngresosBrutos INTEGER				-- 10
		, Provincia_numeroRENATEA INTEGER      				-- 11
		, Pais_id VARCHAR(36)                  				-- 12
		, Pais_numero INTEGER                  				-- 13
		, Pais_nombre VARCHAR(50)(50)          				-- 14
		, Pais_abreviatura VARCHAR(5)(5)       				-- 15
);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CodigoPostal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CodigoPostal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_CodigoPostal_level_1 CASCADE;

CREATE TYPE massoftware.type_CodigoPostal_level_1 AS (

		  CodigoPostal_id VARCHAR(36)              				-- 0
		, CodigoPostal_codigo VARCHAR(12)(12)      				-- 1
		, CodigoPostal_numero INTEGER              				-- 2
		, CodigoPostal_nombreCalle VARCHAR(200)(200)				-- 3
		, CodigoPostal_numeroCalle VARCHAR(20)(20) 				-- 4
		, Ciudad_id VARCHAR(36)                    				-- 5
		, Ciudad_numero INTEGER                    				-- 6
		, Ciudad_nombre VARCHAR(50)(50)            				-- 7
		, Ciudad_departamento VARCHAR(50)(50)      				-- 8
		, Ciudad_numeroAFIP INTEGER                				-- 9
		, Ciudad_provincia VARCHAR(36)             				-- 10
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_CodigoPostal_level_2 CASCADE;

CREATE TYPE massoftware.type_CodigoPostal_level_2 AS (

		  CodigoPostal_id VARCHAR(36)              				-- 0
		, CodigoPostal_codigo VARCHAR(12)(12)      				-- 1
		, CodigoPostal_numero INTEGER              				-- 2
		, CodigoPostal_nombreCalle VARCHAR(200)(200)				-- 3
		, CodigoPostal_numeroCalle VARCHAR(20)(20) 				-- 4
		, Ciudad_id VARCHAR(36)                    				-- 5
		, Ciudad_numero INTEGER                    				-- 6
		, Ciudad_nombre VARCHAR(50)(50)            				-- 7
		, Ciudad_departamento VARCHAR(50)(50)      				-- 8
		, Ciudad_numeroAFIP INTEGER                				-- 9
		, Provincia_id VARCHAR(36)                 				-- 10
		, Provincia_numero INTEGER                 				-- 11
		, Provincia_nombre VARCHAR(50)(50)         				-- 12
		, Provincia_abreviatura VARCHAR(5)(5)      				-- 13
		, Provincia_numeroAFIP INTEGER             				-- 14
		, Provincia_numeroIngresosBrutos INTEGER   				-- 15
		, Provincia_numeroRENATEA INTEGER          				-- 16
		, Provincia_pais VARCHAR(36)               				-- 17
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_CodigoPostal_level_3 CASCADE;

CREATE TYPE massoftware.type_CodigoPostal_level_3 AS (

		  CodigoPostal_id VARCHAR(36)              				-- 0
		, CodigoPostal_codigo VARCHAR(12)(12)      				-- 1
		, CodigoPostal_numero INTEGER              				-- 2
		, CodigoPostal_nombreCalle VARCHAR(200)(200)				-- 3
		, CodigoPostal_numeroCalle VARCHAR(20)(20) 				-- 4
		, Ciudad_id VARCHAR(36)                    				-- 5
		, Ciudad_numero INTEGER                    				-- 6
		, Ciudad_nombre VARCHAR(50)(50)            				-- 7
		, Ciudad_departamento VARCHAR(50)(50)      				-- 8
		, Ciudad_numeroAFIP INTEGER                				-- 9
		, Provincia_id VARCHAR(36)                 				-- 10
		, Provincia_numero INTEGER                 				-- 11
		, Provincia_nombre VARCHAR(50)(50)         				-- 12
		, Provincia_abreviatura VARCHAR(5)(5)      				-- 13
		, Provincia_numeroAFIP INTEGER             				-- 14
		, Provincia_numeroIngresosBrutos INTEGER   				-- 15
		, Provincia_numeroRENATEA INTEGER          				-- 16
		, Pais_id VARCHAR(36)                      				-- 17
		, Pais_numero INTEGER                      				-- 18
		, Pais_nombre VARCHAR(50)(50)              				-- 19
		, Pais_abreviatura VARCHAR(5)(5)           				-- 20
);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Transporte                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Transporte

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Transporte_level_1 CASCADE;

CREATE TYPE massoftware.type_Transporte_level_1 AS (

		  Transporte_id VARCHAR(36)                				-- 0
		, Transporte_numero INTEGER                				-- 1
		, Transporte_nombre VARCHAR(50)(50)        				-- 2
		, Transporte_cuit BIGINT                   				-- 3
		, Transporte_ingresosBrutos VARCHAR(13)(13)				-- 4
		, Transporte_telefono VARCHAR(50)(50)      				-- 5
		, Transporte_fax VARCHAR(50)(50)           				-- 6
		, CodigoPostal_id VARCHAR(36)              				-- 7
		, CodigoPostal_codigo VARCHAR(12)(12)      				-- 8
		, CodigoPostal_numero INTEGER              				-- 9
		, CodigoPostal_nombreCalle VARCHAR(200)(200)				-- 10
		, CodigoPostal_numeroCalle VARCHAR(20)(20) 				-- 11
		, CodigoPostal_ciudad VARCHAR(36)          				-- 12
		, Transporte_domicilio VARCHAR(150)(150)   				-- 13
		, Transporte_comentario VARCHAR(300)(300)  				-- 14
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Transporte_level_2 CASCADE;

CREATE TYPE massoftware.type_Transporte_level_2 AS (

		  Transporte_id VARCHAR(36)                				-- 0
		, Transporte_numero INTEGER                				-- 1
		, Transporte_nombre VARCHAR(50)(50)        				-- 2
		, Transporte_cuit BIGINT                   				-- 3
		, Transporte_ingresosBrutos VARCHAR(13)(13)				-- 4
		, Transporte_telefono VARCHAR(50)(50)      				-- 5
		, Transporte_fax VARCHAR(50)(50)           				-- 6
		, CodigoPostal_id VARCHAR(36)              				-- 7
		, CodigoPostal_codigo VARCHAR(12)(12)      				-- 8
		, CodigoPostal_numero INTEGER              				-- 9
		, CodigoPostal_nombreCalle VARCHAR(200)(200)				-- 10
		, CodigoPostal_numeroCalle VARCHAR(20)(20) 				-- 11
		, Ciudad_id VARCHAR(36)                    				-- 12
		, Ciudad_numero INTEGER                    				-- 13
		, Ciudad_nombre VARCHAR(50)(50)            				-- 14
		, Ciudad_departamento VARCHAR(50)(50)      				-- 15
		, Ciudad_numeroAFIP INTEGER                				-- 16
		, Ciudad_provincia VARCHAR(36)             				-- 17
		, Transporte_domicilio VARCHAR(150)(150)   				-- 18
		, Transporte_comentario VARCHAR(300)(300)  				-- 19
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Transporte_level_3 CASCADE;

CREATE TYPE massoftware.type_Transporte_level_3 AS (

		  Transporte_id VARCHAR(36)                				-- 0
		, Transporte_numero INTEGER                				-- 1
		, Transporte_nombre VARCHAR(50)(50)        				-- 2
		, Transporte_cuit BIGINT                   				-- 3
		, Transporte_ingresosBrutos VARCHAR(13)(13)				-- 4
		, Transporte_telefono VARCHAR(50)(50)      				-- 5
		, Transporte_fax VARCHAR(50)(50)           				-- 6
		, CodigoPostal_id VARCHAR(36)              				-- 7
		, CodigoPostal_codigo VARCHAR(12)(12)      				-- 8
		, CodigoPostal_numero INTEGER              				-- 9
		, CodigoPostal_nombreCalle VARCHAR(200)(200)				-- 10
		, CodigoPostal_numeroCalle VARCHAR(20)(20) 				-- 11
		, Ciudad_id VARCHAR(36)                    				-- 12
		, Ciudad_numero INTEGER                    				-- 13
		, Ciudad_nombre VARCHAR(50)(50)            				-- 14
		, Ciudad_departamento VARCHAR(50)(50)      				-- 15
		, Ciudad_numeroAFIP INTEGER                				-- 16
		, Provincia_id VARCHAR(36)                 				-- 17
		, Provincia_numero INTEGER                 				-- 18
		, Provincia_nombre VARCHAR(50)(50)         				-- 19
		, Provincia_abreviatura VARCHAR(5)(5)      				-- 20
		, Provincia_numeroAFIP INTEGER             				-- 21
		, Provincia_numeroIngresosBrutos INTEGER   				-- 22
		, Provincia_numeroRENATEA INTEGER          				-- 23
		, Provincia_pais VARCHAR(36)               				-- 24
		, Transporte_domicilio VARCHAR(150)(150)   				-- 25
		, Transporte_comentario VARCHAR(300)(300)  				-- 26
);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Carga                                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Carga

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Carga_level_1 CASCADE;

CREATE TYPE massoftware.type_Carga_level_1 AS (

		  Carga_id VARCHAR(36)                    				-- 0
		, Carga_numero INTEGER                    				-- 1
		, Carga_nombre VARCHAR(50)(50)            				-- 2
		, Transporte_id VARCHAR(36)               				-- 3
		, Transporte_numero INTEGER               				-- 4
		, Transporte_nombre VARCHAR(50)(50)       				-- 5
		, Transporte_cuit BIGINT                  				-- 6
		, Transporte_ingresosBrutos VARCHAR(13)(13)				-- 7
		, Transporte_telefono VARCHAR(50)(50)     				-- 8
		, Transporte_fax VARCHAR(50)(50)          				-- 9
		, Transporte_codigoPostal VARCHAR(36)     				-- 10
		, Transporte_domicilio VARCHAR(150)(150)  				-- 11
		, Transporte_comentario VARCHAR(300)(300) 				-- 12
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Carga_level_2 CASCADE;

CREATE TYPE massoftware.type_Carga_level_2 AS (

		  Carga_id VARCHAR(36)                     				-- 0
		, Carga_numero INTEGER                     				-- 1
		, Carga_nombre VARCHAR(50)(50)             				-- 2
		, Transporte_id VARCHAR(36)                				-- 3
		, Transporte_numero INTEGER                				-- 4
		, Transporte_nombre VARCHAR(50)(50)        				-- 5
		, Transporte_cuit BIGINT                   				-- 6
		, Transporte_ingresosBrutos VARCHAR(13)(13)				-- 7
		, Transporte_telefono VARCHAR(50)(50)      				-- 8
		, Transporte_fax VARCHAR(50)(50)           				-- 9
		, CodigoPostal_id VARCHAR(36)              				-- 10
		, CodigoPostal_codigo VARCHAR(12)(12)      				-- 11
		, CodigoPostal_numero INTEGER              				-- 12
		, CodigoPostal_nombreCalle VARCHAR(200)(200)				-- 13
		, CodigoPostal_numeroCalle VARCHAR(20)(20) 				-- 14
		, CodigoPostal_ciudad VARCHAR(36)          				-- 15
		, Transporte_domicilio VARCHAR(150)(150)   				-- 16
		, Transporte_comentario VARCHAR(300)(300)  				-- 17
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Carga_level_3 CASCADE;

CREATE TYPE massoftware.type_Carga_level_3 AS (

		  Carga_id VARCHAR(36)                     				-- 0
		, Carga_numero INTEGER                     				-- 1
		, Carga_nombre VARCHAR(50)(50)             				-- 2
		, Transporte_id VARCHAR(36)                				-- 3
		, Transporte_numero INTEGER                				-- 4
		, Transporte_nombre VARCHAR(50)(50)        				-- 5
		, Transporte_cuit BIGINT                   				-- 6
		, Transporte_ingresosBrutos VARCHAR(13)(13)				-- 7
		, Transporte_telefono VARCHAR(50)(50)      				-- 8
		, Transporte_fax VARCHAR(50)(50)           				-- 9
		, CodigoPostal_id VARCHAR(36)              				-- 10
		, CodigoPostal_codigo VARCHAR(12)(12)      				-- 11
		, CodigoPostal_numero INTEGER              				-- 12
		, CodigoPostal_nombreCalle VARCHAR(200)(200)				-- 13
		, CodigoPostal_numeroCalle VARCHAR(20)(20) 				-- 14
		, Ciudad_id VARCHAR(36)                    				-- 15
		, Ciudad_numero INTEGER                    				-- 16
		, Ciudad_nombre VARCHAR(50)(50)            				-- 17
		, Ciudad_departamento VARCHAR(50)(50)      				-- 18
		, Ciudad_numeroAFIP INTEGER                				-- 19
		, Ciudad_provincia VARCHAR(36)             				-- 20
		, Transporte_domicilio VARCHAR(150)(150)   				-- 21
		, Transporte_comentario VARCHAR(300)(300)  				-- 22
);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TransporteTarifa                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TransporteTarifa

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_TransporteTarifa_level_1 CASCADE;

CREATE TYPE massoftware.type_TransporteTarifa_level_1 AS (

		  TransporteTarifa_id VARCHAR(36)                             				-- 0
		, TransporteTarifa_numero INTEGER                             				-- 1
		, Carga_id VARCHAR(36)                                        				-- 2
		, Carga_numero INTEGER                                        				-- 3
		, Carga_nombre VARCHAR(50)(50)                                				-- 4
		, Carga_transporte VARCHAR(36)                                				-- 5
		, Ciudad_id VARCHAR(36)                                       				-- 6
		, Ciudad_numero INTEGER                                       				-- 7
		, Ciudad_nombre VARCHAR(50)(50)                               				-- 8
		, Ciudad_departamento VARCHAR(50)(50)                         				-- 9
		, Ciudad_numeroAFIP INTEGER                                   				-- 10
		, Ciudad_provincia VARCHAR(36)                                				-- 11
		, TransporteTarifa_precioFlete DECIMAL(13,5)(13, 5)           				-- 12
		, TransporteTarifa_precioUnidadFacturacion DECIMAL(13,5)(13, 5)				-- 13
		, TransporteTarifa_precioUnidadStock DECIMAL(13,5)(13, 5)     				-- 14
		, TransporteTarifa_precioBultos DECIMAL(13,5)(13, 5)          				-- 15
		, TransporteTarifa_importeMinimoEntrega DECIMAL(13,5)(13, 5)  				-- 16
		, TransporteTarifa_importeMinimoCarga DECIMAL(13,5)(13, 5)    				-- 17
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_TransporteTarifa_level_2 CASCADE;

CREATE TYPE massoftware.type_TransporteTarifa_level_2 AS (

		  TransporteTarifa_id VARCHAR(36)                             				-- 0
		, TransporteTarifa_numero INTEGER                             				-- 1
		, Carga_id VARCHAR(36)                                        				-- 2
		, Carga_numero INTEGER                                        				-- 3
		, Carga_nombre VARCHAR(50)(50)                                				-- 4
		, Transporte_id VARCHAR(36)                                   				-- 5
		, Transporte_numero INTEGER                                   				-- 6
		, Transporte_nombre VARCHAR(50)(50)                           				-- 7
		, Transporte_cuit BIGINT                                      				-- 8
		, Transporte_ingresosBrutos VARCHAR(13)(13)                   				-- 9
		, Transporte_telefono VARCHAR(50)(50)                         				-- 10
		, Transporte_fax VARCHAR(50)(50)                              				-- 11
		, Transporte_codigoPostal VARCHAR(36)                         				-- 12
		, Transporte_domicilio VARCHAR(150)(150)                      				-- 13
		, Transporte_comentario VARCHAR(300)(300)                     				-- 14
		, Ciudad_id VARCHAR(36)                                       				-- 15
		, Ciudad_numero INTEGER                                       				-- 16
		, Ciudad_nombre VARCHAR(50)(50)                               				-- 17
		, Ciudad_departamento VARCHAR(50)(50)                         				-- 18
		, Ciudad_numeroAFIP INTEGER                                   				-- 19
		, Provincia_id VARCHAR(36)                                    				-- 20
		, Provincia_numero INTEGER                                    				-- 21
		, Provincia_nombre VARCHAR(50)(50)                            				-- 22
		, Provincia_abreviatura VARCHAR(5)(5)                         				-- 23
		, Provincia_numeroAFIP INTEGER                                				-- 24
		, Provincia_numeroIngresosBrutos INTEGER                      				-- 25
		, Provincia_numeroRENATEA INTEGER                             				-- 26
		, Provincia_pais VARCHAR(36)                                  				-- 27
		, TransporteTarifa_precioFlete DECIMAL(13,5)(13, 5)           				-- 28
		, TransporteTarifa_precioUnidadFacturacion DECIMAL(13,5)(13, 5)				-- 29
		, TransporteTarifa_precioUnidadStock DECIMAL(13,5)(13, 5)     				-- 30
		, TransporteTarifa_precioBultos DECIMAL(13,5)(13, 5)          				-- 31
		, TransporteTarifa_importeMinimoEntrega DECIMAL(13,5)(13, 5)  				-- 32
		, TransporteTarifa_importeMinimoCarga DECIMAL(13,5)(13, 5)    				-- 33
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_TransporteTarifa_level_3 CASCADE;

CREATE TYPE massoftware.type_TransporteTarifa_level_3 AS (

		  TransporteTarifa_id VARCHAR(36)                             				-- 0
		, TransporteTarifa_numero INTEGER                             				-- 1
		, Carga_id VARCHAR(36)                                        				-- 2
		, Carga_numero INTEGER                                        				-- 3
		, Carga_nombre VARCHAR(50)(50)                                				-- 4
		, Transporte_id VARCHAR(36)                                   				-- 5
		, Transporte_numero INTEGER                                   				-- 6
		, Transporte_nombre VARCHAR(50)(50)                           				-- 7
		, Transporte_cuit BIGINT                                      				-- 8
		, Transporte_ingresosBrutos VARCHAR(13)(13)                   				-- 9
		, Transporte_telefono VARCHAR(50)(50)                         				-- 10
		, Transporte_fax VARCHAR(50)(50)                              				-- 11
		, CodigoPostal_id VARCHAR(36)                                 				-- 12
		, CodigoPostal_codigo VARCHAR(12)(12)                         				-- 13
		, CodigoPostal_numero INTEGER                                 				-- 14
		, CodigoPostal_nombreCalle VARCHAR(200)(200)                  				-- 15
		, CodigoPostal_numeroCalle VARCHAR(20)(20)                    				-- 16
		, CodigoPostal_ciudad VARCHAR(36)                             				-- 17
		, Transporte_domicilio VARCHAR(150)(150)                      				-- 18
		, Transporte_comentario VARCHAR(300)(300)                     				-- 19
		, Ciudad_id VARCHAR(36)                                       				-- 20
		, Ciudad_numero INTEGER                                       				-- 21
		, Ciudad_nombre VARCHAR(50)(50)                               				-- 22
		, Ciudad_departamento VARCHAR(50)(50)                         				-- 23
		, Ciudad_numeroAFIP INTEGER                                   				-- 24
		, Provincia_id VARCHAR(36)                                    				-- 25
		, Provincia_numero INTEGER                                    				-- 26
		, Provincia_nombre VARCHAR(50)(50)                            				-- 27
		, Provincia_abreviatura VARCHAR(5)(5)                         				-- 28
		, Provincia_numeroAFIP INTEGER                                				-- 29
		, Provincia_numeroIngresosBrutos INTEGER                      				-- 30
		, Provincia_numeroRENATEA INTEGER                             				-- 31
		, Pais_id VARCHAR(36)                                         				-- 32
		, Pais_numero INTEGER                                         				-- 33
		, Pais_nombre VARCHAR(50)(50)                                 				-- 34
		, Pais_abreviatura VARCHAR(5)(5)                              				-- 35
		, TransporteTarifa_precioFlete DECIMAL(13,5)(13, 5)           				-- 36
		, TransporteTarifa_precioUnidadFacturacion DECIMAL(13,5)(13, 5)				-- 37
		, TransporteTarifa_precioUnidadStock DECIMAL(13,5)(13, 5)     				-- 38
		, TransporteTarifa_precioBultos DECIMAL(13,5)(13, 5)          				-- 39
		, TransporteTarifa_importeMinimoEntrega DECIMAL(13,5)(13, 5)  				-- 40
		, TransporteTarifa_importeMinimoCarga DECIMAL(13,5)(13, 5)    				-- 41
);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Moneda                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Moneda

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Moneda_level_1 CASCADE;

CREATE TYPE massoftware.type_Moneda_level_1 AS (

		  Moneda_id VARCHAR(36)                				-- 0
		, Moneda_numero INTEGER                				-- 1
		, Moneda_nombre VARCHAR(50)(50)        				-- 2
		, Moneda_abreviatura VARCHAR(5)(5)     				-- 3
		, Moneda_cotizacion DECIMAL(13,5)(13, 5)				-- 4
		, Moneda_cotizacionFecha TIMESTAMP     				-- 5
		, Moneda_controlActualizacion BOOLEAN  				-- 6
		, MonedaAFIP_id VARCHAR(36)            				-- 7
		, MonedaAFIP_codigo VARCHAR(3)(3)      				-- 8
		, MonedaAFIP_nombre VARCHAR(50)(50)    				-- 9
);


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoBloqueoCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoBloqueoCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_MotivoBloqueoCliente_level_1 CASCADE;

CREATE TYPE massoftware.type_MotivoBloqueoCliente_level_1 AS (

		  MotivoBloqueoCliente_id VARCHAR(36)       				-- 0
		, MotivoBloqueoCliente_numero INTEGER       				-- 1
		, MotivoBloqueoCliente_nombre VARCHAR(50)(50)				-- 2
		, ClasificacionCliente_id VARCHAR(36)       				-- 3
		, ClasificacionCliente_numero INTEGER       				-- 4
		, ClasificacionCliente_nombre VARCHAR(50)(50)				-- 5
		, ClasificacionCliente_color INTEGER        				-- 6
);