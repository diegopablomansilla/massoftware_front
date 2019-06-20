
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondo                                                                                            //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondo



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.CuentaFondo CASCADE;

CREATE TABLE massoftware.CuentaFondo
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº cuenta
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT CuentaFondo_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Cuenta contable
	cuentaContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.CuentaContable (id), 
	
	-- Grupo
	cuentaFondoGrupo VARCHAR(36)  NOT NULL  REFERENCES massoftware.CuentaFondoGrupo (id), 
	
	-- Tipo
	cuentaFondoTipo VARCHAR(36)  NOT NULL  REFERENCES massoftware.CuentaFondoTipo (id), 
	
	-- Obsoleto
	obsoleto BOOLEAN NOT NULL, 
	
	-- No imprime caja
	noImprimeCaja BOOLEAN NOT NULL, 
	
	-- Ventas
	ventas BOOLEAN NOT NULL, 
	
	-- Fondos
	fondos BOOLEAN NOT NULL, 
	
	-- Compras
	compras BOOLEAN NOT NULL, 
	
	-- Moneda
	moneda VARCHAR(36)  REFERENCES massoftware.Moneda (id), 
	
	-- Caja
	caja VARCHAR(36)  REFERENCES massoftware.Caja (id), 
	
	-- Rechazados
	rechazados BOOLEAN NOT NULL, 
	
	-- Conciliación
	conciliacion BOOLEAN NOT NULL, 
	
	-- Tipo de banco
	cuentaFondoTipoBanco VARCHAR(36)  REFERENCES massoftware.CuentaFondoTipoBanco (id), 
	
	-- banco
	banco VARCHAR(36)  REFERENCES massoftware.Banco (id), 
	
	-- Cuenta bancaria
	cuentaBancaria VARCHAR(22), 
	
	-- CBU
	cbu VARCHAR(22), 
	
	-- Límite descubierto
	limiteDescubierto DECIMAL(13,5) CONSTRAINT CuentaFondo_limiteDescubierto_chk CHECK ( limiteDescubierto >= -9999.9999 AND limiteDescubierto <= 99999.9999  ), 
	
	-- Cuenta fondo caución
	cuentaFondoCaucion VARCHAR(50), 
	
	-- Cuenta fondo diferidos
	cuentaFondoDiferidos VARCHAR(50), 
	
	-- Formato
	formato VARCHAR(50), 
	
	-- Tipo de copias
	cuentaFondoBancoCopia VARCHAR(36)  REFERENCES massoftware.CuentaFondoBancoCopia (id), 
	
	-- Límite operación individual
	limiteOperacionIndividual DECIMAL(13,5) CONSTRAINT CuentaFondo_limiteOperacionIndividual_chk CHECK ( limiteOperacionIndividual >= -9999.9999 AND limiteOperacionIndividual <= 99999.9999  ), 
	
	-- Puerta p/ uso
	seguridadPuertaUso VARCHAR(36)  REFERENCES massoftware.SeguridadPuerta (id), 
	
	-- Puerta p/ consulta
	seguridadPuertaConsulta VARCHAR(36)  REFERENCES massoftware.SeguridadPuerta (id), 
	
	-- Puerta p/ superar límite
	seguridadPuertaLimite VARCHAR(36)  REFERENCES massoftware.SeguridadPuerta (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_CuentaFondo_nombre ON massoftware.CuentaFondo (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCuentaFondo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCuentaFondo() RETURNS TRIGGER AS $formatCuentaFondo$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.cuentaContable := massoftware.white_is_null(NEW.cuentaContable);
	 NEW.cuentaFondoGrupo := massoftware.white_is_null(NEW.cuentaFondoGrupo);
	 NEW.cuentaFondoTipo := massoftware.white_is_null(NEW.cuentaFondoTipo);
	 NEW.moneda := massoftware.white_is_null(NEW.moneda);
	 NEW.caja := massoftware.white_is_null(NEW.caja);
	 NEW.cuentaFondoTipoBanco := massoftware.white_is_null(NEW.cuentaFondoTipoBanco);
	 NEW.banco := massoftware.white_is_null(NEW.banco);
	 NEW.cuentaBancaria := massoftware.white_is_null(NEW.cuentaBancaria);
	 NEW.cbu := massoftware.white_is_null(NEW.cbu);
	 NEW.cuentaFondoCaucion := massoftware.white_is_null(NEW.cuentaFondoCaucion);
	 NEW.cuentaFondoDiferidos := massoftware.white_is_null(NEW.cuentaFondoDiferidos);
	 NEW.formato := massoftware.white_is_null(NEW.formato);
	 NEW.cuentaFondoBancoCopia := massoftware.white_is_null(NEW.cuentaFondoBancoCopia);
	 NEW.seguridadPuertaUso := massoftware.white_is_null(NEW.seguridadPuertaUso);
	 NEW.seguridadPuertaConsulta := massoftware.white_is_null(NEW.seguridadPuertaConsulta);
	 NEW.seguridadPuertaLimite := massoftware.white_is_null(NEW.seguridadPuertaLimite);

	RETURN NEW;
END;
$formatCuentaFondo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCuentaFondo ON massoftware.CuentaFondo CASCADE;

CREATE TRIGGER tgFormatCuentaFondo BEFORE INSERT OR UPDATE
	ON massoftware.CuentaFondo FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatCuentaFondo();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.CuentaFondo;

-- SELECT * FROM massoftware.CuentaFondo LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.CuentaFondo;

-- SELECT * FROM massoftware.CuentaFondo WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_CuentaFondo_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_CuentaFondo_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.CuentaFondo
	WHERE	(numeroArg IS NULL OR CuentaFondo.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_CuentaFondo_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_CuentaFondo_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_CuentaFondo_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.CuentaFondo
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(CuentaFondo.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_CuentaFondo_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CuentaFondo_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CuentaFondo_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.CuentaFondo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CuentaFondo_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CuentaFondo_limiteDescubierto() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CuentaFondo_limiteDescubierto() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(limiteDescubierto),0) + 1)::DECIMAL(13,5) FROM massoftware.CuentaFondo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CuentaFondo_limiteDescubierto();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CuentaFondo_limiteOperacionIndividual() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CuentaFondo_limiteOperacionIndividual() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(limiteOperacionIndividual),0) + 1)::DECIMAL(13,5) FROM massoftware.CuentaFondo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CuentaFondo_limiteOperacionIndividual();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_CuentaFondoById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_CuentaFondoById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.CuentaFondo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondo.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.CuentaFondo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaFondo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondo.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_CuentaFondoById('xxx');

-- SELECT * FROM massoftware.d_CuentaFondoById((SELECT CuentaFondo.id FROM massoftware.CuentaFondo LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_CuentaFondo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaContableArg VARCHAR(36)
		, cuentaFondoGrupoArg VARCHAR(36)
		, cuentaFondoTipoArg VARCHAR(36)
		, obsoletoArg BOOLEAN
		, noImprimeCajaArg BOOLEAN
		, ventasArg BOOLEAN
		, fondosArg BOOLEAN
		, comprasArg BOOLEAN
		, monedaArg VARCHAR(36)
		, cajaArg VARCHAR(36)
		, rechazadosArg BOOLEAN
		, conciliacionArg BOOLEAN
		, cuentaFondoTipoBancoArg VARCHAR(36)
		, bancoArg VARCHAR(36)
		, cuentaBancariaArg VARCHAR(22)
		, cbuArg VARCHAR(22)
		, limiteDescubiertoArg DECIMAL(13,5)
		, cuentaFondoCaucionArg VARCHAR(50)
		, cuentaFondoDiferidosArg VARCHAR(50)
		, formatoArg VARCHAR(50)
		, cuentaFondoBancoCopiaArg VARCHAR(36)
		, limiteOperacionIndividualArg DECIMAL(13,5)
		, seguridadPuertaUsoArg VARCHAR(36)
		, seguridadPuertaConsultaArg VARCHAR(36)
		, seguridadPuertaLimiteArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_CuentaFondo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaContableArg VARCHAR(36)
		, cuentaFondoGrupoArg VARCHAR(36)
		, cuentaFondoTipoArg VARCHAR(36)
		, obsoletoArg BOOLEAN
		, noImprimeCajaArg BOOLEAN
		, ventasArg BOOLEAN
		, fondosArg BOOLEAN
		, comprasArg BOOLEAN
		, monedaArg VARCHAR(36)
		, cajaArg VARCHAR(36)
		, rechazadosArg BOOLEAN
		, conciliacionArg BOOLEAN
		, cuentaFondoTipoBancoArg VARCHAR(36)
		, bancoArg VARCHAR(36)
		, cuentaBancariaArg VARCHAR(22)
		, cbuArg VARCHAR(22)
		, limiteDescubiertoArg DECIMAL(13,5)
		, cuentaFondoCaucionArg VARCHAR(50)
		, cuentaFondoDiferidosArg VARCHAR(50)
		, formatoArg VARCHAR(50)
		, cuentaFondoBancoCopiaArg VARCHAR(36)
		, limiteOperacionIndividualArg DECIMAL(13,5)
		, seguridadPuertaUsoArg VARCHAR(36)
		, seguridadPuertaConsultaArg VARCHAR(36)
		, seguridadPuertaLimiteArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF obsoletoArg IS NULL THEN

		obsoletoArg = false;

	END IF;

	IF noImprimeCajaArg IS NULL THEN

		noImprimeCajaArg = false;

	END IF;

	IF ventasArg IS NULL THEN

		ventasArg = false;

	END IF;

	IF fondosArg IS NULL THEN

		fondosArg = false;

	END IF;

	IF comprasArg IS NULL THEN

		comprasArg = false;

	END IF;

	IF rechazadosArg IS NULL THEN

		rechazadosArg = false;

	END IF;

	IF conciliacionArg IS NULL THEN

		conciliacionArg = false;

	END IF;

	INSERT INTO massoftware.CuentaFondo(id, numero, nombre, cuentaContable, cuentaFondoGrupo, cuentaFondoTipo, obsoleto, noImprimeCaja, ventas, fondos, compras, moneda, caja, rechazados, conciliacion, cuentaFondoTipoBanco, banco, cuentaBancaria, cbu, limiteDescubierto, cuentaFondoCaucion, cuentaFondoDiferidos, formato, cuentaFondoBancoCopia, limiteOperacionIndividual, seguridadPuertaUso, seguridadPuertaConsulta, seguridadPuertaLimite) VALUES (idArg, numeroArg, nombreArg, cuentaContableArg, cuentaFondoGrupoArg, cuentaFondoTipoArg, obsoletoArg, noImprimeCajaArg, ventasArg, fondosArg, comprasArg, monedaArg, cajaArg, rechazadosArg, conciliacionArg, cuentaFondoTipoBancoArg, bancoArg, cuentaBancariaArg, cbuArg, limiteDescubiertoArg, cuentaFondoCaucionArg, cuentaFondoDiferidosArg, formatoArg, cuentaFondoBancoCopiaArg, limiteOperacionIndividualArg, seguridadPuertaUsoArg, seguridadPuertaConsultaArg, seguridadPuertaLimiteArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaFondo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_CuentaFondo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::BOOLEAN
		, null::BOOLEAN
		, null::BOOLEAN
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(22)
		, null::VARCHAR(22)
		, null::DECIMAL(13,5)
		, null::VARCHAR(50)
		, null::VARCHAR(50)
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::DECIMAL(13,5)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_CuentaFondo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaContableArg VARCHAR(36)
		, cuentaFondoGrupoArg VARCHAR(36)
		, cuentaFondoTipoArg VARCHAR(36)
		, obsoletoArg BOOLEAN
		, noImprimeCajaArg BOOLEAN
		, ventasArg BOOLEAN
		, fondosArg BOOLEAN
		, comprasArg BOOLEAN
		, monedaArg VARCHAR(36)
		, cajaArg VARCHAR(36)
		, rechazadosArg BOOLEAN
		, conciliacionArg BOOLEAN
		, cuentaFondoTipoBancoArg VARCHAR(36)
		, bancoArg VARCHAR(36)
		, cuentaBancariaArg VARCHAR(22)
		, cbuArg VARCHAR(22)
		, limiteDescubiertoArg DECIMAL(13,5)
		, cuentaFondoCaucionArg VARCHAR(50)
		, cuentaFondoDiferidosArg VARCHAR(50)
		, formatoArg VARCHAR(50)
		, cuentaFondoBancoCopiaArg VARCHAR(36)
		, limiteOperacionIndividualArg DECIMAL(13,5)
		, seguridadPuertaUsoArg VARCHAR(36)
		, seguridadPuertaConsultaArg VARCHAR(36)
		, seguridadPuertaLimiteArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_CuentaFondo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaContableArg VARCHAR(36)
		, cuentaFondoGrupoArg VARCHAR(36)
		, cuentaFondoTipoArg VARCHAR(36)
		, obsoletoArg BOOLEAN
		, noImprimeCajaArg BOOLEAN
		, ventasArg BOOLEAN
		, fondosArg BOOLEAN
		, comprasArg BOOLEAN
		, monedaArg VARCHAR(36)
		, cajaArg VARCHAR(36)
		, rechazadosArg BOOLEAN
		, conciliacionArg BOOLEAN
		, cuentaFondoTipoBancoArg VARCHAR(36)
		, bancoArg VARCHAR(36)
		, cuentaBancariaArg VARCHAR(22)
		, cbuArg VARCHAR(22)
		, limiteDescubiertoArg DECIMAL(13,5)
		, cuentaFondoCaucionArg VARCHAR(50)
		, cuentaFondoDiferidosArg VARCHAR(50)
		, formatoArg VARCHAR(50)
		, cuentaFondoBancoCopiaArg VARCHAR(36)
		, limiteOperacionIndividualArg DECIMAL(13,5)
		, seguridadPuertaUsoArg VARCHAR(36)
		, seguridadPuertaConsultaArg VARCHAR(36)
		, seguridadPuertaLimiteArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF obsoletoArg IS NULL THEN

		obsoletoArg = false;

	END IF;

	IF noImprimeCajaArg IS NULL THEN

		noImprimeCajaArg = false;

	END IF;

	IF ventasArg IS NULL THEN

		ventasArg = false;

	END IF;

	IF fondosArg IS NULL THEN

		fondosArg = false;

	END IF;

	IF comprasArg IS NULL THEN

		comprasArg = false;

	END IF;

	IF rechazadosArg IS NULL THEN

		rechazadosArg = false;

	END IF;

	IF conciliacionArg IS NULL THEN

		conciliacionArg = false;

	END IF;

	UPDATE massoftware.CuentaFondo SET 
		  numero = numeroArg
		, nombre = nombreArg
		, cuentaContable = cuentaContableArg
		, cuentaFondoGrupo = cuentaFondoGrupoArg
		, cuentaFondoTipo = cuentaFondoTipoArg
		, obsoleto = obsoletoArg
		, noImprimeCaja = noImprimeCajaArg
		, ventas = ventasArg
		, fondos = fondosArg
		, compras = comprasArg
		, moneda = monedaArg
		, caja = cajaArg
		, rechazados = rechazadosArg
		, conciliacion = conciliacionArg
		, cuentaFondoTipoBanco = cuentaFondoTipoBancoArg
		, banco = bancoArg
		, cuentaBancaria = cuentaBancariaArg
		, cbu = cbuArg
		, limiteDescubierto = limiteDescubiertoArg
		, cuentaFondoCaucion = cuentaFondoCaucionArg
		, cuentaFondoDiferidos = cuentaFondoDiferidosArg
		, formato = formatoArg
		, cuentaFondoBancoCopia = cuentaFondoBancoCopiaArg
		, limiteOperacionIndividual = limiteOperacionIndividualArg
		, seguridadPuertaUso = seguridadPuertaUsoArg
		, seguridadPuertaConsulta = seguridadPuertaConsultaArg
		, seguridadPuertaLimite = seguridadPuertaLimiteArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaFondo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_CuentaFondo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::BOOLEAN
		, null::BOOLEAN
		, null::BOOLEAN
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(22)
		, null::VARCHAR(22)
		, null::DECIMAL(13,5)
		, null::VARCHAR(50)
		, null::VARCHAR(50)
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::DECIMAL(13,5)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/

DROP TYPE IF EXISTS massoftware.t_CuentaFondo_1 CASCADE;

CREATE TYPE massoftware.t_CuentaFondo_1 AS (

	  CuentaFondo_id                       	VARCHAR(36)  		-- 0	CuentaFondo.id
	, CuentaFondo_numero                   	INTEGER      		-- 1	CuentaFondo.numero
	, CuentaFondo_nombre                   	VARCHAR(50)  		-- 2	CuentaFondo.nombre
	, CuentaContable_3_id                  	VARCHAR(36)  		-- 3	CuentaFondo.CuentaContable.id
	, CuentaContable_3_codigo              	VARCHAR(11)  		-- 4	CuentaFondo.CuentaContable.codigo
	, CuentaContable_3_nombre              	VARCHAR(50)  		-- 5	CuentaFondo.CuentaContable.nombre
	, CuentaContable_3_ejercicioContable   	VARCHAR(36)  		-- 6	CuentaFondo.CuentaContable.ejercicioContable
	, CuentaContable_3_integra             	VARCHAR(16)  		-- 7	CuentaFondo.CuentaContable.integra
	, CuentaContable_3_cuentaJerarquia     	VARCHAR(16)  		-- 8	CuentaFondo.CuentaContable.cuentaJerarquia
	, CuentaContable_3_imputable           	BOOLEAN      		-- 9	CuentaFondo.CuentaContable.imputable
	, CuentaContable_3_ajustaPorInflacion  	BOOLEAN      		-- 10	CuentaFondo.CuentaContable.ajustaPorInflacion
	, CuentaContable_3_cuentaContableEstado	VARCHAR(36)  		-- 11	CuentaFondo.CuentaContable.cuentaContableEstado
	, CuentaContable_3_cuentaConApropiacion	BOOLEAN      		-- 12	CuentaFondo.CuentaContable.cuentaConApropiacion
	, CuentaContable_3_centroCostoContable 	VARCHAR(36)  		-- 13	CuentaFondo.CuentaContable.centroCostoContable
	, CuentaContable_3_cuentaAgrupadora    	VARCHAR(50)  		-- 14	CuentaFondo.CuentaContable.cuentaAgrupadora
	, CuentaContable_3_porcentaje          	DECIMAL(6,3) 		-- 15	CuentaFondo.CuentaContable.porcentaje
	, CuentaContable_3_puntoEquilibrio     	VARCHAR(36)  		-- 16	CuentaFondo.CuentaContable.puntoEquilibrio
	, CuentaContable_3_costoVenta          	VARCHAR(36)  		-- 17	CuentaFondo.CuentaContable.costoVenta
	, CuentaContable_3_seguridadPuerta     	VARCHAR(36)  		-- 18	CuentaFondo.CuentaContable.seguridadPuerta
	, CuentaFondoGrupo_19_id               	VARCHAR(36)  		-- 19	CuentaFondo.CuentaFondoGrupo.id
	, CuentaFondoGrupo_19_numero           	INTEGER      		-- 20	CuentaFondo.CuentaFondoGrupo.numero
	, CuentaFondoGrupo_19_nombre           	VARCHAR(50)  		-- 21	CuentaFondo.CuentaFondoGrupo.nombre
	, CuentaFondoGrupo_19_cuentaFondoRubro 	VARCHAR(36)  		-- 22	CuentaFondo.CuentaFondoGrupo.cuentaFondoRubro
	, CuentaFondoTipo_23_id                	VARCHAR(36)  		-- 23	CuentaFondo.CuentaFondoTipo.id
	, CuentaFondoTipo_23_numero            	INTEGER      		-- 24	CuentaFondo.CuentaFondoTipo.numero
	, CuentaFondoTipo_23_nombre            	VARCHAR(50)  		-- 25	CuentaFondo.CuentaFondoTipo.nombre
	, CuentaFondo_obsoleto                 	BOOLEAN      		-- 26	CuentaFondo.obsoleto
	, CuentaFondo_noImprimeCaja            	BOOLEAN      		-- 27	CuentaFondo.noImprimeCaja
	, CuentaFondo_ventas                   	BOOLEAN      		-- 28	CuentaFondo.ventas
	, CuentaFondo_fondos                   	BOOLEAN      		-- 29	CuentaFondo.fondos
	, CuentaFondo_compras                  	BOOLEAN      		-- 30	CuentaFondo.compras
	, Moneda_31_id                         	VARCHAR(36)  		-- 31	CuentaFondo.Moneda.id
	, Moneda_31_numero                     	INTEGER      		-- 32	CuentaFondo.Moneda.numero
	, Moneda_31_nombre                     	VARCHAR(50)  		-- 33	CuentaFondo.Moneda.nombre
	, Moneda_31_abreviatura                	VARCHAR(5)   		-- 34	CuentaFondo.Moneda.abreviatura
	, Moneda_31_cotizacion                 	DECIMAL(13,5)		-- 35	CuentaFondo.Moneda.cotizacion
	, Moneda_31_cotizacionFecha            	TIMESTAMP    		-- 36	CuentaFondo.Moneda.cotizacionFecha
	, Moneda_31_controlActualizacion       	BOOLEAN      		-- 37	CuentaFondo.Moneda.controlActualizacion
	, Moneda_31_monedaAFIP                 	VARCHAR(36)  		-- 38	CuentaFondo.Moneda.monedaAFIP
	, Caja_39_id                           	VARCHAR(36)  		-- 39	CuentaFondo.Caja.id
	, Caja_39_numero                       	INTEGER      		-- 40	CuentaFondo.Caja.numero
	, Caja_39_nombre                       	VARCHAR(50)  		-- 41	CuentaFondo.Caja.nombre
	, Caja_39_seguridadPuerta              	VARCHAR(36)  		-- 42	CuentaFondo.Caja.seguridadPuerta
	, CuentaFondo_rechazados               	BOOLEAN      		-- 43	CuentaFondo.rechazados
	, CuentaFondo_conciliacion             	BOOLEAN      		-- 44	CuentaFondo.conciliacion
	, CuentaFondoTipoBanco_45_id           	VARCHAR(36)  		-- 45	CuentaFondo.CuentaFondoTipoBanco.id
	, CuentaFondoTipoBanco_45_numero       	INTEGER      		-- 46	CuentaFondo.CuentaFondoTipoBanco.numero
	, CuentaFondoTipoBanco_45_nombre       	VARCHAR(50)  		-- 47	CuentaFondo.CuentaFondoTipoBanco.nombre
	, Banco_48_id                          	VARCHAR(36)  		-- 48	CuentaFondo.Banco.id
	, Banco_48_numero                      	INTEGER      		-- 49	CuentaFondo.Banco.numero
	, Banco_48_nombre                      	VARCHAR(50)  		-- 50	CuentaFondo.Banco.nombre
	, Banco_48_cuit                        	BIGINT       		-- 51	CuentaFondo.Banco.cuit
	, Banco_48_bloqueado                   	BOOLEAN      		-- 52	CuentaFondo.Banco.bloqueado
	, Banco_48_hoja                        	INTEGER      		-- 53	CuentaFondo.Banco.hoja
	, Banco_48_primeraFila                 	INTEGER      		-- 54	CuentaFondo.Banco.primeraFila
	, Banco_48_ultimaFila                  	INTEGER      		-- 55	CuentaFondo.Banco.ultimaFila
	, Banco_48_fecha                       	VARCHAR(3)   		-- 56	CuentaFondo.Banco.fecha
	, Banco_48_descripcion                 	VARCHAR(3)   		-- 57	CuentaFondo.Banco.descripcion
	, Banco_48_referencia1                 	VARCHAR(3)   		-- 58	CuentaFondo.Banco.referencia1
	, Banco_48_importe                     	VARCHAR(3)   		-- 59	CuentaFondo.Banco.importe
	, Banco_48_referencia2                 	VARCHAR(3)   		-- 60	CuentaFondo.Banco.referencia2
	, Banco_48_saldo                       	VARCHAR(3)   		-- 61	CuentaFondo.Banco.saldo
	, CuentaFondo_cuentaBancaria           	VARCHAR(22)  		-- 62	CuentaFondo.cuentaBancaria
	, CuentaFondo_cbu                      	VARCHAR(22)  		-- 63	CuentaFondo.cbu
	, CuentaFondo_limiteDescubierto        	DECIMAL(13,5)		-- 64	CuentaFondo.limiteDescubierto
	, CuentaFondo_cuentaFondoCaucion       	VARCHAR(50)  		-- 65	CuentaFondo.cuentaFondoCaucion
	, CuentaFondo_cuentaFondoDiferidos     	VARCHAR(50)  		-- 66	CuentaFondo.cuentaFondoDiferidos
	, CuentaFondo_formato                  	VARCHAR(50)  		-- 67	CuentaFondo.formato
	, CuentaFondoBancoCopia_68_id          	VARCHAR(36)  		-- 68	CuentaFondo.CuentaFondoBancoCopia.id
	, CuentaFondoBancoCopia_68_numero      	INTEGER      		-- 69	CuentaFondo.CuentaFondoBancoCopia.numero
	, CuentaFondoBancoCopia_68_nombre      	VARCHAR(50)  		-- 70	CuentaFondo.CuentaFondoBancoCopia.nombre
	, CuentaFondo_limiteOperacionIndividual	DECIMAL(13,5)		-- 71	CuentaFondo.limiteOperacionIndividual
	, SeguridadPuerta_72_id                	VARCHAR(36)  		-- 72	CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_72_numero            	INTEGER      		-- 73	CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_72_nombre            	VARCHAR(50)  		-- 74	CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_72_equate            	VARCHAR(30)  		-- 75	CuentaFondo.SeguridadPuerta.equate
	, SeguridadPuerta_72_seguridadModulo   	VARCHAR(36)  		-- 76	CuentaFondo.SeguridadPuerta.seguridadModulo
	, SeguridadPuerta_77_id                	VARCHAR(36)  		-- 77	CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_77_numero            	INTEGER      		-- 78	CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_77_nombre            	VARCHAR(50)  		-- 79	CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_77_equate            	VARCHAR(30)  		-- 80	CuentaFondo.SeguridadPuerta.equate
	, SeguridadPuerta_77_seguridadModulo   	VARCHAR(36)  		-- 81	CuentaFondo.SeguridadPuerta.seguridadModulo
	, SeguridadPuerta_82_id                	VARCHAR(36)  		-- 82	CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_82_numero            	INTEGER      		-- 83	CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_82_nombre            	VARCHAR(50)  		-- 84	CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_82_equate            	VARCHAR(30)  		-- 85	CuentaFondo.SeguridadPuerta.equate
	, SeguridadPuerta_82_seguridadModulo   	VARCHAR(36)  		-- 86	CuentaFondo.SeguridadPuerta.seguridadModulo

);

DROP TYPE IF EXISTS massoftware.t_CuentaFondo_2 CASCADE;

CREATE TYPE massoftware.t_CuentaFondo_2 AS (

	  CuentaFondo_id                          	VARCHAR(36)  		-- 0	CuentaFondo.id
	, CuentaFondo_numero                      	INTEGER      		-- 1	CuentaFondo.numero
	, CuentaFondo_nombre                      	VARCHAR(50)  		-- 2	CuentaFondo.nombre
	, CuentaContable_3_id                     	VARCHAR(36)  		-- 3	CuentaFondo.CuentaContable.id
	, CuentaContable_3_codigo                 	VARCHAR(11)  		-- 4	CuentaFondo.CuentaContable.codigo
	, CuentaContable_3_nombre                 	VARCHAR(50)  		-- 5	CuentaFondo.CuentaContable.nombre
	, EjercicioContable_6_id                  	VARCHAR(36)  		-- 6	CuentaFondo.CuentaContable.EjercicioContable.id
	, EjercicioContable_6_numero              	INTEGER      		-- 7	CuentaFondo.CuentaContable.EjercicioContable.numero
	, EjercicioContable_6_apertura            	DATE         		-- 8	CuentaFondo.CuentaContable.EjercicioContable.apertura
	, EjercicioContable_6_cierre              	DATE         		-- 9	CuentaFondo.CuentaContable.EjercicioContable.cierre
	, EjercicioContable_6_cerrado             	BOOLEAN      		-- 10	CuentaFondo.CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_6_cerradoModulos      	BOOLEAN      		-- 11	CuentaFondo.CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_6_comentario          	VARCHAR(250) 		-- 12	CuentaFondo.CuentaContable.EjercicioContable.comentario
	, CuentaContable_3_integra                	VARCHAR(16)  		-- 13	CuentaFondo.CuentaContable.integra
	, CuentaContable_3_cuentaJerarquia        	VARCHAR(16)  		-- 14	CuentaFondo.CuentaContable.cuentaJerarquia
	, CuentaContable_3_imputable              	BOOLEAN      		-- 15	CuentaFondo.CuentaContable.imputable
	, CuentaContable_3_ajustaPorInflacion     	BOOLEAN      		-- 16	CuentaFondo.CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_17_id              	VARCHAR(36)  		-- 17	CuentaFondo.CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_17_numero          	INTEGER      		-- 18	CuentaFondo.CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_17_nombre          	VARCHAR(50)  		-- 19	CuentaFondo.CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_3_cuentaConApropiacion   	BOOLEAN      		-- 20	CuentaFondo.CuentaContable.cuentaConApropiacion
	, CentroCostoContable_21_id               	VARCHAR(36)  		-- 21	CuentaFondo.CuentaContable.CentroCostoContable.id
	, CentroCostoContable_21_numero           	INTEGER      		-- 22	CuentaFondo.CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_21_nombre           	VARCHAR(50)  		-- 23	CuentaFondo.CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_21_abreviatura      	VARCHAR(5)   		-- 24	CuentaFondo.CuentaContable.CentroCostoContable.abreviatura
	, CentroCostoContable_21_ejercicioContable	VARCHAR(36)  		-- 25	CuentaFondo.CuentaContable.CentroCostoContable.ejercicioContable
	, CuentaContable_3_cuentaAgrupadora       	VARCHAR(50)  		-- 26	CuentaFondo.CuentaContable.cuentaAgrupadora
	, CuentaContable_3_porcentaje             	DECIMAL(6,3) 		-- 27	CuentaFondo.CuentaContable.porcentaje
	, PuntoEquilibrio_28_id                   	VARCHAR(36)  		-- 28	CuentaFondo.CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_28_numero               	INTEGER      		-- 29	CuentaFondo.CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_28_nombre               	VARCHAR(50)  		-- 30	CuentaFondo.CuentaContable.PuntoEquilibrio.nombre
	, PuntoEquilibrio_28_tipoPuntoEquilibrio  	VARCHAR(36)  		-- 31	CuentaFondo.CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio
	, PuntoEquilibrio_28_ejercicioContable    	VARCHAR(36)  		-- 32	CuentaFondo.CuentaContable.PuntoEquilibrio.ejercicioContable
	, CostoVenta_33_id                        	VARCHAR(36)  		-- 33	CuentaFondo.CuentaContable.CostoVenta.id
	, CostoVenta_33_numero                    	INTEGER      		-- 34	CuentaFondo.CuentaContable.CostoVenta.numero
	, CostoVenta_33_nombre                    	VARCHAR(50)  		-- 35	CuentaFondo.CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_36_id                   	VARCHAR(36)  		-- 36	CuentaFondo.CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_36_numero               	INTEGER      		-- 37	CuentaFondo.CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_36_nombre               	VARCHAR(50)  		-- 38	CuentaFondo.CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_36_equate               	VARCHAR(30)  		-- 39	CuentaFondo.CuentaContable.SeguridadPuerta.equate
	, SeguridadPuerta_36_seguridadModulo      	VARCHAR(36)  		-- 40	CuentaFondo.CuentaContable.SeguridadPuerta.seguridadModulo
	, CuentaFondoGrupo_41_id                  	VARCHAR(36)  		-- 41	CuentaFondo.CuentaFondoGrupo.id
	, CuentaFondoGrupo_41_numero              	INTEGER      		-- 42	CuentaFondo.CuentaFondoGrupo.numero
	, CuentaFondoGrupo_41_nombre              	VARCHAR(50)  		-- 43	CuentaFondo.CuentaFondoGrupo.nombre
	, CuentaFondoRubro_44_id                  	VARCHAR(36)  		-- 44	CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.id
	, CuentaFondoRubro_44_numero              	INTEGER      		-- 45	CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.numero
	, CuentaFondoRubro_44_nombre              	VARCHAR(50)  		-- 46	CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.nombre
	, CuentaFondoTipo_47_id                   	VARCHAR(36)  		-- 47	CuentaFondo.CuentaFondoTipo.id
	, CuentaFondoTipo_47_numero               	INTEGER      		-- 48	CuentaFondo.CuentaFondoTipo.numero
	, CuentaFondoTipo_47_nombre               	VARCHAR(50)  		-- 49	CuentaFondo.CuentaFondoTipo.nombre
	, CuentaFondo_obsoleto                    	BOOLEAN      		-- 50	CuentaFondo.obsoleto
	, CuentaFondo_noImprimeCaja               	BOOLEAN      		-- 51	CuentaFondo.noImprimeCaja
	, CuentaFondo_ventas                      	BOOLEAN      		-- 52	CuentaFondo.ventas
	, CuentaFondo_fondos                      	BOOLEAN      		-- 53	CuentaFondo.fondos
	, CuentaFondo_compras                     	BOOLEAN      		-- 54	CuentaFondo.compras
	, Moneda_55_id                            	VARCHAR(36)  		-- 55	CuentaFondo.Moneda.id
	, Moneda_55_numero                        	INTEGER      		-- 56	CuentaFondo.Moneda.numero
	, Moneda_55_nombre                        	VARCHAR(50)  		-- 57	CuentaFondo.Moneda.nombre
	, Moneda_55_abreviatura                   	VARCHAR(5)   		-- 58	CuentaFondo.Moneda.abreviatura
	, Moneda_55_cotizacion                    	DECIMAL(13,5)		-- 59	CuentaFondo.Moneda.cotizacion
	, Moneda_55_cotizacionFecha               	TIMESTAMP    		-- 60	CuentaFondo.Moneda.cotizacionFecha
	, Moneda_55_controlActualizacion          	BOOLEAN      		-- 61	CuentaFondo.Moneda.controlActualizacion
	, MonedaAFIP_62_id                        	VARCHAR(36)  		-- 62	CuentaFondo.Moneda.MonedaAFIP.id
	, MonedaAFIP_62_codigo                    	VARCHAR(3)   		-- 63	CuentaFondo.Moneda.MonedaAFIP.codigo
	, MonedaAFIP_62_nombre                    	VARCHAR(50)  		-- 64	CuentaFondo.Moneda.MonedaAFIP.nombre
	, Caja_65_id                              	VARCHAR(36)  		-- 65	CuentaFondo.Caja.id
	, Caja_65_numero                          	INTEGER      		-- 66	CuentaFondo.Caja.numero
	, Caja_65_nombre                          	VARCHAR(50)  		-- 67	CuentaFondo.Caja.nombre
	, SeguridadPuerta_68_id                   	VARCHAR(36)  		-- 68	CuentaFondo.Caja.SeguridadPuerta.id
	, SeguridadPuerta_68_numero               	INTEGER      		-- 69	CuentaFondo.Caja.SeguridadPuerta.numero
	, SeguridadPuerta_68_nombre               	VARCHAR(50)  		-- 70	CuentaFondo.Caja.SeguridadPuerta.nombre
	, SeguridadPuerta_68_equate               	VARCHAR(30)  		-- 71	CuentaFondo.Caja.SeguridadPuerta.equate
	, SeguridadPuerta_68_seguridadModulo      	VARCHAR(36)  		-- 72	CuentaFondo.Caja.SeguridadPuerta.seguridadModulo
	, CuentaFondo_rechazados                  	BOOLEAN      		-- 73	CuentaFondo.rechazados
	, CuentaFondo_conciliacion                	BOOLEAN      		-- 74	CuentaFondo.conciliacion
	, CuentaFondoTipoBanco_75_id              	VARCHAR(36)  		-- 75	CuentaFondo.CuentaFondoTipoBanco.id
	, CuentaFondoTipoBanco_75_numero          	INTEGER      		-- 76	CuentaFondo.CuentaFondoTipoBanco.numero
	, CuentaFondoTipoBanco_75_nombre          	VARCHAR(50)  		-- 77	CuentaFondo.CuentaFondoTipoBanco.nombre
	, Banco_78_id                             	VARCHAR(36)  		-- 78	CuentaFondo.Banco.id
	, Banco_78_numero                         	INTEGER      		-- 79	CuentaFondo.Banco.numero
	, Banco_78_nombre                         	VARCHAR(50)  		-- 80	CuentaFondo.Banco.nombre
	, Banco_78_cuit                           	BIGINT       		-- 81	CuentaFondo.Banco.cuit
	, Banco_78_bloqueado                      	BOOLEAN      		-- 82	CuentaFondo.Banco.bloqueado
	, Banco_78_hoja                           	INTEGER      		-- 83	CuentaFondo.Banco.hoja
	, Banco_78_primeraFila                    	INTEGER      		-- 84	CuentaFondo.Banco.primeraFila
	, Banco_78_ultimaFila                     	INTEGER      		-- 85	CuentaFondo.Banco.ultimaFila
	, Banco_78_fecha                          	VARCHAR(3)   		-- 86	CuentaFondo.Banco.fecha
	, Banco_78_descripcion                    	VARCHAR(3)   		-- 87	CuentaFondo.Banco.descripcion
	, Banco_78_referencia1                    	VARCHAR(3)   		-- 88	CuentaFondo.Banco.referencia1
	, Banco_78_importe                        	VARCHAR(3)   		-- 89	CuentaFondo.Banco.importe
	, Banco_78_referencia2                    	VARCHAR(3)   		-- 90	CuentaFondo.Banco.referencia2
	, Banco_78_saldo                          	VARCHAR(3)   		-- 91	CuentaFondo.Banco.saldo
	, CuentaFondo_cuentaBancaria              	VARCHAR(22)  		-- 92	CuentaFondo.cuentaBancaria
	, CuentaFondo_cbu                         	VARCHAR(22)  		-- 93	CuentaFondo.cbu
	, CuentaFondo_limiteDescubierto           	DECIMAL(13,5)		-- 94	CuentaFondo.limiteDescubierto
	, CuentaFondo_cuentaFondoCaucion          	VARCHAR(50)  		-- 95	CuentaFondo.cuentaFondoCaucion
	, CuentaFondo_cuentaFondoDiferidos        	VARCHAR(50)  		-- 96	CuentaFondo.cuentaFondoDiferidos
	, CuentaFondo_formato                     	VARCHAR(50)  		-- 97	CuentaFondo.formato
	, CuentaFondoBancoCopia_98_id             	VARCHAR(36)  		-- 98	CuentaFondo.CuentaFondoBancoCopia.id
	, CuentaFondoBancoCopia_98_numero         	INTEGER      		-- 99	CuentaFondo.CuentaFondoBancoCopia.numero
	, CuentaFondoBancoCopia_98_nombre         	VARCHAR(50)  		-- 100	CuentaFondo.CuentaFondoBancoCopia.nombre
	, CuentaFondo_limiteOperacionIndividual   	DECIMAL(13,5)		-- 101	CuentaFondo.limiteOperacionIndividual
	, SeguridadPuerta_102_id                  	VARCHAR(36)  		-- 102	CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_102_numero              	INTEGER      		-- 103	CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_102_nombre              	VARCHAR(50)  		-- 104	CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_102_equate              	VARCHAR(30)  		-- 105	CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_106_id                  	VARCHAR(36)  		-- 106	CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_106_numero              	INTEGER      		-- 107	CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_106_nombre              	VARCHAR(50)  		-- 108	CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre
	, SeguridadPuerta_109_id                  	VARCHAR(36)  		-- 109	CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_109_numero              	INTEGER      		-- 110	CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_109_nombre              	VARCHAR(50)  		-- 111	CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_109_equate              	VARCHAR(30)  		-- 112	CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_113_id                  	VARCHAR(36)  		-- 113	CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_113_numero              	INTEGER      		-- 114	CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_113_nombre              	VARCHAR(50)  		-- 115	CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre
	, SeguridadPuerta_116_id                  	VARCHAR(36)  		-- 116	CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_116_numero              	INTEGER      		-- 117	CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_116_nombre              	VARCHAR(50)  		-- 118	CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_116_equate              	VARCHAR(30)  		-- 119	CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_120_id                  	VARCHAR(36)  		-- 120	CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_120_numero              	INTEGER      		-- 121	CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_120_nombre              	VARCHAR(50)  		-- 122	CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre

);

DROP TYPE IF EXISTS massoftware.t_CuentaFondo_3 CASCADE;

CREATE TYPE massoftware.t_CuentaFondo_3 AS (

	  CuentaFondo_id                       	VARCHAR(36)  		-- 0	CuentaFondo.id
	, CuentaFondo_numero                   	INTEGER      		-- 1	CuentaFondo.numero
	, CuentaFondo_nombre                   	VARCHAR(50)  		-- 2	CuentaFondo.nombre
	, CuentaContable_3_id                  	VARCHAR(36)  		-- 3	CuentaFondo.CuentaContable.id
	, CuentaContable_3_codigo              	VARCHAR(11)  		-- 4	CuentaFondo.CuentaContable.codigo
	, CuentaContable_3_nombre              	VARCHAR(50)  		-- 5	CuentaFondo.CuentaContable.nombre
	, EjercicioContable_6_id               	VARCHAR(36)  		-- 6	CuentaFondo.CuentaContable.EjercicioContable.id
	, EjercicioContable_6_numero           	INTEGER      		-- 7	CuentaFondo.CuentaContable.EjercicioContable.numero
	, EjercicioContable_6_apertura         	DATE         		-- 8	CuentaFondo.CuentaContable.EjercicioContable.apertura
	, EjercicioContable_6_cierre           	DATE         		-- 9	CuentaFondo.CuentaContable.EjercicioContable.cierre
	, EjercicioContable_6_cerrado          	BOOLEAN      		-- 10	CuentaFondo.CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_6_cerradoModulos   	BOOLEAN      		-- 11	CuentaFondo.CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_6_comentario       	VARCHAR(250) 		-- 12	CuentaFondo.CuentaContable.EjercicioContable.comentario
	, CuentaContable_3_integra             	VARCHAR(16)  		-- 13	CuentaFondo.CuentaContable.integra
	, CuentaContable_3_cuentaJerarquia     	VARCHAR(16)  		-- 14	CuentaFondo.CuentaContable.cuentaJerarquia
	, CuentaContable_3_imputable           	BOOLEAN      		-- 15	CuentaFondo.CuentaContable.imputable
	, CuentaContable_3_ajustaPorInflacion  	BOOLEAN      		-- 16	CuentaFondo.CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_17_id           	VARCHAR(36)  		-- 17	CuentaFondo.CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_17_numero       	INTEGER      		-- 18	CuentaFondo.CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_17_nombre       	VARCHAR(50)  		-- 19	CuentaFondo.CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_3_cuentaConApropiacion	BOOLEAN      		-- 20	CuentaFondo.CuentaContable.cuentaConApropiacion
	, CentroCostoContable_21_id            	VARCHAR(36)  		-- 21	CuentaFondo.CuentaContable.CentroCostoContable.id
	, CentroCostoContable_21_numero        	INTEGER      		-- 22	CuentaFondo.CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_21_nombre        	VARCHAR(50)  		-- 23	CuentaFondo.CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_21_abreviatura   	VARCHAR(5)   		-- 24	CuentaFondo.CuentaContable.CentroCostoContable.abreviatura
	, EjercicioContable_25_id              	VARCHAR(36)  		-- 25	CuentaFondo.CuentaContable.CentroCostoContable.EjercicioContable.id
	, EjercicioContable_25_numero          	INTEGER      		-- 26	CuentaFondo.CuentaContable.CentroCostoContable.EjercicioContable.numero
	, EjercicioContable_25_apertura        	DATE         		-- 27	CuentaFondo.CuentaContable.CentroCostoContable.EjercicioContable.apertura
	, EjercicioContable_25_cierre          	DATE         		-- 28	CuentaFondo.CuentaContable.CentroCostoContable.EjercicioContable.cierre
	, EjercicioContable_25_cerrado         	BOOLEAN      		-- 29	CuentaFondo.CuentaContable.CentroCostoContable.EjercicioContable.cerrado
	, EjercicioContable_25_cerradoModulos  	BOOLEAN      		-- 30	CuentaFondo.CuentaContable.CentroCostoContable.EjercicioContable.cerradoModulos
	, EjercicioContable_25_comentario      	VARCHAR(250) 		-- 31	CuentaFondo.CuentaContable.CentroCostoContable.EjercicioContable.comentario
	, CuentaContable_3_cuentaAgrupadora    	VARCHAR(50)  		-- 32	CuentaFondo.CuentaContable.cuentaAgrupadora
	, CuentaContable_3_porcentaje          	DECIMAL(6,3) 		-- 33	CuentaFondo.CuentaContable.porcentaje
	, PuntoEquilibrio_34_id                	VARCHAR(36)  		-- 34	CuentaFondo.CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_34_numero            	INTEGER      		-- 35	CuentaFondo.CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_34_nombre            	VARCHAR(50)  		-- 36	CuentaFondo.CuentaContable.PuntoEquilibrio.nombre
	, TipoPuntoEquilibrio_37_id            	VARCHAR(36)  		-- 37	CuentaFondo.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.id
	, TipoPuntoEquilibrio_37_numero        	INTEGER      		-- 38	CuentaFondo.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.numero
	, TipoPuntoEquilibrio_37_nombre        	VARCHAR(50)  		-- 39	CuentaFondo.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.nombre
	, EjercicioContable_40_id              	VARCHAR(36)  		-- 40	CuentaFondo.CuentaContable.PuntoEquilibrio.EjercicioContable.id
	, EjercicioContable_40_numero          	INTEGER      		-- 41	CuentaFondo.CuentaContable.PuntoEquilibrio.EjercicioContable.numero
	, EjercicioContable_40_apertura        	DATE         		-- 42	CuentaFondo.CuentaContable.PuntoEquilibrio.EjercicioContable.apertura
	, EjercicioContable_40_cierre          	DATE         		-- 43	CuentaFondo.CuentaContable.PuntoEquilibrio.EjercicioContable.cierre
	, EjercicioContable_40_cerrado         	BOOLEAN      		-- 44	CuentaFondo.CuentaContable.PuntoEquilibrio.EjercicioContable.cerrado
	, EjercicioContable_40_cerradoModulos  	BOOLEAN      		-- 45	CuentaFondo.CuentaContable.PuntoEquilibrio.EjercicioContable.cerradoModulos
	, EjercicioContable_40_comentario      	VARCHAR(250) 		-- 46	CuentaFondo.CuentaContable.PuntoEquilibrio.EjercicioContable.comentario
	, CostoVenta_47_id                     	VARCHAR(36)  		-- 47	CuentaFondo.CuentaContable.CostoVenta.id
	, CostoVenta_47_numero                 	INTEGER      		-- 48	CuentaFondo.CuentaContable.CostoVenta.numero
	, CostoVenta_47_nombre                 	VARCHAR(50)  		-- 49	CuentaFondo.CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_50_id                	VARCHAR(36)  		-- 50	CuentaFondo.CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_50_numero            	INTEGER      		-- 51	CuentaFondo.CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_50_nombre            	VARCHAR(50)  		-- 52	CuentaFondo.CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_50_equate            	VARCHAR(30)  		-- 53	CuentaFondo.CuentaContable.SeguridadPuerta.equate
	, SeguridadModulo_54_id                	VARCHAR(36)  		-- 54	CuentaFondo.CuentaContable.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_54_numero            	INTEGER      		-- 55	CuentaFondo.CuentaContable.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_54_nombre            	VARCHAR(50)  		-- 56	CuentaFondo.CuentaContable.SeguridadPuerta.SeguridadModulo.nombre
	, CuentaFondoGrupo_57_id               	VARCHAR(36)  		-- 57	CuentaFondo.CuentaFondoGrupo.id
	, CuentaFondoGrupo_57_numero           	INTEGER      		-- 58	CuentaFondo.CuentaFondoGrupo.numero
	, CuentaFondoGrupo_57_nombre           	VARCHAR(50)  		-- 59	CuentaFondo.CuentaFondoGrupo.nombre
	, CuentaFondoRubro_60_id               	VARCHAR(36)  		-- 60	CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.id
	, CuentaFondoRubro_60_numero           	INTEGER      		-- 61	CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.numero
	, CuentaFondoRubro_60_nombre           	VARCHAR(50)  		-- 62	CuentaFondo.CuentaFondoGrupo.CuentaFondoRubro.nombre
	, CuentaFondoTipo_63_id                	VARCHAR(36)  		-- 63	CuentaFondo.CuentaFondoTipo.id
	, CuentaFondoTipo_63_numero            	INTEGER      		-- 64	CuentaFondo.CuentaFondoTipo.numero
	, CuentaFondoTipo_63_nombre            	VARCHAR(50)  		-- 65	CuentaFondo.CuentaFondoTipo.nombre
	, CuentaFondo_obsoleto                 	BOOLEAN      		-- 66	CuentaFondo.obsoleto
	, CuentaFondo_noImprimeCaja            	BOOLEAN      		-- 67	CuentaFondo.noImprimeCaja
	, CuentaFondo_ventas                   	BOOLEAN      		-- 68	CuentaFondo.ventas
	, CuentaFondo_fondos                   	BOOLEAN      		-- 69	CuentaFondo.fondos
	, CuentaFondo_compras                  	BOOLEAN      		-- 70	CuentaFondo.compras
	, Moneda_71_id                         	VARCHAR(36)  		-- 71	CuentaFondo.Moneda.id
	, Moneda_71_numero                     	INTEGER      		-- 72	CuentaFondo.Moneda.numero
	, Moneda_71_nombre                     	VARCHAR(50)  		-- 73	CuentaFondo.Moneda.nombre
	, Moneda_71_abreviatura                	VARCHAR(5)   		-- 74	CuentaFondo.Moneda.abreviatura
	, Moneda_71_cotizacion                 	DECIMAL(13,5)		-- 75	CuentaFondo.Moneda.cotizacion
	, Moneda_71_cotizacionFecha            	TIMESTAMP    		-- 76	CuentaFondo.Moneda.cotizacionFecha
	, Moneda_71_controlActualizacion       	BOOLEAN      		-- 77	CuentaFondo.Moneda.controlActualizacion
	, MonedaAFIP_78_id                     	VARCHAR(36)  		-- 78	CuentaFondo.Moneda.MonedaAFIP.id
	, MonedaAFIP_78_codigo                 	VARCHAR(3)   		-- 79	CuentaFondo.Moneda.MonedaAFIP.codigo
	, MonedaAFIP_78_nombre                 	VARCHAR(50)  		-- 80	CuentaFondo.Moneda.MonedaAFIP.nombre
	, Caja_81_id                           	VARCHAR(36)  		-- 81	CuentaFondo.Caja.id
	, Caja_81_numero                       	INTEGER      		-- 82	CuentaFondo.Caja.numero
	, Caja_81_nombre                       	VARCHAR(50)  		-- 83	CuentaFondo.Caja.nombre
	, SeguridadPuerta_84_id                	VARCHAR(36)  		-- 84	CuentaFondo.Caja.SeguridadPuerta.id
	, SeguridadPuerta_84_numero            	INTEGER      		-- 85	CuentaFondo.Caja.SeguridadPuerta.numero
	, SeguridadPuerta_84_nombre            	VARCHAR(50)  		-- 86	CuentaFondo.Caja.SeguridadPuerta.nombre
	, SeguridadPuerta_84_equate            	VARCHAR(30)  		-- 87	CuentaFondo.Caja.SeguridadPuerta.equate
	, SeguridadModulo_88_id                	VARCHAR(36)  		-- 88	CuentaFondo.Caja.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_88_numero            	INTEGER      		-- 89	CuentaFondo.Caja.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_88_nombre            	VARCHAR(50)  		-- 90	CuentaFondo.Caja.SeguridadPuerta.SeguridadModulo.nombre
	, CuentaFondo_rechazados               	BOOLEAN      		-- 91	CuentaFondo.rechazados
	, CuentaFondo_conciliacion             	BOOLEAN      		-- 92	CuentaFondo.conciliacion
	, CuentaFondoTipoBanco_93_id           	VARCHAR(36)  		-- 93	CuentaFondo.CuentaFondoTipoBanco.id
	, CuentaFondoTipoBanco_93_numero       	INTEGER      		-- 94	CuentaFondo.CuentaFondoTipoBanco.numero
	, CuentaFondoTipoBanco_93_nombre       	VARCHAR(50)  		-- 95	CuentaFondo.CuentaFondoTipoBanco.nombre
	, Banco_96_id                          	VARCHAR(36)  		-- 96	CuentaFondo.Banco.id
	, Banco_96_numero                      	INTEGER      		-- 97	CuentaFondo.Banco.numero
	, Banco_96_nombre                      	VARCHAR(50)  		-- 98	CuentaFondo.Banco.nombre
	, Banco_96_cuit                        	BIGINT       		-- 99	CuentaFondo.Banco.cuit
	, Banco_96_bloqueado                   	BOOLEAN      		-- 100	CuentaFondo.Banco.bloqueado
	, Banco_96_hoja                        	INTEGER      		-- 101	CuentaFondo.Banco.hoja
	, Banco_96_primeraFila                 	INTEGER      		-- 102	CuentaFondo.Banco.primeraFila
	, Banco_96_ultimaFila                  	INTEGER      		-- 103	CuentaFondo.Banco.ultimaFila
	, Banco_96_fecha                       	VARCHAR(3)   		-- 104	CuentaFondo.Banco.fecha
	, Banco_96_descripcion                 	VARCHAR(3)   		-- 105	CuentaFondo.Banco.descripcion
	, Banco_96_referencia1                 	VARCHAR(3)   		-- 106	CuentaFondo.Banco.referencia1
	, Banco_96_importe                     	VARCHAR(3)   		-- 107	CuentaFondo.Banco.importe
	, Banco_96_referencia2                 	VARCHAR(3)   		-- 108	CuentaFondo.Banco.referencia2
	, Banco_96_saldo                       	VARCHAR(3)   		-- 109	CuentaFondo.Banco.saldo
	, CuentaFondo_cuentaBancaria           	VARCHAR(22)  		-- 110	CuentaFondo.cuentaBancaria
	, CuentaFondo_cbu                      	VARCHAR(22)  		-- 111	CuentaFondo.cbu
	, CuentaFondo_limiteDescubierto        	DECIMAL(13,5)		-- 112	CuentaFondo.limiteDescubierto
	, CuentaFondo_cuentaFondoCaucion       	VARCHAR(50)  		-- 113	CuentaFondo.cuentaFondoCaucion
	, CuentaFondo_cuentaFondoDiferidos     	VARCHAR(50)  		-- 114	CuentaFondo.cuentaFondoDiferidos
	, CuentaFondo_formato                  	VARCHAR(50)  		-- 115	CuentaFondo.formato
	, CuentaFondoBancoCopia_116_id         	VARCHAR(36)  		-- 116	CuentaFondo.CuentaFondoBancoCopia.id
	, CuentaFondoBancoCopia_116_numero     	INTEGER      		-- 117	CuentaFondo.CuentaFondoBancoCopia.numero
	, CuentaFondoBancoCopia_116_nombre     	VARCHAR(50)  		-- 118	CuentaFondo.CuentaFondoBancoCopia.nombre
	, CuentaFondo_limiteOperacionIndividual	DECIMAL(13,5)		-- 119	CuentaFondo.limiteOperacionIndividual
	, SeguridadPuerta_120_id               	VARCHAR(36)  		-- 120	CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_120_numero           	INTEGER      		-- 121	CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_120_nombre           	VARCHAR(50)  		-- 122	CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_120_equate           	VARCHAR(30)  		-- 123	CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_124_id               	VARCHAR(36)  		-- 124	CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_124_numero           	INTEGER      		-- 125	CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_124_nombre           	VARCHAR(50)  		-- 126	CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre
	, SeguridadPuerta_127_id               	VARCHAR(36)  		-- 127	CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_127_numero           	INTEGER      		-- 128	CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_127_nombre           	VARCHAR(50)  		-- 129	CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_127_equate           	VARCHAR(30)  		-- 130	CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_131_id               	VARCHAR(36)  		-- 131	CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_131_numero           	INTEGER      		-- 132	CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_131_nombre           	VARCHAR(50)  		-- 133	CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre
	, SeguridadPuerta_134_id               	VARCHAR(36)  		-- 134	CuentaFondo.SeguridadPuerta.id
	, SeguridadPuerta_134_numero           	INTEGER      		-- 135	CuentaFondo.SeguridadPuerta.numero
	, SeguridadPuerta_134_nombre           	VARCHAR(50)  		-- 136	CuentaFondo.SeguridadPuerta.nombre
	, SeguridadPuerta_134_equate           	VARCHAR(30)  		-- 137	CuentaFondo.SeguridadPuerta.equate
	, SeguridadModulo_138_id               	VARCHAR(36)  		-- 138	CuentaFondo.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_138_numero           	INTEGER      		-- 139	CuentaFondo.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_138_nombre           	VARCHAR(50)  		-- 140	CuentaFondo.SeguridadPuerta.SeguridadModulo.nombre

);

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondo (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, bancoArg8         VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondo (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, bancoArg8         VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.CuentaFondo AS $$

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
				  CuentaFondo.id                            AS CuentaFondo_id                       	-- 0	.id                      		VARCHAR(36)
				, CuentaFondo.numero                        AS CuentaFondo_numero                   	-- 1	.numero                  		INTEGER
				, CuentaFondo.nombre                        AS CuentaFondo_nombre                   	-- 2	.nombre                  		VARCHAR(50)
				, CuentaFondo.cuentaContable                AS CuentaFondo_cuentaContable           	-- 3	.cuentaContable          		VARCHAR(36)	CuentaContable.id
				, CuentaFondo.cuentaFondoGrupo              AS CuentaFondo_cuentaFondoGrupo         	-- 4	.cuentaFondoGrupo        		VARCHAR(36)	CuentaFondoGrupo.id
				, CuentaFondo.cuentaFondoTipo               AS CuentaFondo_cuentaFondoTipo          	-- 5	.cuentaFondoTipo         		VARCHAR(36)	CuentaFondoTipo.id
				, CuentaFondo.obsoleto                      AS CuentaFondo_obsoleto                 	-- 6	.obsoleto                		BOOLEAN
				, CuentaFondo.noImprimeCaja                 AS CuentaFondo_noImprimeCaja            	-- 7	.noImprimeCaja           		BOOLEAN
				, CuentaFondo.ventas                        AS CuentaFondo_ventas                   	-- 8	.ventas                  		BOOLEAN
				, CuentaFondo.fondos                        AS CuentaFondo_fondos                   	-- 9	.fondos                  		BOOLEAN
				, CuentaFondo.compras                       AS CuentaFondo_compras                  	-- 10	.compras                 		BOOLEAN
				, CuentaFondo.moneda                        AS CuentaFondo_moneda                   	-- 11	.moneda                  		VARCHAR(36)	Moneda.id
				, CuentaFondo.caja                          AS CuentaFondo_caja                     	-- 12	.caja                    		VARCHAR(36)	Caja.id
				, CuentaFondo.rechazados                    AS CuentaFondo_rechazados               	-- 13	.rechazados              		BOOLEAN
				, CuentaFondo.conciliacion                  AS CuentaFondo_conciliacion             	-- 14	.conciliacion            		BOOLEAN
				, CuentaFondo.cuentaFondoTipoBanco          AS CuentaFondo_cuentaFondoTipoBanco     	-- 15	.cuentaFondoTipoBanco    		VARCHAR(36)	CuentaFondoTipoBanco.id
				, CuentaFondo.banco                         AS CuentaFondo_banco                    	-- 16	.banco                   		VARCHAR(36)	Banco.id
				, CuentaFondo.cuentaBancaria                AS CuentaFondo_cuentaBancaria           	-- 17	.cuentaBancaria          		VARCHAR(22)
				, CuentaFondo.cbu                           AS CuentaFondo_cbu                      	-- 18	.cbu                     		VARCHAR(22)
				, CuentaFondo.limiteDescubierto             AS CuentaFondo_limiteDescubierto        	-- 19	.limiteDescubierto       		DECIMAL(13,5)
				, CuentaFondo.cuentaFondoCaucion            AS CuentaFondo_cuentaFondoCaucion       	-- 20	.cuentaFondoCaucion      		VARCHAR(50)
				, CuentaFondo.cuentaFondoDiferidos          AS CuentaFondo_cuentaFondoDiferidos     	-- 21	.cuentaFondoDiferidos    		VARCHAR(50)
				, CuentaFondo.formato                       AS CuentaFondo_formato                  	-- 22	.formato                 		VARCHAR(50)
				, CuentaFondo.cuentaFondoBancoCopia         AS CuentaFondo_cuentaFondoBancoCopia    	-- 23	.cuentaFondoBancoCopia   		VARCHAR(36)	CuentaFondoBancoCopia.id
				, CuentaFondo.limiteOperacionIndividual     AS CuentaFondo_limiteOperacionIndividual	-- 24	.limiteOperacionIndividual		DECIMAL(13,5)
				, CuentaFondo.seguridadPuertaUso            AS CuentaFondo_seguridadPuertaUso       	-- 25	.seguridadPuertaUso      		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondo.seguridadPuertaConsulta       AS CuentaFondo_seguridadPuertaConsulta  	-- 26	.seguridadPuertaConsulta 		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondo.seguridadPuertaLimite         AS CuentaFondo_seguridadPuertaLimite    	-- 27	.seguridadPuertaLimite   		VARCHAR(36)	SeguridadPuerta.id

		FROM	massoftware.CuentaFondo

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondo.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND bancoArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(bancoArg8)) > 0 THEN
		bancoArg8 = REPLACE(bancoArg8, '''', '''''');
		bancoArg8 = LOWER(TRIM(bancoArg8));
		bancoArg8 = TRANSLATE(bancoArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(bancoArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondo.banco),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoById (idArg VARCHAR(36)) RETURNS SETOF massoftware.CuentaFondo AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaFondo ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaFondo ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaFondoById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondo_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, bancoArg8         VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondo_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, bancoArg8         VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_CuentaFondo_1 AS $$

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
				  CuentaFondo.id                            AS CuentaFondo_id                       	-- 0	.id                                		VARCHAR(36)
				, CuentaFondo.numero                        AS CuentaFondo_numero                   	-- 1	.numero                            		INTEGER
				, CuentaFondo.nombre                        AS CuentaFondo_nombre                   	-- 2	.nombre                            		VARCHAR(50)
				, CuentaContable_3.id                       AS CuentaContable_3_id                  	-- 3	.CuentaContable.id                 		VARCHAR(36)
				, CuentaContable_3.codigo                   AS CuentaContable_3_codigo              	-- 4	.CuentaContable.codigo             		VARCHAR(11)
				, CuentaContable_3.nombre                   AS CuentaContable_3_nombre              	-- 5	.CuentaContable.nombre             		VARCHAR(50)
				, CuentaContable_3.ejercicioContable        AS CuentaContable_3_ejercicioContable   	-- 6	.CuentaContable.ejercicioContable  		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_3.integra                  AS CuentaContable_3_integra             	-- 7	.CuentaContable.integra            		VARCHAR(16)
				, CuentaContable_3.cuentaJerarquia          AS CuentaContable_3_cuentaJerarquia     	-- 8	.CuentaContable.cuentaJerarquia    		VARCHAR(16)
				, CuentaContable_3.imputable                AS CuentaContable_3_imputable           	-- 9	.CuentaContable.imputable          		BOOLEAN
				, CuentaContable_3.ajustaPorInflacion       AS CuentaContable_3_ajustaPorInflacion  	-- 10	.CuentaContable.ajustaPorInflacion 		BOOLEAN
				, CuentaContable_3.cuentaContableEstado     AS CuentaContable_3_cuentaContableEstado	-- 11	.CuentaContable.cuentaContableEstado		VARCHAR(36)	CuentaContableEstado.id
				, CuentaContable_3.cuentaConApropiacion     AS CuentaContable_3_cuentaConApropiacion	-- 12	.CuentaContable.cuentaConApropiacion		BOOLEAN
				, CuentaContable_3.centroCostoContable      AS CuentaContable_3_centroCostoContable 	-- 13	.CuentaContable.centroCostoContable		VARCHAR(36)	CentroCostoContable.id
				, CuentaContable_3.cuentaAgrupadora         AS CuentaContable_3_cuentaAgrupadora    	-- 14	.CuentaContable.cuentaAgrupadora   		VARCHAR(50)
				, CuentaContable_3.porcentaje               AS CuentaContable_3_porcentaje          	-- 15	.CuentaContable.porcentaje         		DECIMAL(6,3)
				, CuentaContable_3.puntoEquilibrio          AS CuentaContable_3_puntoEquilibrio     	-- 16	.CuentaContable.puntoEquilibrio    		VARCHAR(36)	PuntoEquilibrio.id
				, CuentaContable_3.costoVenta               AS CuentaContable_3_costoVenta          	-- 17	.CuentaContable.costoVenta         		VARCHAR(36)	CostoVenta.id
				, CuentaContable_3.seguridadPuerta          AS CuentaContable_3_seguridadPuerta     	-- 18	.CuentaContable.seguridadPuerta    		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondoGrupo_19.id                    AS CuentaFondoGrupo_19_id               	-- 19	.CuentaFondoGrupo.id               		VARCHAR(36)
				, CuentaFondoGrupo_19.numero                AS CuentaFondoGrupo_19_numero           	-- 20	.CuentaFondoGrupo.numero           		INTEGER
				, CuentaFondoGrupo_19.nombre                AS CuentaFondoGrupo_19_nombre           	-- 21	.CuentaFondoGrupo.nombre           		VARCHAR(50)
				, CuentaFondoGrupo_19.cuentaFondoRubro      AS CuentaFondoGrupo_19_cuentaFondoRubro 	-- 22	.CuentaFondoGrupo.cuentaFondoRubro 		VARCHAR(36)	CuentaFondoRubro.id
				, CuentaFondoTipo_23.id                     AS CuentaFondoTipo_23_id                	-- 23	.CuentaFondoTipo.id                		VARCHAR(36)
				, CuentaFondoTipo_23.numero                 AS CuentaFondoTipo_23_numero            	-- 24	.CuentaFondoTipo.numero            		INTEGER
				, CuentaFondoTipo_23.nombre                 AS CuentaFondoTipo_23_nombre            	-- 25	.CuentaFondoTipo.nombre            		VARCHAR(50)
				, CuentaFondo.obsoleto                      AS CuentaFondo_obsoleto                 	-- 26	.obsoleto                          		BOOLEAN
				, CuentaFondo.noImprimeCaja                 AS CuentaFondo_noImprimeCaja            	-- 27	.noImprimeCaja                     		BOOLEAN
				, CuentaFondo.ventas                        AS CuentaFondo_ventas                   	-- 28	.ventas                            		BOOLEAN
				, CuentaFondo.fondos                        AS CuentaFondo_fondos                   	-- 29	.fondos                            		BOOLEAN
				, CuentaFondo.compras                       AS CuentaFondo_compras                  	-- 30	.compras                           		BOOLEAN
				, Moneda_31.id                              AS Moneda_31_id                         	-- 31	.Moneda.id                         		VARCHAR(36)
				, Moneda_31.numero                          AS Moneda_31_numero                     	-- 32	.Moneda.numero                     		INTEGER
				, Moneda_31.nombre                          AS Moneda_31_nombre                     	-- 33	.Moneda.nombre                     		VARCHAR(50)
				, Moneda_31.abreviatura                     AS Moneda_31_abreviatura                	-- 34	.Moneda.abreviatura                		VARCHAR(5)
				, Moneda_31.cotizacion                      AS Moneda_31_cotizacion                 	-- 35	.Moneda.cotizacion                 		DECIMAL(13,5)
				, Moneda_31.cotizacionFecha                 AS Moneda_31_cotizacionFecha            	-- 36	.Moneda.cotizacionFecha            		TIMESTAMP
				, Moneda_31.controlActualizacion            AS Moneda_31_controlActualizacion       	-- 37	.Moneda.controlActualizacion       		BOOLEAN
				, Moneda_31.monedaAFIP                      AS Moneda_31_monedaAFIP                 	-- 38	.Moneda.monedaAFIP                 		VARCHAR(36)	MonedaAFIP.id
				, Caja_39.id                                AS Caja_39_id                           	-- 39	.Caja.id                           		VARCHAR(36)
				, Caja_39.numero                            AS Caja_39_numero                       	-- 40	.Caja.numero                       		INTEGER
				, Caja_39.nombre                            AS Caja_39_nombre                       	-- 41	.Caja.nombre                       		VARCHAR(50)
				, Caja_39.seguridadPuerta                   AS Caja_39_seguridadPuerta              	-- 42	.Caja.seguridadPuerta              		VARCHAR(36)	SeguridadPuerta.id
				, CuentaFondo.rechazados                    AS CuentaFondo_rechazados               	-- 43	.rechazados                        		BOOLEAN
				, CuentaFondo.conciliacion                  AS CuentaFondo_conciliacion             	-- 44	.conciliacion                      		BOOLEAN
				, CuentaFondoTipoBanco_45.id                AS CuentaFondoTipoBanco_45_id           	-- 45	.CuentaFondoTipoBanco.id           		VARCHAR(36)
				, CuentaFondoTipoBanco_45.numero            AS CuentaFondoTipoBanco_45_numero       	-- 46	.CuentaFondoTipoBanco.numero       		INTEGER
				, CuentaFondoTipoBanco_45.nombre            AS CuentaFondoTipoBanco_45_nombre       	-- 47	.CuentaFondoTipoBanco.nombre       		VARCHAR(50)
				, Banco_48.id                               AS Banco_48_id                          	-- 48	.Banco.id                          		VARCHAR(36)
				, Banco_48.numero                           AS Banco_48_numero                      	-- 49	.Banco.numero                      		INTEGER
				, Banco_48.nombre                           AS Banco_48_nombre                      	-- 50	.Banco.nombre                      		VARCHAR(50)
				, Banco_48.cuit                             AS Banco_48_cuit                        	-- 51	.Banco.cuit                        		BIGINT
				, Banco_48.bloqueado                        AS Banco_48_bloqueado                   	-- 52	.Banco.bloqueado                   		BOOLEAN
				, Banco_48.hoja                             AS Banco_48_hoja                        	-- 53	.Banco.hoja                        		INTEGER
				, Banco_48.primeraFila                      AS Banco_48_primeraFila                 	-- 54	.Banco.primeraFila                 		INTEGER
				, Banco_48.ultimaFila                       AS Banco_48_ultimaFila                  	-- 55	.Banco.ultimaFila                  		INTEGER
				, Banco_48.fecha                            AS Banco_48_fecha                       	-- 56	.Banco.fecha                       		VARCHAR(3)
				, Banco_48.descripcion                      AS Banco_48_descripcion                 	-- 57	.Banco.descripcion                 		VARCHAR(3)
				, Banco_48.referencia1                      AS Banco_48_referencia1                 	-- 58	.Banco.referencia1                 		VARCHAR(3)
				, Banco_48.importe                          AS Banco_48_importe                     	-- 59	.Banco.importe                     		VARCHAR(3)
				, Banco_48.referencia2                      AS Banco_48_referencia2                 	-- 60	.Banco.referencia2                 		VARCHAR(3)
				, Banco_48.saldo                            AS Banco_48_saldo                       	-- 61	.Banco.saldo                       		VARCHAR(3)
				, CuentaFondo.cuentaBancaria                AS CuentaFondo_cuentaBancaria           	-- 62	.cuentaBancaria                    		VARCHAR(22)
				, CuentaFondo.cbu                           AS CuentaFondo_cbu                      	-- 63	.cbu                               		VARCHAR(22)
				, CuentaFondo.limiteDescubierto             AS CuentaFondo_limiteDescubierto        	-- 64	.limiteDescubierto                 		DECIMAL(13,5)
				, CuentaFondo.cuentaFondoCaucion            AS CuentaFondo_cuentaFondoCaucion       	-- 65	.cuentaFondoCaucion                		VARCHAR(50)
				, CuentaFondo.cuentaFondoDiferidos          AS CuentaFondo_cuentaFondoDiferidos     	-- 66	.cuentaFondoDiferidos              		VARCHAR(50)
				, CuentaFondo.formato                       AS CuentaFondo_formato                  	-- 67	.formato                           		VARCHAR(50)
				, CuentaFondoBancoCopia_68.id               AS CuentaFondoBancoCopia_68_id          	-- 68	.CuentaFondoBancoCopia.id          		VARCHAR(36)
				, CuentaFondoBancoCopia_68.numero           AS CuentaFondoBancoCopia_68_numero      	-- 69	.CuentaFondoBancoCopia.numero      		INTEGER
				, CuentaFondoBancoCopia_68.nombre           AS CuentaFondoBancoCopia_68_nombre      	-- 70	.CuentaFondoBancoCopia.nombre      		VARCHAR(50)
				, CuentaFondo.limiteOperacionIndividual     AS CuentaFondo_limiteOperacionIndividual	-- 71	.limiteOperacionIndividual         		DECIMAL(13,5)
				, SeguridadPuerta_72.id                     AS SeguridadPuerta_72_id                	-- 72	.SeguridadPuerta.id                		VARCHAR(36)
				, SeguridadPuerta_72.numero                 AS SeguridadPuerta_72_numero            	-- 73	.SeguridadPuerta.numero            		INTEGER
				, SeguridadPuerta_72.nombre                 AS SeguridadPuerta_72_nombre            	-- 74	.SeguridadPuerta.nombre            		VARCHAR(50)
				, SeguridadPuerta_72.equate                 AS SeguridadPuerta_72_equate            	-- 75	.SeguridadPuerta.equate            		VARCHAR(30)
				, SeguridadPuerta_72.seguridadModulo        AS SeguridadPuerta_72_seguridadModulo   	-- 76	.SeguridadPuerta.seguridadModulo   		VARCHAR(36)	SeguridadModulo.id
				, SeguridadPuerta_77.id                     AS SeguridadPuerta_77_id                	-- 77	.SeguridadPuerta.id                		VARCHAR(36)
				, SeguridadPuerta_77.numero                 AS SeguridadPuerta_77_numero            	-- 78	.SeguridadPuerta.numero            		INTEGER
				, SeguridadPuerta_77.nombre                 AS SeguridadPuerta_77_nombre            	-- 79	.SeguridadPuerta.nombre            		VARCHAR(50)
				, SeguridadPuerta_77.equate                 AS SeguridadPuerta_77_equate            	-- 80	.SeguridadPuerta.equate            		VARCHAR(30)
				, SeguridadPuerta_77.seguridadModulo        AS SeguridadPuerta_77_seguridadModulo   	-- 81	.SeguridadPuerta.seguridadModulo   		VARCHAR(36)	SeguridadModulo.id
				, SeguridadPuerta_82.id                     AS SeguridadPuerta_82_id                	-- 82	.SeguridadPuerta.id                		VARCHAR(36)
				, SeguridadPuerta_82.numero                 AS SeguridadPuerta_82_numero            	-- 83	.SeguridadPuerta.numero            		INTEGER
				, SeguridadPuerta_82.nombre                 AS SeguridadPuerta_82_nombre            	-- 84	.SeguridadPuerta.nombre            		VARCHAR(50)
				, SeguridadPuerta_82.equate                 AS SeguridadPuerta_82_equate            	-- 85	.SeguridadPuerta.equate            		VARCHAR(30)
				, SeguridadPuerta_82.seguridadModulo        AS SeguridadPuerta_82_seguridadModulo   	-- 86	.SeguridadPuerta.seguridadModulo   		VARCHAR(36)	SeguridadModulo.id

		FROM	massoftware.CuentaFondo
			LEFT JOIN massoftware.CuentaContable AS CuentaContable_3                ON CuentaFondo.cuentaContable = CuentaContable_3.id 	-- 3 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaFondoGrupo AS CuentaFondoGrupo_19             ON CuentaFondo.cuentaFondoGrupo = CuentaFondoGrupo_19.id 	-- 19 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaFondoTipo AS CuentaFondoTipo_23              ON CuentaFondo.cuentaFondoTipo = CuentaFondoTipo_23.id 	-- 23 LEFT LEVEL: 1
			LEFT JOIN massoftware.Moneda AS Moneda_31                       ON CuentaFondo.moneda = Moneda_31.id 	-- 31 LEFT LEVEL: 1
			LEFT JOIN massoftware.Caja AS Caja_39                         ON CuentaFondo.caja = Caja_39.id 	-- 39 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaFondoTipoBanco AS CuentaFondoTipoBanco_45         ON CuentaFondo.cuentaFondoTipoBanco = CuentaFondoTipoBanco_45.id 	-- 45 LEFT LEVEL: 1
			LEFT JOIN massoftware.Banco AS Banco_48                        ON CuentaFondo.banco = Banco_48.id 	-- 48 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaFondoBancoCopia AS CuentaFondoBancoCopia_68        ON CuentaFondo.cuentaFondoBancoCopia = CuentaFondoBancoCopia_68.id 	-- 68 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_72              ON CuentaFondo.seguridadPuertaUso = SeguridadPuerta_72.id 	-- 72 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_77              ON CuentaFondo.seguridadPuertaConsulta = SeguridadPuerta_77.id 	-- 77 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_82              ON CuentaFondo.seguridadPuertaLimite = SeguridadPuerta_82.id 	-- 82 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondo.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND bancoArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(bancoArg8)) > 0 THEN
		bancoArg8 = REPLACE(bancoArg8, '''', '''''');
		bancoArg8 = LOWER(TRIM(bancoArg8));
		bancoArg8 = TRANSLATE(bancoArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(bancoArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondo.banco),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_CuentaFondo_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaFondo_1 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaFondo_1 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaFondoById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondo_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, bancoArg8         VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondo_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, bancoArg8         VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_CuentaFondo_2 AS $$

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
				  CuentaFondo.id                               AS CuentaFondo_id                          	-- 0	.id                                                 		VARCHAR(36)
				, CuentaFondo.numero                           AS CuentaFondo_numero                      	-- 1	.numero                                             		INTEGER
				, CuentaFondo.nombre                           AS CuentaFondo_nombre                      	-- 2	.nombre                                             		VARCHAR(50)
				, CuentaContable_3.id                          AS CuentaContable_3_id                     	-- 3	.CuentaContable.id                                  		VARCHAR(36)
				, CuentaContable_3.codigo                      AS CuentaContable_3_codigo                 	-- 4	.CuentaContable.codigo                              		VARCHAR(11)
				, CuentaContable_3.nombre                      AS CuentaContable_3_nombre                 	-- 5	.CuentaContable.nombre                              		VARCHAR(50)
				, EjercicioContable_6.id                       AS EjercicioContable_6_id                  	-- 6	.CuentaContable.EjercicioContable.id                		VARCHAR(36)
				, EjercicioContable_6.numero                   AS EjercicioContable_6_numero              	-- 7	.CuentaContable.EjercicioContable.numero            		INTEGER
				, EjercicioContable_6.apertura                 AS EjercicioContable_6_apertura            	-- 8	.CuentaContable.EjercicioContable.apertura          		DATE
				, EjercicioContable_6.cierre                   AS EjercicioContable_6_cierre              	-- 9	.CuentaContable.EjercicioContable.cierre            		DATE
				, EjercicioContable_6.cerrado                  AS EjercicioContable_6_cerrado             	-- 10	.CuentaContable.EjercicioContable.cerrado           		BOOLEAN
				, EjercicioContable_6.cerradoModulos           AS EjercicioContable_6_cerradoModulos      	-- 11	.CuentaContable.EjercicioContable.cerradoModulos    		BOOLEAN
				, EjercicioContable_6.comentario               AS EjercicioContable_6_comentario          	-- 12	.CuentaContable.EjercicioContable.comentario        		VARCHAR(250)
				, CuentaContable_3.integra                     AS CuentaContable_3_integra                	-- 13	.CuentaContable.integra                             		VARCHAR(16)
				, CuentaContable_3.cuentaJerarquia             AS CuentaContable_3_cuentaJerarquia        	-- 14	.CuentaContable.cuentaJerarquia                     		VARCHAR(16)
				, CuentaContable_3.imputable                   AS CuentaContable_3_imputable              	-- 15	.CuentaContable.imputable                           		BOOLEAN
				, CuentaContable_3.ajustaPorInflacion          AS CuentaContable_3_ajustaPorInflacion     	-- 16	.CuentaContable.ajustaPorInflacion                  		BOOLEAN
				, CuentaContableEstado_17.id                   AS CuentaContableEstado_17_id              	-- 17	.CuentaContable.CuentaContableEstado.id             		VARCHAR(36)
				, CuentaContableEstado_17.numero               AS CuentaContableEstado_17_numero          	-- 18	.CuentaContable.CuentaContableEstado.numero         		INTEGER
				, CuentaContableEstado_17.nombre               AS CuentaContableEstado_17_nombre          	-- 19	.CuentaContable.CuentaContableEstado.nombre         		VARCHAR(50)
				, CuentaContable_3.cuentaConApropiacion        AS CuentaContable_3_cuentaConApropiacion   	-- 20	.CuentaContable.cuentaConApropiacion                		BOOLEAN
				, CentroCostoContable_21.id                    AS CentroCostoContable_21_id               	-- 21	.CuentaContable.CentroCostoContable.id              		VARCHAR(36)
				, CentroCostoContable_21.numero                AS CentroCostoContable_21_numero           	-- 22	.CuentaContable.CentroCostoContable.numero          		INTEGER
				, CentroCostoContable_21.nombre                AS CentroCostoContable_21_nombre           	-- 23	.CuentaContable.CentroCostoContable.nombre          		VARCHAR(50)
				, CentroCostoContable_21.abreviatura           AS CentroCostoContable_21_abreviatura      	-- 24	.CuentaContable.CentroCostoContable.abreviatura     		VARCHAR(5)
				, CentroCostoContable_21.ejercicioContable     AS CentroCostoContable_21_ejercicioContable	-- 25	.CuentaContable.CentroCostoContable.ejercicioContable		VARCHAR(36)	EjercicioContable.id
				, CuentaContable_3.cuentaAgrupadora            AS CuentaContable_3_cuentaAgrupadora       	-- 26	.CuentaContable.cuentaAgrupadora                    		VARCHAR(50)
				, CuentaContable_3.porcentaje                  AS CuentaContable_3_porcentaje             	-- 27	.CuentaContable.porcentaje                          		DECIMAL(6,3)
				, PuntoEquilibrio_28.id                        AS PuntoEquilibrio_28_id                   	-- 28	.CuentaContable.PuntoEquilibrio.id                  		VARCHAR(36)
				, PuntoEquilibrio_28.numero                    AS PuntoEquilibrio_28_numero               	-- 29	.CuentaContable.PuntoEquilibrio.numero              		INTEGER
				, PuntoEquilibrio_28.nombre                    AS PuntoEquilibrio_28_nombre               	-- 30	.CuentaContable.PuntoEquilibrio.nombre              		VARCHAR(50)
				, PuntoEquilibrio_28.tipoPuntoEquilibrio       AS PuntoEquilibrio_28_tipoPuntoEquilibrio  	-- 31	.CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio 		VARCHAR(36)	TipoPuntoEquilibrio.id
				, PuntoEquilibrio_28.ejercicioContable         AS PuntoEquilibrio_28_ejercicioContable    	-- 32	.CuentaContable.PuntoEquilibrio.ejercicioContable   		VARCHAR(36)	EjercicioContable.id
				, CostoVenta_33.id                             AS CostoVenta_33_id                        	-- 33	.CuentaContable.CostoVenta.id                       		VARCHAR(36)
				, CostoVenta_33.numero                         AS CostoVenta_33_numero                    	-- 34	.CuentaContable.CostoVenta.numero                   		INTEGER
				, CostoVenta_33.nombre                         AS CostoVenta_33_nombre                    	-- 35	.CuentaContable.CostoVenta.nombre                   		VARCHAR(50)
				, SeguridadPuerta_36.id                        AS SeguridadPuerta_36_id                   	-- 36	.CuentaContable.SeguridadPuerta.id                  		VARCHAR(36)
				, SeguridadPuerta_36.numero                    AS SeguridadPuerta_36_numero               	-- 37	.CuentaContable.SeguridadPuerta.numero              		INTEGER
				, SeguridadPuerta_36.nombre                    AS SeguridadPuerta_36_nombre               	-- 38	.CuentaContable.SeguridadPuerta.nombre              		VARCHAR(50)
				, SeguridadPuerta_36.equate                    AS SeguridadPuerta_36_equate               	-- 39	.CuentaContable.SeguridadPuerta.equate              		VARCHAR(30)
				, SeguridadPuerta_36.seguridadModulo           AS SeguridadPuerta_36_seguridadModulo      	-- 40	.CuentaContable.SeguridadPuerta.seguridadModulo     		VARCHAR(36)	SeguridadModulo.id
				, CuentaFondoGrupo_41.id                       AS CuentaFondoGrupo_41_id                  	-- 41	.CuentaFondoGrupo.id                                		VARCHAR(36)
				, CuentaFondoGrupo_41.numero                   AS CuentaFondoGrupo_41_numero              	-- 42	.CuentaFondoGrupo.numero                            		INTEGER
				, CuentaFondoGrupo_41.nombre                   AS CuentaFondoGrupo_41_nombre              	-- 43	.CuentaFondoGrupo.nombre                            		VARCHAR(50)
				, CuentaFondoRubro_44.id                       AS CuentaFondoRubro_44_id                  	-- 44	.CuentaFondoGrupo.CuentaFondoRubro.id               		VARCHAR(36)
				, CuentaFondoRubro_44.numero                   AS CuentaFondoRubro_44_numero              	-- 45	.CuentaFondoGrupo.CuentaFondoRubro.numero           		INTEGER
				, CuentaFondoRubro_44.nombre                   AS CuentaFondoRubro_44_nombre              	-- 46	.CuentaFondoGrupo.CuentaFondoRubro.nombre           		VARCHAR(50)
				, CuentaFondoTipo_47.id                        AS CuentaFondoTipo_47_id                   	-- 47	.CuentaFondoTipo.id                                 		VARCHAR(36)
				, CuentaFondoTipo_47.numero                    AS CuentaFondoTipo_47_numero               	-- 48	.CuentaFondoTipo.numero                             		INTEGER
				, CuentaFondoTipo_47.nombre                    AS CuentaFondoTipo_47_nombre               	-- 49	.CuentaFondoTipo.nombre                             		VARCHAR(50)
				, CuentaFondo.obsoleto                         AS CuentaFondo_obsoleto                    	-- 50	.obsoleto                                           		BOOLEAN
				, CuentaFondo.noImprimeCaja                    AS CuentaFondo_noImprimeCaja               	-- 51	.noImprimeCaja                                      		BOOLEAN
				, CuentaFondo.ventas                           AS CuentaFondo_ventas                      	-- 52	.ventas                                             		BOOLEAN
				, CuentaFondo.fondos                           AS CuentaFondo_fondos                      	-- 53	.fondos                                             		BOOLEAN
				, CuentaFondo.compras                          AS CuentaFondo_compras                     	-- 54	.compras                                            		BOOLEAN
				, Moneda_55.id                                 AS Moneda_55_id                            	-- 55	.Moneda.id                                          		VARCHAR(36)
				, Moneda_55.numero                             AS Moneda_55_numero                        	-- 56	.Moneda.numero                                      		INTEGER
				, Moneda_55.nombre                             AS Moneda_55_nombre                        	-- 57	.Moneda.nombre                                      		VARCHAR(50)
				, Moneda_55.abreviatura                        AS Moneda_55_abreviatura                   	-- 58	.Moneda.abreviatura                                 		VARCHAR(5)
				, Moneda_55.cotizacion                         AS Moneda_55_cotizacion                    	-- 59	.Moneda.cotizacion                                  		DECIMAL(13,5)
				, Moneda_55.cotizacionFecha                    AS Moneda_55_cotizacionFecha               	-- 60	.Moneda.cotizacionFecha                             		TIMESTAMP
				, Moneda_55.controlActualizacion               AS Moneda_55_controlActualizacion          	-- 61	.Moneda.controlActualizacion                        		BOOLEAN
				, MonedaAFIP_62.id                             AS MonedaAFIP_62_id                        	-- 62	.Moneda.MonedaAFIP.id                               		VARCHAR(36)
				, MonedaAFIP_62.codigo                         AS MonedaAFIP_62_codigo                    	-- 63	.Moneda.MonedaAFIP.codigo                           		VARCHAR(3)
				, MonedaAFIP_62.nombre                         AS MonedaAFIP_62_nombre                    	-- 64	.Moneda.MonedaAFIP.nombre                           		VARCHAR(50)
				, Caja_65.id                                   AS Caja_65_id                              	-- 65	.Caja.id                                            		VARCHAR(36)
				, Caja_65.numero                               AS Caja_65_numero                          	-- 66	.Caja.numero                                        		INTEGER
				, Caja_65.nombre                               AS Caja_65_nombre                          	-- 67	.Caja.nombre                                        		VARCHAR(50)
				, SeguridadPuerta_68.id                        AS SeguridadPuerta_68_id                   	-- 68	.Caja.SeguridadPuerta.id                            		VARCHAR(36)
				, SeguridadPuerta_68.numero                    AS SeguridadPuerta_68_numero               	-- 69	.Caja.SeguridadPuerta.numero                        		INTEGER
				, SeguridadPuerta_68.nombre                    AS SeguridadPuerta_68_nombre               	-- 70	.Caja.SeguridadPuerta.nombre                        		VARCHAR(50)
				, SeguridadPuerta_68.equate                    AS SeguridadPuerta_68_equate               	-- 71	.Caja.SeguridadPuerta.equate                        		VARCHAR(30)
				, SeguridadPuerta_68.seguridadModulo           AS SeguridadPuerta_68_seguridadModulo      	-- 72	.Caja.SeguridadPuerta.seguridadModulo               		VARCHAR(36)	SeguridadModulo.id
				, CuentaFondo.rechazados                       AS CuentaFondo_rechazados                  	-- 73	.rechazados                                         		BOOLEAN
				, CuentaFondo.conciliacion                     AS CuentaFondo_conciliacion                	-- 74	.conciliacion                                       		BOOLEAN
				, CuentaFondoTipoBanco_75.id                   AS CuentaFondoTipoBanco_75_id              	-- 75	.CuentaFondoTipoBanco.id                            		VARCHAR(36)
				, CuentaFondoTipoBanco_75.numero               AS CuentaFondoTipoBanco_75_numero          	-- 76	.CuentaFondoTipoBanco.numero                        		INTEGER
				, CuentaFondoTipoBanco_75.nombre               AS CuentaFondoTipoBanco_75_nombre          	-- 77	.CuentaFondoTipoBanco.nombre                        		VARCHAR(50)
				, Banco_78.id                                  AS Banco_78_id                             	-- 78	.Banco.id                                           		VARCHAR(36)
				, Banco_78.numero                              AS Banco_78_numero                         	-- 79	.Banco.numero                                       		INTEGER
				, Banco_78.nombre                              AS Banco_78_nombre                         	-- 80	.Banco.nombre                                       		VARCHAR(50)
				, Banco_78.cuit                                AS Banco_78_cuit                           	-- 81	.Banco.cuit                                         		BIGINT
				, Banco_78.bloqueado                           AS Banco_78_bloqueado                      	-- 82	.Banco.bloqueado                                    		BOOLEAN
				, Banco_78.hoja                                AS Banco_78_hoja                           	-- 83	.Banco.hoja                                         		INTEGER
				, Banco_78.primeraFila                         AS Banco_78_primeraFila                    	-- 84	.Banco.primeraFila                                  		INTEGER
				, Banco_78.ultimaFila                          AS Banco_78_ultimaFila                     	-- 85	.Banco.ultimaFila                                   		INTEGER
				, Banco_78.fecha                               AS Banco_78_fecha                          	-- 86	.Banco.fecha                                        		VARCHAR(3)
				, Banco_78.descripcion                         AS Banco_78_descripcion                    	-- 87	.Banco.descripcion                                  		VARCHAR(3)
				, Banco_78.referencia1                         AS Banco_78_referencia1                    	-- 88	.Banco.referencia1                                  		VARCHAR(3)
				, Banco_78.importe                             AS Banco_78_importe                        	-- 89	.Banco.importe                                      		VARCHAR(3)
				, Banco_78.referencia2                         AS Banco_78_referencia2                    	-- 90	.Banco.referencia2                                  		VARCHAR(3)
				, Banco_78.saldo                               AS Banco_78_saldo                          	-- 91	.Banco.saldo                                        		VARCHAR(3)
				, CuentaFondo.cuentaBancaria                   AS CuentaFondo_cuentaBancaria              	-- 92	.cuentaBancaria                                     		VARCHAR(22)
				, CuentaFondo.cbu                              AS CuentaFondo_cbu                         	-- 93	.cbu                                                		VARCHAR(22)
				, CuentaFondo.limiteDescubierto                AS CuentaFondo_limiteDescubierto           	-- 94	.limiteDescubierto                                  		DECIMAL(13,5)
				, CuentaFondo.cuentaFondoCaucion               AS CuentaFondo_cuentaFondoCaucion          	-- 95	.cuentaFondoCaucion                                 		VARCHAR(50)
				, CuentaFondo.cuentaFondoDiferidos             AS CuentaFondo_cuentaFondoDiferidos        	-- 96	.cuentaFondoDiferidos                               		VARCHAR(50)
				, CuentaFondo.formato                          AS CuentaFondo_formato                     	-- 97	.formato                                            		VARCHAR(50)
				, CuentaFondoBancoCopia_98.id                  AS CuentaFondoBancoCopia_98_id             	-- 98	.CuentaFondoBancoCopia.id                           		VARCHAR(36)
				, CuentaFondoBancoCopia_98.numero              AS CuentaFondoBancoCopia_98_numero         	-- 99	.CuentaFondoBancoCopia.numero                       		INTEGER
				, CuentaFondoBancoCopia_98.nombre              AS CuentaFondoBancoCopia_98_nombre         	-- 100	.CuentaFondoBancoCopia.nombre                       		VARCHAR(50)
				, CuentaFondo.limiteOperacionIndividual        AS CuentaFondo_limiteOperacionIndividual   	-- 101	.limiteOperacionIndividual                          		DECIMAL(13,5)
				, SeguridadPuerta_102.id                       AS SeguridadPuerta_102_id                  	-- 102	.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_102.numero                   AS SeguridadPuerta_102_numero              	-- 103	.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_102.nombre                   AS SeguridadPuerta_102_nombre              	-- 104	.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_102.equate                   AS SeguridadPuerta_102_equate              	-- 105	.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_106.id                       AS SeguridadModulo_106_id                  	-- 106	.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_106.numero                   AS SeguridadModulo_106_numero              	-- 107	.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_106.nombre                   AS SeguridadModulo_106_nombre              	-- 108	.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)
				, SeguridadPuerta_109.id                       AS SeguridadPuerta_109_id                  	-- 109	.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_109.numero                   AS SeguridadPuerta_109_numero              	-- 110	.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_109.nombre                   AS SeguridadPuerta_109_nombre              	-- 111	.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_109.equate                   AS SeguridadPuerta_109_equate              	-- 112	.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_113.id                       AS SeguridadModulo_113_id                  	-- 113	.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_113.numero                   AS SeguridadModulo_113_numero              	-- 114	.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_113.nombre                   AS SeguridadModulo_113_nombre              	-- 115	.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)
				, SeguridadPuerta_116.id                       AS SeguridadPuerta_116_id                  	-- 116	.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_116.numero                   AS SeguridadPuerta_116_numero              	-- 117	.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_116.nombre                   AS SeguridadPuerta_116_nombre              	-- 118	.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_116.equate                   AS SeguridadPuerta_116_equate              	-- 119	.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_120.id                       AS SeguridadModulo_120_id                  	-- 120	.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_120.numero                   AS SeguridadModulo_120_numero              	-- 121	.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_120.nombre                   AS SeguridadModulo_120_nombre              	-- 122	.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)

		FROM	massoftware.CuentaFondo
			LEFT JOIN massoftware.CuentaContable AS CuentaContable_3                  ON CuentaFondo.cuentaContable = CuentaContable_3.id 	-- 3 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_6              ON CuentaContable_3.ejercicioContable = EjercicioContable_6.id 	-- 6 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_17           ON CuentaContable_3.cuentaContableEstado = CuentaContableEstado_17.id 	-- 17 LEFT LEVEL: 2
				LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_21            ON CuentaContable_3.centroCostoContable = CentroCostoContable_21.id 	-- 21 LEFT LEVEL: 2
				LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_28                ON CuentaContable_3.puntoEquilibrio = PuntoEquilibrio_28.id 	-- 28 LEFT LEVEL: 2
				LEFT JOIN massoftware.CostoVenta AS CostoVenta_33                     ON CuentaContable_3.costoVenta = CostoVenta_33.id 	-- 33 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_36                ON CuentaContable_3.seguridadPuerta = SeguridadPuerta_36.id 	-- 36 LEFT LEVEL: 2
			LEFT JOIN massoftware.CuentaFondoGrupo AS CuentaFondoGrupo_41               ON CuentaFondo.cuentaFondoGrupo = CuentaFondoGrupo_41.id 	-- 41 LEFT LEVEL: 1
				LEFT JOIN massoftware.CuentaFondoRubro AS CuentaFondoRubro_44               ON CuentaFondoGrupo_41.cuentaFondoRubro = CuentaFondoRubro_44.id 	-- 44 LEFT LEVEL: 2
			LEFT JOIN massoftware.CuentaFondoTipo AS CuentaFondoTipo_47                ON CuentaFondo.cuentaFondoTipo = CuentaFondoTipo_47.id 	-- 47 LEFT LEVEL: 1
			LEFT JOIN massoftware.Moneda AS Moneda_55                         ON CuentaFondo.moneda = Moneda_55.id 	-- 55 LEFT LEVEL: 1
				LEFT JOIN massoftware.MonedaAFIP AS MonedaAFIP_62                     ON Moneda_55.monedaAFIP = MonedaAFIP_62.id 	-- 62 LEFT LEVEL: 2
			LEFT JOIN massoftware.Caja AS Caja_65                           ON CuentaFondo.caja = Caja_65.id 	-- 65 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_68                ON Caja_65.seguridadPuerta = SeguridadPuerta_68.id 	-- 68 LEFT LEVEL: 2
			LEFT JOIN massoftware.CuentaFondoTipoBanco AS CuentaFondoTipoBanco_75           ON CuentaFondo.cuentaFondoTipoBanco = CuentaFondoTipoBanco_75.id 	-- 75 LEFT LEVEL: 1
			LEFT JOIN massoftware.Banco AS Banco_78                          ON CuentaFondo.banco = Banco_78.id 	-- 78 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaFondoBancoCopia AS CuentaFondoBancoCopia_98          ON CuentaFondo.cuentaFondoBancoCopia = CuentaFondoBancoCopia_98.id 	-- 98 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_102                ON CuentaFondo.seguridadPuertaUso = SeguridadPuerta_102.id 	-- 102 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_106               ON SeguridadPuerta_102.seguridadModulo = SeguridadModulo_106.id 	-- 106 LEFT LEVEL: 2
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_109                ON CuentaFondo.seguridadPuertaConsulta = SeguridadPuerta_109.id 	-- 109 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_113               ON SeguridadPuerta_109.seguridadModulo = SeguridadModulo_113.id 	-- 113 LEFT LEVEL: 2
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_116                ON CuentaFondo.seguridadPuertaLimite = SeguridadPuerta_116.id 	-- 116 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_120               ON SeguridadPuerta_116.seguridadModulo = SeguridadModulo_120.id 	-- 120 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondo.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND bancoArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(bancoArg8)) > 0 THEN
		bancoArg8 = REPLACE(bancoArg8, '''', '''''');
		bancoArg8 = LOWER(TRIM(bancoArg8));
		bancoArg8 = TRANSLATE(bancoArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(bancoArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondo.banco),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_CuentaFondo_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaFondo_2 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaFondo_2 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaFondoById_2 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondo_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, bancoArg8         VARCHAR(36)	-- 8

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondo_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6
	, nombreArg7        VARCHAR(50)	-- 7
	, bancoArg8         VARCHAR(36)	-- 8

) RETURNS SETOF massoftware.t_CuentaFondo_3 AS $$

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
				  CuentaFondo.id                             AS CuentaFondo_id                       	-- 0	.id                                                                		VARCHAR(36)
				, CuentaFondo.numero                         AS CuentaFondo_numero                   	-- 1	.numero                                                            		INTEGER
				, CuentaFondo.nombre                         AS CuentaFondo_nombre                   	-- 2	.nombre                                                            		VARCHAR(50)
				, CuentaContable_3.id                        AS CuentaContable_3_id                  	-- 3	.CuentaContable.id                                                 		VARCHAR(36)
				, CuentaContable_3.codigo                    AS CuentaContable_3_codigo              	-- 4	.CuentaContable.codigo                                             		VARCHAR(11)
				, CuentaContable_3.nombre                    AS CuentaContable_3_nombre              	-- 5	.CuentaContable.nombre                                             		VARCHAR(50)
				, EjercicioContable_6.id                     AS EjercicioContable_6_id               	-- 6	.CuentaContable.EjercicioContable.id                               		VARCHAR(36)
				, EjercicioContable_6.numero                 AS EjercicioContable_6_numero           	-- 7	.CuentaContable.EjercicioContable.numero                           		INTEGER
				, EjercicioContable_6.apertura               AS EjercicioContable_6_apertura         	-- 8	.CuentaContable.EjercicioContable.apertura                         		DATE
				, EjercicioContable_6.cierre                 AS EjercicioContable_6_cierre           	-- 9	.CuentaContable.EjercicioContable.cierre                           		DATE
				, EjercicioContable_6.cerrado                AS EjercicioContable_6_cerrado          	-- 10	.CuentaContable.EjercicioContable.cerrado                          		BOOLEAN
				, EjercicioContable_6.cerradoModulos         AS EjercicioContable_6_cerradoModulos   	-- 11	.CuentaContable.EjercicioContable.cerradoModulos                   		BOOLEAN
				, EjercicioContable_6.comentario             AS EjercicioContable_6_comentario       	-- 12	.CuentaContable.EjercicioContable.comentario                       		VARCHAR(250)
				, CuentaContable_3.integra                   AS CuentaContable_3_integra             	-- 13	.CuentaContable.integra                                            		VARCHAR(16)
				, CuentaContable_3.cuentaJerarquia           AS CuentaContable_3_cuentaJerarquia     	-- 14	.CuentaContable.cuentaJerarquia                                    		VARCHAR(16)
				, CuentaContable_3.imputable                 AS CuentaContable_3_imputable           	-- 15	.CuentaContable.imputable                                          		BOOLEAN
				, CuentaContable_3.ajustaPorInflacion        AS CuentaContable_3_ajustaPorInflacion  	-- 16	.CuentaContable.ajustaPorInflacion                                 		BOOLEAN
				, CuentaContableEstado_17.id                 AS CuentaContableEstado_17_id           	-- 17	.CuentaContable.CuentaContableEstado.id                            		VARCHAR(36)
				, CuentaContableEstado_17.numero             AS CuentaContableEstado_17_numero       	-- 18	.CuentaContable.CuentaContableEstado.numero                        		INTEGER
				, CuentaContableEstado_17.nombre             AS CuentaContableEstado_17_nombre       	-- 19	.CuentaContable.CuentaContableEstado.nombre                        		VARCHAR(50)
				, CuentaContable_3.cuentaConApropiacion      AS CuentaContable_3_cuentaConApropiacion	-- 20	.CuentaContable.cuentaConApropiacion                               		BOOLEAN
				, CentroCostoContable_21.id                  AS CentroCostoContable_21_id            	-- 21	.CuentaContable.CentroCostoContable.id                             		VARCHAR(36)
				, CentroCostoContable_21.numero              AS CentroCostoContable_21_numero        	-- 22	.CuentaContable.CentroCostoContable.numero                         		INTEGER
				, CentroCostoContable_21.nombre              AS CentroCostoContable_21_nombre        	-- 23	.CuentaContable.CentroCostoContable.nombre                         		VARCHAR(50)
				, CentroCostoContable_21.abreviatura         AS CentroCostoContable_21_abreviatura   	-- 24	.CuentaContable.CentroCostoContable.abreviatura                    		VARCHAR(5)
				, EjercicioContable_25.id                    AS EjercicioContable_25_id              	-- 25	.CuentaContable.CentroCostoContable.EjercicioContable.id           		VARCHAR(36)
				, EjercicioContable_25.numero                AS EjercicioContable_25_numero          	-- 26	.CuentaContable.CentroCostoContable.EjercicioContable.numero       		INTEGER
				, EjercicioContable_25.apertura              AS EjercicioContable_25_apertura        	-- 27	.CuentaContable.CentroCostoContable.EjercicioContable.apertura     		DATE
				, EjercicioContable_25.cierre                AS EjercicioContable_25_cierre          	-- 28	.CuentaContable.CentroCostoContable.EjercicioContable.cierre       		DATE
				, EjercicioContable_25.cerrado               AS EjercicioContable_25_cerrado         	-- 29	.CuentaContable.CentroCostoContable.EjercicioContable.cerrado      		BOOLEAN
				, EjercicioContable_25.cerradoModulos        AS EjercicioContable_25_cerradoModulos  	-- 30	.CuentaContable.CentroCostoContable.EjercicioContable.cerradoModulos		BOOLEAN
				, EjercicioContable_25.comentario            AS EjercicioContable_25_comentario      	-- 31	.CuentaContable.CentroCostoContable.EjercicioContable.comentario   		VARCHAR(250)
				, CuentaContable_3.cuentaAgrupadora          AS CuentaContable_3_cuentaAgrupadora    	-- 32	.CuentaContable.cuentaAgrupadora                                   		VARCHAR(50)
				, CuentaContable_3.porcentaje                AS CuentaContable_3_porcentaje          	-- 33	.CuentaContable.porcentaje                                         		DECIMAL(6,3)
				, PuntoEquilibrio_34.id                      AS PuntoEquilibrio_34_id                	-- 34	.CuentaContable.PuntoEquilibrio.id                                 		VARCHAR(36)
				, PuntoEquilibrio_34.numero                  AS PuntoEquilibrio_34_numero            	-- 35	.CuentaContable.PuntoEquilibrio.numero                             		INTEGER
				, PuntoEquilibrio_34.nombre                  AS PuntoEquilibrio_34_nombre            	-- 36	.CuentaContable.PuntoEquilibrio.nombre                             		VARCHAR(50)
				, TipoPuntoEquilibrio_37.id                  AS TipoPuntoEquilibrio_37_id            	-- 37	.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.id             		VARCHAR(36)
				, TipoPuntoEquilibrio_37.numero              AS TipoPuntoEquilibrio_37_numero        	-- 38	.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.numero         		INTEGER
				, TipoPuntoEquilibrio_37.nombre              AS TipoPuntoEquilibrio_37_nombre        	-- 39	.CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.nombre         		VARCHAR(50)
				, EjercicioContable_40.id                    AS EjercicioContable_40_id              	-- 40	.CuentaContable.PuntoEquilibrio.EjercicioContable.id               		VARCHAR(36)
				, EjercicioContable_40.numero                AS EjercicioContable_40_numero          	-- 41	.CuentaContable.PuntoEquilibrio.EjercicioContable.numero           		INTEGER
				, EjercicioContable_40.apertura              AS EjercicioContable_40_apertura        	-- 42	.CuentaContable.PuntoEquilibrio.EjercicioContable.apertura         		DATE
				, EjercicioContable_40.cierre                AS EjercicioContable_40_cierre          	-- 43	.CuentaContable.PuntoEquilibrio.EjercicioContable.cierre           		DATE
				, EjercicioContable_40.cerrado               AS EjercicioContable_40_cerrado         	-- 44	.CuentaContable.PuntoEquilibrio.EjercicioContable.cerrado          		BOOLEAN
				, EjercicioContable_40.cerradoModulos        AS EjercicioContable_40_cerradoModulos  	-- 45	.CuentaContable.PuntoEquilibrio.EjercicioContable.cerradoModulos   		BOOLEAN
				, EjercicioContable_40.comentario            AS EjercicioContable_40_comentario      	-- 46	.CuentaContable.PuntoEquilibrio.EjercicioContable.comentario       		VARCHAR(250)
				, CostoVenta_47.id                           AS CostoVenta_47_id                     	-- 47	.CuentaContable.CostoVenta.id                                      		VARCHAR(36)
				, CostoVenta_47.numero                       AS CostoVenta_47_numero                 	-- 48	.CuentaContable.CostoVenta.numero                                  		INTEGER
				, CostoVenta_47.nombre                       AS CostoVenta_47_nombre                 	-- 49	.CuentaContable.CostoVenta.nombre                                  		VARCHAR(50)
				, SeguridadPuerta_50.id                      AS SeguridadPuerta_50_id                	-- 50	.CuentaContable.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_50.numero                  AS SeguridadPuerta_50_numero            	-- 51	.CuentaContable.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_50.nombre                  AS SeguridadPuerta_50_nombre            	-- 52	.CuentaContable.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_50.equate                  AS SeguridadPuerta_50_equate            	-- 53	.CuentaContable.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_54.id                      AS SeguridadModulo_54_id                	-- 54	.CuentaContable.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_54.numero                  AS SeguridadModulo_54_numero            	-- 55	.CuentaContable.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_54.nombre                  AS SeguridadModulo_54_nombre            	-- 56	.CuentaContable.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)
				, CuentaFondoGrupo_57.id                     AS CuentaFondoGrupo_57_id               	-- 57	.CuentaFondoGrupo.id                                               		VARCHAR(36)
				, CuentaFondoGrupo_57.numero                 AS CuentaFondoGrupo_57_numero           	-- 58	.CuentaFondoGrupo.numero                                           		INTEGER
				, CuentaFondoGrupo_57.nombre                 AS CuentaFondoGrupo_57_nombre           	-- 59	.CuentaFondoGrupo.nombre                                           		VARCHAR(50)
				, CuentaFondoRubro_60.id                     AS CuentaFondoRubro_60_id               	-- 60	.CuentaFondoGrupo.CuentaFondoRubro.id                              		VARCHAR(36)
				, CuentaFondoRubro_60.numero                 AS CuentaFondoRubro_60_numero           	-- 61	.CuentaFondoGrupo.CuentaFondoRubro.numero                          		INTEGER
				, CuentaFondoRubro_60.nombre                 AS CuentaFondoRubro_60_nombre           	-- 62	.CuentaFondoGrupo.CuentaFondoRubro.nombre                          		VARCHAR(50)
				, CuentaFondoTipo_63.id                      AS CuentaFondoTipo_63_id                	-- 63	.CuentaFondoTipo.id                                                		VARCHAR(36)
				, CuentaFondoTipo_63.numero                  AS CuentaFondoTipo_63_numero            	-- 64	.CuentaFondoTipo.numero                                            		INTEGER
				, CuentaFondoTipo_63.nombre                  AS CuentaFondoTipo_63_nombre            	-- 65	.CuentaFondoTipo.nombre                                            		VARCHAR(50)
				, CuentaFondo.obsoleto                       AS CuentaFondo_obsoleto                 	-- 66	.obsoleto                                                          		BOOLEAN
				, CuentaFondo.noImprimeCaja                  AS CuentaFondo_noImprimeCaja            	-- 67	.noImprimeCaja                                                     		BOOLEAN
				, CuentaFondo.ventas                         AS CuentaFondo_ventas                   	-- 68	.ventas                                                            		BOOLEAN
				, CuentaFondo.fondos                         AS CuentaFondo_fondos                   	-- 69	.fondos                                                            		BOOLEAN
				, CuentaFondo.compras                        AS CuentaFondo_compras                  	-- 70	.compras                                                           		BOOLEAN
				, Moneda_71.id                               AS Moneda_71_id                         	-- 71	.Moneda.id                                                         		VARCHAR(36)
				, Moneda_71.numero                           AS Moneda_71_numero                     	-- 72	.Moneda.numero                                                     		INTEGER
				, Moneda_71.nombre                           AS Moneda_71_nombre                     	-- 73	.Moneda.nombre                                                     		VARCHAR(50)
				, Moneda_71.abreviatura                      AS Moneda_71_abreviatura                	-- 74	.Moneda.abreviatura                                                		VARCHAR(5)
				, Moneda_71.cotizacion                       AS Moneda_71_cotizacion                 	-- 75	.Moneda.cotizacion                                                 		DECIMAL(13,5)
				, Moneda_71.cotizacionFecha                  AS Moneda_71_cotizacionFecha            	-- 76	.Moneda.cotizacionFecha                                            		TIMESTAMP
				, Moneda_71.controlActualizacion             AS Moneda_71_controlActualizacion       	-- 77	.Moneda.controlActualizacion                                       		BOOLEAN
				, MonedaAFIP_78.id                           AS MonedaAFIP_78_id                     	-- 78	.Moneda.MonedaAFIP.id                                              		VARCHAR(36)
				, MonedaAFIP_78.codigo                       AS MonedaAFIP_78_codigo                 	-- 79	.Moneda.MonedaAFIP.codigo                                          		VARCHAR(3)
				, MonedaAFIP_78.nombre                       AS MonedaAFIP_78_nombre                 	-- 80	.Moneda.MonedaAFIP.nombre                                          		VARCHAR(50)
				, Caja_81.id                                 AS Caja_81_id                           	-- 81	.Caja.id                                                           		VARCHAR(36)
				, Caja_81.numero                             AS Caja_81_numero                       	-- 82	.Caja.numero                                                       		INTEGER
				, Caja_81.nombre                             AS Caja_81_nombre                       	-- 83	.Caja.nombre                                                       		VARCHAR(50)
				, SeguridadPuerta_84.id                      AS SeguridadPuerta_84_id                	-- 84	.Caja.SeguridadPuerta.id                                           		VARCHAR(36)
				, SeguridadPuerta_84.numero                  AS SeguridadPuerta_84_numero            	-- 85	.Caja.SeguridadPuerta.numero                                       		INTEGER
				, SeguridadPuerta_84.nombre                  AS SeguridadPuerta_84_nombre            	-- 86	.Caja.SeguridadPuerta.nombre                                       		VARCHAR(50)
				, SeguridadPuerta_84.equate                  AS SeguridadPuerta_84_equate            	-- 87	.Caja.SeguridadPuerta.equate                                       		VARCHAR(30)
				, SeguridadModulo_88.id                      AS SeguridadModulo_88_id                	-- 88	.Caja.SeguridadPuerta.SeguridadModulo.id                           		VARCHAR(36)
				, SeguridadModulo_88.numero                  AS SeguridadModulo_88_numero            	-- 89	.Caja.SeguridadPuerta.SeguridadModulo.numero                       		INTEGER
				, SeguridadModulo_88.nombre                  AS SeguridadModulo_88_nombre            	-- 90	.Caja.SeguridadPuerta.SeguridadModulo.nombre                       		VARCHAR(50)
				, CuentaFondo.rechazados                     AS CuentaFondo_rechazados               	-- 91	.rechazados                                                        		BOOLEAN
				, CuentaFondo.conciliacion                   AS CuentaFondo_conciliacion             	-- 92	.conciliacion                                                      		BOOLEAN
				, CuentaFondoTipoBanco_93.id                 AS CuentaFondoTipoBanco_93_id           	-- 93	.CuentaFondoTipoBanco.id                                           		VARCHAR(36)
				, CuentaFondoTipoBanco_93.numero             AS CuentaFondoTipoBanco_93_numero       	-- 94	.CuentaFondoTipoBanco.numero                                       		INTEGER
				, CuentaFondoTipoBanco_93.nombre             AS CuentaFondoTipoBanco_93_nombre       	-- 95	.CuentaFondoTipoBanco.nombre                                       		VARCHAR(50)
				, Banco_96.id                                AS Banco_96_id                          	-- 96	.Banco.id                                                          		VARCHAR(36)
				, Banco_96.numero                            AS Banco_96_numero                      	-- 97	.Banco.numero                                                      		INTEGER
				, Banco_96.nombre                            AS Banco_96_nombre                      	-- 98	.Banco.nombre                                                      		VARCHAR(50)
				, Banco_96.cuit                              AS Banco_96_cuit                        	-- 99	.Banco.cuit                                                        		BIGINT
				, Banco_96.bloqueado                         AS Banco_96_bloqueado                   	-- 100	.Banco.bloqueado                                                   		BOOLEAN
				, Banco_96.hoja                              AS Banco_96_hoja                        	-- 101	.Banco.hoja                                                        		INTEGER
				, Banco_96.primeraFila                       AS Banco_96_primeraFila                 	-- 102	.Banco.primeraFila                                                 		INTEGER
				, Banco_96.ultimaFila                        AS Banco_96_ultimaFila                  	-- 103	.Banco.ultimaFila                                                  		INTEGER
				, Banco_96.fecha                             AS Banco_96_fecha                       	-- 104	.Banco.fecha                                                       		VARCHAR(3)
				, Banco_96.descripcion                       AS Banco_96_descripcion                 	-- 105	.Banco.descripcion                                                 		VARCHAR(3)
				, Banco_96.referencia1                       AS Banco_96_referencia1                 	-- 106	.Banco.referencia1                                                 		VARCHAR(3)
				, Banco_96.importe                           AS Banco_96_importe                     	-- 107	.Banco.importe                                                     		VARCHAR(3)
				, Banco_96.referencia2                       AS Banco_96_referencia2                 	-- 108	.Banco.referencia2                                                 		VARCHAR(3)
				, Banco_96.saldo                             AS Banco_96_saldo                       	-- 109	.Banco.saldo                                                       		VARCHAR(3)
				, CuentaFondo.cuentaBancaria                 AS CuentaFondo_cuentaBancaria           	-- 110	.cuentaBancaria                                                    		VARCHAR(22)
				, CuentaFondo.cbu                            AS CuentaFondo_cbu                      	-- 111	.cbu                                                               		VARCHAR(22)
				, CuentaFondo.limiteDescubierto              AS CuentaFondo_limiteDescubierto        	-- 112	.limiteDescubierto                                                 		DECIMAL(13,5)
				, CuentaFondo.cuentaFondoCaucion             AS CuentaFondo_cuentaFondoCaucion       	-- 113	.cuentaFondoCaucion                                                		VARCHAR(50)
				, CuentaFondo.cuentaFondoDiferidos           AS CuentaFondo_cuentaFondoDiferidos     	-- 114	.cuentaFondoDiferidos                                              		VARCHAR(50)
				, CuentaFondo.formato                        AS CuentaFondo_formato                  	-- 115	.formato                                                           		VARCHAR(50)
				, CuentaFondoBancoCopia_116.id               AS CuentaFondoBancoCopia_116_id         	-- 116	.CuentaFondoBancoCopia.id                                          		VARCHAR(36)
				, CuentaFondoBancoCopia_116.numero           AS CuentaFondoBancoCopia_116_numero     	-- 117	.CuentaFondoBancoCopia.numero                                      		INTEGER
				, CuentaFondoBancoCopia_116.nombre           AS CuentaFondoBancoCopia_116_nombre     	-- 118	.CuentaFondoBancoCopia.nombre                                      		VARCHAR(50)
				, CuentaFondo.limiteOperacionIndividual      AS CuentaFondo_limiteOperacionIndividual	-- 119	.limiteOperacionIndividual                                         		DECIMAL(13,5)
				, SeguridadPuerta_120.id                     AS SeguridadPuerta_120_id               	-- 120	.SeguridadPuerta.id                                                		VARCHAR(36)
				, SeguridadPuerta_120.numero                 AS SeguridadPuerta_120_numero           	-- 121	.SeguridadPuerta.numero                                            		INTEGER
				, SeguridadPuerta_120.nombre                 AS SeguridadPuerta_120_nombre           	-- 122	.SeguridadPuerta.nombre                                            		VARCHAR(50)
				, SeguridadPuerta_120.equate                 AS SeguridadPuerta_120_equate           	-- 123	.SeguridadPuerta.equate                                            		VARCHAR(30)
				, SeguridadModulo_124.id                     AS SeguridadModulo_124_id               	-- 124	.SeguridadPuerta.SeguridadModulo.id                                		VARCHAR(36)
				, SeguridadModulo_124.numero                 AS SeguridadModulo_124_numero           	-- 125	.SeguridadPuerta.SeguridadModulo.numero                            		INTEGER
				, SeguridadModulo_124.nombre                 AS SeguridadModulo_124_nombre           	-- 126	.SeguridadPuerta.SeguridadModulo.nombre                            		VARCHAR(50)
				, SeguridadPuerta_127.id                     AS SeguridadPuerta_127_id               	-- 127	.SeguridadPuerta.id                                                		VARCHAR(36)
				, SeguridadPuerta_127.numero                 AS SeguridadPuerta_127_numero           	-- 128	.SeguridadPuerta.numero                                            		INTEGER
				, SeguridadPuerta_127.nombre                 AS SeguridadPuerta_127_nombre           	-- 129	.SeguridadPuerta.nombre                                            		VARCHAR(50)
				, SeguridadPuerta_127.equate                 AS SeguridadPuerta_127_equate           	-- 130	.SeguridadPuerta.equate                                            		VARCHAR(30)
				, SeguridadModulo_131.id                     AS SeguridadModulo_131_id               	-- 131	.SeguridadPuerta.SeguridadModulo.id                                		VARCHAR(36)
				, SeguridadModulo_131.numero                 AS SeguridadModulo_131_numero           	-- 132	.SeguridadPuerta.SeguridadModulo.numero                            		INTEGER
				, SeguridadModulo_131.nombre                 AS SeguridadModulo_131_nombre           	-- 133	.SeguridadPuerta.SeguridadModulo.nombre                            		VARCHAR(50)
				, SeguridadPuerta_134.id                     AS SeguridadPuerta_134_id               	-- 134	.SeguridadPuerta.id                                                		VARCHAR(36)
				, SeguridadPuerta_134.numero                 AS SeguridadPuerta_134_numero           	-- 135	.SeguridadPuerta.numero                                            		INTEGER
				, SeguridadPuerta_134.nombre                 AS SeguridadPuerta_134_nombre           	-- 136	.SeguridadPuerta.nombre                                            		VARCHAR(50)
				, SeguridadPuerta_134.equate                 AS SeguridadPuerta_134_equate           	-- 137	.SeguridadPuerta.equate                                            		VARCHAR(30)
				, SeguridadModulo_138.id                     AS SeguridadModulo_138_id               	-- 138	.SeguridadPuerta.SeguridadModulo.id                                		VARCHAR(36)
				, SeguridadModulo_138.numero                 AS SeguridadModulo_138_numero           	-- 139	.SeguridadPuerta.SeguridadModulo.numero                            		INTEGER
				, SeguridadModulo_138.nombre                 AS SeguridadModulo_138_nombre           	-- 140	.SeguridadPuerta.SeguridadModulo.nombre                            		VARCHAR(50)

		FROM	massoftware.CuentaFondo
			LEFT JOIN massoftware.CuentaContable AS CuentaContable_3                    ON CuentaFondo.cuentaContable = CuentaContable_3.id 	-- 3 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_6                ON CuentaContable_3.ejercicioContable = EjercicioContable_6.id 	-- 6 LEFT LEVEL: 2
				LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_17             ON CuentaContable_3.cuentaContableEstado = CuentaContableEstado_17.id 	-- 17 LEFT LEVEL: 2
				LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_21              ON CuentaContable_3.centroCostoContable = CentroCostoContable_21.id 	-- 21 LEFT LEVEL: 2
					LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_25               ON CentroCostoContable_21.ejercicioContable = EjercicioContable_25.id 	-- 25 LEFT LEVEL: 3
				LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_34                  ON CuentaContable_3.puntoEquilibrio = PuntoEquilibrio_34.id 	-- 34 LEFT LEVEL: 2
					LEFT JOIN massoftware.TipoPuntoEquilibrio AS TipoPuntoEquilibrio_37             ON PuntoEquilibrio_34.tipoPuntoEquilibrio = TipoPuntoEquilibrio_37.id 	-- 37 LEFT LEVEL: 3
					LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_40               ON PuntoEquilibrio_34.ejercicioContable = EjercicioContable_40.id 	-- 40 LEFT LEVEL: 3
				LEFT JOIN massoftware.CostoVenta AS CostoVenta_47                       ON CuentaContable_3.costoVenta = CostoVenta_47.id 	-- 47 LEFT LEVEL: 2
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_50                  ON CuentaContable_3.seguridadPuerta = SeguridadPuerta_50.id 	-- 50 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_54                 ON SeguridadPuerta_50.seguridadModulo = SeguridadModulo_54.id 	-- 54 LEFT LEVEL: 3
			LEFT JOIN massoftware.CuentaFondoGrupo AS CuentaFondoGrupo_57                 ON CuentaFondo.cuentaFondoGrupo = CuentaFondoGrupo_57.id 	-- 57 LEFT LEVEL: 1
				LEFT JOIN massoftware.CuentaFondoRubro AS CuentaFondoRubro_60                 ON CuentaFondoGrupo_57.cuentaFondoRubro = CuentaFondoRubro_60.id 	-- 60 LEFT LEVEL: 2
			LEFT JOIN massoftware.CuentaFondoTipo AS CuentaFondoTipo_63                  ON CuentaFondo.cuentaFondoTipo = CuentaFondoTipo_63.id 	-- 63 LEFT LEVEL: 1
			LEFT JOIN massoftware.Moneda AS Moneda_71                           ON CuentaFondo.moneda = Moneda_71.id 	-- 71 LEFT LEVEL: 1
				LEFT JOIN massoftware.MonedaAFIP AS MonedaAFIP_78                       ON Moneda_71.monedaAFIP = MonedaAFIP_78.id 	-- 78 LEFT LEVEL: 2
			LEFT JOIN massoftware.Caja AS Caja_81                             ON CuentaFondo.caja = Caja_81.id 	-- 81 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_84                  ON Caja_81.seguridadPuerta = SeguridadPuerta_84.id 	-- 84 LEFT LEVEL: 2
					LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_88                 ON SeguridadPuerta_84.seguridadModulo = SeguridadModulo_88.id 	-- 88 LEFT LEVEL: 3
			LEFT JOIN massoftware.CuentaFondoTipoBanco AS CuentaFondoTipoBanco_93             ON CuentaFondo.cuentaFondoTipoBanco = CuentaFondoTipoBanco_93.id 	-- 93 LEFT LEVEL: 1
			LEFT JOIN massoftware.Banco AS Banco_96                            ON CuentaFondo.banco = Banco_96.id 	-- 96 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaFondoBancoCopia AS CuentaFondoBancoCopia_116            ON CuentaFondo.cuentaFondoBancoCopia = CuentaFondoBancoCopia_116.id 	-- 116 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_120                  ON CuentaFondo.seguridadPuertaUso = SeguridadPuerta_120.id 	-- 120 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_124                 ON SeguridadPuerta_120.seguridadModulo = SeguridadModulo_124.id 	-- 124 LEFT LEVEL: 2
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_127                  ON CuentaFondo.seguridadPuertaConsulta = SeguridadPuerta_127.id 	-- 127 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_131                 ON SeguridadPuerta_127.seguridadModulo = SeguridadModulo_131.id 	-- 131 LEFT LEVEL: 2
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_134                  ON CuentaFondo.seguridadPuertaLimite = SeguridadPuerta_134.id 	-- 134 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_138                 ON SeguridadPuerta_134.seguridadModulo = SeguridadModulo_138.id 	-- 138 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' CuentaFondo.numero <= ' || numeroToArg6;
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
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondo.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND bancoArg8 IS NOT NULL AND CHAR_LENGTH(TRIM(bancoArg8)) > 0 THEN
		bancoArg8 = REPLACE(bancoArg8, '''', '''''');
		bancoArg8 = LOWER(TRIM(bancoArg8));
		bancoArg8 = TRANSLATE(bancoArg8,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(bancoArg8, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaFondo.banco),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaFondoById_3 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaFondoById_3 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_CuentaFondo_3 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaFondo_3 ( idArg , null, null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaFondo_3 ( null , null, null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaFondoById_3 ('xxx'); 