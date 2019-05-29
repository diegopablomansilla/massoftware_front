
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Ciudad                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Ciudad

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Ciudad_level_1 CASCADE;

CREATE TYPE massoftware.type_Ciudad_level_1(

		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Ciudad_level_2 CASCADE;

CREATE TYPE massoftware.type_Ciudad_level_2(

		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
);