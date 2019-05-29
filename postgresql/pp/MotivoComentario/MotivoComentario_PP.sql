
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoComentario                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoComentario

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.MotivoComentario CASCADE;

CREATE TABLE massoftware.MotivoComentario
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº motivo
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT MotivoComentario_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_MotivoComentario_nombre ON massoftware.MotivoComentario (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatMotivoComentario() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatMotivoComentario() RETURNS TRIGGER AS $formatMotivoComentario$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatMotivoComentario$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatMotivoComentario ON massoftware.MotivoComentario CASCADE;

CREATE TRIGGER tgFormatMotivoComentario BEFORE INSERT OR UPDATE
	ON massoftware.MotivoComentario FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatMotivoComentario();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.MotivoComentario;

-- SELECT * FROM massoftware.MotivoComentario LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.MotivoComentario;

-- SELECT * FROM massoftware.MotivoComentario WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_MotivoComentarioById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_MotivoComentarioById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.MotivoComentario WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoComentario.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.MotivoComentario WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoComentario.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.MotivoComentario WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoComentario.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_MotivoComentarioById('xxx');

-- SELECT * FROM massoftware.d_MotivoComentarioById((SELECT MotivoComentario.id FROM massoftware.MotivoComentario LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_MotivoComentario(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_MotivoComentario(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.MotivoComentario(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.MotivoComentario WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoComentario.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_MotivoComentario(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_MotivoComentario(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_MotivoComentario(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.MotivoComentario SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoComentario.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.MotivoComentario WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoComentario.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_MotivoComentario(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_MotivoComentario_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_MotivoComentario_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.MotivoComentario
	WHERE	(numeroArg IS NULL OR MotivoComentario.numero = numeroArg);

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_MotivoComentario_numero(null::INTEGER);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_MotivoComentario_nombre(nombreArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_MotivoComentario_nombre(nombreArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.MotivoComentario
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(MotivoComentario.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_MotivoComentario_nombre(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_MotivoComentario_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_MotivoComentario_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER
	FROM	massoftware.MotivoComentario;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_MotivoComentario_numero();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentarioById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentarioById(idArg VARCHAR(36)) RETURNS massoftware.MotivoComentario AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoComentario.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_MotivoComentarioById('xxx');

-- SELECT * FROM massoftware.f_MotivoComentarioById((SELECT MotivoComentario.id FROM massoftware.MotivoComentario LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 MotivoComentario_id VARCHAR(36)   	-- 0
		,MotivoComentario_numero INTEGER   	-- 1
		,MotivoComentario_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario(
		 null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario(
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

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario(
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
		 MotivoComentario_id VARCHAR(36)   	-- 0
		,MotivoComentario_numero INTEGER   	-- 1
		,MotivoComentario_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario(
		100
		, 0
		, null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario_asc_MotivoComentario_Numero(
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

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario_asc_MotivoComentario_Numero(
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
		 MotivoComentario_id VARCHAR(36)   	-- 0
		,MotivoComentario_numero INTEGER   	-- 1
		,MotivoComentario_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario_asc_MotivoComentario_Numero(
		100
		, 0
		, null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario_des_MotivoComentario_Numero(
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

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario_des_MotivoComentario_Numero(
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
		 MotivoComentario_id VARCHAR(36)   	-- 0
		,MotivoComentario_numero INTEGER   	-- 1
		,MotivoComentario_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario_des_MotivoComentario_Numero(
		100
		, 0
		, null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario_asc_MotivoComentario_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario_asc_MotivoComentario_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 MotivoComentario_id VARCHAR(36)   	-- 0
		,MotivoComentario_numero INTEGER   	-- 1
		,MotivoComentario_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario_asc_MotivoComentario_Numero(
		 null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario_des_MotivoComentario_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario_des_MotivoComentario_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 MotivoComentario_id VARCHAR(36)   	-- 0
		,MotivoComentario_numero INTEGER   	-- 1
		,MotivoComentario_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario_des_MotivoComentario_Numero(
		 null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario_asc_MotivoComentario_Nombre(
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

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario_asc_MotivoComentario_Nombre(
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
		 MotivoComentario_id VARCHAR(36)   	-- 0
		,MotivoComentario_numero INTEGER   	-- 1
		,MotivoComentario_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario_asc_MotivoComentario_Nombre(
		100
		, 0
		, null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario_des_MotivoComentario_Nombre(
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

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario_des_MotivoComentario_Nombre(
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
		 MotivoComentario_id VARCHAR(36)   	-- 0
		,MotivoComentario_numero INTEGER   	-- 1
		,MotivoComentario_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario_des_MotivoComentario_Nombre(
		100
		, 0
		, null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario_asc_MotivoComentario_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario_asc_MotivoComentario_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 MotivoComentario_id VARCHAR(36)   	-- 0
		,MotivoComentario_numero INTEGER   	-- 1
		,MotivoComentario_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario_asc_MotivoComentario_Nombre(
		 null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario_des_MotivoComentario_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario_des_MotivoComentario_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 MotivoComentario_id VARCHAR(36)   	-- 0
		,MotivoComentario_numero INTEGER   	-- 1
		,MotivoComentario_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario_des_MotivoComentario_Nombre(
		 null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/