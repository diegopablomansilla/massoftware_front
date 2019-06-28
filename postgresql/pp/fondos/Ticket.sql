
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Ticket                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Ticket



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Ticket CASCADE;

CREATE TABLE massoftware.Ticket
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº ticket
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Ticket_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Fecha actualización
	fechaActualizacion DATE, 
	
	-- Cantidad por lotes
	cantidadPorLotes INTEGER CONSTRAINT Ticket_cantidadPorLotes_chk CHECK ( cantidadPorLotes >= 1  ), 
	
	-- Control denunciados
	ticketControlDenunciados VARCHAR(36)  NOT NULL  REFERENCES massoftware.TicketControlDenunciados (id), 
	
	-- Valor máximo
	valorMaximo DECIMAL(13,5) CONSTRAINT Ticket_valorMaximo_chk CHECK ( valorMaximo >= 0 AND valorMaximo <= 99999.9999  )
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Ticket_nombre ON massoftware.Ticket (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatTicket() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatTicket() RETURNS TRIGGER AS $formatTicket$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.ticketControlDenunciados := massoftware.white_is_null(NEW.ticketControlDenunciados);

	RETURN NEW;
END;
$formatTicket$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTicket ON massoftware.Ticket CASCADE;

CREATE TRIGGER tgFormatTicket BEFORE INSERT OR UPDATE
	ON massoftware.Ticket FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatTicket();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Ticket;

-- SELECT * FROM massoftware.Ticket LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Ticket;

-- SELECT * FROM massoftware.Ticket WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Ticket_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Ticket_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Ticket
	WHERE	(numeroArg IS NULL OR Ticket.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Ticket_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Ticket_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Ticket_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Ticket
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Ticket.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Ticket_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Ticket_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Ticket_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Ticket;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Ticket_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Ticket_cantidadPorLotes() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Ticket_cantidadPorLotes() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(cantidadPorLotes),0) + 1)::INTEGER FROM massoftware.Ticket;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Ticket_cantidadPorLotes();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Ticket_valorMaximo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Ticket_valorMaximo() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(valorMaximo),0) + 1)::DECIMAL(13,5) FROM massoftware.Ticket;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Ticket_valorMaximo();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_TicketById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_TicketById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.Ticket WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ticket.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.Ticket WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ticket.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Ticket WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ticket.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_TicketById('xxx');

-- SELECT * FROM massoftware.d_TicketById((SELECT Ticket.id FROM massoftware.Ticket LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Ticket(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, fechaActualizacionArg DATE
		, cantidadPorLotesArg INTEGER
		, ticketControlDenunciadosArg VARCHAR(36)
		, valorMaximoArg DECIMAL(13,5)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Ticket(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, fechaActualizacionArg DATE
		, cantidadPorLotesArg INTEGER
		, ticketControlDenunciadosArg VARCHAR(36)
		, valorMaximoArg DECIMAL(13,5)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Ticket(id, numero, nombre, fechaActualizacion, cantidadPorLotes, ticketControlDenunciados, valorMaximo) VALUES (idArg, numeroArg, nombreArg, fechaActualizacionArg, cantidadPorLotesArg, ticketControlDenunciadosArg, valorMaximoArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Ticket WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ticket.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Ticket(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::DATE
		, null::INTEGER
		, null::VARCHAR(36)
		, null::DECIMAL(13,5)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Ticket(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, fechaActualizacionArg DATE
		, cantidadPorLotesArg INTEGER
		, ticketControlDenunciadosArg VARCHAR(36)
		, valorMaximoArg DECIMAL(13,5)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Ticket(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, fechaActualizacionArg DATE
		, cantidadPorLotesArg INTEGER
		, ticketControlDenunciadosArg VARCHAR(36)
		, valorMaximoArg DECIMAL(13,5)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Ticket SET 
		  numero = numeroArg
		, nombre = nombreArg
		, fechaActualizacion = fechaActualizacionArg
		, cantidadPorLotes = cantidadPorLotesArg
		, ticketControlDenunciados = ticketControlDenunciadosArg
		, valorMaximo = valorMaximoArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ticket.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Ticket WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ticket.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Ticket(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::DATE
		, null::INTEGER
		, null::VARCHAR(36)
		, null::DECIMAL(13,5)
);

*/

DROP TYPE IF EXISTS massoftware.t_Ticket_1 CASCADE;

CREATE TYPE massoftware.t_Ticket_1 AS (

	  Ticket_id                        	VARCHAR(36)  		-- 0	Ticket.id
	, Ticket_numero                    	INTEGER      		-- 1	Ticket.numero
	, Ticket_nombre                    	VARCHAR(50)  		-- 2	Ticket.nombre
	, Ticket_fechaActualizacion        	DATE         		-- 3	Ticket.fechaActualizacion
	, Ticket_cantidadPorLotes          	INTEGER      		-- 4	Ticket.cantidadPorLotes
	, TicketControlDenunciados_5_id    	VARCHAR(36)  		-- 5	Ticket.TicketControlDenunciados.id
	, TicketControlDenunciados_5_numero	INTEGER      		-- 6	Ticket.TicketControlDenunciados.numero
	, TicketControlDenunciados_5_nombre	VARCHAR(50)  		-- 7	Ticket.TicketControlDenunciados.nombre
	, Ticket_valorMaximo               	DECIMAL(13,5)		-- 8	Ticket.valorMaximo

);

DROP FUNCTION IF EXISTS massoftware.f_Ticket (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ticket (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.Ticket AS $$

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
				  Ticket.id                          AS Ticket_id                      	-- 0	.id                     		VARCHAR(36)
				, Ticket.numero                      AS Ticket_numero                  	-- 1	.numero                 		INTEGER
				, Ticket.nombre                      AS Ticket_nombre                  	-- 2	.nombre                 		VARCHAR(50)
				, Ticket.fechaActualizacion          AS Ticket_fechaActualizacion      	-- 3	.fechaActualizacion     		DATE
				, Ticket.cantidadPorLotes            AS Ticket_cantidadPorLotes        	-- 4	.cantidadPorLotes       		INTEGER
				, Ticket.ticketControlDenunciados    AS Ticket_ticketControlDenunciados	-- 5	.ticketControlDenunciados		VARCHAR(36)	TicketControlDenunciados.id
				, Ticket.valorMaximo                 AS Ticket_valorMaximo             	-- 6	.valorMaximo            		DECIMAL(13,5)

		FROM	massoftware.Ticket

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Ticket.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Ticket.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Ticket.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Ticket.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_TicketById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TicketById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Ticket AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Ticket ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Ticket ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_TicketById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Ticket_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Ticket_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7

) RETURNS SETOF massoftware.t_Ticket_1 AS $$

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
				  Ticket.id                            AS Ticket_id                        	-- 0	.id                            		VARCHAR(36)
				, Ticket.numero                        AS Ticket_numero                    	-- 1	.numero                        		INTEGER
				, Ticket.nombre                        AS Ticket_nombre                    	-- 2	.nombre                        		VARCHAR(50)
				, Ticket.fechaActualizacion            AS Ticket_fechaActualizacion        	-- 3	.fechaActualizacion            		DATE
				, Ticket.cantidadPorLotes              AS Ticket_cantidadPorLotes          	-- 4	.cantidadPorLotes              		INTEGER
				, TicketControlDenunciados_5.id        AS TicketControlDenunciados_5_id    	-- 5	.TicketControlDenunciados.id   		VARCHAR(36)
				, TicketControlDenunciados_5.numero    AS TicketControlDenunciados_5_numero	-- 6	.TicketControlDenunciados.numero		INTEGER
				, TicketControlDenunciados_5.nombre    AS TicketControlDenunciados_5_nombre	-- 7	.TicketControlDenunciados.nombre		VARCHAR(50)
				, Ticket.valorMaximo                   AS Ticket_valorMaximo               	-- 8	.valorMaximo                   		DECIMAL(13,5)

		FROM	massoftware.Ticket
			LEFT JOIN massoftware.TicketControlDenunciados AS TicketControlDenunciados_5        ON Ticket.ticketControlDenunciados = TicketControlDenunciados_5.id 	-- 5 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Ticket.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Ticket.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Ticket.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Ticket.nombre),
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

DROP FUNCTION IF EXISTS massoftware.f_TicketById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TicketById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Ticket_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Ticket_1 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Ticket_1 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_TicketById_1 ('xxx'); 