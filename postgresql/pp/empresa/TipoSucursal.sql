
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoSucursal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoSucursal



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.TipoSucursal CASCADE;

CREATE TABLE massoftware.TipoSucursal
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº tipo de sucursal
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT TipoSucursal_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_TipoSucursal_nombre ON massoftware.TipoSucursal (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatTipoSucursal() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatTipoSucursal() RETURNS TRIGGER AS $formatTipoSucursal$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatTipoSucursal$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTipoSucursal ON massoftware.TipoSucursal CASCADE;

CREATE TRIGGER tgFormatTipoSucursal BEFORE INSERT OR UPDATE
	ON massoftware.TipoSucursal FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatTipoSucursal();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.TipoSucursal;

-- SELECT * FROM massoftware.TipoSucursal LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.TipoSucursal;

-- SELECT * FROM massoftware.TipoSucursal WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_TipoSucursal_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_TipoSucursal_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.TipoSucursal
	WHERE	(numeroArg IS NULL OR TipoSucursal.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_TipoSucursal_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_TipoSucursal_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_TipoSucursal_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.TipoSucursal
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(TipoSucursal.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_TipoSucursal_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TipoSucursal_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TipoSucursal_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.TipoSucursal;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TipoSucursal_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_TipoSucursalById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_TipoSucursalById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.TipoSucursal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoSucursal.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.TipoSucursal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoSucursal.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TipoSucursal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoSucursal.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_TipoSucursalById('xxx');

-- SELECT * FROM massoftware.d_TipoSucursalById((SELECT TipoSucursal.id FROM massoftware.TipoSucursal LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_TipoSucursal(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_TipoSucursal(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.TipoSucursal(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.TipoSucursal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoSucursal.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_TipoSucursal(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_TipoSucursal(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_TipoSucursal(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.TipoSucursal SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoSucursal.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TipoSucursal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoSucursal.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_TipoSucursal(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/

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