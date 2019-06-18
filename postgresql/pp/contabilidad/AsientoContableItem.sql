
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContableItem                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoContableItem



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.AsientoContableItem CASCADE;

CREATE TABLE massoftware.AsientoContableItem
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº item
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT AsientoContableItem_numero_chk CHECK ( numero >= 1  ), 
	
	-- Fecha
	fecha DATE NOT NULL, 
	
	-- Detalle
	detalle VARCHAR(100), 
	
	-- Asiento contable
	asientoContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.AsientoContable (id), 
	
	-- Cuenta contable
	cuentaContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.CuentaContable (id), 
	
	-- Debe
	debe DECIMAL(13,5) NOT NULL, 
	
	-- Haber
	haber DECIMAL(13,5) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatAsientoContableItem() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatAsientoContableItem() RETURNS TRIGGER AS $formatAsientoContableItem$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.detalle := massoftware.white_is_null(NEW.detalle);
	 NEW.asientoContable := massoftware.white_is_null(NEW.asientoContable);
	 NEW.cuentaContable := massoftware.white_is_null(NEW.cuentaContable);

	RETURN NEW;
END;
$formatAsientoContableItem$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatAsientoContableItem ON massoftware.AsientoContableItem CASCADE;

CREATE TRIGGER tgFormatAsientoContableItem BEFORE INSERT OR UPDATE
	ON massoftware.AsientoContableItem FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatAsientoContableItem();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.AsientoContableItem;

-- SELECT * FROM massoftware.AsientoContableItem LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.AsientoContableItem;

-- SELECT * FROM massoftware.AsientoContableItem WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_AsientoContableItem_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_AsientoContableItem_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.AsientoContableItem
	WHERE	(numeroArg IS NULL OR AsientoContableItem.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_AsientoContableItem_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_AsientoContableItem_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_AsientoContableItem_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.AsientoContableItem;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_AsientoContableItem_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_AsientoContableItem_debe() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_AsientoContableItem_debe() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(debe),0) + 1)::DECIMAL(13,5) FROM massoftware.AsientoContableItem;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_AsientoContableItem_debe();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_AsientoContableItem_haber() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_AsientoContableItem_haber() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(haber),0) + 1)::DECIMAL(13,5) FROM massoftware.AsientoContableItem;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_AsientoContableItem_haber();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_AsientoContableItemById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_AsientoContableItemById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.AsientoContableItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContableItem.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.AsientoContableItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContableItem.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoContableItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContableItem.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_AsientoContableItemById('xxx');

-- SELECT * FROM massoftware.d_AsientoContableItemById((SELECT AsientoContableItem.id FROM massoftware.AsientoContableItem LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_AsientoContableItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, fechaArg DATE
		, detalleArg VARCHAR(100)
		, asientoContableArg VARCHAR(36)
		, cuentaContableArg VARCHAR(36)
		, debeArg DECIMAL(13,5)
		, haberArg DECIMAL(13,5)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_AsientoContableItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, fechaArg DATE
		, detalleArg VARCHAR(100)
		, asientoContableArg VARCHAR(36)
		, cuentaContableArg VARCHAR(36)
		, debeArg DECIMAL(13,5)
		, haberArg DECIMAL(13,5)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.AsientoContableItem(id, numero, fecha, detalle, asientoContable, cuentaContable, debe, haber) VALUES (idArg, numeroArg, fechaArg, detalleArg, asientoContableArg, cuentaContableArg, debeArg, haberArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoContableItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContableItem.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_AsientoContableItem(
		null::VARCHAR(36)
		, null::INTEGER
		, null::DATE
		, null::VARCHAR(100)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_AsientoContableItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, fechaArg DATE
		, detalleArg VARCHAR(100)
		, asientoContableArg VARCHAR(36)
		, cuentaContableArg VARCHAR(36)
		, debeArg DECIMAL(13,5)
		, haberArg DECIMAL(13,5)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_AsientoContableItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, fechaArg DATE
		, detalleArg VARCHAR(100)
		, asientoContableArg VARCHAR(36)
		, cuentaContableArg VARCHAR(36)
		, debeArg DECIMAL(13,5)
		, haberArg DECIMAL(13,5)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.AsientoContableItem SET 
		  numero = numeroArg
		, fecha = fechaArg
		, detalle = detalleArg
		, asientoContable = asientoContableArg
		, cuentaContable = cuentaContableArg
		, debe = debeArg
		, haber = haberArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContableItem.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoContableItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContableItem.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_AsientoContableItem(
		null::VARCHAR(36)
		, null::INTEGER
		, null::DATE
		, null::VARCHAR(100)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
);

*/

DROP TYPE IF EXISTS massoftware.t_AsientoContableItem_1 CASCADE;

CREATE TYPE massoftware.t_AsientoContableItem_1 AS (

	  AsientoContableItem_id                 	VARCHAR(36)  		-- 0	AsientoContableItem.id
	, AsientoContableItem_numero             	INTEGER      		-- 1	AsientoContableItem.numero
	, AsientoContableItem_fecha              	DATE         		-- 2	AsientoContableItem.fecha
	, AsientoContableItem_detalle            	VARCHAR(100) 		-- 3	AsientoContableItem.detalle
	, AsientoContable_4_id                   	VARCHAR(36)  		-- 4	AsientoContableItem.AsientoContable.id
	, AsientoContable_4_numero               	INTEGER      		-- 5	AsientoContableItem.AsientoContable.numero
	, AsientoContable_4_fecha                	DATE         		-- 6	AsientoContableItem.AsientoContable.fecha
	, AsientoContable_4_detalle              	VARCHAR(100) 		-- 7	AsientoContableItem.AsientoContable.detalle
	, AsientoContable_4_ejercicioContable    	VARCHAR(36)  		-- 8	AsientoContableItem.AsientoContable.ejercicioContable
	, AsientoContable_4_minutaContable       	VARCHAR(36)  		-- 9	AsientoContableItem.AsientoContable.minutaContable
	, AsientoContable_4_sucursal             	VARCHAR(36)  		-- 10	AsientoContableItem.AsientoContable.sucursal
	, AsientoContable_4_asientoContableModulo	VARCHAR(36)  		-- 11	AsientoContableItem.AsientoContable.asientoContableModulo
	, CuentaContable_12_id                   	VARCHAR(36)  		-- 12	AsientoContableItem.CuentaContable.id
	, CuentaContable_12_codigo               	VARCHAR(11)  		-- 13	AsientoContableItem.CuentaContable.codigo
	, CuentaContable_12_nombre               	VARCHAR(50)  		-- 14	AsientoContableItem.CuentaContable.nombre
	, CuentaContable_12_ejercicioContable    	VARCHAR(36)  		-- 15	AsientoContableItem.CuentaContable.ejercicioContable
	, CuentaContable_12_integra              	VARCHAR(16)  		-- 16	AsientoContableItem.CuentaContable.integra
	, CuentaContable_12_cuentaJerarquia      	VARCHAR(16)  		-- 17	AsientoContableItem.CuentaContable.cuentaJerarquia
	, CuentaContable_12_imputable            	BOOLEAN      		-- 18	AsientoContableItem.CuentaContable.imputable
	, CuentaContable_12_ajustaPorInflacion   	BOOLEAN      		-- 19	AsientoContableItem.CuentaContable.ajustaPorInflacion
	, CuentaContable_12_cuentaContableEstado 	VARCHAR(36)  		-- 20	AsientoContableItem.CuentaContable.cuentaContableEstado
	, CuentaContable_12_cuentaConApropiacion 	BOOLEAN      		-- 21	AsientoContableItem.CuentaContable.cuentaConApropiacion
	, CuentaContable_12_centroCostoContable  	VARCHAR(36)  		-- 22	AsientoContableItem.CuentaContable.centroCostoContable
	, CuentaContable_12_cuentaAgrupadora     	VARCHAR(50)  		-- 23	AsientoContableItem.CuentaContable.cuentaAgrupadora
	, CuentaContable_12_porcentaje           	DECIMAL(6,3) 		-- 24	AsientoContableItem.CuentaContable.porcentaje
	, CuentaContable_12_puntoEquilibrio      	VARCHAR(36)  		-- 25	AsientoContableItem.CuentaContable.puntoEquilibrio
	, CuentaContable_12_costoVenta           	VARCHAR(36)  		-- 26	AsientoContableItem.CuentaContable.costoVenta
	, CuentaContable_12_seguridadPuerta      	VARCHAR(36)  		-- 27	AsientoContableItem.CuentaContable.seguridadPuerta
	, AsientoContableItem_debe               	DECIMAL(13,5)		-- 28	AsientoContableItem.debe
	, AsientoContableItem_haber              	DECIMAL(13,5)		-- 29	AsientoContableItem.haber

);

DROP TYPE IF EXISTS massoftware.t_AsientoContableItem_2 CASCADE;

CREATE TYPE massoftware.t_AsientoContableItem_2 AS (

	  AsientoContableItem_id                       	VARCHAR(36)  		-- 0	AsientoContableItem.id
	, AsientoContableItem_numero                   	INTEGER      		-- 1	AsientoContableItem.numero
	, AsientoContableItem_fecha                    	DATE         		-- 2	AsientoContableItem.fecha
	, AsientoContableItem_detalle                  	VARCHAR(100) 		-- 3	AsientoContableItem.detalle
	, AsientoContable_4_id                         	VARCHAR(36)  		-- 4	AsientoContableItem.AsientoContable.id
	, AsientoContable_4_numero                     	INTEGER      		-- 5	AsientoContableItem.AsientoContable.numero
	, AsientoContable_4_fecha                      	DATE         		-- 6	AsientoContableItem.AsientoContable.fecha
	, AsientoContable_4_detalle                    	VARCHAR(100) 		-- 7	AsientoContableItem.AsientoContable.detalle
	, EjercicioContable_8_id                       	VARCHAR(36)  		-- 8	AsientoContableItem.AsientoContable.EjercicioContable.id
	, EjercicioContable_8_numero                   	INTEGER      		-- 9	AsientoContableItem.AsientoContable.EjercicioContable.numero
	, EjercicioContable_8_apertura                 	DATE         		-- 10	AsientoContableItem.AsientoContable.EjercicioContable.apertura
	, EjercicioContable_8_cierre                   	DATE         		-- 11	AsientoContableItem.AsientoContable.EjercicioContable.cierre
	, EjercicioContable_8_cerrado                  	BOOLEAN      		-- 12	AsientoContableItem.AsientoContable.EjercicioContable.cerrado
	, EjercicioContable_8_cerradoModulos           	BOOLEAN      		-- 13	AsientoContableItem.AsientoContable.EjercicioContable.cerradoModulos
	, EjercicioContable_8_comentario               	VARCHAR(250) 		-- 14	AsientoContableItem.AsientoContable.EjercicioContable.comentario
	, MinutaContable_15_id                         	VARCHAR(36)  		-- 15	AsientoContableItem.AsientoContable.MinutaContable.id
	, MinutaContable_15_numero                     	INTEGER      		-- 16	AsientoContableItem.AsientoContable.MinutaContable.numero
	, MinutaContable_15_nombre                     	VARCHAR(50)  		-- 17	AsientoContableItem.AsientoContable.MinutaContable.nombre
	, Sucursal_18_id                               	VARCHAR(36)  		-- 18	AsientoContableItem.AsientoContable.Sucursal.id
	, Sucursal_18_numero                           	INTEGER      		-- 19	AsientoContableItem.AsientoContable.Sucursal.numero
	, Sucursal_18_nombre                           	VARCHAR(50)  		-- 20	AsientoContableItem.AsientoContable.Sucursal.nombre
	, Sucursal_18_abreviatura                      	VARCHAR(5)   		-- 21	AsientoContableItem.AsientoContable.Sucursal.abreviatura
	, Sucursal_18_tipoSucursal                     	VARCHAR(36)  		-- 22	AsientoContableItem.AsientoContable.Sucursal.tipoSucursal
	, Sucursal_18_cuentaClientesDesde              	VARCHAR(7)   		-- 23	AsientoContableItem.AsientoContable.Sucursal.cuentaClientesDesde
	, Sucursal_18_cuentaClientesHasta              	VARCHAR(7)   		-- 24	AsientoContableItem.AsientoContable.Sucursal.cuentaClientesHasta
	, Sucursal_18_cantidadCaracteresClientes       	INTEGER      		-- 25	AsientoContableItem.AsientoContable.Sucursal.cantidadCaracteresClientes
	, Sucursal_18_identificacionNumericaClientes   	BOOLEAN      		-- 26	AsientoContableItem.AsientoContable.Sucursal.identificacionNumericaClientes
	, Sucursal_18_permiteCambiarClientes           	BOOLEAN      		-- 27	AsientoContableItem.AsientoContable.Sucursal.permiteCambiarClientes
	, Sucursal_18_cuentaProveedoresDesde           	VARCHAR(6)   		-- 28	AsientoContableItem.AsientoContable.Sucursal.cuentaProveedoresDesde
	, Sucursal_18_cuentaProveedoresHasta           	VARCHAR(6)   		-- 29	AsientoContableItem.AsientoContable.Sucursal.cuentaProveedoresHasta
	, Sucursal_18_cantidadCaracteresProveedores    	INTEGER      		-- 30	AsientoContableItem.AsientoContable.Sucursal.cantidadCaracteresProveedores
	, Sucursal_18_identificacionNumericaProveedores	BOOLEAN      		-- 31	AsientoContableItem.AsientoContable.Sucursal.identificacionNumericaProveedores
	, Sucursal_18_permiteCambiarProveedores        	BOOLEAN      		-- 32	AsientoContableItem.AsientoContable.Sucursal.permiteCambiarProveedores
	, Sucursal_18_clientesOcacionalesDesde         	INTEGER      		-- 33	AsientoContableItem.AsientoContable.Sucursal.clientesOcacionalesDesde
	, Sucursal_18_clientesOcacionalesHasta         	INTEGER      		-- 34	AsientoContableItem.AsientoContable.Sucursal.clientesOcacionalesHasta
	, Sucursal_18_numeroCobranzaDesde              	INTEGER      		-- 35	AsientoContableItem.AsientoContable.Sucursal.numeroCobranzaDesde
	, Sucursal_18_numeroCobranzaHasta              	INTEGER      		-- 36	AsientoContableItem.AsientoContable.Sucursal.numeroCobranzaHasta
	, AsientoContableModulo_37_id                  	VARCHAR(36)  		-- 37	AsientoContableItem.AsientoContable.AsientoContableModulo.id
	, AsientoContableModulo_37_numero              	INTEGER      		-- 38	AsientoContableItem.AsientoContable.AsientoContableModulo.numero
	, AsientoContableModulo_37_nombre              	VARCHAR(50)  		-- 39	AsientoContableItem.AsientoContable.AsientoContableModulo.nombre
	, CuentaContable_40_id                         	VARCHAR(36)  		-- 40	AsientoContableItem.CuentaContable.id
	, CuentaContable_40_codigo                     	VARCHAR(11)  		-- 41	AsientoContableItem.CuentaContable.codigo
	, CuentaContable_40_nombre                     	VARCHAR(50)  		-- 42	AsientoContableItem.CuentaContable.nombre
	, EjercicioContable_43_id                      	VARCHAR(36)  		-- 43	AsientoContableItem.CuentaContable.EjercicioContable.id
	, EjercicioContable_43_numero                  	INTEGER      		-- 44	AsientoContableItem.CuentaContable.EjercicioContable.numero
	, EjercicioContable_43_apertura                	DATE         		-- 45	AsientoContableItem.CuentaContable.EjercicioContable.apertura
	, EjercicioContable_43_cierre                  	DATE         		-- 46	AsientoContableItem.CuentaContable.EjercicioContable.cierre
	, EjercicioContable_43_cerrado                 	BOOLEAN      		-- 47	AsientoContableItem.CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_43_cerradoModulos          	BOOLEAN      		-- 48	AsientoContableItem.CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_43_comentario              	VARCHAR(250) 		-- 49	AsientoContableItem.CuentaContable.EjercicioContable.comentario
	, CuentaContable_40_integra                    	VARCHAR(16)  		-- 50	AsientoContableItem.CuentaContable.integra
	, CuentaContable_40_cuentaJerarquia            	VARCHAR(16)  		-- 51	AsientoContableItem.CuentaContable.cuentaJerarquia
	, CuentaContable_40_imputable                  	BOOLEAN      		-- 52	AsientoContableItem.CuentaContable.imputable
	, CuentaContable_40_ajustaPorInflacion         	BOOLEAN      		-- 53	AsientoContableItem.CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_54_id                   	VARCHAR(36)  		-- 54	AsientoContableItem.CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_54_numero               	INTEGER      		-- 55	AsientoContableItem.CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_54_nombre               	VARCHAR(50)  		-- 56	AsientoContableItem.CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_40_cuentaConApropiacion       	BOOLEAN      		-- 57	AsientoContableItem.CuentaContable.cuentaConApropiacion
	, CentroCostoContable_58_id                    	VARCHAR(36)  		-- 58	AsientoContableItem.CuentaContable.CentroCostoContable.id
	, CentroCostoContable_58_numero                	INTEGER      		-- 59	AsientoContableItem.CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_58_nombre                	VARCHAR(50)  		-- 60	AsientoContableItem.CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_58_abreviatura           	VARCHAR(5)   		-- 61	AsientoContableItem.CuentaContable.CentroCostoContable.abreviatura
	, CentroCostoContable_58_ejercicioContable     	VARCHAR(36)  		-- 62	AsientoContableItem.CuentaContable.CentroCostoContable.ejercicioContable
	, CuentaContable_40_cuentaAgrupadora           	VARCHAR(50)  		-- 63	AsientoContableItem.CuentaContable.cuentaAgrupadora
	, CuentaContable_40_porcentaje                 	DECIMAL(6,3) 		-- 64	AsientoContableItem.CuentaContable.porcentaje
	, PuntoEquilibrio_65_id                        	VARCHAR(36)  		-- 65	AsientoContableItem.CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_65_numero                    	INTEGER      		-- 66	AsientoContableItem.CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_65_nombre                    	VARCHAR(50)  		-- 67	AsientoContableItem.CuentaContable.PuntoEquilibrio.nombre
	, PuntoEquilibrio_65_tipoPuntoEquilibrio       	VARCHAR(36)  		-- 68	AsientoContableItem.CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio
	, PuntoEquilibrio_65_ejercicioContable         	VARCHAR(36)  		-- 69	AsientoContableItem.CuentaContable.PuntoEquilibrio.ejercicioContable
	, CostoVenta_70_id                             	VARCHAR(36)  		-- 70	AsientoContableItem.CuentaContable.CostoVenta.id
	, CostoVenta_70_numero                         	INTEGER      		-- 71	AsientoContableItem.CuentaContable.CostoVenta.numero
	, CostoVenta_70_nombre                         	VARCHAR(50)  		-- 72	AsientoContableItem.CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_73_id                        	VARCHAR(36)  		-- 73	AsientoContableItem.CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_73_numero                    	INTEGER      		-- 74	AsientoContableItem.CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_73_nombre                    	VARCHAR(50)  		-- 75	AsientoContableItem.CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_73_equate                    	VARCHAR(30)  		-- 76	AsientoContableItem.CuentaContable.SeguridadPuerta.equate
	, SeguridadPuerta_73_seguridadModulo           	VARCHAR(36)  		-- 77	AsientoContableItem.CuentaContable.SeguridadPuerta.seguridadModulo
	, AsientoContableItem_debe                     	DECIMAL(13,5)		-- 78	AsientoContableItem.debe
	, AsientoContableItem_haber                    	DECIMAL(13,5)		-- 79	AsientoContableItem.haber

);

DROP TYPE IF EXISTS massoftware.t_AsientoContableItem_3 CASCADE;

CREATE TYPE massoftware.t_AsientoContableItem_3 AS (

	  AsientoContableItem_id                       	VARCHAR(36)  		-- 0	AsientoContableItem.id
	, AsientoContableItem_numero                   	INTEGER      		-- 1	AsientoContableItem.numero
	, AsientoContableItem_fecha                    	DATE         		-- 2	AsientoContableItem.fecha
	, AsientoContableItem_detalle                  	VARCHAR(100) 		-- 3	AsientoContableItem.detalle
	, AsientoContable_4_id                         	VARCHAR(36)  		-- 4	AsientoContableItem.AsientoContable.id
	, AsientoContable_4_numero                     	INTEGER      		-- 5	AsientoContableItem.AsientoContable.numero
	, AsientoContable_4_fecha                      	DATE         		-- 6	AsientoContableItem.AsientoContable.fecha
	, AsientoContable_4_detalle                    	VARCHAR(100) 		-- 7	AsientoContableItem.AsientoContable.detalle
	, EjercicioContable_8_id                       	VARCHAR(36)  		-- 8	AsientoContableItem.AsientoContable.EjercicioContable.id
	, EjercicioContable_8_numero                   	INTEGER      		-- 9	AsientoContableItem.AsientoContable.EjercicioContable.numero
	, EjercicioContable_8_apertura                 	DATE         		-- 10	AsientoContableItem.AsientoContable.EjercicioContable.apertura
	, EjercicioContable_8_cierre                   	DATE         		-- 11	AsientoContableItem.AsientoContable.EjercicioContable.cierre
	, EjercicioContable_8_cerrado                  	BOOLEAN      		-- 12	AsientoContableItem.AsientoContable.EjercicioContable.cerrado
	, EjercicioContable_8_cerradoModulos           	BOOLEAN      		-- 13	AsientoContableItem.AsientoContable.EjercicioContable.cerradoModulos
	, EjercicioContable_8_comentario               	VARCHAR(250) 		-- 14	AsientoContableItem.AsientoContable.EjercicioContable.comentario
	, MinutaContable_15_id                         	VARCHAR(36)  		-- 15	AsientoContableItem.AsientoContable.MinutaContable.id
	, MinutaContable_15_numero                     	INTEGER      		-- 16	AsientoContableItem.AsientoContable.MinutaContable.numero
	, MinutaContable_15_nombre                     	VARCHAR(50)  		-- 17	AsientoContableItem.AsientoContable.MinutaContable.nombre
	, Sucursal_18_id                               	VARCHAR(36)  		-- 18	AsientoContableItem.AsientoContable.Sucursal.id
	, Sucursal_18_numero                           	INTEGER      		-- 19	AsientoContableItem.AsientoContable.Sucursal.numero
	, Sucursal_18_nombre                           	VARCHAR(50)  		-- 20	AsientoContableItem.AsientoContable.Sucursal.nombre
	, Sucursal_18_abreviatura                      	VARCHAR(5)   		-- 21	AsientoContableItem.AsientoContable.Sucursal.abreviatura
	, TipoSucursal_22_id                           	VARCHAR(36)  		-- 22	AsientoContableItem.AsientoContable.Sucursal.TipoSucursal.id
	, TipoSucursal_22_numero                       	INTEGER      		-- 23	AsientoContableItem.AsientoContable.Sucursal.TipoSucursal.numero
	, TipoSucursal_22_nombre                       	VARCHAR(50)  		-- 24	AsientoContableItem.AsientoContable.Sucursal.TipoSucursal.nombre
	, Sucursal_18_cuentaClientesDesde              	VARCHAR(7)   		-- 25	AsientoContableItem.AsientoContable.Sucursal.cuentaClientesDesde
	, Sucursal_18_cuentaClientesHasta              	VARCHAR(7)   		-- 26	AsientoContableItem.AsientoContable.Sucursal.cuentaClientesHasta
	, Sucursal_18_cantidadCaracteresClientes       	INTEGER      		-- 27	AsientoContableItem.AsientoContable.Sucursal.cantidadCaracteresClientes
	, Sucursal_18_identificacionNumericaClientes   	BOOLEAN      		-- 28	AsientoContableItem.AsientoContable.Sucursal.identificacionNumericaClientes
	, Sucursal_18_permiteCambiarClientes           	BOOLEAN      		-- 29	AsientoContableItem.AsientoContable.Sucursal.permiteCambiarClientes
	, Sucursal_18_cuentaProveedoresDesde           	VARCHAR(6)   		-- 30	AsientoContableItem.AsientoContable.Sucursal.cuentaProveedoresDesde
	, Sucursal_18_cuentaProveedoresHasta           	VARCHAR(6)   		-- 31	AsientoContableItem.AsientoContable.Sucursal.cuentaProveedoresHasta
	, Sucursal_18_cantidadCaracteresProveedores    	INTEGER      		-- 32	AsientoContableItem.AsientoContable.Sucursal.cantidadCaracteresProveedores
	, Sucursal_18_identificacionNumericaProveedores	BOOLEAN      		-- 33	AsientoContableItem.AsientoContable.Sucursal.identificacionNumericaProveedores
	, Sucursal_18_permiteCambiarProveedores        	BOOLEAN      		-- 34	AsientoContableItem.AsientoContable.Sucursal.permiteCambiarProveedores
	, Sucursal_18_clientesOcacionalesDesde         	INTEGER      		-- 35	AsientoContableItem.AsientoContable.Sucursal.clientesOcacionalesDesde
	, Sucursal_18_clientesOcacionalesHasta         	INTEGER      		-- 36	AsientoContableItem.AsientoContable.Sucursal.clientesOcacionalesHasta
	, Sucursal_18_numeroCobranzaDesde              	INTEGER      		-- 37	AsientoContableItem.AsientoContable.Sucursal.numeroCobranzaDesde
	, Sucursal_18_numeroCobranzaHasta              	INTEGER      		-- 38	AsientoContableItem.AsientoContable.Sucursal.numeroCobranzaHasta
	, AsientoContableModulo_39_id                  	VARCHAR(36)  		-- 39	AsientoContableItem.AsientoContable.AsientoContableModulo.id
	, AsientoContableModulo_39_numero              	INTEGER      		-- 40	AsientoContableItem.AsientoContable.AsientoContableModulo.numero
	, AsientoContableModulo_39_nombre              	VARCHAR(50)  		-- 41	AsientoContableItem.AsientoContable.AsientoContableModulo.nombre
	, CuentaContable_42_id                         	VARCHAR(36)  		-- 42	AsientoContableItem.CuentaContable.id
	, CuentaContable_42_codigo                     	VARCHAR(11)  		-- 43	AsientoContableItem.CuentaContable.codigo
	, CuentaContable_42_nombre                     	VARCHAR(50)  		-- 44	AsientoContableItem.CuentaContable.nombre
	, EjercicioContable_45_id                      	VARCHAR(36)  		-- 45	AsientoContableItem.CuentaContable.EjercicioContable.id
	, EjercicioContable_45_numero                  	INTEGER      		-- 46	AsientoContableItem.CuentaContable.EjercicioContable.numero
	, EjercicioContable_45_apertura                	DATE         		-- 47	AsientoContableItem.CuentaContable.EjercicioContable.apertura
	, EjercicioContable_45_cierre                  	DATE         		-- 48	AsientoContableItem.CuentaContable.EjercicioContable.cierre
	, EjercicioContable_45_cerrado                 	BOOLEAN      		-- 49	AsientoContableItem.CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_45_cerradoModulos          	BOOLEAN      		-- 50	AsientoContableItem.CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_45_comentario              	VARCHAR(250) 		-- 51	AsientoContableItem.CuentaContable.EjercicioContable.comentario
	, CuentaContable_42_integra                    	VARCHAR(16)  		-- 52	AsientoContableItem.CuentaContable.integra
	, CuentaContable_42_cuentaJerarquia            	VARCHAR(16)  		-- 53	AsientoContableItem.CuentaContable.cuentaJerarquia
	, CuentaContable_42_imputable                  	BOOLEAN      		-- 54	AsientoContableItem.CuentaContable.imputable
	, CuentaContable_42_ajustaPorInflacion         	BOOLEAN      		-- 55	AsientoContableItem.CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_56_id                   	VARCHAR(36)  		-- 56	AsientoContableItem.CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_56_numero               	INTEGER      		-- 57	AsientoContableItem.CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_56_nombre               	VARCHAR(50)  		-- 58	AsientoContableItem.CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_42_cuentaConApropiacion       	BOOLEAN      		-- 59	AsientoContableItem.CuentaContable.cuentaConApropiacion
	, CentroCostoContable_60_id                    	VARCHAR(36)  		-- 60	AsientoContableItem.CuentaContable.CentroCostoContable.id
	, CentroCostoContable_60_numero                	INTEGER      		-- 61	AsientoContableItem.CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_60_nombre                	VARCHAR(50)  		-- 62	AsientoContableItem.CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_60_abreviatura           	VARCHAR(5)   		-- 63	AsientoContableItem.CuentaContable.CentroCostoContable.abreviatura
	, EjercicioContable_64_id                      	VARCHAR(36)  		-- 64	AsientoContableItem.CuentaContable.CentroCostoContable.EjercicioContable.id
	, EjercicioContable_64_numero                  	INTEGER      		-- 65	AsientoContableItem.CuentaContable.CentroCostoContable.EjercicioContable.numero
	, EjercicioContable_64_apertura                	DATE         		-- 66	AsientoContableItem.CuentaContable.CentroCostoContable.EjercicioContable.apertura
	, EjercicioContable_64_cierre                  	DATE         		-- 67	AsientoContableItem.CuentaContable.CentroCostoContable.EjercicioContable.cierre
	, EjercicioContable_64_cerrado                 	BOOLEAN      		-- 68	AsientoContableItem.CuentaContable.CentroCostoContable.EjercicioContable.cerrado
	, EjercicioContable_64_cerradoModulos          	BOOLEAN      		-- 69	AsientoContableItem.CuentaContable.CentroCostoContable.EjercicioContable.cerradoModulos
	, EjercicioContable_64_comentario              	VARCHAR(250) 		-- 70	AsientoContableItem.CuentaContable.CentroCostoContable.EjercicioContable.comentario
	, CuentaContable_42_cuentaAgrupadora           	VARCHAR(50)  		-- 71	AsientoContableItem.CuentaContable.cuentaAgrupadora
	, CuentaContable_42_porcentaje                 	DECIMAL(6,3) 		-- 72	AsientoContableItem.CuentaContable.porcentaje
	, PuntoEquilibrio_73_id                        	VARCHAR(36)  		-- 73	AsientoContableItem.CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_73_numero                    	INTEGER      		-- 74	AsientoContableItem.CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_73_nombre                    	VARCHAR(50)  		-- 75	AsientoContableItem.CuentaContable.PuntoEquilibrio.nombre
	, TipoPuntoEquilibrio_76_id                    	VARCHAR(36)  		-- 76	AsientoContableItem.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.id
	, TipoPuntoEquilibrio_76_numero                	INTEGER      		-- 77	AsientoContableItem.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.numero
	, TipoPuntoEquilibrio_76_nombre                	VARCHAR(50)  		-- 78	AsientoContableItem.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.nombre
	, EjercicioContable_79_id                      	VARCHAR(36)  		-- 79	AsientoContableItem.CuentaContable.PuntoEquilibrio.EjercicioContable.id
	, EjercicioContable_79_numero                  	INTEGER      		-- 80	AsientoContableItem.CuentaContable.PuntoEquilibrio.EjercicioContable.numero
	, EjercicioContable_79_apertura                	DATE         		-- 81	AsientoContableItem.CuentaContable.PuntoEquilibrio.EjercicioContable.apertura
	, EjercicioContable_79_cierre                  	DATE         		-- 82	AsientoContableItem.CuentaContable.PuntoEquilibrio.EjercicioContable.cierre
	, EjercicioContable_79_cerrado                 	BOOLEAN      		-- 83	AsientoContableItem.CuentaContable.PuntoEquilibrio.EjercicioContable.cerrado
	, EjercicioContable_79_cerradoModulos          	BOOLEAN      		-- 84	AsientoContableItem.CuentaContable.PuntoEquilibrio.EjercicioContable.cerradoModulos
	, EjercicioContable_79_comentario              	VARCHAR(250) 		-- 85	AsientoContableItem.CuentaContable.PuntoEquilibrio.EjercicioContable.comentario
	, CostoVenta_86_id                             	VARCHAR(36)  		-- 86	AsientoContableItem.CuentaContable.CostoVenta.id
	, CostoVenta_86_numero                         	INTEGER      		-- 87	AsientoContableItem.CuentaContable.CostoVenta.numero
	, CostoVenta_86_nombre                         	VARCHAR(50)  		-- 88	AsientoContableItem.CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_89_id                        	VARCHAR(36)  		-- 89	AsientoContableItem.CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_89_numero                    	INTEGER      		-- 90	AsientoContableItem.CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_89_nombre                    	VARCHAR(50)  		-- 91	AsientoContableItem.CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_89_equate                    	VARCHAR(30)  		-- 92	AsientoContableItem.CuentaContable.SeguridadPuerta.equate
	, SeguridadModulo_93_id                        	VARCHAR(36)  		-- 93	AsientoContableItem.CuentaContable.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_93_numero                    	INTEGER      		-- 94	AsientoContableItem.CuentaContable.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_93_nombre                    	VARCHAR(50)  		-- 95	AsientoContableItem.CuentaContable.SeguridadPuerta.SeguridadModulo.nombre
	, AsientoContableItem_debe                     	DECIMAL(13,5)		-- 96	AsientoContableItem.debe
	, AsientoContableItem_haber                    	DECIMAL(13,5)		-- 97	AsientoContableItem.haber

);

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableItem (

	  idArg0                VARCHAR(36) 	-- 0
	, orderByArg1           INTEGER     	-- 1
	, orderByDescArg2       BOOLEAN     	-- 2
	, limitArg3             BIGINT      	-- 3
	, offSetArg4            BIGINT      	-- 4
	, numeroFromArg5        INTEGER     	-- 5
	, numeroToArg6          INTEGER     	-- 6
	, detalleArg7           VARCHAR(100)	-- 7
	, asientoContableArg8   VARCHAR(36) 	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableItem (

	  idArg0                VARCHAR(36) 	-- 0
	, orderByArg1           INTEGER     	-- 1
	, orderByDescArg2       BOOLEAN     	-- 2
	, limitArg3             BIGINT      	-- 3
	, offSetArg4            BIGINT      	-- 4
	, numeroFromArg5        INTEGER     	-- 5
	, numeroToArg6          INTEGER     	-- 6
	, detalleArg7           VARCHAR(100)	-- 7
	, asientoContableArg8   VARCHAR(36) 	-- 8

) RETURNS SETOF massoftware.AsientoContableItem AS $$

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
				  AsientoContableItem.id                 AS AsientoContableItem_id             	-- 0	.id            		VARCHAR(36)
				, AsientoContableItem.numero             AS AsientoContableItem_numero         	-- 1	.numero        		INTEGER
				, AsientoContableItem.fecha              AS AsientoContableItem_fecha          	-- 2	.fecha         		DATE
				, AsientoContableItem.detalle            AS AsientoContableItem_detalle        	-- 3	.detalle       		VARCHAR(100)
				, AsientoContableItem.asientoContable    AS AsientoContableItem_asientoContable	-- 4	.asientoContable		VARCHAR(36)	AsientoContable.id
				, AsientoContableItem.cuentaContable     AS AsientoContableItem_cuentaContable 	-- 5	.cuentaContable		VARCHAR(36)	CuentaContable.id
				, AsientoContableItem.debe               AS AsientoContableItem_debe           	-- 6	.debe          		DECIMAL(13,5)
				, AsientoContableItem.haber              AS AsientoContableItem_haber          	-- 7	.haber         		DECIMAL(13,5)

		FROM	massoftware.AsientoContableItem

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContableItem.detalle),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND asientoContableArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoContableArg8)) > 0 THEN
		asientoContableArg8 = REPLACE(asientoContableArg8, '''', '''''');
		asientoContableArg8 = LOWER(TRIM(asientoContableArg8));
		asientoContableArg8 = TRANSLATE(asientoContableArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoContableArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContableItem.asientoContable),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableItemById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableItemById (idArg VARCHAR(36)) RETURNS SETOF massoftware.AsientoContableItem AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoContableItem ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoContableItem ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoContableItemById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableItem_1 (

	  idArg0                VARCHAR(36) 	-- 0
	, orderByArg1           INTEGER     	-- 1
	, orderByDescArg2       BOOLEAN     	-- 2
	, limitArg3             BIGINT      	-- 3
	, offSetArg4            BIGINT      	-- 4
	, numeroFromArg5        INTEGER     	-- 5
	, numeroToArg6          INTEGER     	-- 6
	, detalleArg7           VARCHAR(100)	-- 7
	, asientoContableArg8   VARCHAR(36) 	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableItem_1 (

	  idArg0                VARCHAR(36) 	-- 0
	, orderByArg1           INTEGER     	-- 1
	, orderByDescArg2       BOOLEAN     	-- 2
	, limitArg3             BIGINT      	-- 3
	, offSetArg4            BIGINT      	-- 4
	, numeroFromArg5        INTEGER     	-- 5
	, numeroToArg6          INTEGER     	-- 6
	, detalleArg7           VARCHAR(100)	-- 7
	, asientoContableArg8   VARCHAR(36) 	-- 8

) RETURNS SETOF massoftware.t_AsientoContableItem_1 AS $$

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
				  AsientoContableItem.id                      AS AsientoContableItem_id                 	-- 0	.id                                  		VARCHAR(36)
				, AsientoContableItem.numero                  AS AsientoContableItem_numero             	-- 1	.numero                              		INTEGER
				, AsientoContableItem.fecha                   AS AsientoContableItem_fecha              	-- 2	.fecha                               		DATE
				, AsientoContableItem.detalle                 AS AsientoContableItem_detalle            	-- 3	.detalle                             		VARCHAR(100)
				, AsientoContable_4.id                        AS AsientoContable_4_id                   	-- 4	.AsientoContable.id                  		VARCHAR(36)
				, AsientoContable_4.numero                    AS AsientoContable_4_numero               	-- 5	.AsientoContable.numero              		INTEGER
				, AsientoContable_4.fecha                     AS AsientoContable_4_fecha                	-- 6	.AsientoContable.fecha               		DATE
				, AsientoContable_4.detalle                   AS AsientoContable_4_detalle              	-- 7	.AsientoContable.detalle             		VARCHAR(100)
				, AsientoContable_4.ejercicioContable         AS AsientoContable_4_ejercicioContable    	-- 8	.AsientoContable.ejercicioContable   		VARCHAR(36)	EjercicioContable.id
				, AsientoContable_4.minutaContable            AS AsientoContable_4_minutaContable       	-- 9	.AsientoContable.minutaContable      		VARCHAR(36)	MinutaContable.id
				, AsientoContable_4.sucursal                  AS AsientoContable_4_sucursal             	-- 10	.AsientoContable.sucursal            		VARCHAR(36)	Sucursal.id
				, AsientoContable_4.asientoContableModulo     AS AsientoContable_4_asientoContableModulo	-- 11	.AsientoContable.asientoContableModulo		VARCHAR(36)	AsientoContableModulo.id
				, CuentaContable_12.id                        AS CuentaContable_12_id                   	-- 12	.CuentaContable.id                   		VARCHAR(36)
				, CuentaContable_12.codigo                    AS CuentaContable_12_codigo               	-- 13	.CuentaContable.codigo               		VARCHAR(11)
				, CuentaContable_12.nombre                    AS CuentaContable_12_nombre               	-- 14	.CuentaContable.nombre               		VARCHAR(50)
				, CuentaContable_12.ejercicioContable         AS CuentaContable_12_ejercicioContable    	-- 15	.CuentaContable.ejercicioContable    		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_12.integra                   AS CuentaContable_12_integra              	-- 16	.CuentaContable.integra              		VARCHAR(16)
				, CuentaContable_12.cuentaJerarquia           AS CuentaContable_12_cuentaJerarquia      	-- 17	.CuentaContable.cuentaJerarquia      		VARCHAR(16)
				, CuentaContable_12.imputable                 AS CuentaContable_12_imputable            	-- 18	.CuentaContable.imputable            		BOOLEAN
				, CuentaContable_12.ajustaPorInflacion        AS CuentaContable_12_ajustaPorInflacion   	-- 19	.CuentaContable.ajustaPorInflacion   		BOOLEAN
				, CuentaContable_12.cuentaContableEstado      AS CuentaContable_12_cuentaContableEstado 	-- 20	.CuentaContable.cuentaContableEstado 		VARCHAR(36)	CuentaContableEstado.id
				, CuentaContable_12.cuentaConApropiacion      AS CuentaContable_12_cuentaConApropiacion 	-- 21	.CuentaContable.cuentaConApropiacion 		BOOLEAN
				, CuentaContable_12.centroCostoContable       AS CuentaContable_12_centroCostoContable  	-- 22	.CuentaContable.centroCostoContable  		VARCHAR(36)	CentroCostoContable.id
				, CuentaContable_12.cuentaAgrupadora          AS CuentaContable_12_cuentaAgrupadora     	-- 23	.CuentaContable.cuentaAgrupadora     		VARCHAR(50)
				, CuentaContable_12.porcentaje                AS CuentaContable_12_porcentaje           	-- 24	.CuentaContable.porcentaje           		DECIMAL(6,3)
				, CuentaContable_12.puntoEquilibrio           AS CuentaContable_12_puntoEquilibrio      	-- 25	.CuentaContable.puntoEquilibrio      		VARCHAR(36)	PuntoEquilibrio.id
				, CuentaContable_12.costoVenta                AS CuentaContable_12_costoVenta           	-- 26	.CuentaContable.costoVenta           		VARCHAR(36)	CostoVenta.id
				, CuentaContable_12.seguridadPuerta           AS CuentaContable_12_seguridadPuerta      	-- 27	.CuentaContable.seguridadPuerta      		VARCHAR(36)	SeguridadPuerta.id
				, AsientoContableItem.debe                    AS AsientoContableItem_debe               	-- 28	.debe                                		DECIMAL(13,5)
				, AsientoContableItem.haber                   AS AsientoContableItem_haber              	-- 29	.haber                               		DECIMAL(13,5)

		FROM	massoftware.AsientoContableItem
			LEFT JOIN massoftware.AsientoContable AS AsientoContable_4        ON AsientoContableItem.asientoContable = AsientoContable_4.id 	-- 4 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaContable AS CuentaContable_12         ON AsientoContableItem.cuentaContable = CuentaContable_12.id 	-- 12 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContableItem.detalle),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND asientoContableArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoContableArg8)) > 0 THEN
		asientoContableArg8 = REPLACE(asientoContableArg8, '''', '''''');
		asientoContableArg8 = LOWER(TRIM(asientoContableArg8));
		asientoContableArg8 = TRANSLATE(asientoContableArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoContableArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContableItem.asientoContable),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableItemById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableItemById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_AsientoContableItem_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoContableItem_1 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoContableItem_1 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoContableItemById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableItem_2 (

	  idArg0                VARCHAR(36) 	-- 0
	, orderByArg1           INTEGER     	-- 1
	, orderByDescArg2       BOOLEAN     	-- 2
	, limitArg3             BIGINT      	-- 3
	, offSetArg4            BIGINT      	-- 4
	, numeroFromArg5        INTEGER     	-- 5
	, numeroToArg6          INTEGER     	-- 6
	, detalleArg7           VARCHAR(100)	-- 7
	, asientoContableArg8   VARCHAR(36) 	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableItem_2 (

	  idArg0                VARCHAR(36) 	-- 0
	, orderByArg1           INTEGER     	-- 1
	, orderByDescArg2       BOOLEAN     	-- 2
	, limitArg3             BIGINT      	-- 3
	, offSetArg4            BIGINT      	-- 4
	, numeroFromArg5        INTEGER     	-- 5
	, numeroToArg6          INTEGER     	-- 6
	, detalleArg7           VARCHAR(100)	-- 7
	, asientoContableArg8   VARCHAR(36) 	-- 8

) RETURNS SETOF massoftware.t_AsientoContableItem_2 AS $$

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
				  AsientoContableItem.id                            AS AsientoContableItem_id                       	-- 0	.id                                                       		VARCHAR(36)
				, AsientoContableItem.numero                        AS AsientoContableItem_numero                   	-- 1	.numero                                                   		INTEGER
				, AsientoContableItem.fecha                         AS AsientoContableItem_fecha                    	-- 2	.fecha                                                    		DATE
				, AsientoContableItem.detalle                       AS AsientoContableItem_detalle                  	-- 3	.detalle                                                  		VARCHAR(100)
				, AsientoContable_4.id                              AS AsientoContable_4_id                         	-- 4	.AsientoContable.id                                       		VARCHAR(36)
				, AsientoContable_4.numero                          AS AsientoContable_4_numero                     	-- 5	.AsientoContable.numero                                   		INTEGER
				, AsientoContable_4.fecha                           AS AsientoContable_4_fecha                      	-- 6	.AsientoContable.fecha                                    		DATE
				, AsientoContable_4.detalle                         AS AsientoContable_4_detalle                    	-- 7	.AsientoContable.detalle                                  		VARCHAR(100)
				, EjercicioContable_8.id                            AS EjercicioContable_8_id                       	-- 8	.AsientoContable.EjercicioContable.id                     		VARCHAR(36)
				, EjercicioContable_8.numero                        AS EjercicioContable_8_numero                   	-- 9	.AsientoContable.EjercicioContable.numero                 		INTEGER
				, EjercicioContable_8.apertura                      AS EjercicioContable_8_apertura                 	-- 10	.AsientoContable.EjercicioContable.apertura               		DATE
				, EjercicioContable_8.cierre                        AS EjercicioContable_8_cierre                   	-- 11	.AsientoContable.EjercicioContable.cierre                 		DATE
				, EjercicioContable_8.cerrado                       AS EjercicioContable_8_cerrado                  	-- 12	.AsientoContable.EjercicioContable.cerrado                		BOOLEAN
				, EjercicioContable_8.cerradoModulos                AS EjercicioContable_8_cerradoModulos           	-- 13	.AsientoContable.EjercicioContable.cerradoModulos         		BOOLEAN
				, EjercicioContable_8.comentario                    AS EjercicioContable_8_comentario               	-- 14	.AsientoContable.EjercicioContable.comentario             		VARCHAR(250)
				, MinutaContable_15.id                              AS MinutaContable_15_id                         	-- 15	.AsientoContable.MinutaContable.id                        		VARCHAR(36)
				, MinutaContable_15.numero                          AS MinutaContable_15_numero                     	-- 16	.AsientoContable.MinutaContable.numero                    		INTEGER
				, MinutaContable_15.nombre                          AS MinutaContable_15_nombre                     	-- 17	.AsientoContable.MinutaContable.nombre                    		VARCHAR(50)
				, Sucursal_18.id                                    AS Sucursal_18_id                               	-- 18	.AsientoContable.Sucursal.id                              		VARCHAR(36)
				, Sucursal_18.numero                                AS Sucursal_18_numero                           	-- 19	.AsientoContable.Sucursal.numero                          		INTEGER
				, Sucursal_18.nombre                                AS Sucursal_18_nombre                           	-- 20	.AsientoContable.Sucursal.nombre                          		VARCHAR(50)
				, Sucursal_18.abreviatura                           AS Sucursal_18_abreviatura                      	-- 21	.AsientoContable.Sucursal.abreviatura                     		VARCHAR(5)
				, Sucursal_18.tipoSucursal                          AS Sucursal_18_tipoSucursal                     	-- 22	.AsientoContable.Sucursal.tipoSucursal                    		VARCHAR(36)	TipoSucursal.id
				, Sucursal_18.cuentaClientesDesde                   AS Sucursal_18_cuentaClientesDesde              	-- 23	.AsientoContable.Sucursal.cuentaClientesDesde             		VARCHAR(7)
				, Sucursal_18.cuentaClientesHasta                   AS Sucursal_18_cuentaClientesHasta              	-- 24	.AsientoContable.Sucursal.cuentaClientesHasta             		VARCHAR(7)
				, Sucursal_18.cantidadCaracteresClientes            AS Sucursal_18_cantidadCaracteresClientes       	-- 25	.AsientoContable.Sucursal.cantidadCaracteresClientes      		INTEGER
				, Sucursal_18.identificacionNumericaClientes        AS Sucursal_18_identificacionNumericaClientes   	-- 26	.AsientoContable.Sucursal.identificacionNumericaClientes  		BOOLEAN
				, Sucursal_18.permiteCambiarClientes                AS Sucursal_18_permiteCambiarClientes           	-- 27	.AsientoContable.Sucursal.permiteCambiarClientes          		BOOLEAN
				, Sucursal_18.cuentaProveedoresDesde                AS Sucursal_18_cuentaProveedoresDesde           	-- 28	.AsientoContable.Sucursal.cuentaProveedoresDesde          		VARCHAR(6)
				, Sucursal_18.cuentaProveedoresHasta                AS Sucursal_18_cuentaProveedoresHasta           	-- 29	.AsientoContable.Sucursal.cuentaProveedoresHasta          		VARCHAR(6)
				, Sucursal_18.cantidadCaracteresProveedores         AS Sucursal_18_cantidadCaracteresProveedores    	-- 30	.AsientoContable.Sucursal.cantidadCaracteresProveedores   		INTEGER
				, Sucursal_18.identificacionNumericaProveedores     AS Sucursal_18_identificacionNumericaProveedores	-- 31	.AsientoContable.Sucursal.identificacionNumericaProveedores		BOOLEAN
				, Sucursal_18.permiteCambiarProveedores             AS Sucursal_18_permiteCambiarProveedores        	-- 32	.AsientoContable.Sucursal.permiteCambiarProveedores       		BOOLEAN
				, Sucursal_18.clientesOcacionalesDesde              AS Sucursal_18_clientesOcacionalesDesde         	-- 33	.AsientoContable.Sucursal.clientesOcacionalesDesde        		INTEGER
				, Sucursal_18.clientesOcacionalesHasta              AS Sucursal_18_clientesOcacionalesHasta         	-- 34	.AsientoContable.Sucursal.clientesOcacionalesHasta        		INTEGER
				, Sucursal_18.numeroCobranzaDesde                   AS Sucursal_18_numeroCobranzaDesde              	-- 35	.AsientoContable.Sucursal.numeroCobranzaDesde             		INTEGER
				, Sucursal_18.numeroCobranzaHasta                   AS Sucursal_18_numeroCobranzaHasta              	-- 36	.AsientoContable.Sucursal.numeroCobranzaHasta             		INTEGER
				, AsientoContableModulo_37.id                       AS AsientoContableModulo_37_id                  	-- 37	.AsientoContable.AsientoContableModulo.id                 		VARCHAR(36)
				, AsientoContableModulo_37.numero                   AS AsientoContableModulo_37_numero              	-- 38	.AsientoContable.AsientoContableModulo.numero             		INTEGER
				, AsientoContableModulo_37.nombre                   AS AsientoContableModulo_37_nombre              	-- 39	.AsientoContable.AsientoContableModulo.nombre             		VARCHAR(50)
				, CuentaContable_40.id                              AS CuentaContable_40_id                         	-- 40	.CuentaContable.id                                        		VARCHAR(36)
				, CuentaContable_40.codigo                          AS CuentaContable_40_codigo                     	-- 41	.CuentaContable.codigo                                    		VARCHAR(11)
				, CuentaContable_40.nombre                          AS CuentaContable_40_nombre                     	-- 42	.CuentaContable.nombre                                    		VARCHAR(50)
				, EjercicioContable_43.id                           AS EjercicioContable_43_id                      	-- 43	.CuentaContable.EjercicioContable.id                      		VARCHAR(36)
				, EjercicioContable_43.numero                       AS EjercicioContable_43_numero                  	-- 44	.CuentaContable.EjercicioContable.numero                  		INTEGER
				, EjercicioContable_43.apertura                     AS EjercicioContable_43_apertura                	-- 45	.CuentaContable.EjercicioContable.apertura                		DATE
				, EjercicioContable_43.cierre                       AS EjercicioContable_43_cierre                  	-- 46	.CuentaContable.EjercicioContable.cierre                  		DATE
				, EjercicioContable_43.cerrado                      AS EjercicioContable_43_cerrado                 	-- 47	.CuentaContable.EjercicioContable.cerrado                 		BOOLEAN
				, EjercicioContable_43.cerradoModulos               AS EjercicioContable_43_cerradoModulos          	-- 48	.CuentaContable.EjercicioContable.cerradoModulos          		BOOLEAN
				, EjercicioContable_43.comentario                   AS EjercicioContable_43_comentario              	-- 49	.CuentaContable.EjercicioContable.comentario              		VARCHAR(250)
				, CuentaContable_40.integra                         AS CuentaContable_40_integra                    	-- 50	.CuentaContable.integra                                   		VARCHAR(16)
				, CuentaContable_40.cuentaJerarquia                 AS CuentaContable_40_cuentaJerarquia            	-- 51	.CuentaContable.cuentaJerarquia                           		VARCHAR(16)
				, CuentaContable_40.imputable                       AS CuentaContable_40_imputable                  	-- 52	.CuentaContable.imputable                                 		BOOLEAN
				, CuentaContable_40.ajustaPorInflacion              AS CuentaContable_40_ajustaPorInflacion         	-- 53	.CuentaContable.ajustaPorInflacion                        		BOOLEAN
				, CuentaContableEstado_54.id                        AS CuentaContableEstado_54_id                   	-- 54	.CuentaContable.CuentaContableEstado.id                   		VARCHAR(36)
				, CuentaContableEstado_54.numero                    AS CuentaContableEstado_54_numero               	-- 55	.CuentaContable.CuentaContableEstado.numero               		INTEGER
				, CuentaContableEstado_54.nombre                    AS CuentaContableEstado_54_nombre               	-- 56	.CuentaContable.CuentaContableEstado.nombre               		VARCHAR(50)
				, CuentaContable_40.cuentaConApropiacion            AS CuentaContable_40_cuentaConApropiacion       	-- 57	.CuentaContable.cuentaConApropiacion                      		BOOLEAN
				, CentroCostoContable_58.id                         AS CentroCostoContable_58_id                    	-- 58	.CuentaContable.CentroCostoContable.id                    		VARCHAR(36)
				, CentroCostoContable_58.numero                     AS CentroCostoContable_58_numero                	-- 59	.CuentaContable.CentroCostoContable.numero                		INTEGER
				, CentroCostoContable_58.nombre                     AS CentroCostoContable_58_nombre                	-- 60	.CuentaContable.CentroCostoContable.nombre                		VARCHAR(50)
				, CentroCostoContable_58.abreviatura                AS CentroCostoContable_58_abreviatura           	-- 61	.CuentaContable.CentroCostoContable.abreviatura           		VARCHAR(5)
				, CentroCostoContable_58.ejercicioContable          AS CentroCostoContable_58_ejercicioContable     	-- 62	.CuentaContable.CentroCostoContable.ejercicioContable     		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_40.cuentaAgrupadora                AS CuentaContable_40_cuentaAgrupadora           	-- 63	.CuentaContable.cuentaAgrupadora                          		VARCHAR(50)
				, CuentaContable_40.porcentaje                      AS CuentaContable_40_porcentaje                 	-- 64	.CuentaContable.porcentaje                                		DECIMAL(6,3)
				, PuntoEquilibrio_65.id                             AS PuntoEquilibrio_65_id                        	-- 65	.CuentaContable.PuntoEquilibrio.id                        		VARCHAR(36)
				, PuntoEquilibrio_65.numero                         AS PuntoEquilibrio_65_numero                    	-- 66	.CuentaContable.PuntoEquilibrio.numero                    		INTEGER
				, PuntoEquilibrio_65.nombre                         AS PuntoEquilibrio_65_nombre                    	-- 67	.CuentaContable.PuntoEquilibrio.nombre                    		VARCHAR(50)
				, PuntoEquilibrio_65.tipoPuntoEquilibrio            AS PuntoEquilibrio_65_tipoPuntoEquilibrio       	-- 68	.CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio       		VARCHAR(36)	TipoPuntoEquilibrio.id
				, PuntoEquilibrio_65.ejercicioContable              AS PuntoEquilibrio_65_ejercicioContable         	-- 69	.CuentaContable.PuntoEquilibrio.ejercicioContable         		VARCHAR(36)	EjercicioContable.id
				, CostoVenta_70.id                                  AS CostoVenta_70_id                             	-- 70	.CuentaContable.CostoVenta.id                             		VARCHAR(36)
				, CostoVenta_70.numero                              AS CostoVenta_70_numero                         	-- 71	.CuentaContable.CostoVenta.numero                         		INTEGER
				, CostoVenta_70.nombre                              AS CostoVenta_70_nombre                         	-- 72	.CuentaContable.CostoVenta.nombre                         		VARCHAR(50)
				, SeguridadPuerta_73.id                             AS SeguridadPuerta_73_id                        	-- 73	.CuentaContable.SeguridadPuerta.id                        		VARCHAR(36)
				, SeguridadPuerta_73.numero                         AS SeguridadPuerta_73_numero                    	-- 74	.CuentaContable.SeguridadPuerta.numero                    		INTEGER
				, SeguridadPuerta_73.nombre                         AS SeguridadPuerta_73_nombre                    	-- 75	.CuentaContable.SeguridadPuerta.nombre                    		VARCHAR(50)
				, SeguridadPuerta_73.equate                         AS SeguridadPuerta_73_equate                    	-- 76	.CuentaContable.SeguridadPuerta.equate                    		VARCHAR(30)
				, SeguridadPuerta_73.seguridadModulo                AS SeguridadPuerta_73_seguridadModulo           	-- 77	.CuentaContable.SeguridadPuerta.seguridadModulo           		VARCHAR(36)	SeguridadModulo.id
				, AsientoContableItem.debe                          AS AsientoContableItem_debe                     	-- 78	.debe                                                     		DECIMAL(13,5)
				, AsientoContableItem.haber                         AS AsientoContableItem_haber                    	-- 79	.haber                                                    		DECIMAL(13,5)

		FROM	massoftware.AsientoContableItem
			LEFT JOIN massoftware.AsientoContable AS AsientoContable_4                  ON AsientoContableItem.asientoContable = AsientoContable_4.id 	-- 4 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_8               ON AsientoContable_4.ejercicioContable = EjercicioContable_8.id 	-- 8 LEFT LEVEL: 2
				LEFT JOIN massoftware.MinutaContable AS MinutaContable_15                  ON AsientoContable_4.minutaContable = MinutaContable_15.id 	-- 15 LEFT LEVEL: 2
				LEFT JOIN massoftware.Sucursal AS Sucursal_18                        ON AsientoContable_4.sucursal = Sucursal_18.id 	-- 18 LEFT LEVEL: 2
				LEFT JOIN massoftware.AsientoContableModulo AS AsientoContableModulo_37           ON AsientoContable_4.asientoContableModulo = AsientoContableModulo_37.id 	-- 37 LEFT LEVEL: 2
			LEFT JOIN massoftware.CuentaContable AS CuentaContable_40                  ON AsientoContableItem.cuentaContable = CuentaContable_40.id 	-- 40 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_43               ON CuentaContable_40.ejercicioContable = EjercicioContable_43.id 	-- 43 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_54            ON CuentaContable_40.cuentaContableEstado = CuentaContableEstado_54.id 	-- 54 LEFT LEVEL: 2
				LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_58             ON CuentaContable_40.centroCostoContable = CentroCostoContable_58.id 	-- 58 LEFT LEVEL: 2
				LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_65                 ON CuentaContable_40.puntoEquilibrio = PuntoEquilibrio_65.id 	-- 65 LEFT LEVEL: 2
				LEFT JOIN massoftware.CostoVenta AS CostoVenta_70                      ON CuentaContable_40.costoVenta = CostoVenta_70.id 	-- 70 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_73                 ON CuentaContable_40.seguridadPuerta = SeguridadPuerta_73.id 	-- 73 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContableItem.detalle),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND asientoContableArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoContableArg8)) > 0 THEN
		asientoContableArg8 = REPLACE(asientoContableArg8, '''', '''''');
		asientoContableArg8 = LOWER(TRIM(asientoContableArg8));
		asientoContableArg8 = TRANSLATE(asientoContableArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoContableArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContableItem.asientoContable),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableItemById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableItemById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_AsientoContableItem_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoContableItem_2 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoContableItem_2 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoContableItemById_2 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableItem_3 (

	  idArg0                VARCHAR(36) 	-- 0
	, orderByArg1           INTEGER     	-- 1
	, orderByDescArg2       BOOLEAN     	-- 2
	, limitArg3             BIGINT      	-- 3
	, offSetArg4            BIGINT      	-- 4
	, numeroFromArg5        INTEGER     	-- 5
	, numeroToArg6          INTEGER     	-- 6
	, detalleArg7           VARCHAR(100)	-- 7
	, asientoContableArg8   VARCHAR(36) 	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableItem_3 (

	  idArg0                VARCHAR(36) 	-- 0
	, orderByArg1           INTEGER     	-- 1
	, orderByDescArg2       BOOLEAN     	-- 2
	, limitArg3             BIGINT      	-- 3
	, offSetArg4            BIGINT      	-- 4
	, numeroFromArg5        INTEGER     	-- 5
	, numeroToArg6          INTEGER     	-- 6
	, detalleArg7           VARCHAR(100)	-- 7
	, asientoContableArg8   VARCHAR(36) 	-- 8

) RETURNS SETOF massoftware.t_AsientoContableItem_3 AS $$

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
				  AsientoContableItem.id                            AS AsientoContableItem_id                       	-- 0	.id                                                                		VARCHAR(36)
				, AsientoContableItem.numero                        AS AsientoContableItem_numero                   	-- 1	.numero                                                            		INTEGER
				, AsientoContableItem.fecha                         AS AsientoContableItem_fecha                    	-- 2	.fecha                                                             		DATE
				, AsientoContableItem.detalle                       AS AsientoContableItem_detalle                  	-- 3	.detalle                                                           		VARCHAR(100)
				, AsientoContable_4.id                              AS AsientoContable_4_id                         	-- 4	.AsientoContable.id                                                		VARCHAR(36)
				, AsientoContable_4.numero                          AS AsientoContable_4_numero                     	-- 5	.AsientoContable.numero                                            		INTEGER
				, AsientoContable_4.fecha                           AS AsientoContable_4_fecha                      	-- 6	.AsientoContable.fecha                                             		DATE
				, AsientoContable_4.detalle                         AS AsientoContable_4_detalle                    	-- 7	.AsientoContable.detalle                                           		VARCHAR(100)
				, EjercicioContable_8.id                            AS EjercicioContable_8_id                       	-- 8	.AsientoContable.EjercicioContable.id                              		VARCHAR(36)
				, EjercicioContable_8.numero                        AS EjercicioContable_8_numero                   	-- 9	.AsientoContable.EjercicioContable.numero                          		INTEGER
				, EjercicioContable_8.apertura                      AS EjercicioContable_8_apertura                 	-- 10	.AsientoContable.EjercicioContable.apertura                        		DATE
				, EjercicioContable_8.cierre                        AS EjercicioContable_8_cierre                   	-- 11	.AsientoContable.EjercicioContable.cierre                          		DATE
				, EjercicioContable_8.cerrado                       AS EjercicioContable_8_cerrado                  	-- 12	.AsientoContable.EjercicioContable.cerrado                         		BOOLEAN
				, EjercicioContable_8.cerradoModulos                AS EjercicioContable_8_cerradoModulos           	-- 13	.AsientoContable.EjercicioContable.cerradoModulos                  		BOOLEAN
				, EjercicioContable_8.comentario                    AS EjercicioContable_8_comentario               	-- 14	.AsientoContable.EjercicioContable.comentario                      		VARCHAR(250)
				, MinutaContable_15.id                              AS MinutaContable_15_id                         	-- 15	.AsientoContable.MinutaContable.id                                 		VARCHAR(36)
				, MinutaContable_15.numero                          AS MinutaContable_15_numero                     	-- 16	.AsientoContable.MinutaContable.numero                             		INTEGER
				, MinutaContable_15.nombre                          AS MinutaContable_15_nombre                     	-- 17	.AsientoContable.MinutaContable.nombre                             		VARCHAR(50)
				, Sucursal_18.id                                    AS Sucursal_18_id                               	-- 18	.AsientoContable.Sucursal.id                                       		VARCHAR(36)
				, Sucursal_18.numero                                AS Sucursal_18_numero                           	-- 19	.AsientoContable.Sucursal.numero                                   		INTEGER
				, Sucursal_18.nombre                                AS Sucursal_18_nombre                           	-- 20	.AsientoContable.Sucursal.nombre                                   		VARCHAR(50)
				, Sucursal_18.abreviatura                           AS Sucursal_18_abreviatura                      	-- 21	.AsientoContable.Sucursal.abreviatura                              		VARCHAR(5)
				, TipoSucursal_22.id                                AS TipoSucursal_22_id                           	-- 22	.AsientoContable.Sucursal.TipoSucursal.id                          		VARCHAR(36)
				, TipoSucursal_22.numero                            AS TipoSucursal_22_numero                       	-- 23	.AsientoContable.Sucursal.TipoSucursal.numero                      		INTEGER
				, TipoSucursal_22.nombre                            AS TipoSucursal_22_nombre                       	-- 24	.AsientoContable.Sucursal.TipoSucursal.nombre                      		VARCHAR(50)
				, Sucursal_18.cuentaClientesDesde                   AS Sucursal_18_cuentaClientesDesde              	-- 25	.AsientoContable.Sucursal.cuentaClientesDesde                      		VARCHAR(7)
				, Sucursal_18.cuentaClientesHasta                   AS Sucursal_18_cuentaClientesHasta              	-- 26	.AsientoContable.Sucursal.cuentaClientesHasta                      		VARCHAR(7)
				, Sucursal_18.cantidadCaracteresClientes            AS Sucursal_18_cantidadCaracteresClientes       	-- 27	.AsientoContable.Sucursal.cantidadCaracteresClientes               		INTEGER
				, Sucursal_18.identificacionNumericaClientes        AS Sucursal_18_identificacionNumericaClientes   	-- 28	.AsientoContable.Sucursal.identificacionNumericaClientes           		BOOLEAN
				, Sucursal_18.permiteCambiarClientes                AS Sucursal_18_permiteCambiarClientes           	-- 29	.AsientoContable.Sucursal.permiteCambiarClientes                   		BOOLEAN
				, Sucursal_18.cuentaProveedoresDesde                AS Sucursal_18_cuentaProveedoresDesde           	-- 30	.AsientoContable.Sucursal.cuentaProveedoresDesde                   		VARCHAR(6)
				, Sucursal_18.cuentaProveedoresHasta                AS Sucursal_18_cuentaProveedoresHasta           	-- 31	.AsientoContable.Sucursal.cuentaProveedoresHasta                   		VARCHAR(6)
				, Sucursal_18.cantidadCaracteresProveedores         AS Sucursal_18_cantidadCaracteresProveedores    	-- 32	.AsientoContable.Sucursal.cantidadCaracteresProveedores            		INTEGER
				, Sucursal_18.identificacionNumericaProveedores     AS Sucursal_18_identificacionNumericaProveedores	-- 33	.AsientoContable.Sucursal.identificacionNumericaProveedores        		BOOLEAN
				, Sucursal_18.permiteCambiarProveedores             AS Sucursal_18_permiteCambiarProveedores        	-- 34	.AsientoContable.Sucursal.permiteCambiarProveedores                		BOOLEAN
				, Sucursal_18.clientesOcacionalesDesde              AS Sucursal_18_clientesOcacionalesDesde         	-- 35	.AsientoContable.Sucursal.clientesOcacionalesDesde                 		INTEGER
				, Sucursal_18.clientesOcacionalesHasta              AS Sucursal_18_clientesOcacionalesHasta         	-- 36	.AsientoContable.Sucursal.clientesOcacionalesHasta                 		INTEGER
				, Sucursal_18.numeroCobranzaDesde                   AS Sucursal_18_numeroCobranzaDesde              	-- 37	.AsientoContable.Sucursal.numeroCobranzaDesde                      		INTEGER
				, Sucursal_18.numeroCobranzaHasta                   AS Sucursal_18_numeroCobranzaHasta              	-- 38	.AsientoContable.Sucursal.numeroCobranzaHasta                      		INTEGER
				, AsientoContableModulo_39.id                       AS AsientoContableModulo_39_id                  	-- 39	.AsientoContable.AsientoContableModulo.id                          		VARCHAR(36)
				, AsientoContableModulo_39.numero                   AS AsientoContableModulo_39_numero              	-- 40	.AsientoContable.AsientoContableModulo.numero                      		INTEGER
				, AsientoContableModulo_39.nombre                   AS AsientoContableModulo_39_nombre              	-- 41	.AsientoContable.AsientoContableModulo.nombre                      		VARCHAR(50)
				, CuentaContable_42.id                              AS CuentaContable_42_id                         	-- 42	.CuentaContable.id                                                 		VARCHAR(36)
				, CuentaContable_42.codigo                          AS CuentaContable_42_codigo                     	-- 43	.CuentaContable.codigo                                             		VARCHAR(11)
				, CuentaContable_42.nombre                          AS CuentaContable_42_nombre                     	-- 44	.CuentaContable.nombre                                             		VARCHAR(50)
				, EjercicioContable_45.id                           AS EjercicioContable_45_id                      	-- 45	.CuentaContable.EjercicioContable.id                               		VARCHAR(36)
				, EjercicioContable_45.numero                       AS EjercicioContable_45_numero                  	-- 46	.CuentaContable.EjercicioContable.numero                           		INTEGER
				, EjercicioContable_45.apertura                     AS EjercicioContable_45_apertura                	-- 47	.CuentaContable.EjercicioContable.apertura                         		DATE
				, EjercicioContable_45.cierre                       AS EjercicioContable_45_cierre                  	-- 48	.CuentaContable.EjercicioContable.cierre                           		DATE
				, EjercicioContable_45.cerrado                      AS EjercicioContable_45_cerrado                 	-- 49	.CuentaContable.EjercicioContable.cerrado                          		BOOLEAN
				, EjercicioContable_45.cerradoModulos               AS EjercicioContable_45_cerradoModulos          	-- 50	.CuentaContable.EjercicioContable.cerradoModulos                   		BOOLEAN
				, EjercicioContable_45.comentario                   AS EjercicioContable_45_comentario              	-- 51	.CuentaContable.EjercicioContable.comentario                       		VARCHAR(250)
				, CuentaContable_42.integra                         AS CuentaContable_42_integra                    	-- 52	.CuentaContable.integra                                            		VARCHAR(16)
				, CuentaContable_42.cuentaJerarquia                 AS CuentaContable_42_cuentaJerarquia            	-- 53	.CuentaContable.cuentaJerarquia                                    		VARCHAR(16)
				, CuentaContable_42.imputable                       AS CuentaContable_42_imputable                  	-- 54	.CuentaContable.imputable                                          		BOOLEAN
				, CuentaContable_42.ajustaPorInflacion              AS CuentaContable_42_ajustaPorInflacion         	-- 55	.CuentaContable.ajustaPorInflacion                                 		BOOLEAN
				, CuentaContableEstado_56.id                        AS CuentaContableEstado_56_id                   	-- 56	.CuentaContable.CuentaContableEstado.id                            		VARCHAR(36)
				, CuentaContableEstado_56.numero                    AS CuentaContableEstado_56_numero               	-- 57	.CuentaContable.CuentaContableEstado.numero                        		INTEGER
				, CuentaContableEstado_56.nombre                    AS CuentaContableEstado_56_nombre               	-- 58	.CuentaContable.CuentaContableEstado.nombre                        		VARCHAR(50)
				, CuentaContable_42.cuentaConApropiacion            AS CuentaContable_42_cuentaConApropiacion       	-- 59	.CuentaContable.cuentaConApropiacion                               		BOOLEAN
				, CentroCostoContable_60.id                         AS CentroCostoContable_60_id                    	-- 60	.CuentaContable.CentroCostoContable.id                             		VARCHAR(36)
				, CentroCostoContable_60.numero                     AS CentroCostoContable_60_numero                	-- 61	.CuentaContable.CentroCostoContable.numero                         		INTEGER
				, CentroCostoContable_60.nombre                     AS CentroCostoContable_60_nombre                	-- 62	.CuentaContable.CentroCostoContable.nombre                         		VARCHAR(50)
				, CentroCostoContable_60.abreviatura                AS CentroCostoContable_60_abreviatura           	-- 63	.CuentaContable.CentroCostoContable.abreviatura                    		VARCHAR(5)
				, EjercicioContable_64.id                           AS EjercicioContable_64_id                      	-- 64	.CuentaContable.CentroCostoContable.EjercicioContable.id           		VARCHAR(36)
				, EjercicioContable_64.numero                       AS EjercicioContable_64_numero                  	-- 65	.CuentaContable.CentroCostoContable.EjercicioContable.numero       		INTEGER
				, EjercicioContable_64.apertura                     AS EjercicioContable_64_apertura                	-- 66	.CuentaContable.CentroCostoContable.EjercicioContable.apertura     		DATE
				, EjercicioContable_64.cierre                       AS EjercicioContable_64_cierre                  	-- 67	.CuentaContable.CentroCostoContable.EjercicioContable.cierre       		DATE
				, EjercicioContable_64.cerrado                      AS EjercicioContable_64_cerrado                 	-- 68	.CuentaContable.CentroCostoContable.EjercicioContable.cerrado      		BOOLEAN
				, EjercicioContable_64.cerradoModulos               AS EjercicioContable_64_cerradoModulos          	-- 69	.CuentaContable.CentroCostoContable.EjercicioContable.cerradoModulos		BOOLEAN
				, EjercicioContable_64.comentario                   AS EjercicioContable_64_comentario              	-- 70	.CuentaContable.CentroCostoContable.EjercicioContable.comentario   		VARCHAR(250)
				, CuentaContable_42.cuentaAgrupadora                AS CuentaContable_42_cuentaAgrupadora           	-- 71	.CuentaContable.cuentaAgrupadora                                   		VARCHAR(50)
				, CuentaContable_42.porcentaje                      AS CuentaContable_42_porcentaje                 	-- 72	.CuentaContable.porcentaje                                         		DECIMAL(6,3)
				, PuntoEquilibrio_73.id                             AS PuntoEquilibrio_73_id                        	-- 73	.CuentaContable.PuntoEquilibrio.id                                 		VARCHAR(36)
				, PuntoEquilibrio_73.numero                         AS PuntoEquilibrio_73_numero                    	-- 74	.CuentaContable.PuntoEquilibrio.numero                             		INTEGER
				, PuntoEquilibrio_73.nombre                         AS PuntoEquilibrio_73_nombre                    	-- 75	.CuentaContable.PuntoEquilibrio.nombre                             		VARCHAR(50)
				, TipoPuntoEquilibrio_76.id                         AS TipoPuntoEquilibrio_76_id                    	-- 76	.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.id             		VARCHAR(36)
				, TipoPuntoEquilibrio_76.numero                     AS TipoPuntoEquilibrio_76_numero                	-- 77	.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.numero         		INTEGER
				, TipoPuntoEquilibrio_76.nombre                     AS TipoPuntoEquilibrio_76_nombre                	-- 78	.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.nombre         		VARCHAR(50)
				, EjercicioContable_79.id                           AS EjercicioContable_79_id                      	-- 79	.CuentaContable.PuntoEquilibrio.EjercicioContable.id               		VARCHAR(36)
				, EjercicioContable_79.numero                       AS EjercicioContable_79_numero                  	-- 80	.CuentaContable.PuntoEquilibrio.EjercicioContable.numero           		INTEGER
				, EjercicioContable_79.apertura                     AS EjercicioContable_79_apertura                	-- 81	.CuentaContable.PuntoEquilibrio.EjercicioContable.apertura         		DATE
				, EjercicioContable_79.cierre                       AS EjercicioContable_79_cierre                  	-- 82	.CuentaContable.PuntoEquilibrio.EjercicioContable.cierre           		DATE
				, EjercicioContable_79.cerrado                      AS EjercicioContable_79_cerrado                 	-- 83	.CuentaContable.PuntoEquilibrio.EjercicioContable.cerrado          		BOOLEAN
				, EjercicioContable_79.cerradoModulos               AS EjercicioContable_79_cerradoModulos          	-- 84	.CuentaContable.PuntoEquilibrio.EjercicioContable.cerradoModulos   		BOOLEAN
				, EjercicioContable_79.comentario                   AS EjercicioContable_79_comentario              	-- 85	.CuentaContable.PuntoEquilibrio.EjercicioContable.comentario       		VARCHAR(250)
				, CostoVenta_86.id                                  AS CostoVenta_86_id                             	-- 86	.CuentaContable.CostoVenta.id                                      		VARCHAR(36)
				, CostoVenta_86.numero                              AS CostoVenta_86_numero                         	-- 87	.CuentaContable.CostoVenta.numero                                  		INTEGER
				, CostoVenta_86.nombre                              AS CostoVenta_86_nombre                         	-- 88	.CuentaContable.CostoVenta.nombre                                  		VARCHAR(50)
				, SeguridadPuerta_89.id                             AS SeguridadPuerta_89_id                        	-- 89	.CuentaContable.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_89.numero                         AS SeguridadPuerta_89_numero                    	-- 90	.CuentaContable.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_89.nombre                         AS SeguridadPuerta_89_nombre                    	-- 91	.CuentaContable.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_89.equate                         AS SeguridadPuerta_89_equate                    	-- 92	.CuentaContable.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_93.id                             AS SeguridadModulo_93_id                        	-- 93	.CuentaContable.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_93.numero                         AS SeguridadModulo_93_numero                    	-- 94	.CuentaContable.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_93.nombre                         AS SeguridadModulo_93_nombre                    	-- 95	.CuentaContable.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)
				, AsientoContableItem.debe                          AS AsientoContableItem_debe                     	-- 96	.debe                                                              		DECIMAL(13,5)
				, AsientoContableItem.haber                         AS AsientoContableItem_haber                    	-- 97	.haber                                                             		DECIMAL(13,5)

		FROM	massoftware.AsientoContableItem
			LEFT JOIN massoftware.AsientoContable AS AsientoContable_4                   ON AsientoContableItem.asientoContable = AsientoContable_4.id 	-- 4 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_8                ON AsientoContable_4.ejercicioContable = EjercicioContable_8.id 	-- 8 LEFT LEVEL: 2
				LEFT JOIN massoftware.MinutaContable AS MinutaContable_15                   ON AsientoContable_4.minutaContable = MinutaContable_15.id 	-- 15 LEFT LEVEL: 2
				LEFT JOIN massoftware.Sucursal AS Sucursal_18                         ON AsientoContable_4.sucursal = Sucursal_18.id 	-- 18 LEFT LEVEL: 2
					LEFT JOIN massoftware.TipoSucursal AS TipoSucursal_22                    ON Sucursal_18.tipoSucursal = TipoSucursal_22.id 	-- 22 LEFT LEVEL: 3
				LEFT JOIN massoftware.AsientoContableModulo AS AsientoContableModulo_39            ON AsientoContable_4.asientoContableModulo = AsientoContableModulo_39.id 	-- 39 LEFT LEVEL: 2
			LEFT JOIN massoftware.CuentaContable AS CuentaContable_42                   ON AsientoContableItem.cuentaContable = CuentaContable_42.id 	-- 42 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_45                ON CuentaContable_42.ejercicioContable = EjercicioContable_45.id 	-- 45 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_56             ON CuentaContable_42.cuentaContableEstado = CuentaContableEstado_56.id 	-- 56 LEFT LEVEL: 2
				LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_60              ON CuentaContable_42.centroCostoContable = CentroCostoContable_60.id 	-- 60 LEFT LEVEL: 2
					LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_64               ON CentroCostoContable_60.ejercicioContable = EjercicioContable_64.id 	-- 64 LEFT LEVEL: 3
				LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_73                  ON CuentaContable_42.puntoEquilibrio = PuntoEquilibrio_73.id 	-- 73 LEFT LEVEL: 2
					LEFT JOIN massoftware.TipoPuntoEquilibrio AS TipoPuntoEquilibrio_76             ON PuntoEquilibrio_73.tipoPuntoEquilibrio = TipoPuntoEquilibrio_76.id 	-- 76 LEFT LEVEL: 3
					LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_79               ON PuntoEquilibrio_73.ejercicioContable = EjercicioContable_79.id 	-- 79 LEFT LEVEL: 3
				LEFT JOIN massoftware.CostoVenta AS CostoVenta_86                       ON CuentaContable_42.costoVenta = CostoVenta_86.id 	-- 86 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_89                  ON CuentaContable_42.seguridadPuerta = SeguridadPuerta_89.id 	-- 89 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_93                 ON SeguridadPuerta_89.seguridadModulo = SeguridadModulo_93.id 	-- 93 LEFT LEVEL: 3

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' AsientoContableItem.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContableItem.detalle),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND asientoContableArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoContableArg8)) > 0 THEN
		asientoContableArg8 = REPLACE(asientoContableArg8, '''', '''''');
		asientoContableArg8 = LOWER(TRIM(asientoContableArg8));
		asientoContableArg8 = TRANSLATE(asientoContableArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoContableArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoContableItem.asientoContable),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoContableItemById_3 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoContableItemById_3 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_AsientoContableItem_3 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoContableItem_3 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoContableItem_3 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoContableItemById_3 ('xxx'); 