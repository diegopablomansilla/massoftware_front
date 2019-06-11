
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Zona                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Zona



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Zona CASCADE;

CREATE TABLE massoftware.Zona
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Código
	codigo VARCHAR(3) NOT NULL, 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Bonificación
	bonificacion DECIMAL(13,5) CONSTRAINT Zona_bonificacion_chk CHECK ( bonificacion >= 0 AND bonificacion <= 99999.9999  ), 
	
	-- Recargo
	recargo DECIMAL(13,5) CONSTRAINT Zona_recargo_chk CHECK ( recargo >= 0 AND recargo <= 99999.9999  )
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Zona_codigo ON massoftware.Zona (TRANSLATE(LOWER(TRIM(codigo))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_Zona_nombre ON massoftware.Zona (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatZona() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatZona() RETURNS TRIGGER AS $formatZona$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.codigo := massoftware.white_is_null(NEW.codigo);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatZona$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatZona ON massoftware.Zona CASCADE;

CREATE TRIGGER tgFormatZona BEFORE INSERT OR UPDATE
	ON massoftware.Zona FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatZona();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Zona;

-- SELECT * FROM massoftware.Zona LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Zona;

-- SELECT * FROM massoftware.Zona WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Zona_codigo(codigoArg VARCHAR(3)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Zona_codigo(codigoArg VARCHAR(3)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Zona
	WHERE	(codigoArg IS NULL OR (CHAR_LENGTH(TRIM(codigoArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Zona.codigo)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(codigoArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Zona_codigo(null::VARCHAR(3));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Zona_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Zona_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Zona
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Zona.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Zona_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Zona_bonificacion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Zona_bonificacion() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(bonificacion),0) + 1)::DECIMAL(13,5) FROM massoftware.Zona;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Zona_bonificacion();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Zona_recargo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Zona_recargo() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(recargo),0) + 1)::DECIMAL(13,5) FROM massoftware.Zona;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Zona_recargo();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_ZonaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_ZonaById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.Zona WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Zona.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.Zona WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Zona.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Zona WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Zona.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_ZonaById('xxx');

-- SELECT * FROM massoftware.d_ZonaById((SELECT Zona.id FROM massoftware.Zona LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Zona(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
		, bonificacionArg DECIMAL(13,5)
		, recargoArg DECIMAL(13,5)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Zona(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
		, bonificacionArg DECIMAL(13,5)
		, recargoArg DECIMAL(13,5)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Zona(id, codigo, nombre, bonificacion, recargo) VALUES (idArg, codigoArg, nombreArg, bonificacionArg, recargoArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Zona WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Zona.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Zona(
		null::VARCHAR(36)
		, null::VARCHAR(3)
		, null::VARCHAR(50)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Zona(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
		, bonificacionArg DECIMAL(13,5)
		, recargoArg DECIMAL(13,5)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Zona(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
		, bonificacionArg DECIMAL(13,5)
		, recargoArg DECIMAL(13,5)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Zona SET 
		  codigo = codigoArg
		, nombre = nombreArg
		, bonificacion = bonificacionArg
		, recargo = recargoArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Zona.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Zona WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Zona.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Zona(
		null::VARCHAR(36)
		, null::VARCHAR(3)
		, null::VARCHAR(50)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
);

*/

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