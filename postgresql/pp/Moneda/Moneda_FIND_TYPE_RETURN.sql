
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Moneda                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Moneda

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Moneda_level_1 CASCADE;

CREATE TYPE massoftware.type_Moneda_level_1(

		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(13, 5)  	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
);