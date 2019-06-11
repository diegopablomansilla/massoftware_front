
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


DROP FUNCTION IF EXISTS massoftware.f_exists_CodigoPostal_codigo(codigoArg VARCHAR(12)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_CodigoPostal_codigo(codigoArg VARCHAR(12)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.CodigoPostal
	WHERE	(codigoArg IS NULL OR (CHAR_LENGTH(TRIM(codigoArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(CodigoPostal.codigo)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(codigoArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_CodigoPostal_codigo(null::VARCHAR(12));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_CodigoPostal_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_CodigoPostal_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.CodigoPostal
	WHERE	(numeroArg IS NULL OR CodigoPostal.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_CodigoPostal_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CodigoPostal_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CodigoPostal_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.CodigoPostal;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CodigoPostal_numero();

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
		, null::VARCHAR(12)
		, null::INTEGER
		, null::VARCHAR(200)
		, null::VARCHAR(20)
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
		, null::VARCHAR(12)
		, null::INTEGER
		, null::VARCHAR(200)
		, null::VARCHAR(20)
		, null::VARCHAR(36)
);

*/

DROP TYPE IF EXISTS massoftware.t_CodigoPostal_1 CASCADE;

CREATE TYPE massoftware.t_CodigoPostal_1 AS (

	  CodigoPostal_id         	VARCHAR(36) 		-- 0	CodigoPostal.id
	, CodigoPostal_codigo     	VARCHAR(12) 		-- 1	CodigoPostal.codigo
	, CodigoPostal_numero     	INTEGER     		-- 2	CodigoPostal.numero
	, CodigoPostal_nombreCalle	VARCHAR(200)		-- 3	CodigoPostal.nombreCalle
	, CodigoPostal_numeroCalle	VARCHAR(20) 		-- 4	CodigoPostal.numeroCalle
	, Ciudad_5_id             	VARCHAR(36) 		-- 5	CodigoPostal.Ciudad.id
	, Ciudad_5_numero         	INTEGER     		-- 6	CodigoPostal.Ciudad.numero
	, Ciudad_5_nombre         	VARCHAR(50) 		-- 7	CodigoPostal.Ciudad.nombre
	, Ciudad_5_departamento   	VARCHAR(50) 		-- 8	CodigoPostal.Ciudad.departamento
	, Ciudad_5_numeroAFIP     	INTEGER     		-- 9	CodigoPostal.Ciudad.numeroAFIP
	, Ciudad_5_provincia      	VARCHAR(36) 		-- 10	CodigoPostal.Ciudad.provincia

);

DROP TYPE IF EXISTS massoftware.t_CodigoPostal_2 CASCADE;

CREATE TYPE massoftware.t_CodigoPostal_2 AS (

	  CodigoPostal_id                  	VARCHAR(36) 		-- 0	CodigoPostal.id
	, CodigoPostal_codigo              	VARCHAR(12) 		-- 1	CodigoPostal.codigo
	, CodigoPostal_numero              	INTEGER     		-- 2	CodigoPostal.numero
	, CodigoPostal_nombreCalle         	VARCHAR(200)		-- 3	CodigoPostal.nombreCalle
	, CodigoPostal_numeroCalle         	VARCHAR(20) 		-- 4	CodigoPostal.numeroCalle
	, Ciudad_5_id                      	VARCHAR(36) 		-- 5	CodigoPostal.Ciudad.id
	, Ciudad_5_numero                  	INTEGER     		-- 6	CodigoPostal.Ciudad.numero
	, Ciudad_5_nombre                  	VARCHAR(50) 		-- 7	CodigoPostal.Ciudad.nombre
	, Ciudad_5_departamento            	VARCHAR(50) 		-- 8	CodigoPostal.Ciudad.departamento
	, Ciudad_5_numeroAFIP              	INTEGER     		-- 9	CodigoPostal.Ciudad.numeroAFIP
	, Provincia_10_id                  	VARCHAR(36) 		-- 10	CodigoPostal.Ciudad.Provincia.id
	, Provincia_10_numero              	INTEGER     		-- 11	CodigoPostal.Ciudad.Provincia.numero
	, Provincia_10_nombre              	VARCHAR(50) 		-- 12	CodigoPostal.Ciudad.Provincia.nombre
	, Provincia_10_abreviatura         	VARCHAR(5)  		-- 13	CodigoPostal.Ciudad.Provincia.abreviatura
	, Provincia_10_numeroAFIP          	INTEGER     		-- 14	CodigoPostal.Ciudad.Provincia.numeroAFIP
	, Provincia_10_numeroIngresosBrutos	INTEGER     		-- 15	CodigoPostal.Ciudad.Provincia.numeroIngresosBrutos
	, Provincia_10_numeroRENATEA       	INTEGER     		-- 16	CodigoPostal.Ciudad.Provincia.numeroRENATEA
	, Provincia_10_pais                	VARCHAR(36) 		-- 17	CodigoPostal.Ciudad.Provincia.pais

);

DROP TYPE IF EXISTS massoftware.t_CodigoPostal_3 CASCADE;

CREATE TYPE massoftware.t_CodigoPostal_3 AS (

	  CodigoPostal_id                  	VARCHAR(36) 		-- 0	CodigoPostal.id
	, CodigoPostal_codigo              	VARCHAR(12) 		-- 1	CodigoPostal.codigo
	, CodigoPostal_numero              	INTEGER     		-- 2	CodigoPostal.numero
	, CodigoPostal_nombreCalle         	VARCHAR(200)		-- 3	CodigoPostal.nombreCalle
	, CodigoPostal_numeroCalle         	VARCHAR(20) 		-- 4	CodigoPostal.numeroCalle
	, Ciudad_5_id                      	VARCHAR(36) 		-- 5	CodigoPostal.Ciudad.id
	, Ciudad_5_numero                  	INTEGER     		-- 6	CodigoPostal.Ciudad.numero
	, Ciudad_5_nombre                  	VARCHAR(50) 		-- 7	CodigoPostal.Ciudad.nombre
	, Ciudad_5_departamento            	VARCHAR(50) 		-- 8	CodigoPostal.Ciudad.departamento
	, Ciudad_5_numeroAFIP              	INTEGER     		-- 9	CodigoPostal.Ciudad.numeroAFIP
	, Provincia_10_id                  	VARCHAR(36) 		-- 10	CodigoPostal.Ciudad.Provincia.id
	, Provincia_10_numero              	INTEGER     		-- 11	CodigoPostal.Ciudad.Provincia.numero
	, Provincia_10_nombre              	VARCHAR(50) 		-- 12	CodigoPostal.Ciudad.Provincia.nombre
	, Provincia_10_abreviatura         	VARCHAR(5)  		-- 13	CodigoPostal.Ciudad.Provincia.abreviatura
	, Provincia_10_numeroAFIP          	INTEGER     		-- 14	CodigoPostal.Ciudad.Provincia.numeroAFIP
	, Provincia_10_numeroIngresosBrutos	INTEGER     		-- 15	CodigoPostal.Ciudad.Provincia.numeroIngresosBrutos
	, Provincia_10_numeroRENATEA       	INTEGER     		-- 16	CodigoPostal.Ciudad.Provincia.numeroRENATEA
	, Pais_17_id                       	VARCHAR(36) 		-- 17	CodigoPostal.Ciudad.Provincia.Pais.id
	, Pais_17_numero                   	INTEGER     		-- 18	CodigoPostal.Ciudad.Provincia.Pais.numero
	, Pais_17_nombre                   	VARCHAR(50) 		-- 19	CodigoPostal.Ciudad.Provincia.Pais.nombre
	, Pais_17_abreviatura              	VARCHAR(5)  		-- 20	CodigoPostal.Ciudad.Provincia.Pais.abreviatura

);

DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, codigoArg5        VARCHAR(12)	-- 5
	, numeroFromArg6    INTEGER    	-- 6
	, numeroToArg7      INTEGER    	-- 7
	, ciudadArg8        VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, codigoArg5        VARCHAR(12)	-- 5
	, numeroFromArg6    INTEGER    	-- 6
	, numeroToArg7      INTEGER    	-- 7
	, ciudadArg8        VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.CodigoPostal AS $$

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
				  CodigoPostal.id             AS CodigoPostal_id         	-- 0	.id        		VARCHAR(36)
				, CodigoPostal.codigo         AS CodigoPostal_codigo     	-- 1	.codigo    		VARCHAR(12)
				, CodigoPostal.numero         AS CodigoPostal_numero     	-- 2	.numero    		INTEGER
				, CodigoPostal.nombreCalle    AS CodigoPostal_nombreCalle	-- 3	.nombreCalle		VARCHAR(200)
				, CodigoPostal.numeroCalle    AS CodigoPostal_numeroCalle	-- 4	.numeroCalle		VARCHAR(20)
				, CodigoPostal.ciudad         AS CodigoPostal_ciudad     	-- 5	.ciudad    		VARCHAR(36)	Ciudad.id

		FROM	massoftware.CodigoPostal

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND codigoArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(codigoArg5)) > 0 THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		codigoArg5 = REPLACE(codigoArg5, '''', '''''');
		codigoArg5 = LOWER(TRIM(codigoArg5));
		sqlSrcWhere = sqlSrcWhere || ' LOWER(CodigoPostal.codigo) = ''' || codigoArg5 || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroFromArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.numero >= ' || numeroFromArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg7 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.numero <= ' || numeroToArg7;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND ciudadArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(ciudadArg8)) > 0 THEN
		ciudadArg8 = REPLACE(ciudadArg8, '''', '''''');
		ciudadArg8 = LOWER(TRIM(ciudadArg8));
		ciudadArg8 = TRANSLATE(ciudadArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ciudadArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CodigoPostal.ciudad),
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

DROP FUNCTION IF EXISTS massoftware.f_CodigoPostalById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostalById (idArg VARCHAR(36)) RETURNS SETOF massoftware.CodigoPostal AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CodigoPostal ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CodigoPostal ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CodigoPostalById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, codigoArg5        VARCHAR(12)	-- 5
	, numeroFromArg6    INTEGER    	-- 6
	, numeroToArg7      INTEGER    	-- 7
	, ciudadArg8        VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, codigoArg5        VARCHAR(12)	-- 5
	, numeroFromArg6    INTEGER    	-- 6
	, numeroToArg7      INTEGER    	-- 7
	, ciudadArg8        VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_CodigoPostal_1 AS $$

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
				  CodigoPostal.id             AS CodigoPostal_id         	-- 0	.id                		VARCHAR(36)
				, CodigoPostal.codigo         AS CodigoPostal_codigo     	-- 1	.codigo            		VARCHAR(12)
				, CodigoPostal.numero         AS CodigoPostal_numero     	-- 2	.numero            		INTEGER
				, CodigoPostal.nombreCalle    AS CodigoPostal_nombreCalle	-- 3	.nombreCalle       		VARCHAR(200)
				, CodigoPostal.numeroCalle    AS CodigoPostal_numeroCalle	-- 4	.numeroCalle       		VARCHAR(20)
				, Ciudad_5.id                 AS Ciudad_5_id             	-- 5	.Ciudad.id         		VARCHAR(36)
				, Ciudad_5.numero             AS Ciudad_5_numero         	-- 6	.Ciudad.numero     		INTEGER
				, Ciudad_5.nombre             AS Ciudad_5_nombre         	-- 7	.Ciudad.nombre     		VARCHAR(50)
				, Ciudad_5.departamento       AS Ciudad_5_departamento   	-- 8	.Ciudad.departamento		VARCHAR(50)
				, Ciudad_5.numeroAFIP         AS Ciudad_5_numeroAFIP     	-- 9	.Ciudad.numeroAFIP 		INTEGER
				, Ciudad_5.provincia          AS Ciudad_5_provincia      	-- 10	.Ciudad.provincia  		VARCHAR(36)	Provincia.id

		FROM	massoftware.CodigoPostal
			LEFT JOIN massoftware.Ciudad AS Ciudad_5        ON CodigoPostal.ciudad = Ciudad_5.id 	-- 5 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND codigoArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(codigoArg5)) > 0 THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		codigoArg5 = REPLACE(codigoArg5, '''', '''''');
		codigoArg5 = LOWER(TRIM(codigoArg5));
		sqlSrcWhere = sqlSrcWhere || ' LOWER(CodigoPostal.codigo) = ''' || codigoArg5 || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroFromArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.numero >= ' || numeroFromArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg7 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.numero <= ' || numeroToArg7;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND ciudadArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(ciudadArg8)) > 0 THEN
		ciudadArg8 = REPLACE(ciudadArg8, '''', '''''');
		ciudadArg8 = LOWER(TRIM(ciudadArg8));
		ciudadArg8 = TRANSLATE(ciudadArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ciudadArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CodigoPostal.ciudad),
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

DROP FUNCTION IF EXISTS massoftware.f_CodigoPostalById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostalById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_CodigoPostal_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CodigoPostal_1 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CodigoPostal_1 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CodigoPostalById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, codigoArg5        VARCHAR(12)	-- 5
	, numeroFromArg6    INTEGER    	-- 6
	, numeroToArg7      INTEGER    	-- 7
	, ciudadArg8        VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, codigoArg5        VARCHAR(12)	-- 5
	, numeroFromArg6    INTEGER    	-- 6
	, numeroToArg7      INTEGER    	-- 7
	, ciudadArg8        VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_CodigoPostal_2 AS $$

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
				  CodigoPostal.id                       AS CodigoPostal_id                  	-- 0	.id                                  		VARCHAR(36)
				, CodigoPostal.codigo                   AS CodigoPostal_codigo              	-- 1	.codigo                              		VARCHAR(12)
				, CodigoPostal.numero                   AS CodigoPostal_numero              	-- 2	.numero                              		INTEGER
				, CodigoPostal.nombreCalle              AS CodigoPostal_nombreCalle         	-- 3	.nombreCalle                         		VARCHAR(200)
				, CodigoPostal.numeroCalle              AS CodigoPostal_numeroCalle         	-- 4	.numeroCalle                         		VARCHAR(20)
				, Ciudad_5.id                           AS Ciudad_5_id                      	-- 5	.Ciudad.id                           		VARCHAR(36)
				, Ciudad_5.numero                       AS Ciudad_5_numero                  	-- 6	.Ciudad.numero                       		INTEGER
				, Ciudad_5.nombre                       AS Ciudad_5_nombre                  	-- 7	.Ciudad.nombre                       		VARCHAR(50)
				, Ciudad_5.departamento                 AS Ciudad_5_departamento            	-- 8	.Ciudad.departamento                 		VARCHAR(50)
				, Ciudad_5.numeroAFIP                   AS Ciudad_5_numeroAFIP              	-- 9	.Ciudad.numeroAFIP                   		INTEGER
				, Provincia_10.id                       AS Provincia_10_id                  	-- 10	.Ciudad.Provincia.id                 		VARCHAR(36)
				, Provincia_10.numero                   AS Provincia_10_numero              	-- 11	.Ciudad.Provincia.numero             		INTEGER
				, Provincia_10.nombre                   AS Provincia_10_nombre              	-- 12	.Ciudad.Provincia.nombre             		VARCHAR(50)
				, Provincia_10.abreviatura              AS Provincia_10_abreviatura         	-- 13	.Ciudad.Provincia.abreviatura        		VARCHAR(5)
				, Provincia_10.numeroAFIP               AS Provincia_10_numeroAFIP          	-- 14	.Ciudad.Provincia.numeroAFIP         		INTEGER
				, Provincia_10.numeroIngresosBrutos     AS Provincia_10_numeroIngresosBrutos	-- 15	.Ciudad.Provincia.numeroIngresosBrutos		INTEGER
				, Provincia_10.numeroRENATEA            AS Provincia_10_numeroRENATEA       	-- 16	.Ciudad.Provincia.numeroRENATEA      		INTEGER
				, Provincia_10.pais                     AS Provincia_10_pais                	-- 17	.Ciudad.Provincia.pais               		VARCHAR(36)	Pais.id

		FROM	massoftware.CodigoPostal
			LEFT JOIN massoftware.Ciudad AS Ciudad_5               ON CodigoPostal.ciudad = Ciudad_5.id 	-- 5 LEFT LEVEL: 1
				LEFT JOIN massoftware.Provincia AS Provincia_10           ON Ciudad_5.provincia = Provincia_10.id 	-- 10 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND codigoArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(codigoArg5)) > 0 THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		codigoArg5 = REPLACE(codigoArg5, '''', '''''');
		codigoArg5 = LOWER(TRIM(codigoArg5));
		sqlSrcWhere = sqlSrcWhere || ' LOWER(CodigoPostal.codigo) = ''' || codigoArg5 || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroFromArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.numero >= ' || numeroFromArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg7 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.numero <= ' || numeroToArg7;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND ciudadArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(ciudadArg8)) > 0 THEN
		ciudadArg8 = REPLACE(ciudadArg8, '''', '''''');
		ciudadArg8 = LOWER(TRIM(ciudadArg8));
		ciudadArg8 = TRANSLATE(ciudadArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ciudadArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CodigoPostal.ciudad),
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

DROP FUNCTION IF EXISTS massoftware.f_CodigoPostalById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostalById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_CodigoPostal_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CodigoPostal_2 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CodigoPostal_2 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CodigoPostalById_2 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_CodigoPostal_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, codigoArg5        VARCHAR(12)	-- 5
	, numeroFromArg6    INTEGER    	-- 6
	, numeroToArg7      INTEGER    	-- 7
	, ciudadArg8        VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostal_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, codigoArg5        VARCHAR(12)	-- 5
	, numeroFromArg6    INTEGER    	-- 6
	, numeroToArg7      INTEGER    	-- 7
	, ciudadArg8        VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_CodigoPostal_3 AS $$

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
				  CodigoPostal.id                       AS CodigoPostal_id                  	-- 0	.id                                  		VARCHAR(36)
				, CodigoPostal.codigo                   AS CodigoPostal_codigo              	-- 1	.codigo                              		VARCHAR(12)
				, CodigoPostal.numero                   AS CodigoPostal_numero              	-- 2	.numero                              		INTEGER
				, CodigoPostal.nombreCalle              AS CodigoPostal_nombreCalle         	-- 3	.nombreCalle                         		VARCHAR(200)
				, CodigoPostal.numeroCalle              AS CodigoPostal_numeroCalle         	-- 4	.numeroCalle                         		VARCHAR(20)
				, Ciudad_5.id                           AS Ciudad_5_id                      	-- 5	.Ciudad.id                           		VARCHAR(36)
				, Ciudad_5.numero                       AS Ciudad_5_numero                  	-- 6	.Ciudad.numero                       		INTEGER
				, Ciudad_5.nombre                       AS Ciudad_5_nombre                  	-- 7	.Ciudad.nombre                       		VARCHAR(50)
				, Ciudad_5.departamento                 AS Ciudad_5_departamento            	-- 8	.Ciudad.departamento                 		VARCHAR(50)
				, Ciudad_5.numeroAFIP                   AS Ciudad_5_numeroAFIP              	-- 9	.Ciudad.numeroAFIP                   		INTEGER
				, Provincia_10.id                       AS Provincia_10_id                  	-- 10	.Ciudad.Provincia.id                 		VARCHAR(36)
				, Provincia_10.numero                   AS Provincia_10_numero              	-- 11	.Ciudad.Provincia.numero             		INTEGER
				, Provincia_10.nombre                   AS Provincia_10_nombre              	-- 12	.Ciudad.Provincia.nombre             		VARCHAR(50)
				, Provincia_10.abreviatura              AS Provincia_10_abreviatura         	-- 13	.Ciudad.Provincia.abreviatura        		VARCHAR(5)
				, Provincia_10.numeroAFIP               AS Provincia_10_numeroAFIP          	-- 14	.Ciudad.Provincia.numeroAFIP         		INTEGER
				, Provincia_10.numeroIngresosBrutos     AS Provincia_10_numeroIngresosBrutos	-- 15	.Ciudad.Provincia.numeroIngresosBrutos		INTEGER
				, Provincia_10.numeroRENATEA            AS Provincia_10_numeroRENATEA       	-- 16	.Ciudad.Provincia.numeroRENATEA      		INTEGER
				, Pais_17.id                            AS Pais_17_id                       	-- 17	.Ciudad.Provincia.Pais.id            		VARCHAR(36)
				, Pais_17.numero                        AS Pais_17_numero                   	-- 18	.Ciudad.Provincia.Pais.numero        		INTEGER
				, Pais_17.nombre                        AS Pais_17_nombre                   	-- 19	.Ciudad.Provincia.Pais.nombre        		VARCHAR(50)
				, Pais_17.abreviatura                   AS Pais_17_abreviatura              	-- 20	.Ciudad.Provincia.Pais.abreviatura   		VARCHAR(5)

		FROM	massoftware.CodigoPostal
			LEFT JOIN massoftware.Ciudad AS Ciudad_5               ON CodigoPostal.ciudad = Ciudad_5.id 	-- 5 LEFT LEVEL: 1
				LEFT JOIN massoftware.Provincia AS Provincia_10           ON Ciudad_5.provincia = Provincia_10.id 	-- 10 LEFT LEVEL: 2
					LEFT JOIN massoftware.Pais AS Pais_17               ON Provincia_10.pais = Pais_17.id 	-- 17 LEFT LEVEL: 3

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND codigoArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(codigoArg5)) > 0 THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		codigoArg5 = REPLACE(codigoArg5, '''', '''''');
		codigoArg5 = LOWER(TRIM(codigoArg5));
		sqlSrcWhere = sqlSrcWhere || ' LOWER(CodigoPostal.codigo) = ''' || codigoArg5 || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroFromArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.numero >= ' || numeroFromArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg7 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CodigoPostal.numero <= ' || numeroToArg7;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND ciudadArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(ciudadArg8)) > 0 THEN
		ciudadArg8 = REPLACE(ciudadArg8, '''', '''''');
		ciudadArg8 = LOWER(TRIM(ciudadArg8));
		ciudadArg8 = TRANSLATE(ciudadArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ciudadArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CodigoPostal.ciudad),
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

DROP FUNCTION IF EXISTS massoftware.f_CodigoPostalById_3 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CodigoPostalById_3 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_CodigoPostal_3 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CodigoPostal_3 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CodigoPostal_3 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CodigoPostalById_3 ('xxx'); 