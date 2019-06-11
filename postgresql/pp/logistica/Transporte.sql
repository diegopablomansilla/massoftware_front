
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


DROP FUNCTION IF EXISTS massoftware.f_exists_Transporte_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Transporte_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Transporte
	WHERE	(numeroArg IS NULL OR Transporte.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Transporte_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Transporte_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Transporte_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Transporte
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Transporte.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Transporte_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Transporte_cuit(cuitArg BIGINT) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Transporte_cuit(cuitArg BIGINT) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Transporte
	WHERE	(cuitArg IS NULL OR Transporte.cuit = cuitArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Transporte_cuit(null::BIGINT);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Transporte_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Transporte_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Transporte;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Transporte_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Transporte_cuit() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Transporte_cuit() RETURNS BIGINT AS $$

	SELECT (COALESCE(MAX(cuit),0) + 1)::BIGINT FROM massoftware.Transporte;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Transporte_cuit();

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
		, null::VARCHAR(50)
		, null::BIGINT
		, null::VARCHAR(13)
		, null::VARCHAR(50)
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::VARCHAR(150)
		, null::VARCHAR(300)
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
		, null::VARCHAR(50)
		, null::BIGINT
		, null::VARCHAR(13)
		, null::VARCHAR(50)
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::VARCHAR(150)
		, null::VARCHAR(300)
);

*/

DROP TYPE IF EXISTS massoftware.t_Transporte_1 CASCADE;

CREATE TYPE massoftware.t_Transporte_1 AS (

	  Transporte_id             	VARCHAR(36) 		-- 0	Transporte.id
	, Transporte_numero         	INTEGER     		-- 1	Transporte.numero
	, Transporte_nombre         	VARCHAR(50) 		-- 2	Transporte.nombre
	, Transporte_cuit           	BIGINT      		-- 3	Transporte.cuit
	, Transporte_ingresosBrutos 	VARCHAR(13) 		-- 4	Transporte.ingresosBrutos
	, Transporte_telefono       	VARCHAR(50) 		-- 5	Transporte.telefono
	, Transporte_fax            	VARCHAR(50) 		-- 6	Transporte.fax
	, CodigoPostal_7_id         	VARCHAR(36) 		-- 7	Transporte.CodigoPostal.id
	, CodigoPostal_7_codigo     	VARCHAR(12) 		-- 8	Transporte.CodigoPostal.codigo
	, CodigoPostal_7_numero     	INTEGER     		-- 9	Transporte.CodigoPostal.numero
	, CodigoPostal_7_nombreCalle	VARCHAR(200)		-- 10	Transporte.CodigoPostal.nombreCalle
	, CodigoPostal_7_numeroCalle	VARCHAR(20) 		-- 11	Transporte.CodigoPostal.numeroCalle
	, CodigoPostal_7_ciudad     	VARCHAR(36) 		-- 12	Transporte.CodigoPostal.ciudad
	, Transporte_domicilio      	VARCHAR(150)		-- 13	Transporte.domicilio
	, Transporte_comentario     	VARCHAR(300)		-- 14	Transporte.comentario

);

DROP TYPE IF EXISTS massoftware.t_Transporte_2 CASCADE;

CREATE TYPE massoftware.t_Transporte_2 AS (

	  Transporte_id             	VARCHAR(36) 		-- 0	Transporte.id
	, Transporte_numero         	INTEGER     		-- 1	Transporte.numero
	, Transporte_nombre         	VARCHAR(50) 		-- 2	Transporte.nombre
	, Transporte_cuit           	BIGINT      		-- 3	Transporte.cuit
	, Transporte_ingresosBrutos 	VARCHAR(13) 		-- 4	Transporte.ingresosBrutos
	, Transporte_telefono       	VARCHAR(50) 		-- 5	Transporte.telefono
	, Transporte_fax            	VARCHAR(50) 		-- 6	Transporte.fax
	, CodigoPostal_7_id         	VARCHAR(36) 		-- 7	Transporte.CodigoPostal.id
	, CodigoPostal_7_codigo     	VARCHAR(12) 		-- 8	Transporte.CodigoPostal.codigo
	, CodigoPostal_7_numero     	INTEGER     		-- 9	Transporte.CodigoPostal.numero
	, CodigoPostal_7_nombreCalle	VARCHAR(200)		-- 10	Transporte.CodigoPostal.nombreCalle
	, CodigoPostal_7_numeroCalle	VARCHAR(20) 		-- 11	Transporte.CodigoPostal.numeroCalle
	, Ciudad_12_id              	VARCHAR(36) 		-- 12	Transporte.CodigoPostal.Ciudad.id
	, Ciudad_12_numero          	INTEGER     		-- 13	Transporte.CodigoPostal.Ciudad.numero
	, Ciudad_12_nombre          	VARCHAR(50) 		-- 14	Transporte.CodigoPostal.Ciudad.nombre
	, Ciudad_12_departamento    	VARCHAR(50) 		-- 15	Transporte.CodigoPostal.Ciudad.departamento
	, Ciudad_12_numeroAFIP      	INTEGER     		-- 16	Transporte.CodigoPostal.Ciudad.numeroAFIP
	, Ciudad_12_provincia       	VARCHAR(36) 		-- 17	Transporte.CodigoPostal.Ciudad.provincia
	, Transporte_domicilio      	VARCHAR(150)		-- 18	Transporte.domicilio
	, Transporte_comentario     	VARCHAR(300)		-- 19	Transporte.comentario

);

DROP TYPE IF EXISTS massoftware.t_Transporte_3 CASCADE;

CREATE TYPE massoftware.t_Transporte_3 AS (

	  Transporte_id                    	VARCHAR(36) 		-- 0	Transporte.id
	, Transporte_numero                	INTEGER     		-- 1	Transporte.numero
	, Transporte_nombre                	VARCHAR(50) 		-- 2	Transporte.nombre
	, Transporte_cuit                  	BIGINT      		-- 3	Transporte.cuit
	, Transporte_ingresosBrutos        	VARCHAR(13) 		-- 4	Transporte.ingresosBrutos
	, Transporte_telefono              	VARCHAR(50) 		-- 5	Transporte.telefono
	, Transporte_fax                   	VARCHAR(50) 		-- 6	Transporte.fax
	, CodigoPostal_7_id                	VARCHAR(36) 		-- 7	Transporte.CodigoPostal.id
	, CodigoPostal_7_codigo            	VARCHAR(12) 		-- 8	Transporte.CodigoPostal.codigo
	, CodigoPostal_7_numero            	INTEGER     		-- 9	Transporte.CodigoPostal.numero
	, CodigoPostal_7_nombreCalle       	VARCHAR(200)		-- 10	Transporte.CodigoPostal.nombreCalle
	, CodigoPostal_7_numeroCalle       	VARCHAR(20) 		-- 11	Transporte.CodigoPostal.numeroCalle
	, Ciudad_12_id                     	VARCHAR(36) 		-- 12	Transporte.CodigoPostal.Ciudad.id
	, Ciudad_12_numero                 	INTEGER     		-- 13	Transporte.CodigoPostal.Ciudad.numero
	, Ciudad_12_nombre                 	VARCHAR(50) 		-- 14	Transporte.CodigoPostal.Ciudad.nombre
	, Ciudad_12_departamento           	VARCHAR(50) 		-- 15	Transporte.CodigoPostal.Ciudad.departamento
	, Ciudad_12_numeroAFIP             	INTEGER     		-- 16	Transporte.CodigoPostal.Ciudad.numeroAFIP
	, Provincia_17_id                  	VARCHAR(36) 		-- 17	Transporte.CodigoPostal.Ciudad.Provincia.id
	, Provincia_17_numero              	INTEGER     		-- 18	Transporte.CodigoPostal.Ciudad.Provincia.numero
	, Provincia_17_nombre              	VARCHAR(50) 		-- 19	Transporte.CodigoPostal.Ciudad.Provincia.nombre
	, Provincia_17_abreviatura         	VARCHAR(5)  		-- 20	Transporte.CodigoPostal.Ciudad.Provincia.abreviatura
	, Provincia_17_numeroAFIP          	INTEGER     		-- 21	Transporte.CodigoPostal.Ciudad.Provincia.numeroAFIP
	, Provincia_17_numeroIngresosBrutos	INTEGER     		-- 22	Transporte.CodigoPostal.Ciudad.Provincia.numeroIngresosBrutos
	, Provincia_17_numeroRENATEA       	INTEGER     		-- 23	Transporte.CodigoPostal.Ciudad.Provincia.numeroRENATEA
	, Provincia_17_pais                	VARCHAR(36) 		-- 24	Transporte.CodigoPostal.Ciudad.Provincia.pais
	, Transporte_domicilio             	VARCHAR(150)		-- 25	Transporte.domicilio
	, Transporte_comentario            	VARCHAR(300)		-- 26	Transporte.comentario

);

DROP FUNCTION IF EXISTS massoftware.f_Transporte (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.Transporte AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Transporte.id                AS Transporte_id            	-- 0	.id           		VARCHAR(36)
				, Transporte.numero            AS Transporte_numero        	-- 1	.numero       		INTEGER
				, Transporte.nombre            AS Transporte_nombre        	-- 2	.nombre       		VARCHAR(50)
				, Transporte.cuit              AS Transporte_cuit          	-- 3	.cuit         		BIGINT
				, Transporte.ingresosBrutos    AS Transporte_ingresosBrutos	-- 4	.ingresosBrutos		VARCHAR(13)
				, Transporte.telefono          AS Transporte_telefono      	-- 5	.telefono     		VARCHAR(50)
				, Transporte.fax               AS Transporte_fax           	-- 6	.fax          		VARCHAR(50)
				, Transporte.codigoPostal      AS Transporte_codigoPostal  	-- 7	.codigoPostal 		VARCHAR(36)	CodigoPostal.id
				, Transporte.domicilio         AS Transporte_domicilio     	-- 8	.domicilio    		VARCHAR(150)
				, Transporte.comentario        AS Transporte_comentario    	-- 9	.comentario   		VARCHAR(300)

		FROM	massoftware.Transporte

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Transporte.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Transporte.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Transporte.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg7)) > 0 THEN
		nombreArg7 = REPLACE(nombreArg7, '''', '''''');
		nombreArg7 = LOWER(TRIM(nombreArg7));
		nombreArg7 = TRANSLATE(nombreArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Transporte.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	IF searchById = false AND orderByArg1 IS NOT NULL AND orderByArg1 > -1 THEN
		sqlSrc = sqlSrc || ' ORDER BY ' || orderByArg1;
	ELSEIF searchById = false THEN 
		sqlSrc = sqlSrc || ' ORDER BY 1 ';
	END IF;

	IF searchById = false AND orderByDescArg2 IS NOT NULL AND orderByDescArg2 = true THEN
		sqlSrc = sqlSrc || ' DESC ';
	END IF;

	IF searchById = false AND limitArg3 IS NOT NULL AND offSetArg4 IS NOT NULL AND limitArg3 > 0 AND limitArg3 <= 100 AND offSetArg4 >= 0 THEN
		sqlSrc = sqlSrc || ' LIMIT ' || limitArg3 || ' OFFSET ' || offSetArg4;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	RETURN QUERY EXECUTE sqlSrc || ';';

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_TransporteById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Transporte AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Transporte ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Transporte ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_TransporteById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Transporte_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.t_Transporte_1 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Transporte.id                  AS Transporte_id             	-- 0	.id                     		VARCHAR(36)
				, Transporte.numero              AS Transporte_numero         	-- 1	.numero                 		INTEGER
				, Transporte.nombre              AS Transporte_nombre         	-- 2	.nombre                 		VARCHAR(50)
				, Transporte.cuit                AS Transporte_cuit           	-- 3	.cuit                   		BIGINT
				, Transporte.ingresosBrutos      AS Transporte_ingresosBrutos 	-- 4	.ingresosBrutos         		VARCHAR(13)
				, Transporte.telefono            AS Transporte_telefono       	-- 5	.telefono               		VARCHAR(50)
				, Transporte.fax                 AS Transporte_fax            	-- 6	.fax                    		VARCHAR(50)
				, CodigoPostal_7.id              AS CodigoPostal_7_id         	-- 7	.CodigoPostal.id        		VARCHAR(36)
				, CodigoPostal_7.codigo          AS CodigoPostal_7_codigo     	-- 8	.CodigoPostal.codigo    		VARCHAR(12)
				, CodigoPostal_7.numero          AS CodigoPostal_7_numero     	-- 9	.CodigoPostal.numero    		INTEGER
				, CodigoPostal_7.nombreCalle     AS CodigoPostal_7_nombreCalle	-- 10	.CodigoPostal.nombreCalle		VARCHAR(200)
				, CodigoPostal_7.numeroCalle     AS CodigoPostal_7_numeroCalle	-- 11	.CodigoPostal.numeroCalle		VARCHAR(20)
				, CodigoPostal_7.ciudad          AS CodigoPostal_7_ciudad     	-- 12	.CodigoPostal.ciudad    		VARCHAR(36)	Ciudad.id
				, Transporte.domicilio           AS Transporte_domicilio      	-- 13	.domicilio              		VARCHAR(150)
				, Transporte.comentario          AS Transporte_comentario     	-- 14	.comentario             		VARCHAR(300)

		FROM	massoftware.Transporte
			LEFT JOIN massoftware.CodigoPostal AS CodigoPostal_7        ON Transporte.codigoPostal = CodigoPostal_7.id 	-- 7 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Transporte.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Transporte.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Transporte.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg7)) > 0 THEN
		nombreArg7 = REPLACE(nombreArg7, '''', '''''');
		nombreArg7 = LOWER(TRIM(nombreArg7));
		nombreArg7 = TRANSLATE(nombreArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Transporte.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	IF searchById = false AND orderByArg1 IS NOT NULL AND orderByArg1 > -1 THEN
		sqlSrc = sqlSrc || ' ORDER BY ' || orderByArg1;
	ELSEIF searchById = false THEN 
		sqlSrc = sqlSrc || ' ORDER BY 1 ';
	END IF;

	IF searchById = false AND orderByDescArg2 IS NOT NULL AND orderByDescArg2 = true THEN
		sqlSrc = sqlSrc || ' DESC ';
	END IF;

	IF searchById = false AND limitArg3 IS NOT NULL AND offSetArg4 IS NOT NULL AND limitArg3 > 0 AND limitArg3 <= 100 AND offSetArg4 >= 0 THEN
		sqlSrc = sqlSrc || ' LIMIT ' || limitArg3 || ' OFFSET ' || offSetArg4;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	RETURN QUERY EXECUTE sqlSrc || ';';

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_TransporteById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Transporte_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Transporte_1 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Transporte_1 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_TransporteById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Transporte_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.t_Transporte_2 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Transporte.id                  AS Transporte_id             	-- 0	.id                             		VARCHAR(36)
				, Transporte.numero              AS Transporte_numero         	-- 1	.numero                         		INTEGER
				, Transporte.nombre              AS Transporte_nombre         	-- 2	.nombre                         		VARCHAR(50)
				, Transporte.cuit                AS Transporte_cuit           	-- 3	.cuit                           		BIGINT
				, Transporte.ingresosBrutos      AS Transporte_ingresosBrutos 	-- 4	.ingresosBrutos                 		VARCHAR(13)
				, Transporte.telefono            AS Transporte_telefono       	-- 5	.telefono                       		VARCHAR(50)
				, Transporte.fax                 AS Transporte_fax            	-- 6	.fax                            		VARCHAR(50)
				, CodigoPostal_7.id              AS CodigoPostal_7_id         	-- 7	.CodigoPostal.id                		VARCHAR(36)
				, CodigoPostal_7.codigo          AS CodigoPostal_7_codigo     	-- 8	.CodigoPostal.codigo            		VARCHAR(12)
				, CodigoPostal_7.numero          AS CodigoPostal_7_numero     	-- 9	.CodigoPostal.numero            		INTEGER
				, CodigoPostal_7.nombreCalle     AS CodigoPostal_7_nombreCalle	-- 10	.CodigoPostal.nombreCalle       		VARCHAR(200)
				, CodigoPostal_7.numeroCalle     AS CodigoPostal_7_numeroCalle	-- 11	.CodigoPostal.numeroCalle       		VARCHAR(20)
				, Ciudad_12.id                   AS Ciudad_12_id              	-- 12	.CodigoPostal.Ciudad.id         		VARCHAR(36)
				, Ciudad_12.numero               AS Ciudad_12_numero          	-- 13	.CodigoPostal.Ciudad.numero     		INTEGER
				, Ciudad_12.nombre               AS Ciudad_12_nombre          	-- 14	.CodigoPostal.Ciudad.nombre     		VARCHAR(50)
				, Ciudad_12.departamento         AS Ciudad_12_departamento    	-- 15	.CodigoPostal.Ciudad.departamento		VARCHAR(50)
				, Ciudad_12.numeroAFIP           AS Ciudad_12_numeroAFIP      	-- 16	.CodigoPostal.Ciudad.numeroAFIP 		INTEGER
				, Ciudad_12.provincia            AS Ciudad_12_provincia       	-- 17	.CodigoPostal.Ciudad.provincia  		VARCHAR(36)	Provincia.id
				, Transporte.domicilio           AS Transporte_domicilio      	-- 18	.domicilio                      		VARCHAR(150)
				, Transporte.comentario          AS Transporte_comentario     	-- 19	.comentario                     		VARCHAR(300)

		FROM	massoftware.Transporte
			LEFT JOIN massoftware.CodigoPostal AS CodigoPostal_7        ON Transporte.codigoPostal = CodigoPostal_7.id 	-- 7 LEFT LEVEL: 1
				LEFT JOIN massoftware.Ciudad AS Ciudad_12             ON CodigoPostal_7.ciudad = Ciudad_12.id 	-- 12 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Transporte.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Transporte.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Transporte.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg7)) > 0 THEN
		nombreArg7 = REPLACE(nombreArg7, '''', '''''');
		nombreArg7 = LOWER(TRIM(nombreArg7));
		nombreArg7 = TRANSLATE(nombreArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Transporte.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	IF searchById = false AND orderByArg1 IS NOT NULL AND orderByArg1 > -1 THEN
		sqlSrc = sqlSrc || ' ORDER BY ' || orderByArg1;
	ELSEIF searchById = false THEN 
		sqlSrc = sqlSrc || ' ORDER BY 1 ';
	END IF;

	IF searchById = false AND orderByDescArg2 IS NOT NULL AND orderByDescArg2 = true THEN
		sqlSrc = sqlSrc || ' DESC ';
	END IF;

	IF searchById = false AND limitArg3 IS NOT NULL AND offSetArg4 IS NOT NULL AND limitArg3 > 0 AND limitArg3 <= 100 AND offSetArg4 >= 0 THEN
		sqlSrc = sqlSrc || ' LIMIT ' || limitArg3 || ' OFFSET ' || offSetArg4;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	RETURN QUERY EXECUTE sqlSrc || ';';

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_TransporteById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Transporte_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Transporte_2 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Transporte_2 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_TransporteById_2 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Transporte_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Transporte_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.t_Transporte_3 AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  Transporte.id                         AS Transporte_id                    	-- 0	.id                                               		VARCHAR(36)
				, Transporte.numero                     AS Transporte_numero                	-- 1	.numero                                           		INTEGER
				, Transporte.nombre                     AS Transporte_nombre                	-- 2	.nombre                                           		VARCHAR(50)
				, Transporte.cuit                       AS Transporte_cuit                  	-- 3	.cuit                                             		BIGINT
				, Transporte.ingresosBrutos             AS Transporte_ingresosBrutos        	-- 4	.ingresosBrutos                                   		VARCHAR(13)
				, Transporte.telefono                   AS Transporte_telefono              	-- 5	.telefono                                         		VARCHAR(50)
				, Transporte.fax                        AS Transporte_fax                   	-- 6	.fax                                              		VARCHAR(50)
				, CodigoPostal_7.id                     AS CodigoPostal_7_id                	-- 7	.CodigoPostal.id                                  		VARCHAR(36)
				, CodigoPostal_7.codigo                 AS CodigoPostal_7_codigo            	-- 8	.CodigoPostal.codigo                              		VARCHAR(12)
				, CodigoPostal_7.numero                 AS CodigoPostal_7_numero            	-- 9	.CodigoPostal.numero                              		INTEGER
				, CodigoPostal_7.nombreCalle            AS CodigoPostal_7_nombreCalle       	-- 10	.CodigoPostal.nombreCalle                         		VARCHAR(200)
				, CodigoPostal_7.numeroCalle            AS CodigoPostal_7_numeroCalle       	-- 11	.CodigoPostal.numeroCalle                         		VARCHAR(20)
				, Ciudad_12.id                          AS Ciudad_12_id                     	-- 12	.CodigoPostal.Ciudad.id                           		VARCHAR(36)
				, Ciudad_12.numero                      AS Ciudad_12_numero                 	-- 13	.CodigoPostal.Ciudad.numero                       		INTEGER
				, Ciudad_12.nombre                      AS Ciudad_12_nombre                 	-- 14	.CodigoPostal.Ciudad.nombre                       		VARCHAR(50)
				, Ciudad_12.departamento                AS Ciudad_12_departamento           	-- 15	.CodigoPostal.Ciudad.departamento                 		VARCHAR(50)
				, Ciudad_12.numeroAFIP                  AS Ciudad_12_numeroAFIP             	-- 16	.CodigoPostal.Ciudad.numeroAFIP                   		INTEGER
				, Provincia_17.id                       AS Provincia_17_id                  	-- 17	.CodigoPostal.Ciudad.Provincia.id                 		VARCHAR(36)
				, Provincia_17.numero                   AS Provincia_17_numero              	-- 18	.CodigoPostal.Ciudad.Provincia.numero             		INTEGER
				, Provincia_17.nombre                   AS Provincia_17_nombre              	-- 19	.CodigoPostal.Ciudad.Provincia.nombre             		VARCHAR(50)
				, Provincia_17.abreviatura              AS Provincia_17_abreviatura         	-- 20	.CodigoPostal.Ciudad.Provincia.abreviatura        		VARCHAR(5)
				, Provincia_17.numeroAFIP               AS Provincia_17_numeroAFIP          	-- 21	.CodigoPostal.Ciudad.Provincia.numeroAFIP         		INTEGER
				, Provincia_17.numeroIngresosBrutos     AS Provincia_17_numeroIngresosBrutos	-- 22	.CodigoPostal.Ciudad.Provincia.numeroIngresosBrutos		INTEGER
				, Provincia_17.numeroRENATEA            AS Provincia_17_numeroRENATEA       	-- 23	.CodigoPostal.Ciudad.Provincia.numeroRENATEA      		INTEGER
				, Provincia_17.pais                     AS Provincia_17_pais                	-- 24	.CodigoPostal.Ciudad.Provincia.pais               		VARCHAR(36)	Pais.id
				, Transporte.domicilio                  AS Transporte_domicilio             	-- 25	.domicilio                                        		VARCHAR(150)
				, Transporte.comentario                 AS Transporte_comentario            	-- 26	.comentario                                       		VARCHAR(300)

		FROM	massoftware.Transporte
			LEFT JOIN massoftware.CodigoPostal AS CodigoPostal_7            ON Transporte.codigoPostal = CodigoPostal_7.id 	-- 7 LEFT LEVEL: 1
				LEFT JOIN massoftware.Ciudad AS Ciudad_12                 ON CodigoPostal_7.ciudad = Ciudad_12.id 	-- 12 LEFT LEVEL: 2
					LEFT JOIN massoftware.Provincia AS Provincia_17             ON Ciudad_12.provincia = Provincia_17.id 	-- 17 LEFT LEVEL: 3

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Transporte.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Transporte.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Transporte.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg7)) > 0 THEN
		nombreArg7 = REPLACE(nombreArg7, '''', '''''');
		nombreArg7 = LOWER(TRIM(nombreArg7));
		nombreArg7 = TRANSLATE(nombreArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Transporte.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	IF searchById = false AND orderByArg1 IS NOT NULL AND orderByArg1 > -1 THEN
		sqlSrc = sqlSrc || ' ORDER BY ' || orderByArg1;
	ELSEIF searchById = false THEN 
		sqlSrc = sqlSrc || ' ORDER BY 1 ';
	END IF;

	IF searchById = false AND orderByDescArg2 IS NOT NULL AND orderByDescArg2 = true THEN
		sqlSrc = sqlSrc || ' DESC ';
	END IF;

	IF searchById = false AND limitArg3 IS NOT NULL AND offSetArg4 IS NOT NULL AND limitArg3 > 0 AND limitArg3 <= 100 AND offSetArg4 >= 0 THEN
		sqlSrc = sqlSrc || ' LIMIT ' || limitArg3 || ' OFFSET ' || offSetArg4;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	RETURN QUERY EXECUTE sqlSrc || ';';

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_TransporteById_3 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteById_3 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Transporte_3 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Transporte_3 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Transporte_3 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_TransporteById_3 ('xxx'); 