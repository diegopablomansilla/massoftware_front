
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Sucursal                                                                                               //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Sucursal



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Sucursal CASCADE;

CREATE TABLE massoftware.Sucursal
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº sucursal
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Sucursal_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Abreviatura
	abreviatura VARCHAR(5) NOT NULL, 
	
	-- Tipo sucursal
	tipoSucursal VARCHAR(36)  NOT NULL  REFERENCES massoftware.TipoSucursal (id), 
	
	-- Cuenta clientes desde
	cuentaClientesDesde VARCHAR(7), 
	
	-- Cuenta clientes hasta
	cuentaClientesHasta VARCHAR(7), 
	
	-- Cantidad caracteres clientes
	cantidadCaracteresClientes INTEGER NOT NULL  CONSTRAINT Sucursal_cantidadCaracteresClientes_chk CHECK ( cantidadCaracteresClientes >= 3 AND cantidadCaracteresClientes <= 6  ), 
	
	-- Identificacion numérica clientes
	identificacionNumericaClientes BOOLEAN NOT NULL, 
	
	-- Permite cambiar clientes
	permiteCambiarClientes BOOLEAN NOT NULL, 
	
	-- Cuenta proveedores desde
	cuentaProveedoresDesde VARCHAR(6), 
	
	-- Cuenta proveedores hasta
	cuentaProveedoresHasta VARCHAR(6), 
	
	-- Cantidad caracteres proveedores
	cantidadCaracteresProveedores INTEGER NOT NULL  CONSTRAINT Sucursal_cantidadCaracteresProveedores_chk CHECK ( cantidadCaracteresProveedores >= 3 AND cantidadCaracteresProveedores <= 6  ), 
	
	-- Identificacion numérica proveedores
	identificacionNumericaProveedores BOOLEAN NOT NULL, 
	
	-- Permite cambiar proveedores
	permiteCambiarProveedores BOOLEAN NOT NULL, 
	
	-- Clientes ocacionales desde
	clientesOcacionalesDesde INTEGER NOT NULL  CONSTRAINT Sucursal_clientesOcacionalesDesde_chk CHECK ( clientesOcacionalesDesde >= 1  ), 
	
	-- Clientes ocacionales hasta
	clientesOcacionalesHasta INTEGER NOT NULL  CONSTRAINT Sucursal_clientesOcacionalesHasta_chk CHECK ( clientesOcacionalesHasta >= 1  ), 
	
	-- Número cobranza desde
	numeroCobranzaDesde INTEGER NOT NULL  CONSTRAINT Sucursal_numeroCobranzaDesde_chk CHECK ( numeroCobranzaDesde >= 1  ), 
	
	-- Número cobranza hasta
	numeroCobranzaHasta INTEGER NOT NULL  CONSTRAINT Sucursal_numeroCobranzaHasta_chk CHECK ( numeroCobranzaHasta >= 1  )
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Sucursal_nombre ON massoftware.Sucursal (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_Sucursal_abreviatura ON massoftware.Sucursal (TRANSLATE(LOWER(TRIM(abreviatura))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatSucursal() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatSucursal() RETURNS TRIGGER AS $formatSucursal$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.abreviatura := massoftware.white_is_null(NEW.abreviatura);
	 NEW.tipoSucursal := massoftware.white_is_null(NEW.tipoSucursal);
	 NEW.cuentaClientesDesde := massoftware.white_is_null(NEW.cuentaClientesDesde);
	 NEW.cuentaClientesHasta := massoftware.white_is_null(NEW.cuentaClientesHasta);
	 NEW.cuentaProveedoresDesde := massoftware.white_is_null(NEW.cuentaProveedoresDesde);
	 NEW.cuentaProveedoresHasta := massoftware.white_is_null(NEW.cuentaProveedoresHasta);

	RETURN NEW;
END;
$formatSucursal$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatSucursal ON massoftware.Sucursal CASCADE;

CREATE TRIGGER tgFormatSucursal BEFORE INSERT OR UPDATE
	ON massoftware.Sucursal FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatSucursal();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Sucursal;

-- SELECT * FROM massoftware.Sucursal LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Sucursal;

-- SELECT * FROM massoftware.Sucursal WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Sucursal_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Sucursal_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Sucursal
	WHERE	(numeroArg IS NULL OR Sucursal.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Sucursal_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Sucursal_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Sucursal_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Sucursal
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Sucursal.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Sucursal_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Sucursal_abreviatura(abreviaturaArg VARCHAR(5)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Sucursal_abreviatura(abreviaturaArg VARCHAR(5)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Sucursal
	WHERE	(abreviaturaArg IS NULL OR (CHAR_LENGTH(TRIM(abreviaturaArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Sucursal.abreviatura)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(abreviaturaArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Sucursal_abreviatura(null::VARCHAR(5));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Sucursal_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Sucursal_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Sucursal;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Sucursal_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Sucursal_cantidadCaracteresClientes() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Sucursal_cantidadCaracteresClientes() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(cantidadCaracteresClientes),0) + 1)::INTEGER FROM massoftware.Sucursal;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Sucursal_cantidadCaracteresClientes();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Sucursal_cantidadCaracteresProveedores() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Sucursal_cantidadCaracteresProveedores() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(cantidadCaracteresProveedores),0) + 1)::INTEGER FROM massoftware.Sucursal;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Sucursal_cantidadCaracteresProveedores();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Sucursal_clientesOcacionalesDesde() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Sucursal_clientesOcacionalesDesde() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(clientesOcacionalesDesde),0) + 1)::INTEGER FROM massoftware.Sucursal;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Sucursal_clientesOcacionalesDesde();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Sucursal_clientesOcacionalesHasta() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Sucursal_clientesOcacionalesHasta() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(clientesOcacionalesHasta),0) + 1)::INTEGER FROM massoftware.Sucursal;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Sucursal_clientesOcacionalesHasta();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Sucursal_numeroCobranzaDesde() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Sucursal_numeroCobranzaDesde() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numeroCobranzaDesde),0) + 1)::INTEGER FROM massoftware.Sucursal;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Sucursal_numeroCobranzaDesde();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Sucursal_numeroCobranzaHasta() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Sucursal_numeroCobranzaHasta() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numeroCobranzaHasta),0) + 1)::INTEGER FROM massoftware.Sucursal;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Sucursal_numeroCobranzaHasta();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_SucursalById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_SucursalById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.Sucursal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Sucursal.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.Sucursal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Sucursal.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Sucursal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Sucursal.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_SucursalById('xxx');

-- SELECT * FROM massoftware.d_SucursalById((SELECT Sucursal.id FROM massoftware.Sucursal LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Sucursal(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, tipoSucursalArg VARCHAR(36)
		, cuentaClientesDesdeArg VARCHAR(7)
		, cuentaClientesHastaArg VARCHAR(7)
		, cantidadCaracteresClientesArg INTEGER
		, identificacionNumericaClientesArg BOOLEAN
		, permiteCambiarClientesArg BOOLEAN
		, cuentaProveedoresDesdeArg VARCHAR(6)
		, cuentaProveedoresHastaArg VARCHAR(6)
		, cantidadCaracteresProveedoresArg INTEGER
		, identificacionNumericaProveedoresArg BOOLEAN
		, permiteCambiarProveedoresArg BOOLEAN
		, clientesOcacionalesDesdeArg INTEGER
		, clientesOcacionalesHastaArg INTEGER
		, numeroCobranzaDesdeArg INTEGER
		, numeroCobranzaHastaArg INTEGER
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Sucursal(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, tipoSucursalArg VARCHAR(36)
		, cuentaClientesDesdeArg VARCHAR(7)
		, cuentaClientesHastaArg VARCHAR(7)
		, cantidadCaracteresClientesArg INTEGER
		, identificacionNumericaClientesArg BOOLEAN
		, permiteCambiarClientesArg BOOLEAN
		, cuentaProveedoresDesdeArg VARCHAR(6)
		, cuentaProveedoresHastaArg VARCHAR(6)
		, cantidadCaracteresProveedoresArg INTEGER
		, identificacionNumericaProveedoresArg BOOLEAN
		, permiteCambiarProveedoresArg BOOLEAN
		, clientesOcacionalesDesdeArg INTEGER
		, clientesOcacionalesHastaArg INTEGER
		, numeroCobranzaDesdeArg INTEGER
		, numeroCobranzaHastaArg INTEGER
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF identificacionNumericaClientesArg IS NULL THEN

		identificacionNumericaClientesArg = false;

	END IF;

	IF permiteCambiarClientesArg IS NULL THEN

		permiteCambiarClientesArg = false;

	END IF;

	IF identificacionNumericaProveedoresArg IS NULL THEN

		identificacionNumericaProveedoresArg = false;

	END IF;

	IF permiteCambiarProveedoresArg IS NULL THEN

		permiteCambiarProveedoresArg = false;

	END IF;

	INSERT INTO massoftware.Sucursal(id, numero, nombre, abreviatura, tipoSucursal, cuentaClientesDesde, cuentaClientesHasta, cantidadCaracteresClientes, identificacionNumericaClientes, permiteCambiarClientes, cuentaProveedoresDesde, cuentaProveedoresHasta, cantidadCaracteresProveedores, identificacionNumericaProveedores, permiteCambiarProveedores, clientesOcacionalesDesde, clientesOcacionalesHasta, numeroCobranzaDesde, numeroCobranzaHasta) VALUES (idArg, numeroArg, nombreArg, abreviaturaArg, tipoSucursalArg, cuentaClientesDesdeArg, cuentaClientesHastaArg, cantidadCaracteresClientesArg, identificacionNumericaClientesArg, permiteCambiarClientesArg, cuentaProveedoresDesdeArg, cuentaProveedoresHastaArg, cantidadCaracteresProveedoresArg, identificacionNumericaProveedoresArg, permiteCambiarProveedoresArg, clientesOcacionalesDesdeArg, clientesOcacionalesHastaArg, numeroCobranzaDesdeArg, numeroCobranzaHastaArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Sucursal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Sucursal.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Sucursal(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(5)
		, null::VARCHAR(36)
		, null::VARCHAR(7)
		, null::VARCHAR(7)
		, null::INTEGER
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(6)
		, null::VARCHAR(6)
		, null::INTEGER
		, null::BOOLEAN
		, null::BOOLEAN
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Sucursal(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, tipoSucursalArg VARCHAR(36)
		, cuentaClientesDesdeArg VARCHAR(7)
		, cuentaClientesHastaArg VARCHAR(7)
		, cantidadCaracteresClientesArg INTEGER
		, identificacionNumericaClientesArg BOOLEAN
		, permiteCambiarClientesArg BOOLEAN
		, cuentaProveedoresDesdeArg VARCHAR(6)
		, cuentaProveedoresHastaArg VARCHAR(6)
		, cantidadCaracteresProveedoresArg INTEGER
		, identificacionNumericaProveedoresArg BOOLEAN
		, permiteCambiarProveedoresArg BOOLEAN
		, clientesOcacionalesDesdeArg INTEGER
		, clientesOcacionalesHastaArg INTEGER
		, numeroCobranzaDesdeArg INTEGER
		, numeroCobranzaHastaArg INTEGER
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Sucursal(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, tipoSucursalArg VARCHAR(36)
		, cuentaClientesDesdeArg VARCHAR(7)
		, cuentaClientesHastaArg VARCHAR(7)
		, cantidadCaracteresClientesArg INTEGER
		, identificacionNumericaClientesArg BOOLEAN
		, permiteCambiarClientesArg BOOLEAN
		, cuentaProveedoresDesdeArg VARCHAR(6)
		, cuentaProveedoresHastaArg VARCHAR(6)
		, cantidadCaracteresProveedoresArg INTEGER
		, identificacionNumericaProveedoresArg BOOLEAN
		, permiteCambiarProveedoresArg BOOLEAN
		, clientesOcacionalesDesdeArg INTEGER
		, clientesOcacionalesHastaArg INTEGER
		, numeroCobranzaDesdeArg INTEGER
		, numeroCobranzaHastaArg INTEGER
) RETURNS BOOLEAN AS $$

BEGIN

	IF identificacionNumericaClientesArg IS NULL THEN

		identificacionNumericaClientesArg = false;

	END IF;

	IF permiteCambiarClientesArg IS NULL THEN

		permiteCambiarClientesArg = false;

	END IF;

	IF identificacionNumericaProveedoresArg IS NULL THEN

		identificacionNumericaProveedoresArg = false;

	END IF;

	IF permiteCambiarProveedoresArg IS NULL THEN

		permiteCambiarProveedoresArg = false;

	END IF;

	UPDATE massoftware.Sucursal SET 
		  numero = numeroArg
		, nombre = nombreArg
		, abreviatura = abreviaturaArg
		, tipoSucursal = tipoSucursalArg
		, cuentaClientesDesde = cuentaClientesDesdeArg
		, cuentaClientesHasta = cuentaClientesHastaArg
		, cantidadCaracteresClientes = cantidadCaracteresClientesArg
		, identificacionNumericaClientes = identificacionNumericaClientesArg
		, permiteCambiarClientes = permiteCambiarClientesArg
		, cuentaProveedoresDesde = cuentaProveedoresDesdeArg
		, cuentaProveedoresHasta = cuentaProveedoresHastaArg
		, cantidadCaracteresProveedores = cantidadCaracteresProveedoresArg
		, identificacionNumericaProveedores = identificacionNumericaProveedoresArg
		, permiteCambiarProveedores = permiteCambiarProveedoresArg
		, clientesOcacionalesDesde = clientesOcacionalesDesdeArg
		, clientesOcacionalesHasta = clientesOcacionalesHastaArg
		, numeroCobranzaDesde = numeroCobranzaDesdeArg
		, numeroCobranzaHasta = numeroCobranzaHastaArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Sucursal.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Sucursal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Sucursal.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Sucursal(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(5)
		, null::VARCHAR(36)
		, null::VARCHAR(7)
		, null::VARCHAR(7)
		, null::INTEGER
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(6)
		, null::VARCHAR(6)
		, null::INTEGER
		, null::BOOLEAN
		, null::BOOLEAN
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
);

*/

DROP TYPE IF EXISTS massoftware.t_Sucursal_1 CASCADE;

CREATE TYPE massoftware.t_Sucursal_1 AS (

	  Sucursal_id                               	VARCHAR(36)		-- 0	Sucursal.id
	, Sucursal_numero                           	INTEGER    		-- 1	Sucursal.numero
	, Sucursal_nombre                           	VARCHAR(50)		-- 2	Sucursal.nombre
	, Sucursal_abreviatura                      	VARCHAR(5) 		-- 3	Sucursal.abreviatura
	, TipoSucursal_4_id                         	VARCHAR(36)		-- 4	Sucursal.TipoSucursal.id
	, TipoSucursal_4_numero                     	INTEGER    		-- 5	Sucursal.TipoSucursal.numero
	, TipoSucursal_4_nombre                     	VARCHAR(50)		-- 6	Sucursal.TipoSucursal.nombre
	, Sucursal_cuentaClientesDesde              	VARCHAR(7) 		-- 7	Sucursal.cuentaClientesDesde
	, Sucursal_cuentaClientesHasta              	VARCHAR(7) 		-- 8	Sucursal.cuentaClientesHasta
	, Sucursal_cantidadCaracteresClientes       	INTEGER    		-- 9	Sucursal.cantidadCaracteresClientes
	, Sucursal_identificacionNumericaClientes   	BOOLEAN    		-- 10	Sucursal.identificacionNumericaClientes
	, Sucursal_permiteCambiarClientes           	BOOLEAN    		-- 11	Sucursal.permiteCambiarClientes
	, Sucursal_cuentaProveedoresDesde           	VARCHAR(6) 		-- 12	Sucursal.cuentaProveedoresDesde
	, Sucursal_cuentaProveedoresHasta           	VARCHAR(6) 		-- 13	Sucursal.cuentaProveedoresHasta
	, Sucursal_cantidadCaracteresProveedores    	INTEGER    		-- 14	Sucursal.cantidadCaracteresProveedores
	, Sucursal_identificacionNumericaProveedores	BOOLEAN    		-- 15	Sucursal.identificacionNumericaProveedores
	, Sucursal_permiteCambiarProveedores        	BOOLEAN    		-- 16	Sucursal.permiteCambiarProveedores
	, Sucursal_clientesOcacionalesDesde         	INTEGER    		-- 17	Sucursal.clientesOcacionalesDesde
	, Sucursal_clientesOcacionalesHasta         	INTEGER    		-- 18	Sucursal.clientesOcacionalesHasta
	, Sucursal_numeroCobranzaDesde              	INTEGER    		-- 19	Sucursal.numeroCobranzaDesde
	, Sucursal_numeroCobranzaHasta              	INTEGER    		-- 20	Sucursal.numeroCobranzaHasta

);

DROP FUNCTION IF EXISTS massoftware.f_Sucursal (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Sucursal (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.Sucursal AS $$

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
				  Sucursal.id                                    AS Sucursal_id                               	-- 0	.id                              		VARCHAR(36)
				, Sucursal.numero                                AS Sucursal_numero                           	-- 1	.numero                          		INTEGER
				, Sucursal.nombre                                AS Sucursal_nombre                           	-- 2	.nombre                          		VARCHAR(50)
				, Sucursal.abreviatura                           AS Sucursal_abreviatura                      	-- 3	.abreviatura                     		VARCHAR(5)
				, Sucursal.tipoSucursal                          AS Sucursal_tipoSucursal                     	-- 4	.tipoSucursal                    		VARCHAR(36)	TipoSucursal.id
				, Sucursal.cuentaClientesDesde                   AS Sucursal_cuentaClientesDesde              	-- 5	.cuentaClientesDesde             		VARCHAR(7)
				, Sucursal.cuentaClientesHasta                   AS Sucursal_cuentaClientesHasta              	-- 6	.cuentaClientesHasta             		VARCHAR(7)
				, Sucursal.cantidadCaracteresClientes            AS Sucursal_cantidadCaracteresClientes       	-- 7	.cantidadCaracteresClientes      		INTEGER
				, Sucursal.identificacionNumericaClientes        AS Sucursal_identificacionNumericaClientes   	-- 8	.identificacionNumericaClientes  		BOOLEAN
				, Sucursal.permiteCambiarClientes                AS Sucursal_permiteCambiarClientes           	-- 9	.permiteCambiarClientes          		BOOLEAN
				, Sucursal.cuentaProveedoresDesde                AS Sucursal_cuentaProveedoresDesde           	-- 10	.cuentaProveedoresDesde          		VARCHAR(6)
				, Sucursal.cuentaProveedoresHasta                AS Sucursal_cuentaProveedoresHasta           	-- 11	.cuentaProveedoresHasta          		VARCHAR(6)
				, Sucursal.cantidadCaracteresProveedores         AS Sucursal_cantidadCaracteresProveedores    	-- 12	.cantidadCaracteresProveedores   		INTEGER
				, Sucursal.identificacionNumericaProveedores     AS Sucursal_identificacionNumericaProveedores	-- 13	.identificacionNumericaProveedores		BOOLEAN
				, Sucursal.permiteCambiarProveedores             AS Sucursal_permiteCambiarProveedores        	-- 14	.permiteCambiarProveedores       		BOOLEAN
				, Sucursal.clientesOcacionalesDesde              AS Sucursal_clientesOcacionalesDesde         	-- 15	.clientesOcacionalesDesde        		INTEGER
				, Sucursal.clientesOcacionalesHasta              AS Sucursal_clientesOcacionalesHasta         	-- 16	.clientesOcacionalesHasta        		INTEGER
				, Sucursal.numeroCobranzaDesde                   AS Sucursal_numeroCobranzaDesde              	-- 17	.numeroCobranzaDesde             		INTEGER
				, Sucursal.numeroCobranzaHasta                   AS Sucursal_numeroCobranzaHasta              	-- 18	.numeroCobranzaHasta             		INTEGER

		FROM	massoftware.Sucursal

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Sucursal.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Sucursal.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Sucursal.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Sucursal.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_SucursalById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_SucursalById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Sucursal AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Sucursal ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Sucursal ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_SucursalById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Sucursal_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Sucursal_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.t_Sucursal_1 AS $$

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
				  Sucursal.id                                    AS Sucursal_id                               	-- 0	.id                              		VARCHAR(36)
				, Sucursal.numero                                AS Sucursal_numero                           	-- 1	.numero                          		INTEGER
				, Sucursal.nombre                                AS Sucursal_nombre                           	-- 2	.nombre                          		VARCHAR(50)
				, Sucursal.abreviatura                           AS Sucursal_abreviatura                      	-- 3	.abreviatura                     		VARCHAR(5)
				, TipoSucursal_4.id                              AS TipoSucursal_4_id                         	-- 4	.TipoSucursal.id                 		VARCHAR(36)
				, TipoSucursal_4.numero                          AS TipoSucursal_4_numero                     	-- 5	.TipoSucursal.numero             		INTEGER
				, TipoSucursal_4.nombre                          AS TipoSucursal_4_nombre                     	-- 6	.TipoSucursal.nombre             		VARCHAR(50)
				, Sucursal.cuentaClientesDesde                   AS Sucursal_cuentaClientesDesde              	-- 7	.cuentaClientesDesde             		VARCHAR(7)
				, Sucursal.cuentaClientesHasta                   AS Sucursal_cuentaClientesHasta              	-- 8	.cuentaClientesHasta             		VARCHAR(7)
				, Sucursal.cantidadCaracteresClientes            AS Sucursal_cantidadCaracteresClientes       	-- 9	.cantidadCaracteresClientes      		INTEGER
				, Sucursal.identificacionNumericaClientes        AS Sucursal_identificacionNumericaClientes   	-- 10	.identificacionNumericaClientes  		BOOLEAN
				, Sucursal.permiteCambiarClientes                AS Sucursal_permiteCambiarClientes           	-- 11	.permiteCambiarClientes          		BOOLEAN
				, Sucursal.cuentaProveedoresDesde                AS Sucursal_cuentaProveedoresDesde           	-- 12	.cuentaProveedoresDesde          		VARCHAR(6)
				, Sucursal.cuentaProveedoresHasta                AS Sucursal_cuentaProveedoresHasta           	-- 13	.cuentaProveedoresHasta          		VARCHAR(6)
				, Sucursal.cantidadCaracteresProveedores         AS Sucursal_cantidadCaracteresProveedores    	-- 14	.cantidadCaracteresProveedores   		INTEGER
				, Sucursal.identificacionNumericaProveedores     AS Sucursal_identificacionNumericaProveedores	-- 15	.identificacionNumericaProveedores		BOOLEAN
				, Sucursal.permiteCambiarProveedores             AS Sucursal_permiteCambiarProveedores        	-- 16	.permiteCambiarProveedores       		BOOLEAN
				, Sucursal.clientesOcacionalesDesde              AS Sucursal_clientesOcacionalesDesde         	-- 17	.clientesOcacionalesDesde        		INTEGER
				, Sucursal.clientesOcacionalesHasta              AS Sucursal_clientesOcacionalesHasta         	-- 18	.clientesOcacionalesHasta        		INTEGER
				, Sucursal.numeroCobranzaDesde                   AS Sucursal_numeroCobranzaDesde              	-- 19	.numeroCobranzaDesde             		INTEGER
				, Sucursal.numeroCobranzaHasta                   AS Sucursal_numeroCobranzaHasta              	-- 20	.numeroCobranzaHasta             		INTEGER

		FROM	massoftware.Sucursal
			LEFT JOIN massoftware.TipoSucursal AS TipoSucursal_4        ON Sucursal.tipoSucursal = TipoSucursal_4.id 	-- 4 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Sucursal.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Sucursal.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Sucursal.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Sucursal.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_SucursalById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_SucursalById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Sucursal_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Sucursal_1 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Sucursal_1 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_SucursalById_1 ('xxx'); 