
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CodigoPostal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CodigoPostal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_CodigoPostal_level_1 CASCADE;

CREATE TYPE massoftware.type_CodigoPostal_level_1(

		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_CodigoPostal_level_2 CASCADE;

CREATE TYPE massoftware.type_CodigoPostal_level_2(

		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_CodigoPostal_level_3 CASCADE;

CREATE TYPE massoftware.type_CodigoPostal_level_3(

		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
);