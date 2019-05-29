
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CodigoPostal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CodigoPostal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_2(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_2(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.codigo ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo_2(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Codigo_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Codigo_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.codigo DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Codigo_2(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.codigo ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo_2(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Codigo_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Codigo_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.codigo DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Codigo_2(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Numero_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Numero_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Numero_2(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Numero_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Numero_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Numero_2(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Numero_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Numero_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Numero_2(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Numero_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Numero_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Numero_2(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.nombreCalle ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle_2(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.nombreCalle DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle_2(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.nombreCalle ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle_2(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.nombreCalle DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle_2(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numeroCalle ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle_2(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numeroCalle DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle_2(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numeroCalle ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle_2(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numeroCalle DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle_2(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.ciudad ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad_2(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad_2(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.ciudad DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad_2(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.ciudad ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad_2(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad_2(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)          	-- 0
		,CodigoPostal_codigo VARCHAR(12)      	-- 1
		,CodigoPostal_numero INTEGER          	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 4
		,Ciudad_id VARCHAR(36)                	-- 5
		,Ciudad_numero INTEGER                	-- 6
		,Ciudad_nombre VARCHAR(50)            	-- 7
		,Ciudad_departamento VARCHAR(50)      	-- 8
		,Ciudad_numeroAFIP INTEGER            	-- 9
		,Provincia_id VARCHAR(36)             	-- 10
		,Provincia_numero INTEGER             	-- 11
		,Provincia_nombre VARCHAR(50)         	-- 12
		,Provincia_abreviatura VARCHAR(5)     	-- 13
		,Provincia_numeroAFIP INTEGER         	-- 14
		,Provincia_numeroIngresosBrutos INTEGER	-- 15
		,Provincia_numeroRENATEA INTEGER      	-- 16
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                             	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 4
		,Ciudad.id AS Ciudad_id                                         	-- 5
		,Ciudad.numero AS Ciudad_numero                                 	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 7
		,Ciudad.departamento AS Ciudad_departamento                     	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 9
		,Provincia.id AS Provincia_id                                   	-- 10
		,Provincia.numero AS Provincia_numero                           	-- 11
		,Provincia.nombre AS Provincia_nombre                           	-- 12
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 13
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 14
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 15
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 16

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.ciudad DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad_2(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/