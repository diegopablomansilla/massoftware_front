
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MonedaAFIP                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MonedaAFIP

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS massoftware.MonedaAFIP  AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP(
		 null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)) RETURNS massoftware.MonedaAFIP  AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP(100, 0
		, null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP_asc_MonedaAFIP_Codigo(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP_asc_MonedaAFIP_Codigo(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)) RETURNS massoftware.MonedaAFIP  AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.codigo ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP_asc_MonedaAFIP_Codigo(100, 0
		, null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP_des_MonedaAFIP_Codigo(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP_des_MonedaAFIP_Codigo(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)) RETURNS massoftware.MonedaAFIP  AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.codigo DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP_des_MonedaAFIP_Codigo(100, 0
		, null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP_asc_MonedaAFIP_Codigo(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP_asc_MonedaAFIP_Codigo(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS massoftware.MonedaAFIP  AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.codigo ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP_asc_MonedaAFIP_Codigo(
		 null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP_des_MonedaAFIP_Codigo(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP_des_MonedaAFIP_Codigo(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS massoftware.MonedaAFIP  AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.codigo DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP_des_MonedaAFIP_Codigo(
		 null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP_asc_MonedaAFIP_Nombre(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP_asc_MonedaAFIP_Nombre(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)) RETURNS massoftware.MonedaAFIP  AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP_asc_MonedaAFIP_Nombre(100, 0
		, null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP_des_MonedaAFIP_Nombre(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP_des_MonedaAFIP_Nombre(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)) RETURNS massoftware.MonedaAFIP  AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP_des_MonedaAFIP_Nombre(100, 0
		, null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP_asc_MonedaAFIP_Nombre(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP_asc_MonedaAFIP_Nombre(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS massoftware.MonedaAFIP  AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP_asc_MonedaAFIP_Nombre(
		 null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP_des_MonedaAFIP_Nombre(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP_des_MonedaAFIP_Nombre(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS massoftware.MonedaAFIP  AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(MonedaAFIP.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(MonedaAFIP.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY MonedaAFIP.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_MonedaAFIP_des_MonedaAFIP_Nombre(
		 null::VARCHAR -- MonedaAFIP_codigoArg0
		, null::VARCHAR -- MonedaAFIP_nombreWord0Arg1
		, null::VARCHAR -- MonedaAFIP_nombreWord1Arg2
		, null::VARCHAR -- MonedaAFIP_nombreWord2Arg3
		, null::VARCHAR -- MonedaAFIP_nombreWord3Arg4
		, null::VARCHAR -- MonedaAFIP_nombreWord4Arg5
);

*/