
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Carga                                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Carga

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Carga CASCADE;

CREATE TABLE massoftware.Carga
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº carga
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Carga_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Transporte
	transporte VARCHAR(36)  NOT NULL  REFERENCES massoftware.Transporte (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Carga_nombre ON massoftware.Carga (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCarga() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCarga() RETURNS TRIGGER AS $formatCarga$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.transporte := massoftware.white_is_null(NEW.transporte);

	RETURN NEW;
END;
$formatCarga$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCarga ON massoftware.Carga CASCADE;

CREATE TRIGGER tgFormatCarga BEFORE INSERT OR UPDATE
	ON massoftware.Carga FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatCarga();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Carga;

-- SELECT * FROM massoftware.Carga LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Carga;

-- SELECT * FROM massoftware.Carga WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_CargaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_CargaById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.Carga WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.Carga WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Carga WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_CargaById('xxx');

-- SELECT * FROM massoftware.d_CargaById((SELECT Carga.id FROM massoftware.Carga LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Carga(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, transporteArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Carga(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, transporteArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Carga(id, numero, nombre, transporte) VALUES (idArg, numeroArg, nombreArg, transporteArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Carga WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Carga(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Carga(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, transporteArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Carga(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, transporteArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Carga SET 
		  numero = numeroArg
		, nombre = nombreArg
		, transporte = transporteArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Carga WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Carga(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Carga_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Carga_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.Carga
	WHERE	(numeroArg IS NULL OR Carga.numero = numeroArg);

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Carga_numero(null::INTEGER);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Carga_nombre(nombreArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Carga_nombre(nombreArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.Carga
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Carga.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Carga_nombre(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Carga_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Carga_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER
	FROM	massoftware.Carga;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_Carga_numero();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CargaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CargaById(idArg VARCHAR(36)) RETURNS
	TABLE(
		 Carga_id VARCHAR(36)   	-- 0
		,Carga_numero INTEGER   	-- 1
		,Carga_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 Carga.id AS Carga_id       	-- 0
		,Carga.numero AS Carga_numero	-- 1
		,Carga.nombre AS Carga_nombre	-- 2

	FROM	massoftware.Carga

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CargaById('xxx');

-- SELECT * FROM massoftware.f_CargaById((SELECT Carga.id FROM massoftware.Carga LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CargaById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CargaById_1(idArg VARCHAR(36)) RETURNS
	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CargaById_1('xxx');

-- SELECT * FROM massoftware.f_CargaById_1((SELECT Carga.id FROM massoftware.Carga LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CargaById_2(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CargaById_2(idArg VARCHAR(36)) RETURNS
	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Transporte_domicilio VARCHAR(150)   	-- 15
		,Transporte_comentario VARCHAR(300)  	-- 16
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Transporte.domicilio AS Transporte_domicilio         	-- 15
		,Transporte.comentario AS Transporte_comentario       	-- 16

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CargaById_2('xxx');

-- SELECT * FROM massoftware.f_CargaById_2((SELECT Carga.id FROM massoftware.Carga LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_CargaById_3(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CargaById_3(idArg VARCHAR(36)) RETURNS
	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Ciudad_id VARCHAR(36)               	-- 15
		,Ciudad_numero INTEGER               	-- 16
		,Ciudad_nombre VARCHAR(50)           	-- 17
		,Ciudad_departamento VARCHAR(50)     	-- 18
		,Ciudad_numeroAFIP INTEGER           	-- 19
		,Transporte_domicilio VARCHAR(150)   	-- 20
		,Transporte_comentario VARCHAR(300)  	-- 21
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Ciudad.id AS Ciudad_id                               	-- 15
		,Ciudad.numero AS Ciudad_numero                       	-- 16
		,Ciudad.nombre AS Ciudad_nombre                       	-- 17
		,Ciudad.departamento AS Ciudad_departamento           	-- 18
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 19
		,Transporte.domicilio AS Transporte_domicilio         	-- 20
		,Transporte.comentario AS Transporte_comentario       	-- 21

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 15

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_CargaById_3('xxx');

-- SELECT * FROM massoftware.f_CargaById_3((SELECT Carga.id FROM massoftware.Carga LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)   	-- 0
		,Carga_numero INTEGER   	-- 1
		,Carga_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 Carga.id AS Carga_id       	-- 0
		,Carga.numero AS Carga_numero	-- 1
		,Carga.nombre AS Carga_nombre	-- 2

	FROM	massoftware.Carga

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga(
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
		 Carga_id VARCHAR(36)   	-- 0
		,Carga_numero INTEGER   	-- 1
		,Carga_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 Carga.id AS Carga_id       	-- 0
		,Carga.numero AS Carga_numero	-- 1
		,Carga.nombre AS Carga_nombre	-- 2

	FROM	massoftware.Carga

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Numero(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Numero(
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
		 Carga_id VARCHAR(36)   	-- 0
		,Carga_numero INTEGER   	-- 1
		,Carga_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 Carga.id AS Carga_id       	-- 0
		,Carga.numero AS Carga_numero	-- 1
		,Carga.nombre AS Carga_nombre	-- 2

	FROM	massoftware.Carga

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Numero(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Numero(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Numero(
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
		 Carga_id VARCHAR(36)   	-- 0
		,Carga_numero INTEGER   	-- 1
		,Carga_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 Carga.id AS Carga_id       	-- 0
		,Carga.numero AS Carga_numero	-- 1
		,Carga.nombre AS Carga_nombre	-- 2

	FROM	massoftware.Carga

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Numero(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)   	-- 0
		,Carga_numero INTEGER   	-- 1
		,Carga_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 Carga.id AS Carga_id       	-- 0
		,Carga.numero AS Carga_numero	-- 1
		,Carga.nombre AS Carga_nombre	-- 2

	FROM	massoftware.Carga

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Numero(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Numero(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)   	-- 0
		,Carga_numero INTEGER   	-- 1
		,Carga_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 Carga.id AS Carga_id       	-- 0
		,Carga.numero AS Carga_numero	-- 1
		,Carga.nombre AS Carga_nombre	-- 2

	FROM	massoftware.Carga

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Numero(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Nombre(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Nombre(
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
		 Carga_id VARCHAR(36)   	-- 0
		,Carga_numero INTEGER   	-- 1
		,Carga_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 Carga.id AS Carga_id       	-- 0
		,Carga.numero AS Carga_numero	-- 1
		,Carga.nombre AS Carga_nombre	-- 2

	FROM	massoftware.Carga

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Nombre(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Nombre(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Nombre(
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
		 Carga_id VARCHAR(36)   	-- 0
		,Carga_numero INTEGER   	-- 1
		,Carga_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 Carga.id AS Carga_id       	-- 0
		,Carga.numero AS Carga_numero	-- 1
		,Carga.nombre AS Carga_nombre	-- 2

	FROM	massoftware.Carga

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Nombre(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)   	-- 0
		,Carga_numero INTEGER   	-- 1
		,Carga_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 Carga.id AS Carga_id       	-- 0
		,Carga.numero AS Carga_numero	-- 1
		,Carga.nombre AS Carga_nombre	-- 2

	FROM	massoftware.Carga

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Nombre(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Nombre(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)   	-- 0
		,Carga_numero INTEGER   	-- 1
		,Carga_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 Carga.id AS Carga_id       	-- 0
		,Carga.numero AS Carga_numero	-- 1
		,Carga.nombre AS Carga_nombre	-- 2

	FROM	massoftware.Carga

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Nombre(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Transporte(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Transporte(
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
		 Carga_id VARCHAR(36)   	-- 0
		,Carga_numero INTEGER   	-- 1
		,Carga_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 Carga.id AS Carga_id       	-- 0
		,Carga.numero AS Carga_numero	-- 1
		,Carga.nombre AS Carga_nombre	-- 2

	FROM	massoftware.Carga

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Transporte(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Transporte(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Transporte(
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
		 Carga_id VARCHAR(36)   	-- 0
		,Carga_numero INTEGER   	-- 1
		,Carga_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 Carga.id AS Carga_id       	-- 0
		,Carga.numero AS Carga_numero	-- 1
		,Carga.nombre AS Carga_nombre	-- 2

	FROM	massoftware.Carga

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Transporte(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Transporte(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Transporte(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)   	-- 0
		,Carga_numero INTEGER   	-- 1
		,Carga_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 Carga.id AS Carga_id       	-- 0
		,Carga.numero AS Carga_numero	-- 1
		,Carga.nombre AS Carga_nombre	-- 2

	FROM	massoftware.Carga

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Transporte(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Transporte(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Transporte(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)   	-- 0
		,Carga_numero INTEGER   	-- 1
		,Carga_nombre VARCHAR(50)	-- 2
	) AS $$

	SELECT
		 Carga.id AS Carga_id       	-- 0
		,Carga.numero AS Carga_numero	-- 1
		,Carga.nombre AS Carga_nombre	-- 2

	FROM	massoftware.Carga

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Transporte(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_1(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_1(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_1(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Numero_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Numero_1(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Numero_1(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Numero_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Numero_1(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Numero_1(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Numero_1(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Numero_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Numero_1(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Nombre_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Nombre_1(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Nombre_1(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Nombre_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Nombre_1(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Nombre_1(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Nombre_1(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Nombre_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Nombre_1(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Transporte_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Transporte_1(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Transporte_1(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Transporte_1(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Transporte_1(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Transporte_1(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Transporte_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Transporte_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Transporte_1(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Transporte_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Transporte_1(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,Transporte_domicilio VARCHAR(150)   	-- 10
		,Transporte_comentario VARCHAR(300)  	-- 11
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,Transporte.domicilio AS Transporte_domicilio         	-- 10
		,Transporte.comentario AS Transporte_comentario       	-- 11

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 3

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Transporte_1(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Transporte_domicilio VARCHAR(150)   	-- 15
		,Transporte_comentario VARCHAR(300)  	-- 16
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Transporte.domicilio AS Transporte_domicilio         	-- 15
		,Transporte.comentario AS Transporte_comentario       	-- 16

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_2(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_2(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_2(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Transporte_domicilio VARCHAR(150)   	-- 15
		,Transporte_comentario VARCHAR(300)  	-- 16
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Transporte.domicilio AS Transporte_domicilio         	-- 15
		,Transporte.comentario AS Transporte_comentario       	-- 16

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_2(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Numero_2(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Numero_2(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Transporte_domicilio VARCHAR(150)   	-- 15
		,Transporte_comentario VARCHAR(300)  	-- 16
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Transporte.domicilio AS Transporte_domicilio         	-- 15
		,Transporte.comentario AS Transporte_comentario       	-- 16

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Numero_2(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Numero_2(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Numero_2(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Transporte_domicilio VARCHAR(150)   	-- 15
		,Transporte_comentario VARCHAR(300)  	-- 16
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Transporte.domicilio AS Transporte_domicilio         	-- 15
		,Transporte.comentario AS Transporte_comentario       	-- 16

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Numero_2(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Numero_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Numero_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Transporte_domicilio VARCHAR(150)   	-- 15
		,Transporte_comentario VARCHAR(300)  	-- 16
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Transporte.domicilio AS Transporte_domicilio         	-- 15
		,Transporte.comentario AS Transporte_comentario       	-- 16

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Numero_2(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Numero_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Numero_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Transporte_domicilio VARCHAR(150)   	-- 15
		,Transporte_comentario VARCHAR(300)  	-- 16
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Transporte.domicilio AS Transporte_domicilio         	-- 15
		,Transporte.comentario AS Transporte_comentario       	-- 16

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Numero_2(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Nombre_2(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Nombre_2(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Transporte_domicilio VARCHAR(150)   	-- 15
		,Transporte_comentario VARCHAR(300)  	-- 16
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Transporte.domicilio AS Transporte_domicilio         	-- 15
		,Transporte.comentario AS Transporte_comentario       	-- 16

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Nombre_2(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Nombre_2(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Nombre_2(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Transporte_domicilio VARCHAR(150)   	-- 15
		,Transporte_comentario VARCHAR(300)  	-- 16
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Transporte.domicilio AS Transporte_domicilio         	-- 15
		,Transporte.comentario AS Transporte_comentario       	-- 16

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Nombre_2(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Nombre_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Nombre_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Transporte_domicilio VARCHAR(150)   	-- 15
		,Transporte_comentario VARCHAR(300)  	-- 16
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Transporte.domicilio AS Transporte_domicilio         	-- 15
		,Transporte.comentario AS Transporte_comentario       	-- 16

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Nombre_2(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Nombre_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Nombre_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Transporte_domicilio VARCHAR(150)   	-- 15
		,Transporte_comentario VARCHAR(300)  	-- 16
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Transporte.domicilio AS Transporte_domicilio         	-- 15
		,Transporte.comentario AS Transporte_comentario       	-- 16

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Nombre_2(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Transporte_2(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Transporte_2(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Transporte_domicilio VARCHAR(150)   	-- 15
		,Transporte_comentario VARCHAR(300)  	-- 16
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Transporte.domicilio AS Transporte_domicilio         	-- 15
		,Transporte.comentario AS Transporte_comentario       	-- 16

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Transporte_2(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Transporte_2(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Transporte_2(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Transporte_domicilio VARCHAR(150)   	-- 15
		,Transporte_comentario VARCHAR(300)  	-- 16
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Transporte.domicilio AS Transporte_domicilio         	-- 15
		,Transporte.comentario AS Transporte_comentario       	-- 16

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Transporte_2(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Transporte_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Transporte_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Transporte_domicilio VARCHAR(150)   	-- 15
		,Transporte_comentario VARCHAR(300)  	-- 16
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Transporte.domicilio AS Transporte_domicilio         	-- 15
		,Transporte.comentario AS Transporte_comentario       	-- 16

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Transporte_2(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Transporte_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Transporte_2(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Transporte_domicilio VARCHAR(150)   	-- 15
		,Transporte_comentario VARCHAR(300)  	-- 16
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Transporte.domicilio AS Transporte_domicilio         	-- 15
		,Transporte.comentario AS Transporte_comentario       	-- 16

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Transporte_2(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Ciudad_id VARCHAR(36)               	-- 15
		,Ciudad_numero INTEGER               	-- 16
		,Ciudad_nombre VARCHAR(50)           	-- 17
		,Ciudad_departamento VARCHAR(50)     	-- 18
		,Ciudad_numeroAFIP INTEGER           	-- 19
		,Transporte_domicilio VARCHAR(150)   	-- 20
		,Transporte_comentario VARCHAR(300)  	-- 21
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Ciudad.id AS Ciudad_id                               	-- 15
		,Ciudad.numero AS Ciudad_numero                       	-- 16
		,Ciudad.nombre AS Ciudad_nombre                       	-- 17
		,Ciudad.departamento AS Ciudad_departamento           	-- 18
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 19
		,Transporte.domicilio AS Transporte_domicilio         	-- 20
		,Transporte.comentario AS Transporte_comentario       	-- 21

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 15

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_3(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_3(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Ciudad_id VARCHAR(36)               	-- 15
		,Ciudad_numero INTEGER               	-- 16
		,Ciudad_nombre VARCHAR(50)           	-- 17
		,Ciudad_departamento VARCHAR(50)     	-- 18
		,Ciudad_numeroAFIP INTEGER           	-- 19
		,Transporte_domicilio VARCHAR(150)   	-- 20
		,Transporte_comentario VARCHAR(300)  	-- 21
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Ciudad.id AS Ciudad_id                               	-- 15
		,Ciudad.numero AS Ciudad_numero                       	-- 16
		,Ciudad.nombre AS Ciudad_nombre                       	-- 17
		,Ciudad.departamento AS Ciudad_departamento           	-- 18
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 19
		,Transporte.domicilio AS Transporte_domicilio         	-- 20
		,Transporte.comentario AS Transporte_comentario       	-- 21

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 15

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_3(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Numero_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Numero_3(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Ciudad_id VARCHAR(36)               	-- 15
		,Ciudad_numero INTEGER               	-- 16
		,Ciudad_nombre VARCHAR(50)           	-- 17
		,Ciudad_departamento VARCHAR(50)     	-- 18
		,Ciudad_numeroAFIP INTEGER           	-- 19
		,Transporte_domicilio VARCHAR(150)   	-- 20
		,Transporte_comentario VARCHAR(300)  	-- 21
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Ciudad.id AS Ciudad_id                               	-- 15
		,Ciudad.numero AS Ciudad_numero                       	-- 16
		,Ciudad.nombre AS Ciudad_nombre                       	-- 17
		,Ciudad.departamento AS Ciudad_departamento           	-- 18
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 19
		,Transporte.domicilio AS Transporte_domicilio         	-- 20
		,Transporte.comentario AS Transporte_comentario       	-- 21

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 15

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Numero_3(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Numero_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Numero_3(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Ciudad_id VARCHAR(36)               	-- 15
		,Ciudad_numero INTEGER               	-- 16
		,Ciudad_nombre VARCHAR(50)           	-- 17
		,Ciudad_departamento VARCHAR(50)     	-- 18
		,Ciudad_numeroAFIP INTEGER           	-- 19
		,Transporte_domicilio VARCHAR(150)   	-- 20
		,Transporte_comentario VARCHAR(300)  	-- 21
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Ciudad.id AS Ciudad_id                               	-- 15
		,Ciudad.numero AS Ciudad_numero                       	-- 16
		,Ciudad.nombre AS Ciudad_nombre                       	-- 17
		,Ciudad.departamento AS Ciudad_departamento           	-- 18
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 19
		,Transporte.domicilio AS Transporte_domicilio         	-- 20
		,Transporte.comentario AS Transporte_comentario       	-- 21

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 15

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Numero_3(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Numero_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Numero_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Ciudad_id VARCHAR(36)               	-- 15
		,Ciudad_numero INTEGER               	-- 16
		,Ciudad_nombre VARCHAR(50)           	-- 17
		,Ciudad_departamento VARCHAR(50)     	-- 18
		,Ciudad_numeroAFIP INTEGER           	-- 19
		,Transporte_domicilio VARCHAR(150)   	-- 20
		,Transporte_comentario VARCHAR(300)  	-- 21
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Ciudad.id AS Ciudad_id                               	-- 15
		,Ciudad.numero AS Ciudad_numero                       	-- 16
		,Ciudad.nombre AS Ciudad_nombre                       	-- 17
		,Ciudad.departamento AS Ciudad_departamento           	-- 18
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 19
		,Transporte.domicilio AS Transporte_domicilio         	-- 20
		,Transporte.comentario AS Transporte_comentario       	-- 21

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 15

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Numero_3(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Numero_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Numero_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Ciudad_id VARCHAR(36)               	-- 15
		,Ciudad_numero INTEGER               	-- 16
		,Ciudad_nombre VARCHAR(50)           	-- 17
		,Ciudad_departamento VARCHAR(50)     	-- 18
		,Ciudad_numeroAFIP INTEGER           	-- 19
		,Transporte_domicilio VARCHAR(150)   	-- 20
		,Transporte_comentario VARCHAR(300)  	-- 21
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Ciudad.id AS Ciudad_id                               	-- 15
		,Ciudad.numero AS Ciudad_numero                       	-- 16
		,Ciudad.nombre AS Ciudad_nombre                       	-- 17
		,Ciudad.departamento AS Ciudad_departamento           	-- 18
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 19
		,Transporte.domicilio AS Transporte_domicilio         	-- 20
		,Transporte.comentario AS Transporte_comentario       	-- 21

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 15

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Numero_3(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Nombre_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Nombre_3(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Ciudad_id VARCHAR(36)               	-- 15
		,Ciudad_numero INTEGER               	-- 16
		,Ciudad_nombre VARCHAR(50)           	-- 17
		,Ciudad_departamento VARCHAR(50)     	-- 18
		,Ciudad_numeroAFIP INTEGER           	-- 19
		,Transporte_domicilio VARCHAR(150)   	-- 20
		,Transporte_comentario VARCHAR(300)  	-- 21
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Ciudad.id AS Ciudad_id                               	-- 15
		,Ciudad.numero AS Ciudad_numero                       	-- 16
		,Ciudad.nombre AS Ciudad_nombre                       	-- 17
		,Ciudad.departamento AS Ciudad_departamento           	-- 18
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 19
		,Transporte.domicilio AS Transporte_domicilio         	-- 20
		,Transporte.comentario AS Transporte_comentario       	-- 21

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 15

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Nombre_3(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Nombre_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Nombre_3(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Ciudad_id VARCHAR(36)               	-- 15
		,Ciudad_numero INTEGER               	-- 16
		,Ciudad_nombre VARCHAR(50)           	-- 17
		,Ciudad_departamento VARCHAR(50)     	-- 18
		,Ciudad_numeroAFIP INTEGER           	-- 19
		,Transporte_domicilio VARCHAR(150)   	-- 20
		,Transporte_comentario VARCHAR(300)  	-- 21
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Ciudad.id AS Ciudad_id                               	-- 15
		,Ciudad.numero AS Ciudad_numero                       	-- 16
		,Ciudad.nombre AS Ciudad_nombre                       	-- 17
		,Ciudad.departamento AS Ciudad_departamento           	-- 18
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 19
		,Transporte.domicilio AS Transporte_domicilio         	-- 20
		,Transporte.comentario AS Transporte_comentario       	-- 21

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 15

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Nombre_3(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Nombre_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Nombre_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Ciudad_id VARCHAR(36)               	-- 15
		,Ciudad_numero INTEGER               	-- 16
		,Ciudad_nombre VARCHAR(50)           	-- 17
		,Ciudad_departamento VARCHAR(50)     	-- 18
		,Ciudad_numeroAFIP INTEGER           	-- 19
		,Transporte_domicilio VARCHAR(150)   	-- 20
		,Transporte_comentario VARCHAR(300)  	-- 21
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Ciudad.id AS Ciudad_id                               	-- 15
		,Ciudad.numero AS Ciudad_numero                       	-- 16
		,Ciudad.nombre AS Ciudad_nombre                       	-- 17
		,Ciudad.departamento AS Ciudad_departamento           	-- 18
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 19
		,Transporte.domicilio AS Transporte_domicilio         	-- 20
		,Transporte.comentario AS Transporte_comentario       	-- 21

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 15

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Nombre_3(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Nombre_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Nombre_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Ciudad_id VARCHAR(36)               	-- 15
		,Ciudad_numero INTEGER               	-- 16
		,Ciudad_nombre VARCHAR(50)           	-- 17
		,Ciudad_departamento VARCHAR(50)     	-- 18
		,Ciudad_numeroAFIP INTEGER           	-- 19
		,Transporte_domicilio VARCHAR(150)   	-- 20
		,Transporte_comentario VARCHAR(300)  	-- 21
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Ciudad.id AS Ciudad_id                               	-- 15
		,Ciudad.numero AS Ciudad_numero                       	-- 16
		,Ciudad.nombre AS Ciudad_nombre                       	-- 17
		,Ciudad.departamento AS Ciudad_departamento           	-- 18
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 19
		,Transporte.domicilio AS Transporte_domicilio         	-- 20
		,Transporte.comentario AS Transporte_comentario       	-- 21

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 15

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Nombre_3(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Transporte_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Transporte_3(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Ciudad_id VARCHAR(36)               	-- 15
		,Ciudad_numero INTEGER               	-- 16
		,Ciudad_nombre VARCHAR(50)           	-- 17
		,Ciudad_departamento VARCHAR(50)     	-- 18
		,Ciudad_numeroAFIP INTEGER           	-- 19
		,Transporte_domicilio VARCHAR(150)   	-- 20
		,Transporte_comentario VARCHAR(300)  	-- 21
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Ciudad.id AS Ciudad_id                               	-- 15
		,Ciudad.numero AS Ciudad_numero                       	-- 16
		,Ciudad.nombre AS Ciudad_nombre                       	-- 17
		,Ciudad.departamento AS Ciudad_departamento           	-- 18
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 19
		,Transporte.domicilio AS Transporte_domicilio         	-- 20
		,Transporte.comentario AS Transporte_comentario       	-- 21

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 15

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Transporte_3(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Transporte_3(
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

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Transporte_3(
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
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Ciudad_id VARCHAR(36)               	-- 15
		,Ciudad_numero INTEGER               	-- 16
		,Ciudad_nombre VARCHAR(50)           	-- 17
		,Ciudad_departamento VARCHAR(50)     	-- 18
		,Ciudad_numeroAFIP INTEGER           	-- 19
		,Transporte_domicilio VARCHAR(150)   	-- 20
		,Transporte_comentario VARCHAR(300)  	-- 21
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Ciudad.id AS Ciudad_id                               	-- 15
		,Ciudad.numero AS Ciudad_numero                       	-- 16
		,Ciudad.nombre AS Ciudad_nombre                       	-- 17
		,Ciudad.departamento AS Ciudad_departamento           	-- 18
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 19
		,Transporte.domicilio AS Transporte_domicilio         	-- 20
		,Transporte.comentario AS Transporte_comentario       	-- 21

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 15

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Transporte_3(
		100
		, 0
		, null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_asc_Carga_Transporte_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_asc_Carga_Transporte_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Ciudad_id VARCHAR(36)               	-- 15
		,Ciudad_numero INTEGER               	-- 16
		,Ciudad_nombre VARCHAR(50)           	-- 17
		,Ciudad_departamento VARCHAR(50)     	-- 18
		,Ciudad_numeroAFIP INTEGER           	-- 19
		,Transporte_domicilio VARCHAR(150)   	-- 20
		,Transporte_comentario VARCHAR(300)  	-- 21
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Ciudad.id AS Ciudad_id                               	-- 15
		,Ciudad.numero AS Ciudad_numero                       	-- 16
		,Ciudad.nombre AS Ciudad_nombre                       	-- 17
		,Ciudad.departamento AS Ciudad_departamento           	-- 18
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 19
		,Transporte.domicilio AS Transporte_domicilio         	-- 20
		,Transporte.comentario AS Transporte_comentario       	-- 21

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 15

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_asc_Carga_Transporte_3(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Carga_des_Carga_Transporte_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_des_Carga_Transporte_3(

		  numeroFromArg0 INTEGER
		, numeroToArg1 INTEGER
		, nombreWord0Arg2 VARCHAR(15)
		, nombreWord1Arg3 VARCHAR(15)
		, nombreWord2Arg4 VARCHAR(15)
		, nombreWord3Arg5 VARCHAR(15)
		, nombreWord4Arg6 VARCHAR(15)
) RETURNS

	TABLE(
		 Carga_id VARCHAR(36)                	-- 0
		,Carga_numero INTEGER                	-- 1
		,Carga_nombre VARCHAR(50)            	-- 2
		,Transporte_id VARCHAR(36)           	-- 3
		,Transporte_numero INTEGER           	-- 4
		,Transporte_nombre VARCHAR(50)       	-- 5
		,Transporte_cuit BIGINT              	-- 6
		,Transporte_ingresosBrutos VARCHAR(13)	-- 7
		,Transporte_telefono VARCHAR(50)     	-- 8
		,Transporte_fax VARCHAR(50)          	-- 9
		,CodigoPostal_id VARCHAR(36)         	-- 10
		,CodigoPostal_codigo VARCHAR(12)     	-- 11
		,CodigoPostal_numero INTEGER         	-- 12
		,CodigoPostal_nombreCalle VARCHAR(200)	-- 13
		,CodigoPostal_numeroCalle VARCHAR(20)	-- 14
		,Ciudad_id VARCHAR(36)               	-- 15
		,Ciudad_numero INTEGER               	-- 16
		,Ciudad_nombre VARCHAR(50)           	-- 17
		,Ciudad_departamento VARCHAR(50)     	-- 18
		,Ciudad_numeroAFIP INTEGER           	-- 19
		,Transporte_domicilio VARCHAR(150)   	-- 20
		,Transporte_comentario VARCHAR(300)  	-- 21
	) AS $$

	SELECT
		 Carga.id AS Carga_id                                 	-- 0
		,Carga.numero AS Carga_numero                         	-- 1
		,Carga.nombre AS Carga_nombre                         	-- 2
		,Transporte.id AS Transporte_id                       	-- 3
		,Transporte.numero AS Transporte_numero               	-- 4
		,Transporte.nombre AS Transporte_nombre               	-- 5
		,Transporte.cuit AS Transporte_cuit                   	-- 6
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos	-- 7
		,Transporte.telefono AS Transporte_telefono           	-- 8
		,Transporte.fax AS Transporte_fax                     	-- 9
		,CodigoPostal.id AS CodigoPostal_id                   	-- 10
		,CodigoPostal.codigo AS CodigoPostal_codigo           	-- 11
		,CodigoPostal.numero AS CodigoPostal_numero           	-- 12
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle 	-- 13
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle 	-- 14
		,Ciudad.id AS Ciudad_id                               	-- 15
		,Ciudad.numero AS Ciudad_numero                       	-- 16
		,Ciudad.nombre AS Ciudad_nombre                       	-- 17
		,Ciudad.departamento AS Ciudad_departamento           	-- 18
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP               	-- 19
		,Transporte.domicilio AS Transporte_domicilio         	-- 20
		,Transporte.comentario AS Transporte_comentario       	-- 21

	FROM	massoftware.Carga
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 3
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 10
		LEFT JOIN massoftware.Ciudad ON CodigoPostal.ciudad = Ciudad.id               	-- 15

	WHERE	(numeroFromArg0 IS NULL OR Carga.numero >= numeroFromArg0)
		 AND (numeroToArg1 IS NULL OR Carga.numero <= numeroToArg1)
		 AND (nombreWord0Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg2)) || '%')::VARCHAR))
		 AND (nombreWord1Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg3)) || '%')::VARCHAR))
		 AND (nombreWord2Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg4)) || '%')::VARCHAR))
		 AND (nombreWord3Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg5)) || '%')::VARCHAR))
		 AND (nombreWord4Arg6 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg6)) > 0 AND TRIM(massoftware.TRANSLATE(Carga.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg6)) || '%')::VARCHAR))

	ORDER BY Carga.transporte DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Carga_des_Carga_Transporte_3(
		 null::INTEGER -- Carga_numeroFromArg0
		, null::INTEGER -- Carga_numeroToArg1
		, null::VARCHAR -- Carga_nombreWord0Arg2
		, null::VARCHAR -- Carga_nombreWord1Arg3
		, null::VARCHAR -- Carga_nombreWord2Arg4
		, null::VARCHAR -- Carga_nombreWord3Arg5
		, null::VARCHAR -- Carga_nombreWord4Arg6
);

*/