
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Provincia                                                                                              //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Provincia

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Numero(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Numero(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Numero(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Numero(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Numero(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Numero(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Numero(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Numero(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Numero(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Numero(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Numero(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Numero(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Nombre(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Nombre(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Nombre(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Nombre(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Nombre(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Nombre(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Nombre(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Nombre(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Nombre(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Nombre(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Nombre(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Nombre(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Abreviatura(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Abreviatura(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.abreviatura ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Abreviatura(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Abreviatura(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Abreviatura(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.abreviatura DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Abreviatura(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Abreviatura(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Abreviatura(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.abreviatura ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Abreviatura(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Abreviatura(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Abreviatura(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.abreviatura DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Abreviatura(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroAFIP(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroAFIP(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroAFIP ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroAFIP(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroAFIP(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroAFIP(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroAFIP DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroAFIP(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroAFIP(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroAFIP(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroAFIP ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroAFIP(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroAFIP(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroAFIP(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroAFIP DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroAFIP(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroIngresosBrutos ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroIngresosBrutos DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroIngresosBrutos ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroIngresosBrutos DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroRENATEA(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroRENATEA(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroRENATEA ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroRENATEA(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroRENATEA(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroRENATEA(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroRENATEA DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroRENATEA(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroRENATEA(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroRENATEA(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroRENATEA ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroRENATEA(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroRENATEA(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroRENATEA(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroRENATEA DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroRENATEA(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Pais(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Pais(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.pais ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Pais(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Pais(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Pais(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.pais DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Pais(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Pais(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Pais(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.pais ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Pais(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Pais(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Pais(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.pais DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Pais(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_1(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_1(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_1(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_1(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Numero_1(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Numero_1(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Numero_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Numero_1(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Numero_1(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Numero_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Numero_1(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Numero_1(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Numero_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Numero_1(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Numero_1(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Numero_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Nombre_1(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Nombre_1(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Nombre_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Nombre_1(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Nombre_1(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Nombre_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Nombre_1(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Nombre_1(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Nombre_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Nombre_1(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Nombre_1(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Nombre_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Abreviatura_1(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Abreviatura_1(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.abreviatura ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Abreviatura_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Abreviatura_1(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Abreviatura_1(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.abreviatura DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Abreviatura_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Abreviatura_1(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Abreviatura_1(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.abreviatura ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Abreviatura_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Abreviatura_1(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Abreviatura_1(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.abreviatura DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Abreviatura_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroAFIP_1(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroAFIP_1(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroAFIP ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroAFIP_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroAFIP_1(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroAFIP_1(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroAFIP DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroAFIP_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroAFIP_1(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroAFIP_1(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroAFIP ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroAFIP_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroAFIP_1(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroAFIP_1(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroAFIP DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroAFIP_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos_1(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos_1(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroIngresosBrutos ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos_1(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos_1(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroIngresosBrutos DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos_1(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos_1(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroIngresosBrutos ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos_1(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos_1(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroIngresosBrutos DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroRENATEA_1(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroRENATEA_1(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroRENATEA ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroRENATEA_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroRENATEA_1(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroRENATEA_1(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroRENATEA DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroRENATEA_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroRENATEA_1(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroRENATEA_1(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroRENATEA ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroRENATEA_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroRENATEA_1(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroRENATEA_1(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroRENATEA DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroRENATEA_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Pais_1(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Pais_1(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.pais ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Pais_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Pais_1(
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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Pais_1(
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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.pais DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Pais_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Pais_1(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Pais_1(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.pais ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Pais_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Pais_1(

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
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Pais_1(

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
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.pais DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Pais_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/