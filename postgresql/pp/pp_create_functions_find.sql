


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Usuario                                                                                                //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Usuario



DROP FUNCTION IF EXISTS massoftware.f_Usuario (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Usuario (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.Usuario AS $$

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
				  Usuario.id        AS Usuario_id    	-- 0	.id   		VARCHAR(36)
				, Usuario.numero    AS Usuario_numero	-- 1	.numero		INTEGER
				, Usuario.nombre    AS Usuario_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.Usuario

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Usuario.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Usuario.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Usuario.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Usuario.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_UsuarioById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_UsuarioById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Usuario AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Usuario ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Usuario ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_UsuarioById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: SeguridadModulo                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.SeguridadModulo



DROP FUNCTION IF EXISTS massoftware.f_SeguridadModulo (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_SeguridadModulo (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.SeguridadModulo AS $$

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
				  SeguridadModulo.id        AS SeguridadModulo_id    	-- 0	.id   		VARCHAR(36)
				, SeguridadModulo.numero    AS SeguridadModulo_numero	-- 1	.numero		INTEGER
				, SeguridadModulo.nombre    AS SeguridadModulo_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.SeguridadModulo

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' SeguridadModulo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' SeguridadModulo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' SeguridadModulo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(SeguridadModulo.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_SeguridadModuloById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_SeguridadModuloById (idArg VARCHAR(36)) RETURNS SETOF massoftware.SeguridadModulo AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_SeguridadModulo ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_SeguridadModulo ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_SeguridadModuloById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: SeguridadPuerta                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.SeguridadPuerta



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


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Zona                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Zona



DROP FUNCTION IF EXISTS massoftware.f_Zona (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, codigoArg5        VARCHAR(3) 	-- 5
	, nombreArg6        VARCHAR(50)	-- 6

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, codigoArg5        VARCHAR(3) 	-- 5
	, nombreArg6        VARCHAR(50)	-- 6

) RETURNS SETOF massoftware.Zona AS $$

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
				  Zona.id              AS Zona_id          	-- 0	.id         		VARCHAR(36)
				, Zona.codigo          AS Zona_codigo      	-- 1	.codigo     		VARCHAR(3)
				, Zona.nombre          AS Zona_nombre      	-- 2	.nombre     		VARCHAR(50)
				, Zona.bonificacion    AS Zona_bonificacion	-- 3	.bonificacion		DECIMAL(13,5)
				, Zona.recargo         AS Zona_recargo     	-- 4	.recargo    		DECIMAL(13,5)

		FROM	massoftware.Zona

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Zona.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND codigoArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(codigoArg5)) > 0 THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		codigoArg5 = REPLACE(codigoArg5, '''', '''''');
		codigoArg5 = LOWER(TRIM(codigoArg5));
		sqlSrcWhere = sqlSrcWhere || ' LOWER(Zona.codigo) = ''' || codigoArg5 || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Zona.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_ZonaById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ZonaById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Zona AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Zona ( idArg , null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Zona ( null , null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_ZonaById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Pais                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Pais



DROP FUNCTION IF EXISTS massoftware.f_Pais (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, abreviaturaArg8   VARCHAR(5) 	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Pais (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, abreviaturaArg8   VARCHAR(5) 	-- 8

) RETURNS SETOF massoftware.Pais AS $$

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
				  Pais.id             AS Pais_id         	-- 0	.id        		VARCHAR(36)
				, Pais.numero         AS Pais_numero     	-- 1	.numero    		INTEGER
				, Pais.nombre         AS Pais_nombre     	-- 2	.nombre    		VARCHAR(50)
				, Pais.abreviatura    AS Pais_abreviatura	-- 3	.abreviatura		VARCHAR(5)

		FROM	massoftware.Pais

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Pais.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Pais.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Pais.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Pais.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND abreviaturaArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(abreviaturaArg8)) > 0 THEN
		abreviaturaArg8 = REPLACE(abreviaturaArg8, '''', '''''');
		abreviaturaArg8 = LOWER(TRIM(abreviaturaArg8));
		abreviaturaArg8 = TRANSLATE(abreviaturaArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(abreviaturaArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Pais.abreviatura),
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

DROP FUNCTION IF EXISTS massoftware.f_PaisById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_PaisById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Pais AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Pais ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Pais ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_PaisById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Provincia                                                                                              //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Provincia



DROP FUNCTION IF EXISTS massoftware.f_Provincia (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, abreviaturaArg8   VARCHAR(5) 	-- 8
	, paisArg9          VARCHAR(36)	-- 9

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, abreviaturaArg8   VARCHAR(5) 	-- 8
	, paisArg9          VARCHAR(36)	-- 9

) RETURNS SETOF massoftware.Provincia AS $$

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
				  Provincia.id                      AS Provincia_id                  	-- 0	.id                 		VARCHAR(36)
				, Provincia.numero                  AS Provincia_numero              	-- 1	.numero             		INTEGER
				, Provincia.nombre                  AS Provincia_nombre              	-- 2	.nombre             		VARCHAR(50)
				, Provincia.abreviatura             AS Provincia_abreviatura         	-- 3	.abreviatura        		VARCHAR(5)
				, Provincia.numeroAFIP              AS Provincia_numeroAFIP          	-- 4	.numeroAFIP         		INTEGER
				, Provincia.numeroIngresosBrutos    AS Provincia_numeroIngresosBrutos	-- 5	.numeroIngresosBrutos		INTEGER
				, Provincia.numeroRENATEA           AS Provincia_numeroRENATEA       	-- 6	.numeroRENATEA      		INTEGER
				, Provincia.pais                    AS Provincia_pais                	-- 7	.pais               		VARCHAR(36)	Pais.id

		FROM	massoftware.Provincia

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Provincia.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Provincia.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Provincia.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Provincia.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND abreviaturaArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(abreviaturaArg8)) > 0 THEN
		abreviaturaArg8 = REPLACE(abreviaturaArg8, '''', '''''');
		abreviaturaArg8 = LOWER(TRIM(abreviaturaArg8));
		abreviaturaArg8 = TRANSLATE(abreviaturaArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(abreviaturaArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Provincia.abreviatura),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND paisArg9 IS NOT NULL AND CHAR_LENGTH(TRIM(paisArg9)) > 0 THEN
		paisArg9 = REPLACE(paisArg9, '''', '''''');
		paisArg9 = LOWER(TRIM(paisArg9));
		paisArg9 = TRANSLATE(paisArg9,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(paisArg9, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Provincia.pais),
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

DROP FUNCTION IF EXISTS massoftware.f_ProvinciaById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ProvinciaById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Provincia AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Provincia ( idArg , null, null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Provincia ( null , null, null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_ProvinciaById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Provincia_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, abreviaturaArg8   VARCHAR(5) 	-- 8
	, paisArg9          VARCHAR(36)	-- 9

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Provincia_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, abreviaturaArg8   VARCHAR(5) 	-- 8
	, paisArg9          VARCHAR(36)	-- 9

) RETURNS SETOF massoftware.t_Provincia_1 AS $$

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
				  Provincia.id                      AS Provincia_id                  	-- 0	.id                 		VARCHAR(36)
				, Provincia.numero                  AS Provincia_numero              	-- 1	.numero             		INTEGER
				, Provincia.nombre                  AS Provincia_nombre              	-- 2	.nombre             		VARCHAR(50)
				, Provincia.abreviatura             AS Provincia_abreviatura         	-- 3	.abreviatura        		VARCHAR(5)
				, Provincia.numeroAFIP              AS Provincia_numeroAFIP          	-- 4	.numeroAFIP         		INTEGER
				, Provincia.numeroIngresosBrutos    AS Provincia_numeroIngresosBrutos	-- 5	.numeroIngresosBrutos		INTEGER
				, Provincia.numeroRENATEA           AS Provincia_numeroRENATEA       	-- 6	.numeroRENATEA      		INTEGER
				, Pais_7.id                         AS Pais_7_id                     	-- 7	.Pais.id            		VARCHAR(36)
				, Pais_7.numero                     AS Pais_7_numero                 	-- 8	.Pais.numero        		INTEGER
				, Pais_7.nombre                     AS Pais_7_nombre                 	-- 9	.Pais.nombre        		VARCHAR(50)
				, Pais_7.abreviatura                AS Pais_7_abreviatura            	-- 10	.Pais.abreviatura   		VARCHAR(5)

		FROM	massoftware.Provincia
			LEFT JOIN massoftware.Pais AS Pais_7        ON Provincia.pais = Pais_7.id 	-- 7 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Provincia.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Provincia.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Provincia.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Provincia.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND abreviaturaArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(abreviaturaArg8)) > 0 THEN
		abreviaturaArg8 = REPLACE(abreviaturaArg8, '''', '''''');
		abreviaturaArg8 = LOWER(TRIM(abreviaturaArg8));
		abreviaturaArg8 = TRANSLATE(abreviaturaArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(abreviaturaArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Provincia.abreviatura),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND paisArg9 IS NOT NULL AND CHAR_LENGTH(TRIM(paisArg9)) > 0 THEN
		paisArg9 = REPLACE(paisArg9, '''', '''''');
		paisArg9 = LOWER(TRIM(paisArg9));
		paisArg9 = TRANSLATE(paisArg9,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(paisArg9, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Provincia.pais),
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

DROP FUNCTION IF EXISTS massoftware.f_ProvinciaById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ProvinciaById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Provincia_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Provincia_1 ( idArg , null, null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Provincia_1 ( null , null, null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_ProvinciaById_1 ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Ciudad                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Ciudad



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


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CodigoPostal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CodigoPostal



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


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Transporte                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Transporte



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


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Carga                                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Carga



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


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TransporteTarifa                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TransporteTarifa



DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) RETURNS SETOF massoftware.TransporteTarifa AS $$

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
				  TransporteTarifa.id                         AS TransporteTarifa_id                     	-- 0	.id                    		VARCHAR(36)
				, TransporteTarifa.numero                     AS TransporteTarifa_numero                 	-- 1	.numero                		INTEGER
				, TransporteTarifa.carga                      AS TransporteTarifa_carga                  	-- 2	.carga                 		VARCHAR(36)	Carga.id
				, TransporteTarifa.ciudad                     AS TransporteTarifa_ciudad                 	-- 3	.ciudad                		VARCHAR(36)	Ciudad.id
				, TransporteTarifa.precioFlete                AS TransporteTarifa_precioFlete            	-- 4	.precioFlete           		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadFacturacion    AS TransporteTarifa_precioUnidadFacturacion	-- 5	.precioUnidadFacturacion		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadStock          AS TransporteTarifa_precioUnidadStock      	-- 6	.precioUnidadStock     		DECIMAL(13,5)
				, TransporteTarifa.precioBultos               AS TransporteTarifa_precioBultos           	-- 7	.precioBultos          		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoEntrega       AS TransporteTarifa_importeMinimoEntrega   	-- 8	.importeMinimoEntrega  		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoCarga         AS TransporteTarifa_importeMinimoCarga     	-- 9	.importeMinimoCarga    		DECIMAL(13,5)

		FROM	massoftware.TransporteTarifa

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TransporteTarifa.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
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

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById (idArg VARCHAR(36)) RETURNS SETOF massoftware.TransporteTarifa AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TransporteTarifa ( idArg , null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_TransporteTarifa ( null , null, null, null, null); 

-- SELECT * FROM massoftware.f_TransporteTarifaById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) RETURNS SETOF massoftware.t_TransporteTarifa_1 AS $$

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
				  TransporteTarifa.id                          AS TransporteTarifa_id                     	-- 0	.id                    		VARCHAR(36)
				, TransporteTarifa.numero                      AS TransporteTarifa_numero                 	-- 1	.numero                		INTEGER
				, Carga_2.id                                   AS Carga_2_id                              	-- 2	.Carga.id              		VARCHAR(36)
				, Carga_2.numero                               AS Carga_2_numero                          	-- 3	.Carga.numero          		INTEGER
				, Carga_2.nombre                               AS Carga_2_nombre                          	-- 4	.Carga.nombre          		VARCHAR(50)
				, Carga_2.transporte                           AS Carga_2_transporte                      	-- 5	.Carga.transporte      		VARCHAR(36)	Transporte.id
				, Ciudad_6.id                                  AS Ciudad_6_id                             	-- 6	.Ciudad.id             		VARCHAR(36)
				, Ciudad_6.numero                              AS Ciudad_6_numero                         	-- 7	.Ciudad.numero         		INTEGER
				, Ciudad_6.nombre                              AS Ciudad_6_nombre                         	-- 8	.Ciudad.nombre         		VARCHAR(50)
				, Ciudad_6.departamento                        AS Ciudad_6_departamento                   	-- 9	.Ciudad.departamento   		VARCHAR(50)
				, Ciudad_6.numeroAFIP                          AS Ciudad_6_numeroAFIP                     	-- 10	.Ciudad.numeroAFIP     		INTEGER
				, Ciudad_6.provincia                           AS Ciudad_6_provincia                      	-- 11	.Ciudad.provincia      		VARCHAR(36)	Provincia.id
				, TransporteTarifa.precioFlete                 AS TransporteTarifa_precioFlete            	-- 12	.precioFlete           		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadFacturacion     AS TransporteTarifa_precioUnidadFacturacion	-- 13	.precioUnidadFacturacion		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadStock           AS TransporteTarifa_precioUnidadStock      	-- 14	.precioUnidadStock     		DECIMAL(13,5)
				, TransporteTarifa.precioBultos                AS TransporteTarifa_precioBultos           	-- 15	.precioBultos          		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoEntrega        AS TransporteTarifa_importeMinimoEntrega   	-- 16	.importeMinimoEntrega  		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoCarga          AS TransporteTarifa_importeMinimoCarga     	-- 17	.importeMinimoCarga    		DECIMAL(13,5)

		FROM	massoftware.TransporteTarifa
			LEFT JOIN massoftware.Carga AS Carga_2         ON TransporteTarifa.carga = Carga_2.id 	-- 2 LEFT LEVEL: 1
			LEFT JOIN massoftware.Ciudad AS Ciudad_6        ON TransporteTarifa.ciudad = Ciudad_6.id 	-- 6 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TransporteTarifa.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
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

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_TransporteTarifa_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TransporteTarifa_1 ( idArg , null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_TransporteTarifa_1 ( null , null, null, null, null); 

-- SELECT * FROM massoftware.f_TransporteTarifaById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) RETURNS SETOF massoftware.t_TransporteTarifa_2 AS $$

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
				  TransporteTarifa.id                          AS TransporteTarifa_id                     	-- 0	.id                                  		VARCHAR(36)
				, TransporteTarifa.numero                      AS TransporteTarifa_numero                 	-- 1	.numero                              		INTEGER
				, Carga_2.id                                   AS Carga_2_id                              	-- 2	.Carga.id                            		VARCHAR(36)
				, Carga_2.numero                               AS Carga_2_numero                          	-- 3	.Carga.numero                        		INTEGER
				, Carga_2.nombre                               AS Carga_2_nombre                          	-- 4	.Carga.nombre                        		VARCHAR(50)
				, Transporte_5.id                              AS Transporte_5_id                         	-- 5	.Carga.Transporte.id                 		VARCHAR(36)
				, Transporte_5.numero                          AS Transporte_5_numero                     	-- 6	.Carga.Transporte.numero             		INTEGER
				, Transporte_5.nombre                          AS Transporte_5_nombre                     	-- 7	.Carga.Transporte.nombre             		VARCHAR(50)
				, Transporte_5.cuit                            AS Transporte_5_cuit                       	-- 8	.Carga.Transporte.cuit               		BIGINT
				, Transporte_5.ingresosBrutos                  AS Transporte_5_ingresosBrutos             	-- 9	.Carga.Transporte.ingresosBrutos     		VARCHAR(13)
				, Transporte_5.telefono                        AS Transporte_5_telefono                   	-- 10	.Carga.Transporte.telefono           		VARCHAR(50)
				, Transporte_5.fax                             AS Transporte_5_fax                        	-- 11	.Carga.Transporte.fax                		VARCHAR(50)
				, Transporte_5.codigoPostal                    AS Transporte_5_codigoPostal               	-- 12	.Carga.Transporte.codigoPostal       		VARCHAR(36)	CodigoPostal.id
				, Transporte_5.domicilio                       AS Transporte_5_domicilio                  	-- 13	.Carga.Transporte.domicilio          		VARCHAR(150)
				, Transporte_5.comentario                      AS Transporte_5_comentario                 	-- 14	.Carga.Transporte.comentario         		VARCHAR(300)
				, Ciudad_15.id                                 AS Ciudad_15_id                            	-- 15	.Ciudad.id                           		VARCHAR(36)
				, Ciudad_15.numero                             AS Ciudad_15_numero                        	-- 16	.Ciudad.numero                       		INTEGER
				, Ciudad_15.nombre                             AS Ciudad_15_nombre                        	-- 17	.Ciudad.nombre                       		VARCHAR(50)
				, Ciudad_15.departamento                       AS Ciudad_15_departamento                  	-- 18	.Ciudad.departamento                 		VARCHAR(50)
				, Ciudad_15.numeroAFIP                         AS Ciudad_15_numeroAFIP                    	-- 19	.Ciudad.numeroAFIP                   		INTEGER
				, Provincia_20.id                              AS Provincia_20_id                         	-- 20	.Ciudad.Provincia.id                 		VARCHAR(36)
				, Provincia_20.numero                          AS Provincia_20_numero                     	-- 21	.Ciudad.Provincia.numero             		INTEGER
				, Provincia_20.nombre                          AS Provincia_20_nombre                     	-- 22	.Ciudad.Provincia.nombre             		VARCHAR(50)
				, Provincia_20.abreviatura                     AS Provincia_20_abreviatura                	-- 23	.Ciudad.Provincia.abreviatura        		VARCHAR(5)
				, Provincia_20.numeroAFIP                      AS Provincia_20_numeroAFIP                 	-- 24	.Ciudad.Provincia.numeroAFIP         		INTEGER
				, Provincia_20.numeroIngresosBrutos            AS Provincia_20_numeroIngresosBrutos       	-- 25	.Ciudad.Provincia.numeroIngresosBrutos		INTEGER
				, Provincia_20.numeroRENATEA                   AS Provincia_20_numeroRENATEA              	-- 26	.Ciudad.Provincia.numeroRENATEA      		INTEGER
				, Provincia_20.pais                            AS Provincia_20_pais                       	-- 27	.Ciudad.Provincia.pais               		VARCHAR(36)	Pais.id
				, TransporteTarifa.precioFlete                 AS TransporteTarifa_precioFlete            	-- 28	.precioFlete                         		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadFacturacion     AS TransporteTarifa_precioUnidadFacturacion	-- 29	.precioUnidadFacturacion             		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadStock           AS TransporteTarifa_precioUnidadStock      	-- 30	.precioUnidadStock                   		DECIMAL(13,5)
				, TransporteTarifa.precioBultos                AS TransporteTarifa_precioBultos           	-- 31	.precioBultos                        		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoEntrega        AS TransporteTarifa_importeMinimoEntrega   	-- 32	.importeMinimoEntrega                		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoCarga          AS TransporteTarifa_importeMinimoCarga     	-- 33	.importeMinimoCarga                  		DECIMAL(13,5)

		FROM	massoftware.TransporteTarifa
			LEFT JOIN massoftware.Carga AS Carga_2                ON TransporteTarifa.carga = Carga_2.id 	-- 2 LEFT LEVEL: 1
				LEFT JOIN massoftware.Transporte AS Transporte_5           ON Carga_2.transporte = Transporte_5.id 	-- 5 LEFT LEVEL: 2
			LEFT JOIN massoftware.Ciudad AS Ciudad_15               ON TransporteTarifa.ciudad = Ciudad_15.id 	-- 15 LEFT LEVEL: 1
				LEFT JOIN massoftware.Provincia AS Provincia_20           ON Ciudad_15.provincia = Provincia_20.id 	-- 20 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TransporteTarifa.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
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

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_TransporteTarifa_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TransporteTarifa_2 ( idArg , null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_TransporteTarifa_2 ( null , null, null, null, null); 

-- SELECT * FROM massoftware.f_TransporteTarifaById_2 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) RETURNS SETOF massoftware.t_TransporteTarifa_3 AS $$

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
				  TransporteTarifa.id                          AS TransporteTarifa_id                     	-- 0	.id                                      		VARCHAR(36)
				, TransporteTarifa.numero                      AS TransporteTarifa_numero                 	-- 1	.numero                                  		INTEGER
				, Carga_2.id                                   AS Carga_2_id                              	-- 2	.Carga.id                                		VARCHAR(36)
				, Carga_2.numero                               AS Carga_2_numero                          	-- 3	.Carga.numero                            		INTEGER
				, Carga_2.nombre                               AS Carga_2_nombre                          	-- 4	.Carga.nombre                            		VARCHAR(50)
				, Transporte_5.id                              AS Transporte_5_id                         	-- 5	.Carga.Transporte.id                     		VARCHAR(36)
				, Transporte_5.numero                          AS Transporte_5_numero                     	-- 6	.Carga.Transporte.numero                 		INTEGER
				, Transporte_5.nombre                          AS Transporte_5_nombre                     	-- 7	.Carga.Transporte.nombre                 		VARCHAR(50)
				, Transporte_5.cuit                            AS Transporte_5_cuit                       	-- 8	.Carga.Transporte.cuit                   		BIGINT
				, Transporte_5.ingresosBrutos                  AS Transporte_5_ingresosBrutos             	-- 9	.Carga.Transporte.ingresosBrutos         		VARCHAR(13)
				, Transporte_5.telefono                        AS Transporte_5_telefono                   	-- 10	.Carga.Transporte.telefono               		VARCHAR(50)
				, Transporte_5.fax                             AS Transporte_5_fax                        	-- 11	.Carga.Transporte.fax                    		VARCHAR(50)
				, CodigoPostal_12.id                           AS CodigoPostal_12_id                      	-- 12	.Carga.Transporte.CodigoPostal.id        		VARCHAR(36)
				, CodigoPostal_12.codigo                       AS CodigoPostal_12_codigo                  	-- 13	.Carga.Transporte.CodigoPostal.codigo    		VARCHAR(12)
				, CodigoPostal_12.numero                       AS CodigoPostal_12_numero                  	-- 14	.Carga.Transporte.CodigoPostal.numero    		INTEGER
				, CodigoPostal_12.nombreCalle                  AS CodigoPostal_12_nombreCalle             	-- 15	.Carga.Transporte.CodigoPostal.nombreCalle		VARCHAR(200)
				, CodigoPostal_12.numeroCalle                  AS CodigoPostal_12_numeroCalle             	-- 16	.Carga.Transporte.CodigoPostal.numeroCalle		VARCHAR(20)
				, CodigoPostal_12.ciudad                       AS CodigoPostal_12_ciudad                  	-- 17	.Carga.Transporte.CodigoPostal.ciudad    		VARCHAR(36)	Ciudad.id
				, Transporte_5.domicilio                       AS Transporte_5_domicilio                  	-- 18	.Carga.Transporte.domicilio              		VARCHAR(150)
				, Transporte_5.comentario                      AS Transporte_5_comentario                 	-- 19	.Carga.Transporte.comentario             		VARCHAR(300)
				, Ciudad_20.id                                 AS Ciudad_20_id                            	-- 20	.Ciudad.id                               		VARCHAR(36)
				, Ciudad_20.numero                             AS Ciudad_20_numero                        	-- 21	.Ciudad.numero                           		INTEGER
				, Ciudad_20.nombre                             AS Ciudad_20_nombre                        	-- 22	.Ciudad.nombre                           		VARCHAR(50)
				, Ciudad_20.departamento                       AS Ciudad_20_departamento                  	-- 23	.Ciudad.departamento                     		VARCHAR(50)
				, Ciudad_20.numeroAFIP                         AS Ciudad_20_numeroAFIP                    	-- 24	.Ciudad.numeroAFIP                       		INTEGER
				, Provincia_25.id                              AS Provincia_25_id                         	-- 25	.Ciudad.Provincia.id                     		VARCHAR(36)
				, Provincia_25.numero                          AS Provincia_25_numero                     	-- 26	.Ciudad.Provincia.numero                 		INTEGER
				, Provincia_25.nombre                          AS Provincia_25_nombre                     	-- 27	.Ciudad.Provincia.nombre                 		VARCHAR(50)
				, Provincia_25.abreviatura                     AS Provincia_25_abreviatura                	-- 28	.Ciudad.Provincia.abreviatura            		VARCHAR(5)
				, Provincia_25.numeroAFIP                      AS Provincia_25_numeroAFIP                 	-- 29	.Ciudad.Provincia.numeroAFIP             		INTEGER
				, Provincia_25.numeroIngresosBrutos            AS Provincia_25_numeroIngresosBrutos       	-- 30	.Ciudad.Provincia.numeroIngresosBrutos   		INTEGER
				, Provincia_25.numeroRENATEA                   AS Provincia_25_numeroRENATEA              	-- 31	.Ciudad.Provincia.numeroRENATEA          		INTEGER
				, Pais_32.id                                   AS Pais_32_id                              	-- 32	.Ciudad.Provincia.Pais.id                		VARCHAR(36)
				, Pais_32.numero                               AS Pais_32_numero                          	-- 33	.Ciudad.Provincia.Pais.numero            		INTEGER
				, Pais_32.nombre                               AS Pais_32_nombre                          	-- 34	.Ciudad.Provincia.Pais.nombre            		VARCHAR(50)
				, Pais_32.abreviatura                          AS Pais_32_abreviatura                     	-- 35	.Ciudad.Provincia.Pais.abreviatura       		VARCHAR(5)
				, TransporteTarifa.precioFlete                 AS TransporteTarifa_precioFlete            	-- 36	.precioFlete                             		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadFacturacion     AS TransporteTarifa_precioUnidadFacturacion	-- 37	.precioUnidadFacturacion                 		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadStock           AS TransporteTarifa_precioUnidadStock      	-- 38	.precioUnidadStock                       		DECIMAL(13,5)
				, TransporteTarifa.precioBultos                AS TransporteTarifa_precioBultos           	-- 39	.precioBultos                            		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoEntrega        AS TransporteTarifa_importeMinimoEntrega   	-- 40	.importeMinimoEntrega                    		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoCarga          AS TransporteTarifa_importeMinimoCarga     	-- 41	.importeMinimoCarga                      		DECIMAL(13,5)

		FROM	massoftware.TransporteTarifa
			LEFT JOIN massoftware.Carga AS Carga_2                      ON TransporteTarifa.carga = Carga_2.id 	-- 2 LEFT LEVEL: 1
				LEFT JOIN massoftware.Transporte AS Transporte_5                ON Carga_2.transporte = Transporte_5.id 	-- 5 LEFT LEVEL: 2
					LEFT JOIN massoftware.CodigoPostal AS CodigoPostal_12             ON Transporte_5.codigoPostal = CodigoPostal_12.id 	-- 12 LEFT LEVEL: 3
			LEFT JOIN massoftware.Ciudad AS Ciudad_20                    ON TransporteTarifa.ciudad = Ciudad_20.id 	-- 20 LEFT LEVEL: 1
				LEFT JOIN massoftware.Provincia AS Provincia_25                 ON Ciudad_20.provincia = Provincia_25.id 	-- 25 LEFT LEVEL: 2
					LEFT JOIN massoftware.Pais AS Pais_32                     ON Provincia_25.pais = Pais_32.id 	-- 32 LEFT LEVEL: 3

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TransporteTarifa.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
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

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById_3 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById_3 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_TransporteTarifa_3 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TransporteTarifa_3 ( idArg , null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_TransporteTarifa_3 ( null , null, null, null, null); 

-- SELECT * FROM massoftware.f_TransporteTarifaById_3 ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoDocumentoAFIP                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoDocumentoAFIP



DROP FUNCTION IF EXISTS massoftware.f_TipoDocumentoAFIP (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoDocumentoAFIP (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.TipoDocumentoAFIP AS $$

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
				  TipoDocumentoAFIP.id        AS TipoDocumentoAFIP_id    	-- 0	.id   		VARCHAR(36)
				, TipoDocumentoAFIP.numero    AS TipoDocumentoAFIP_numero	-- 1	.numero		INTEGER
				, TipoDocumentoAFIP.nombre    AS TipoDocumentoAFIP_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.TipoDocumentoAFIP

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TipoDocumentoAFIP.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' TipoDocumentoAFIP.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' TipoDocumentoAFIP.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(TipoDocumentoAFIP.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_TipoDocumentoAFIPById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoDocumentoAFIPById (idArg VARCHAR(36)) RETURNS SETOF massoftware.TipoDocumentoAFIP AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TipoDocumentoAFIP ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_TipoDocumentoAFIP ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_TipoDocumentoAFIPById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MonedaAFIP                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MonedaAFIP



DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIP (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, codigoArg5        VARCHAR(3) 	-- 5
	, nombreArg6        VARCHAR(50)	-- 6

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIP (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, codigoArg5        VARCHAR(3) 	-- 5
	, nombreArg6        VARCHAR(50)	-- 6

) RETURNS SETOF massoftware.MonedaAFIP AS $$

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
				  MonedaAFIP.id        AS MonedaAFIP_id    	-- 0	.id   		VARCHAR(36)
				, MonedaAFIP.codigo    AS MonedaAFIP_codigo	-- 1	.codigo		VARCHAR(3)
				, MonedaAFIP.nombre    AS MonedaAFIP_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.MonedaAFIP

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' MonedaAFIP.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND codigoArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(codigoArg5)) > 0 THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		codigoArg5 = REPLACE(codigoArg5, '''', '''''');
		codigoArg5 = LOWER(TRIM(codigoArg5));
		sqlSrcWhere = sqlSrcWhere || ' LOWER(MonedaAFIP.codigo) = ''' || codigoArg5 || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MonedaAFIP.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIPById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIPById (idArg VARCHAR(36)) RETURNS SETOF massoftware.MonedaAFIP AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_MonedaAFIP ( idArg , null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_MonedaAFIP ( null , null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_MonedaAFIPById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: NotaCreditoMotivo                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.NotaCreditoMotivo



DROP FUNCTION IF EXISTS massoftware.f_NotaCreditoMotivo (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_NotaCreditoMotivo (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.NotaCreditoMotivo AS $$

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
				  NotaCreditoMotivo.id        AS NotaCreditoMotivo_id    	-- 0	.id   		VARCHAR(36)
				, NotaCreditoMotivo.numero    AS NotaCreditoMotivo_numero	-- 1	.numero		INTEGER
				, NotaCreditoMotivo.nombre    AS NotaCreditoMotivo_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.NotaCreditoMotivo

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' NotaCreditoMotivo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' NotaCreditoMotivo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' NotaCreditoMotivo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(NotaCreditoMotivo.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_NotaCreditoMotivoById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_NotaCreditoMotivoById (idArg VARCHAR(36)) RETURNS SETOF massoftware.NotaCreditoMotivo AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_NotaCreditoMotivo ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_NotaCreditoMotivo ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_NotaCreditoMotivoById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoComentario                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoComentario



DROP FUNCTION IF EXISTS massoftware.f_MotivoComentario (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentario (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.MotivoComentario AS $$

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
				  MotivoComentario.id        AS MotivoComentario_id    	-- 0	.id   		VARCHAR(36)
				, MotivoComentario.numero    AS MotivoComentario_numero	-- 1	.numero		INTEGER
				, MotivoComentario.nombre    AS MotivoComentario_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.MotivoComentario

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' MotivoComentario.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MotivoComentario.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MotivoComentario.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MotivoComentario.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_MotivoComentarioById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoComentarioById (idArg VARCHAR(36)) RETURNS SETOF massoftware.MotivoComentario AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_MotivoComentario ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_MotivoComentario ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_MotivoComentarioById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoCliente                                                                                            //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoCliente



DROP FUNCTION IF EXISTS massoftware.f_TipoCliente (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoCliente (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.TipoCliente AS $$

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
				  TipoCliente.id        AS TipoCliente_id    	-- 0	.id   		VARCHAR(36)
				, TipoCliente.numero    AS TipoCliente_numero	-- 1	.numero		INTEGER
				, TipoCliente.nombre    AS TipoCliente_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.TipoCliente

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TipoCliente.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' TipoCliente.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' TipoCliente.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(TipoCliente.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_TipoClienteById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoClienteById (idArg VARCHAR(36)) RETURNS SETOF massoftware.TipoCliente AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TipoCliente ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_TipoCliente ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_TipoClienteById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ClasificacionCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ClasificacionCliente



DROP FUNCTION IF EXISTS massoftware.f_ClasificacionCliente (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionCliente (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.ClasificacionCliente AS $$

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
				  ClasificacionCliente.id        AS ClasificacionCliente_id    	-- 0	.id   		VARCHAR(36)
				, ClasificacionCliente.numero    AS ClasificacionCliente_numero	-- 1	.numero		INTEGER
				, ClasificacionCliente.nombre    AS ClasificacionCliente_nombre	-- 2	.nombre		VARCHAR(50)
				, ClasificacionCliente.color     AS ClasificacionCliente_color 	-- 3	.color		INTEGER

		FROM	massoftware.ClasificacionCliente

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' ClasificacionCliente.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ClasificacionCliente.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ClasificacionCliente.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(ClasificacionCliente.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_ClasificacionClienteById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionClienteById (idArg VARCHAR(36)) RETURNS SETOF massoftware.ClasificacionCliente AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_ClasificacionCliente ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_ClasificacionCliente ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_ClasificacionClienteById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoBloqueoCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoBloqueoCliente



DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente (

	  idArg0                     VARCHAR(36)	-- 0
	, orderByArg1                INTEGER    	-- 1
	, orderByDescArg2            BOOLEAN    	-- 2
	, limitArg3                  BIGINT     	-- 3
	, offSetArg4                 BIGINT     	-- 4
	, numeroFromArg5             INTEGER    	-- 5
	, numeroToArg6               INTEGER    	-- 6
	, nombreArg7                 VARCHAR(50)	-- 7
	, clasificacionClienteArg8   VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente (

	  idArg0                     VARCHAR(36)	-- 0
	, orderByArg1                INTEGER    	-- 1
	, orderByDescArg2            BOOLEAN    	-- 2
	, limitArg3                  BIGINT     	-- 3
	, offSetArg4                 BIGINT     	-- 4
	, numeroFromArg5             INTEGER    	-- 5
	, numeroToArg6               INTEGER    	-- 6
	, nombreArg7                 VARCHAR(50)	-- 7
	, clasificacionClienteArg8   VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.MotivoBloqueoCliente AS $$

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
				  MotivoBloqueoCliente.id                      AS MotivoBloqueoCliente_id                  	-- 0	.id                 		VARCHAR(36)
				, MotivoBloqueoCliente.numero                  AS MotivoBloqueoCliente_numero              	-- 1	.numero             		INTEGER
				, MotivoBloqueoCliente.nombre                  AS MotivoBloqueoCliente_nombre              	-- 2	.nombre             		VARCHAR(50)
				, MotivoBloqueoCliente.clasificacionCliente    AS MotivoBloqueoCliente_clasificacionCliente	-- 3	.clasificacionCliente		VARCHAR(36)	ClasificacionCliente.id

		FROM	massoftware.MotivoBloqueoCliente

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' MotivoBloqueoCliente.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MotivoBloqueoCliente.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MotivoBloqueoCliente.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MotivoBloqueoCliente.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND clasificacionClienteArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(clasificacionClienteArg8)) > 0 THEN
		clasificacionClienteArg8 = REPLACE(clasificacionClienteArg8, '''', '''''');
		clasificacionClienteArg8 = LOWER(TRIM(clasificacionClienteArg8));
		clasificacionClienteArg8 = TRANSLATE(clasificacionClienteArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(clasificacionClienteArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MotivoBloqueoCliente.clasificacionCliente),
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

DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoClienteById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoClienteById (idArg VARCHAR(36)) RETURNS SETOF massoftware.MotivoBloqueoCliente AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_MotivoBloqueoCliente ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_MotivoBloqueoCliente ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_MotivoBloqueoClienteById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoCliente_1 (

	  idArg0                     VARCHAR(36)	-- 0
	, orderByArg1                INTEGER    	-- 1
	, orderByDescArg2            BOOLEAN    	-- 2
	, limitArg3                  BIGINT     	-- 3
	, offSetArg4                 BIGINT     	-- 4
	, numeroFromArg5             INTEGER    	-- 5
	, numeroToArg6               INTEGER    	-- 6
	, nombreArg7                 VARCHAR(50)	-- 7
	, clasificacionClienteArg8   VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoCliente_1 (

	  idArg0                     VARCHAR(36)	-- 0
	, orderByArg1                INTEGER    	-- 1
	, orderByDescArg2            BOOLEAN    	-- 2
	, limitArg3                  BIGINT     	-- 3
	, offSetArg4                 BIGINT     	-- 4
	, numeroFromArg5             INTEGER    	-- 5
	, numeroToArg6               INTEGER    	-- 6
	, nombreArg7                 VARCHAR(50)	-- 7
	, clasificacionClienteArg8   VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_MotivoBloqueoCliente_1 AS $$

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
				  MotivoBloqueoCliente.id          AS MotivoBloqueoCliente_id      	-- 0	.id                        		VARCHAR(36)
				, MotivoBloqueoCliente.numero      AS MotivoBloqueoCliente_numero  	-- 1	.numero                    		INTEGER
				, MotivoBloqueoCliente.nombre      AS MotivoBloqueoCliente_nombre  	-- 2	.nombre                    		VARCHAR(50)
				, ClasificacionCliente_3.id        AS ClasificacionCliente_3_id    	-- 3	.ClasificacionCliente.id   		VARCHAR(36)
				, ClasificacionCliente_3.numero    AS ClasificacionCliente_3_numero	-- 4	.ClasificacionCliente.numero		INTEGER
				, ClasificacionCliente_3.nombre    AS ClasificacionCliente_3_nombre	-- 5	.ClasificacionCliente.nombre		VARCHAR(50)
				, ClasificacionCliente_3.color     AS ClasificacionCliente_3_color 	-- 6	.ClasificacionCliente.color		INTEGER

		FROM	massoftware.MotivoBloqueoCliente
			LEFT JOIN massoftware.ClasificacionCliente AS ClasificacionCliente_3        ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente_3.id 	-- 3 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' MotivoBloqueoCliente.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MotivoBloqueoCliente.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MotivoBloqueoCliente.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MotivoBloqueoCliente.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND clasificacionClienteArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(clasificacionClienteArg8)) > 0 THEN
		clasificacionClienteArg8 = REPLACE(clasificacionClienteArg8, '''', '''''');
		clasificacionClienteArg8 = LOWER(TRIM(clasificacionClienteArg8));
		clasificacionClienteArg8 = TRANSLATE(clasificacionClienteArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(clasificacionClienteArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MotivoBloqueoCliente.clasificacionCliente),
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

DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoClienteById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoClienteById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_MotivoBloqueoCliente_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_MotivoBloqueoCliente_1 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_MotivoBloqueoCliente_1 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_MotivoBloqueoClienteById_1 ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoSucursal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoSucursal



DROP FUNCTION IF EXISTS massoftware.f_TipoSucursal (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoSucursal (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.TipoSucursal AS $$

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
				  TipoSucursal.id        AS TipoSucursal_id    	-- 0	.id   		VARCHAR(36)
				, TipoSucursal.numero    AS TipoSucursal_numero	-- 1	.numero		INTEGER
				, TipoSucursal.nombre    AS TipoSucursal_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.TipoSucursal

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TipoSucursal.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' TipoSucursal.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' TipoSucursal.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(TipoSucursal.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_TipoSucursalById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoSucursalById (idArg VARCHAR(36)) RETURNS SETOF massoftware.TipoSucursal AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TipoSucursal ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_TipoSucursal ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_TipoSucursalById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Sucursal                                                                                               //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Sucursal



DROP FUNCTION IF EXISTS massoftware.f_Sucursal (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Sucursal (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.Sucursal AS $$

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
				  Sucursal.id                                    AS Sucursal_id                               	-- 0	.id                              		VARCHAR(36)
				, Sucursal.numero                                AS Sucursal_numero                           	-- 1	.numero                          		INTEGER
				, Sucursal.nombre                                AS Sucursal_nombre                           	-- 2	.nombre                          		VARCHAR(50)
				, Sucursal.abreviatura                           AS Sucursal_abreviatura                      	-- 3	.abreviatura                     		VARCHAR(5)
				, Sucursal.tipoSucursal                          AS Sucursal_tipoSucursal                     	-- 4	.tipoSucursal                    		VARCHAR(36)	TipoSucursal.id
				, Sucursal.cuentaClientesDesde                   AS Sucursal_cuentaClientesDesde              	-- 5	.cuentaClientesDesde             		VARCHAR(7)
				, Sucursal.cuentaClientesHasta                   AS Sucursal_cuentaClientesHasta              	-- 6	.cuentaClientesHasta             		VARCHAR(7)
				, Sucursal.cantidadCaracteresClientes            AS Sucursal_cantidadCaracteresClientes       	-- 7	.cantidadCaracteresClientes      		INTEGER
				, Sucursal.identificacionNumericaClientes        AS Sucursal_identificacionNumericaClientes   	-- 8	.identificacionNumericaClientes  		BOOLEAN
				, Sucursal.permiteCambiarClientes                AS Sucursal_permiteCambiarClientes           	-- 9	.permiteCambiarClientes          		BOOLEAN
				, Sucursal.cuentaProveedoresDesde                AS Sucursal_cuentaProveedoresDesde           	-- 10	.cuentaProveedoresDesde          		VARCHAR(6)
				, Sucursal.cuentaProveedoresHasta                AS Sucursal_cuentaProveedoresHasta           	-- 11	.cuentaProveedoresHasta          		VARCHAR(6)
				, Sucursal.cantidadCaracteresProveedores         AS Sucursal_cantidadCaracteresProveedores    	-- 12	.cantidadCaracteresProveedores   		INTEGER
				, Sucursal.identificacionNumericaProveedores     AS Sucursal_identificacionNumericaProveedores	-- 13	.identificacionNumericaProveedores		BOOLEAN
				, Sucursal.permiteCambiarProveedores             AS Sucursal_permiteCambiarProveedores        	-- 14	.permiteCambiarProveedores       		BOOLEAN
				, Sucursal.clientesOcacionalesDesde              AS Sucursal_clientesOcacionalesDesde         	-- 15	.clientesOcacionalesDesde        		INTEGER
				, Sucursal.clientesOcacionalesHasta              AS Sucursal_clientesOcacionalesHasta         	-- 16	.clientesOcacionalesHasta        		INTEGER
				, Sucursal.numeroCobranzaDesde                   AS Sucursal_numeroCobranzaDesde              	-- 17	.numeroCobranzaDesde             		INTEGER
				, Sucursal.numeroCobranzaHasta                   AS Sucursal_numeroCobranzaHasta              	-- 18	.numeroCobranzaHasta             		INTEGER

		FROM	massoftware.Sucursal

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Sucursal.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Sucursal.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Sucursal.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Sucursal.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_SucursalById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_SucursalById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Sucursal AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Sucursal ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Sucursal ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_SucursalById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Sucursal_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Sucursal_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.t_Sucursal_1 AS $$

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
				  Sucursal.id                                    AS Sucursal_id                               	-- 0	.id                              		VARCHAR(36)
				, Sucursal.numero                                AS Sucursal_numero                           	-- 1	.numero                          		INTEGER
				, Sucursal.nombre                                AS Sucursal_nombre                           	-- 2	.nombre                          		VARCHAR(50)
				, Sucursal.abreviatura                           AS Sucursal_abreviatura                      	-- 3	.abreviatura                     		VARCHAR(5)
				, TipoSucursal_4.id                              AS TipoSucursal_4_id                         	-- 4	.TipoSucursal.id                 		VARCHAR(36)
				, TipoSucursal_4.numero                          AS TipoSucursal_4_numero                     	-- 5	.TipoSucursal.numero             		INTEGER
				, TipoSucursal_4.nombre                          AS TipoSucursal_4_nombre                     	-- 6	.TipoSucursal.nombre             		VARCHAR(50)
				, Sucursal.cuentaClientesDesde                   AS Sucursal_cuentaClientesDesde              	-- 7	.cuentaClientesDesde             		VARCHAR(7)
				, Sucursal.cuentaClientesHasta                   AS Sucursal_cuentaClientesHasta              	-- 8	.cuentaClientesHasta             		VARCHAR(7)
				, Sucursal.cantidadCaracteresClientes            AS Sucursal_cantidadCaracteresClientes       	-- 9	.cantidadCaracteresClientes      		INTEGER
				, Sucursal.identificacionNumericaClientes        AS Sucursal_identificacionNumericaClientes   	-- 10	.identificacionNumericaClientes  		BOOLEAN
				, Sucursal.permiteCambiarClientes                AS Sucursal_permiteCambiarClientes           	-- 11	.permiteCambiarClientes          		BOOLEAN
				, Sucursal.cuentaProveedoresDesde                AS Sucursal_cuentaProveedoresDesde           	-- 12	.cuentaProveedoresDesde          		VARCHAR(6)
				, Sucursal.cuentaProveedoresHasta                AS Sucursal_cuentaProveedoresHasta           	-- 13	.cuentaProveedoresHasta          		VARCHAR(6)
				, Sucursal.cantidadCaracteresProveedores         AS Sucursal_cantidadCaracteresProveedores    	-- 14	.cantidadCaracteresProveedores   		INTEGER
				, Sucursal.identificacionNumericaProveedores     AS Sucursal_identificacionNumericaProveedores	-- 15	.identificacionNumericaProveedores		BOOLEAN
				, Sucursal.permiteCambiarProveedores             AS Sucursal_permiteCambiarProveedores        	-- 16	.permiteCambiarProveedores       		BOOLEAN
				, Sucursal.clientesOcacionalesDesde              AS Sucursal_clientesOcacionalesDesde         	-- 17	.clientesOcacionalesDesde        		INTEGER
				, Sucursal.clientesOcacionalesHasta              AS Sucursal_clientesOcacionalesHasta         	-- 18	.clientesOcacionalesHasta        		INTEGER
				, Sucursal.numeroCobranzaDesde                   AS Sucursal_numeroCobranzaDesde              	-- 19	.numeroCobranzaDesde             		INTEGER
				, Sucursal.numeroCobranzaHasta                   AS Sucursal_numeroCobranzaHasta              	-- 20	.numeroCobranzaHasta             		INTEGER

		FROM	massoftware.Sucursal
			LEFT JOIN massoftware.TipoSucursal AS TipoSucursal_4        ON Sucursal.tipoSucursal = TipoSucursal_4.id 	-- 4 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Sucursal.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Sucursal.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Sucursal.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Sucursal.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_SucursalById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_SucursalById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Sucursal_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Sucursal_1 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Sucursal_1 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_SucursalById_1 ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: DepositoModulo                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.DepositoModulo



DROP FUNCTION IF EXISTS massoftware.f_DepositoModulo (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_DepositoModulo (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.DepositoModulo AS $$

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
				  DepositoModulo.id        AS DepositoModulo_id    	-- 0	.id   		VARCHAR(36)
				, DepositoModulo.numero    AS DepositoModulo_numero	-- 1	.numero		INTEGER
				, DepositoModulo.nombre    AS DepositoModulo_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.DepositoModulo

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' DepositoModulo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' DepositoModulo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' DepositoModulo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(DepositoModulo.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_DepositoModuloById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_DepositoModuloById (idArg VARCHAR(36)) RETURNS SETOF massoftware.DepositoModulo AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_DepositoModulo ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_DepositoModulo ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_DepositoModuloById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Deposito                                                                                               //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Deposito



DROP FUNCTION IF EXISTS massoftware.f_Deposito (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, sucursalArg8      VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Deposito (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, sucursalArg8      VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.Deposito AS $$

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
				  Deposito.id                 AS Deposito_id             	-- 0	.id            		VARCHAR(36)
				, Deposito.numero             AS Deposito_numero         	-- 1	.numero        		INTEGER
				, Deposito.nombre             AS Deposito_nombre         	-- 2	.nombre        		VARCHAR(50)
				, Deposito.abreviatura        AS Deposito_abreviatura    	-- 3	.abreviatura   		VARCHAR(5)
				, Deposito.sucursal           AS Deposito_sucursal       	-- 4	.sucursal      		VARCHAR(36)	Sucursal.id
				, Deposito.depositoModulo     AS Deposito_depositoModulo 	-- 5	.depositoModulo		VARCHAR(36)	DepositoModulo.id
				, Deposito.puertaOperativo    AS Deposito_puertaOperativo	-- 6	.puertaOperativo		VARCHAR(36)	SeguridadPuerta.id
				, Deposito.puertaConsulta     AS Deposito_puertaConsulta 	-- 7	.puertaConsulta		VARCHAR(36)	SeguridadPuerta.id

		FROM	massoftware.Deposito

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Deposito.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Deposito.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Deposito.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Deposito.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND sucursalArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(sucursalArg8)) > 0 THEN
		sucursalArg8 = REPLACE(sucursalArg8, '''', '''''');
		sucursalArg8 = LOWER(TRIM(sucursalArg8));
		sucursalArg8 = TRANSLATE(sucursalArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(sucursalArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Deposito.sucursal),
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

DROP FUNCTION IF EXISTS massoftware.f_DepositoById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_DepositoById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Deposito AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Deposito ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Deposito ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_DepositoById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Deposito_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, sucursalArg8      VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Deposito_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, sucursalArg8      VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_Deposito_1 AS $$

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
				  Deposito.id                                      AS Deposito_id                                 	-- 0	.id                                       		VARCHAR(36)
				, Deposito.numero                                  AS Deposito_numero                             	-- 1	.numero                                   		INTEGER
				, Deposito.nombre                                  AS Deposito_nombre                             	-- 2	.nombre                                   		VARCHAR(50)
				, Deposito.abreviatura                             AS Deposito_abreviatura                        	-- 3	.abreviatura                              		VARCHAR(5)
				, Sucursal_4.id                                    AS Sucursal_4_id                               	-- 4	.Sucursal.id                              		VARCHAR(36)
				, Sucursal_4.numero                                AS Sucursal_4_numero                           	-- 5	.Sucursal.numero                          		INTEGER
				, Sucursal_4.nombre                                AS Sucursal_4_nombre                           	-- 6	.Sucursal.nombre                          		VARCHAR(50)
				, Sucursal_4.abreviatura                           AS Sucursal_4_abreviatura                      	-- 7	.Sucursal.abreviatura                     		VARCHAR(5)
				, Sucursal_4.tipoSucursal                          AS Sucursal_4_tipoSucursal                     	-- 8	.Sucursal.tipoSucursal                    		VARCHAR(36)	TipoSucursal.id
				, Sucursal_4.cuentaClientesDesde                   AS Sucursal_4_cuentaClientesDesde              	-- 9	.Sucursal.cuentaClientesDesde             		VARCHAR(7)
				, Sucursal_4.cuentaClientesHasta                   AS Sucursal_4_cuentaClientesHasta              	-- 10	.Sucursal.cuentaClientesHasta             		VARCHAR(7)
				, Sucursal_4.cantidadCaracteresClientes            AS Sucursal_4_cantidadCaracteresClientes       	-- 11	.Sucursal.cantidadCaracteresClientes      		INTEGER
				, Sucursal_4.identificacionNumericaClientes        AS Sucursal_4_identificacionNumericaClientes   	-- 12	.Sucursal.identificacionNumericaClientes  		BOOLEAN
				, Sucursal_4.permiteCambiarClientes                AS Sucursal_4_permiteCambiarClientes           	-- 13	.Sucursal.permiteCambiarClientes          		BOOLEAN
				, Sucursal_4.cuentaProveedoresDesde                AS Sucursal_4_cuentaProveedoresDesde           	-- 14	.Sucursal.cuentaProveedoresDesde          		VARCHAR(6)
				, Sucursal_4.cuentaProveedoresHasta                AS Sucursal_4_cuentaProveedoresHasta           	-- 15	.Sucursal.cuentaProveedoresHasta          		VARCHAR(6)
				, Sucursal_4.cantidadCaracteresProveedores         AS Sucursal_4_cantidadCaracteresProveedores    	-- 16	.Sucursal.cantidadCaracteresProveedores   		INTEGER
				, Sucursal_4.identificacionNumericaProveedores     AS Sucursal_4_identificacionNumericaProveedores	-- 17	.Sucursal.identificacionNumericaProveedores		BOOLEAN
				, Sucursal_4.permiteCambiarProveedores             AS Sucursal_4_permiteCambiarProveedores        	-- 18	.Sucursal.permiteCambiarProveedores       		BOOLEAN
				, Sucursal_4.clientesOcacionalesDesde              AS Sucursal_4_clientesOcacionalesDesde         	-- 19	.Sucursal.clientesOcacionalesDesde        		INTEGER
				, Sucursal_4.clientesOcacionalesHasta              AS Sucursal_4_clientesOcacionalesHasta         	-- 20	.Sucursal.clientesOcacionalesHasta        		INTEGER
				, Sucursal_4.numeroCobranzaDesde                   AS Sucursal_4_numeroCobranzaDesde              	-- 21	.Sucursal.numeroCobranzaDesde             		INTEGER
				, Sucursal_4.numeroCobranzaHasta                   AS Sucursal_4_numeroCobranzaHasta              	-- 22	.Sucursal.numeroCobranzaHasta             		INTEGER
				, DepositoModulo_23.id                             AS DepositoModulo_23_id                        	-- 23	.DepositoModulo.id                        		VARCHAR(36)
				, DepositoModulo_23.numero                         AS DepositoModulo_23_numero                    	-- 24	.DepositoModulo.numero                    		INTEGER
				, DepositoModulo_23.nombre                         AS DepositoModulo_23_nombre                    	-- 25	.DepositoModulo.nombre                    		VARCHAR(50)
				, SeguridadPuerta_26.id                            AS SeguridadPuerta_26_id                       	-- 26	.SeguridadPuerta.id                       		VARCHAR(36)
				, SeguridadPuerta_26.numero                        AS SeguridadPuerta_26_numero                   	-- 27	.SeguridadPuerta.numero                   		INTEGER
				, SeguridadPuerta_26.nombre                        AS SeguridadPuerta_26_nombre                   	-- 28	.SeguridadPuerta.nombre                   		VARCHAR(50)
				, SeguridadPuerta_26.equate                        AS SeguridadPuerta_26_equate                   	-- 29	.SeguridadPuerta.equate                   		VARCHAR(30)
				, SeguridadPuerta_26.seguridadModulo               AS SeguridadPuerta_26_seguridadModulo          	-- 30	.SeguridadPuerta.seguridadModulo          		VARCHAR(36)	SeguridadModulo.id
				, SeguridadPuerta_31.id                            AS SeguridadPuerta_31_id                       	-- 31	.SeguridadPuerta.id                       		VARCHAR(36)
				, SeguridadPuerta_31.numero                        AS SeguridadPuerta_31_numero                   	-- 32	.SeguridadPuerta.numero                   		INTEGER
				, SeguridadPuerta_31.nombre                        AS SeguridadPuerta_31_nombre                   	-- 33	.SeguridadPuerta.nombre                   		VARCHAR(50)
				, SeguridadPuerta_31.equate                        AS SeguridadPuerta_31_equate                   	-- 34	.SeguridadPuerta.equate                   		VARCHAR(30)
				, SeguridadPuerta_31.seguridadModulo               AS SeguridadPuerta_31_seguridadModulo          	-- 35	.SeguridadPuerta.seguridadModulo          		VARCHAR(36)	SeguridadModulo.id

		FROM	massoftware.Deposito
			LEFT JOIN massoftware.Sucursal AS Sucursal_4                ON Deposito.sucursal = Sucursal_4.id 	-- 4 LEFT LEVEL: 1
			LEFT JOIN massoftware.DepositoModulo AS DepositoModulo_23         ON Deposito.depositoModulo = DepositoModulo_23.id 	-- 23 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_26        ON Deposito.puertaOperativo = SeguridadPuerta_26.id 	-- 26 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_31        ON Deposito.puertaConsulta = SeguridadPuerta_31.id 	-- 31 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Deposito.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Deposito.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Deposito.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Deposito.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND sucursalArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(sucursalArg8)) > 0 THEN
		sucursalArg8 = REPLACE(sucursalArg8, '''', '''''');
		sucursalArg8 = LOWER(TRIM(sucursalArg8));
		sucursalArg8 = TRANSLATE(sucursalArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(sucursalArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Deposito.sucursal),
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

DROP FUNCTION IF EXISTS massoftware.f_DepositoById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_DepositoById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Deposito_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Deposito_1 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Deposito_1 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_DepositoById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Deposito_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, sucursalArg8      VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Deposito_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, sucursalArg8      VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_Deposito_2 AS $$

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
				  Deposito.id                                      AS Deposito_id                                 	-- 0	.id                                       		VARCHAR(36)
				, Deposito.numero                                  AS Deposito_numero                             	-- 1	.numero                                   		INTEGER
				, Deposito.nombre                                  AS Deposito_nombre                             	-- 2	.nombre                                   		VARCHAR(50)
				, Deposito.abreviatura                             AS Deposito_abreviatura                        	-- 3	.abreviatura                              		VARCHAR(5)
				, Sucursal_4.id                                    AS Sucursal_4_id                               	-- 4	.Sucursal.id                              		VARCHAR(36)
				, Sucursal_4.numero                                AS Sucursal_4_numero                           	-- 5	.Sucursal.numero                          		INTEGER
				, Sucursal_4.nombre                                AS Sucursal_4_nombre                           	-- 6	.Sucursal.nombre                          		VARCHAR(50)
				, Sucursal_4.abreviatura                           AS Sucursal_4_abreviatura                      	-- 7	.Sucursal.abreviatura                     		VARCHAR(5)
				, TipoSucursal_8.id                                AS TipoSucursal_8_id                           	-- 8	.Sucursal.TipoSucursal.id                 		VARCHAR(36)
				, TipoSucursal_8.numero                            AS TipoSucursal_8_numero                       	-- 9	.Sucursal.TipoSucursal.numero             		INTEGER
				, TipoSucursal_8.nombre                            AS TipoSucursal_8_nombre                       	-- 10	.Sucursal.TipoSucursal.nombre             		VARCHAR(50)
				, Sucursal_4.cuentaClientesDesde                   AS Sucursal_4_cuentaClientesDesde              	-- 11	.Sucursal.cuentaClientesDesde             		VARCHAR(7)
				, Sucursal_4.cuentaClientesHasta                   AS Sucursal_4_cuentaClientesHasta              	-- 12	.Sucursal.cuentaClientesHasta             		VARCHAR(7)
				, Sucursal_4.cantidadCaracteresClientes            AS Sucursal_4_cantidadCaracteresClientes       	-- 13	.Sucursal.cantidadCaracteresClientes      		INTEGER
				, Sucursal_4.identificacionNumericaClientes        AS Sucursal_4_identificacionNumericaClientes   	-- 14	.Sucursal.identificacionNumericaClientes  		BOOLEAN
				, Sucursal_4.permiteCambiarClientes                AS Sucursal_4_permiteCambiarClientes           	-- 15	.Sucursal.permiteCambiarClientes          		BOOLEAN
				, Sucursal_4.cuentaProveedoresDesde                AS Sucursal_4_cuentaProveedoresDesde           	-- 16	.Sucursal.cuentaProveedoresDesde          		VARCHAR(6)
				, Sucursal_4.cuentaProveedoresHasta                AS Sucursal_4_cuentaProveedoresHasta           	-- 17	.Sucursal.cuentaProveedoresHasta          		VARCHAR(6)
				, Sucursal_4.cantidadCaracteresProveedores         AS Sucursal_4_cantidadCaracteresProveedores    	-- 18	.Sucursal.cantidadCaracteresProveedores   		INTEGER
				, Sucursal_4.identificacionNumericaProveedores     AS Sucursal_4_identificacionNumericaProveedores	-- 19	.Sucursal.identificacionNumericaProveedores		BOOLEAN
				, Sucursal_4.permiteCambiarProveedores             AS Sucursal_4_permiteCambiarProveedores        	-- 20	.Sucursal.permiteCambiarProveedores       		BOOLEAN
				, Sucursal_4.clientesOcacionalesDesde              AS Sucursal_4_clientesOcacionalesDesde         	-- 21	.Sucursal.clientesOcacionalesDesde        		INTEGER
				, Sucursal_4.clientesOcacionalesHasta              AS Sucursal_4_clientesOcacionalesHasta         	-- 22	.Sucursal.clientesOcacionalesHasta        		INTEGER
				, Sucursal_4.numeroCobranzaDesde                   AS Sucursal_4_numeroCobranzaDesde              	-- 23	.Sucursal.numeroCobranzaDesde             		INTEGER
				, Sucursal_4.numeroCobranzaHasta                   AS Sucursal_4_numeroCobranzaHasta              	-- 24	.Sucursal.numeroCobranzaHasta             		INTEGER
				, DepositoModulo_25.id                             AS DepositoModulo_25_id                        	-- 25	.DepositoModulo.id                        		VARCHAR(36)
				, DepositoModulo_25.numero                         AS DepositoModulo_25_numero                    	-- 26	.DepositoModulo.numero                    		INTEGER
				, DepositoModulo_25.nombre                         AS DepositoModulo_25_nombre                    	-- 27	.DepositoModulo.nombre                    		VARCHAR(50)
				, SeguridadPuerta_28.id                            AS SeguridadPuerta_28_id                       	-- 28	.SeguridadPuerta.id                       		VARCHAR(36)
				, SeguridadPuerta_28.numero                        AS SeguridadPuerta_28_numero                   	-- 29	.SeguridadPuerta.numero                   		INTEGER
				, SeguridadPuerta_28.nombre                        AS SeguridadPuerta_28_nombre                   	-- 30	.SeguridadPuerta.nombre                   		VARCHAR(50)
				, SeguridadPuerta_28.equate                        AS SeguridadPuerta_28_equate                   	-- 31	.SeguridadPuerta.equate                   		VARCHAR(30)
				, SeguridadModulo_32.id                            AS SeguridadModulo_32_id                       	-- 32	.SeguridadPuerta.SeguridadModulo.id       		VARCHAR(36)
				, SeguridadModulo_32.numero                        AS SeguridadModulo_32_numero                   	-- 33	.SeguridadPuerta.SeguridadModulo.numero   		INTEGER
				, SeguridadModulo_32.nombre                        AS SeguridadModulo_32_nombre                   	-- 34	.SeguridadPuerta.SeguridadModulo.nombre   		VARCHAR(50)
				, SeguridadPuerta_35.id                            AS SeguridadPuerta_35_id                       	-- 35	.SeguridadPuerta.id                       		VARCHAR(36)
				, SeguridadPuerta_35.numero                        AS SeguridadPuerta_35_numero                   	-- 36	.SeguridadPuerta.numero                   		INTEGER
				, SeguridadPuerta_35.nombre                        AS SeguridadPuerta_35_nombre                   	-- 37	.SeguridadPuerta.nombre                   		VARCHAR(50)
				, SeguridadPuerta_35.equate                        AS SeguridadPuerta_35_equate                   	-- 38	.SeguridadPuerta.equate                   		VARCHAR(30)
				, SeguridadModulo_39.id                            AS SeguridadModulo_39_id                       	-- 39	.SeguridadPuerta.SeguridadModulo.id       		VARCHAR(36)
				, SeguridadModulo_39.numero                        AS SeguridadModulo_39_numero                   	-- 40	.SeguridadPuerta.SeguridadModulo.numero   		INTEGER
				, SeguridadModulo_39.nombre                        AS SeguridadModulo_39_nombre                   	-- 41	.SeguridadPuerta.SeguridadModulo.nombre   		VARCHAR(50)

		FROM	massoftware.Deposito
			LEFT JOIN massoftware.Sucursal AS Sucursal_4                   ON Deposito.sucursal = Sucursal_4.id 	-- 4 LEFT LEVEL: 1
				LEFT JOIN massoftware.TipoSucursal AS TipoSucursal_8              ON Sucursal_4.tipoSucursal = TipoSucursal_8.id 	-- 8 LEFT LEVEL: 2
			LEFT JOIN massoftware.DepositoModulo AS DepositoModulo_25            ON Deposito.depositoModulo = DepositoModulo_25.id 	-- 25 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_28           ON Deposito.puertaOperativo = SeguridadPuerta_28.id 	-- 28 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_32           ON SeguridadPuerta_28.seguridadModulo = SeguridadModulo_32.id 	-- 32 LEFT LEVEL: 2
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_35           ON Deposito.puertaConsulta = SeguridadPuerta_35.id 	-- 35 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_39           ON SeguridadPuerta_35.seguridadModulo = SeguridadModulo_39.id 	-- 39 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Deposito.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Deposito.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Deposito.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Deposito.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND sucursalArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(sucursalArg8)) > 0 THEN
		sucursalArg8 = REPLACE(sucursalArg8, '''', '''''');
		sucursalArg8 = LOWER(TRIM(sucursalArg8));
		sucursalArg8 = TRANSLATE(sucursalArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(sucursalArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Deposito.sucursal),
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

DROP FUNCTION IF EXISTS massoftware.f_DepositoById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_DepositoById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Deposito_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Deposito_2 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Deposito_2 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_DepositoById_2 ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: EjercicioContable                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.EjercicioContable



DROP FUNCTION IF EXISTS massoftware.f_EjercicioContable (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_EjercicioContable (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6

) RETURNS SETOF massoftware.EjercicioContable AS $$

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
				  EjercicioContable.id                AS EjercicioContable_id            	-- 0	.id           		VARCHAR(36)
				, EjercicioContable.numero            AS EjercicioContable_numero        	-- 1	.numero       		INTEGER
				, EjercicioContable.apertura          AS EjercicioContable_apertura      	-- 2	.apertura     		DATE
				, EjercicioContable.cierre            AS EjercicioContable_cierre        	-- 3	.cierre       		DATE
				, EjercicioContable.cerrado           AS EjercicioContable_cerrado       	-- 4	.cerrado      		BOOLEAN
				, EjercicioContable.cerradoModulos    AS EjercicioContable_cerradoModulos	-- 5	.cerradoModulos		BOOLEAN
				, EjercicioContable.comentario        AS EjercicioContable_comentario    	-- 6	.comentario   		VARCHAR(250)

		FROM	massoftware.EjercicioContable

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' EjercicioContable.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' EjercicioContable.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' EjercicioContable.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
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

DROP FUNCTION IF EXISTS massoftware.f_EjercicioContableById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_EjercicioContableById (idArg VARCHAR(36)) RETURNS SETOF massoftware.EjercicioContable AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_EjercicioContable ( idArg , null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_EjercicioContable ( null , null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_EjercicioContableById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CentroCostoContable                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CentroCostoContable



DROP FUNCTION IF EXISTS massoftware.f_CentroCostoContable (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, numeroFromArg5          INTEGER    	-- 5
	, numeroToArg6            INTEGER    	-- 6
	, nombreArg7              VARCHAR(50)	-- 7
	, abreviaturaArg8         VARCHAR(5) 	-- 8
	, ejercicioContableArg9   VARCHAR(36)	-- 9

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CentroCostoContable (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, numeroFromArg5          INTEGER    	-- 5
	, numeroToArg6            INTEGER    	-- 6
	, nombreArg7              VARCHAR(50)	-- 7
	, abreviaturaArg8         VARCHAR(5) 	-- 8
	, ejercicioContableArg9   VARCHAR(36)	-- 9

) RETURNS SETOF massoftware.CentroCostoContable AS $$

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
				  CentroCostoContable.id                   AS CentroCostoContable_id               	-- 0	.id              		VARCHAR(36)
				, CentroCostoContable.numero               AS CentroCostoContable_numero           	-- 1	.numero          		INTEGER
				, CentroCostoContable.nombre               AS CentroCostoContable_nombre           	-- 2	.nombre          		VARCHAR(50)
				, CentroCostoContable.abreviatura          AS CentroCostoContable_abreviatura      	-- 3	.abreviatura     		VARCHAR(5)
				, CentroCostoContable.ejercicioContable    AS CentroCostoContable_ejercicioContable	-- 4	.ejercicioContable		VARCHAR(36)	EjercicioContable.id

		FROM	massoftware.CentroCostoContable

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CentroCostoContable.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CentroCostoContable.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CentroCostoContable.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CentroCostoContable.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND abreviaturaArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(abreviaturaArg8)) > 0 THEN
		abreviaturaArg8 = REPLACE(abreviaturaArg8, '''', '''''');
		abreviaturaArg8 = LOWER(TRIM(abreviaturaArg8));
		abreviaturaArg8 = TRANSLATE(abreviaturaArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(abreviaturaArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CentroCostoContable.abreviatura),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND ejercicioContableArg9 IS NOT NULL AND CHAR_LENGTH(TRIM(ejercicioContableArg9)) > 0 THEN
		ejercicioContableArg9 = REPLACE(ejercicioContableArg9, '''', '''''');
		ejercicioContableArg9 = LOWER(TRIM(ejercicioContableArg9));
		ejercicioContableArg9 = TRANSLATE(ejercicioContableArg9,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ejercicioContableArg9, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CentroCostoContable.ejercicioContable),
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

DROP FUNCTION IF EXISTS massoftware.f_CentroCostoContableById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CentroCostoContableById (idArg VARCHAR(36)) RETURNS SETOF massoftware.CentroCostoContable AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CentroCostoContable ( idArg , null, null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CentroCostoContable ( null , null, null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CentroCostoContableById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_CentroCostoContable_1 (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, numeroFromArg5          INTEGER    	-- 5
	, numeroToArg6            INTEGER    	-- 6
	, nombreArg7              VARCHAR(50)	-- 7
	, abreviaturaArg8         VARCHAR(5) 	-- 8
	, ejercicioContableArg9   VARCHAR(36)	-- 9

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CentroCostoContable_1 (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, numeroFromArg5          INTEGER    	-- 5
	, numeroToArg6            INTEGER    	-- 6
	, nombreArg7              VARCHAR(50)	-- 7
	, abreviaturaArg8         VARCHAR(5) 	-- 8
	, ejercicioContableArg9   VARCHAR(36)	-- 9

) RETURNS SETOF massoftware.t_CentroCostoContable_1 AS $$

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
				  CentroCostoContable.id                AS CentroCostoContable_id            	-- 0	.id                             		VARCHAR(36)
				, CentroCostoContable.numero            AS CentroCostoContable_numero        	-- 1	.numero                         		INTEGER
				, CentroCostoContable.nombre            AS CentroCostoContable_nombre        	-- 2	.nombre                         		VARCHAR(50)
				, CentroCostoContable.abreviatura       AS CentroCostoContable_abreviatura   	-- 3	.abreviatura                    		VARCHAR(5)
				, EjercicioContable_4.id                AS EjercicioContable_4_id            	-- 4	.EjercicioContable.id           		VARCHAR(36)
				, EjercicioContable_4.numero            AS EjercicioContable_4_numero        	-- 5	.EjercicioContable.numero       		INTEGER
				, EjercicioContable_4.apertura          AS EjercicioContable_4_apertura      	-- 6	.EjercicioContable.apertura     		DATE
				, EjercicioContable_4.cierre            AS EjercicioContable_4_cierre        	-- 7	.EjercicioContable.cierre       		DATE
				, EjercicioContable_4.cerrado           AS EjercicioContable_4_cerrado       	-- 8	.EjercicioContable.cerrado      		BOOLEAN
				, EjercicioContable_4.cerradoModulos    AS EjercicioContable_4_cerradoModulos	-- 9	.EjercicioContable.cerradoModulos		BOOLEAN
				, EjercicioContable_4.comentario        AS EjercicioContable_4_comentario    	-- 10	.EjercicioContable.comentario   		VARCHAR(250)

		FROM	massoftware.CentroCostoContable
			LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_4        ON CentroCostoContable.ejercicioContable = EjercicioContable_4.id 	-- 4 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CentroCostoContable.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CentroCostoContable.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CentroCostoContable.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CentroCostoContable.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND abreviaturaArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(abreviaturaArg8)) > 0 THEN
		abreviaturaArg8 = REPLACE(abreviaturaArg8, '''', '''''');
		abreviaturaArg8 = LOWER(TRIM(abreviaturaArg8));
		abreviaturaArg8 = TRANSLATE(abreviaturaArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(abreviaturaArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CentroCostoContable.abreviatura),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND ejercicioContableArg9 IS NOT NULL AND CHAR_LENGTH(TRIM(ejercicioContableArg9)) > 0 THEN
		ejercicioContableArg9 = REPLACE(ejercicioContableArg9, '''', '''''');
		ejercicioContableArg9 = LOWER(TRIM(ejercicioContableArg9));
		ejercicioContableArg9 = TRANSLATE(ejercicioContableArg9,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ejercicioContableArg9, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CentroCostoContable.ejercicioContable),
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

DROP FUNCTION IF EXISTS massoftware.f_CentroCostoContableById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CentroCostoContableById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_CentroCostoContable_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CentroCostoContable_1 ( idArg , null, null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CentroCostoContable_1 ( null , null, null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CentroCostoContableById_1 ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoPuntoEquilibrio                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoPuntoEquilibrio



DROP FUNCTION IF EXISTS massoftware.f_TipoPuntoEquilibrio (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoPuntoEquilibrio (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.TipoPuntoEquilibrio AS $$

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
				  TipoPuntoEquilibrio.id        AS TipoPuntoEquilibrio_id    	-- 0	.id   		VARCHAR(36)
				, TipoPuntoEquilibrio.numero    AS TipoPuntoEquilibrio_numero	-- 1	.numero		INTEGER
				, TipoPuntoEquilibrio.nombre    AS TipoPuntoEquilibrio_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.TipoPuntoEquilibrio

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TipoPuntoEquilibrio.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' TipoPuntoEquilibrio.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' TipoPuntoEquilibrio.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(TipoPuntoEquilibrio.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_TipoPuntoEquilibrioById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoPuntoEquilibrioById (idArg VARCHAR(36)) RETURNS SETOF massoftware.TipoPuntoEquilibrio AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TipoPuntoEquilibrio ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_TipoPuntoEquilibrio ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_TipoPuntoEquilibrioById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: PuntoEquilibrio                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.PuntoEquilibrio



DROP FUNCTION IF EXISTS massoftware.f_PuntoEquilibrio (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, numeroFromArg5          INTEGER    	-- 5
	, numeroToArg6            INTEGER    	-- 6
	, nombreArg7              VARCHAR(50)	-- 7
	, ejercicioContableArg8   VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_PuntoEquilibrio (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, numeroFromArg5          INTEGER    	-- 5
	, numeroToArg6            INTEGER    	-- 6
	, nombreArg7              VARCHAR(50)	-- 7
	, ejercicioContableArg8   VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.PuntoEquilibrio AS $$

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
				  PuntoEquilibrio.id                     AS PuntoEquilibrio_id                 	-- 0	.id                		VARCHAR(36)
				, PuntoEquilibrio.numero                 AS PuntoEquilibrio_numero             	-- 1	.numero            		INTEGER
				, PuntoEquilibrio.nombre                 AS PuntoEquilibrio_nombre             	-- 2	.nombre            		VARCHAR(50)
				, PuntoEquilibrio.tipoPuntoEquilibrio    AS PuntoEquilibrio_tipoPuntoEquilibrio	-- 3	.tipoPuntoEquilibrio		VARCHAR(36)	TipoPuntoEquilibrio.id
				, PuntoEquilibrio.ejercicioContable      AS PuntoEquilibrio_ejercicioContable  	-- 4	.ejercicioContable 		VARCHAR(36)	EjercicioContable.id

		FROM	massoftware.PuntoEquilibrio

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' PuntoEquilibrio.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' PuntoEquilibrio.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' PuntoEquilibrio.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(PuntoEquilibrio.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND ejercicioContableArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(ejercicioContableArg8)) > 0 THEN
		ejercicioContableArg8 = REPLACE(ejercicioContableArg8, '''', '''''');
		ejercicioContableArg8 = LOWER(TRIM(ejercicioContableArg8));
		ejercicioContableArg8 = TRANSLATE(ejercicioContableArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ejercicioContableArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(PuntoEquilibrio.ejercicioContable),
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

DROP FUNCTION IF EXISTS massoftware.f_PuntoEquilibrioById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_PuntoEquilibrioById (idArg VARCHAR(36)) RETURNS SETOF massoftware.PuntoEquilibrio AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_PuntoEquilibrio ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_PuntoEquilibrio ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_PuntoEquilibrioById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_PuntoEquilibrio_1 (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, numeroFromArg5          INTEGER    	-- 5
	, numeroToArg6            INTEGER    	-- 6
	, nombreArg7              VARCHAR(50)	-- 7
	, ejercicioContableArg8   VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_PuntoEquilibrio_1 (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, numeroFromArg5          INTEGER    	-- 5
	, numeroToArg6            INTEGER    	-- 6
	, nombreArg7              VARCHAR(50)	-- 7
	, ejercicioContableArg8   VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_PuntoEquilibrio_1 AS $$

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
				  PuntoEquilibrio.id                     AS PuntoEquilibrio_id                	-- 0	.id                             		VARCHAR(36)
				, PuntoEquilibrio.numero                 AS PuntoEquilibrio_numero            	-- 1	.numero                         		INTEGER
				, PuntoEquilibrio.nombre                 AS PuntoEquilibrio_nombre            	-- 2	.nombre                         		VARCHAR(50)
				, TipoPuntoEquilibrio_3.id               AS TipoPuntoEquilibrio_3_id          	-- 3	.TipoPuntoEquilibrio.id         		VARCHAR(36)
				, TipoPuntoEquilibrio_3.numero           AS TipoPuntoEquilibrio_3_numero      	-- 4	.TipoPuntoEquilibrio.numero     		INTEGER
				, TipoPuntoEquilibrio_3.nombre           AS TipoPuntoEquilibrio_3_nombre      	-- 5	.TipoPuntoEquilibrio.nombre     		VARCHAR(50)
				, EjercicioContable_6.id                 AS EjercicioContable_6_id            	-- 6	.EjercicioContable.id           		VARCHAR(36)
				, EjercicioContable_6.numero             AS EjercicioContable_6_numero        	-- 7	.EjercicioContable.numero       		INTEGER
				, EjercicioContable_6.apertura           AS EjercicioContable_6_apertura      	-- 8	.EjercicioContable.apertura     		DATE
				, EjercicioContable_6.cierre             AS EjercicioContable_6_cierre        	-- 9	.EjercicioContable.cierre       		DATE
				, EjercicioContable_6.cerrado            AS EjercicioContable_6_cerrado       	-- 10	.EjercicioContable.cerrado      		BOOLEAN
				, EjercicioContable_6.cerradoModulos     AS EjercicioContable_6_cerradoModulos	-- 11	.EjercicioContable.cerradoModulos		BOOLEAN
				, EjercicioContable_6.comentario         AS EjercicioContable_6_comentario    	-- 12	.EjercicioContable.comentario   		VARCHAR(250)

		FROM	massoftware.PuntoEquilibrio
			LEFT JOIN massoftware.TipoPuntoEquilibrio AS TipoPuntoEquilibrio_3        ON PuntoEquilibrio.tipoPuntoEquilibrio = TipoPuntoEquilibrio_3.id 	-- 3 LEFT LEVEL: 1
			LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_6          ON PuntoEquilibrio.ejercicioContable = EjercicioContable_6.id 	-- 6 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' PuntoEquilibrio.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' PuntoEquilibrio.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' PuntoEquilibrio.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(PuntoEquilibrio.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND ejercicioContableArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(ejercicioContableArg8)) > 0 THEN
		ejercicioContableArg8 = REPLACE(ejercicioContableArg8, '''', '''''');
		ejercicioContableArg8 = LOWER(TRIM(ejercicioContableArg8));
		ejercicioContableArg8 = TRANSLATE(ejercicioContableArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ejercicioContableArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(PuntoEquilibrio.ejercicioContable),
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

DROP FUNCTION IF EXISTS massoftware.f_PuntoEquilibrioById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_PuntoEquilibrioById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_PuntoEquilibrio_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_PuntoEquilibrio_1 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_PuntoEquilibrio_1 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_PuntoEquilibrioById_1 ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CostoVenta                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CostoVenta



DROP FUNCTION IF EXISTS massoftware.f_CostoVenta (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CostoVenta (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.CostoVenta AS $$

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
				  CostoVenta.id        AS CostoVenta_id    	-- 0	.id   		VARCHAR(36)
				, CostoVenta.numero    AS CostoVenta_numero	-- 1	.numero		INTEGER
				, CostoVenta.nombre    AS CostoVenta_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.CostoVenta

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CostoVenta.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CostoVenta.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CostoVenta.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CostoVenta.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_CostoVentaById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CostoVentaById (idArg VARCHAR(36)) RETURNS SETOF massoftware.CostoVenta AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CostoVenta ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CostoVenta ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CostoVentaById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaContableEstado                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaContableEstado



DROP FUNCTION IF EXISTS massoftware.f_CuentaContableEstado (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaContableEstado (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.CuentaContableEstado AS $$

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
				  CuentaContableEstado.id        AS CuentaContableEstado_id    	-- 0	.id   		VARCHAR(36)
				, CuentaContableEstado.numero    AS CuentaContableEstado_numero	-- 1	.numero		INTEGER
				, CuentaContableEstado.nombre    AS CuentaContableEstado_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.CuentaContableEstado

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaContableEstado.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaContableEstado.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaContableEstado.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContableEstado.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaContableEstadoById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaContableEstadoById (idArg VARCHAR(36)) RETURNS SETOF massoftware.CuentaContableEstado AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaContableEstado ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaContableEstado ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaContableEstadoById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaContable                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaContable



DROP FUNCTION IF EXISTS massoftware.f_CuentaContable (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, codigoArg5              VARCHAR(11)	-- 5
	, nombreArg6              VARCHAR(50)	-- 6
	, ejercicioContableArg7   VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaContable (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, codigoArg5              VARCHAR(11)	-- 5
	, nombreArg6              VARCHAR(50)	-- 6
	, ejercicioContableArg7   VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.CuentaContable AS $$

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
				  CuentaContable.id                      AS CuentaContable_id                  	-- 0	.id                 		VARCHAR(36)
				, CuentaContable.codigo                  AS CuentaContable_codigo              	-- 1	.codigo             		VARCHAR(11)
				, CuentaContable.nombre                  AS CuentaContable_nombre              	-- 2	.nombre             		VARCHAR(50)
				, CuentaContable.ejercicioContable       AS CuentaContable_ejercicioContable   	-- 3	.ejercicioContable  		VARCHAR(36)	EjercicioContable.id
				, CuentaContable.integra                 AS CuentaContable_integra             	-- 4	.integra            		VARCHAR(16)
				, CuentaContable.cuentaJerarquia         AS CuentaContable_cuentaJerarquia     	-- 5	.cuentaJerarquia    		VARCHAR(16)
				, CuentaContable.imputable               AS CuentaContable_imputable           	-- 6	.imputable          		BOOLEAN
				, CuentaContable.ajustaPorInflacion      AS CuentaContable_ajustaPorInflacion  	-- 7	.ajustaPorInflacion 		BOOLEAN
				, CuentaContable.cuentaContableEstado    AS CuentaContable_cuentaContableEstado	-- 8	.cuentaContableEstado		VARCHAR(36)	CuentaContableEstado.id
				, CuentaContable.cuentaConApropiacion    AS CuentaContable_cuentaConApropiacion	-- 9	.cuentaConApropiacion		BOOLEAN
				, CuentaContable.centroCostoContable     AS CuentaContable_centroCostoContable 	-- 10	.centroCostoContable		VARCHAR(36)	CentroCostoContable.id
				, CuentaContable.cuentaAgrupadora        AS CuentaContable_cuentaAgrupadora    	-- 11	.cuentaAgrupadora   		VARCHAR(50)
				, CuentaContable.porcentaje              AS CuentaContable_porcentaje          	-- 12	.porcentaje         		DECIMAL(6,3)
				, CuentaContable.puntoEquilibrio         AS CuentaContable_puntoEquilibrio     	-- 13	.puntoEquilibrio    		VARCHAR(36)	PuntoEquilibrio.id
				, CuentaContable.costoVenta              AS CuentaContable_costoVenta          	-- 14	.costoVenta         		VARCHAR(36)	CostoVenta.id
				, CuentaContable.seguridadPuerta         AS CuentaContable_seguridadPuerta     	-- 15	.seguridadPuerta    		VARCHAR(36)	SeguridadPuerta.id

		FROM	massoftware.CuentaContable

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaContable.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND codigoArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(codigoArg5)) > 0 THEN
		codigoArg5 = REPLACE(codigoArg5, '''', '''''');
		codigoArg5 = LOWER(TRIM(codigoArg5));
		codigoArg5 = TRANSLATE(codigoArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(codigoArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContable.codigo),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContable.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND ejercicioContableArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(ejercicioContableArg7)) > 0 THEN
		ejercicioContableArg7 = REPLACE(ejercicioContableArg7, '''', '''''');
		ejercicioContableArg7 = LOWER(TRIM(ejercicioContableArg7));
		ejercicioContableArg7 = TRANSLATE(ejercicioContableArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ejercicioContableArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContable.ejercicioContable),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaContableById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaContableById (idArg VARCHAR(36)) RETURNS SETOF massoftware.CuentaContable AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaContable ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaContable ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaContableById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_CuentaContable_1 (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, codigoArg5              VARCHAR(11)	-- 5
	, nombreArg6              VARCHAR(50)	-- 6
	, ejercicioContableArg7   VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaContable_1 (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, codigoArg5              VARCHAR(11)	-- 5
	, nombreArg6              VARCHAR(50)	-- 6
	, ejercicioContableArg7   VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.t_CuentaContable_1 AS $$

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
				  CuentaContable.id                            AS CuentaContable_id                       	-- 0	.id                                  		VARCHAR(36)
				, CuentaContable.codigo                        AS CuentaContable_codigo                   	-- 1	.codigo                              		VARCHAR(11)
				, CuentaContable.nombre                        AS CuentaContable_nombre                   	-- 2	.nombre                              		VARCHAR(50)
				, EjercicioContable_3.id                       AS EjercicioContable_3_id                  	-- 3	.EjercicioContable.id                		VARCHAR(36)
				, EjercicioContable_3.numero                   AS EjercicioContable_3_numero              	-- 4	.EjercicioContable.numero            		INTEGER
				, EjercicioContable_3.apertura                 AS EjercicioContable_3_apertura            	-- 5	.EjercicioContable.apertura          		DATE
				, EjercicioContable_3.cierre                   AS EjercicioContable_3_cierre              	-- 6	.EjercicioContable.cierre            		DATE
				, EjercicioContable_3.cerrado                  AS EjercicioContable_3_cerrado             	-- 7	.EjercicioContable.cerrado           		BOOLEAN
				, EjercicioContable_3.cerradoModulos           AS EjercicioContable_3_cerradoModulos      	-- 8	.EjercicioContable.cerradoModulos    		BOOLEAN
				, EjercicioContable_3.comentario               AS EjercicioContable_3_comentario          	-- 9	.EjercicioContable.comentario        		VARCHAR(250)
				, CuentaContable.integra                       AS CuentaContable_integra                  	-- 10	.integra                             		VARCHAR(16)
				, CuentaContable.cuentaJerarquia               AS CuentaContable_cuentaJerarquia          	-- 11	.cuentaJerarquia                     		VARCHAR(16)
				, CuentaContable.imputable                     AS CuentaContable_imputable                	-- 12	.imputable                           		BOOLEAN
				, CuentaContable.ajustaPorInflacion            AS CuentaContable_ajustaPorInflacion       	-- 13	.ajustaPorInflacion                  		BOOLEAN
				, CuentaContableEstado_14.id                   AS CuentaContableEstado_14_id              	-- 14	.CuentaContableEstado.id             		VARCHAR(36)
				, CuentaContableEstado_14.numero               AS CuentaContableEstado_14_numero          	-- 15	.CuentaContableEstado.numero         		INTEGER
				, CuentaContableEstado_14.nombre               AS CuentaContableEstado_14_nombre          	-- 16	.CuentaContableEstado.nombre         		VARCHAR(50)
				, CuentaContable.cuentaConApropiacion          AS CuentaContable_cuentaConApropiacion     	-- 17	.cuentaConApropiacion                		BOOLEAN
				, CentroCostoContable_18.id                    AS CentroCostoContable_18_id               	-- 18	.CentroCostoContable.id              		VARCHAR(36)
				, CentroCostoContable_18.numero                AS CentroCostoContable_18_numero           	-- 19	.CentroCostoContable.numero          		INTEGER
				, CentroCostoContable_18.nombre                AS CentroCostoContable_18_nombre           	-- 20	.CentroCostoContable.nombre          		VARCHAR(50)
				, CentroCostoContable_18.abreviatura           AS CentroCostoContable_18_abreviatura      	-- 21	.CentroCostoContable.abreviatura     		VARCHAR(5)
				, CentroCostoContable_18.ejercicioContable     AS CentroCostoContable_18_ejercicioContable	-- 22	.CentroCostoContable.ejercicioContable		VARCHAR(36)	EjercicioContable.id
				, CuentaContable.cuentaAgrupadora              AS CuentaContable_cuentaAgrupadora         	-- 23	.cuentaAgrupadora                    		VARCHAR(50)
				, CuentaContable.porcentaje                    AS CuentaContable_porcentaje               	-- 24	.porcentaje                          		DECIMAL(6,3)
				, PuntoEquilibrio_25.id                        AS PuntoEquilibrio_25_id                   	-- 25	.PuntoEquilibrio.id                  		VARCHAR(36)
				, PuntoEquilibrio_25.numero                    AS PuntoEquilibrio_25_numero               	-- 26	.PuntoEquilibrio.numero              		INTEGER
				, PuntoEquilibrio_25.nombre                    AS PuntoEquilibrio_25_nombre               	-- 27	.PuntoEquilibrio.nombre              		VARCHAR(50)
				, PuntoEquilibrio_25.tipoPuntoEquilibrio       AS PuntoEquilibrio_25_tipoPuntoEquilibrio  	-- 28	.PuntoEquilibrio.tipoPuntoEquilibrio 		VARCHAR(36)	TipoPuntoEquilibrio.id
				, PuntoEquilibrio_25.ejercicioContable         AS PuntoEquilibrio_25_ejercicioContable    	-- 29	.PuntoEquilibrio.ejercicioContable   		VARCHAR(36)	EjercicioContable.id
				, CostoVenta_30.id                             AS CostoVenta_30_id                        	-- 30	.CostoVenta.id                       		VARCHAR(36)
				, CostoVenta_30.numero                         AS CostoVenta_30_numero                    	-- 31	.CostoVenta.numero                   		INTEGER
				, CostoVenta_30.nombre                         AS CostoVenta_30_nombre                    	-- 32	.CostoVenta.nombre                   		VARCHAR(50)
				, SeguridadPuerta_33.id                        AS SeguridadPuerta_33_id                   	-- 33	.SeguridadPuerta.id                  		VARCHAR(36)
				, SeguridadPuerta_33.numero                    AS SeguridadPuerta_33_numero               	-- 34	.SeguridadPuerta.numero              		INTEGER
				, SeguridadPuerta_33.nombre                    AS SeguridadPuerta_33_nombre               	-- 35	.SeguridadPuerta.nombre              		VARCHAR(50)
				, SeguridadPuerta_33.equate                    AS SeguridadPuerta_33_equate               	-- 36	.SeguridadPuerta.equate              		VARCHAR(30)
				, SeguridadPuerta_33.seguridadModulo           AS SeguridadPuerta_33_seguridadModulo      	-- 37	.SeguridadPuerta.seguridadModulo     		VARCHAR(36)	SeguridadModulo.id

		FROM	massoftware.CuentaContable
			LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_3            ON CuentaContable.ejercicioContable = EjercicioContable_3.id 	-- 3 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_14        ON CuentaContable.cuentaContableEstado = CuentaContableEstado_14.id 	-- 14 LEFT LEVEL: 1
			LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_18         ON CuentaContable.centroCostoContable = CentroCostoContable_18.id 	-- 18 LEFT LEVEL: 1
			LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_25             ON CuentaContable.puntoEquilibrio = PuntoEquilibrio_25.id 	-- 25 LEFT LEVEL: 1
			LEFT JOIN massoftware.CostoVenta AS CostoVenta_30                  ON CuentaContable.costoVenta = CostoVenta_30.id 	-- 30 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_33             ON CuentaContable.seguridadPuerta = SeguridadPuerta_33.id 	-- 33 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaContable.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND codigoArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(codigoArg5)) > 0 THEN
		codigoArg5 = REPLACE(codigoArg5, '''', '''''');
		codigoArg5 = LOWER(TRIM(codigoArg5));
		codigoArg5 = TRANSLATE(codigoArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(codigoArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContable.codigo),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContable.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND ejercicioContableArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(ejercicioContableArg7)) > 0 THEN
		ejercicioContableArg7 = REPLACE(ejercicioContableArg7, '''', '''''');
		ejercicioContableArg7 = LOWER(TRIM(ejercicioContableArg7));
		ejercicioContableArg7 = TRANSLATE(ejercicioContableArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ejercicioContableArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContable.ejercicioContable),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaContableById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaContableById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_CuentaContable_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaContable_1 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaContable_1 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaContableById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_CuentaContable_2 (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, codigoArg5              VARCHAR(11)	-- 5
	, nombreArg6              VARCHAR(50)	-- 6
	, ejercicioContableArg7   VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaContable_2 (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, codigoArg5              VARCHAR(11)	-- 5
	, nombreArg6              VARCHAR(50)	-- 6
	, ejercicioContableArg7   VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.t_CuentaContable_2 AS $$

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
				  CuentaContable.id                       AS CuentaContable_id                  	-- 0	.id                                                 		VARCHAR(36)
				, CuentaContable.codigo                   AS CuentaContable_codigo              	-- 1	.codigo                                             		VARCHAR(11)
				, CuentaContable.nombre                   AS CuentaContable_nombre              	-- 2	.nombre                                             		VARCHAR(50)
				, EjercicioContable_3.id                  AS EjercicioContable_3_id             	-- 3	.EjercicioContable.id                               		VARCHAR(36)
				, EjercicioContable_3.numero              AS EjercicioContable_3_numero         	-- 4	.EjercicioContable.numero                           		INTEGER
				, EjercicioContable_3.apertura            AS EjercicioContable_3_apertura       	-- 5	.EjercicioContable.apertura                         		DATE
				, EjercicioContable_3.cierre              AS EjercicioContable_3_cierre         	-- 6	.EjercicioContable.cierre                           		DATE
				, EjercicioContable_3.cerrado             AS EjercicioContable_3_cerrado        	-- 7	.EjercicioContable.cerrado                          		BOOLEAN
				, EjercicioContable_3.cerradoModulos      AS EjercicioContable_3_cerradoModulos 	-- 8	.EjercicioContable.cerradoModulos                   		BOOLEAN
				, EjercicioContable_3.comentario          AS EjercicioContable_3_comentario     	-- 9	.EjercicioContable.comentario                       		VARCHAR(250)
				, CuentaContable.integra                  AS CuentaContable_integra             	-- 10	.integra                                            		VARCHAR(16)
				, CuentaContable.cuentaJerarquia          AS CuentaContable_cuentaJerarquia     	-- 11	.cuentaJerarquia                                    		VARCHAR(16)
				, CuentaContable.imputable                AS CuentaContable_imputable           	-- 12	.imputable                                          		BOOLEAN
				, CuentaContable.ajustaPorInflacion       AS CuentaContable_ajustaPorInflacion  	-- 13	.ajustaPorInflacion                                 		BOOLEAN
				, CuentaContableEstado_14.id              AS CuentaContableEstado_14_id         	-- 14	.CuentaContableEstado.id                            		VARCHAR(36)
				, CuentaContableEstado_14.numero          AS CuentaContableEstado_14_numero     	-- 15	.CuentaContableEstado.numero                        		INTEGER
				, CuentaContableEstado_14.nombre          AS CuentaContableEstado_14_nombre     	-- 16	.CuentaContableEstado.nombre                        		VARCHAR(50)
				, CuentaContable.cuentaConApropiacion     AS CuentaContable_cuentaConApropiacion	-- 17	.cuentaConApropiacion                               		BOOLEAN
				, CentroCostoContable_18.id               AS CentroCostoContable_18_id          	-- 18	.CentroCostoContable.id                             		VARCHAR(36)
				, CentroCostoContable_18.numero           AS CentroCostoContable_18_numero      	-- 19	.CentroCostoContable.numero                         		INTEGER
				, CentroCostoContable_18.nombre           AS CentroCostoContable_18_nombre      	-- 20	.CentroCostoContable.nombre                         		VARCHAR(50)
				, CentroCostoContable_18.abreviatura      AS CentroCostoContable_18_abreviatura 	-- 21	.CentroCostoContable.abreviatura                    		VARCHAR(5)
				, EjercicioContable_22.id                 AS EjercicioContable_22_id            	-- 22	.CentroCostoContable.EjercicioContable.id           		VARCHAR(36)
				, EjercicioContable_22.numero             AS EjercicioContable_22_numero        	-- 23	.CentroCostoContable.EjercicioContable.numero       		INTEGER
				, EjercicioContable_22.apertura           AS EjercicioContable_22_apertura      	-- 24	.CentroCostoContable.EjercicioContable.apertura     		DATE
				, EjercicioContable_22.cierre             AS EjercicioContable_22_cierre        	-- 25	.CentroCostoContable.EjercicioContable.cierre       		DATE
				, EjercicioContable_22.cerrado            AS EjercicioContable_22_cerrado       	-- 26	.CentroCostoContable.EjercicioContable.cerrado      		BOOLEAN
				, EjercicioContable_22.cerradoModulos     AS EjercicioContable_22_cerradoModulos	-- 27	.CentroCostoContable.EjercicioContable.cerradoModulos		BOOLEAN
				, EjercicioContable_22.comentario         AS EjercicioContable_22_comentario    	-- 28	.CentroCostoContable.EjercicioContable.comentario   		VARCHAR(250)
				, CuentaContable.cuentaAgrupadora         AS CuentaContable_cuentaAgrupadora    	-- 29	.cuentaAgrupadora                                   		VARCHAR(50)
				, CuentaContable.porcentaje               AS CuentaContable_porcentaje          	-- 30	.porcentaje                                         		DECIMAL(6,3)
				, PuntoEquilibrio_31.id                   AS PuntoEquilibrio_31_id              	-- 31	.PuntoEquilibrio.id                                 		VARCHAR(36)
				, PuntoEquilibrio_31.numero               AS PuntoEquilibrio_31_numero          	-- 32	.PuntoEquilibrio.numero                             		INTEGER
				, PuntoEquilibrio_31.nombre               AS PuntoEquilibrio_31_nombre          	-- 33	.PuntoEquilibrio.nombre                             		VARCHAR(50)
				, TipoPuntoEquilibrio_34.id               AS TipoPuntoEquilibrio_34_id          	-- 34	.PuntoEquilibrio.TipoPuntoEquilibrio.id             		VARCHAR(36)
				, TipoPuntoEquilibrio_34.numero           AS TipoPuntoEquilibrio_34_numero      	-- 35	.PuntoEquilibrio.TipoPuntoEquilibrio.numero         		INTEGER
				, TipoPuntoEquilibrio_34.nombre           AS TipoPuntoEquilibrio_34_nombre      	-- 36	.PuntoEquilibrio.TipoPuntoEquilibrio.nombre         		VARCHAR(50)
				, EjercicioContable_37.id                 AS EjercicioContable_37_id            	-- 37	.PuntoEquilibrio.EjercicioContable.id               		VARCHAR(36)
				, EjercicioContable_37.numero             AS EjercicioContable_37_numero        	-- 38	.PuntoEquilibrio.EjercicioContable.numero           		INTEGER
				, EjercicioContable_37.apertura           AS EjercicioContable_37_apertura      	-- 39	.PuntoEquilibrio.EjercicioContable.apertura         		DATE
				, EjercicioContable_37.cierre             AS EjercicioContable_37_cierre        	-- 40	.PuntoEquilibrio.EjercicioContable.cierre           		DATE
				, EjercicioContable_37.cerrado            AS EjercicioContable_37_cerrado       	-- 41	.PuntoEquilibrio.EjercicioContable.cerrado          		BOOLEAN
				, EjercicioContable_37.cerradoModulos     AS EjercicioContable_37_cerradoModulos	-- 42	.PuntoEquilibrio.EjercicioContable.cerradoModulos   		BOOLEAN
				, EjercicioContable_37.comentario         AS EjercicioContable_37_comentario    	-- 43	.PuntoEquilibrio.EjercicioContable.comentario       		VARCHAR(250)
				, CostoVenta_44.id                        AS CostoVenta_44_id                   	-- 44	.CostoVenta.id                                      		VARCHAR(36)
				, CostoVenta_44.numero                    AS CostoVenta_44_numero               	-- 45	.CostoVenta.numero                                  		INTEGER
				, CostoVenta_44.nombre                    AS CostoVenta_44_nombre               	-- 46	.CostoVenta.nombre                                  		VARCHAR(50)
				, SeguridadPuerta_47.id                   AS SeguridadPuerta_47_id              	-- 47	.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_47.numero               AS SeguridadPuerta_47_numero          	-- 48	.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_47.nombre               AS SeguridadPuerta_47_nombre          	-- 49	.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_47.equate               AS SeguridadPuerta_47_equate          	-- 50	.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_51.id                   AS SeguridadModulo_51_id              	-- 51	.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_51.numero               AS SeguridadModulo_51_numero          	-- 52	.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_51.nombre               AS SeguridadModulo_51_nombre          	-- 53	.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)

		FROM	massoftware.CuentaContable
			LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_3              ON CuentaContable.ejercicioContable = EjercicioContable_3.id 	-- 3 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_14          ON CuentaContable.cuentaContableEstado = CuentaContableEstado_14.id 	-- 14 LEFT LEVEL: 1
			LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_18           ON CuentaContable.centroCostoContable = CentroCostoContable_18.id 	-- 18 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_22             ON CentroCostoContable_18.ejercicioContable = EjercicioContable_22.id 	-- 22 LEFT LEVEL: 2
			LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_31               ON CuentaContable.puntoEquilibrio = PuntoEquilibrio_31.id 	-- 31 LEFT LEVEL: 1
				LEFT JOIN massoftware.TipoPuntoEquilibrio AS TipoPuntoEquilibrio_34           ON PuntoEquilibrio_31.tipoPuntoEquilibrio = TipoPuntoEquilibrio_34.id 	-- 34 LEFT LEVEL: 2
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_37             ON PuntoEquilibrio_31.ejercicioContable = EjercicioContable_37.id 	-- 37 LEFT LEVEL: 2
			LEFT JOIN massoftware.CostoVenta AS CostoVenta_44                    ON CuentaContable.costoVenta = CostoVenta_44.id 	-- 44 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_47               ON CuentaContable.seguridadPuerta = SeguridadPuerta_47.id 	-- 47 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_51               ON SeguridadPuerta_47.seguridadModulo = SeguridadModulo_51.id 	-- 51 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaContable.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND codigoArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(codigoArg5)) > 0 THEN
		codigoArg5 = REPLACE(codigoArg5, '''', '''''');
		codigoArg5 = LOWER(TRIM(codigoArg5));
		codigoArg5 = TRANSLATE(codigoArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(codigoArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContable.codigo),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContable.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND ejercicioContableArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(ejercicioContableArg7)) > 0 THEN
		ejercicioContableArg7 = REPLACE(ejercicioContableArg7, '''', '''''');
		ejercicioContableArg7 = LOWER(TRIM(ejercicioContableArg7));
		ejercicioContableArg7 = TRANSLATE(ejercicioContableArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ejercicioContableArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContable.ejercicioContable),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaContableById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaContableById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_CuentaContable_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaContable_2 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaContable_2 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaContableById_2 ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoModelo                                                                                          //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoModelo



DROP FUNCTION IF EXISTS massoftware.f_AsientoModelo (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, numeroFromArg5          INTEGER    	-- 5
	, numeroToArg6            INTEGER    	-- 6
	, nombreArg7              VARCHAR(50)	-- 7
	, ejercicioContableArg8   VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModelo (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, numeroFromArg5          INTEGER    	-- 5
	, numeroToArg6            INTEGER    	-- 6
	, nombreArg7              VARCHAR(50)	-- 7
	, ejercicioContableArg8   VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.AsientoModelo AS $$

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
				  AsientoModelo.id                   AS AsientoModelo_id               	-- 0	.id              		VARCHAR(36)
				, AsientoModelo.numero               AS AsientoModelo_numero           	-- 1	.numero          		INTEGER
				, AsientoModelo.nombre               AS AsientoModelo_nombre           	-- 2	.nombre          		VARCHAR(50)
				, AsientoModelo.ejercicioContable    AS AsientoModelo_ejercicioContable	-- 3	.ejercicioContable		VARCHAR(36)	EjercicioContable.id

		FROM	massoftware.AsientoModelo

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoModelo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoModelo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoModelo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoModelo.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND ejercicioContableArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(ejercicioContableArg8)) > 0 THEN
		ejercicioContableArg8 = REPLACE(ejercicioContableArg8, '''', '''''');
		ejercicioContableArg8 = LOWER(TRIM(ejercicioContableArg8));
		ejercicioContableArg8 = TRANSLATE(ejercicioContableArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ejercicioContableArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoModelo.ejercicioContable),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoModeloById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModeloById (idArg VARCHAR(36)) RETURNS SETOF massoftware.AsientoModelo AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoModelo ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoModelo ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoModeloById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_AsientoModelo_1 (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, numeroFromArg5          INTEGER    	-- 5
	, numeroToArg6            INTEGER    	-- 6
	, nombreArg7              VARCHAR(50)	-- 7
	, ejercicioContableArg8   VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModelo_1 (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, numeroFromArg5          INTEGER    	-- 5
	, numeroToArg6            INTEGER    	-- 6
	, nombreArg7              VARCHAR(50)	-- 7
	, ejercicioContableArg8   VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_AsientoModelo_1 AS $$

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
				  AsientoModelo.id                      AS AsientoModelo_id                  	-- 0	.id                             		VARCHAR(36)
				, AsientoModelo.numero                  AS AsientoModelo_numero              	-- 1	.numero                         		INTEGER
				, AsientoModelo.nombre                  AS AsientoModelo_nombre              	-- 2	.nombre                         		VARCHAR(50)
				, EjercicioContable_3.id                AS EjercicioContable_3_id            	-- 3	.EjercicioContable.id           		VARCHAR(36)
				, EjercicioContable_3.numero            AS EjercicioContable_3_numero        	-- 4	.EjercicioContable.numero       		INTEGER
				, EjercicioContable_3.apertura          AS EjercicioContable_3_apertura      	-- 5	.EjercicioContable.apertura     		DATE
				, EjercicioContable_3.cierre            AS EjercicioContable_3_cierre        	-- 6	.EjercicioContable.cierre       		DATE
				, EjercicioContable_3.cerrado           AS EjercicioContable_3_cerrado       	-- 7	.EjercicioContable.cerrado      		BOOLEAN
				, EjercicioContable_3.cerradoModulos    AS EjercicioContable_3_cerradoModulos	-- 8	.EjercicioContable.cerradoModulos		BOOLEAN
				, EjercicioContable_3.comentario        AS EjercicioContable_3_comentario    	-- 9	.EjercicioContable.comentario   		VARCHAR(250)

		FROM	massoftware.AsientoModelo
			LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_3        ON AsientoModelo.ejercicioContable = EjercicioContable_3.id 	-- 3 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoModelo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoModelo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoModelo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoModelo.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND ejercicioContableArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(ejercicioContableArg8)) > 0 THEN
		ejercicioContableArg8 = REPLACE(ejercicioContableArg8, '''', '''''');
		ejercicioContableArg8 = LOWER(TRIM(ejercicioContableArg8));
		ejercicioContableArg8 = TRANSLATE(ejercicioContableArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ejercicioContableArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoModelo.ejercicioContable),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoModeloById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModeloById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_AsientoModelo_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoModelo_1 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoModelo_1 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoModeloById_1 ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoModeloItem                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoModeloItem



DROP FUNCTION IF EXISTS massoftware.f_AsientoModeloItem (

	  idArg0              VARCHAR(36)	-- 0
	, orderByArg1         INTEGER    	-- 1
	, orderByDescArg2     BOOLEAN    	-- 2
	, limitArg3           BIGINT     	-- 3
	, offSetArg4          BIGINT     	-- 4
	, asientoModeloArg5   VARCHAR(36)	-- 5

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModeloItem (

	  idArg0              VARCHAR(36)	-- 0
	, orderByArg1         INTEGER    	-- 1
	, orderByDescArg2     BOOLEAN    	-- 2
	, limitArg3           BIGINT     	-- 3
	, offSetArg4          BIGINT     	-- 4
	, asientoModeloArg5   VARCHAR(36)	-- 5

) RETURNS SETOF massoftware.AsientoModeloItem AS $$

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
				  AsientoModeloItem.id                AS AsientoModeloItem_id            	-- 0	.id           		VARCHAR(36)
				, AsientoModeloItem.numero            AS AsientoModeloItem_numero        	-- 1	.numero       		INTEGER
				, AsientoModeloItem.asientoModelo     AS AsientoModeloItem_asientoModelo 	-- 2	.asientoModelo		VARCHAR(36)	AsientoModelo.id
				, AsientoModeloItem.cuentaContable    AS AsientoModeloItem_cuentaContable	-- 3	.cuentaContable		VARCHAR(36)	CuentaContable.id

		FROM	massoftware.AsientoModeloItem

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoModeloItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND asientoModeloArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoModeloArg5)) > 0 THEN
		asientoModeloArg5 = REPLACE(asientoModeloArg5, '''', '''''');
		asientoModeloArg5 = LOWER(TRIM(asientoModeloArg5));
		asientoModeloArg5 = TRANSLATE(asientoModeloArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoModeloArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoModeloItem.asientoModelo),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoModeloItemById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModeloItemById (idArg VARCHAR(36)) RETURNS SETOF massoftware.AsientoModeloItem AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoModeloItem ( idArg , null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoModeloItem ( null , null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoModeloItemById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_AsientoModeloItem_1 (

	  idArg0              VARCHAR(36)	-- 0
	, orderByArg1         INTEGER    	-- 1
	, orderByDescArg2     BOOLEAN    	-- 2
	, limitArg3           BIGINT     	-- 3
	, offSetArg4          BIGINT     	-- 4
	, asientoModeloArg5   VARCHAR(36)	-- 5

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModeloItem_1 (

	  idArg0              VARCHAR(36)	-- 0
	, orderByArg1         INTEGER    	-- 1
	, orderByDescArg2     BOOLEAN    	-- 2
	, limitArg3           BIGINT     	-- 3
	, offSetArg4          BIGINT     	-- 4
	, asientoModeloArg5   VARCHAR(36)	-- 5

) RETURNS SETOF massoftware.t_AsientoModeloItem_1 AS $$

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
				  AsientoModeloItem.id                      AS AsientoModeloItem_id                 	-- 0	.id                                		VARCHAR(36)
				, AsientoModeloItem.numero                  AS AsientoModeloItem_numero             	-- 1	.numero                            		INTEGER
				, AsientoModelo_2.id                        AS AsientoModelo_2_id                   	-- 2	.AsientoModelo.id                  		VARCHAR(36)
				, AsientoModelo_2.numero                    AS AsientoModelo_2_numero               	-- 3	.AsientoModelo.numero              		INTEGER
				, AsientoModelo_2.nombre                    AS AsientoModelo_2_nombre               	-- 4	.AsientoModelo.nombre              		VARCHAR(50)
				, AsientoModelo_2.ejercicioContable         AS AsientoModelo_2_ejercicioContable    	-- 5	.AsientoModelo.ejercicioContable   		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_6.id                       AS CuentaContable_6_id                  	-- 6	.CuentaContable.id                 		VARCHAR(36)
				, CuentaContable_6.codigo                   AS CuentaContable_6_codigo              	-- 7	.CuentaContable.codigo             		VARCHAR(11)
				, CuentaContable_6.nombre                   AS CuentaContable_6_nombre              	-- 8	.CuentaContable.nombre             		VARCHAR(50)
				, CuentaContable_6.ejercicioContable        AS CuentaContable_6_ejercicioContable   	-- 9	.CuentaContable.ejercicioContable  		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_6.integra                  AS CuentaContable_6_integra             	-- 10	.CuentaContable.integra            		VARCHAR(16)
				, CuentaContable_6.cuentaJerarquia          AS CuentaContable_6_cuentaJerarquia     	-- 11	.CuentaContable.cuentaJerarquia    		VARCHAR(16)
				, CuentaContable_6.imputable                AS CuentaContable_6_imputable           	-- 12	.CuentaContable.imputable          		BOOLEAN
				, CuentaContable_6.ajustaPorInflacion       AS CuentaContable_6_ajustaPorInflacion  	-- 13	.CuentaContable.ajustaPorInflacion 		BOOLEAN
				, CuentaContable_6.cuentaContableEstado     AS CuentaContable_6_cuentaContableEstado	-- 14	.CuentaContable.cuentaContableEstado		VARCHAR(36)	CuentaContableEstado.id
				, CuentaContable_6.cuentaConApropiacion     AS CuentaContable_6_cuentaConApropiacion	-- 15	.CuentaContable.cuentaConApropiacion		BOOLEAN
				, CuentaContable_6.centroCostoContable      AS CuentaContable_6_centroCostoContable 	-- 16	.CuentaContable.centroCostoContable		VARCHAR(36)	CentroCostoContable.id
				, CuentaContable_6.cuentaAgrupadora         AS CuentaContable_6_cuentaAgrupadora    	-- 17	.CuentaContable.cuentaAgrupadora   		VARCHAR(50)
				, CuentaContable_6.porcentaje               AS CuentaContable_6_porcentaje          	-- 18	.CuentaContable.porcentaje         		DECIMAL(6,3)
				, CuentaContable_6.puntoEquilibrio          AS CuentaContable_6_puntoEquilibrio     	-- 19	.CuentaContable.puntoEquilibrio    		VARCHAR(36)	PuntoEquilibrio.id
				, CuentaContable_6.costoVenta               AS CuentaContable_6_costoVenta          	-- 20	.CuentaContable.costoVenta         		VARCHAR(36)	CostoVenta.id
				, CuentaContable_6.seguridadPuerta          AS CuentaContable_6_seguridadPuerta     	-- 21	.CuentaContable.seguridadPuerta    		VARCHAR(36)	SeguridadPuerta.id

		FROM	massoftware.AsientoModeloItem
			LEFT JOIN massoftware.AsientoModelo AS AsientoModelo_2         ON AsientoModeloItem.asientoModelo = AsientoModelo_2.id 	-- 2 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaContable AS CuentaContable_6        ON AsientoModeloItem.cuentaContable = CuentaContable_6.id 	-- 6 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoModeloItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND asientoModeloArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoModeloArg5)) > 0 THEN
		asientoModeloArg5 = REPLACE(asientoModeloArg5, '''', '''''');
		asientoModeloArg5 = LOWER(TRIM(asientoModeloArg5));
		asientoModeloArg5 = TRANSLATE(asientoModeloArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoModeloArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoModeloItem.asientoModelo),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoModeloItemById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModeloItemById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_AsientoModeloItem_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoModeloItem_1 ( idArg , null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoModeloItem_1 ( null , null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoModeloItemById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_AsientoModeloItem_2 (

	  idArg0              VARCHAR(36)	-- 0
	, orderByArg1         INTEGER    	-- 1
	, orderByDescArg2     BOOLEAN    	-- 2
	, limitArg3           BIGINT     	-- 3
	, offSetArg4          BIGINT     	-- 4
	, asientoModeloArg5   VARCHAR(36)	-- 5

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModeloItem_2 (

	  idArg0              VARCHAR(36)	-- 0
	, orderByArg1         INTEGER    	-- 1
	, orderByDescArg2     BOOLEAN    	-- 2
	, limitArg3           BIGINT     	-- 3
	, offSetArg4          BIGINT     	-- 4
	, asientoModeloArg5   VARCHAR(36)	-- 5

) RETURNS SETOF massoftware.t_AsientoModeloItem_2 AS $$

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
				  AsientoModeloItem.id                         AS AsientoModeloItem_id                    	-- 0	.id                                                 		VARCHAR(36)
				, AsientoModeloItem.numero                     AS AsientoModeloItem_numero                	-- 1	.numero                                             		INTEGER
				, AsientoModelo_2.id                           AS AsientoModelo_2_id                      	-- 2	.AsientoModelo.id                                   		VARCHAR(36)
				, AsientoModelo_2.numero                       AS AsientoModelo_2_numero                  	-- 3	.AsientoModelo.numero                               		INTEGER
				, AsientoModelo_2.nombre                       AS AsientoModelo_2_nombre                  	-- 4	.AsientoModelo.nombre                               		VARCHAR(50)
				, EjercicioContable_5.id                       AS EjercicioContable_5_id                  	-- 5	.AsientoModelo.EjercicioContable.id                 		VARCHAR(36)
				, EjercicioContable_5.numero                   AS EjercicioContable_5_numero              	-- 6	.AsientoModelo.EjercicioContable.numero             		INTEGER
				, EjercicioContable_5.apertura                 AS EjercicioContable_5_apertura            	-- 7	.AsientoModelo.EjercicioContable.apertura           		DATE
				, EjercicioContable_5.cierre                   AS EjercicioContable_5_cierre              	-- 8	.AsientoModelo.EjercicioContable.cierre             		DATE
				, EjercicioContable_5.cerrado                  AS EjercicioContable_5_cerrado             	-- 9	.AsientoModelo.EjercicioContable.cerrado            		BOOLEAN
				, EjercicioContable_5.cerradoModulos           AS EjercicioContable_5_cerradoModulos      	-- 10	.AsientoModelo.EjercicioContable.cerradoModulos     		BOOLEAN
				, EjercicioContable_5.comentario               AS EjercicioContable_5_comentario          	-- 11	.AsientoModelo.EjercicioContable.comentario         		VARCHAR(250)
				, CuentaContable_12.id                         AS CuentaContable_12_id                    	-- 12	.CuentaContable.id                                  		VARCHAR(36)
				, CuentaContable_12.codigo                     AS CuentaContable_12_codigo                	-- 13	.CuentaContable.codigo                              		VARCHAR(11)
				, CuentaContable_12.nombre                     AS CuentaContable_12_nombre                	-- 14	.CuentaContable.nombre                              		VARCHAR(50)
				, EjercicioContable_15.id                      AS EjercicioContable_15_id                 	-- 15	.CuentaContable.EjercicioContable.id                		VARCHAR(36)
				, EjercicioContable_15.numero                  AS EjercicioContable_15_numero             	-- 16	.CuentaContable.EjercicioContable.numero            		INTEGER
				, EjercicioContable_15.apertura                AS EjercicioContable_15_apertura           	-- 17	.CuentaContable.EjercicioContable.apertura          		DATE
				, EjercicioContable_15.cierre                  AS EjercicioContable_15_cierre             	-- 18	.CuentaContable.EjercicioContable.cierre            		DATE
				, EjercicioContable_15.cerrado                 AS EjercicioContable_15_cerrado            	-- 19	.CuentaContable.EjercicioContable.cerrado           		BOOLEAN
				, EjercicioContable_15.cerradoModulos          AS EjercicioContable_15_cerradoModulos     	-- 20	.CuentaContable.EjercicioContable.cerradoModulos    		BOOLEAN
				, EjercicioContable_15.comentario              AS EjercicioContable_15_comentario         	-- 21	.CuentaContable.EjercicioContable.comentario        		VARCHAR(250)
				, CuentaContable_12.integra                    AS CuentaContable_12_integra               	-- 22	.CuentaContable.integra                             		VARCHAR(16)
				, CuentaContable_12.cuentaJerarquia            AS CuentaContable_12_cuentaJerarquia       	-- 23	.CuentaContable.cuentaJerarquia                     		VARCHAR(16)
				, CuentaContable_12.imputable                  AS CuentaContable_12_imputable             	-- 24	.CuentaContable.imputable                           		BOOLEAN
				, CuentaContable_12.ajustaPorInflacion         AS CuentaContable_12_ajustaPorInflacion    	-- 25	.CuentaContable.ajustaPorInflacion                  		BOOLEAN
				, CuentaContableEstado_26.id                   AS CuentaContableEstado_26_id              	-- 26	.CuentaContable.CuentaContableEstado.id             		VARCHAR(36)
				, CuentaContableEstado_26.numero               AS CuentaContableEstado_26_numero          	-- 27	.CuentaContable.CuentaContableEstado.numero         		INTEGER
				, CuentaContableEstado_26.nombre               AS CuentaContableEstado_26_nombre          	-- 28	.CuentaContable.CuentaContableEstado.nombre         		VARCHAR(50)
				, CuentaContable_12.cuentaConApropiacion       AS CuentaContable_12_cuentaConApropiacion  	-- 29	.CuentaContable.cuentaConApropiacion                		BOOLEAN
				, CentroCostoContable_30.id                    AS CentroCostoContable_30_id               	-- 30	.CuentaContable.CentroCostoContable.id              		VARCHAR(36)
				, CentroCostoContable_30.numero                AS CentroCostoContable_30_numero           	-- 31	.CuentaContable.CentroCostoContable.numero          		INTEGER
				, CentroCostoContable_30.nombre                AS CentroCostoContable_30_nombre           	-- 32	.CuentaContable.CentroCostoContable.nombre          		VARCHAR(50)
				, CentroCostoContable_30.abreviatura           AS CentroCostoContable_30_abreviatura      	-- 33	.CuentaContable.CentroCostoContable.abreviatura     		VARCHAR(5)
				, CentroCostoContable_30.ejercicioContable     AS CentroCostoContable_30_ejercicioContable	-- 34	.CuentaContable.CentroCostoContable.ejercicioContable		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_12.cuentaAgrupadora           AS CuentaContable_12_cuentaAgrupadora      	-- 35	.CuentaContable.cuentaAgrupadora                    		VARCHAR(50)
				, CuentaContable_12.porcentaje                 AS CuentaContable_12_porcentaje            	-- 36	.CuentaContable.porcentaje                          		DECIMAL(6,3)
				, PuntoEquilibrio_37.id                        AS PuntoEquilibrio_37_id                   	-- 37	.CuentaContable.PuntoEquilibrio.id                  		VARCHAR(36)
				, PuntoEquilibrio_37.numero                    AS PuntoEquilibrio_37_numero               	-- 38	.CuentaContable.PuntoEquilibrio.numero              		INTEGER
				, PuntoEquilibrio_37.nombre                    AS PuntoEquilibrio_37_nombre               	-- 39	.CuentaContable.PuntoEquilibrio.nombre              		VARCHAR(50)
				, PuntoEquilibrio_37.tipoPuntoEquilibrio       AS PuntoEquilibrio_37_tipoPuntoEquilibrio  	-- 40	.CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio 		VARCHAR(36)	TipoPuntoEquilibrio.id
				, PuntoEquilibrio_37.ejercicioContable         AS PuntoEquilibrio_37_ejercicioContable    	-- 41	.CuentaContable.PuntoEquilibrio.ejercicioContable   		VARCHAR(36)	EjercicioContable.id
				, CostoVenta_42.id                             AS CostoVenta_42_id                        	-- 42	.CuentaContable.CostoVenta.id                       		VARCHAR(36)
				, CostoVenta_42.numero                         AS CostoVenta_42_numero                    	-- 43	.CuentaContable.CostoVenta.numero                   		INTEGER
				, CostoVenta_42.nombre                         AS CostoVenta_42_nombre                    	-- 44	.CuentaContable.CostoVenta.nombre                   		VARCHAR(50)
				, SeguridadPuerta_45.id                        AS SeguridadPuerta_45_id                   	-- 45	.CuentaContable.SeguridadPuerta.id                  		VARCHAR(36)
				, SeguridadPuerta_45.numero                    AS SeguridadPuerta_45_numero               	-- 46	.CuentaContable.SeguridadPuerta.numero              		INTEGER
				, SeguridadPuerta_45.nombre                    AS SeguridadPuerta_45_nombre               	-- 47	.CuentaContable.SeguridadPuerta.nombre              		VARCHAR(50)
				, SeguridadPuerta_45.equate                    AS SeguridadPuerta_45_equate               	-- 48	.CuentaContable.SeguridadPuerta.equate              		VARCHAR(30)
				, SeguridadPuerta_45.seguridadModulo           AS SeguridadPuerta_45_seguridadModulo      	-- 49	.CuentaContable.SeguridadPuerta.seguridadModulo     		VARCHAR(36)	SeguridadModulo.id

		FROM	massoftware.AsientoModeloItem
			LEFT JOIN massoftware.AsientoModelo AS AsientoModelo_2                   ON AsientoModeloItem.asientoModelo = AsientoModelo_2.id 	-- 2 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_5              ON AsientoModelo_2.ejercicioContable = EjercicioContable_5.id 	-- 5 LEFT LEVEL: 2
			LEFT JOIN massoftware.CuentaContable AS CuentaContable_12                 ON AsientoModeloItem.cuentaContable = CuentaContable_12.id 	-- 12 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_15              ON CuentaContable_12.ejercicioContable = EjercicioContable_15.id 	-- 15 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_26           ON CuentaContable_12.cuentaContableEstado = CuentaContableEstado_26.id 	-- 26 LEFT LEVEL: 2
				LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_30            ON CuentaContable_12.centroCostoContable = CentroCostoContable_30.id 	-- 30 LEFT LEVEL: 2
				LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_37                ON CuentaContable_12.puntoEquilibrio = PuntoEquilibrio_37.id 	-- 37 LEFT LEVEL: 2
				LEFT JOIN massoftware.CostoVenta AS CostoVenta_42                     ON CuentaContable_12.costoVenta = CostoVenta_42.id 	-- 42 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_45                ON CuentaContable_12.seguridadPuerta = SeguridadPuerta_45.id 	-- 45 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoModeloItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND asientoModeloArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoModeloArg5)) > 0 THEN
		asientoModeloArg5 = REPLACE(asientoModeloArg5, '''', '''''');
		asientoModeloArg5 = LOWER(TRIM(asientoModeloArg5));
		asientoModeloArg5 = TRANSLATE(asientoModeloArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoModeloArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoModeloItem.asientoModelo),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoModeloItemById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModeloItemById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_AsientoModeloItem_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoModeloItem_2 ( idArg , null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoModeloItem_2 ( null , null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoModeloItemById_2 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_AsientoModeloItem_3 (

	  idArg0              VARCHAR(36)	-- 0
	, orderByArg1         INTEGER    	-- 1
	, orderByDescArg2     BOOLEAN    	-- 2
	, limitArg3           BIGINT     	-- 3
	, offSetArg4          BIGINT     	-- 4
	, asientoModeloArg5   VARCHAR(36)	-- 5

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModeloItem_3 (

	  idArg0              VARCHAR(36)	-- 0
	, orderByArg1         INTEGER    	-- 1
	, orderByDescArg2     BOOLEAN    	-- 2
	, limitArg3           BIGINT     	-- 3
	, offSetArg4          BIGINT     	-- 4
	, asientoModeloArg5   VARCHAR(36)	-- 5

) RETURNS SETOF massoftware.t_AsientoModeloItem_3 AS $$

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
				  AsientoModeloItem.id                       AS AsientoModeloItem_id                  	-- 0	.id                                                                		VARCHAR(36)
				, AsientoModeloItem.numero                   AS AsientoModeloItem_numero              	-- 1	.numero                                                            		INTEGER
				, AsientoModelo_2.id                         AS AsientoModelo_2_id                    	-- 2	.AsientoModelo.id                                                  		VARCHAR(36)
				, AsientoModelo_2.numero                     AS AsientoModelo_2_numero                	-- 3	.AsientoModelo.numero                                              		INTEGER
				, AsientoModelo_2.nombre                     AS AsientoModelo_2_nombre                	-- 4	.AsientoModelo.nombre                                              		VARCHAR(50)
				, EjercicioContable_5.id                     AS EjercicioContable_5_id                	-- 5	.AsientoModelo.EjercicioContable.id                                		VARCHAR(36)
				, EjercicioContable_5.numero                 AS EjercicioContable_5_numero            	-- 6	.AsientoModelo.EjercicioContable.numero                            		INTEGER
				, EjercicioContable_5.apertura               AS EjercicioContable_5_apertura          	-- 7	.AsientoModelo.EjercicioContable.apertura                          		DATE
				, EjercicioContable_5.cierre                 AS EjercicioContable_5_cierre            	-- 8	.AsientoModelo.EjercicioContable.cierre                            		DATE
				, EjercicioContable_5.cerrado                AS EjercicioContable_5_cerrado           	-- 9	.AsientoModelo.EjercicioContable.cerrado                           		BOOLEAN
				, EjercicioContable_5.cerradoModulos         AS EjercicioContable_5_cerradoModulos    	-- 10	.AsientoModelo.EjercicioContable.cerradoModulos                    		BOOLEAN
				, EjercicioContable_5.comentario             AS EjercicioContable_5_comentario        	-- 11	.AsientoModelo.EjercicioContable.comentario                        		VARCHAR(250)
				, CuentaContable_12.id                       AS CuentaContable_12_id                  	-- 12	.CuentaContable.id                                                 		VARCHAR(36)
				, CuentaContable_12.codigo                   AS CuentaContable_12_codigo              	-- 13	.CuentaContable.codigo                                             		VARCHAR(11)
				, CuentaContable_12.nombre                   AS CuentaContable_12_nombre              	-- 14	.CuentaContable.nombre                                             		VARCHAR(50)
				, EjercicioContable_15.id                    AS EjercicioContable_15_id               	-- 15	.CuentaContable.EjercicioContable.id                               		VARCHAR(36)
				, EjercicioContable_15.numero                AS EjercicioContable_15_numero           	-- 16	.CuentaContable.EjercicioContable.numero                           		INTEGER
				, EjercicioContable_15.apertura              AS EjercicioContable_15_apertura         	-- 17	.CuentaContable.EjercicioContable.apertura                         		DATE
				, EjercicioContable_15.cierre                AS EjercicioContable_15_cierre           	-- 18	.CuentaContable.EjercicioContable.cierre                           		DATE
				, EjercicioContable_15.cerrado               AS EjercicioContable_15_cerrado          	-- 19	.CuentaContable.EjercicioContable.cerrado                          		BOOLEAN
				, EjercicioContable_15.cerradoModulos        AS EjercicioContable_15_cerradoModulos   	-- 20	.CuentaContable.EjercicioContable.cerradoModulos                   		BOOLEAN
				, EjercicioContable_15.comentario            AS EjercicioContable_15_comentario       	-- 21	.CuentaContable.EjercicioContable.comentario                       		VARCHAR(250)
				, CuentaContable_12.integra                  AS CuentaContable_12_integra             	-- 22	.CuentaContable.integra                                            		VARCHAR(16)
				, CuentaContable_12.cuentaJerarquia          AS CuentaContable_12_cuentaJerarquia     	-- 23	.CuentaContable.cuentaJerarquia                                    		VARCHAR(16)
				, CuentaContable_12.imputable                AS CuentaContable_12_imputable           	-- 24	.CuentaContable.imputable                                          		BOOLEAN
				, CuentaContable_12.ajustaPorInflacion       AS CuentaContable_12_ajustaPorInflacion  	-- 25	.CuentaContable.ajustaPorInflacion                                 		BOOLEAN
				, CuentaContableEstado_26.id                 AS CuentaContableEstado_26_id            	-- 26	.CuentaContable.CuentaContableEstado.id                            		VARCHAR(36)
				, CuentaContableEstado_26.numero             AS CuentaContableEstado_26_numero        	-- 27	.CuentaContable.CuentaContableEstado.numero                        		INTEGER
				, CuentaContableEstado_26.nombre             AS CuentaContableEstado_26_nombre        	-- 28	.CuentaContable.CuentaContableEstado.nombre                        		VARCHAR(50)
				, CuentaContable_12.cuentaConApropiacion     AS CuentaContable_12_cuentaConApropiacion	-- 29	.CuentaContable.cuentaConApropiacion                               		BOOLEAN
				, CentroCostoContable_30.id                  AS CentroCostoContable_30_id             	-- 30	.CuentaContable.CentroCostoContable.id                             		VARCHAR(36)
				, CentroCostoContable_30.numero              AS CentroCostoContable_30_numero         	-- 31	.CuentaContable.CentroCostoContable.numero                         		INTEGER
				, CentroCostoContable_30.nombre              AS CentroCostoContable_30_nombre         	-- 32	.CuentaContable.CentroCostoContable.nombre                         		VARCHAR(50)
				, CentroCostoContable_30.abreviatura         AS CentroCostoContable_30_abreviatura    	-- 33	.CuentaContable.CentroCostoContable.abreviatura                    		VARCHAR(5)
				, EjercicioContable_34.id                    AS EjercicioContable_34_id               	-- 34	.CuentaContable.CentroCostoContable.EjercicioContable.id           		VARCHAR(36)
				, EjercicioContable_34.numero                AS EjercicioContable_34_numero           	-- 35	.CuentaContable.CentroCostoContable.EjercicioContable.numero       		INTEGER
				, EjercicioContable_34.apertura              AS EjercicioContable_34_apertura         	-- 36	.CuentaContable.CentroCostoContable.EjercicioContable.apertura     		DATE
				, EjercicioContable_34.cierre                AS EjercicioContable_34_cierre           	-- 37	.CuentaContable.CentroCostoContable.EjercicioContable.cierre       		DATE
				, EjercicioContable_34.cerrado               AS EjercicioContable_34_cerrado          	-- 38	.CuentaContable.CentroCostoContable.EjercicioContable.cerrado      		BOOLEAN
				, EjercicioContable_34.cerradoModulos        AS EjercicioContable_34_cerradoModulos   	-- 39	.CuentaContable.CentroCostoContable.EjercicioContable.cerradoModulos		BOOLEAN
				, EjercicioContable_34.comentario            AS EjercicioContable_34_comentario       	-- 40	.CuentaContable.CentroCostoContable.EjercicioContable.comentario   		VARCHAR(250)
				, CuentaContable_12.cuentaAgrupadora         AS CuentaContable_12_cuentaAgrupadora    	-- 41	.CuentaContable.cuentaAgrupadora                                   		VARCHAR(50)
				, CuentaContable_12.porcentaje               AS CuentaContable_12_porcentaje          	-- 42	.CuentaContable.porcentaje                                         		DECIMAL(6,3)
				, PuntoEquilibrio_43.id                      AS PuntoEquilibrio_43_id                 	-- 43	.CuentaContable.PuntoEquilibrio.id                                 		VARCHAR(36)
				, PuntoEquilibrio_43.numero                  AS PuntoEquilibrio_43_numero             	-- 44	.CuentaContable.PuntoEquilibrio.numero                             		INTEGER
				, PuntoEquilibrio_43.nombre                  AS PuntoEquilibrio_43_nombre             	-- 45	.CuentaContable.PuntoEquilibrio.nombre                             		VARCHAR(50)
				, TipoPuntoEquilibrio_46.id                  AS TipoPuntoEquilibrio_46_id             	-- 46	.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.id             		VARCHAR(36)
				, TipoPuntoEquilibrio_46.numero              AS TipoPuntoEquilibrio_46_numero         	-- 47	.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.numero         		INTEGER
				, TipoPuntoEquilibrio_46.nombre              AS TipoPuntoEquilibrio_46_nombre         	-- 48	.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.nombre         		VARCHAR(50)
				, EjercicioContable_49.id                    AS EjercicioContable_49_id               	-- 49	.CuentaContable.PuntoEquilibrio.EjercicioContable.id               		VARCHAR(36)
				, EjercicioContable_49.numero                AS EjercicioContable_49_numero           	-- 50	.CuentaContable.PuntoEquilibrio.EjercicioContable.numero           		INTEGER
				, EjercicioContable_49.apertura              AS EjercicioContable_49_apertura         	-- 51	.CuentaContable.PuntoEquilibrio.EjercicioContable.apertura         		DATE
				, EjercicioContable_49.cierre                AS EjercicioContable_49_cierre           	-- 52	.CuentaContable.PuntoEquilibrio.EjercicioContable.cierre           		DATE
				, EjercicioContable_49.cerrado               AS EjercicioContable_49_cerrado          	-- 53	.CuentaContable.PuntoEquilibrio.EjercicioContable.cerrado          		BOOLEAN
				, EjercicioContable_49.cerradoModulos        AS EjercicioContable_49_cerradoModulos   	-- 54	.CuentaContable.PuntoEquilibrio.EjercicioContable.cerradoModulos   		BOOLEAN
				, EjercicioContable_49.comentario            AS EjercicioContable_49_comentario       	-- 55	.CuentaContable.PuntoEquilibrio.EjercicioContable.comentario       		VARCHAR(250)
				, CostoVenta_56.id                           AS CostoVenta_56_id                      	-- 56	.CuentaContable.CostoVenta.id                                      		VARCHAR(36)
				, CostoVenta_56.numero                       AS CostoVenta_56_numero                  	-- 57	.CuentaContable.CostoVenta.numero                                  		INTEGER
				, CostoVenta_56.nombre                       AS CostoVenta_56_nombre                  	-- 58	.CuentaContable.CostoVenta.nombre                                  		VARCHAR(50)
				, SeguridadPuerta_59.id                      AS SeguridadPuerta_59_id                 	-- 59	.CuentaContable.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_59.numero                  AS SeguridadPuerta_59_numero             	-- 60	.CuentaContable.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_59.nombre                  AS SeguridadPuerta_59_nombre             	-- 61	.CuentaContable.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_59.equate                  AS SeguridadPuerta_59_equate             	-- 62	.CuentaContable.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_63.id                      AS SeguridadModulo_63_id                 	-- 63	.CuentaContable.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_63.numero                  AS SeguridadModulo_63_numero             	-- 64	.CuentaContable.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_63.nombre                  AS SeguridadModulo_63_nombre             	-- 65	.CuentaContable.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)

		FROM	massoftware.AsientoModeloItem
			LEFT JOIN massoftware.AsientoModelo AS AsientoModelo_2                     ON AsientoModeloItem.asientoModelo = AsientoModelo_2.id 	-- 2 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_5                ON AsientoModelo_2.ejercicioContable = EjercicioContable_5.id 	-- 5 LEFT LEVEL: 2
			LEFT JOIN massoftware.CuentaContable AS CuentaContable_12                   ON AsientoModeloItem.cuentaContable = CuentaContable_12.id 	-- 12 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_15                ON CuentaContable_12.ejercicioContable = EjercicioContable_15.id 	-- 15 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_26             ON CuentaContable_12.cuentaContableEstado = CuentaContableEstado_26.id 	-- 26 LEFT LEVEL: 2
				LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_30              ON CuentaContable_12.centroCostoContable = CentroCostoContable_30.id 	-- 30 LEFT LEVEL: 2
					LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_34               ON CentroCostoContable_30.ejercicioContable = EjercicioContable_34.id 	-- 34 LEFT LEVEL: 3
				LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_43                  ON CuentaContable_12.puntoEquilibrio = PuntoEquilibrio_43.id 	-- 43 LEFT LEVEL: 2
					LEFT JOIN massoftware.TipoPuntoEquilibrio AS TipoPuntoEquilibrio_46             ON PuntoEquilibrio_43.tipoPuntoEquilibrio = TipoPuntoEquilibrio_46.id 	-- 46 LEFT LEVEL: 3
					LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_49               ON PuntoEquilibrio_43.ejercicioContable = EjercicioContable_49.id 	-- 49 LEFT LEVEL: 3
				LEFT JOIN massoftware.CostoVenta AS CostoVenta_56                       ON CuentaContable_12.costoVenta = CostoVenta_56.id 	-- 56 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_59                  ON CuentaContable_12.seguridadPuerta = SeguridadPuerta_59.id 	-- 59 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_63                 ON SeguridadPuerta_59.seguridadModulo = SeguridadModulo_63.id 	-- 63 LEFT LEVEL: 3

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoModeloItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND asientoModeloArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoModeloArg5)) > 0 THEN
		asientoModeloArg5 = REPLACE(asientoModeloArg5, '''', '''''');
		asientoModeloArg5 = LOWER(TRIM(asientoModeloArg5));
		asientoModeloArg5 = TRANSLATE(asientoModeloArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoModeloArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoModeloItem.asientoModelo),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoModeloItemById_3 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModeloItemById_3 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_AsientoModeloItem_3 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoModeloItem_3 ( idArg , null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoModeloItem_3 ( null , null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoModeloItemById_3 ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MinutaContable                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MinutaContable



DROP FUNCTION IF EXISTS massoftware.f_MinutaContable (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MinutaContable (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.MinutaContable AS $$

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
				  MinutaContable.id        AS MinutaContable_id    	-- 0	.id   		VARCHAR(36)
				, MinutaContable.numero    AS MinutaContable_numero	-- 1	.numero		INTEGER
				, MinutaContable.nombre    AS MinutaContable_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.MinutaContable

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' MinutaContable.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MinutaContable.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MinutaContable.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MinutaContable.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_MinutaContableById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MinutaContableById (idArg VARCHAR(36)) RETURNS SETOF massoftware.MinutaContable AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_MinutaContable ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_MinutaContable ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_MinutaContableById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContableModulo                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoContableModulo



DROP FUNCTION IF EXISTS massoftware.f_AsientoContableModulo (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableModulo (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.AsientoContableModulo AS $$

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
				  AsientoContableModulo.id        AS AsientoContableModulo_id    	-- 0	.id   		VARCHAR(36)
				, AsientoContableModulo.numero    AS AsientoContableModulo_numero	-- 1	.numero		INTEGER
				, AsientoContableModulo.nombre    AS AsientoContableModulo_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.AsientoContableModulo

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableModulo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableModulo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableModulo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContableModulo.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableModuloById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableModuloById (idArg VARCHAR(36)) RETURNS SETOF massoftware.AsientoContableModulo AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoContableModulo ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoContableModulo ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoContableModuloById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContable                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoContable



DROP FUNCTION IF EXISTS massoftware.f_AsientoContable (

	  idArg0                       VARCHAR(36) 	-- 0
	, orderByArg1                  INTEGER     	-- 1
	, orderByDescArg2              BOOLEAN     	-- 2
	, limitArg3                    BIGINT      	-- 3
	, offSetArg4                   BIGINT      	-- 4
	, numeroFromArg5               INTEGER     	-- 5
	, numeroToArg6                 INTEGER     	-- 6
	, detalleArg7                  VARCHAR(100)	-- 7
	, fechaFromArg8                DATE        	-- 8
	, fechaToArg9                  DATE        	-- 9
	, ejercicioContableArg10       VARCHAR(36) 	-- 10
	, minutaContableArg11          VARCHAR(36) 	-- 11
	, asientoContableModuloArg12   VARCHAR(36) 	-- 12
	, sucursalArg13                VARCHAR(36) 	-- 13

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContable (

	  idArg0                       VARCHAR(36) 	-- 0
	, orderByArg1                  INTEGER     	-- 1
	, orderByDescArg2              BOOLEAN     	-- 2
	, limitArg3                    BIGINT      	-- 3
	, offSetArg4                   BIGINT      	-- 4
	, numeroFromArg5               INTEGER     	-- 5
	, numeroToArg6                 INTEGER     	-- 6
	, detalleArg7                  VARCHAR(100)	-- 7
	, fechaFromArg8                DATE        	-- 8
	, fechaToArg9                  DATE        	-- 9
	, ejercicioContableArg10       VARCHAR(36) 	-- 10
	, minutaContableArg11          VARCHAR(36) 	-- 11
	, asientoContableModuloArg12   VARCHAR(36) 	-- 12
	, sucursalArg13                VARCHAR(36) 	-- 13

) RETURNS SETOF massoftware.AsientoContable AS $$

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
				  AsientoContable.id                       AS AsientoContable_id                   	-- 0	.id                  		VARCHAR(36)
				, AsientoContable.numero                   AS AsientoContable_numero               	-- 1	.numero              		INTEGER
				, AsientoContable.fecha                    AS AsientoContable_fecha                	-- 2	.fecha               		DATE
				, AsientoContable.detalle                  AS AsientoContable_detalle              	-- 3	.detalle             		VARCHAR(100)
				, AsientoContable.ejercicioContable        AS AsientoContable_ejercicioContable    	-- 4	.ejercicioContable   		VARCHAR(36)	EjercicioContable.id
				, AsientoContable.minutaContable           AS AsientoContable_minutaContable       	-- 5	.minutaContable      		VARCHAR(36)	MinutaContable.id
				, AsientoContable.sucursal                 AS AsientoContable_sucursal             	-- 6	.sucursal            		VARCHAR(36)	Sucursal.id
				, AsientoContable.asientoContableModulo    AS AsientoContable_asientoContableModulo	-- 7	.asientoContableModulo		VARCHAR(36)	AsientoContableModulo.id

		FROM	massoftware.AsientoContable

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND detalleArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(detalleArg7)) > 0 THEN
		detalleArg7 = REPLACE(detalleArg7, '''', '''''');
		detalleArg7 = LOWER(TRIM(detalleArg7));
		detalleArg7 = TRANSLATE(detalleArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(detalleArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.detalle),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND fechaFromArg8 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.fecha >= ' || fechaFromArg8;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND fechaToArg9 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.fecha <= ' || fechaToArg9;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND ejercicioContableArg10 IS NOT NULL AND CHAR_LENGTH(TRIM(ejercicioContableArg10)) > 0 THEN
		ejercicioContableArg10 = REPLACE(ejercicioContableArg10, '''', '''''');
		ejercicioContableArg10 = LOWER(TRIM(ejercicioContableArg10));
		ejercicioContableArg10 = TRANSLATE(ejercicioContableArg10,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ejercicioContableArg10, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.ejercicioContable),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND minutaContableArg11 IS NOT NULL AND CHAR_LENGTH(TRIM(minutaContableArg11)) > 0 THEN
		minutaContableArg11 = REPLACE(minutaContableArg11, '''', '''''');
		minutaContableArg11 = LOWER(TRIM(minutaContableArg11));
		minutaContableArg11 = TRANSLATE(minutaContableArg11,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(minutaContableArg11, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.minutaContable),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND asientoContableModuloArg12 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoContableModuloArg12)) > 0 THEN
		asientoContableModuloArg12 = REPLACE(asientoContableModuloArg12, '''', '''''');
		asientoContableModuloArg12 = LOWER(TRIM(asientoContableModuloArg12));
		asientoContableModuloArg12 = TRANSLATE(asientoContableModuloArg12,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoContableModuloArg12, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.asientoContableModulo),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND sucursalArg13 IS NOT NULL AND CHAR_LENGTH(TRIM(sucursalArg13)) > 0 THEN
		sucursalArg13 = REPLACE(sucursalArg13, '''', '''''');
		sucursalArg13 = LOWER(TRIM(sucursalArg13));
		sucursalArg13 = TRANSLATE(sucursalArg13,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(sucursalArg13, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.sucursal),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableById (idArg VARCHAR(36)) RETURNS SETOF massoftware.AsientoContable AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoContable ( idArg , null, null, null, null, null, null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoContable ( null , null, null, null, null, null, null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoContableById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_AsientoContable_1 (

	  idArg0                       VARCHAR(36) 	-- 0
	, orderByArg1                  INTEGER     	-- 1
	, orderByDescArg2              BOOLEAN     	-- 2
	, limitArg3                    BIGINT      	-- 3
	, offSetArg4                   BIGINT      	-- 4
	, numeroFromArg5               INTEGER     	-- 5
	, numeroToArg6                 INTEGER     	-- 6
	, detalleArg7                  VARCHAR(100)	-- 7
	, fechaFromArg8                DATE        	-- 8
	, fechaToArg9                  DATE        	-- 9
	, ejercicioContableArg10       VARCHAR(36) 	-- 10
	, minutaContableArg11          VARCHAR(36) 	-- 11
	, asientoContableModuloArg12   VARCHAR(36) 	-- 12
	, sucursalArg13                VARCHAR(36) 	-- 13

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContable_1 (

	  idArg0                       VARCHAR(36) 	-- 0
	, orderByArg1                  INTEGER     	-- 1
	, orderByDescArg2              BOOLEAN     	-- 2
	, limitArg3                    BIGINT      	-- 3
	, offSetArg4                   BIGINT      	-- 4
	, numeroFromArg5               INTEGER     	-- 5
	, numeroToArg6                 INTEGER     	-- 6
	, detalleArg7                  VARCHAR(100)	-- 7
	, fechaFromArg8                DATE        	-- 8
	, fechaToArg9                  DATE        	-- 9
	, ejercicioContableArg10       VARCHAR(36) 	-- 10
	, minutaContableArg11          VARCHAR(36) 	-- 11
	, asientoContableModuloArg12   VARCHAR(36) 	-- 12
	, sucursalArg13                VARCHAR(36) 	-- 13

) RETURNS SETOF massoftware.t_AsientoContable_1 AS $$

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
				  AsientoContable.id                                AS AsientoContable_id                           	-- 0	.id                                       		VARCHAR(36)
				, AsientoContable.numero                            AS AsientoContable_numero                       	-- 1	.numero                                   		INTEGER
				, AsientoContable.fecha                             AS AsientoContable_fecha                        	-- 2	.fecha                                    		DATE
				, AsientoContable.detalle                           AS AsientoContable_detalle                      	-- 3	.detalle                                  		VARCHAR(100)
				, EjercicioContable_4.id                            AS EjercicioContable_4_id                       	-- 4	.EjercicioContable.id                     		VARCHAR(36)
				, EjercicioContable_4.numero                        AS EjercicioContable_4_numero                   	-- 5	.EjercicioContable.numero                 		INTEGER
				, EjercicioContable_4.apertura                      AS EjercicioContable_4_apertura                 	-- 6	.EjercicioContable.apertura               		DATE
				, EjercicioContable_4.cierre                        AS EjercicioContable_4_cierre                   	-- 7	.EjercicioContable.cierre                 		DATE
				, EjercicioContable_4.cerrado                       AS EjercicioContable_4_cerrado                  	-- 8	.EjercicioContable.cerrado                		BOOLEAN
				, EjercicioContable_4.cerradoModulos                AS EjercicioContable_4_cerradoModulos           	-- 9	.EjercicioContable.cerradoModulos         		BOOLEAN
				, EjercicioContable_4.comentario                    AS EjercicioContable_4_comentario               	-- 10	.EjercicioContable.comentario             		VARCHAR(250)
				, MinutaContable_11.id                              AS MinutaContable_11_id                         	-- 11	.MinutaContable.id                        		VARCHAR(36)
				, MinutaContable_11.numero                          AS MinutaContable_11_numero                     	-- 12	.MinutaContable.numero                    		INTEGER
				, MinutaContable_11.nombre                          AS MinutaContable_11_nombre                     	-- 13	.MinutaContable.nombre                    		VARCHAR(50)
				, Sucursal_14.id                                    AS Sucursal_14_id                               	-- 14	.Sucursal.id                              		VARCHAR(36)
				, Sucursal_14.numero                                AS Sucursal_14_numero                           	-- 15	.Sucursal.numero                          		INTEGER
				, Sucursal_14.nombre                                AS Sucursal_14_nombre                           	-- 16	.Sucursal.nombre                          		VARCHAR(50)
				, Sucursal_14.abreviatura                           AS Sucursal_14_abreviatura                      	-- 17	.Sucursal.abreviatura                     		VARCHAR(5)
				, Sucursal_14.tipoSucursal                          AS Sucursal_14_tipoSucursal                     	-- 18	.Sucursal.tipoSucursal                    		VARCHAR(36)	TipoSucursal.id
				, Sucursal_14.cuentaClientesDesde                   AS Sucursal_14_cuentaClientesDesde              	-- 19	.Sucursal.cuentaClientesDesde             		VARCHAR(7)
				, Sucursal_14.cuentaClientesHasta                   AS Sucursal_14_cuentaClientesHasta              	-- 20	.Sucursal.cuentaClientesHasta             		VARCHAR(7)
				, Sucursal_14.cantidadCaracteresClientes            AS Sucursal_14_cantidadCaracteresClientes       	-- 21	.Sucursal.cantidadCaracteresClientes      		INTEGER
				, Sucursal_14.identificacionNumericaClientes        AS Sucursal_14_identificacionNumericaClientes   	-- 22	.Sucursal.identificacionNumericaClientes  		BOOLEAN
				, Sucursal_14.permiteCambiarClientes                AS Sucursal_14_permiteCambiarClientes           	-- 23	.Sucursal.permiteCambiarClientes          		BOOLEAN
				, Sucursal_14.cuentaProveedoresDesde                AS Sucursal_14_cuentaProveedoresDesde           	-- 24	.Sucursal.cuentaProveedoresDesde          		VARCHAR(6)
				, Sucursal_14.cuentaProveedoresHasta                AS Sucursal_14_cuentaProveedoresHasta           	-- 25	.Sucursal.cuentaProveedoresHasta          		VARCHAR(6)
				, Sucursal_14.cantidadCaracteresProveedores         AS Sucursal_14_cantidadCaracteresProveedores    	-- 26	.Sucursal.cantidadCaracteresProveedores   		INTEGER
				, Sucursal_14.identificacionNumericaProveedores     AS Sucursal_14_identificacionNumericaProveedores	-- 27	.Sucursal.identificacionNumericaProveedores		BOOLEAN
				, Sucursal_14.permiteCambiarProveedores             AS Sucursal_14_permiteCambiarProveedores        	-- 28	.Sucursal.permiteCambiarProveedores       		BOOLEAN
				, Sucursal_14.clientesOcacionalesDesde              AS Sucursal_14_clientesOcacionalesDesde         	-- 29	.Sucursal.clientesOcacionalesDesde        		INTEGER
				, Sucursal_14.clientesOcacionalesHasta              AS Sucursal_14_clientesOcacionalesHasta         	-- 30	.Sucursal.clientesOcacionalesHasta        		INTEGER
				, Sucursal_14.numeroCobranzaDesde                   AS Sucursal_14_numeroCobranzaDesde              	-- 31	.Sucursal.numeroCobranzaDesde             		INTEGER
				, Sucursal_14.numeroCobranzaHasta                   AS Sucursal_14_numeroCobranzaHasta              	-- 32	.Sucursal.numeroCobranzaHasta             		INTEGER
				, AsientoContableModulo_33.id                       AS AsientoContableModulo_33_id                  	-- 33	.AsientoContableModulo.id                 		VARCHAR(36)
				, AsientoContableModulo_33.numero                   AS AsientoContableModulo_33_numero              	-- 34	.AsientoContableModulo.numero             		INTEGER
				, AsientoContableModulo_33.nombre                   AS AsientoContableModulo_33_nombre              	-- 35	.AsientoContableModulo.nombre             		VARCHAR(50)

		FROM	massoftware.AsientoContable
			LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_4             ON AsientoContable.ejercicioContable = EjercicioContable_4.id 	-- 4 LEFT LEVEL: 1
			LEFT JOIN massoftware.MinutaContable AS MinutaContable_11               ON AsientoContable.minutaContable = MinutaContable_11.id 	-- 11 LEFT LEVEL: 1
			LEFT JOIN massoftware.Sucursal AS Sucursal_14                     ON AsientoContable.sucursal = Sucursal_14.id 	-- 14 LEFT LEVEL: 1
			LEFT JOIN massoftware.AsientoContableModulo AS AsientoContableModulo_33        ON AsientoContable.asientoContableModulo = AsientoContableModulo_33.id 	-- 33 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND detalleArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(detalleArg7)) > 0 THEN
		detalleArg7 = REPLACE(detalleArg7, '''', '''''');
		detalleArg7 = LOWER(TRIM(detalleArg7));
		detalleArg7 = TRANSLATE(detalleArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(detalleArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.detalle),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND fechaFromArg8 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.fecha >= ' || fechaFromArg8;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND fechaToArg9 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.fecha <= ' || fechaToArg9;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND ejercicioContableArg10 IS NOT NULL AND CHAR_LENGTH(TRIM(ejercicioContableArg10)) > 0 THEN
		ejercicioContableArg10 = REPLACE(ejercicioContableArg10, '''', '''''');
		ejercicioContableArg10 = LOWER(TRIM(ejercicioContableArg10));
		ejercicioContableArg10 = TRANSLATE(ejercicioContableArg10,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ejercicioContableArg10, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.ejercicioContable),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND minutaContableArg11 IS NOT NULL AND CHAR_LENGTH(TRIM(minutaContableArg11)) > 0 THEN
		minutaContableArg11 = REPLACE(minutaContableArg11, '''', '''''');
		minutaContableArg11 = LOWER(TRIM(minutaContableArg11));
		minutaContableArg11 = TRANSLATE(minutaContableArg11,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(minutaContableArg11, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.minutaContable),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND asientoContableModuloArg12 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoContableModuloArg12)) > 0 THEN
		asientoContableModuloArg12 = REPLACE(asientoContableModuloArg12, '''', '''''');
		asientoContableModuloArg12 = LOWER(TRIM(asientoContableModuloArg12));
		asientoContableModuloArg12 = TRANSLATE(asientoContableModuloArg12,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoContableModuloArg12, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.asientoContableModulo),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND sucursalArg13 IS NOT NULL AND CHAR_LENGTH(TRIM(sucursalArg13)) > 0 THEN
		sucursalArg13 = REPLACE(sucursalArg13, '''', '''''');
		sucursalArg13 = LOWER(TRIM(sucursalArg13));
		sucursalArg13 = TRANSLATE(sucursalArg13,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(sucursalArg13, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.sucursal),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_AsientoContable_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoContable_1 ( idArg , null, null, null, null, null, null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoContable_1 ( null , null, null, null, null, null, null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoContableById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_AsientoContable_2 (

	  idArg0                       VARCHAR(36) 	-- 0
	, orderByArg1                  INTEGER     	-- 1
	, orderByDescArg2              BOOLEAN     	-- 2
	, limitArg3                    BIGINT      	-- 3
	, offSetArg4                   BIGINT      	-- 4
	, numeroFromArg5               INTEGER     	-- 5
	, numeroToArg6                 INTEGER     	-- 6
	, detalleArg7                  VARCHAR(100)	-- 7
	, fechaFromArg8                DATE        	-- 8
	, fechaToArg9                  DATE        	-- 9
	, ejercicioContableArg10       VARCHAR(36) 	-- 10
	, minutaContableArg11          VARCHAR(36) 	-- 11
	, asientoContableModuloArg12   VARCHAR(36) 	-- 12
	, sucursalArg13                VARCHAR(36) 	-- 13

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContable_2 (

	  idArg0                       VARCHAR(36) 	-- 0
	, orderByArg1                  INTEGER     	-- 1
	, orderByDescArg2              BOOLEAN     	-- 2
	, limitArg3                    BIGINT      	-- 3
	, offSetArg4                   BIGINT      	-- 4
	, numeroFromArg5               INTEGER     	-- 5
	, numeroToArg6                 INTEGER     	-- 6
	, detalleArg7                  VARCHAR(100)	-- 7
	, fechaFromArg8                DATE        	-- 8
	, fechaToArg9                  DATE        	-- 9
	, ejercicioContableArg10       VARCHAR(36) 	-- 10
	, minutaContableArg11          VARCHAR(36) 	-- 11
	, asientoContableModuloArg12   VARCHAR(36) 	-- 12
	, sucursalArg13                VARCHAR(36) 	-- 13

) RETURNS SETOF massoftware.t_AsientoContable_2 AS $$

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
				  AsientoContable.id                                AS AsientoContable_id                           	-- 0	.id                                       		VARCHAR(36)
				, AsientoContable.numero                            AS AsientoContable_numero                       	-- 1	.numero                                   		INTEGER
				, AsientoContable.fecha                             AS AsientoContable_fecha                        	-- 2	.fecha                                    		DATE
				, AsientoContable.detalle                           AS AsientoContable_detalle                      	-- 3	.detalle                                  		VARCHAR(100)
				, EjercicioContable_4.id                            AS EjercicioContable_4_id                       	-- 4	.EjercicioContable.id                     		VARCHAR(36)
				, EjercicioContable_4.numero                        AS EjercicioContable_4_numero                   	-- 5	.EjercicioContable.numero                 		INTEGER
				, EjercicioContable_4.apertura                      AS EjercicioContable_4_apertura                 	-- 6	.EjercicioContable.apertura               		DATE
				, EjercicioContable_4.cierre                        AS EjercicioContable_4_cierre                   	-- 7	.EjercicioContable.cierre                 		DATE
				, EjercicioContable_4.cerrado                       AS EjercicioContable_4_cerrado                  	-- 8	.EjercicioContable.cerrado                		BOOLEAN
				, EjercicioContable_4.cerradoModulos                AS EjercicioContable_4_cerradoModulos           	-- 9	.EjercicioContable.cerradoModulos         		BOOLEAN
				, EjercicioContable_4.comentario                    AS EjercicioContable_4_comentario               	-- 10	.EjercicioContable.comentario             		VARCHAR(250)
				, MinutaContable_11.id                              AS MinutaContable_11_id                         	-- 11	.MinutaContable.id                        		VARCHAR(36)
				, MinutaContable_11.numero                          AS MinutaContable_11_numero                     	-- 12	.MinutaContable.numero                    		INTEGER
				, MinutaContable_11.nombre                          AS MinutaContable_11_nombre                     	-- 13	.MinutaContable.nombre                    		VARCHAR(50)
				, Sucursal_14.id                                    AS Sucursal_14_id                               	-- 14	.Sucursal.id                              		VARCHAR(36)
				, Sucursal_14.numero                                AS Sucursal_14_numero                           	-- 15	.Sucursal.numero                          		INTEGER
				, Sucursal_14.nombre                                AS Sucursal_14_nombre                           	-- 16	.Sucursal.nombre                          		VARCHAR(50)
				, Sucursal_14.abreviatura                           AS Sucursal_14_abreviatura                      	-- 17	.Sucursal.abreviatura                     		VARCHAR(5)
				, TipoSucursal_18.id                                AS TipoSucursal_18_id                           	-- 18	.Sucursal.TipoSucursal.id                 		VARCHAR(36)
				, TipoSucursal_18.numero                            AS TipoSucursal_18_numero                       	-- 19	.Sucursal.TipoSucursal.numero             		INTEGER
				, TipoSucursal_18.nombre                            AS TipoSucursal_18_nombre                       	-- 20	.Sucursal.TipoSucursal.nombre             		VARCHAR(50)
				, Sucursal_14.cuentaClientesDesde                   AS Sucursal_14_cuentaClientesDesde              	-- 21	.Sucursal.cuentaClientesDesde             		VARCHAR(7)
				, Sucursal_14.cuentaClientesHasta                   AS Sucursal_14_cuentaClientesHasta              	-- 22	.Sucursal.cuentaClientesHasta             		VARCHAR(7)
				, Sucursal_14.cantidadCaracteresClientes            AS Sucursal_14_cantidadCaracteresClientes       	-- 23	.Sucursal.cantidadCaracteresClientes      		INTEGER
				, Sucursal_14.identificacionNumericaClientes        AS Sucursal_14_identificacionNumericaClientes   	-- 24	.Sucursal.identificacionNumericaClientes  		BOOLEAN
				, Sucursal_14.permiteCambiarClientes                AS Sucursal_14_permiteCambiarClientes           	-- 25	.Sucursal.permiteCambiarClientes          		BOOLEAN
				, Sucursal_14.cuentaProveedoresDesde                AS Sucursal_14_cuentaProveedoresDesde           	-- 26	.Sucursal.cuentaProveedoresDesde          		VARCHAR(6)
				, Sucursal_14.cuentaProveedoresHasta                AS Sucursal_14_cuentaProveedoresHasta           	-- 27	.Sucursal.cuentaProveedoresHasta          		VARCHAR(6)
				, Sucursal_14.cantidadCaracteresProveedores         AS Sucursal_14_cantidadCaracteresProveedores    	-- 28	.Sucursal.cantidadCaracteresProveedores   		INTEGER
				, Sucursal_14.identificacionNumericaProveedores     AS Sucursal_14_identificacionNumericaProveedores	-- 29	.Sucursal.identificacionNumericaProveedores		BOOLEAN
				, Sucursal_14.permiteCambiarProveedores             AS Sucursal_14_permiteCambiarProveedores        	-- 30	.Sucursal.permiteCambiarProveedores       		BOOLEAN
				, Sucursal_14.clientesOcacionalesDesde              AS Sucursal_14_clientesOcacionalesDesde         	-- 31	.Sucursal.clientesOcacionalesDesde        		INTEGER
				, Sucursal_14.clientesOcacionalesHasta              AS Sucursal_14_clientesOcacionalesHasta         	-- 32	.Sucursal.clientesOcacionalesHasta        		INTEGER
				, Sucursal_14.numeroCobranzaDesde                   AS Sucursal_14_numeroCobranzaDesde              	-- 33	.Sucursal.numeroCobranzaDesde             		INTEGER
				, Sucursal_14.numeroCobranzaHasta                   AS Sucursal_14_numeroCobranzaHasta              	-- 34	.Sucursal.numeroCobranzaHasta             		INTEGER
				, AsientoContableModulo_35.id                       AS AsientoContableModulo_35_id                  	-- 35	.AsientoContableModulo.id                 		VARCHAR(36)
				, AsientoContableModulo_35.numero                   AS AsientoContableModulo_35_numero              	-- 36	.AsientoContableModulo.numero             		INTEGER
				, AsientoContableModulo_35.nombre                   AS AsientoContableModulo_35_nombre              	-- 37	.AsientoContableModulo.nombre             		VARCHAR(50)

		FROM	massoftware.AsientoContable
			LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_4             ON AsientoContable.ejercicioContable = EjercicioContable_4.id 	-- 4 LEFT LEVEL: 1
			LEFT JOIN massoftware.MinutaContable AS MinutaContable_11               ON AsientoContable.minutaContable = MinutaContable_11.id 	-- 11 LEFT LEVEL: 1
			LEFT JOIN massoftware.Sucursal AS Sucursal_14                     ON AsientoContable.sucursal = Sucursal_14.id 	-- 14 LEFT LEVEL: 1
				LEFT JOIN massoftware.TipoSucursal AS TipoSucursal_18                 ON Sucursal_14.tipoSucursal = TipoSucursal_18.id 	-- 18 LEFT LEVEL: 2
			LEFT JOIN massoftware.AsientoContableModulo AS AsientoContableModulo_35        ON AsientoContable.asientoContableModulo = AsientoContableModulo_35.id 	-- 35 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND detalleArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(detalleArg7)) > 0 THEN
		detalleArg7 = REPLACE(detalleArg7, '''', '''''');
		detalleArg7 = LOWER(TRIM(detalleArg7));
		detalleArg7 = TRANSLATE(detalleArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(detalleArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.detalle),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND fechaFromArg8 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.fecha >= ' || fechaFromArg8;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND fechaToArg9 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.fecha <= ' || fechaToArg9;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND ejercicioContableArg10 IS NOT NULL AND CHAR_LENGTH(TRIM(ejercicioContableArg10)) > 0 THEN
		ejercicioContableArg10 = REPLACE(ejercicioContableArg10, '''', '''''');
		ejercicioContableArg10 = LOWER(TRIM(ejercicioContableArg10));
		ejercicioContableArg10 = TRANSLATE(ejercicioContableArg10,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ejercicioContableArg10, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.ejercicioContable),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND minutaContableArg11 IS NOT NULL AND CHAR_LENGTH(TRIM(minutaContableArg11)) > 0 THEN
		minutaContableArg11 = REPLACE(minutaContableArg11, '''', '''''');
		minutaContableArg11 = LOWER(TRIM(minutaContableArg11));
		minutaContableArg11 = TRANSLATE(minutaContableArg11,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(minutaContableArg11, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.minutaContable),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND asientoContableModuloArg12 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoContableModuloArg12)) > 0 THEN
		asientoContableModuloArg12 = REPLACE(asientoContableModuloArg12, '''', '''''');
		asientoContableModuloArg12 = LOWER(TRIM(asientoContableModuloArg12));
		asientoContableModuloArg12 = TRANSLATE(asientoContableModuloArg12,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoContableModuloArg12, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.asientoContableModulo),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND sucursalArg13 IS NOT NULL AND CHAR_LENGTH(TRIM(sucursalArg13)) > 0 THEN
		sucursalArg13 = REPLACE(sucursalArg13, '''', '''''');
		sucursalArg13 = LOWER(TRIM(sucursalArg13));
		sucursalArg13 = TRANSLATE(sucursalArg13,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(sucursalArg13, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.sucursal),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_AsientoContable_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoContable_2 ( idArg , null, null, null, null, null, null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoContable_2 ( null , null, null, null, null, null, null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoContableById_2 ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContableItem                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoContableItem



DROP FUNCTION IF EXISTS massoftware.f_AsientoContableItem (

	  idArg0                VARCHAR(36) 	-- 0
	, orderByArg1           INTEGER     	-- 1
	, orderByDescArg2       BOOLEAN     	-- 2
	, limitArg3             BIGINT      	-- 3
	, offSetArg4            BIGINT      	-- 4
	, numeroFromArg5        INTEGER     	-- 5
	, numeroToArg6          INTEGER     	-- 6
	, detalleArg7           VARCHAR(100)	-- 7
	, asientoContableArg8   VARCHAR(36) 	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableItem (

	  idArg0                VARCHAR(36) 	-- 0
	, orderByArg1           INTEGER     	-- 1
	, orderByDescArg2       BOOLEAN     	-- 2
	, limitArg3             BIGINT      	-- 3
	, offSetArg4            BIGINT      	-- 4
	, numeroFromArg5        INTEGER     	-- 5
	, numeroToArg6          INTEGER     	-- 6
	, detalleArg7           VARCHAR(100)	-- 7
	, asientoContableArg8   VARCHAR(36) 	-- 8

) RETURNS SETOF massoftware.AsientoContableItem AS $$

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
				  AsientoContableItem.id                 AS AsientoContableItem_id             	-- 0	.id            		VARCHAR(36)
				, AsientoContableItem.numero             AS AsientoContableItem_numero         	-- 1	.numero        		INTEGER
				, AsientoContableItem.fecha              AS AsientoContableItem_fecha          	-- 2	.fecha         		DATE
				, AsientoContableItem.detalle            AS AsientoContableItem_detalle        	-- 3	.detalle       		VARCHAR(100)
				, AsientoContableItem.asientoContable    AS AsientoContableItem_asientoContable	-- 4	.asientoContable		VARCHAR(36)	AsientoContable.id
				, AsientoContableItem.cuentaContable     AS AsientoContableItem_cuentaContable 	-- 5	.cuentaContable		VARCHAR(36)	CuentaContable.id
				, AsientoContableItem.debe               AS AsientoContableItem_debe           	-- 6	.debe          		DECIMAL(13,5)
				, AsientoContableItem.haber              AS AsientoContableItem_haber          	-- 7	.haber         		DECIMAL(13,5)

		FROM	massoftware.AsientoContableItem

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND detalleArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(detalleArg7)) > 0 THEN
		detalleArg7 = REPLACE(detalleArg7, '''', '''''');
		detalleArg7 = LOWER(TRIM(detalleArg7));
		detalleArg7 = TRANSLATE(detalleArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(detalleArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContableItem.detalle),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND asientoContableArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoContableArg8)) > 0 THEN
		asientoContableArg8 = REPLACE(asientoContableArg8, '''', '''''');
		asientoContableArg8 = LOWER(TRIM(asientoContableArg8));
		asientoContableArg8 = TRANSLATE(asientoContableArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoContableArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContableItem.asientoContable),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableItemById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableItemById (idArg VARCHAR(36)) RETURNS SETOF massoftware.AsientoContableItem AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoContableItem ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoContableItem ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoContableItemById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableItem_1 (

	  idArg0                VARCHAR(36) 	-- 0
	, orderByArg1           INTEGER     	-- 1
	, orderByDescArg2       BOOLEAN     	-- 2
	, limitArg3             BIGINT      	-- 3
	, offSetArg4            BIGINT      	-- 4
	, numeroFromArg5        INTEGER     	-- 5
	, numeroToArg6          INTEGER     	-- 6
	, detalleArg7           VARCHAR(100)	-- 7
	, asientoContableArg8   VARCHAR(36) 	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableItem_1 (

	  idArg0                VARCHAR(36) 	-- 0
	, orderByArg1           INTEGER     	-- 1
	, orderByDescArg2       BOOLEAN     	-- 2
	, limitArg3             BIGINT      	-- 3
	, offSetArg4            BIGINT      	-- 4
	, numeroFromArg5        INTEGER     	-- 5
	, numeroToArg6          INTEGER     	-- 6
	, detalleArg7           VARCHAR(100)	-- 7
	, asientoContableArg8   VARCHAR(36) 	-- 8

) RETURNS SETOF massoftware.t_AsientoContableItem_1 AS $$

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
				  AsientoContableItem.id                      AS AsientoContableItem_id                 	-- 0	.id                                  		VARCHAR(36)
				, AsientoContableItem.numero                  AS AsientoContableItem_numero             	-- 1	.numero                              		INTEGER
				, AsientoContableItem.fecha                   AS AsientoContableItem_fecha              	-- 2	.fecha                               		DATE
				, AsientoContableItem.detalle                 AS AsientoContableItem_detalle            	-- 3	.detalle                             		VARCHAR(100)
				, AsientoContable_4.id                        AS AsientoContable_4_id                   	-- 4	.AsientoContable.id                  		VARCHAR(36)
				, AsientoContable_4.numero                    AS AsientoContable_4_numero               	-- 5	.AsientoContable.numero              		INTEGER
				, AsientoContable_4.fecha                     AS AsientoContable_4_fecha                	-- 6	.AsientoContable.fecha               		DATE
				, AsientoContable_4.detalle                   AS AsientoContable_4_detalle              	-- 7	.AsientoContable.detalle             		VARCHAR(100)
				, AsientoContable_4.ejercicioContable         AS AsientoContable_4_ejercicioContable    	-- 8	.AsientoContable.ejercicioContable   		VARCHAR(36)	EjercicioContable.id
				, AsientoContable_4.minutaContable            AS AsientoContable_4_minutaContable       	-- 9	.AsientoContable.minutaContable      		VARCHAR(36)	MinutaContable.id
				, AsientoContable_4.sucursal                  AS AsientoContable_4_sucursal             	-- 10	.AsientoContable.sucursal            		VARCHAR(36)	Sucursal.id
				, AsientoContable_4.asientoContableModulo     AS AsientoContable_4_asientoContableModulo	-- 11	.AsientoContable.asientoContableModulo		VARCHAR(36)	AsientoContableModulo.id
				, CuentaContable_12.id                        AS CuentaContable_12_id                   	-- 12	.CuentaContable.id                   		VARCHAR(36)
				, CuentaContable_12.codigo                    AS CuentaContable_12_codigo               	-- 13	.CuentaContable.codigo               		VARCHAR(11)
				, CuentaContable_12.nombre                    AS CuentaContable_12_nombre               	-- 14	.CuentaContable.nombre               		VARCHAR(50)
				, CuentaContable_12.ejercicioContable         AS CuentaContable_12_ejercicioContable    	-- 15	.CuentaContable.ejercicioContable    		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_12.integra                   AS CuentaContable_12_integra              	-- 16	.CuentaContable.integra              		VARCHAR(16)
				, CuentaContable_12.cuentaJerarquia           AS CuentaContable_12_cuentaJerarquia      	-- 17	.CuentaContable.cuentaJerarquia      		VARCHAR(16)
				, CuentaContable_12.imputable                 AS CuentaContable_12_imputable            	-- 18	.CuentaContable.imputable            		BOOLEAN
				, CuentaContable_12.ajustaPorInflacion        AS CuentaContable_12_ajustaPorInflacion   	-- 19	.CuentaContable.ajustaPorInflacion   		BOOLEAN
				, CuentaContable_12.cuentaContableEstado      AS CuentaContable_12_cuentaContableEstado 	-- 20	.CuentaContable.cuentaContableEstado 		VARCHAR(36)	CuentaContableEstado.id
				, CuentaContable_12.cuentaConApropiacion      AS CuentaContable_12_cuentaConApropiacion 	-- 21	.CuentaContable.cuentaConApropiacion 		BOOLEAN
				, CuentaContable_12.centroCostoContable       AS CuentaContable_12_centroCostoContable  	-- 22	.CuentaContable.centroCostoContable  		VARCHAR(36)	CentroCostoContable.id
				, CuentaContable_12.cuentaAgrupadora          AS CuentaContable_12_cuentaAgrupadora     	-- 23	.CuentaContable.cuentaAgrupadora     		VARCHAR(50)
				, CuentaContable_12.porcentaje                AS CuentaContable_12_porcentaje           	-- 24	.CuentaContable.porcentaje           		DECIMAL(6,3)
				, CuentaContable_12.puntoEquilibrio           AS CuentaContable_12_puntoEquilibrio      	-- 25	.CuentaContable.puntoEquilibrio      		VARCHAR(36)	PuntoEquilibrio.id
				, CuentaContable_12.costoVenta                AS CuentaContable_12_costoVenta           	-- 26	.CuentaContable.costoVenta           		VARCHAR(36)	CostoVenta.id
				, CuentaContable_12.seguridadPuerta           AS CuentaContable_12_seguridadPuerta      	-- 27	.CuentaContable.seguridadPuerta      		VARCHAR(36)	SeguridadPuerta.id
				, AsientoContableItem.debe                    AS AsientoContableItem_debe               	-- 28	.debe                                		DECIMAL(13,5)
				, AsientoContableItem.haber                   AS AsientoContableItem_haber              	-- 29	.haber                               		DECIMAL(13,5)

		FROM	massoftware.AsientoContableItem
			LEFT JOIN massoftware.AsientoContable AS AsientoContable_4        ON AsientoContableItem.asientoContable = AsientoContable_4.id 	-- 4 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaContable AS CuentaContable_12         ON AsientoContableItem.cuentaContable = CuentaContable_12.id 	-- 12 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND detalleArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(detalleArg7)) > 0 THEN
		detalleArg7 = REPLACE(detalleArg7, '''', '''''');
		detalleArg7 = LOWER(TRIM(detalleArg7));
		detalleArg7 = TRANSLATE(detalleArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(detalleArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContableItem.detalle),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND asientoContableArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoContableArg8)) > 0 THEN
		asientoContableArg8 = REPLACE(asientoContableArg8, '''', '''''');
		asientoContableArg8 = LOWER(TRIM(asientoContableArg8));
		asientoContableArg8 = TRANSLATE(asientoContableArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoContableArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContableItem.asientoContable),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableItemById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableItemById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_AsientoContableItem_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoContableItem_1 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoContableItem_1 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoContableItemById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableItem_2 (

	  idArg0                VARCHAR(36) 	-- 0
	, orderByArg1           INTEGER     	-- 1
	, orderByDescArg2       BOOLEAN     	-- 2
	, limitArg3             BIGINT      	-- 3
	, offSetArg4            BIGINT      	-- 4
	, numeroFromArg5        INTEGER     	-- 5
	, numeroToArg6          INTEGER     	-- 6
	, detalleArg7           VARCHAR(100)	-- 7
	, asientoContableArg8   VARCHAR(36) 	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableItem_2 (

	  idArg0                VARCHAR(36) 	-- 0
	, orderByArg1           INTEGER     	-- 1
	, orderByDescArg2       BOOLEAN     	-- 2
	, limitArg3             BIGINT      	-- 3
	, offSetArg4            BIGINT      	-- 4
	, numeroFromArg5        INTEGER     	-- 5
	, numeroToArg6          INTEGER     	-- 6
	, detalleArg7           VARCHAR(100)	-- 7
	, asientoContableArg8   VARCHAR(36) 	-- 8

) RETURNS SETOF massoftware.t_AsientoContableItem_2 AS $$

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
				  AsientoContableItem.id                            AS AsientoContableItem_id                       	-- 0	.id                                                       		VARCHAR(36)
				, AsientoContableItem.numero                        AS AsientoContableItem_numero                   	-- 1	.numero                                                   		INTEGER
				, AsientoContableItem.fecha                         AS AsientoContableItem_fecha                    	-- 2	.fecha                                                    		DATE
				, AsientoContableItem.detalle                       AS AsientoContableItem_detalle                  	-- 3	.detalle                                                  		VARCHAR(100)
				, AsientoContable_4.id                              AS AsientoContable_4_id                         	-- 4	.AsientoContable.id                                       		VARCHAR(36)
				, AsientoContable_4.numero                          AS AsientoContable_4_numero                     	-- 5	.AsientoContable.numero                                   		INTEGER
				, AsientoContable_4.fecha                           AS AsientoContable_4_fecha                      	-- 6	.AsientoContable.fecha                                    		DATE
				, AsientoContable_4.detalle                         AS AsientoContable_4_detalle                    	-- 7	.AsientoContable.detalle                                  		VARCHAR(100)
				, EjercicioContable_8.id                            AS EjercicioContable_8_id                       	-- 8	.AsientoContable.EjercicioContable.id                     		VARCHAR(36)
				, EjercicioContable_8.numero                        AS EjercicioContable_8_numero                   	-- 9	.AsientoContable.EjercicioContable.numero                 		INTEGER
				, EjercicioContable_8.apertura                      AS EjercicioContable_8_apertura                 	-- 10	.AsientoContable.EjercicioContable.apertura               		DATE
				, EjercicioContable_8.cierre                        AS EjercicioContable_8_cierre                   	-- 11	.AsientoContable.EjercicioContable.cierre                 		DATE
				, EjercicioContable_8.cerrado                       AS EjercicioContable_8_cerrado                  	-- 12	.AsientoContable.EjercicioContable.cerrado                		BOOLEAN
				, EjercicioContable_8.cerradoModulos                AS EjercicioContable_8_cerradoModulos           	-- 13	.AsientoContable.EjercicioContable.cerradoModulos         		BOOLEAN
				, EjercicioContable_8.comentario                    AS EjercicioContable_8_comentario               	-- 14	.AsientoContable.EjercicioContable.comentario             		VARCHAR(250)
				, MinutaContable_15.id                              AS MinutaContable_15_id                         	-- 15	.AsientoContable.MinutaContable.id                        		VARCHAR(36)
				, MinutaContable_15.numero                          AS MinutaContable_15_numero                     	-- 16	.AsientoContable.MinutaContable.numero                    		INTEGER
				, MinutaContable_15.nombre                          AS MinutaContable_15_nombre                     	-- 17	.AsientoContable.MinutaContable.nombre                    		VARCHAR(50)
				, Sucursal_18.id                                    AS Sucursal_18_id                               	-- 18	.AsientoContable.Sucursal.id                              		VARCHAR(36)
				, Sucursal_18.numero                                AS Sucursal_18_numero                           	-- 19	.AsientoContable.Sucursal.numero                          		INTEGER
				, Sucursal_18.nombre                                AS Sucursal_18_nombre                           	-- 20	.AsientoContable.Sucursal.nombre                          		VARCHAR(50)
				, Sucursal_18.abreviatura                           AS Sucursal_18_abreviatura                      	-- 21	.AsientoContable.Sucursal.abreviatura                     		VARCHAR(5)
				, Sucursal_18.tipoSucursal                          AS Sucursal_18_tipoSucursal                     	-- 22	.AsientoContable.Sucursal.tipoSucursal                    		VARCHAR(36)	TipoSucursal.id
				, Sucursal_18.cuentaClientesDesde                   AS Sucursal_18_cuentaClientesDesde              	-- 23	.AsientoContable.Sucursal.cuentaClientesDesde             		VARCHAR(7)
				, Sucursal_18.cuentaClientesHasta                   AS Sucursal_18_cuentaClientesHasta              	-- 24	.AsientoContable.Sucursal.cuentaClientesHasta             		VARCHAR(7)
				, Sucursal_18.cantidadCaracteresClientes            AS Sucursal_18_cantidadCaracteresClientes       	-- 25	.AsientoContable.Sucursal.cantidadCaracteresClientes      		INTEGER
				, Sucursal_18.identificacionNumericaClientes        AS Sucursal_18_identificacionNumericaClientes   	-- 26	.AsientoContable.Sucursal.identificacionNumericaClientes  		BOOLEAN
				, Sucursal_18.permiteCambiarClientes                AS Sucursal_18_permiteCambiarClientes           	-- 27	.AsientoContable.Sucursal.permiteCambiarClientes          		BOOLEAN
				, Sucursal_18.cuentaProveedoresDesde                AS Sucursal_18_cuentaProveedoresDesde           	-- 28	.AsientoContable.Sucursal.cuentaProveedoresDesde          		VARCHAR(6)
				, Sucursal_18.cuentaProveedoresHasta                AS Sucursal_18_cuentaProveedoresHasta           	-- 29	.AsientoContable.Sucursal.cuentaProveedoresHasta          		VARCHAR(6)
				, Sucursal_18.cantidadCaracteresProveedores         AS Sucursal_18_cantidadCaracteresProveedores    	-- 30	.AsientoContable.Sucursal.cantidadCaracteresProveedores   		INTEGER
				, Sucursal_18.identificacionNumericaProveedores     AS Sucursal_18_identificacionNumericaProveedores	-- 31	.AsientoContable.Sucursal.identificacionNumericaProveedores		BOOLEAN
				, Sucursal_18.permiteCambiarProveedores             AS Sucursal_18_permiteCambiarProveedores        	-- 32	.AsientoContable.Sucursal.permiteCambiarProveedores       		BOOLEAN
				, Sucursal_18.clientesOcacionalesDesde              AS Sucursal_18_clientesOcacionalesDesde         	-- 33	.AsientoContable.Sucursal.clientesOcacionalesDesde        		INTEGER
				, Sucursal_18.clientesOcacionalesHasta              AS Sucursal_18_clientesOcacionalesHasta         	-- 34	.AsientoContable.Sucursal.clientesOcacionalesHasta        		INTEGER
				, Sucursal_18.numeroCobranzaDesde                   AS Sucursal_18_numeroCobranzaDesde              	-- 35	.AsientoContable.Sucursal.numeroCobranzaDesde             		INTEGER
				, Sucursal_18.numeroCobranzaHasta                   AS Sucursal_18_numeroCobranzaHasta              	-- 36	.AsientoContable.Sucursal.numeroCobranzaHasta             		INTEGER
				, AsientoContableModulo_37.id                       AS AsientoContableModulo_37_id                  	-- 37	.AsientoContable.AsientoContableModulo.id                 		VARCHAR(36)
				, AsientoContableModulo_37.numero                   AS AsientoContableModulo_37_numero              	-- 38	.AsientoContable.AsientoContableModulo.numero             		INTEGER
				, AsientoContableModulo_37.nombre                   AS AsientoContableModulo_37_nombre              	-- 39	.AsientoContable.AsientoContableModulo.nombre             		VARCHAR(50)
				, CuentaContable_40.id                              AS CuentaContable_40_id                         	-- 40	.CuentaContable.id                                        		VARCHAR(36)
				, CuentaContable_40.codigo                          AS CuentaContable_40_codigo                     	-- 41	.CuentaContable.codigo                                    		VARCHAR(11)
				, CuentaContable_40.nombre                          AS CuentaContable_40_nombre                     	-- 42	.CuentaContable.nombre                                    		VARCHAR(50)
				, EjercicioContable_43.id                           AS EjercicioContable_43_id                      	-- 43	.CuentaContable.EjercicioContable.id                      		VARCHAR(36)
				, EjercicioContable_43.numero                       AS EjercicioContable_43_numero                  	-- 44	.CuentaContable.EjercicioContable.numero                  		INTEGER
				, EjercicioContable_43.apertura                     AS EjercicioContable_43_apertura                	-- 45	.CuentaContable.EjercicioContable.apertura                		DATE
				, EjercicioContable_43.cierre                       AS EjercicioContable_43_cierre                  	-- 46	.CuentaContable.EjercicioContable.cierre                  		DATE
				, EjercicioContable_43.cerrado                      AS EjercicioContable_43_cerrado                 	-- 47	.CuentaContable.EjercicioContable.cerrado                 		BOOLEAN
				, EjercicioContable_43.cerradoModulos               AS EjercicioContable_43_cerradoModulos          	-- 48	.CuentaContable.EjercicioContable.cerradoModulos          		BOOLEAN
				, EjercicioContable_43.comentario                   AS EjercicioContable_43_comentario              	-- 49	.CuentaContable.EjercicioContable.comentario              		VARCHAR(250)
				, CuentaContable_40.integra                         AS CuentaContable_40_integra                    	-- 50	.CuentaContable.integra                                   		VARCHAR(16)
				, CuentaContable_40.cuentaJerarquia                 AS CuentaContable_40_cuentaJerarquia            	-- 51	.CuentaContable.cuentaJerarquia                           		VARCHAR(16)
				, CuentaContable_40.imputable                       AS CuentaContable_40_imputable                  	-- 52	.CuentaContable.imputable                                 		BOOLEAN
				, CuentaContable_40.ajustaPorInflacion              AS CuentaContable_40_ajustaPorInflacion         	-- 53	.CuentaContable.ajustaPorInflacion                        		BOOLEAN
				, CuentaContableEstado_54.id                        AS CuentaContableEstado_54_id                   	-- 54	.CuentaContable.CuentaContableEstado.id                   		VARCHAR(36)
				, CuentaContableEstado_54.numero                    AS CuentaContableEstado_54_numero               	-- 55	.CuentaContable.CuentaContableEstado.numero               		INTEGER
				, CuentaContableEstado_54.nombre                    AS CuentaContableEstado_54_nombre               	-- 56	.CuentaContable.CuentaContableEstado.nombre               		VARCHAR(50)
				, CuentaContable_40.cuentaConApropiacion            AS CuentaContable_40_cuentaConApropiacion       	-- 57	.CuentaContable.cuentaConApropiacion                      		BOOLEAN
				, CentroCostoContable_58.id                         AS CentroCostoContable_58_id                    	-- 58	.CuentaContable.CentroCostoContable.id                    		VARCHAR(36)
				, CentroCostoContable_58.numero                     AS CentroCostoContable_58_numero                	-- 59	.CuentaContable.CentroCostoContable.numero                		INTEGER
				, CentroCostoContable_58.nombre                     AS CentroCostoContable_58_nombre                	-- 60	.CuentaContable.CentroCostoContable.nombre                		VARCHAR(50)
				, CentroCostoContable_58.abreviatura                AS CentroCostoContable_58_abreviatura           	-- 61	.CuentaContable.CentroCostoContable.abreviatura           		VARCHAR(5)
				, CentroCostoContable_58.ejercicioContable          AS CentroCostoContable_58_ejercicioContable     	-- 62	.CuentaContable.CentroCostoContable.ejercicioContable     		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_40.cuentaAgrupadora                AS CuentaContable_40_cuentaAgrupadora           	-- 63	.CuentaContable.cuentaAgrupadora                          		VARCHAR(50)
				, CuentaContable_40.porcentaje                      AS CuentaContable_40_porcentaje                 	-- 64	.CuentaContable.porcentaje                                		DECIMAL(6,3)
				, PuntoEquilibrio_65.id                             AS PuntoEquilibrio_65_id                        	-- 65	.CuentaContable.PuntoEquilibrio.id                        		VARCHAR(36)
				, PuntoEquilibrio_65.numero                         AS PuntoEquilibrio_65_numero                    	-- 66	.CuentaContable.PuntoEquilibrio.numero                    		INTEGER
				, PuntoEquilibrio_65.nombre                         AS PuntoEquilibrio_65_nombre                    	-- 67	.CuentaContable.PuntoEquilibrio.nombre                    		VARCHAR(50)
				, PuntoEquilibrio_65.tipoPuntoEquilibrio            AS PuntoEquilibrio_65_tipoPuntoEquilibrio       	-- 68	.CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio       		VARCHAR(36)	TipoPuntoEquilibrio.id
				, PuntoEquilibrio_65.ejercicioContable              AS PuntoEquilibrio_65_ejercicioContable         	-- 69	.CuentaContable.PuntoEquilibrio.ejercicioContable         		VARCHAR(36)	EjercicioContable.id
				, CostoVenta_70.id                                  AS CostoVenta_70_id                             	-- 70	.CuentaContable.CostoVenta.id                             		VARCHAR(36)
				, CostoVenta_70.numero                              AS CostoVenta_70_numero                         	-- 71	.CuentaContable.CostoVenta.numero                         		INTEGER
				, CostoVenta_70.nombre                              AS CostoVenta_70_nombre                         	-- 72	.CuentaContable.CostoVenta.nombre                         		VARCHAR(50)
				, SeguridadPuerta_73.id                             AS SeguridadPuerta_73_id                        	-- 73	.CuentaContable.SeguridadPuerta.id                        		VARCHAR(36)
				, SeguridadPuerta_73.numero                         AS SeguridadPuerta_73_numero                    	-- 74	.CuentaContable.SeguridadPuerta.numero                    		INTEGER
				, SeguridadPuerta_73.nombre                         AS SeguridadPuerta_73_nombre                    	-- 75	.CuentaContable.SeguridadPuerta.nombre                    		VARCHAR(50)
				, SeguridadPuerta_73.equate                         AS SeguridadPuerta_73_equate                    	-- 76	.CuentaContable.SeguridadPuerta.equate                    		VARCHAR(30)
				, SeguridadPuerta_73.seguridadModulo                AS SeguridadPuerta_73_seguridadModulo           	-- 77	.CuentaContable.SeguridadPuerta.seguridadModulo           		VARCHAR(36)	SeguridadModulo.id
				, AsientoContableItem.debe                          AS AsientoContableItem_debe                     	-- 78	.debe                                                     		DECIMAL(13,5)
				, AsientoContableItem.haber                         AS AsientoContableItem_haber                    	-- 79	.haber                                                    		DECIMAL(13,5)

		FROM	massoftware.AsientoContableItem
			LEFT JOIN massoftware.AsientoContable AS AsientoContable_4                  ON AsientoContableItem.asientoContable = AsientoContable_4.id 	-- 4 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_8               ON AsientoContable_4.ejercicioContable = EjercicioContable_8.id 	-- 8 LEFT LEVEL: 2
				LEFT JOIN massoftware.MinutaContable AS MinutaContable_15                  ON AsientoContable_4.minutaContable = MinutaContable_15.id 	-- 15 LEFT LEVEL: 2
				LEFT JOIN massoftware.Sucursal AS Sucursal_18                        ON AsientoContable_4.sucursal = Sucursal_18.id 	-- 18 LEFT LEVEL: 2
				LEFT JOIN massoftware.AsientoContableModulo AS AsientoContableModulo_37           ON AsientoContable_4.asientoContableModulo = AsientoContableModulo_37.id 	-- 37 LEFT LEVEL: 2
			LEFT JOIN massoftware.CuentaContable AS CuentaContable_40                  ON AsientoContableItem.cuentaContable = CuentaContable_40.id 	-- 40 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_43               ON CuentaContable_40.ejercicioContable = EjercicioContable_43.id 	-- 43 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_54            ON CuentaContable_40.cuentaContableEstado = CuentaContableEstado_54.id 	-- 54 LEFT LEVEL: 2
				LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_58             ON CuentaContable_40.centroCostoContable = CentroCostoContable_58.id 	-- 58 LEFT LEVEL: 2
				LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_65                 ON CuentaContable_40.puntoEquilibrio = PuntoEquilibrio_65.id 	-- 65 LEFT LEVEL: 2
				LEFT JOIN massoftware.CostoVenta AS CostoVenta_70                      ON CuentaContable_40.costoVenta = CostoVenta_70.id 	-- 70 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_73                 ON CuentaContable_40.seguridadPuerta = SeguridadPuerta_73.id 	-- 73 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND detalleArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(detalleArg7)) > 0 THEN
		detalleArg7 = REPLACE(detalleArg7, '''', '''''');
		detalleArg7 = LOWER(TRIM(detalleArg7));
		detalleArg7 = TRANSLATE(detalleArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(detalleArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContableItem.detalle),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND asientoContableArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoContableArg8)) > 0 THEN
		asientoContableArg8 = REPLACE(asientoContableArg8, '''', '''''');
		asientoContableArg8 = LOWER(TRIM(asientoContableArg8));
		asientoContableArg8 = TRANSLATE(asientoContableArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoContableArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContableItem.asientoContable),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableItemById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableItemById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_AsientoContableItem_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoContableItem_2 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoContableItem_2 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoContableItemById_2 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableItem_3 (

	  idArg0                VARCHAR(36) 	-- 0
	, orderByArg1           INTEGER     	-- 1
	, orderByDescArg2       BOOLEAN     	-- 2
	, limitArg3             BIGINT      	-- 3
	, offSetArg4            BIGINT      	-- 4
	, numeroFromArg5        INTEGER     	-- 5
	, numeroToArg6          INTEGER     	-- 6
	, detalleArg7           VARCHAR(100)	-- 7
	, asientoContableArg8   VARCHAR(36) 	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableItem_3 (

	  idArg0                VARCHAR(36) 	-- 0
	, orderByArg1           INTEGER     	-- 1
	, orderByDescArg2       BOOLEAN     	-- 2
	, limitArg3             BIGINT      	-- 3
	, offSetArg4            BIGINT      	-- 4
	, numeroFromArg5        INTEGER     	-- 5
	, numeroToArg6          INTEGER     	-- 6
	, detalleArg7           VARCHAR(100)	-- 7
	, asientoContableArg8   VARCHAR(36) 	-- 8

) RETURNS SETOF massoftware.t_AsientoContableItem_3 AS $$

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
				  AsientoContableItem.id                            AS AsientoContableItem_id                       	-- 0	.id                                                                		VARCHAR(36)
				, AsientoContableItem.numero                        AS AsientoContableItem_numero                   	-- 1	.numero                                                            		INTEGER
				, AsientoContableItem.fecha                         AS AsientoContableItem_fecha                    	-- 2	.fecha                                                             		DATE
				, AsientoContableItem.detalle                       AS AsientoContableItem_detalle                  	-- 3	.detalle                                                           		VARCHAR(100)
				, AsientoContable_4.id                              AS AsientoContable_4_id                         	-- 4	.AsientoContable.id                                                		VARCHAR(36)
				, AsientoContable_4.numero                          AS AsientoContable_4_numero                     	-- 5	.AsientoContable.numero                                            		INTEGER
				, AsientoContable_4.fecha                           AS AsientoContable_4_fecha                      	-- 6	.AsientoContable.fecha                                             		DATE
				, AsientoContable_4.detalle                         AS AsientoContable_4_detalle                    	-- 7	.AsientoContable.detalle                                           		VARCHAR(100)
				, EjercicioContable_8.id                            AS EjercicioContable_8_id                       	-- 8	.AsientoContable.EjercicioContable.id                              		VARCHAR(36)
				, EjercicioContable_8.numero                        AS EjercicioContable_8_numero                   	-- 9	.AsientoContable.EjercicioContable.numero                          		INTEGER
				, EjercicioContable_8.apertura                      AS EjercicioContable_8_apertura                 	-- 10	.AsientoContable.EjercicioContable.apertura                        		DATE
				, EjercicioContable_8.cierre                        AS EjercicioContable_8_cierre                   	-- 11	.AsientoContable.EjercicioContable.cierre                          		DATE
				, EjercicioContable_8.cerrado                       AS EjercicioContable_8_cerrado                  	-- 12	.AsientoContable.EjercicioContable.cerrado                         		BOOLEAN
				, EjercicioContable_8.cerradoModulos                AS EjercicioContable_8_cerradoModulos           	-- 13	.AsientoContable.EjercicioContable.cerradoModulos                  		BOOLEAN
				, EjercicioContable_8.comentario                    AS EjercicioContable_8_comentario               	-- 14	.AsientoContable.EjercicioContable.comentario                      		VARCHAR(250)
				, MinutaContable_15.id                              AS MinutaContable_15_id                         	-- 15	.AsientoContable.MinutaContable.id                                 		VARCHAR(36)
				, MinutaContable_15.numero                          AS MinutaContable_15_numero                     	-- 16	.AsientoContable.MinutaContable.numero                             		INTEGER
				, MinutaContable_15.nombre                          AS MinutaContable_15_nombre                     	-- 17	.AsientoContable.MinutaContable.nombre                             		VARCHAR(50)
				, Sucursal_18.id                                    AS Sucursal_18_id                               	-- 18	.AsientoContable.Sucursal.id                                       		VARCHAR(36)
				, Sucursal_18.numero                                AS Sucursal_18_numero                           	-- 19	.AsientoContable.Sucursal.numero                                   		INTEGER
				, Sucursal_18.nombre                                AS Sucursal_18_nombre                           	-- 20	.AsientoContable.Sucursal.nombre                                   		VARCHAR(50)
				, Sucursal_18.abreviatura                           AS Sucursal_18_abreviatura                      	-- 21	.AsientoContable.Sucursal.abreviatura                              		VARCHAR(5)
				, TipoSucursal_22.id                                AS TipoSucursal_22_id                           	-- 22	.AsientoContable.Sucursal.TipoSucursal.id                          		VARCHAR(36)
				, TipoSucursal_22.numero                            AS TipoSucursal_22_numero                       	-- 23	.AsientoContable.Sucursal.TipoSucursal.numero                      		INTEGER
				, TipoSucursal_22.nombre                            AS TipoSucursal_22_nombre                       	-- 24	.AsientoContable.Sucursal.TipoSucursal.nombre                      		VARCHAR(50)
				, Sucursal_18.cuentaClientesDesde                   AS Sucursal_18_cuentaClientesDesde              	-- 25	.AsientoContable.Sucursal.cuentaClientesDesde                      		VARCHAR(7)
				, Sucursal_18.cuentaClientesHasta                   AS Sucursal_18_cuentaClientesHasta              	-- 26	.AsientoContable.Sucursal.cuentaClientesHasta                      		VARCHAR(7)
				, Sucursal_18.cantidadCaracteresClientes            AS Sucursal_18_cantidadCaracteresClientes       	-- 27	.AsientoContable.Sucursal.cantidadCaracteresClientes               		INTEGER
				, Sucursal_18.identificacionNumericaClientes        AS Sucursal_18_identificacionNumericaClientes   	-- 28	.AsientoContable.Sucursal.identificacionNumericaClientes           		BOOLEAN
				, Sucursal_18.permiteCambiarClientes                AS Sucursal_18_permiteCambiarClientes           	-- 29	.AsientoContable.Sucursal.permiteCambiarClientes                   		BOOLEAN
				, Sucursal_18.cuentaProveedoresDesde                AS Sucursal_18_cuentaProveedoresDesde           	-- 30	.AsientoContable.Sucursal.cuentaProveedoresDesde                   		VARCHAR(6)
				, Sucursal_18.cuentaProveedoresHasta                AS Sucursal_18_cuentaProveedoresHasta           	-- 31	.AsientoContable.Sucursal.cuentaProveedoresHasta                   		VARCHAR(6)
				, Sucursal_18.cantidadCaracteresProveedores         AS Sucursal_18_cantidadCaracteresProveedores    	-- 32	.AsientoContable.Sucursal.cantidadCaracteresProveedores            		INTEGER
				, Sucursal_18.identificacionNumericaProveedores     AS Sucursal_18_identificacionNumericaProveedores	-- 33	.AsientoContable.Sucursal.identificacionNumericaProveedores        		BOOLEAN
				, Sucursal_18.permiteCambiarProveedores             AS Sucursal_18_permiteCambiarProveedores        	-- 34	.AsientoContable.Sucursal.permiteCambiarProveedores                		BOOLEAN
				, Sucursal_18.clientesOcacionalesDesde              AS Sucursal_18_clientesOcacionalesDesde         	-- 35	.AsientoContable.Sucursal.clientesOcacionalesDesde                 		INTEGER
				, Sucursal_18.clientesOcacionalesHasta              AS Sucursal_18_clientesOcacionalesHasta         	-- 36	.AsientoContable.Sucursal.clientesOcacionalesHasta                 		INTEGER
				, Sucursal_18.numeroCobranzaDesde                   AS Sucursal_18_numeroCobranzaDesde              	-- 37	.AsientoContable.Sucursal.numeroCobranzaDesde                      		INTEGER
				, Sucursal_18.numeroCobranzaHasta                   AS Sucursal_18_numeroCobranzaHasta              	-- 38	.AsientoContable.Sucursal.numeroCobranzaHasta                      		INTEGER
				, AsientoContableModulo_39.id                       AS AsientoContableModulo_39_id                  	-- 39	.AsientoContable.AsientoContableModulo.id                          		VARCHAR(36)
				, AsientoContableModulo_39.numero                   AS AsientoContableModulo_39_numero              	-- 40	.AsientoContable.AsientoContableModulo.numero                      		INTEGER
				, AsientoContableModulo_39.nombre                   AS AsientoContableModulo_39_nombre              	-- 41	.AsientoContable.AsientoContableModulo.nombre                      		VARCHAR(50)
				, CuentaContable_42.id                              AS CuentaContable_42_id                         	-- 42	.CuentaContable.id                                                 		VARCHAR(36)
				, CuentaContable_42.codigo                          AS CuentaContable_42_codigo                     	-- 43	.CuentaContable.codigo                                             		VARCHAR(11)
				, CuentaContable_42.nombre                          AS CuentaContable_42_nombre                     	-- 44	.CuentaContable.nombre                                             		VARCHAR(50)
				, EjercicioContable_45.id                           AS EjercicioContable_45_id                      	-- 45	.CuentaContable.EjercicioContable.id                               		VARCHAR(36)
				, EjercicioContable_45.numero                       AS EjercicioContable_45_numero                  	-- 46	.CuentaContable.EjercicioContable.numero                           		INTEGER
				, EjercicioContable_45.apertura                     AS EjercicioContable_45_apertura                	-- 47	.CuentaContable.EjercicioContable.apertura                         		DATE
				, EjercicioContable_45.cierre                       AS EjercicioContable_45_cierre                  	-- 48	.CuentaContable.EjercicioContable.cierre                           		DATE
				, EjercicioContable_45.cerrado                      AS EjercicioContable_45_cerrado                 	-- 49	.CuentaContable.EjercicioContable.cerrado                          		BOOLEAN
				, EjercicioContable_45.cerradoModulos               AS EjercicioContable_45_cerradoModulos          	-- 50	.CuentaContable.EjercicioContable.cerradoModulos                   		BOOLEAN
				, EjercicioContable_45.comentario                   AS EjercicioContable_45_comentario              	-- 51	.CuentaContable.EjercicioContable.comentario                       		VARCHAR(250)
				, CuentaContable_42.integra                         AS CuentaContable_42_integra                    	-- 52	.CuentaContable.integra                                            		VARCHAR(16)
				, CuentaContable_42.cuentaJerarquia                 AS CuentaContable_42_cuentaJerarquia            	-- 53	.CuentaContable.cuentaJerarquia                                    		VARCHAR(16)
				, CuentaContable_42.imputable                       AS CuentaContable_42_imputable                  	-- 54	.CuentaContable.imputable                                          		BOOLEAN
				, CuentaContable_42.ajustaPorInflacion              AS CuentaContable_42_ajustaPorInflacion         	-- 55	.CuentaContable.ajustaPorInflacion                                 		BOOLEAN
				, CuentaContableEstado_56.id                        AS CuentaContableEstado_56_id                   	-- 56	.CuentaContable.CuentaContableEstado.id                            		VARCHAR(36)
				, CuentaContableEstado_56.numero                    AS CuentaContableEstado_56_numero               	-- 57	.CuentaContable.CuentaContableEstado.numero                        		INTEGER
				, CuentaContableEstado_56.nombre                    AS CuentaContableEstado_56_nombre               	-- 58	.CuentaContable.CuentaContableEstado.nombre                        		VARCHAR(50)
				, CuentaContable_42.cuentaConApropiacion            AS CuentaContable_42_cuentaConApropiacion       	-- 59	.CuentaContable.cuentaConApropiacion                               		BOOLEAN
				, CentroCostoContable_60.id                         AS CentroCostoContable_60_id                    	-- 60	.CuentaContable.CentroCostoContable.id                             		VARCHAR(36)
				, CentroCostoContable_60.numero                     AS CentroCostoContable_60_numero                	-- 61	.CuentaContable.CentroCostoContable.numero                         		INTEGER
				, CentroCostoContable_60.nombre                     AS CentroCostoContable_60_nombre                	-- 62	.CuentaContable.CentroCostoContable.nombre                         		VARCHAR(50)
				, CentroCostoContable_60.abreviatura                AS CentroCostoContable_60_abreviatura           	-- 63	.CuentaContable.CentroCostoContable.abreviatura                    		VARCHAR(5)
				, EjercicioContable_64.id                           AS EjercicioContable_64_id                      	-- 64	.CuentaContable.CentroCostoContable.EjercicioContable.id           		VARCHAR(36)
				, EjercicioContable_64.numero                       AS EjercicioContable_64_numero                  	-- 65	.CuentaContable.CentroCostoContable.EjercicioContable.numero       		INTEGER
				, EjercicioContable_64.apertura                     AS EjercicioContable_64_apertura                	-- 66	.CuentaContable.CentroCostoContable.EjercicioContable.apertura     		DATE
				, EjercicioContable_64.cierre                       AS EjercicioContable_64_cierre                  	-- 67	.CuentaContable.CentroCostoContable.EjercicioContable.cierre       		DATE
				, EjercicioContable_64.cerrado                      AS EjercicioContable_64_cerrado                 	-- 68	.CuentaContable.CentroCostoContable.EjercicioContable.cerrado      		BOOLEAN
				, EjercicioContable_64.cerradoModulos               AS EjercicioContable_64_cerradoModulos          	-- 69	.CuentaContable.CentroCostoContable.EjercicioContable.cerradoModulos		BOOLEAN
				, EjercicioContable_64.comentario                   AS EjercicioContable_64_comentario              	-- 70	.CuentaContable.CentroCostoContable.EjercicioContable.comentario   		VARCHAR(250)
				, CuentaContable_42.cuentaAgrupadora                AS CuentaContable_42_cuentaAgrupadora           	-- 71	.CuentaContable.cuentaAgrupadora                                   		VARCHAR(50)
				, CuentaContable_42.porcentaje                      AS CuentaContable_42_porcentaje                 	-- 72	.CuentaContable.porcentaje                                         		DECIMAL(6,3)
				, PuntoEquilibrio_73.id                             AS PuntoEquilibrio_73_id                        	-- 73	.CuentaContable.PuntoEquilibrio.id                                 		VARCHAR(36)
				, PuntoEquilibrio_73.numero                         AS PuntoEquilibrio_73_numero                    	-- 74	.CuentaContable.PuntoEquilibrio.numero                             		INTEGER
				, PuntoEquilibrio_73.nombre                         AS PuntoEquilibrio_73_nombre                    	-- 75	.CuentaContable.PuntoEquilibrio.nombre                             		VARCHAR(50)
				, TipoPuntoEquilibrio_76.id                         AS TipoPuntoEquilibrio_76_id                    	-- 76	.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.id             		VARCHAR(36)
				, TipoPuntoEquilibrio_76.numero                     AS TipoPuntoEquilibrio_76_numero                	-- 77	.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.numero         		INTEGER
				, TipoPuntoEquilibrio_76.nombre                     AS TipoPuntoEquilibrio_76_nombre                	-- 78	.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.nombre         		VARCHAR(50)
				, EjercicioContable_79.id                           AS EjercicioContable_79_id                      	-- 79	.CuentaContable.PuntoEquilibrio.EjercicioContable.id               		VARCHAR(36)
				, EjercicioContable_79.numero                       AS EjercicioContable_79_numero                  	-- 80	.CuentaContable.PuntoEquilibrio.EjercicioContable.numero           		INTEGER
				, EjercicioContable_79.apertura                     AS EjercicioContable_79_apertura                	-- 81	.CuentaContable.PuntoEquilibrio.EjercicioContable.apertura         		DATE
				, EjercicioContable_79.cierre                       AS EjercicioContable_79_cierre                  	-- 82	.CuentaContable.PuntoEquilibrio.EjercicioContable.cierre           		DATE
				, EjercicioContable_79.cerrado                      AS EjercicioContable_79_cerrado                 	-- 83	.CuentaContable.PuntoEquilibrio.EjercicioContable.cerrado          		BOOLEAN
				, EjercicioContable_79.cerradoModulos               AS EjercicioContable_79_cerradoModulos          	-- 84	.CuentaContable.PuntoEquilibrio.EjercicioContable.cerradoModulos   		BOOLEAN
				, EjercicioContable_79.comentario                   AS EjercicioContable_79_comentario              	-- 85	.CuentaContable.PuntoEquilibrio.EjercicioContable.comentario       		VARCHAR(250)
				, CostoVenta_86.id                                  AS CostoVenta_86_id                             	-- 86	.CuentaContable.CostoVenta.id                                      		VARCHAR(36)
				, CostoVenta_86.numero                              AS CostoVenta_86_numero                         	-- 87	.CuentaContable.CostoVenta.numero                                  		INTEGER
				, CostoVenta_86.nombre                              AS CostoVenta_86_nombre                         	-- 88	.CuentaContable.CostoVenta.nombre                                  		VARCHAR(50)
				, SeguridadPuerta_89.id                             AS SeguridadPuerta_89_id                        	-- 89	.CuentaContable.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_89.numero                         AS SeguridadPuerta_89_numero                    	-- 90	.CuentaContable.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_89.nombre                         AS SeguridadPuerta_89_nombre                    	-- 91	.CuentaContable.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_89.equate                         AS SeguridadPuerta_89_equate                    	-- 92	.CuentaContable.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_93.id                             AS SeguridadModulo_93_id                        	-- 93	.CuentaContable.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_93.numero                         AS SeguridadModulo_93_numero                    	-- 94	.CuentaContable.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_93.nombre                         AS SeguridadModulo_93_nombre                    	-- 95	.CuentaContable.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)
				, AsientoContableItem.debe                          AS AsientoContableItem_debe                     	-- 96	.debe                                                              		DECIMAL(13,5)
				, AsientoContableItem.haber                         AS AsientoContableItem_haber                    	-- 97	.haber                                                             		DECIMAL(13,5)

		FROM	massoftware.AsientoContableItem
			LEFT JOIN massoftware.AsientoContable AS AsientoContable_4                   ON AsientoContableItem.asientoContable = AsientoContable_4.id 	-- 4 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_8                ON AsientoContable_4.ejercicioContable = EjercicioContable_8.id 	-- 8 LEFT LEVEL: 2
				LEFT JOIN massoftware.MinutaContable AS MinutaContable_15                   ON AsientoContable_4.minutaContable = MinutaContable_15.id 	-- 15 LEFT LEVEL: 2
				LEFT JOIN massoftware.Sucursal AS Sucursal_18                         ON AsientoContable_4.sucursal = Sucursal_18.id 	-- 18 LEFT LEVEL: 2
					LEFT JOIN massoftware.TipoSucursal AS TipoSucursal_22                    ON Sucursal_18.tipoSucursal = TipoSucursal_22.id 	-- 22 LEFT LEVEL: 3
				LEFT JOIN massoftware.AsientoContableModulo AS AsientoContableModulo_39            ON AsientoContable_4.asientoContableModulo = AsientoContableModulo_39.id 	-- 39 LEFT LEVEL: 2
			LEFT JOIN massoftware.CuentaContable AS CuentaContable_42                   ON AsientoContableItem.cuentaContable = CuentaContable_42.id 	-- 42 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_45                ON CuentaContable_42.ejercicioContable = EjercicioContable_45.id 	-- 45 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_56             ON CuentaContable_42.cuentaContableEstado = CuentaContableEstado_56.id 	-- 56 LEFT LEVEL: 2
				LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_60              ON CuentaContable_42.centroCostoContable = CentroCostoContable_60.id 	-- 60 LEFT LEVEL: 2
					LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_64               ON CentroCostoContable_60.ejercicioContable = EjercicioContable_64.id 	-- 64 LEFT LEVEL: 3
				LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_73                  ON CuentaContable_42.puntoEquilibrio = PuntoEquilibrio_73.id 	-- 73 LEFT LEVEL: 2
					LEFT JOIN massoftware.TipoPuntoEquilibrio AS TipoPuntoEquilibrio_76             ON PuntoEquilibrio_73.tipoPuntoEquilibrio = TipoPuntoEquilibrio_76.id 	-- 76 LEFT LEVEL: 3
					LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_79               ON PuntoEquilibrio_73.ejercicioContable = EjercicioContable_79.id 	-- 79 LEFT LEVEL: 3
				LEFT JOIN massoftware.CostoVenta AS CostoVenta_86                       ON CuentaContable_42.costoVenta = CostoVenta_86.id 	-- 86 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_89                  ON CuentaContable_42.seguridadPuerta = SeguridadPuerta_89.id 	-- 89 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_93                 ON SeguridadPuerta_89.seguridadModulo = SeguridadModulo_93.id 	-- 93 LEFT LEVEL: 3

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND detalleArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(detalleArg7)) > 0 THEN
		detalleArg7 = REPLACE(detalleArg7, '''', '''''');
		detalleArg7 = LOWER(TRIM(detalleArg7));
		detalleArg7 = TRANSLATE(detalleArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(detalleArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContableItem.detalle),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND asientoContableArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoContableArg8)) > 0 THEN
		asientoContableArg8 = REPLACE(asientoContableArg8, '''', '''''');
		asientoContableArg8 = LOWER(TRIM(asientoContableArg8));
		asientoContableArg8 = TRANSLATE(asientoContableArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoContableArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContableItem.asientoContable),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableItemById_3 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableItemById_3 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_AsientoContableItem_3 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoContableItem_3 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoContableItem_3 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoContableItemById_3 ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Empresa                                                                                                //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Empresa



DROP FUNCTION IF EXISTS massoftware.f_Empresa (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Empresa (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) RETURNS SETOF massoftware.Empresa AS $$

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
				  Empresa.id                                 AS Empresa_id                             	-- 0	.id                            		VARCHAR(36)
				, Empresa.ejercicioContable                  AS Empresa_ejercicioContable              	-- 1	.ejercicioContable             		VARCHAR(36)	EjercicioContable.id
				, Empresa.fechaCierreVentas                  AS Empresa_fechaCierreVentas              	-- 2	.fechaCierreVentas             		DATE
				, Empresa.fechaCierreStock                   AS Empresa_fechaCierreStock               	-- 3	.fechaCierreStock              		DATE
				, Empresa.fechaCierreFondo                   AS Empresa_fechaCierreFondo               	-- 4	.fechaCierreFondo              		DATE
				, Empresa.fechaCierreCompras                 AS Empresa_fechaCierreCompras             	-- 5	.fechaCierreCompras            		DATE
				, Empresa.fechaCierreContabilidad            AS Empresa_fechaCierreContabilidad        	-- 6	.fechaCierreContabilidad       		DATE
				, Empresa.fechaCierreGarantiaDevoluciones    AS Empresa_fechaCierreGarantiaDevoluciones	-- 7	.fechaCierreGarantiaDevoluciones		DATE
				, Empresa.fechaCierreTambos                  AS Empresa_fechaCierreTambos              	-- 8	.fechaCierreTambos             		DATE
				, Empresa.fechaCierreRRHH                    AS Empresa_fechaCierreRRHH                	-- 9	.fechaCierreRRHH               		DATE

		FROM	massoftware.Empresa

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Empresa.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
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

DROP FUNCTION IF EXISTS massoftware.f_EmpresaById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_EmpresaById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Empresa AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Empresa ( idArg , null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Empresa ( null , null, null, null, null); 

-- SELECT * FROM massoftware.f_EmpresaById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Empresa_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Empresa_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) RETURNS SETOF massoftware.t_Empresa_1 AS $$

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
				  Empresa.id                                  AS Empresa_id                             	-- 0	.id                             		VARCHAR(36)
				, EjercicioContable_1.id                      AS EjercicioContable_1_id                 	-- 1	.EjercicioContable.id           		VARCHAR(36)
				, EjercicioContable_1.numero                  AS EjercicioContable_1_numero             	-- 2	.EjercicioContable.numero       		INTEGER
				, EjercicioContable_1.apertura                AS EjercicioContable_1_apertura           	-- 3	.EjercicioContable.apertura     		DATE
				, EjercicioContable_1.cierre                  AS EjercicioContable_1_cierre             	-- 4	.EjercicioContable.cierre       		DATE
				, EjercicioContable_1.cerrado                 AS EjercicioContable_1_cerrado            	-- 5	.EjercicioContable.cerrado      		BOOLEAN
				, EjercicioContable_1.cerradoModulos          AS EjercicioContable_1_cerradoModulos     	-- 6	.EjercicioContable.cerradoModulos		BOOLEAN
				, EjercicioContable_1.comentario              AS EjercicioContable_1_comentario         	-- 7	.EjercicioContable.comentario   		VARCHAR(250)
				, Empresa.fechaCierreVentas                   AS Empresa_fechaCierreVentas              	-- 8	.fechaCierreVentas              		DATE
				, Empresa.fechaCierreStock                    AS Empresa_fechaCierreStock               	-- 9	.fechaCierreStock               		DATE
				, Empresa.fechaCierreFondo                    AS Empresa_fechaCierreFondo               	-- 10	.fechaCierreFondo               		DATE
				, Empresa.fechaCierreCompras                  AS Empresa_fechaCierreCompras             	-- 11	.fechaCierreCompras             		DATE
				, Empresa.fechaCierreContabilidad             AS Empresa_fechaCierreContabilidad        	-- 12	.fechaCierreContabilidad        		DATE
				, Empresa.fechaCierreGarantiaDevoluciones     AS Empresa_fechaCierreGarantiaDevoluciones	-- 13	.fechaCierreGarantiaDevoluciones		DATE
				, Empresa.fechaCierreTambos                   AS Empresa_fechaCierreTambos              	-- 14	.fechaCierreTambos              		DATE
				, Empresa.fechaCierreRRHH                     AS Empresa_fechaCierreRRHH                	-- 15	.fechaCierreRRHH                		DATE

		FROM	massoftware.Empresa
			LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_1        ON Empresa.ejercicioContable = EjercicioContable_1.id 	-- 1 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Empresa.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
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

DROP FUNCTION IF EXISTS massoftware.f_EmpresaById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_EmpresaById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Empresa_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Empresa_1 ( idArg , null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Empresa_1 ( null , null, null, null, null); 

-- SELECT * FROM massoftware.f_EmpresaById_1 ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Moneda                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Moneda



DROP FUNCTION IF EXISTS massoftware.f_Moneda (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, abreviaturaArg8   VARCHAR(5) 	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, abreviaturaArg8   VARCHAR(5) 	-- 8

) RETURNS SETOF massoftware.Moneda AS $$

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
				  Moneda.id                      AS Moneda_id                  	-- 0	.id                 		VARCHAR(36)
				, Moneda.numero                  AS Moneda_numero              	-- 1	.numero             		INTEGER
				, Moneda.nombre                  AS Moneda_nombre              	-- 2	.nombre             		VARCHAR(50)
				, Moneda.abreviatura             AS Moneda_abreviatura         	-- 3	.abreviatura        		VARCHAR(5)
				, Moneda.cotizacion              AS Moneda_cotizacion          	-- 4	.cotizacion         		DECIMAL(13,5)
				, Moneda.cotizacionFecha         AS Moneda_cotizacionFecha     	-- 5	.cotizacionFecha    		TIMESTAMP
				, Moneda.controlActualizacion    AS Moneda_controlActualizacion	-- 6	.controlActualizacion		BOOLEAN
				, Moneda.monedaAFIP              AS Moneda_monedaAFIP          	-- 7	.monedaAFIP         		VARCHAR(36)	MonedaAFIP.id

		FROM	massoftware.Moneda

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Moneda.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Moneda.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Moneda.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Moneda.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND abreviaturaArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(abreviaturaArg8)) > 0 THEN
		abreviaturaArg8 = REPLACE(abreviaturaArg8, '''', '''''');
		abreviaturaArg8 = LOWER(TRIM(abreviaturaArg8));
		abreviaturaArg8 = TRANSLATE(abreviaturaArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(abreviaturaArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Moneda.abreviatura),
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

DROP FUNCTION IF EXISTS massoftware.f_MonedaById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Moneda AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Moneda ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Moneda ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_MonedaById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Moneda_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, abreviaturaArg8   VARCHAR(5) 	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Moneda_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, abreviaturaArg8   VARCHAR(5) 	-- 8

) RETURNS SETOF massoftware.t_Moneda_1 AS $$

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
				  Moneda.id                      AS Moneda_id                  	-- 0	.id                 		VARCHAR(36)
				, Moneda.numero                  AS Moneda_numero              	-- 1	.numero             		INTEGER
				, Moneda.nombre                  AS Moneda_nombre              	-- 2	.nombre             		VARCHAR(50)
				, Moneda.abreviatura             AS Moneda_abreviatura         	-- 3	.abreviatura        		VARCHAR(5)
				, Moneda.cotizacion              AS Moneda_cotizacion          	-- 4	.cotizacion         		DECIMAL(13,5)
				, Moneda.cotizacionFecha         AS Moneda_cotizacionFecha     	-- 5	.cotizacionFecha    		TIMESTAMP
				, Moneda.controlActualizacion    AS Moneda_controlActualizacion	-- 6	.controlActualizacion		BOOLEAN
				, MonedaAFIP_7.id                AS MonedaAFIP_7_id            	-- 7	.MonedaAFIP.id      		VARCHAR(36)
				, MonedaAFIP_7.codigo            AS MonedaAFIP_7_codigo        	-- 8	.MonedaAFIP.codigo  		VARCHAR(3)
				, MonedaAFIP_7.nombre            AS MonedaAFIP_7_nombre        	-- 9	.MonedaAFIP.nombre  		VARCHAR(50)

		FROM	massoftware.Moneda
			LEFT JOIN massoftware.MonedaAFIP AS MonedaAFIP_7        ON Moneda.monedaAFIP = MonedaAFIP_7.id 	-- 7 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Moneda.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Moneda.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Moneda.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Moneda.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND abreviaturaArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(abreviaturaArg8)) > 0 THEN
		abreviaturaArg8 = REPLACE(abreviaturaArg8, '''', '''''');
		abreviaturaArg8 = LOWER(TRIM(abreviaturaArg8));
		abreviaturaArg8 = TRANSLATE(abreviaturaArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(abreviaturaArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Moneda.abreviatura),
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

DROP FUNCTION IF EXISTS massoftware.f_MonedaById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Moneda_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Moneda_1 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Moneda_1 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_MonedaById_1 ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MonedaCotizacion                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MonedaCotizacion



DROP FUNCTION IF EXISTS massoftware.f_MonedaCotizacion (

	  idArg0                    VARCHAR(36)	-- 0
	, orderByArg1               INTEGER    	-- 1
	, orderByDescArg2           BOOLEAN    	-- 2
	, limitArg3                 BIGINT     	-- 3
	, offSetArg4                BIGINT     	-- 4
	, monedaArg5                VARCHAR(36)	-- 5
	, cotizacionFechaFromArg6   TIMESTAMP  	-- 6
	, cotizacionFechaToArg7     TIMESTAMP  	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaCotizacion (

	  idArg0                    VARCHAR(36)	-- 0
	, orderByArg1               INTEGER    	-- 1
	, orderByDescArg2           BOOLEAN    	-- 2
	, limitArg3                 BIGINT     	-- 3
	, offSetArg4                BIGINT     	-- 4
	, monedaArg5                VARCHAR(36)	-- 5
	, cotizacionFechaFromArg6   TIMESTAMP  	-- 6
	, cotizacionFechaToArg7     TIMESTAMP  	-- 7

) RETURNS SETOF massoftware.MonedaCotizacion AS $$

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
				  MonedaCotizacion.id                          AS MonedaCotizacion_id                      	-- 0	.id                     		VARCHAR(36)
				, MonedaCotizacion.cotizacionFecha             AS MonedaCotizacion_cotizacionFecha         	-- 1	.cotizacionFecha        		TIMESTAMP
				, MonedaCotizacion.compra                      AS MonedaCotizacion_compra                  	-- 2	.compra                 		DECIMAL(13,5)
				, MonedaCotizacion.venta                       AS MonedaCotizacion_venta                   	-- 3	.venta                  		DECIMAL(13,5)
				, MonedaCotizacion.cotizacionFechaAuditoria    AS MonedaCotizacion_cotizacionFechaAuditoria	-- 4	.cotizacionFechaAuditoria		TIMESTAMP
				, MonedaCotizacion.moneda                      AS MonedaCotizacion_moneda                  	-- 5	.moneda                 		VARCHAR(36)	Moneda.id
				, MonedaCotizacion.usuario                     AS MonedaCotizacion_usuario                 	-- 6	.usuario                		VARCHAR(36)	Usuario.id

		FROM	massoftware.MonedaCotizacion

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' MonedaCotizacion.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND monedaArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(monedaArg5)) > 0 THEN
		monedaArg5 = REPLACE(monedaArg5, '''', '''''');
		monedaArg5 = LOWER(TRIM(monedaArg5));
		monedaArg5 = TRANSLATE(monedaArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(monedaArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MonedaCotizacion.moneda),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND cotizacionFechaFromArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MonedaCotizacion.cotizacionFecha >= ' || cotizacionFechaFromArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND cotizacionFechaToArg7 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MonedaCotizacion.cotizacionFecha <= ' || cotizacionFechaToArg7;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
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

DROP FUNCTION IF EXISTS massoftware.f_MonedaCotizacionById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaCotizacionById (idArg VARCHAR(36)) RETURNS SETOF massoftware.MonedaCotizacion AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_MonedaCotizacion ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_MonedaCotizacion ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_MonedaCotizacionById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_MonedaCotizacion_1 (

	  idArg0                    VARCHAR(36)	-- 0
	, orderByArg1               INTEGER    	-- 1
	, orderByDescArg2           BOOLEAN    	-- 2
	, limitArg3                 BIGINT     	-- 3
	, offSetArg4                BIGINT     	-- 4
	, monedaArg5                VARCHAR(36)	-- 5
	, cotizacionFechaFromArg6   TIMESTAMP  	-- 6
	, cotizacionFechaToArg7     TIMESTAMP  	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaCotizacion_1 (

	  idArg0                    VARCHAR(36)	-- 0
	, orderByArg1               INTEGER    	-- 1
	, orderByDescArg2           BOOLEAN    	-- 2
	, limitArg3                 BIGINT     	-- 3
	, offSetArg4                BIGINT     	-- 4
	, monedaArg5                VARCHAR(36)	-- 5
	, cotizacionFechaFromArg6   TIMESTAMP  	-- 6
	, cotizacionFechaToArg7     TIMESTAMP  	-- 7

) RETURNS SETOF massoftware.t_MonedaCotizacion_1 AS $$

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
				  MonedaCotizacion.id                          AS MonedaCotizacion_id                      	-- 0	.id                        		VARCHAR(36)
				, MonedaCotizacion.cotizacionFecha             AS MonedaCotizacion_cotizacionFecha         	-- 1	.cotizacionFecha           		TIMESTAMP
				, MonedaCotizacion.compra                      AS MonedaCotizacion_compra                  	-- 2	.compra                    		DECIMAL(13,5)
				, MonedaCotizacion.venta                       AS MonedaCotizacion_venta                   	-- 3	.venta                     		DECIMAL(13,5)
				, MonedaCotizacion.cotizacionFechaAuditoria    AS MonedaCotizacion_cotizacionFechaAuditoria	-- 4	.cotizacionFechaAuditoria  		TIMESTAMP
				, Moneda_5.id                                  AS Moneda_5_id                              	-- 5	.Moneda.id                 		VARCHAR(36)
				, Moneda_5.numero                              AS Moneda_5_numero                          	-- 6	.Moneda.numero             		INTEGER
				, Moneda_5.nombre                              AS Moneda_5_nombre                          	-- 7	.Moneda.nombre             		VARCHAR(50)
				, Moneda_5.abreviatura                         AS Moneda_5_abreviatura                     	-- 8	.Moneda.abreviatura        		VARCHAR(5)
				, Moneda_5.cotizacion                          AS Moneda_5_cotizacion                      	-- 9	.Moneda.cotizacion         		DECIMAL(13,5)
				, Moneda_5.cotizacionFecha                     AS Moneda_5_cotizacionFecha                 	-- 10	.Moneda.cotizacionFecha    		TIMESTAMP
				, Moneda_5.controlActualizacion                AS Moneda_5_controlActualizacion            	-- 11	.Moneda.controlActualizacion		BOOLEAN
				, Moneda_5.monedaAFIP                          AS Moneda_5_monedaAFIP                      	-- 12	.Moneda.monedaAFIP         		VARCHAR(36)	MonedaAFIP.id
				, Usuario_13.id                                AS Usuario_13_id                            	-- 13	.Usuario.id                		VARCHAR(36)
				, Usuario_13.numero                            AS Usuario_13_numero                        	-- 14	.Usuario.numero            		INTEGER
				, Usuario_13.nombre                            AS Usuario_13_nombre                        	-- 15	.Usuario.nombre            		VARCHAR(50)

		FROM	massoftware.MonedaCotizacion
			LEFT JOIN massoftware.Moneda AS Moneda_5          ON MonedaCotizacion.moneda = Moneda_5.id 	-- 5 LEFT LEVEL: 1
			LEFT JOIN massoftware.Usuario AS Usuario_13        ON MonedaCotizacion.usuario = Usuario_13.id 	-- 13 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' MonedaCotizacion.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND monedaArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(monedaArg5)) > 0 THEN
		monedaArg5 = REPLACE(monedaArg5, '''', '''''');
		monedaArg5 = LOWER(TRIM(monedaArg5));
		monedaArg5 = TRANSLATE(monedaArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(monedaArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MonedaCotizacion.moneda),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND cotizacionFechaFromArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MonedaCotizacion.cotizacionFecha >= ' || cotizacionFechaFromArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND cotizacionFechaToArg7 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MonedaCotizacion.cotizacionFecha <= ' || cotizacionFechaToArg7;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
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

DROP FUNCTION IF EXISTS massoftware.f_MonedaCotizacionById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaCotizacionById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_MonedaCotizacion_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_MonedaCotizacion_1 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_MonedaCotizacion_1 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_MonedaCotizacionById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_MonedaCotizacion_2 (

	  idArg0                    VARCHAR(36)	-- 0
	, orderByArg1               INTEGER    	-- 1
	, orderByDescArg2           BOOLEAN    	-- 2
	, limitArg3                 BIGINT     	-- 3
	, offSetArg4                BIGINT     	-- 4
	, monedaArg5                VARCHAR(36)	-- 5
	, cotizacionFechaFromArg6   TIMESTAMP  	-- 6
	, cotizacionFechaToArg7     TIMESTAMP  	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaCotizacion_2 (

	  idArg0                    VARCHAR(36)	-- 0
	, orderByArg1               INTEGER    	-- 1
	, orderByDescArg2           BOOLEAN    	-- 2
	, limitArg3                 BIGINT     	-- 3
	, offSetArg4                BIGINT     	-- 4
	, monedaArg5                VARCHAR(36)	-- 5
	, cotizacionFechaFromArg6   TIMESTAMP  	-- 6
	, cotizacionFechaToArg7     TIMESTAMP  	-- 7

) RETURNS SETOF massoftware.t_MonedaCotizacion_2 AS $$

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
				  MonedaCotizacion.id                          AS MonedaCotizacion_id                      	-- 0	.id                        		VARCHAR(36)
				, MonedaCotizacion.cotizacionFecha             AS MonedaCotizacion_cotizacionFecha         	-- 1	.cotizacionFecha           		TIMESTAMP
				, MonedaCotizacion.compra                      AS MonedaCotizacion_compra                  	-- 2	.compra                    		DECIMAL(13,5)
				, MonedaCotizacion.venta                       AS MonedaCotizacion_venta                   	-- 3	.venta                     		DECIMAL(13,5)
				, MonedaCotizacion.cotizacionFechaAuditoria    AS MonedaCotizacion_cotizacionFechaAuditoria	-- 4	.cotizacionFechaAuditoria  		TIMESTAMP
				, Moneda_5.id                                  AS Moneda_5_id                              	-- 5	.Moneda.id                 		VARCHAR(36)
				, Moneda_5.numero                              AS Moneda_5_numero                          	-- 6	.Moneda.numero             		INTEGER
				, Moneda_5.nombre                              AS Moneda_5_nombre                          	-- 7	.Moneda.nombre             		VARCHAR(50)
				, Moneda_5.abreviatura                         AS Moneda_5_abreviatura                     	-- 8	.Moneda.abreviatura        		VARCHAR(5)
				, Moneda_5.cotizacion                          AS Moneda_5_cotizacion                      	-- 9	.Moneda.cotizacion         		DECIMAL(13,5)
				, Moneda_5.cotizacionFecha                     AS Moneda_5_cotizacionFecha                 	-- 10	.Moneda.cotizacionFecha    		TIMESTAMP
				, Moneda_5.controlActualizacion                AS Moneda_5_controlActualizacion            	-- 11	.Moneda.controlActualizacion		BOOLEAN
				, MonedaAFIP_12.id                             AS MonedaAFIP_12_id                         	-- 12	.Moneda.MonedaAFIP.id      		VARCHAR(36)
				, MonedaAFIP_12.codigo                         AS MonedaAFIP_12_codigo                     	-- 13	.Moneda.MonedaAFIP.codigo  		VARCHAR(3)
				, MonedaAFIP_12.nombre                         AS MonedaAFIP_12_nombre                     	-- 14	.Moneda.MonedaAFIP.nombre  		VARCHAR(50)
				, Usuario_15.id                                AS Usuario_15_id                            	-- 15	.Usuario.id                		VARCHAR(36)
				, Usuario_15.numero                            AS Usuario_15_numero                        	-- 16	.Usuario.numero            		INTEGER
				, Usuario_15.nombre                            AS Usuario_15_nombre                        	-- 17	.Usuario.nombre            		VARCHAR(50)

		FROM	massoftware.MonedaCotizacion
			LEFT JOIN massoftware.Moneda AS Moneda_5                ON MonedaCotizacion.moneda = Moneda_5.id 	-- 5 LEFT LEVEL: 1
				LEFT JOIN massoftware.MonedaAFIP AS MonedaAFIP_12           ON Moneda_5.monedaAFIP = MonedaAFIP_12.id 	-- 12 LEFT LEVEL: 2
			LEFT JOIN massoftware.Usuario AS Usuario_15              ON MonedaCotizacion.usuario = Usuario_15.id 	-- 15 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' MonedaCotizacion.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND monedaArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(monedaArg5)) > 0 THEN
		monedaArg5 = REPLACE(monedaArg5, '''', '''''');
		monedaArg5 = LOWER(TRIM(monedaArg5));
		monedaArg5 = TRANSLATE(monedaArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(monedaArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MonedaCotizacion.moneda),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND cotizacionFechaFromArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MonedaCotizacion.cotizacionFecha >= ' || cotizacionFechaFromArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND cotizacionFechaToArg7 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MonedaCotizacion.cotizacionFecha <= ' || cotizacionFechaToArg7;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
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

DROP FUNCTION IF EXISTS massoftware.f_MonedaCotizacionById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaCotizacionById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_MonedaCotizacion_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_MonedaCotizacion_2 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_MonedaCotizacion_2 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_MonedaCotizacionById_2 ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Banco                                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Banco



DROP FUNCTION IF EXISTS massoftware.f_Banco (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Banco (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.Banco AS $$

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
				  Banco.id              AS Banco_id         	-- 0	.id        		VARCHAR(36)
				, Banco.numero          AS Banco_numero     	-- 1	.numero    		INTEGER
				, Banco.nombre          AS Banco_nombre     	-- 2	.nombre    		VARCHAR(50)
				, Banco.cuit            AS Banco_cuit       	-- 3	.cuit      		BIGINT
				, Banco.bloqueado       AS Banco_bloqueado  	-- 4	.bloqueado 		BOOLEAN
				, Banco.hoja            AS Banco_hoja       	-- 5	.hoja      		INTEGER
				, Banco.primeraFila     AS Banco_primeraFila	-- 6	.primeraFila		INTEGER
				, Banco.ultimaFila      AS Banco_ultimaFila 	-- 7	.ultimaFila		INTEGER
				, Banco.fecha           AS Banco_fecha      	-- 8	.fecha     		VARCHAR(3)
				, Banco.descripcion     AS Banco_descripcion	-- 9	.descripcion		VARCHAR(3)
				, Banco.referencia1     AS Banco_referencia1	-- 10	.referencia1		VARCHAR(3)
				, Banco.importe         AS Banco_importe    	-- 11	.importe   		VARCHAR(3)
				, Banco.referencia2     AS Banco_referencia2	-- 12	.referencia2		VARCHAR(3)
				, Banco.saldo           AS Banco_saldo      	-- 13	.saldo     		VARCHAR(3)

		FROM	massoftware.Banco

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Banco.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Banco.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Banco.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Banco.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_BancoById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_BancoById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Banco AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Banco ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Banco ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_BancoById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: BancoFirmante                                                                                          //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.BancoFirmante



DROP FUNCTION IF EXISTS massoftware.f_BancoFirmante (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_BancoFirmante (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.BancoFirmante AS $$

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
				  BancoFirmante.id           AS BancoFirmante_id       	-- 0	.id      		VARCHAR(36)
				, BancoFirmante.numero       AS BancoFirmante_numero   	-- 1	.numero  		INTEGER
				, BancoFirmante.nombre       AS BancoFirmante_nombre   	-- 2	.nombre  		VARCHAR(50)
				, BancoFirmante.cargo        AS BancoFirmante_cargo    	-- 3	.cargo   		VARCHAR(50)
				, BancoFirmante.bloqueado    AS BancoFirmante_bloqueado	-- 4	.bloqueado		BOOLEAN

		FROM	massoftware.BancoFirmante

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' BancoFirmante.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' BancoFirmante.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' BancoFirmante.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(BancoFirmante.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_BancoFirmanteById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_BancoFirmanteById (idArg VARCHAR(36)) RETURNS SETOF massoftware.BancoFirmante AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_BancoFirmante ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_BancoFirmante ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_BancoFirmanteById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Caja                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Caja



DROP FUNCTION IF EXISTS massoftware.f_Caja (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Caja (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.Caja AS $$

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
				  Caja.id                 AS Caja_id             	-- 0	.id            		VARCHAR(36)
				, Caja.numero             AS Caja_numero         	-- 1	.numero        		INTEGER
				, Caja.nombre             AS Caja_nombre         	-- 2	.nombre        		VARCHAR(50)
				, Caja.seguridadPuerta    AS Caja_seguridadPuerta	-- 3	.seguridadPuerta		VARCHAR(36)	SeguridadPuerta.id

		FROM	massoftware.Caja

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Caja.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Caja.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Caja.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Caja.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_CajaById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CajaById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Caja AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Caja ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Caja ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CajaById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Caja_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Caja_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.t_Caja_1 AS $$

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
				  Caja.id                              AS Caja_id                          	-- 0	.id                            		VARCHAR(36)
				, Caja.numero                          AS Caja_numero                      	-- 1	.numero                        		INTEGER
				, Caja.nombre                          AS Caja_nombre                      	-- 2	.nombre                        		VARCHAR(50)
				, SeguridadPuerta_3.id                 AS SeguridadPuerta_3_id             	-- 3	.SeguridadPuerta.id            		VARCHAR(36)
				, SeguridadPuerta_3.numero             AS SeguridadPuerta_3_numero         	-- 4	.SeguridadPuerta.numero        		INTEGER
				, SeguridadPuerta_3.nombre             AS SeguridadPuerta_3_nombre         	-- 5	.SeguridadPuerta.nombre        		VARCHAR(50)
				, SeguridadPuerta_3.equate             AS SeguridadPuerta_3_equate         	-- 6	.SeguridadPuerta.equate        		VARCHAR(30)
				, SeguridadPuerta_3.seguridadModulo    AS SeguridadPuerta_3_seguridadModulo	-- 7	.SeguridadPuerta.seguridadModulo		VARCHAR(36)	SeguridadModulo.id

		FROM	massoftware.Caja
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_3        ON Caja.seguridadPuerta = SeguridadPuerta_3.id 	-- 3 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Caja.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Caja.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Caja.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Caja.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_CajaById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CajaById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Caja_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Caja_1 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Caja_1 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CajaById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Caja_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Caja_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.t_Caja_2 AS $$

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
				  Caja.id                     AS Caja_id                 	-- 0	.id                                   		VARCHAR(36)
				, Caja.numero                 AS Caja_numero             	-- 1	.numero                               		INTEGER
				, Caja.nombre                 AS Caja_nombre             	-- 2	.nombre                               		VARCHAR(50)
				, SeguridadPuerta_3.id        AS SeguridadPuerta_3_id    	-- 3	.SeguridadPuerta.id                   		VARCHAR(36)
				, SeguridadPuerta_3.numero    AS SeguridadPuerta_3_numero	-- 4	.SeguridadPuerta.numero               		INTEGER
				, SeguridadPuerta_3.nombre    AS SeguridadPuerta_3_nombre	-- 5	.SeguridadPuerta.nombre               		VARCHAR(50)
				, SeguridadPuerta_3.equate    AS SeguridadPuerta_3_equate	-- 6	.SeguridadPuerta.equate               		VARCHAR(30)
				, SeguridadModulo_7.id        AS SeguridadModulo_7_id    	-- 7	.SeguridadPuerta.SeguridadModulo.id   		VARCHAR(36)
				, SeguridadModulo_7.numero    AS SeguridadModulo_7_numero	-- 8	.SeguridadPuerta.SeguridadModulo.numero		INTEGER
				, SeguridadModulo_7.nombre    AS SeguridadModulo_7_nombre	-- 9	.SeguridadPuerta.SeguridadModulo.nombre		VARCHAR(50)

		FROM	massoftware.Caja
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_3           ON Caja.seguridadPuerta = SeguridadPuerta_3.id 	-- 3 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_7           ON SeguridadPuerta_3.seguridadModulo = SeguridadModulo_7.id 	-- 7 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Caja.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Caja.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Caja.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Caja.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_CajaById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CajaById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Caja_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Caja_2 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Caja_2 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CajaById_2 ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondoTipo                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondoTipo



DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoTipo (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoTipo (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.CuentaFondoTipo AS $$

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
				  CuentaFondoTipo.id        AS CuentaFondoTipo_id    	-- 0	.id   		VARCHAR(36)
				, CuentaFondoTipo.numero    AS CuentaFondoTipo_numero	-- 1	.numero		INTEGER
				, CuentaFondoTipo.nombre    AS CuentaFondoTipo_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.CuentaFondoTipo

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondoTipo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondoTipo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondoTipo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondoTipo.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoTipoById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoTipoById (idArg VARCHAR(36)) RETURNS SETOF massoftware.CuentaFondoTipo AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaFondoTipo ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaFondoTipo ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaFondoTipoById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondoRubro                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondoRubro



DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoRubro (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoRubro (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.CuentaFondoRubro AS $$

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
				  CuentaFondoRubro.id        AS CuentaFondoRubro_id    	-- 0	.id   		VARCHAR(36)
				, CuentaFondoRubro.numero    AS CuentaFondoRubro_numero	-- 1	.numero		INTEGER
				, CuentaFondoRubro.nombre    AS CuentaFondoRubro_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.CuentaFondoRubro

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondoRubro.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondoRubro.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondoRubro.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondoRubro.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoRubroById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoRubroById (idArg VARCHAR(36)) RETURNS SETOF massoftware.CuentaFondoRubro AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaFondoRubro ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaFondoRubro ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaFondoRubroById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondoGrupo                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondoGrupo



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


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondoTipoBanco                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondoTipoBanco



DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoTipoBanco (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoTipoBanco (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.CuentaFondoTipoBanco AS $$

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
				  CuentaFondoTipoBanco.id        AS CuentaFondoTipoBanco_id    	-- 0	.id   		VARCHAR(36)
				, CuentaFondoTipoBanco.numero    AS CuentaFondoTipoBanco_numero	-- 1	.numero		INTEGER
				, CuentaFondoTipoBanco.nombre    AS CuentaFondoTipoBanco_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.CuentaFondoTipoBanco

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondoTipoBanco.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondoTipoBanco.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondoTipoBanco.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondoTipoBanco.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoTipoBancoById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoTipoBancoById (idArg VARCHAR(36)) RETURNS SETOF massoftware.CuentaFondoTipoBanco AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaFondoTipoBanco ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaFondoTipoBanco ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaFondoTipoBancoById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondoBancoCopia                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondoBancoCopia



DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoBancoCopia (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoBancoCopia (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.CuentaFondoBancoCopia AS $$

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
				  CuentaFondoBancoCopia.id        AS CuentaFondoBancoCopia_id    	-- 0	.id   		VARCHAR(36)
				, CuentaFondoBancoCopia.numero    AS CuentaFondoBancoCopia_numero	-- 1	.numero		INTEGER
				, CuentaFondoBancoCopia.nombre    AS CuentaFondoBancoCopia_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.CuentaFondoBancoCopia

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondoBancoCopia.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondoBancoCopia.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondoBancoCopia.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondoBancoCopia.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoBancoCopiaById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoBancoCopiaById (idArg VARCHAR(36)) RETURNS SETOF massoftware.CuentaFondoBancoCopia AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaFondoBancoCopia ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaFondoBancoCopia ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaFondoBancoCopiaById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondo                                                                                            //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondo



DROP FUNCTION IF EXISTS massoftware.f_CuentaFondo (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, bancoArg8         VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondo (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, bancoArg8         VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.CuentaFondo AS $$

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
				  CuentaFondo.id                            AS CuentaFondo_id                       	-- 0	.id                      		VARCHAR(36)
				, CuentaFondo.numero                        AS CuentaFondo_numero                   	-- 1	.numero                  		INTEGER
				, CuentaFondo.nombre                        AS CuentaFondo_nombre                   	-- 2	.nombre                  		VARCHAR(50)
				, CuentaFondo.cuentaContable                AS CuentaFondo_cuentaContable           	-- 3	.cuentaContable          		VARCHAR(36)	CuentaContable.id
				, CuentaFondo.cuentaFondoGrupo              AS CuentaFondo_cuentaFondoGrupo         	-- 4	.cuentaFondoGrupo        		VARCHAR(36)	CuentaFondoGrupo.id
				, CuentaFondo.cuentaFondoTipo               AS CuentaFondo_cuentaFondoTipo          	-- 5	.cuentaFondoTipo         		VARCHAR(36)	CuentaFondoTipo.id
				, CuentaFondo.obsoleto                      AS CuentaFondo_obsoleto                 	-- 6	.obsoleto                		BOOLEAN
				, CuentaFondo.noImprimeCaja                 AS CuentaFondo_noImprimeCaja            	-- 7	.noImprimeCaja           		BOOLEAN
				, CuentaFondo.ventas                        AS CuentaFondo_ventas                   	-- 8	.ventas                  		BOOLEAN
				, CuentaFondo.fondos                        AS CuentaFondo_fondos                   	-- 9	.fondos                  		BOOLEAN
				, CuentaFondo.compras                       AS CuentaFondo_compras                  	-- 10	.compras                 		BOOLEAN
				, CuentaFondo.moneda                        AS CuentaFondo_moneda                   	-- 11	.moneda                  		VARCHAR(36)	Moneda.id
				, CuentaFondo.caja                          AS CuentaFondo_caja                     	-- 12	.caja                    		VARCHAR(36)	Caja.id
				, CuentaFondo.rechazados                    AS CuentaFondo_rechazados               	-- 13	.rechazados              		BOOLEAN
				, CuentaFondo.conciliacion                  AS CuentaFondo_conciliacion             	-- 14	.conciliacion            		BOOLEAN
				, CuentaFondo.cuentaFondoTipoBanco          AS CuentaFondo_cuentaFondoTipoBanco     	-- 15	.cuentaFondoTipoBanco    		VARCHAR(36)	CuentaFondoTipoBanco.id
				, CuentaFondo.banco                         AS CuentaFondo_banco                    	-- 16	.banco                   		VARCHAR(36)	Banco.id
				, CuentaFondo.cuentaBancaria                AS CuentaFondo_cuentaBancaria           	-- 17	.cuentaBancaria          		VARCHAR(22)
				, CuentaFondo.cbu                           AS CuentaFondo_cbu                      	-- 18	.cbu                     		VARCHAR(22)
				, CuentaFondo.limiteDescubierto             AS CuentaFondo_limiteDescubierto        	-- 19	.limiteDescubierto       		DECIMAL(13,5)
				, CuentaFondo.cuentaFondoCaucion            AS CuentaFondo_cuentaFondoCaucion       	-- 20	.cuentaFondoCaucion      		VARCHAR(50)
				, CuentaFondo.cuentaFondoDiferidos          AS CuentaFondo_cuentaFondoDiferidos     	-- 21	.cuentaFondoDiferidos    		VARCHAR(50)
				, CuentaFondo.formato                       AS CuentaFondo_formato                  	-- 22	.formato                 		VARCHAR(50)
				, CuentaFondo.cuentaFondoBancoCopia         AS CuentaFondo_cuentaFondoBancoCopia    	-- 23	.cuentaFondoBancoCopia   		VARCHAR(36)	CuentaFondoBancoCopia.id
				, CuentaFondo.limiteOperacionIndividual     AS CuentaFondo_limiteOperacionIndividual	-- 24	.limiteOperacionIndividual		DECIMAL(13,5)
				, CuentaFondo.seguridadPuertaUso            AS CuentaFondo_seguridadPuertaUso       	-- 25	.seguridadPuertaUso      		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondo.seguridadPuertaConsulta       AS CuentaFondo_seguridadPuertaConsulta  	-- 26	.seguridadPuertaConsulta 		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondo.seguridadPuertaLimite         AS CuentaFondo_seguridadPuertaLimite    	-- 27	.seguridadPuertaLimite   		VARCHAR(36)	SeguridadPuerta.id

		FROM	massoftware.CuentaFondo

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondo.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND bancoArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(bancoArg8)) > 0 THEN
		bancoArg8 = REPLACE(bancoArg8, '''', '''''');
		bancoArg8 = LOWER(TRIM(bancoArg8));
		bancoArg8 = TRANSLATE(bancoArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(bancoArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondo.banco),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoById (idArg VARCHAR(36)) RETURNS SETOF massoftware.CuentaFondo AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaFondo ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaFondo ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaFondoById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondo_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, bancoArg8         VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondo_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, bancoArg8         VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_CuentaFondo_1 AS $$

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
				  CuentaFondo.id                            AS CuentaFondo_id                       	-- 0	.id                                		VARCHAR(36)
				, CuentaFondo.numero                        AS CuentaFondo_numero                   	-- 1	.numero                            		INTEGER
				, CuentaFondo.nombre                        AS CuentaFondo_nombre                   	-- 2	.nombre                            		VARCHAR(50)
				, CuentaContable_3.id                       AS CuentaContable_3_id                  	-- 3	.CuentaContable.id                 		VARCHAR(36)
				, CuentaContable_3.codigo                   AS CuentaContable_3_codigo              	-- 4	.CuentaContable.codigo             		VARCHAR(11)
				, CuentaContable_3.nombre                   AS CuentaContable_3_nombre              	-- 5	.CuentaContable.nombre             		VARCHAR(50)
				, CuentaContable_3.ejercicioContable        AS CuentaContable_3_ejercicioContable   	-- 6	.CuentaContable.ejercicioContable  		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_3.integra                  AS CuentaContable_3_integra             	-- 7	.CuentaContable.integra            		VARCHAR(16)
				, CuentaContable_3.cuentaJerarquia          AS CuentaContable_3_cuentaJerarquia     	-- 8	.CuentaContable.cuentaJerarquia    		VARCHAR(16)
				, CuentaContable_3.imputable                AS CuentaContable_3_imputable           	-- 9	.CuentaContable.imputable          		BOOLEAN
				, CuentaContable_3.ajustaPorInflacion       AS CuentaContable_3_ajustaPorInflacion  	-- 10	.CuentaContable.ajustaPorInflacion 		BOOLEAN
				, CuentaContable_3.cuentaContableEstado     AS CuentaContable_3_cuentaContableEstado	-- 11	.CuentaContable.cuentaContableEstado		VARCHAR(36)	CuentaContableEstado.id
				, CuentaContable_3.cuentaConApropiacion     AS CuentaContable_3_cuentaConApropiacion	-- 12	.CuentaContable.cuentaConApropiacion		BOOLEAN
				, CuentaContable_3.centroCostoContable      AS CuentaContable_3_centroCostoContable 	-- 13	.CuentaContable.centroCostoContable		VARCHAR(36)	CentroCostoContable.id
				, CuentaContable_3.cuentaAgrupadora         AS CuentaContable_3_cuentaAgrupadora    	-- 14	.CuentaContable.cuentaAgrupadora   		VARCHAR(50)
				, CuentaContable_3.porcentaje               AS CuentaContable_3_porcentaje          	-- 15	.CuentaContable.porcentaje         		DECIMAL(6,3)
				, CuentaContable_3.puntoEquilibrio          AS CuentaContable_3_puntoEquilibrio     	-- 16	.CuentaContable.puntoEquilibrio    		VARCHAR(36)	PuntoEquilibrio.id
				, CuentaContable_3.costoVenta               AS CuentaContable_3_costoVenta          	-- 17	.CuentaContable.costoVenta         		VARCHAR(36)	CostoVenta.id
				, CuentaContable_3.seguridadPuerta          AS CuentaContable_3_seguridadPuerta     	-- 18	.CuentaContable.seguridadPuerta    		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondoGrupo_19.id                    AS CuentaFondoGrupo_19_id               	-- 19	.CuentaFondoGrupo.id               		VARCHAR(36)
				, CuentaFondoGrupo_19.numero                AS CuentaFondoGrupo_19_numero           	-- 20	.CuentaFondoGrupo.numero           		INTEGER
				, CuentaFondoGrupo_19.nombre                AS CuentaFondoGrupo_19_nombre           	-- 21	.CuentaFondoGrupo.nombre           		VARCHAR(50)
				, CuentaFondoGrupo_19.cuentaFondoRubro      AS CuentaFondoGrupo_19_cuentaFondoRubro 	-- 22	.CuentaFondoGrupo.cuentaFondoRubro 		VARCHAR(36)	CuentaFondoRubro.id
				, CuentaFondoTipo_23.id                     AS CuentaFondoTipo_23_id                	-- 23	.CuentaFondoTipo.id                		VARCHAR(36)
				, CuentaFondoTipo_23.numero                 AS CuentaFondoTipo_23_numero            	-- 24	.CuentaFondoTipo.numero            		INTEGER
				, CuentaFondoTipo_23.nombre                 AS CuentaFondoTipo_23_nombre            	-- 25	.CuentaFondoTipo.nombre            		VARCHAR(50)
				, CuentaFondo.obsoleto                      AS CuentaFondo_obsoleto                 	-- 26	.obsoleto                          		BOOLEAN
				, CuentaFondo.noImprimeCaja                 AS CuentaFondo_noImprimeCaja            	-- 27	.noImprimeCaja                     		BOOLEAN
				, CuentaFondo.ventas                        AS CuentaFondo_ventas                   	-- 28	.ventas                            		BOOLEAN
				, CuentaFondo.fondos                        AS CuentaFondo_fondos                   	-- 29	.fondos                            		BOOLEAN
				, CuentaFondo.compras                       AS CuentaFondo_compras                  	-- 30	.compras                           		BOOLEAN
				, Moneda_31.id                              AS Moneda_31_id                         	-- 31	.Moneda.id                         		VARCHAR(36)
				, Moneda_31.numero                          AS Moneda_31_numero                     	-- 32	.Moneda.numero                     		INTEGER
				, Moneda_31.nombre                          AS Moneda_31_nombre                     	-- 33	.Moneda.nombre                     		VARCHAR(50)
				, Moneda_31.abreviatura                     AS Moneda_31_abreviatura                	-- 34	.Moneda.abreviatura                		VARCHAR(5)
				, Moneda_31.cotizacion                      AS Moneda_31_cotizacion                 	-- 35	.Moneda.cotizacion                 		DECIMAL(13,5)
				, Moneda_31.cotizacionFecha                 AS Moneda_31_cotizacionFecha            	-- 36	.Moneda.cotizacionFecha            		TIMESTAMP
				, Moneda_31.controlActualizacion            AS Moneda_31_controlActualizacion       	-- 37	.Moneda.controlActualizacion       		BOOLEAN
				, Moneda_31.monedaAFIP                      AS Moneda_31_monedaAFIP                 	-- 38	.Moneda.monedaAFIP                 		VARCHAR(36)	MonedaAFIP.id
				, Caja_39.id                                AS Caja_39_id                           	-- 39	.Caja.id                           		VARCHAR(36)
				, Caja_39.numero                            AS Caja_39_numero                       	-- 40	.Caja.numero                       		INTEGER
				, Caja_39.nombre                            AS Caja_39_nombre                       	-- 41	.Caja.nombre                       		VARCHAR(50)
				, Caja_39.seguridadPuerta                   AS Caja_39_seguridadPuerta              	-- 42	.Caja.seguridadPuerta              		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondo.rechazados                    AS CuentaFondo_rechazados               	-- 43	.rechazados                        		BOOLEAN
				, CuentaFondo.conciliacion                  AS CuentaFondo_conciliacion             	-- 44	.conciliacion                      		BOOLEAN
				, CuentaFondoTipoBanco_45.id                AS CuentaFondoTipoBanco_45_id           	-- 45	.CuentaFondoTipoBanco.id           		VARCHAR(36)
				, CuentaFondoTipoBanco_45.numero            AS CuentaFondoTipoBanco_45_numero       	-- 46	.CuentaFondoTipoBanco.numero       		INTEGER
				, CuentaFondoTipoBanco_45.nombre            AS CuentaFondoTipoBanco_45_nombre       	-- 47	.CuentaFondoTipoBanco.nombre       		VARCHAR(50)
				, Banco_48.id                               AS Banco_48_id                          	-- 48	.Banco.id                          		VARCHAR(36)
				, Banco_48.numero                           AS Banco_48_numero                      	-- 49	.Banco.numero                      		INTEGER
				, Banco_48.nombre                           AS Banco_48_nombre                      	-- 50	.Banco.nombre                      		VARCHAR(50)
				, Banco_48.cuit                             AS Banco_48_cuit                        	-- 51	.Banco.cuit                        		BIGINT
				, Banco_48.bloqueado                        AS Banco_48_bloqueado                   	-- 52	.Banco.bloqueado                   		BOOLEAN
				, Banco_48.hoja                             AS Banco_48_hoja                        	-- 53	.Banco.hoja                        		INTEGER
				, Banco_48.primeraFila                      AS Banco_48_primeraFila                 	-- 54	.Banco.primeraFila                 		INTEGER
				, Banco_48.ultimaFila                       AS Banco_48_ultimaFila                  	-- 55	.Banco.ultimaFila                  		INTEGER
				, Banco_48.fecha                            AS Banco_48_fecha                       	-- 56	.Banco.fecha                       		VARCHAR(3)
				, Banco_48.descripcion                      AS Banco_48_descripcion                 	-- 57	.Banco.descripcion                 		VARCHAR(3)
				, Banco_48.referencia1                      AS Banco_48_referencia1                 	-- 58	.Banco.referencia1                 		VARCHAR(3)
				, Banco_48.importe                          AS Banco_48_importe                     	-- 59	.Banco.importe                     		VARCHAR(3)
				, Banco_48.referencia2                      AS Banco_48_referencia2                 	-- 60	.Banco.referencia2                 		VARCHAR(3)
				, Banco_48.saldo                            AS Banco_48_saldo                       	-- 61	.Banco.saldo                       		VARCHAR(3)
				, CuentaFondo.cuentaBancaria                AS CuentaFondo_cuentaBancaria           	-- 62	.cuentaBancaria                    		VARCHAR(22)
				, CuentaFondo.cbu                           AS CuentaFondo_cbu                      	-- 63	.cbu                               		VARCHAR(22)
				, CuentaFondo.limiteDescubierto             AS CuentaFondo_limiteDescubierto        	-- 64	.limiteDescubierto                 		DECIMAL(13,5)
				, CuentaFondo.cuentaFondoCaucion            AS CuentaFondo_cuentaFondoCaucion       	-- 65	.cuentaFondoCaucion                		VARCHAR(50)
				, CuentaFondo.cuentaFondoDiferidos          AS CuentaFondo_cuentaFondoDiferidos     	-- 66	.cuentaFondoDiferidos              		VARCHAR(50)
				, CuentaFondo.formato                       AS CuentaFondo_formato                  	-- 67	.formato                           		VARCHAR(50)
				, CuentaFondoBancoCopia_68.id               AS CuentaFondoBancoCopia_68_id          	-- 68	.CuentaFondoBancoCopia.id          		VARCHAR(36)
				, CuentaFondoBancoCopia_68.numero           AS CuentaFondoBancoCopia_68_numero      	-- 69	.CuentaFondoBancoCopia.numero      		INTEGER
				, CuentaFondoBancoCopia_68.nombre           AS CuentaFondoBancoCopia_68_nombre      	-- 70	.CuentaFondoBancoCopia.nombre      		VARCHAR(50)
				, CuentaFondo.limiteOperacionIndividual     AS CuentaFondo_limiteOperacionIndividual	-- 71	.limiteOperacionIndividual         		DECIMAL(13,5)
				, SeguridadPuerta_72.id                     AS SeguridadPuerta_72_id                	-- 72	.SeguridadPuerta.id                		VARCHAR(36)
				, SeguridadPuerta_72.numero                 AS SeguridadPuerta_72_numero            	-- 73	.SeguridadPuerta.numero            		INTEGER
				, SeguridadPuerta_72.nombre                 AS SeguridadPuerta_72_nombre            	-- 74	.SeguridadPuerta.nombre            		VARCHAR(50)
				, SeguridadPuerta_72.equate                 AS SeguridadPuerta_72_equate            	-- 75	.SeguridadPuerta.equate            		VARCHAR(30)
				, SeguridadPuerta_72.seguridadModulo        AS SeguridadPuerta_72_seguridadModulo   	-- 76	.SeguridadPuerta.seguridadModulo   		VARCHAR(36)	SeguridadModulo.id
				, SeguridadPuerta_77.id                     AS SeguridadPuerta_77_id                	-- 77	.SeguridadPuerta.id                		VARCHAR(36)
				, SeguridadPuerta_77.numero                 AS SeguridadPuerta_77_numero            	-- 78	.SeguridadPuerta.numero            		INTEGER
				, SeguridadPuerta_77.nombre                 AS SeguridadPuerta_77_nombre            	-- 79	.SeguridadPuerta.nombre            		VARCHAR(50)
				, SeguridadPuerta_77.equate                 AS SeguridadPuerta_77_equate            	-- 80	.SeguridadPuerta.equate            		VARCHAR(30)
				, SeguridadPuerta_77.seguridadModulo        AS SeguridadPuerta_77_seguridadModulo   	-- 81	.SeguridadPuerta.seguridadModulo   		VARCHAR(36)	SeguridadModulo.id
				, SeguridadPuerta_82.id                     AS SeguridadPuerta_82_id                	-- 82	.SeguridadPuerta.id                		VARCHAR(36)
				, SeguridadPuerta_82.numero                 AS SeguridadPuerta_82_numero            	-- 83	.SeguridadPuerta.numero            		INTEGER
				, SeguridadPuerta_82.nombre                 AS SeguridadPuerta_82_nombre            	-- 84	.SeguridadPuerta.nombre            		VARCHAR(50)
				, SeguridadPuerta_82.equate                 AS SeguridadPuerta_82_equate            	-- 85	.SeguridadPuerta.equate            		VARCHAR(30)
				, SeguridadPuerta_82.seguridadModulo        AS SeguridadPuerta_82_seguridadModulo   	-- 86	.SeguridadPuerta.seguridadModulo   		VARCHAR(36)	SeguridadModulo.id

		FROM	massoftware.CuentaFondo
			LEFT JOIN massoftware.CuentaContable AS CuentaContable_3                ON CuentaFondo.cuentaContable = CuentaContable_3.id 	-- 3 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaFondoGrupo AS CuentaFondoGrupo_19             ON CuentaFondo.cuentaFondoGrupo = CuentaFondoGrupo_19.id 	-- 19 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaFondoTipo AS CuentaFondoTipo_23              ON CuentaFondo.cuentaFondoTipo = CuentaFondoTipo_23.id 	-- 23 LEFT LEVEL: 1
			LEFT JOIN massoftware.Moneda AS Moneda_31                       ON CuentaFondo.moneda = Moneda_31.id 	-- 31 LEFT LEVEL: 1
			LEFT JOIN massoftware.Caja AS Caja_39                         ON CuentaFondo.caja = Caja_39.id 	-- 39 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaFondoTipoBanco AS CuentaFondoTipoBanco_45         ON CuentaFondo.cuentaFondoTipoBanco = CuentaFondoTipoBanco_45.id 	-- 45 LEFT LEVEL: 1
			LEFT JOIN massoftware.Banco AS Banco_48                        ON CuentaFondo.banco = Banco_48.id 	-- 48 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaFondoBancoCopia AS CuentaFondoBancoCopia_68        ON CuentaFondo.cuentaFondoBancoCopia = CuentaFondoBancoCopia_68.id 	-- 68 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_72              ON CuentaFondo.seguridadPuertaUso = SeguridadPuerta_72.id 	-- 72 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_77              ON CuentaFondo.seguridadPuertaConsulta = SeguridadPuerta_77.id 	-- 77 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_82              ON CuentaFondo.seguridadPuertaLimite = SeguridadPuerta_82.id 	-- 82 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondo.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND bancoArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(bancoArg8)) > 0 THEN
		bancoArg8 = REPLACE(bancoArg8, '''', '''''');
		bancoArg8 = LOWER(TRIM(bancoArg8));
		bancoArg8 = TRANSLATE(bancoArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(bancoArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondo.banco),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_CuentaFondo_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaFondo_1 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaFondo_1 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaFondoById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondo_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, bancoArg8         VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondo_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, bancoArg8         VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_CuentaFondo_2 AS $$

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
				  CuentaFondo.id                               AS CuentaFondo_id                          	-- 0	.id                                                 		VARCHAR(36)
				, CuentaFondo.numero                           AS CuentaFondo_numero                      	-- 1	.numero                                             		INTEGER
				, CuentaFondo.nombre                           AS CuentaFondo_nombre                      	-- 2	.nombre                                             		VARCHAR(50)
				, CuentaContable_3.id                          AS CuentaContable_3_id                     	-- 3	.CuentaContable.id                                  		VARCHAR(36)
				, CuentaContable_3.codigo                      AS CuentaContable_3_codigo                 	-- 4	.CuentaContable.codigo                              		VARCHAR(11)
				, CuentaContable_3.nombre                      AS CuentaContable_3_nombre                 	-- 5	.CuentaContable.nombre                              		VARCHAR(50)
				, EjercicioContable_6.id                       AS EjercicioContable_6_id                  	-- 6	.CuentaContable.EjercicioContable.id                		VARCHAR(36)
				, EjercicioContable_6.numero                   AS EjercicioContable_6_numero              	-- 7	.CuentaContable.EjercicioContable.numero            		INTEGER
				, EjercicioContable_6.apertura                 AS EjercicioContable_6_apertura            	-- 8	.CuentaContable.EjercicioContable.apertura          		DATE
				, EjercicioContable_6.cierre                   AS EjercicioContable_6_cierre              	-- 9	.CuentaContable.EjercicioContable.cierre            		DATE
				, EjercicioContable_6.cerrado                  AS EjercicioContable_6_cerrado             	-- 10	.CuentaContable.EjercicioContable.cerrado           		BOOLEAN
				, EjercicioContable_6.cerradoModulos           AS EjercicioContable_6_cerradoModulos      	-- 11	.CuentaContable.EjercicioContable.cerradoModulos    		BOOLEAN
				, EjercicioContable_6.comentario               AS EjercicioContable_6_comentario          	-- 12	.CuentaContable.EjercicioContable.comentario        		VARCHAR(250)
				, CuentaContable_3.integra                     AS CuentaContable_3_integra                	-- 13	.CuentaContable.integra                             		VARCHAR(16)
				, CuentaContable_3.cuentaJerarquia             AS CuentaContable_3_cuentaJerarquia        	-- 14	.CuentaContable.cuentaJerarquia                     		VARCHAR(16)
				, CuentaContable_3.imputable                   AS CuentaContable_3_imputable              	-- 15	.CuentaContable.imputable                           		BOOLEAN
				, CuentaContable_3.ajustaPorInflacion          AS CuentaContable_3_ajustaPorInflacion     	-- 16	.CuentaContable.ajustaPorInflacion                  		BOOLEAN
				, CuentaContableEstado_17.id                   AS CuentaContableEstado_17_id              	-- 17	.CuentaContable.CuentaContableEstado.id             		VARCHAR(36)
				, CuentaContableEstado_17.numero               AS CuentaContableEstado_17_numero          	-- 18	.CuentaContable.CuentaContableEstado.numero         		INTEGER
				, CuentaContableEstado_17.nombre               AS CuentaContableEstado_17_nombre          	-- 19	.CuentaContable.CuentaContableEstado.nombre         		VARCHAR(50)
				, CuentaContable_3.cuentaConApropiacion        AS CuentaContable_3_cuentaConApropiacion   	-- 20	.CuentaContable.cuentaConApropiacion                		BOOLEAN
				, CentroCostoContable_21.id                    AS CentroCostoContable_21_id               	-- 21	.CuentaContable.CentroCostoContable.id              		VARCHAR(36)
				, CentroCostoContable_21.numero                AS CentroCostoContable_21_numero           	-- 22	.CuentaContable.CentroCostoContable.numero          		INTEGER
				, CentroCostoContable_21.nombre                AS CentroCostoContable_21_nombre           	-- 23	.CuentaContable.CentroCostoContable.nombre          		VARCHAR(50)
				, CentroCostoContable_21.abreviatura           AS CentroCostoContable_21_abreviatura      	-- 24	.CuentaContable.CentroCostoContable.abreviatura     		VARCHAR(5)
				, CentroCostoContable_21.ejercicioContable     AS CentroCostoContable_21_ejercicioContable	-- 25	.CuentaContable.CentroCostoContable.ejercicioContable		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_3.cuentaAgrupadora            AS CuentaContable_3_cuentaAgrupadora       	-- 26	.CuentaContable.cuentaAgrupadora                    		VARCHAR(50)
				, CuentaContable_3.porcentaje                  AS CuentaContable_3_porcentaje             	-- 27	.CuentaContable.porcentaje                          		DECIMAL(6,3)
				, PuntoEquilibrio_28.id                        AS PuntoEquilibrio_28_id                   	-- 28	.CuentaContable.PuntoEquilibrio.id                  		VARCHAR(36)
				, PuntoEquilibrio_28.numero                    AS PuntoEquilibrio_28_numero               	-- 29	.CuentaContable.PuntoEquilibrio.numero              		INTEGER
				, PuntoEquilibrio_28.nombre                    AS PuntoEquilibrio_28_nombre               	-- 30	.CuentaContable.PuntoEquilibrio.nombre              		VARCHAR(50)
				, PuntoEquilibrio_28.tipoPuntoEquilibrio       AS PuntoEquilibrio_28_tipoPuntoEquilibrio  	-- 31	.CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio 		VARCHAR(36)	TipoPuntoEquilibrio.id
				, PuntoEquilibrio_28.ejercicioContable         AS PuntoEquilibrio_28_ejercicioContable    	-- 32	.CuentaContable.PuntoEquilibrio.ejercicioContable   		VARCHAR(36)	EjercicioContable.id
				, CostoVenta_33.id                             AS CostoVenta_33_id                        	-- 33	.CuentaContable.CostoVenta.id                       		VARCHAR(36)
				, CostoVenta_33.numero                         AS CostoVenta_33_numero                    	-- 34	.CuentaContable.CostoVenta.numero                   		INTEGER
				, CostoVenta_33.nombre                         AS CostoVenta_33_nombre                    	-- 35	.CuentaContable.CostoVenta.nombre                   		VARCHAR(50)
				, SeguridadPuerta_36.id                        AS SeguridadPuerta_36_id                   	-- 36	.CuentaContable.SeguridadPuerta.id                  		VARCHAR(36)
				, SeguridadPuerta_36.numero                    AS SeguridadPuerta_36_numero               	-- 37	.CuentaContable.SeguridadPuerta.numero              		INTEGER
				, SeguridadPuerta_36.nombre                    AS SeguridadPuerta_36_nombre               	-- 38	.CuentaContable.SeguridadPuerta.nombre              		VARCHAR(50)
				, SeguridadPuerta_36.equate                    AS SeguridadPuerta_36_equate               	-- 39	.CuentaContable.SeguridadPuerta.equate              		VARCHAR(30)
				, SeguridadPuerta_36.seguridadModulo           AS SeguridadPuerta_36_seguridadModulo      	-- 40	.CuentaContable.SeguridadPuerta.seguridadModulo     		VARCHAR(36)	SeguridadModulo.id
				, CuentaFondoGrupo_41.id                       AS CuentaFondoGrupo_41_id                  	-- 41	.CuentaFondoGrupo.id                                		VARCHAR(36)
				, CuentaFondoGrupo_41.numero                   AS CuentaFondoGrupo_41_numero              	-- 42	.CuentaFondoGrupo.numero                            		INTEGER
				, CuentaFondoGrupo_41.nombre                   AS CuentaFondoGrupo_41_nombre              	-- 43	.CuentaFondoGrupo.nombre                            		VARCHAR(50)
				, CuentaFondoRubro_44.id                       AS CuentaFondoRubro_44_id                  	-- 44	.CuentaFondoGrupo.CuentaFondoRubro.id               		VARCHAR(36)
				, CuentaFondoRubro_44.numero                   AS CuentaFondoRubro_44_numero              	-- 45	.CuentaFondoGrupo.CuentaFondoRubro.numero           		INTEGER
				, CuentaFondoRubro_44.nombre                   AS CuentaFondoRubro_44_nombre              	-- 46	.CuentaFondoGrupo.CuentaFondoRubro.nombre           		VARCHAR(50)
				, CuentaFondoTipo_47.id                        AS CuentaFondoTipo_47_id                   	-- 47	.CuentaFondoTipo.id                                 		VARCHAR(36)
				, CuentaFondoTipo_47.numero                    AS CuentaFondoTipo_47_numero               	-- 48	.CuentaFondoTipo.numero                             		INTEGER
				, CuentaFondoTipo_47.nombre                    AS CuentaFondoTipo_47_nombre               	-- 49	.CuentaFondoTipo.nombre                             		VARCHAR(50)
				, CuentaFondo.obsoleto                         AS CuentaFondo_obsoleto                    	-- 50	.obsoleto                                           		BOOLEAN
				, CuentaFondo.noImprimeCaja                    AS CuentaFondo_noImprimeCaja               	-- 51	.noImprimeCaja                                      		BOOLEAN
				, CuentaFondo.ventas                           AS CuentaFondo_ventas                      	-- 52	.ventas                                             		BOOLEAN
				, CuentaFondo.fondos                           AS CuentaFondo_fondos                      	-- 53	.fondos                                             		BOOLEAN
				, CuentaFondo.compras                          AS CuentaFondo_compras                     	-- 54	.compras                                            		BOOLEAN
				, Moneda_55.id                                 AS Moneda_55_id                            	-- 55	.Moneda.id                                          		VARCHAR(36)
				, Moneda_55.numero                             AS Moneda_55_numero                        	-- 56	.Moneda.numero                                      		INTEGER
				, Moneda_55.nombre                             AS Moneda_55_nombre                        	-- 57	.Moneda.nombre                                      		VARCHAR(50)
				, Moneda_55.abreviatura                        AS Moneda_55_abreviatura                   	-- 58	.Moneda.abreviatura                                 		VARCHAR(5)
				, Moneda_55.cotizacion                         AS Moneda_55_cotizacion                    	-- 59	.Moneda.cotizacion                                  		DECIMAL(13,5)
				, Moneda_55.cotizacionFecha                    AS Moneda_55_cotizacionFecha               	-- 60	.Moneda.cotizacionFecha                             		TIMESTAMP
				, Moneda_55.controlActualizacion               AS Moneda_55_controlActualizacion          	-- 61	.Moneda.controlActualizacion                        		BOOLEAN
				, MonedaAFIP_62.id                             AS MonedaAFIP_62_id                        	-- 62	.Moneda.MonedaAFIP.id                               		VARCHAR(36)
				, MonedaAFIP_62.codigo                         AS MonedaAFIP_62_codigo                    	-- 63	.Moneda.MonedaAFIP.codigo                           		VARCHAR(3)
				, MonedaAFIP_62.nombre                         AS MonedaAFIP_62_nombre                    	-- 64	.Moneda.MonedaAFIP.nombre                           		VARCHAR(50)
				, Caja_65.id                                   AS Caja_65_id                              	-- 65	.Caja.id                                            		VARCHAR(36)
				, Caja_65.numero                               AS Caja_65_numero                          	-- 66	.Caja.numero                                        		INTEGER
				, Caja_65.nombre                               AS Caja_65_nombre                          	-- 67	.Caja.nombre                                        		VARCHAR(50)
				, SeguridadPuerta_68.id                        AS SeguridadPuerta_68_id                   	-- 68	.Caja.SeguridadPuerta.id                            		VARCHAR(36)
				, SeguridadPuerta_68.numero                    AS SeguridadPuerta_68_numero               	-- 69	.Caja.SeguridadPuerta.numero                        		INTEGER
				, SeguridadPuerta_68.nombre                    AS SeguridadPuerta_68_nombre               	-- 70	.Caja.SeguridadPuerta.nombre                        		VARCHAR(50)
				, SeguridadPuerta_68.equate                    AS SeguridadPuerta_68_equate               	-- 71	.Caja.SeguridadPuerta.equate                        		VARCHAR(30)
				, SeguridadPuerta_68.seguridadModulo           AS SeguridadPuerta_68_seguridadModulo      	-- 72	.Caja.SeguridadPuerta.seguridadModulo               		VARCHAR(36)	SeguridadModulo.id
				, CuentaFondo.rechazados                       AS CuentaFondo_rechazados                  	-- 73	.rechazados                                         		BOOLEAN
				, CuentaFondo.conciliacion                     AS CuentaFondo_conciliacion                	-- 74	.conciliacion                                       		BOOLEAN
				, CuentaFondoTipoBanco_75.id                   AS CuentaFondoTipoBanco_75_id              	-- 75	.CuentaFondoTipoBanco.id                            		VARCHAR(36)
				, CuentaFondoTipoBanco_75.numero               AS CuentaFondoTipoBanco_75_numero          	-- 76	.CuentaFondoTipoBanco.numero                        		INTEGER
				, CuentaFondoTipoBanco_75.nombre               AS CuentaFondoTipoBanco_75_nombre          	-- 77	.CuentaFondoTipoBanco.nombre                        		VARCHAR(50)
				, Banco_78.id                                  AS Banco_78_id                             	-- 78	.Banco.id                                           		VARCHAR(36)
				, Banco_78.numero                              AS Banco_78_numero                         	-- 79	.Banco.numero                                       		INTEGER
				, Banco_78.nombre                              AS Banco_78_nombre                         	-- 80	.Banco.nombre                                       		VARCHAR(50)
				, Banco_78.cuit                                AS Banco_78_cuit                           	-- 81	.Banco.cuit                                         		BIGINT
				, Banco_78.bloqueado                           AS Banco_78_bloqueado                      	-- 82	.Banco.bloqueado                                    		BOOLEAN
				, Banco_78.hoja                                AS Banco_78_hoja                           	-- 83	.Banco.hoja                                         		INTEGER
				, Banco_78.primeraFila                         AS Banco_78_primeraFila                    	-- 84	.Banco.primeraFila                                  		INTEGER
				, Banco_78.ultimaFila                          AS Banco_78_ultimaFila                     	-- 85	.Banco.ultimaFila                                   		INTEGER
				, Banco_78.fecha                               AS Banco_78_fecha                          	-- 86	.Banco.fecha                                        		VARCHAR(3)
				, Banco_78.descripcion                         AS Banco_78_descripcion                    	-- 87	.Banco.descripcion                                  		VARCHAR(3)
				, Banco_78.referencia1                         AS Banco_78_referencia1                    	-- 88	.Banco.referencia1                                  		VARCHAR(3)
				, Banco_78.importe                             AS Banco_78_importe                        	-- 89	.Banco.importe                                      		VARCHAR(3)
				, Banco_78.referencia2                         AS Banco_78_referencia2                    	-- 90	.Banco.referencia2                                  		VARCHAR(3)
				, Banco_78.saldo                               AS Banco_78_saldo                          	-- 91	.Banco.saldo                                        		VARCHAR(3)
				, CuentaFondo.cuentaBancaria                   AS CuentaFondo_cuentaBancaria              	-- 92	.cuentaBancaria                                     		VARCHAR(22)
				, CuentaFondo.cbu                              AS CuentaFondo_cbu                         	-- 93	.cbu                                                		VARCHAR(22)
				, CuentaFondo.limiteDescubierto                AS CuentaFondo_limiteDescubierto           	-- 94	.limiteDescubierto                                  		DECIMAL(13,5)
				, CuentaFondo.cuentaFondoCaucion               AS CuentaFondo_cuentaFondoCaucion          	-- 95	.cuentaFondoCaucion                                 		VARCHAR(50)
				, CuentaFondo.cuentaFondoDiferidos             AS CuentaFondo_cuentaFondoDiferidos        	-- 96	.cuentaFondoDiferidos                               		VARCHAR(50)
				, CuentaFondo.formato                          AS CuentaFondo_formato                     	-- 97	.formato                                            		VARCHAR(50)
				, CuentaFondoBancoCopia_98.id                  AS CuentaFondoBancoCopia_98_id             	-- 98	.CuentaFondoBancoCopia.id                           		VARCHAR(36)
				, CuentaFondoBancoCopia_98.numero              AS CuentaFondoBancoCopia_98_numero         	-- 99	.CuentaFondoBancoCopia.numero                       		INTEGER
				, CuentaFondoBancoCopia_98.nombre              AS CuentaFondoBancoCopia_98_nombre         	-- 100	.CuentaFondoBancoCopia.nombre                       		VARCHAR(50)
				, CuentaFondo.limiteOperacionIndividual        AS CuentaFondo_limiteOperacionIndividual   	-- 101	.limiteOperacionIndividual                          		DECIMAL(13,5)
				, SeguridadPuerta_102.id                       AS SeguridadPuerta_102_id                  	-- 102	.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_102.numero                   AS SeguridadPuerta_102_numero              	-- 103	.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_102.nombre                   AS SeguridadPuerta_102_nombre              	-- 104	.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_102.equate                   AS SeguridadPuerta_102_equate              	-- 105	.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_106.id                       AS SeguridadModulo_106_id                  	-- 106	.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_106.numero                   AS SeguridadModulo_106_numero              	-- 107	.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_106.nombre                   AS SeguridadModulo_106_nombre              	-- 108	.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)
				, SeguridadPuerta_109.id                       AS SeguridadPuerta_109_id                  	-- 109	.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_109.numero                   AS SeguridadPuerta_109_numero              	-- 110	.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_109.nombre                   AS SeguridadPuerta_109_nombre              	-- 111	.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_109.equate                   AS SeguridadPuerta_109_equate              	-- 112	.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_113.id                       AS SeguridadModulo_113_id                  	-- 113	.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_113.numero                   AS SeguridadModulo_113_numero              	-- 114	.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_113.nombre                   AS SeguridadModulo_113_nombre              	-- 115	.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)
				, SeguridadPuerta_116.id                       AS SeguridadPuerta_116_id                  	-- 116	.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_116.numero                   AS SeguridadPuerta_116_numero              	-- 117	.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_116.nombre                   AS SeguridadPuerta_116_nombre              	-- 118	.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_116.equate                   AS SeguridadPuerta_116_equate              	-- 119	.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_120.id                       AS SeguridadModulo_120_id                  	-- 120	.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_120.numero                   AS SeguridadModulo_120_numero              	-- 121	.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_120.nombre                   AS SeguridadModulo_120_nombre              	-- 122	.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)

		FROM	massoftware.CuentaFondo
			LEFT JOIN massoftware.CuentaContable AS CuentaContable_3                  ON CuentaFondo.cuentaContable = CuentaContable_3.id 	-- 3 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_6              ON CuentaContable_3.ejercicioContable = EjercicioContable_6.id 	-- 6 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_17           ON CuentaContable_3.cuentaContableEstado = CuentaContableEstado_17.id 	-- 17 LEFT LEVEL: 2
				LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_21            ON CuentaContable_3.centroCostoContable = CentroCostoContable_21.id 	-- 21 LEFT LEVEL: 2
				LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_28                ON CuentaContable_3.puntoEquilibrio = PuntoEquilibrio_28.id 	-- 28 LEFT LEVEL: 2
				LEFT JOIN massoftware.CostoVenta AS CostoVenta_33                     ON CuentaContable_3.costoVenta = CostoVenta_33.id 	-- 33 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_36                ON CuentaContable_3.seguridadPuerta = SeguridadPuerta_36.id 	-- 36 LEFT LEVEL: 2
			LEFT JOIN massoftware.CuentaFondoGrupo AS CuentaFondoGrupo_41               ON CuentaFondo.cuentaFondoGrupo = CuentaFondoGrupo_41.id 	-- 41 LEFT LEVEL: 1
				LEFT JOIN massoftware.CuentaFondoRubro AS CuentaFondoRubro_44               ON CuentaFondoGrupo_41.cuentaFondoRubro = CuentaFondoRubro_44.id 	-- 44 LEFT LEVEL: 2
			LEFT JOIN massoftware.CuentaFondoTipo AS CuentaFondoTipo_47                ON CuentaFondo.cuentaFondoTipo = CuentaFondoTipo_47.id 	-- 47 LEFT LEVEL: 1
			LEFT JOIN massoftware.Moneda AS Moneda_55                         ON CuentaFondo.moneda = Moneda_55.id 	-- 55 LEFT LEVEL: 1
				LEFT JOIN massoftware.MonedaAFIP AS MonedaAFIP_62                     ON Moneda_55.monedaAFIP = MonedaAFIP_62.id 	-- 62 LEFT LEVEL: 2
			LEFT JOIN massoftware.Caja AS Caja_65                           ON CuentaFondo.caja = Caja_65.id 	-- 65 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_68                ON Caja_65.seguridadPuerta = SeguridadPuerta_68.id 	-- 68 LEFT LEVEL: 2
			LEFT JOIN massoftware.CuentaFondoTipoBanco AS CuentaFondoTipoBanco_75           ON CuentaFondo.cuentaFondoTipoBanco = CuentaFondoTipoBanco_75.id 	-- 75 LEFT LEVEL: 1
			LEFT JOIN massoftware.Banco AS Banco_78                          ON CuentaFondo.banco = Banco_78.id 	-- 78 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaFondoBancoCopia AS CuentaFondoBancoCopia_98          ON CuentaFondo.cuentaFondoBancoCopia = CuentaFondoBancoCopia_98.id 	-- 98 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_102                ON CuentaFondo.seguridadPuertaUso = SeguridadPuerta_102.id 	-- 102 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_106               ON SeguridadPuerta_102.seguridadModulo = SeguridadModulo_106.id 	-- 106 LEFT LEVEL: 2
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_109                ON CuentaFondo.seguridadPuertaConsulta = SeguridadPuerta_109.id 	-- 109 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_113               ON SeguridadPuerta_109.seguridadModulo = SeguridadModulo_113.id 	-- 113 LEFT LEVEL: 2
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_116                ON CuentaFondo.seguridadPuertaLimite = SeguridadPuerta_116.id 	-- 116 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_120               ON SeguridadPuerta_116.seguridadModulo = SeguridadModulo_120.id 	-- 120 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondo.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND bancoArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(bancoArg8)) > 0 THEN
		bancoArg8 = REPLACE(bancoArg8, '''', '''''');
		bancoArg8 = LOWER(TRIM(bancoArg8));
		bancoArg8 = TRANSLATE(bancoArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(bancoArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondo.banco),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_CuentaFondo_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaFondo_2 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaFondo_2 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaFondoById_2 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondo_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, bancoArg8         VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondo_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, bancoArg8         VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_CuentaFondo_3 AS $$

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
				  CuentaFondo.id                             AS CuentaFondo_id                       	-- 0	.id                                                                		VARCHAR(36)
				, CuentaFondo.numero                         AS CuentaFondo_numero                   	-- 1	.numero                                                            		INTEGER
				, CuentaFondo.nombre                         AS CuentaFondo_nombre                   	-- 2	.nombre                                                            		VARCHAR(50)
				, CuentaContable_3.id                        AS CuentaContable_3_id                  	-- 3	.CuentaContable.id                                                 		VARCHAR(36)
				, CuentaContable_3.codigo                    AS CuentaContable_3_codigo              	-- 4	.CuentaContable.codigo                                             		VARCHAR(11)
				, CuentaContable_3.nombre                    AS CuentaContable_3_nombre              	-- 5	.CuentaContable.nombre                                             		VARCHAR(50)
				, EjercicioContable_6.id                     AS EjercicioContable_6_id               	-- 6	.CuentaContable.EjercicioContable.id                               		VARCHAR(36)
				, EjercicioContable_6.numero                 AS EjercicioContable_6_numero           	-- 7	.CuentaContable.EjercicioContable.numero                           		INTEGER
				, EjercicioContable_6.apertura               AS EjercicioContable_6_apertura         	-- 8	.CuentaContable.EjercicioContable.apertura                         		DATE
				, EjercicioContable_6.cierre                 AS EjercicioContable_6_cierre           	-- 9	.CuentaContable.EjercicioContable.cierre                           		DATE
				, EjercicioContable_6.cerrado                AS EjercicioContable_6_cerrado          	-- 10	.CuentaContable.EjercicioContable.cerrado                          		BOOLEAN
				, EjercicioContable_6.cerradoModulos         AS EjercicioContable_6_cerradoModulos   	-- 11	.CuentaContable.EjercicioContable.cerradoModulos                   		BOOLEAN
				, EjercicioContable_6.comentario             AS EjercicioContable_6_comentario       	-- 12	.CuentaContable.EjercicioContable.comentario                       		VARCHAR(250)
				, CuentaContable_3.integra                   AS CuentaContable_3_integra             	-- 13	.CuentaContable.integra                                            		VARCHAR(16)
				, CuentaContable_3.cuentaJerarquia           AS CuentaContable_3_cuentaJerarquia     	-- 14	.CuentaContable.cuentaJerarquia                                    		VARCHAR(16)
				, CuentaContable_3.imputable                 AS CuentaContable_3_imputable           	-- 15	.CuentaContable.imputable                                          		BOOLEAN
				, CuentaContable_3.ajustaPorInflacion        AS CuentaContable_3_ajustaPorInflacion  	-- 16	.CuentaContable.ajustaPorInflacion                                 		BOOLEAN
				, CuentaContableEstado_17.id                 AS CuentaContableEstado_17_id           	-- 17	.CuentaContable.CuentaContableEstado.id                            		VARCHAR(36)
				, CuentaContableEstado_17.numero             AS CuentaContableEstado_17_numero       	-- 18	.CuentaContable.CuentaContableEstado.numero                        		INTEGER
				, CuentaContableEstado_17.nombre             AS CuentaContableEstado_17_nombre       	-- 19	.CuentaContable.CuentaContableEstado.nombre                        		VARCHAR(50)
				, CuentaContable_3.cuentaConApropiacion      AS CuentaContable_3_cuentaConApropiacion	-- 20	.CuentaContable.cuentaConApropiacion                               		BOOLEAN
				, CentroCostoContable_21.id                  AS CentroCostoContable_21_id            	-- 21	.CuentaContable.CentroCostoContable.id                             		VARCHAR(36)
				, CentroCostoContable_21.numero              AS CentroCostoContable_21_numero        	-- 22	.CuentaContable.CentroCostoContable.numero                         		INTEGER
				, CentroCostoContable_21.nombre              AS CentroCostoContable_21_nombre        	-- 23	.CuentaContable.CentroCostoContable.nombre                         		VARCHAR(50)
				, CentroCostoContable_21.abreviatura         AS CentroCostoContable_21_abreviatura   	-- 24	.CuentaContable.CentroCostoContable.abreviatura                    		VARCHAR(5)
				, EjercicioContable_25.id                    AS EjercicioContable_25_id              	-- 25	.CuentaContable.CentroCostoContable.EjercicioContable.id           		VARCHAR(36)
				, EjercicioContable_25.numero                AS EjercicioContable_25_numero          	-- 26	.CuentaContable.CentroCostoContable.EjercicioContable.numero       		INTEGER
				, EjercicioContable_25.apertura              AS EjercicioContable_25_apertura        	-- 27	.CuentaContable.CentroCostoContable.EjercicioContable.apertura     		DATE
				, EjercicioContable_25.cierre                AS EjercicioContable_25_cierre          	-- 28	.CuentaContable.CentroCostoContable.EjercicioContable.cierre       		DATE
				, EjercicioContable_25.cerrado               AS EjercicioContable_25_cerrado         	-- 29	.CuentaContable.CentroCostoContable.EjercicioContable.cerrado      		BOOLEAN
				, EjercicioContable_25.cerradoModulos        AS EjercicioContable_25_cerradoModulos  	-- 30	.CuentaContable.CentroCostoContable.EjercicioContable.cerradoModulos		BOOLEAN
				, EjercicioContable_25.comentario            AS EjercicioContable_25_comentario      	-- 31	.CuentaContable.CentroCostoContable.EjercicioContable.comentario   		VARCHAR(250)
				, CuentaContable_3.cuentaAgrupadora          AS CuentaContable_3_cuentaAgrupadora    	-- 32	.CuentaContable.cuentaAgrupadora                                   		VARCHAR(50)
				, CuentaContable_3.porcentaje                AS CuentaContable_3_porcentaje          	-- 33	.CuentaContable.porcentaje                                         		DECIMAL(6,3)
				, PuntoEquilibrio_34.id                      AS PuntoEquilibrio_34_id                	-- 34	.CuentaContable.PuntoEquilibrio.id                                 		VARCHAR(36)
				, PuntoEquilibrio_34.numero                  AS PuntoEquilibrio_34_numero            	-- 35	.CuentaContable.PuntoEquilibrio.numero                             		INTEGER
				, PuntoEquilibrio_34.nombre                  AS PuntoEquilibrio_34_nombre            	-- 36	.CuentaContable.PuntoEquilibrio.nombre                             		VARCHAR(50)
				, TipoPuntoEquilibrio_37.id                  AS TipoPuntoEquilibrio_37_id            	-- 37	.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.id             		VARCHAR(36)
				, TipoPuntoEquilibrio_37.numero              AS TipoPuntoEquilibrio_37_numero        	-- 38	.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.numero         		INTEGER
				, TipoPuntoEquilibrio_37.nombre              AS TipoPuntoEquilibrio_37_nombre        	-- 39	.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.nombre         		VARCHAR(50)
				, EjercicioContable_40.id                    AS EjercicioContable_40_id              	-- 40	.CuentaContable.PuntoEquilibrio.EjercicioContable.id               		VARCHAR(36)
				, EjercicioContable_40.numero                AS EjercicioContable_40_numero          	-- 41	.CuentaContable.PuntoEquilibrio.EjercicioContable.numero           		INTEGER
				, EjercicioContable_40.apertura              AS EjercicioContable_40_apertura        	-- 42	.CuentaContable.PuntoEquilibrio.EjercicioContable.apertura         		DATE
				, EjercicioContable_40.cierre                AS EjercicioContable_40_cierre          	-- 43	.CuentaContable.PuntoEquilibrio.EjercicioContable.cierre           		DATE
				, EjercicioContable_40.cerrado               AS EjercicioContable_40_cerrado         	-- 44	.CuentaContable.PuntoEquilibrio.EjercicioContable.cerrado          		BOOLEAN
				, EjercicioContable_40.cerradoModulos        AS EjercicioContable_40_cerradoModulos  	-- 45	.CuentaContable.PuntoEquilibrio.EjercicioContable.cerradoModulos   		BOOLEAN
				, EjercicioContable_40.comentario            AS EjercicioContable_40_comentario      	-- 46	.CuentaContable.PuntoEquilibrio.EjercicioContable.comentario       		VARCHAR(250)
				, CostoVenta_47.id                           AS CostoVenta_47_id                     	-- 47	.CuentaContable.CostoVenta.id                                      		VARCHAR(36)
				, CostoVenta_47.numero                       AS CostoVenta_47_numero                 	-- 48	.CuentaContable.CostoVenta.numero                                  		INTEGER
				, CostoVenta_47.nombre                       AS CostoVenta_47_nombre                 	-- 49	.CuentaContable.CostoVenta.nombre                                  		VARCHAR(50)
				, SeguridadPuerta_50.id                      AS SeguridadPuerta_50_id                	-- 50	.CuentaContable.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_50.numero                  AS SeguridadPuerta_50_numero            	-- 51	.CuentaContable.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_50.nombre                  AS SeguridadPuerta_50_nombre            	-- 52	.CuentaContable.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_50.equate                  AS SeguridadPuerta_50_equate            	-- 53	.CuentaContable.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_54.id                      AS SeguridadModulo_54_id                	-- 54	.CuentaContable.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_54.numero                  AS SeguridadModulo_54_numero            	-- 55	.CuentaContable.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_54.nombre                  AS SeguridadModulo_54_nombre            	-- 56	.CuentaContable.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)
				, CuentaFondoGrupo_57.id                     AS CuentaFondoGrupo_57_id               	-- 57	.CuentaFondoGrupo.id                                               		VARCHAR(36)
				, CuentaFondoGrupo_57.numero                 AS CuentaFondoGrupo_57_numero           	-- 58	.CuentaFondoGrupo.numero                                           		INTEGER
				, CuentaFondoGrupo_57.nombre                 AS CuentaFondoGrupo_57_nombre           	-- 59	.CuentaFondoGrupo.nombre                                           		VARCHAR(50)
				, CuentaFondoRubro_60.id                     AS CuentaFondoRubro_60_id               	-- 60	.CuentaFondoGrupo.CuentaFondoRubro.id                              		VARCHAR(36)
				, CuentaFondoRubro_60.numero                 AS CuentaFondoRubro_60_numero           	-- 61	.CuentaFondoGrupo.CuentaFondoRubro.numero                          		INTEGER
				, CuentaFondoRubro_60.nombre                 AS CuentaFondoRubro_60_nombre           	-- 62	.CuentaFondoGrupo.CuentaFondoRubro.nombre                          		VARCHAR(50)
				, CuentaFondoTipo_63.id                      AS CuentaFondoTipo_63_id                	-- 63	.CuentaFondoTipo.id                                                		VARCHAR(36)
				, CuentaFondoTipo_63.numero                  AS CuentaFondoTipo_63_numero            	-- 64	.CuentaFondoTipo.numero                                            		INTEGER
				, CuentaFondoTipo_63.nombre                  AS CuentaFondoTipo_63_nombre            	-- 65	.CuentaFondoTipo.nombre                                            		VARCHAR(50)
				, CuentaFondo.obsoleto                       AS CuentaFondo_obsoleto                 	-- 66	.obsoleto                                                          		BOOLEAN
				, CuentaFondo.noImprimeCaja                  AS CuentaFondo_noImprimeCaja            	-- 67	.noImprimeCaja                                                     		BOOLEAN
				, CuentaFondo.ventas                         AS CuentaFondo_ventas                   	-- 68	.ventas                                                            		BOOLEAN
				, CuentaFondo.fondos                         AS CuentaFondo_fondos                   	-- 69	.fondos                                                            		BOOLEAN
				, CuentaFondo.compras                        AS CuentaFondo_compras                  	-- 70	.compras                                                           		BOOLEAN
				, Moneda_71.id                               AS Moneda_71_id                         	-- 71	.Moneda.id                                                         		VARCHAR(36)
				, Moneda_71.numero                           AS Moneda_71_numero                     	-- 72	.Moneda.numero                                                     		INTEGER
				, Moneda_71.nombre                           AS Moneda_71_nombre                     	-- 73	.Moneda.nombre                                                     		VARCHAR(50)
				, Moneda_71.abreviatura                      AS Moneda_71_abreviatura                	-- 74	.Moneda.abreviatura                                                		VARCHAR(5)
				, Moneda_71.cotizacion                       AS Moneda_71_cotizacion                 	-- 75	.Moneda.cotizacion                                                 		DECIMAL(13,5)
				, Moneda_71.cotizacionFecha                  AS Moneda_71_cotizacionFecha            	-- 76	.Moneda.cotizacionFecha                                            		TIMESTAMP
				, Moneda_71.controlActualizacion             AS Moneda_71_controlActualizacion       	-- 77	.Moneda.controlActualizacion                                       		BOOLEAN
				, MonedaAFIP_78.id                           AS MonedaAFIP_78_id                     	-- 78	.Moneda.MonedaAFIP.id                                              		VARCHAR(36)
				, MonedaAFIP_78.codigo                       AS MonedaAFIP_78_codigo                 	-- 79	.Moneda.MonedaAFIP.codigo                                          		VARCHAR(3)
				, MonedaAFIP_78.nombre                       AS MonedaAFIP_78_nombre                 	-- 80	.Moneda.MonedaAFIP.nombre                                          		VARCHAR(50)
				, Caja_81.id                                 AS Caja_81_id                           	-- 81	.Caja.id                                                           		VARCHAR(36)
				, Caja_81.numero                             AS Caja_81_numero                       	-- 82	.Caja.numero                                                       		INTEGER
				, Caja_81.nombre                             AS Caja_81_nombre                       	-- 83	.Caja.nombre                                                       		VARCHAR(50)
				, SeguridadPuerta_84.id                      AS SeguridadPuerta_84_id                	-- 84	.Caja.SeguridadPuerta.id                                           		VARCHAR(36)
				, SeguridadPuerta_84.numero                  AS SeguridadPuerta_84_numero            	-- 85	.Caja.SeguridadPuerta.numero                                       		INTEGER
				, SeguridadPuerta_84.nombre                  AS SeguridadPuerta_84_nombre            	-- 86	.Caja.SeguridadPuerta.nombre                                       		VARCHAR(50)
				, SeguridadPuerta_84.equate                  AS SeguridadPuerta_84_equate            	-- 87	.Caja.SeguridadPuerta.equate                                       		VARCHAR(30)
				, SeguridadModulo_88.id                      AS SeguridadModulo_88_id                	-- 88	.Caja.SeguridadPuerta.SeguridadModulo.id                           		VARCHAR(36)
				, SeguridadModulo_88.numero                  AS SeguridadModulo_88_numero            	-- 89	.Caja.SeguridadPuerta.SeguridadModulo.numero                       		INTEGER
				, SeguridadModulo_88.nombre                  AS SeguridadModulo_88_nombre            	-- 90	.Caja.SeguridadPuerta.SeguridadModulo.nombre                       		VARCHAR(50)
				, CuentaFondo.rechazados                     AS CuentaFondo_rechazados               	-- 91	.rechazados                                                        		BOOLEAN
				, CuentaFondo.conciliacion                   AS CuentaFondo_conciliacion             	-- 92	.conciliacion                                                      		BOOLEAN
				, CuentaFondoTipoBanco_93.id                 AS CuentaFondoTipoBanco_93_id           	-- 93	.CuentaFondoTipoBanco.id                                           		VARCHAR(36)
				, CuentaFondoTipoBanco_93.numero             AS CuentaFondoTipoBanco_93_numero       	-- 94	.CuentaFondoTipoBanco.numero                                       		INTEGER
				, CuentaFondoTipoBanco_93.nombre             AS CuentaFondoTipoBanco_93_nombre       	-- 95	.CuentaFondoTipoBanco.nombre                                       		VARCHAR(50)
				, Banco_96.id                                AS Banco_96_id                          	-- 96	.Banco.id                                                          		VARCHAR(36)
				, Banco_96.numero                            AS Banco_96_numero                      	-- 97	.Banco.numero                                                      		INTEGER
				, Banco_96.nombre                            AS Banco_96_nombre                      	-- 98	.Banco.nombre                                                      		VARCHAR(50)
				, Banco_96.cuit                              AS Banco_96_cuit                        	-- 99	.Banco.cuit                                                        		BIGINT
				, Banco_96.bloqueado                         AS Banco_96_bloqueado                   	-- 100	.Banco.bloqueado                                                   		BOOLEAN
				, Banco_96.hoja                              AS Banco_96_hoja                        	-- 101	.Banco.hoja                                                        		INTEGER
				, Banco_96.primeraFila                       AS Banco_96_primeraFila                 	-- 102	.Banco.primeraFila                                                 		INTEGER
				, Banco_96.ultimaFila                        AS Banco_96_ultimaFila                  	-- 103	.Banco.ultimaFila                                                  		INTEGER
				, Banco_96.fecha                             AS Banco_96_fecha                       	-- 104	.Banco.fecha                                                       		VARCHAR(3)
				, Banco_96.descripcion                       AS Banco_96_descripcion                 	-- 105	.Banco.descripcion                                                 		VARCHAR(3)
				, Banco_96.referencia1                       AS Banco_96_referencia1                 	-- 106	.Banco.referencia1                                                 		VARCHAR(3)
				, Banco_96.importe                           AS Banco_96_importe                     	-- 107	.Banco.importe                                                     		VARCHAR(3)
				, Banco_96.referencia2                       AS Banco_96_referencia2                 	-- 108	.Banco.referencia2                                                 		VARCHAR(3)
				, Banco_96.saldo                             AS Banco_96_saldo                       	-- 109	.Banco.saldo                                                       		VARCHAR(3)
				, CuentaFondo.cuentaBancaria                 AS CuentaFondo_cuentaBancaria           	-- 110	.cuentaBancaria                                                    		VARCHAR(22)
				, CuentaFondo.cbu                            AS CuentaFondo_cbu                      	-- 111	.cbu                                                               		VARCHAR(22)
				, CuentaFondo.limiteDescubierto              AS CuentaFondo_limiteDescubierto        	-- 112	.limiteDescubierto                                                 		DECIMAL(13,5)
				, CuentaFondo.cuentaFondoCaucion             AS CuentaFondo_cuentaFondoCaucion       	-- 113	.cuentaFondoCaucion                                                		VARCHAR(50)
				, CuentaFondo.cuentaFondoDiferidos           AS CuentaFondo_cuentaFondoDiferidos     	-- 114	.cuentaFondoDiferidos                                              		VARCHAR(50)
				, CuentaFondo.formato                        AS CuentaFondo_formato                  	-- 115	.formato                                                           		VARCHAR(50)
				, CuentaFondoBancoCopia_116.id               AS CuentaFondoBancoCopia_116_id         	-- 116	.CuentaFondoBancoCopia.id                                          		VARCHAR(36)
				, CuentaFondoBancoCopia_116.numero           AS CuentaFondoBancoCopia_116_numero     	-- 117	.CuentaFondoBancoCopia.numero                                      		INTEGER
				, CuentaFondoBancoCopia_116.nombre           AS CuentaFondoBancoCopia_116_nombre     	-- 118	.CuentaFondoBancoCopia.nombre                                      		VARCHAR(50)
				, CuentaFondo.limiteOperacionIndividual      AS CuentaFondo_limiteOperacionIndividual	-- 119	.limiteOperacionIndividual                                         		DECIMAL(13,5)
				, SeguridadPuerta_120.id                     AS SeguridadPuerta_120_id               	-- 120	.SeguridadPuerta.id                                                		VARCHAR(36)
				, SeguridadPuerta_120.numero                 AS SeguridadPuerta_120_numero           	-- 121	.SeguridadPuerta.numero                                            		INTEGER
				, SeguridadPuerta_120.nombre                 AS SeguridadPuerta_120_nombre           	-- 122	.SeguridadPuerta.nombre                                            		VARCHAR(50)
				, SeguridadPuerta_120.equate                 AS SeguridadPuerta_120_equate           	-- 123	.SeguridadPuerta.equate                                            		VARCHAR(30)
				, SeguridadModulo_124.id                     AS SeguridadModulo_124_id               	-- 124	.SeguridadPuerta.SeguridadModulo.id                                		VARCHAR(36)
				, SeguridadModulo_124.numero                 AS SeguridadModulo_124_numero           	-- 125	.SeguridadPuerta.SeguridadModulo.numero                            		INTEGER
				, SeguridadModulo_124.nombre                 AS SeguridadModulo_124_nombre           	-- 126	.SeguridadPuerta.SeguridadModulo.nombre                            		VARCHAR(50)
				, SeguridadPuerta_127.id                     AS SeguridadPuerta_127_id               	-- 127	.SeguridadPuerta.id                                                		VARCHAR(36)
				, SeguridadPuerta_127.numero                 AS SeguridadPuerta_127_numero           	-- 128	.SeguridadPuerta.numero                                            		INTEGER
				, SeguridadPuerta_127.nombre                 AS SeguridadPuerta_127_nombre           	-- 129	.SeguridadPuerta.nombre                                            		VARCHAR(50)
				, SeguridadPuerta_127.equate                 AS SeguridadPuerta_127_equate           	-- 130	.SeguridadPuerta.equate                                            		VARCHAR(30)
				, SeguridadModulo_131.id                     AS SeguridadModulo_131_id               	-- 131	.SeguridadPuerta.SeguridadModulo.id                                		VARCHAR(36)
				, SeguridadModulo_131.numero                 AS SeguridadModulo_131_numero           	-- 132	.SeguridadPuerta.SeguridadModulo.numero                            		INTEGER
				, SeguridadModulo_131.nombre                 AS SeguridadModulo_131_nombre           	-- 133	.SeguridadPuerta.SeguridadModulo.nombre                            		VARCHAR(50)
				, SeguridadPuerta_134.id                     AS SeguridadPuerta_134_id               	-- 134	.SeguridadPuerta.id                                                		VARCHAR(36)
				, SeguridadPuerta_134.numero                 AS SeguridadPuerta_134_numero           	-- 135	.SeguridadPuerta.numero                                            		INTEGER
				, SeguridadPuerta_134.nombre                 AS SeguridadPuerta_134_nombre           	-- 136	.SeguridadPuerta.nombre                                            		VARCHAR(50)
				, SeguridadPuerta_134.equate                 AS SeguridadPuerta_134_equate           	-- 137	.SeguridadPuerta.equate                                            		VARCHAR(30)
				, SeguridadModulo_138.id                     AS SeguridadModulo_138_id               	-- 138	.SeguridadPuerta.SeguridadModulo.id                                		VARCHAR(36)
				, SeguridadModulo_138.numero                 AS SeguridadModulo_138_numero           	-- 139	.SeguridadPuerta.SeguridadModulo.numero                            		INTEGER
				, SeguridadModulo_138.nombre                 AS SeguridadModulo_138_nombre           	-- 140	.SeguridadPuerta.SeguridadModulo.nombre                            		VARCHAR(50)

		FROM	massoftware.CuentaFondo
			LEFT JOIN massoftware.CuentaContable AS CuentaContable_3                    ON CuentaFondo.cuentaContable = CuentaContable_3.id 	-- 3 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_6                ON CuentaContable_3.ejercicioContable = EjercicioContable_6.id 	-- 6 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_17             ON CuentaContable_3.cuentaContableEstado = CuentaContableEstado_17.id 	-- 17 LEFT LEVEL: 2
				LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_21              ON CuentaContable_3.centroCostoContable = CentroCostoContable_21.id 	-- 21 LEFT LEVEL: 2
					LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_25               ON CentroCostoContable_21.ejercicioContable = EjercicioContable_25.id 	-- 25 LEFT LEVEL: 3
				LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_34                  ON CuentaContable_3.puntoEquilibrio = PuntoEquilibrio_34.id 	-- 34 LEFT LEVEL: 2
					LEFT JOIN massoftware.TipoPuntoEquilibrio AS TipoPuntoEquilibrio_37             ON PuntoEquilibrio_34.tipoPuntoEquilibrio = TipoPuntoEquilibrio_37.id 	-- 37 LEFT LEVEL: 3
					LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_40               ON PuntoEquilibrio_34.ejercicioContable = EjercicioContable_40.id 	-- 40 LEFT LEVEL: 3
				LEFT JOIN massoftware.CostoVenta AS CostoVenta_47                       ON CuentaContable_3.costoVenta = CostoVenta_47.id 	-- 47 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_50                  ON CuentaContable_3.seguridadPuerta = SeguridadPuerta_50.id 	-- 50 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_54                 ON SeguridadPuerta_50.seguridadModulo = SeguridadModulo_54.id 	-- 54 LEFT LEVEL: 3
			LEFT JOIN massoftware.CuentaFondoGrupo AS CuentaFondoGrupo_57                 ON CuentaFondo.cuentaFondoGrupo = CuentaFondoGrupo_57.id 	-- 57 LEFT LEVEL: 1
				LEFT JOIN massoftware.CuentaFondoRubro AS CuentaFondoRubro_60                 ON CuentaFondoGrupo_57.cuentaFondoRubro = CuentaFondoRubro_60.id 	-- 60 LEFT LEVEL: 2
			LEFT JOIN massoftware.CuentaFondoTipo AS CuentaFondoTipo_63                  ON CuentaFondo.cuentaFondoTipo = CuentaFondoTipo_63.id 	-- 63 LEFT LEVEL: 1
			LEFT JOIN massoftware.Moneda AS Moneda_71                           ON CuentaFondo.moneda = Moneda_71.id 	-- 71 LEFT LEVEL: 1
				LEFT JOIN massoftware.MonedaAFIP AS MonedaAFIP_78                       ON Moneda_71.monedaAFIP = MonedaAFIP_78.id 	-- 78 LEFT LEVEL: 2
			LEFT JOIN massoftware.Caja AS Caja_81                             ON CuentaFondo.caja = Caja_81.id 	-- 81 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_84                  ON Caja_81.seguridadPuerta = SeguridadPuerta_84.id 	-- 84 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_88                 ON SeguridadPuerta_84.seguridadModulo = SeguridadModulo_88.id 	-- 88 LEFT LEVEL: 3
			LEFT JOIN massoftware.CuentaFondoTipoBanco AS CuentaFondoTipoBanco_93             ON CuentaFondo.cuentaFondoTipoBanco = CuentaFondoTipoBanco_93.id 	-- 93 LEFT LEVEL: 1
			LEFT JOIN massoftware.Banco AS Banco_96                            ON CuentaFondo.banco = Banco_96.id 	-- 96 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaFondoBancoCopia AS CuentaFondoBancoCopia_116            ON CuentaFondo.cuentaFondoBancoCopia = CuentaFondoBancoCopia_116.id 	-- 116 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_120                  ON CuentaFondo.seguridadPuertaUso = SeguridadPuerta_120.id 	-- 120 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_124                 ON SeguridadPuerta_120.seguridadModulo = SeguridadModulo_124.id 	-- 124 LEFT LEVEL: 2
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_127                  ON CuentaFondo.seguridadPuertaConsulta = SeguridadPuerta_127.id 	-- 127 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_131                 ON SeguridadPuerta_127.seguridadModulo = SeguridadModulo_131.id 	-- 131 LEFT LEVEL: 2
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_134                  ON CuentaFondo.seguridadPuertaLimite = SeguridadPuerta_134.id 	-- 134 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_138                 ON SeguridadPuerta_134.seguridadModulo = SeguridadModulo_138.id 	-- 138 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondo.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND bancoArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(bancoArg8)) > 0 THEN
		bancoArg8 = REPLACE(bancoArg8, '''', '''''');
		bancoArg8 = LOWER(TRIM(bancoArg8));
		bancoArg8 = TRANSLATE(bancoArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(bancoArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondo.banco),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoById_3 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoById_3 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_CuentaFondo_3 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaFondo_3 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaFondo_3 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaFondoById_3 ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ComprobanteFondoModelo                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ComprobanteFondoModelo



DROP FUNCTION IF EXISTS massoftware.f_ComprobanteFondoModelo (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ComprobanteFondoModelo (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.ComprobanteFondoModelo AS $$

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
				  ComprobanteFondoModelo.id        AS ComprobanteFondoModelo_id    	-- 0	.id   		VARCHAR(36)
				, ComprobanteFondoModelo.numero    AS ComprobanteFondoModelo_numero	-- 1	.numero		INTEGER
				, ComprobanteFondoModelo.nombre    AS ComprobanteFondoModelo_nombre	-- 2	.nombre		VARCHAR(50)

		FROM	massoftware.ComprobanteFondoModelo

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModelo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModelo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModelo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(ComprobanteFondoModelo.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_ComprobanteFondoModeloById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ComprobanteFondoModeloById (idArg VARCHAR(36)) RETURNS SETOF massoftware.ComprobanteFondoModelo AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_ComprobanteFondoModelo ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_ComprobanteFondoModelo ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_ComprobanteFondoModeloById ('xxx'); 


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ComprobanteFondoModeloItem                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ComprobanteFondoModeloItem



DROP FUNCTION IF EXISTS massoftware.f_ComprobanteFondoModeloItem (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, cuentaFondoArg7   VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ComprobanteFondoModeloItem (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, cuentaFondoArg7   VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.ComprobanteFondoModeloItem AS $$

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
				  ComprobanteFondoModeloItem.id                        AS ComprobanteFondoModeloItem_id                    	-- 0	.id                   		VARCHAR(36)
				, ComprobanteFondoModeloItem.numero                    AS ComprobanteFondoModeloItem_numero                	-- 1	.numero               		INTEGER
				, ComprobanteFondoModeloItem.debe                      AS ComprobanteFondoModeloItem_debe                  	-- 2	.debe                 		BOOLEAN
				, ComprobanteFondoModeloItem.comprobanteFondoModelo    AS ComprobanteFondoModeloItem_comprobanteFondoModelo	-- 3	.comprobanteFondoModelo		VARCHAR(36)	ComprobanteFondoModelo.id
				, ComprobanteFondoModeloItem.cuentaFondo               AS ComprobanteFondoModeloItem_cuentaFondo           	-- 4	.cuentaFondo          		VARCHAR(36)	CuentaFondo.id

		FROM	massoftware.ComprobanteFondoModeloItem

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND cuentaFondoArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(cuentaFondoArg7)) > 0 THEN
		cuentaFondoArg7 = REPLACE(cuentaFondoArg7, '''', '''''');
		cuentaFondoArg7 = LOWER(TRIM(cuentaFondoArg7));
		cuentaFondoArg7 = TRANSLATE(cuentaFondoArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(cuentaFondoArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(ComprobanteFondoModeloItem.cuentaFondo),
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

DROP FUNCTION IF EXISTS massoftware.f_ComprobanteFondoModeloItemById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ComprobanteFondoModeloItemById (idArg VARCHAR(36)) RETURNS SETOF massoftware.ComprobanteFondoModeloItem AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_ComprobanteFondoModeloItem ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_ComprobanteFondoModeloItem ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_ComprobanteFondoModeloItemById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_ComprobanteFondoModeloItem_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, cuentaFondoArg7   VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ComprobanteFondoModeloItem_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, cuentaFondoArg7   VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.t_ComprobanteFondoModeloItem_1 AS $$

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
				  ComprobanteFondoModeloItem.id               AS ComprobanteFondoModeloItem_id          	-- 0	.id                                  		VARCHAR(36)
				, ComprobanteFondoModeloItem.numero           AS ComprobanteFondoModeloItem_numero      	-- 1	.numero                              		INTEGER
				, ComprobanteFondoModeloItem.debe             AS ComprobanteFondoModeloItem_debe        	-- 2	.debe                                		BOOLEAN
				, ComprobanteFondoModelo_3.id                 AS ComprobanteFondoModelo_3_id            	-- 3	.ComprobanteFondoModelo.id           		VARCHAR(36)
				, ComprobanteFondoModelo_3.numero             AS ComprobanteFondoModelo_3_numero        	-- 4	.ComprobanteFondoModelo.numero       		INTEGER
				, ComprobanteFondoModelo_3.nombre             AS ComprobanteFondoModelo_3_nombre        	-- 5	.ComprobanteFondoModelo.nombre       		VARCHAR(50)
				, CuentaFondo_6.id                            AS CuentaFondo_6_id                       	-- 6	.CuentaFondo.id                      		VARCHAR(36)
				, CuentaFondo_6.numero                        AS CuentaFondo_6_numero                   	-- 7	.CuentaFondo.numero                  		INTEGER
				, CuentaFondo_6.nombre                        AS CuentaFondo_6_nombre                   	-- 8	.CuentaFondo.nombre                  		VARCHAR(50)
				, CuentaFondo_6.cuentaContable                AS CuentaFondo_6_cuentaContable           	-- 9	.CuentaFondo.cuentaContable          		VARCHAR(36)	CuentaContable.id
				, CuentaFondo_6.cuentaFondoGrupo              AS CuentaFondo_6_cuentaFondoGrupo         	-- 10	.CuentaFondo.cuentaFondoGrupo        		VARCHAR(36)	CuentaFondoGrupo.id
				, CuentaFondo_6.cuentaFondoTipo               AS CuentaFondo_6_cuentaFondoTipo          	-- 11	.CuentaFondo.cuentaFondoTipo         		VARCHAR(36)	CuentaFondoTipo.id
				, CuentaFondo_6.obsoleto                      AS CuentaFondo_6_obsoleto                 	-- 12	.CuentaFondo.obsoleto                		BOOLEAN
				, CuentaFondo_6.noImprimeCaja                 AS CuentaFondo_6_noImprimeCaja            	-- 13	.CuentaFondo.noImprimeCaja           		BOOLEAN
				, CuentaFondo_6.ventas                        AS CuentaFondo_6_ventas                   	-- 14	.CuentaFondo.ventas                  		BOOLEAN
				, CuentaFondo_6.fondos                        AS CuentaFondo_6_fondos                   	-- 15	.CuentaFondo.fondos                  		BOOLEAN
				, CuentaFondo_6.compras                       AS CuentaFondo_6_compras                  	-- 16	.CuentaFondo.compras                 		BOOLEAN
				, CuentaFondo_6.moneda                        AS CuentaFondo_6_moneda                   	-- 17	.CuentaFondo.moneda                  		VARCHAR(36)	Moneda.id
				, CuentaFondo_6.caja                          AS CuentaFondo_6_caja                     	-- 18	.CuentaFondo.caja                    		VARCHAR(36)	Caja.id
				, CuentaFondo_6.rechazados                    AS CuentaFondo_6_rechazados               	-- 19	.CuentaFondo.rechazados              		BOOLEAN
				, CuentaFondo_6.conciliacion                  AS CuentaFondo_6_conciliacion             	-- 20	.CuentaFondo.conciliacion            		BOOLEAN
				, CuentaFondo_6.cuentaFondoTipoBanco          AS CuentaFondo_6_cuentaFondoTipoBanco     	-- 21	.CuentaFondo.cuentaFondoTipoBanco    		VARCHAR(36)	CuentaFondoTipoBanco.id
				, CuentaFondo_6.banco                         AS CuentaFondo_6_banco                    	-- 22	.CuentaFondo.banco                   		VARCHAR(36)	Banco.id
				, CuentaFondo_6.cuentaBancaria                AS CuentaFondo_6_cuentaBancaria           	-- 23	.CuentaFondo.cuentaBancaria          		VARCHAR(22)
				, CuentaFondo_6.cbu                           AS CuentaFondo_6_cbu                      	-- 24	.CuentaFondo.cbu                     		VARCHAR(22)
				, CuentaFondo_6.limiteDescubierto             AS CuentaFondo_6_limiteDescubierto        	-- 25	.CuentaFondo.limiteDescubierto       		DECIMAL(13,5)
				, CuentaFondo_6.cuentaFondoCaucion            AS CuentaFondo_6_cuentaFondoCaucion       	-- 26	.CuentaFondo.cuentaFondoCaucion      		VARCHAR(50)
				, CuentaFondo_6.cuentaFondoDiferidos          AS CuentaFondo_6_cuentaFondoDiferidos     	-- 27	.CuentaFondo.cuentaFondoDiferidos    		VARCHAR(50)
				, CuentaFondo_6.formato                       AS CuentaFondo_6_formato                  	-- 28	.CuentaFondo.formato                 		VARCHAR(50)
				, CuentaFondo_6.cuentaFondoBancoCopia         AS CuentaFondo_6_cuentaFondoBancoCopia    	-- 29	.CuentaFondo.cuentaFondoBancoCopia   		VARCHAR(36)	CuentaFondoBancoCopia.id
				, CuentaFondo_6.limiteOperacionIndividual     AS CuentaFondo_6_limiteOperacionIndividual	-- 30	.CuentaFondo.limiteOperacionIndividual		DECIMAL(13,5)
				, CuentaFondo_6.seguridadPuertaUso            AS CuentaFondo_6_seguridadPuertaUso       	-- 31	.CuentaFondo.seguridadPuertaUso      		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondo_6.seguridadPuertaConsulta       AS CuentaFondo_6_seguridadPuertaConsulta  	-- 32	.CuentaFondo.seguridadPuertaConsulta 		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondo_6.seguridadPuertaLimite         AS CuentaFondo_6_seguridadPuertaLimite    	-- 33	.CuentaFondo.seguridadPuertaLimite   		VARCHAR(36)	SeguridadPuerta.id

		FROM	massoftware.ComprobanteFondoModeloItem
			LEFT JOIN massoftware.ComprobanteFondoModelo AS ComprobanteFondoModelo_3        ON ComprobanteFondoModeloItem.comprobanteFondoModelo = ComprobanteFondoModelo_3.id 	-- 3 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaFondo AS CuentaFondo_6                   ON ComprobanteFondoModeloItem.cuentaFondo = CuentaFondo_6.id 	-- 6 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND cuentaFondoArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(cuentaFondoArg7)) > 0 THEN
		cuentaFondoArg7 = REPLACE(cuentaFondoArg7, '''', '''''');
		cuentaFondoArg7 = LOWER(TRIM(cuentaFondoArg7));
		cuentaFondoArg7 = TRANSLATE(cuentaFondoArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(cuentaFondoArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(ComprobanteFondoModeloItem.cuentaFondo),
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

DROP FUNCTION IF EXISTS massoftware.f_ComprobanteFondoModeloItemById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ComprobanteFondoModeloItemById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_ComprobanteFondoModeloItem_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_ComprobanteFondoModeloItem_1 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_ComprobanteFondoModeloItem_1 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_ComprobanteFondoModeloItemById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_ComprobanteFondoModeloItem_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, cuentaFondoArg7   VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ComprobanteFondoModeloItem_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, cuentaFondoArg7   VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.t_ComprobanteFondoModeloItem_2 AS $$

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
				  ComprobanteFondoModeloItem.id               AS ComprobanteFondoModeloItem_id          	-- 0	.id                                            		VARCHAR(36)
				, ComprobanteFondoModeloItem.numero           AS ComprobanteFondoModeloItem_numero      	-- 1	.numero                                        		INTEGER
				, ComprobanteFondoModeloItem.debe             AS ComprobanteFondoModeloItem_debe        	-- 2	.debe                                          		BOOLEAN
				, ComprobanteFondoModelo_3.id                 AS ComprobanteFondoModelo_3_id            	-- 3	.ComprobanteFondoModelo.id                     		VARCHAR(36)
				, ComprobanteFondoModelo_3.numero             AS ComprobanteFondoModelo_3_numero        	-- 4	.ComprobanteFondoModelo.numero                 		INTEGER
				, ComprobanteFondoModelo_3.nombre             AS ComprobanteFondoModelo_3_nombre        	-- 5	.ComprobanteFondoModelo.nombre                 		VARCHAR(50)
				, CuentaFondo_6.id                            AS CuentaFondo_6_id                       	-- 6	.CuentaFondo.id                                		VARCHAR(36)
				, CuentaFondo_6.numero                        AS CuentaFondo_6_numero                   	-- 7	.CuentaFondo.numero                            		INTEGER
				, CuentaFondo_6.nombre                        AS CuentaFondo_6_nombre                   	-- 8	.CuentaFondo.nombre                            		VARCHAR(50)
				, CuentaContable_9.id                         AS CuentaContable_9_id                    	-- 9	.CuentaFondo.CuentaContable.id                 		VARCHAR(36)
				, CuentaContable_9.codigo                     AS CuentaContable_9_codigo                	-- 10	.CuentaFondo.CuentaContable.codigo             		VARCHAR(11)
				, CuentaContable_9.nombre                     AS CuentaContable_9_nombre                	-- 11	.CuentaFondo.CuentaContable.nombre             		VARCHAR(50)
				, CuentaContable_9.ejercicioContable          AS CuentaContable_9_ejercicioContable     	-- 12	.CuentaFondo.CuentaContable.ejercicioContable  		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_9.integra                    AS CuentaContable_9_integra               	-- 13	.CuentaFondo.CuentaContable.integra            		VARCHAR(16)
				, CuentaContable_9.cuentaJerarquia            AS CuentaContable_9_cuentaJerarquia       	-- 14	.CuentaFondo.CuentaContable.cuentaJerarquia    		VARCHAR(16)
				, CuentaContable_9.imputable                  AS CuentaContable_9_imputable             	-- 15	.CuentaFondo.CuentaContable.imputable          		BOOLEAN
				, CuentaContable_9.ajustaPorInflacion         AS CuentaContable_9_ajustaPorInflacion    	-- 16	.CuentaFondo.CuentaContable.ajustaPorInflacion 		BOOLEAN
				, CuentaContable_9.cuentaContableEstado       AS CuentaContable_9_cuentaContableEstado  	-- 17	.CuentaFondo.CuentaContable.cuentaContableEstado		VARCHAR(36)	CuentaContableEstado.id
				, CuentaContable_9.cuentaConApropiacion       AS CuentaContable_9_cuentaConApropiacion  	-- 18	.CuentaFondo.CuentaContable.cuentaConApropiacion		BOOLEAN
				, CuentaContable_9.centroCostoContable        AS CuentaContable_9_centroCostoContable   	-- 19	.CuentaFondo.CuentaContable.centroCostoContable		VARCHAR(36)	CentroCostoContable.id
				, CuentaContable_9.cuentaAgrupadora           AS CuentaContable_9_cuentaAgrupadora      	-- 20	.CuentaFondo.CuentaContable.cuentaAgrupadora   		VARCHAR(50)
				, CuentaContable_9.porcentaje                 AS CuentaContable_9_porcentaje            	-- 21	.CuentaFondo.CuentaContable.porcentaje         		DECIMAL(6,3)
				, CuentaContable_9.puntoEquilibrio            AS CuentaContable_9_puntoEquilibrio       	-- 22	.CuentaFondo.CuentaContable.puntoEquilibrio    		VARCHAR(36)	PuntoEquilibrio.id
				, CuentaContable_9.costoVenta                 AS CuentaContable_9_costoVenta            	-- 23	.CuentaFondo.CuentaContable.costoVenta         		VARCHAR(36)	CostoVenta.id
				, CuentaContable_9.seguridadPuerta            AS CuentaContable_9_seguridadPuerta       	-- 24	.CuentaFondo.CuentaContable.seguridadPuerta    		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondoGrupo_25.id                      AS CuentaFondoGrupo_25_id                 	-- 25	.CuentaFondo.CuentaFondoGrupo.id               		VARCHAR(36)
				, CuentaFondoGrupo_25.numero                  AS CuentaFondoGrupo_25_numero             	-- 26	.CuentaFondo.CuentaFondoGrupo.numero           		INTEGER
				, CuentaFondoGrupo_25.nombre                  AS CuentaFondoGrupo_25_nombre             	-- 27	.CuentaFondo.CuentaFondoGrupo.nombre           		VARCHAR(50)
				, CuentaFondoGrupo_25.cuentaFondoRubro        AS CuentaFondoGrupo_25_cuentaFondoRubro   	-- 28	.CuentaFondo.CuentaFondoGrupo.cuentaFondoRubro 		VARCHAR(36)	CuentaFondoRubro.id
				, CuentaFondoTipo_29.id                       AS CuentaFondoTipo_29_id                  	-- 29	.CuentaFondo.CuentaFondoTipo.id                		VARCHAR(36)
				, CuentaFondoTipo_29.numero                   AS CuentaFondoTipo_29_numero              	-- 30	.CuentaFondo.CuentaFondoTipo.numero            		INTEGER
				, CuentaFondoTipo_29.nombre                   AS CuentaFondoTipo_29_nombre              	-- 31	.CuentaFondo.CuentaFondoTipo.nombre            		VARCHAR(50)
				, CuentaFondo_6.obsoleto                      AS CuentaFondo_6_obsoleto                 	-- 32	.CuentaFondo.obsoleto                          		BOOLEAN
				, CuentaFondo_6.noImprimeCaja                 AS CuentaFondo_6_noImprimeCaja            	-- 33	.CuentaFondo.noImprimeCaja                     		BOOLEAN
				, CuentaFondo_6.ventas                        AS CuentaFondo_6_ventas                   	-- 34	.CuentaFondo.ventas                            		BOOLEAN
				, CuentaFondo_6.fondos                        AS CuentaFondo_6_fondos                   	-- 35	.CuentaFondo.fondos                            		BOOLEAN
				, CuentaFondo_6.compras                       AS CuentaFondo_6_compras                  	-- 36	.CuentaFondo.compras                           		BOOLEAN
				, Moneda_37.id                                AS Moneda_37_id                           	-- 37	.CuentaFondo.Moneda.id                         		VARCHAR(36)
				, Moneda_37.numero                            AS Moneda_37_numero                       	-- 38	.CuentaFondo.Moneda.numero                     		INTEGER
				, Moneda_37.nombre                            AS Moneda_37_nombre                       	-- 39	.CuentaFondo.Moneda.nombre                     		VARCHAR(50)
				, Moneda_37.abreviatura                       AS Moneda_37_abreviatura                  	-- 40	.CuentaFondo.Moneda.abreviatura                		VARCHAR(5)
				, Moneda_37.cotizacion                        AS Moneda_37_cotizacion                   	-- 41	.CuentaFondo.Moneda.cotizacion                 		DECIMAL(13,5)
				, Moneda_37.cotizacionFecha                   AS Moneda_37_cotizacionFecha              	-- 42	.CuentaFondo.Moneda.cotizacionFecha            		TIMESTAMP
				, Moneda_37.controlActualizacion              AS Moneda_37_controlActualizacion         	-- 43	.CuentaFondo.Moneda.controlActualizacion       		BOOLEAN
				, Moneda_37.monedaAFIP                        AS Moneda_37_monedaAFIP                   	-- 44	.CuentaFondo.Moneda.monedaAFIP                 		VARCHAR(36)	MonedaAFIP.id
				, Caja_45.id                                  AS Caja_45_id                             	-- 45	.CuentaFondo.Caja.id                           		VARCHAR(36)
				, Caja_45.numero                              AS Caja_45_numero                         	-- 46	.CuentaFondo.Caja.numero                       		INTEGER
				, Caja_45.nombre                              AS Caja_45_nombre                         	-- 47	.CuentaFondo.Caja.nombre                       		VARCHAR(50)
				, Caja_45.seguridadPuerta                     AS Caja_45_seguridadPuerta                	-- 48	.CuentaFondo.Caja.seguridadPuerta              		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondo_6.rechazados                    AS CuentaFondo_6_rechazados               	-- 49	.CuentaFondo.rechazados                        		BOOLEAN
				, CuentaFondo_6.conciliacion                  AS CuentaFondo_6_conciliacion             	-- 50	.CuentaFondo.conciliacion                      		BOOLEAN
				, CuentaFondoTipoBanco_51.id                  AS CuentaFondoTipoBanco_51_id             	-- 51	.CuentaFondo.CuentaFondoTipoBanco.id           		VARCHAR(36)
				, CuentaFondoTipoBanco_51.numero              AS CuentaFondoTipoBanco_51_numero         	-- 52	.CuentaFondo.CuentaFondoTipoBanco.numero       		INTEGER
				, CuentaFondoTipoBanco_51.nombre              AS CuentaFondoTipoBanco_51_nombre         	-- 53	.CuentaFondo.CuentaFondoTipoBanco.nombre       		VARCHAR(50)
				, Banco_54.id                                 AS Banco_54_id                            	-- 54	.CuentaFondo.Banco.id                          		VARCHAR(36)
				, Banco_54.numero                             AS Banco_54_numero                        	-- 55	.CuentaFondo.Banco.numero                      		INTEGER
				, Banco_54.nombre                             AS Banco_54_nombre                        	-- 56	.CuentaFondo.Banco.nombre                      		VARCHAR(50)
				, Banco_54.cuit                               AS Banco_54_cuit                          	-- 57	.CuentaFondo.Banco.cuit                        		BIGINT
				, Banco_54.bloqueado                          AS Banco_54_bloqueado                     	-- 58	.CuentaFondo.Banco.bloqueado                   		BOOLEAN
				, Banco_54.hoja                               AS Banco_54_hoja                          	-- 59	.CuentaFondo.Banco.hoja                        		INTEGER
				, Banco_54.primeraFila                        AS Banco_54_primeraFila                   	-- 60	.CuentaFondo.Banco.primeraFila                 		INTEGER
				, Banco_54.ultimaFila                         AS Banco_54_ultimaFila                    	-- 61	.CuentaFondo.Banco.ultimaFila                  		INTEGER
				, Banco_54.fecha                              AS Banco_54_fecha                         	-- 62	.CuentaFondo.Banco.fecha                       		VARCHAR(3)
				, Banco_54.descripcion                        AS Banco_54_descripcion                   	-- 63	.CuentaFondo.Banco.descripcion                 		VARCHAR(3)
				, Banco_54.referencia1                        AS Banco_54_referencia1                   	-- 64	.CuentaFondo.Banco.referencia1                 		VARCHAR(3)
				, Banco_54.importe                            AS Banco_54_importe                       	-- 65	.CuentaFondo.Banco.importe                     		VARCHAR(3)
				, Banco_54.referencia2                        AS Banco_54_referencia2                   	-- 66	.CuentaFondo.Banco.referencia2                 		VARCHAR(3)
				, Banco_54.saldo                              AS Banco_54_saldo                         	-- 67	.CuentaFondo.Banco.saldo                       		VARCHAR(3)
				, CuentaFondo_6.cuentaBancaria                AS CuentaFondo_6_cuentaBancaria           	-- 68	.CuentaFondo.cuentaBancaria                    		VARCHAR(22)
				, CuentaFondo_6.cbu                           AS CuentaFondo_6_cbu                      	-- 69	.CuentaFondo.cbu                               		VARCHAR(22)
				, CuentaFondo_6.limiteDescubierto             AS CuentaFondo_6_limiteDescubierto        	-- 70	.CuentaFondo.limiteDescubierto                 		DECIMAL(13,5)
				, CuentaFondo_6.cuentaFondoCaucion            AS CuentaFondo_6_cuentaFondoCaucion       	-- 71	.CuentaFondo.cuentaFondoCaucion                		VARCHAR(50)
				, CuentaFondo_6.cuentaFondoDiferidos          AS CuentaFondo_6_cuentaFondoDiferidos     	-- 72	.CuentaFondo.cuentaFondoDiferidos              		VARCHAR(50)
				, CuentaFondo_6.formato                       AS CuentaFondo_6_formato                  	-- 73	.CuentaFondo.formato                           		VARCHAR(50)
				, CuentaFondoBancoCopia_74.id                 AS CuentaFondoBancoCopia_74_id            	-- 74	.CuentaFondo.CuentaFondoBancoCopia.id          		VARCHAR(36)
				, CuentaFondoBancoCopia_74.numero             AS CuentaFondoBancoCopia_74_numero        	-- 75	.CuentaFondo.CuentaFondoBancoCopia.numero      		INTEGER
				, CuentaFondoBancoCopia_74.nombre             AS CuentaFondoBancoCopia_74_nombre        	-- 76	.CuentaFondo.CuentaFondoBancoCopia.nombre      		VARCHAR(50)
				, CuentaFondo_6.limiteOperacionIndividual     AS CuentaFondo_6_limiteOperacionIndividual	-- 77	.CuentaFondo.limiteOperacionIndividual         		DECIMAL(13,5)
				, SeguridadPuerta_78.id                       AS SeguridadPuerta_78_id                  	-- 78	.CuentaFondo.SeguridadPuerta.id                		VARCHAR(36)
				, SeguridadPuerta_78.numero                   AS SeguridadPuerta_78_numero              	-- 79	.CuentaFondo.SeguridadPuerta.numero            		INTEGER
				, SeguridadPuerta_78.nombre                   AS SeguridadPuerta_78_nombre              	-- 80	.CuentaFondo.SeguridadPuerta.nombre            		VARCHAR(50)
				, SeguridadPuerta_78.equate                   AS SeguridadPuerta_78_equate              	-- 81	.CuentaFondo.SeguridadPuerta.equate            		VARCHAR(30)
				, SeguridadPuerta_78.seguridadModulo          AS SeguridadPuerta_78_seguridadModulo     	-- 82	.CuentaFondo.SeguridadPuerta.seguridadModulo   		VARCHAR(36)	SeguridadModulo.id
				, SeguridadPuerta_83.id                       AS SeguridadPuerta_83_id                  	-- 83	.CuentaFondo.SeguridadPuerta.id                		VARCHAR(36)
				, SeguridadPuerta_83.numero                   AS SeguridadPuerta_83_numero              	-- 84	.CuentaFondo.SeguridadPuerta.numero            		INTEGER
				, SeguridadPuerta_83.nombre                   AS SeguridadPuerta_83_nombre              	-- 85	.CuentaFondo.SeguridadPuerta.nombre            		VARCHAR(50)
				, SeguridadPuerta_83.equate                   AS SeguridadPuerta_83_equate              	-- 86	.CuentaFondo.SeguridadPuerta.equate            		VARCHAR(30)
				, SeguridadPuerta_83.seguridadModulo          AS SeguridadPuerta_83_seguridadModulo     	-- 87	.CuentaFondo.SeguridadPuerta.seguridadModulo   		VARCHAR(36)	SeguridadModulo.id
				, SeguridadPuerta_88.id                       AS SeguridadPuerta_88_id                  	-- 88	.CuentaFondo.SeguridadPuerta.id                		VARCHAR(36)
				, SeguridadPuerta_88.numero                   AS SeguridadPuerta_88_numero              	-- 89	.CuentaFondo.SeguridadPuerta.numero            		INTEGER
				, SeguridadPuerta_88.nombre                   AS SeguridadPuerta_88_nombre              	-- 90	.CuentaFondo.SeguridadPuerta.nombre            		VARCHAR(50)
				, SeguridadPuerta_88.equate                   AS SeguridadPuerta_88_equate              	-- 91	.CuentaFondo.SeguridadPuerta.equate            		VARCHAR(30)
				, SeguridadPuerta_88.seguridadModulo          AS SeguridadPuerta_88_seguridadModulo     	-- 92	.CuentaFondo.SeguridadPuerta.seguridadModulo   		VARCHAR(36)	SeguridadModulo.id

		FROM	massoftware.ComprobanteFondoModeloItem
			LEFT JOIN massoftware.ComprobanteFondoModelo AS ComprobanteFondoModelo_3           ON ComprobanteFondoModeloItem.comprobanteFondoModelo = ComprobanteFondoModelo_3.id 	-- 3 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaFondo AS CuentaFondo_6                      ON ComprobanteFondoModeloItem.cuentaFondo = CuentaFondo_6.id 	-- 6 LEFT LEVEL: 1
				LEFT JOIN massoftware.CuentaContable AS CuentaContable_9                  ON CuentaFondo_6.cuentaContable = CuentaContable_9.id 	-- 9 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaFondoGrupo AS CuentaFondoGrupo_25                ON CuentaFondo_6.cuentaFondoGrupo = CuentaFondoGrupo_25.id 	-- 25 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaFondoTipo AS CuentaFondoTipo_29                 ON CuentaFondo_6.cuentaFondoTipo = CuentaFondoTipo_29.id 	-- 29 LEFT LEVEL: 2
				LEFT JOIN massoftware.Moneda AS Moneda_37                          ON CuentaFondo_6.moneda = Moneda_37.id 	-- 37 LEFT LEVEL: 2
				LEFT JOIN massoftware.Caja AS Caja_45                            ON CuentaFondo_6.caja = Caja_45.id 	-- 45 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaFondoTipoBanco AS CuentaFondoTipoBanco_51            ON CuentaFondo_6.cuentaFondoTipoBanco = CuentaFondoTipoBanco_51.id 	-- 51 LEFT LEVEL: 2
				LEFT JOIN massoftware.Banco AS Banco_54                           ON CuentaFondo_6.banco = Banco_54.id 	-- 54 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaFondoBancoCopia AS CuentaFondoBancoCopia_74           ON CuentaFondo_6.cuentaFondoBancoCopia = CuentaFondoBancoCopia_74.id 	-- 74 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_78                 ON CuentaFondo_6.seguridadPuertaUso = SeguridadPuerta_78.id 	-- 78 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_83                 ON CuentaFondo_6.seguridadPuertaConsulta = SeguridadPuerta_83.id 	-- 83 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_88                 ON CuentaFondo_6.seguridadPuertaLimite = SeguridadPuerta_88.id 	-- 88 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND cuentaFondoArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(cuentaFondoArg7)) > 0 THEN
		cuentaFondoArg7 = REPLACE(cuentaFondoArg7, '''', '''''');
		cuentaFondoArg7 = LOWER(TRIM(cuentaFondoArg7));
		cuentaFondoArg7 = TRANSLATE(cuentaFondoArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(cuentaFondoArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(ComprobanteFondoModeloItem.cuentaFondo),
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

DROP FUNCTION IF EXISTS massoftware.f_ComprobanteFondoModeloItemById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ComprobanteFondoModeloItemById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_ComprobanteFondoModeloItem_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_ComprobanteFondoModeloItem_2 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_ComprobanteFondoModeloItem_2 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_ComprobanteFondoModeloItemById_2 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_ComprobanteFondoModeloItem_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, cuentaFondoArg7   VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ComprobanteFondoModeloItem_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, cuentaFondoArg7   VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.t_ComprobanteFondoModeloItem_3 AS $$

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
				  ComprobanteFondoModeloItem.id                AS ComprobanteFondoModeloItem_id           	-- 0	.id                                                             		VARCHAR(36)
				, ComprobanteFondoModeloItem.numero            AS ComprobanteFondoModeloItem_numero       	-- 1	.numero                                                         		INTEGER
				, ComprobanteFondoModeloItem.debe              AS ComprobanteFondoModeloItem_debe         	-- 2	.debe                                                           		BOOLEAN
				, ComprobanteFondoModelo_3.id                  AS ComprobanteFondoModelo_3_id             	-- 3	.ComprobanteFondoModelo.id                                      		VARCHAR(36)
				, ComprobanteFondoModelo_3.numero              AS ComprobanteFondoModelo_3_numero         	-- 4	.ComprobanteFondoModelo.numero                                  		INTEGER
				, ComprobanteFondoModelo_3.nombre              AS ComprobanteFondoModelo_3_nombre         	-- 5	.ComprobanteFondoModelo.nombre                                  		VARCHAR(50)
				, CuentaFondo_6.id                             AS CuentaFondo_6_id                        	-- 6	.CuentaFondo.id                                                 		VARCHAR(36)
				, CuentaFondo_6.numero                         AS CuentaFondo_6_numero                    	-- 7	.CuentaFondo.numero                                             		INTEGER
				, CuentaFondo_6.nombre                         AS CuentaFondo_6_nombre                    	-- 8	.CuentaFondo.nombre                                             		VARCHAR(50)
				, CuentaContable_9.id                          AS CuentaContable_9_id                     	-- 9	.CuentaFondo.CuentaContable.id                                  		VARCHAR(36)
				, CuentaContable_9.codigo                      AS CuentaContable_9_codigo                 	-- 10	.CuentaFondo.CuentaContable.codigo                              		VARCHAR(11)
				, CuentaContable_9.nombre                      AS CuentaContable_9_nombre                 	-- 11	.CuentaFondo.CuentaContable.nombre                              		VARCHAR(50)
				, EjercicioContable_12.id                      AS EjercicioContable_12_id                 	-- 12	.CuentaFondo.CuentaContable.EjercicioContable.id                		VARCHAR(36)
				, EjercicioContable_12.numero                  AS EjercicioContable_12_numero             	-- 13	.CuentaFondo.CuentaContable.EjercicioContable.numero            		INTEGER
				, EjercicioContable_12.apertura                AS EjercicioContable_12_apertura           	-- 14	.CuentaFondo.CuentaContable.EjercicioContable.apertura          		DATE
				, EjercicioContable_12.cierre                  AS EjercicioContable_12_cierre             	-- 15	.CuentaFondo.CuentaContable.EjercicioContable.cierre            		DATE
				, EjercicioContable_12.cerrado                 AS EjercicioContable_12_cerrado            	-- 16	.CuentaFondo.CuentaContable.EjercicioContable.cerrado           		BOOLEAN
				, EjercicioContable_12.cerradoModulos          AS EjercicioContable_12_cerradoModulos     	-- 17	.CuentaFondo.CuentaContable.EjercicioContable.cerradoModulos    		BOOLEAN
				, EjercicioContable_12.comentario              AS EjercicioContable_12_comentario         	-- 18	.CuentaFondo.CuentaContable.EjercicioContable.comentario        		VARCHAR(250)
				, CuentaContable_9.integra                     AS CuentaContable_9_integra                	-- 19	.CuentaFondo.CuentaContable.integra                             		VARCHAR(16)
				, CuentaContable_9.cuentaJerarquia             AS CuentaContable_9_cuentaJerarquia        	-- 20	.CuentaFondo.CuentaContable.cuentaJerarquia                     		VARCHAR(16)
				, CuentaContable_9.imputable                   AS CuentaContable_9_imputable              	-- 21	.CuentaFondo.CuentaContable.imputable                           		BOOLEAN
				, CuentaContable_9.ajustaPorInflacion          AS CuentaContable_9_ajustaPorInflacion     	-- 22	.CuentaFondo.CuentaContable.ajustaPorInflacion                  		BOOLEAN
				, CuentaContableEstado_23.id                   AS CuentaContableEstado_23_id              	-- 23	.CuentaFondo.CuentaContable.CuentaContableEstado.id             		VARCHAR(36)
				, CuentaContableEstado_23.numero               AS CuentaContableEstado_23_numero          	-- 24	.CuentaFondo.CuentaContable.CuentaContableEstado.numero         		INTEGER
				, CuentaContableEstado_23.nombre               AS CuentaContableEstado_23_nombre          	-- 25	.CuentaFondo.CuentaContable.CuentaContableEstado.nombre         		VARCHAR(50)
				, CuentaContable_9.cuentaConApropiacion        AS CuentaContable_9_cuentaConApropiacion   	-- 26	.CuentaFondo.CuentaContable.cuentaConApropiacion                		BOOLEAN
				, CentroCostoContable_27.id                    AS CentroCostoContable_27_id               	-- 27	.CuentaFondo.CuentaContable.CentroCostoContable.id              		VARCHAR(36)
				, CentroCostoContable_27.numero                AS CentroCostoContable_27_numero           	-- 28	.CuentaFondo.CuentaContable.CentroCostoContable.numero          		INTEGER
				, CentroCostoContable_27.nombre                AS CentroCostoContable_27_nombre           	-- 29	.CuentaFondo.CuentaContable.CentroCostoContable.nombre          		VARCHAR(50)
				, CentroCostoContable_27.abreviatura           AS CentroCostoContable_27_abreviatura      	-- 30	.CuentaFondo.CuentaContable.CentroCostoContable.abreviatura     		VARCHAR(5)
				, CentroCostoContable_27.ejercicioContable     AS CentroCostoContable_27_ejercicioContable	-- 31	.CuentaFondo.CuentaContable.CentroCostoContable.ejercicioContable		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_9.cuentaAgrupadora            AS CuentaContable_9_cuentaAgrupadora       	-- 32	.CuentaFondo.CuentaContable.cuentaAgrupadora                    		VARCHAR(50)
				, CuentaContable_9.porcentaje                  AS CuentaContable_9_porcentaje             	-- 33	.CuentaFondo.CuentaContable.porcentaje                          		DECIMAL(6,3)
				, PuntoEquilibrio_34.id                        AS PuntoEquilibrio_34_id                   	-- 34	.CuentaFondo.CuentaContable.PuntoEquilibrio.id                  		VARCHAR(36)
				, PuntoEquilibrio_34.numero                    AS PuntoEquilibrio_34_numero               	-- 35	.CuentaFondo.CuentaContable.PuntoEquilibrio.numero              		INTEGER
				, PuntoEquilibrio_34.nombre                    AS PuntoEquilibrio_34_nombre               	-- 36	.CuentaFondo.CuentaContable.PuntoEquilibrio.nombre              		VARCHAR(50)
				, PuntoEquilibrio_34.tipoPuntoEquilibrio       AS PuntoEquilibrio_34_tipoPuntoEquilibrio  	-- 37	.CuentaFondo.CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio 		VARCHAR(36)	TipoPuntoEquilibrio.id
				, PuntoEquilibrio_34.ejercicioContable         AS PuntoEquilibrio_34_ejercicioContable    	-- 38	.CuentaFondo.CuentaContable.PuntoEquilibrio.ejercicioContable   		VARCHAR(36)	EjercicioContable.id
				, CostoVenta_39.id                             AS CostoVenta_39_id                        	-- 39	.CuentaFondo.CuentaContable.CostoVenta.id                       		VARCHAR(36)
				, CostoVenta_39.numero                         AS CostoVenta_39_numero                    	-- 40	.CuentaFondo.CuentaContable.CostoVenta.numero                   		INTEGER
				, CostoVenta_39.nombre                         AS CostoVenta_39_nombre                    	-- 41	.CuentaFondo.CuentaContable.CostoVenta.nombre                   		VARCHAR(50)
				, SeguridadPuerta_42.id                        AS SeguridadPuerta_42_id                   	-- 42	.CuentaFondo.CuentaContable.SeguridadPuerta.id                  		VARCHAR(36)
				, SeguridadPuerta_42.numero                    AS SeguridadPuerta_42_numero               	-- 43	.CuentaFondo.CuentaContable.SeguridadPuerta.numero              		INTEGER
				, SeguridadPuerta_42.nombre                    AS SeguridadPuerta_42_nombre               	-- 44	.CuentaFondo.CuentaContable.SeguridadPuerta.nombre              		VARCHAR(50)
				, SeguridadPuerta_42.equate                    AS SeguridadPuerta_42_equate               	-- 45	.CuentaFondo.CuentaContable.SeguridadPuerta.equate              		VARCHAR(30)
				, SeguridadPuerta_42.seguridadModulo           AS SeguridadPuerta_42_seguridadModulo      	-- 46	.CuentaFondo.CuentaContable.SeguridadPuerta.seguridadModulo     		VARCHAR(36)	SeguridadModulo.id
				, CuentaFondoGrupo_47.id                       AS CuentaFondoGrupo_47_id                  	-- 47	.CuentaFondo.CuentaFondoGrupo.id                                		VARCHAR(36)
				, CuentaFondoGrupo_47.numero                   AS CuentaFondoGrupo_47_numero              	-- 48	.CuentaFondo.CuentaFondoGrupo.numero                            		INTEGER
				, CuentaFondoGrupo_47.nombre                   AS CuentaFondoGrupo_47_nombre              	-- 49	.CuentaFondo.CuentaFondoGrupo.nombre                            		VARCHAR(50)
				, CuentaFondoRubro_50.id                       AS CuentaFondoRubro_50_id                  	-- 50	.CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.id               		VARCHAR(36)
				, CuentaFondoRubro_50.numero                   AS CuentaFondoRubro_50_numero              	-- 51	.CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.numero           		INTEGER
				, CuentaFondoRubro_50.nombre                   AS CuentaFondoRubro_50_nombre              	-- 52	.CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.nombre           		VARCHAR(50)
				, CuentaFondoTipo_53.id                        AS CuentaFondoTipo_53_id                   	-- 53	.CuentaFondo.CuentaFondoTipo.id                                 		VARCHAR(36)
				, CuentaFondoTipo_53.numero                    AS CuentaFondoTipo_53_numero               	-- 54	.CuentaFondo.CuentaFondoTipo.numero                             		INTEGER
				, CuentaFondoTipo_53.nombre                    AS CuentaFondoTipo_53_nombre               	-- 55	.CuentaFondo.CuentaFondoTipo.nombre                             		VARCHAR(50)
				, CuentaFondo_6.obsoleto                       AS CuentaFondo_6_obsoleto                  	-- 56	.CuentaFondo.obsoleto                                           		BOOLEAN
				, CuentaFondo_6.noImprimeCaja                  AS CuentaFondo_6_noImprimeCaja             	-- 57	.CuentaFondo.noImprimeCaja                                      		BOOLEAN
				, CuentaFondo_6.ventas                         AS CuentaFondo_6_ventas                    	-- 58	.CuentaFondo.ventas                                             		BOOLEAN
				, CuentaFondo_6.fondos                         AS CuentaFondo_6_fondos                    	-- 59	.CuentaFondo.fondos                                             		BOOLEAN
				, CuentaFondo_6.compras                        AS CuentaFondo_6_compras                   	-- 60	.CuentaFondo.compras                                            		BOOLEAN
				, Moneda_61.id                                 AS Moneda_61_id                            	-- 61	.CuentaFondo.Moneda.id                                          		VARCHAR(36)
				, Moneda_61.numero                             AS Moneda_61_numero                        	-- 62	.CuentaFondo.Moneda.numero                                      		INTEGER
				, Moneda_61.nombre                             AS Moneda_61_nombre                        	-- 63	.CuentaFondo.Moneda.nombre                                      		VARCHAR(50)
				, Moneda_61.abreviatura                        AS Moneda_61_abreviatura                   	-- 64	.CuentaFondo.Moneda.abreviatura                                 		VARCHAR(5)
				, Moneda_61.cotizacion                         AS Moneda_61_cotizacion                    	-- 65	.CuentaFondo.Moneda.cotizacion                                  		DECIMAL(13,5)
				, Moneda_61.cotizacionFecha                    AS Moneda_61_cotizacionFecha               	-- 66	.CuentaFondo.Moneda.cotizacionFecha                             		TIMESTAMP
				, Moneda_61.controlActualizacion               AS Moneda_61_controlActualizacion          	-- 67	.CuentaFondo.Moneda.controlActualizacion                        		BOOLEAN
				, MonedaAFIP_68.id                             AS MonedaAFIP_68_id                        	-- 68	.CuentaFondo.Moneda.MonedaAFIP.id                               		VARCHAR(36)
				, MonedaAFIP_68.codigo                         AS MonedaAFIP_68_codigo                    	-- 69	.CuentaFondo.Moneda.MonedaAFIP.codigo                           		VARCHAR(3)
				, MonedaAFIP_68.nombre                         AS MonedaAFIP_68_nombre                    	-- 70	.CuentaFondo.Moneda.MonedaAFIP.nombre                           		VARCHAR(50)
				, Caja_71.id                                   AS Caja_71_id                              	-- 71	.CuentaFondo.Caja.id                                            		VARCHAR(36)
				, Caja_71.numero                               AS Caja_71_numero                          	-- 72	.CuentaFondo.Caja.numero                                        		INTEGER
				, Caja_71.nombre                               AS Caja_71_nombre                          	-- 73	.CuentaFondo.Caja.nombre                                        		VARCHAR(50)
				, SeguridadPuerta_74.id                        AS SeguridadPuerta_74_id                   	-- 74	.CuentaFondo.Caja.SeguridadPuerta.id                            		VARCHAR(36)
				, SeguridadPuerta_74.numero                    AS SeguridadPuerta_74_numero               	-- 75	.CuentaFondo.Caja.SeguridadPuerta.numero                        		INTEGER
				, SeguridadPuerta_74.nombre                    AS SeguridadPuerta_74_nombre               	-- 76	.CuentaFondo.Caja.SeguridadPuerta.nombre                        		VARCHAR(50)
				, SeguridadPuerta_74.equate                    AS SeguridadPuerta_74_equate               	-- 77	.CuentaFondo.Caja.SeguridadPuerta.equate                        		VARCHAR(30)
				, SeguridadPuerta_74.seguridadModulo           AS SeguridadPuerta_74_seguridadModulo      	-- 78	.CuentaFondo.Caja.SeguridadPuerta.seguridadModulo               		VARCHAR(36)	SeguridadModulo.id
				, CuentaFondo_6.rechazados                     AS CuentaFondo_6_rechazados                	-- 79	.CuentaFondo.rechazados                                         		BOOLEAN
				, CuentaFondo_6.conciliacion                   AS CuentaFondo_6_conciliacion              	-- 80	.CuentaFondo.conciliacion                                       		BOOLEAN
				, CuentaFondoTipoBanco_81.id                   AS CuentaFondoTipoBanco_81_id              	-- 81	.CuentaFondo.CuentaFondoTipoBanco.id                            		VARCHAR(36)
				, CuentaFondoTipoBanco_81.numero               AS CuentaFondoTipoBanco_81_numero          	-- 82	.CuentaFondo.CuentaFondoTipoBanco.numero                        		INTEGER
				, CuentaFondoTipoBanco_81.nombre               AS CuentaFondoTipoBanco_81_nombre          	-- 83	.CuentaFondo.CuentaFondoTipoBanco.nombre                        		VARCHAR(50)
				, Banco_84.id                                  AS Banco_84_id                             	-- 84	.CuentaFondo.Banco.id                                           		VARCHAR(36)
				, Banco_84.numero                              AS Banco_84_numero                         	-- 85	.CuentaFondo.Banco.numero                                       		INTEGER
				, Banco_84.nombre                              AS Banco_84_nombre                         	-- 86	.CuentaFondo.Banco.nombre                                       		VARCHAR(50)
				, Banco_84.cuit                                AS Banco_84_cuit                           	-- 87	.CuentaFondo.Banco.cuit                                         		BIGINT
				, Banco_84.bloqueado                           AS Banco_84_bloqueado                      	-- 88	.CuentaFondo.Banco.bloqueado                                    		BOOLEAN
				, Banco_84.hoja                                AS Banco_84_hoja                           	-- 89	.CuentaFondo.Banco.hoja                                         		INTEGER
				, Banco_84.primeraFila                         AS Banco_84_primeraFila                    	-- 90	.CuentaFondo.Banco.primeraFila                                  		INTEGER
				, Banco_84.ultimaFila                          AS Banco_84_ultimaFila                     	-- 91	.CuentaFondo.Banco.ultimaFila                                   		INTEGER
				, Banco_84.fecha                               AS Banco_84_fecha                          	-- 92	.CuentaFondo.Banco.fecha                                        		VARCHAR(3)
				, Banco_84.descripcion                         AS Banco_84_descripcion                    	-- 93	.CuentaFondo.Banco.descripcion                                  		VARCHAR(3)
				, Banco_84.referencia1                         AS Banco_84_referencia1                    	-- 94	.CuentaFondo.Banco.referencia1                                  		VARCHAR(3)
				, Banco_84.importe                             AS Banco_84_importe                        	-- 95	.CuentaFondo.Banco.importe                                      		VARCHAR(3)
				, Banco_84.referencia2                         AS Banco_84_referencia2                    	-- 96	.CuentaFondo.Banco.referencia2                                  		VARCHAR(3)
				, Banco_84.saldo                               AS Banco_84_saldo                          	-- 97	.CuentaFondo.Banco.saldo                                        		VARCHAR(3)
				, CuentaFondo_6.cuentaBancaria                 AS CuentaFondo_6_cuentaBancaria            	-- 98	.CuentaFondo.cuentaBancaria                                     		VARCHAR(22)
				, CuentaFondo_6.cbu                            AS CuentaFondo_6_cbu                       	-- 99	.CuentaFondo.cbu                                                		VARCHAR(22)
				, CuentaFondo_6.limiteDescubierto              AS CuentaFondo_6_limiteDescubierto         	-- 100	.CuentaFondo.limiteDescubierto                                  		DECIMAL(13,5)
				, CuentaFondo_6.cuentaFondoCaucion             AS CuentaFondo_6_cuentaFondoCaucion        	-- 101	.CuentaFondo.cuentaFondoCaucion                                 		VARCHAR(50)
				, CuentaFondo_6.cuentaFondoDiferidos           AS CuentaFondo_6_cuentaFondoDiferidos      	-- 102	.CuentaFondo.cuentaFondoDiferidos                               		VARCHAR(50)
				, CuentaFondo_6.formato                        AS CuentaFondo_6_formato                   	-- 103	.CuentaFondo.formato                                            		VARCHAR(50)
				, CuentaFondoBancoCopia_104.id                 AS CuentaFondoBancoCopia_104_id            	-- 104	.CuentaFondo.CuentaFondoBancoCopia.id                           		VARCHAR(36)
				, CuentaFondoBancoCopia_104.numero             AS CuentaFondoBancoCopia_104_numero        	-- 105	.CuentaFondo.CuentaFondoBancoCopia.numero                       		INTEGER
				, CuentaFondoBancoCopia_104.nombre             AS CuentaFondoBancoCopia_104_nombre        	-- 106	.CuentaFondo.CuentaFondoBancoCopia.nombre                       		VARCHAR(50)
				, CuentaFondo_6.limiteOperacionIndividual      AS CuentaFondo_6_limiteOperacionIndividual 	-- 107	.CuentaFondo.limiteOperacionIndividual                          		DECIMAL(13,5)
				, SeguridadPuerta_108.id                       AS SeguridadPuerta_108_id                  	-- 108	.CuentaFondo.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_108.numero                   AS SeguridadPuerta_108_numero              	-- 109	.CuentaFondo.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_108.nombre                   AS SeguridadPuerta_108_nombre              	-- 110	.CuentaFondo.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_108.equate                   AS SeguridadPuerta_108_equate              	-- 111	.CuentaFondo.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_112.id                       AS SeguridadModulo_112_id                  	-- 112	.CuentaFondo.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_112.numero                   AS SeguridadModulo_112_numero              	-- 113	.CuentaFondo.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_112.nombre                   AS SeguridadModulo_112_nombre              	-- 114	.CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)
				, SeguridadPuerta_115.id                       AS SeguridadPuerta_115_id                  	-- 115	.CuentaFondo.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_115.numero                   AS SeguridadPuerta_115_numero              	-- 116	.CuentaFondo.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_115.nombre                   AS SeguridadPuerta_115_nombre              	-- 117	.CuentaFondo.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_115.equate                   AS SeguridadPuerta_115_equate              	-- 118	.CuentaFondo.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_119.id                       AS SeguridadModulo_119_id                  	-- 119	.CuentaFondo.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_119.numero                   AS SeguridadModulo_119_numero              	-- 120	.CuentaFondo.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_119.nombre                   AS SeguridadModulo_119_nombre              	-- 121	.CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)
				, SeguridadPuerta_122.id                       AS SeguridadPuerta_122_id                  	-- 122	.CuentaFondo.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_122.numero                   AS SeguridadPuerta_122_numero              	-- 123	.CuentaFondo.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_122.nombre                   AS SeguridadPuerta_122_nombre              	-- 124	.CuentaFondo.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_122.equate                   AS SeguridadPuerta_122_equate              	-- 125	.CuentaFondo.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_126.id                       AS SeguridadModulo_126_id                  	-- 126	.CuentaFondo.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_126.numero                   AS SeguridadModulo_126_numero              	-- 127	.CuentaFondo.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_126.nombre                   AS SeguridadModulo_126_nombre              	-- 128	.CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)

		FROM	massoftware.ComprobanteFondoModeloItem
			LEFT JOIN massoftware.ComprobanteFondoModelo AS ComprobanteFondoModelo_3             ON ComprobanteFondoModeloItem.comprobanteFondoModelo = ComprobanteFondoModelo_3.id 	-- 3 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaFondo AS CuentaFondo_6                        ON ComprobanteFondoModeloItem.cuentaFondo = CuentaFondo_6.id 	-- 6 LEFT LEVEL: 1
				LEFT JOIN massoftware.CuentaContable AS CuentaContable_9                    ON CuentaFondo_6.cuentaContable = CuentaContable_9.id 	-- 9 LEFT LEVEL: 2
					LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_12                ON CuentaContable_9.ejercicioContable = EjercicioContable_12.id 	-- 12 LEFT LEVEL: 3
					LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_23             ON CuentaContable_9.cuentaContableEstado = CuentaContableEstado_23.id 	-- 23 LEFT LEVEL: 3
					LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_27              ON CuentaContable_9.centroCostoContable = CentroCostoContable_27.id 	-- 27 LEFT LEVEL: 3
					LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_34                  ON CuentaContable_9.puntoEquilibrio = PuntoEquilibrio_34.id 	-- 34 LEFT LEVEL: 3
					LEFT JOIN massoftware.CostoVenta AS CostoVenta_39                       ON CuentaContable_9.costoVenta = CostoVenta_39.id 	-- 39 LEFT LEVEL: 3
					LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_42                  ON CuentaContable_9.seguridadPuerta = SeguridadPuerta_42.id 	-- 42 LEFT LEVEL: 3
				LEFT JOIN massoftware.CuentaFondoGrupo AS CuentaFondoGrupo_47                  ON CuentaFondo_6.cuentaFondoGrupo = CuentaFondoGrupo_47.id 	-- 47 LEFT LEVEL: 2
					LEFT JOIN massoftware.CuentaFondoRubro AS CuentaFondoRubro_50                 ON CuentaFondoGrupo_47.cuentaFondoRubro = CuentaFondoRubro_50.id 	-- 50 LEFT LEVEL: 3
				LEFT JOIN massoftware.CuentaFondoTipo AS CuentaFondoTipo_53                   ON CuentaFondo_6.cuentaFondoTipo = CuentaFondoTipo_53.id 	-- 53 LEFT LEVEL: 2
				LEFT JOIN massoftware.Moneda AS Moneda_61                            ON CuentaFondo_6.moneda = Moneda_61.id 	-- 61 LEFT LEVEL: 2
					LEFT JOIN massoftware.MonedaAFIP AS MonedaAFIP_68                       ON Moneda_61.monedaAFIP = MonedaAFIP_68.id 	-- 68 LEFT LEVEL: 3
				LEFT JOIN massoftware.Caja AS Caja_71                              ON CuentaFondo_6.caja = Caja_71.id 	-- 71 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_74                  ON Caja_71.seguridadPuerta = SeguridadPuerta_74.id 	-- 74 LEFT LEVEL: 3
				LEFT JOIN massoftware.CuentaFondoTipoBanco AS CuentaFondoTipoBanco_81              ON CuentaFondo_6.cuentaFondoTipoBanco = CuentaFondoTipoBanco_81.id 	-- 81 LEFT LEVEL: 2
				LEFT JOIN massoftware.Banco AS Banco_84                             ON CuentaFondo_6.banco = Banco_84.id 	-- 84 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaFondoBancoCopia AS CuentaFondoBancoCopia_104            ON CuentaFondo_6.cuentaFondoBancoCopia = CuentaFondoBancoCopia_104.id 	-- 104 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_108                  ON CuentaFondo_6.seguridadPuertaUso = SeguridadPuerta_108.id 	-- 108 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_112                  ON SeguridadPuerta_108.seguridadModulo = SeguridadModulo_112.id 	-- 112 LEFT LEVEL: 3
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_115                  ON CuentaFondo_6.seguridadPuertaConsulta = SeguridadPuerta_115.id 	-- 115 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_119                  ON SeguridadPuerta_115.seguridadModulo = SeguridadModulo_119.id 	-- 119 LEFT LEVEL: 3
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_122                  ON CuentaFondo_6.seguridadPuertaLimite = SeguridadPuerta_122.id 	-- 122 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_126                  ON SeguridadPuerta_122.seguridadModulo = SeguridadModulo_126.id 	-- 126 LEFT LEVEL: 3

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND cuentaFondoArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(cuentaFondoArg7)) > 0 THEN
		cuentaFondoArg7 = REPLACE(cuentaFondoArg7, '''', '''''');
		cuentaFondoArg7 = LOWER(TRIM(cuentaFondoArg7));
		cuentaFondoArg7 = TRANSLATE(cuentaFondoArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(cuentaFondoArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(ComprobanteFondoModeloItem.cuentaFondo),
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

DROP FUNCTION IF EXISTS massoftware.f_ComprobanteFondoModeloItemById_3 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ComprobanteFondoModeloItemById_3 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_ComprobanteFondoModeloItem_3 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_ComprobanteFondoModeloItem_3 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_ComprobanteFondoModeloItem_3 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_ComprobanteFondoModeloItemById_3 ('xxx'); 