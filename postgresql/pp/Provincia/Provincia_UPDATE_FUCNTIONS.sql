
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Provincia                                                                                              //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Provincia

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Provincia;

-- SELECT * FROM massoftware.Provincia LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Provincia;

-- SELECT * FROM massoftware.Provincia WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_ProvinciaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_ProvinciaById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.Provincia WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.Provincia WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Provincia WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_ProvinciaById('xxx');

-- SELECT * FROM massoftware.d_ProvinciaById((SELECT Provincia.id FROM massoftware.Provincia LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Provincia(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, numeroAFIPArg INTEGER
		, numeroIngresosBrutosArg INTEGER
		, numeroRENATEAArg INTEGER
		, paisArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Provincia(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, numeroAFIPArg INTEGER
		, numeroIngresosBrutosArg INTEGER
		, numeroRENATEAArg INTEGER
		, paisArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Provincia(id, numero, nombre, abreviatura, numeroAFIP, numeroIngresosBrutos, numeroRENATEA, pais) VALUES (idArg, numeroArg, nombreArg, abreviaturaArg, numeroAFIPArg, numeroIngresosBrutosArg, numeroRENATEAArg, paisArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Provincia WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Provincia(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::VARCHAR
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Provincia(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, numeroAFIPArg INTEGER
		, numeroIngresosBrutosArg INTEGER
		, numeroRENATEAArg INTEGER
		, paisArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Provincia(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, numeroAFIPArg INTEGER
		, numeroIngresosBrutosArg INTEGER
		, numeroRENATEAArg INTEGER
		, paisArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Provincia SET 
		  numero = numeroArg
		, nombre = nombreArg
		, abreviatura = abreviaturaArg
		, numeroAFIP = numeroAFIPArg
		, numeroIngresosBrutos = numeroIngresosBrutosArg
		, numeroRENATEA = numeroRENATEAArg
		, pais = paisArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Provincia WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Provincia(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::VARCHAR
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::VARCHAR(36)
);

*/