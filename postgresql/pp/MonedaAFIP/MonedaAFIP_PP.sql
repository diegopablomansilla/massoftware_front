
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

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIPById(idArg VARCHAR(36)) RETURNS massoftware.MonedaAFIP AS $$

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