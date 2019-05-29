
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Transporte                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Transporte

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Numero_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Numero_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Numero_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Numero_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Numero_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_des_Transporte_Numero_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Numero_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_des_Transporte_Numero_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Nombre_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Nombre_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Nombre_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Nombre_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Nombre_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_des_Transporte_Nombre_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Nombre_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_des_Transporte_Nombre_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Cuit_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Cuit_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.cuit ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Cuit_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Cuit_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Cuit_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.cuit DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_des_Transporte_Cuit_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Cuit_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Cuit_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.cuit ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Cuit_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Cuit_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Cuit_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.cuit DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_des_Transporte_Cuit_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_IngresosBrutos_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_IngresosBrutos_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.ingresosBrutos ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_asc_Transporte_IngresosBrutos_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_IngresosBrutos_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_IngresosBrutos_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.ingresosBrutos DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_des_Transporte_IngresosBrutos_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_IngresosBrutos_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_IngresosBrutos_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.ingresosBrutos ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_asc_Transporte_IngresosBrutos_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_IngresosBrutos_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_IngresosBrutos_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.ingresosBrutos DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_des_Transporte_IngresosBrutos_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Telefono_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Telefono_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.telefono ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Telefono_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Telefono_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Telefono_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.telefono DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_des_Transporte_Telefono_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Telefono_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Telefono_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.telefono ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Telefono_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Telefono_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Telefono_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.telefono DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_des_Transporte_Telefono_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Fax_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Fax_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.fax ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Fax_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Fax_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Fax_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.fax DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_des_Transporte_Fax_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Fax_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Fax_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.fax ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Fax_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Fax_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Fax_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.fax DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_des_Transporte_Fax_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_CodigoPostal_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_CodigoPostal_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.codigoPostal ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_asc_Transporte_CodigoPostal_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_CodigoPostal_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_CodigoPostal_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.codigoPostal DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_des_Transporte_CodigoPostal_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_CodigoPostal_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_CodigoPostal_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.codigoPostal ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_asc_Transporte_CodigoPostal_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_CodigoPostal_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_CodigoPostal_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.codigoPostal DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_des_Transporte_CodigoPostal_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Domicilio_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Domicilio_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.domicilio ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Domicilio_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Domicilio_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Domicilio_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.domicilio DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_des_Transporte_Domicilio_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Domicilio_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Domicilio_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.domicilio ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Domicilio_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Domicilio_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Domicilio_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.domicilio DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_des_Transporte_Domicilio_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Comentario_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Comentario_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.comentario ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Comentario_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Comentario_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Comentario_1(
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
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.comentario DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_des_Transporte_Comentario_1(
		100
		, 0
		, null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Comentario_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Comentario_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.comentario ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Comentario_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Comentario_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Comentario_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Transporte.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Transporte.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Transporte.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Transporte.comentario DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Transporte_des_Transporte_Comentario_1(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/