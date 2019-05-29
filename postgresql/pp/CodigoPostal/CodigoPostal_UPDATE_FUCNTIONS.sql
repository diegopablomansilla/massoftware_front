
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CodigoPostal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CodigoPostal

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.CodigoPostal;

-- SELECT * FROM massoftware.CodigoPostal LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.CodigoPostal;

-- SELECT * FROM massoftware.CodigoPostal WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_CodigoPostalById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_CodigoPostalById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.CodigoPostal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.CodigoPostal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CodigoPostal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_CodigoPostalById('xxx');

-- SELECT * FROM massoftware.d_CodigoPostalById((SELECT CodigoPostal.id FROM massoftware.CodigoPostal LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_CodigoPostal(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(12)
		, numeroArg INTEGER
		, nombreCalleArg VARCHAR(200)
		, numeroCalleArg VARCHAR(20)
		, ciudadArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_CodigoPostal(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(12)
		, numeroArg INTEGER
		, nombreCalleArg VARCHAR(200)
		, numeroCalleArg VARCHAR(20)
		, ciudadArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.CodigoPostal(id, codigo, numero, nombreCalle, numeroCalle, ciudad) VALUES (idArg, codigoArg, numeroArg, nombreCalleArg, numeroCalleArg, ciudadArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.CodigoPostal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_CodigoPostal(
		null::VARCHAR(36)
		, null::VARCHAR
		, null::INTEGER
		, null::VARCHAR
		, null::VARCHAR
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_CodigoPostal(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(12)
		, numeroArg INTEGER
		, nombreCalleArg VARCHAR(200)
		, numeroCalleArg VARCHAR(20)
		, ciudadArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_CodigoPostal(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(12)
		, numeroArg INTEGER
		, nombreCalleArg VARCHAR(200)
		, numeroCalleArg VARCHAR(20)
		, ciudadArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.CodigoPostal SET 
		  codigo = codigoArg
		, numero = numeroArg
		, nombreCalle = nombreCalleArg
		, numeroCalle = numeroCalleArg
		, ciudad = ciudadArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CodigoPostal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_CodigoPostal(
		null::VARCHAR(36)
		, null::VARCHAR
		, null::INTEGER
		, null::VARCHAR
		, null::VARCHAR
		, null::VARCHAR(36)
);

*/