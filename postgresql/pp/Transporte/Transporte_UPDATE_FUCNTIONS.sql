
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Transporte                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Transporte

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Transporte;

-- SELECT * FROM massoftware.Transporte LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Transporte;

-- SELECT * FROM massoftware.Transporte WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_TransporteById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_TransporteById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.Transporte WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.Transporte WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Transporte WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_TransporteById('xxx');

-- SELECT * FROM massoftware.d_TransporteById((SELECT Transporte.id FROM massoftware.Transporte LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Transporte(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuitArg BIGINT
		, ingresosBrutosArg VARCHAR(13)
		, telefonoArg VARCHAR(50)
		, faxArg VARCHAR(50)
		, codigoPostalArg VARCHAR(36)
		, domicilioArg VARCHAR(150)
		, comentarioArg VARCHAR(300)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Transporte(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuitArg BIGINT
		, ingresosBrutosArg VARCHAR(13)
		, telefonoArg VARCHAR(50)
		, faxArg VARCHAR(50)
		, codigoPostalArg VARCHAR(36)
		, domicilioArg VARCHAR(150)
		, comentarioArg VARCHAR(300)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Transporte(id, numero, nombre, cuit, ingresosBrutos, telefono, fax, codigoPostal, domicilio, comentario) VALUES (idArg, numeroArg, nombreArg, cuitArg, ingresosBrutosArg, telefonoArg, faxArg, codigoPostalArg, domicilioArg, comentarioArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Transporte WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Transporte(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::BIGINT
		, null::VARCHAR
		, null::VARCHAR
		, null::VARCHAR
		, null::VARCHAR(36)
		, null::VARCHAR
		, null::VARCHAR
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Transporte(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuitArg BIGINT
		, ingresosBrutosArg VARCHAR(13)
		, telefonoArg VARCHAR(50)
		, faxArg VARCHAR(50)
		, codigoPostalArg VARCHAR(36)
		, domicilioArg VARCHAR(150)
		, comentarioArg VARCHAR(300)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Transporte(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuitArg BIGINT
		, ingresosBrutosArg VARCHAR(13)
		, telefonoArg VARCHAR(50)
		, faxArg VARCHAR(50)
		, codigoPostalArg VARCHAR(36)
		, domicilioArg VARCHAR(150)
		, comentarioArg VARCHAR(300)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Transporte SET 
		  numero = numeroArg
		, nombre = nombreArg
		, cuit = cuitArg
		, ingresosBrutos = ingresosBrutosArg
		, telefono = telefonoArg
		, fax = faxArg
		, codigoPostal = codigoPostalArg
		, domicilio = domicilioArg
		, comentario = comentarioArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Transporte WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Transporte(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::BIGINT
		, null::VARCHAR
		, null::VARCHAR
		, null::VARCHAR
		, null::VARCHAR(36)
		, null::VARCHAR
		, null::VARCHAR
);

*/