
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: SeguridadPuerta                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.SeguridadPuerta



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.SeguridadPuerta CASCADE;

CREATE TABLE massoftware.SeguridadPuerta
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº puerta
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT SeguridadPuerta_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- I.D
	equate VARCHAR(30) NOT NULL, 
	
	-- Módulo
	seguridadModulo VARCHAR(36)  NOT NULL  REFERENCES massoftware.SeguridadModulo (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_SeguridadPuerta_nombre ON massoftware.SeguridadPuerta (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatSeguridadPuerta() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatSeguridadPuerta() RETURNS TRIGGER AS $formatSeguridadPuerta$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.equate := massoftware.white_is_null(NEW.equate);
	 NEW.seguridadModulo := massoftware.white_is_null(NEW.seguridadModulo);

	RETURN NEW;
END;
$formatSeguridadPuerta$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatSeguridadPuerta ON massoftware.SeguridadPuerta CASCADE;

CREATE TRIGGER tgFormatSeguridadPuerta BEFORE INSERT OR UPDATE
	ON massoftware.SeguridadPuerta FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatSeguridadPuerta();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.SeguridadPuerta;

-- SELECT * FROM massoftware.SeguridadPuerta LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.SeguridadPuerta;

-- SELECT * FROM massoftware.SeguridadPuerta WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_SeguridadPuerta_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_SeguridadPuerta_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.SeguridadPuerta
	WHERE	(numeroArg IS NULL OR SeguridadPuerta.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_SeguridadPuerta_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_SeguridadPuerta_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_SeguridadPuerta_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.SeguridadPuerta
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(SeguridadPuerta.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_SeguridadPuerta_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_SeguridadPuerta_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_SeguridadPuerta_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.SeguridadPuerta;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_SeguridadPuerta_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_SeguridadPuertaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_SeguridadPuertaById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.SeguridadPuerta WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND SeguridadPuerta.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.SeguridadPuerta WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND SeguridadPuerta.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.SeguridadPuerta WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND SeguridadPuerta.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_SeguridadPuertaById('xxx');

-- SELECT * FROM massoftware.d_SeguridadPuertaById((SELECT SeguridadPuerta.id FROM massoftware.SeguridadPuerta LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_SeguridadPuerta(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, equateArg VARCHAR(30)
		, seguridadModuloArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_SeguridadPuerta(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, equateArg VARCHAR(30)
		, seguridadModuloArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.SeguridadPuerta(id, numero, nombre, equate, seguridadModulo) VALUES (idArg, numeroArg, nombreArg, equateArg, seguridadModuloArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.SeguridadPuerta WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND SeguridadPuerta.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_SeguridadPuerta(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(30)
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_SeguridadPuerta(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, equateArg VARCHAR(30)
		, seguridadModuloArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_SeguridadPuerta(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, equateArg VARCHAR(30)
		, seguridadModuloArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.SeguridadPuerta SET 
		  numero = numeroArg
		, nombre = nombreArg
		, equate = equateArg
		, seguridadModulo = seguridadModuloArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND SeguridadPuerta.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.SeguridadPuerta WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND SeguridadPuerta.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_SeguridadPuerta(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(30)
		, null::VARCHAR(36)
);

*/

DROP TYPE IF EXISTS massoftware.t_SeguridadPuerta_1 CASCADE;

CREATE TYPE massoftware.t_SeguridadPuerta_1 AS (

	  SeguridadPuerta_id      	VARCHAR(36)		-- 0	SeguridadPuerta.id
	, SeguridadPuerta_numero  	INTEGER    		-- 1	SeguridadPuerta.numero
	, SeguridadPuerta_nombre  	VARCHAR(50)		-- 2	SeguridadPuerta.nombre
	, SeguridadPuerta_equate  	VARCHAR(30)		-- 3	SeguridadPuerta.equate
	, SeguridadModulo_4_id    	VARCHAR(36)		-- 4	SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_4_numero	INTEGER    		-- 5	SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_4_nombre	VARCHAR(50)		-- 6	SeguridadPuerta.SeguridadModulo.nombre

);

DROP FUNCTION IF EXISTS massoftware.f_SeguridadPuerta (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_SeguridadPuerta (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.SeguridadPuerta AS $$

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
				  SeguridadPuerta.id                 AS SeguridadPuerta_id             	-- 0	.id            		VARCHAR(36)
				, SeguridadPuerta.numero             AS SeguridadPuerta_numero         	-- 1	.numero        		INTEGER
				, SeguridadPuerta.nombre             AS SeguridadPuerta_nombre         	-- 2	.nombre        		VARCHAR(50)
				, SeguridadPuerta.equate             AS SeguridadPuerta_equate         	-- 3	.equate        		VARCHAR(30)
				, SeguridadPuerta.seguridadModulo    AS SeguridadPuerta_seguridadModulo	-- 4	.seguridadModulo		VARCHAR(36)	SeguridadModulo.id

		FROM	massoftware.SeguridadPuerta

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' SeguridadPuerta.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' SeguridadPuerta.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' SeguridadPuerta.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(SeguridadPuerta.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_SeguridadPuertaById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_SeguridadPuertaById (idArg VARCHAR(36)) RETURNS SETOF massoftware.SeguridadPuerta AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_SeguridadPuerta ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_SeguridadPuerta ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_SeguridadPuertaById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_SeguridadPuerta_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_SeguridadPuerta_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.t_SeguridadPuerta_1 AS $$

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
				  SeguridadPuerta.id          AS SeguridadPuerta_id      	-- 0	.id                   		VARCHAR(36)
				, SeguridadPuerta.numero      AS SeguridadPuerta_numero  	-- 1	.numero               		INTEGER
				, SeguridadPuerta.nombre      AS SeguridadPuerta_nombre  	-- 2	.nombre               		VARCHAR(50)
				, SeguridadPuerta.equate      AS SeguridadPuerta_equate  	-- 3	.equate               		VARCHAR(30)
				, SeguridadModulo_4.id        AS SeguridadModulo_4_id    	-- 4	.SeguridadModulo.id   		VARCHAR(36)
				, SeguridadModulo_4.numero    AS SeguridadModulo_4_numero	-- 5	.SeguridadModulo.numero		INTEGER
				, SeguridadModulo_4.nombre    AS SeguridadModulo_4_nombre	-- 6	.SeguridadModulo.nombre		VARCHAR(50)

		FROM	massoftware.SeguridadPuerta
			LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_4        ON SeguridadPuerta.seguridadModulo = SeguridadModulo_4.id 	-- 4 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' SeguridadPuerta.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' SeguridadPuerta.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' SeguridadPuerta.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(SeguridadPuerta.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_SeguridadPuertaById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_SeguridadPuertaById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_SeguridadPuerta_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_SeguridadPuerta_1 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_SeguridadPuerta_1 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_SeguridadPuertaById_1 ('xxx'); 