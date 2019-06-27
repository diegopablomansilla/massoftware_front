
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Talonario                                                                                              //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Talonario



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Talonario CASCADE;

CREATE TABLE massoftware.Talonario
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº talonario
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Talonario_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Letra
	talonarioLetra VARCHAR(36)  NOT NULL  REFERENCES massoftware.TalonarioLetra (id), 
	
	-- Punto de venta
	puntoVenta INTEGER NOT NULL  CONSTRAINT Talonario_puntoVenta_chk CHECK ( puntoVenta >= 1 AND puntoVenta <= 9999  ), 
	
	-- Autonumeración
	autonumeracion BOOLEAN NOT NULL, 
	
	-- Numeración pre-impresa
	numeracionPreImpresa BOOLEAN NOT NULL, 
	
	-- Asociado al RG 100/98
	asociadoRG10098 BOOLEAN NOT NULL, 
	
	-- Asociado a controlador fizcal
	talonarioControladorFizcal VARCHAR(36)  NOT NULL  REFERENCES massoftware.TalonarioControladorFizcal (id), 
	
	-- Primer nº
	primerNumero INTEGER CONSTRAINT Talonario_primerNumero_chk CHECK ( primerNumero >= 1  ), 
	
	-- Próximo nº
	proximoNumero INTEGER CONSTRAINT Talonario_proximoNumero_chk CHECK ( proximoNumero >= 1  ), 
	
	-- Último nº
	ultimoNumero INTEGER CONSTRAINT Talonario_ultimoNumero_chk CHECK ( ultimoNumero >= 1  ), 
	
	-- Cant. min. cbtes.
	cantidadMinimaComprobantes INTEGER CONSTRAINT Talonario_cantidadMinimaComprobantes_chk CHECK ( cantidadMinimaComprobantes >= 1  ), 
	
	-- Fecha
	fecha DATE, 
	
	-- Nº C.A.I
	numeroCAI BIGINT CONSTRAINT Talonario_numeroCAI_chk CHECK ( numeroCAI >= 1 AND numeroCAI <= 99999999999999  ), 
	
	-- Vencimiento C.A.I
	vencimiento DATE, 
	
	-- Días aviso vto.
	diasAvisoVencimiento INTEGER CONSTRAINT Talonario_diasAvisoVencimiento_chk CHECK ( diasAvisoVencimiento >= 1  )
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Talonario_nombre ON massoftware.Talonario (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatTalonario() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatTalonario() RETURNS TRIGGER AS $formatTalonario$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.talonarioLetra := massoftware.white_is_null(NEW.talonarioLetra);
	 NEW.talonarioControladorFizcal := massoftware.white_is_null(NEW.talonarioControladorFizcal);

	RETURN NEW;
END;
$formatTalonario$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTalonario ON massoftware.Talonario CASCADE;

CREATE TRIGGER tgFormatTalonario BEFORE INSERT OR UPDATE
	ON massoftware.Talonario FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatTalonario();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Talonario;

-- SELECT * FROM massoftware.Talonario LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Talonario;

-- SELECT * FROM massoftware.Talonario WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Talonario_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Talonario_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Talonario
	WHERE	(numeroArg IS NULL OR Talonario.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Talonario_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Talonario_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Talonario_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Talonario
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Talonario.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Talonario_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Talonario_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Talonario_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Talonario;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Talonario_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Talonario_puntoVenta() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Talonario_puntoVenta() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(puntoVenta),0) + 1)::INTEGER FROM massoftware.Talonario;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Talonario_puntoVenta();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Talonario_primerNumero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Talonario_primerNumero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(primerNumero),0) + 1)::INTEGER FROM massoftware.Talonario;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Talonario_primerNumero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Talonario_proximoNumero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Talonario_proximoNumero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(proximoNumero),0) + 1)::INTEGER FROM massoftware.Talonario;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Talonario_proximoNumero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Talonario_ultimoNumero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Talonario_ultimoNumero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(ultimoNumero),0) + 1)::INTEGER FROM massoftware.Talonario;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Talonario_ultimoNumero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Talonario_cantidadMinimaComprobantes() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Talonario_cantidadMinimaComprobantes() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(cantidadMinimaComprobantes),0) + 1)::INTEGER FROM massoftware.Talonario;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Talonario_cantidadMinimaComprobantes();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Talonario_numeroCAI() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Talonario_numeroCAI() RETURNS BIGINT AS $$

	SELECT (COALESCE(MAX(numeroCAI),0) + 1)::BIGINT FROM massoftware.Talonario;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Talonario_numeroCAI();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Talonario_diasAvisoVencimiento() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Talonario_diasAvisoVencimiento() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(diasAvisoVencimiento),0) + 1)::INTEGER FROM massoftware.Talonario;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Talonario_diasAvisoVencimiento();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_TalonarioById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_TalonarioById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.Talonario WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Talonario.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.Talonario WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Talonario.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Talonario WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Talonario.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_TalonarioById('xxx');

-- SELECT * FROM massoftware.d_TalonarioById((SELECT Talonario.id FROM massoftware.Talonario LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Talonario(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, talonarioLetraArg VARCHAR(36)
		, puntoVentaArg INTEGER
		, autonumeracionArg BOOLEAN
		, numeracionPreImpresaArg BOOLEAN
		, asociadoRG10098Arg BOOLEAN
		, talonarioControladorFizcalArg VARCHAR(36)
		, primerNumeroArg INTEGER
		, proximoNumeroArg INTEGER
		, ultimoNumeroArg INTEGER
		, cantidadMinimaComprobantesArg INTEGER
		, fechaArg DATE
		, numeroCAIArg BIGINT
		, vencimientoArg DATE
		, diasAvisoVencimientoArg INTEGER
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Talonario(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, talonarioLetraArg VARCHAR(36)
		, puntoVentaArg INTEGER
		, autonumeracionArg BOOLEAN
		, numeracionPreImpresaArg BOOLEAN
		, asociadoRG10098Arg BOOLEAN
		, talonarioControladorFizcalArg VARCHAR(36)
		, primerNumeroArg INTEGER
		, proximoNumeroArg INTEGER
		, ultimoNumeroArg INTEGER
		, cantidadMinimaComprobantesArg INTEGER
		, fechaArg DATE
		, numeroCAIArg BIGINT
		, vencimientoArg DATE
		, diasAvisoVencimientoArg INTEGER
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF autonumeracionArg IS NULL THEN

		autonumeracionArg = false;

	END IF;

	IF numeracionPreImpresaArg IS NULL THEN

		numeracionPreImpresaArg = false;

	END IF;

	IF asociadoRG10098Arg IS NULL THEN

		asociadoRG10098Arg = false;

	END IF;

	INSERT INTO massoftware.Talonario(id, numero, nombre, talonarioLetra, puntoVenta, autonumeracion, numeracionPreImpresa, asociadoRG10098, talonarioControladorFizcal, primerNumero, proximoNumero, ultimoNumero, cantidadMinimaComprobantes, fecha, numeroCAI, vencimiento, diasAvisoVencimiento) VALUES (idArg, numeroArg, nombreArg, talonarioLetraArg, puntoVentaArg, autonumeracionArg, numeracionPreImpresaArg, asociadoRG10098Arg, talonarioControladorFizcalArg, primerNumeroArg, proximoNumeroArg, ultimoNumeroArg, cantidadMinimaComprobantesArg, fechaArg, numeroCAIArg, vencimientoArg, diasAvisoVencimientoArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Talonario WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Talonario.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Talonario(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::INTEGER
		, null::BOOLEAN
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::DATE
		, null::BIGINT
		, null::DATE
		, null::INTEGER
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Talonario(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, talonarioLetraArg VARCHAR(36)
		, puntoVentaArg INTEGER
		, autonumeracionArg BOOLEAN
		, numeracionPreImpresaArg BOOLEAN
		, asociadoRG10098Arg BOOLEAN
		, talonarioControladorFizcalArg VARCHAR(36)
		, primerNumeroArg INTEGER
		, proximoNumeroArg INTEGER
		, ultimoNumeroArg INTEGER
		, cantidadMinimaComprobantesArg INTEGER
		, fechaArg DATE
		, numeroCAIArg BIGINT
		, vencimientoArg DATE
		, diasAvisoVencimientoArg INTEGER
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Talonario(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, talonarioLetraArg VARCHAR(36)
		, puntoVentaArg INTEGER
		, autonumeracionArg BOOLEAN
		, numeracionPreImpresaArg BOOLEAN
		, asociadoRG10098Arg BOOLEAN
		, talonarioControladorFizcalArg VARCHAR(36)
		, primerNumeroArg INTEGER
		, proximoNumeroArg INTEGER
		, ultimoNumeroArg INTEGER
		, cantidadMinimaComprobantesArg INTEGER
		, fechaArg DATE
		, numeroCAIArg BIGINT
		, vencimientoArg DATE
		, diasAvisoVencimientoArg INTEGER
) RETURNS BOOLEAN AS $$

BEGIN

	IF autonumeracionArg IS NULL THEN

		autonumeracionArg = false;

	END IF;

	IF numeracionPreImpresaArg IS NULL THEN

		numeracionPreImpresaArg = false;

	END IF;

	IF asociadoRG10098Arg IS NULL THEN

		asociadoRG10098Arg = false;

	END IF;

	UPDATE massoftware.Talonario SET 
		  numero = numeroArg
		, nombre = nombreArg
		, talonarioLetra = talonarioLetraArg
		, puntoVenta = puntoVentaArg
		, autonumeracion = autonumeracionArg
		, numeracionPreImpresa = numeracionPreImpresaArg
		, asociadoRG10098 = asociadoRG10098Arg
		, talonarioControladorFizcal = talonarioControladorFizcalArg
		, primerNumero = primerNumeroArg
		, proximoNumero = proximoNumeroArg
		, ultimoNumero = ultimoNumeroArg
		, cantidadMinimaComprobantes = cantidadMinimaComprobantesArg
		, fecha = fechaArg
		, numeroCAI = numeroCAIArg
		, vencimiento = vencimientoArg
		, diasAvisoVencimiento = diasAvisoVencimientoArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Talonario.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Talonario WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Talonario.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Talonario(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::INTEGER
		, null::BOOLEAN
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::DATE
		, null::BIGINT
		, null::DATE
		, null::INTEGER
);

*/

DROP TYPE IF EXISTS massoftware.t_Talonario_1 CASCADE;

CREATE TYPE massoftware.t_Talonario_1 AS (

	  Talonario_id                        	VARCHAR(36)		-- 0	Talonario.id
	, Talonario_numero                    	INTEGER    		-- 1	Talonario.numero
	, Talonario_nombre                    	VARCHAR(50)		-- 2	Talonario.nombre
	, TalonarioLetra_3_id                 	VARCHAR(36)		-- 3	Talonario.TalonarioLetra.id
	, TalonarioLetra_3_nombre             	VARCHAR(50)		-- 4	Talonario.TalonarioLetra.nombre
	, Talonario_puntoVenta                	INTEGER    		-- 5	Talonario.puntoVenta
	, Talonario_autonumeracion            	BOOLEAN    		-- 6	Talonario.autonumeracion
	, Talonario_numeracionPreImpresa      	BOOLEAN    		-- 7	Talonario.numeracionPreImpresa
	, Talonario_asociadoRG10098           	BOOLEAN    		-- 8	Talonario.asociadoRG10098
	, TalonarioControladorFizcal_9_id     	VARCHAR(36)		-- 9	Talonario.TalonarioControladorFizcal.id
	, TalonarioControladorFizcal_9_codigo 	VARCHAR(10)		-- 10	Talonario.TalonarioControladorFizcal.codigo
	, TalonarioControladorFizcal_9_nombre 	VARCHAR(50)		-- 11	Talonario.TalonarioControladorFizcal.nombre
	, Talonario_primerNumero              	INTEGER    		-- 12	Talonario.primerNumero
	, Talonario_proximoNumero             	INTEGER    		-- 13	Talonario.proximoNumero
	, Talonario_ultimoNumero              	INTEGER    		-- 14	Talonario.ultimoNumero
	, Talonario_cantidadMinimaComprobantes	INTEGER    		-- 15	Talonario.cantidadMinimaComprobantes
	, Talonario_fecha                     	DATE       		-- 16	Talonario.fecha
	, Talonario_numeroCAI                 	BIGINT     		-- 17	Talonario.numeroCAI
	, Talonario_vencimiento               	DATE       		-- 18	Talonario.vencimiento
	, Talonario_diasAvisoVencimiento      	INTEGER    		-- 19	Talonario.diasAvisoVencimiento

);

DROP FUNCTION IF EXISTS massoftware.f_Talonario (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Talonario (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.Talonario AS $$

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
				  Talonario.id                             AS Talonario_id                        	-- 0	.id                       		VARCHAR(36)
				, Talonario.numero                         AS Talonario_numero                    	-- 1	.numero                   		INTEGER
				, Talonario.nombre                         AS Talonario_nombre                    	-- 2	.nombre                   		VARCHAR(50)
				, Talonario.talonarioLetra                 AS Talonario_talonarioLetra            	-- 3	.talonarioLetra           		VARCHAR(36)	TalonarioLetra.id
				, Talonario.puntoVenta                     AS Talonario_puntoVenta                	-- 4	.puntoVenta               		INTEGER
				, Talonario.autonumeracion                 AS Talonario_autonumeracion            	-- 5	.autonumeracion           		BOOLEAN
				, Talonario.numeracionPreImpresa           AS Talonario_numeracionPreImpresa      	-- 6	.numeracionPreImpresa     		BOOLEAN
				, Talonario.asociadoRG10098                AS Talonario_asociadoRG10098           	-- 7	.asociadoRG10098          		BOOLEAN
				, Talonario.talonarioControladorFizcal     AS Talonario_talonarioControladorFizcal	-- 8	.talonarioControladorFizcal		VARCHAR(36)	TalonarioControladorFizcal.id
				, Talonario.primerNumero                   AS Talonario_primerNumero              	-- 9	.primerNumero             		INTEGER
				, Talonario.proximoNumero                  AS Talonario_proximoNumero             	-- 10	.proximoNumero            		INTEGER
				, Talonario.ultimoNumero                   AS Talonario_ultimoNumero              	-- 11	.ultimoNumero             		INTEGER
				, Talonario.cantidadMinimaComprobantes     AS Talonario_cantidadMinimaComprobantes	-- 12	.cantidadMinimaComprobantes		INTEGER
				, Talonario.fecha                          AS Talonario_fecha                     	-- 13	.fecha                    		DATE
				, Talonario.numeroCAI                      AS Talonario_numeroCAI                 	-- 14	.numeroCAI                		BIGINT
				, Talonario.vencimiento                    AS Talonario_vencimiento               	-- 15	.vencimiento              		DATE
				, Talonario.diasAvisoVencimiento           AS Talonario_diasAvisoVencimiento      	-- 16	.diasAvisoVencimiento     		INTEGER

		FROM	massoftware.Talonario

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Talonario.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Talonario.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Talonario.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Talonario.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_TalonarioById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TalonarioById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Talonario AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Talonario ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Talonario ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_TalonarioById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Talonario_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Talonario_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.t_Talonario_1 AS $$

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
				  Talonario.id                             AS Talonario_id                        	-- 0	.id                              		VARCHAR(36)
				, Talonario.numero                         AS Talonario_numero                    	-- 1	.numero                          		INTEGER
				, Talonario.nombre                         AS Talonario_nombre                    	-- 2	.nombre                          		VARCHAR(50)
				, TalonarioLetra_3.id                      AS TalonarioLetra_3_id                 	-- 3	.TalonarioLetra.id               		VARCHAR(36)
				, TalonarioLetra_3.nombre                  AS TalonarioLetra_3_nombre             	-- 4	.TalonarioLetra.nombre           		VARCHAR(50)
				, Talonario.puntoVenta                     AS Talonario_puntoVenta                	-- 5	.puntoVenta                      		INTEGER
				, Talonario.autonumeracion                 AS Talonario_autonumeracion            	-- 6	.autonumeracion                  		BOOLEAN
				, Talonario.numeracionPreImpresa           AS Talonario_numeracionPreImpresa      	-- 7	.numeracionPreImpresa            		BOOLEAN
				, Talonario.asociadoRG10098                AS Talonario_asociadoRG10098           	-- 8	.asociadoRG10098                 		BOOLEAN
				, TalonarioControladorFizcal_9.id          AS TalonarioControladorFizcal_9_id     	-- 9	.TalonarioControladorFizcal.id   		VARCHAR(36)
				, TalonarioControladorFizcal_9.codigo      AS TalonarioControladorFizcal_9_codigo 	-- 10	.TalonarioControladorFizcal.codigo		VARCHAR(10)
				, TalonarioControladorFizcal_9.nombre      AS TalonarioControladorFizcal_9_nombre 	-- 11	.TalonarioControladorFizcal.nombre		VARCHAR(50)
				, Talonario.primerNumero                   AS Talonario_primerNumero              	-- 12	.primerNumero                    		INTEGER
				, Talonario.proximoNumero                  AS Talonario_proximoNumero             	-- 13	.proximoNumero                   		INTEGER
				, Talonario.ultimoNumero                   AS Talonario_ultimoNumero              	-- 14	.ultimoNumero                    		INTEGER
				, Talonario.cantidadMinimaComprobantes     AS Talonario_cantidadMinimaComprobantes	-- 15	.cantidadMinimaComprobantes      		INTEGER
				, Talonario.fecha                          AS Talonario_fecha                     	-- 16	.fecha                           		DATE
				, Talonario.numeroCAI                      AS Talonario_numeroCAI                 	-- 17	.numeroCAI                       		BIGINT
				, Talonario.vencimiento                    AS Talonario_vencimiento               	-- 18	.vencimiento                     		DATE
				, Talonario.diasAvisoVencimiento           AS Talonario_diasAvisoVencimiento      	-- 19	.diasAvisoVencimiento            		INTEGER

		FROM	massoftware.Talonario
			LEFT JOIN massoftware.TalonarioLetra AS TalonarioLetra_3                    ON Talonario.talonarioLetra = TalonarioLetra_3.id 	-- 3 LEFT LEVEL: 1
			LEFT JOIN massoftware.TalonarioControladorFizcal AS TalonarioControladorFizcal_9        ON Talonario.talonarioControladorFizcal = TalonarioControladorFizcal_9.id 	-- 9 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Talonario.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Talonario.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Talonario.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Talonario.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_TalonarioById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TalonarioById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Talonario_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Talonario_1 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Talonario_1 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_TalonarioById_1 ('xxx'); 