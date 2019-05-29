
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ClasificacionCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ClasificacionCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.ClasificacionCliente CASCADE;

CREATE TABLE massoftware.ClasificacionCliente
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº clasificación
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT ClasificacionCliente_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Color
	color INTEGER NOT NULL  CONSTRAINT ClasificacionCliente_color_chk CHECK ( color >= 1  )
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_ClasificacionCliente_nombre ON massoftware.ClasificacionCliente (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatClasificacionCliente() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatClasificacionCliente() RETURNS TRIGGER AS $formatClasificacionCliente$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatClasificacionCliente$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatClasificacionCliente ON massoftware.ClasificacionCliente CASCADE;

CREATE TRIGGER tgFormatClasificacionCliente BEFORE INSERT OR UPDATE
	ON massoftware.ClasificacionCliente FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatClasificacionCliente();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.ClasificacionCliente;

-- SELECT * FROM massoftware.ClasificacionCliente LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.ClasificacionCliente;

-- SELECT * FROM massoftware.ClasificacionCliente WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_ClasificacionClienteById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_ClasificacionClienteById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.ClasificacionCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ClasificacionCliente.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.ClasificacionCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ClasificacionCliente.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.ClasificacionCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ClasificacionCliente.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_ClasificacionClienteById('xxx');

-- SELECT * FROM massoftware.d_ClasificacionClienteById((SELECT ClasificacionCliente.id FROM massoftware.ClasificacionCliente LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_ClasificacionCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, colorArg INTEGER
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_ClasificacionCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, colorArg INTEGER
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.ClasificacionCliente(id, numero, nombre, color) VALUES (idArg, numeroArg, nombreArg, colorArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.ClasificacionCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ClasificacionCliente.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_ClasificacionCliente(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::INTEGER
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_ClasificacionCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, colorArg INTEGER
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_ClasificacionCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, colorArg INTEGER
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.ClasificacionCliente SET 
		  numero = numeroArg
		, nombre = nombreArg
		, color = colorArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ClasificacionCliente.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.ClasificacionCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ClasificacionCliente.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_ClasificacionCliente(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::INTEGER
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_ClasificacionCliente_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_ClasificacionCliente_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.ClasificacionCliente
	WHERE	(numeroArg IS NULL OR ClasificacionCliente.numero = numeroArg);

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_ClasificacionCliente_numero(null::INTEGER);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_ClasificacionCliente_nombre(nombreArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_ClasificacionCliente_nombre(nombreArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.ClasificacionCliente
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(ClasificacionCliente.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_ClasificacionCliente_nombre(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_ClasificacionCliente_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_ClasificacionCliente_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER
	FROM	massoftware.ClasificacionCliente;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_ClasificacionCliente_numero();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_ClasificacionCliente_color() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_ClasificacionCliente_color() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(color),0) + 1)::INTEGER
	FROM	massoftware.ClasificacionCliente;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_ClasificacionCliente_color();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionClienteById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionClienteById(idArg VARCHAR(36)) RETURNS massoftware.ClasificacionCliente AS $$

	SELECT
		 ClasificacionCliente.id AS ClasificacionCliente_id       	-- 0
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 1
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 2
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 3

	FROM	massoftware.ClasificacionCliente

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ClasificacionCliente.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_ClasificacionClienteById('xxx');

-- SELECT * FROM massoftware.f_ClasificacionClienteById((SELECT ClasificacionCliente.id FROM massoftware.ClasificacionCliente LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 ClasificacionCliente_id VARCHAR(36)   	-- 0
		,ClasificacionCliente_numero INTEGER   	-- 1
		,ClasificacionCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_color INTEGER    	-- 3
	) AS $$

	SELECT
		 ClasificacionCliente.id AS ClasificacionCliente_id       	-- 0
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 1
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 2
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 3

	FROM	massoftware.ClasificacionCliente

	WHERE	(numeroFromArg0 IS NULL OR ClasificacionCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR ClasificacionCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY ClasificacionCliente.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_ClasificacionCliente(
		 null::INTEGER -- ClasificacionCliente_numeroFromArg0
		, null::INTEGER -- ClasificacionCliente_numeroToArg1
		, null::VARCHAR -- ClasificacionCliente_nombreWord0Arg2
		, null::VARCHAR -- ClasificacionCliente_nombreWord1Arg3
		, null::VARCHAR -- ClasificacionCliente_nombreWord2Arg4
		, null::VARCHAR -- ClasificacionCliente_nombreWord3Arg5
		, null::VARCHAR -- ClasificacionCliente_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 ClasificacionCliente_id VARCHAR(36)   	-- 0
		,ClasificacionCliente_numero INTEGER   	-- 1
		,ClasificacionCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_color INTEGER    	-- 3
	) AS $$

	SELECT
		 ClasificacionCliente.id AS ClasificacionCliente_id       	-- 0
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 1
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 2
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 3

	FROM	massoftware.ClasificacionCliente

	WHERE	(numeroFromArg0 IS NULL OR ClasificacionCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR ClasificacionCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY ClasificacionCliente.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_ClasificacionCliente(
		100
		, 0
		, null::INTEGER -- ClasificacionCliente_numeroFromArg0
		, null::INTEGER -- ClasificacionCliente_numeroToArg1
		, null::VARCHAR -- ClasificacionCliente_nombreWord0Arg2
		, null::VARCHAR -- ClasificacionCliente_nombreWord1Arg3
		, null::VARCHAR -- ClasificacionCliente_nombreWord2Arg4
		, null::VARCHAR -- ClasificacionCliente_nombreWord3Arg5
		, null::VARCHAR -- ClasificacionCliente_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 ClasificacionCliente_id VARCHAR(36)   	-- 0
		,ClasificacionCliente_numero INTEGER   	-- 1
		,ClasificacionCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_color INTEGER    	-- 3
	) AS $$

	SELECT
		 ClasificacionCliente.id AS ClasificacionCliente_id       	-- 0
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 1
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 2
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 3

	FROM	massoftware.ClasificacionCliente

	WHERE	(numeroFromArg0 IS NULL OR ClasificacionCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR ClasificacionCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY ClasificacionCliente.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Numero(
		100
		, 0
		, null::INTEGER -- ClasificacionCliente_numeroFromArg0
		, null::INTEGER -- ClasificacionCliente_numeroToArg1
		, null::VARCHAR -- ClasificacionCliente_nombreWord0Arg2
		, null::VARCHAR -- ClasificacionCliente_nombreWord1Arg3
		, null::VARCHAR -- ClasificacionCliente_nombreWord2Arg4
		, null::VARCHAR -- ClasificacionCliente_nombreWord3Arg5
		, null::VARCHAR -- ClasificacionCliente_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 ClasificacionCliente_id VARCHAR(36)   	-- 0
		,ClasificacionCliente_numero INTEGER   	-- 1
		,ClasificacionCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_color INTEGER    	-- 3
	) AS $$

	SELECT
		 ClasificacionCliente.id AS ClasificacionCliente_id       	-- 0
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 1
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 2
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 3

	FROM	massoftware.ClasificacionCliente

	WHERE	(numeroFromArg0 IS NULL OR ClasificacionCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR ClasificacionCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY ClasificacionCliente.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Numero(
		100
		, 0
		, null::INTEGER -- ClasificacionCliente_numeroFromArg0
		, null::INTEGER -- ClasificacionCliente_numeroToArg1
		, null::VARCHAR -- ClasificacionCliente_nombreWord0Arg2
		, null::VARCHAR -- ClasificacionCliente_nombreWord1Arg3
		, null::VARCHAR -- ClasificacionCliente_nombreWord2Arg4
		, null::VARCHAR -- ClasificacionCliente_nombreWord3Arg5
		, null::VARCHAR -- ClasificacionCliente_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 ClasificacionCliente_id VARCHAR(36)   	-- 0
		,ClasificacionCliente_numero INTEGER   	-- 1
		,ClasificacionCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_color INTEGER    	-- 3
	) AS $$

	SELECT
		 ClasificacionCliente.id AS ClasificacionCliente_id       	-- 0
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 1
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 2
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 3

	FROM	massoftware.ClasificacionCliente

	WHERE	(numeroFromArg0 IS NULL OR ClasificacionCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR ClasificacionCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY ClasificacionCliente.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Numero(
		 null::INTEGER -- ClasificacionCliente_numeroFromArg0
		, null::INTEGER -- ClasificacionCliente_numeroToArg1
		, null::VARCHAR -- ClasificacionCliente_nombreWord0Arg2
		, null::VARCHAR -- ClasificacionCliente_nombreWord1Arg3
		, null::VARCHAR -- ClasificacionCliente_nombreWord2Arg4
		, null::VARCHAR -- ClasificacionCliente_nombreWord3Arg5
		, null::VARCHAR -- ClasificacionCliente_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 ClasificacionCliente_id VARCHAR(36)   	-- 0
		,ClasificacionCliente_numero INTEGER   	-- 1
		,ClasificacionCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_color INTEGER    	-- 3
	) AS $$

	SELECT
		 ClasificacionCliente.id AS ClasificacionCliente_id       	-- 0
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 1
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 2
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 3

	FROM	massoftware.ClasificacionCliente

	WHERE	(numeroFromArg0 IS NULL OR ClasificacionCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR ClasificacionCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY ClasificacionCliente.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Numero(
		 null::INTEGER -- ClasificacionCliente_numeroFromArg0
		, null::INTEGER -- ClasificacionCliente_numeroToArg1
		, null::VARCHAR -- ClasificacionCliente_nombreWord0Arg2
		, null::VARCHAR -- ClasificacionCliente_nombreWord1Arg3
		, null::VARCHAR -- ClasificacionCliente_nombreWord2Arg4
		, null::VARCHAR -- ClasificacionCliente_nombreWord3Arg5
		, null::VARCHAR -- ClasificacionCliente_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 ClasificacionCliente_id VARCHAR(36)   	-- 0
		,ClasificacionCliente_numero INTEGER   	-- 1
		,ClasificacionCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_color INTEGER    	-- 3
	) AS $$

	SELECT
		 ClasificacionCliente.id AS ClasificacionCliente_id       	-- 0
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 1
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 2
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 3

	FROM	massoftware.ClasificacionCliente

	WHERE	(numeroFromArg0 IS NULL OR ClasificacionCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR ClasificacionCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY ClasificacionCliente.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Nombre(
		100
		, 0
		, null::INTEGER -- ClasificacionCliente_numeroFromArg0
		, null::INTEGER -- ClasificacionCliente_numeroToArg1
		, null::VARCHAR -- ClasificacionCliente_nombreWord0Arg2
		, null::VARCHAR -- ClasificacionCliente_nombreWord1Arg3
		, null::VARCHAR -- ClasificacionCliente_nombreWord2Arg4
		, null::VARCHAR -- ClasificacionCliente_nombreWord3Arg5
		, null::VARCHAR -- ClasificacionCliente_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 ClasificacionCliente_id VARCHAR(36)   	-- 0
		,ClasificacionCliente_numero INTEGER   	-- 1
		,ClasificacionCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_color INTEGER    	-- 3
	) AS $$

	SELECT
		 ClasificacionCliente.id AS ClasificacionCliente_id       	-- 0
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 1
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 2
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 3

	FROM	massoftware.ClasificacionCliente

	WHERE	(numeroFromArg0 IS NULL OR ClasificacionCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR ClasificacionCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY ClasificacionCliente.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Nombre(
		100
		, 0
		, null::INTEGER -- ClasificacionCliente_numeroFromArg0
		, null::INTEGER -- ClasificacionCliente_numeroToArg1
		, null::VARCHAR -- ClasificacionCliente_nombreWord0Arg2
		, null::VARCHAR -- ClasificacionCliente_nombreWord1Arg3
		, null::VARCHAR -- ClasificacionCliente_nombreWord2Arg4
		, null::VARCHAR -- ClasificacionCliente_nombreWord3Arg5
		, null::VARCHAR -- ClasificacionCliente_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 ClasificacionCliente_id VARCHAR(36)   	-- 0
		,ClasificacionCliente_numero INTEGER   	-- 1
		,ClasificacionCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_color INTEGER    	-- 3
	) AS $$

	SELECT
		 ClasificacionCliente.id AS ClasificacionCliente_id       	-- 0
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 1
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 2
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 3

	FROM	massoftware.ClasificacionCliente

	WHERE	(numeroFromArg0 IS NULL OR ClasificacionCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR ClasificacionCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY ClasificacionCliente.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Nombre(
		 null::INTEGER -- ClasificacionCliente_numeroFromArg0
		, null::INTEGER -- ClasificacionCliente_numeroToArg1
		, null::VARCHAR -- ClasificacionCliente_nombreWord0Arg2
		, null::VARCHAR -- ClasificacionCliente_nombreWord1Arg3
		, null::VARCHAR -- ClasificacionCliente_nombreWord2Arg4
		, null::VARCHAR -- ClasificacionCliente_nombreWord3Arg5
		, null::VARCHAR -- ClasificacionCliente_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 ClasificacionCliente_id VARCHAR(36)   	-- 0
		,ClasificacionCliente_numero INTEGER   	-- 1
		,ClasificacionCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_color INTEGER    	-- 3
	) AS $$

	SELECT
		 ClasificacionCliente.id AS ClasificacionCliente_id       	-- 0
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 1
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 2
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 3

	FROM	massoftware.ClasificacionCliente

	WHERE	(numeroFromArg0 IS NULL OR ClasificacionCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR ClasificacionCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY ClasificacionCliente.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Nombre(
		 null::INTEGER -- ClasificacionCliente_numeroFromArg0
		, null::INTEGER -- ClasificacionCliente_numeroToArg1
		, null::VARCHAR -- ClasificacionCliente_nombreWord0Arg2
		, null::VARCHAR -- ClasificacionCliente_nombreWord1Arg3
		, null::VARCHAR -- ClasificacionCliente_nombreWord2Arg4
		, null::VARCHAR -- ClasificacionCliente_nombreWord3Arg5
		, null::VARCHAR -- ClasificacionCliente_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Color(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Color(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 ClasificacionCliente_id VARCHAR(36)   	-- 0
		,ClasificacionCliente_numero INTEGER   	-- 1
		,ClasificacionCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_color INTEGER    	-- 3
	) AS $$

	SELECT
		 ClasificacionCliente.id AS ClasificacionCliente_id       	-- 0
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 1
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 2
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 3

	FROM	massoftware.ClasificacionCliente

	WHERE	(numeroFromArg0 IS NULL OR ClasificacionCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR ClasificacionCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY ClasificacionCliente.color ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Color(
		100
		, 0
		, null::INTEGER -- ClasificacionCliente_numeroFromArg0
		, null::INTEGER -- ClasificacionCliente_numeroToArg1
		, null::VARCHAR -- ClasificacionCliente_nombreWord0Arg2
		, null::VARCHAR -- ClasificacionCliente_nombreWord1Arg3
		, null::VARCHAR -- ClasificacionCliente_nombreWord2Arg4
		, null::VARCHAR -- ClasificacionCliente_nombreWord3Arg5
		, null::VARCHAR -- ClasificacionCliente_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Color(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Color(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 ClasificacionCliente_id VARCHAR(36)   	-- 0
		,ClasificacionCliente_numero INTEGER   	-- 1
		,ClasificacionCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_color INTEGER    	-- 3
	) AS $$

	SELECT
		 ClasificacionCliente.id AS ClasificacionCliente_id       	-- 0
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 1
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 2
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 3

	FROM	massoftware.ClasificacionCliente

	WHERE	(numeroFromArg0 IS NULL OR ClasificacionCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR ClasificacionCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY ClasificacionCliente.color DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Color(
		100
		, 0
		, null::INTEGER -- ClasificacionCliente_numeroFromArg0
		, null::INTEGER -- ClasificacionCliente_numeroToArg1
		, null::VARCHAR -- ClasificacionCliente_nombreWord0Arg2
		, null::VARCHAR -- ClasificacionCliente_nombreWord1Arg3
		, null::VARCHAR -- ClasificacionCliente_nombreWord2Arg4
		, null::VARCHAR -- ClasificacionCliente_nombreWord3Arg5
		, null::VARCHAR -- ClasificacionCliente_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Color(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Color(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 ClasificacionCliente_id VARCHAR(36)   	-- 0
		,ClasificacionCliente_numero INTEGER   	-- 1
		,ClasificacionCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_color INTEGER    	-- 3
	) AS $$

	SELECT
		 ClasificacionCliente.id AS ClasificacionCliente_id       	-- 0
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 1
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 2
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 3

	FROM	massoftware.ClasificacionCliente

	WHERE	(numeroFromArg0 IS NULL OR ClasificacionCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR ClasificacionCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY ClasificacionCliente.color ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Color(
		 null::INTEGER -- ClasificacionCliente_numeroFromArg0
		, null::INTEGER -- ClasificacionCliente_numeroToArg1
		, null::VARCHAR -- ClasificacionCliente_nombreWord0Arg2
		, null::VARCHAR -- ClasificacionCliente_nombreWord1Arg3
		, null::VARCHAR -- ClasificacionCliente_nombreWord2Arg4
		, null::VARCHAR -- ClasificacionCliente_nombreWord3Arg5
		, null::VARCHAR -- ClasificacionCliente_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Color(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Color(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 ClasificacionCliente_id VARCHAR(36)   	-- 0
		,ClasificacionCliente_numero INTEGER   	-- 1
		,ClasificacionCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_color INTEGER    	-- 3
	) AS $$

	SELECT
		 ClasificacionCliente.id AS ClasificacionCliente_id       	-- 0
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 1
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 2
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 3

	FROM	massoftware.ClasificacionCliente

	WHERE	(numeroFromArg0 IS NULL OR ClasificacionCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR ClasificacionCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(ClasificacionCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY ClasificacionCliente.color DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Color(
		 null::INTEGER -- ClasificacionCliente_numeroFromArg0
		, null::INTEGER -- ClasificacionCliente_numeroToArg1
		, null::VARCHAR -- ClasificacionCliente_nombreWord0Arg2
		, null::VARCHAR -- ClasificacionCliente_nombreWord1Arg3
		, null::VARCHAR -- ClasificacionCliente_nombreWord2Arg4
		, null::VARCHAR -- ClasificacionCliente_nombreWord3Arg5
		, null::VARCHAR -- ClasificacionCliente_nombreWord4Arg6
);

*/