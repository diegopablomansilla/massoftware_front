
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Banco                                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Banco



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Banco CASCADE;

CREATE TABLE massoftware.Banco
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº banco
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Banco_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- CUIT
	cuit BIGINT NOT NULL  UNIQUE  CONSTRAINT Banco_cuit_chk CHECK ( cuit >= 1 AND cuit <= 99999999999 AND char_length(cuit::VARCHAR) >= 11 AND char_length(cuit::VARCHAR) <= 11  ), 
	
	-- Obsoleto
	bloqueado BOOLEAN NOT NULL, 
	
	-- Hoja
	hoja INTEGER CONSTRAINT Banco_hoja_chk CHECK ( hoja >= 1 AND hoja <= 100  ), 
	
	-- Primera fila
	primeraFila INTEGER CONSTRAINT Banco_primeraFila_chk CHECK ( primeraFila >= 1 AND primeraFila <= 1000  ), 
	
	-- Última fila
	ultimaFila INTEGER CONSTRAINT Banco_ultimaFila_chk CHECK ( ultimaFila >= 1 AND ultimaFila <= 1000  ), 
	
	-- Fecha
	fecha VARCHAR(3), 
	
	-- Descripción
	descripcion VARCHAR(3), 
	
	-- Referencia 1
	referencia1 VARCHAR(3), 
	
	-- Importe
	importe VARCHAR(3), 
	
	-- Referencia 2
	referencia2 VARCHAR(3), 
	
	-- Saldo
	saldo VARCHAR(3)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Banco_nombre ON massoftware.Banco (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatBanco() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatBanco() RETURNS TRIGGER AS $formatBanco$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.fecha := massoftware.white_is_null(NEW.fecha);
	 NEW.descripcion := massoftware.white_is_null(NEW.descripcion);
	 NEW.referencia1 := massoftware.white_is_null(NEW.referencia1);
	 NEW.importe := massoftware.white_is_null(NEW.importe);
	 NEW.referencia2 := massoftware.white_is_null(NEW.referencia2);
	 NEW.saldo := massoftware.white_is_null(NEW.saldo);

	RETURN NEW;
END;
$formatBanco$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatBanco ON massoftware.Banco CASCADE;

CREATE TRIGGER tgFormatBanco BEFORE INSERT OR UPDATE
	ON massoftware.Banco FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatBanco();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Banco;

-- SELECT * FROM massoftware.Banco LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Banco;

-- SELECT * FROM massoftware.Banco WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Banco_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Banco_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Banco
	WHERE	(numeroArg IS NULL OR Banco.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Banco_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Banco_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Banco_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Banco
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Banco.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Banco_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Banco_cuit(cuitArg BIGINT) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Banco_cuit(cuitArg BIGINT) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Banco
	WHERE	(cuitArg IS NULL OR Banco.cuit = cuitArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Banco_cuit(null::BIGINT);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Banco_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Banco_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Banco;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Banco_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Banco_cuit() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Banco_cuit() RETURNS BIGINT AS $$

	SELECT (COALESCE(MAX(cuit),0) + 1)::BIGINT FROM massoftware.Banco;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Banco_cuit();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Banco_hoja() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Banco_hoja() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(hoja),0) + 1)::INTEGER FROM massoftware.Banco;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Banco_hoja();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Banco_primeraFila() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Banco_primeraFila() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(primeraFila),0) + 1)::INTEGER FROM massoftware.Banco;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Banco_primeraFila();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Banco_ultimaFila() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Banco_ultimaFila() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(ultimaFila),0) + 1)::INTEGER FROM massoftware.Banco;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Banco_ultimaFila();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_BancoById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_BancoById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.Banco WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Banco.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.Banco WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Banco.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Banco WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Banco.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_BancoById('xxx');

-- SELECT * FROM massoftware.d_BancoById((SELECT Banco.id FROM massoftware.Banco LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Banco(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuitArg BIGINT
		, bloqueadoArg BOOLEAN
		, hojaArg INTEGER
		, primeraFilaArg INTEGER
		, ultimaFilaArg INTEGER
		, fechaArg VARCHAR(3)
		, descripcionArg VARCHAR(3)
		, referencia1Arg VARCHAR(3)
		, importeArg VARCHAR(3)
		, referencia2Arg VARCHAR(3)
		, saldoArg VARCHAR(3)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Banco(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuitArg BIGINT
		, bloqueadoArg BOOLEAN
		, hojaArg INTEGER
		, primeraFilaArg INTEGER
		, ultimaFilaArg INTEGER
		, fechaArg VARCHAR(3)
		, descripcionArg VARCHAR(3)
		, referencia1Arg VARCHAR(3)
		, importeArg VARCHAR(3)
		, referencia2Arg VARCHAR(3)
		, saldoArg VARCHAR(3)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF bloqueadoArg IS NULL THEN

		bloqueadoArg = false;

	END IF;

	INSERT INTO massoftware.Banco(id, numero, nombre, cuit, bloqueado, hoja, primeraFila, ultimaFila, fecha, descripcion, referencia1, importe, referencia2, saldo) VALUES (idArg, numeroArg, nombreArg, cuitArg, bloqueadoArg, hojaArg, primeraFilaArg, ultimaFilaArg, fechaArg, descripcionArg, referencia1Arg, importeArg, referencia2Arg, saldoArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Banco WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Banco.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Banco(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::BIGINT
		, null::BOOLEAN
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::VARCHAR(3)
		, null::VARCHAR(3)
		, null::VARCHAR(3)
		, null::VARCHAR(3)
		, null::VARCHAR(3)
		, null::VARCHAR(3)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Banco(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuitArg BIGINT
		, bloqueadoArg BOOLEAN
		, hojaArg INTEGER
		, primeraFilaArg INTEGER
		, ultimaFilaArg INTEGER
		, fechaArg VARCHAR(3)
		, descripcionArg VARCHAR(3)
		, referencia1Arg VARCHAR(3)
		, importeArg VARCHAR(3)
		, referencia2Arg VARCHAR(3)
		, saldoArg VARCHAR(3)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Banco(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuitArg BIGINT
		, bloqueadoArg BOOLEAN
		, hojaArg INTEGER
		, primeraFilaArg INTEGER
		, ultimaFilaArg INTEGER
		, fechaArg VARCHAR(3)
		, descripcionArg VARCHAR(3)
		, referencia1Arg VARCHAR(3)
		, importeArg VARCHAR(3)
		, referencia2Arg VARCHAR(3)
		, saldoArg VARCHAR(3)
) RETURNS BOOLEAN AS $$

BEGIN

	IF bloqueadoArg IS NULL THEN

		bloqueadoArg = false;

	END IF;

	UPDATE massoftware.Banco SET 
		  numero = numeroArg
		, nombre = nombreArg
		, cuit = cuitArg
		, bloqueado = bloqueadoArg
		, hoja = hojaArg
		, primeraFila = primeraFilaArg
		, ultimaFila = ultimaFilaArg
		, fecha = fechaArg
		, descripcion = descripcionArg
		, referencia1 = referencia1Arg
		, importe = importeArg
		, referencia2 = referencia2Arg
		, saldo = saldoArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Banco.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Banco WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Banco.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Banco(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::BIGINT
		, null::BOOLEAN
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::VARCHAR(3)
		, null::VARCHAR(3)
		, null::VARCHAR(3)
		, null::VARCHAR(3)
		, null::VARCHAR(3)
		, null::VARCHAR(3)
);

*/

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