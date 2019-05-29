
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Pais                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Pais

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Pais CASCADE;

CREATE TABLE massoftware.Pais
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº país
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Pais_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Abreviatura
	abreviatura VARCHAR(5) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Pais_nombre ON massoftware.Pais (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_Pais_abreviatura ON massoftware.Pais (TRANSLATE(LOWER(TRIM(abreviatura))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatPais() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatPais() RETURNS TRIGGER AS $formatPais$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.abreviatura := massoftware.white_is_null(NEW.abreviatura);

	RETURN NEW;
END;
$formatPais$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatPais ON massoftware.Pais CASCADE;

CREATE TRIGGER tgFormatPais BEFORE INSERT OR UPDATE
	ON massoftware.Pais FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatPais();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Pais;

-- SELECT * FROM massoftware.Pais LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Pais;

-- SELECT * FROM massoftware.Pais WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_PaisById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_PaisById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.Pais WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Pais.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.Pais WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Pais.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Pais WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Pais.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_PaisById('xxx');

-- SELECT * FROM massoftware.d_PaisById((SELECT Pais.id FROM massoftware.Pais LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Pais(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Pais(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Pais(id, numero, nombre, abreviatura) VALUES (idArg, numeroArg, nombreArg, abreviaturaArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Pais WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Pais.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Pais(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::VARCHAR
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Pais(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Pais(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Pais SET 
		  numero = numeroArg
		, nombre = nombreArg
		, abreviatura = abreviaturaArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Pais.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Pais WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Pais.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Pais(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::VARCHAR
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Pais_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Pais_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.Pais
	WHERE	(numeroArg IS NULL OR Pais.numero = numeroArg);

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Pais_numero(null::INTEGER);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Pais_nombre(nombreArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Pais_nombre(nombreArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.Pais
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Pais.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Pais_nombre(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Pais_abreviatura(abreviaturaArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Pais_abreviatura(abreviaturaArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.Pais
	WHERE	(abreviaturaArg IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Pais.abreviatura)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(abreviaturaArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Pais_abreviatura(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Pais_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Pais_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER
	FROM	massoftware.Pais;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_Pais_numero();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_PaisById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_PaisById(idArg VARCHAR(36)) RETURNS massoftware.Pais AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Pais.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_PaisById('xxx');

-- SELECT * FROM massoftware.f_PaisById((SELECT Pais.id FROM massoftware.Pais LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais(

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
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Pais(

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
) RETURNS

	TABLE(
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais(
		 null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais(
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
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Pais(
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
) RETURNS

	TABLE(
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais(
		100
		, 0
		, null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_asc_Pais_Numero(
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
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Pais_asc_Pais_Numero(
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
) RETURNS

	TABLE(
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_asc_Pais_Numero(
		100
		, 0
		, null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_des_Pais_Numero(
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
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Pais_des_Pais_Numero(
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
) RETURNS

	TABLE(
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_des_Pais_Numero(
		100
		, 0
		, null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_asc_Pais_Numero(

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
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Pais_asc_Pais_Numero(

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
) RETURNS

	TABLE(
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_asc_Pais_Numero(
		 null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_des_Pais_Numero(

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
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Pais_des_Pais_Numero(

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
) RETURNS

	TABLE(
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_des_Pais_Numero(
		 null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_asc_Pais_Nombre(
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
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Pais_asc_Pais_Nombre(
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
) RETURNS

	TABLE(
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_asc_Pais_Nombre(
		100
		, 0
		, null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_des_Pais_Nombre(
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
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Pais_des_Pais_Nombre(
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
) RETURNS

	TABLE(
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_des_Pais_Nombre(
		100
		, 0
		, null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_asc_Pais_Nombre(

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
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Pais_asc_Pais_Nombre(

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
) RETURNS

	TABLE(
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_asc_Pais_Nombre(
		 null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_des_Pais_Nombre(

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
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Pais_des_Pais_Nombre(

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
) RETURNS

	TABLE(
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_des_Pais_Nombre(
		 null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_asc_Pais_Abreviatura(
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
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Pais_asc_Pais_Abreviatura(
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
) RETURNS

	TABLE(
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.abreviatura ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_asc_Pais_Abreviatura(
		100
		, 0
		, null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_des_Pais_Abreviatura(
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
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Pais_des_Pais_Abreviatura(
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
) RETURNS

	TABLE(
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.abreviatura DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_des_Pais_Abreviatura(
		100
		, 0
		, null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_asc_Pais_Abreviatura(

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
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Pais_asc_Pais_Abreviatura(

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
) RETURNS

	TABLE(
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.abreviatura ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_asc_Pais_Abreviatura(
		 null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Pais_des_Pais_Abreviatura(

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
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Pais_des_Pais_Abreviatura(

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
) RETURNS

	TABLE(
		 Pais_id VARCHAR(36)       	-- 0
		,Pais_numero INTEGER       	-- 1
		,Pais_nombre VARCHAR(50)   	-- 2
		,Pais_abreviatura VARCHAR(5)	-- 3
	) AS $$

	SELECT
		 Pais.id AS Pais_id                 	-- 0
		,Pais.numero AS Pais_numero         	-- 1
		,Pais.nombre AS Pais_nombre         	-- 2
		,Pais.abreviatura AS Pais_abreviatura	-- 3

	FROM	massoftware.Pais

	WHERE	(numeroFromArg0 IS NULL OR Pais.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Pais.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))
		 AND (abreviaturaWord0Arg7 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord0Arg7)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord0Arg7)) || '%')::VARCHAR))
		 AND (abreviaturaWord1Arg8 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord1Arg8)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord1Arg8)) || '%')::VARCHAR))
		 AND (abreviaturaWord2Arg9 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord2Arg9)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord2Arg9)) || '%')::VARCHAR))
		 AND (abreviaturaWord3Arg10 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord3Arg10)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord3Arg10)) || '%')::VARCHAR))
		 AND (abreviaturaWord4Arg11 IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaWord4Arg11)) > 0 AND TRIM(massoftware.TRANSLATE(Pais.abreviatura))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(abreviaturaWord4Arg11)) || '%')::VARCHAR))

	ORDER BY Pais.abreviatura DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Pais_des_Pais_Abreviatura(
		 null::INTEGER -- Pais_numeroFromArg0
		, null::INTEGER -- Pais_numeroToArg1
		, null::VARCHAR -- Pais_nombreWord0Arg2
		, null::VARCHAR -- Pais_nombreWord1Arg3
		, null::VARCHAR -- Pais_nombreWord2Arg4
		, null::VARCHAR -- Pais_nombreWord3Arg5
		, null::VARCHAR -- Pais_nombreWord4Arg6
		, null::VARCHAR -- Pais_abreviaturaWord0Arg7
		, null::VARCHAR -- Pais_abreviaturaWord1Arg8
		, null::VARCHAR -- Pais_abreviaturaWord2Arg9
		, null::VARCHAR -- Pais_abreviaturaWord3Arg10
		, null::VARCHAR -- Pais_abreviaturaWord4Arg11
);

*/