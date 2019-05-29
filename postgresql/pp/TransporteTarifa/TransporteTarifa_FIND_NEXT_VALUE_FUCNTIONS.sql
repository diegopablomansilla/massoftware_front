
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TransporteTarifa                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TransporteTarifa

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER
	FROM	massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_TransporteTarifa_numero();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_precioFlete() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_precioFlete() RETURNS DECIMAL AS $$

	SELECT (COALESCE(MAX(precioFlete),0) + 1)::DECIMAL
	FROM	massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_TransporteTarifa_precioFlete();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_precioUnidadFacturacion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_precioUnidadFacturacion() RETURNS DECIMAL AS $$

	SELECT (COALESCE(MAX(precioUnidadFacturacion),0) + 1)::DECIMAL
	FROM	massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_TransporteTarifa_precioUnidadFacturacion();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_precioUnidadStock() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_precioUnidadStock() RETURNS DECIMAL AS $$

	SELECT (COALESCE(MAX(precioUnidadStock),0) + 1)::DECIMAL
	FROM	massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_TransporteTarifa_precioUnidadStock();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_precioBultos() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_precioBultos() RETURNS DECIMAL AS $$

	SELECT (COALESCE(MAX(precioBultos),0) + 1)::DECIMAL
	FROM	massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_TransporteTarifa_precioBultos();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_importeMinimoEntrega() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_importeMinimoEntrega() RETURNS DECIMAL AS $$

	SELECT (COALESCE(MAX(importeMinimoEntrega),0) + 1)::DECIMAL
	FROM	massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_TransporteTarifa_importeMinimoEntrega();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_importeMinimoCarga() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_importeMinimoCarga() RETURNS DECIMAL AS $$

	SELECT (COALESCE(MAX(importeMinimoCarga),0) + 1)::DECIMAL
	FROM	massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_TransporteTarifa_importeMinimoCarga();

*/