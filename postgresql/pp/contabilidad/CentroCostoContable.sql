
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CentroCostoContable                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CentroCostoContable



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.CentroCostoContable CASCADE;

CREATE TABLE massoftware.CentroCostoContable
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº cc
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT CentroCostoContable_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Abreviatura
	abreviatura VARCHAR(5) NOT NULL, 
	
	-- Ejercicio
	ejercicioContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.EjercicioContable (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_CentroCostoContable_nombre ON massoftware.CentroCostoContable (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_CentroCostoContable_abreviatura ON massoftware.CentroCostoContable (TRANSLATE(LOWER(TRIM(abreviatura))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCentroCostoContable() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCentroCostoContable() RETURNS TRIGGER AS $formatCentroCostoContable$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.abreviatura := massoftware.white_is_null(NEW.abreviatura);
	 NEW.ejercicioContable := massoftware.white_is_null(NEW.ejercicioContable);

	RETURN NEW;
END;
$formatCentroCostoContable$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCentroCostoContable ON massoftware.CentroCostoContable CASCADE;

CREATE TRIGGER tgFormatCentroCostoContable BEFORE INSERT OR UPDATE
	ON massoftware.CentroCostoContable FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatCentroCostoContable();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.CentroCostoContable;

-- SELECT * FROM massoftware.CentroCostoContable LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.CentroCostoContable;

-- SELECT * FROM massoftware.CentroCostoContable WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_CentroCostoContable_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_CentroCostoContable_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.CentroCostoContable
	WHERE	(numeroArg IS NULL OR CentroCostoContable.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_CentroCostoContable_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_CentroCostoContable_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_CentroCostoContable_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.CentroCostoContable
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(CentroCostoContable.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_CentroCostoContable_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_CentroCostoContable_abreviatura(abreviaturaArg VARCHAR(5)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_CentroCostoContable_abreviatura(abreviaturaArg VARCHAR(5)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.CentroCostoContable
	WHERE	(abreviaturaArg IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(CentroCostoContable.abreviatura)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(abreviaturaArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_CentroCostoContable_abreviatura(null::VARCHAR(5));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CentroCostoContable_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CentroCostoContable_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.CentroCostoContable;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CentroCostoContable_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_CentroCostoContableById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_CentroCostoContableById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.CentroCostoContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CentroCostoContable.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.CentroCostoContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CentroCostoContable.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CentroCostoContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CentroCostoContable.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_CentroCostoContableById('xxx');

-- SELECT * FROM massoftware.d_CentroCostoContableById((SELECT CentroCostoContable.id FROM massoftware.CentroCostoContable LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_CentroCostoContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, ejercicioContableArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_CentroCostoContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, ejercicioContableArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.CentroCostoContable(id, numero, nombre, abreviatura, ejercicioContable) VALUES (idArg, numeroArg, nombreArg, abreviaturaArg, ejercicioContableArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.CentroCostoContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CentroCostoContable.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_CentroCostoContable(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(5)
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_CentroCostoContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, ejercicioContableArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_CentroCostoContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, ejercicioContableArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.CentroCostoContable SET 
		  numero = numeroArg
		, nombre = nombreArg
		, abreviatura = abreviaturaArg
		, ejercicioContable = ejercicioContableArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CentroCostoContable.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CentroCostoContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CentroCostoContable.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_CentroCostoContable(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(5)
		, null::VARCHAR(36)
);

*/

DROP TYPE IF EXISTS massoftware.t_CentroCostoContable_1 CASCADE;

CREATE TYPE massoftware.t_CentroCostoContable_1 AS (

	  CentroCostoContable_id            	VARCHAR(36) 		-- 0	CentroCostoContable.id
	, CentroCostoContable_numero        	INTEGER     		-- 1	CentroCostoContable.numero
	, CentroCostoContable_nombre        	VARCHAR(50) 		-- 2	CentroCostoContable.nombre
	, CentroCostoContable_abreviatura   	VARCHAR(5)  		-- 3	CentroCostoContable.abreviatura
	, EjercicioContable_4_id            	VARCHAR(36) 		-- 4	CentroCostoContable.EjercicioContable.id
	, EjercicioContable_4_numero        	INTEGER     		-- 5	CentroCostoContable.EjercicioContable.numero
	, EjercicioContable_4_apertura      	DATE        		-- 6	CentroCostoContable.EjercicioContable.apertura
	, EjercicioContable_4_cierre        	DATE        		-- 7	CentroCostoContable.EjercicioContable.cierre
	, EjercicioContable_4_cerrado       	BOOLEAN     		-- 8	CentroCostoContable.EjercicioContable.cerrado
	, EjercicioContable_4_cerradoModulos	BOOLEAN     		-- 9	CentroCostoContable.EjercicioContable.cerradoModulos
	, EjercicioContable_4_comentario    	VARCHAR(250)		-- 10	CentroCostoContable.EjercicioContable.comentario

);

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