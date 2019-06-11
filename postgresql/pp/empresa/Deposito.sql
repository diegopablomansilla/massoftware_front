
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Deposito                                                                                               //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Deposito



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Deposito CASCADE;

CREATE TABLE massoftware.Deposito
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº depósito
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Deposito_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Abreviatura
	abreviatura VARCHAR(5) NOT NULL, 
	
	-- Sucursal
	sucursal VARCHAR(36)  REFERENCES massoftware.Sucursal (id), 
	
	-- Módulo
	depositoModulo VARCHAR(36)  NOT NULL  REFERENCES massoftware.DepositoModulo (id), 
	
	-- Puerta operativo
	puertaOperativo VARCHAR(36)  NOT NULL  REFERENCES massoftware.SeguridadPuerta (id), 
	
	-- Puerta consulta
	puertaConsulta VARCHAR(36)  NOT NULL  REFERENCES massoftware.SeguridadPuerta (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Deposito_nombre ON massoftware.Deposito (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_Deposito_abreviatura ON massoftware.Deposito (TRANSLATE(LOWER(TRIM(abreviatura))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatDeposito() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatDeposito() RETURNS TRIGGER AS $formatDeposito$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.abreviatura := massoftware.white_is_null(NEW.abreviatura);
	 NEW.sucursal := massoftware.white_is_null(NEW.sucursal);
	 NEW.depositoModulo := massoftware.white_is_null(NEW.depositoModulo);
	 NEW.puertaOperativo := massoftware.white_is_null(NEW.puertaOperativo);
	 NEW.puertaConsulta := massoftware.white_is_null(NEW.puertaConsulta);

	RETURN NEW;
END;
$formatDeposito$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatDeposito ON massoftware.Deposito CASCADE;

CREATE TRIGGER tgFormatDeposito BEFORE INSERT OR UPDATE
	ON massoftware.Deposito FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatDeposito();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Deposito;

-- SELECT * FROM massoftware.Deposito LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Deposito;

-- SELECT * FROM massoftware.Deposito WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Deposito_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Deposito_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Deposito
	WHERE	(numeroArg IS NULL OR Deposito.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Deposito_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Deposito_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Deposito_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Deposito
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Deposito.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Deposito_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Deposito_abreviatura(abreviaturaArg VARCHAR(5)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Deposito_abreviatura(abreviaturaArg VARCHAR(5)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Deposito
	WHERE	(abreviaturaArg IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Deposito.abreviatura)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(abreviaturaArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Deposito_abreviatura(null::VARCHAR(5));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Deposito_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Deposito_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Deposito;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Deposito_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_DepositoById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_DepositoById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.Deposito WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Deposito.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.Deposito WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Deposito.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Deposito WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Deposito.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_DepositoById('xxx');

-- SELECT * FROM massoftware.d_DepositoById((SELECT Deposito.id FROM massoftware.Deposito LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Deposito(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, sucursalArg VARCHAR(36)
		, depositoModuloArg VARCHAR(36)
		, puertaOperativoArg VARCHAR(36)
		, puertaConsultaArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Deposito(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, sucursalArg VARCHAR(36)
		, depositoModuloArg VARCHAR(36)
		, puertaOperativoArg VARCHAR(36)
		, puertaConsultaArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Deposito(id, numero, nombre, abreviatura, sucursal, depositoModulo, puertaOperativo, puertaConsulta) VALUES (idArg, numeroArg, nombreArg, abreviaturaArg, sucursalArg, depositoModuloArg, puertaOperativoArg, puertaConsultaArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Deposito WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Deposito.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Deposito(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(5)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Deposito(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, sucursalArg VARCHAR(36)
		, depositoModuloArg VARCHAR(36)
		, puertaOperativoArg VARCHAR(36)
		, puertaConsultaArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Deposito(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, sucursalArg VARCHAR(36)
		, depositoModuloArg VARCHAR(36)
		, puertaOperativoArg VARCHAR(36)
		, puertaConsultaArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Deposito SET 
		  numero = numeroArg
		, nombre = nombreArg
		, abreviatura = abreviaturaArg
		, sucursal = sucursalArg
		, depositoModulo = depositoModuloArg
		, puertaOperativo = puertaOperativoArg
		, puertaConsulta = puertaConsultaArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Deposito.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Deposito WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Deposito.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Deposito(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(5)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/

DROP TYPE IF EXISTS massoftware.t_Deposito_1 CASCADE;

CREATE TYPE massoftware.t_Deposito_1 AS (

	  Deposito_id                                 	VARCHAR(36)		-- 0	Deposito.id
	, Deposito_numero                             	INTEGER    		-- 1	Deposito.numero
	, Deposito_nombre                             	VARCHAR(50)		-- 2	Deposito.nombre
	, Deposito_abreviatura                        	VARCHAR(5) 		-- 3	Deposito.abreviatura
	, Sucursal_4_id                               	VARCHAR(36)		-- 4	Deposito.Sucursal.id
	, Sucursal_4_numero                           	INTEGER    		-- 5	Deposito.Sucursal.numero
	, Sucursal_4_nombre                           	VARCHAR(50)		-- 6	Deposito.Sucursal.nombre
	, Sucursal_4_abreviatura                      	VARCHAR(5) 		-- 7	Deposito.Sucursal.abreviatura
	, Sucursal_4_tipoSucursal                     	VARCHAR(36)		-- 8	Deposito.Sucursal.tipoSucursal
	, Sucursal_4_cuentaClientesDesde              	VARCHAR(7) 		-- 9	Deposito.Sucursal.cuentaClientesDesde
	, Sucursal_4_cuentaClientesHasta              	VARCHAR(7) 		-- 10	Deposito.Sucursal.cuentaClientesHasta
	, Sucursal_4_cantidadCaracteresClientes       	INTEGER    		-- 11	Deposito.Sucursal.cantidadCaracteresClientes
	, Sucursal_4_identificacionNumericaClientes   	BOOLEAN    		-- 12	Deposito.Sucursal.identificacionNumericaClientes
	, Sucursal_4_permiteCambiarClientes           	BOOLEAN    		-- 13	Deposito.Sucursal.permiteCambiarClientes
	, Sucursal_4_cuentaProveedoresDesde           	VARCHAR(6) 		-- 14	Deposito.Sucursal.cuentaProveedoresDesde
	, Sucursal_4_cuentaProveedoresHasta           	VARCHAR(6) 		-- 15	Deposito.Sucursal.cuentaProveedoresHasta
	, Sucursal_4_cantidadCaracteresProveedores    	INTEGER    		-- 16	Deposito.Sucursal.cantidadCaracteresProveedores
	, Sucursal_4_identificacionNumericaProveedores	BOOLEAN    		-- 17	Deposito.Sucursal.identificacionNumericaProveedores
	, Sucursal_4_permiteCambiarProveedores        	BOOLEAN    		-- 18	Deposito.Sucursal.permiteCambiarProveedores
	, Sucursal_4_clientesOcacionalesDesde         	INTEGER    		-- 19	Deposito.Sucursal.clientesOcacionalesDesde
	, Sucursal_4_clientesOcacionalesHasta         	INTEGER    		-- 20	Deposito.Sucursal.clientesOcacionalesHasta
	, Sucursal_4_numeroCobranzaDesde              	INTEGER    		-- 21	Deposito.Sucursal.numeroCobranzaDesde
	, Sucursal_4_numeroCobranzaHasta              	INTEGER    		-- 22	Deposito.Sucursal.numeroCobranzaHasta
	, DepositoModulo_23_id                        	VARCHAR(36)		-- 23	Deposito.DepositoModulo.id
	, DepositoModulo_23_numero                    	INTEGER    		-- 24	Deposito.DepositoModulo.numero
	, DepositoModulo_23_nombre                    	VARCHAR(50)		-- 25	Deposito.DepositoModulo.nombre
	, SeguridadPuerta_26_id                       	VARCHAR(36)		-- 26	Deposito.SeguridadPuerta.id
	, SeguridadPuerta_26_numero                   	INTEGER    		-- 27	Deposito.SeguridadPuerta.numero
	, SeguridadPuerta_26_nombre                   	VARCHAR(50)		-- 28	Deposito.SeguridadPuerta.nombre
	, SeguridadPuerta_26_equate                   	VARCHAR(30)		-- 29	Deposito.SeguridadPuerta.equate
	, SeguridadPuerta_26_seguridadModulo          	VARCHAR(36)		-- 30	Deposito.SeguridadPuerta.seguridadModulo
	, SeguridadPuerta_31_id                       	VARCHAR(36)		-- 31	Deposito.SeguridadPuerta.id
	, SeguridadPuerta_31_numero                   	INTEGER    		-- 32	Deposito.SeguridadPuerta.numero
	, SeguridadPuerta_31_nombre                   	VARCHAR(50)		-- 33	Deposito.SeguridadPuerta.nombre
	, SeguridadPuerta_31_equate                   	VARCHAR(30)		-- 34	Deposito.SeguridadPuerta.equate
	, SeguridadPuerta_31_seguridadModulo          	VARCHAR(36)		-- 35	Deposito.SeguridadPuerta.seguridadModulo

);

DROP TYPE IF EXISTS massoftware.t_Deposito_2 CASCADE;

CREATE TYPE massoftware.t_Deposito_2 AS (

	  Deposito_id                                 	VARCHAR(36)		-- 0	Deposito.id
	, Deposito_numero                             	INTEGER    		-- 1	Deposito.numero
	, Deposito_nombre                             	VARCHAR(50)		-- 2	Deposito.nombre
	, Deposito_abreviatura                        	VARCHAR(5) 		-- 3	Deposito.abreviatura
	, Sucursal_4_id                               	VARCHAR(36)		-- 4	Deposito.Sucursal.id
	, Sucursal_4_numero                           	INTEGER    		-- 5	Deposito.Sucursal.numero
	, Sucursal_4_nombre                           	VARCHAR(50)		-- 6	Deposito.Sucursal.nombre
	, Sucursal_4_abreviatura                      	VARCHAR(5) 		-- 7	Deposito.Sucursal.abreviatura
	, TipoSucursal_8_id                           	VARCHAR(36)		-- 8	Deposito.Sucursal.TipoSucursal.id
	, TipoSucursal_8_numero                       	INTEGER    		-- 9	Deposito.Sucursal.TipoSucursal.numero
	, TipoSucursal_8_nombre                       	VARCHAR(50)		-- 10	Deposito.Sucursal.TipoSucursal.nombre
	, Sucursal_4_cuentaClientesDesde              	VARCHAR(7) 		-- 11	Deposito.Sucursal.cuentaClientesDesde
	, Sucursal_4_cuentaClientesHasta              	VARCHAR(7) 		-- 12	Deposito.Sucursal.cuentaClientesHasta
	, Sucursal_4_cantidadCaracteresClientes       	INTEGER    		-- 13	Deposito.Sucursal.cantidadCaracteresClientes
	, Sucursal_4_identificacionNumericaClientes   	BOOLEAN    		-- 14	Deposito.Sucursal.identificacionNumericaClientes
	, Sucursal_4_permiteCambiarClientes           	BOOLEAN    		-- 15	Deposito.Sucursal.permiteCambiarClientes
	, Sucursal_4_cuentaProveedoresDesde           	VARCHAR(6) 		-- 16	Deposito.Sucursal.cuentaProveedoresDesde
	, Sucursal_4_cuentaProveedoresHasta           	VARCHAR(6) 		-- 17	Deposito.Sucursal.cuentaProveedoresHasta
	, Sucursal_4_cantidadCaracteresProveedores    	INTEGER    		-- 18	Deposito.Sucursal.cantidadCaracteresProveedores
	, Sucursal_4_identificacionNumericaProveedores	BOOLEAN    		-- 19	Deposito.Sucursal.identificacionNumericaProveedores
	, Sucursal_4_permiteCambiarProveedores        	BOOLEAN    		-- 20	Deposito.Sucursal.permiteCambiarProveedores
	, Sucursal_4_clientesOcacionalesDesde         	INTEGER    		-- 21	Deposito.Sucursal.clientesOcacionalesDesde
	, Sucursal_4_clientesOcacionalesHasta         	INTEGER    		-- 22	Deposito.Sucursal.clientesOcacionalesHasta
	, Sucursal_4_numeroCobranzaDesde              	INTEGER    		-- 23	Deposito.Sucursal.numeroCobranzaDesde
	, Sucursal_4_numeroCobranzaHasta              	INTEGER    		-- 24	Deposito.Sucursal.numeroCobranzaHasta
	, DepositoModulo_25_id                        	VARCHAR(36)		-- 25	Deposito.DepositoModulo.id
	, DepositoModulo_25_numero                    	INTEGER    		-- 26	Deposito.DepositoModulo.numero
	, DepositoModulo_25_nombre                    	VARCHAR(50)		-- 27	Deposito.DepositoModulo.nombre
	, SeguridadPuerta_28_id                       	VARCHAR(36)		-- 28	Deposito.SeguridadPuerta.id
	, SeguridadPuerta_28_numero                   	INTEGER    		-- 29	Deposito.SeguridadPuerta.numero
	, SeguridadPuerta_28_nombre                   	VARCHAR(50)		-- 30	Deposito.SeguridadPuerta.nombre
	, SeguridadPuerta_28_equate                   	VARCHAR(30)		-- 31	Deposito.SeguridadPuerta.equate
	, SeguridadModulo_32_id                       	VARCHAR(36)		-- 32	Deposito.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_32_numero                   	INTEGER    		-- 33	Deposito.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_32_nombre                   	VARCHAR(50)		-- 34	Deposito.SeguridadPuerta.SeguridadModulo.nombre
	, SeguridadPuerta_35_id                       	VARCHAR(36)		-- 35	Deposito.SeguridadPuerta.id
	, SeguridadPuerta_35_numero                   	INTEGER    		-- 36	Deposito.SeguridadPuerta.numero
	, SeguridadPuerta_35_nombre                   	VARCHAR(50)		-- 37	Deposito.SeguridadPuerta.nombre
	, SeguridadPuerta_35_equate                   	VARCHAR(30)		-- 38	Deposito.SeguridadPuerta.equate
	, SeguridadModulo_39_id                       	VARCHAR(36)		-- 39	Deposito.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_39_numero                   	INTEGER    		-- 40	Deposito.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_39_nombre                   	VARCHAR(50)		-- 41	Deposito.SeguridadPuerta.SeguridadModulo.nombre

);

DROP FUNCTION IF EXISTS massoftware.f_Deposito (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, sucursalArg8      VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Deposito (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, sucursalArg8      VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.Deposito AS $$

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
				  Deposito.id                 AS Deposito_id             	-- 0	.id            		VARCHAR(36)
				, Deposito.numero             AS Deposito_numero         	-- 1	.numero        		INTEGER
				, Deposito.nombre             AS Deposito_nombre         	-- 2	.nombre        		VARCHAR(50)
				, Deposito.abreviatura        AS Deposito_abreviatura    	-- 3	.abreviatura   		VARCHAR(5)
				, Deposito.sucursal           AS Deposito_sucursal       	-- 4	.sucursal      		VARCHAR(36)	Sucursal.id
				, Deposito.depositoModulo     AS Deposito_depositoModulo 	-- 5	.depositoModulo		VARCHAR(36)	DepositoModulo.id
				, Deposito.puertaOperativo    AS Deposito_puertaOperativo	-- 6	.puertaOperativo		VARCHAR(36)	SeguridadPuerta.id
				, Deposito.puertaConsulta     AS Deposito_puertaConsulta 	-- 7	.puertaConsulta		VARCHAR(36)	SeguridadPuerta.id

		FROM	massoftware.Deposito

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Deposito.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Deposito.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Deposito.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Deposito.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND sucursalArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(sucursalArg8)) > 0 THEN
		sucursalArg8 = REPLACE(sucursalArg8, '''', '''''');
		sucursalArg8 = LOWER(TRIM(sucursalArg8));
		sucursalArg8 = TRANSLATE(sucursalArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(sucursalArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Deposito.sucursal),
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

DROP FUNCTION IF EXISTS massoftware.f_DepositoById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_DepositoById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Deposito AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Deposito ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Deposito ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_DepositoById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Deposito_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, sucursalArg8      VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Deposito_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, sucursalArg8      VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_Deposito_1 AS $$

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
				  Deposito.id                                      AS Deposito_id                                 	-- 0	.id                                       		VARCHAR(36)
				, Deposito.numero                                  AS Deposito_numero                             	-- 1	.numero                                   		INTEGER
				, Deposito.nombre                                  AS Deposito_nombre                             	-- 2	.nombre                                   		VARCHAR(50)
				, Deposito.abreviatura                             AS Deposito_abreviatura                        	-- 3	.abreviatura                              		VARCHAR(5)
				, Sucursal_4.id                                    AS Sucursal_4_id                               	-- 4	.Sucursal.id                              		VARCHAR(36)
				, Sucursal_4.numero                                AS Sucursal_4_numero                           	-- 5	.Sucursal.numero                          		INTEGER
				, Sucursal_4.nombre                                AS Sucursal_4_nombre                           	-- 6	.Sucursal.nombre                          		VARCHAR(50)
				, Sucursal_4.abreviatura                           AS Sucursal_4_abreviatura                      	-- 7	.Sucursal.abreviatura                     		VARCHAR(5)
				, Sucursal_4.tipoSucursal                          AS Sucursal_4_tipoSucursal                     	-- 8	.Sucursal.tipoSucursal                    		VARCHAR(36)	TipoSucursal.id
				, Sucursal_4.cuentaClientesDesde                   AS Sucursal_4_cuentaClientesDesde              	-- 9	.Sucursal.cuentaClientesDesde             		VARCHAR(7)
				, Sucursal_4.cuentaClientesHasta                   AS Sucursal_4_cuentaClientesHasta              	-- 10	.Sucursal.cuentaClientesHasta             		VARCHAR(7)
				, Sucursal_4.cantidadCaracteresClientes            AS Sucursal_4_cantidadCaracteresClientes       	-- 11	.Sucursal.cantidadCaracteresClientes      		INTEGER
				, Sucursal_4.identificacionNumericaClientes        AS Sucursal_4_identificacionNumericaClientes   	-- 12	.Sucursal.identificacionNumericaClientes  		BOOLEAN
				, Sucursal_4.permiteCambiarClientes                AS Sucursal_4_permiteCambiarClientes           	-- 13	.Sucursal.permiteCambiarClientes          		BOOLEAN
				, Sucursal_4.cuentaProveedoresDesde                AS Sucursal_4_cuentaProveedoresDesde           	-- 14	.Sucursal.cuentaProveedoresDesde          		VARCHAR(6)
				, Sucursal_4.cuentaProveedoresHasta                AS Sucursal_4_cuentaProveedoresHasta           	-- 15	.Sucursal.cuentaProveedoresHasta          		VARCHAR(6)
				, Sucursal_4.cantidadCaracteresProveedores         AS Sucursal_4_cantidadCaracteresProveedores    	-- 16	.Sucursal.cantidadCaracteresProveedores   		INTEGER
				, Sucursal_4.identificacionNumericaProveedores     AS Sucursal_4_identificacionNumericaProveedores	-- 17	.Sucursal.identificacionNumericaProveedores		BOOLEAN
				, Sucursal_4.permiteCambiarProveedores             AS Sucursal_4_permiteCambiarProveedores        	-- 18	.Sucursal.permiteCambiarProveedores       		BOOLEAN
				, Sucursal_4.clientesOcacionalesDesde              AS Sucursal_4_clientesOcacionalesDesde         	-- 19	.Sucursal.clientesOcacionalesDesde        		INTEGER
				, Sucursal_4.clientesOcacionalesHasta              AS Sucursal_4_clientesOcacionalesHasta         	-- 20	.Sucursal.clientesOcacionalesHasta        		INTEGER
				, Sucursal_4.numeroCobranzaDesde                   AS Sucursal_4_numeroCobranzaDesde              	-- 21	.Sucursal.numeroCobranzaDesde             		INTEGER
				, Sucursal_4.numeroCobranzaHasta                   AS Sucursal_4_numeroCobranzaHasta              	-- 22	.Sucursal.numeroCobranzaHasta             		INTEGER
				, DepositoModulo_23.id                             AS DepositoModulo_23_id                        	-- 23	.DepositoModulo.id                        		VARCHAR(36)
				, DepositoModulo_23.numero                         AS DepositoModulo_23_numero                    	-- 24	.DepositoModulo.numero                    		INTEGER
				, DepositoModulo_23.nombre                         AS DepositoModulo_23_nombre                    	-- 25	.DepositoModulo.nombre                    		VARCHAR(50)
				, SeguridadPuerta_26.id                            AS SeguridadPuerta_26_id                       	-- 26	.SeguridadPuerta.id                       		VARCHAR(36)
				, SeguridadPuerta_26.numero                        AS SeguridadPuerta_26_numero                   	-- 27	.SeguridadPuerta.numero                   		INTEGER
				, SeguridadPuerta_26.nombre                        AS SeguridadPuerta_26_nombre                   	-- 28	.SeguridadPuerta.nombre                   		VARCHAR(50)
				, SeguridadPuerta_26.equate                        AS SeguridadPuerta_26_equate                   	-- 29	.SeguridadPuerta.equate                   		VARCHAR(30)
				, SeguridadPuerta_26.seguridadModulo               AS SeguridadPuerta_26_seguridadModulo          	-- 30	.SeguridadPuerta.seguridadModulo          		VARCHAR(36)	SeguridadModulo.id
				, SeguridadPuerta_31.id                            AS SeguridadPuerta_31_id                       	-- 31	.SeguridadPuerta.id                       		VARCHAR(36)
				, SeguridadPuerta_31.numero                        AS SeguridadPuerta_31_numero                   	-- 32	.SeguridadPuerta.numero                   		INTEGER
				, SeguridadPuerta_31.nombre                        AS SeguridadPuerta_31_nombre                   	-- 33	.SeguridadPuerta.nombre                   		VARCHAR(50)
				, SeguridadPuerta_31.equate                        AS SeguridadPuerta_31_equate                   	-- 34	.SeguridadPuerta.equate                   		VARCHAR(30)
				, SeguridadPuerta_31.seguridadModulo               AS SeguridadPuerta_31_seguridadModulo          	-- 35	.SeguridadPuerta.seguridadModulo          		VARCHAR(36)	SeguridadModulo.id

		FROM	massoftware.Deposito
			LEFT JOIN massoftware.Sucursal AS Sucursal_4                ON Deposito.sucursal = Sucursal_4.id 	-- 4 LEFT LEVEL: 1
			LEFT JOIN massoftware.DepositoModulo AS DepositoModulo_23         ON Deposito.depositoModulo = DepositoModulo_23.id 	-- 23 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_26        ON Deposito.puertaOperativo = SeguridadPuerta_26.id 	-- 26 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_31        ON Deposito.puertaConsulta = SeguridadPuerta_31.id 	-- 31 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Deposito.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Deposito.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Deposito.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Deposito.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND sucursalArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(sucursalArg8)) > 0 THEN
		sucursalArg8 = REPLACE(sucursalArg8, '''', '''''');
		sucursalArg8 = LOWER(TRIM(sucursalArg8));
		sucursalArg8 = TRANSLATE(sucursalArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(sucursalArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Deposito.sucursal),
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

DROP FUNCTION IF EXISTS massoftware.f_DepositoById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_DepositoById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Deposito_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Deposito_1 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Deposito_1 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_DepositoById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Deposito_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, sucursalArg8      VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Deposito_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, sucursalArg8      VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_Deposito_2 AS $$

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
				  Deposito.id                                      AS Deposito_id                                 	-- 0	.id                                       		VARCHAR(36)
				, Deposito.numero                                  AS Deposito_numero                             	-- 1	.numero                                   		INTEGER
				, Deposito.nombre                                  AS Deposito_nombre                             	-- 2	.nombre                                   		VARCHAR(50)
				, Deposito.abreviatura                             AS Deposito_abreviatura                        	-- 3	.abreviatura                              		VARCHAR(5)
				, Sucursal_4.id                                    AS Sucursal_4_id                               	-- 4	.Sucursal.id                              		VARCHAR(36)
				, Sucursal_4.numero                                AS Sucursal_4_numero                           	-- 5	.Sucursal.numero                          		INTEGER
				, Sucursal_4.nombre                                AS Sucursal_4_nombre                           	-- 6	.Sucursal.nombre                          		VARCHAR(50)
				, Sucursal_4.abreviatura                           AS Sucursal_4_abreviatura                      	-- 7	.Sucursal.abreviatura                     		VARCHAR(5)
				, TipoSucursal_8.id                                AS TipoSucursal_8_id                           	-- 8	.Sucursal.TipoSucursal.id                 		VARCHAR(36)
				, TipoSucursal_8.numero                            AS TipoSucursal_8_numero                       	-- 9	.Sucursal.TipoSucursal.numero             		INTEGER
				, TipoSucursal_8.nombre                            AS TipoSucursal_8_nombre                       	-- 10	.Sucursal.TipoSucursal.nombre             		VARCHAR(50)
				, Sucursal_4.cuentaClientesDesde                   AS Sucursal_4_cuentaClientesDesde              	-- 11	.Sucursal.cuentaClientesDesde             		VARCHAR(7)
				, Sucursal_4.cuentaClientesHasta                   AS Sucursal_4_cuentaClientesHasta              	-- 12	.Sucursal.cuentaClientesHasta             		VARCHAR(7)
				, Sucursal_4.cantidadCaracteresClientes            AS Sucursal_4_cantidadCaracteresClientes       	-- 13	.Sucursal.cantidadCaracteresClientes      		INTEGER
				, Sucursal_4.identificacionNumericaClientes        AS Sucursal_4_identificacionNumericaClientes   	-- 14	.Sucursal.identificacionNumericaClientes  		BOOLEAN
				, Sucursal_4.permiteCambiarClientes                AS Sucursal_4_permiteCambiarClientes           	-- 15	.Sucursal.permiteCambiarClientes          		BOOLEAN
				, Sucursal_4.cuentaProveedoresDesde                AS Sucursal_4_cuentaProveedoresDesde           	-- 16	.Sucursal.cuentaProveedoresDesde          		VARCHAR(6)
				, Sucursal_4.cuentaProveedoresHasta                AS Sucursal_4_cuentaProveedoresHasta           	-- 17	.Sucursal.cuentaProveedoresHasta          		VARCHAR(6)
				, Sucursal_4.cantidadCaracteresProveedores         AS Sucursal_4_cantidadCaracteresProveedores    	-- 18	.Sucursal.cantidadCaracteresProveedores   		INTEGER
				, Sucursal_4.identificacionNumericaProveedores     AS Sucursal_4_identificacionNumericaProveedores	-- 19	.Sucursal.identificacionNumericaProveedores		BOOLEAN
				, Sucursal_4.permiteCambiarProveedores             AS Sucursal_4_permiteCambiarProveedores        	-- 20	.Sucursal.permiteCambiarProveedores       		BOOLEAN
				, Sucursal_4.clientesOcacionalesDesde              AS Sucursal_4_clientesOcacionalesDesde         	-- 21	.Sucursal.clientesOcacionalesDesde        		INTEGER
				, Sucursal_4.clientesOcacionalesHasta              AS Sucursal_4_clientesOcacionalesHasta         	-- 22	.Sucursal.clientesOcacionalesHasta        		INTEGER
				, Sucursal_4.numeroCobranzaDesde                   AS Sucursal_4_numeroCobranzaDesde              	-- 23	.Sucursal.numeroCobranzaDesde             		INTEGER
				, Sucursal_4.numeroCobranzaHasta                   AS Sucursal_4_numeroCobranzaHasta              	-- 24	.Sucursal.numeroCobranzaHasta             		INTEGER
				, DepositoModulo_25.id                             AS DepositoModulo_25_id                        	-- 25	.DepositoModulo.id                        		VARCHAR(36)
				, DepositoModulo_25.numero                         AS DepositoModulo_25_numero                    	-- 26	.DepositoModulo.numero                    		INTEGER
				, DepositoModulo_25.nombre                         AS DepositoModulo_25_nombre                    	-- 27	.DepositoModulo.nombre                    		VARCHAR(50)
				, SeguridadPuerta_28.id                            AS SeguridadPuerta_28_id                       	-- 28	.SeguridadPuerta.id                       		VARCHAR(36)
				, SeguridadPuerta_28.numero                        AS SeguridadPuerta_28_numero                   	-- 29	.SeguridadPuerta.numero                   		INTEGER
				, SeguridadPuerta_28.nombre                        AS SeguridadPuerta_28_nombre                   	-- 30	.SeguridadPuerta.nombre                   		VARCHAR(50)
				, SeguridadPuerta_28.equate                        AS SeguridadPuerta_28_equate                   	-- 31	.SeguridadPuerta.equate                   		VARCHAR(30)
				, SeguridadModulo_32.id                            AS SeguridadModulo_32_id                       	-- 32	.SeguridadPuerta.SeguridadModulo.id       		VARCHAR(36)
				, SeguridadModulo_32.numero                        AS SeguridadModulo_32_numero                   	-- 33	.SeguridadPuerta.SeguridadModulo.numero   		INTEGER
				, SeguridadModulo_32.nombre                        AS SeguridadModulo_32_nombre                   	-- 34	.SeguridadPuerta.SeguridadModulo.nombre   		VARCHAR(50)
				, SeguridadPuerta_35.id                            AS SeguridadPuerta_35_id                       	-- 35	.SeguridadPuerta.id                       		VARCHAR(36)
				, SeguridadPuerta_35.numero                        AS SeguridadPuerta_35_numero                   	-- 36	.SeguridadPuerta.numero                   		INTEGER
				, SeguridadPuerta_35.nombre                        AS SeguridadPuerta_35_nombre                   	-- 37	.SeguridadPuerta.nombre                   		VARCHAR(50)
				, SeguridadPuerta_35.equate                        AS SeguridadPuerta_35_equate                   	-- 38	.SeguridadPuerta.equate                   		VARCHAR(30)
				, SeguridadModulo_39.id                            AS SeguridadModulo_39_id                       	-- 39	.SeguridadPuerta.SeguridadModulo.id       		VARCHAR(36)
				, SeguridadModulo_39.numero                        AS SeguridadModulo_39_numero                   	-- 40	.SeguridadPuerta.SeguridadModulo.numero   		INTEGER
				, SeguridadModulo_39.nombre                        AS SeguridadModulo_39_nombre                   	-- 41	.SeguridadPuerta.SeguridadModulo.nombre   		VARCHAR(50)

		FROM	massoftware.Deposito
			LEFT JOIN massoftware.Sucursal AS Sucursal_4                   ON Deposito.sucursal = Sucursal_4.id 	-- 4 LEFT LEVEL: 1
				LEFT JOIN massoftware.TipoSucursal AS TipoSucursal_8              ON Sucursal_4.tipoSucursal = TipoSucursal_8.id 	-- 8 LEFT LEVEL: 2
			LEFT JOIN massoftware.DepositoModulo AS DepositoModulo_25            ON Deposito.depositoModulo = DepositoModulo_25.id 	-- 25 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_28           ON Deposito.puertaOperativo = SeguridadPuerta_28.id 	-- 28 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_32           ON SeguridadPuerta_28.seguridadModulo = SeguridadModulo_32.id 	-- 32 LEFT LEVEL: 2
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_35           ON Deposito.puertaConsulta = SeguridadPuerta_35.id 	-- 35 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_39           ON SeguridadPuerta_35.seguridadModulo = SeguridadModulo_39.id 	-- 39 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Deposito.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Deposito.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Deposito.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Deposito.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND sucursalArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(sucursalArg8)) > 0 THEN
		sucursalArg8 = REPLACE(sucursalArg8, '''', '''''');
		sucursalArg8 = LOWER(TRIM(sucursalArg8));
		sucursalArg8 = TRANSLATE(sucursalArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(sucursalArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Deposito.sucursal),
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

DROP FUNCTION IF EXISTS massoftware.f_DepositoById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_DepositoById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Deposito_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Deposito_2 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Deposito_2 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_DepositoById_2 ('xxx'); 