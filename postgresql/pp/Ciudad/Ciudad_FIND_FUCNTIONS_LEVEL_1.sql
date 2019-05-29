
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Ciudad                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Ciudad

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_1(

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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_1(
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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Numero_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Numero_1(
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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Numero_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Numero_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Numero_1(
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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Numero_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Numero_1(

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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Numero_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Numero_1(

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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Numero_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Nombre_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Nombre_1(
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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Nombre_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Nombre_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Nombre_1(
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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Nombre_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Nombre_1(

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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Nombre_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Nombre_1(

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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Nombre_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Departamento_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Departamento_1(
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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Departamento_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Departamento_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Departamento_1(
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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Departamento_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Departamento_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Departamento_1(

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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Departamento_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Departamento_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Departamento_1(

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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Departamento_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP_1(
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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_NumeroAFIP_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_NumeroAFIP_1(
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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_NumeroAFIP_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP_1(

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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_NumeroAFIP_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_NumeroAFIP_1(

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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_NumeroAFIP_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Provincia_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Provincia_1(
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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Provincia_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Provincia_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Provincia_1(
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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Provincia_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Provincia_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Provincia_1(

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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Provincia_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Provincia_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Provincia_1(

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
		 Ciudad_id VARCHAR(36)                	-- 0
		,Ciudad_numero INTEGER                	-- 1
		,Ciudad_nombre VARCHAR(50)            	-- 2
		,Ciudad_departamento VARCHAR(50)      	-- 3
		,Ciudad_numeroAFIP INTEGER            	-- 4
		,Provincia_id VARCHAR(36)             	-- 5
		,Provincia_numero INTEGER             	-- 6
		,Provincia_nombre VARCHAR(50)         	-- 7
		,Provincia_abreviatura VARCHAR(5)     	-- 8
		,Provincia_numeroAFIP INTEGER         	-- 9
		,Provincia_numeroIngresosBrutos INTEGER	-- 10
		,Provincia_numeroRENATEA INTEGER      	-- 11
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                                         	-- 0
		,Ciudad.numero AS Ciudad_numero                                 	-- 1
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 2
		,Ciudad.departamento AS Ciudad_departamento                     	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 4
		,Provincia.id AS Provincia_id                                   	-- 5
		,Provincia.numero AS Provincia_numero                           	-- 6
		,Provincia.nombre AS Provincia_nombre                           	-- 7
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 8
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 9
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 10
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 11

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Provincia_1(
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