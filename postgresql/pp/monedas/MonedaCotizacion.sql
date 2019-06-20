
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MonedaCotizacion                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MonedaCotizacion



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.MonedaCotizacion CASCADE;

CREATE TABLE massoftware.MonedaCotizacion
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Fecha cotización
	cotizacionFecha TIMESTAMP NOT NULL, 
	
	-- Compra
	compra DECIMAL(13,5) NOT NULL  CONSTRAINT MonedaCotizacion_compra_chk CHECK ( compra >= -9999.9999 AND compra <= 99999.9999  ), 
	
	-- Venta
	venta DECIMAL(13,5) NOT NULL  CONSTRAINT MonedaCotizacion_venta_chk CHECK ( venta >= -9999.9999 AND venta <= 99999.9999  ), 
	
	-- Fecha cotización (Auditoria)
	cotizacionFechaAuditoria TIMESTAMP NOT NULL, 
	
	-- Moneda
	moneda VARCHAR(36)  NOT NULL  REFERENCES massoftware.Moneda (id), 
	
	-- Usuario
	usuario VARCHAR(36)  NOT NULL  REFERENCES massoftware.Usuario (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatMonedaCotizacion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatMonedaCotizacion() RETURNS TRIGGER AS $formatMonedaCotizacion$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.moneda := massoftware.white_is_null(NEW.moneda);
	 NEW.usuario := massoftware.white_is_null(NEW.usuario);

	RETURN NEW;
END;
$formatMonedaCotizacion$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatMonedaCotizacion ON massoftware.MonedaCotizacion CASCADE;

CREATE TRIGGER tgFormatMonedaCotizacion BEFORE INSERT OR UPDATE
	ON massoftware.MonedaCotizacion FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatMonedaCotizacion();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.MonedaCotizacion;

-- SELECT * FROM massoftware.MonedaCotizacion LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.MonedaCotizacion;

-- SELECT * FROM massoftware.MonedaCotizacion WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_MonedaCotizacion_compra() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_MonedaCotizacion_compra() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(compra),0) + 1)::DECIMAL(13,5) FROM massoftware.MonedaCotizacion;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_MonedaCotizacion_compra();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_MonedaCotizacion_venta() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_MonedaCotizacion_venta() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(venta),0) + 1)::DECIMAL(13,5) FROM massoftware.MonedaCotizacion;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_MonedaCotizacion_venta();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_MonedaCotizacionById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_MonedaCotizacionById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.MonedaCotizacion WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaCotizacion.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.MonedaCotizacion WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaCotizacion.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.MonedaCotizacion WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaCotizacion.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_MonedaCotizacionById('xxx');

-- SELECT * FROM massoftware.d_MonedaCotizacionById((SELECT MonedaCotizacion.id FROM massoftware.MonedaCotizacion LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_MonedaCotizacion(
		  idArg VARCHAR(36)

		, cotizacionFechaArg TIMESTAMP
		, compraArg DECIMAL(13,5)
		, ventaArg DECIMAL(13,5)
		, cotizacionFechaAuditoriaArg TIMESTAMP
		, monedaArg VARCHAR(36)
		, usuarioArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_MonedaCotizacion(
		  idArg VARCHAR(36)

		, cotizacionFechaArg TIMESTAMP
		, compraArg DECIMAL(13,5)
		, ventaArg DECIMAL(13,5)
		, cotizacionFechaAuditoriaArg TIMESTAMP
		, monedaArg VARCHAR(36)
		, usuarioArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF cotizacionFechaAuditoriaArg IS NULL THEN

		cotizacionFechaAuditoriaArg = now();

	END IF;

	INSERT INTO massoftware.MonedaCotizacion(id, cotizacionFecha, compra, venta, cotizacionFechaAuditoria, moneda, usuario) VALUES (idArg, cotizacionFechaArg, compraArg, ventaArg, cotizacionFechaAuditoriaArg, monedaArg, usuarioArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.MonedaCotizacion WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaCotizacion.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_MonedaCotizacion(
		null::VARCHAR(36)
		, null::TIMESTAMP
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
		, null::TIMESTAMP
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_MonedaCotizacion(
		  idArg VARCHAR(36)

		, cotizacionFechaArg TIMESTAMP
		, compraArg DECIMAL(13,5)
		, ventaArg DECIMAL(13,5)
		, cotizacionFechaAuditoriaArg TIMESTAMP
		, monedaArg VARCHAR(36)
		, usuarioArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_MonedaCotizacion(
		  idArg VARCHAR(36)

		, cotizacionFechaArg TIMESTAMP
		, compraArg DECIMAL(13,5)
		, ventaArg DECIMAL(13,5)
		, cotizacionFechaAuditoriaArg TIMESTAMP
		, monedaArg VARCHAR(36)
		, usuarioArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.MonedaCotizacion SET 
		  cotizacionFecha = cotizacionFechaArg
		, compra = compraArg
		, venta = ventaArg
		, cotizacionFechaAuditoria = cotizacionFechaAuditoriaArg
		, moneda = monedaArg
		, usuario = usuarioArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaCotizacion.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.MonedaCotizacion WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaCotizacion.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_MonedaCotizacion(
		null::VARCHAR(36)
		, null::TIMESTAMP
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
		, null::TIMESTAMP
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/

DROP TYPE IF EXISTS massoftware.t_MonedaCotizacion_1 CASCADE;

CREATE TYPE massoftware.t_MonedaCotizacion_1 AS (

	  MonedaCotizacion_id                      	VARCHAR(36)  		-- 0	MonedaCotizacion.id
	, MonedaCotizacion_cotizacionFecha         	TIMESTAMP    		-- 1	MonedaCotizacion.cotizacionFecha
	, MonedaCotizacion_compra                  	DECIMAL(13,5)		-- 2	MonedaCotizacion.compra
	, MonedaCotizacion_venta                   	DECIMAL(13,5)		-- 3	MonedaCotizacion.venta
	, MonedaCotizacion_cotizacionFechaAuditoria	TIMESTAMP    		-- 4	MonedaCotizacion.cotizacionFechaAuditoria
	, Moneda_5_id                              	VARCHAR(36)  		-- 5	MonedaCotizacion.Moneda.id
	, Moneda_5_numero                          	INTEGER      		-- 6	MonedaCotizacion.Moneda.numero
	, Moneda_5_nombre                          	VARCHAR(50)  		-- 7	MonedaCotizacion.Moneda.nombre
	, Moneda_5_abreviatura                     	VARCHAR(5)   		-- 8	MonedaCotizacion.Moneda.abreviatura
	, Moneda_5_cotizacion                      	DECIMAL(13,5)		-- 9	MonedaCotizacion.Moneda.cotizacion
	, Moneda_5_cotizacionFecha                 	TIMESTAMP    		-- 10	MonedaCotizacion.Moneda.cotizacionFecha
	, Moneda_5_controlActualizacion            	BOOLEAN      		-- 11	MonedaCotizacion.Moneda.controlActualizacion
	, Moneda_5_monedaAFIP                      	VARCHAR(36)  		-- 12	MonedaCotizacion.Moneda.monedaAFIP
	, Usuario_13_id                            	VARCHAR(36)  		-- 13	MonedaCotizacion.Usuario.id
	, Usuario_13_numero                        	INTEGER      		-- 14	MonedaCotizacion.Usuario.numero
	, Usuario_13_nombre                        	VARCHAR(50)  		-- 15	MonedaCotizacion.Usuario.nombre

);

DROP TYPE IF EXISTS massoftware.t_MonedaCotizacion_2 CASCADE;

CREATE TYPE massoftware.t_MonedaCotizacion_2 AS (

	  MonedaCotizacion_id                      	VARCHAR(36)  		-- 0	MonedaCotizacion.id
	, MonedaCotizacion_cotizacionFecha         	TIMESTAMP    		-- 1	MonedaCotizacion.cotizacionFecha
	, MonedaCotizacion_compra                  	DECIMAL(13,5)		-- 2	MonedaCotizacion.compra
	, MonedaCotizacion_venta                   	DECIMAL(13,5)		-- 3	MonedaCotizacion.venta
	, MonedaCotizacion_cotizacionFechaAuditoria	TIMESTAMP    		-- 4	MonedaCotizacion.cotizacionFechaAuditoria
	, Moneda_5_id                              	VARCHAR(36)  		-- 5	MonedaCotizacion.Moneda.id
	, Moneda_5_numero                          	INTEGER      		-- 6	MonedaCotizacion.Moneda.numero
	, Moneda_5_nombre                          	VARCHAR(50)  		-- 7	MonedaCotizacion.Moneda.nombre
	, Moneda_5_abreviatura                     	VARCHAR(5)   		-- 8	MonedaCotizacion.Moneda.abreviatura
	, Moneda_5_cotizacion                      	DECIMAL(13,5)		-- 9	MonedaCotizacion.Moneda.cotizacion
	, Moneda_5_cotizacionFecha                 	TIMESTAMP    		-- 10	MonedaCotizacion.Moneda.cotizacionFecha
	, Moneda_5_controlActualizacion            	BOOLEAN      		-- 11	MonedaCotizacion.Moneda.controlActualizacion
	, MonedaAFIP_12_id                         	VARCHAR(36)  		-- 12	MonedaCotizacion.Moneda.MonedaAFIP.id
	, MonedaAFIP_12_codigo                     	VARCHAR(3)   		-- 13	MonedaCotizacion.Moneda.MonedaAFIP.codigo
	, MonedaAFIP_12_nombre                     	VARCHAR(50)  		-- 14	MonedaCotizacion.Moneda.MonedaAFIP.nombre
	, Usuario_15_id                            	VARCHAR(36)  		-- 15	MonedaCotizacion.Usuario.id
	, Usuario_15_numero                        	INTEGER      		-- 16	MonedaCotizacion.Usuario.numero
	, Usuario_15_nombre                        	VARCHAR(50)  		-- 17	MonedaCotizacion.Usuario.nombre

);

DROP FUNCTION IF EXISTS massoftware.f_MonedaCotizacion (

	  idArg0                    VARCHAR(36)	-- 0
	, orderByArg1               INTEGER    	-- 1
	, orderByDescArg2           BOOLEAN    	-- 2
	, limitArg3                 BIGINT     	-- 3
	, offSetArg4                BIGINT     	-- 4
	, monedaArg5                VARCHAR(36)	-- 5
	, cotizacionFechaFromArg6   TIMESTAMP  	-- 6
	, cotizacionFechaToArg7     TIMESTAMP  	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaCotizacion (

	  idArg0                    VARCHAR(36)	-- 0
	, orderByArg1               INTEGER    	-- 1
	, orderByDescArg2           BOOLEAN    	-- 2
	, limitArg3                 BIGINT     	-- 3
	, offSetArg4                BIGINT     	-- 4
	, monedaArg5                VARCHAR(36)	-- 5
	, cotizacionFechaFromArg6   TIMESTAMP  	-- 6
	, cotizacionFechaToArg7     TIMESTAMP  	-- 7

) RETURNS SETOF massoftware.MonedaCotizacion AS $$

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
				  MonedaCotizacion.id                          AS MonedaCotizacion_id                      	-- 0	.id                     		VARCHAR(36)
				, MonedaCotizacion.cotizacionFecha             AS MonedaCotizacion_cotizacionFecha         	-- 1	.cotizacionFecha        		TIMESTAMP
				, MonedaCotizacion.compra                      AS MonedaCotizacion_compra                  	-- 2	.compra                 		DECIMAL(13,5)
				, MonedaCotizacion.venta                       AS MonedaCotizacion_venta                   	-- 3	.venta                  		DECIMAL(13,5)
				, MonedaCotizacion.cotizacionFechaAuditoria    AS MonedaCotizacion_cotizacionFechaAuditoria	-- 4	.cotizacionFechaAuditoria		TIMESTAMP
				, MonedaCotizacion.moneda                      AS MonedaCotizacion_moneda                  	-- 5	.moneda                 		VARCHAR(36)	Moneda.id
				, MonedaCotizacion.usuario                     AS MonedaCotizacion_usuario                 	-- 6	.usuario                		VARCHAR(36)	Usuario.id

		FROM	massoftware.MonedaCotizacion

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' MonedaCotizacion.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND monedaArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(monedaArg5)) > 0 THEN
		monedaArg5 = REPLACE(monedaArg5, '''', '''''');
		monedaArg5 = LOWER(TRIM(monedaArg5));
		monedaArg5 = TRANSLATE(monedaArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(monedaArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MonedaCotizacion.moneda),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND cotizacionFechaFromArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MonedaCotizacion.cotizacionFecha >= ' || cotizacionFechaFromArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND cotizacionFechaToArg7 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MonedaCotizacion.cotizacionFecha <= ' || cotizacionFechaToArg7;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
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

DROP FUNCTION IF EXISTS massoftware.f_MonedaCotizacionById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaCotizacionById (idArg VARCHAR(36)) RETURNS SETOF massoftware.MonedaCotizacion AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_MonedaCotizacion ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_MonedaCotizacion ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_MonedaCotizacionById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_MonedaCotizacion_1 (

	  idArg0                    VARCHAR(36)	-- 0
	, orderByArg1               INTEGER    	-- 1
	, orderByDescArg2           BOOLEAN    	-- 2
	, limitArg3                 BIGINT     	-- 3
	, offSetArg4                BIGINT     	-- 4
	, monedaArg5                VARCHAR(36)	-- 5
	, cotizacionFechaFromArg6   TIMESTAMP  	-- 6
	, cotizacionFechaToArg7     TIMESTAMP  	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaCotizacion_1 (

	  idArg0                    VARCHAR(36)	-- 0
	, orderByArg1               INTEGER    	-- 1
	, orderByDescArg2           BOOLEAN    	-- 2
	, limitArg3                 BIGINT     	-- 3
	, offSetArg4                BIGINT     	-- 4
	, monedaArg5                VARCHAR(36)	-- 5
	, cotizacionFechaFromArg6   TIMESTAMP  	-- 6
	, cotizacionFechaToArg7     TIMESTAMP  	-- 7

) RETURNS SETOF massoftware.t_MonedaCotizacion_1 AS $$

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
				  MonedaCotizacion.id                          AS MonedaCotizacion_id                      	-- 0	.id                        		VARCHAR(36)
				, MonedaCotizacion.cotizacionFecha             AS MonedaCotizacion_cotizacionFecha         	-- 1	.cotizacionFecha           		TIMESTAMP
				, MonedaCotizacion.compra                      AS MonedaCotizacion_compra                  	-- 2	.compra                    		DECIMAL(13,5)
				, MonedaCotizacion.venta                       AS MonedaCotizacion_venta                   	-- 3	.venta                     		DECIMAL(13,5)
				, MonedaCotizacion.cotizacionFechaAuditoria    AS MonedaCotizacion_cotizacionFechaAuditoria	-- 4	.cotizacionFechaAuditoria  		TIMESTAMP
				, Moneda_5.id                                  AS Moneda_5_id                              	-- 5	.Moneda.id                 		VARCHAR(36)
				, Moneda_5.numero                              AS Moneda_5_numero                          	-- 6	.Moneda.numero             		INTEGER
				, Moneda_5.nombre                              AS Moneda_5_nombre                          	-- 7	.Moneda.nombre             		VARCHAR(50)
				, Moneda_5.abreviatura                         AS Moneda_5_abreviatura                     	-- 8	.Moneda.abreviatura        		VARCHAR(5)
				, Moneda_5.cotizacion                          AS Moneda_5_cotizacion                      	-- 9	.Moneda.cotizacion         		DECIMAL(13,5)
				, Moneda_5.cotizacionFecha                     AS Moneda_5_cotizacionFecha                 	-- 10	.Moneda.cotizacionFecha    		TIMESTAMP
				, Moneda_5.controlActualizacion                AS Moneda_5_controlActualizacion            	-- 11	.Moneda.controlActualizacion		BOOLEAN
				, Moneda_5.monedaAFIP                          AS Moneda_5_monedaAFIP                      	-- 12	.Moneda.monedaAFIP         		VARCHAR(36)	MonedaAFIP.id
				, Usuario_13.id                                AS Usuario_13_id                            	-- 13	.Usuario.id                		VARCHAR(36)
				, Usuario_13.numero                            AS Usuario_13_numero                        	-- 14	.Usuario.numero            		INTEGER
				, Usuario_13.nombre                            AS Usuario_13_nombre                        	-- 15	.Usuario.nombre            		VARCHAR(50)

		FROM	massoftware.MonedaCotizacion
			LEFT JOIN massoftware.Moneda AS Moneda_5          ON MonedaCotizacion.moneda = Moneda_5.id 	-- 5 LEFT LEVEL: 1
			LEFT JOIN massoftware.Usuario AS Usuario_13        ON MonedaCotizacion.usuario = Usuario_13.id 	-- 13 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' MonedaCotizacion.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND monedaArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(monedaArg5)) > 0 THEN
		monedaArg5 = REPLACE(monedaArg5, '''', '''''');
		monedaArg5 = LOWER(TRIM(monedaArg5));
		monedaArg5 = TRANSLATE(monedaArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(monedaArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MonedaCotizacion.moneda),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND cotizacionFechaFromArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MonedaCotizacion.cotizacionFecha >= ' || cotizacionFechaFromArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND cotizacionFechaToArg7 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MonedaCotizacion.cotizacionFecha <= ' || cotizacionFechaToArg7;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
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

DROP FUNCTION IF EXISTS massoftware.f_MonedaCotizacionById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaCotizacionById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_MonedaCotizacion_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_MonedaCotizacion_1 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_MonedaCotizacion_1 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_MonedaCotizacionById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_MonedaCotizacion_2 (

	  idArg0                    VARCHAR(36)	-- 0
	, orderByArg1               INTEGER    	-- 1
	, orderByDescArg2           BOOLEAN    	-- 2
	, limitArg3                 BIGINT     	-- 3
	, offSetArg4                BIGINT     	-- 4
	, monedaArg5                VARCHAR(36)	-- 5
	, cotizacionFechaFromArg6   TIMESTAMP  	-- 6
	, cotizacionFechaToArg7     TIMESTAMP  	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaCotizacion_2 (

	  idArg0                    VARCHAR(36)	-- 0
	, orderByArg1               INTEGER    	-- 1
	, orderByDescArg2           BOOLEAN    	-- 2
	, limitArg3                 BIGINT     	-- 3
	, offSetArg4                BIGINT     	-- 4
	, monedaArg5                VARCHAR(36)	-- 5
	, cotizacionFechaFromArg6   TIMESTAMP  	-- 6
	, cotizacionFechaToArg7     TIMESTAMP  	-- 7

) RETURNS SETOF massoftware.t_MonedaCotizacion_2 AS $$

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
				  MonedaCotizacion.id                          AS MonedaCotizacion_id                      	-- 0	.id                        		VARCHAR(36)
				, MonedaCotizacion.cotizacionFecha             AS MonedaCotizacion_cotizacionFecha         	-- 1	.cotizacionFecha           		TIMESTAMP
				, MonedaCotizacion.compra                      AS MonedaCotizacion_compra                  	-- 2	.compra                    		DECIMAL(13,5)
				, MonedaCotizacion.venta                       AS MonedaCotizacion_venta                   	-- 3	.venta                     		DECIMAL(13,5)
				, MonedaCotizacion.cotizacionFechaAuditoria    AS MonedaCotizacion_cotizacionFechaAuditoria	-- 4	.cotizacionFechaAuditoria  		TIMESTAMP
				, Moneda_5.id                                  AS Moneda_5_id                              	-- 5	.Moneda.id                 		VARCHAR(36)
				, Moneda_5.numero                              AS Moneda_5_numero                          	-- 6	.Moneda.numero             		INTEGER
				, Moneda_5.nombre                              AS Moneda_5_nombre                          	-- 7	.Moneda.nombre             		VARCHAR(50)
				, Moneda_5.abreviatura                         AS Moneda_5_abreviatura                     	-- 8	.Moneda.abreviatura        		VARCHAR(5)
				, Moneda_5.cotizacion                          AS Moneda_5_cotizacion                      	-- 9	.Moneda.cotizacion         		DECIMAL(13,5)
				, Moneda_5.cotizacionFecha                     AS Moneda_5_cotizacionFecha                 	-- 10	.Moneda.cotizacionFecha    		TIMESTAMP
				, Moneda_5.controlActualizacion                AS Moneda_5_controlActualizacion            	-- 11	.Moneda.controlActualizacion		BOOLEAN
				, MonedaAFIP_12.id                             AS MonedaAFIP_12_id                         	-- 12	.Moneda.MonedaAFIP.id      		VARCHAR(36)
				, MonedaAFIP_12.codigo                         AS MonedaAFIP_12_codigo                     	-- 13	.Moneda.MonedaAFIP.codigo  		VARCHAR(3)
				, MonedaAFIP_12.nombre                         AS MonedaAFIP_12_nombre                     	-- 14	.Moneda.MonedaAFIP.nombre  		VARCHAR(50)
				, Usuario_15.id                                AS Usuario_15_id                            	-- 15	.Usuario.id                		VARCHAR(36)
				, Usuario_15.numero                            AS Usuario_15_numero                        	-- 16	.Usuario.numero            		INTEGER
				, Usuario_15.nombre                            AS Usuario_15_nombre                        	-- 17	.Usuario.nombre            		VARCHAR(50)

		FROM	massoftware.MonedaCotizacion
			LEFT JOIN massoftware.Moneda AS Moneda_5                ON MonedaCotizacion.moneda = Moneda_5.id 	-- 5 LEFT LEVEL: 1
				LEFT JOIN massoftware.MonedaAFIP AS MonedaAFIP_12           ON Moneda_5.monedaAFIP = MonedaAFIP_12.id 	-- 12 LEFT LEVEL: 2
			LEFT JOIN massoftware.Usuario AS Usuario_15              ON MonedaCotizacion.usuario = Usuario_15.id 	-- 15 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' MonedaCotizacion.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND monedaArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(monedaArg5)) > 0 THEN
		monedaArg5 = REPLACE(monedaArg5, '''', '''''');
		monedaArg5 = LOWER(TRIM(monedaArg5));
		monedaArg5 = TRANSLATE(monedaArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(monedaArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(MonedaCotizacion.moneda),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND cotizacionFechaFromArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MonedaCotizacion.cotizacionFecha >= ' || cotizacionFechaFromArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND cotizacionFechaToArg7 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' MonedaCotizacion.cotizacionFecha <= ' || cotizacionFechaToArg7;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
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

DROP FUNCTION IF EXISTS massoftware.f_MonedaCotizacionById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaCotizacionById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_MonedaCotizacion_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_MonedaCotizacion_2 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_MonedaCotizacion_2 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_MonedaCotizacionById_2 ('xxx'); 