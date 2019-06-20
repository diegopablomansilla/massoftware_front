
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondoGrupo                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondoGrupo



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.CuentaFondoGrupo CASCADE;

CREATE TABLE massoftware.CuentaFondoGrupo
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº grupo
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT CuentaFondoGrupo_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Rubro
	cuentaFondoRubro VARCHAR(36)  NOT NULL  REFERENCES massoftware.CuentaFondoRubro (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_CuentaFondoGrupo_nombre ON massoftware.CuentaFondoGrupo (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCuentaFondoGrupo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCuentaFondoGrupo() RETURNS TRIGGER AS $formatCuentaFondoGrupo$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.cuentaFondoRubro := massoftware.white_is_null(NEW.cuentaFondoRubro);

	RETURN NEW;
END;
$formatCuentaFondoGrupo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCuentaFondoGrupo ON massoftware.CuentaFondoGrupo CASCADE;

CREATE TRIGGER tgFormatCuentaFondoGrupo BEFORE INSERT OR UPDATE
	ON massoftware.CuentaFondoGrupo FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatCuentaFondoGrupo();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.CuentaFondoGrupo;

-- SELECT * FROM massoftware.CuentaFondoGrupo LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.CuentaFondoGrupo;

-- SELECT * FROM massoftware.CuentaFondoGrupo WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_CuentaFondoGrupo_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_CuentaFondoGrupo_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.CuentaFondoGrupo
	WHERE	(numeroArg IS NULL OR CuentaFondoGrupo.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_CuentaFondoGrupo_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_CuentaFondoGrupo_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_CuentaFondoGrupo_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.CuentaFondoGrupo
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(CuentaFondoGrupo.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_CuentaFondoGrupo_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CuentaFondoGrupo_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CuentaFondoGrupo_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.CuentaFondoGrupo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CuentaFondoGrupo_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_CuentaFondoGrupoById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_CuentaFondoGrupoById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.CuentaFondoGrupo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoGrupo.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.CuentaFondoGrupo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoGrupo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaFondoGrupo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoGrupo.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_CuentaFondoGrupoById('xxx');

-- SELECT * FROM massoftware.d_CuentaFondoGrupoById((SELECT CuentaFondoGrupo.id FROM massoftware.CuentaFondoGrupo LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_CuentaFondoGrupo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaFondoRubroArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_CuentaFondoGrupo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaFondoRubroArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.CuentaFondoGrupo(id, numero, nombre, cuentaFondoRubro) VALUES (idArg, numeroArg, nombreArg, cuentaFondoRubroArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaFondoGrupo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoGrupo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_CuentaFondoGrupo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_CuentaFondoGrupo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaFondoRubroArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_CuentaFondoGrupo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaFondoRubroArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.CuentaFondoGrupo SET 
		  numero = numeroArg
		, nombre = nombreArg
		, cuentaFondoRubro = cuentaFondoRubroArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoGrupo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaFondoGrupo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoGrupo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_CuentaFondoGrupo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
);

*/

DROP TYPE IF EXISTS massoftware.t_CuentaFondoGrupo_1 CASCADE;

CREATE TYPE massoftware.t_CuentaFondoGrupo_1 AS (

	  CuentaFondoGrupo_id      	VARCHAR(36)		-- 0	CuentaFondoGrupo.id
	, CuentaFondoGrupo_numero  	INTEGER    		-- 1	CuentaFondoGrupo.numero
	, CuentaFondoGrupo_nombre  	VARCHAR(50)		-- 2	CuentaFondoGrupo.nombre
	, CuentaFondoRubro_3_id    	VARCHAR(36)		-- 3	CuentaFondoGrupo.CuentaFondoRubro.id
	, CuentaFondoRubro_3_numero	INTEGER    		-- 4	CuentaFondoGrupo.CuentaFondoRubro.numero
	, CuentaFondoRubro_3_nombre	VARCHAR(50)		-- 5	CuentaFondoGrupo.CuentaFondoRubro.nombre

);

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoGrupo (

	  idArg0                 VARCHAR(36)	-- 0
	, orderByArg1            INTEGER    	-- 1
	, orderByDescArg2        BOOLEAN    	-- 2
	, limitArg3              BIGINT     	-- 3
	, offSetArg4             BIGINT     	-- 4
	, numeroFromArg5         INTEGER    	-- 5
	, numeroToArg6           INTEGER    	-- 6
	, nombreArg7             VARCHAR(50)	-- 7
	, cuentaFondoRubroArg8   VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoGrupo (

	  idArg0                 VARCHAR(36)	-- 0
	, orderByArg1            INTEGER    	-- 1
	, orderByDescArg2        BOOLEAN    	-- 2
	, limitArg3              BIGINT     	-- 3
	, offSetArg4             BIGINT     	-- 4
	, numeroFromArg5         INTEGER    	-- 5
	, numeroToArg6           INTEGER    	-- 6
	, nombreArg7             VARCHAR(50)	-- 7
	, cuentaFondoRubroArg8   VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.CuentaFondoGrupo AS $$

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
				  CuentaFondoGrupo.id                  AS CuentaFondoGrupo_id              	-- 0	.id             		VARCHAR(36)
				, CuentaFondoGrupo.numero              AS CuentaFondoGrupo_numero          	-- 1	.numero         		INTEGER
				, CuentaFondoGrupo.nombre              AS CuentaFondoGrupo_nombre          	-- 2	.nombre         		VARCHAR(50)
				, CuentaFondoGrupo.cuentaFondoRubro    AS CuentaFondoGrupo_cuentaFondoRubro	-- 3	.cuentaFondoRubro		VARCHAR(36)	CuentaFondoRubro.id

		FROM	massoftware.CuentaFondoGrupo

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondoGrupo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondoGrupo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondoGrupo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondoGrupo.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND cuentaFondoRubroArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(cuentaFondoRubroArg8)) > 0 THEN
		cuentaFondoRubroArg8 = REPLACE(cuentaFondoRubroArg8, '''', '''''');
		cuentaFondoRubroArg8 = LOWER(TRIM(cuentaFondoRubroArg8));
		cuentaFondoRubroArg8 = TRANSLATE(cuentaFondoRubroArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(cuentaFondoRubroArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondoGrupo.cuentaFondoRubro),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoGrupoById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoGrupoById (idArg VARCHAR(36)) RETURNS SETOF massoftware.CuentaFondoGrupo AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaFondoGrupo ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaFondoGrupo ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaFondoGrupoById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoGrupo_1 (

	  idArg0                 VARCHAR(36)	-- 0
	, orderByArg1            INTEGER    	-- 1
	, orderByDescArg2        BOOLEAN    	-- 2
	, limitArg3              BIGINT     	-- 3
	, offSetArg4             BIGINT     	-- 4
	, numeroFromArg5         INTEGER    	-- 5
	, numeroToArg6           INTEGER    	-- 6
	, nombreArg7             VARCHAR(50)	-- 7
	, cuentaFondoRubroArg8   VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoGrupo_1 (

	  idArg0                 VARCHAR(36)	-- 0
	, orderByArg1            INTEGER    	-- 1
	, orderByDescArg2        BOOLEAN    	-- 2
	, limitArg3              BIGINT     	-- 3
	, offSetArg4             BIGINT     	-- 4
	, numeroFromArg5         INTEGER    	-- 5
	, numeroToArg6           INTEGER    	-- 6
	, nombreArg7             VARCHAR(50)	-- 7
	, cuentaFondoRubroArg8   VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_CuentaFondoGrupo_1 AS $$

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
				  CuentaFondoGrupo.id          AS CuentaFondoGrupo_id      	-- 0	.id                    		VARCHAR(36)
				, CuentaFondoGrupo.numero      AS CuentaFondoGrupo_numero  	-- 1	.numero                		INTEGER
				, CuentaFondoGrupo.nombre      AS CuentaFondoGrupo_nombre  	-- 2	.nombre                		VARCHAR(50)
				, CuentaFondoRubro_3.id        AS CuentaFondoRubro_3_id    	-- 3	.CuentaFondoRubro.id   		VARCHAR(36)
				, CuentaFondoRubro_3.numero    AS CuentaFondoRubro_3_numero	-- 4	.CuentaFondoRubro.numero		INTEGER
				, CuentaFondoRubro_3.nombre    AS CuentaFondoRubro_3_nombre	-- 5	.CuentaFondoRubro.nombre		VARCHAR(50)

		FROM	massoftware.CuentaFondoGrupo
			LEFT JOIN massoftware.CuentaFondoRubro AS CuentaFondoRubro_3        ON CuentaFondoGrupo.cuentaFondoRubro = CuentaFondoRubro_3.id 	-- 3 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondoGrupo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondoGrupo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondoGrupo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondoGrupo.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND cuentaFondoRubroArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(cuentaFondoRubroArg8)) > 0 THEN
		cuentaFondoRubroArg8 = REPLACE(cuentaFondoRubroArg8, '''', '''''');
		cuentaFondoRubroArg8 = LOWER(TRIM(cuentaFondoRubroArg8));
		cuentaFondoRubroArg8 = TRANSLATE(cuentaFondoRubroArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(cuentaFondoRubroArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondoGrupo.cuentaFondoRubro),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoGrupoById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoGrupoById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_CuentaFondoGrupo_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaFondoGrupo_1 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaFondoGrupo_1 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaFondoGrupoById_1 ('xxx'); 