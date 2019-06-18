
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoModeloItem                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoModeloItem



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.AsientoModeloItem CASCADE;

CREATE TABLE massoftware.AsientoModeloItem
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº item
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT AsientoModeloItem_numero_chk CHECK ( numero >= 1  ), 
	
	-- Asiento modelo
	asientoModelo VARCHAR(36)  NOT NULL  REFERENCES massoftware.AsientoModelo (id), 
	
	-- Cuenta contable
	cuentaContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.CuentaContable (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatAsientoModeloItem() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatAsientoModeloItem() RETURNS TRIGGER AS $formatAsientoModeloItem$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.asientoModelo := massoftware.white_is_null(NEW.asientoModelo);
	 NEW.cuentaContable := massoftware.white_is_null(NEW.cuentaContable);

	RETURN NEW;
END;
$formatAsientoModeloItem$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatAsientoModeloItem ON massoftware.AsientoModeloItem CASCADE;

CREATE TRIGGER tgFormatAsientoModeloItem BEFORE INSERT OR UPDATE
	ON massoftware.AsientoModeloItem FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatAsientoModeloItem();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.AsientoModeloItem;

-- SELECT * FROM massoftware.AsientoModeloItem LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.AsientoModeloItem;

-- SELECT * FROM massoftware.AsientoModeloItem WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_AsientoModeloItem_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_AsientoModeloItem_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.AsientoModeloItem
	WHERE	(numeroArg IS NULL OR AsientoModeloItem.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_AsientoModeloItem_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_AsientoModeloItem_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_AsientoModeloItem_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.AsientoModeloItem;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_AsientoModeloItem_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_AsientoModeloItemById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_AsientoModeloItemById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.AsientoModeloItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoModeloItem.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.AsientoModeloItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoModeloItem.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoModeloItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoModeloItem.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_AsientoModeloItemById('xxx');

-- SELECT * FROM massoftware.d_AsientoModeloItemById((SELECT AsientoModeloItem.id FROM massoftware.AsientoModeloItem LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_AsientoModeloItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, asientoModeloArg VARCHAR(36)
		, cuentaContableArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_AsientoModeloItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, asientoModeloArg VARCHAR(36)
		, cuentaContableArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.AsientoModeloItem(id, numero, asientoModelo, cuentaContable) VALUES (idArg, numeroArg, asientoModeloArg, cuentaContableArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoModeloItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoModeloItem.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_AsientoModeloItem(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_AsientoModeloItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, asientoModeloArg VARCHAR(36)
		, cuentaContableArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_AsientoModeloItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, asientoModeloArg VARCHAR(36)
		, cuentaContableArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.AsientoModeloItem SET 
		  numero = numeroArg
		, asientoModelo = asientoModeloArg
		, cuentaContable = cuentaContableArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoModeloItem.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoModeloItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoModeloItem.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_AsientoModeloItem(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/

DROP TYPE IF EXISTS massoftware.t_AsientoModeloItem_1 CASCADE;

CREATE TYPE massoftware.t_AsientoModeloItem_1 AS (

	  AsientoModeloItem_id                 	VARCHAR(36) 		-- 0	AsientoModeloItem.id
	, AsientoModeloItem_numero             	INTEGER     		-- 1	AsientoModeloItem.numero
	, AsientoModelo_2_id                   	VARCHAR(36) 		-- 2	AsientoModeloItem.AsientoModelo.id
	, AsientoModelo_2_numero               	INTEGER     		-- 3	AsientoModeloItem.AsientoModelo.numero
	, AsientoModelo_2_nombre               	VARCHAR(50) 		-- 4	AsientoModeloItem.AsientoModelo.nombre
	, AsientoModelo_2_ejercicioContable    	VARCHAR(36) 		-- 5	AsientoModeloItem.AsientoModelo.ejercicioContable
	, CuentaContable_6_id                  	VARCHAR(36) 		-- 6	AsientoModeloItem.CuentaContable.id
	, CuentaContable_6_codigo              	VARCHAR(11) 		-- 7	AsientoModeloItem.CuentaContable.codigo
	, CuentaContable_6_nombre              	VARCHAR(50) 		-- 8	AsientoModeloItem.CuentaContable.nombre
	, CuentaContable_6_ejercicioContable   	VARCHAR(36) 		-- 9	AsientoModeloItem.CuentaContable.ejercicioContable
	, CuentaContable_6_integra             	VARCHAR(16) 		-- 10	AsientoModeloItem.CuentaContable.integra
	, CuentaContable_6_cuentaJerarquia     	VARCHAR(16) 		-- 11	AsientoModeloItem.CuentaContable.cuentaJerarquia
	, CuentaContable_6_imputable           	BOOLEAN     		-- 12	AsientoModeloItem.CuentaContable.imputable
	, CuentaContable_6_ajustaPorInflacion  	BOOLEAN     		-- 13	AsientoModeloItem.CuentaContable.ajustaPorInflacion
	, CuentaContable_6_cuentaContableEstado	VARCHAR(36) 		-- 14	AsientoModeloItem.CuentaContable.cuentaContableEstado
	, CuentaContable_6_cuentaConApropiacion	BOOLEAN     		-- 15	AsientoModeloItem.CuentaContable.cuentaConApropiacion
	, CuentaContable_6_centroCostoContable 	VARCHAR(36) 		-- 16	AsientoModeloItem.CuentaContable.centroCostoContable
	, CuentaContable_6_cuentaAgrupadora    	VARCHAR(50) 		-- 17	AsientoModeloItem.CuentaContable.cuentaAgrupadora
	, CuentaContable_6_porcentaje          	DECIMAL(6,3)		-- 18	AsientoModeloItem.CuentaContable.porcentaje
	, CuentaContable_6_puntoEquilibrio     	VARCHAR(36) 		-- 19	AsientoModeloItem.CuentaContable.puntoEquilibrio
	, CuentaContable_6_costoVenta          	VARCHAR(36) 		-- 20	AsientoModeloItem.CuentaContable.costoVenta
	, CuentaContable_6_seguridadPuerta     	VARCHAR(36) 		-- 21	AsientoModeloItem.CuentaContable.seguridadPuerta

);

DROP TYPE IF EXISTS massoftware.t_AsientoModeloItem_2 CASCADE;

CREATE TYPE massoftware.t_AsientoModeloItem_2 AS (

	  AsientoModeloItem_id                    	VARCHAR(36) 		-- 0	AsientoModeloItem.id
	, AsientoModeloItem_numero                	INTEGER     		-- 1	AsientoModeloItem.numero
	, AsientoModelo_2_id                      	VARCHAR(36) 		-- 2	AsientoModeloItem.AsientoModelo.id
	, AsientoModelo_2_numero                  	INTEGER     		-- 3	AsientoModeloItem.AsientoModelo.numero
	, AsientoModelo_2_nombre                  	VARCHAR(50) 		-- 4	AsientoModeloItem.AsientoModelo.nombre
	, EjercicioContable_5_id                  	VARCHAR(36) 		-- 5	AsientoModeloItem.AsientoModelo.EjercicioContable.id
	, EjercicioContable_5_numero              	INTEGER     		-- 6	AsientoModeloItem.AsientoModelo.EjercicioContable.numero
	, EjercicioContable_5_apertura            	DATE        		-- 7	AsientoModeloItem.AsientoModelo.EjercicioContable.apertura
	, EjercicioContable_5_cierre              	DATE        		-- 8	AsientoModeloItem.AsientoModelo.EjercicioContable.cierre
	, EjercicioContable_5_cerrado             	BOOLEAN     		-- 9	AsientoModeloItem.AsientoModelo.EjercicioContable.cerrado
	, EjercicioContable_5_cerradoModulos      	BOOLEAN     		-- 10	AsientoModeloItem.AsientoModelo.EjercicioContable.cerradoModulos
	, EjercicioContable_5_comentario          	VARCHAR(250)		-- 11	AsientoModeloItem.AsientoModelo.EjercicioContable.comentario
	, CuentaContable_12_id                    	VARCHAR(36) 		-- 12	AsientoModeloItem.CuentaContable.id
	, CuentaContable_12_codigo                	VARCHAR(11) 		-- 13	AsientoModeloItem.CuentaContable.codigo
	, CuentaContable_12_nombre                	VARCHAR(50) 		-- 14	AsientoModeloItem.CuentaContable.nombre
	, EjercicioContable_15_id                 	VARCHAR(36) 		-- 15	AsientoModeloItem.CuentaContable.EjercicioContable.id
	, EjercicioContable_15_numero             	INTEGER     		-- 16	AsientoModeloItem.CuentaContable.EjercicioContable.numero
	, EjercicioContable_15_apertura           	DATE        		-- 17	AsientoModeloItem.CuentaContable.EjercicioContable.apertura
	, EjercicioContable_15_cierre             	DATE        		-- 18	AsientoModeloItem.CuentaContable.EjercicioContable.cierre
	, EjercicioContable_15_cerrado            	BOOLEAN     		-- 19	AsientoModeloItem.CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_15_cerradoModulos     	BOOLEAN     		-- 20	AsientoModeloItem.CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_15_comentario         	VARCHAR(250)		-- 21	AsientoModeloItem.CuentaContable.EjercicioContable.comentario
	, CuentaContable_12_integra               	VARCHAR(16) 		-- 22	AsientoModeloItem.CuentaContable.integra
	, CuentaContable_12_cuentaJerarquia       	VARCHAR(16) 		-- 23	AsientoModeloItem.CuentaContable.cuentaJerarquia
	, CuentaContable_12_imputable             	BOOLEAN     		-- 24	AsientoModeloItem.CuentaContable.imputable
	, CuentaContable_12_ajustaPorInflacion    	BOOLEAN     		-- 25	AsientoModeloItem.CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_26_id              	VARCHAR(36) 		-- 26	AsientoModeloItem.CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_26_numero          	INTEGER     		-- 27	AsientoModeloItem.CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_26_nombre          	VARCHAR(50) 		-- 28	AsientoModeloItem.CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_12_cuentaConApropiacion  	BOOLEAN     		-- 29	AsientoModeloItem.CuentaContable.cuentaConApropiacion
	, CentroCostoContable_30_id               	VARCHAR(36) 		-- 30	AsientoModeloItem.CuentaContable.CentroCostoContable.id
	, CentroCostoContable_30_numero           	INTEGER     		-- 31	AsientoModeloItem.CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_30_nombre           	VARCHAR(50) 		-- 32	AsientoModeloItem.CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_30_abreviatura      	VARCHAR(5)  		-- 33	AsientoModeloItem.CuentaContable.CentroCostoContable.abreviatura
	, CentroCostoContable_30_ejercicioContable	VARCHAR(36) 		-- 34	AsientoModeloItem.CuentaContable.CentroCostoContable.ejercicioContable
	, CuentaContable_12_cuentaAgrupadora      	VARCHAR(50) 		-- 35	AsientoModeloItem.CuentaContable.cuentaAgrupadora
	, CuentaContable_12_porcentaje            	DECIMAL(6,3)		-- 36	AsientoModeloItem.CuentaContable.porcentaje
	, PuntoEquilibrio_37_id                   	VARCHAR(36) 		-- 37	AsientoModeloItem.CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_37_numero               	INTEGER     		-- 38	AsientoModeloItem.CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_37_nombre               	VARCHAR(50) 		-- 39	AsientoModeloItem.CuentaContable.PuntoEquilibrio.nombre
	, PuntoEquilibrio_37_tipoPuntoEquilibrio  	VARCHAR(36) 		-- 40	AsientoModeloItem.CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio
	, PuntoEquilibrio_37_ejercicioContable    	VARCHAR(36) 		-- 41	AsientoModeloItem.CuentaContable.PuntoEquilibrio.ejercicioContable
	, CostoVenta_42_id                        	VARCHAR(36) 		-- 42	AsientoModeloItem.CuentaContable.CostoVenta.id
	, CostoVenta_42_numero                    	INTEGER     		-- 43	AsientoModeloItem.CuentaContable.CostoVenta.numero
	, CostoVenta_42_nombre                    	VARCHAR(50) 		-- 44	AsientoModeloItem.CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_45_id                   	VARCHAR(36) 		-- 45	AsientoModeloItem.CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_45_numero               	INTEGER     		-- 46	AsientoModeloItem.CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_45_nombre               	VARCHAR(50) 		-- 47	AsientoModeloItem.CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_45_equate               	VARCHAR(30) 		-- 48	AsientoModeloItem.CuentaContable.SeguridadPuerta.equate
	, SeguridadPuerta_45_seguridadModulo      	VARCHAR(36) 		-- 49	AsientoModeloItem.CuentaContable.SeguridadPuerta.seguridadModulo

);

DROP TYPE IF EXISTS massoftware.t_AsientoModeloItem_3 CASCADE;

CREATE TYPE massoftware.t_AsientoModeloItem_3 AS (

	  AsientoModeloItem_id                  	VARCHAR(36) 		-- 0	AsientoModeloItem.id
	, AsientoModeloItem_numero              	INTEGER     		-- 1	AsientoModeloItem.numero
	, AsientoModelo_2_id                    	VARCHAR(36) 		-- 2	AsientoModeloItem.AsientoModelo.id
	, AsientoModelo_2_numero                	INTEGER     		-- 3	AsientoModeloItem.AsientoModelo.numero
	, AsientoModelo_2_nombre                	VARCHAR(50) 		-- 4	AsientoModeloItem.AsientoModelo.nombre
	, EjercicioContable_5_id                	VARCHAR(36) 		-- 5	AsientoModeloItem.AsientoModelo.EjercicioContable.id
	, EjercicioContable_5_numero            	INTEGER     		-- 6	AsientoModeloItem.AsientoModelo.EjercicioContable.numero
	, EjercicioContable_5_apertura          	DATE        		-- 7	AsientoModeloItem.AsientoModelo.EjercicioContable.apertura
	, EjercicioContable_5_cierre            	DATE        		-- 8	AsientoModeloItem.AsientoModelo.EjercicioContable.cierre
	, EjercicioContable_5_cerrado           	BOOLEAN     		-- 9	AsientoModeloItem.AsientoModelo.EjercicioContable.cerrado
	, EjercicioContable_5_cerradoModulos    	BOOLEAN     		-- 10	AsientoModeloItem.AsientoModelo.EjercicioContable.cerradoModulos
	, EjercicioContable_5_comentario        	VARCHAR(250)		-- 11	AsientoModeloItem.AsientoModelo.EjercicioContable.comentario
	, CuentaContable_12_id                  	VARCHAR(36) 		-- 12	AsientoModeloItem.CuentaContable.id
	, CuentaContable_12_codigo              	VARCHAR(11) 		-- 13	AsientoModeloItem.CuentaContable.codigo
	, CuentaContable_12_nombre              	VARCHAR(50) 		-- 14	AsientoModeloItem.CuentaContable.nombre
	, EjercicioContable_15_id               	VARCHAR(36) 		-- 15	AsientoModeloItem.CuentaContable.EjercicioContable.id
	, EjercicioContable_15_numero           	INTEGER     		-- 16	AsientoModeloItem.CuentaContable.EjercicioContable.numero
	, EjercicioContable_15_apertura         	DATE        		-- 17	AsientoModeloItem.CuentaContable.EjercicioContable.apertura
	, EjercicioContable_15_cierre           	DATE        		-- 18	AsientoModeloItem.CuentaContable.EjercicioContable.cierre
	, EjercicioContable_15_cerrado          	BOOLEAN     		-- 19	AsientoModeloItem.CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_15_cerradoModulos   	BOOLEAN     		-- 20	AsientoModeloItem.CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_15_comentario       	VARCHAR(250)		-- 21	AsientoModeloItem.CuentaContable.EjercicioContable.comentario
	, CuentaContable_12_integra             	VARCHAR(16) 		-- 22	AsientoModeloItem.CuentaContable.integra
	, CuentaContable_12_cuentaJerarquia     	VARCHAR(16) 		-- 23	AsientoModeloItem.CuentaContable.cuentaJerarquia
	, CuentaContable_12_imputable           	BOOLEAN     		-- 24	AsientoModeloItem.CuentaContable.imputable
	, CuentaContable_12_ajustaPorInflacion  	BOOLEAN     		-- 25	AsientoModeloItem.CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_26_id            	VARCHAR(36) 		-- 26	AsientoModeloItem.CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_26_numero        	INTEGER     		-- 27	AsientoModeloItem.CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_26_nombre        	VARCHAR(50) 		-- 28	AsientoModeloItem.CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_12_cuentaConApropiacion	BOOLEAN     		-- 29	AsientoModeloItem.CuentaContable.cuentaConApropiacion
	, CentroCostoContable_30_id             	VARCHAR(36) 		-- 30	AsientoModeloItem.CuentaContable.CentroCostoContable.id
	, CentroCostoContable_30_numero         	INTEGER     		-- 31	AsientoModeloItem.CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_30_nombre         	VARCHAR(50) 		-- 32	AsientoModeloItem.CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_30_abreviatura    	VARCHAR(5)  		-- 33	AsientoModeloItem.CuentaContable.CentroCostoContable.abreviatura
	, EjercicioContable_34_id               	VARCHAR(36) 		-- 34	AsientoModeloItem.CuentaContable.CentroCostoContable.EjercicioContable.id
	, EjercicioContable_34_numero           	INTEGER     		-- 35	AsientoModeloItem.CuentaContable.CentroCostoContable.EjercicioContable.numero
	, EjercicioContable_34_apertura         	DATE        		-- 36	AsientoModeloItem.CuentaContable.CentroCostoContable.EjercicioContable.apertura
	, EjercicioContable_34_cierre           	DATE        		-- 37	AsientoModeloItem.CuentaContable.CentroCostoContable.EjercicioContable.cierre
	, EjercicioContable_34_cerrado          	BOOLEAN     		-- 38	AsientoModeloItem.CuentaContable.CentroCostoContable.EjercicioContable.cerrado
	, EjercicioContable_34_cerradoModulos   	BOOLEAN     		-- 39	AsientoModeloItem.CuentaContable.CentroCostoContable.EjercicioContable.cerradoModulos
	, EjercicioContable_34_comentario       	VARCHAR(250)		-- 40	AsientoModeloItem.CuentaContable.CentroCostoContable.EjercicioContable.comentario
	, CuentaContable_12_cuentaAgrupadora    	VARCHAR(50) 		-- 41	AsientoModeloItem.CuentaContable.cuentaAgrupadora
	, CuentaContable_12_porcentaje          	DECIMAL(6,3)		-- 42	AsientoModeloItem.CuentaContable.porcentaje
	, PuntoEquilibrio_43_id                 	VARCHAR(36) 		-- 43	AsientoModeloItem.CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_43_numero             	INTEGER     		-- 44	AsientoModeloItem.CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_43_nombre             	VARCHAR(50) 		-- 45	AsientoModeloItem.CuentaContable.PuntoEquilibrio.nombre
	, TipoPuntoEquilibrio_46_id             	VARCHAR(36) 		-- 46	AsientoModeloItem.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.id
	, TipoPuntoEquilibrio_46_numero         	INTEGER     		-- 47	AsientoModeloItem.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.numero
	, TipoPuntoEquilibrio_46_nombre         	VARCHAR(50) 		-- 48	AsientoModeloItem.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.nombre
	, EjercicioContable_49_id               	VARCHAR(36) 		-- 49	AsientoModeloItem.CuentaContable.PuntoEquilibrio.EjercicioContable.id
	, EjercicioContable_49_numero           	INTEGER     		-- 50	AsientoModeloItem.CuentaContable.PuntoEquilibrio.EjercicioContable.numero
	, EjercicioContable_49_apertura         	DATE        		-- 51	AsientoModeloItem.CuentaContable.PuntoEquilibrio.EjercicioContable.apertura
	, EjercicioContable_49_cierre           	DATE        		-- 52	AsientoModeloItem.CuentaContable.PuntoEquilibrio.EjercicioContable.cierre
	, EjercicioContable_49_cerrado          	BOOLEAN     		-- 53	AsientoModeloItem.CuentaContable.PuntoEquilibrio.EjercicioContable.cerrado
	, EjercicioContable_49_cerradoModulos   	BOOLEAN     		-- 54	AsientoModeloItem.CuentaContable.PuntoEquilibrio.EjercicioContable.cerradoModulos
	, EjercicioContable_49_comentario       	VARCHAR(250)		-- 55	AsientoModeloItem.CuentaContable.PuntoEquilibrio.EjercicioContable.comentario
	, CostoVenta_56_id                      	VARCHAR(36) 		-- 56	AsientoModeloItem.CuentaContable.CostoVenta.id
	, CostoVenta_56_numero                  	INTEGER     		-- 57	AsientoModeloItem.CuentaContable.CostoVenta.numero
	, CostoVenta_56_nombre                  	VARCHAR(50) 		-- 58	AsientoModeloItem.CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_59_id                 	VARCHAR(36) 		-- 59	AsientoModeloItem.CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_59_numero             	INTEGER     		-- 60	AsientoModeloItem.CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_59_nombre             	VARCHAR(50) 		-- 61	AsientoModeloItem.CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_59_equate             	VARCHAR(30) 		-- 62	AsientoModeloItem.CuentaContable.SeguridadPuerta.equate
	, SeguridadModulo_63_id                 	VARCHAR(36) 		-- 63	AsientoModeloItem.CuentaContable.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_63_numero             	INTEGER     		-- 64	AsientoModeloItem.CuentaContable.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_63_nombre             	VARCHAR(50) 		-- 65	AsientoModeloItem.CuentaContable.SeguridadPuerta.SeguridadModulo.nombre

);

DROP FUNCTION IF EXISTS massoftware.f_AsientoModeloItem (

	  idArg0              VARCHAR(36)	-- 0
	, orderByArg1         INTEGER    	-- 1
	, orderByDescArg2     BOOLEAN    	-- 2
	, limitArg3           BIGINT     	-- 3
	, offSetArg4          BIGINT     	-- 4
	, asientoModeloArg5   VARCHAR(36)	-- 5

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModeloItem (

	  idArg0              VARCHAR(36)	-- 0
	, orderByArg1         INTEGER    	-- 1
	, orderByDescArg2     BOOLEAN    	-- 2
	, limitArg3           BIGINT     	-- 3
	, offSetArg4          BIGINT     	-- 4
	, asientoModeloArg5   VARCHAR(36)	-- 5

) RETURNS SETOF massoftware.AsientoModeloItem AS $$

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
				  AsientoModeloItem.id                AS AsientoModeloItem_id            	-- 0	.id           		VARCHAR(36)
				, AsientoModeloItem.numero            AS AsientoModeloItem_numero        	-- 1	.numero       		INTEGER
				, AsientoModeloItem.asientoModelo     AS AsientoModeloItem_asientoModelo 	-- 2	.asientoModelo		VARCHAR(36)	AsientoModelo.id
				, AsientoModeloItem.cuentaContable    AS AsientoModeloItem_cuentaContable	-- 3	.cuentaContable		VARCHAR(36)	CuentaContable.id

		FROM	massoftware.AsientoModeloItem

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoModeloItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND asientoModeloArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoModeloArg5)) > 0 THEN
		asientoModeloArg5 = REPLACE(asientoModeloArg5, '''', '''''');
		asientoModeloArg5 = LOWER(TRIM(asientoModeloArg5));
		asientoModeloArg5 = TRANSLATE(asientoModeloArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoModeloArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoModeloItem.asientoModelo),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoModeloItemById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModeloItemById (idArg VARCHAR(36)) RETURNS SETOF massoftware.AsientoModeloItem AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoModeloItem ( idArg , null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoModeloItem ( null , null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoModeloItemById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_AsientoModeloItem_1 (

	  idArg0              VARCHAR(36)	-- 0
	, orderByArg1         INTEGER    	-- 1
	, orderByDescArg2     BOOLEAN    	-- 2
	, limitArg3           BIGINT     	-- 3
	, offSetArg4          BIGINT     	-- 4
	, asientoModeloArg5   VARCHAR(36)	-- 5

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModeloItem_1 (

	  idArg0              VARCHAR(36)	-- 0
	, orderByArg1         INTEGER    	-- 1
	, orderByDescArg2     BOOLEAN    	-- 2
	, limitArg3           BIGINT     	-- 3
	, offSetArg4          BIGINT     	-- 4
	, asientoModeloArg5   VARCHAR(36)	-- 5

) RETURNS SETOF massoftware.t_AsientoModeloItem_1 AS $$

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
				  AsientoModeloItem.id                      AS AsientoModeloItem_id                 	-- 0	.id                                		VARCHAR(36)
				, AsientoModeloItem.numero                  AS AsientoModeloItem_numero             	-- 1	.numero                            		INTEGER
				, AsientoModelo_2.id                        AS AsientoModelo_2_id                   	-- 2	.AsientoModelo.id                  		VARCHAR(36)
				, AsientoModelo_2.numero                    AS AsientoModelo_2_numero               	-- 3	.AsientoModelo.numero              		INTEGER
				, AsientoModelo_2.nombre                    AS AsientoModelo_2_nombre               	-- 4	.AsientoModelo.nombre              		VARCHAR(50)
				, AsientoModelo_2.ejercicioContable         AS AsientoModelo_2_ejercicioContable    	-- 5	.AsientoModelo.ejercicioContable   		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_6.id                       AS CuentaContable_6_id                  	-- 6	.CuentaContable.id                 		VARCHAR(36)
				, CuentaContable_6.codigo                   AS CuentaContable_6_codigo              	-- 7	.CuentaContable.codigo             		VARCHAR(11)
				, CuentaContable_6.nombre                   AS CuentaContable_6_nombre              	-- 8	.CuentaContable.nombre             		VARCHAR(50)
				, CuentaContable_6.ejercicioContable        AS CuentaContable_6_ejercicioContable   	-- 9	.CuentaContable.ejercicioContable  		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_6.integra                  AS CuentaContable_6_integra             	-- 10	.CuentaContable.integra            		VARCHAR(16)
				, CuentaContable_6.cuentaJerarquia          AS CuentaContable_6_cuentaJerarquia     	-- 11	.CuentaContable.cuentaJerarquia    		VARCHAR(16)
				, CuentaContable_6.imputable                AS CuentaContable_6_imputable           	-- 12	.CuentaContable.imputable          		BOOLEAN
				, CuentaContable_6.ajustaPorInflacion       AS CuentaContable_6_ajustaPorInflacion  	-- 13	.CuentaContable.ajustaPorInflacion 		BOOLEAN
				, CuentaContable_6.cuentaContableEstado     AS CuentaContable_6_cuentaContableEstado	-- 14	.CuentaContable.cuentaContableEstado		VARCHAR(36)	CuentaContableEstado.id
				, CuentaContable_6.cuentaConApropiacion     AS CuentaContable_6_cuentaConApropiacion	-- 15	.CuentaContable.cuentaConApropiacion		BOOLEAN
				, CuentaContable_6.centroCostoContable      AS CuentaContable_6_centroCostoContable 	-- 16	.CuentaContable.centroCostoContable		VARCHAR(36)	CentroCostoContable.id
				, CuentaContable_6.cuentaAgrupadora         AS CuentaContable_6_cuentaAgrupadora    	-- 17	.CuentaContable.cuentaAgrupadora   		VARCHAR(50)
				, CuentaContable_6.porcentaje               AS CuentaContable_6_porcentaje          	-- 18	.CuentaContable.porcentaje         		DECIMAL(6,3)
				, CuentaContable_6.puntoEquilibrio          AS CuentaContable_6_puntoEquilibrio     	-- 19	.CuentaContable.puntoEquilibrio    		VARCHAR(36)	PuntoEquilibrio.id
				, CuentaContable_6.costoVenta               AS CuentaContable_6_costoVenta          	-- 20	.CuentaContable.costoVenta         		VARCHAR(36)	CostoVenta.id
				, CuentaContable_6.seguridadPuerta          AS CuentaContable_6_seguridadPuerta     	-- 21	.CuentaContable.seguridadPuerta    		VARCHAR(36)	SeguridadPuerta.id

		FROM	massoftware.AsientoModeloItem
			LEFT JOIN massoftware.AsientoModelo AS AsientoModelo_2         ON AsientoModeloItem.asientoModelo = AsientoModelo_2.id 	-- 2 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaContable AS CuentaContable_6        ON AsientoModeloItem.cuentaContable = CuentaContable_6.id 	-- 6 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoModeloItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND asientoModeloArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoModeloArg5)) > 0 THEN
		asientoModeloArg5 = REPLACE(asientoModeloArg5, '''', '''''');
		asientoModeloArg5 = LOWER(TRIM(asientoModeloArg5));
		asientoModeloArg5 = TRANSLATE(asientoModeloArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoModeloArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoModeloItem.asientoModelo),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoModeloItemById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModeloItemById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_AsientoModeloItem_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoModeloItem_1 ( idArg , null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoModeloItem_1 ( null , null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoModeloItemById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_AsientoModeloItem_2 (

	  idArg0              VARCHAR(36)	-- 0
	, orderByArg1         INTEGER    	-- 1
	, orderByDescArg2     BOOLEAN    	-- 2
	, limitArg3           BIGINT     	-- 3
	, offSetArg4          BIGINT     	-- 4
	, asientoModeloArg5   VARCHAR(36)	-- 5

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModeloItem_2 (

	  idArg0              VARCHAR(36)	-- 0
	, orderByArg1         INTEGER    	-- 1
	, orderByDescArg2     BOOLEAN    	-- 2
	, limitArg3           BIGINT     	-- 3
	, offSetArg4          BIGINT     	-- 4
	, asientoModeloArg5   VARCHAR(36)	-- 5

) RETURNS SETOF massoftware.t_AsientoModeloItem_2 AS $$

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
				  AsientoModeloItem.id                         AS AsientoModeloItem_id                    	-- 0	.id                                                 		VARCHAR(36)
				, AsientoModeloItem.numero                     AS AsientoModeloItem_numero                	-- 1	.numero                                             		INTEGER
				, AsientoModelo_2.id                           AS AsientoModelo_2_id                      	-- 2	.AsientoModelo.id                                   		VARCHAR(36)
				, AsientoModelo_2.numero                       AS AsientoModelo_2_numero                  	-- 3	.AsientoModelo.numero                               		INTEGER
				, AsientoModelo_2.nombre                       AS AsientoModelo_2_nombre                  	-- 4	.AsientoModelo.nombre                               		VARCHAR(50)
				, EjercicioContable_5.id                       AS EjercicioContable_5_id                  	-- 5	.AsientoModelo.EjercicioContable.id                 		VARCHAR(36)
				, EjercicioContable_5.numero                   AS EjercicioContable_5_numero              	-- 6	.AsientoModelo.EjercicioContable.numero             		INTEGER
				, EjercicioContable_5.apertura                 AS EjercicioContable_5_apertura            	-- 7	.AsientoModelo.EjercicioContable.apertura           		DATE
				, EjercicioContable_5.cierre                   AS EjercicioContable_5_cierre              	-- 8	.AsientoModelo.EjercicioContable.cierre             		DATE
				, EjercicioContable_5.cerrado                  AS EjercicioContable_5_cerrado             	-- 9	.AsientoModelo.EjercicioContable.cerrado            		BOOLEAN
				, EjercicioContable_5.cerradoModulos           AS EjercicioContable_5_cerradoModulos      	-- 10	.AsientoModelo.EjercicioContable.cerradoModulos     		BOOLEAN
				, EjercicioContable_5.comentario               AS EjercicioContable_5_comentario          	-- 11	.AsientoModelo.EjercicioContable.comentario         		VARCHAR(250)
				, CuentaContable_12.id                         AS CuentaContable_12_id                    	-- 12	.CuentaContable.id                                  		VARCHAR(36)
				, CuentaContable_12.codigo                     AS CuentaContable_12_codigo                	-- 13	.CuentaContable.codigo                              		VARCHAR(11)
				, CuentaContable_12.nombre                     AS CuentaContable_12_nombre                	-- 14	.CuentaContable.nombre                              		VARCHAR(50)
				, EjercicioContable_15.id                      AS EjercicioContable_15_id                 	-- 15	.CuentaContable.EjercicioContable.id                		VARCHAR(36)
				, EjercicioContable_15.numero                  AS EjercicioContable_15_numero             	-- 16	.CuentaContable.EjercicioContable.numero            		INTEGER
				, EjercicioContable_15.apertura                AS EjercicioContable_15_apertura           	-- 17	.CuentaContable.EjercicioContable.apertura          		DATE
				, EjercicioContable_15.cierre                  AS EjercicioContable_15_cierre             	-- 18	.CuentaContable.EjercicioContable.cierre            		DATE
				, EjercicioContable_15.cerrado                 AS EjercicioContable_15_cerrado            	-- 19	.CuentaContable.EjercicioContable.cerrado           		BOOLEAN
				, EjercicioContable_15.cerradoModulos          AS EjercicioContable_15_cerradoModulos     	-- 20	.CuentaContable.EjercicioContable.cerradoModulos    		BOOLEAN
				, EjercicioContable_15.comentario              AS EjercicioContable_15_comentario         	-- 21	.CuentaContable.EjercicioContable.comentario        		VARCHAR(250)
				, CuentaContable_12.integra                    AS CuentaContable_12_integra               	-- 22	.CuentaContable.integra                             		VARCHAR(16)
				, CuentaContable_12.cuentaJerarquia            AS CuentaContable_12_cuentaJerarquia       	-- 23	.CuentaContable.cuentaJerarquia                     		VARCHAR(16)
				, CuentaContable_12.imputable                  AS CuentaContable_12_imputable             	-- 24	.CuentaContable.imputable                           		BOOLEAN
				, CuentaContable_12.ajustaPorInflacion         AS CuentaContable_12_ajustaPorInflacion    	-- 25	.CuentaContable.ajustaPorInflacion                  		BOOLEAN
				, CuentaContableEstado_26.id                   AS CuentaContableEstado_26_id              	-- 26	.CuentaContable.CuentaContableEstado.id             		VARCHAR(36)
				, CuentaContableEstado_26.numero               AS CuentaContableEstado_26_numero          	-- 27	.CuentaContable.CuentaContableEstado.numero         		INTEGER
				, CuentaContableEstado_26.nombre               AS CuentaContableEstado_26_nombre          	-- 28	.CuentaContable.CuentaContableEstado.nombre         		VARCHAR(50)
				, CuentaContable_12.cuentaConApropiacion       AS CuentaContable_12_cuentaConApropiacion  	-- 29	.CuentaContable.cuentaConApropiacion                		BOOLEAN
				, CentroCostoContable_30.id                    AS CentroCostoContable_30_id               	-- 30	.CuentaContable.CentroCostoContable.id              		VARCHAR(36)
				, CentroCostoContable_30.numero                AS CentroCostoContable_30_numero           	-- 31	.CuentaContable.CentroCostoContable.numero          		INTEGER
				, CentroCostoContable_30.nombre                AS CentroCostoContable_30_nombre           	-- 32	.CuentaContable.CentroCostoContable.nombre          		VARCHAR(50)
				, CentroCostoContable_30.abreviatura           AS CentroCostoContable_30_abreviatura      	-- 33	.CuentaContable.CentroCostoContable.abreviatura     		VARCHAR(5)
				, CentroCostoContable_30.ejercicioContable     AS CentroCostoContable_30_ejercicioContable	-- 34	.CuentaContable.CentroCostoContable.ejercicioContable		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_12.cuentaAgrupadora           AS CuentaContable_12_cuentaAgrupadora      	-- 35	.CuentaContable.cuentaAgrupadora                    		VARCHAR(50)
				, CuentaContable_12.porcentaje                 AS CuentaContable_12_porcentaje            	-- 36	.CuentaContable.porcentaje                          		DECIMAL(6,3)
				, PuntoEquilibrio_37.id                        AS PuntoEquilibrio_37_id                   	-- 37	.CuentaContable.PuntoEquilibrio.id                  		VARCHAR(36)
				, PuntoEquilibrio_37.numero                    AS PuntoEquilibrio_37_numero               	-- 38	.CuentaContable.PuntoEquilibrio.numero              		INTEGER
				, PuntoEquilibrio_37.nombre                    AS PuntoEquilibrio_37_nombre               	-- 39	.CuentaContable.PuntoEquilibrio.nombre              		VARCHAR(50)
				, PuntoEquilibrio_37.tipoPuntoEquilibrio       AS PuntoEquilibrio_37_tipoPuntoEquilibrio  	-- 40	.CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio 		VARCHAR(36)	TipoPuntoEquilibrio.id
				, PuntoEquilibrio_37.ejercicioContable         AS PuntoEquilibrio_37_ejercicioContable    	-- 41	.CuentaContable.PuntoEquilibrio.ejercicioContable   		VARCHAR(36)	EjercicioContable.id
				, CostoVenta_42.id                             AS CostoVenta_42_id                        	-- 42	.CuentaContable.CostoVenta.id                       		VARCHAR(36)
				, CostoVenta_42.numero                         AS CostoVenta_42_numero                    	-- 43	.CuentaContable.CostoVenta.numero                   		INTEGER
				, CostoVenta_42.nombre                         AS CostoVenta_42_nombre                    	-- 44	.CuentaContable.CostoVenta.nombre                   		VARCHAR(50)
				, SeguridadPuerta_45.id                        AS SeguridadPuerta_45_id                   	-- 45	.CuentaContable.SeguridadPuerta.id                  		VARCHAR(36)
				, SeguridadPuerta_45.numero                    AS SeguridadPuerta_45_numero               	-- 46	.CuentaContable.SeguridadPuerta.numero              		INTEGER
				, SeguridadPuerta_45.nombre                    AS SeguridadPuerta_45_nombre               	-- 47	.CuentaContable.SeguridadPuerta.nombre              		VARCHAR(50)
				, SeguridadPuerta_45.equate                    AS SeguridadPuerta_45_equate               	-- 48	.CuentaContable.SeguridadPuerta.equate              		VARCHAR(30)
				, SeguridadPuerta_45.seguridadModulo           AS SeguridadPuerta_45_seguridadModulo      	-- 49	.CuentaContable.SeguridadPuerta.seguridadModulo     		VARCHAR(36)	SeguridadModulo.id

		FROM	massoftware.AsientoModeloItem
			LEFT JOIN massoftware.AsientoModelo AS AsientoModelo_2                   ON AsientoModeloItem.asientoModelo = AsientoModelo_2.id 	-- 2 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_5              ON AsientoModelo_2.ejercicioContable = EjercicioContable_5.id 	-- 5 LEFT LEVEL: 2
			LEFT JOIN massoftware.CuentaContable AS CuentaContable_12                 ON AsientoModeloItem.cuentaContable = CuentaContable_12.id 	-- 12 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_15              ON CuentaContable_12.ejercicioContable = EjercicioContable_15.id 	-- 15 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_26           ON CuentaContable_12.cuentaContableEstado = CuentaContableEstado_26.id 	-- 26 LEFT LEVEL: 2
				LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_30            ON CuentaContable_12.centroCostoContable = CentroCostoContable_30.id 	-- 30 LEFT LEVEL: 2
				LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_37                ON CuentaContable_12.puntoEquilibrio = PuntoEquilibrio_37.id 	-- 37 LEFT LEVEL: 2
				LEFT JOIN massoftware.CostoVenta AS CostoVenta_42                     ON CuentaContable_12.costoVenta = CostoVenta_42.id 	-- 42 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_45                ON CuentaContable_12.seguridadPuerta = SeguridadPuerta_45.id 	-- 45 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoModeloItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND asientoModeloArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoModeloArg5)) > 0 THEN
		asientoModeloArg5 = REPLACE(asientoModeloArg5, '''', '''''');
		asientoModeloArg5 = LOWER(TRIM(asientoModeloArg5));
		asientoModeloArg5 = TRANSLATE(asientoModeloArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoModeloArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoModeloItem.asientoModelo),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoModeloItemById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModeloItemById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_AsientoModeloItem_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoModeloItem_2 ( idArg , null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoModeloItem_2 ( null , null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoModeloItemById_2 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_AsientoModeloItem_3 (

	  idArg0              VARCHAR(36)	-- 0
	, orderByArg1         INTEGER    	-- 1
	, orderByDescArg2     BOOLEAN    	-- 2
	, limitArg3           BIGINT     	-- 3
	, offSetArg4          BIGINT     	-- 4
	, asientoModeloArg5   VARCHAR(36)	-- 5

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModeloItem_3 (

	  idArg0              VARCHAR(36)	-- 0
	, orderByArg1         INTEGER    	-- 1
	, orderByDescArg2     BOOLEAN    	-- 2
	, limitArg3           BIGINT     	-- 3
	, offSetArg4          BIGINT     	-- 4
	, asientoModeloArg5   VARCHAR(36)	-- 5

) RETURNS SETOF massoftware.t_AsientoModeloItem_3 AS $$

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
				  AsientoModeloItem.id                       AS AsientoModeloItem_id                  	-- 0	.id                                                                		VARCHAR(36)
				, AsientoModeloItem.numero                   AS AsientoModeloItem_numero              	-- 1	.numero                                                            		INTEGER
				, AsientoModelo_2.id                         AS AsientoModelo_2_id                    	-- 2	.AsientoModelo.id                                                  		VARCHAR(36)
				, AsientoModelo_2.numero                     AS AsientoModelo_2_numero                	-- 3	.AsientoModelo.numero                                              		INTEGER
				, AsientoModelo_2.nombre                     AS AsientoModelo_2_nombre                	-- 4	.AsientoModelo.nombre                                              		VARCHAR(50)
				, EjercicioContable_5.id                     AS EjercicioContable_5_id                	-- 5	.AsientoModelo.EjercicioContable.id                                		VARCHAR(36)
				, EjercicioContable_5.numero                 AS EjercicioContable_5_numero            	-- 6	.AsientoModelo.EjercicioContable.numero                            		INTEGER
				, EjercicioContable_5.apertura               AS EjercicioContable_5_apertura          	-- 7	.AsientoModelo.EjercicioContable.apertura                          		DATE
				, EjercicioContable_5.cierre                 AS EjercicioContable_5_cierre            	-- 8	.AsientoModelo.EjercicioContable.cierre                            		DATE
				, EjercicioContable_5.cerrado                AS EjercicioContable_5_cerrado           	-- 9	.AsientoModelo.EjercicioContable.cerrado                           		BOOLEAN
				, EjercicioContable_5.cerradoModulos         AS EjercicioContable_5_cerradoModulos    	-- 10	.AsientoModelo.EjercicioContable.cerradoModulos                    		BOOLEAN
				, EjercicioContable_5.comentario             AS EjercicioContable_5_comentario        	-- 11	.AsientoModelo.EjercicioContable.comentario                        		VARCHAR(250)
				, CuentaContable_12.id                       AS CuentaContable_12_id                  	-- 12	.CuentaContable.id                                                 		VARCHAR(36)
				, CuentaContable_12.codigo                   AS CuentaContable_12_codigo              	-- 13	.CuentaContable.codigo                                             		VARCHAR(11)
				, CuentaContable_12.nombre                   AS CuentaContable_12_nombre              	-- 14	.CuentaContable.nombre                                             		VARCHAR(50)
				, EjercicioContable_15.id                    AS EjercicioContable_15_id               	-- 15	.CuentaContable.EjercicioContable.id                               		VARCHAR(36)
				, EjercicioContable_15.numero                AS EjercicioContable_15_numero           	-- 16	.CuentaContable.EjercicioContable.numero                           		INTEGER
				, EjercicioContable_15.apertura              AS EjercicioContable_15_apertura         	-- 17	.CuentaContable.EjercicioContable.apertura                         		DATE
				, EjercicioContable_15.cierre                AS EjercicioContable_15_cierre           	-- 18	.CuentaContable.EjercicioContable.cierre                           		DATE
				, EjercicioContable_15.cerrado               AS EjercicioContable_15_cerrado          	-- 19	.CuentaContable.EjercicioContable.cerrado                          		BOOLEAN
				, EjercicioContable_15.cerradoModulos        AS EjercicioContable_15_cerradoModulos   	-- 20	.CuentaContable.EjercicioContable.cerradoModulos                   		BOOLEAN
				, EjercicioContable_15.comentario            AS EjercicioContable_15_comentario       	-- 21	.CuentaContable.EjercicioContable.comentario                       		VARCHAR(250)
				, CuentaContable_12.integra                  AS CuentaContable_12_integra             	-- 22	.CuentaContable.integra                                            		VARCHAR(16)
				, CuentaContable_12.cuentaJerarquia          AS CuentaContable_12_cuentaJerarquia     	-- 23	.CuentaContable.cuentaJerarquia                                    		VARCHAR(16)
				, CuentaContable_12.imputable                AS CuentaContable_12_imputable           	-- 24	.CuentaContable.imputable                                          		BOOLEAN
				, CuentaContable_12.ajustaPorInflacion       AS CuentaContable_12_ajustaPorInflacion  	-- 25	.CuentaContable.ajustaPorInflacion                                 		BOOLEAN
				, CuentaContableEstado_26.id                 AS CuentaContableEstado_26_id            	-- 26	.CuentaContable.CuentaContableEstado.id                            		VARCHAR(36)
				, CuentaContableEstado_26.numero             AS CuentaContableEstado_26_numero        	-- 27	.CuentaContable.CuentaContableEstado.numero                        		INTEGER
				, CuentaContableEstado_26.nombre             AS CuentaContableEstado_26_nombre        	-- 28	.CuentaContable.CuentaContableEstado.nombre                        		VARCHAR(50)
				, CuentaContable_12.cuentaConApropiacion     AS CuentaContable_12_cuentaConApropiacion	-- 29	.CuentaContable.cuentaConApropiacion                               		BOOLEAN
				, CentroCostoContable_30.id                  AS CentroCostoContable_30_id             	-- 30	.CuentaContable.CentroCostoContable.id                             		VARCHAR(36)
				, CentroCostoContable_30.numero              AS CentroCostoContable_30_numero         	-- 31	.CuentaContable.CentroCostoContable.numero                         		INTEGER
				, CentroCostoContable_30.nombre              AS CentroCostoContable_30_nombre         	-- 32	.CuentaContable.CentroCostoContable.nombre                         		VARCHAR(50)
				, CentroCostoContable_30.abreviatura         AS CentroCostoContable_30_abreviatura    	-- 33	.CuentaContable.CentroCostoContable.abreviatura                    		VARCHAR(5)
				, EjercicioContable_34.id                    AS EjercicioContable_34_id               	-- 34	.CuentaContable.CentroCostoContable.EjercicioContable.id           		VARCHAR(36)
				, EjercicioContable_34.numero                AS EjercicioContable_34_numero           	-- 35	.CuentaContable.CentroCostoContable.EjercicioContable.numero       		INTEGER
				, EjercicioContable_34.apertura              AS EjercicioContable_34_apertura         	-- 36	.CuentaContable.CentroCostoContable.EjercicioContable.apertura     		DATE
				, EjercicioContable_34.cierre                AS EjercicioContable_34_cierre           	-- 37	.CuentaContable.CentroCostoContable.EjercicioContable.cierre       		DATE
				, EjercicioContable_34.cerrado               AS EjercicioContable_34_cerrado          	-- 38	.CuentaContable.CentroCostoContable.EjercicioContable.cerrado      		BOOLEAN
				, EjercicioContable_34.cerradoModulos        AS EjercicioContable_34_cerradoModulos   	-- 39	.CuentaContable.CentroCostoContable.EjercicioContable.cerradoModulos		BOOLEAN
				, EjercicioContable_34.comentario            AS EjercicioContable_34_comentario       	-- 40	.CuentaContable.CentroCostoContable.EjercicioContable.comentario   		VARCHAR(250)
				, CuentaContable_12.cuentaAgrupadora         AS CuentaContable_12_cuentaAgrupadora    	-- 41	.CuentaContable.cuentaAgrupadora                                   		VARCHAR(50)
				, CuentaContable_12.porcentaje               AS CuentaContable_12_porcentaje          	-- 42	.CuentaContable.porcentaje                                         		DECIMAL(6,3)
				, PuntoEquilibrio_43.id                      AS PuntoEquilibrio_43_id                 	-- 43	.CuentaContable.PuntoEquilibrio.id                                 		VARCHAR(36)
				, PuntoEquilibrio_43.numero                  AS PuntoEquilibrio_43_numero             	-- 44	.CuentaContable.PuntoEquilibrio.numero                             		INTEGER
				, PuntoEquilibrio_43.nombre                  AS PuntoEquilibrio_43_nombre             	-- 45	.CuentaContable.PuntoEquilibrio.nombre                             		VARCHAR(50)
				, TipoPuntoEquilibrio_46.id                  AS TipoPuntoEquilibrio_46_id             	-- 46	.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.id             		VARCHAR(36)
				, TipoPuntoEquilibrio_46.numero              AS TipoPuntoEquilibrio_46_numero         	-- 47	.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.numero         		INTEGER
				, TipoPuntoEquilibrio_46.nombre              AS TipoPuntoEquilibrio_46_nombre         	-- 48	.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.nombre         		VARCHAR(50)
				, EjercicioContable_49.id                    AS EjercicioContable_49_id               	-- 49	.CuentaContable.PuntoEquilibrio.EjercicioContable.id               		VARCHAR(36)
				, EjercicioContable_49.numero                AS EjercicioContable_49_numero           	-- 50	.CuentaContable.PuntoEquilibrio.EjercicioContable.numero           		INTEGER
				, EjercicioContable_49.apertura              AS EjercicioContable_49_apertura         	-- 51	.CuentaContable.PuntoEquilibrio.EjercicioContable.apertura         		DATE
				, EjercicioContable_49.cierre                AS EjercicioContable_49_cierre           	-- 52	.CuentaContable.PuntoEquilibrio.EjercicioContable.cierre           		DATE
				, EjercicioContable_49.cerrado               AS EjercicioContable_49_cerrado          	-- 53	.CuentaContable.PuntoEquilibrio.EjercicioContable.cerrado          		BOOLEAN
				, EjercicioContable_49.cerradoModulos        AS EjercicioContable_49_cerradoModulos   	-- 54	.CuentaContable.PuntoEquilibrio.EjercicioContable.cerradoModulos   		BOOLEAN
				, EjercicioContable_49.comentario            AS EjercicioContable_49_comentario       	-- 55	.CuentaContable.PuntoEquilibrio.EjercicioContable.comentario       		VARCHAR(250)
				, CostoVenta_56.id                           AS CostoVenta_56_id                      	-- 56	.CuentaContable.CostoVenta.id                                      		VARCHAR(36)
				, CostoVenta_56.numero                       AS CostoVenta_56_numero                  	-- 57	.CuentaContable.CostoVenta.numero                                  		INTEGER
				, CostoVenta_56.nombre                       AS CostoVenta_56_nombre                  	-- 58	.CuentaContable.CostoVenta.nombre                                  		VARCHAR(50)
				, SeguridadPuerta_59.id                      AS SeguridadPuerta_59_id                 	-- 59	.CuentaContable.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_59.numero                  AS SeguridadPuerta_59_numero             	-- 60	.CuentaContable.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_59.nombre                  AS SeguridadPuerta_59_nombre             	-- 61	.CuentaContable.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_59.equate                  AS SeguridadPuerta_59_equate             	-- 62	.CuentaContable.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_63.id                      AS SeguridadModulo_63_id                 	-- 63	.CuentaContable.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_63.numero                  AS SeguridadModulo_63_numero             	-- 64	.CuentaContable.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_63.nombre                  AS SeguridadModulo_63_nombre             	-- 65	.CuentaContable.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)

		FROM	massoftware.AsientoModeloItem
			LEFT JOIN massoftware.AsientoModelo AS AsientoModelo_2                     ON AsientoModeloItem.asientoModelo = AsientoModelo_2.id 	-- 2 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_5                ON AsientoModelo_2.ejercicioContable = EjercicioContable_5.id 	-- 5 LEFT LEVEL: 2
			LEFT JOIN massoftware.CuentaContable AS CuentaContable_12                   ON AsientoModeloItem.cuentaContable = CuentaContable_12.id 	-- 12 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_15                ON CuentaContable_12.ejercicioContable = EjercicioContable_15.id 	-- 15 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_26             ON CuentaContable_12.cuentaContableEstado = CuentaContableEstado_26.id 	-- 26 LEFT LEVEL: 2
				LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_30              ON CuentaContable_12.centroCostoContable = CentroCostoContable_30.id 	-- 30 LEFT LEVEL: 2
					LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_34               ON CentroCostoContable_30.ejercicioContable = EjercicioContable_34.id 	-- 34 LEFT LEVEL: 3
				LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_43                  ON CuentaContable_12.puntoEquilibrio = PuntoEquilibrio_43.id 	-- 43 LEFT LEVEL: 2
					LEFT JOIN massoftware.TipoPuntoEquilibrio AS TipoPuntoEquilibrio_46             ON PuntoEquilibrio_43.tipoPuntoEquilibrio = TipoPuntoEquilibrio_46.id 	-- 46 LEFT LEVEL: 3
					LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_49               ON PuntoEquilibrio_43.ejercicioContable = EjercicioContable_49.id 	-- 49 LEFT LEVEL: 3
				LEFT JOIN massoftware.CostoVenta AS CostoVenta_56                       ON CuentaContable_12.costoVenta = CostoVenta_56.id 	-- 56 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_59                  ON CuentaContable_12.seguridadPuerta = SeguridadPuerta_59.id 	-- 59 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_63                 ON SeguridadPuerta_59.seguridadModulo = SeguridadModulo_63.id 	-- 63 LEFT LEVEL: 3

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' AsientoModeloItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND asientoModeloArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(asientoModeloArg5)) > 0 THEN
		asientoModeloArg5 = REPLACE(asientoModeloArg5, '''', '''''');
		asientoModeloArg5 = LOWER(TRIM(asientoModeloArg5));
		asientoModeloArg5 = TRANSLATE(asientoModeloArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(asientoModeloArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(AsientoModeloItem.asientoModelo),
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

DROP FUNCTION IF EXISTS massoftware.f_AsientoModeloItemById_3 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_AsientoModeloItemById_3 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_AsientoModeloItem_3 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_AsientoModeloItem_3 ( idArg , null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_AsientoModeloItem_3 ( null , null, null, null, null, null); 

-- SELECT * FROM massoftware.f_AsientoModeloItemById_3 ('xxx'); 