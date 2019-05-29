
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
	bonificacion DECIMAL(13, 5) CONSTRAINT Zona_bonificacion_chk CHECK ( bonificacion >= 0 AND bonificacion <= 99999.9999  ), 
	
	-- Recargo
	recargo DECIMAL(13, 5) CONSTRAINT Zona_recargo_chk CHECK ( recargo >= 0 AND recargo <= 99999.9999  )
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
		, bonificacionArg DECIMAL
		, recargoArg DECIMAL
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Zona(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
		, bonificacionArg DECIMAL
		, recargoArg DECIMAL
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
		, null::VARCHAR
		, null::VARCHAR
		, null::DECIMAL
		, null::DECIMAL
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Zona(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
		, bonificacionArg DECIMAL
		, recargoArg DECIMAL
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Zona(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
		, bonificacionArg DECIMAL
		, recargoArg DECIMAL
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
		, null::VARCHAR
		, null::VARCHAR
		, null::DECIMAL
		, null::DECIMAL
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Zona_codigo(codigoArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Zona_codigo(codigoArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.Zona
	WHERE	(codigoArg IS NULL OR (CHAR_LENGTH(TRIM(codigoArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Zona.codigo)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(codigoArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Zona_codigo(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Zona_nombre(nombreArg VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Zona_nombre(nombreArg VARCHAR) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN
	FROM	massoftware.Zona
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Zona.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_exists_Zona_nombre(null::VARCHAR);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Zona_bonificacion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Zona_bonificacion() RETURNS DECIMAL AS $$

	SELECT (COALESCE(MAX(bonificacion),0) + 1)::DECIMAL
	FROM	massoftware.Zona;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_Zona_bonificacion();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Zona_recargo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Zona_recargo() RETURNS DECIMAL AS $$

	SELECT (COALESCE(MAX(recargo),0) + 1)::DECIMAL
	FROM	massoftware.Zona;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_Zona_recargo();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ZonaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ZonaById(idArg VARCHAR(36)) RETURNS massoftware.Zona AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Zona.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_ZonaById('xxx');

-- SELECT * FROM massoftware.f_ZonaById((SELECT Zona.id FROM massoftware.Zona LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Zona(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 Zona_id VARCHAR(36)            	-- 0
		,Zona_codigo VARCHAR(3)         	-- 1
		,Zona_nombre VARCHAR(50)        	-- 2
		,Zona_bonificacion DECIMAL(13, 5)	-- 3
		,Zona_recargo DECIMAL(13, 5)    	-- 4
	) AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(Zona.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY Zona.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Zona(
		 null::VARCHAR -- Zona_codigoArg0
		, null::VARCHAR -- Zona_nombreWord0Arg1
		, null::VARCHAR -- Zona_nombreWord1Arg2
		, null::VARCHAR -- Zona_nombreWord2Arg3
		, null::VARCHAR -- Zona_nombreWord3Arg4
		, null::VARCHAR -- Zona_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Zona(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 Zona_id VARCHAR(36)            	-- 0
		,Zona_codigo VARCHAR(3)         	-- 1
		,Zona_nombre VARCHAR(50)        	-- 2
		,Zona_bonificacion DECIMAL(13, 5)	-- 3
		,Zona_recargo DECIMAL(13, 5)    	-- 4
	) AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(Zona.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY Zona.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Zona(
		100
		, 0
		, null::VARCHAR -- Zona_codigoArg0
		, null::VARCHAR -- Zona_nombreWord0Arg1
		, null::VARCHAR -- Zona_nombreWord1Arg2
		, null::VARCHAR -- Zona_nombreWord2Arg3
		, null::VARCHAR -- Zona_nombreWord3Arg4
		, null::VARCHAR -- Zona_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Zona_asc_Zona_Codigo(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona_asc_Zona_Codigo(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 Zona_id VARCHAR(36)            	-- 0
		,Zona_codigo VARCHAR(3)         	-- 1
		,Zona_nombre VARCHAR(50)        	-- 2
		,Zona_bonificacion DECIMAL(13, 5)	-- 3
		,Zona_recargo DECIMAL(13, 5)    	-- 4
	) AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(Zona.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY Zona.codigo ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Zona_asc_Zona_Codigo(
		100
		, 0
		, null::VARCHAR -- Zona_codigoArg0
		, null::VARCHAR -- Zona_nombreWord0Arg1
		, null::VARCHAR -- Zona_nombreWord1Arg2
		, null::VARCHAR -- Zona_nombreWord2Arg3
		, null::VARCHAR -- Zona_nombreWord3Arg4
		, null::VARCHAR -- Zona_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Zona_des_Zona_Codigo(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona_des_Zona_Codigo(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 Zona_id VARCHAR(36)            	-- 0
		,Zona_codigo VARCHAR(3)         	-- 1
		,Zona_nombre VARCHAR(50)        	-- 2
		,Zona_bonificacion DECIMAL(13, 5)	-- 3
		,Zona_recargo DECIMAL(13, 5)    	-- 4
	) AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(Zona.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY Zona.codigo DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Zona_des_Zona_Codigo(
		100
		, 0
		, null::VARCHAR -- Zona_codigoArg0
		, null::VARCHAR -- Zona_nombreWord0Arg1
		, null::VARCHAR -- Zona_nombreWord1Arg2
		, null::VARCHAR -- Zona_nombreWord2Arg3
		, null::VARCHAR -- Zona_nombreWord3Arg4
		, null::VARCHAR -- Zona_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Zona_asc_Zona_Codigo(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona_asc_Zona_Codigo(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 Zona_id VARCHAR(36)            	-- 0
		,Zona_codigo VARCHAR(3)         	-- 1
		,Zona_nombre VARCHAR(50)        	-- 2
		,Zona_bonificacion DECIMAL(13, 5)	-- 3
		,Zona_recargo DECIMAL(13, 5)    	-- 4
	) AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(Zona.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY Zona.codigo ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Zona_asc_Zona_Codigo(
		 null::VARCHAR -- Zona_codigoArg0
		, null::VARCHAR -- Zona_nombreWord0Arg1
		, null::VARCHAR -- Zona_nombreWord1Arg2
		, null::VARCHAR -- Zona_nombreWord2Arg3
		, null::VARCHAR -- Zona_nombreWord3Arg4
		, null::VARCHAR -- Zona_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Zona_des_Zona_Codigo(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona_des_Zona_Codigo(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 Zona_id VARCHAR(36)            	-- 0
		,Zona_codigo VARCHAR(3)         	-- 1
		,Zona_nombre VARCHAR(50)        	-- 2
		,Zona_bonificacion DECIMAL(13, 5)	-- 3
		,Zona_recargo DECIMAL(13, 5)    	-- 4
	) AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(Zona.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY Zona.codigo DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Zona_des_Zona_Codigo(
		 null::VARCHAR -- Zona_codigoArg0
		, null::VARCHAR -- Zona_nombreWord0Arg1
		, null::VARCHAR -- Zona_nombreWord1Arg2
		, null::VARCHAR -- Zona_nombreWord2Arg3
		, null::VARCHAR -- Zona_nombreWord3Arg4
		, null::VARCHAR -- Zona_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Zona_asc_Zona_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona_asc_Zona_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 Zona_id VARCHAR(36)            	-- 0
		,Zona_codigo VARCHAR(3)         	-- 1
		,Zona_nombre VARCHAR(50)        	-- 2
		,Zona_bonificacion DECIMAL(13, 5)	-- 3
		,Zona_recargo DECIMAL(13, 5)    	-- 4
	) AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(Zona.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY Zona.nombre ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Zona_asc_Zona_Nombre(
		100
		, 0
		, null::VARCHAR -- Zona_codigoArg0
		, null::VARCHAR -- Zona_nombreWord0Arg1
		, null::VARCHAR -- Zona_nombreWord1Arg2
		, null::VARCHAR -- Zona_nombreWord2Arg3
		, null::VARCHAR -- Zona_nombreWord3Arg4
		, null::VARCHAR -- Zona_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Zona_des_Zona_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona_des_Zona_Nombre(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 Zona_id VARCHAR(36)            	-- 0
		,Zona_codigo VARCHAR(3)         	-- 1
		,Zona_nombre VARCHAR(50)        	-- 2
		,Zona_bonificacion DECIMAL(13, 5)	-- 3
		,Zona_recargo DECIMAL(13, 5)    	-- 4
	) AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(Zona.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY Zona.nombre DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Zona_des_Zona_Nombre(
		100
		, 0
		, null::VARCHAR -- Zona_codigoArg0
		, null::VARCHAR -- Zona_nombreWord0Arg1
		, null::VARCHAR -- Zona_nombreWord1Arg2
		, null::VARCHAR -- Zona_nombreWord2Arg3
		, null::VARCHAR -- Zona_nombreWord3Arg4
		, null::VARCHAR -- Zona_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Zona_asc_Zona_Nombre(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona_asc_Zona_Nombre(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 Zona_id VARCHAR(36)            	-- 0
		,Zona_codigo VARCHAR(3)         	-- 1
		,Zona_nombre VARCHAR(50)        	-- 2
		,Zona_bonificacion DECIMAL(13, 5)	-- 3
		,Zona_recargo DECIMAL(13, 5)    	-- 4
	) AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(Zona.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY Zona.nombre ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Zona_asc_Zona_Nombre(
		 null::VARCHAR -- Zona_codigoArg0
		, null::VARCHAR -- Zona_nombreWord0Arg1
		, null::VARCHAR -- Zona_nombreWord1Arg2
		, null::VARCHAR -- Zona_nombreWord2Arg3
		, null::VARCHAR -- Zona_nombreWord3Arg4
		, null::VARCHAR -- Zona_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Zona_des_Zona_Nombre(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona_des_Zona_Nombre(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 Zona_id VARCHAR(36)            	-- 0
		,Zona_codigo VARCHAR(3)         	-- 1
		,Zona_nombre VARCHAR(50)        	-- 2
		,Zona_bonificacion DECIMAL(13, 5)	-- 3
		,Zona_recargo DECIMAL(13, 5)    	-- 4
	) AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(Zona.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY Zona.nombre DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Zona_des_Zona_Nombre(
		 null::VARCHAR -- Zona_codigoArg0
		, null::VARCHAR -- Zona_nombreWord0Arg1
		, null::VARCHAR -- Zona_nombreWord1Arg2
		, null::VARCHAR -- Zona_nombreWord2Arg3
		, null::VARCHAR -- Zona_nombreWord3Arg4
		, null::VARCHAR -- Zona_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Zona_asc_Zona_Bonificacion(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona_asc_Zona_Bonificacion(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 Zona_id VARCHAR(36)            	-- 0
		,Zona_codigo VARCHAR(3)         	-- 1
		,Zona_nombre VARCHAR(50)        	-- 2
		,Zona_bonificacion DECIMAL(13, 5)	-- 3
		,Zona_recargo DECIMAL(13, 5)    	-- 4
	) AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(Zona.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY Zona.bonificacion ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Zona_asc_Zona_Bonificacion(
		100
		, 0
		, null::VARCHAR -- Zona_codigoArg0
		, null::VARCHAR -- Zona_nombreWord0Arg1
		, null::VARCHAR -- Zona_nombreWord1Arg2
		, null::VARCHAR -- Zona_nombreWord2Arg3
		, null::VARCHAR -- Zona_nombreWord3Arg4
		, null::VARCHAR -- Zona_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Zona_des_Zona_Bonificacion(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona_des_Zona_Bonificacion(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 Zona_id VARCHAR(36)            	-- 0
		,Zona_codigo VARCHAR(3)         	-- 1
		,Zona_nombre VARCHAR(50)        	-- 2
		,Zona_bonificacion DECIMAL(13, 5)	-- 3
		,Zona_recargo DECIMAL(13, 5)    	-- 4
	) AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(Zona.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY Zona.bonificacion DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Zona_des_Zona_Bonificacion(
		100
		, 0
		, null::VARCHAR -- Zona_codigoArg0
		, null::VARCHAR -- Zona_nombreWord0Arg1
		, null::VARCHAR -- Zona_nombreWord1Arg2
		, null::VARCHAR -- Zona_nombreWord2Arg3
		, null::VARCHAR -- Zona_nombreWord3Arg4
		, null::VARCHAR -- Zona_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Zona_asc_Zona_Bonificacion(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona_asc_Zona_Bonificacion(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 Zona_id VARCHAR(36)            	-- 0
		,Zona_codigo VARCHAR(3)         	-- 1
		,Zona_nombre VARCHAR(50)        	-- 2
		,Zona_bonificacion DECIMAL(13, 5)	-- 3
		,Zona_recargo DECIMAL(13, 5)    	-- 4
	) AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(Zona.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY Zona.bonificacion ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Zona_asc_Zona_Bonificacion(
		 null::VARCHAR -- Zona_codigoArg0
		, null::VARCHAR -- Zona_nombreWord0Arg1
		, null::VARCHAR -- Zona_nombreWord1Arg2
		, null::VARCHAR -- Zona_nombreWord2Arg3
		, null::VARCHAR -- Zona_nombreWord3Arg4
		, null::VARCHAR -- Zona_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Zona_des_Zona_Bonificacion(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona_des_Zona_Bonificacion(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 Zona_id VARCHAR(36)            	-- 0
		,Zona_codigo VARCHAR(3)         	-- 1
		,Zona_nombre VARCHAR(50)        	-- 2
		,Zona_bonificacion DECIMAL(13, 5)	-- 3
		,Zona_recargo DECIMAL(13, 5)    	-- 4
	) AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(Zona.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY Zona.bonificacion DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Zona_des_Zona_Bonificacion(
		 null::VARCHAR -- Zona_codigoArg0
		, null::VARCHAR -- Zona_nombreWord0Arg1
		, null::VARCHAR -- Zona_nombreWord1Arg2
		, null::VARCHAR -- Zona_nombreWord2Arg3
		, null::VARCHAR -- Zona_nombreWord3Arg4
		, null::VARCHAR -- Zona_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Zona_asc_Zona_Recargo(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona_asc_Zona_Recargo(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 Zona_id VARCHAR(36)            	-- 0
		,Zona_codigo VARCHAR(3)         	-- 1
		,Zona_nombre VARCHAR(50)        	-- 2
		,Zona_bonificacion DECIMAL(13, 5)	-- 3
		,Zona_recargo DECIMAL(13, 5)    	-- 4
	) AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(Zona.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY Zona.recargo ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Zona_asc_Zona_Recargo(
		100
		, 0
		, null::VARCHAR -- Zona_codigoArg0
		, null::VARCHAR -- Zona_nombreWord0Arg1
		, null::VARCHAR -- Zona_nombreWord1Arg2
		, null::VARCHAR -- Zona_nombreWord2Arg3
		, null::VARCHAR -- Zona_nombreWord3Arg4
		, null::VARCHAR -- Zona_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Zona_des_Zona_Recargo(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona_des_Zona_Recargo(
		limitArg BIGINT
		, offsetArg BIGINT

		, codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 Zona_id VARCHAR(36)            	-- 0
		,Zona_codigo VARCHAR(3)         	-- 1
		,Zona_nombre VARCHAR(50)        	-- 2
		,Zona_bonificacion DECIMAL(13, 5)	-- 3
		,Zona_recargo DECIMAL(13, 5)    	-- 4
	) AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(Zona.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY Zona.recargo DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Zona_des_Zona_Recargo(
		100
		, 0
		, null::VARCHAR -- Zona_codigoArg0
		, null::VARCHAR -- Zona_nombreWord0Arg1
		, null::VARCHAR -- Zona_nombreWord1Arg2
		, null::VARCHAR -- Zona_nombreWord2Arg3
		, null::VARCHAR -- Zona_nombreWord3Arg4
		, null::VARCHAR -- Zona_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Zona_asc_Zona_Recargo(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona_asc_Zona_Recargo(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 Zona_id VARCHAR(36)            	-- 0
		,Zona_codigo VARCHAR(3)         	-- 1
		,Zona_nombre VARCHAR(50)        	-- 2
		,Zona_bonificacion DECIMAL(13, 5)	-- 3
		,Zona_recargo DECIMAL(13, 5)    	-- 4
	) AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(Zona.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY Zona.recargo ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Zona_asc_Zona_Recargo(
		 null::VARCHAR -- Zona_codigoArg0
		, null::VARCHAR -- Zona_nombreWord0Arg1
		, null::VARCHAR -- Zona_nombreWord1Arg2
		, null::VARCHAR -- Zona_nombreWord2Arg3
		, null::VARCHAR -- Zona_nombreWord3Arg4
		, null::VARCHAR -- Zona_nombreWord4Arg5
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_Zona_des_Zona_Recargo(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Zona_des_Zona_Recargo(

		  codigoArg0 VARCHAR(3)
		, nombreWord0Arg1 VARCHAR(15)
		, nombreWord1Arg2 VARCHAR(15)
		, nombreWord2Arg3 VARCHAR(15)
		, nombreWord3Arg4 VARCHAR(15)
		, nombreWord4Arg5 VARCHAR(15)
) RETURNS

	TABLE(
		 Zona_id VARCHAR(36)            	-- 0
		,Zona_codigo VARCHAR(3)         	-- 1
		,Zona_nombre VARCHAR(50)        	-- 2
		,Zona_bonificacion DECIMAL(13, 5)	-- 3
		,Zona_recargo DECIMAL(13, 5)    	-- 4
	) AS $$

	SELECT
		 Zona.id AS Zona_id                   	-- 0
		,Zona.codigo AS Zona_codigo           	-- 1
		,Zona.nombre AS Zona_nombre           	-- 2
		,Zona.bonificacion AS Zona_bonificacion	-- 3
		,Zona.recargo AS Zona_recargo         	-- 4

	FROM	massoftware.Zona

	WHERE	(codigoArg0 IS NULL OR (CHAR_LENGTH(TRIM(codigoArg0)) > 0 AND TRIM(LOWER(Zona.codigo))::VARCHAR = TRIM(LOWER(codigoArg0))::VARCHAR))
		 AND (nombreWord0Arg1 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord0Arg1)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord0Arg1)) || '%')::VARCHAR))
		 AND (nombreWord1Arg2 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord1Arg2)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord1Arg2)) || '%')::VARCHAR))
		 AND (nombreWord2Arg3 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord2Arg3)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord2Arg3)) || '%')::VARCHAR))
		 AND (nombreWord3Arg4 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord3Arg4)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord3Arg4)) || '%')::VARCHAR))
		 AND (nombreWord4Arg5 IS NULL OR (CHAR_LENGTH(TRIM(nombreWord4Arg5)) > 0 AND TRIM(massoftware.TRANSLATE(Zona.nombre))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(nombreWord4Arg5)) || '%')::VARCHAR))

	ORDER BY Zona.recargo DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_Zona_des_Zona_Recargo(
		 null::VARCHAR -- Zona_codigoArg0
		, null::VARCHAR -- Zona_nombreWord0Arg1
		, null::VARCHAR -- Zona_nombreWord1Arg2
		, null::VARCHAR -- Zona_nombreWord2Arg3
		, null::VARCHAR -- Zona_nombreWord3Arg4
		, null::VARCHAR -- Zona_nombreWord4Arg5
);

*/