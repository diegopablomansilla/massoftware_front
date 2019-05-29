
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Provincia                                                                                              //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Provincia

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Provincia_level_1 CASCADE;

CREATE TYPE massoftware.type_Provincia_level_1(

		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
);