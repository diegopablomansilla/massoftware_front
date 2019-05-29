
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Zona                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Zona

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Zona;

-- SELECT * FROM massoftware.Zona LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Zona;

-- SELECT * FROM massoftware.Zona WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_ZonaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_ZonaById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.Zona WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Zona.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.Zona WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Zona.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Zona WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Zona.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_ZonaById('xxx');

-- SELECT * FROM massoftware.d_ZonaById((SELECT Zona.id FROM massoftware.Zona LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Zona(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
		, bonificacionArg DECIMAL
		, recargoArg DECIMAL
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Zona(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
		, bonificacionArg DECIMAL
		, recargoArg DECIMAL
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Zona(id, codigo, nombre, bonificacion, recargo) VALUES (idArg, codigoArg, nombreArg, bonificacionArg, recargoArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Zona WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Zona.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Zona(
		null::VARCHAR(36)
		, null::VARCHAR
		, null::VARCHAR
		, null::DECIMAL
		, null::DECIMAL
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Zona(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
		, bonificacionArg DECIMAL
		, recargoArg DECIMAL
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Zona(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
		, bonificacionArg DECIMAL
		, recargoArg DECIMAL
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Zona SET 
		  codigo = codigoArg
		, nombre = nombreArg
		, bonificacion = bonificacionArg
		, recargo = recargoArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Zona.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Zona WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Zona.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Zona(
		null::VARCHAR(36)
		, null::VARCHAR
		, null::VARCHAR
		, null::DECIMAL
		, null::DECIMAL
);

*/