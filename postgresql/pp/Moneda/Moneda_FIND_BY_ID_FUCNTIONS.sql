
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Moneda                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Moneda

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaById(idArg VARCHAR(36)) RETURNS massoftware.Moneda AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Moneda.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_MonedaById('xxx');

-- SELECT * FROM massoftware.f_MonedaById((SELECT Moneda.id FROM massoftware.Moneda LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaById_1(idArg VARCHAR(36)) RETURNS massoftware.type_Moneda_level_1 AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Moneda.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_MonedaById_1('xxx');

-- SELECT * FROM massoftware.f_MonedaById_1((SELECT Moneda.id FROM massoftware.Moneda LIMIT 1)::VARCHAR);