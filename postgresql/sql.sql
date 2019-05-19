


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MonedaAFIP                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MonedaAFIP

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.MonedaAFIP CASCADE;

CREATE TABLE massoftware.MonedaAFIP
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Código
	codigo VARCHAR(3) NOT NULL, 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_MonedaAFIP_codigo ON massoftware.MonedaAFIP (TRANSLATE(LOWER(TRIM(codigo))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_MonedaAFIP_nombre ON massoftware.MonedaAFIP (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatMonedaAFIP() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatMonedaAFIP() RETURNS TRIGGER AS $formatMonedaAFIP$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.codigo := massoftware.white_is_null(NEW.codigo);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatMonedaAFIP$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatMonedaAFIP ON massoftware.MonedaAFIP CASCADE;

CREATE TRIGGER tgFormatMonedaAFIP BEFORE INSERT OR UPDATE
	ON massoftware.MonedaAFIP FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatMonedaAFIP();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.MonedaAFIP;

-- SELECT * FROM massoftware.MonedaAFIP LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.MonedaAFIP;

-- SELECT * FROM massoftware.MonedaAFIP WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_MonedaAFIPById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_MonedaAFIPById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.MonedaAFIP WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaAFIP.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.MonedaAFIP WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaAFIP.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.MonedaAFIP WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaAFIP.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_MonedaAFIPById('xxx');

-- SELECT * FROM massoftware.d_MonedaAFIPById((SELECT MonedaAFIP.id FROM massoftware.MonedaAFIP LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_MonedaAFIP(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_MonedaAFIP(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.MonedaAFIP(id, codigo, nombre) VALUES (idArg, codigoArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.MonedaAFIP WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaAFIP.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_MonedaAFIP(
		null::VARCHAR(36)
		, null::VARCHAR
		, null::VARCHAR
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_MonedaAFIP(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_MonedaAFIP(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.MonedaAFIP SET 
		  codigo = codigoArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaAFIP.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.MonedaAFIP WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaAFIP.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_MonedaAFIP(
		null::VARCHAR(36)
		, null::VARCHAR
		, null::VARCHAR
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_MonedaAFIP_codigo(codigoArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_MonedaAFIP_codigo(codigoArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.MonedaAFIP
	WHERE	(codigoArg IS NULL OR (CHAR_LENGTH(TRIM(codigoArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(MonedaAFIP.codigo)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(codigoArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_MonedaAFIP_codigo(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_MonedaAFIP_nombre(nombreArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_MonedaAFIP_nombre(nombreArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.MonedaAFIP
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(MonedaAFIP.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_MonedaAFIP_nombre(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIPById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIPById(idArg VARCHAR(36)) RETURNS
	TABLE(
		 MonedaAFIP_id VARCHAR(36)   	-- 0
		,MonedaAFIP_codigo VARCHAR(3)	-- 1
		,MonedaAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaAFIP.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_MonedaAFIPById('xxx');

-- SELECT * FROM massoftware.f_MonedaAFIPById((SELECT MonedaAFIP.id FROM massoftware.MonedaAFIP LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 MonedaAFIP_id VARCHAR(36)   	-- 0
		,MonedaAFIP_codigo VARCHAR(3)	-- 1
		,MonedaAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP(
		 null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 MonedaAFIP_id VARCHAR(36)   	-- 0
		,MonedaAFIP_codigo VARCHAR(3)	-- 1
		,MonedaAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP(
		100
		, 0
		, null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP_asc_MonedaAFIP_Codigo(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP_asc_MonedaAFIP_Codigo(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 MonedaAFIP_id VARCHAR(36)   	-- 0
		,MonedaAFIP_codigo VARCHAR(3)	-- 1
		,MonedaAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.codigo ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP_asc_MonedaAFIP_Codigo(
		100
		, 0
		, null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP_des_MonedaAFIP_Codigo(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP_des_MonedaAFIP_Codigo(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 MonedaAFIP_id VARCHAR(36)   	-- 0
		,MonedaAFIP_codigo VARCHAR(3)	-- 1
		,MonedaAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.codigo DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP_des_MonedaAFIP_Codigo(
		100
		, 0
		, null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP_asc_MonedaAFIP_Codigo(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP_asc_MonedaAFIP_Codigo(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 MonedaAFIP_id VARCHAR(36)   	-- 0
		,MonedaAFIP_codigo VARCHAR(3)	-- 1
		,MonedaAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.codigo ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP_asc_MonedaAFIP_Codigo(
		 null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP_des_MonedaAFIP_Codigo(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP_des_MonedaAFIP_Codigo(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 MonedaAFIP_id VARCHAR(36)   	-- 0
		,MonedaAFIP_codigo VARCHAR(3)	-- 1
		,MonedaAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.codigo DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP_des_MonedaAFIP_Codigo(
		 null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP_asc_MonedaAFIP_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP_asc_MonedaAFIP_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 MonedaAFIP_id VARCHAR(36)   	-- 0
		,MonedaAFIP_codigo VARCHAR(3)	-- 1
		,MonedaAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP_asc_MonedaAFIP_Nombre(
		100
		, 0
		, null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP_des_MonedaAFIP_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP_des_MonedaAFIP_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 MonedaAFIP_id VARCHAR(36)   	-- 0
		,MonedaAFIP_codigo VARCHAR(3)	-- 1
		,MonedaAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP_des_MonedaAFIP_Nombre(
		100
		, 0
		, null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP_asc_MonedaAFIP_Nombre(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP_asc_MonedaAFIP_Nombre(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 MonedaAFIP_id VARCHAR(36)   	-- 0
		,MonedaAFIP_codigo VARCHAR(3)	-- 1
		,MonedaAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP_asc_MonedaAFIP_Nombre(
		 null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP_des_MonedaAFIP_Nombre(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP_des_MonedaAFIP_Nombre(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 MonedaAFIP_id VARCHAR(36)   	-- 0
		,MonedaAFIP_codigo VARCHAR(3)	-- 1
		,MonedaAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP_des_MonedaAFIP_Nombre(
		 null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Moneda                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Moneda

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Moneda CASCADE;

CREATE TABLE massoftware.Moneda
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº moneda
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Moneda_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Abreviatura
	abreviatura VARCHAR(5) NOT NULL, 
	
	-- Cotización
	cotizacion DECIMAL(9, 4) NOT NULL  CONSTRAINT Moneda_cotizacion_chk CHECK ( cotizacion >= -9999.9999 AND cotizacion <= 99999.9999  ), 
	
	-- Fecha cotización
	cotizacionFecha TIMESTAMP NOT NULL, 
	
	-- Control de actualizacion
	controlActualizacion BOOLEAN NOT NULL, 
	
	-- Moneda AFIP
	monedaAFIP VARCHAR(36)  NOT NULL  REFERENCES massoftware.MonedaAFIP (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Moneda_nombre ON massoftware.Moneda (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_Moneda_abreviatura ON massoftware.Moneda (TRANSLATE(LOWER(TRIM(abreviatura))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatMoneda() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatMoneda() RETURNS TRIGGER AS $formatMoneda$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.abreviatura := massoftware.white_is_null(NEW.abreviatura);
	 NEW.monedaAFIP := massoftware.white_is_null(NEW.monedaAFIP);

	RETURN NEW;
END;
$formatMoneda$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatMoneda ON massoftware.Moneda CASCADE;

CREATE TRIGGER tgFormatMoneda BEFORE INSERT OR UPDATE
	ON massoftware.Moneda FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatMoneda();

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

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Moneda_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Moneda_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.Moneda
	WHERE	(numeroArg IS NULL OR Moneda.numero = numeroArg);

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Moneda_numero(null::INTEGER);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Moneda_nombre(nombreArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Moneda_nombre(nombreArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.Moneda
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Moneda.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Moneda_nombre(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Moneda_abreviatura(abreviaturaArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Moneda_abreviatura(abreviaturaArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.Moneda
	WHERE	(abreviaturaArg IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Moneda.abreviatura)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(abreviaturaArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Moneda_abreviatura(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Moneda_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Moneda_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER
	FROM	massoftware.Moneda;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_Moneda_numero();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Moneda_cotizacion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Moneda_cotizacion() RETURNS DECIMAL AS $$

	SELECT (COALESCE(MAX(cotizacion),0) + 1)::DECIMAL
	FROM	massoftware.Moneda;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_Moneda_cotizacion();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaById(idArg VARCHAR(36)) RETURNS
	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Moneda.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_MonedaById('xxx');

-- SELECT * FROM massoftware.f_MonedaById((SELECT Moneda.id FROM massoftware.Moneda LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaById_1(idArg VARCHAR(36)) RETURNS
	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Moneda.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_MonedaById_1('xxx');

-- SELECT * FROM massoftware.f_MonedaById_1((SELECT Moneda.id FROM massoftware.Moneda LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_Numero(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_Numero(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_Numero(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_Numero(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_Nombre(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_Nombre(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_Nombre(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_Nombre(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_Abreviatura(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_Abreviatura(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.abreviatura ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_Abreviatura(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_Abreviatura(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_Abreviatura(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.abreviatura DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_Abreviatura(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_Abreviatura(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_Abreviatura(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.abreviatura ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_Abreviatura(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_Abreviatura(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_Abreviatura(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.abreviatura DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_Abreviatura(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_Cotizacion(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_Cotizacion(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.cotizacion ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_Cotizacion(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_Cotizacion(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_Cotizacion(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.cotizacion DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_Cotizacion(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_Cotizacion(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_Cotizacion(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.cotizacion ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_Cotizacion(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_Cotizacion(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_Cotizacion(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.cotizacion DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_Cotizacion(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_ControlActualizacion(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_ControlActualizacion(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.controlActualizacion ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_ControlActualizacion(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_ControlActualizacion(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_ControlActualizacion(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.controlActualizacion DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_ControlActualizacion(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_ControlActualizacion(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_ControlActualizacion(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.controlActualizacion ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_ControlActualizacion(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_ControlActualizacion(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_ControlActualizacion(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.controlActualizacion DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_ControlActualizacion(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_MonedaAFIP(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_MonedaAFIP(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.monedaAFIP ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_MonedaAFIP(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_MonedaAFIP(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_MonedaAFIP(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.monedaAFIP DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_MonedaAFIP(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_MonedaAFIP(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_MonedaAFIP(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.monedaAFIP ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_MonedaAFIP(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_MonedaAFIP(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_MonedaAFIP(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6

	FROM	massoftware.Moneda

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.monedaAFIP DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_MonedaAFIP(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_1(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_1(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------

 
						
DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_Numero_1(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_Numero_1(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_Numero_1(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_Numero_1(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_Nombre_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_Nombre_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_Nombre_1(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_Nombre_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_Nombre_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_Nombre_1(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_Nombre_1(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_Nombre_1(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_Abreviatura_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_Abreviatura_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.abreviatura ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_Abreviatura_1(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_Abreviatura_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_Abreviatura_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.abreviatura DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_Abreviatura_1(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_Abreviatura_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_Abreviatura_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.abreviatura ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_Abreviatura_1(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_Abreviatura_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_Abreviatura_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.abreviatura DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_Abreviatura_1(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_Cotizacion_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_Cotizacion_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.cotizacion ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_Cotizacion_1(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_Cotizacion_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_Cotizacion_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.cotizacion DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_Cotizacion_1(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_Cotizacion_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_Cotizacion_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.cotizacion ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_Cotizacion_1(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_Cotizacion_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_Cotizacion_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.cotizacion DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_Cotizacion_1(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_ControlActualizacion_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_ControlActualizacion_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.controlActualizacion ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_ControlActualizacion_1(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_ControlActualizacion_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_ControlActualizacion_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.controlActualizacion DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_ControlActualizacion_1(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_ControlActualizacion_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_ControlActualizacion_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.controlActualizacion ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_ControlActualizacion_1(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_ControlActualizacion_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_ControlActualizacion_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.controlActualizacion DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_ControlActualizacion_1(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_MonedaAFIP_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_MonedaAFIP_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.monedaAFIP ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_MonedaAFIP_1(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_MonedaAFIP_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_MonedaAFIP_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.monedaAFIP DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_MonedaAFIP_1(
		100
		, 0
		, null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_asc_Moneda_MonedaAFIP_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_asc_Moneda_MonedaAFIP_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.monedaAFIP ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_asc_Moneda_MonedaAFIP_1(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Moneda_des_Moneda_MonedaAFIP_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_des_Moneda_MonedaAFIP_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
) RETURNS

	TABLE(
		 Moneda_id VARCHAR(36)             	-- 0
		,Moneda_numero INTEGER             	-- 1
		,Moneda_nombre VARCHAR(50)         	-- 2
		,Moneda_abreviatura VARCHAR(5)     	-- 3
		,Moneda_cotizacion DECIMAL(9, 4)   	-- 4
		,Moneda_cotizacionFecha TIMESTAMP  	-- 5
		,Moneda_controlActualizacion BOOLEAN	-- 6
		,MonedaAFIP_id VARCHAR(36)         	-- 7
		,MonedaAFIP_codigo VARCHAR(3)      	-- 8
		,MonedaAFIP_nombre VARCHAR(50)     	-- 9
	) AS $$

	SELECT
		 Moneda.id AS Moneda_id                                   	-- 0
		,Moneda.numero AS Moneda_numero                           	-- 1
		,Moneda.nombre AS Moneda_nombre                           	-- 2
		,Moneda.abreviatura AS Moneda_abreviatura                 	-- 3
		,Moneda.cotizacion AS Moneda_cotizacion                   	-- 4
		,Moneda.cotizacionFecha AS Moneda_cotizacionFecha         	-- 5
		,Moneda.controlActualizacion AS Moneda_controlActualizacion	-- 6
		,MonedaAFIP.id AS MonedaAFIP_id                           	-- 7
		,MonedaAFIP.codigo AS MonedaAFIP_codigo                   	-- 8
		,MonedaAFIP.nombre AS MonedaAFIP_nombre                   	-- 9

	FROM	massoftware.Moneda
		LEFT JOIN massoftware.MonedaAFIP ON Moneda.monedaAFIP = MonedaAFIP.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Moneda.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Moneda.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Moneda.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Moneda.monedaAFIP DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Moneda_des_Moneda_MonedaAFIP_1(
		 null::INTEGER -- Moneda_numeroFromArg0
		, null::INTEGER -- Moneda_numeroToArg1
		, null::VARCHAR -- Moneda_nombreWord0Arg2
		, null::VARCHAR -- Moneda_nombreWord1Arg3
		, null::VARCHAR -- Moneda_nombreWord2Arg4
		, null::VARCHAR -- Moneda_nombreWord3Arg5
		, null::VARCHAR -- Moneda_nombreWord4Arg6
		, null::VARCHAR -- Moneda_abreviaturaWord0Arg7
		, null::VARCHAR -- Moneda_abreviaturaWord1Arg8
		, null::VARCHAR -- Moneda_abreviaturaWord2Arg9
		, null::VARCHAR -- Moneda_abreviaturaWord3Arg10
		, null::VARCHAR -- Moneda_abreviaturaWord4Arg11
);

*/