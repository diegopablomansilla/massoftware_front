
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CodigoPostal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CodigoPostal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.CodigoPostal CASCADE;

CREATE TABLE massoftware.CodigoPostal
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Código
	codigo VARCHAR(12) NOT NULL, 
	
	-- Secuencia
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT CodigoPostal_numero_chk CHECK ( numero >= 1  ), 
	
	-- Calle
	nombreCalle VARCHAR(200) NOT NULL, 
	
	-- Número calle
	numeroCalle VARCHAR(20) NOT NULL, 
	
	-- Ciudad
	ciudad VARCHAR(36)  NOT NULL  REFERENCES massoftware.Ciudad (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_CodigoPostal_codigo ON massoftware.CodigoPostal (TRANSLATE(LOWER(TRIM(codigo))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCodigoPostal() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCodigoPostal() RETURNS TRIGGER AS $formatCodigoPostal$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.codigo := massoftware.white_is_null(NEW.codigo);
	 NEW.nombreCalle := massoftware.white_is_null(NEW.nombreCalle);
	 NEW.numeroCalle := massoftware.white_is_null(NEW.numeroCalle);
	 NEW.ciudad := massoftware.white_is_null(NEW.ciudad);

	RETURN NEW;
END;
$formatCodigoPostal$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCodigoPostal ON massoftware.CodigoPostal CASCADE;

CREATE TRIGGER tgFormatCodigoPostal BEFORE INSERT OR UPDATE
	ON massoftware.CodigoPostal FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatCodigoPostal();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.CodigoPostal;

-- SELECT * FROM massoftware.CodigoPostal LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.CodigoPostal;

-- SELECT * FROM massoftware.CodigoPostal WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_CodigoPostalById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_CodigoPostalById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.CodigoPostal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.CodigoPostal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CodigoPostal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_CodigoPostalById('xxx');

-- SELECT * FROM massoftware.d_CodigoPostalById((SELECT CodigoPostal.id FROM massoftware.CodigoPostal LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_CodigoPostal(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(12)
		, numeroArg INTEGER
		, nombreCalleArg VARCHAR(200)
		, numeroCalleArg VARCHAR(20)
		, ciudadArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_CodigoPostal(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(12)
		, numeroArg INTEGER
		, nombreCalleArg VARCHAR(200)
		, numeroCalleArg VARCHAR(20)
		, ciudadArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.CodigoPostal(id, codigo, numero, nombreCalle, numeroCalle, ciudad) VALUES (idArg, codigoArg, numeroArg, nombreCalleArg, numeroCalleArg, ciudadArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.CodigoPostal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_CodigoPostal(
		null::VARCHAR(36)
		, null::VARCHAR
		, null::INTEGER
		, null::VARCHAR
		, null::VARCHAR
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_CodigoPostal(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(12)
		, numeroArg INTEGER
		, nombreCalleArg VARCHAR(200)
		, numeroCalleArg VARCHAR(20)
		, ciudadArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_CodigoPostal(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(12)
		, numeroArg INTEGER
		, nombreCalleArg VARCHAR(200)
		, numeroCalleArg VARCHAR(20)
		, ciudadArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.CodigoPostal SET 
		  codigo = codigoArg
		, numero = numeroArg
		, nombreCalle = nombreCalleArg
		, numeroCalle = numeroCalleArg
		, ciudad = ciudadArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CodigoPostal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_CodigoPostal(
		null::VARCHAR(36)
		, null::VARCHAR
		, null::INTEGER
		, null::VARCHAR
		, null::VARCHAR
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_CodigoPostal_codigo(codigoArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_CodigoPostal_codigo(codigoArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.CodigoPostal
	WHERE	(codigoArg IS NULL OR (CHAR_LENGTH(TRIM(codigoArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(CodigoPostal.codigo)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(codigoArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_CodigoPostal_codigo(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_CodigoPostal_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_CodigoPostal_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.CodigoPostal
	WHERE	(numeroArg IS NULL OR CodigoPostal.numero = numeroArg);

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_CodigoPostal_numero(null::INTEGER);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CodigoPostal_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CodigoPostal_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER
	FROM	massoftware.CodigoPostal;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_CodigoPostal_numero();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostalById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostalById(idArg VARCHAR(36)) RETURNS
	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4

	FROM	massoftware.CodigoPostal

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CodigoPostalById('xxx');

-- SELECT * FROM massoftware.f_CodigoPostalById((SELECT CodigoPostal.id FROM massoftware.CodigoPostal LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostalById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostalById_1(idArg VARCHAR(36)) RETURNS
	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CodigoPostalById_1('xxx');

-- SELECT * FROM massoftware.f_CodigoPostalById_1((SELECT CodigoPostal.id FROM massoftware.CodigoPostal LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostalById_2(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostalById_2(idArg VARCHAR(36)) RETURNS
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

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CodigoPostalById_2('xxx');

-- SELECT * FROM massoftware.f_CodigoPostalById_2((SELECT CodigoPostal.id FROM massoftware.CodigoPostal LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostalById_3(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostalById_3(idArg VARCHAR(36)) RETURNS
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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CodigoPostalById_3('xxx');

-- SELECT * FROM massoftware.f_CodigoPostalById_3((SELECT CodigoPostal.id FROM massoftware.CodigoPostal LIMIT 1)::VARCHAR);

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
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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

SELECT * FROM massoftware.f_CodigoPostal(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Codigo(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Codigo(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Codigo(
		100
		, 0
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
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Numero(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Numero(
		100
		, 0
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
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle(
		100
		, 0
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
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle(
		100
		, 0
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
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad(
		100
		, 0
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
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
	) AS $$

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

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_1(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_1(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.codigo ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo_1(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Codigo_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Codigo_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.codigo DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Codigo_1(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.codigo ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo_1(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Codigo_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Codigo_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.codigo DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Codigo_1(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Numero_1(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Numero_1(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Numero_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Numero_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Numero_1(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Numero_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Numero_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Numero_1(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.nombreCalle ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle_1(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.nombreCalle DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle_1(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.nombreCalle ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle_1(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.nombreCalle DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle_1(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numeroCalle ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle_1(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numeroCalle DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle_1(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numeroCalle ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle_1(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numeroCalle DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle_1(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.ciudad ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad_1(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad_1(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.ciudad DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad_1(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.ciudad ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad_1(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad_1(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) RETURNS

	TABLE(
		 CodigoPostal_id VARCHAR(36)         	-- 0
		,CodigoPostal_codigo VARCHAR(12)     	-- 1
		,CodigoPostal_numero INTEGER         	-- 2
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 3
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 4
		,Ciudad_id VARCHAR(36)               	-- 5
		,Ciudad_numero INTEGER               	-- 6
		,Ciudad_nombre VARCHAR(50)           	-- 7
		,Ciudad_departamento VARCHAR(50)     	-- 8
		,Ciudad_numeroAFIP INTEGER           	-- 9
	) AS $$

	SELECT
		 CodigoPostal.id AS CodigoPostal_id                 	-- 0
		,CodigoPostal.codigo AS CodigoPostal_codigo         	-- 1
		,CodigoPostal.numero AS CodigoPostal_numero         	-- 2
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle	-- 3
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle	-- 4
		,Ciudad.id AS Ciudad_id                             	-- 5
		,Ciudad.numero AS Ciudad_numero                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP             	-- 9

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id	-- 5

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.ciudad DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad_1(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

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

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_3(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_3(

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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_3(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_3(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_3(
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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_3(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo_3(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo_3(
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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.codigo ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo_3(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Codigo_3(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Codigo_3(
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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.codigo DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Codigo_3(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo_3(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo_3(

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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.codigo ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Codigo_3(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Codigo_3(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Codigo_3(

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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.codigo DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Codigo_3(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Numero_3(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Numero_3(
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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Numero_3(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Numero_3(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Numero_3(
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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Numero_3(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Numero_3(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Numero_3(

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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Numero_3(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Numero_3(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Numero_3(

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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Numero_3(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle_3(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle_3(
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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.nombreCalle ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle_3(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle_3(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle_3(
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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.nombreCalle DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle_3(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle_3(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle_3(

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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.nombreCalle ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_NombreCalle_3(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle_3(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle_3(

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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.nombreCalle DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_NombreCalle_3(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle_3(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle_3(
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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numeroCalle ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle_3(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle_3(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle_3(
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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numeroCalle DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle_3(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle_3(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle_3(

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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numeroCalle ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_NumeroCalle_3(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle_3(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle_3(

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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.numeroCalle DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_NumeroCalle_3(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad_3(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad_3(
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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.ciudad ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad_3(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad_3(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad_3(
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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.ciudad DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad_3(
		100
		, 0
		, null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad_3(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad_3(

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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.ciudad ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_asc_CodigoPostal_Ciudad_3(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad_3(

		  codigoArg0 VARCHAR(12)
		, numeroFromArg1 INTEGER
		, numeroToArg2 INTEGER
		, ciudadArg3 VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad_3(

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
		,Pais_id VARCHAR(36)                  	-- 17
		,Pais_numero INTEGER                  	-- 18
		,Pais_nombre VARCHAR(50)              	-- 19
		,Pais_abreviatura VARCHAR(5)          	-- 20
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
		,Pais.id AS Pais_id                                             	-- 17
		,Pais.numero AS Pais_numero                                     	-- 18
		,Pais.nombre AS Pais_nombre                                     	-- 19
		,Pais.abreviatura AS Pais_abreviatura                           	-- 20

	FROM	massoftware.CodigoPostal
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id  	-- 5
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id	-- 10
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id           	-- 17

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(CodigoPostal.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (numeroFromArg1 IS NULL OR CodigoPostal.numero >= numeroFromArg1)
		 AND (numeroToArg2 IS NULL OR CodigoPostal.numero <= numeroToArg2)
		 AND (ciudadArg3 IS NULL OR (CHAR_LENGTH(TRIM(ciudadArg3)) > 0 AND CodigoPostal.ciudad = TRIM(ciudadArg3)::VARCHAR))

	ORDER BY CodigoPostal.ciudad DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_CodigoPostal_des_CodigoPostal_Ciudad_3(
		 null::VARCHAR -- CodigoPostal_codigoArg0
		, null::INTEGER -- CodigoPostal_numeroFromArg1
		, null::INTEGER -- CodigoPostal_numeroToArg2
		, null::VARCHAR -- CodigoPostal_ciudadArg3
);

*/