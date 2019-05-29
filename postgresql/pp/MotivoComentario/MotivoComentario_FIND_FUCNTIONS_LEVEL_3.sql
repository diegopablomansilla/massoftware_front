
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoComentario                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoComentario

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.MotivoComentario  AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario(
		 null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.MotivoComentario  AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario(100, 0
		, null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario_asc_MotivoComentario_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario_asc_MotivoComentario_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.MotivoComentario  AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario_asc_MotivoComentario_Numero(100, 0
		, null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario_des_MotivoComentario_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario_des_MotivoComentario_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.MotivoComentario  AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario_des_MotivoComentario_Numero(100, 0
		, null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario_asc_MotivoComentario_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario_asc_MotivoComentario_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.MotivoComentario  AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario_asc_MotivoComentario_Numero(
		 null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario_des_MotivoComentario_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario_des_MotivoComentario_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.MotivoComentario  AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario_des_MotivoComentario_Numero(
		 null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario_asc_MotivoComentario_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario_asc_MotivoComentario_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.MotivoComentario  AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario_asc_MotivoComentario_Nombre(100, 0
		, null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario_des_MotivoComentario_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario_des_MotivoComentario_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.MotivoComentario  AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario_des_MotivoComentario_Nombre(100, 0
		, null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario_asc_MotivoComentario_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario_asc_MotivoComentario_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.MotivoComentario  AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario_asc_MotivoComentario_Nombre(
		 null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario_des_MotivoComentario_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario_des_MotivoComentario_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.MotivoComentario  AS $$

	SELECT
		 MotivoComentario.id AS MotivoComentario_id       	-- 0
		,MotivoComentario.numero AS MotivoComentario_numero	-- 1
		,MotivoComentario.nombre AS MotivoComentario_nombre	-- 2

	FROM	massoftware.MotivoComentario

	WHERE	(numeroFromArg0 IS NULL OR MotivoComentario.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR MotivoComentario.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(MotivoComentario.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY MotivoComentario.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MotivoComentario_des_MotivoComentario_Nombre(
		 null::INTEGER -- MotivoComentario_numeroFromArg0
		, null::INTEGER -- MotivoComentario_numeroToArg1
		, null::VARCHAR -- MotivoComentario_nombreWord0Arg2
		, null::VARCHAR -- MotivoComentario_nombreWord1Arg3
		, null::VARCHAR -- MotivoComentario_nombreWord2Arg4
		, null::VARCHAR -- MotivoComentario_nombreWord3Arg5
		, null::VARCHAR -- MotivoComentario_nombreWord4Arg6
);

*/