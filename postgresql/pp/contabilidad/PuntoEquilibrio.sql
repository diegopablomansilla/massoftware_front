
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: PuntoEquilibrio                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.PuntoEquilibrio



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.PuntoEquilibrio CASCADE;

CREATE TABLE massoftware.PuntoEquilibrio
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº cc
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT PuntoEquilibrio_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Tipo
	tipoPuntoEquilibrio VARCHAR(36)  NOT NULL  REFERENCES massoftware.TipoPuntoEquilibrio (id), 
	
	-- Ejercicio
	ejercicioContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.EjercicioContable (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_PuntoEquilibrio_nombre ON massoftware.PuntoEquilibrio (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatPuntoEquilibrio() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatPuntoEquilibrio() RETURNS TRIGGER AS $formatPuntoEquilibrio$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.tipoPuntoEquilibrio := massoftware.white_is_null(NEW.tipoPuntoEquilibrio);
	 NEW.ejercicioContable := massoftware.white_is_null(NEW.ejercicioContable);

	RETURN NEW;
END;
$formatPuntoEquilibrio$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatPuntoEquilibrio ON massoftware.PuntoEquilibrio CASCADE;

CREATE TRIGGER tgFormatPuntoEquilibrio BEFORE INSERT OR UPDATE
	ON massoftware.PuntoEquilibrio FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatPuntoEquilibrio();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.PuntoEquilibrio;

-- SELECT * FROM massoftware.PuntoEquilibrio LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.PuntoEquilibrio;

-- SELECT * FROM massoftware.PuntoEquilibrio WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_PuntoEquilibrio_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_PuntoEquilibrio_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.PuntoEquilibrio
	WHERE	(numeroArg IS NULL OR PuntoEquilibrio.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_PuntoEquilibrio_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_PuntoEquilibrio_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_PuntoEquilibrio_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.PuntoEquilibrio
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(PuntoEquilibrio.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_PuntoEquilibrio_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_PuntoEquilibrio_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_PuntoEquilibrio_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.PuntoEquilibrio;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_PuntoEquilibrio_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_PuntoEquilibrioById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_PuntoEquilibrioById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.PuntoEquilibrio WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND PuntoEquilibrio.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.PuntoEquilibrio WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND PuntoEquilibrio.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.PuntoEquilibrio WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND PuntoEquilibrio.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_PuntoEquilibrioById('xxx');

-- SELECT * FROM massoftware.d_PuntoEquilibrioById((SELECT PuntoEquilibrio.id FROM massoftware.PuntoEquilibrio LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_PuntoEquilibrio(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, tipoPuntoEquilibrioArg VARCHAR(36)
		, ejercicioContableArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_PuntoEquilibrio(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, tipoPuntoEquilibrioArg VARCHAR(36)
		, ejercicioContableArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.PuntoEquilibrio(id, numero, nombre, tipoPuntoEquilibrio, ejercicioContable) VALUES (idArg, numeroArg, nombreArg, tipoPuntoEquilibrioArg, ejercicioContableArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.PuntoEquilibrio WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND PuntoEquilibrio.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_PuntoEquilibrio(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_PuntoEquilibrio(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, tipoPuntoEquilibrioArg VARCHAR(36)
		, ejercicioContableArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_PuntoEquilibrio(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, tipoPuntoEquilibrioArg VARCHAR(36)
		, ejercicioContableArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.PuntoEquilibrio SET 
		  numero = numeroArg
		, nombre = nombreArg
		, tipoPuntoEquilibrio = tipoPuntoEquilibrioArg
		, ejercicioContable = ejercicioContableArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND PuntoEquilibrio.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.PuntoEquilibrio WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND PuntoEquilibrio.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_PuntoEquilibrio(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/

DROP TYPE IF EXISTS massoftware.t_PuntoEquilibrio_1 CASCADE;

CREATE TYPE massoftware.t_PuntoEquilibrio_1 AS (

	  PuntoEquilibrio_id                	VARCHAR(36) 		-- 0	PuntoEquilibrio.id
	, PuntoEquilibrio_numero            	INTEGER     		-- 1	PuntoEquilibrio.numero
	, PuntoEquilibrio_nombre            	VARCHAR(50) 		-- 2	PuntoEquilibrio.nombre
	, TipoPuntoEquilibrio_3_id          	VARCHAR(36) 		-- 3	PuntoEquilibrio.TipoPuntoEquilibrio.id
	, TipoPuntoEquilibrio_3_numero      	INTEGER     		-- 4	PuntoEquilibrio.TipoPuntoEquilibrio.numero
	, TipoPuntoEquilibrio_3_nombre      	VARCHAR(50) 		-- 5	PuntoEquilibrio.TipoPuntoEquilibrio.nombre
	, EjercicioContable_6_id            	VARCHAR(36) 		-- 6	PuntoEquilibrio.EjercicioContable.id
	, EjercicioContable_6_numero        	INTEGER     		-- 7	PuntoEquilibrio.EjercicioContable.numero
	, EjercicioContable_6_apertura      	DATE        		-- 8	PuntoEquilibrio.EjercicioContable.apertura
	, EjercicioContable_6_cierre        	DATE        		-- 9	PuntoEquilibrio.EjercicioContable.cierre
	, EjercicioContable_6_cerrado       	BOOLEAN     		-- 10	PuntoEquilibrio.EjercicioContable.cerrado
	, EjercicioContable_6_cerradoModulos	BOOLEAN     		-- 11	PuntoEquilibrio.EjercicioContable.cerradoModulos
	, EjercicioContable_6_comentario    	VARCHAR(250)		-- 12	PuntoEquilibrio.EjercicioContable.comentario

);

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