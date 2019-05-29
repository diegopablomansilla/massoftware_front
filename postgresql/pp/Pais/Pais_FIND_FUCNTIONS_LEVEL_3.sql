
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Pais                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Pais

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais(

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

CREATE OR REPLACE FUNCTION massoftware.f_Pais(

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
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais(
		 null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais(
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

CREATE OR REPLACE FUNCTION massoftware.f_Pais(
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
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais(
		100
		, 0
		, null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_asc_Pais_Numero(
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

CREATE OR REPLACE FUNCTION massoftware.f_Pais_asc_Pais_Numero(
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
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_asc_Pais_Numero(
		100
		, 0
		, null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_des_Pais_Numero(
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

CREATE OR REPLACE FUNCTION massoftware.f_Pais_des_Pais_Numero(
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
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_des_Pais_Numero(
		100
		, 0
		, null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_asc_Pais_Numero(

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

CREATE OR REPLACE FUNCTION massoftware.f_Pais_asc_Pais_Numero(

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
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_asc_Pais_Numero(
		 null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_des_Pais_Numero(

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

CREATE OR REPLACE FUNCTION massoftware.f_Pais_des_Pais_Numero(

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
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_des_Pais_Numero(
		 null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_asc_Pais_Nombre(
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

CREATE OR REPLACE FUNCTION massoftware.f_Pais_asc_Pais_Nombre(
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
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_asc_Pais_Nombre(
		100
		, 0
		, null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_des_Pais_Nombre(
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

CREATE OR REPLACE FUNCTION massoftware.f_Pais_des_Pais_Nombre(
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
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_des_Pais_Nombre(
		100
		, 0
		, null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_asc_Pais_Nombre(

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

CREATE OR REPLACE FUNCTION massoftware.f_Pais_asc_Pais_Nombre(

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
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_asc_Pais_Nombre(
		 null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_des_Pais_Nombre(

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

CREATE OR REPLACE FUNCTION massoftware.f_Pais_des_Pais_Nombre(

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
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_des_Pais_Nombre(
		 null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_asc_Pais_Abreviatura(
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

CREATE OR REPLACE FUNCTION massoftware.f_Pais_asc_Pais_Abreviatura(
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
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.abreviatura ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_asc_Pais_Abreviatura(
		100
		, 0
		, null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_des_Pais_Abreviatura(
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

CREATE OR REPLACE FUNCTION massoftware.f_Pais_des_Pais_Abreviatura(
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
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.abreviatura DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_des_Pais_Abreviatura(
		100
		, 0
		, null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_asc_Pais_Abreviatura(

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

CREATE OR REPLACE FUNCTION massoftware.f_Pais_asc_Pais_Abreviatura(

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
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.abreviatura ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_asc_Pais_Abreviatura(
		 null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_des_Pais_Abreviatura(

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

CREATE OR REPLACE FUNCTION massoftware.f_Pais_des_Pais_Abreviatura(

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
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.abreviatura DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_des_Pais_Abreviatura(
		 null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/