
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContable                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoContable



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.AsientoContable CASCADE;

CREATE TABLE massoftware.AsientoContable
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº asiento
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT AsientoContable_numero_chk CHECK ( numero >= 1  ), 
	
	-- Fecha
	fecha DATE NOT NULL, 
	
	-- Detalle
	detalle VARCHAR(100), 
	
	-- Ejercicio
	ejercicioContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.EjercicioContable (id), 
	
	-- Minuta contable
	minutaContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.MinutaContable (id), 
	
	-- Sucursal
	sucursal VARCHAR(36)  NOT NULL  REFERENCES massoftware.Sucursal (id), 
	
	-- Módulo
	asientoContableModulo VARCHAR(36)  NOT NULL  REFERENCES massoftware.AsientoContableModulo (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatAsientoContable() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatAsientoContable() RETURNS TRIGGER AS $formatAsientoContable$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.detalle := massoftware.white_is_null(NEW.detalle);
	 NEW.ejercicioContable := massoftware.white_is_null(NEW.ejercicioContable);
	 NEW.minutaContable := massoftware.white_is_null(NEW.minutaContable);
	 NEW.sucursal := massoftware.white_is_null(NEW.sucursal);
	 NEW.asientoContableModulo := massoftware.white_is_null(NEW.asientoContableModulo);

	RETURN NEW;
END;
$formatAsientoContable$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatAsientoContable ON massoftware.AsientoContable CASCADE;

CREATE TRIGGER tgFormatAsientoContable BEFORE INSERT OR UPDATE
	ON massoftware.AsientoContable FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatAsientoContable();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.AsientoContable;

-- SELECT * FROM massoftware.AsientoContable LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.AsientoContable;

-- SELECT * FROM massoftware.AsientoContable WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_AsientoContable_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_AsientoContable_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.AsientoContable
	WHERE	(numeroArg IS NULL OR AsientoContable.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_AsientoContable_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_AsientoContable_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_AsientoContable_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.AsientoContable;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_AsientoContable_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_AsientoContableById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_AsientoContableById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.AsientoContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContable.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.AsientoContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContable.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContable.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_AsientoContableById('xxx');

-- SELECT * FROM massoftware.d_AsientoContableById((SELECT AsientoContable.id FROM massoftware.AsientoContable LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_AsientoContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, fechaArg DATE
		, detalleArg VARCHAR(100)
		, ejercicioContableArg VARCHAR(36)
		, minutaContableArg VARCHAR(36)
		, sucursalArg VARCHAR(36)
		, asientoContableModuloArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_AsientoContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, fechaArg DATE
		, detalleArg VARCHAR(100)
		, ejercicioContableArg VARCHAR(36)
		, minutaContableArg VARCHAR(36)
		, sucursalArg VARCHAR(36)
		, asientoContableModuloArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.AsientoContable(id, numero, fecha, detalle, ejercicioContable, minutaContable, sucursal, asientoContableModulo) VALUES (idArg, numeroArg, fechaArg, detalleArg, ejercicioContableArg, minutaContableArg, sucursalArg, asientoContableModuloArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContable.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_AsientoContable(
		null::VARCHAR(36)
		, null::INTEGER
		, null::DATE
		, null::VARCHAR(100)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_AsientoContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, fechaArg DATE
		, detalleArg VARCHAR(100)
		, ejercicioContableArg VARCHAR(36)
		, minutaContableArg VARCHAR(36)
		, sucursalArg VARCHAR(36)
		, asientoContableModuloArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_AsientoContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, fechaArg DATE
		, detalleArg VARCHAR(100)
		, ejercicioContableArg VARCHAR(36)
		, minutaContableArg VARCHAR(36)
		, sucursalArg VARCHAR(36)
		, asientoContableModuloArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.AsientoContable SET 
		  numero = numeroArg
		, fecha = fechaArg
		, detalle = detalleArg
		, ejercicioContable = ejercicioContableArg
		, minutaContable = minutaContableArg
		, sucursal = sucursalArg
		, asientoContableModulo = asientoContableModuloArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContable.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContable.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_AsientoContable(
		null::VARCHAR(36)
		, null::INTEGER
		, null::DATE
		, null::VARCHAR(100)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/

DROP TYPE IF EXISTS massoftware.t_AsientoContable_1 CASCADE;

CREATE TYPE massoftware.t_AsientoContable_1 AS (

	  AsientoContable_id                           	VARCHAR(36) 		-- 0	AsientoContable.id
	, AsientoContable_numero                       	INTEGER     		-- 1	AsientoContable.numero
	, AsientoContable_fecha                        	DATE        		-- 2	AsientoContable.fecha
	, AsientoContable_detalle                      	VARCHAR(100)		-- 3	AsientoContable.detalle
	, EjercicioContable_4_id                       	VARCHAR(36) 		-- 4	AsientoContable.EjercicioContable.id
	, EjercicioContable_4_numero                   	INTEGER     		-- 5	AsientoContable.EjercicioContable.numero
	, EjercicioContable_4_apertura                 	DATE        		-- 6	AsientoContable.EjercicioContable.apertura
	, EjercicioContable_4_cierre                   	DATE        		-- 7	AsientoContable.EjercicioContable.cierre
	, EjercicioContable_4_cerrado                  	BOOLEAN     		-- 8	AsientoContable.EjercicioContable.cerrado
	, EjercicioContable_4_cerradoModulos           	BOOLEAN     		-- 9	AsientoContable.EjercicioContable.cerradoModulos
	, EjercicioContable_4_comentario               	VARCHAR(250)		-- 10	AsientoContable.EjercicioContable.comentario
	, MinutaContable_11_id                         	VARCHAR(36) 		-- 11	AsientoContable.MinutaContable.id
	, MinutaContable_11_numero                     	INTEGER     		-- 12	AsientoContable.MinutaContable.numero
	, MinutaContable_11_nombre                     	VARCHAR(50) 		-- 13	AsientoContable.MinutaContable.nombre
	, Sucursal_14_id                               	VARCHAR(36) 		-- 14	AsientoContable.Sucursal.id
	, Sucursal_14_numero                           	INTEGER     		-- 15	AsientoContable.Sucursal.numero
	, Sucursal_14_nombre                           	VARCHAR(50) 		-- 16	AsientoContable.Sucursal.nombre
	, Sucursal_14_abreviatura                      	VARCHAR(5)  		-- 17	AsientoContable.Sucursal.abreviatura
	, Sucursal_14_tipoSucursal                     	VARCHAR(36) 		-- 18	AsientoContable.Sucursal.tipoSucursal
	, Sucursal_14_cuentaClientesDesde              	VARCHAR(7)  		-- 19	AsientoContable.Sucursal.cuentaClientesDesde
	, Sucursal_14_cuentaClientesHasta              	VARCHAR(7)  		-- 20	AsientoContable.Sucursal.cuentaClientesHasta
	, Sucursal_14_cantidadCaracteresClientes       	INTEGER     		-- 21	AsientoContable.Sucursal.cantidadCaracteresClientes
	, Sucursal_14_identificacionNumericaClientes   	BOOLEAN     		-- 22	AsientoContable.Sucursal.identificacionNumericaClientes
	, Sucursal_14_permiteCambiarClientes           	BOOLEAN     		-- 23	AsientoContable.Sucursal.permiteCambiarClientes
	, Sucursal_14_cuentaProveedoresDesde           	VARCHAR(6)  		-- 24	AsientoContable.Sucursal.cuentaProveedoresDesde
	, Sucursal_14_cuentaProveedoresHasta           	VARCHAR(6)  		-- 25	AsientoContable.Sucursal.cuentaProveedoresHasta
	, Sucursal_14_cantidadCaracteresProveedores    	INTEGER     		-- 26	AsientoContable.Sucursal.cantidadCaracteresProveedores
	, Sucursal_14_identificacionNumericaProveedores	BOOLEAN     		-- 27	AsientoContable.Sucursal.identificacionNumericaProveedores
	, Sucursal_14_permiteCambiarProveedores        	BOOLEAN     		-- 28	AsientoContable.Sucursal.permiteCambiarProveedores
	, Sucursal_14_clientesOcacionalesDesde         	INTEGER     		-- 29	AsientoContable.Sucursal.clientesOcacionalesDesde
	, Sucursal_14_clientesOcacionalesHasta         	INTEGER     		-- 30	AsientoContable.Sucursal.clientesOcacionalesHasta
	, Sucursal_14_numeroCobranzaDesde              	INTEGER     		-- 31	AsientoContable.Sucursal.numeroCobranzaDesde
	, Sucursal_14_numeroCobranzaHasta              	INTEGER     		-- 32	AsientoContable.Sucursal.numeroCobranzaHasta
	, AsientoContableModulo_33_id                  	VARCHAR(36) 		-- 33	AsientoContable.AsientoContableModulo.id
	, AsientoContableModulo_33_numero              	INTEGER     		-- 34	AsientoContable.AsientoContableModulo.numero
	, AsientoContableModulo_33_nombre              	VARCHAR(50) 		-- 35	AsientoContable.AsientoContableModulo.nombre

);

DROP TYPE IF EXISTS massoftware.t_AsientoContable_2 CASCADE;

CREATE TYPE massoftware.t_AsientoContable_2 AS (

	  AsientoContable_id                           	VARCHAR(36) 		-- 0	AsientoContable.id
	, AsientoContable_numero                       	INTEGER     		-- 1	AsientoContable.numero
	, AsientoContable_fecha                        	DATE        		-- 2	AsientoContable.fecha
	, AsientoContable_detalle                      	VARCHAR(100)		-- 3	AsientoContable.detalle
	, EjercicioContable_4_id                       	VARCHAR(36) 		-- 4	AsientoContable.EjercicioContable.id
	, EjercicioContable_4_numero                   	INTEGER     		-- 5	AsientoContable.EjercicioContable.numero
	, EjercicioContable_4_apertura                 	DATE        		-- 6	AsientoContable.EjercicioContable.apertura
	, EjercicioContable_4_cierre                   	DATE        		-- 7	AsientoContable.EjercicioContable.cierre
	, EjercicioContable_4_cerrado                  	BOOLEAN     		-- 8	AsientoContable.EjercicioContable.cerrado
	, EjercicioContable_4_cerradoModulos           	BOOLEAN     		-- 9	AsientoContable.EjercicioContable.cerradoModulos
	, EjercicioContable_4_comentario               	VARCHAR(250)		-- 10	AsientoContable.EjercicioContable.comentario
	, MinutaContable_11_id                         	VARCHAR(36) 		-- 11	AsientoContable.MinutaContable.id
	, MinutaContable_11_numero                     	INTEGER     		-- 12	AsientoContable.MinutaContable.numero
	, MinutaContable_11_nombre                     	VARCHAR(50) 		-- 13	AsientoContable.MinutaContable.nombre
	, Sucursal_14_id                               	VARCHAR(36) 		-- 14	AsientoContable.Sucursal.id
	, Sucursal_14_numero                           	INTEGER     		-- 15	AsientoContable.Sucursal.numero
	, Sucursal_14_nombre                           	VARCHAR(50) 		-- 16	AsientoContable.Sucursal.nombre
	, Sucursal_14_abreviatura                      	VARCHAR(5)  		-- 17	AsientoContable.Sucursal.abreviatura
	, TipoSucursal_18_id                           	VARCHAR(36) 		-- 18	AsientoContable.Sucursal.TipoSucursal.id
	, TipoSucursal_18_numero                       	INTEGER     		-- 19	AsientoContable.Sucursal.TipoSucursal.numero
	, TipoSucursal_18_nombre                       	VARCHAR(50) 		-- 20	AsientoContable.Sucursal.TipoSucursal.nombre
	, Sucursal_14_cuentaClientesDesde              	VARCHAR(7)  		-- 21	AsientoContable.Sucursal.cuentaClientesDesde
	, Sucursal_14_cuentaClientesHasta              	VARCHAR(7)  		-- 22	AsientoContable.Sucursal.cuentaClientesHasta
	, Sucursal_14_cantidadCaracteresClientes       	INTEGER     		-- 23	AsientoContable.Sucursal.cantidadCaracteresClientes
	, Sucursal_14_identificacionNumericaClientes   	BOOLEAN     		-- 24	AsientoContable.Sucursal.identificacionNumericaClientes
	, Sucursal_14_permiteCambiarClientes           	BOOLEAN     		-- 25	AsientoContable.Sucursal.permiteCambiarClientes
	, Sucursal_14_cuentaProveedoresDesde           	VARCHAR(6)  		-- 26	AsientoContable.Sucursal.cuentaProveedoresDesde
	, Sucursal_14_cuentaProveedoresHasta           	VARCHAR(6)  		-- 27	AsientoContable.Sucursal.cuentaProveedoresHasta
	, Sucursal_14_cantidadCaracteresProveedores    	INTEGER     		-- 28	AsientoContable.Sucursal.cantidadCaracteresProveedores
	, Sucursal_14_identificacionNumericaProveedores	BOOLEAN     		-- 29	AsientoContable.Sucursal.identificacionNumericaProveedores
	, Sucursal_14_permiteCambiarProveedores        	BOOLEAN     		-- 30	AsientoContable.Sucursal.permiteCambiarProveedores
	, Sucursal_14_clientesOcacionalesDesde         	INTEGER     		-- 31	AsientoContable.Sucursal.clientesOcacionalesDesde
	, Sucursal_14_clientesOcacionalesHasta         	INTEGER     		-- 32	AsientoContable.Sucursal.clientesOcacionalesHasta
	, Sucursal_14_numeroCobranzaDesde              	INTEGER     		-- 33	AsientoContable.Sucursal.numeroCobranzaDesde
	, Sucursal_14_numeroCobranzaHasta              	INTEGER     		-- 34	AsientoContable.Sucursal.numeroCobranzaHasta
	, AsientoContableModulo_35_id                  	VARCHAR(36) 		-- 35	AsientoContable.AsientoContableModulo.id
	, AsientoContableModulo_35_numero              	INTEGER     		-- 36	AsientoContable.AsientoContableModulo.numero
	, AsientoContableModulo_35_nombre              	VARCHAR(50) 		-- 37	AsientoContable.AsientoContableModulo.nombre

);

DROP FUNCTION IF EXISTS massoftware.f_AsientoContable (

	  idArg0                       VARCHAR(36) 	-- 0
	, orderByArg1                  INTEGER     	-- 1
	, orderByDescArg2              BOOLEAN     	-- 2
	, limitArg3                    BIGINT      	-- 3
	, offSetArg4                   BIGINT      	-- 4
	, numeroFromArg5               INTEGER     	-- 5
	, numeroToArg6                 INTEGER     	-- 6
	, detalleArg7                  VARCHAR(100)	-- 7
	, fechaFromArg8                DATE        	-- 8
	, fechaToArg9                  DATE        	-- 9
	, ejercicioContableArg10       VARCHAR(36) 	-- 10
	, minutaContableArg11          VARCHAR(36) 	-- 11
	, asientoContableModuloArg12   VARCHAR(36) 	-- 12
	, sucursalArg13                VARCHAR(36) 	-- 13

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContable (

	  idArg0                       VARCHAR(36) 	-- 0
	, orderByArg1                  INTEGER     	-- 1
	, orderByDescArg2              BOOLEAN     	-- 2
	, limitArg3                    BIGINT      	-- 3
	, offSetArg4                   BIGINT      	-- 4
	, numeroFromArg5               INTEGER     	-- 5
	, numeroToArg6                 INTEGER     	-- 6
	, detalleArg7                  VARCHAR(100)	-- 7
	, fechaFromArg8                DATE        	-- 8
	, fechaToArg9                  DATE        	-- 9
	, ejercicioContableArg10       VARCHAR(36) 	-- 10
	, minutaContableArg11          VARCHAR(36) 	-- 11
	, asientoContableModuloArg12   VARCHAR(36) 	-- 12
	, sucursalArg13                VARCHAR(36) 	-- 13

) RETURNS SETOF massoftware.AsientoContable AS $$

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
				  AsientoContable.id                       AS AsientoContable_id                   	-- 0	.id                  		VARCHAR(36)
				, AsientoContable.numero                   AS AsientoContable_numero               	-- 1	.numero              		INTEGER
				, AsientoContable.fecha                    AS AsientoContable_fecha                	-- 2	.fecha               		DATE
				, AsientoContable.detalle                  AS AsientoContable_detalle              	-- 3	.detalle             		VARCHAR(100)
				, AsientoContable.ejercicioContable        AS AsientoContable_ejercicioContable    	-- 4	.ejercicioContable   		VARCHAR(36)	EjercicioContable.id
				, AsientoContable.minutaContable           AS AsientoContable_minutaContable       	-- 5	.minutaContable      		VARCHAR(36)	MinutaContable.id
				, AsientoContable.sucursal                 AS AsientoContable_sucursal             	-- 6	.sucursal            		VARCHAR(36)	Sucursal.id
				, AsientoContable.asientoContableModulo    AS AsientoContable_asientoContableModulo	-- 7	.asientoContableModulo		VARCHAR(36)	AsientoContableModulo.id

		FROM	massoftware.AsientoContable

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND detalleArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(detalleArg7)) > 0 THEN
		detalleArg7 = REPLACE(detalleArg7, '''', '''''');
		detalleArg7 = LOWER(TRIM(detalleArg7));
		detalleArg7 = TRANSLATE(detalleArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(detalleArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.detalle),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND fechaFromArg8 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.fecha >= ' || fechaFromArg8;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND fechaToArg9 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.fecha <= ' || fechaToArg9;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND ejercicioContableArg10 IS NOT NULL AND CHAR_LENGTH(TRIM(ejercicioContableArg10)) > 0 THEN
		ejercicioContableArg10 = REPLACE(ejercicioContableArg10, '''', '''''');
		ejercicioContableArg10 = LOWER(TRIM(ejercicioContableArg10));
		ejercicioContableArg10 = TRANSLATE(ejercicioContableArg10,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ejercicioContableArg10, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.ejercicioContable),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND minutaContableArg11 IS NOT NULL AND CHAR_LENGTH(TRIM(minutaContableArg11)) > 0 THEN
		minutaContableArg11 = REPLACE(minutaContableArg11, '''', '''''');
		minutaContableArg11 = LOWER(TRIM(minutaContableArg11));
		minutaContableArg11 = TRANSLATE(minutaContableArg11,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(minutaContableArg11, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.minutaContable),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND asientoContableModuloArg12 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoContableModuloArg12)) > 0 THEN
		asientoContableModuloArg12 = REPLACE(asientoContableModuloArg12, '''', '''''');
		asientoContableModuloArg12 = LOWER(TRIM(asientoContableModuloArg12));
		asientoContableModuloArg12 = TRANSLATE(asientoContableModuloArg12,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoContableModuloArg12, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.asientoContableModulo),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND sucursalArg13 IS NOT NULL AND CHAR_LENGTH(TRIM(sucursalArg13)) > 0 THEN
		sucursalArg13 = REPLACE(sucursalArg13, '''', '''''');
		sucursalArg13 = LOWER(TRIM(sucursalArg13));
		sucursalArg13 = TRANSLATE(sucursalArg13,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(sucursalArg13, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.sucursal),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableById (idArg VARCHAR(36)) RETURNS SETOF massoftware.AsientoContable AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoContable ( idArg , null, null, null, null, null, null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoContable ( null , null, null, null, null, null, null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoContableById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_AsientoContable_1 (

	  idArg0                       VARCHAR(36) 	-- 0
	, orderByArg1                  INTEGER     	-- 1
	, orderByDescArg2              BOOLEAN     	-- 2
	, limitArg3                    BIGINT      	-- 3
	, offSetArg4                   BIGINT      	-- 4
	, numeroFromArg5               INTEGER     	-- 5
	, numeroToArg6                 INTEGER     	-- 6
	, detalleArg7                  VARCHAR(100)	-- 7
	, fechaFromArg8                DATE        	-- 8
	, fechaToArg9                  DATE        	-- 9
	, ejercicioContableArg10       VARCHAR(36) 	-- 10
	, minutaContableArg11          VARCHAR(36) 	-- 11
	, asientoContableModuloArg12   VARCHAR(36) 	-- 12
	, sucursalArg13                VARCHAR(36) 	-- 13

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContable_1 (

	  idArg0                       VARCHAR(36) 	-- 0
	, orderByArg1                  INTEGER     	-- 1
	, orderByDescArg2              BOOLEAN     	-- 2
	, limitArg3                    BIGINT      	-- 3
	, offSetArg4                   BIGINT      	-- 4
	, numeroFromArg5               INTEGER     	-- 5
	, numeroToArg6                 INTEGER     	-- 6
	, detalleArg7                  VARCHAR(100)	-- 7
	, fechaFromArg8                DATE        	-- 8
	, fechaToArg9                  DATE        	-- 9
	, ejercicioContableArg10       VARCHAR(36) 	-- 10
	, minutaContableArg11          VARCHAR(36) 	-- 11
	, asientoContableModuloArg12   VARCHAR(36) 	-- 12
	, sucursalArg13                VARCHAR(36) 	-- 13

) RETURNS SETOF massoftware.t_AsientoContable_1 AS $$

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
				  AsientoContable.id                                AS AsientoContable_id                           	-- 0	.id                                       		VARCHAR(36)
				, AsientoContable.numero                            AS AsientoContable_numero                       	-- 1	.numero                                   		INTEGER
				, AsientoContable.fecha                             AS AsientoContable_fecha                        	-- 2	.fecha                                    		DATE
				, AsientoContable.detalle                           AS AsientoContable_detalle                      	-- 3	.detalle                                  		VARCHAR(100)
				, EjercicioContable_4.id                            AS EjercicioContable_4_id                       	-- 4	.EjercicioContable.id                     		VARCHAR(36)
				, EjercicioContable_4.numero                        AS EjercicioContable_4_numero                   	-- 5	.EjercicioContable.numero                 		INTEGER
				, EjercicioContable_4.apertura                      AS EjercicioContable_4_apertura                 	-- 6	.EjercicioContable.apertura               		DATE
				, EjercicioContable_4.cierre                        AS EjercicioContable_4_cierre                   	-- 7	.EjercicioContable.cierre                 		DATE
				, EjercicioContable_4.cerrado                       AS EjercicioContable_4_cerrado                  	-- 8	.EjercicioContable.cerrado                		BOOLEAN
				, EjercicioContable_4.cerradoModulos                AS EjercicioContable_4_cerradoModulos           	-- 9	.EjercicioContable.cerradoModulos         		BOOLEAN
				, EjercicioContable_4.comentario                    AS EjercicioContable_4_comentario               	-- 10	.EjercicioContable.comentario             		VARCHAR(250)
				, MinutaContable_11.id                              AS MinutaContable_11_id                         	-- 11	.MinutaContable.id                        		VARCHAR(36)
				, MinutaContable_11.numero                          AS MinutaContable_11_numero                     	-- 12	.MinutaContable.numero                    		INTEGER
				, MinutaContable_11.nombre                          AS MinutaContable_11_nombre                     	-- 13	.MinutaContable.nombre                    		VARCHAR(50)
				, Sucursal_14.id                                    AS Sucursal_14_id                               	-- 14	.Sucursal.id                              		VARCHAR(36)
				, Sucursal_14.numero                                AS Sucursal_14_numero                           	-- 15	.Sucursal.numero                          		INTEGER
				, Sucursal_14.nombre                                AS Sucursal_14_nombre                           	-- 16	.Sucursal.nombre                          		VARCHAR(50)
				, Sucursal_14.abreviatura                           AS Sucursal_14_abreviatura                      	-- 17	.Sucursal.abreviatura                     		VARCHAR(5)
				, Sucursal_14.tipoSucursal                          AS Sucursal_14_tipoSucursal                     	-- 18	.Sucursal.tipoSucursal                    		VARCHAR(36)	TipoSucursal.id
				, Sucursal_14.cuentaClientesDesde                   AS Sucursal_14_cuentaClientesDesde              	-- 19	.Sucursal.cuentaClientesDesde             		VARCHAR(7)
				, Sucursal_14.cuentaClientesHasta                   AS Sucursal_14_cuentaClientesHasta              	-- 20	.Sucursal.cuentaClientesHasta             		VARCHAR(7)
				, Sucursal_14.cantidadCaracteresClientes            AS Sucursal_14_cantidadCaracteresClientes       	-- 21	.Sucursal.cantidadCaracteresClientes      		INTEGER
				, Sucursal_14.identificacionNumericaClientes        AS Sucursal_14_identificacionNumericaClientes   	-- 22	.Sucursal.identificacionNumericaClientes  		BOOLEAN
				, Sucursal_14.permiteCambiarClientes                AS Sucursal_14_permiteCambiarClientes           	-- 23	.Sucursal.permiteCambiarClientes          		BOOLEAN
				, Sucursal_14.cuentaProveedoresDesde                AS Sucursal_14_cuentaProveedoresDesde           	-- 24	.Sucursal.cuentaProveedoresDesde          		VARCHAR(6)
				, Sucursal_14.cuentaProveedoresHasta                AS Sucursal_14_cuentaProveedoresHasta           	-- 25	.Sucursal.cuentaProveedoresHasta          		VARCHAR(6)
				, Sucursal_14.cantidadCaracteresProveedores         AS Sucursal_14_cantidadCaracteresProveedores    	-- 26	.Sucursal.cantidadCaracteresProveedores   		INTEGER
				, Sucursal_14.identificacionNumericaProveedores     AS Sucursal_14_identificacionNumericaProveedores	-- 27	.Sucursal.identificacionNumericaProveedores		BOOLEAN
				, Sucursal_14.permiteCambiarProveedores             AS Sucursal_14_permiteCambiarProveedores        	-- 28	.Sucursal.permiteCambiarProveedores       		BOOLEAN
				, Sucursal_14.clientesOcacionalesDesde              AS Sucursal_14_clientesOcacionalesDesde         	-- 29	.Sucursal.clientesOcacionalesDesde        		INTEGER
				, Sucursal_14.clientesOcacionalesHasta              AS Sucursal_14_clientesOcacionalesHasta         	-- 30	.Sucursal.clientesOcacionalesHasta        		INTEGER
				, Sucursal_14.numeroCobranzaDesde                   AS Sucursal_14_numeroCobranzaDesde              	-- 31	.Sucursal.numeroCobranzaDesde             		INTEGER
				, Sucursal_14.numeroCobranzaHasta                   AS Sucursal_14_numeroCobranzaHasta              	-- 32	.Sucursal.numeroCobranzaHasta             		INTEGER
				, AsientoContableModulo_33.id                       AS AsientoContableModulo_33_id                  	-- 33	.AsientoContableModulo.id                 		VARCHAR(36)
				, AsientoContableModulo_33.numero                   AS AsientoContableModulo_33_numero              	-- 34	.AsientoContableModulo.numero             		INTEGER
				, AsientoContableModulo_33.nombre                   AS AsientoContableModulo_33_nombre              	-- 35	.AsientoContableModulo.nombre             		VARCHAR(50)

		FROM	massoftware.AsientoContable
			LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_4             ON AsientoContable.ejercicioContable = EjercicioContable_4.id 	-- 4 LEFT LEVEL: 1
			LEFT JOIN massoftware.MinutaContable AS MinutaContable_11               ON AsientoContable.minutaContable = MinutaContable_11.id 	-- 11 LEFT LEVEL: 1
			LEFT JOIN massoftware.Sucursal AS Sucursal_14                     ON AsientoContable.sucursal = Sucursal_14.id 	-- 14 LEFT LEVEL: 1
			LEFT JOIN massoftware.AsientoContableModulo AS AsientoContableModulo_33        ON AsientoContable.asientoContableModulo = AsientoContableModulo_33.id 	-- 33 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND detalleArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(detalleArg7)) > 0 THEN
		detalleArg7 = REPLACE(detalleArg7, '''', '''''');
		detalleArg7 = LOWER(TRIM(detalleArg7));
		detalleArg7 = TRANSLATE(detalleArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(detalleArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.detalle),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND fechaFromArg8 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.fecha >= ' || fechaFromArg8;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND fechaToArg9 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.fecha <= ' || fechaToArg9;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND ejercicioContableArg10 IS NOT NULL AND CHAR_LENGTH(TRIM(ejercicioContableArg10)) > 0 THEN
		ejercicioContableArg10 = REPLACE(ejercicioContableArg10, '''', '''''');
		ejercicioContableArg10 = LOWER(TRIM(ejercicioContableArg10));
		ejercicioContableArg10 = TRANSLATE(ejercicioContableArg10,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ejercicioContableArg10, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.ejercicioContable),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND minutaContableArg11 IS NOT NULL AND CHAR_LENGTH(TRIM(minutaContableArg11)) > 0 THEN
		minutaContableArg11 = REPLACE(minutaContableArg11, '''', '''''');
		minutaContableArg11 = LOWER(TRIM(minutaContableArg11));
		minutaContableArg11 = TRANSLATE(minutaContableArg11,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(minutaContableArg11, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.minutaContable),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND asientoContableModuloArg12 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoContableModuloArg12)) > 0 THEN
		asientoContableModuloArg12 = REPLACE(asientoContableModuloArg12, '''', '''''');
		asientoContableModuloArg12 = LOWER(TRIM(asientoContableModuloArg12));
		asientoContableModuloArg12 = TRANSLATE(asientoContableModuloArg12,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoContableModuloArg12, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.asientoContableModulo),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND sucursalArg13 IS NOT NULL AND CHAR_LENGTH(TRIM(sucursalArg13)) > 0 THEN
		sucursalArg13 = REPLACE(sucursalArg13, '''', '''''');
		sucursalArg13 = LOWER(TRIM(sucursalArg13));
		sucursalArg13 = TRANSLATE(sucursalArg13,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(sucursalArg13, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.sucursal),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_AsientoContable_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoContable_1 ( idArg , null, null, null, null, null, null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoContable_1 ( null , null, null, null, null, null, null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoContableById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_AsientoContable_2 (

	  idArg0                       VARCHAR(36) 	-- 0
	, orderByArg1                  INTEGER     	-- 1
	, orderByDescArg2              BOOLEAN     	-- 2
	, limitArg3                    BIGINT      	-- 3
	, offSetArg4                   BIGINT      	-- 4
	, numeroFromArg5               INTEGER     	-- 5
	, numeroToArg6                 INTEGER     	-- 6
	, detalleArg7                  VARCHAR(100)	-- 7
	, fechaFromArg8                DATE        	-- 8
	, fechaToArg9                  DATE        	-- 9
	, ejercicioContableArg10       VARCHAR(36) 	-- 10
	, minutaContableArg11          VARCHAR(36) 	-- 11
	, asientoContableModuloArg12   VARCHAR(36) 	-- 12
	, sucursalArg13                VARCHAR(36) 	-- 13

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContable_2 (

	  idArg0                       VARCHAR(36) 	-- 0
	, orderByArg1                  INTEGER     	-- 1
	, orderByDescArg2              BOOLEAN     	-- 2
	, limitArg3                    BIGINT      	-- 3
	, offSetArg4                   BIGINT      	-- 4
	, numeroFromArg5               INTEGER     	-- 5
	, numeroToArg6                 INTEGER     	-- 6
	, detalleArg7                  VARCHAR(100)	-- 7
	, fechaFromArg8                DATE        	-- 8
	, fechaToArg9                  DATE        	-- 9
	, ejercicioContableArg10       VARCHAR(36) 	-- 10
	, minutaContableArg11          VARCHAR(36) 	-- 11
	, asientoContableModuloArg12   VARCHAR(36) 	-- 12
	, sucursalArg13                VARCHAR(36) 	-- 13

) RETURNS SETOF massoftware.t_AsientoContable_2 AS $$

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
				  AsientoContable.id                                AS AsientoContable_id                           	-- 0	.id                                       		VARCHAR(36)
				, AsientoContable.numero                            AS AsientoContable_numero                       	-- 1	.numero                                   		INTEGER
				, AsientoContable.fecha                             AS AsientoContable_fecha                        	-- 2	.fecha                                    		DATE
				, AsientoContable.detalle                           AS AsientoContable_detalle                      	-- 3	.detalle                                  		VARCHAR(100)
				, EjercicioContable_4.id                            AS EjercicioContable_4_id                       	-- 4	.EjercicioContable.id                     		VARCHAR(36)
				, EjercicioContable_4.numero                        AS EjercicioContable_4_numero                   	-- 5	.EjercicioContable.numero                 		INTEGER
				, EjercicioContable_4.apertura                      AS EjercicioContable_4_apertura                 	-- 6	.EjercicioContable.apertura               		DATE
				, EjercicioContable_4.cierre                        AS EjercicioContable_4_cierre                   	-- 7	.EjercicioContable.cierre                 		DATE
				, EjercicioContable_4.cerrado                       AS EjercicioContable_4_cerrado                  	-- 8	.EjercicioContable.cerrado                		BOOLEAN
				, EjercicioContable_4.cerradoModulos                AS EjercicioContable_4_cerradoModulos           	-- 9	.EjercicioContable.cerradoModulos         		BOOLEAN
				, EjercicioContable_4.comentario                    AS EjercicioContable_4_comentario               	-- 10	.EjercicioContable.comentario             		VARCHAR(250)
				, MinutaContable_11.id                              AS MinutaContable_11_id                         	-- 11	.MinutaContable.id                        		VARCHAR(36)
				, MinutaContable_11.numero                          AS MinutaContable_11_numero                     	-- 12	.MinutaContable.numero                    		INTEGER
				, MinutaContable_11.nombre                          AS MinutaContable_11_nombre                     	-- 13	.MinutaContable.nombre                    		VARCHAR(50)
				, Sucursal_14.id                                    AS Sucursal_14_id                               	-- 14	.Sucursal.id                              		VARCHAR(36)
				, Sucursal_14.numero                                AS Sucursal_14_numero                           	-- 15	.Sucursal.numero                          		INTEGER
				, Sucursal_14.nombre                                AS Sucursal_14_nombre                           	-- 16	.Sucursal.nombre                          		VARCHAR(50)
				, Sucursal_14.abreviatura                           AS Sucursal_14_abreviatura                      	-- 17	.Sucursal.abreviatura                     		VARCHAR(5)
				, TipoSucursal_18.id                                AS TipoSucursal_18_id                           	-- 18	.Sucursal.TipoSucursal.id                 		VARCHAR(36)
				, TipoSucursal_18.numero                            AS TipoSucursal_18_numero                       	-- 19	.Sucursal.TipoSucursal.numero             		INTEGER
				, TipoSucursal_18.nombre                            AS TipoSucursal_18_nombre                       	-- 20	.Sucursal.TipoSucursal.nombre             		VARCHAR(50)
				, Sucursal_14.cuentaClientesDesde                   AS Sucursal_14_cuentaClientesDesde              	-- 21	.Sucursal.cuentaClientesDesde             		VARCHAR(7)
				, Sucursal_14.cuentaClientesHasta                   AS Sucursal_14_cuentaClientesHasta              	-- 22	.Sucursal.cuentaClientesHasta             		VARCHAR(7)
				, Sucursal_14.cantidadCaracteresClientes            AS Sucursal_14_cantidadCaracteresClientes       	-- 23	.Sucursal.cantidadCaracteresClientes      		INTEGER
				, Sucursal_14.identificacionNumericaClientes        AS Sucursal_14_identificacionNumericaClientes   	-- 24	.Sucursal.identificacionNumericaClientes  		BOOLEAN
				, Sucursal_14.permiteCambiarClientes                AS Sucursal_14_permiteCambiarClientes           	-- 25	.Sucursal.permiteCambiarClientes          		BOOLEAN
				, Sucursal_14.cuentaProveedoresDesde                AS Sucursal_14_cuentaProveedoresDesde           	-- 26	.Sucursal.cuentaProveedoresDesde          		VARCHAR(6)
				, Sucursal_14.cuentaProveedoresHasta                AS Sucursal_14_cuentaProveedoresHasta           	-- 27	.Sucursal.cuentaProveedoresHasta          		VARCHAR(6)
				, Sucursal_14.cantidadCaracteresProveedores         AS Sucursal_14_cantidadCaracteresProveedores    	-- 28	.Sucursal.cantidadCaracteresProveedores   		INTEGER
				, Sucursal_14.identificacionNumericaProveedores     AS Sucursal_14_identificacionNumericaProveedores	-- 29	.Sucursal.identificacionNumericaProveedores		BOOLEAN
				, Sucursal_14.permiteCambiarProveedores             AS Sucursal_14_permiteCambiarProveedores        	-- 30	.Sucursal.permiteCambiarProveedores       		BOOLEAN
				, Sucursal_14.clientesOcacionalesDesde              AS Sucursal_14_clientesOcacionalesDesde         	-- 31	.Sucursal.clientesOcacionalesDesde        		INTEGER
				, Sucursal_14.clientesOcacionalesHasta              AS Sucursal_14_clientesOcacionalesHasta         	-- 32	.Sucursal.clientesOcacionalesHasta        		INTEGER
				, Sucursal_14.numeroCobranzaDesde                   AS Sucursal_14_numeroCobranzaDesde              	-- 33	.Sucursal.numeroCobranzaDesde             		INTEGER
				, Sucursal_14.numeroCobranzaHasta                   AS Sucursal_14_numeroCobranzaHasta              	-- 34	.Sucursal.numeroCobranzaHasta             		INTEGER
				, AsientoContableModulo_35.id                       AS AsientoContableModulo_35_id                  	-- 35	.AsientoContableModulo.id                 		VARCHAR(36)
				, AsientoContableModulo_35.numero                   AS AsientoContableModulo_35_numero              	-- 36	.AsientoContableModulo.numero             		INTEGER
				, AsientoContableModulo_35.nombre                   AS AsientoContableModulo_35_nombre              	-- 37	.AsientoContableModulo.nombre             		VARCHAR(50)

		FROM	massoftware.AsientoContable
			LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_4             ON AsientoContable.ejercicioContable = EjercicioContable_4.id 	-- 4 LEFT LEVEL: 1
			LEFT JOIN massoftware.MinutaContable AS MinutaContable_11               ON AsientoContable.minutaContable = MinutaContable_11.id 	-- 11 LEFT LEVEL: 1
			LEFT JOIN massoftware.Sucursal AS Sucursal_14                     ON AsientoContable.sucursal = Sucursal_14.id 	-- 14 LEFT LEVEL: 1
				LEFT JOIN massoftware.TipoSucursal AS TipoSucursal_18                 ON Sucursal_14.tipoSucursal = TipoSucursal_18.id 	-- 18 LEFT LEVEL: 2
			LEFT JOIN massoftware.AsientoContableModulo AS AsientoContableModulo_35        ON AsientoContable.asientoContableModulo = AsientoContableModulo_35.id 	-- 35 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND detalleArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(detalleArg7)) > 0 THEN
		detalleArg7 = REPLACE(detalleArg7, '''', '''''');
		detalleArg7 = LOWER(TRIM(detalleArg7));
		detalleArg7 = TRANSLATE(detalleArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(detalleArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.detalle),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND fechaFromArg8 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.fecha >= ' || fechaFromArg8;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND fechaToArg9 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContable.fecha <= ' || fechaToArg9;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND ejercicioContableArg10 IS NOT NULL AND CHAR_LENGTH(TRIM(ejercicioContableArg10)) > 0 THEN
		ejercicioContableArg10 = REPLACE(ejercicioContableArg10, '''', '''''');
		ejercicioContableArg10 = LOWER(TRIM(ejercicioContableArg10));
		ejercicioContableArg10 = TRANSLATE(ejercicioContableArg10,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ejercicioContableArg10, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.ejercicioContable),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND minutaContableArg11 IS NOT NULL AND CHAR_LENGTH(TRIM(minutaContableArg11)) > 0 THEN
		minutaContableArg11 = REPLACE(minutaContableArg11, '''', '''''');
		minutaContableArg11 = LOWER(TRIM(minutaContableArg11));
		minutaContableArg11 = TRANSLATE(minutaContableArg11,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(minutaContableArg11, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.minutaContable),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND asientoContableModuloArg12 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoContableModuloArg12)) > 0 THEN
		asientoContableModuloArg12 = REPLACE(asientoContableModuloArg12, '''', '''''');
		asientoContableModuloArg12 = LOWER(TRIM(asientoContableModuloArg12));
		asientoContableModuloArg12 = TRANSLATE(asientoContableModuloArg12,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoContableModuloArg12, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.asientoContableModulo),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND sucursalArg13 IS NOT NULL AND CHAR_LENGTH(TRIM(sucursalArg13)) > 0 THEN
		sucursalArg13 = REPLACE(sucursalArg13, '''', '''''');
		sucursalArg13 = LOWER(TRIM(sucursalArg13));
		sucursalArg13 = TRANSLATE(sucursalArg13,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(sucursalArg13, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContable.sucursal),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_AsientoContable_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoContable_2 ( idArg , null, null, null, null, null, null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoContable_2 ( null , null, null, null, null, null, null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoContableById_2 ('xxx'); 