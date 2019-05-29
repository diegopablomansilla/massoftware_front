
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoBloqueoCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoBloqueoCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.MotivoBloqueoCliente CASCADE;

CREATE TABLE massoftware.MotivoBloqueoCliente
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº motivo
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT MotivoBloqueoCliente_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Clasificación de cliente
	clasificacionCliente VARCHAR(36)  NOT NULL  REFERENCES massoftware.ClasificacionCliente (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_MotivoBloqueoCliente_nombre ON massoftware.MotivoBloqueoCliente (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatMotivoBloqueoCliente() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatMotivoBloqueoCliente() RETURNS TRIGGER AS $formatMotivoBloqueoCliente$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.clasificacionCliente := massoftware.white_is_null(NEW.clasificacionCliente);

	RETURN NEW;
END;
$formatMotivoBloqueoCliente$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatMotivoBloqueoCliente ON massoftware.MotivoBloqueoCliente CASCADE;

CREATE TRIGGER tgFormatMotivoBloqueoCliente BEFORE INSERT OR UPDATE
	ON massoftware.MotivoBloqueoCliente FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatMotivoBloqueoCliente();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.MotivoBloqueoCliente;

-- SELECT * FROM massoftware.MotivoBloqueoCliente LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.MotivoBloqueoCliente;

-- SELECT * FROM massoftware.MotivoBloqueoCliente WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_MotivoBloqueoClienteById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_MotivoBloqueoClienteById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.MotivoBloqueoCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.MotivoBloqueoCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.MotivoBloqueoCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_MotivoBloqueoClienteById('xxx');

-- SELECT * FROM massoftware.d_MotivoBloqueoClienteById((SELECT MotivoBloqueoCliente.id FROM massoftware.MotivoBloqueoCliente LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_MotivoBloqueoCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, clasificacionClienteArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_MotivoBloqueoCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, clasificacionClienteArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.MotivoBloqueoCliente(id, numero, nombre, clasificacionCliente) VALUES (idArg, numeroArg, nombreArg, clasificacionClienteArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.MotivoBloqueoCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_MotivoBloqueoCliente(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_MotivoBloqueoCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, clasificacionClienteArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_MotivoBloqueoCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, clasificacionClienteArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.MotivoBloqueoCliente SET 
		  numero = numeroArg
		, nombre = nombreArg
		, clasificacionCliente = clasificacionClienteArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.MotivoBloqueoCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_MotivoBloqueoCliente(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_MotivoBloqueoCliente_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_MotivoBloqueoCliente_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.MotivoBloqueoCliente
	WHERE	(numeroArg IS NULL OR MotivoBloqueoCliente.numero = numeroArg);

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_MotivoBloqueoCliente_numero(null::INTEGER);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_MotivoBloqueoCliente_nombre(nombreArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_MotivoBloqueoCliente_nombre(nombreArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.MotivoBloqueoCliente
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_MotivoBloqueoCliente_nombre(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_MotivoBloqueoCliente_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_MotivoBloqueoCliente_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER
	FROM	massoftware.MotivoBloqueoCliente;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_MotivoBloqueoCliente_numero();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoClienteById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoClienteById(idArg VARCHAR(36)) RETURNS
	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2

	FROM	massoftware.MotivoBloqueoCliente

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_MotivoBloqueoClienteById('xxx');

-- SELECT * FROM massoftware.f_MotivoBloqueoClienteById((SELECT MotivoBloqueoCliente.id FROM massoftware.MotivoBloqueoCliente LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoClienteById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoClienteById_1(idArg VARCHAR(36)) RETURNS
	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_MotivoBloqueoClienteById_1('xxx');

-- SELECT * FROM massoftware.f_MotivoBloqueoClienteById_1((SELECT MotivoBloqueoCliente.id FROM massoftware.MotivoBloqueoCliente LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2

	FROM	massoftware.MotivoBloqueoCliente

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2

	FROM	massoftware.MotivoBloqueoCliente

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2

	FROM	massoftware.MotivoBloqueoCliente

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Numero(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2

	FROM	massoftware.MotivoBloqueoCliente

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Numero(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2

	FROM	massoftware.MotivoBloqueoCliente

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Numero(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2

	FROM	massoftware.MotivoBloqueoCliente

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Numero(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2

	FROM	massoftware.MotivoBloqueoCliente

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Nombre(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2

	FROM	massoftware.MotivoBloqueoCliente

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Nombre(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2

	FROM	massoftware.MotivoBloqueoCliente

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Nombre(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2

	FROM	massoftware.MotivoBloqueoCliente

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Nombre(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_ClasificacionCliente(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_ClasificacionCliente(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2

	FROM	massoftware.MotivoBloqueoCliente

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.clasificacionCliente ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_ClasificacionCliente(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_ClasificacionCliente(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_ClasificacionCliente(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2

	FROM	massoftware.MotivoBloqueoCliente

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.clasificacionCliente DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_ClasificacionCliente(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_ClasificacionCliente(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_ClasificacionCliente(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2

	FROM	massoftware.MotivoBloqueoCliente

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.clasificacionCliente ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_ClasificacionCliente(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_ClasificacionCliente(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_ClasificacionCliente(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2

	FROM	massoftware.MotivoBloqueoCliente

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.clasificacionCliente DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_ClasificacionCliente(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_1(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_1(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Numero_1(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Numero_1(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Numero_1(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Numero_1(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Nombre_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Nombre_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Nombre_1(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Nombre_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Nombre_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Nombre_1(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Nombre_1(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Nombre_1(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_ClasificacionCliente_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_ClasificacionCliente_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.clasificacionCliente ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_ClasificacionCliente_1(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_ClasificacionCliente_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_ClasificacionCliente_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.clasificacionCliente DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_ClasificacionCliente_1(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_ClasificacionCliente_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_ClasificacionCliente_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.clasificacionCliente ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_ClasificacionCliente_1(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_ClasificacionCliente_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_ClasificacionCliente_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.clasificacionCliente DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_ClasificacionCliente_1(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/