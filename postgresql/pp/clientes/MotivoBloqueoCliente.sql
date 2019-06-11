
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoBloqueoCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoBloqueoCliente



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.MotivoBloqueoCliente CASCADE;

CREATE TABLE massoftware.MotivoBloqueoCliente
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº motivo
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT MotivoBloqueoCliente_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Clasificación de cliente
	clasificacionCliente VARCHAR(36)  NOT NULL  REFERENCES massoftware.ClasificacionCliente (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_MotivoBloqueoCliente_nombre ON massoftware.MotivoBloqueoCliente (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatMotivoBloqueoCliente() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatMotivoBloqueoCliente() RETURNS TRIGGER AS $formatMotivoBloqueoCliente$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.clasificacionCliente := massoftware.white_is_null(NEW.clasificacionCliente);

	RETURN NEW;
END;
$formatMotivoBloqueoCliente$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatMotivoBloqueoCliente ON massoftware.MotivoBloqueoCliente CASCADE;

CREATE TRIGGER tgFormatMotivoBloqueoCliente BEFORE INSERT OR UPDATE
	ON massoftware.MotivoBloqueoCliente FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatMotivoBloqueoCliente();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.MotivoBloqueoCliente;

-- SELECT * FROM massoftware.MotivoBloqueoCliente LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.MotivoBloqueoCliente;

-- SELECT * FROM massoftware.MotivoBloqueoCliente WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_MotivoBloqueoCliente_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_MotivoBloqueoCliente_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.MotivoBloqueoCliente
	WHERE	(numeroArg IS NULL OR MotivoBloqueoCliente.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_MotivoBloqueoCliente_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_MotivoBloqueoCliente_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_MotivoBloqueoCliente_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.MotivoBloqueoCliente
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(MotivoBloqueoCliente.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_MotivoBloqueoCliente_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_MotivoBloqueoCliente_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_MotivoBloqueoCliente_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.MotivoBloqueoCliente;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_MotivoBloqueoCliente_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_MotivoBloqueoClienteById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_MotivoBloqueoClienteById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.MotivoBloqueoCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.MotivoBloqueoCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.MotivoBloqueoCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_MotivoBloqueoClienteById('xxx');

-- SELECT * FROM massoftware.d_MotivoBloqueoClienteById((SELECT MotivoBloqueoCliente.id FROM massoftware.MotivoBloqueoCliente LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_MotivoBloqueoCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, clasificacionClienteArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_MotivoBloqueoCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, clasificacionClienteArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.MotivoBloqueoCliente(id, numero, nombre, clasificacionCliente) VALUES (idArg, numeroArg, nombreArg, clasificacionClienteArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.MotivoBloqueoCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_MotivoBloqueoCliente(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_MotivoBloqueoCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, clasificacionClienteArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_MotivoBloqueoCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, clasificacionClienteArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.MotivoBloqueoCliente SET 
		  numero = numeroArg
		, nombre = nombreArg
		, clasificacionCliente = clasificacionClienteArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.MotivoBloqueoCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_MotivoBloqueoCliente(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
);

*/

DROP TYPE IF EXISTS massoftware.t_MotivoBloqueoCliente_1 CASCADE;

CREATE TYPE massoftware.t_MotivoBloqueoCliente_1 AS (

	  MotivoBloqueoCliente_id      	VARCHAR(36)		-- 0	MotivoBloqueoCliente.id
	, MotivoBloqueoCliente_numero  	INTEGER    		-- 1	MotivoBloqueoCliente.numero
	, MotivoBloqueoCliente_nombre  	VARCHAR(50)		-- 2	MotivoBloqueoCliente.nombre
	, ClasificacionCliente_3_id    	VARCHAR(36)		-- 3	MotivoBloqueoCliente.ClasificacionCliente.id
	, ClasificacionCliente_3_numero	INTEGER    		-- 4	MotivoBloqueoCliente.ClasificacionCliente.numero
	, ClasificacionCliente_3_nombre	VARCHAR(50)		-- 5	MotivoBloqueoCliente.ClasificacionCliente.nombre
	, ClasificacionCliente_3_color 	INTEGER    		-- 6	MotivoBloqueoCliente.ClasificacionCliente.color

);

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