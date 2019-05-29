
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Transporte                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Transporte

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Numero(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Numero(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Numero(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Numero(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Nombre(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Nombre(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Nombre(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Nombre(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Cuit(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Cuit(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Cuit(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Cuit(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Cuit(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Cuit(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Cuit(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Cuit(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Cuit(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Cuit(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Cuit(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Cuit(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_IngresosBrutos(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_IngresosBrutos(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_IngresosBrutos(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_IngresosBrutos(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_IngresosBrutos(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_IngresosBrutos(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_IngresosBrutos(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_IngresosBrutos(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_IngresosBrutos(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_IngresosBrutos(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_IngresosBrutos(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_IngresosBrutos(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Telefono(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Telefono(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Telefono(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Telefono(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Telefono(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Telefono(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Telefono(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Telefono(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Telefono(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Telefono(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Telefono(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Telefono(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Fax(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Fax(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Fax(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Fax(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Fax(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Fax(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Fax(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Fax(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Fax(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Fax(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Fax(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Fax(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_CodigoPostal(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_CodigoPostal(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_CodigoPostal(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_CodigoPostal(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_CodigoPostal(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_CodigoPostal(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_CodigoPostal(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_CodigoPostal(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_CodigoPostal(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_CodigoPostal(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_CodigoPostal(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_CodigoPostal(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Domicilio(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Domicilio(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Domicilio(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Domicilio(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Domicilio(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Domicilio(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Domicilio(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Domicilio(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Domicilio(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Domicilio(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Domicilio(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Domicilio(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Comentario(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Comentario(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Comentario(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Comentario(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Comentario(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Comentario(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Comentario(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Comentario(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Comentario(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Comentario(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Comentario(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Comentario(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/