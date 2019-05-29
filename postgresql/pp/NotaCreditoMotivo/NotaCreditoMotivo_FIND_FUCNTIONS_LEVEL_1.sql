
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: NotaCreditoMotivo                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.NotaCreditoMotivo

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