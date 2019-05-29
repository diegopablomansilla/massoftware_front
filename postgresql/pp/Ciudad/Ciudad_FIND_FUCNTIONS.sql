
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Ciudad                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Ciudad

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad(
		 null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad(
		100
		, 0
		, null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Numero(
		100
		, 0
		, null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Numero(
		100
		, 0
		, null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Numero(
		 null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Numero(
		 null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Nombre(
		100
		, 0
		, null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Nombre(
		100
		, 0
		, null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Nombre(
		 null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Nombre(
		 null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Departamento(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Departamento(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.departamento ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Departamento(
		100
		, 0
		, null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Departamento(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Departamento(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.departamento DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Departamento(
		100
		, 0
		, null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Departamento(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Departamento(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.departamento ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Departamento(
		 null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Departamento(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Departamento(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.departamento DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Departamento(
		 null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.numeroAFIP ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP(
		100
		, 0
		, null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_NumeroAFIP(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_NumeroAFIP(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.numeroAFIP DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_NumeroAFIP(
		100
		, 0
		, null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.numeroAFIP ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP(
		 null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_NumeroAFIP(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_NumeroAFIP(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.numeroAFIP DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_NumeroAFIP(
		 null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Provincia(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Provincia(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.provincia ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Provincia(
		100
		, 0
		, null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Provincia(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Provincia(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.provincia DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Provincia(
		100
		, 0
		, null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Provincia(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Provincia(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.provincia ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Provincia(
		 null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Provincia(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Provincia(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE	(numeroFromArg0 IS NULL OR Ciudad.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Ciudad.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Ciudad.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (provinciaArg7 IS NULL OR (CHAR_LENGTH(TRIM(provinciaArg7)) > 0 AND Ciudad.provincia = TRIM(provinciaArg7)::VARCHAR))

	ORDER BY Ciudad.provincia DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Provincia(
		 null::INTEGER -- Ciudad_numeroFromArg0
		, null::INTEGER -- Ciudad_numeroToArg1
		, null::VARCHAR -- Ciudad_nombreWord0Arg2
		, null::VARCHAR -- Ciudad_nombreWord1Arg3
		, null::VARCHAR -- Ciudad_nombreWord2Arg4
		, null::VARCHAR -- Ciudad_nombreWord3Arg5
		, null::VARCHAR -- Ciudad_nombreWord4Arg6
		, null::VARCHAR -- Ciudad_provinciaArg7
);

*/