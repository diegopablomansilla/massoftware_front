
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


DROP FUNCTION IF EXISTS massoftware.f_exists_Carga_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Carga_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Carga
	WHERE	(numeroArg IS NULL OR Carga.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Carga_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Carga_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Carga_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Carga
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Carga.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Carga_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Carga_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Carga_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Carga;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Carga_numero();

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
		, null::VARCHAR(50)
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
		, null::VARCHAR(50)
		, null::VARCHAR(36)
);

*/

DROP TYPE IF EXISTS massoftware.t_Carga_1 CASCADE;

CREATE TYPE massoftware.t_Carga_1 AS (

	  Carga_id                   	VARCHAR(36) 		-- 0	Carga.id
	, Carga_numero               	INTEGER     		-- 1	Carga.numero
	, Carga_nombre               	VARCHAR(50) 		-- 2	Carga.nombre
	, Transporte_3_id            	VARCHAR(36) 		-- 3	Carga.Transporte.id
	, Transporte_3_numero        	INTEGER     		-- 4	Carga.Transporte.numero
	, Transporte_3_nombre        	VARCHAR(50) 		-- 5	Carga.Transporte.nombre
	, Transporte_3_cuit          	BIGINT      		-- 6	Carga.Transporte.cuit
	, Transporte_3_ingresosBrutos	VARCHAR(13) 		-- 7	Carga.Transporte.ingresosBrutos
	, Transporte_3_telefono      	VARCHAR(50) 		-- 8	Carga.Transporte.telefono
	, Transporte_3_fax           	VARCHAR(50) 		-- 9	Carga.Transporte.fax
	, Transporte_3_codigoPostal  	VARCHAR(36) 		-- 10	Carga.Transporte.codigoPostal
	, Transporte_3_domicilio     	VARCHAR(150)		-- 11	Carga.Transporte.domicilio
	, Transporte_3_comentario    	VARCHAR(300)		-- 12	Carga.Transporte.comentario

);

DROP TYPE IF EXISTS massoftware.t_Carga_2 CASCADE;

CREATE TYPE massoftware.t_Carga_2 AS (

	  Carga_id                   	VARCHAR(36) 		-- 0	Carga.id
	, Carga_numero               	INTEGER     		-- 1	Carga.numero
	, Carga_nombre               	VARCHAR(50) 		-- 2	Carga.nombre
	, Transporte_3_id            	VARCHAR(36) 		-- 3	Carga.Transporte.id
	, Transporte_3_numero        	INTEGER     		-- 4	Carga.Transporte.numero
	, Transporte_3_nombre        	VARCHAR(50) 		-- 5	Carga.Transporte.nombre
	, Transporte_3_cuit          	BIGINT      		-- 6	Carga.Transporte.cuit
	, Transporte_3_ingresosBrutos	VARCHAR(13) 		-- 7	Carga.Transporte.ingresosBrutos
	, Transporte_3_telefono      	VARCHAR(50) 		-- 8	Carga.Transporte.telefono
	, Transporte_3_fax           	VARCHAR(50) 		-- 9	Carga.Transporte.fax
	, CodigoPostal_10_id         	VARCHAR(36) 		-- 10	Carga.Transporte.CodigoPostal.id
	, CodigoPostal_10_codigo     	VARCHAR(12) 		-- 11	Carga.Transporte.CodigoPostal.codigo
	, CodigoPostal_10_numero     	INTEGER     		-- 12	Carga.Transporte.CodigoPostal.numero
	, CodigoPostal_10_nombreCalle	VARCHAR(200)		-- 13	Carga.Transporte.CodigoPostal.nombreCalle
	, CodigoPostal_10_numeroCalle	VARCHAR(20) 		-- 14	Carga.Transporte.CodigoPostal.numeroCalle
	, CodigoPostal_10_ciudad     	VARCHAR(36) 		-- 15	Carga.Transporte.CodigoPostal.ciudad
	, Transporte_3_domicilio     	VARCHAR(150)		-- 16	Carga.Transporte.domicilio
	, Transporte_3_comentario    	VARCHAR(300)		-- 17	Carga.Transporte.comentario

);

DROP TYPE IF EXISTS massoftware.t_Carga_3 CASCADE;

CREATE TYPE massoftware.t_Carga_3 AS (

	  Carga_id                   	VARCHAR(36) 		-- 0	Carga.id
	, Carga_numero               	INTEGER     		-- 1	Carga.numero
	, Carga_nombre               	VARCHAR(50) 		-- 2	Carga.nombre
	, Transporte_3_id            	VARCHAR(36) 		-- 3	Carga.Transporte.id
	, Transporte_3_numero        	INTEGER     		-- 4	Carga.Transporte.numero
	, Transporte_3_nombre        	VARCHAR(50) 		-- 5	Carga.Transporte.nombre
	, Transporte_3_cuit          	BIGINT      		-- 6	Carga.Transporte.cuit
	, Transporte_3_ingresosBrutos	VARCHAR(13) 		-- 7	Carga.Transporte.ingresosBrutos
	, Transporte_3_telefono      	VARCHAR(50) 		-- 8	Carga.Transporte.telefono
	, Transporte_3_fax           	VARCHAR(50) 		-- 9	Carga.Transporte.fax
	, CodigoPostal_10_id         	VARCHAR(36) 		-- 10	Carga.Transporte.CodigoPostal.id
	, CodigoPostal_10_codigo     	VARCHAR(12) 		-- 11	Carga.Transporte.CodigoPostal.codigo
	, CodigoPostal_10_numero     	INTEGER     		-- 12	Carga.Transporte.CodigoPostal.numero
	, CodigoPostal_10_nombreCalle	VARCHAR(200)		-- 13	Carga.Transporte.CodigoPostal.nombreCalle
	, CodigoPostal_10_numeroCalle	VARCHAR(20) 		-- 14	Carga.Transporte.CodigoPostal.numeroCalle
	, Ciudad_15_id               	VARCHAR(36) 		-- 15	Carga.Transporte.CodigoPostal.Ciudad.id
	, Ciudad_15_numero           	INTEGER     		-- 16	Carga.Transporte.CodigoPostal.Ciudad.numero
	, Ciudad_15_nombre           	VARCHAR(50) 		-- 17	Carga.Transporte.CodigoPostal.Ciudad.nombre
	, Ciudad_15_departamento     	VARCHAR(50) 		-- 18	Carga.Transporte.CodigoPostal.Ciudad.departamento
	, Ciudad_15_numeroAFIP       	INTEGER     		-- 19	Carga.Transporte.CodigoPostal.Ciudad.numeroAFIP
	, Ciudad_15_provincia        	VARCHAR(36) 		-- 20	Carga.Transporte.CodigoPostal.Ciudad.provincia
	, Transporte_3_domicilio     	VARCHAR(150)		-- 21	Carga.Transporte.domicilio
	, Transporte_3_comentario    	VARCHAR(300)		-- 22	Carga.Transporte.comentario

);

DROP FUNCTION IF EXISTS massoftware.f_Carga (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.Carga AS $$

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
				  Carga.id            AS Carga_id        	-- 0	.id       		VARCHAR(36)
				, Carga.numero        AS Carga_numero    	-- 1	.numero   		INTEGER
				, Carga.nombre        AS Carga_nombre    	-- 2	.nombre   		VARCHAR(50)
				, Carga.transporte    AS Carga_transporte	-- 3	.transporte		VARCHAR(36)	Transporte.id

		FROM	massoftware.Carga

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Carga.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Carga.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Carga.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Carga.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_CargaById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CargaById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Carga AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Carga ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Carga ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CargaById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Carga_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.t_Carga_1 AS $$

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
				  Carga.id                       AS Carga_id                   	-- 0	.id                      		VARCHAR(36)
				, Carga.numero                   AS Carga_numero               	-- 1	.numero                  		INTEGER
				, Carga.nombre                   AS Carga_nombre               	-- 2	.nombre                  		VARCHAR(50)
				, Transporte_3.id                AS Transporte_3_id            	-- 3	.Transporte.id           		VARCHAR(36)
				, Transporte_3.numero            AS Transporte_3_numero        	-- 4	.Transporte.numero       		INTEGER
				, Transporte_3.nombre            AS Transporte_3_nombre        	-- 5	.Transporte.nombre       		VARCHAR(50)
				, Transporte_3.cuit              AS Transporte_3_cuit          	-- 6	.Transporte.cuit         		BIGINT
				, Transporte_3.ingresosBrutos    AS Transporte_3_ingresosBrutos	-- 7	.Transporte.ingresosBrutos		VARCHAR(13)
				, Transporte_3.telefono          AS Transporte_3_telefono      	-- 8	.Transporte.telefono     		VARCHAR(50)
				, Transporte_3.fax               AS Transporte_3_fax           	-- 9	.Transporte.fax          		VARCHAR(50)
				, Transporte_3.codigoPostal      AS Transporte_3_codigoPostal  	-- 10	.Transporte.codigoPostal 		VARCHAR(36)	CodigoPostal.id
				, Transporte_3.domicilio         AS Transporte_3_domicilio     	-- 11	.Transporte.domicilio    		VARCHAR(150)
				, Transporte_3.comentario        AS Transporte_3_comentario    	-- 12	.Transporte.comentario   		VARCHAR(300)

		FROM	massoftware.Carga
			LEFT JOIN massoftware.Transporte AS Transporte_3        ON Carga.transporte = Transporte_3.id 	-- 3 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Carga.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Carga.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Carga.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Carga.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_CargaById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CargaById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Carga_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Carga_1 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Carga_1 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CargaById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Carga_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.t_Carga_2 AS $$

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
				  Carga.id                        AS Carga_id                   	-- 0	.id                                		VARCHAR(36)
				, Carga.numero                    AS Carga_numero               	-- 1	.numero                            		INTEGER
				, Carga.nombre                    AS Carga_nombre               	-- 2	.nombre                            		VARCHAR(50)
				, Transporte_3.id                 AS Transporte_3_id            	-- 3	.Transporte.id                     		VARCHAR(36)
				, Transporte_3.numero             AS Transporte_3_numero        	-- 4	.Transporte.numero                 		INTEGER
				, Transporte_3.nombre             AS Transporte_3_nombre        	-- 5	.Transporte.nombre                 		VARCHAR(50)
				, Transporte_3.cuit               AS Transporte_3_cuit          	-- 6	.Transporte.cuit                   		BIGINT
				, Transporte_3.ingresosBrutos     AS Transporte_3_ingresosBrutos	-- 7	.Transporte.ingresosBrutos         		VARCHAR(13)
				, Transporte_3.telefono           AS Transporte_3_telefono      	-- 8	.Transporte.telefono               		VARCHAR(50)
				, Transporte_3.fax                AS Transporte_3_fax           	-- 9	.Transporte.fax                    		VARCHAR(50)
				, CodigoPostal_10.id              AS CodigoPostal_10_id         	-- 10	.Transporte.CodigoPostal.id        		VARCHAR(36)
				, CodigoPostal_10.codigo          AS CodigoPostal_10_codigo     	-- 11	.Transporte.CodigoPostal.codigo    		VARCHAR(12)
				, CodigoPostal_10.numero          AS CodigoPostal_10_numero     	-- 12	.Transporte.CodigoPostal.numero    		INTEGER
				, CodigoPostal_10.nombreCalle     AS CodigoPostal_10_nombreCalle	-- 13	.Transporte.CodigoPostal.nombreCalle		VARCHAR(200)
				, CodigoPostal_10.numeroCalle     AS CodigoPostal_10_numeroCalle	-- 14	.Transporte.CodigoPostal.numeroCalle		VARCHAR(20)
				, CodigoPostal_10.ciudad          AS CodigoPostal_10_ciudad     	-- 15	.Transporte.CodigoPostal.ciudad    		VARCHAR(36)	Ciudad.id
				, Transporte_3.domicilio          AS Transporte_3_domicilio     	-- 16	.Transporte.domicilio              		VARCHAR(150)
				, Transporte_3.comentario         AS Transporte_3_comentario    	-- 17	.Transporte.comentario             		VARCHAR(300)

		FROM	massoftware.Carga
			LEFT JOIN massoftware.Transporte AS Transporte_3              ON Carga.transporte = Transporte_3.id 	-- 3 LEFT LEVEL: 1
				LEFT JOIN massoftware.CodigoPostal AS CodigoPostal_10           ON Transporte_3.codigoPostal = CodigoPostal_10.id 	-- 10 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Carga.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Carga.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Carga.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Carga.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_CargaById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CargaById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Carga_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Carga_2 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Carga_2 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CargaById_2 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Carga_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Carga_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.t_Carga_3 AS $$

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
				  Carga.id                        AS Carga_id                   	-- 0	.id                                        		VARCHAR(36)
				, Carga.numero                    AS Carga_numero               	-- 1	.numero                                    		INTEGER
				, Carga.nombre                    AS Carga_nombre               	-- 2	.nombre                                    		VARCHAR(50)
				, Transporte_3.id                 AS Transporte_3_id            	-- 3	.Transporte.id                             		VARCHAR(36)
				, Transporte_3.numero             AS Transporte_3_numero        	-- 4	.Transporte.numero                         		INTEGER
				, Transporte_3.nombre             AS Transporte_3_nombre        	-- 5	.Transporte.nombre                         		VARCHAR(50)
				, Transporte_3.cuit               AS Transporte_3_cuit          	-- 6	.Transporte.cuit                           		BIGINT
				, Transporte_3.ingresosBrutos     AS Transporte_3_ingresosBrutos	-- 7	.Transporte.ingresosBrutos                 		VARCHAR(13)
				, Transporte_3.telefono           AS Transporte_3_telefono      	-- 8	.Transporte.telefono                       		VARCHAR(50)
				, Transporte_3.fax                AS Transporte_3_fax           	-- 9	.Transporte.fax                            		VARCHAR(50)
				, CodigoPostal_10.id              AS CodigoPostal_10_id         	-- 10	.Transporte.CodigoPostal.id                		VARCHAR(36)
				, CodigoPostal_10.codigo          AS CodigoPostal_10_codigo     	-- 11	.Transporte.CodigoPostal.codigo            		VARCHAR(12)
				, CodigoPostal_10.numero          AS CodigoPostal_10_numero     	-- 12	.Transporte.CodigoPostal.numero            		INTEGER
				, CodigoPostal_10.nombreCalle     AS CodigoPostal_10_nombreCalle	-- 13	.Transporte.CodigoPostal.nombreCalle       		VARCHAR(200)
				, CodigoPostal_10.numeroCalle     AS CodigoPostal_10_numeroCalle	-- 14	.Transporte.CodigoPostal.numeroCalle       		VARCHAR(20)
				, Ciudad_15.id                    AS Ciudad_15_id               	-- 15	.Transporte.CodigoPostal.Ciudad.id         		VARCHAR(36)
				, Ciudad_15.numero                AS Ciudad_15_numero           	-- 16	.Transporte.CodigoPostal.Ciudad.numero     		INTEGER
				, Ciudad_15.nombre                AS Ciudad_15_nombre           	-- 17	.Transporte.CodigoPostal.Ciudad.nombre     		VARCHAR(50)
				, Ciudad_15.departamento          AS Ciudad_15_departamento     	-- 18	.Transporte.CodigoPostal.Ciudad.departamento		VARCHAR(50)
				, Ciudad_15.numeroAFIP            AS Ciudad_15_numeroAFIP       	-- 19	.Transporte.CodigoPostal.Ciudad.numeroAFIP 		INTEGER
				, Ciudad_15.provincia             AS Ciudad_15_provincia        	-- 20	.Transporte.CodigoPostal.Ciudad.provincia  		VARCHAR(36)	Provincia.id
				, Transporte_3.domicilio          AS Transporte_3_domicilio     	-- 21	.Transporte.domicilio                      		VARCHAR(150)
				, Transporte_3.comentario         AS Transporte_3_comentario    	-- 22	.Transporte.comentario                     		VARCHAR(300)

		FROM	massoftware.Carga
			LEFT JOIN massoftware.Transporte AS Transporte_3              ON Carga.transporte = Transporte_3.id 	-- 3 LEFT LEVEL: 1
				LEFT JOIN massoftware.CodigoPostal AS CodigoPostal_10           ON Transporte_3.codigoPostal = CodigoPostal_10.id 	-- 10 LEFT LEVEL: 2
					LEFT JOIN massoftware.Ciudad AS Ciudad_15                ON CodigoPostal_10.ciudad = Ciudad_15.id 	-- 15 LEFT LEVEL: 3

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Carga.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Carga.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Carga.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Carga.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_CargaById_3 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CargaById_3 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Carga_3 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Carga_3 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Carga_3 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CargaById_3 ('xxx'); 