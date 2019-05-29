
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Provincia                                                                                              //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Provincia

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Provincia CASCADE;

CREATE TABLE massoftware.Provincia
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº provincia
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Provincia_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Abreviatura
	abreviatura VARCHAR(5) NOT NULL, 
	
	-- Nº provincia AFIP
	numeroAFIP INTEGER CONSTRAINT Provincia_numeroAFIP_chk CHECK ( numeroAFIP >= 1  ), 
	
	-- Nº provincia ingresos brutos
	numeroIngresosBrutos INTEGER CONSTRAINT Provincia_numeroIngresosBrutos_chk CHECK ( numeroIngresosBrutos >= 1  ), 
	
	-- Nº provincia RENATEA
	numeroRENATEA INTEGER CONSTRAINT Provincia_numeroRENATEA_chk CHECK ( numeroRENATEA >= 1  ), 
	
	-- País
	pais VARCHAR(36)  NOT NULL  REFERENCES massoftware.Pais (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Provincia_nombre ON massoftware.Provincia (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_Provincia_abreviatura ON massoftware.Provincia (TRANSLATE(LOWER(TRIM(abreviatura))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatProvincia() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatProvincia() RETURNS TRIGGER AS $formatProvincia$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.abreviatura := massoftware.white_is_null(NEW.abreviatura);
	 NEW.pais := massoftware.white_is_null(NEW.pais);

	RETURN NEW;
END;
$formatProvincia$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatProvincia ON massoftware.Provincia CASCADE;

CREATE TRIGGER tgFormatProvincia BEFORE INSERT OR UPDATE
	ON massoftware.Provincia FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatProvincia();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Provincia;

-- SELECT * FROM massoftware.Provincia LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Provincia;

-- SELECT * FROM massoftware.Provincia WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_ProvinciaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_ProvinciaById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.Provincia WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.Provincia WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Provincia WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_ProvinciaById('xxx');

-- SELECT * FROM massoftware.d_ProvinciaById((SELECT Provincia.id FROM massoftware.Provincia LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Provincia(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, numeroAFIPArg INTEGER
		, numeroIngresosBrutosArg INTEGER
		, numeroRENATEAArg INTEGER
		, paisArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Provincia(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, numeroAFIPArg INTEGER
		, numeroIngresosBrutosArg INTEGER
		, numeroRENATEAArg INTEGER
		, paisArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Provincia(id, numero, nombre, abreviatura, numeroAFIP, numeroIngresosBrutos, numeroRENATEA, pais) VALUES (idArg, numeroArg, nombreArg, abreviaturaArg, numeroAFIPArg, numeroIngresosBrutosArg, numeroRENATEAArg, paisArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Provincia WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Provincia(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::VARCHAR
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Provincia(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, numeroAFIPArg INTEGER
		, numeroIngresosBrutosArg INTEGER
		, numeroRENATEAArg INTEGER
		, paisArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Provincia(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, numeroAFIPArg INTEGER
		, numeroIngresosBrutosArg INTEGER
		, numeroRENATEAArg INTEGER
		, paisArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Provincia SET 
		  numero = numeroArg
		, nombre = nombreArg
		, abreviatura = abreviaturaArg
		, numeroAFIP = numeroAFIPArg
		, numeroIngresosBrutos = numeroIngresosBrutosArg
		, numeroRENATEA = numeroRENATEAArg
		, pais = paisArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Provincia WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Provincia(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::VARCHAR
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Provincia_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Provincia_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.Provincia
	WHERE	(numeroArg IS NULL OR Provincia.numero = numeroArg);

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Provincia_numero(null::INTEGER);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Provincia_nombre(nombreArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Provincia_nombre(nombreArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.Provincia
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Provincia.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Provincia_nombre(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Provincia_abreviatura(abreviaturaArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Provincia_abreviatura(abreviaturaArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.Provincia
	WHERE	(abreviaturaArg IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Provincia.abreviatura)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(abreviaturaArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Provincia_abreviatura(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Provincia_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Provincia_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER
	FROM	massoftware.Provincia;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_Provincia_numero();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Provincia_numeroAFIP() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Provincia_numeroAFIP() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numeroAFIP),0) + 1)::INTEGER
	FROM	massoftware.Provincia;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_Provincia_numeroAFIP();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Provincia_numeroIngresosBrutos() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Provincia_numeroIngresosBrutos() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numeroIngresosBrutos),0) + 1)::INTEGER
	FROM	massoftware.Provincia;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_Provincia_numeroIngresosBrutos();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Provincia_numeroRENATEA() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Provincia_numeroRENATEA() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numeroRENATEA),0) + 1)::INTEGER
	FROM	massoftware.Provincia;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_Provincia_numeroRENATEA();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Provincia_level_1 CASCADE;

CREATE TYPE massoftware.type_Provincia_level_1(

		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ProvinciaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ProvinciaById(idArg VARCHAR(36)) RETURNS massoftware.Provincia AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_ProvinciaById('xxx');

-- SELECT * FROM massoftware.f_ProvinciaById((SELECT Provincia.id FROM massoftware.Provincia LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ProvinciaById_level_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ProvinciaById_level_1(idArg VARCHAR(36)) RETURNS massoftware.Provincia_level_1 AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_ProvinciaById_level_1('xxx');

-- SELECT * FROM massoftware.f_ProvinciaById_level_1((SELECT Provincia.id FROM massoftware.Provincia LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Numero(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Numero(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Numero(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Numero(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Nombre(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Nombre(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Nombre(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Nombre(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Abreviatura(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Abreviatura(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.abreviatura ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Abreviatura(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Abreviatura(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Abreviatura(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.abreviatura DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Abreviatura(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Abreviatura(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Abreviatura(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.abreviatura ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Abreviatura(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Abreviatura(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Abreviatura(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.abreviatura DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Abreviatura(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroAFIP(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroAFIP(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroAFIP ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroAFIP(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroAFIP(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroAFIP(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroAFIP DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroAFIP(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroAFIP(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroAFIP(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroAFIP ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroAFIP(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroAFIP(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroAFIP(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroAFIP DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroAFIP(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroIngresosBrutos ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroIngresosBrutos DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroIngresosBrutos ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroIngresosBrutos DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroRENATEA(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroRENATEA(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroRENATEA ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroRENATEA(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroRENATEA(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroRENATEA(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroRENATEA DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroRENATEA(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroRENATEA(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroRENATEA(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroRENATEA ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroRENATEA(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroRENATEA(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroRENATEA(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroRENATEA DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroRENATEA(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Pais(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Pais(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.pais ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Pais(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Pais(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Pais(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.pais DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Pais(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Pais(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Pais(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.pais ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Pais(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Pais(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Pais(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6

	FROM	massoftware.Provincia

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.pais DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Pais(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Numero_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Numero_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Numero_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Numero_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Nombre_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Nombre_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Nombre_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Nombre_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Nombre_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Nombre_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Nombre_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Nombre_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Abreviatura_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Abreviatura_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.abreviatura ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Abreviatura_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Abreviatura_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Abreviatura_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.abreviatura DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Abreviatura_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Abreviatura_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Abreviatura_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.abreviatura ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Abreviatura_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Abreviatura_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Abreviatura_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.abreviatura DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Abreviatura_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroAFIP_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroAFIP_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroAFIP ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroAFIP_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroAFIP_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroAFIP_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroAFIP DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroAFIP_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroAFIP_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroAFIP_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroAFIP ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroAFIP_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroAFIP_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroAFIP_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroAFIP DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroAFIP_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroIngresosBrutos ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroIngresosBrutos DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroIngresosBrutos ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroIngresosBrutos_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroIngresosBrutos DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroIngresosBrutos_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroRENATEA_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroRENATEA_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroRENATEA ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroRENATEA_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroRENATEA_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroRENATEA_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroRENATEA DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroRENATEA_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_NumeroRENATEA_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_NumeroRENATEA_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroRENATEA ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_NumeroRENATEA_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_NumeroRENATEA_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_NumeroRENATEA_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.numeroRENATEA DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_NumeroRENATEA_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Pais_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Pais_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.pais ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Pais_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Pais_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Pais_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.pais DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Pais_1(
		100
		, 0
		, null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_asc_Provincia_Pais_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_asc_Provincia_Pais_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.pais ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_asc_Provincia_Pais_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Provincia_des_Provincia_Pais_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_des_Provincia_Pais_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
		, abreviaturaWord0Arg7 VARCHAR(15)
		, abreviaturaWord1Arg8 VARCHAR(15)
		, abreviaturaWord2Arg9 VARCHAR(15)
		, abreviaturaWord3Arg10 VARCHAR(15)
		, abreviaturaWord4Arg11 VARCHAR(15)
		, paisArg12 VARCHAR(36)
) RETURNS

	TABLE(
		 Provincia_id VARCHAR(36)             	-- 0
		,Provincia_numero INTEGER             	-- 1
		,Provincia_nombre VARCHAR(50)         	-- 2
		,Provincia_abreviatura VARCHAR(5)     	-- 3
		,Provincia_numeroAFIP INTEGER         	-- 4
		,Provincia_numeroIngresosBrutos INTEGER	-- 5
		,Provincia_numeroRENATEA INTEGER      	-- 6
		,Pais_id VARCHAR(36)                  	-- 7
		,Pais_numero INTEGER                  	-- 8
		,Pais_nombre VARCHAR(50)              	-- 9
		,Pais_abreviatura VARCHAR(5)          	-- 10
	) AS $$

	SELECT
		 Provincia.id AS Provincia_id                                   	-- 0
		,Provincia.numero AS Provincia_numero                           	-- 1
		,Provincia.nombre AS Provincia_nombre                           	-- 2
		,Provincia.abreviatura AS Provincia_abreviatura                 	-- 3
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                   	-- 4
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos	-- 5
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA             	-- 6
		,Pais.id AS Pais_id                                             	-- 7
		,Pais.numero AS Pais_numero                                     	-- 8
		,Pais.nombre AS Pais_nombre                                     	-- 9
		,Pais.abreviatura AS Pais_abreviatura                           	-- 10

	FROM	massoftware.Provincia
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id	-- 7

	WHERE	(numeroFromArg0 IS NULL OR Provincia.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Provincia.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Provincia.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))
		 AND (paisArg12 IS NULL OR (CHAR_LENGTH(TRIM(paisArg12)) > 0 AND Provincia.pais = TRIM(paisArg12)::VARCHAR))

	ORDER BY Provincia.pais DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Provincia_des_Provincia_Pais_1(
		 null::INTEGER -- Provincia_numeroFromArg0
		, null::INTEGER -- Provincia_numeroToArg1
		, null::VARCHAR -- Provincia_nombreWord0Arg2
		, null::VARCHAR -- Provincia_nombreWord1Arg3
		, null::VARCHAR -- Provincia_nombreWord2Arg4
		, null::VARCHAR -- Provincia_nombreWord3Arg5
		, null::VARCHAR -- Provincia_nombreWord4Arg6
		, null::VARCHAR -- Provincia_abreviaturaWord0Arg7
		, null::VARCHAR -- Provincia_abreviaturaWord1Arg8
		, null::VARCHAR -- Provincia_abreviaturaWord2Arg9
		, null::VARCHAR -- Provincia_abreviaturaWord3Arg10
		, null::VARCHAR -- Provincia_abreviaturaWord4Arg11
		, null::VARCHAR -- Provincia_paisArg12
);

*/