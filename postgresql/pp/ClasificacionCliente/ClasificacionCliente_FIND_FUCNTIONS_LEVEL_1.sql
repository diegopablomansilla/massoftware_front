
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ClasificacionCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ClasificacionCliente

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
) RETURNS massoftware.ClasificacionCliente  AS $$

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


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.ClasificacionCliente  AS $$

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

SELECT * FROM massoftware.f_ClasificacionCliente(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.ClasificacionCliente  AS $$

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

SELECT * FROM massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Numero(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.ClasificacionCliente  AS $$

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

SELECT * FROM massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Numero(100, 0
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
) RETURNS massoftware.ClasificacionCliente  AS $$

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
) RETURNS massoftware.ClasificacionCliente  AS $$

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


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.ClasificacionCliente  AS $$

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

SELECT * FROM massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Nombre(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.ClasificacionCliente  AS $$

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

SELECT * FROM massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Nombre(100, 0
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
) RETURNS massoftware.ClasificacionCliente  AS $$

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
) RETURNS massoftware.ClasificacionCliente  AS $$

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


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Color(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Color(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.ClasificacionCliente  AS $$

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

SELECT * FROM massoftware.f_ClasificacionCliente_asc_ClasificacionCliente_Color(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Color(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Color(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.ClasificacionCliente  AS $$

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

SELECT * FROM massoftware.f_ClasificacionCliente_des_ClasificacionCliente_Color(100, 0
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
) RETURNS massoftware.ClasificacionCliente  AS $$

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
) RETURNS massoftware.ClasificacionCliente  AS $$

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