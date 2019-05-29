
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CodigoPostal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CodigoPostal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal(100, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.codigo ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo(100, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Codigo(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Codigo(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.codigo DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Codigo(100, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.codigo ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Codigo(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Codigo(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.codigo DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Codigo(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Numero(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Numero(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Numero(100, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Numero(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Numero(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Numero(100, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Numero(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Numero(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Numero(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Numero(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Numero(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Numero(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.nombreCalle ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle(100, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.nombreCalle DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle(100, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.nombreCalle ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.nombreCalle DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numeroCalle ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle(100, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numeroCalle DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle(100, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numeroCalle ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numeroCalle DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.ciudad ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad(100, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad(limitArg BIGINT, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.ciudad DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad(100, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.ciudad ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS massoftware.CodigoPostal  AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.ciudad DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/