
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoBloqueoCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoBloqueoCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_1(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_1(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Numero_1(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Numero_1(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Numero_1(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Numero_1(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Nombre_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Nombre_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Nombre_1(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Nombre_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Nombre_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Nombre_1(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_Nombre_1(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_Nombre_1(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_ClasificacionCliente_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_ClasificacionCliente_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.clasificacionCliente ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_ClasificacionCliente_1(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_ClasificacionCliente_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_ClasificacionCliente_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.clasificacionCliente DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_ClasificacionCliente_1(
		100
		, 0
		, null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_ClasificacionCliente_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_ClasificacionCliente_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.clasificacionCliente ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_asc_MotivoBloqueoCliente_ClasificacionCliente_1(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_ClasificacionCliente_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_ClasificacionCliente_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, clasificacionClienteArg7 VARCHAR(36)
) RETURNS

	TABLE(
		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
	) AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR MotivoBloqueoCliente.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoBloqueoCliente.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (clasificacionClienteArg7 IS NULL OR (CHAR_LENGTH(TRIM(clasificacionClienteArg7)) > 0 AND MotivoBloqueoCliente.clasificacionCliente = TRIM(clasificacionClienteArg7)::VARCHAR))

	ORDER BY MotivoBloqueoCliente.clasificacionCliente DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoBloqueoCliente_des_MotivoBloqueoCliente_ClasificacionCliente_1(
		 null::INTEGER -- MotivoBloqueoCliente_numeroFromArg0
		, null::INTEGER -- MotivoBloqueoCliente_numeroToArg1
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord0Arg2
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord1Arg3
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord2Arg4
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord3Arg5
		, null::VARCHAR -- MotivoBloqueoCliente_nombreWord4Arg6
		, null::VARCHAR -- MotivoBloqueoCliente_clasificacionClienteArg7
);

*/