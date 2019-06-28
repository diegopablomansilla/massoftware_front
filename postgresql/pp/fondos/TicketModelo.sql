
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TicketModelo                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TicketModelo



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.TicketModelo CASCADE;

CREATE TABLE massoftware.TicketModelo
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº modelo
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT TicketModelo_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- ticket
	ticket VARCHAR(36)  NOT NULL  REFERENCES massoftware.Ticket (id), 
	
	-- Prueba lectura
	pruebaLectura VARCHAR(50), 
	
	-- activo
	activo BOOLEAN NOT NULL, 
	
	-- Longitud lectura
	longitudLectura INTEGER CONSTRAINT TicketModelo_longitudLectura_chk CHECK ( longitudLectura >= 0  ), 
	
	-- Posición
	identificacionPosicion INTEGER CONSTRAINT TicketModelo_identificacionPosicion_chk CHECK ( identificacionPosicion >= 0  ), 
	
	-- Identificación
	identificacion INTEGER CONSTRAINT TicketModelo_identificacion_chk CHECK ( identificacion >= 0  ), 
	
	-- Posición
	importePosicion INTEGER CONSTRAINT TicketModelo_importePosicion_chk CHECK ( importePosicion >= 0  ), 
	
	-- Longitud
	longitud INTEGER CONSTRAINT TicketModelo_longitud_chk CHECK ( longitud >= 0  ), 
	
	-- Cantidad decimales
	cantidadDecimales INTEGER CONSTRAINT TicketModelo_cantidadDecimales_chk CHECK ( cantidadDecimales >= 0  ), 
	
	-- Número posición
	numeroPosicion INTEGER CONSTRAINT TicketModelo_numeroPosicion_chk CHECK ( numeroPosicion >= 0  ), 
	
	-- Número longitud
	numeroLongitud INTEGER CONSTRAINT TicketModelo_numeroLongitud_chk CHECK ( numeroLongitud >= 0  ), 
	
	-- Prefijo identificación importación
	prefijoIdentificacion VARCHAR(10), 
	
	-- Posición prefijo
	posicionPrefijo INTEGER CONSTRAINT TicketModelo_posicionPrefijo_chk CHECK ( posicionPrefijo >= 0  )
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_TicketModelo_nombre ON massoftware.TicketModelo (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatTicketModelo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatTicketModelo() RETURNS TRIGGER AS $formatTicketModelo$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.ticket := massoftware.white_is_null(NEW.ticket);
	 NEW.pruebaLectura := massoftware.white_is_null(NEW.pruebaLectura);
	 NEW.prefijoIdentificacion := massoftware.white_is_null(NEW.prefijoIdentificacion);

	RETURN NEW;
END;
$formatTicketModelo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTicketModelo ON massoftware.TicketModelo CASCADE;

CREATE TRIGGER tgFormatTicketModelo BEFORE INSERT OR UPDATE
	ON massoftware.TicketModelo FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatTicketModelo();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.TicketModelo;

-- SELECT * FROM massoftware.TicketModelo LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.TicketModelo;

-- SELECT * FROM massoftware.TicketModelo WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_TicketModelo_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_TicketModelo_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.TicketModelo
	WHERE	(numeroArg IS NULL OR TicketModelo.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_TicketModelo_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_TicketModelo_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_TicketModelo_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.TicketModelo
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(TicketModelo.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_TicketModelo_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_longitudLectura() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_longitudLectura() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(longitudLectura),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_longitudLectura();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_identificacionPosicion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_identificacionPosicion() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(identificacionPosicion),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_identificacionPosicion();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_identificacion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_identificacion() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(identificacion),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_identificacion();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_importePosicion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_importePosicion() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(importePosicion),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_importePosicion();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_longitud() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_longitud() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(longitud),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_longitud();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_cantidadDecimales() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_cantidadDecimales() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(cantidadDecimales),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_cantidadDecimales();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_numeroPosicion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_numeroPosicion() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numeroPosicion),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_numeroPosicion();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_numeroLongitud() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_numeroLongitud() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numeroLongitud),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_numeroLongitud();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_posicionPrefijo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_posicionPrefijo() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(posicionPrefijo),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_posicionPrefijo();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_TicketModeloById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_TicketModeloById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.TicketModelo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TicketModelo.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.TicketModelo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TicketModelo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TicketModelo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TicketModelo.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_TicketModeloById('xxx');

-- SELECT * FROM massoftware.d_TicketModeloById((SELECT TicketModelo.id FROM massoftware.TicketModelo LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_TicketModelo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, ticketArg VARCHAR(36)
		, pruebaLecturaArg VARCHAR(50)
		, activoArg BOOLEAN
		, longitudLecturaArg INTEGER
		, identificacionPosicionArg INTEGER
		, identificacionArg INTEGER
		, importePosicionArg INTEGER
		, longitudArg INTEGER
		, cantidadDecimalesArg INTEGER
		, numeroPosicionArg INTEGER
		, numeroLongitudArg INTEGER
		, prefijoIdentificacionArg VARCHAR(10)
		, posicionPrefijoArg INTEGER
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_TicketModelo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, ticketArg VARCHAR(36)
		, pruebaLecturaArg VARCHAR(50)
		, activoArg BOOLEAN
		, longitudLecturaArg INTEGER
		, identificacionPosicionArg INTEGER
		, identificacionArg INTEGER
		, importePosicionArg INTEGER
		, longitudArg INTEGER
		, cantidadDecimalesArg INTEGER
		, numeroPosicionArg INTEGER
		, numeroLongitudArg INTEGER
		, prefijoIdentificacionArg VARCHAR(10)
		, posicionPrefijoArg INTEGER
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF activoArg IS NULL THEN

		activoArg = false;

	END IF;

	INSERT INTO massoftware.TicketModelo(id, numero, nombre, ticket, pruebaLectura, activo, longitudLectura, identificacionPosicion, identificacion, importePosicion, longitud, cantidadDecimales, numeroPosicion, numeroLongitud, prefijoIdentificacion, posicionPrefijo) VALUES (idArg, numeroArg, nombreArg, ticketArg, pruebaLecturaArg, activoArg, longitudLecturaArg, identificacionPosicionArg, identificacionArg, importePosicionArg, longitudArg, cantidadDecimalesArg, numeroPosicionArg, numeroLongitudArg, prefijoIdentificacionArg, posicionPrefijoArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.TicketModelo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TicketModelo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_TicketModelo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::VARCHAR(50)
		, null::BOOLEAN
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::VARCHAR(10)
		, null::INTEGER
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_TicketModelo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, ticketArg VARCHAR(36)
		, pruebaLecturaArg VARCHAR(50)
		, activoArg BOOLEAN
		, longitudLecturaArg INTEGER
		, identificacionPosicionArg INTEGER
		, identificacionArg INTEGER
		, importePosicionArg INTEGER
		, longitudArg INTEGER
		, cantidadDecimalesArg INTEGER
		, numeroPosicionArg INTEGER
		, numeroLongitudArg INTEGER
		, prefijoIdentificacionArg VARCHAR(10)
		, posicionPrefijoArg INTEGER
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_TicketModelo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, ticketArg VARCHAR(36)
		, pruebaLecturaArg VARCHAR(50)
		, activoArg BOOLEAN
		, longitudLecturaArg INTEGER
		, identificacionPosicionArg INTEGER
		, identificacionArg INTEGER
		, importePosicionArg INTEGER
		, longitudArg INTEGER
		, cantidadDecimalesArg INTEGER
		, numeroPosicionArg INTEGER
		, numeroLongitudArg INTEGER
		, prefijoIdentificacionArg VARCHAR(10)
		, posicionPrefijoArg INTEGER
) RETURNS BOOLEAN AS $$

BEGIN

	IF activoArg IS NULL THEN

		activoArg = false;

	END IF;

	UPDATE massoftware.TicketModelo SET 
		  numero = numeroArg
		, nombre = nombreArg
		, ticket = ticketArg
		, pruebaLectura = pruebaLecturaArg
		, activo = activoArg
		, longitudLectura = longitudLecturaArg
		, identificacionPosicion = identificacionPosicionArg
		, identificacion = identificacionArg
		, importePosicion = importePosicionArg
		, longitud = longitudArg
		, cantidadDecimales = cantidadDecimalesArg
		, numeroPosicion = numeroPosicionArg
		, numeroLongitud = numeroLongitudArg
		, prefijoIdentificacion = prefijoIdentificacionArg
		, posicionPrefijo = posicionPrefijoArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TicketModelo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TicketModelo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TicketModelo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_TicketModelo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::VARCHAR(50)
		, null::BOOLEAN
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::VARCHAR(10)
		, null::INTEGER
);

*/

DROP TYPE IF EXISTS massoftware.t_TicketModelo_1 CASCADE;

CREATE TYPE massoftware.t_TicketModelo_1 AS (

	  TicketModelo_id                    	VARCHAR(36)  		-- 0	TicketModelo.id
	, TicketModelo_numero                	INTEGER      		-- 1	TicketModelo.numero
	, TicketModelo_nombre                	VARCHAR(50)  		-- 2	TicketModelo.nombre
	, Ticket_3_id                        	VARCHAR(36)  		-- 3	TicketModelo.Ticket.id
	, Ticket_3_numero                    	INTEGER      		-- 4	TicketModelo.Ticket.numero
	, Ticket_3_nombre                    	VARCHAR(50)  		-- 5	TicketModelo.Ticket.nombre
	, Ticket_3_fechaActualizacion        	DATE         		-- 6	TicketModelo.Ticket.fechaActualizacion
	, Ticket_3_cantidadPorLotes          	INTEGER      		-- 7	TicketModelo.Ticket.cantidadPorLotes
	, Ticket_3_ticketControlDenunciados  	VARCHAR(36)  		-- 8	TicketModelo.Ticket.ticketControlDenunciados
	, Ticket_3_valorMaximo               	DECIMAL(13,5)		-- 9	TicketModelo.Ticket.valorMaximo
	, TicketModelo_pruebaLectura         	VARCHAR(50)  		-- 10	TicketModelo.pruebaLectura
	, TicketModelo_activo                	BOOLEAN      		-- 11	TicketModelo.activo
	, TicketModelo_longitudLectura       	INTEGER      		-- 12	TicketModelo.longitudLectura
	, TicketModelo_identificacionPosicion	INTEGER      		-- 13	TicketModelo.identificacionPosicion
	, TicketModelo_identificacion        	INTEGER      		-- 14	TicketModelo.identificacion
	, TicketModelo_importePosicion       	INTEGER      		-- 15	TicketModelo.importePosicion
	, TicketModelo_longitud              	INTEGER      		-- 16	TicketModelo.longitud
	, TicketModelo_cantidadDecimales     	INTEGER      		-- 17	TicketModelo.cantidadDecimales
	, TicketModelo_numeroPosicion        	INTEGER      		-- 18	TicketModelo.numeroPosicion
	, TicketModelo_numeroLongitud        	INTEGER      		-- 19	TicketModelo.numeroLongitud
	, TicketModelo_prefijoIdentificacion 	VARCHAR(10)  		-- 20	TicketModelo.prefijoIdentificacion
	, TicketModelo_posicionPrefijo       	INTEGER      		-- 21	TicketModelo.posicionPrefijo

);

DROP TYPE IF EXISTS massoftware.t_TicketModelo_2 CASCADE;

CREATE TYPE massoftware.t_TicketModelo_2 AS (

	  TicketModelo_id                    	VARCHAR(36)  		-- 0	TicketModelo.id
	, TicketModelo_numero                	INTEGER      		-- 1	TicketModelo.numero
	, TicketModelo_nombre                	VARCHAR(50)  		-- 2	TicketModelo.nombre
	, Ticket_3_id                        	VARCHAR(36)  		-- 3	TicketModelo.Ticket.id
	, Ticket_3_numero                    	INTEGER      		-- 4	TicketModelo.Ticket.numero
	, Ticket_3_nombre                    	VARCHAR(50)  		-- 5	TicketModelo.Ticket.nombre
	, Ticket_3_fechaActualizacion        	DATE         		-- 6	TicketModelo.Ticket.fechaActualizacion
	, Ticket_3_cantidadPorLotes          	INTEGER      		-- 7	TicketModelo.Ticket.cantidadPorLotes
	, TicketControlDenunciados_8_id      	VARCHAR(36)  		-- 8	TicketModelo.Ticket.TicketControlDenunciados.id
	, TicketControlDenunciados_8_numero  	INTEGER      		-- 9	TicketModelo.Ticket.TicketControlDenunciados.numero
	, TicketControlDenunciados_8_nombre  	VARCHAR(50)  		-- 10	TicketModelo.Ticket.TicketControlDenunciados.nombre
	, Ticket_3_valorMaximo               	DECIMAL(13,5)		-- 11	TicketModelo.Ticket.valorMaximo
	, TicketModelo_pruebaLectura         	VARCHAR(50)  		-- 12	TicketModelo.pruebaLectura
	, TicketModelo_activo                	BOOLEAN      		-- 13	TicketModelo.activo
	, TicketModelo_longitudLectura       	INTEGER      		-- 14	TicketModelo.longitudLectura
	, TicketModelo_identificacionPosicion	INTEGER      		-- 15	TicketModelo.identificacionPosicion
	, TicketModelo_identificacion        	INTEGER      		-- 16	TicketModelo.identificacion
	, TicketModelo_importePosicion       	INTEGER      		-- 17	TicketModelo.importePosicion
	, TicketModelo_longitud              	INTEGER      		-- 18	TicketModelo.longitud
	, TicketModelo_cantidadDecimales     	INTEGER      		-- 19	TicketModelo.cantidadDecimales
	, TicketModelo_numeroPosicion        	INTEGER      		-- 20	TicketModelo.numeroPosicion
	, TicketModelo_numeroLongitud        	INTEGER      		-- 21	TicketModelo.numeroLongitud
	, TicketModelo_prefijoIdentificacion 	VARCHAR(10)  		-- 22	TicketModelo.prefijoIdentificacion
	, TicketModelo_posicionPrefijo       	INTEGER      		-- 23	TicketModelo.posicionPrefijo

);

DROP FUNCTION IF EXISTS massoftware.f_TicketModelo (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, ticketArg8        VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TicketModelo (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, ticketArg8        VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.TicketModelo AS $$

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
				  TicketModelo.id                        AS TicketModelo_id                    	-- 0	.id                   		VARCHAR(36)
				, TicketModelo.numero                    AS TicketModelo_numero                	-- 1	.numero               		INTEGER
				, TicketModelo.nombre                    AS TicketModelo_nombre                	-- 2	.nombre               		VARCHAR(50)
				, TicketModelo.ticket                    AS TicketModelo_ticket                	-- 3	.ticket               		VARCHAR(36)	Ticket.id
				, TicketModelo.pruebaLectura             AS TicketModelo_pruebaLectura         	-- 4	.pruebaLectura        		VARCHAR(50)
				, TicketModelo.activo                    AS TicketModelo_activo                	-- 5	.activo               		BOOLEAN
				, TicketModelo.longitudLectura           AS TicketModelo_longitudLectura       	-- 6	.longitudLectura      		INTEGER
				, TicketModelo.identificacionPosicion    AS TicketModelo_identificacionPosicion	-- 7	.identificacionPosicion		INTEGER
				, TicketModelo.identificacion            AS TicketModelo_identificacion        	-- 8	.identificacion       		INTEGER
				, TicketModelo.importePosicion           AS TicketModelo_importePosicion       	-- 9	.importePosicion      		INTEGER
				, TicketModelo.longitud                  AS TicketModelo_longitud              	-- 10	.longitud             		INTEGER
				, TicketModelo.cantidadDecimales         AS TicketModelo_cantidadDecimales     	-- 11	.cantidadDecimales    		INTEGER
				, TicketModelo.numeroPosicion            AS TicketModelo_numeroPosicion        	-- 12	.numeroPosicion       		INTEGER
				, TicketModelo.numeroLongitud            AS TicketModelo_numeroLongitud        	-- 13	.numeroLongitud       		INTEGER
				, TicketModelo.prefijoIdentificacion     AS TicketModelo_prefijoIdentificacion 	-- 14	.prefijoIdentificacion		VARCHAR(10)
				, TicketModelo.posicionPrefijo           AS TicketModelo_posicionPrefijo       	-- 15	.posicionPrefijo      		INTEGER

		FROM	massoftware.TicketModelo

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TicketModelo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' TicketModelo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' TicketModelo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(TicketModelo.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND ticketArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(ticketArg8)) > 0 THEN
		ticketArg8 = REPLACE(ticketArg8, '''', '''''');
		ticketArg8 = LOWER(TRIM(ticketArg8));
		ticketArg8 = TRANSLATE(ticketArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ticketArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(TicketModelo.ticket),
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

DROP FUNCTION IF EXISTS massoftware.f_TicketModeloById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TicketModeloById (idArg VARCHAR(36)) RETURNS SETOF massoftware.TicketModelo AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TicketModelo ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_TicketModelo ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_TicketModeloById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_TicketModelo_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, ticketArg8        VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TicketModelo_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, ticketArg8        VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_TicketModelo_1 AS $$

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
				  TicketModelo.id                         AS TicketModelo_id                    	-- 0	.id                            		VARCHAR(36)
				, TicketModelo.numero                     AS TicketModelo_numero                	-- 1	.numero                        		INTEGER
				, TicketModelo.nombre                     AS TicketModelo_nombre                	-- 2	.nombre                        		VARCHAR(50)
				, Ticket_3.id                             AS Ticket_3_id                        	-- 3	.Ticket.id                     		VARCHAR(36)
				, Ticket_3.numero                         AS Ticket_3_numero                    	-- 4	.Ticket.numero                 		INTEGER
				, Ticket_3.nombre                         AS Ticket_3_nombre                    	-- 5	.Ticket.nombre                 		VARCHAR(50)
				, Ticket_3.fechaActualizacion             AS Ticket_3_fechaActualizacion        	-- 6	.Ticket.fechaActualizacion     		DATE
				, Ticket_3.cantidadPorLotes               AS Ticket_3_cantidadPorLotes          	-- 7	.Ticket.cantidadPorLotes       		INTEGER
				, Ticket_3.ticketControlDenunciados       AS Ticket_3_ticketControlDenunciados  	-- 8	.Ticket.ticketControlDenunciados		VARCHAR(36)	TicketControlDenunciados.id
				, Ticket_3.valorMaximo                    AS Ticket_3_valorMaximo               	-- 9	.Ticket.valorMaximo            		DECIMAL(13,5)
				, TicketModelo.pruebaLectura              AS TicketModelo_pruebaLectura         	-- 10	.pruebaLectura                 		VARCHAR(50)
				, TicketModelo.activo                     AS TicketModelo_activo                	-- 11	.activo                        		BOOLEAN
				, TicketModelo.longitudLectura            AS TicketModelo_longitudLectura       	-- 12	.longitudLectura               		INTEGER
				, TicketModelo.identificacionPosicion     AS TicketModelo_identificacionPosicion	-- 13	.identificacionPosicion        		INTEGER
				, TicketModelo.identificacion             AS TicketModelo_identificacion        	-- 14	.identificacion                		INTEGER
				, TicketModelo.importePosicion            AS TicketModelo_importePosicion       	-- 15	.importePosicion               		INTEGER
				, TicketModelo.longitud                   AS TicketModelo_longitud              	-- 16	.longitud                      		INTEGER
				, TicketModelo.cantidadDecimales          AS TicketModelo_cantidadDecimales     	-- 17	.cantidadDecimales             		INTEGER
				, TicketModelo.numeroPosicion             AS TicketModelo_numeroPosicion        	-- 18	.numeroPosicion                		INTEGER
				, TicketModelo.numeroLongitud             AS TicketModelo_numeroLongitud        	-- 19	.numeroLongitud                		INTEGER
				, TicketModelo.prefijoIdentificacion      AS TicketModelo_prefijoIdentificacion 	-- 20	.prefijoIdentificacion         		VARCHAR(10)
				, TicketModelo.posicionPrefijo            AS TicketModelo_posicionPrefijo       	-- 21	.posicionPrefijo               		INTEGER

		FROM	massoftware.TicketModelo
			LEFT JOIN massoftware.Ticket AS Ticket_3        ON TicketModelo.ticket = Ticket_3.id 	-- 3 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TicketModelo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' TicketModelo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' TicketModelo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(TicketModelo.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND ticketArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(ticketArg8)) > 0 THEN
		ticketArg8 = REPLACE(ticketArg8, '''', '''''');
		ticketArg8 = LOWER(TRIM(ticketArg8));
		ticketArg8 = TRANSLATE(ticketArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ticketArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(TicketModelo.ticket),
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

DROP FUNCTION IF EXISTS massoftware.f_TicketModeloById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TicketModeloById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_TicketModelo_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TicketModelo_1 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_TicketModelo_1 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_TicketModeloById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_TicketModelo_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, ticketArg8        VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TicketModelo_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, ticketArg8        VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_TicketModelo_2 AS $$

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
				  TicketModelo.id                         AS TicketModelo_id                    	-- 0	.id                                   		VARCHAR(36)
				, TicketModelo.numero                     AS TicketModelo_numero                	-- 1	.numero                               		INTEGER
				, TicketModelo.nombre                     AS TicketModelo_nombre                	-- 2	.nombre                               		VARCHAR(50)
				, Ticket_3.id                             AS Ticket_3_id                        	-- 3	.Ticket.id                            		VARCHAR(36)
				, Ticket_3.numero                         AS Ticket_3_numero                    	-- 4	.Ticket.numero                        		INTEGER
				, Ticket_3.nombre                         AS Ticket_3_nombre                    	-- 5	.Ticket.nombre                        		VARCHAR(50)
				, Ticket_3.fechaActualizacion             AS Ticket_3_fechaActualizacion        	-- 6	.Ticket.fechaActualizacion            		DATE
				, Ticket_3.cantidadPorLotes               AS Ticket_3_cantidadPorLotes          	-- 7	.Ticket.cantidadPorLotes              		INTEGER
				, TicketControlDenunciados_8.id           AS TicketControlDenunciados_8_id      	-- 8	.Ticket.TicketControlDenunciados.id   		VARCHAR(36)
				, TicketControlDenunciados_8.numero       AS TicketControlDenunciados_8_numero  	-- 9	.Ticket.TicketControlDenunciados.numero		INTEGER
				, TicketControlDenunciados_8.nombre       AS TicketControlDenunciados_8_nombre  	-- 10	.Ticket.TicketControlDenunciados.nombre		VARCHAR(50)
				, Ticket_3.valorMaximo                    AS Ticket_3_valorMaximo               	-- 11	.Ticket.valorMaximo                   		DECIMAL(13,5)
				, TicketModelo.pruebaLectura              AS TicketModelo_pruebaLectura         	-- 12	.pruebaLectura                        		VARCHAR(50)
				, TicketModelo.activo                     AS TicketModelo_activo                	-- 13	.activo                               		BOOLEAN
				, TicketModelo.longitudLectura            AS TicketModelo_longitudLectura       	-- 14	.longitudLectura                      		INTEGER
				, TicketModelo.identificacionPosicion     AS TicketModelo_identificacionPosicion	-- 15	.identificacionPosicion               		INTEGER
				, TicketModelo.identificacion             AS TicketModelo_identificacion        	-- 16	.identificacion                       		INTEGER
				, TicketModelo.importePosicion            AS TicketModelo_importePosicion       	-- 17	.importePosicion                      		INTEGER
				, TicketModelo.longitud                   AS TicketModelo_longitud              	-- 18	.longitud                             		INTEGER
				, TicketModelo.cantidadDecimales          AS TicketModelo_cantidadDecimales     	-- 19	.cantidadDecimales                    		INTEGER
				, TicketModelo.numeroPosicion             AS TicketModelo_numeroPosicion        	-- 20	.numeroPosicion                       		INTEGER
				, TicketModelo.numeroLongitud             AS TicketModelo_numeroLongitud        	-- 21	.numeroLongitud                       		INTEGER
				, TicketModelo.prefijoIdentificacion      AS TicketModelo_prefijoIdentificacion 	-- 22	.prefijoIdentificacion                		VARCHAR(10)
				, TicketModelo.posicionPrefijo            AS TicketModelo_posicionPrefijo       	-- 23	.posicionPrefijo                      		INTEGER

		FROM	massoftware.TicketModelo
			LEFT JOIN massoftware.Ticket AS Ticket_3                             ON TicketModelo.ticket = Ticket_3.id 	-- 3 LEFT LEVEL: 1
				LEFT JOIN massoftware.TicketControlDenunciados AS TicketControlDenunciados_8           ON Ticket_3.ticketControlDenunciados = TicketControlDenunciados_8.id 	-- 8 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TicketModelo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' TicketModelo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' TicketModelo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(TicketModelo.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND ticketArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(ticketArg8)) > 0 THEN
		ticketArg8 = REPLACE(ticketArg8, '''', '''''');
		ticketArg8 = LOWER(TRIM(ticketArg8));
		ticketArg8 = TRANSLATE(ticketArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ticketArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(TicketModelo.ticket),
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

DROP FUNCTION IF EXISTS massoftware.f_TicketModeloById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TicketModeloById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_TicketModelo_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TicketModelo_2 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_TicketModelo_2 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_TicketModeloById_2 ('xxx'); 