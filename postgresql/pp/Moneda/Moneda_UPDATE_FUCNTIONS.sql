
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Moneda                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Moneda

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Moneda;

-- SELECT * FROM massoftware.Moneda LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Moneda;

-- SELECT * FROM massoftware.Moneda WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_MonedaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_MonedaById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.Moneda WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Moneda.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.Moneda WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Moneda.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Moneda WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Moneda.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_MonedaById('xxx');

-- SELECT * FROM massoftware.d_MonedaById((SELECT Moneda.id FROM massoftware.Moneda LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Moneda(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, cotizacionArg DECIMAL
		, cotizacionFechaArg TIMESTAMP
		, controlActualizacionArg BOOLEAN
		, monedaAFIPArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Moneda(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, cotizacionArg DECIMAL
		, cotizacionFechaArg TIMESTAMP
		, controlActualizacionArg BOOLEAN
		, monedaAFIPArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF cotizacionArg IS NULL THEN

		cotizacionArg = 1;

	END IF;

	IF cotizacionFechaArg IS NULL THEN

		cotizacionFechaArg = now();

	END IF;

	IF controlActualizacionArg IS NULL THEN

		controlActualizacionArg = false;

	END IF;

	INSERT INTO massoftware.Moneda(id, numero, nombre, abreviatura, cotizacion, cotizacionFecha, controlActualizacion, monedaAFIP) VALUES (idArg, numeroArg, nombreArg, abreviaturaArg, cotizacionArg, cotizacionFechaArg, controlActualizacionArg, monedaAFIPArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Moneda WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Moneda.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Moneda(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::VARCHAR
		, null::DECIMAL
		, null::TIMESTAMP
		, null::BOOLEAN
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Moneda(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, cotizacionArg DECIMAL
		, cotizacionFechaArg TIMESTAMP
		, controlActualizacionArg BOOLEAN
		, monedaAFIPArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Moneda(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, cotizacionArg DECIMAL
		, cotizacionFechaArg TIMESTAMP
		, controlActualizacionArg BOOLEAN
		, monedaAFIPArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF controlActualizacionArg IS NULL THEN

		controlActualizacionArg = false;

	END IF;

	UPDATE massoftware.Moneda SET 
		  numero = numeroArg
		, nombre = nombreArg
		, abreviatura = abreviaturaArg
		, cotizacion = cotizacionArg
		, cotizacionFecha = cotizacionFechaArg
		, controlActualizacion = controlActualizacionArg
		, monedaAFIP = monedaAFIPArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Moneda.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Moneda WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Moneda.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Moneda(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::VARCHAR
		, null::DECIMAL
		, null::TIMESTAMP
		, null::BOOLEAN
		, null::VARCHAR(36)
);

*/