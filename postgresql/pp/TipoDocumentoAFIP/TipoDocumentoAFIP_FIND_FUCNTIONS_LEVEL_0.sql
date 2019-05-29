
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoDocumentoAFIP                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoDocumentoAFIP

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TipoDocumentoAFIP(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoDocumentoAFIP(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 TipoDocumentoAFIP_id VARCHAR(36)   	-- 0
		,TipoDocumentoAFIP_numero INTEGER   	-- 1
		,TipoDocumentoAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 TipoDocumentoAFIP.id AS TipoDocumentoAFIP_id       	-- 0
		,TipoDocumentoAFIP.numero AS TipoDocumentoAFIP_numero	-- 1
		,TipoDocumentoAFIP.nombre AS TipoDocumentoAFIP_nombre	-- 2

	FROM	massoftware.TipoDocumentoAFIP

	WHERE	(numeroFromArg0 IS NULL OR TipoDocumentoAFIP.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR TipoDocumentoAFIP.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY TipoDocumentoAFIP.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TipoDocumentoAFIP(
		 null::INTEGER -- TipoDocumentoAFIP_numeroFromArg0
		, null::INTEGER -- TipoDocumentoAFIP_numeroToArg1
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord0Arg2
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord1Arg3
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord2Arg4
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord3Arg5
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TipoDocumentoAFIP(
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

CREATE OR REPLACE FUNCTION massoftware.f_TipoDocumentoAFIP(
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
		 TipoDocumentoAFIP_id VARCHAR(36)   	-- 0
		,TipoDocumentoAFIP_numero INTEGER   	-- 1
		,TipoDocumentoAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 TipoDocumentoAFIP.id AS TipoDocumentoAFIP_id       	-- 0
		,TipoDocumentoAFIP.numero AS TipoDocumentoAFIP_numero	-- 1
		,TipoDocumentoAFIP.nombre AS TipoDocumentoAFIP_nombre	-- 2

	FROM	massoftware.TipoDocumentoAFIP

	WHERE	(numeroFromArg0 IS NULL OR TipoDocumentoAFIP.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR TipoDocumentoAFIP.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY TipoDocumentoAFIP.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TipoDocumentoAFIP(
		100
		, 0
		, null::INTEGER -- TipoDocumentoAFIP_numeroFromArg0
		, null::INTEGER -- TipoDocumentoAFIP_numeroToArg1
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord0Arg2
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord1Arg3
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord2Arg4
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord3Arg5
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TipoDocumentoAFIP_asc_TipoDocumentoAFIP_Numero(
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

CREATE OR REPLACE FUNCTION massoftware.f_TipoDocumentoAFIP_asc_TipoDocumentoAFIP_Numero(
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
		 TipoDocumentoAFIP_id VARCHAR(36)   	-- 0
		,TipoDocumentoAFIP_numero INTEGER   	-- 1
		,TipoDocumentoAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 TipoDocumentoAFIP.id AS TipoDocumentoAFIP_id       	-- 0
		,TipoDocumentoAFIP.numero AS TipoDocumentoAFIP_numero	-- 1
		,TipoDocumentoAFIP.nombre AS TipoDocumentoAFIP_nombre	-- 2

	FROM	massoftware.TipoDocumentoAFIP

	WHERE	(numeroFromArg0 IS NULL OR TipoDocumentoAFIP.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR TipoDocumentoAFIP.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY TipoDocumentoAFIP.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TipoDocumentoAFIP_asc_TipoDocumentoAFIP_Numero(
		100
		, 0
		, null::INTEGER -- TipoDocumentoAFIP_numeroFromArg0
		, null::INTEGER -- TipoDocumentoAFIP_numeroToArg1
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord0Arg2
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord1Arg3
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord2Arg4
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord3Arg5
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TipoDocumentoAFIP_des_TipoDocumentoAFIP_Numero(
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

CREATE OR REPLACE FUNCTION massoftware.f_TipoDocumentoAFIP_des_TipoDocumentoAFIP_Numero(
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
		 TipoDocumentoAFIP_id VARCHAR(36)   	-- 0
		,TipoDocumentoAFIP_numero INTEGER   	-- 1
		,TipoDocumentoAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 TipoDocumentoAFIP.id AS TipoDocumentoAFIP_id       	-- 0
		,TipoDocumentoAFIP.numero AS TipoDocumentoAFIP_numero	-- 1
		,TipoDocumentoAFIP.nombre AS TipoDocumentoAFIP_nombre	-- 2

	FROM	massoftware.TipoDocumentoAFIP

	WHERE	(numeroFromArg0 IS NULL OR TipoDocumentoAFIP.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR TipoDocumentoAFIP.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY TipoDocumentoAFIP.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TipoDocumentoAFIP_des_TipoDocumentoAFIP_Numero(
		100
		, 0
		, null::INTEGER -- TipoDocumentoAFIP_numeroFromArg0
		, null::INTEGER -- TipoDocumentoAFIP_numeroToArg1
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord0Arg2
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord1Arg3
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord2Arg4
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord3Arg5
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TipoDocumentoAFIP_asc_TipoDocumentoAFIP_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoDocumentoAFIP_asc_TipoDocumentoAFIP_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 TipoDocumentoAFIP_id VARCHAR(36)   	-- 0
		,TipoDocumentoAFIP_numero INTEGER   	-- 1
		,TipoDocumentoAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 TipoDocumentoAFIP.id AS TipoDocumentoAFIP_id       	-- 0
		,TipoDocumentoAFIP.numero AS TipoDocumentoAFIP_numero	-- 1
		,TipoDocumentoAFIP.nombre AS TipoDocumentoAFIP_nombre	-- 2

	FROM	massoftware.TipoDocumentoAFIP

	WHERE	(numeroFromArg0 IS NULL OR TipoDocumentoAFIP.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR TipoDocumentoAFIP.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY TipoDocumentoAFIP.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TipoDocumentoAFIP_asc_TipoDocumentoAFIP_Numero(
		 null::INTEGER -- TipoDocumentoAFIP_numeroFromArg0
		, null::INTEGER -- TipoDocumentoAFIP_numeroToArg1
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord0Arg2
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord1Arg3
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord2Arg4
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord3Arg5
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TipoDocumentoAFIP_des_TipoDocumentoAFIP_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoDocumentoAFIP_des_TipoDocumentoAFIP_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 TipoDocumentoAFIP_id VARCHAR(36)   	-- 0
		,TipoDocumentoAFIP_numero INTEGER   	-- 1
		,TipoDocumentoAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 TipoDocumentoAFIP.id AS TipoDocumentoAFIP_id       	-- 0
		,TipoDocumentoAFIP.numero AS TipoDocumentoAFIP_numero	-- 1
		,TipoDocumentoAFIP.nombre AS TipoDocumentoAFIP_nombre	-- 2

	FROM	massoftware.TipoDocumentoAFIP

	WHERE	(numeroFromArg0 IS NULL OR TipoDocumentoAFIP.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR TipoDocumentoAFIP.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY TipoDocumentoAFIP.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TipoDocumentoAFIP_des_TipoDocumentoAFIP_Numero(
		 null::INTEGER -- TipoDocumentoAFIP_numeroFromArg0
		, null::INTEGER -- TipoDocumentoAFIP_numeroToArg1
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord0Arg2
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord1Arg3
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord2Arg4
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord3Arg5
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TipoDocumentoAFIP_asc_TipoDocumentoAFIP_Nombre(
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

CREATE OR REPLACE FUNCTION massoftware.f_TipoDocumentoAFIP_asc_TipoDocumentoAFIP_Nombre(
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
		 TipoDocumentoAFIP_id VARCHAR(36)   	-- 0
		,TipoDocumentoAFIP_numero INTEGER   	-- 1
		,TipoDocumentoAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 TipoDocumentoAFIP.id AS TipoDocumentoAFIP_id       	-- 0
		,TipoDocumentoAFIP.numero AS TipoDocumentoAFIP_numero	-- 1
		,TipoDocumentoAFIP.nombre AS TipoDocumentoAFIP_nombre	-- 2

	FROM	massoftware.TipoDocumentoAFIP

	WHERE	(numeroFromArg0 IS NULL OR TipoDocumentoAFIP.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR TipoDocumentoAFIP.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY TipoDocumentoAFIP.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TipoDocumentoAFIP_asc_TipoDocumentoAFIP_Nombre(
		100
		, 0
		, null::INTEGER -- TipoDocumentoAFIP_numeroFromArg0
		, null::INTEGER -- TipoDocumentoAFIP_numeroToArg1
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord0Arg2
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord1Arg3
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord2Arg4
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord3Arg5
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TipoDocumentoAFIP_des_TipoDocumentoAFIP_Nombre(
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

CREATE OR REPLACE FUNCTION massoftware.f_TipoDocumentoAFIP_des_TipoDocumentoAFIP_Nombre(
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
		 TipoDocumentoAFIP_id VARCHAR(36)   	-- 0
		,TipoDocumentoAFIP_numero INTEGER   	-- 1
		,TipoDocumentoAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 TipoDocumentoAFIP.id AS TipoDocumentoAFIP_id       	-- 0
		,TipoDocumentoAFIP.numero AS TipoDocumentoAFIP_numero	-- 1
		,TipoDocumentoAFIP.nombre AS TipoDocumentoAFIP_nombre	-- 2

	FROM	massoftware.TipoDocumentoAFIP

	WHERE	(numeroFromArg0 IS NULL OR TipoDocumentoAFIP.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR TipoDocumentoAFIP.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY TipoDocumentoAFIP.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TipoDocumentoAFIP_des_TipoDocumentoAFIP_Nombre(
		100
		, 0
		, null::INTEGER -- TipoDocumentoAFIP_numeroFromArg0
		, null::INTEGER -- TipoDocumentoAFIP_numeroToArg1
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord0Arg2
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord1Arg3
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord2Arg4
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord3Arg5
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TipoDocumentoAFIP_asc_TipoDocumentoAFIP_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoDocumentoAFIP_asc_TipoDocumentoAFIP_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 TipoDocumentoAFIP_id VARCHAR(36)   	-- 0
		,TipoDocumentoAFIP_numero INTEGER   	-- 1
		,TipoDocumentoAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 TipoDocumentoAFIP.id AS TipoDocumentoAFIP_id       	-- 0
		,TipoDocumentoAFIP.numero AS TipoDocumentoAFIP_numero	-- 1
		,TipoDocumentoAFIP.nombre AS TipoDocumentoAFIP_nombre	-- 2

	FROM	massoftware.TipoDocumentoAFIP

	WHERE	(numeroFromArg0 IS NULL OR TipoDocumentoAFIP.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR TipoDocumentoAFIP.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY TipoDocumentoAFIP.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TipoDocumentoAFIP_asc_TipoDocumentoAFIP_Nombre(
		 null::INTEGER -- TipoDocumentoAFIP_numeroFromArg0
		, null::INTEGER -- TipoDocumentoAFIP_numeroToArg1
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord0Arg2
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord1Arg3
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord2Arg4
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord3Arg5
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TipoDocumentoAFIP_des_TipoDocumentoAFIP_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoDocumentoAFIP_des_TipoDocumentoAFIP_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 TipoDocumentoAFIP_id VARCHAR(36)   	-- 0
		,TipoDocumentoAFIP_numero INTEGER   	-- 1
		,TipoDocumentoAFIP_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 TipoDocumentoAFIP.id AS TipoDocumentoAFIP_id       	-- 0
		,TipoDocumentoAFIP.numero AS TipoDocumentoAFIP_numero	-- 1
		,TipoDocumentoAFIP.nombre AS TipoDocumentoAFIP_nombre	-- 2

	FROM	massoftware.TipoDocumentoAFIP

	WHERE	(numeroFromArg0 IS NULL OR TipoDocumentoAFIP.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR TipoDocumentoAFIP.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(TipoDocumentoAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY TipoDocumentoAFIP.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TipoDocumentoAFIP_des_TipoDocumentoAFIP_Nombre(
		 null::INTEGER -- TipoDocumentoAFIP_numeroFromArg0
		, null::INTEGER -- TipoDocumentoAFIP_numeroToArg1
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord0Arg2
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord1Arg3
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord2Arg4
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord3Arg5
		, null::VARCHAR -- TipoDocumentoAFIP_nombreWord4Arg6
);

*/