
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Moneda                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Moneda

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Moneda_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Moneda_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER
	FROM	massoftware.Moneda;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_Moneda_numero();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Moneda_cotizacion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Moneda_cotizacion() RETURNS DECIMAL AS $$

	SELECT (COALESCE(MAX(cotizacion),0) + 1)::DECIMAL
	FROM	massoftware.Moneda;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_Moneda_cotizacion();

*/