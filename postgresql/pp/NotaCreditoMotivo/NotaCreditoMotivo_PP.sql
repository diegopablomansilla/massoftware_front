
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: NotaCreditoMotivo                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.NotaCreditoMotivo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.NotaCreditoMotivo CASCADE;

CREATE TABLE massoftware.NotaCreditoMotivo
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº motivo
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT NotaCreditoMotivo_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_NotaCreditoMotivo_nombre ON massoftware.NotaCreditoMotivo (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatNotaCreditoMotivo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatNotaCreditoMotivo() RETURNS TRIGGER AS $formatNotaCreditoMotivo$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatNotaCreditoMotivo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatNotaCreditoMotivo ON massoftware.NotaCreditoMotivo CASCADE;

CREATE TRIGGER tgFormatNotaCreditoMotivo BEFORE INSERT OR UPDATE
	ON massoftware.NotaCreditoMotivo FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatNotaCreditoMotivo();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.NotaCreditoMotivo;

-- SELECT * FROM massoftware.NotaCreditoMotivo LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.NotaCreditoMotivo;

-- SELECT * FROM massoftware.NotaCreditoMotivo WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_NotaCreditoMotivoById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_NotaCreditoMotivoById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.NotaCreditoMotivo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND NotaCreditoMotivo.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.NotaCreditoMotivo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND NotaCreditoMotivo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.NotaCreditoMotivo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND NotaCreditoMotivo.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_NotaCreditoMotivoById('xxx');

-- SELECT * FROM massoftware.d_NotaCreditoMotivoById((SELECT NotaCreditoMotivo.id FROM massoftware.NotaCreditoMotivo LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_NotaCreditoMotivo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_NotaCreditoMotivo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.NotaCreditoMotivo(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.NotaCreditoMotivo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND NotaCreditoMotivo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_NotaCreditoMotivo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_NotaCreditoMotivo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_NotaCreditoMotivo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.NotaCreditoMotivo SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND NotaCreditoMotivo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.NotaCreditoMotivo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND NotaCreditoMotivo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_NotaCreditoMotivo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_NotaCreditoMotivo_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_NotaCreditoMotivo_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.NotaCreditoMotivo
	WHERE	(numeroArg IS NULL OR NotaCreditoMotivo.numero = numeroArg);

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_NotaCreditoMotivo_numero(null::INTEGER);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_NotaCreditoMotivo_nombre(nombreArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_NotaCreditoMotivo_nombre(nombreArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.NotaCreditoMotivo
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(NotaCreditoMotivo.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_NotaCreditoMotivo_nombre(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_NotaCreditoMotivo_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_NotaCreditoMotivo_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.NotaCreditoMotivo;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_NotaCreditoMotivo_numero();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_NotaCreditoMotivoById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_NotaCreditoMotivoById(idArg VARCHAR(36)) RETURNS massoftware.NotaCreditoMotivo AS $$

	SELECT
		 NotaCreditoMotivo.id AS NotaCreditoMotivo_id       	-- 0
		,NotaCreditoMotivo.numero AS NotaCreditoMotivo_numero	-- 1
		,NotaCreditoMotivo.nombre AS NotaCreditoMotivo_nombre	-- 2

	FROM	massoftware.NotaCreditoMotivo

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND NotaCreditoMotivo.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_NotaCreditoMotivoById('xxx');

-- SELECT * FROM massoftware.f_NotaCreditoMotivoById((SELECT NotaCreditoMotivo.id FROM massoftware.NotaCreditoMotivo LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_NotaCreditoMotivo(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_NotaCreditoMotivo(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.NotaCreditoMotivo  AS $$

	SELECT
		 NotaCreditoMotivo.id AS NotaCreditoMotivo_id       	-- 0
		,NotaCreditoMotivo.numero AS NotaCreditoMotivo_numero	-- 1
		,NotaCreditoMotivo.nombre AS NotaCreditoMotivo_nombre	-- 2

	FROM	massoftware.NotaCreditoMotivo

	WHERE	(numeroFromArg0 IS NULL OR NotaCreditoMotivo.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR NotaCreditoMotivo.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY NotaCreditoMotivo.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_NotaCreditoMotivo(
		 null::INTEGER -- NotaCreditoMotivo_numeroFromArg0
		, null::INTEGER -- NotaCreditoMotivo_numeroToArg1
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord0Arg2
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord1Arg3
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord2Arg4
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord3Arg5
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_NotaCreditoMotivo(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_NotaCreditoMotivo(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.NotaCreditoMotivo  AS $$

	SELECT
		 NotaCreditoMotivo.id AS NotaCreditoMotivo_id       	-- 0
		,NotaCreditoMotivo.numero AS NotaCreditoMotivo_numero	-- 1
		,NotaCreditoMotivo.nombre AS NotaCreditoMotivo_nombre	-- 2

	FROM	massoftware.NotaCreditoMotivo

	WHERE	(numeroFromArg0 IS NULL OR NotaCreditoMotivo.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR NotaCreditoMotivo.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY NotaCreditoMotivo.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_NotaCreditoMotivo(100, 0
		, null::INTEGER -- NotaCreditoMotivo_numeroFromArg0
		, null::INTEGER -- NotaCreditoMotivo_numeroToArg1
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord0Arg2
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord1Arg3
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord2Arg4
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord3Arg5
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_NotaCreditoMotivo_asc_NotaCreditoMotivo_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_NotaCreditoMotivo_asc_NotaCreditoMotivo_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.NotaCreditoMotivo  AS $$

	SELECT
		 NotaCreditoMotivo.id AS NotaCreditoMotivo_id       	-- 0
		,NotaCreditoMotivo.numero AS NotaCreditoMotivo_numero	-- 1
		,NotaCreditoMotivo.nombre AS NotaCreditoMotivo_nombre	-- 2

	FROM	massoftware.NotaCreditoMotivo

	WHERE	(numeroFromArg0 IS NULL OR NotaCreditoMotivo.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR NotaCreditoMotivo.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY NotaCreditoMotivo.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_NotaCreditoMotivo_asc_NotaCreditoMotivo_Numero(100, 0
		, null::INTEGER -- NotaCreditoMotivo_numeroFromArg0
		, null::INTEGER -- NotaCreditoMotivo_numeroToArg1
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord0Arg2
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord1Arg3
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord2Arg4
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord3Arg5
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_NotaCreditoMotivo_des_NotaCreditoMotivo_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_NotaCreditoMotivo_des_NotaCreditoMotivo_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.NotaCreditoMotivo  AS $$

	SELECT
		 NotaCreditoMotivo.id AS NotaCreditoMotivo_id       	-- 0
		,NotaCreditoMotivo.numero AS NotaCreditoMotivo_numero	-- 1
		,NotaCreditoMotivo.nombre AS NotaCreditoMotivo_nombre	-- 2

	FROM	massoftware.NotaCreditoMotivo

	WHERE	(numeroFromArg0 IS NULL OR NotaCreditoMotivo.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR NotaCreditoMotivo.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY NotaCreditoMotivo.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_NotaCreditoMotivo_des_NotaCreditoMotivo_Numero(100, 0
		, null::INTEGER -- NotaCreditoMotivo_numeroFromArg0
		, null::INTEGER -- NotaCreditoMotivo_numeroToArg1
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord0Arg2
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord1Arg3
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord2Arg4
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord3Arg5
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_NotaCreditoMotivo_asc_NotaCreditoMotivo_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_NotaCreditoMotivo_asc_NotaCreditoMotivo_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.NotaCreditoMotivo  AS $$

	SELECT
		 NotaCreditoMotivo.id AS NotaCreditoMotivo_id       	-- 0
		,NotaCreditoMotivo.numero AS NotaCreditoMotivo_numero	-- 1
		,NotaCreditoMotivo.nombre AS NotaCreditoMotivo_nombre	-- 2

	FROM	massoftware.NotaCreditoMotivo

	WHERE	(numeroFromArg0 IS NULL OR NotaCreditoMotivo.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR NotaCreditoMotivo.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY NotaCreditoMotivo.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_NotaCreditoMotivo_asc_NotaCreditoMotivo_Numero(
		 null::INTEGER -- NotaCreditoMotivo_numeroFromArg0
		, null::INTEGER -- NotaCreditoMotivo_numeroToArg1
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord0Arg2
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord1Arg3
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord2Arg4
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord3Arg5
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_NotaCreditoMotivo_des_NotaCreditoMotivo_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_NotaCreditoMotivo_des_NotaCreditoMotivo_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.NotaCreditoMotivo  AS $$

	SELECT
		 NotaCreditoMotivo.id AS NotaCreditoMotivo_id       	-- 0
		,NotaCreditoMotivo.numero AS NotaCreditoMotivo_numero	-- 1
		,NotaCreditoMotivo.nombre AS NotaCreditoMotivo_nombre	-- 2

	FROM	massoftware.NotaCreditoMotivo

	WHERE	(numeroFromArg0 IS NULL OR NotaCreditoMotivo.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR NotaCreditoMotivo.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY NotaCreditoMotivo.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_NotaCreditoMotivo_des_NotaCreditoMotivo_Numero(
		 null::INTEGER -- NotaCreditoMotivo_numeroFromArg0
		, null::INTEGER -- NotaCreditoMotivo_numeroToArg1
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord0Arg2
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord1Arg3
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord2Arg4
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord3Arg5
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_NotaCreditoMotivo_asc_NotaCreditoMotivo_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_NotaCreditoMotivo_asc_NotaCreditoMotivo_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.NotaCreditoMotivo  AS $$

	SELECT
		 NotaCreditoMotivo.id AS NotaCreditoMotivo_id       	-- 0
		,NotaCreditoMotivo.numero AS NotaCreditoMotivo_numero	-- 1
		,NotaCreditoMotivo.nombre AS NotaCreditoMotivo_nombre	-- 2

	FROM	massoftware.NotaCreditoMotivo

	WHERE	(numeroFromArg0 IS NULL OR NotaCreditoMotivo.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR NotaCreditoMotivo.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY NotaCreditoMotivo.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_NotaCreditoMotivo_asc_NotaCreditoMotivo_Nombre(100, 0
		, null::INTEGER -- NotaCreditoMotivo_numeroFromArg0
		, null::INTEGER -- NotaCreditoMotivo_numeroToArg1
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord0Arg2
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord1Arg3
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord2Arg4
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord3Arg5
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_NotaCreditoMotivo_des_NotaCreditoMotivo_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_NotaCreditoMotivo_des_NotaCreditoMotivo_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.NotaCreditoMotivo  AS $$

	SELECT
		 NotaCreditoMotivo.id AS NotaCreditoMotivo_id       	-- 0
		,NotaCreditoMotivo.numero AS NotaCreditoMotivo_numero	-- 1
		,NotaCreditoMotivo.nombre AS NotaCreditoMotivo_nombre	-- 2

	FROM	massoftware.NotaCreditoMotivo

	WHERE	(numeroFromArg0 IS NULL OR NotaCreditoMotivo.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR NotaCreditoMotivo.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY NotaCreditoMotivo.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_NotaCreditoMotivo_des_NotaCreditoMotivo_Nombre(100, 0
		, null::INTEGER -- NotaCreditoMotivo_numeroFromArg0
		, null::INTEGER -- NotaCreditoMotivo_numeroToArg1
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord0Arg2
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord1Arg3
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord2Arg4
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord3Arg5
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_NotaCreditoMotivo_asc_NotaCreditoMotivo_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_NotaCreditoMotivo_asc_NotaCreditoMotivo_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.NotaCreditoMotivo  AS $$

	SELECT
		 NotaCreditoMotivo.id AS NotaCreditoMotivo_id       	-- 0
		,NotaCreditoMotivo.numero AS NotaCreditoMotivo_numero	-- 1
		,NotaCreditoMotivo.nombre AS NotaCreditoMotivo_nombre	-- 2

	FROM	massoftware.NotaCreditoMotivo

	WHERE	(numeroFromArg0 IS NULL OR NotaCreditoMotivo.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR NotaCreditoMotivo.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY NotaCreditoMotivo.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_NotaCreditoMotivo_asc_NotaCreditoMotivo_Nombre(
		 null::INTEGER -- NotaCreditoMotivo_numeroFromArg0
		, null::INTEGER -- NotaCreditoMotivo_numeroToArg1
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord0Arg2
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord1Arg3
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord2Arg4
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord3Arg5
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_NotaCreditoMotivo_des_NotaCreditoMotivo_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_NotaCreditoMotivo_des_NotaCreditoMotivo_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.NotaCreditoMotivo  AS $$

	SELECT
		 NotaCreditoMotivo.id AS NotaCreditoMotivo_id       	-- 0
		,NotaCreditoMotivo.numero AS NotaCreditoMotivo_numero	-- 1
		,NotaCreditoMotivo.nombre AS NotaCreditoMotivo_nombre	-- 2

	FROM	massoftware.NotaCreditoMotivo

	WHERE	(numeroFromArg0 IS NULL OR NotaCreditoMotivo.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR NotaCreditoMotivo.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(NotaCreditoMotivo.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY NotaCreditoMotivo.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_NotaCreditoMotivo_des_NotaCreditoMotivo_Nombre(
		 null::INTEGER -- NotaCreditoMotivo_numeroFromArg0
		, null::INTEGER -- NotaCreditoMotivo_numeroToArg1
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord0Arg2
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord1Arg3
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord2Arg4
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord3Arg5
		, null::VARCHAR -- NotaCreditoMotivo_nombreWord4Arg6
);

*/