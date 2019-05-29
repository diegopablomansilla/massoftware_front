
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Ciudad                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Ciudad

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Ciudad CASCADE;

CREATE TABLE massoftware.Ciudad
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº ciudad
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Ciudad_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Departamento
	departamento VARCHAR(50), 
	
	-- Nº provincia AFIP
	numeroAFIP INTEGER CONSTRAINT Ciudad_numeroAFIP_chk CHECK ( numeroAFIP >= 1  ), 
	
	-- Provincia
	provincia VARCHAR(36)  NOT NULL  REFERENCES massoftware.Provincia (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Ciudad_nombre ON massoftware.Ciudad (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCiudad() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCiudad() RETURNS TRIGGER AS $formatCiudad$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.departamento := massoftware.white_is_null(NEW.departamento);
	 NEW.provincia := massoftware.white_is_null(NEW.provincia);

	RETURN NEW;
END;
$formatCiudad$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCiudad ON massoftware.Ciudad CASCADE;

CREATE TRIGGER tgFormatCiudad BEFORE INSERT OR UPDATE
	ON massoftware.Ciudad FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatCiudad();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Ciudad;

-- SELECT * FROM massoftware.Ciudad LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Ciudad;

-- SELECT * FROM massoftware.Ciudad WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_CiudadById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_CiudadById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.Ciudad WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ciudad.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.Ciudad WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ciudad.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Ciudad WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ciudad.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_CiudadById('xxx');

-- SELECT * FROM massoftware.d_CiudadById((SELECT Ciudad.id FROM massoftware.Ciudad LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Ciudad(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, departamentoArg VARCHAR(50)
		, numeroAFIPArg INTEGER
		, provinciaArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Ciudad(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, departamentoArg VARCHAR(50)
		, numeroAFIPArg INTEGER
		, provinciaArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Ciudad(id, numero, nombre, departamento, numeroAFIP, provincia) VALUES (idArg, numeroArg, nombreArg, departamentoArg, numeroAFIPArg, provinciaArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Ciudad WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ciudad.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Ciudad(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::VARCHAR
		, null::INTEGER
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Ciudad(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, departamentoArg VARCHAR(50)
		, numeroAFIPArg INTEGER
		, provinciaArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Ciudad(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, departamentoArg VARCHAR(50)
		, numeroAFIPArg INTEGER
		, provinciaArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Ciudad SET 
		  numero = numeroArg
		, nombre = nombreArg
		, departamento = departamentoArg
		, numeroAFIP = numeroAFIPArg
		, provincia = provinciaArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ciudad.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Ciudad WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ciudad.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Ciudad(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::VARCHAR
		, null::INTEGER
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Ciudad_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Ciudad_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.Ciudad
	WHERE	(numeroArg IS NULL OR Ciudad.numero = numeroArg);

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Ciudad_numero(null::INTEGER);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Ciudad_nombre(nombreArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Ciudad_nombre(nombreArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.Ciudad
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Ciudad.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Ciudad_nombre(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Ciudad_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Ciudad_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER
	FROM	massoftware.Ciudad;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_Ciudad_numero();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Ciudad_numeroAFIP() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Ciudad_numeroAFIP() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numeroAFIP),0) + 1)::INTEGER
	FROM	massoftware.Ciudad;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_Ciudad_numeroAFIP();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Ciudad_level_1 CASCADE;

CREATE TYPE massoftware.type_Ciudad_level_1(

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
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Ciudad_level_2 CASCADE;

CREATE TYPE massoftware.type_Ciudad_level_2(

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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CiudadById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CiudadById(idArg VARCHAR(36)) RETURNS massoftware.Ciudad AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ciudad.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CiudadById('xxx');

-- SELECT * FROM massoftware.f_CiudadById((SELECT Ciudad.id FROM massoftware.Ciudad LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CiudadById_level_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CiudadById_level_1(idArg VARCHAR(36)) RETURNS massoftware.Ciudad_level_1 AS $$

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

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ciudad.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CiudadById_level_1('xxx');

-- SELECT * FROM massoftware.f_CiudadById_level_1((SELECT Ciudad.id FROM massoftware.Ciudad LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CiudadById_level_2(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CiudadById_level_2(idArg VARCHAR(36)) RETURNS massoftware.Ciudad_level_2 AS $$

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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ciudad.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CiudadById_level_2('xxx');

-- SELECT * FROM massoftware.f_CiudadById_level_2((SELECT Ciudad.id FROM massoftware.Ciudad LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad(

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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad(
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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Numero(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Numero(
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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Numero(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Numero(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Numero(
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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Numero(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Numero(

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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Numero(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Numero(

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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Numero(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Nombre(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Nombre(
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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Nombre(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Nombre(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Nombre(
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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Nombre(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Nombre(

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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Nombre(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Nombre(

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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Nombre(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Departamento(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Departamento(
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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Departamento(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Departamento(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Departamento(
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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Departamento(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Departamento(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Departamento(

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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Departamento(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Departamento(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Departamento(

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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Departamento(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP(
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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_NumeroAFIP(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_NumeroAFIP(
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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_NumeroAFIP(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP(

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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_NumeroAFIP(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_NumeroAFIP(

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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_NumeroAFIP(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Provincia(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Provincia(
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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Provincia(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Provincia(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Provincia(
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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Provincia(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Provincia(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Provincia(

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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Provincia(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Provincia(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Provincia(

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
		 Ciudad_id VARCHAR(36)         	-- 0
		,Ciudad_numero INTEGER         	-- 1
		,Ciudad_nombre VARCHAR(50)     	-- 2
		,Ciudad_departamento VARCHAR(50)	-- 3
		,Ciudad_numeroAFIP INTEGER     	-- 4
	) AS $$

	SELECT
		 Ciudad.id AS Ciudad_id                   	-- 0
		,Ciudad.numero AS Ciudad_numero           	-- 1
		,Ciudad.nombre AS Ciudad_nombre           	-- 2
		,Ciudad.departamento AS Ciudad_departamento	-- 3
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP   	-- 4

	FROM	massoftware.Ciudad

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Provincia(
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

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_2(

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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_2(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_2(
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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Numero_2(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Numero_2(
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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Numero_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Numero_2(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Numero_2(
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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Numero_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Numero_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Numero_2(

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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Numero_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Numero_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Numero_2(

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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Numero_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Nombre_2(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Nombre_2(
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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Nombre_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Nombre_2(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Nombre_2(
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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Nombre_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Nombre_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Nombre_2(

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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Nombre_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Nombre_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Nombre_2(

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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Nombre_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Departamento_2(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Departamento_2(
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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Departamento_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Departamento_2(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Departamento_2(
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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Departamento_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Departamento_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Departamento_2(

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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Departamento_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Departamento_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Departamento_2(

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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Departamento_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP_2(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP_2(
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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_NumeroAFIP_2(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_NumeroAFIP_2(
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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_NumeroAFIP_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP_2(

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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_NumeroAFIP_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_NumeroAFIP_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_NumeroAFIP_2(

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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_NumeroAFIP_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Provincia_2(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Provincia_2(
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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Provincia_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Provincia_2(
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

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Provincia_2(
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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Provincia_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_asc_Ciudad_Provincia_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_asc_Ciudad_Provincia_2(

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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_asc_Ciudad_Provincia_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Ciudad_des_Ciudad_Provincia_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, provinciaArg7 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_des_Ciudad_Provincia_2(

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
		,Pais_id VARCHAR(36)                  	-- 12
		,Pais_numero INTEGER                  	-- 13
		,Pais_nombre VARCHAR(50)              	-- 14
		,Pais_abreviatura VARCHAR(5)          	-- 15
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
		,Pais.id AS Pais_id                                             	-- 12
		,Pais.numero AS Pais_numero                                     	-- 13
		,Pais.nombre AS Pais_nombre                                     	-- 14
		,Pais.abreviatura AS Pais_abreviatura                           	-- 15

	FROM	massoftware.Ciudad
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 5
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 12

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

SELECT * FROM massoftware.f_Ciudad_des_Ciudad_Provincia_2(
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