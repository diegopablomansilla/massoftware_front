
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Transporte                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Transporte

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Transporte CASCADE;

CREATE TABLE massoftware.Transporte
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº transporte
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Transporte_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- CUIT
	cuit BIGINT NOT NULL  UNIQUE  CONSTRAINT Transporte_cuit_chk CHECK ( cuit >= 1 AND cuit <= 99999999999 AND char_length(cuit::VARCHAR) >= 11 AND char_length(cuit::VARCHAR) <= 11  ), 
	
	-- Ingresos brutos
	ingresosBrutos VARCHAR(13), 
	
	-- Teléfono
	telefono VARCHAR(50), 
	
	-- Fax
	fax VARCHAR(50), 
	
	-- Código postal
	codigoPostal VARCHAR(36)  NOT NULL  REFERENCES massoftware.CodigoPostal (id), 
	
	-- Domicilio
	domicilio VARCHAR(150), 
	
	-- Comentario
	comentario VARCHAR(300)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Transporte_nombre ON massoftware.Transporte (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatTransporte() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatTransporte() RETURNS TRIGGER AS $formatTransporte$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.ingresosBrutos := massoftware.white_is_null(NEW.ingresosBrutos);
	 NEW.telefono := massoftware.white_is_null(NEW.telefono);
	 NEW.fax := massoftware.white_is_null(NEW.fax);
	 NEW.codigoPostal := massoftware.white_is_null(NEW.codigoPostal);
	 NEW.domicilio := massoftware.white_is_null(NEW.domicilio);
	 NEW.comentario := massoftware.white_is_null(NEW.comentario);

	RETURN NEW;
END;
$formatTransporte$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTransporte ON massoftware.Transporte CASCADE;

CREATE TRIGGER tgFormatTransporte BEFORE INSERT OR UPDATE
	ON massoftware.Transporte FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatTransporte();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Transporte;

-- SELECT * FROM massoftware.Transporte LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Transporte;

-- SELECT * FROM massoftware.Transporte WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_TransporteById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_TransporteById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.Transporte WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.Transporte WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Transporte WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_TransporteById('xxx');

-- SELECT * FROM massoftware.d_TransporteById((SELECT Transporte.id FROM massoftware.Transporte LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Transporte(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuitArg BIGINT
		, ingresosBrutosArg VARCHAR(13)
		, telefonoArg VARCHAR(50)
		, faxArg VARCHAR(50)
		, codigoPostalArg VARCHAR(36)
		, domicilioArg VARCHAR(150)
		, comentarioArg VARCHAR(300)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Transporte(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuitArg BIGINT
		, ingresosBrutosArg VARCHAR(13)
		, telefonoArg VARCHAR(50)
		, faxArg VARCHAR(50)
		, codigoPostalArg VARCHAR(36)
		, domicilioArg VARCHAR(150)
		, comentarioArg VARCHAR(300)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Transporte(id, numero, nombre, cuit, ingresosBrutos, telefono, fax, codigoPostal, domicilio, comentario) VALUES (idArg, numeroArg, nombreArg, cuitArg, ingresosBrutosArg, telefonoArg, faxArg, codigoPostalArg, domicilioArg, comentarioArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Transporte WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Transporte(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::BIGINT
		, null::VARCHAR
		, null::VARCHAR
		, null::VARCHAR
		, null::VARCHAR(36)
		, null::VARCHAR
		, null::VARCHAR
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Transporte(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuitArg BIGINT
		, ingresosBrutosArg VARCHAR(13)
		, telefonoArg VARCHAR(50)
		, faxArg VARCHAR(50)
		, codigoPostalArg VARCHAR(36)
		, domicilioArg VARCHAR(150)
		, comentarioArg VARCHAR(300)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Transporte(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuitArg BIGINT
		, ingresosBrutosArg VARCHAR(13)
		, telefonoArg VARCHAR(50)
		, faxArg VARCHAR(50)
		, codigoPostalArg VARCHAR(36)
		, domicilioArg VARCHAR(150)
		, comentarioArg VARCHAR(300)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Transporte SET 
		  numero = numeroArg
		, nombre = nombreArg
		, cuit = cuitArg
		, ingresosBrutos = ingresosBrutosArg
		, telefono = telefonoArg
		, fax = faxArg
		, codigoPostal = codigoPostalArg
		, domicilio = domicilioArg
		, comentario = comentarioArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Transporte WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Transporte(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::BIGINT
		, null::VARCHAR
		, null::VARCHAR
		, null::VARCHAR
		, null::VARCHAR(36)
		, null::VARCHAR
		, null::VARCHAR
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Transporte_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Transporte_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Transporte
	WHERE	(numeroArg IS NULL OR Transporte.numero = numeroArg);

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Transporte_numero(null::INTEGER);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Transporte_nombre(nombreArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Transporte_nombre(nombreArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Transporte
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Transporte.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Transporte_nombre(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Transporte_cuit(cuitArg BIGINT) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Transporte_cuit(cuitArg BIGINT) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Transporte
	WHERE	(cuitArg IS NULL OR Transporte.cuit = cuitArg);

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Transporte_cuit(null::BIGINT);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Transporte_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Transporte_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Transporte;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_Transporte_numero();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Transporte_cuit() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Transporte_cuit() RETURNS BIGINT AS $$

	SELECT (COALESCE(MAX(cuit),0) + 1)::BIGINT FROM massoftware.Transporte;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_Transporte_cuit();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Transporte_level_1 CASCADE;

CREATE TYPE massoftware.type_Transporte_level_1(

		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Transporte_domicilio VARCHAR(150)   	-- 12
		,Transporte_comentario VARCHAR(300)  	-- 13
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Transporte_level_2 CASCADE;

CREATE TYPE massoftware.type_Transporte_level_2(

		 Transporte_id VARCHAR(36)           	-- 0
		,Transporte_numero INTEGER           	-- 1
		,Transporte_nombre VARCHAR(50)       	-- 2
		,Transporte_cuit BIGINT              	-- 3
		,Transporte_ingresosBrutos VARCHAR(13)	-- 4
		,Transporte_telefono VARCHAR(50)     	-- 5
		,Transporte_fax VARCHAR(50)          	-- 6
		,CodigoPostal_id VARCHAR(36)         	-- 7
		,CodigoPostal_codigo VARCHAR(12)     	-- 8
		,CodigoPostal_numero INTEGER         	-- 9
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 10
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 11
		,Ciudad_id VARCHAR(36)               	-- 12
		,Ciudad_numero INTEGER               	-- 13
		,Ciudad_nombre VARCHAR(50)           	-- 14
		,Ciudad_departamento VARCHAR(50)     	-- 15
		,Ciudad_numeroAFIP INTEGER           	-- 16
		,Transporte_domicilio VARCHAR(150)   	-- 17
		,Transporte_comentario VARCHAR(300)  	-- 18
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_Transporte_level_3 CASCADE;

CREATE TYPE massoftware.type_Transporte_level_3(

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
);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteById(idArg VARCHAR(36)) RETURNS massoftware.Transporte AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteById('xxx');

-- SELECT * FROM massoftware.f_TransporteById((SELECT Transporte.id FROM massoftware.Transporte LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteById_1(idArg VARCHAR(36)) RETURNS massoftware.type_Transporte_level_1 AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteById_1('xxx');

-- SELECT * FROM massoftware.f_TransporteById_1((SELECT Transporte.id FROM massoftware.Transporte LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteById_2(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteById_2(idArg VARCHAR(36)) RETURNS massoftware.type_Transporte_level_2 AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteById_2('xxx');

-- SELECT * FROM massoftware.f_TransporteById_2((SELECT Transporte.id FROM massoftware.Transporte LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteById_3(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteById_3(idArg VARCHAR(36)) RETURNS massoftware.type_Transporte_level_3 AS $$

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

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteById_3('xxx');

-- SELECT * FROM massoftware.f_TransporteById_3((SELECT Transporte.id FROM massoftware.Transporte LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Transporte(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Numero(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Numero(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Numero(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Numero(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Numero(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Nombre(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Nombre(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Nombre(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Nombre(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Nombre(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Cuit(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Cuit(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Cuit(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Cuit(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Cuit(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Cuit(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Cuit(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Cuit(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Cuit(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Cuit(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Cuit(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Cuit(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_IngresosBrutos(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_IngresosBrutos(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_IngresosBrutos(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_IngresosBrutos(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_IngresosBrutos(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_IngresosBrutos(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_IngresosBrutos(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_IngresosBrutos(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_IngresosBrutos(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_IngresosBrutos(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_IngresosBrutos(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_IngresosBrutos(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Telefono(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Telefono(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Telefono(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Telefono(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Telefono(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Telefono(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Telefono(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Telefono(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Telefono(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Telefono(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Telefono(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Telefono(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Fax(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Fax(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Fax(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Fax(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Fax(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Fax(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Fax(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Fax(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Fax(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Fax(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Fax(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Fax(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_CodigoPostal(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_CodigoPostal(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_CodigoPostal(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_CodigoPostal(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_CodigoPostal(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_CodigoPostal(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_CodigoPostal(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_CodigoPostal(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_CodigoPostal(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_CodigoPostal(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_CodigoPostal(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_CodigoPostal(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Domicilio(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Domicilio(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Domicilio(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Domicilio(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Domicilio(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Domicilio(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Domicilio(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Domicilio(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Domicilio(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Domicilio(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Domicilio(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Domicilio(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Comentario(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Comentario(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Comentario(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Comentario(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Comentario(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Comentario(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Comentario(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Comentario(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Comentario(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Comentario(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Comentario(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.Transporte  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,Transporte.domicilio AS Transporte_domicilio         	-- 7
		,Transporte.comentario AS Transporte_comentario       	-- 8

	FROM	massoftware.Transporte

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Comentario(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Numero_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Numero_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Numero_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Numero_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Numero_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Numero_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Numero_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Numero_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Nombre_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Nombre_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Nombre_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Nombre_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Nombre_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Nombre_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Nombre_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Nombre_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Cuit_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Cuit_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Cuit_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Cuit_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Cuit_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Cuit_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Cuit_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Cuit_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Cuit_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Cuit_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Cuit_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Cuit_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_IngresosBrutos_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_IngresosBrutos_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_IngresosBrutos_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_IngresosBrutos_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_IngresosBrutos_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_IngresosBrutos_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_IngresosBrutos_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_IngresosBrutos_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_IngresosBrutos_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_IngresosBrutos_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_IngresosBrutos_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_IngresosBrutos_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Telefono_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Telefono_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Telefono_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Telefono_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Telefono_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Telefono_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Telefono_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Telefono_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Telefono_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Telefono_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Telefono_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Telefono_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Fax_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Fax_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Fax_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Fax_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Fax_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Fax_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Fax_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Fax_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Fax_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Fax_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Fax_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Fax_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_CodigoPostal_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_CodigoPostal_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_CodigoPostal_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_CodigoPostal_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_CodigoPostal_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_CodigoPostal_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_CodigoPostal_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_CodigoPostal_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_CodigoPostal_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_CodigoPostal_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_CodigoPostal_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_CodigoPostal_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Domicilio_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Domicilio_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Domicilio_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Domicilio_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Domicilio_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Domicilio_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Domicilio_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Domicilio_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Domicilio_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Domicilio_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Domicilio_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Domicilio_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Comentario_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Comentario_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Comentario_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Comentario_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Comentario_1(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Comentario_1(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Comentario_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Comentario_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Comentario_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Comentario_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Comentario_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_1  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Transporte.domicilio AS Transporte_domicilio         	-- 12
		,Transporte.comentario AS Transporte_comentario       	-- 13

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Comentario_1(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Numero_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Numero_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Numero_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Numero_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Numero_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Numero_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Numero_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Numero_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Numero_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Numero_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Numero_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Numero_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Nombre_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Nombre_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Nombre_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Nombre_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Nombre_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Nombre_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Nombre_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Nombre_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Nombre_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Nombre_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Nombre_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Nombre_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Cuit_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Cuit_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Cuit_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Cuit_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Cuit_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Cuit_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Cuit_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Cuit_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Cuit_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Cuit_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Cuit_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Cuit_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_IngresosBrutos_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_IngresosBrutos_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_IngresosBrutos_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_IngresosBrutos_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_IngresosBrutos_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_IngresosBrutos_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_IngresosBrutos_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_IngresosBrutos_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_IngresosBrutos_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_IngresosBrutos_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_IngresosBrutos_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_IngresosBrutos_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Telefono_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Telefono_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Telefono_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Telefono_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Telefono_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Telefono_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Telefono_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Telefono_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Telefono_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Telefono_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Telefono_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Telefono_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Fax_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Fax_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Fax_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Fax_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Fax_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Fax_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Fax_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Fax_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Fax_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Fax_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Fax_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Fax_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_CodigoPostal_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_CodigoPostal_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_CodigoPostal_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_CodigoPostal_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_CodigoPostal_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_CodigoPostal_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_CodigoPostal_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_CodigoPostal_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_CodigoPostal_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_CodigoPostal_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_CodigoPostal_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_CodigoPostal_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Domicilio_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Domicilio_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Domicilio_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Domicilio_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Domicilio_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Domicilio_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Domicilio_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Domicilio_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Domicilio_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Domicilio_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Domicilio_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Domicilio_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Comentario_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Comentario_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Comentario_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Comentario_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Comentario_2(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Comentario_2(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Comentario_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Comentario_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Comentario_2(
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Comentario_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Comentario_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_2  AS $$

	SELECT
		 Transporte.id AS Transporte_id                       	-- 0
		,Transporte.numero AS Transporte_numero               	-- 1
		,Transporte.nombre AS Transporte_nombre               	-- 2
		,Transporte.cuit AS Transporte_cuit                   	-- 3
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 4
		,Transporte.telefono AS Transporte_telefono           	-- 5
		,Transporte.fax AS Transporte_fax                     	-- 6
		,CodigoPostal.id AS CodigoPostal_id                   	-- 7
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 8
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 9
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 10
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 11
		,Ciudad.id AS Ciudad_id                               	-- 12
		,Ciudad.numero AS Ciudad_numero                       	-- 13
		,Ciudad.nombre AS Ciudad_nombre                       	-- 14
		,Ciudad.departamento AS Ciudad_departamento           	-- 15
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 16
		,Transporte.domicilio AS Transporte_domicilio         	-- 17
		,Transporte.comentario AS Transporte_comentario       	-- 18

	FROM	massoftware.Transporte
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 7
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 12

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Comentario_2(
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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_3(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Numero_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Numero_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Numero_3(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Numero_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Numero_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Numero_3(100, 0
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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Nombre_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Nombre_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Nombre_3(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Nombre_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Nombre_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Nombre_3(100, 0
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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Cuit_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Cuit_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Cuit_3(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Cuit_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Cuit_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Cuit_3(100, 0
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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_IngresosBrutos_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_IngresosBrutos_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_IngresosBrutos_3(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_IngresosBrutos_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_IngresosBrutos_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_IngresosBrutos_3(100, 0
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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Telefono_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Telefono_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Telefono_3(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Telefono_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Telefono_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Telefono_3(100, 0
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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Fax_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Fax_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Fax_3(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Fax_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Fax_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Fax_3(100, 0
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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_CodigoPostal_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_CodigoPostal_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_CodigoPostal_3(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_CodigoPostal_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_CodigoPostal_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_CodigoPostal_3(100, 0
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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Domicilio_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Domicilio_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Domicilio_3(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Domicilio_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Domicilio_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Domicilio_3(100, 0
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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_asc_Transporte_Comentario_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_asc_Transporte_Comentario_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_asc_Transporte_Comentario_3(100, 0
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


DROP FUNCTION IF EXISTS massoftware.f_Transporte_des_Transporte_Comentario_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_des_Transporte_Comentario_3(limitArg BIGINT, offsetArg BIGINT

		, numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS massoftware.type_Transporte_level_3  AS $$

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

SELECT * FROM massoftware.f_Transporte_des_Transporte_Comentario_3(100, 0
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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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
) RETURNS massoftware.type_Transporte_level_3  AS $$

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