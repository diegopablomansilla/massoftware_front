
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ComprobanteFondoModeloItem                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ComprobanteFondoModeloItem



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.ComprobanteFondoModeloItem CASCADE;

CREATE TABLE massoftware.ComprobanteFondoModeloItem
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº modelo
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT ComprobanteFondoModeloItem_numero_chk CHECK ( numero >= 1  ), 
	
	-- Debe
	debe BOOLEAN NOT NULL, 
	
	-- Modelo
	comprobanteFondoModelo VARCHAR(36)  NOT NULL  REFERENCES massoftware.ComprobanteFondoModelo (id), 
	
	-- Cuenta fondo
	cuentaFondo VARCHAR(36)  NOT NULL  REFERENCES massoftware.CuentaFondo (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatComprobanteFondoModeloItem() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatComprobanteFondoModeloItem() RETURNS TRIGGER AS $formatComprobanteFondoModeloItem$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.comprobanteFondoModelo := massoftware.white_is_null(NEW.comprobanteFondoModelo);
	 NEW.cuentaFondo := massoftware.white_is_null(NEW.cuentaFondo);

	RETURN NEW;
END;
$formatComprobanteFondoModeloItem$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatComprobanteFondoModeloItem ON massoftware.ComprobanteFondoModeloItem CASCADE;

CREATE TRIGGER tgFormatComprobanteFondoModeloItem BEFORE INSERT OR UPDATE
	ON massoftware.ComprobanteFondoModeloItem FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatComprobanteFondoModeloItem();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.ComprobanteFondoModeloItem;

-- SELECT * FROM massoftware.ComprobanteFondoModeloItem LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.ComprobanteFondoModeloItem;

-- SELECT * FROM massoftware.ComprobanteFondoModeloItem WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_ComprobanteFondoModeloItem_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_ComprobanteFondoModeloItem_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.ComprobanteFondoModeloItem
	WHERE	(numeroArg IS NULL OR ComprobanteFondoModeloItem.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_ComprobanteFondoModeloItem_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_ComprobanteFondoModeloItem_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_ComprobanteFondoModeloItem_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.ComprobanteFondoModeloItem;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_ComprobanteFondoModeloItem_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_ComprobanteFondoModeloItemById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_ComprobanteFondoModeloItemById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.ComprobanteFondoModeloItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ComprobanteFondoModeloItem.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.ComprobanteFondoModeloItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ComprobanteFondoModeloItem.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.ComprobanteFondoModeloItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ComprobanteFondoModeloItem.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_ComprobanteFondoModeloItemById('xxx');

-- SELECT * FROM massoftware.d_ComprobanteFondoModeloItemById((SELECT ComprobanteFondoModeloItem.id FROM massoftware.ComprobanteFondoModeloItem LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_ComprobanteFondoModeloItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, debeArg BOOLEAN
		, comprobanteFondoModeloArg VARCHAR(36)
		, cuentaFondoArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_ComprobanteFondoModeloItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, debeArg BOOLEAN
		, comprobanteFondoModeloArg VARCHAR(36)
		, cuentaFondoArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF debeArg IS NULL THEN

		debeArg = false;

	END IF;

	INSERT INTO massoftware.ComprobanteFondoModeloItem(id, numero, debe, comprobanteFondoModelo, cuentaFondo) VALUES (idArg, numeroArg, debeArg, comprobanteFondoModeloArg, cuentaFondoArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.ComprobanteFondoModeloItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ComprobanteFondoModeloItem.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_ComprobanteFondoModeloItem(
		null::VARCHAR(36)
		, null::INTEGER
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_ComprobanteFondoModeloItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, debeArg BOOLEAN
		, comprobanteFondoModeloArg VARCHAR(36)
		, cuentaFondoArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_ComprobanteFondoModeloItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, debeArg BOOLEAN
		, comprobanteFondoModeloArg VARCHAR(36)
		, cuentaFondoArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF debeArg IS NULL THEN

		debeArg = false;

	END IF;

	UPDATE massoftware.ComprobanteFondoModeloItem SET 
		  numero = numeroArg
		, debe = debeArg
		, comprobanteFondoModelo = comprobanteFondoModeloArg
		, cuentaFondo = cuentaFondoArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ComprobanteFondoModeloItem.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.ComprobanteFondoModeloItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ComprobanteFondoModeloItem.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_ComprobanteFondoModeloItem(
		null::VARCHAR(36)
		, null::INTEGER
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/

DROP TYPE IF EXISTS massoftware.t_ComprobanteFondoModeloItem_1 CASCADE;

CREATE TYPE massoftware.t_ComprobanteFondoModeloItem_1 AS (

	  ComprobanteFondoModeloItem_id          	VARCHAR(36)  		-- 0	ComprobanteFondoModeloItem.id
	, ComprobanteFondoModeloItem_numero      	INTEGER      		-- 1	ComprobanteFondoModeloItem.numero
	, ComprobanteFondoModeloItem_debe        	BOOLEAN      		-- 2	ComprobanteFondoModeloItem.debe
	, ComprobanteFondoModelo_3_id            	VARCHAR(36)  		-- 3	ComprobanteFondoModeloItem.ComprobanteFondoModelo.id
	, ComprobanteFondoModelo_3_numero        	INTEGER      		-- 4	ComprobanteFondoModeloItem.ComprobanteFondoModelo.numero
	, ComprobanteFondoModelo_3_nombre        	VARCHAR(50)  		-- 5	ComprobanteFondoModeloItem.ComprobanteFondoModelo.nombre
	, CuentaFondo_6_id                       	VARCHAR(36)  		-- 6	ComprobanteFondoModeloItem.CuentaFondo.id
	, CuentaFondo_6_numero                   	INTEGER      		-- 7	ComprobanteFondoModeloItem.CuentaFondo.numero
	, CuentaFondo_6_nombre                   	VARCHAR(50)  		-- 8	ComprobanteFondoModeloItem.CuentaFondo.nombre
	, CuentaFondo_6_cuentaContable           	VARCHAR(36)  		-- 9	ComprobanteFondoModeloItem.CuentaFondo.cuentaContable
	, CuentaFondo_6_cuentaFondoGrupo         	VARCHAR(36)  		-- 10	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoGrupo
	, CuentaFondo_6_cuentaFondoTipo          	VARCHAR(36)  		-- 11	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoTipo
	, CuentaFondo_6_obsoleto                 	BOOLEAN      		-- 12	ComprobanteFondoModeloItem.CuentaFondo.obsoleto
	, CuentaFondo_6_noImprimeCaja            	BOOLEAN      		-- 13	ComprobanteFondoModeloItem.CuentaFondo.noImprimeCaja
	, CuentaFondo_6_ventas                   	BOOLEAN      		-- 14	ComprobanteFondoModeloItem.CuentaFondo.ventas
	, CuentaFondo_6_fondos                   	BOOLEAN      		-- 15	ComprobanteFondoModeloItem.CuentaFondo.fondos
	, CuentaFondo_6_compras                  	BOOLEAN      		-- 16	ComprobanteFondoModeloItem.CuentaFondo.compras
	, CuentaFondo_6_moneda                   	VARCHAR(36)  		-- 17	ComprobanteFondoModeloItem.CuentaFondo.moneda
	, CuentaFondo_6_caja                     	VARCHAR(36)  		-- 18	ComprobanteFondoModeloItem.CuentaFondo.caja
	, CuentaFondo_6_rechazados               	BOOLEAN      		-- 19	ComprobanteFondoModeloItem.CuentaFondo.rechazados
	, CuentaFondo_6_conciliacion             	BOOLEAN      		-- 20	ComprobanteFondoModeloItem.CuentaFondo.conciliacion
	, CuentaFondo_6_cuentaFondoTipoBanco     	VARCHAR(36)  		-- 21	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoTipoBanco
	, CuentaFondo_6_banco                    	VARCHAR(36)  		-- 22	ComprobanteFondoModeloItem.CuentaFondo.banco
	, CuentaFondo_6_cuentaBancaria           	VARCHAR(22)  		-- 23	ComprobanteFondoModeloItem.CuentaFondo.cuentaBancaria
	, CuentaFondo_6_cbu                      	VARCHAR(22)  		-- 24	ComprobanteFondoModeloItem.CuentaFondo.cbu
	, CuentaFondo_6_limiteDescubierto        	DECIMAL(13,5)		-- 25	ComprobanteFondoModeloItem.CuentaFondo.limiteDescubierto
	, CuentaFondo_6_cuentaFondoCaucion       	VARCHAR(50)  		-- 26	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoCaucion
	, CuentaFondo_6_cuentaFondoDiferidos     	VARCHAR(50)  		-- 27	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoDiferidos
	, CuentaFondo_6_formato                  	VARCHAR(50)  		-- 28	ComprobanteFondoModeloItem.CuentaFondo.formato
	, CuentaFondo_6_cuentaFondoBancoCopia    	VARCHAR(36)  		-- 29	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoBancoCopia
	, CuentaFondo_6_limiteOperacionIndividual	DECIMAL(13,5)		-- 30	ComprobanteFondoModeloItem.CuentaFondo.limiteOperacionIndividual
	, CuentaFondo_6_seguridadPuertaUso       	VARCHAR(36)  		-- 31	ComprobanteFondoModeloItem.CuentaFondo.seguridadPuertaUso
	, CuentaFondo_6_seguridadPuertaConsulta  	VARCHAR(36)  		-- 32	ComprobanteFondoModeloItem.CuentaFondo.seguridadPuertaConsulta
	, CuentaFondo_6_seguridadPuertaLimite    	VARCHAR(36)  		-- 33	ComprobanteFondoModeloItem.CuentaFondo.seguridadPuertaLimite

);

DROP TYPE IF EXISTS massoftware.t_ComprobanteFondoModeloItem_2 CASCADE;

CREATE TYPE massoftware.t_ComprobanteFondoModeloItem_2 AS (

	  ComprobanteFondoModeloItem_id          	VARCHAR(36)  		-- 0	ComprobanteFondoModeloItem.id
	, ComprobanteFondoModeloItem_numero      	INTEGER      		-- 1	ComprobanteFondoModeloItem.numero
	, ComprobanteFondoModeloItem_debe        	BOOLEAN      		-- 2	ComprobanteFondoModeloItem.debe
	, ComprobanteFondoModelo_3_id            	VARCHAR(36)  		-- 3	ComprobanteFondoModeloItem.ComprobanteFondoModelo.id
	, ComprobanteFondoModelo_3_numero        	INTEGER      		-- 4	ComprobanteFondoModeloItem.ComprobanteFondoModelo.numero
	, ComprobanteFondoModelo_3_nombre        	VARCHAR(50)  		-- 5	ComprobanteFondoModeloItem.ComprobanteFondoModelo.nombre
	, CuentaFondo_6_id                       	VARCHAR(36)  		-- 6	ComprobanteFondoModeloItem.CuentaFondo.id
	, CuentaFondo_6_numero                   	INTEGER      		-- 7	ComprobanteFondoModeloItem.CuentaFondo.numero
	, CuentaFondo_6_nombre                   	VARCHAR(50)  		-- 8	ComprobanteFondoModeloItem.CuentaFondo.nombre
	, CuentaContable_9_id                    	VARCHAR(36)  		-- 9	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.id
	, CuentaContable_9_codigo                	VARCHAR(11)  		-- 10	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.codigo
	, CuentaContable_9_nombre                	VARCHAR(50)  		-- 11	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.nombre
	, CuentaContable_9_ejercicioContable     	VARCHAR(36)  		-- 12	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.ejercicioContable
	, CuentaContable_9_integra               	VARCHAR(16)  		-- 13	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.integra
	, CuentaContable_9_cuentaJerarquia       	VARCHAR(16)  		-- 14	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.cuentaJerarquia
	, CuentaContable_9_imputable             	BOOLEAN      		-- 15	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.imputable
	, CuentaContable_9_ajustaPorInflacion    	BOOLEAN      		-- 16	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.ajustaPorInflacion
	, CuentaContable_9_cuentaContableEstado  	VARCHAR(36)  		-- 17	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.cuentaContableEstado
	, CuentaContable_9_cuentaConApropiacion  	BOOLEAN      		-- 18	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.cuentaConApropiacion
	, CuentaContable_9_centroCostoContable   	VARCHAR(36)  		-- 19	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.centroCostoContable
	, CuentaContable_9_cuentaAgrupadora      	VARCHAR(50)  		-- 20	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.cuentaAgrupadora
	, CuentaContable_9_porcentaje            	DECIMAL(6,3) 		-- 21	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.porcentaje
	, CuentaContable_9_puntoEquilibrio       	VARCHAR(36)  		-- 22	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.puntoEquilibrio
	, CuentaContable_9_costoVenta            	VARCHAR(36)  		-- 23	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.costoVenta
	, CuentaContable_9_seguridadPuerta       	VARCHAR(36)  		-- 24	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.seguridadPuerta
	, CuentaFondoGrupo_25_id                 	VARCHAR(36)  		-- 25	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.id
	, CuentaFondoGrupo_25_numero             	INTEGER      		-- 26	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.numero
	, CuentaFondoGrupo_25_nombre             	VARCHAR(50)  		-- 27	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.nombre
	, CuentaFondoGrupo_25_cuentaFondoRubro   	VARCHAR(36)  		-- 28	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.cuentaFondoRubro
	, CuentaFondoTipo_29_id                  	VARCHAR(36)  		-- 29	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipo.id
	, CuentaFondoTipo_29_numero              	INTEGER      		-- 30	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipo.numero
	, CuentaFondoTipo_29_nombre              	VARCHAR(50)  		-- 31	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipo.nombre
	, CuentaFondo_6_obsoleto                 	BOOLEAN      		-- 32	ComprobanteFondoModeloItem.CuentaFondo.obsoleto
	, CuentaFondo_6_noImprimeCaja            	BOOLEAN      		-- 33	ComprobanteFondoModeloItem.CuentaFondo.noImprimeCaja
	, CuentaFondo_6_ventas                   	BOOLEAN      		-- 34	ComprobanteFondoModeloItem.CuentaFondo.ventas
	, CuentaFondo_6_fondos                   	BOOLEAN      		-- 35	ComprobanteFondoModeloItem.CuentaFondo.fondos
	, CuentaFondo_6_compras                  	BOOLEAN      		-- 36	ComprobanteFondoModeloItem.CuentaFondo.compras
	, Moneda_37_id                           	VARCHAR(36)  		-- 37	ComprobanteFondoModeloItem.CuentaFondo.Moneda.id
	, Moneda_37_numero                       	INTEGER      		-- 38	ComprobanteFondoModeloItem.CuentaFondo.Moneda.numero
	, Moneda_37_nombre                       	VARCHAR(50)  		-- 39	ComprobanteFondoModeloItem.CuentaFondo.Moneda.nombre
	, Moneda_37_abreviatura                  	VARCHAR(5)   		-- 40	ComprobanteFondoModeloItem.CuentaFondo.Moneda.abreviatura
	, Moneda_37_cotizacion                   	DECIMAL(13,5)		-- 41	ComprobanteFondoModeloItem.CuentaFondo.Moneda.cotizacion
	, Moneda_37_cotizacionFecha              	TIMESTAMP    		-- 42	ComprobanteFondoModeloItem.CuentaFondo.Moneda.cotizacionFecha
	, Moneda_37_controlActualizacion         	BOOLEAN      		-- 43	ComprobanteFondoModeloItem.CuentaFondo.Moneda.controlActualizacion
	, Moneda_37_monedaAFIP                   	VARCHAR(36)  		-- 44	ComprobanteFondoModeloItem.CuentaFondo.Moneda.monedaAFIP
	, Caja_45_id                             	VARCHAR(36)  		-- 45	ComprobanteFondoModeloItem.CuentaFondo.Caja.id
	, Caja_45_numero                         	INTEGER      		-- 46	ComprobanteFondoModeloItem.CuentaFondo.Caja.numero
	, Caja_45_nombre                         	VARCHAR(50)  		-- 47	ComprobanteFondoModeloItem.CuentaFondo.Caja.nombre
	, Caja_45_seguridadPuerta                	VARCHAR(36)  		-- 48	ComprobanteFondoModeloItem.CuentaFondo.Caja.seguridadPuerta
	, CuentaFondo_6_rechazados               	BOOLEAN      		-- 49	ComprobanteFondoModeloItem.CuentaFondo.rechazados
	, CuentaFondo_6_conciliacion             	BOOLEAN      		-- 50	ComprobanteFondoModeloItem.CuentaFondo.conciliacion
	, CuentaFondoTipoBanco_51_id             	VARCHAR(36)  		-- 51	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipoBanco.id
	, CuentaFondoTipoBanco_51_numero         	INTEGER      		-- 52	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipoBanco.numero
	, CuentaFondoTipoBanco_51_nombre         	VARCHAR(50)  		-- 53	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipoBanco.nombre
	, Banco_54_id                            	VARCHAR(36)  		-- 54	ComprobanteFondoModeloItem.CuentaFondo.Banco.id
	, Banco_54_numero                        	INTEGER      		-- 55	ComprobanteFondoModeloItem.CuentaFondo.Banco.numero
	, Banco_54_nombre                        	VARCHAR(50)  		-- 56	ComprobanteFondoModeloItem.CuentaFondo.Banco.nombre
	, Banco_54_cuit                          	BIGINT       		-- 57	ComprobanteFondoModeloItem.CuentaFondo.Banco.cuit
	, Banco_54_bloqueado                     	BOOLEAN      		-- 58	ComprobanteFondoModeloItem.CuentaFondo.Banco.bloqueado
	, Banco_54_hoja                          	INTEGER      		-- 59	ComprobanteFondoModeloItem.CuentaFondo.Banco.hoja
	, Banco_54_primeraFila                   	INTEGER      		-- 60	ComprobanteFondoModeloItem.CuentaFondo.Banco.primeraFila
	, Banco_54_ultimaFila                    	INTEGER      		-- 61	ComprobanteFondoModeloItem.CuentaFondo.Banco.ultimaFila
	, Banco_54_fecha                         	VARCHAR(3)   		-- 62	ComprobanteFondoModeloItem.CuentaFondo.Banco.fecha
	, Banco_54_descripcion                   	VARCHAR(3)   		-- 63	ComprobanteFondoModeloItem.CuentaFondo.Banco.descripcion
	, Banco_54_referencia1                   	VARCHAR(3)   		-- 64	ComprobanteFondoModeloItem.CuentaFondo.Banco.referencia1
	, Banco_54_importe                       	VARCHAR(3)   		-- 65	ComprobanteFondoModeloItem.CuentaFondo.Banco.importe
	, Banco_54_referencia2                   	VARCHAR(3)   		-- 66	ComprobanteFondoModeloItem.CuentaFondo.Banco.referencia2
	, Banco_54_saldo                         	VARCHAR(3)   		-- 67	ComprobanteFondoModeloItem.CuentaFondo.Banco.saldo
	, CuentaFondo_6_cuentaBancaria           	VARCHAR(22)  		-- 68	ComprobanteFondoModeloItem.CuentaFondo.cuentaBancaria
	, CuentaFondo_6_cbu                      	VARCHAR(22)  		-- 69	ComprobanteFondoModeloItem.CuentaFondo.cbu
	, CuentaFondo_6_limiteDescubierto        	DECIMAL(13,5)		-- 70	ComprobanteFondoModeloItem.CuentaFondo.limiteDescubierto
	, CuentaFondo_6_cuentaFondoCaucion       	VARCHAR(50)  		-- 71	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoCaucion
	, CuentaFondo_6_cuentaFondoDiferidos     	VARCHAR(50)  		-- 72	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoDiferidos
	, CuentaFondo_6_formato                  	VARCHAR(50)  		-- 73	ComprobanteFondoModeloItem.CuentaFondo.formato
	, CuentaFondoBancoCopia_74_id            	VARCHAR(36)  		-- 74	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoBancoCopia.id
	, CuentaFondoBancoCopia_74_numero        	INTEGER      		-- 75	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoBancoCopia.numero
	, CuentaFondoBancoCopia_74_nombre        	VARCHAR(50)  		-- 76	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoBancoCopia.nombre
	, CuentaFondo_6_limiteOperacionIndividual	DECIMAL(13,5)		-- 77	ComprobanteFondoModeloItem.CuentaFondo.limiteOperacionIndividual
	, SeguridadPuerta_78_id                  	VARCHAR(36)  		-- 78	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_78_numero              	INTEGER      		-- 79	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_78_nombre              	VARCHAR(50)  		-- 80	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_78_equate              	VARCHAR(30)  		-- 81	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.equate
	, SeguridadPuerta_78_seguridadModulo     	VARCHAR(36)  		-- 82	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.seguridadModulo
	, SeguridadPuerta_83_id                  	VARCHAR(36)  		-- 83	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_83_numero              	INTEGER      		-- 84	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_83_nombre              	VARCHAR(50)  		-- 85	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_83_equate              	VARCHAR(30)  		-- 86	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.equate
	, SeguridadPuerta_83_seguridadModulo     	VARCHAR(36)  		-- 87	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.seguridadModulo
	, SeguridadPuerta_88_id                  	VARCHAR(36)  		-- 88	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_88_numero              	INTEGER      		-- 89	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_88_nombre              	VARCHAR(50)  		-- 90	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_88_equate              	VARCHAR(30)  		-- 91	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.equate
	, SeguridadPuerta_88_seguridadModulo     	VARCHAR(36)  		-- 92	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.seguridadModulo

);

DROP TYPE IF EXISTS massoftware.t_ComprobanteFondoModeloItem_3 CASCADE;

CREATE TYPE massoftware.t_ComprobanteFondoModeloItem_3 AS (

	  ComprobanteFondoModeloItem_id           	VARCHAR(36)  		-- 0	ComprobanteFondoModeloItem.id
	, ComprobanteFondoModeloItem_numero       	INTEGER      		-- 1	ComprobanteFondoModeloItem.numero
	, ComprobanteFondoModeloItem_debe         	BOOLEAN      		-- 2	ComprobanteFondoModeloItem.debe
	, ComprobanteFondoModelo_3_id             	VARCHAR(36)  		-- 3	ComprobanteFondoModeloItem.ComprobanteFondoModelo.id
	, ComprobanteFondoModelo_3_numero         	INTEGER      		-- 4	ComprobanteFondoModeloItem.ComprobanteFondoModelo.numero
	, ComprobanteFondoModelo_3_nombre         	VARCHAR(50)  		-- 5	ComprobanteFondoModeloItem.ComprobanteFondoModelo.nombre
	, CuentaFondo_6_id                        	VARCHAR(36)  		-- 6	ComprobanteFondoModeloItem.CuentaFondo.id
	, CuentaFondo_6_numero                    	INTEGER      		-- 7	ComprobanteFondoModeloItem.CuentaFondo.numero
	, CuentaFondo_6_nombre                    	VARCHAR(50)  		-- 8	ComprobanteFondoModeloItem.CuentaFondo.nombre
	, CuentaContable_9_id                     	VARCHAR(36)  		-- 9	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.id
	, CuentaContable_9_codigo                 	VARCHAR(11)  		-- 10	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.codigo
	, CuentaContable_9_nombre                 	VARCHAR(50)  		-- 11	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.nombre
	, EjercicioContable_12_id                 	VARCHAR(36)  		-- 12	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.EjercicioContable.id
	, EjercicioContable_12_numero             	INTEGER      		-- 13	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.EjercicioContable.numero
	, EjercicioContable_12_apertura           	DATE         		-- 14	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.EjercicioContable.apertura
	, EjercicioContable_12_cierre             	DATE         		-- 15	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.EjercicioContable.cierre
	, EjercicioContable_12_cerrado            	BOOLEAN      		-- 16	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_12_cerradoModulos     	BOOLEAN      		-- 17	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_12_comentario         	VARCHAR(250) 		-- 18	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.EjercicioContable.comentario
	, CuentaContable_9_integra                	VARCHAR(16)  		-- 19	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.integra
	, CuentaContable_9_cuentaJerarquia        	VARCHAR(16)  		-- 20	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.cuentaJerarquia
	, CuentaContable_9_imputable              	BOOLEAN      		-- 21	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.imputable
	, CuentaContable_9_ajustaPorInflacion     	BOOLEAN      		-- 22	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_23_id              	VARCHAR(36)  		-- 23	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_23_numero          	INTEGER      		-- 24	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_23_nombre          	VARCHAR(50)  		-- 25	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_9_cuentaConApropiacion   	BOOLEAN      		-- 26	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.cuentaConApropiacion
	, CentroCostoContable_27_id               	VARCHAR(36)  		-- 27	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CentroCostoContable.id
	, CentroCostoContable_27_numero           	INTEGER      		-- 28	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_27_nombre           	VARCHAR(50)  		-- 29	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_27_abreviatura      	VARCHAR(5)   		-- 30	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CentroCostoContable.abreviatura
	, CentroCostoContable_27_ejercicioContable	VARCHAR(36)  		-- 31	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CentroCostoContable.ejercicioContable
	, CuentaContable_9_cuentaAgrupadora       	VARCHAR(50)  		-- 32	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.cuentaAgrupadora
	, CuentaContable_9_porcentaje             	DECIMAL(6,3) 		-- 33	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.porcentaje
	, PuntoEquilibrio_34_id                   	VARCHAR(36)  		-- 34	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_34_numero               	INTEGER      		-- 35	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_34_nombre               	VARCHAR(50)  		-- 36	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.PuntoEquilibrio.nombre
	, PuntoEquilibrio_34_tipoPuntoEquilibrio  	VARCHAR(36)  		-- 37	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio
	, PuntoEquilibrio_34_ejercicioContable    	VARCHAR(36)  		-- 38	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.PuntoEquilibrio.ejercicioContable
	, CostoVenta_39_id                        	VARCHAR(36)  		-- 39	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CostoVenta.id
	, CostoVenta_39_numero                    	INTEGER      		-- 40	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CostoVenta.numero
	, CostoVenta_39_nombre                    	VARCHAR(50)  		-- 41	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_42_id                   	VARCHAR(36)  		-- 42	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_42_numero               	INTEGER      		-- 43	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_42_nombre               	VARCHAR(50)  		-- 44	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_42_equate               	VARCHAR(30)  		-- 45	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.SeguridadPuerta.equate
	, SeguridadPuerta_42_seguridadModulo      	VARCHAR(36)  		-- 46	ComprobanteFondoModeloItem.CuentaFondo.CuentaContable.SeguridadPuerta.seguridadModulo
	, CuentaFondoGrupo_47_id                  	VARCHAR(36)  		-- 47	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.id
	, CuentaFondoGrupo_47_numero              	INTEGER      		-- 48	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.numero
	, CuentaFondoGrupo_47_nombre              	VARCHAR(50)  		-- 49	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.nombre
	, CuentaFondoRubro_50_id                  	VARCHAR(36)  		-- 50	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.id
	, CuentaFondoRubro_50_numero              	INTEGER      		-- 51	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.numero
	, CuentaFondoRubro_50_nombre              	VARCHAR(50)  		-- 52	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.nombre
	, CuentaFondoTipo_53_id                   	VARCHAR(36)  		-- 53	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipo.id
	, CuentaFondoTipo_53_numero               	INTEGER      		-- 54	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipo.numero
	, CuentaFondoTipo_53_nombre               	VARCHAR(50)  		-- 55	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipo.nombre
	, CuentaFondo_6_obsoleto                  	BOOLEAN      		-- 56	ComprobanteFondoModeloItem.CuentaFondo.obsoleto
	, CuentaFondo_6_noImprimeCaja             	BOOLEAN      		-- 57	ComprobanteFondoModeloItem.CuentaFondo.noImprimeCaja
	, CuentaFondo_6_ventas                    	BOOLEAN      		-- 58	ComprobanteFondoModeloItem.CuentaFondo.ventas
	, CuentaFondo_6_fondos                    	BOOLEAN      		-- 59	ComprobanteFondoModeloItem.CuentaFondo.fondos
	, CuentaFondo_6_compras                   	BOOLEAN      		-- 60	ComprobanteFondoModeloItem.CuentaFondo.compras
	, Moneda_61_id                            	VARCHAR(36)  		-- 61	ComprobanteFondoModeloItem.CuentaFondo.Moneda.id
	, Moneda_61_numero                        	INTEGER      		-- 62	ComprobanteFondoModeloItem.CuentaFondo.Moneda.numero
	, Moneda_61_nombre                        	VARCHAR(50)  		-- 63	ComprobanteFondoModeloItem.CuentaFondo.Moneda.nombre
	, Moneda_61_abreviatura                   	VARCHAR(5)   		-- 64	ComprobanteFondoModeloItem.CuentaFondo.Moneda.abreviatura
	, Moneda_61_cotizacion                    	DECIMAL(13,5)		-- 65	ComprobanteFondoModeloItem.CuentaFondo.Moneda.cotizacion
	, Moneda_61_cotizacionFecha               	TIMESTAMP    		-- 66	ComprobanteFondoModeloItem.CuentaFondo.Moneda.cotizacionFecha
	, Moneda_61_controlActualizacion          	BOOLEAN      		-- 67	ComprobanteFondoModeloItem.CuentaFondo.Moneda.controlActualizacion
	, MonedaAFIP_68_id                        	VARCHAR(36)  		-- 68	ComprobanteFondoModeloItem.CuentaFondo.Moneda.MonedaAFIP.id
	, MonedaAFIP_68_codigo                    	VARCHAR(3)   		-- 69	ComprobanteFondoModeloItem.CuentaFondo.Moneda.MonedaAFIP.codigo
	, MonedaAFIP_68_nombre                    	VARCHAR(50)  		-- 70	ComprobanteFondoModeloItem.CuentaFondo.Moneda.MonedaAFIP.nombre
	, Caja_71_id                              	VARCHAR(36)  		-- 71	ComprobanteFondoModeloItem.CuentaFondo.Caja.id
	, Caja_71_numero                          	INTEGER      		-- 72	ComprobanteFondoModeloItem.CuentaFondo.Caja.numero
	, Caja_71_nombre                          	VARCHAR(50)  		-- 73	ComprobanteFondoModeloItem.CuentaFondo.Caja.nombre
	, SeguridadPuerta_74_id                   	VARCHAR(36)  		-- 74	ComprobanteFondoModeloItem.CuentaFondo.Caja.SeguridadPuerta.id
	, SeguridadPuerta_74_numero               	INTEGER      		-- 75	ComprobanteFondoModeloItem.CuentaFondo.Caja.SeguridadPuerta.numero
	, SeguridadPuerta_74_nombre               	VARCHAR(50)  		-- 76	ComprobanteFondoModeloItem.CuentaFondo.Caja.SeguridadPuerta.nombre
	, SeguridadPuerta_74_equate               	VARCHAR(30)  		-- 77	ComprobanteFondoModeloItem.CuentaFondo.Caja.SeguridadPuerta.equate
	, SeguridadPuerta_74_seguridadModulo      	VARCHAR(36)  		-- 78	ComprobanteFondoModeloItem.CuentaFondo.Caja.SeguridadPuerta.seguridadModulo
	, CuentaFondo_6_rechazados                	BOOLEAN      		-- 79	ComprobanteFondoModeloItem.CuentaFondo.rechazados
	, CuentaFondo_6_conciliacion              	BOOLEAN      		-- 80	ComprobanteFondoModeloItem.CuentaFondo.conciliacion
	, CuentaFondoTipoBanco_81_id              	VARCHAR(36)  		-- 81	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipoBanco.id
	, CuentaFondoTipoBanco_81_numero          	INTEGER      		-- 82	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipoBanco.numero
	, CuentaFondoTipoBanco_81_nombre          	VARCHAR(50)  		-- 83	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoTipoBanco.nombre
	, Banco_84_id                             	VARCHAR(36)  		-- 84	ComprobanteFondoModeloItem.CuentaFondo.Banco.id
	, Banco_84_numero                         	INTEGER      		-- 85	ComprobanteFondoModeloItem.CuentaFondo.Banco.numero
	, Banco_84_nombre                         	VARCHAR(50)  		-- 86	ComprobanteFondoModeloItem.CuentaFondo.Banco.nombre
	, Banco_84_cuit                           	BIGINT       		-- 87	ComprobanteFondoModeloItem.CuentaFondo.Banco.cuit
	, Banco_84_bloqueado                      	BOOLEAN      		-- 88	ComprobanteFondoModeloItem.CuentaFondo.Banco.bloqueado
	, Banco_84_hoja                           	INTEGER      		-- 89	ComprobanteFondoModeloItem.CuentaFondo.Banco.hoja
	, Banco_84_primeraFila                    	INTEGER      		-- 90	ComprobanteFondoModeloItem.CuentaFondo.Banco.primeraFila
	, Banco_84_ultimaFila                     	INTEGER      		-- 91	ComprobanteFondoModeloItem.CuentaFondo.Banco.ultimaFila
	, Banco_84_fecha                          	VARCHAR(3)   		-- 92	ComprobanteFondoModeloItem.CuentaFondo.Banco.fecha
	, Banco_84_descripcion                    	VARCHAR(3)   		-- 93	ComprobanteFondoModeloItem.CuentaFondo.Banco.descripcion
	, Banco_84_referencia1                    	VARCHAR(3)   		-- 94	ComprobanteFondoModeloItem.CuentaFondo.Banco.referencia1
	, Banco_84_importe                        	VARCHAR(3)   		-- 95	ComprobanteFondoModeloItem.CuentaFondo.Banco.importe
	, Banco_84_referencia2                    	VARCHAR(3)   		-- 96	ComprobanteFondoModeloItem.CuentaFondo.Banco.referencia2
	, Banco_84_saldo                          	VARCHAR(3)   		-- 97	ComprobanteFondoModeloItem.CuentaFondo.Banco.saldo
	, CuentaFondo_6_cuentaBancaria            	VARCHAR(22)  		-- 98	ComprobanteFondoModeloItem.CuentaFondo.cuentaBancaria
	, CuentaFondo_6_cbu                       	VARCHAR(22)  		-- 99	ComprobanteFondoModeloItem.CuentaFondo.cbu
	, CuentaFondo_6_limiteDescubierto         	DECIMAL(13,5)		-- 100	ComprobanteFondoModeloItem.CuentaFondo.limiteDescubierto
	, CuentaFondo_6_cuentaFondoCaucion        	VARCHAR(50)  		-- 101	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoCaucion
	, CuentaFondo_6_cuentaFondoDiferidos      	VARCHAR(50)  		-- 102	ComprobanteFondoModeloItem.CuentaFondo.cuentaFondoDiferidos
	, CuentaFondo_6_formato                   	VARCHAR(50)  		-- 103	ComprobanteFondoModeloItem.CuentaFondo.formato
	, CuentaFondoBancoCopia_104_id            	VARCHAR(36)  		-- 104	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoBancoCopia.id
	, CuentaFondoBancoCopia_104_numero        	INTEGER      		-- 105	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoBancoCopia.numero
	, CuentaFondoBancoCopia_104_nombre        	VARCHAR(50)  		-- 106	ComprobanteFondoModeloItem.CuentaFondo.CuentaFondoBancoCopia.nombre
	, CuentaFondo_6_limiteOperacionIndividual 	DECIMAL(13,5)		-- 107	ComprobanteFondoModeloItem.CuentaFondo.limiteOperacionIndividual
	, SeguridadPuerta_108_id                  	VARCHAR(36)  		-- 108	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_108_numero              	INTEGER      		-- 109	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_108_nombre              	VARCHAR(50)  		-- 110	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_108_equate              	VARCHAR(30)  		-- 111	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_112_id                  	VARCHAR(36)  		-- 112	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_112_numero              	INTEGER      		-- 113	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_112_nombre              	VARCHAR(50)  		-- 114	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre
	, SeguridadPuerta_115_id                  	VARCHAR(36)  		-- 115	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_115_numero              	INTEGER      		-- 116	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_115_nombre              	VARCHAR(50)  		-- 117	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_115_equate              	VARCHAR(30)  		-- 118	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_119_id                  	VARCHAR(36)  		-- 119	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_119_numero              	INTEGER      		-- 120	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_119_nombre              	VARCHAR(50)  		-- 121	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre
	, SeguridadPuerta_122_id                  	VARCHAR(36)  		-- 122	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_122_numero              	INTEGER      		-- 123	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_122_nombre              	VARCHAR(50)  		-- 124	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_122_equate              	VARCHAR(30)  		-- 125	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_126_id                  	VARCHAR(36)  		-- 126	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_126_numero              	INTEGER      		-- 127	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_126_nombre              	VARCHAR(50)  		-- 128	ComprobanteFondoModeloItem.CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre

);

DROP FUNCTION IF EXISTS massoftware.f_ComprobanteFondoModeloItem (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, cuentaFondoArg7   VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ComprobanteFondoModeloItem (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, cuentaFondoArg7   VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.ComprobanteFondoModeloItem AS $$

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
				  ComprobanteFondoModeloItem.id                        AS ComprobanteFondoModeloItem_id                    	-- 0	.id                   		VARCHAR(36)
				, ComprobanteFondoModeloItem.numero                    AS ComprobanteFondoModeloItem_numero                	-- 1	.numero               		INTEGER
				, ComprobanteFondoModeloItem.debe                      AS ComprobanteFondoModeloItem_debe                  	-- 2	.debe                 		BOOLEAN
				, ComprobanteFondoModeloItem.comprobanteFondoModelo    AS ComprobanteFondoModeloItem_comprobanteFondoModelo	-- 3	.comprobanteFondoModelo		VARCHAR(36)	ComprobanteFondoModelo.id
				, ComprobanteFondoModeloItem.cuentaFondo               AS ComprobanteFondoModeloItem_cuentaFondo           	-- 4	.cuentaFondo          		VARCHAR(36)	CuentaFondo.id

		FROM	massoftware.ComprobanteFondoModeloItem

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND cuentaFondoArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(cuentaFondoArg7)) > 0 THEN
		cuentaFondoArg7 = REPLACE(cuentaFondoArg7, '''', '''''');
		cuentaFondoArg7 = LOWER(TRIM(cuentaFondoArg7));
		cuentaFondoArg7 = TRANSLATE(cuentaFondoArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(cuentaFondoArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(ComprobanteFondoModeloItem.cuentaFondo),
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

DROP FUNCTION IF EXISTS massoftware.f_ComprobanteFondoModeloItemById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ComprobanteFondoModeloItemById (idArg VARCHAR(36)) RETURNS SETOF massoftware.ComprobanteFondoModeloItem AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_ComprobanteFondoModeloItem ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_ComprobanteFondoModeloItem ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_ComprobanteFondoModeloItemById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_ComprobanteFondoModeloItem_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, cuentaFondoArg7   VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ComprobanteFondoModeloItem_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, cuentaFondoArg7   VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.t_ComprobanteFondoModeloItem_1 AS $$

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
				  ComprobanteFondoModeloItem.id               AS ComprobanteFondoModeloItem_id          	-- 0	.id                                  		VARCHAR(36)
				, ComprobanteFondoModeloItem.numero           AS ComprobanteFondoModeloItem_numero      	-- 1	.numero                              		INTEGER
				, ComprobanteFondoModeloItem.debe             AS ComprobanteFondoModeloItem_debe        	-- 2	.debe                                		BOOLEAN
				, ComprobanteFondoModelo_3.id                 AS ComprobanteFondoModelo_3_id            	-- 3	.ComprobanteFondoModelo.id           		VARCHAR(36)
				, ComprobanteFondoModelo_3.numero             AS ComprobanteFondoModelo_3_numero        	-- 4	.ComprobanteFondoModelo.numero       		INTEGER
				, ComprobanteFondoModelo_3.nombre             AS ComprobanteFondoModelo_3_nombre        	-- 5	.ComprobanteFondoModelo.nombre       		VARCHAR(50)
				, CuentaFondo_6.id                            AS CuentaFondo_6_id                       	-- 6	.CuentaFondo.id                      		VARCHAR(36)
				, CuentaFondo_6.numero                        AS CuentaFondo_6_numero                   	-- 7	.CuentaFondo.numero                  		INTEGER
				, CuentaFondo_6.nombre                        AS CuentaFondo_6_nombre                   	-- 8	.CuentaFondo.nombre                  		VARCHAR(50)
				, CuentaFondo_6.cuentaContable                AS CuentaFondo_6_cuentaContable           	-- 9	.CuentaFondo.cuentaContable          		VARCHAR(36)	CuentaContable.id
				, CuentaFondo_6.cuentaFondoGrupo              AS CuentaFondo_6_cuentaFondoGrupo         	-- 10	.CuentaFondo.cuentaFondoGrupo        		VARCHAR(36)	CuentaFondoGrupo.id
				, CuentaFondo_6.cuentaFondoTipo               AS CuentaFondo_6_cuentaFondoTipo          	-- 11	.CuentaFondo.cuentaFondoTipo         		VARCHAR(36)	CuentaFondoTipo.id
				, CuentaFondo_6.obsoleto                      AS CuentaFondo_6_obsoleto                 	-- 12	.CuentaFondo.obsoleto                		BOOLEAN
				, CuentaFondo_6.noImprimeCaja                 AS CuentaFondo_6_noImprimeCaja            	-- 13	.CuentaFondo.noImprimeCaja           		BOOLEAN
				, CuentaFondo_6.ventas                        AS CuentaFondo_6_ventas                   	-- 14	.CuentaFondo.ventas                  		BOOLEAN
				, CuentaFondo_6.fondos                        AS CuentaFondo_6_fondos                   	-- 15	.CuentaFondo.fondos                  		BOOLEAN
				, CuentaFondo_6.compras                       AS CuentaFondo_6_compras                  	-- 16	.CuentaFondo.compras                 		BOOLEAN
				, CuentaFondo_6.moneda                        AS CuentaFondo_6_moneda                   	-- 17	.CuentaFondo.moneda                  		VARCHAR(36)	Moneda.id
				, CuentaFondo_6.caja                          AS CuentaFondo_6_caja                     	-- 18	.CuentaFondo.caja                    		VARCHAR(36)	Caja.id
				, CuentaFondo_6.rechazados                    AS CuentaFondo_6_rechazados               	-- 19	.CuentaFondo.rechazados              		BOOLEAN
				, CuentaFondo_6.conciliacion                  AS CuentaFondo_6_conciliacion             	-- 20	.CuentaFondo.conciliacion            		BOOLEAN
				, CuentaFondo_6.cuentaFondoTipoBanco          AS CuentaFondo_6_cuentaFondoTipoBanco     	-- 21	.CuentaFondo.cuentaFondoTipoBanco    		VARCHAR(36)	CuentaFondoTipoBanco.id
				, CuentaFondo_6.banco                         AS CuentaFondo_6_banco                    	-- 22	.CuentaFondo.banco                   		VARCHAR(36)	Banco.id
				, CuentaFondo_6.cuentaBancaria                AS CuentaFondo_6_cuentaBancaria           	-- 23	.CuentaFondo.cuentaBancaria          		VARCHAR(22)
				, CuentaFondo_6.cbu                           AS CuentaFondo_6_cbu                      	-- 24	.CuentaFondo.cbu                     		VARCHAR(22)
				, CuentaFondo_6.limiteDescubierto             AS CuentaFondo_6_limiteDescubierto        	-- 25	.CuentaFondo.limiteDescubierto       		DECIMAL(13,5)
				, CuentaFondo_6.cuentaFondoCaucion            AS CuentaFondo_6_cuentaFondoCaucion       	-- 26	.CuentaFondo.cuentaFondoCaucion      		VARCHAR(50)
				, CuentaFondo_6.cuentaFondoDiferidos          AS CuentaFondo_6_cuentaFondoDiferidos     	-- 27	.CuentaFondo.cuentaFondoDiferidos    		VARCHAR(50)
				, CuentaFondo_6.formato                       AS CuentaFondo_6_formato                  	-- 28	.CuentaFondo.formato                 		VARCHAR(50)
				, CuentaFondo_6.cuentaFondoBancoCopia         AS CuentaFondo_6_cuentaFondoBancoCopia    	-- 29	.CuentaFondo.cuentaFondoBancoCopia   		VARCHAR(36)	CuentaFondoBancoCopia.id
				, CuentaFondo_6.limiteOperacionIndividual     AS CuentaFondo_6_limiteOperacionIndividual	-- 30	.CuentaFondo.limiteOperacionIndividual		DECIMAL(13,5)
				, CuentaFondo_6.seguridadPuertaUso            AS CuentaFondo_6_seguridadPuertaUso       	-- 31	.CuentaFondo.seguridadPuertaUso      		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondo_6.seguridadPuertaConsulta       AS CuentaFondo_6_seguridadPuertaConsulta  	-- 32	.CuentaFondo.seguridadPuertaConsulta 		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondo_6.seguridadPuertaLimite         AS CuentaFondo_6_seguridadPuertaLimite    	-- 33	.CuentaFondo.seguridadPuertaLimite   		VARCHAR(36)	SeguridadPuerta.id

		FROM	massoftware.ComprobanteFondoModeloItem
			LEFT JOIN massoftware.ComprobanteFondoModelo AS ComprobanteFondoModelo_3        ON ComprobanteFondoModeloItem.comprobanteFondoModelo = ComprobanteFondoModelo_3.id 	-- 3 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaFondo AS CuentaFondo_6                   ON ComprobanteFondoModeloItem.cuentaFondo = CuentaFondo_6.id 	-- 6 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND cuentaFondoArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(cuentaFondoArg7)) > 0 THEN
		cuentaFondoArg7 = REPLACE(cuentaFondoArg7, '''', '''''');
		cuentaFondoArg7 = LOWER(TRIM(cuentaFondoArg7));
		cuentaFondoArg7 = TRANSLATE(cuentaFondoArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(cuentaFondoArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(ComprobanteFondoModeloItem.cuentaFondo),
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

DROP FUNCTION IF EXISTS massoftware.f_ComprobanteFondoModeloItemById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ComprobanteFondoModeloItemById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_ComprobanteFondoModeloItem_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_ComprobanteFondoModeloItem_1 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_ComprobanteFondoModeloItem_1 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_ComprobanteFondoModeloItemById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_ComprobanteFondoModeloItem_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, cuentaFondoArg7   VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ComprobanteFondoModeloItem_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, cuentaFondoArg7   VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.t_ComprobanteFondoModeloItem_2 AS $$

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
				  ComprobanteFondoModeloItem.id               AS ComprobanteFondoModeloItem_id          	-- 0	.id                                            		VARCHAR(36)
				, ComprobanteFondoModeloItem.numero           AS ComprobanteFondoModeloItem_numero      	-- 1	.numero                                        		INTEGER
				, ComprobanteFondoModeloItem.debe             AS ComprobanteFondoModeloItem_debe        	-- 2	.debe                                          		BOOLEAN
				, ComprobanteFondoModelo_3.id                 AS ComprobanteFondoModelo_3_id            	-- 3	.ComprobanteFondoModelo.id                     		VARCHAR(36)
				, ComprobanteFondoModelo_3.numero             AS ComprobanteFondoModelo_3_numero        	-- 4	.ComprobanteFondoModelo.numero                 		INTEGER
				, ComprobanteFondoModelo_3.nombre             AS ComprobanteFondoModelo_3_nombre        	-- 5	.ComprobanteFondoModelo.nombre                 		VARCHAR(50)
				, CuentaFondo_6.id                            AS CuentaFondo_6_id                       	-- 6	.CuentaFondo.id                                		VARCHAR(36)
				, CuentaFondo_6.numero                        AS CuentaFondo_6_numero                   	-- 7	.CuentaFondo.numero                            		INTEGER
				, CuentaFondo_6.nombre                        AS CuentaFondo_6_nombre                   	-- 8	.CuentaFondo.nombre                            		VARCHAR(50)
				, CuentaContable_9.id                         AS CuentaContable_9_id                    	-- 9	.CuentaFondo.CuentaContable.id                 		VARCHAR(36)
				, CuentaContable_9.codigo                     AS CuentaContable_9_codigo                	-- 10	.CuentaFondo.CuentaContable.codigo             		VARCHAR(11)
				, CuentaContable_9.nombre                     AS CuentaContable_9_nombre                	-- 11	.CuentaFondo.CuentaContable.nombre             		VARCHAR(50)
				, CuentaContable_9.ejercicioContable          AS CuentaContable_9_ejercicioContable     	-- 12	.CuentaFondo.CuentaContable.ejercicioContable  		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_9.integra                    AS CuentaContable_9_integra               	-- 13	.CuentaFondo.CuentaContable.integra            		VARCHAR(16)
				, CuentaContable_9.cuentaJerarquia            AS CuentaContable_9_cuentaJerarquia       	-- 14	.CuentaFondo.CuentaContable.cuentaJerarquia    		VARCHAR(16)
				, CuentaContable_9.imputable                  AS CuentaContable_9_imputable             	-- 15	.CuentaFondo.CuentaContable.imputable          		BOOLEAN
				, CuentaContable_9.ajustaPorInflacion         AS CuentaContable_9_ajustaPorInflacion    	-- 16	.CuentaFondo.CuentaContable.ajustaPorInflacion 		BOOLEAN
				, CuentaContable_9.cuentaContableEstado       AS CuentaContable_9_cuentaContableEstado  	-- 17	.CuentaFondo.CuentaContable.cuentaContableEstado		VARCHAR(36)	CuentaContableEstado.id
				, CuentaContable_9.cuentaConApropiacion       AS CuentaContable_9_cuentaConApropiacion  	-- 18	.CuentaFondo.CuentaContable.cuentaConApropiacion		BOOLEAN
				, CuentaContable_9.centroCostoContable        AS CuentaContable_9_centroCostoContable   	-- 19	.CuentaFondo.CuentaContable.centroCostoContable		VARCHAR(36)	CentroCostoContable.id
				, CuentaContable_9.cuentaAgrupadora           AS CuentaContable_9_cuentaAgrupadora      	-- 20	.CuentaFondo.CuentaContable.cuentaAgrupadora   		VARCHAR(50)
				, CuentaContable_9.porcentaje                 AS CuentaContable_9_porcentaje            	-- 21	.CuentaFondo.CuentaContable.porcentaje         		DECIMAL(6,3)
				, CuentaContable_9.puntoEquilibrio            AS CuentaContable_9_puntoEquilibrio       	-- 22	.CuentaFondo.CuentaContable.puntoEquilibrio    		VARCHAR(36)	PuntoEquilibrio.id
				, CuentaContable_9.costoVenta                 AS CuentaContable_9_costoVenta            	-- 23	.CuentaFondo.CuentaContable.costoVenta         		VARCHAR(36)	CostoVenta.id
				, CuentaContable_9.seguridadPuerta            AS CuentaContable_9_seguridadPuerta       	-- 24	.CuentaFondo.CuentaContable.seguridadPuerta    		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondoGrupo_25.id                      AS CuentaFondoGrupo_25_id                 	-- 25	.CuentaFondo.CuentaFondoGrupo.id               		VARCHAR(36)
				, CuentaFondoGrupo_25.numero                  AS CuentaFondoGrupo_25_numero             	-- 26	.CuentaFondo.CuentaFondoGrupo.numero           		INTEGER
				, CuentaFondoGrupo_25.nombre                  AS CuentaFondoGrupo_25_nombre             	-- 27	.CuentaFondo.CuentaFondoGrupo.nombre           		VARCHAR(50)
				, CuentaFondoGrupo_25.cuentaFondoRubro        AS CuentaFondoGrupo_25_cuentaFondoRubro   	-- 28	.CuentaFondo.CuentaFondoGrupo.cuentaFondoRubro 		VARCHAR(36)	CuentaFondoRubro.id
				, CuentaFondoTipo_29.id                       AS CuentaFondoTipo_29_id                  	-- 29	.CuentaFondo.CuentaFondoTipo.id                		VARCHAR(36)
				, CuentaFondoTipo_29.numero                   AS CuentaFondoTipo_29_numero              	-- 30	.CuentaFondo.CuentaFondoTipo.numero            		INTEGER
				, CuentaFondoTipo_29.nombre                   AS CuentaFondoTipo_29_nombre              	-- 31	.CuentaFondo.CuentaFondoTipo.nombre            		VARCHAR(50)
				, CuentaFondo_6.obsoleto                      AS CuentaFondo_6_obsoleto                 	-- 32	.CuentaFondo.obsoleto                          		BOOLEAN
				, CuentaFondo_6.noImprimeCaja                 AS CuentaFondo_6_noImprimeCaja            	-- 33	.CuentaFondo.noImprimeCaja                     		BOOLEAN
				, CuentaFondo_6.ventas                        AS CuentaFondo_6_ventas                   	-- 34	.CuentaFondo.ventas                            		BOOLEAN
				, CuentaFondo_6.fondos                        AS CuentaFondo_6_fondos                   	-- 35	.CuentaFondo.fondos                            		BOOLEAN
				, CuentaFondo_6.compras                       AS CuentaFondo_6_compras                  	-- 36	.CuentaFondo.compras                           		BOOLEAN
				, Moneda_37.id                                AS Moneda_37_id                           	-- 37	.CuentaFondo.Moneda.id                         		VARCHAR(36)
				, Moneda_37.numero                            AS Moneda_37_numero                       	-- 38	.CuentaFondo.Moneda.numero                     		INTEGER
				, Moneda_37.nombre                            AS Moneda_37_nombre                       	-- 39	.CuentaFondo.Moneda.nombre                     		VARCHAR(50)
				, Moneda_37.abreviatura                       AS Moneda_37_abreviatura                  	-- 40	.CuentaFondo.Moneda.abreviatura                		VARCHAR(5)
				, Moneda_37.cotizacion                        AS Moneda_37_cotizacion                   	-- 41	.CuentaFondo.Moneda.cotizacion                 		DECIMAL(13,5)
				, Moneda_37.cotizacionFecha                   AS Moneda_37_cotizacionFecha              	-- 42	.CuentaFondo.Moneda.cotizacionFecha            		TIMESTAMP
				, Moneda_37.controlActualizacion              AS Moneda_37_controlActualizacion         	-- 43	.CuentaFondo.Moneda.controlActualizacion       		BOOLEAN
				, Moneda_37.monedaAFIP                        AS Moneda_37_monedaAFIP                   	-- 44	.CuentaFondo.Moneda.monedaAFIP                 		VARCHAR(36)	MonedaAFIP.id
				, Caja_45.id                                  AS Caja_45_id                             	-- 45	.CuentaFondo.Caja.id                           		VARCHAR(36)
				, Caja_45.numero                              AS Caja_45_numero                         	-- 46	.CuentaFondo.Caja.numero                       		INTEGER
				, Caja_45.nombre                              AS Caja_45_nombre                         	-- 47	.CuentaFondo.Caja.nombre                       		VARCHAR(50)
				, Caja_45.seguridadPuerta                     AS Caja_45_seguridadPuerta                	-- 48	.CuentaFondo.Caja.seguridadPuerta              		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondo_6.rechazados                    AS CuentaFondo_6_rechazados               	-- 49	.CuentaFondo.rechazados                        		BOOLEAN
				, CuentaFondo_6.conciliacion                  AS CuentaFondo_6_conciliacion             	-- 50	.CuentaFondo.conciliacion                      		BOOLEAN
				, CuentaFondoTipoBanco_51.id                  AS CuentaFondoTipoBanco_51_id             	-- 51	.CuentaFondo.CuentaFondoTipoBanco.id           		VARCHAR(36)
				, CuentaFondoTipoBanco_51.numero              AS CuentaFondoTipoBanco_51_numero         	-- 52	.CuentaFondo.CuentaFondoTipoBanco.numero       		INTEGER
				, CuentaFondoTipoBanco_51.nombre              AS CuentaFondoTipoBanco_51_nombre         	-- 53	.CuentaFondo.CuentaFondoTipoBanco.nombre       		VARCHAR(50)
				, Banco_54.id                                 AS Banco_54_id                            	-- 54	.CuentaFondo.Banco.id                          		VARCHAR(36)
				, Banco_54.numero                             AS Banco_54_numero                        	-- 55	.CuentaFondo.Banco.numero                      		INTEGER
				, Banco_54.nombre                             AS Banco_54_nombre                        	-- 56	.CuentaFondo.Banco.nombre                      		VARCHAR(50)
				, Banco_54.cuit                               AS Banco_54_cuit                          	-- 57	.CuentaFondo.Banco.cuit                        		BIGINT
				, Banco_54.bloqueado                          AS Banco_54_bloqueado                     	-- 58	.CuentaFondo.Banco.bloqueado                   		BOOLEAN
				, Banco_54.hoja                               AS Banco_54_hoja                          	-- 59	.CuentaFondo.Banco.hoja                        		INTEGER
				, Banco_54.primeraFila                        AS Banco_54_primeraFila                   	-- 60	.CuentaFondo.Banco.primeraFila                 		INTEGER
				, Banco_54.ultimaFila                         AS Banco_54_ultimaFila                    	-- 61	.CuentaFondo.Banco.ultimaFila                  		INTEGER
				, Banco_54.fecha                              AS Banco_54_fecha                         	-- 62	.CuentaFondo.Banco.fecha                       		VARCHAR(3)
				, Banco_54.descripcion                        AS Banco_54_descripcion                   	-- 63	.CuentaFondo.Banco.descripcion                 		VARCHAR(3)
				, Banco_54.referencia1                        AS Banco_54_referencia1                   	-- 64	.CuentaFondo.Banco.referencia1                 		VARCHAR(3)
				, Banco_54.importe                            AS Banco_54_importe                       	-- 65	.CuentaFondo.Banco.importe                     		VARCHAR(3)
				, Banco_54.referencia2                        AS Banco_54_referencia2                   	-- 66	.CuentaFondo.Banco.referencia2                 		VARCHAR(3)
				, Banco_54.saldo                              AS Banco_54_saldo                         	-- 67	.CuentaFondo.Banco.saldo                       		VARCHAR(3)
				, CuentaFondo_6.cuentaBancaria                AS CuentaFondo_6_cuentaBancaria           	-- 68	.CuentaFondo.cuentaBancaria                    		VARCHAR(22)
				, CuentaFondo_6.cbu                           AS CuentaFondo_6_cbu                      	-- 69	.CuentaFondo.cbu                               		VARCHAR(22)
				, CuentaFondo_6.limiteDescubierto             AS CuentaFondo_6_limiteDescubierto        	-- 70	.CuentaFondo.limiteDescubierto                 		DECIMAL(13,5)
				, CuentaFondo_6.cuentaFondoCaucion            AS CuentaFondo_6_cuentaFondoCaucion       	-- 71	.CuentaFondo.cuentaFondoCaucion                		VARCHAR(50)
				, CuentaFondo_6.cuentaFondoDiferidos          AS CuentaFondo_6_cuentaFondoDiferidos     	-- 72	.CuentaFondo.cuentaFondoDiferidos              		VARCHAR(50)
				, CuentaFondo_6.formato                       AS CuentaFondo_6_formato                  	-- 73	.CuentaFondo.formato                           		VARCHAR(50)
				, CuentaFondoBancoCopia_74.id                 AS CuentaFondoBancoCopia_74_id            	-- 74	.CuentaFondo.CuentaFondoBancoCopia.id          		VARCHAR(36)
				, CuentaFondoBancoCopia_74.numero             AS CuentaFondoBancoCopia_74_numero        	-- 75	.CuentaFondo.CuentaFondoBancoCopia.numero      		INTEGER
				, CuentaFondoBancoCopia_74.nombre             AS CuentaFondoBancoCopia_74_nombre        	-- 76	.CuentaFondo.CuentaFondoBancoCopia.nombre      		VARCHAR(50)
				, CuentaFondo_6.limiteOperacionIndividual     AS CuentaFondo_6_limiteOperacionIndividual	-- 77	.CuentaFondo.limiteOperacionIndividual         		DECIMAL(13,5)
				, SeguridadPuerta_78.id                       AS SeguridadPuerta_78_id                  	-- 78	.CuentaFondo.SeguridadPuerta.id                		VARCHAR(36)
				, SeguridadPuerta_78.numero                   AS SeguridadPuerta_78_numero              	-- 79	.CuentaFondo.SeguridadPuerta.numero            		INTEGER
				, SeguridadPuerta_78.nombre                   AS SeguridadPuerta_78_nombre              	-- 80	.CuentaFondo.SeguridadPuerta.nombre            		VARCHAR(50)
				, SeguridadPuerta_78.equate                   AS SeguridadPuerta_78_equate              	-- 81	.CuentaFondo.SeguridadPuerta.equate            		VARCHAR(30)
				, SeguridadPuerta_78.seguridadModulo          AS SeguridadPuerta_78_seguridadModulo     	-- 82	.CuentaFondo.SeguridadPuerta.seguridadModulo   		VARCHAR(36)	SeguridadModulo.id
				, SeguridadPuerta_83.id                       AS SeguridadPuerta_83_id                  	-- 83	.CuentaFondo.SeguridadPuerta.id                		VARCHAR(36)
				, SeguridadPuerta_83.numero                   AS SeguridadPuerta_83_numero              	-- 84	.CuentaFondo.SeguridadPuerta.numero            		INTEGER
				, SeguridadPuerta_83.nombre                   AS SeguridadPuerta_83_nombre              	-- 85	.CuentaFondo.SeguridadPuerta.nombre            		VARCHAR(50)
				, SeguridadPuerta_83.equate                   AS SeguridadPuerta_83_equate              	-- 86	.CuentaFondo.SeguridadPuerta.equate            		VARCHAR(30)
				, SeguridadPuerta_83.seguridadModulo          AS SeguridadPuerta_83_seguridadModulo     	-- 87	.CuentaFondo.SeguridadPuerta.seguridadModulo   		VARCHAR(36)	SeguridadModulo.id
				, SeguridadPuerta_88.id                       AS SeguridadPuerta_88_id                  	-- 88	.CuentaFondo.SeguridadPuerta.id                		VARCHAR(36)
				, SeguridadPuerta_88.numero                   AS SeguridadPuerta_88_numero              	-- 89	.CuentaFondo.SeguridadPuerta.numero            		INTEGER
				, SeguridadPuerta_88.nombre                   AS SeguridadPuerta_88_nombre              	-- 90	.CuentaFondo.SeguridadPuerta.nombre            		VARCHAR(50)
				, SeguridadPuerta_88.equate                   AS SeguridadPuerta_88_equate              	-- 91	.CuentaFondo.SeguridadPuerta.equate            		VARCHAR(30)
				, SeguridadPuerta_88.seguridadModulo          AS SeguridadPuerta_88_seguridadModulo     	-- 92	.CuentaFondo.SeguridadPuerta.seguridadModulo   		VARCHAR(36)	SeguridadModulo.id

		FROM	massoftware.ComprobanteFondoModeloItem
			LEFT JOIN massoftware.ComprobanteFondoModelo AS ComprobanteFondoModelo_3           ON ComprobanteFondoModeloItem.comprobanteFondoModelo = ComprobanteFondoModelo_3.id 	-- 3 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaFondo AS CuentaFondo_6                      ON ComprobanteFondoModeloItem.cuentaFondo = CuentaFondo_6.id 	-- 6 LEFT LEVEL: 1
				LEFT JOIN massoftware.CuentaContable AS CuentaContable_9                  ON CuentaFondo_6.cuentaContable = CuentaContable_9.id 	-- 9 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaFondoGrupo AS CuentaFondoGrupo_25                ON CuentaFondo_6.cuentaFondoGrupo = CuentaFondoGrupo_25.id 	-- 25 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaFondoTipo AS CuentaFondoTipo_29                 ON CuentaFondo_6.cuentaFondoTipo = CuentaFondoTipo_29.id 	-- 29 LEFT LEVEL: 2
				LEFT JOIN massoftware.Moneda AS Moneda_37                          ON CuentaFondo_6.moneda = Moneda_37.id 	-- 37 LEFT LEVEL: 2
				LEFT JOIN massoftware.Caja AS Caja_45                            ON CuentaFondo_6.caja = Caja_45.id 	-- 45 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaFondoTipoBanco AS CuentaFondoTipoBanco_51            ON CuentaFondo_6.cuentaFondoTipoBanco = CuentaFondoTipoBanco_51.id 	-- 51 LEFT LEVEL: 2
				LEFT JOIN massoftware.Banco AS Banco_54                           ON CuentaFondo_6.banco = Banco_54.id 	-- 54 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaFondoBancoCopia AS CuentaFondoBancoCopia_74           ON CuentaFondo_6.cuentaFondoBancoCopia = CuentaFondoBancoCopia_74.id 	-- 74 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_78                 ON CuentaFondo_6.seguridadPuertaUso = SeguridadPuerta_78.id 	-- 78 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_83                 ON CuentaFondo_6.seguridadPuertaConsulta = SeguridadPuerta_83.id 	-- 83 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_88                 ON CuentaFondo_6.seguridadPuertaLimite = SeguridadPuerta_88.id 	-- 88 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND cuentaFondoArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(cuentaFondoArg7)) > 0 THEN
		cuentaFondoArg7 = REPLACE(cuentaFondoArg7, '''', '''''');
		cuentaFondoArg7 = LOWER(TRIM(cuentaFondoArg7));
		cuentaFondoArg7 = TRANSLATE(cuentaFondoArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(cuentaFondoArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(ComprobanteFondoModeloItem.cuentaFondo),
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

DROP FUNCTION IF EXISTS massoftware.f_ComprobanteFondoModeloItemById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ComprobanteFondoModeloItemById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_ComprobanteFondoModeloItem_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_ComprobanteFondoModeloItem_2 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_ComprobanteFondoModeloItem_2 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_ComprobanteFondoModeloItemById_2 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_ComprobanteFondoModeloItem_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, cuentaFondoArg7   VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ComprobanteFondoModeloItem_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, cuentaFondoArg7   VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.t_ComprobanteFondoModeloItem_3 AS $$

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
				  ComprobanteFondoModeloItem.id                AS ComprobanteFondoModeloItem_id           	-- 0	.id                                                             		VARCHAR(36)
				, ComprobanteFondoModeloItem.numero            AS ComprobanteFondoModeloItem_numero       	-- 1	.numero                                                         		INTEGER
				, ComprobanteFondoModeloItem.debe              AS ComprobanteFondoModeloItem_debe         	-- 2	.debe                                                           		BOOLEAN
				, ComprobanteFondoModelo_3.id                  AS ComprobanteFondoModelo_3_id             	-- 3	.ComprobanteFondoModelo.id                                      		VARCHAR(36)
				, ComprobanteFondoModelo_3.numero              AS ComprobanteFondoModelo_3_numero         	-- 4	.ComprobanteFondoModelo.numero                                  		INTEGER
				, ComprobanteFondoModelo_3.nombre              AS ComprobanteFondoModelo_3_nombre         	-- 5	.ComprobanteFondoModelo.nombre                                  		VARCHAR(50)
				, CuentaFondo_6.id                             AS CuentaFondo_6_id                        	-- 6	.CuentaFondo.id                                                 		VARCHAR(36)
				, CuentaFondo_6.numero                         AS CuentaFondo_6_numero                    	-- 7	.CuentaFondo.numero                                             		INTEGER
				, CuentaFondo_6.nombre                         AS CuentaFondo_6_nombre                    	-- 8	.CuentaFondo.nombre                                             		VARCHAR(50)
				, CuentaContable_9.id                          AS CuentaContable_9_id                     	-- 9	.CuentaFondo.CuentaContable.id                                  		VARCHAR(36)
				, CuentaContable_9.codigo                      AS CuentaContable_9_codigo                 	-- 10	.CuentaFondo.CuentaContable.codigo                              		VARCHAR(11)
				, CuentaContable_9.nombre                      AS CuentaContable_9_nombre                 	-- 11	.CuentaFondo.CuentaContable.nombre                              		VARCHAR(50)
				, EjercicioContable_12.id                      AS EjercicioContable_12_id                 	-- 12	.CuentaFondo.CuentaContable.EjercicioContable.id                		VARCHAR(36)
				, EjercicioContable_12.numero                  AS EjercicioContable_12_numero             	-- 13	.CuentaFondo.CuentaContable.EjercicioContable.numero            		INTEGER
				, EjercicioContable_12.apertura                AS EjercicioContable_12_apertura           	-- 14	.CuentaFondo.CuentaContable.EjercicioContable.apertura          		DATE
				, EjercicioContable_12.cierre                  AS EjercicioContable_12_cierre             	-- 15	.CuentaFondo.CuentaContable.EjercicioContable.cierre            		DATE
				, EjercicioContable_12.cerrado                 AS EjercicioContable_12_cerrado            	-- 16	.CuentaFondo.CuentaContable.EjercicioContable.cerrado           		BOOLEAN
				, EjercicioContable_12.cerradoModulos          AS EjercicioContable_12_cerradoModulos     	-- 17	.CuentaFondo.CuentaContable.EjercicioContable.cerradoModulos    		BOOLEAN
				, EjercicioContable_12.comentario              AS EjercicioContable_12_comentario         	-- 18	.CuentaFondo.CuentaContable.EjercicioContable.comentario        		VARCHAR(250)
				, CuentaContable_9.integra                     AS CuentaContable_9_integra                	-- 19	.CuentaFondo.CuentaContable.integra                             		VARCHAR(16)
				, CuentaContable_9.cuentaJerarquia             AS CuentaContable_9_cuentaJerarquia        	-- 20	.CuentaFondo.CuentaContable.cuentaJerarquia                     		VARCHAR(16)
				, CuentaContable_9.imputable                   AS CuentaContable_9_imputable              	-- 21	.CuentaFondo.CuentaContable.imputable                           		BOOLEAN
				, CuentaContable_9.ajustaPorInflacion          AS CuentaContable_9_ajustaPorInflacion     	-- 22	.CuentaFondo.CuentaContable.ajustaPorInflacion                  		BOOLEAN
				, CuentaContableEstado_23.id                   AS CuentaContableEstado_23_id              	-- 23	.CuentaFondo.CuentaContable.CuentaContableEstado.id             		VARCHAR(36)
				, CuentaContableEstado_23.numero               AS CuentaContableEstado_23_numero          	-- 24	.CuentaFondo.CuentaContable.CuentaContableEstado.numero         		INTEGER
				, CuentaContableEstado_23.nombre               AS CuentaContableEstado_23_nombre          	-- 25	.CuentaFondo.CuentaContable.CuentaContableEstado.nombre         		VARCHAR(50)
				, CuentaContable_9.cuentaConApropiacion        AS CuentaContable_9_cuentaConApropiacion   	-- 26	.CuentaFondo.CuentaContable.cuentaConApropiacion                		BOOLEAN
				, CentroCostoContable_27.id                    AS CentroCostoContable_27_id               	-- 27	.CuentaFondo.CuentaContable.CentroCostoContable.id              		VARCHAR(36)
				, CentroCostoContable_27.numero                AS CentroCostoContable_27_numero           	-- 28	.CuentaFondo.CuentaContable.CentroCostoContable.numero          		INTEGER
				, CentroCostoContable_27.nombre                AS CentroCostoContable_27_nombre           	-- 29	.CuentaFondo.CuentaContable.CentroCostoContable.nombre          		VARCHAR(50)
				, CentroCostoContable_27.abreviatura           AS CentroCostoContable_27_abreviatura      	-- 30	.CuentaFondo.CuentaContable.CentroCostoContable.abreviatura     		VARCHAR(5)
				, CentroCostoContable_27.ejercicioContable     AS CentroCostoContable_27_ejercicioContable	-- 31	.CuentaFondo.CuentaContable.CentroCostoContable.ejercicioContable		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_9.cuentaAgrupadora            AS CuentaContable_9_cuentaAgrupadora       	-- 32	.CuentaFondo.CuentaContable.cuentaAgrupadora                    		VARCHAR(50)
				, CuentaContable_9.porcentaje                  AS CuentaContable_9_porcentaje             	-- 33	.CuentaFondo.CuentaContable.porcentaje                          		DECIMAL(6,3)
				, PuntoEquilibrio_34.id                        AS PuntoEquilibrio_34_id                   	-- 34	.CuentaFondo.CuentaContable.PuntoEquilibrio.id                  		VARCHAR(36)
				, PuntoEquilibrio_34.numero                    AS PuntoEquilibrio_34_numero               	-- 35	.CuentaFondo.CuentaContable.PuntoEquilibrio.numero              		INTEGER
				, PuntoEquilibrio_34.nombre                    AS PuntoEquilibrio_34_nombre               	-- 36	.CuentaFondo.CuentaContable.PuntoEquilibrio.nombre              		VARCHAR(50)
				, PuntoEquilibrio_34.tipoPuntoEquilibrio       AS PuntoEquilibrio_34_tipoPuntoEquilibrio  	-- 37	.CuentaFondo.CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio 		VARCHAR(36)	TipoPuntoEquilibrio.id
				, PuntoEquilibrio_34.ejercicioContable         AS PuntoEquilibrio_34_ejercicioContable    	-- 38	.CuentaFondo.CuentaContable.PuntoEquilibrio.ejercicioContable   		VARCHAR(36)	EjercicioContable.id
				, CostoVenta_39.id                             AS CostoVenta_39_id                        	-- 39	.CuentaFondo.CuentaContable.CostoVenta.id                       		VARCHAR(36)
				, CostoVenta_39.numero                         AS CostoVenta_39_numero                    	-- 40	.CuentaFondo.CuentaContable.CostoVenta.numero                   		INTEGER
				, CostoVenta_39.nombre                         AS CostoVenta_39_nombre                    	-- 41	.CuentaFondo.CuentaContable.CostoVenta.nombre                   		VARCHAR(50)
				, SeguridadPuerta_42.id                        AS SeguridadPuerta_42_id                   	-- 42	.CuentaFondo.CuentaContable.SeguridadPuerta.id                  		VARCHAR(36)
				, SeguridadPuerta_42.numero                    AS SeguridadPuerta_42_numero               	-- 43	.CuentaFondo.CuentaContable.SeguridadPuerta.numero              		INTEGER
				, SeguridadPuerta_42.nombre                    AS SeguridadPuerta_42_nombre               	-- 44	.CuentaFondo.CuentaContable.SeguridadPuerta.nombre              		VARCHAR(50)
				, SeguridadPuerta_42.equate                    AS SeguridadPuerta_42_equate               	-- 45	.CuentaFondo.CuentaContable.SeguridadPuerta.equate              		VARCHAR(30)
				, SeguridadPuerta_42.seguridadModulo           AS SeguridadPuerta_42_seguridadModulo      	-- 46	.CuentaFondo.CuentaContable.SeguridadPuerta.seguridadModulo     		VARCHAR(36)	SeguridadModulo.id
				, CuentaFondoGrupo_47.id                       AS CuentaFondoGrupo_47_id                  	-- 47	.CuentaFondo.CuentaFondoGrupo.id                                		VARCHAR(36)
				, CuentaFondoGrupo_47.numero                   AS CuentaFondoGrupo_47_numero              	-- 48	.CuentaFondo.CuentaFondoGrupo.numero                            		INTEGER
				, CuentaFondoGrupo_47.nombre                   AS CuentaFondoGrupo_47_nombre              	-- 49	.CuentaFondo.CuentaFondoGrupo.nombre                            		VARCHAR(50)
				, CuentaFondoRubro_50.id                       AS CuentaFondoRubro_50_id                  	-- 50	.CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.id               		VARCHAR(36)
				, CuentaFondoRubro_50.numero                   AS CuentaFondoRubro_50_numero              	-- 51	.CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.numero           		INTEGER
				, CuentaFondoRubro_50.nombre                   AS CuentaFondoRubro_50_nombre              	-- 52	.CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.nombre           		VARCHAR(50)
				, CuentaFondoTipo_53.id                        AS CuentaFondoTipo_53_id                   	-- 53	.CuentaFondo.CuentaFondoTipo.id                                 		VARCHAR(36)
				, CuentaFondoTipo_53.numero                    AS CuentaFondoTipo_53_numero               	-- 54	.CuentaFondo.CuentaFondoTipo.numero                             		INTEGER
				, CuentaFondoTipo_53.nombre                    AS CuentaFondoTipo_53_nombre               	-- 55	.CuentaFondo.CuentaFondoTipo.nombre                             		VARCHAR(50)
				, CuentaFondo_6.obsoleto                       AS CuentaFondo_6_obsoleto                  	-- 56	.CuentaFondo.obsoleto                                           		BOOLEAN
				, CuentaFondo_6.noImprimeCaja                  AS CuentaFondo_6_noImprimeCaja             	-- 57	.CuentaFondo.noImprimeCaja                                      		BOOLEAN
				, CuentaFondo_6.ventas                         AS CuentaFondo_6_ventas                    	-- 58	.CuentaFondo.ventas                                             		BOOLEAN
				, CuentaFondo_6.fondos                         AS CuentaFondo_6_fondos                    	-- 59	.CuentaFondo.fondos                                             		BOOLEAN
				, CuentaFondo_6.compras                        AS CuentaFondo_6_compras                   	-- 60	.CuentaFondo.compras                                            		BOOLEAN
				, Moneda_61.id                                 AS Moneda_61_id                            	-- 61	.CuentaFondo.Moneda.id                                          		VARCHAR(36)
				, Moneda_61.numero                             AS Moneda_61_numero                        	-- 62	.CuentaFondo.Moneda.numero                                      		INTEGER
				, Moneda_61.nombre                             AS Moneda_61_nombre                        	-- 63	.CuentaFondo.Moneda.nombre                                      		VARCHAR(50)
				, Moneda_61.abreviatura                        AS Moneda_61_abreviatura                   	-- 64	.CuentaFondo.Moneda.abreviatura                                 		VARCHAR(5)
				, Moneda_61.cotizacion                         AS Moneda_61_cotizacion                    	-- 65	.CuentaFondo.Moneda.cotizacion                                  		DECIMAL(13,5)
				, Moneda_61.cotizacionFecha                    AS Moneda_61_cotizacionFecha               	-- 66	.CuentaFondo.Moneda.cotizacionFecha                             		TIMESTAMP
				, Moneda_61.controlActualizacion               AS Moneda_61_controlActualizacion          	-- 67	.CuentaFondo.Moneda.controlActualizacion                        		BOOLEAN
				, MonedaAFIP_68.id                             AS MonedaAFIP_68_id                        	-- 68	.CuentaFondo.Moneda.MonedaAFIP.id                               		VARCHAR(36)
				, MonedaAFIP_68.codigo                         AS MonedaAFIP_68_codigo                    	-- 69	.CuentaFondo.Moneda.MonedaAFIP.codigo                           		VARCHAR(3)
				, MonedaAFIP_68.nombre                         AS MonedaAFIP_68_nombre                    	-- 70	.CuentaFondo.Moneda.MonedaAFIP.nombre                           		VARCHAR(50)
				, Caja_71.id                                   AS Caja_71_id                              	-- 71	.CuentaFondo.Caja.id                                            		VARCHAR(36)
				, Caja_71.numero                               AS Caja_71_numero                          	-- 72	.CuentaFondo.Caja.numero                                        		INTEGER
				, Caja_71.nombre                               AS Caja_71_nombre                          	-- 73	.CuentaFondo.Caja.nombre                                        		VARCHAR(50)
				, SeguridadPuerta_74.id                        AS SeguridadPuerta_74_id                   	-- 74	.CuentaFondo.Caja.SeguridadPuerta.id                            		VARCHAR(36)
				, SeguridadPuerta_74.numero                    AS SeguridadPuerta_74_numero               	-- 75	.CuentaFondo.Caja.SeguridadPuerta.numero                        		INTEGER
				, SeguridadPuerta_74.nombre                    AS SeguridadPuerta_74_nombre               	-- 76	.CuentaFondo.Caja.SeguridadPuerta.nombre                        		VARCHAR(50)
				, SeguridadPuerta_74.equate                    AS SeguridadPuerta_74_equate               	-- 77	.CuentaFondo.Caja.SeguridadPuerta.equate                        		VARCHAR(30)
				, SeguridadPuerta_74.seguridadModulo           AS SeguridadPuerta_74_seguridadModulo      	-- 78	.CuentaFondo.Caja.SeguridadPuerta.seguridadModulo               		VARCHAR(36)	SeguridadModulo.id
				, CuentaFondo_6.rechazados                     AS CuentaFondo_6_rechazados                	-- 79	.CuentaFondo.rechazados                                         		BOOLEAN
				, CuentaFondo_6.conciliacion                   AS CuentaFondo_6_conciliacion              	-- 80	.CuentaFondo.conciliacion                                       		BOOLEAN
				, CuentaFondoTipoBanco_81.id                   AS CuentaFondoTipoBanco_81_id              	-- 81	.CuentaFondo.CuentaFondoTipoBanco.id                            		VARCHAR(36)
				, CuentaFondoTipoBanco_81.numero               AS CuentaFondoTipoBanco_81_numero          	-- 82	.CuentaFondo.CuentaFondoTipoBanco.numero                        		INTEGER
				, CuentaFondoTipoBanco_81.nombre               AS CuentaFondoTipoBanco_81_nombre          	-- 83	.CuentaFondo.CuentaFondoTipoBanco.nombre                        		VARCHAR(50)
				, Banco_84.id                                  AS Banco_84_id                             	-- 84	.CuentaFondo.Banco.id                                           		VARCHAR(36)
				, Banco_84.numero                              AS Banco_84_numero                         	-- 85	.CuentaFondo.Banco.numero                                       		INTEGER
				, Banco_84.nombre                              AS Banco_84_nombre                         	-- 86	.CuentaFondo.Banco.nombre                                       		VARCHAR(50)
				, Banco_84.cuit                                AS Banco_84_cuit                           	-- 87	.CuentaFondo.Banco.cuit                                         		BIGINT
				, Banco_84.bloqueado                           AS Banco_84_bloqueado                      	-- 88	.CuentaFondo.Banco.bloqueado                                    		BOOLEAN
				, Banco_84.hoja                                AS Banco_84_hoja                           	-- 89	.CuentaFondo.Banco.hoja                                         		INTEGER
				, Banco_84.primeraFila                         AS Banco_84_primeraFila                    	-- 90	.CuentaFondo.Banco.primeraFila                                  		INTEGER
				, Banco_84.ultimaFila                          AS Banco_84_ultimaFila                     	-- 91	.CuentaFondo.Banco.ultimaFila                                   		INTEGER
				, Banco_84.fecha                               AS Banco_84_fecha                          	-- 92	.CuentaFondo.Banco.fecha                                        		VARCHAR(3)
				, Banco_84.descripcion                         AS Banco_84_descripcion                    	-- 93	.CuentaFondo.Banco.descripcion                                  		VARCHAR(3)
				, Banco_84.referencia1                         AS Banco_84_referencia1                    	-- 94	.CuentaFondo.Banco.referencia1                                  		VARCHAR(3)
				, Banco_84.importe                             AS Banco_84_importe                        	-- 95	.CuentaFondo.Banco.importe                                      		VARCHAR(3)
				, Banco_84.referencia2                         AS Banco_84_referencia2                    	-- 96	.CuentaFondo.Banco.referencia2                                  		VARCHAR(3)
				, Banco_84.saldo                               AS Banco_84_saldo                          	-- 97	.CuentaFondo.Banco.saldo                                        		VARCHAR(3)
				, CuentaFondo_6.cuentaBancaria                 AS CuentaFondo_6_cuentaBancaria            	-- 98	.CuentaFondo.cuentaBancaria                                     		VARCHAR(22)
				, CuentaFondo_6.cbu                            AS CuentaFondo_6_cbu                       	-- 99	.CuentaFondo.cbu                                                		VARCHAR(22)
				, CuentaFondo_6.limiteDescubierto              AS CuentaFondo_6_limiteDescubierto         	-- 100	.CuentaFondo.limiteDescubierto                                  		DECIMAL(13,5)
				, CuentaFondo_6.cuentaFondoCaucion             AS CuentaFondo_6_cuentaFondoCaucion        	-- 101	.CuentaFondo.cuentaFondoCaucion                                 		VARCHAR(50)
				, CuentaFondo_6.cuentaFondoDiferidos           AS CuentaFondo_6_cuentaFondoDiferidos      	-- 102	.CuentaFondo.cuentaFondoDiferidos                               		VARCHAR(50)
				, CuentaFondo_6.formato                        AS CuentaFondo_6_formato                   	-- 103	.CuentaFondo.formato                                            		VARCHAR(50)
				, CuentaFondoBancoCopia_104.id                 AS CuentaFondoBancoCopia_104_id            	-- 104	.CuentaFondo.CuentaFondoBancoCopia.id                           		VARCHAR(36)
				, CuentaFondoBancoCopia_104.numero             AS CuentaFondoBancoCopia_104_numero        	-- 105	.CuentaFondo.CuentaFondoBancoCopia.numero                       		INTEGER
				, CuentaFondoBancoCopia_104.nombre             AS CuentaFondoBancoCopia_104_nombre        	-- 106	.CuentaFondo.CuentaFondoBancoCopia.nombre                       		VARCHAR(50)
				, CuentaFondo_6.limiteOperacionIndividual      AS CuentaFondo_6_limiteOperacionIndividual 	-- 107	.CuentaFondo.limiteOperacionIndividual                          		DECIMAL(13,5)
				, SeguridadPuerta_108.id                       AS SeguridadPuerta_108_id                  	-- 108	.CuentaFondo.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_108.numero                   AS SeguridadPuerta_108_numero              	-- 109	.CuentaFondo.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_108.nombre                   AS SeguridadPuerta_108_nombre              	-- 110	.CuentaFondo.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_108.equate                   AS SeguridadPuerta_108_equate              	-- 111	.CuentaFondo.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_112.id                       AS SeguridadModulo_112_id                  	-- 112	.CuentaFondo.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_112.numero                   AS SeguridadModulo_112_numero              	-- 113	.CuentaFondo.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_112.nombre                   AS SeguridadModulo_112_nombre              	-- 114	.CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)
				, SeguridadPuerta_115.id                       AS SeguridadPuerta_115_id                  	-- 115	.CuentaFondo.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_115.numero                   AS SeguridadPuerta_115_numero              	-- 116	.CuentaFondo.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_115.nombre                   AS SeguridadPuerta_115_nombre              	-- 117	.CuentaFondo.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_115.equate                   AS SeguridadPuerta_115_equate              	-- 118	.CuentaFondo.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_119.id                       AS SeguridadModulo_119_id                  	-- 119	.CuentaFondo.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_119.numero                   AS SeguridadModulo_119_numero              	-- 120	.CuentaFondo.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_119.nombre                   AS SeguridadModulo_119_nombre              	-- 121	.CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)
				, SeguridadPuerta_122.id                       AS SeguridadPuerta_122_id                  	-- 122	.CuentaFondo.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_122.numero                   AS SeguridadPuerta_122_numero              	-- 123	.CuentaFondo.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_122.nombre                   AS SeguridadPuerta_122_nombre              	-- 124	.CuentaFondo.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_122.equate                   AS SeguridadPuerta_122_equate              	-- 125	.CuentaFondo.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_126.id                       AS SeguridadModulo_126_id                  	-- 126	.CuentaFondo.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_126.numero                   AS SeguridadModulo_126_numero              	-- 127	.CuentaFondo.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_126.nombre                   AS SeguridadModulo_126_nombre              	-- 128	.CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)

		FROM	massoftware.ComprobanteFondoModeloItem
			LEFT JOIN massoftware.ComprobanteFondoModelo AS ComprobanteFondoModelo_3             ON ComprobanteFondoModeloItem.comprobanteFondoModelo = ComprobanteFondoModelo_3.id 	-- 3 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaFondo AS CuentaFondo_6                        ON ComprobanteFondoModeloItem.cuentaFondo = CuentaFondo_6.id 	-- 6 LEFT LEVEL: 1
				LEFT JOIN massoftware.CuentaContable AS CuentaContable_9                    ON CuentaFondo_6.cuentaContable = CuentaContable_9.id 	-- 9 LEFT LEVEL: 2
					LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_12                ON CuentaContable_9.ejercicioContable = EjercicioContable_12.id 	-- 12 LEFT LEVEL: 3
					LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_23             ON CuentaContable_9.cuentaContableEstado = CuentaContableEstado_23.id 	-- 23 LEFT LEVEL: 3
					LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_27              ON CuentaContable_9.centroCostoContable = CentroCostoContable_27.id 	-- 27 LEFT LEVEL: 3
					LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_34                  ON CuentaContable_9.puntoEquilibrio = PuntoEquilibrio_34.id 	-- 34 LEFT LEVEL: 3
					LEFT JOIN massoftware.CostoVenta AS CostoVenta_39                       ON CuentaContable_9.costoVenta = CostoVenta_39.id 	-- 39 LEFT LEVEL: 3
					LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_42                  ON CuentaContable_9.seguridadPuerta = SeguridadPuerta_42.id 	-- 42 LEFT LEVEL: 3
				LEFT JOIN massoftware.CuentaFondoGrupo AS CuentaFondoGrupo_47                  ON CuentaFondo_6.cuentaFondoGrupo = CuentaFondoGrupo_47.id 	-- 47 LEFT LEVEL: 2
					LEFT JOIN massoftware.CuentaFondoRubro AS CuentaFondoRubro_50                 ON CuentaFondoGrupo_47.cuentaFondoRubro = CuentaFondoRubro_50.id 	-- 50 LEFT LEVEL: 3
				LEFT JOIN massoftware.CuentaFondoTipo AS CuentaFondoTipo_53                   ON CuentaFondo_6.cuentaFondoTipo = CuentaFondoTipo_53.id 	-- 53 LEFT LEVEL: 2
				LEFT JOIN massoftware.Moneda AS Moneda_61                            ON CuentaFondo_6.moneda = Moneda_61.id 	-- 61 LEFT LEVEL: 2
					LEFT JOIN massoftware.MonedaAFIP AS MonedaAFIP_68                       ON Moneda_61.monedaAFIP = MonedaAFIP_68.id 	-- 68 LEFT LEVEL: 3
				LEFT JOIN massoftware.Caja AS Caja_71                              ON CuentaFondo_6.caja = Caja_71.id 	-- 71 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_74                  ON Caja_71.seguridadPuerta = SeguridadPuerta_74.id 	-- 74 LEFT LEVEL: 3
				LEFT JOIN massoftware.CuentaFondoTipoBanco AS CuentaFondoTipoBanco_81              ON CuentaFondo_6.cuentaFondoTipoBanco = CuentaFondoTipoBanco_81.id 	-- 81 LEFT LEVEL: 2
				LEFT JOIN massoftware.Banco AS Banco_84                             ON CuentaFondo_6.banco = Banco_84.id 	-- 84 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaFondoBancoCopia AS CuentaFondoBancoCopia_104            ON CuentaFondo_6.cuentaFondoBancoCopia = CuentaFondoBancoCopia_104.id 	-- 104 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_108                  ON CuentaFondo_6.seguridadPuertaUso = SeguridadPuerta_108.id 	-- 108 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_112                  ON SeguridadPuerta_108.seguridadModulo = SeguridadModulo_112.id 	-- 112 LEFT LEVEL: 3
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_115                  ON CuentaFondo_6.seguridadPuertaConsulta = SeguridadPuerta_115.id 	-- 115 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_119                  ON SeguridadPuerta_115.seguridadModulo = SeguridadModulo_119.id 	-- 119 LEFT LEVEL: 3
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_122                  ON CuentaFondo_6.seguridadPuertaLimite = SeguridadPuerta_122.id 	-- 122 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_126                  ON SeguridadPuerta_122.seguridadModulo = SeguridadModulo_126.id 	-- 126 LEFT LEVEL: 3

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' ComprobanteFondoModeloItem.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND cuentaFondoArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(cuentaFondoArg7)) > 0 THEN
		cuentaFondoArg7 = REPLACE(cuentaFondoArg7, '''', '''''');
		cuentaFondoArg7 = LOWER(TRIM(cuentaFondoArg7));
		cuentaFondoArg7 = TRANSLATE(cuentaFondoArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(cuentaFondoArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(ComprobanteFondoModeloItem.cuentaFondo),
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

DROP FUNCTION IF EXISTS massoftware.f_ComprobanteFondoModeloItemById_3 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ComprobanteFondoModeloItemById_3 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_ComprobanteFondoModeloItem_3 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_ComprobanteFondoModeloItem_3 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_ComprobanteFondoModeloItem_3 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_ComprobanteFondoModeloItemById_3 ('xxx'); 