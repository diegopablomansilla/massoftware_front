
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Carga                                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Carga

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Carga_level_1 CASCADE;

CREATE TYPE massoftware.type_Carga_level_1(

		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Carga_level_2 CASCADE;

CREATE TYPE massoftware.type_Carga_level_2(

		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Transporte_domicilio VARCHAR(150)   	-- 15
		,Transporte_comentario VARCHAR(300)  	-- 16
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Carga_level_3 CASCADE;

CREATE TYPE massoftware.type_Carga_level_3(

		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Ciudad_id VARCHAR(36)               	-- 15
		,Ciudad_numero INTEGER               	-- 16
		,Ciudad_nombre VARCHAR(50)           	-- 17
		,Ciudad_departamento VARCHAR(50)     	-- 18
		,Ciudad_numeroAFIP INTEGER           	-- 19
		,Transporte_domicilio VARCHAR(150)   	-- 20
		,Transporte_comentario VARCHAR(300)  	-- 21
);