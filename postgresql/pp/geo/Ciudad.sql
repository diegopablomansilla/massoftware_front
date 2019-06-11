
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


DROP FUNCTION IF EXISTS massoftware.f_exists_Ciudad_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Ciudad_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Ciudad
	WHERE	(numeroArg IS NULL OR Ciudad.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Ciudad_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Ciudad_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Ciudad_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Ciudad
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Ciudad.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Ciudad_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Ciudad_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Ciudad_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Ciudad;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Ciudad_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Ciudad_numeroAFIP() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Ciudad_numeroAFIP() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numeroAFIP),0) + 1)::INTEGER FROM massoftware.Ciudad;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Ciudad_numeroAFIP();

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
		, null::VARCHAR(50)
		, null::VARCHAR(50)
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
		, null::VARCHAR(50)
		, null::VARCHAR(50)
		, null::INTEGER
		, null::VARCHAR(36)
);

*/

DROP TYPE IF EXISTS massoftware.t_Ciudad_1 CASCADE;

CREATE TYPE massoftware.t_Ciudad_1 AS (

	  Ciudad_id                       	VARCHAR(36)		-- 0	Ciudad.id
	, Ciudad_numero                   	INTEGER    		-- 1	Ciudad.numero
	, Ciudad_nombre                   	VARCHAR(50)		-- 2	Ciudad.nombre
	, Ciudad_departamento             	VARCHAR(50)		-- 3	Ciudad.departamento
	, Ciudad_numeroAFIP               	INTEGER    		-- 4	Ciudad.numeroAFIP
	, Provincia_5_id                  	VARCHAR(36)		-- 5	Ciudad.Provincia.id
	, Provincia_5_numero              	INTEGER    		-- 6	Ciudad.Provincia.numero
	, Provincia_5_nombre              	VARCHAR(50)		-- 7	Ciudad.Provincia.nombre
	, Provincia_5_abreviatura         	VARCHAR(5) 		-- 8	Ciudad.Provincia.abreviatura
	, Provincia_5_numeroAFIP          	INTEGER    		-- 9	Ciudad.Provincia.numeroAFIP
	, Provincia_5_numeroIngresosBrutos	INTEGER    		-- 10	Ciudad.Provincia.numeroIngresosBrutos
	, Provincia_5_numeroRENATEA       	INTEGER    		-- 11	Ciudad.Provincia.numeroRENATEA
	, Provincia_5_pais                	VARCHAR(36)		-- 12	Ciudad.Provincia.pais

);

DROP TYPE IF EXISTS massoftware.t_Ciudad_2 CASCADE;

CREATE TYPE massoftware.t_Ciudad_2 AS (

	  Ciudad_id                       	VARCHAR(36)		-- 0	Ciudad.id
	, Ciudad_numero                   	INTEGER    		-- 1	Ciudad.numero
	, Ciudad_nombre                   	VARCHAR(50)		-- 2	Ciudad.nombre
	, Ciudad_departamento             	VARCHAR(50)		-- 3	Ciudad.departamento
	, Ciudad_numeroAFIP               	INTEGER    		-- 4	Ciudad.numeroAFIP
	, Provincia_5_id                  	VARCHAR(36)		-- 5	Ciudad.Provincia.id
	, Provincia_5_numero              	INTEGER    		-- 6	Ciudad.Provincia.numero
	, Provincia_5_nombre              	VARCHAR(50)		-- 7	Ciudad.Provincia.nombre
	, Provincia_5_abreviatura         	VARCHAR(5) 		-- 8	Ciudad.Provincia.abreviatura
	, Provincia_5_numeroAFIP          	INTEGER    		-- 9	Ciudad.Provincia.numeroAFIP
	, Provincia_5_numeroIngresosBrutos	INTEGER    		-- 10	Ciudad.Provincia.numeroIngresosBrutos
	, Provincia_5_numeroRENATEA       	INTEGER    		-- 11	Ciudad.Provincia.numeroRENATEA
	, Pais_12_id                      	VARCHAR(36)		-- 12	Ciudad.Provincia.Pais.id
	, Pais_12_numero                  	INTEGER    		-- 13	Ciudad.Provincia.Pais.numero
	, Pais_12_nombre                  	VARCHAR(50)		-- 14	Ciudad.Provincia.Pais.nombre
	, Pais_12_abreviatura             	VARCHAR(5) 		-- 15	Ciudad.Provincia.Pais.abreviatura

);

DROP FUNCTION IF EXISTS massoftware.f_Ciudad (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, provinciaArg8     VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, provinciaArg8     VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.Ciudad AS $$

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
				  Ciudad.id              AS Ciudad_id          	-- 0	.id         		VARCHAR(36)
				, Ciudad.numero          AS Ciudad_numero      	-- 1	.numero     		INTEGER
				, Ciudad.nombre          AS Ciudad_nombre      	-- 2	.nombre     		VARCHAR(50)
				, Ciudad.departamento    AS Ciudad_departamento	-- 3	.departamento		VARCHAR(50)
				, Ciudad.numeroAFIP      AS Ciudad_numeroAFIP  	-- 4	.numeroAFIP 		INTEGER
				, Ciudad.provincia       AS Ciudad_provincia   	-- 5	.provincia  		VARCHAR(36)	Provincia.id

		FROM	massoftware.Ciudad

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Ciudad.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Ciudad.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Ciudad.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Ciudad.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND provinciaArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(provinciaArg8)) > 0 THEN
		provinciaArg8 = REPLACE(provinciaArg8, '''', '''''');
		provinciaArg8 = LOWER(TRIM(provinciaArg8));
		provinciaArg8 = TRANSLATE(provinciaArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(provinciaArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Ciudad.provincia),
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

DROP FUNCTION IF EXISTS massoftware.f_CiudadById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CiudadById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Ciudad AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Ciudad ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Ciudad ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CiudadById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Ciudad_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, provinciaArg8     VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, provinciaArg8     VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_Ciudad_1 AS $$

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
				  Ciudad.id                            AS Ciudad_id                       	-- 0	.id                           		VARCHAR(36)
				, Ciudad.numero                        AS Ciudad_numero                   	-- 1	.numero                       		INTEGER
				, Ciudad.nombre                        AS Ciudad_nombre                   	-- 2	.nombre                       		VARCHAR(50)
				, Ciudad.departamento                  AS Ciudad_departamento             	-- 3	.departamento                 		VARCHAR(50)
				, Ciudad.numeroAFIP                    AS Ciudad_numeroAFIP               	-- 4	.numeroAFIP                   		INTEGER
				, Provincia_5.id                       AS Provincia_5_id                  	-- 5	.Provincia.id                 		VARCHAR(36)
				, Provincia_5.numero                   AS Provincia_5_numero              	-- 6	.Provincia.numero             		INTEGER
				, Provincia_5.nombre                   AS Provincia_5_nombre              	-- 7	.Provincia.nombre             		VARCHAR(50)
				, Provincia_5.abreviatura              AS Provincia_5_abreviatura         	-- 8	.Provincia.abreviatura        		VARCHAR(5)
				, Provincia_5.numeroAFIP               AS Provincia_5_numeroAFIP          	-- 9	.Provincia.numeroAFIP         		INTEGER
				, Provincia_5.numeroIngresosBrutos     AS Provincia_5_numeroIngresosBrutos	-- 10	.Provincia.numeroIngresosBrutos		INTEGER
				, Provincia_5.numeroRENATEA            AS Provincia_5_numeroRENATEA       	-- 11	.Provincia.numeroRENATEA      		INTEGER
				, Provincia_5.pais                     AS Provincia_5_pais                	-- 12	.Provincia.pais               		VARCHAR(36)	Pais.id

		FROM	massoftware.Ciudad
			LEFT JOIN massoftware.Provincia AS Provincia_5        ON Ciudad.provincia = Provincia_5.id 	-- 5 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Ciudad.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Ciudad.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Ciudad.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Ciudad.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND provinciaArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(provinciaArg8)) > 0 THEN
		provinciaArg8 = REPLACE(provinciaArg8, '''', '''''');
		provinciaArg8 = LOWER(TRIM(provinciaArg8));
		provinciaArg8 = TRANSLATE(provinciaArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(provinciaArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Ciudad.provincia),
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

DROP FUNCTION IF EXISTS massoftware.f_CiudadById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CiudadById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Ciudad_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Ciudad_1 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Ciudad_1 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CiudadById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Ciudad_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, provinciaArg8     VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ciudad_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, provinciaArg8     VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_Ciudad_2 AS $$

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
				  Ciudad.id                            AS Ciudad_id                       	-- 0	.id                           		VARCHAR(36)
				, Ciudad.numero                        AS Ciudad_numero                   	-- 1	.numero                       		INTEGER
				, Ciudad.nombre                        AS Ciudad_nombre                   	-- 2	.nombre                       		VARCHAR(50)
				, Ciudad.departamento                  AS Ciudad_departamento             	-- 3	.departamento                 		VARCHAR(50)
				, Ciudad.numeroAFIP                    AS Ciudad_numeroAFIP               	-- 4	.numeroAFIP                   		INTEGER
				, Provincia_5.id                       AS Provincia_5_id                  	-- 5	.Provincia.id                 		VARCHAR(36)
				, Provincia_5.numero                   AS Provincia_5_numero              	-- 6	.Provincia.numero             		INTEGER
				, Provincia_5.nombre                   AS Provincia_5_nombre              	-- 7	.Provincia.nombre             		VARCHAR(50)
				, Provincia_5.abreviatura              AS Provincia_5_abreviatura         	-- 8	.Provincia.abreviatura        		VARCHAR(5)
				, Provincia_5.numeroAFIP               AS Provincia_5_numeroAFIP          	-- 9	.Provincia.numeroAFIP         		INTEGER
				, Provincia_5.numeroIngresosBrutos     AS Provincia_5_numeroIngresosBrutos	-- 10	.Provincia.numeroIngresosBrutos		INTEGER
				, Provincia_5.numeroRENATEA            AS Provincia_5_numeroRENATEA       	-- 11	.Provincia.numeroRENATEA      		INTEGER
				, Pais_12.id                           AS Pais_12_id                      	-- 12	.Provincia.Pais.id            		VARCHAR(36)
				, Pais_12.numero                       AS Pais_12_numero                  	-- 13	.Provincia.Pais.numero        		INTEGER
				, Pais_12.nombre                       AS Pais_12_nombre                  	-- 14	.Provincia.Pais.nombre        		VARCHAR(50)
				, Pais_12.abreviatura                  AS Pais_12_abreviatura             	-- 15	.Provincia.Pais.abreviatura   		VARCHAR(5)

		FROM	massoftware.Ciudad
			LEFT JOIN massoftware.Provincia AS Provincia_5        ON Ciudad.provincia = Provincia_5.id 	-- 5 LEFT LEVEL: 1
				LEFT JOIN massoftware.Pais AS Pais_12            ON Provincia_5.pais = Pais_12.id 	-- 12 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Ciudad.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Ciudad.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Ciudad.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Ciudad.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND provinciaArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(provinciaArg8)) > 0 THEN
		provinciaArg8 = REPLACE(provinciaArg8, '''', '''''');
		provinciaArg8 = LOWER(TRIM(provinciaArg8));
		provinciaArg8 = TRANSLATE(provinciaArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(provinciaArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Ciudad.provincia),
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

DROP FUNCTION IF EXISTS massoftware.f_CiudadById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CiudadById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Ciudad_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Ciudad_2 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Ciudad_2 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CiudadById_2 ('xxx'); 