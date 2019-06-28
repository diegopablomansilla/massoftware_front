
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Chequera                                                                                               //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Chequera



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Chequera CASCADE;

CREATE TABLE massoftware.Chequera
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº chequera
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Chequera_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Cuenta fondo
	cuentaFondo VARCHAR(36)  NOT NULL  REFERENCES massoftware.CuentaFondo (id), 
	
	-- Primer número
	primerNumero INTEGER CONSTRAINT Chequera_primerNumero_chk CHECK ( primerNumero >= 0  ), 
	
	-- Último número
	ultimoNumero INTEGER CONSTRAINT Chequera_ultimoNumero_chk CHECK ( ultimoNumero >= 0  ), 
	
	-- Próximo número
	proximoNumero INTEGER CONSTRAINT Chequera_proximoNumero_chk CHECK ( proximoNumero >= 0  ), 
	
	-- Obsoleto
	bloqueado BOOLEAN NOT NULL, 
	
	-- Impresión diferida
	impresionDiferida BOOLEAN NOT NULL, 
	
	-- Formato
	formato VARCHAR(50)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Chequera_nombre ON massoftware.Chequera (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatChequera() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatChequera() RETURNS TRIGGER AS $formatChequera$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.cuentaFondo := massoftware.white_is_null(NEW.cuentaFondo);
	 NEW.formato := massoftware.white_is_null(NEW.formato);

	RETURN NEW;
END;
$formatChequera$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatChequera ON massoftware.Chequera CASCADE;

CREATE TRIGGER tgFormatChequera BEFORE INSERT OR UPDATE
	ON massoftware.Chequera FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatChequera();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Chequera;

-- SELECT * FROM massoftware.Chequera LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Chequera;

-- SELECT * FROM massoftware.Chequera WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Chequera_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Chequera_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Chequera
	WHERE	(numeroArg IS NULL OR Chequera.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Chequera_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_Chequera_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_Chequera_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.Chequera
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(Chequera.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_Chequera_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Chequera_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Chequera_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Chequera;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Chequera_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Chequera_primerNumero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Chequera_primerNumero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(primerNumero),0) + 1)::INTEGER FROM massoftware.Chequera;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Chequera_primerNumero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Chequera_ultimoNumero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Chequera_ultimoNumero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(ultimoNumero),0) + 1)::INTEGER FROM massoftware.Chequera;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Chequera_ultimoNumero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Chequera_proximoNumero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Chequera_proximoNumero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(proximoNumero),0) + 1)::INTEGER FROM massoftware.Chequera;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Chequera_proximoNumero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_ChequeraById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_ChequeraById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.Chequera WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Chequera.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.Chequera WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Chequera.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Chequera WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Chequera.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_ChequeraById('xxx');

-- SELECT * FROM massoftware.d_ChequeraById((SELECT Chequera.id FROM massoftware.Chequera LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Chequera(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaFondoArg VARCHAR(36)
		, primerNumeroArg INTEGER
		, ultimoNumeroArg INTEGER
		, proximoNumeroArg INTEGER
		, bloqueadoArg BOOLEAN
		, impresionDiferidaArg BOOLEAN
		, formatoArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Chequera(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaFondoArg VARCHAR(36)
		, primerNumeroArg INTEGER
		, ultimoNumeroArg INTEGER
		, proximoNumeroArg INTEGER
		, bloqueadoArg BOOLEAN
		, impresionDiferidaArg BOOLEAN
		, formatoArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF bloqueadoArg IS NULL THEN

		bloqueadoArg = false;

	END IF;

	IF impresionDiferidaArg IS NULL THEN

		impresionDiferidaArg = false;

	END IF;

	INSERT INTO massoftware.Chequera(id, numero, nombre, cuentaFondo, primerNumero, ultimoNumero, proximoNumero, bloqueado, impresionDiferida, formato) VALUES (idArg, numeroArg, nombreArg, cuentaFondoArg, primerNumeroArg, ultimoNumeroArg, proximoNumeroArg, bloqueadoArg, impresionDiferidaArg, formatoArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Chequera WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Chequera.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Chequera(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(50)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Chequera(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaFondoArg VARCHAR(36)
		, primerNumeroArg INTEGER
		, ultimoNumeroArg INTEGER
		, proximoNumeroArg INTEGER
		, bloqueadoArg BOOLEAN
		, impresionDiferidaArg BOOLEAN
		, formatoArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Chequera(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaFondoArg VARCHAR(36)
		, primerNumeroArg INTEGER
		, ultimoNumeroArg INTEGER
		, proximoNumeroArg INTEGER
		, bloqueadoArg BOOLEAN
		, impresionDiferidaArg BOOLEAN
		, formatoArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF bloqueadoArg IS NULL THEN

		bloqueadoArg = false;

	END IF;

	IF impresionDiferidaArg IS NULL THEN

		impresionDiferidaArg = false;

	END IF;

	UPDATE massoftware.Chequera SET 
		  numero = numeroArg
		, nombre = nombreArg
		, cuentaFondo = cuentaFondoArg
		, primerNumero = primerNumeroArg
		, ultimoNumero = ultimoNumeroArg
		, proximoNumero = proximoNumeroArg
		, bloqueado = bloqueadoArg
		, impresionDiferida = impresionDiferidaArg
		, formato = formatoArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Chequera.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Chequera WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Chequera.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Chequera(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(50)
);

*/

DROP TYPE IF EXISTS massoftware.t_Chequera_1 CASCADE;

CREATE TYPE massoftware.t_Chequera_1 AS (

	  Chequera_id                            	VARCHAR(36)  		-- 0	Chequera.id
	, Chequera_numero                        	INTEGER      		-- 1	Chequera.numero
	, Chequera_nombre                        	VARCHAR(50)  		-- 2	Chequera.nombre
	, CuentaFondo_3_id                       	VARCHAR(36)  		-- 3	Chequera.CuentaFondo.id
	, CuentaFondo_3_numero                   	INTEGER      		-- 4	Chequera.CuentaFondo.numero
	, CuentaFondo_3_nombre                   	VARCHAR(50)  		-- 5	Chequera.CuentaFondo.nombre
	, CuentaFondo_3_cuentaContable           	VARCHAR(36)  		-- 6	Chequera.CuentaFondo.cuentaContable
	, CuentaFondo_3_cuentaFondoGrupo         	VARCHAR(36)  		-- 7	Chequera.CuentaFondo.cuentaFondoGrupo
	, CuentaFondo_3_cuentaFondoTipo          	VARCHAR(36)  		-- 8	Chequera.CuentaFondo.cuentaFondoTipo
	, CuentaFondo_3_obsoleto                 	BOOLEAN      		-- 9	Chequera.CuentaFondo.obsoleto
	, CuentaFondo_3_noImprimeCaja            	BOOLEAN      		-- 10	Chequera.CuentaFondo.noImprimeCaja
	, CuentaFondo_3_ventas                   	BOOLEAN      		-- 11	Chequera.CuentaFondo.ventas
	, CuentaFondo_3_fondos                   	BOOLEAN      		-- 12	Chequera.CuentaFondo.fondos
	, CuentaFondo_3_compras                  	BOOLEAN      		-- 13	Chequera.CuentaFondo.compras
	, CuentaFondo_3_moneda                   	VARCHAR(36)  		-- 14	Chequera.CuentaFondo.moneda
	, CuentaFondo_3_caja                     	VARCHAR(36)  		-- 15	Chequera.CuentaFondo.caja
	, CuentaFondo_3_rechazados               	BOOLEAN      		-- 16	Chequera.CuentaFondo.rechazados
	, CuentaFondo_3_conciliacion             	BOOLEAN      		-- 17	Chequera.CuentaFondo.conciliacion
	, CuentaFondo_3_cuentaFondoTipoBanco     	VARCHAR(36)  		-- 18	Chequera.CuentaFondo.cuentaFondoTipoBanco
	, CuentaFondo_3_banco                    	VARCHAR(36)  		-- 19	Chequera.CuentaFondo.banco
	, CuentaFondo_3_cuentaBancaria           	VARCHAR(22)  		-- 20	Chequera.CuentaFondo.cuentaBancaria
	, CuentaFondo_3_cbu                      	VARCHAR(22)  		-- 21	Chequera.CuentaFondo.cbu
	, CuentaFondo_3_limiteDescubierto        	DECIMAL(13,5)		-- 22	Chequera.CuentaFondo.limiteDescubierto
	, CuentaFondo_3_cuentaFondoCaucion       	VARCHAR(50)  		-- 23	Chequera.CuentaFondo.cuentaFondoCaucion
	, CuentaFondo_3_cuentaFondoDiferidos     	VARCHAR(50)  		-- 24	Chequera.CuentaFondo.cuentaFondoDiferidos
	, CuentaFondo_3_formato                  	VARCHAR(50)  		-- 25	Chequera.CuentaFondo.formato
	, CuentaFondo_3_cuentaFondoBancoCopia    	VARCHAR(36)  		-- 26	Chequera.CuentaFondo.cuentaFondoBancoCopia
	, CuentaFondo_3_limiteOperacionIndividual	DECIMAL(13,5)		-- 27	Chequera.CuentaFondo.limiteOperacionIndividual
	, CuentaFondo_3_seguridadPuertaUso       	VARCHAR(36)  		-- 28	Chequera.CuentaFondo.seguridadPuertaUso
	, CuentaFondo_3_seguridadPuertaConsulta  	VARCHAR(36)  		-- 29	Chequera.CuentaFondo.seguridadPuertaConsulta
	, CuentaFondo_3_seguridadPuertaLimite    	VARCHAR(36)  		-- 30	Chequera.CuentaFondo.seguridadPuertaLimite
	, Chequera_primerNumero                  	INTEGER      		-- 31	Chequera.primerNumero
	, Chequera_ultimoNumero                  	INTEGER      		-- 32	Chequera.ultimoNumero
	, Chequera_proximoNumero                 	INTEGER      		-- 33	Chequera.proximoNumero
	, Chequera_bloqueado                     	BOOLEAN      		-- 34	Chequera.bloqueado
	, Chequera_impresionDiferida             	BOOLEAN      		-- 35	Chequera.impresionDiferida
	, Chequera_formato                       	VARCHAR(50)  		-- 36	Chequera.formato

);

DROP TYPE IF EXISTS massoftware.t_Chequera_2 CASCADE;

CREATE TYPE massoftware.t_Chequera_2 AS (

	  Chequera_id                            	VARCHAR(36)  		-- 0	Chequera.id
	, Chequera_numero                        	INTEGER      		-- 1	Chequera.numero
	, Chequera_nombre                        	VARCHAR(50)  		-- 2	Chequera.nombre
	, CuentaFondo_3_id                       	VARCHAR(36)  		-- 3	Chequera.CuentaFondo.id
	, CuentaFondo_3_numero                   	INTEGER      		-- 4	Chequera.CuentaFondo.numero
	, CuentaFondo_3_nombre                   	VARCHAR(50)  		-- 5	Chequera.CuentaFondo.nombre
	, CuentaContable_6_id                    	VARCHAR(36)  		-- 6	Chequera.CuentaFondo.CuentaContable.id
	, CuentaContable_6_codigo                	VARCHAR(11)  		-- 7	Chequera.CuentaFondo.CuentaContable.codigo
	, CuentaContable_6_nombre                	VARCHAR(50)  		-- 8	Chequera.CuentaFondo.CuentaContable.nombre
	, CuentaContable_6_ejercicioContable     	VARCHAR(36)  		-- 9	Chequera.CuentaFondo.CuentaContable.ejercicioContable
	, CuentaContable_6_integra               	VARCHAR(16)  		-- 10	Chequera.CuentaFondo.CuentaContable.integra
	, CuentaContable_6_cuentaJerarquia       	VARCHAR(16)  		-- 11	Chequera.CuentaFondo.CuentaContable.cuentaJerarquia
	, CuentaContable_6_imputable             	BOOLEAN      		-- 12	Chequera.CuentaFondo.CuentaContable.imputable
	, CuentaContable_6_ajustaPorInflacion    	BOOLEAN      		-- 13	Chequera.CuentaFondo.CuentaContable.ajustaPorInflacion
	, CuentaContable_6_cuentaContableEstado  	VARCHAR(36)  		-- 14	Chequera.CuentaFondo.CuentaContable.cuentaContableEstado
	, CuentaContable_6_cuentaConApropiacion  	BOOLEAN      		-- 15	Chequera.CuentaFondo.CuentaContable.cuentaConApropiacion
	, CuentaContable_6_centroCostoContable   	VARCHAR(36)  		-- 16	Chequera.CuentaFondo.CuentaContable.centroCostoContable
	, CuentaContable_6_cuentaAgrupadora      	VARCHAR(50)  		-- 17	Chequera.CuentaFondo.CuentaContable.cuentaAgrupadora
	, CuentaContable_6_porcentaje            	DECIMAL(6,3) 		-- 18	Chequera.CuentaFondo.CuentaContable.porcentaje
	, CuentaContable_6_puntoEquilibrio       	VARCHAR(36)  		-- 19	Chequera.CuentaFondo.CuentaContable.puntoEquilibrio
	, CuentaContable_6_costoVenta            	VARCHAR(36)  		-- 20	Chequera.CuentaFondo.CuentaContable.costoVenta
	, CuentaContable_6_seguridadPuerta       	VARCHAR(36)  		-- 21	Chequera.CuentaFondo.CuentaContable.seguridadPuerta
	, CuentaFondoGrupo_22_id                 	VARCHAR(36)  		-- 22	Chequera.CuentaFondo.CuentaFondoGrupo.id
	, CuentaFondoGrupo_22_numero             	INTEGER      		-- 23	Chequera.CuentaFondo.CuentaFondoGrupo.numero
	, CuentaFondoGrupo_22_nombre             	VARCHAR(50)  		-- 24	Chequera.CuentaFondo.CuentaFondoGrupo.nombre
	, CuentaFondoGrupo_22_cuentaFondoRubro   	VARCHAR(36)  		-- 25	Chequera.CuentaFondo.CuentaFondoGrupo.cuentaFondoRubro
	, CuentaFondoTipo_26_id                  	VARCHAR(36)  		-- 26	Chequera.CuentaFondo.CuentaFondoTipo.id
	, CuentaFondoTipo_26_numero              	INTEGER      		-- 27	Chequera.CuentaFondo.CuentaFondoTipo.numero
	, CuentaFondoTipo_26_nombre              	VARCHAR(50)  		-- 28	Chequera.CuentaFondo.CuentaFondoTipo.nombre
	, CuentaFondo_3_obsoleto                 	BOOLEAN      		-- 29	Chequera.CuentaFondo.obsoleto
	, CuentaFondo_3_noImprimeCaja            	BOOLEAN      		-- 30	Chequera.CuentaFondo.noImprimeCaja
	, CuentaFondo_3_ventas                   	BOOLEAN      		-- 31	Chequera.CuentaFondo.ventas
	, CuentaFondo_3_fondos                   	BOOLEAN      		-- 32	Chequera.CuentaFondo.fondos
	, CuentaFondo_3_compras                  	BOOLEAN      		-- 33	Chequera.CuentaFondo.compras
	, Moneda_34_id                           	VARCHAR(36)  		-- 34	Chequera.CuentaFondo.Moneda.id
	, Moneda_34_numero                       	INTEGER      		-- 35	Chequera.CuentaFondo.Moneda.numero
	, Moneda_34_nombre                       	VARCHAR(50)  		-- 36	Chequera.CuentaFondo.Moneda.nombre
	, Moneda_34_abreviatura                  	VARCHAR(5)   		-- 37	Chequera.CuentaFondo.Moneda.abreviatura
	, Moneda_34_cotizacion                   	DECIMAL(13,5)		-- 38	Chequera.CuentaFondo.Moneda.cotizacion
	, Moneda_34_cotizacionFecha              	TIMESTAMP    		-- 39	Chequera.CuentaFondo.Moneda.cotizacionFecha
	, Moneda_34_controlActualizacion         	BOOLEAN      		-- 40	Chequera.CuentaFondo.Moneda.controlActualizacion
	, Moneda_34_monedaAFIP                   	VARCHAR(36)  		-- 41	Chequera.CuentaFondo.Moneda.monedaAFIP
	, Caja_42_id                             	VARCHAR(36)  		-- 42	Chequera.CuentaFondo.Caja.id
	, Caja_42_numero                         	INTEGER      		-- 43	Chequera.CuentaFondo.Caja.numero
	, Caja_42_nombre                         	VARCHAR(50)  		-- 44	Chequera.CuentaFondo.Caja.nombre
	, Caja_42_seguridadPuerta                	VARCHAR(36)  		-- 45	Chequera.CuentaFondo.Caja.seguridadPuerta
	, CuentaFondo_3_rechazados               	BOOLEAN      		-- 46	Chequera.CuentaFondo.rechazados
	, CuentaFondo_3_conciliacion             	BOOLEAN      		-- 47	Chequera.CuentaFondo.conciliacion
	, CuentaFondoTipoBanco_48_id             	VARCHAR(36)  		-- 48	Chequera.CuentaFondo.CuentaFondoTipoBanco.id
	, CuentaFondoTipoBanco_48_numero         	INTEGER      		-- 49	Chequera.CuentaFondo.CuentaFondoTipoBanco.numero
	, CuentaFondoTipoBanco_48_nombre         	VARCHAR(50)  		-- 50	Chequera.CuentaFondo.CuentaFondoTipoBanco.nombre
	, Banco_51_id                            	VARCHAR(36)  		-- 51	Chequera.CuentaFondo.Banco.id
	, Banco_51_numero                        	INTEGER      		-- 52	Chequera.CuentaFondo.Banco.numero
	, Banco_51_nombre                        	VARCHAR(50)  		-- 53	Chequera.CuentaFondo.Banco.nombre
	, Banco_51_cuit                          	BIGINT       		-- 54	Chequera.CuentaFondo.Banco.cuit
	, Banco_51_bloqueado                     	BOOLEAN      		-- 55	Chequera.CuentaFondo.Banco.bloqueado
	, Banco_51_hoja                          	INTEGER      		-- 56	Chequera.CuentaFondo.Banco.hoja
	, Banco_51_primeraFila                   	INTEGER      		-- 57	Chequera.CuentaFondo.Banco.primeraFila
	, Banco_51_ultimaFila                    	INTEGER      		-- 58	Chequera.CuentaFondo.Banco.ultimaFila
	, Banco_51_fecha                         	VARCHAR(3)   		-- 59	Chequera.CuentaFondo.Banco.fecha
	, Banco_51_descripcion                   	VARCHAR(3)   		-- 60	Chequera.CuentaFondo.Banco.descripcion
	, Banco_51_referencia1                   	VARCHAR(3)   		-- 61	Chequera.CuentaFondo.Banco.referencia1
	, Banco_51_importe                       	VARCHAR(3)   		-- 62	Chequera.CuentaFondo.Banco.importe
	, Banco_51_referencia2                   	VARCHAR(3)   		-- 63	Chequera.CuentaFondo.Banco.referencia2
	, Banco_51_saldo                         	VARCHAR(3)   		-- 64	Chequera.CuentaFondo.Banco.saldo
	, CuentaFondo_3_cuentaBancaria           	VARCHAR(22)  		-- 65	Chequera.CuentaFondo.cuentaBancaria
	, CuentaFondo_3_cbu                      	VARCHAR(22)  		-- 66	Chequera.CuentaFondo.cbu
	, CuentaFondo_3_limiteDescubierto        	DECIMAL(13,5)		-- 67	Chequera.CuentaFondo.limiteDescubierto
	, CuentaFondo_3_cuentaFondoCaucion       	VARCHAR(50)  		-- 68	Chequera.CuentaFondo.cuentaFondoCaucion
	, CuentaFondo_3_cuentaFondoDiferidos     	VARCHAR(50)  		-- 69	Chequera.CuentaFondo.cuentaFondoDiferidos
	, CuentaFondo_3_formato                  	VARCHAR(50)  		-- 70	Chequera.CuentaFondo.formato
	, CuentaFondoBancoCopia_71_id            	VARCHAR(36)  		-- 71	Chequera.CuentaFondo.CuentaFondoBancoCopia.id
	, CuentaFondoBancoCopia_71_numero        	INTEGER      		-- 72	Chequera.CuentaFondo.CuentaFondoBancoCopia.numero
	, CuentaFondoBancoCopia_71_nombre        	VARCHAR(50)  		-- 73	Chequera.CuentaFondo.CuentaFondoBancoCopia.nombre
	, CuentaFondo_3_limiteOperacionIndividual	DECIMAL(13,5)		-- 74	Chequera.CuentaFondo.limiteOperacionIndividual
	, SeguridadPuerta_75_id                  	VARCHAR(36)  		-- 75	Chequera.CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_75_numero              	INTEGER      		-- 76	Chequera.CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_75_nombre              	VARCHAR(50)  		-- 77	Chequera.CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_75_equate              	VARCHAR(30)  		-- 78	Chequera.CuentaFondo.SeguridadPuerta.equate
	, SeguridadPuerta_75_seguridadModulo     	VARCHAR(36)  		-- 79	Chequera.CuentaFondo.SeguridadPuerta.seguridadModulo
	, SeguridadPuerta_80_id                  	VARCHAR(36)  		-- 80	Chequera.CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_80_numero              	INTEGER      		-- 81	Chequera.CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_80_nombre              	VARCHAR(50)  		-- 82	Chequera.CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_80_equate              	VARCHAR(30)  		-- 83	Chequera.CuentaFondo.SeguridadPuerta.equate
	, SeguridadPuerta_80_seguridadModulo     	VARCHAR(36)  		-- 84	Chequera.CuentaFondo.SeguridadPuerta.seguridadModulo
	, SeguridadPuerta_85_id                  	VARCHAR(36)  		-- 85	Chequera.CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_85_numero              	INTEGER      		-- 86	Chequera.CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_85_nombre              	VARCHAR(50)  		-- 87	Chequera.CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_85_equate              	VARCHAR(30)  		-- 88	Chequera.CuentaFondo.SeguridadPuerta.equate
	, SeguridadPuerta_85_seguridadModulo     	VARCHAR(36)  		-- 89	Chequera.CuentaFondo.SeguridadPuerta.seguridadModulo
	, Chequera_primerNumero                  	INTEGER      		-- 90	Chequera.primerNumero
	, Chequera_ultimoNumero                  	INTEGER      		-- 91	Chequera.ultimoNumero
	, Chequera_proximoNumero                 	INTEGER      		-- 92	Chequera.proximoNumero
	, Chequera_bloqueado                     	BOOLEAN      		-- 93	Chequera.bloqueado
	, Chequera_impresionDiferida             	BOOLEAN      		-- 94	Chequera.impresionDiferida
	, Chequera_formato                       	VARCHAR(50)  		-- 95	Chequera.formato

);

DROP TYPE IF EXISTS massoftware.t_Chequera_3 CASCADE;

CREATE TYPE massoftware.t_Chequera_3 AS (

	  Chequera_id                             	VARCHAR(36)  		-- 0	Chequera.id
	, Chequera_numero                         	INTEGER      		-- 1	Chequera.numero
	, Chequera_nombre                         	VARCHAR(50)  		-- 2	Chequera.nombre
	, CuentaFondo_3_id                        	VARCHAR(36)  		-- 3	Chequera.CuentaFondo.id
	, CuentaFondo_3_numero                    	INTEGER      		-- 4	Chequera.CuentaFondo.numero
	, CuentaFondo_3_nombre                    	VARCHAR(50)  		-- 5	Chequera.CuentaFondo.nombre
	, CuentaContable_6_id                     	VARCHAR(36)  		-- 6	Chequera.CuentaFondo.CuentaContable.id
	, CuentaContable_6_codigo                 	VARCHAR(11)  		-- 7	Chequera.CuentaFondo.CuentaContable.codigo
	, CuentaContable_6_nombre                 	VARCHAR(50)  		-- 8	Chequera.CuentaFondo.CuentaContable.nombre
	, EjercicioContable_9_id                  	VARCHAR(36)  		-- 9	Chequera.CuentaFondo.CuentaContable.EjercicioContable.id
	, EjercicioContable_9_numero              	INTEGER      		-- 10	Chequera.CuentaFondo.CuentaContable.EjercicioContable.numero
	, EjercicioContable_9_apertura            	DATE         		-- 11	Chequera.CuentaFondo.CuentaContable.EjercicioContable.apertura
	, EjercicioContable_9_cierre              	DATE         		-- 12	Chequera.CuentaFondo.CuentaContable.EjercicioContable.cierre
	, EjercicioContable_9_cerrado             	BOOLEAN      		-- 13	Chequera.CuentaFondo.CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_9_cerradoModulos      	BOOLEAN      		-- 14	Chequera.CuentaFondo.CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_9_comentario          	VARCHAR(250) 		-- 15	Chequera.CuentaFondo.CuentaContable.EjercicioContable.comentario
	, CuentaContable_6_integra                	VARCHAR(16)  		-- 16	Chequera.CuentaFondo.CuentaContable.integra
	, CuentaContable_6_cuentaJerarquia        	VARCHAR(16)  		-- 17	Chequera.CuentaFondo.CuentaContable.cuentaJerarquia
	, CuentaContable_6_imputable              	BOOLEAN      		-- 18	Chequera.CuentaFondo.CuentaContable.imputable
	, CuentaContable_6_ajustaPorInflacion     	BOOLEAN      		-- 19	Chequera.CuentaFondo.CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_20_id              	VARCHAR(36)  		-- 20	Chequera.CuentaFondo.CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_20_numero          	INTEGER      		-- 21	Chequera.CuentaFondo.CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_20_nombre          	VARCHAR(50)  		-- 22	Chequera.CuentaFondo.CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_6_cuentaConApropiacion   	BOOLEAN      		-- 23	Chequera.CuentaFondo.CuentaContable.cuentaConApropiacion
	, CentroCostoContable_24_id               	VARCHAR(36)  		-- 24	Chequera.CuentaFondo.CuentaContable.CentroCostoContable.id
	, CentroCostoContable_24_numero           	INTEGER      		-- 25	Chequera.CuentaFondo.CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_24_nombre           	VARCHAR(50)  		-- 26	Chequera.CuentaFondo.CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_24_abreviatura      	VARCHAR(5)   		-- 27	Chequera.CuentaFondo.CuentaContable.CentroCostoContable.abreviatura
	, CentroCostoContable_24_ejercicioContable	VARCHAR(36)  		-- 28	Chequera.CuentaFondo.CuentaContable.CentroCostoContable.ejercicioContable
	, CuentaContable_6_cuentaAgrupadora       	VARCHAR(50)  		-- 29	Chequera.CuentaFondo.CuentaContable.cuentaAgrupadora
	, CuentaContable_6_porcentaje             	DECIMAL(6,3) 		-- 30	Chequera.CuentaFondo.CuentaContable.porcentaje
	, PuntoEquilibrio_31_id                   	VARCHAR(36)  		-- 31	Chequera.CuentaFondo.CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_31_numero               	INTEGER      		-- 32	Chequera.CuentaFondo.CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_31_nombre               	VARCHAR(50)  		-- 33	Chequera.CuentaFondo.CuentaContable.PuntoEquilibrio.nombre
	, PuntoEquilibrio_31_tipoPuntoEquilibrio  	VARCHAR(36)  		-- 34	Chequera.CuentaFondo.CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio
	, PuntoEquilibrio_31_ejercicioContable    	VARCHAR(36)  		-- 35	Chequera.CuentaFondo.CuentaContable.PuntoEquilibrio.ejercicioContable
	, CostoVenta_36_id                        	VARCHAR(36)  		-- 36	Chequera.CuentaFondo.CuentaContable.CostoVenta.id
	, CostoVenta_36_numero                    	INTEGER      		-- 37	Chequera.CuentaFondo.CuentaContable.CostoVenta.numero
	, CostoVenta_36_nombre                    	VARCHAR(50)  		-- 38	Chequera.CuentaFondo.CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_39_id                   	VARCHAR(36)  		-- 39	Chequera.CuentaFondo.CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_39_numero               	INTEGER      		-- 40	Chequera.CuentaFondo.CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_39_nombre               	VARCHAR(50)  		-- 41	Chequera.CuentaFondo.CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_39_equate               	VARCHAR(30)  		-- 42	Chequera.CuentaFondo.CuentaContable.SeguridadPuerta.equate
	, SeguridadPuerta_39_seguridadModulo      	VARCHAR(36)  		-- 43	Chequera.CuentaFondo.CuentaContable.SeguridadPuerta.seguridadModulo
	, CuentaFondoGrupo_44_id                  	VARCHAR(36)  		-- 44	Chequera.CuentaFondo.CuentaFondoGrupo.id
	, CuentaFondoGrupo_44_numero              	INTEGER      		-- 45	Chequera.CuentaFondo.CuentaFondoGrupo.numero
	, CuentaFondoGrupo_44_nombre              	VARCHAR(50)  		-- 46	Chequera.CuentaFondo.CuentaFondoGrupo.nombre
	, CuentaFondoRubro_47_id                  	VARCHAR(36)  		-- 47	Chequera.CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.id
	, CuentaFondoRubro_47_numero              	INTEGER      		-- 48	Chequera.CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.numero
	, CuentaFondoRubro_47_nombre              	VARCHAR(50)  		-- 49	Chequera.CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.nombre
	, CuentaFondoTipo_50_id                   	VARCHAR(36)  		-- 50	Chequera.CuentaFondo.CuentaFondoTipo.id
	, CuentaFondoTipo_50_numero               	INTEGER      		-- 51	Chequera.CuentaFondo.CuentaFondoTipo.numero
	, CuentaFondoTipo_50_nombre               	VARCHAR(50)  		-- 52	Chequera.CuentaFondo.CuentaFondoTipo.nombre
	, CuentaFondo_3_obsoleto                  	BOOLEAN      		-- 53	Chequera.CuentaFondo.obsoleto
	, CuentaFondo_3_noImprimeCaja             	BOOLEAN      		-- 54	Chequera.CuentaFondo.noImprimeCaja
	, CuentaFondo_3_ventas                    	BOOLEAN      		-- 55	Chequera.CuentaFondo.ventas
	, CuentaFondo_3_fondos                    	BOOLEAN      		-- 56	Chequera.CuentaFondo.fondos
	, CuentaFondo_3_compras                   	BOOLEAN      		-- 57	Chequera.CuentaFondo.compras
	, Moneda_58_id                            	VARCHAR(36)  		-- 58	Chequera.CuentaFondo.Moneda.id
	, Moneda_58_numero                        	INTEGER      		-- 59	Chequera.CuentaFondo.Moneda.numero
	, Moneda_58_nombre                        	VARCHAR(50)  		-- 60	Chequera.CuentaFondo.Moneda.nombre
	, Moneda_58_abreviatura                   	VARCHAR(5)   		-- 61	Chequera.CuentaFondo.Moneda.abreviatura
	, Moneda_58_cotizacion                    	DECIMAL(13,5)		-- 62	Chequera.CuentaFondo.Moneda.cotizacion
	, Moneda_58_cotizacionFecha               	TIMESTAMP    		-- 63	Chequera.CuentaFondo.Moneda.cotizacionFecha
	, Moneda_58_controlActualizacion          	BOOLEAN      		-- 64	Chequera.CuentaFondo.Moneda.controlActualizacion
	, MonedaAFIP_65_id                        	VARCHAR(36)  		-- 65	Chequera.CuentaFondo.Moneda.MonedaAFIP.id
	, MonedaAFIP_65_codigo                    	VARCHAR(3)   		-- 66	Chequera.CuentaFondo.Moneda.MonedaAFIP.codigo
	, MonedaAFIP_65_nombre                    	VARCHAR(50)  		-- 67	Chequera.CuentaFondo.Moneda.MonedaAFIP.nombre
	, Caja_68_id                              	VARCHAR(36)  		-- 68	Chequera.CuentaFondo.Caja.id
	, Caja_68_numero                          	INTEGER      		-- 69	Chequera.CuentaFondo.Caja.numero
	, Caja_68_nombre                          	VARCHAR(50)  		-- 70	Chequera.CuentaFondo.Caja.nombre
	, SeguridadPuerta_71_id                   	VARCHAR(36)  		-- 71	Chequera.CuentaFondo.Caja.SeguridadPuerta.id
	, SeguridadPuerta_71_numero               	INTEGER      		-- 72	Chequera.CuentaFondo.Caja.SeguridadPuerta.numero
	, SeguridadPuerta_71_nombre               	VARCHAR(50)  		-- 73	Chequera.CuentaFondo.Caja.SeguridadPuerta.nombre
	, SeguridadPuerta_71_equate               	VARCHAR(30)  		-- 74	Chequera.CuentaFondo.Caja.SeguridadPuerta.equate
	, SeguridadPuerta_71_seguridadModulo      	VARCHAR(36)  		-- 75	Chequera.CuentaFondo.Caja.SeguridadPuerta.seguridadModulo
	, CuentaFondo_3_rechazados                	BOOLEAN      		-- 76	Chequera.CuentaFondo.rechazados
	, CuentaFondo_3_conciliacion              	BOOLEAN      		-- 77	Chequera.CuentaFondo.conciliacion
	, CuentaFondoTipoBanco_78_id              	VARCHAR(36)  		-- 78	Chequera.CuentaFondo.CuentaFondoTipoBanco.id
	, CuentaFondoTipoBanco_78_numero          	INTEGER      		-- 79	Chequera.CuentaFondo.CuentaFondoTipoBanco.numero
	, CuentaFondoTipoBanco_78_nombre          	VARCHAR(50)  		-- 80	Chequera.CuentaFondo.CuentaFondoTipoBanco.nombre
	, Banco_81_id                             	VARCHAR(36)  		-- 81	Chequera.CuentaFondo.Banco.id
	, Banco_81_numero                         	INTEGER      		-- 82	Chequera.CuentaFondo.Banco.numero
	, Banco_81_nombre                         	VARCHAR(50)  		-- 83	Chequera.CuentaFondo.Banco.nombre
	, Banco_81_cuit                           	BIGINT       		-- 84	Chequera.CuentaFondo.Banco.cuit
	, Banco_81_bloqueado                      	BOOLEAN      		-- 85	Chequera.CuentaFondo.Banco.bloqueado
	, Banco_81_hoja                           	INTEGER      		-- 86	Chequera.CuentaFondo.Banco.hoja
	, Banco_81_primeraFila                    	INTEGER      		-- 87	Chequera.CuentaFondo.Banco.primeraFila
	, Banco_81_ultimaFila                     	INTEGER      		-- 88	Chequera.CuentaFondo.Banco.ultimaFila
	, Banco_81_fecha                          	VARCHAR(3)   		-- 89	Chequera.CuentaFondo.Banco.fecha
	, Banco_81_descripcion                    	VARCHAR(3)   		-- 90	Chequera.CuentaFondo.Banco.descripcion
	, Banco_81_referencia1                    	VARCHAR(3)   		-- 91	Chequera.CuentaFondo.Banco.referencia1
	, Banco_81_importe                        	VARCHAR(3)   		-- 92	Chequera.CuentaFondo.Banco.importe
	, Banco_81_referencia2                    	VARCHAR(3)   		-- 93	Chequera.CuentaFondo.Banco.referencia2
	, Banco_81_saldo                          	VARCHAR(3)   		-- 94	Chequera.CuentaFondo.Banco.saldo
	, CuentaFondo_3_cuentaBancaria            	VARCHAR(22)  		-- 95	Chequera.CuentaFondo.cuentaBancaria
	, CuentaFondo_3_cbu                       	VARCHAR(22)  		-- 96	Chequera.CuentaFondo.cbu
	, CuentaFondo_3_limiteDescubierto         	DECIMAL(13,5)		-- 97	Chequera.CuentaFondo.limiteDescubierto
	, CuentaFondo_3_cuentaFondoCaucion        	VARCHAR(50)  		-- 98	Chequera.CuentaFondo.cuentaFondoCaucion
	, CuentaFondo_3_cuentaFondoDiferidos      	VARCHAR(50)  		-- 99	Chequera.CuentaFondo.cuentaFondoDiferidos
	, CuentaFondo_3_formato                   	VARCHAR(50)  		-- 100	Chequera.CuentaFondo.formato
	, CuentaFondoBancoCopia_101_id            	VARCHAR(36)  		-- 101	Chequera.CuentaFondo.CuentaFondoBancoCopia.id
	, CuentaFondoBancoCopia_101_numero        	INTEGER      		-- 102	Chequera.CuentaFondo.CuentaFondoBancoCopia.numero
	, CuentaFondoBancoCopia_101_nombre        	VARCHAR(50)  		-- 103	Chequera.CuentaFondo.CuentaFondoBancoCopia.nombre
	, CuentaFondo_3_limiteOperacionIndividual 	DECIMAL(13,5)		-- 104	Chequera.CuentaFondo.limiteOperacionIndividual
	, SeguridadPuerta_105_id                  	VARCHAR(36)  		-- 105	Chequera.CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_105_numero              	INTEGER      		-- 106	Chequera.CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_105_nombre              	VARCHAR(50)  		-- 107	Chequera.CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_105_equate              	VARCHAR(30)  		-- 108	Chequera.CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_109_id                  	VARCHAR(36)  		-- 109	Chequera.CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_109_numero              	INTEGER      		-- 110	Chequera.CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_109_nombre              	VARCHAR(50)  		-- 111	Chequera.CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre
	, SeguridadPuerta_112_id                  	VARCHAR(36)  		-- 112	Chequera.CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_112_numero              	INTEGER      		-- 113	Chequera.CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_112_nombre              	VARCHAR(50)  		-- 114	Chequera.CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_112_equate              	VARCHAR(30)  		-- 115	Chequera.CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_116_id                  	VARCHAR(36)  		-- 116	Chequera.CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_116_numero              	INTEGER      		-- 117	Chequera.CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_116_nombre              	VARCHAR(50)  		-- 118	Chequera.CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre
	, SeguridadPuerta_119_id                  	VARCHAR(36)  		-- 119	Chequera.CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_119_numero              	INTEGER      		-- 120	Chequera.CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_119_nombre              	VARCHAR(50)  		-- 121	Chequera.CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_119_equate              	VARCHAR(30)  		-- 122	Chequera.CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_123_id                  	VARCHAR(36)  		-- 123	Chequera.CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_123_numero              	INTEGER      		-- 124	Chequera.CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_123_nombre              	VARCHAR(50)  		-- 125	Chequera.CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre
	, Chequera_primerNumero                   	INTEGER      		-- 126	Chequera.primerNumero
	, Chequera_ultimoNumero                   	INTEGER      		-- 127	Chequera.ultimoNumero
	, Chequera_proximoNumero                  	INTEGER      		-- 128	Chequera.proximoNumero
	, Chequera_bloqueado                      	BOOLEAN      		-- 129	Chequera.bloqueado
	, Chequera_impresionDiferida              	BOOLEAN      		-- 130	Chequera.impresionDiferida
	, Chequera_formato                        	VARCHAR(50)  		-- 131	Chequera.formato

);

DROP FUNCTION IF EXISTS massoftware.f_Chequera (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, cuentaFondoArg8   VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Chequera (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, cuentaFondoArg8   VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.Chequera AS $$

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
				  Chequera.id                   AS Chequera_id               	-- 0	.id              		VARCHAR(36)
				, Chequera.numero               AS Chequera_numero           	-- 1	.numero          		INTEGER
				, Chequera.nombre               AS Chequera_nombre           	-- 2	.nombre          		VARCHAR(50)
				, Chequera.cuentaFondo          AS Chequera_cuentaFondo      	-- 3	.cuentaFondo     		VARCHAR(36)	CuentaFondo.id
				, Chequera.primerNumero         AS Chequera_primerNumero     	-- 4	.primerNumero    		INTEGER
				, Chequera.ultimoNumero         AS Chequera_ultimoNumero     	-- 5	.ultimoNumero    		INTEGER
				, Chequera.proximoNumero        AS Chequera_proximoNumero    	-- 6	.proximoNumero   		INTEGER
				, Chequera.bloqueado            AS Chequera_bloqueado        	-- 7	.bloqueado       		BOOLEAN
				, Chequera.impresionDiferida    AS Chequera_impresionDiferida	-- 8	.impresionDiferida		BOOLEAN
				, Chequera.formato              AS Chequera_formato          	-- 9	.formato         		VARCHAR(50)

		FROM	massoftware.Chequera

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Chequera.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Chequera.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Chequera.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Chequera.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND cuentaFondoArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(cuentaFondoArg8)) > 0 THEN
		cuentaFondoArg8 = REPLACE(cuentaFondoArg8, '''', '''''');
		cuentaFondoArg8 = LOWER(TRIM(cuentaFondoArg8));
		cuentaFondoArg8 = TRANSLATE(cuentaFondoArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(cuentaFondoArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Chequera.cuentaFondo),
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

DROP FUNCTION IF EXISTS massoftware.f_ChequeraById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ChequeraById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Chequera AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Chequera ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Chequera ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_ChequeraById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Chequera_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, cuentaFondoArg8   VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Chequera_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, cuentaFondoArg8   VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_Chequera_1 AS $$

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
				  Chequera.id                                 AS Chequera_id                            	-- 0	.id                                  		VARCHAR(36)
				, Chequera.numero                             AS Chequera_numero                        	-- 1	.numero                              		INTEGER
				, Chequera.nombre                             AS Chequera_nombre                        	-- 2	.nombre                              		VARCHAR(50)
				, CuentaFondo_3.id                            AS CuentaFondo_3_id                       	-- 3	.CuentaFondo.id                      		VARCHAR(36)
				, CuentaFondo_3.numero                        AS CuentaFondo_3_numero                   	-- 4	.CuentaFondo.numero                  		INTEGER
				, CuentaFondo_3.nombre                        AS CuentaFondo_3_nombre                   	-- 5	.CuentaFondo.nombre                  		VARCHAR(50)
				, CuentaFondo_3.cuentaContable                AS CuentaFondo_3_cuentaContable           	-- 6	.CuentaFondo.cuentaContable          		VARCHAR(36)	CuentaContable.id
				, CuentaFondo_3.cuentaFondoGrupo              AS CuentaFondo_3_cuentaFondoGrupo         	-- 7	.CuentaFondo.cuentaFondoGrupo        		VARCHAR(36)	CuentaFondoGrupo.id
				, CuentaFondo_3.cuentaFondoTipo               AS CuentaFondo_3_cuentaFondoTipo          	-- 8	.CuentaFondo.cuentaFondoTipo         		VARCHAR(36)	CuentaFondoTipo.id
				, CuentaFondo_3.obsoleto                      AS CuentaFondo_3_obsoleto                 	-- 9	.CuentaFondo.obsoleto                		BOOLEAN
				, CuentaFondo_3.noImprimeCaja                 AS CuentaFondo_3_noImprimeCaja            	-- 10	.CuentaFondo.noImprimeCaja           		BOOLEAN
				, CuentaFondo_3.ventas                        AS CuentaFondo_3_ventas                   	-- 11	.CuentaFondo.ventas                  		BOOLEAN
				, CuentaFondo_3.fondos                        AS CuentaFondo_3_fondos                   	-- 12	.CuentaFondo.fondos                  		BOOLEAN
				, CuentaFondo_3.compras                       AS CuentaFondo_3_compras                  	-- 13	.CuentaFondo.compras                 		BOOLEAN
				, CuentaFondo_3.moneda                        AS CuentaFondo_3_moneda                   	-- 14	.CuentaFondo.moneda                  		VARCHAR(36)	Moneda.id
				, CuentaFondo_3.caja                          AS CuentaFondo_3_caja                     	-- 15	.CuentaFondo.caja                    		VARCHAR(36)	Caja.id
				, CuentaFondo_3.rechazados                    AS CuentaFondo_3_rechazados               	-- 16	.CuentaFondo.rechazados              		BOOLEAN
				, CuentaFondo_3.conciliacion                  AS CuentaFondo_3_conciliacion             	-- 17	.CuentaFondo.conciliacion            		BOOLEAN
				, CuentaFondo_3.cuentaFondoTipoBanco          AS CuentaFondo_3_cuentaFondoTipoBanco     	-- 18	.CuentaFondo.cuentaFondoTipoBanco    		VARCHAR(36)	CuentaFondoTipoBanco.id
				, CuentaFondo_3.banco                         AS CuentaFondo_3_banco                    	-- 19	.CuentaFondo.banco                   		VARCHAR(36)	Banco.id
				, CuentaFondo_3.cuentaBancaria                AS CuentaFondo_3_cuentaBancaria           	-- 20	.CuentaFondo.cuentaBancaria          		VARCHAR(22)
				, CuentaFondo_3.cbu                           AS CuentaFondo_3_cbu                      	-- 21	.CuentaFondo.cbu                     		VARCHAR(22)
				, CuentaFondo_3.limiteDescubierto             AS CuentaFondo_3_limiteDescubierto        	-- 22	.CuentaFondo.limiteDescubierto       		DECIMAL(13,5)
				, CuentaFondo_3.cuentaFondoCaucion            AS CuentaFondo_3_cuentaFondoCaucion       	-- 23	.CuentaFondo.cuentaFondoCaucion      		VARCHAR(50)
				, CuentaFondo_3.cuentaFondoDiferidos          AS CuentaFondo_3_cuentaFondoDiferidos     	-- 24	.CuentaFondo.cuentaFondoDiferidos    		VARCHAR(50)
				, CuentaFondo_3.formato                       AS CuentaFondo_3_formato                  	-- 25	.CuentaFondo.formato                 		VARCHAR(50)
				, CuentaFondo_3.cuentaFondoBancoCopia         AS CuentaFondo_3_cuentaFondoBancoCopia    	-- 26	.CuentaFondo.cuentaFondoBancoCopia   		VARCHAR(36)	CuentaFondoBancoCopia.id
				, CuentaFondo_3.limiteOperacionIndividual     AS CuentaFondo_3_limiteOperacionIndividual	-- 27	.CuentaFondo.limiteOperacionIndividual		DECIMAL(13,5)
				, CuentaFondo_3.seguridadPuertaUso            AS CuentaFondo_3_seguridadPuertaUso       	-- 28	.CuentaFondo.seguridadPuertaUso      		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondo_3.seguridadPuertaConsulta       AS CuentaFondo_3_seguridadPuertaConsulta  	-- 29	.CuentaFondo.seguridadPuertaConsulta 		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondo_3.seguridadPuertaLimite         AS CuentaFondo_3_seguridadPuertaLimite    	-- 30	.CuentaFondo.seguridadPuertaLimite   		VARCHAR(36)	SeguridadPuerta.id
				, Chequera.primerNumero                       AS Chequera_primerNumero                  	-- 31	.primerNumero                        		INTEGER
				, Chequera.ultimoNumero                       AS Chequera_ultimoNumero                  	-- 32	.ultimoNumero                        		INTEGER
				, Chequera.proximoNumero                      AS Chequera_proximoNumero                 	-- 33	.proximoNumero                       		INTEGER
				, Chequera.bloqueado                          AS Chequera_bloqueado                     	-- 34	.bloqueado                           		BOOLEAN
				, Chequera.impresionDiferida                  AS Chequera_impresionDiferida             	-- 35	.impresionDiferida                   		BOOLEAN
				, Chequera.formato                            AS Chequera_formato                       	-- 36	.formato                             		VARCHAR(50)

		FROM	massoftware.Chequera
			LEFT JOIN massoftware.CuentaFondo AS CuentaFondo_3        ON Chequera.cuentaFondo = CuentaFondo_3.id 	-- 3 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Chequera.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Chequera.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Chequera.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Chequera.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND cuentaFondoArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(cuentaFondoArg8)) > 0 THEN
		cuentaFondoArg8 = REPLACE(cuentaFondoArg8, '''', '''''');
		cuentaFondoArg8 = LOWER(TRIM(cuentaFondoArg8));
		cuentaFondoArg8 = TRANSLATE(cuentaFondoArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(cuentaFondoArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Chequera.cuentaFondo),
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

DROP FUNCTION IF EXISTS massoftware.f_ChequeraById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ChequeraById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Chequera_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Chequera_1 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Chequera_1 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_ChequeraById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Chequera_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, cuentaFondoArg8   VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Chequera_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, cuentaFondoArg8   VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_Chequera_2 AS $$

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
				  Chequera.id                                 AS Chequera_id                            	-- 0	.id                                            		VARCHAR(36)
				, Chequera.numero                             AS Chequera_numero                        	-- 1	.numero                                        		INTEGER
				, Chequera.nombre                             AS Chequera_nombre                        	-- 2	.nombre                                        		VARCHAR(50)
				, CuentaFondo_3.id                            AS CuentaFondo_3_id                       	-- 3	.CuentaFondo.id                                		VARCHAR(36)
				, CuentaFondo_3.numero                        AS CuentaFondo_3_numero                   	-- 4	.CuentaFondo.numero                            		INTEGER
				, CuentaFondo_3.nombre                        AS CuentaFondo_3_nombre                   	-- 5	.CuentaFondo.nombre                            		VARCHAR(50)
				, CuentaContable_6.id                         AS CuentaContable_6_id                    	-- 6	.CuentaFondo.CuentaContable.id                 		VARCHAR(36)
				, CuentaContable_6.codigo                     AS CuentaContable_6_codigo                	-- 7	.CuentaFondo.CuentaContable.codigo             		VARCHAR(11)
				, CuentaContable_6.nombre                     AS CuentaContable_6_nombre                	-- 8	.CuentaFondo.CuentaContable.nombre             		VARCHAR(50)
				, CuentaContable_6.ejercicioContable          AS CuentaContable_6_ejercicioContable     	-- 9	.CuentaFondo.CuentaContable.ejercicioContable  		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_6.integra                    AS CuentaContable_6_integra               	-- 10	.CuentaFondo.CuentaContable.integra            		VARCHAR(16)
				, CuentaContable_6.cuentaJerarquia            AS CuentaContable_6_cuentaJerarquia       	-- 11	.CuentaFondo.CuentaContable.cuentaJerarquia    		VARCHAR(16)
				, CuentaContable_6.imputable                  AS CuentaContable_6_imputable             	-- 12	.CuentaFondo.CuentaContable.imputable          		BOOLEAN
				, CuentaContable_6.ajustaPorInflacion         AS CuentaContable_6_ajustaPorInflacion    	-- 13	.CuentaFondo.CuentaContable.ajustaPorInflacion 		BOOLEAN
				, CuentaContable_6.cuentaContableEstado       AS CuentaContable_6_cuentaContableEstado  	-- 14	.CuentaFondo.CuentaContable.cuentaContableEstado		VARCHAR(36)	CuentaContableEstado.id
				, CuentaContable_6.cuentaConApropiacion       AS CuentaContable_6_cuentaConApropiacion  	-- 15	.CuentaFondo.CuentaContable.cuentaConApropiacion		BOOLEAN
				, CuentaContable_6.centroCostoContable        AS CuentaContable_6_centroCostoContable   	-- 16	.CuentaFondo.CuentaContable.centroCostoContable		VARCHAR(36)	CentroCostoContable.id
				, CuentaContable_6.cuentaAgrupadora           AS CuentaContable_6_cuentaAgrupadora      	-- 17	.CuentaFondo.CuentaContable.cuentaAgrupadora   		VARCHAR(50)
				, CuentaContable_6.porcentaje                 AS CuentaContable_6_porcentaje            	-- 18	.CuentaFondo.CuentaContable.porcentaje         		DECIMAL(6,3)
				, CuentaContable_6.puntoEquilibrio            AS CuentaContable_6_puntoEquilibrio       	-- 19	.CuentaFondo.CuentaContable.puntoEquilibrio    		VARCHAR(36)	PuntoEquilibrio.id
				, CuentaContable_6.costoVenta                 AS CuentaContable_6_costoVenta            	-- 20	.CuentaFondo.CuentaContable.costoVenta         		VARCHAR(36)	CostoVenta.id
				, CuentaContable_6.seguridadPuerta            AS CuentaContable_6_seguridadPuerta       	-- 21	.CuentaFondo.CuentaContable.seguridadPuerta    		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondoGrupo_22.id                      AS CuentaFondoGrupo_22_id                 	-- 22	.CuentaFondo.CuentaFondoGrupo.id               		VARCHAR(36)
				, CuentaFondoGrupo_22.numero                  AS CuentaFondoGrupo_22_numero             	-- 23	.CuentaFondo.CuentaFondoGrupo.numero           		INTEGER
				, CuentaFondoGrupo_22.nombre                  AS CuentaFondoGrupo_22_nombre             	-- 24	.CuentaFondo.CuentaFondoGrupo.nombre           		VARCHAR(50)
				, CuentaFondoGrupo_22.cuentaFondoRubro        AS CuentaFondoGrupo_22_cuentaFondoRubro   	-- 25	.CuentaFondo.CuentaFondoGrupo.cuentaFondoRubro 		VARCHAR(36)	CuentaFondoRubro.id
				, CuentaFondoTipo_26.id                       AS CuentaFondoTipo_26_id                  	-- 26	.CuentaFondo.CuentaFondoTipo.id                		VARCHAR(36)
				, CuentaFondoTipo_26.numero                   AS CuentaFondoTipo_26_numero              	-- 27	.CuentaFondo.CuentaFondoTipo.numero            		INTEGER
				, CuentaFondoTipo_26.nombre                   AS CuentaFondoTipo_26_nombre              	-- 28	.CuentaFondo.CuentaFondoTipo.nombre            		VARCHAR(50)
				, CuentaFondo_3.obsoleto                      AS CuentaFondo_3_obsoleto                 	-- 29	.CuentaFondo.obsoleto                          		BOOLEAN
				, CuentaFondo_3.noImprimeCaja                 AS CuentaFondo_3_noImprimeCaja            	-- 30	.CuentaFondo.noImprimeCaja                     		BOOLEAN
				, CuentaFondo_3.ventas                        AS CuentaFondo_3_ventas                   	-- 31	.CuentaFondo.ventas                            		BOOLEAN
				, CuentaFondo_3.fondos                        AS CuentaFondo_3_fondos                   	-- 32	.CuentaFondo.fondos                            		BOOLEAN
				, CuentaFondo_3.compras                       AS CuentaFondo_3_compras                  	-- 33	.CuentaFondo.compras                           		BOOLEAN
				, Moneda_34.id                                AS Moneda_34_id                           	-- 34	.CuentaFondo.Moneda.id                         		VARCHAR(36)
				, Moneda_34.numero                            AS Moneda_34_numero                       	-- 35	.CuentaFondo.Moneda.numero                     		INTEGER
				, Moneda_34.nombre                            AS Moneda_34_nombre                       	-- 36	.CuentaFondo.Moneda.nombre                     		VARCHAR(50)
				, Moneda_34.abreviatura                       AS Moneda_34_abreviatura                  	-- 37	.CuentaFondo.Moneda.abreviatura                		VARCHAR(5)
				, Moneda_34.cotizacion                        AS Moneda_34_cotizacion                   	-- 38	.CuentaFondo.Moneda.cotizacion                 		DECIMAL(13,5)
				, Moneda_34.cotizacionFecha                   AS Moneda_34_cotizacionFecha              	-- 39	.CuentaFondo.Moneda.cotizacionFecha            		TIMESTAMP
				, Moneda_34.controlActualizacion              AS Moneda_34_controlActualizacion         	-- 40	.CuentaFondo.Moneda.controlActualizacion       		BOOLEAN
				, Moneda_34.monedaAFIP                        AS Moneda_34_monedaAFIP                   	-- 41	.CuentaFondo.Moneda.monedaAFIP                 		VARCHAR(36)	MonedaAFIP.id
				, Caja_42.id                                  AS Caja_42_id                             	-- 42	.CuentaFondo.Caja.id                           		VARCHAR(36)
				, Caja_42.numero                              AS Caja_42_numero                         	-- 43	.CuentaFondo.Caja.numero                       		INTEGER
				, Caja_42.nombre                              AS Caja_42_nombre                         	-- 44	.CuentaFondo.Caja.nombre                       		VARCHAR(50)
				, Caja_42.seguridadPuerta                     AS Caja_42_seguridadPuerta                	-- 45	.CuentaFondo.Caja.seguridadPuerta              		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondo_3.rechazados                    AS CuentaFondo_3_rechazados               	-- 46	.CuentaFondo.rechazados                        		BOOLEAN
				, CuentaFondo_3.conciliacion                  AS CuentaFondo_3_conciliacion             	-- 47	.CuentaFondo.conciliacion                      		BOOLEAN
				, CuentaFondoTipoBanco_48.id                  AS CuentaFondoTipoBanco_48_id             	-- 48	.CuentaFondo.CuentaFondoTipoBanco.id           		VARCHAR(36)
				, CuentaFondoTipoBanco_48.numero              AS CuentaFondoTipoBanco_48_numero         	-- 49	.CuentaFondo.CuentaFondoTipoBanco.numero       		INTEGER
				, CuentaFondoTipoBanco_48.nombre              AS CuentaFondoTipoBanco_48_nombre         	-- 50	.CuentaFondo.CuentaFondoTipoBanco.nombre       		VARCHAR(50)
				, Banco_51.id                                 AS Banco_51_id                            	-- 51	.CuentaFondo.Banco.id                          		VARCHAR(36)
				, Banco_51.numero                             AS Banco_51_numero                        	-- 52	.CuentaFondo.Banco.numero                      		INTEGER
				, Banco_51.nombre                             AS Banco_51_nombre                        	-- 53	.CuentaFondo.Banco.nombre                      		VARCHAR(50)
				, Banco_51.cuit                               AS Banco_51_cuit                          	-- 54	.CuentaFondo.Banco.cuit                        		BIGINT
				, Banco_51.bloqueado                          AS Banco_51_bloqueado                     	-- 55	.CuentaFondo.Banco.bloqueado                   		BOOLEAN
				, Banco_51.hoja                               AS Banco_51_hoja                          	-- 56	.CuentaFondo.Banco.hoja                        		INTEGER
				, Banco_51.primeraFila                        AS Banco_51_primeraFila                   	-- 57	.CuentaFondo.Banco.primeraFila                 		INTEGER
				, Banco_51.ultimaFila                         AS Banco_51_ultimaFila                    	-- 58	.CuentaFondo.Banco.ultimaFila                  		INTEGER
				, Banco_51.fecha                              AS Banco_51_fecha                         	-- 59	.CuentaFondo.Banco.fecha                       		VARCHAR(3)
				, Banco_51.descripcion                        AS Banco_51_descripcion                   	-- 60	.CuentaFondo.Banco.descripcion                 		VARCHAR(3)
				, Banco_51.referencia1                        AS Banco_51_referencia1                   	-- 61	.CuentaFondo.Banco.referencia1                 		VARCHAR(3)
				, Banco_51.importe                            AS Banco_51_importe                       	-- 62	.CuentaFondo.Banco.importe                     		VARCHAR(3)
				, Banco_51.referencia2                        AS Banco_51_referencia2                   	-- 63	.CuentaFondo.Banco.referencia2                 		VARCHAR(3)
				, Banco_51.saldo                              AS Banco_51_saldo                         	-- 64	.CuentaFondo.Banco.saldo                       		VARCHAR(3)
				, CuentaFondo_3.cuentaBancaria                AS CuentaFondo_3_cuentaBancaria           	-- 65	.CuentaFondo.cuentaBancaria                    		VARCHAR(22)
				, CuentaFondo_3.cbu                           AS CuentaFondo_3_cbu                      	-- 66	.CuentaFondo.cbu                               		VARCHAR(22)
				, CuentaFondo_3.limiteDescubierto             AS CuentaFondo_3_limiteDescubierto        	-- 67	.CuentaFondo.limiteDescubierto                 		DECIMAL(13,5)
				, CuentaFondo_3.cuentaFondoCaucion            AS CuentaFondo_3_cuentaFondoCaucion       	-- 68	.CuentaFondo.cuentaFondoCaucion                		VARCHAR(50)
				, CuentaFondo_3.cuentaFondoDiferidos          AS CuentaFondo_3_cuentaFondoDiferidos     	-- 69	.CuentaFondo.cuentaFondoDiferidos              		VARCHAR(50)
				, CuentaFondo_3.formato                       AS CuentaFondo_3_formato                  	-- 70	.CuentaFondo.formato                           		VARCHAR(50)
				, CuentaFondoBancoCopia_71.id                 AS CuentaFondoBancoCopia_71_id            	-- 71	.CuentaFondo.CuentaFondoBancoCopia.id          		VARCHAR(36)
				, CuentaFondoBancoCopia_71.numero             AS CuentaFondoBancoCopia_71_numero        	-- 72	.CuentaFondo.CuentaFondoBancoCopia.numero      		INTEGER
				, CuentaFondoBancoCopia_71.nombre             AS CuentaFondoBancoCopia_71_nombre        	-- 73	.CuentaFondo.CuentaFondoBancoCopia.nombre      		VARCHAR(50)
				, CuentaFondo_3.limiteOperacionIndividual     AS CuentaFondo_3_limiteOperacionIndividual	-- 74	.CuentaFondo.limiteOperacionIndividual         		DECIMAL(13,5)
				, SeguridadPuerta_75.id                       AS SeguridadPuerta_75_id                  	-- 75	.CuentaFondo.SeguridadPuerta.id                		VARCHAR(36)
				, SeguridadPuerta_75.numero                   AS SeguridadPuerta_75_numero              	-- 76	.CuentaFondo.SeguridadPuerta.numero            		INTEGER
				, SeguridadPuerta_75.nombre                   AS SeguridadPuerta_75_nombre              	-- 77	.CuentaFondo.SeguridadPuerta.nombre            		VARCHAR(50)
				, SeguridadPuerta_75.equate                   AS SeguridadPuerta_75_equate              	-- 78	.CuentaFondo.SeguridadPuerta.equate            		VARCHAR(30)
				, SeguridadPuerta_75.seguridadModulo          AS SeguridadPuerta_75_seguridadModulo     	-- 79	.CuentaFondo.SeguridadPuerta.seguridadModulo   		VARCHAR(36)	SeguridadModulo.id
				, SeguridadPuerta_80.id                       AS SeguridadPuerta_80_id                  	-- 80	.CuentaFondo.SeguridadPuerta.id                		VARCHAR(36)
				, SeguridadPuerta_80.numero                   AS SeguridadPuerta_80_numero              	-- 81	.CuentaFondo.SeguridadPuerta.numero            		INTEGER
				, SeguridadPuerta_80.nombre                   AS SeguridadPuerta_80_nombre              	-- 82	.CuentaFondo.SeguridadPuerta.nombre            		VARCHAR(50)
				, SeguridadPuerta_80.equate                   AS SeguridadPuerta_80_equate              	-- 83	.CuentaFondo.SeguridadPuerta.equate            		VARCHAR(30)
				, SeguridadPuerta_80.seguridadModulo          AS SeguridadPuerta_80_seguridadModulo     	-- 84	.CuentaFondo.SeguridadPuerta.seguridadModulo   		VARCHAR(36)	SeguridadModulo.id
				, SeguridadPuerta_85.id                       AS SeguridadPuerta_85_id                  	-- 85	.CuentaFondo.SeguridadPuerta.id                		VARCHAR(36)
				, SeguridadPuerta_85.numero                   AS SeguridadPuerta_85_numero              	-- 86	.CuentaFondo.SeguridadPuerta.numero            		INTEGER
				, SeguridadPuerta_85.nombre                   AS SeguridadPuerta_85_nombre              	-- 87	.CuentaFondo.SeguridadPuerta.nombre            		VARCHAR(50)
				, SeguridadPuerta_85.equate                   AS SeguridadPuerta_85_equate              	-- 88	.CuentaFondo.SeguridadPuerta.equate            		VARCHAR(30)
				, SeguridadPuerta_85.seguridadModulo          AS SeguridadPuerta_85_seguridadModulo     	-- 89	.CuentaFondo.SeguridadPuerta.seguridadModulo   		VARCHAR(36)	SeguridadModulo.id
				, Chequera.primerNumero                       AS Chequera_primerNumero                  	-- 90	.primerNumero                                  		INTEGER
				, Chequera.ultimoNumero                       AS Chequera_ultimoNumero                  	-- 91	.ultimoNumero                                  		INTEGER
				, Chequera.proximoNumero                      AS Chequera_proximoNumero                 	-- 92	.proximoNumero                                 		INTEGER
				, Chequera.bloqueado                          AS Chequera_bloqueado                     	-- 93	.bloqueado                                     		BOOLEAN
				, Chequera.impresionDiferida                  AS Chequera_impresionDiferida             	-- 94	.impresionDiferida                             		BOOLEAN
				, Chequera.formato                            AS Chequera_formato                       	-- 95	.formato                                       		VARCHAR(50)

		FROM	massoftware.Chequera
			LEFT JOIN massoftware.CuentaFondo AS CuentaFondo_3                      ON Chequera.cuentaFondo = CuentaFondo_3.id 	-- 3 LEFT LEVEL: 1
				LEFT JOIN massoftware.CuentaContable AS CuentaContable_6                  ON CuentaFondo_3.cuentaContable = CuentaContable_6.id 	-- 6 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaFondoGrupo AS CuentaFondoGrupo_22                ON CuentaFondo_3.cuentaFondoGrupo = CuentaFondoGrupo_22.id 	-- 22 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaFondoTipo AS CuentaFondoTipo_26                 ON CuentaFondo_3.cuentaFondoTipo = CuentaFondoTipo_26.id 	-- 26 LEFT LEVEL: 2
				LEFT JOIN massoftware.Moneda AS Moneda_34                          ON CuentaFondo_3.moneda = Moneda_34.id 	-- 34 LEFT LEVEL: 2
				LEFT JOIN massoftware.Caja AS Caja_42                            ON CuentaFondo_3.caja = Caja_42.id 	-- 42 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaFondoTipoBanco AS CuentaFondoTipoBanco_48            ON CuentaFondo_3.cuentaFondoTipoBanco = CuentaFondoTipoBanco_48.id 	-- 48 LEFT LEVEL: 2
				LEFT JOIN massoftware.Banco AS Banco_51                           ON CuentaFondo_3.banco = Banco_51.id 	-- 51 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaFondoBancoCopia AS CuentaFondoBancoCopia_71           ON CuentaFondo_3.cuentaFondoBancoCopia = CuentaFondoBancoCopia_71.id 	-- 71 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_75                 ON CuentaFondo_3.seguridadPuertaUso = SeguridadPuerta_75.id 	-- 75 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_80                 ON CuentaFondo_3.seguridadPuertaConsulta = SeguridadPuerta_80.id 	-- 80 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_85                 ON CuentaFondo_3.seguridadPuertaLimite = SeguridadPuerta_85.id 	-- 85 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Chequera.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Chequera.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Chequera.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Chequera.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND cuentaFondoArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(cuentaFondoArg8)) > 0 THEN
		cuentaFondoArg8 = REPLACE(cuentaFondoArg8, '''', '''''');
		cuentaFondoArg8 = LOWER(TRIM(cuentaFondoArg8));
		cuentaFondoArg8 = TRANSLATE(cuentaFondoArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(cuentaFondoArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Chequera.cuentaFondo),
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

DROP FUNCTION IF EXISTS massoftware.f_ChequeraById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ChequeraById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Chequera_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Chequera_2 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Chequera_2 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_ChequeraById_2 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Chequera_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, cuentaFondoArg8   VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Chequera_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, cuentaFondoArg8   VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_Chequera_3 AS $$

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
				  Chequera.id                                  AS Chequera_id                             	-- 0	.id                                                             		VARCHAR(36)
				, Chequera.numero                              AS Chequera_numero                         	-- 1	.numero                                                         		INTEGER
				, Chequera.nombre                              AS Chequera_nombre                         	-- 2	.nombre                                                         		VARCHAR(50)
				, CuentaFondo_3.id                             AS CuentaFondo_3_id                        	-- 3	.CuentaFondo.id                                                 		VARCHAR(36)
				, CuentaFondo_3.numero                         AS CuentaFondo_3_numero                    	-- 4	.CuentaFondo.numero                                             		INTEGER
				, CuentaFondo_3.nombre                         AS CuentaFondo_3_nombre                    	-- 5	.CuentaFondo.nombre                                             		VARCHAR(50)
				, CuentaContable_6.id                          AS CuentaContable_6_id                     	-- 6	.CuentaFondo.CuentaContable.id                                  		VARCHAR(36)
				, CuentaContable_6.codigo                      AS CuentaContable_6_codigo                 	-- 7	.CuentaFondo.CuentaContable.codigo                              		VARCHAR(11)
				, CuentaContable_6.nombre                      AS CuentaContable_6_nombre                 	-- 8	.CuentaFondo.CuentaContable.nombre                              		VARCHAR(50)
				, EjercicioContable_9.id                       AS EjercicioContable_9_id                  	-- 9	.CuentaFondo.CuentaContable.EjercicioContable.id                		VARCHAR(36)
				, EjercicioContable_9.numero                   AS EjercicioContable_9_numero              	-- 10	.CuentaFondo.CuentaContable.EjercicioContable.numero            		INTEGER
				, EjercicioContable_9.apertura                 AS EjercicioContable_9_apertura            	-- 11	.CuentaFondo.CuentaContable.EjercicioContable.apertura          		DATE
				, EjercicioContable_9.cierre                   AS EjercicioContable_9_cierre              	-- 12	.CuentaFondo.CuentaContable.EjercicioContable.cierre            		DATE
				, EjercicioContable_9.cerrado                  AS EjercicioContable_9_cerrado             	-- 13	.CuentaFondo.CuentaContable.EjercicioContable.cerrado           		BOOLEAN
				, EjercicioContable_9.cerradoModulos           AS EjercicioContable_9_cerradoModulos      	-- 14	.CuentaFondo.CuentaContable.EjercicioContable.cerradoModulos    		BOOLEAN
				, EjercicioContable_9.comentario               AS EjercicioContable_9_comentario          	-- 15	.CuentaFondo.CuentaContable.EjercicioContable.comentario        		VARCHAR(250)
				, CuentaContable_6.integra                     AS CuentaContable_6_integra                	-- 16	.CuentaFondo.CuentaContable.integra                             		VARCHAR(16)
				, CuentaContable_6.cuentaJerarquia             AS CuentaContable_6_cuentaJerarquia        	-- 17	.CuentaFondo.CuentaContable.cuentaJerarquia                     		VARCHAR(16)
				, CuentaContable_6.imputable                   AS CuentaContable_6_imputable              	-- 18	.CuentaFondo.CuentaContable.imputable                           		BOOLEAN
				, CuentaContable_6.ajustaPorInflacion          AS CuentaContable_6_ajustaPorInflacion     	-- 19	.CuentaFondo.CuentaContable.ajustaPorInflacion                  		BOOLEAN
				, CuentaContableEstado_20.id                   AS CuentaContableEstado_20_id              	-- 20	.CuentaFondo.CuentaContable.CuentaContableEstado.id             		VARCHAR(36)
				, CuentaContableEstado_20.numero               AS CuentaContableEstado_20_numero          	-- 21	.CuentaFondo.CuentaContable.CuentaContableEstado.numero         		INTEGER
				, CuentaContableEstado_20.nombre               AS CuentaContableEstado_20_nombre          	-- 22	.CuentaFondo.CuentaContable.CuentaContableEstado.nombre         		VARCHAR(50)
				, CuentaContable_6.cuentaConApropiacion        AS CuentaContable_6_cuentaConApropiacion   	-- 23	.CuentaFondo.CuentaContable.cuentaConApropiacion                		BOOLEAN
				, CentroCostoContable_24.id                    AS CentroCostoContable_24_id               	-- 24	.CuentaFondo.CuentaContable.CentroCostoContable.id              		VARCHAR(36)
				, CentroCostoContable_24.numero                AS CentroCostoContable_24_numero           	-- 25	.CuentaFondo.CuentaContable.CentroCostoContable.numero          		INTEGER
				, CentroCostoContable_24.nombre                AS CentroCostoContable_24_nombre           	-- 26	.CuentaFondo.CuentaContable.CentroCostoContable.nombre          		VARCHAR(50)
				, CentroCostoContable_24.abreviatura           AS CentroCostoContable_24_abreviatura      	-- 27	.CuentaFondo.CuentaContable.CentroCostoContable.abreviatura     		VARCHAR(5)
				, CentroCostoContable_24.ejercicioContable     AS CentroCostoContable_24_ejercicioContable	-- 28	.CuentaFondo.CuentaContable.CentroCostoContable.ejercicioContable		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_6.cuentaAgrupadora            AS CuentaContable_6_cuentaAgrupadora       	-- 29	.CuentaFondo.CuentaContable.cuentaAgrupadora                    		VARCHAR(50)
				, CuentaContable_6.porcentaje                  AS CuentaContable_6_porcentaje             	-- 30	.CuentaFondo.CuentaContable.porcentaje                          		DECIMAL(6,3)
				, PuntoEquilibrio_31.id                        AS PuntoEquilibrio_31_id                   	-- 31	.CuentaFondo.CuentaContable.PuntoEquilibrio.id                  		VARCHAR(36)
				, PuntoEquilibrio_31.numero                    AS PuntoEquilibrio_31_numero               	-- 32	.CuentaFondo.CuentaContable.PuntoEquilibrio.numero              		INTEGER
				, PuntoEquilibrio_31.nombre                    AS PuntoEquilibrio_31_nombre               	-- 33	.CuentaFondo.CuentaContable.PuntoEquilibrio.nombre              		VARCHAR(50)
				, PuntoEquilibrio_31.tipoPuntoEquilibrio       AS PuntoEquilibrio_31_tipoPuntoEquilibrio  	-- 34	.CuentaFondo.CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio 		VARCHAR(36)	TipoPuntoEquilibrio.id
				, PuntoEquilibrio_31.ejercicioContable         AS PuntoEquilibrio_31_ejercicioContable    	-- 35	.CuentaFondo.CuentaContable.PuntoEquilibrio.ejercicioContable   		VARCHAR(36)	EjercicioContable.id
				, CostoVenta_36.id                             AS CostoVenta_36_id                        	-- 36	.CuentaFondo.CuentaContable.CostoVenta.id                       		VARCHAR(36)
				, CostoVenta_36.numero                         AS CostoVenta_36_numero                    	-- 37	.CuentaFondo.CuentaContable.CostoVenta.numero                   		INTEGER
				, CostoVenta_36.nombre                         AS CostoVenta_36_nombre                    	-- 38	.CuentaFondo.CuentaContable.CostoVenta.nombre                   		VARCHAR(50)
				, SeguridadPuerta_39.id                        AS SeguridadPuerta_39_id                   	-- 39	.CuentaFondo.CuentaContable.SeguridadPuerta.id                  		VARCHAR(36)
				, SeguridadPuerta_39.numero                    AS SeguridadPuerta_39_numero               	-- 40	.CuentaFondo.CuentaContable.SeguridadPuerta.numero              		INTEGER
				, SeguridadPuerta_39.nombre                    AS SeguridadPuerta_39_nombre               	-- 41	.CuentaFondo.CuentaContable.SeguridadPuerta.nombre              		VARCHAR(50)
				, SeguridadPuerta_39.equate                    AS SeguridadPuerta_39_equate               	-- 42	.CuentaFondo.CuentaContable.SeguridadPuerta.equate              		VARCHAR(30)
				, SeguridadPuerta_39.seguridadModulo           AS SeguridadPuerta_39_seguridadModulo      	-- 43	.CuentaFondo.CuentaContable.SeguridadPuerta.seguridadModulo     		VARCHAR(36)	SeguridadModulo.id
				, CuentaFondoGrupo_44.id                       AS CuentaFondoGrupo_44_id                  	-- 44	.CuentaFondo.CuentaFondoGrupo.id                                		VARCHAR(36)
				, CuentaFondoGrupo_44.numero                   AS CuentaFondoGrupo_44_numero              	-- 45	.CuentaFondo.CuentaFondoGrupo.numero                            		INTEGER
				, CuentaFondoGrupo_44.nombre                   AS CuentaFondoGrupo_44_nombre              	-- 46	.CuentaFondo.CuentaFondoGrupo.nombre                            		VARCHAR(50)
				, CuentaFondoRubro_47.id                       AS CuentaFondoRubro_47_id                  	-- 47	.CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.id               		VARCHAR(36)
				, CuentaFondoRubro_47.numero                   AS CuentaFondoRubro_47_numero              	-- 48	.CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.numero           		INTEGER
				, CuentaFondoRubro_47.nombre                   AS CuentaFondoRubro_47_nombre              	-- 49	.CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.nombre           		VARCHAR(50)
				, CuentaFondoTipo_50.id                        AS CuentaFondoTipo_50_id                   	-- 50	.CuentaFondo.CuentaFondoTipo.id                                 		VARCHAR(36)
				, CuentaFondoTipo_50.numero                    AS CuentaFondoTipo_50_numero               	-- 51	.CuentaFondo.CuentaFondoTipo.numero                             		INTEGER
				, CuentaFondoTipo_50.nombre                    AS CuentaFondoTipo_50_nombre               	-- 52	.CuentaFondo.CuentaFondoTipo.nombre                             		VARCHAR(50)
				, CuentaFondo_3.obsoleto                       AS CuentaFondo_3_obsoleto                  	-- 53	.CuentaFondo.obsoleto                                           		BOOLEAN
				, CuentaFondo_3.noImprimeCaja                  AS CuentaFondo_3_noImprimeCaja             	-- 54	.CuentaFondo.noImprimeCaja                                      		BOOLEAN
				, CuentaFondo_3.ventas                         AS CuentaFondo_3_ventas                    	-- 55	.CuentaFondo.ventas                                             		BOOLEAN
				, CuentaFondo_3.fondos                         AS CuentaFondo_3_fondos                    	-- 56	.CuentaFondo.fondos                                             		BOOLEAN
				, CuentaFondo_3.compras                        AS CuentaFondo_3_compras                   	-- 57	.CuentaFondo.compras                                            		BOOLEAN
				, Moneda_58.id                                 AS Moneda_58_id                            	-- 58	.CuentaFondo.Moneda.id                                          		VARCHAR(36)
				, Moneda_58.numero                             AS Moneda_58_numero                        	-- 59	.CuentaFondo.Moneda.numero                                      		INTEGER
				, Moneda_58.nombre                             AS Moneda_58_nombre                        	-- 60	.CuentaFondo.Moneda.nombre                                      		VARCHAR(50)
				, Moneda_58.abreviatura                        AS Moneda_58_abreviatura                   	-- 61	.CuentaFondo.Moneda.abreviatura                                 		VARCHAR(5)
				, Moneda_58.cotizacion                         AS Moneda_58_cotizacion                    	-- 62	.CuentaFondo.Moneda.cotizacion                                  		DECIMAL(13,5)
				, Moneda_58.cotizacionFecha                    AS Moneda_58_cotizacionFecha               	-- 63	.CuentaFondo.Moneda.cotizacionFecha                             		TIMESTAMP
				, Moneda_58.controlActualizacion               AS Moneda_58_controlActualizacion          	-- 64	.CuentaFondo.Moneda.controlActualizacion                        		BOOLEAN
				, MonedaAFIP_65.id                             AS MonedaAFIP_65_id                        	-- 65	.CuentaFondo.Moneda.MonedaAFIP.id                               		VARCHAR(36)
				, MonedaAFIP_65.codigo                         AS MonedaAFIP_65_codigo                    	-- 66	.CuentaFondo.Moneda.MonedaAFIP.codigo                           		VARCHAR(3)
				, MonedaAFIP_65.nombre                         AS MonedaAFIP_65_nombre                    	-- 67	.CuentaFondo.Moneda.MonedaAFIP.nombre                           		VARCHAR(50)
				, Caja_68.id                                   AS Caja_68_id                              	-- 68	.CuentaFondo.Caja.id                                            		VARCHAR(36)
				, Caja_68.numero                               AS Caja_68_numero                          	-- 69	.CuentaFondo.Caja.numero                                        		INTEGER
				, Caja_68.nombre                               AS Caja_68_nombre                          	-- 70	.CuentaFondo.Caja.nombre                                        		VARCHAR(50)
				, SeguridadPuerta_71.id                        AS SeguridadPuerta_71_id                   	-- 71	.CuentaFondo.Caja.SeguridadPuerta.id                            		VARCHAR(36)
				, SeguridadPuerta_71.numero                    AS SeguridadPuerta_71_numero               	-- 72	.CuentaFondo.Caja.SeguridadPuerta.numero                        		INTEGER
				, SeguridadPuerta_71.nombre                    AS SeguridadPuerta_71_nombre               	-- 73	.CuentaFondo.Caja.SeguridadPuerta.nombre                        		VARCHAR(50)
				, SeguridadPuerta_71.equate                    AS SeguridadPuerta_71_equate               	-- 74	.CuentaFondo.Caja.SeguridadPuerta.equate                        		VARCHAR(30)
				, SeguridadPuerta_71.seguridadModulo           AS SeguridadPuerta_71_seguridadModulo      	-- 75	.CuentaFondo.Caja.SeguridadPuerta.seguridadModulo               		VARCHAR(36)	SeguridadModulo.id
				, CuentaFondo_3.rechazados                     AS CuentaFondo_3_rechazados                	-- 76	.CuentaFondo.rechazados                                         		BOOLEAN
				, CuentaFondo_3.conciliacion                   AS CuentaFondo_3_conciliacion              	-- 77	.CuentaFondo.conciliacion                                       		BOOLEAN
				, CuentaFondoTipoBanco_78.id                   AS CuentaFondoTipoBanco_78_id              	-- 78	.CuentaFondo.CuentaFondoTipoBanco.id                            		VARCHAR(36)
				, CuentaFondoTipoBanco_78.numero               AS CuentaFondoTipoBanco_78_numero          	-- 79	.CuentaFondo.CuentaFondoTipoBanco.numero                        		INTEGER
				, CuentaFondoTipoBanco_78.nombre               AS CuentaFondoTipoBanco_78_nombre          	-- 80	.CuentaFondo.CuentaFondoTipoBanco.nombre                        		VARCHAR(50)
				, Banco_81.id                                  AS Banco_81_id                             	-- 81	.CuentaFondo.Banco.id                                           		VARCHAR(36)
				, Banco_81.numero                              AS Banco_81_numero                         	-- 82	.CuentaFondo.Banco.numero                                       		INTEGER
				, Banco_81.nombre                              AS Banco_81_nombre                         	-- 83	.CuentaFondo.Banco.nombre                                       		VARCHAR(50)
				, Banco_81.cuit                                AS Banco_81_cuit                           	-- 84	.CuentaFondo.Banco.cuit                                         		BIGINT
				, Banco_81.bloqueado                           AS Banco_81_bloqueado                      	-- 85	.CuentaFondo.Banco.bloqueado                                    		BOOLEAN
				, Banco_81.hoja                                AS Banco_81_hoja                           	-- 86	.CuentaFondo.Banco.hoja                                         		INTEGER
				, Banco_81.primeraFila                         AS Banco_81_primeraFila                    	-- 87	.CuentaFondo.Banco.primeraFila                                  		INTEGER
				, Banco_81.ultimaFila                          AS Banco_81_ultimaFila                     	-- 88	.CuentaFondo.Banco.ultimaFila                                   		INTEGER
				, Banco_81.fecha                               AS Banco_81_fecha                          	-- 89	.CuentaFondo.Banco.fecha                                        		VARCHAR(3)
				, Banco_81.descripcion                         AS Banco_81_descripcion                    	-- 90	.CuentaFondo.Banco.descripcion                                  		VARCHAR(3)
				, Banco_81.referencia1                         AS Banco_81_referencia1                    	-- 91	.CuentaFondo.Banco.referencia1                                  		VARCHAR(3)
				, Banco_81.importe                             AS Banco_81_importe                        	-- 92	.CuentaFondo.Banco.importe                                      		VARCHAR(3)
				, Banco_81.referencia2                         AS Banco_81_referencia2                    	-- 93	.CuentaFondo.Banco.referencia2                                  		VARCHAR(3)
				, Banco_81.saldo                               AS Banco_81_saldo                          	-- 94	.CuentaFondo.Banco.saldo                                        		VARCHAR(3)
				, CuentaFondo_3.cuentaBancaria                 AS CuentaFondo_3_cuentaBancaria            	-- 95	.CuentaFondo.cuentaBancaria                                     		VARCHAR(22)
				, CuentaFondo_3.cbu                            AS CuentaFondo_3_cbu                       	-- 96	.CuentaFondo.cbu                                                		VARCHAR(22)
				, CuentaFondo_3.limiteDescubierto              AS CuentaFondo_3_limiteDescubierto         	-- 97	.CuentaFondo.limiteDescubierto                                  		DECIMAL(13,5)
				, CuentaFondo_3.cuentaFondoCaucion             AS CuentaFondo_3_cuentaFondoCaucion        	-- 98	.CuentaFondo.cuentaFondoCaucion                                 		VARCHAR(50)
				, CuentaFondo_3.cuentaFondoDiferidos           AS CuentaFondo_3_cuentaFondoDiferidos      	-- 99	.CuentaFondo.cuentaFondoDiferidos                               		VARCHAR(50)
				, CuentaFondo_3.formato                        AS CuentaFondo_3_formato                   	-- 100	.CuentaFondo.formato                                            		VARCHAR(50)
				, CuentaFondoBancoCopia_101.id                 AS CuentaFondoBancoCopia_101_id            	-- 101	.CuentaFondo.CuentaFondoBancoCopia.id                           		VARCHAR(36)
				, CuentaFondoBancoCopia_101.numero             AS CuentaFondoBancoCopia_101_numero        	-- 102	.CuentaFondo.CuentaFondoBancoCopia.numero                       		INTEGER
				, CuentaFondoBancoCopia_101.nombre             AS CuentaFondoBancoCopia_101_nombre        	-- 103	.CuentaFondo.CuentaFondoBancoCopia.nombre                       		VARCHAR(50)
				, CuentaFondo_3.limiteOperacionIndividual      AS CuentaFondo_3_limiteOperacionIndividual 	-- 104	.CuentaFondo.limiteOperacionIndividual                          		DECIMAL(13,5)
				, SeguridadPuerta_105.id                       AS SeguridadPuerta_105_id                  	-- 105	.CuentaFondo.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_105.numero                   AS SeguridadPuerta_105_numero              	-- 106	.CuentaFondo.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_105.nombre                   AS SeguridadPuerta_105_nombre              	-- 107	.CuentaFondo.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_105.equate                   AS SeguridadPuerta_105_equate              	-- 108	.CuentaFondo.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_109.id                       AS SeguridadModulo_109_id                  	-- 109	.CuentaFondo.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_109.numero                   AS SeguridadModulo_109_numero              	-- 110	.CuentaFondo.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_109.nombre                   AS SeguridadModulo_109_nombre              	-- 111	.CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)
				, SeguridadPuerta_112.id                       AS SeguridadPuerta_112_id                  	-- 112	.CuentaFondo.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_112.numero                   AS SeguridadPuerta_112_numero              	-- 113	.CuentaFondo.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_112.nombre                   AS SeguridadPuerta_112_nombre              	-- 114	.CuentaFondo.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_112.equate                   AS SeguridadPuerta_112_equate              	-- 115	.CuentaFondo.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_116.id                       AS SeguridadModulo_116_id                  	-- 116	.CuentaFondo.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_116.numero                   AS SeguridadModulo_116_numero              	-- 117	.CuentaFondo.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_116.nombre                   AS SeguridadModulo_116_nombre              	-- 118	.CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)
				, SeguridadPuerta_119.id                       AS SeguridadPuerta_119_id                  	-- 119	.CuentaFondo.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_119.numero                   AS SeguridadPuerta_119_numero              	-- 120	.CuentaFondo.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_119.nombre                   AS SeguridadPuerta_119_nombre              	-- 121	.CuentaFondo.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_119.equate                   AS SeguridadPuerta_119_equate              	-- 122	.CuentaFondo.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_123.id                       AS SeguridadModulo_123_id                  	-- 123	.CuentaFondo.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_123.numero                   AS SeguridadModulo_123_numero              	-- 124	.CuentaFondo.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_123.nombre                   AS SeguridadModulo_123_nombre              	-- 125	.CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)
				, Chequera.primerNumero                        AS Chequera_primerNumero                   	-- 126	.primerNumero                                                   		INTEGER
				, Chequera.ultimoNumero                        AS Chequera_ultimoNumero                   	-- 127	.ultimoNumero                                                   		INTEGER
				, Chequera.proximoNumero                       AS Chequera_proximoNumero                  	-- 128	.proximoNumero                                                  		INTEGER
				, Chequera.bloqueado                           AS Chequera_bloqueado                      	-- 129	.bloqueado                                                      		BOOLEAN
				, Chequera.impresionDiferida                   AS Chequera_impresionDiferida              	-- 130	.impresionDiferida                                              		BOOLEAN
				, Chequera.formato                             AS Chequera_formato                        	-- 131	.formato                                                        		VARCHAR(50)

		FROM	massoftware.Chequera
			LEFT JOIN massoftware.CuentaFondo AS CuentaFondo_3                        ON Chequera.cuentaFondo = CuentaFondo_3.id 	-- 3 LEFT LEVEL: 1
				LEFT JOIN massoftware.CuentaContable AS CuentaContable_6                    ON CuentaFondo_3.cuentaContable = CuentaContable_6.id 	-- 6 LEFT LEVEL: 2
					LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_9                 ON CuentaContable_6.ejercicioContable = EjercicioContable_9.id 	-- 9 LEFT LEVEL: 3
					LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_20             ON CuentaContable_6.cuentaContableEstado = CuentaContableEstado_20.id 	-- 20 LEFT LEVEL: 3
					LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_24              ON CuentaContable_6.centroCostoContable = CentroCostoContable_24.id 	-- 24 LEFT LEVEL: 3
					LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_31                  ON CuentaContable_6.puntoEquilibrio = PuntoEquilibrio_31.id 	-- 31 LEFT LEVEL: 3
					LEFT JOIN massoftware.CostoVenta AS CostoVenta_36                       ON CuentaContable_6.costoVenta = CostoVenta_36.id 	-- 36 LEFT LEVEL: 3
					LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_39                  ON CuentaContable_6.seguridadPuerta = SeguridadPuerta_39.id 	-- 39 LEFT LEVEL: 3
				LEFT JOIN massoftware.CuentaFondoGrupo AS CuentaFondoGrupo_44                  ON CuentaFondo_3.cuentaFondoGrupo = CuentaFondoGrupo_44.id 	-- 44 LEFT LEVEL: 2
					LEFT JOIN massoftware.CuentaFondoRubro AS CuentaFondoRubro_47                 ON CuentaFondoGrupo_44.cuentaFondoRubro = CuentaFondoRubro_47.id 	-- 47 LEFT LEVEL: 3
				LEFT JOIN massoftware.CuentaFondoTipo AS CuentaFondoTipo_50                   ON CuentaFondo_3.cuentaFondoTipo = CuentaFondoTipo_50.id 	-- 50 LEFT LEVEL: 2
				LEFT JOIN massoftware.Moneda AS Moneda_58                            ON CuentaFondo_3.moneda = Moneda_58.id 	-- 58 LEFT LEVEL: 2
					LEFT JOIN massoftware.MonedaAFIP AS MonedaAFIP_65                       ON Moneda_58.monedaAFIP = MonedaAFIP_65.id 	-- 65 LEFT LEVEL: 3
				LEFT JOIN massoftware.Caja AS Caja_68                              ON CuentaFondo_3.caja = Caja_68.id 	-- 68 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_71                  ON Caja_68.seguridadPuerta = SeguridadPuerta_71.id 	-- 71 LEFT LEVEL: 3
				LEFT JOIN massoftware.CuentaFondoTipoBanco AS CuentaFondoTipoBanco_78              ON CuentaFondo_3.cuentaFondoTipoBanco = CuentaFondoTipoBanco_78.id 	-- 78 LEFT LEVEL: 2
				LEFT JOIN massoftware.Banco AS Banco_81                             ON CuentaFondo_3.banco = Banco_81.id 	-- 81 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaFondoBancoCopia AS CuentaFondoBancoCopia_101            ON CuentaFondo_3.cuentaFondoBancoCopia = CuentaFondoBancoCopia_101.id 	-- 101 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_105                  ON CuentaFondo_3.seguridadPuertaUso = SeguridadPuerta_105.id 	-- 105 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_109                  ON SeguridadPuerta_105.seguridadModulo = SeguridadModulo_109.id 	-- 109 LEFT LEVEL: 3
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_112                  ON CuentaFondo_3.seguridadPuertaConsulta = SeguridadPuerta_112.id 	-- 112 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_116                  ON SeguridadPuerta_112.seguridadModulo = SeguridadModulo_116.id 	-- 116 LEFT LEVEL: 3
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_119                  ON CuentaFondo_3.seguridadPuertaLimite = SeguridadPuerta_119.id 	-- 119 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_123                  ON SeguridadPuerta_119.seguridadModulo = SeguridadModulo_123.id 	-- 123 LEFT LEVEL: 3

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Chequera.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Chequera.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' Chequera.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Chequera.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND cuentaFondoArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(cuentaFondoArg8)) > 0 THEN
		cuentaFondoArg8 = REPLACE(cuentaFondoArg8, '''', '''''');
		cuentaFondoArg8 = LOWER(TRIM(cuentaFondoArg8));
		cuentaFondoArg8 = TRANSLATE(cuentaFondoArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(cuentaFondoArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(Chequera.cuentaFondo),
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

DROP FUNCTION IF EXISTS massoftware.f_ChequeraById_3 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ChequeraById_3 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Chequera_3 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Chequera_3 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Chequera_3 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_ChequeraById_3 ('xxx'); 