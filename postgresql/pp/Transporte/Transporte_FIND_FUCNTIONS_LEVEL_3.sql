
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Transporte                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Transporte

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Numero_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Numero_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Numero_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Numero_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Numero_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Numero_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Numero_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Numero_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Numero_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Numero_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Numero_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Numero_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Nombre_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Nombre_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Nombre_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Nombre_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Nombre_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Nombre_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Nombre_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Nombre_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Nombre_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Nombre_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Nombre_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Nombre_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Cuit_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Cuit_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Cuit_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Cuit_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Cuit_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Cuit_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Cuit_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Cuit_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Cuit_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Cuit_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Cuit_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Cuit_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_IngresosBrutos_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_IngresosBrutos_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_IngresosBrutos_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_IngresosBrutos_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_IngresosBrutos_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_IngresosBrutos_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_IngresosBrutos_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_IngresosBrutos_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_IngresosBrutos_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_IngresosBrutos_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_IngresosBrutos_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_IngresosBrutos_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Telefono_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Telefono_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Telefono_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Telefono_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Telefono_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Telefono_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Telefono_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Telefono_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Telefono_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Telefono_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Telefono_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Telefono_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Fax_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Fax_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Fax_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Fax_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Fax_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Fax_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Fax_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Fax_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Fax_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Fax_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Fax_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Fax_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_CodigoPostal_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_CodigoPostal_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_CodigoPostal_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_CodigoPostal_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_CodigoPostal_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_CodigoPostal_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_CodigoPostal_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_CodigoPostal_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_CodigoPostal_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_CodigoPostal_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_CodigoPostal_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_CodigoPostal_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Domicilio_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Domicilio_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Domicilio_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Domicilio_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Domicilio_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Domicilio_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Domicilio_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Domicilio_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Domicilio_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Domicilio_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Domicilio_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Domicilio_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Comentario_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Comentario_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Comentario_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Comentario_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Comentario_3(
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
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Comentario_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Comentario_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Comentario_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Comentario_3(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Comentario_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Comentario_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Transporte_id VARCHAR(36)            	-- 0
		,Transporte_numero INTEGER            	-- 1
		,Transporte_nombre VARCHAR(50)        	-- 2
		,Transporte_cuit BIGINT               	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)      	-- 5
		,Transporte_fax VARCHAR(50)           	-- 6
		,CodigoPostal_id VARCHAR(36)          	-- 7
		,CodigoPostal_codigo VARCHAR(12)      	-- 8
		,CodigoPostal_numero INTEGER          	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20) 	-- 11
		,Ciudad_id VARCHAR(36)                	-- 12
		,Ciudad_numero INTEGER                	-- 13
		,Ciudad_nombre VARCHAR(50)            	-- 14
		,Ciudad_departamento VARCHAR(50)      	-- 15
		,Ciudad_numeroAFIP INTEGER            	-- 16
		,Provincia_id VARCHAR(36)             	-- 17
		,Provincia_numero INTEGER             	-- 18
		,Provincia_nombre VARCHAR(50)         	-- 19
		,Provincia_abreviatura VARCHAR(5)     	-- 20
		,Provincia_numeroAFIP INTEGER         	-- 21
		,Provincia_numeroIngresosBrutos INTEGER	-- 22
		,Provincia_numeroRENATEA INTEGER      	-- 23
		,Transporte_domicilio VARCHAR(150)    	-- 24
		,Transporte_comentario VARCHAR(300)   	-- 25
	) AS $$

	SELECT
		 Transporte.id AS Transporte_id                                 	-- 0
		,Transporte.numero AS Transporte_numero                         	-- 1
		,Transporte.nombre AS Transporte_nombre                         	-- 2
		,Transporte.cuit AS Transporte_cuit                             	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos         	-- 4
		,Transporte.telefono AS Transporte_telefono                     	-- 5
		,Transporte.fax AS Transporte_fax                               	-- 6
		,CodigoPostal.id AS CodigoPostal_id                             	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo                     	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero                     	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle           	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle           	-- 11
		,Ciudad.id AS Ciudad_id                                         	-- 12
		,Ciudad.numero AS Ciudad_numero                                 	-- 13
		,Ciudad.nombre AS Ciudad_nombre                                 	-- 14
		,Ciudad.departamento AS Ciudad_departamento                     	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                         	-- 16
		,Provincia.id AS Provincia_id                                   	-- 17
		,Provincia.numero AS Provincia_numero                           	-- 18
		,Provincia.nombre AS Provincia_nombre                           	-- 19
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 20
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 21
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 22
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 23
		,Transporte.domicilio AS Transporte_domicilio                   	-- 24
		,Transporte.comentario AS Transporte_comentario                 	-- 25

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 17

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Comentario_3(
		 null::INTEGER -- Transporte_numeroFromArg0
		, null::INTEGER -- Transporte_numeroToArg1
		, null::VARCHAR -- Transporte_nombreWord0Arg2
		, null::VARCHAR -- Transporte_nombreWord1Arg3
		, null::VARCHAR -- Transporte_nombreWord2Arg4
		, null::VARCHAR -- Transporte_nombreWord3Arg5
		, null::VARCHAR -- Transporte_nombreWord4Arg6
);

*/