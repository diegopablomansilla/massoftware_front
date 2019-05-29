
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: NotaCreditoMotivo                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.NotaCreditoMotivo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_NotaCreditoMotivo_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_NotaCreditoMotivo_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER
	FROM	massoftware.NotaCreditoMotivo;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_NotaCreditoMotivo_numero();

*/