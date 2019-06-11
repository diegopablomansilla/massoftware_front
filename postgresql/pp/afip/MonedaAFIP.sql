
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MonedaAFIP                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MonedaAFIP



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.MonedaAFIP CASCADE;

CREATE TABLE massoftware.MonedaAFIP
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Código
	codigo VARCHAR(3) NOT NULL, 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_MonedaAFIP_codigo ON massoftware.MonedaAFIP (TRANSLATE(LOWER(TRIM(codigo))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_MonedaAFIP_nombre ON massoftware.MonedaAFIP (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatMonedaAFIP() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatMonedaAFIP() RETURNS TRIGGER AS $formatMonedaAFIP$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.codigo := massoftware.white_is_null(NEW.codigo);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatMonedaAFIP$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatMonedaAFIP ON massoftware.MonedaAFIP CASCADE;

CREATE TRIGGER tgFormatMonedaAFIP BEFORE INSERT OR UPDATE
	ON massoftware.MonedaAFIP FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatMonedaAFIP();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.MonedaAFIP;

-- SELECT * FROM massoftware.MonedaAFIP LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.MonedaAFIP;

-- SELECT * FROM massoftware.MonedaAFIP WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_MonedaAFIP_codigo(codigoArg VARCHAR(3)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_MonedaAFIP_codigo(codigoArg VARCHAR(3)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.MonedaAFIP
	WHERE	(codigoArg IS NULL OR (CHAR_LENGTH(TRIM(codigoArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(MonedaAFIP.codigo)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(codigoArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_MonedaAFIP_codigo(null::VARCHAR(3));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_MonedaAFIP_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_MonedaAFIP_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.MonedaAFIP
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(MonedaAFIP.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_MonedaAFIP_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_MonedaAFIPById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_MonedaAFIPById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.MonedaAFIP WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaAFIP.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.MonedaAFIP WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaAFIP.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.MonedaAFIP WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaAFIP.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_MonedaAFIPById('xxx');

-- SELECT * FROM massoftware.d_MonedaAFIPById((SELECT MonedaAFIP.id FROM massoftware.MonedaAFIP LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_MonedaAFIP(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_MonedaAFIP(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.MonedaAFIP(id, codigo, nombre) VALUES (idArg, codigoArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.MonedaAFIP WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaAFIP.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_MonedaAFIP(
		null::VARCHAR(36)
		, null::VARCHAR(3)
		, null::VARCHAR(50)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_MonedaAFIP(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_MonedaAFIP(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.MonedaAFIP SET 
		  codigo = codigoArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaAFIP.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.MonedaAFIP WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaAFIP.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_MonedaAFIP(
		null::VARCHAR(36)
		, null::VARCHAR(3)
		, null::VARCHAR(50)
);

*/

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