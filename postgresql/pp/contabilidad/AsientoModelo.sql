
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoModelo                                                                                          //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoModelo



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.AsientoModelo CASCADE;

CREATE TABLE massoftware.AsientoModelo
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº asiento
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT AsientoModelo_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Ejercicio
	ejercicioContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.EjercicioContable (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_AsientoModelo_nombre ON massoftware.AsientoModelo (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatAsientoModelo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatAsientoModelo() RETURNS TRIGGER AS $formatAsientoModelo$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.ejercicioContable := massoftware.white_is_null(NEW.ejercicioContable);

	RETURN NEW;
END;
$formatAsientoModelo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatAsientoModelo ON massoftware.AsientoModelo CASCADE;

CREATE TRIGGER tgFormatAsientoModelo BEFORE INSERT OR UPDATE
	ON massoftware.AsientoModelo FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatAsientoModelo();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.AsientoModelo;

-- SELECT * FROM massoftware.AsientoModelo LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.AsientoModelo;

-- SELECT * FROM massoftware.AsientoModelo WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_AsientoModelo_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_AsientoModelo_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.AsientoModelo
	WHERE	(numeroArg IS NULL OR AsientoModelo.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_AsientoModelo_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_AsientoModelo_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_AsientoModelo_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.AsientoModelo
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(AsientoModelo.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_AsientoModelo_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_AsientoModelo_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_AsientoModelo_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.AsientoModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_AsientoModelo_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_AsientoModeloById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_AsientoModeloById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.AsientoModelo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoModelo.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.AsientoModelo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoModelo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoModelo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoModelo.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_AsientoModeloById('xxx');

-- SELECT * FROM massoftware.d_AsientoModeloById((SELECT AsientoModelo.id FROM massoftware.AsientoModelo LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_AsientoModelo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, ejercicioContableArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_AsientoModelo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, ejercicioContableArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.AsientoModelo(id, numero, nombre, ejercicioContable) VALUES (idArg, numeroArg, nombreArg, ejercicioContableArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoModelo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoModelo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_AsientoModelo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_AsientoModelo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, ejercicioContableArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_AsientoModelo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, ejercicioContableArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.AsientoModelo SET 
		  numero = numeroArg
		, nombre = nombreArg
		, ejercicioContable = ejercicioContableArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoModelo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoModelo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoModelo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_AsientoModelo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
);

*/

DROP TYPE IF EXISTS massoftware.t_AsientoModelo_1 CASCADE;

CREATE TYPE massoftware.t_AsientoModelo_1 AS (

	  AsientoModelo_id                  	VARCHAR(36) 		-- 0	AsientoModelo.id
	, AsientoModelo_numero              	INTEGER     		-- 1	AsientoModelo.numero
	, AsientoModelo_nombre              	VARCHAR(50) 		-- 2	AsientoModelo.nombre
	, EjercicioContable_3_id            	VARCHAR(36) 		-- 3	AsientoModelo.EjercicioContable.id
	, EjercicioContable_3_numero        	INTEGER     		-- 4	AsientoModelo.EjercicioContable.numero
	, EjercicioContable_3_apertura      	DATE        		-- 5	AsientoModelo.EjercicioContable.apertura
	, EjercicioContable_3_cierre        	DATE        		-- 6	AsientoModelo.EjercicioContable.cierre
	, EjercicioContable_3_cerrado       	BOOLEAN     		-- 7	AsientoModelo.EjercicioContable.cerrado
	, EjercicioContable_3_cerradoModulos	BOOLEAN     		-- 8	AsientoModelo.EjercicioContable.cerradoModulos
	, EjercicioContable_3_comentario    	VARCHAR(250)		-- 9	AsientoModelo.EjercicioContable.comentario

);

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