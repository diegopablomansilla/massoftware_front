
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Carga                                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Carga

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_1(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_1(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_1(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Numero_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Numero_1(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Numero_1(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Numero_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Numero_1(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Numero_1(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Numero_1(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Numero_1(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Nombre_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Nombre_1(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Nombre_1(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Nombre_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Nombre_1(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Nombre_1(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Nombre_1(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Nombre_1(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Transporte_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Transporte_1(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Transporte_1(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Transporte_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Transporte_1(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Transporte_1(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Transporte_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Transporte_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Transporte_1(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Transporte_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Transporte_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Transporte_1(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/