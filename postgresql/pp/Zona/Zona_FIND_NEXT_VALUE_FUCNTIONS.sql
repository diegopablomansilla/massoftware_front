
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Zona                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Zona

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Zona_bonificacion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Zona_bonificacion() RETURNS DECIMAL AS $$

	SELECT (COALESCE(MAX(bonificacion),0) + 1)::DECIMAL
	FROM	massoftware.Zona;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_Zona_bonificacion();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Zona_recargo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Zona_recargo() RETURNS DECIMAL AS $$

	SELECT (COALESCE(MAX(recargo),0) + 1)::DECIMAL
	FROM	massoftware.Zona;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_Zona_recargo();

*/