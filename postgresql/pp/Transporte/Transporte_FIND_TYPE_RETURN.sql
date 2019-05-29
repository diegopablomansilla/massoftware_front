
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Transporte                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Transporte

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Transporte_level_1 CASCADE;

CREATE TYPE massoftware.type_Transporte_level_1(

		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Transporte_level_2 CASCADE;

CREATE TYPE massoftware.type_Transporte_level_2(

		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Ciudad_id VARCHAR(36)               	-- 12
		,Ciudad_numero INTEGER               	-- 13
		,Ciudad_nombre VARCHAR(50)           	-- 14
		,Ciudad_departamento VARCHAR(50)     	-- 15
		,Ciudad_numeroAFIP INTEGER           	-- 16
		,Transporte_domicilio VARCHAR(150)   	-- 17
		,Transporte_comentario VARCHAR(300)  	-- 18
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Transporte_level_3 CASCADE;

CREATE TYPE massoftware.type_Transporte_level_3(

		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
);