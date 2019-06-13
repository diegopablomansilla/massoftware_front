
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaContable                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaContable



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.CuentaContable CASCADE;

CREATE TABLE massoftware.CuentaContable
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Cuenta contable
	codigo VARCHAR(11) NOT NULL, 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Ejercicio
	ejercicioContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.EjercicioContable (id), 
	
	-- Integra
	integra VARCHAR(16) NOT NULL  CONSTRAINT CuentaContable_integra_chk CHECK ( char_length(integra::VARCHAR) >= 16  ), 
	
	-- Cuenta de jerarquia
	cuentaJerarquia VARCHAR(16) NOT NULL  CONSTRAINT CuentaContable_cuentaJerarquia_chk CHECK ( char_length(cuentaJerarquia::VARCHAR) >= 16  ), 
	
	-- Imputable
	imputable BOOLEAN NOT NULL, 
	
	-- Ajusta por inflación
	ajustaPorInflacion BOOLEAN NOT NULL, 
	
	-- Estado
	cuentaContableEstado VARCHAR(36)  NOT NULL  REFERENCES massoftware.CuentaContableEstado (id), 
	
	-- Cuenta con apropiación
	cuentaConApropiacion BOOLEAN NOT NULL, 
	
	-- Estado
	centroCostoContable VARCHAR(36)  REFERENCES massoftware.CentroCostoContable (id), 
	
	-- Cuenta agrupadora
	cuentaAgrupadora VARCHAR(50), 
	
	-- Porcentaje
	porcentaje DECIMAL(6,3) CONSTRAINT CuentaContable_porcentaje_chk CHECK ( porcentaje >= 0 AND porcentaje <= 999.99  ), 
	
	-- Punto de equilibrio
	puntoEquilibrio VARCHAR(36)  REFERENCES massoftware.PuntoEquilibrio (id), 
	
	-- Costo de venta
	costoVenta VARCHAR(36)  REFERENCES massoftware.CostoVenta (id), 
	
	-- Puerta
	seguridadPuerta VARCHAR(36)  REFERENCES massoftware.SeguridadPuerta (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_CuentaContable_codigo ON massoftware.CuentaContable (TRANSLATE(LOWER(TRIM(codigo))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_CuentaContable_nombre ON massoftware.CuentaContable (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCuentaContable() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCuentaContable() RETURNS TRIGGER AS $formatCuentaContable$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.codigo := massoftware.white_is_null(NEW.codigo);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.ejercicioContable := massoftware.white_is_null(NEW.ejercicioContable);
	 NEW.integra := massoftware.white_is_null(NEW.integra);
	 NEW.cuentaJerarquia := massoftware.white_is_null(NEW.cuentaJerarquia);
	 NEW.cuentaContableEstado := massoftware.white_is_null(NEW.cuentaContableEstado);
	 NEW.centroCostoContable := massoftware.white_is_null(NEW.centroCostoContable);
	 NEW.cuentaAgrupadora := massoftware.white_is_null(NEW.cuentaAgrupadora);
	 NEW.puntoEquilibrio := massoftware.white_is_null(NEW.puntoEquilibrio);
	 NEW.costoVenta := massoftware.white_is_null(NEW.costoVenta);
	 NEW.seguridadPuerta := massoftware.white_is_null(NEW.seguridadPuerta);

	RETURN NEW;
END;
$formatCuentaContable$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCuentaContable ON massoftware.CuentaContable CASCADE;

CREATE TRIGGER tgFormatCuentaContable BEFORE INSERT OR UPDATE
	ON massoftware.CuentaContable FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatCuentaContable();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.CuentaContable;

-- SELECT * FROM massoftware.CuentaContable LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.CuentaContable;

-- SELECT * FROM massoftware.CuentaContable WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_CuentaContable_codigo(codigoArg VARCHAR(11)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_CuentaContable_codigo(codigoArg VARCHAR(11)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.CuentaContable
	WHERE	(codigoArg IS NULL OR (CHAR_LENGTH(TRIM(codigoArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(CuentaContable.codigo)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(codigoArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_CuentaContable_codigo(null::VARCHAR(11));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_CuentaContable_nombre(nombreArg VARCHAR(50)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_CuentaContable_nombre(nombreArg VARCHAR(50)) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.CuentaContable
	WHERE	(nombreArg IS NULL OR (CHAR_LENGTH(TRIM(nombreArg)) > 0 AND TRIM(LOWER(massoftware.TRANSLATE(CuentaContable.nombre)))::VARCHAR = TRIM(LOWER(massoftware.TRANSLATE(nombreArg)))::VARCHAR));

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_CuentaContable_nombre(null::VARCHAR(50));

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CuentaContable_porcentaje() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CuentaContable_porcentaje() RETURNS DECIMAL(6,3) AS $$

	SELECT (COALESCE(MAX(porcentaje),0) + 1)::DECIMAL(6,3) FROM massoftware.CuentaContable;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CuentaContable_porcentaje();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_CuentaContableById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_CuentaContableById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.CuentaContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaContable.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.CuentaContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaContable.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaContable.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_CuentaContableById('xxx');

-- SELECT * FROM massoftware.d_CuentaContableById((SELECT CuentaContable.id FROM massoftware.CuentaContable LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_CuentaContable(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(11)
		, nombreArg VARCHAR(50)
		, ejercicioContableArg VARCHAR(36)
		, integraArg VARCHAR(16)
		, cuentaJerarquiaArg VARCHAR(16)
		, imputableArg BOOLEAN
		, ajustaPorInflacionArg BOOLEAN
		, cuentaContableEstadoArg VARCHAR(36)
		, cuentaConApropiacionArg BOOLEAN
		, centroCostoContableArg VARCHAR(36)
		, cuentaAgrupadoraArg VARCHAR(50)
		, porcentajeArg DECIMAL(6,3)
		, puntoEquilibrioArg VARCHAR(36)
		, costoVentaArg VARCHAR(36)
		, seguridadPuertaArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_CuentaContable(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(11)
		, nombreArg VARCHAR(50)
		, ejercicioContableArg VARCHAR(36)
		, integraArg VARCHAR(16)
		, cuentaJerarquiaArg VARCHAR(16)
		, imputableArg BOOLEAN
		, ajustaPorInflacionArg BOOLEAN
		, cuentaContableEstadoArg VARCHAR(36)
		, cuentaConApropiacionArg BOOLEAN
		, centroCostoContableArg VARCHAR(36)
		, cuentaAgrupadoraArg VARCHAR(50)
		, porcentajeArg DECIMAL(6,3)
		, puntoEquilibrioArg VARCHAR(36)
		, costoVentaArg VARCHAR(36)
		, seguridadPuertaArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF imputableArg IS NULL THEN

		imputableArg = false;

	END IF;

	IF ajustaPorInflacionArg IS NULL THEN

		ajustaPorInflacionArg = false;

	END IF;

	IF cuentaConApropiacionArg IS NULL THEN

		cuentaConApropiacionArg = false;

	END IF;

	INSERT INTO massoftware.CuentaContable(id, codigo, nombre, ejercicioContable, integra, cuentaJerarquia, imputable, ajustaPorInflacion, cuentaContableEstado, cuentaConApropiacion, centroCostoContable, cuentaAgrupadora, porcentaje, puntoEquilibrio, costoVenta, seguridadPuerta) VALUES (idArg, codigoArg, nombreArg, ejercicioContableArg, integraArg, cuentaJerarquiaArg, imputableArg, ajustaPorInflacionArg, cuentaContableEstadoArg, cuentaConApropiacionArg, centroCostoContableArg, cuentaAgrupadoraArg, porcentajeArg, puntoEquilibrioArg, costoVentaArg, seguridadPuertaArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaContable.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_CuentaContable(
		null::VARCHAR(36)
		, null::VARCHAR(11)
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::VARCHAR(16)
		, null::VARCHAR(16)
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::VARCHAR(50)
		, null::DECIMAL(6,3)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_CuentaContable(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(11)
		, nombreArg VARCHAR(50)
		, ejercicioContableArg VARCHAR(36)
		, integraArg VARCHAR(16)
		, cuentaJerarquiaArg VARCHAR(16)
		, imputableArg BOOLEAN
		, ajustaPorInflacionArg BOOLEAN
		, cuentaContableEstadoArg VARCHAR(36)
		, cuentaConApropiacionArg BOOLEAN
		, centroCostoContableArg VARCHAR(36)
		, cuentaAgrupadoraArg VARCHAR(50)
		, porcentajeArg DECIMAL(6,3)
		, puntoEquilibrioArg VARCHAR(36)
		, costoVentaArg VARCHAR(36)
		, seguridadPuertaArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_CuentaContable(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(11)
		, nombreArg VARCHAR(50)
		, ejercicioContableArg VARCHAR(36)
		, integraArg VARCHAR(16)
		, cuentaJerarquiaArg VARCHAR(16)
		, imputableArg BOOLEAN
		, ajustaPorInflacionArg BOOLEAN
		, cuentaContableEstadoArg VARCHAR(36)
		, cuentaConApropiacionArg BOOLEAN
		, centroCostoContableArg VARCHAR(36)
		, cuentaAgrupadoraArg VARCHAR(50)
		, porcentajeArg DECIMAL(6,3)
		, puntoEquilibrioArg VARCHAR(36)
		, costoVentaArg VARCHAR(36)
		, seguridadPuertaArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF imputableArg IS NULL THEN

		imputableArg = false;

	END IF;

	IF ajustaPorInflacionArg IS NULL THEN

		ajustaPorInflacionArg = false;

	END IF;

	IF cuentaConApropiacionArg IS NULL THEN

		cuentaConApropiacionArg = false;

	END IF;

	UPDATE massoftware.CuentaContable SET 
		  codigo = codigoArg
		, nombre = nombreArg
		, ejercicioContable = ejercicioContableArg
		, integra = integraArg
		, cuentaJerarquia = cuentaJerarquiaArg
		, imputable = imputableArg
		, ajustaPorInflacion = ajustaPorInflacionArg
		, cuentaContableEstado = cuentaContableEstadoArg
		, cuentaConApropiacion = cuentaConApropiacionArg
		, centroCostoContable = centroCostoContableArg
		, cuentaAgrupadora = cuentaAgrupadoraArg
		, porcentaje = porcentajeArg
		, puntoEquilibrio = puntoEquilibrioArg
		, costoVenta = costoVentaArg
		, seguridadPuerta = seguridadPuertaArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaContable.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaContable.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_CuentaContable(
		null::VARCHAR(36)
		, null::VARCHAR(11)
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::VARCHAR(16)
		, null::VARCHAR(16)
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::VARCHAR(50)
		, null::DECIMAL(6,3)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/

DROP TYPE IF EXISTS massoftware.t_CuentaContable_1 CASCADE;

CREATE TYPE massoftware.t_CuentaContable_1 AS (

	  CuentaContable_id                       	VARCHAR(36) 		-- 0	CuentaContable.id
	, CuentaContable_codigo                   	VARCHAR(11) 		-- 1	CuentaContable.codigo
	, CuentaContable_nombre                   	VARCHAR(50) 		-- 2	CuentaContable.nombre
	, EjercicioContable_3_id                  	VARCHAR(36) 		-- 3	CuentaContable.EjercicioContable.id
	, EjercicioContable_3_numero              	INTEGER     		-- 4	CuentaContable.EjercicioContable.numero
	, EjercicioContable_3_apertura            	DATE        		-- 5	CuentaContable.EjercicioContable.apertura
	, EjercicioContable_3_cierre              	DATE        		-- 6	CuentaContable.EjercicioContable.cierre
	, EjercicioContable_3_cerrado             	BOOLEAN     		-- 7	CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_3_cerradoModulos      	BOOLEAN     		-- 8	CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_3_comentario          	VARCHAR(250)		-- 9	CuentaContable.EjercicioContable.comentario
	, CuentaContable_integra                  	VARCHAR(16) 		-- 10	CuentaContable.integra
	, CuentaContable_cuentaJerarquia          	VARCHAR(16) 		-- 11	CuentaContable.cuentaJerarquia
	, CuentaContable_imputable                	BOOLEAN     		-- 12	CuentaContable.imputable
	, CuentaContable_ajustaPorInflacion       	BOOLEAN     		-- 13	CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_14_id              	VARCHAR(36) 		-- 14	CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_14_numero          	INTEGER     		-- 15	CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_14_nombre          	VARCHAR(50) 		-- 16	CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_cuentaConApropiacion     	BOOLEAN     		-- 17	CuentaContable.cuentaConApropiacion
	, CentroCostoContable_18_id               	VARCHAR(36) 		-- 18	CuentaContable.CentroCostoContable.id
	, CentroCostoContable_18_numero           	INTEGER     		-- 19	CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_18_nombre           	VARCHAR(50) 		-- 20	CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_18_abreviatura      	VARCHAR(5)  		-- 21	CuentaContable.CentroCostoContable.abreviatura
	, CentroCostoContable_18_ejercicioContable	VARCHAR(36) 		-- 22	CuentaContable.CentroCostoContable.ejercicioContable
	, CuentaContable_cuentaAgrupadora         	VARCHAR(50) 		-- 23	CuentaContable.cuentaAgrupadora
	, CuentaContable_porcentaje               	DECIMAL(6,3)		-- 24	CuentaContable.porcentaje
	, PuntoEquilibrio_25_id                   	VARCHAR(36) 		-- 25	CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_25_numero               	INTEGER     		-- 26	CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_25_nombre               	VARCHAR(50) 		-- 27	CuentaContable.PuntoEquilibrio.nombre
	, PuntoEquilibrio_25_tipoPuntoEquilibrio  	VARCHAR(36) 		-- 28	CuentaContable.PuntoEquilibrio.tipoPuntoEquilibrio
	, PuntoEquilibrio_25_ejercicioContable    	VARCHAR(36) 		-- 29	CuentaContable.PuntoEquilibrio.ejercicioContable
	, CostoVenta_30_id                        	VARCHAR(36) 		-- 30	CuentaContable.CostoVenta.id
	, CostoVenta_30_numero                    	INTEGER     		-- 31	CuentaContable.CostoVenta.numero
	, CostoVenta_30_nombre                    	VARCHAR(50) 		-- 32	CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_33_id                   	VARCHAR(36) 		-- 33	CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_33_numero               	INTEGER     		-- 34	CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_33_nombre               	VARCHAR(50) 		-- 35	CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_33_equate               	VARCHAR(30) 		-- 36	CuentaContable.SeguridadPuerta.equate
	, SeguridadPuerta_33_seguridadModulo      	VARCHAR(36) 		-- 37	CuentaContable.SeguridadPuerta.seguridadModulo

);

DROP TYPE IF EXISTS massoftware.t_CuentaContable_2 CASCADE;

CREATE TYPE massoftware.t_CuentaContable_2 AS (

	  CuentaContable_id                  	VARCHAR(36) 		-- 0	CuentaContable.id
	, CuentaContable_codigo              	VARCHAR(11) 		-- 1	CuentaContable.codigo
	, CuentaContable_nombre              	VARCHAR(50) 		-- 2	CuentaContable.nombre
	, EjercicioContable_3_id             	VARCHAR(36) 		-- 3	CuentaContable.EjercicioContable.id
	, EjercicioContable_3_numero         	INTEGER     		-- 4	CuentaContable.EjercicioContable.numero
	, EjercicioContable_3_apertura       	DATE        		-- 5	CuentaContable.EjercicioContable.apertura
	, EjercicioContable_3_cierre         	DATE        		-- 6	CuentaContable.EjercicioContable.cierre
	, EjercicioContable_3_cerrado        	BOOLEAN     		-- 7	CuentaContable.EjercicioContable.cerrado
	, EjercicioContable_3_cerradoModulos 	BOOLEAN     		-- 8	CuentaContable.EjercicioContable.cerradoModulos
	, EjercicioContable_3_comentario     	VARCHAR(250)		-- 9	CuentaContable.EjercicioContable.comentario
	, CuentaContable_integra             	VARCHAR(16) 		-- 10	CuentaContable.integra
	, CuentaContable_cuentaJerarquia     	VARCHAR(16) 		-- 11	CuentaContable.cuentaJerarquia
	, CuentaContable_imputable           	BOOLEAN     		-- 12	CuentaContable.imputable
	, CuentaContable_ajustaPorInflacion  	BOOLEAN     		-- 13	CuentaContable.ajustaPorInflacion
	, CuentaContableEstado_14_id         	VARCHAR(36) 		-- 14	CuentaContable.CuentaContableEstado.id
	, CuentaContableEstado_14_numero     	INTEGER     		-- 15	CuentaContable.CuentaContableEstado.numero
	, CuentaContableEstado_14_nombre     	VARCHAR(50) 		-- 16	CuentaContable.CuentaContableEstado.nombre
	, CuentaContable_cuentaConApropiacion	BOOLEAN     		-- 17	CuentaContable.cuentaConApropiacion
	, CentroCostoContable_18_id          	VARCHAR(36) 		-- 18	CuentaContable.CentroCostoContable.id
	, CentroCostoContable_18_numero      	INTEGER     		-- 19	CuentaContable.CentroCostoContable.numero
	, CentroCostoContable_18_nombre      	VARCHAR(50) 		-- 20	CuentaContable.CentroCostoContable.nombre
	, CentroCostoContable_18_abreviatura 	VARCHAR(5)  		-- 21	CuentaContable.CentroCostoContable.abreviatura
	, EjercicioContable_22_id            	VARCHAR(36) 		-- 22	CuentaContable.CentroCostoContable.EjercicioContable.id
	, EjercicioContable_22_numero        	INTEGER     		-- 23	CuentaContable.CentroCostoContable.EjercicioContable.numero
	, EjercicioContable_22_apertura      	DATE        		-- 24	CuentaContable.CentroCostoContable.EjercicioContable.apertura
	, EjercicioContable_22_cierre        	DATE        		-- 25	CuentaContable.CentroCostoContable.EjercicioContable.cierre
	, EjercicioContable_22_cerrado       	BOOLEAN     		-- 26	CuentaContable.CentroCostoContable.EjercicioContable.cerrado
	, EjercicioContable_22_cerradoModulos	BOOLEAN     		-- 27	CuentaContable.CentroCostoContable.EjercicioContable.cerradoModulos
	, EjercicioContable_22_comentario    	VARCHAR(250)		-- 28	CuentaContable.CentroCostoContable.EjercicioContable.comentario
	, CuentaContable_cuentaAgrupadora    	VARCHAR(50) 		-- 29	CuentaContable.cuentaAgrupadora
	, CuentaContable_porcentaje          	DECIMAL(6,3)		-- 30	CuentaContable.porcentaje
	, PuntoEquilibrio_31_id              	VARCHAR(36) 		-- 31	CuentaContable.PuntoEquilibrio.id
	, PuntoEquilibrio_31_numero          	INTEGER     		-- 32	CuentaContable.PuntoEquilibrio.numero
	, PuntoEquilibrio_31_nombre          	VARCHAR(50) 		-- 33	CuentaContable.PuntoEquilibrio.nombre
	, TipoPuntoEquilibrio_34_id          	VARCHAR(36) 		-- 34	CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.id
	, TipoPuntoEquilibrio_34_numero      	INTEGER     		-- 35	CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.numero
	, TipoPuntoEquilibrio_34_nombre      	VARCHAR(50) 		-- 36	CuentaContable.PuntoEquilibrio.TipoPuntoEquilibrio.nombre
	, EjercicioContable_37_id            	VARCHAR(36) 		-- 37	CuentaContable.PuntoEquilibrio.EjercicioContable.id
	, EjercicioContable_37_numero        	INTEGER     		-- 38	CuentaContable.PuntoEquilibrio.EjercicioContable.numero
	, EjercicioContable_37_apertura      	DATE        		-- 39	CuentaContable.PuntoEquilibrio.EjercicioContable.apertura
	, EjercicioContable_37_cierre        	DATE        		-- 40	CuentaContable.PuntoEquilibrio.EjercicioContable.cierre
	, EjercicioContable_37_cerrado       	BOOLEAN     		-- 41	CuentaContable.PuntoEquilibrio.EjercicioContable.cerrado
	, EjercicioContable_37_cerradoModulos	BOOLEAN     		-- 42	CuentaContable.PuntoEquilibrio.EjercicioContable.cerradoModulos
	, EjercicioContable_37_comentario    	VARCHAR(250)		-- 43	CuentaContable.PuntoEquilibrio.EjercicioContable.comentario
	, CostoVenta_44_id                   	VARCHAR(36) 		-- 44	CuentaContable.CostoVenta.id
	, CostoVenta_44_numero               	INTEGER     		-- 45	CuentaContable.CostoVenta.numero
	, CostoVenta_44_nombre               	VARCHAR(50) 		-- 46	CuentaContable.CostoVenta.nombre
	, SeguridadPuerta_47_id              	VARCHAR(36) 		-- 47	CuentaContable.SeguridadPuerta.id
	, SeguridadPuerta_47_numero          	INTEGER     		-- 48	CuentaContable.SeguridadPuerta.numero
	, SeguridadPuerta_47_nombre          	VARCHAR(50) 		-- 49	CuentaContable.SeguridadPuerta.nombre
	, SeguridadPuerta_47_equate          	VARCHAR(30) 		-- 50	CuentaContable.SeguridadPuerta.equate
	, SeguridadModulo_51_id              	VARCHAR(36) 		-- 51	CuentaContable.SeguridadPuerta.SeguridadModulo.id
	, SeguridadModulo_51_numero          	INTEGER     		-- 52	CuentaContable.SeguridadPuerta.SeguridadModulo.numero
	, SeguridadModulo_51_nombre          	VARCHAR(50) 		-- 53	CuentaContable.SeguridadPuerta.SeguridadModulo.nombre

);

DROP FUNCTION IF EXISTS massoftware.f_CuentaContable (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, codigoArg5              VARCHAR(11)	-- 5
	, nombreArg6              VARCHAR(50)	-- 6
	, ejercicioContableArg7   VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaContable (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, codigoArg5              VARCHAR(11)	-- 5
	, nombreArg6              VARCHAR(50)	-- 6
	, ejercicioContableArg7   VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.CuentaContable AS $$

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
				  CuentaContable.id                      AS CuentaContable_id                  	-- 0	.id                 		VARCHAR(36)
				, CuentaContable.codigo                  AS CuentaContable_codigo              	-- 1	.codigo             		VARCHAR(11)
				, CuentaContable.nombre                  AS CuentaContable_nombre              	-- 2	.nombre             		VARCHAR(50)
				, CuentaContable.ejercicioContable       AS CuentaContable_ejercicioContable   	-- 3	.ejercicioContable  		VARCHAR(36)	EjercicioContable.id
				, CuentaContable.integra                 AS CuentaContable_integra             	-- 4	.integra            		VARCHAR(16)
				, CuentaContable.cuentaJerarquia         AS CuentaContable_cuentaJerarquia     	-- 5	.cuentaJerarquia    		VARCHAR(16)
				, CuentaContable.imputable               AS CuentaContable_imputable           	-- 6	.imputable          		BOOLEAN
				, CuentaContable.ajustaPorInflacion      AS CuentaContable_ajustaPorInflacion  	-- 7	.ajustaPorInflacion 		BOOLEAN
				, CuentaContable.cuentaContableEstado    AS CuentaContable_cuentaContableEstado	-- 8	.cuentaContableEstado		VARCHAR(36)	CuentaContableEstado.id
				, CuentaContable.cuentaConApropiacion    AS CuentaContable_cuentaConApropiacion	-- 9	.cuentaConApropiacion		BOOLEAN
				, CuentaContable.centroCostoContable     AS CuentaContable_centroCostoContable 	-- 10	.centroCostoContable		VARCHAR(36)	CentroCostoContable.id
				, CuentaContable.cuentaAgrupadora        AS CuentaContable_cuentaAgrupadora    	-- 11	.cuentaAgrupadora   		VARCHAR(50)
				, CuentaContable.porcentaje              AS CuentaContable_porcentaje          	-- 12	.porcentaje         		DECIMAL(6,3)
				, CuentaContable.puntoEquilibrio         AS CuentaContable_puntoEquilibrio     	-- 13	.puntoEquilibrio    		VARCHAR(36)	PuntoEquilibrio.id
				, CuentaContable.costoVenta              AS CuentaContable_costoVenta          	-- 14	.costoVenta         		VARCHAR(36)	CostoVenta.id
				, CuentaContable.seguridadPuerta         AS CuentaContable_seguridadPuerta     	-- 15	.seguridadPuerta    		VARCHAR(36)	SeguridadPuerta.id

		FROM	massoftware.CuentaContable

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaContable.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND codigoArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(codigoArg5)) > 0 THEN
		codigoArg5 = REPLACE(codigoArg5, '''', '''''');
		codigoArg5 = LOWER(TRIM(codigoArg5));
		codigoArg5 = TRANSLATE(codigoArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(codigoArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContable.codigo),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContable.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND ejercicioContableArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(ejercicioContableArg7)) > 0 THEN
		ejercicioContableArg7 = REPLACE(ejercicioContableArg7, '''', '''''');
		ejercicioContableArg7 = LOWER(TRIM(ejercicioContableArg7));
		ejercicioContableArg7 = TRANSLATE(ejercicioContableArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ejercicioContableArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContable.ejercicioContable),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaContableById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaContableById (idArg VARCHAR(36)) RETURNS SETOF massoftware.CuentaContable AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaContable ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaContable ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaContableById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_CuentaContable_1 (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, codigoArg5              VARCHAR(11)	-- 5
	, nombreArg6              VARCHAR(50)	-- 6
	, ejercicioContableArg7   VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaContable_1 (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, codigoArg5              VARCHAR(11)	-- 5
	, nombreArg6              VARCHAR(50)	-- 6
	, ejercicioContableArg7   VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.t_CuentaContable_1 AS $$

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
				  CuentaContable.id                            AS CuentaContable_id                       	-- 0	.id                                  		VARCHAR(36)
				, CuentaContable.codigo                        AS CuentaContable_codigo                   	-- 1	.codigo                              		VARCHAR(11)
				, CuentaContable.nombre                        AS CuentaContable_nombre                   	-- 2	.nombre                              		VARCHAR(50)
				, EjercicioContable_3.id                       AS EjercicioContable_3_id                  	-- 3	.EjercicioContable.id                		VARCHAR(36)
				, EjercicioContable_3.numero                   AS EjercicioContable_3_numero              	-- 4	.EjercicioContable.numero            		INTEGER
				, EjercicioContable_3.apertura                 AS EjercicioContable_3_apertura            	-- 5	.EjercicioContable.apertura          		DATE
				, EjercicioContable_3.cierre                   AS EjercicioContable_3_cierre              	-- 6	.EjercicioContable.cierre            		DATE
				, EjercicioContable_3.cerrado                  AS EjercicioContable_3_cerrado             	-- 7	.EjercicioContable.cerrado           		BOOLEAN
				, EjercicioContable_3.cerradoModulos           AS EjercicioContable_3_cerradoModulos      	-- 8	.EjercicioContable.cerradoModulos    		BOOLEAN
				, EjercicioContable_3.comentario               AS EjercicioContable_3_comentario          	-- 9	.EjercicioContable.comentario        		VARCHAR(250)
				, CuentaContable.integra                       AS CuentaContable_integra                  	-- 10	.integra                             		VARCHAR(16)
				, CuentaContable.cuentaJerarquia               AS CuentaContable_cuentaJerarquia          	-- 11	.cuentaJerarquia                     		VARCHAR(16)
				, CuentaContable.imputable                     AS CuentaContable_imputable                	-- 12	.imputable                           		BOOLEAN
				, CuentaContable.ajustaPorInflacion            AS CuentaContable_ajustaPorInflacion       	-- 13	.ajustaPorInflacion                  		BOOLEAN
				, CuentaContableEstado_14.id                   AS CuentaContableEstado_14_id              	-- 14	.CuentaContableEstado.id             		VARCHAR(36)
				, CuentaContableEstado_14.numero               AS CuentaContableEstado_14_numero          	-- 15	.CuentaContableEstado.numero         		INTEGER
				, CuentaContableEstado_14.nombre               AS CuentaContableEstado_14_nombre          	-- 16	.CuentaContableEstado.nombre         		VARCHAR(50)
				, CuentaContable.cuentaConApropiacion          AS CuentaContable_cuentaConApropiacion     	-- 17	.cuentaConApropiacion                		BOOLEAN
				, CentroCostoContable_18.id                    AS CentroCostoContable_18_id               	-- 18	.CentroCostoContable.id              		VARCHAR(36)
				, CentroCostoContable_18.numero                AS CentroCostoContable_18_numero           	-- 19	.CentroCostoContable.numero          		INTEGER
				, CentroCostoContable_18.nombre                AS CentroCostoContable_18_nombre           	-- 20	.CentroCostoContable.nombre          		VARCHAR(50)
				, CentroCostoContable_18.abreviatura           AS CentroCostoContable_18_abreviatura      	-- 21	.CentroCostoContable.abreviatura     		VARCHAR(5)
				, CentroCostoContable_18.ejercicioContable     AS CentroCostoContable_18_ejercicioContable	-- 22	.CentroCostoContable.ejercicioContable		VARCHAR(36)	EjercicioContable.id
				, CuentaContable.cuentaAgrupadora              AS CuentaContable_cuentaAgrupadora         	-- 23	.cuentaAgrupadora                    		VARCHAR(50)
				, CuentaContable.porcentaje                    AS CuentaContable_porcentaje               	-- 24	.porcentaje                          		DECIMAL(6,3)
				, PuntoEquilibrio_25.id                        AS PuntoEquilibrio_25_id                   	-- 25	.PuntoEquilibrio.id                  		VARCHAR(36)
				, PuntoEquilibrio_25.numero                    AS PuntoEquilibrio_25_numero               	-- 26	.PuntoEquilibrio.numero              		INTEGER
				, PuntoEquilibrio_25.nombre                    AS PuntoEquilibrio_25_nombre               	-- 27	.PuntoEquilibrio.nombre              		VARCHAR(50)
				, PuntoEquilibrio_25.tipoPuntoEquilibrio       AS PuntoEquilibrio_25_tipoPuntoEquilibrio  	-- 28	.PuntoEquilibrio.tipoPuntoEquilibrio 		VARCHAR(36)	TipoPuntoEquilibrio.id
				, PuntoEquilibrio_25.ejercicioContable         AS PuntoEquilibrio_25_ejercicioContable    	-- 29	.PuntoEquilibrio.ejercicioContable   		VARCHAR(36)	EjercicioContable.id
				, CostoVenta_30.id                             AS CostoVenta_30_id                        	-- 30	.CostoVenta.id                       		VARCHAR(36)
				, CostoVenta_30.numero                         AS CostoVenta_30_numero                    	-- 31	.CostoVenta.numero                   		INTEGER
				, CostoVenta_30.nombre                         AS CostoVenta_30_nombre                    	-- 32	.CostoVenta.nombre                   		VARCHAR(50)
				, SeguridadPuerta_33.id                        AS SeguridadPuerta_33_id                   	-- 33	.SeguridadPuerta.id                  		VARCHAR(36)
				, SeguridadPuerta_33.numero                    AS SeguridadPuerta_33_numero               	-- 34	.SeguridadPuerta.numero              		INTEGER
				, SeguridadPuerta_33.nombre                    AS SeguridadPuerta_33_nombre               	-- 35	.SeguridadPuerta.nombre              		VARCHAR(50)
				, SeguridadPuerta_33.equate                    AS SeguridadPuerta_33_equate               	-- 36	.SeguridadPuerta.equate              		VARCHAR(30)
				, SeguridadPuerta_33.seguridadModulo           AS SeguridadPuerta_33_seguridadModulo      	-- 37	.SeguridadPuerta.seguridadModulo     		VARCHAR(36)	SeguridadModulo.id

		FROM	massoftware.CuentaContable
			LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_3            ON CuentaContable.ejercicioContable = EjercicioContable_3.id 	-- 3 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_14        ON CuentaContable.cuentaContableEstado = CuentaContableEstado_14.id 	-- 14 LEFT LEVEL: 1
			LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_18         ON CuentaContable.centroCostoContable = CentroCostoContable_18.id 	-- 18 LEFT LEVEL: 1
			LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_25             ON CuentaContable.puntoEquilibrio = PuntoEquilibrio_25.id 	-- 25 LEFT LEVEL: 1
			LEFT JOIN massoftware.CostoVenta AS CostoVenta_30                  ON CuentaContable.costoVenta = CostoVenta_30.id 	-- 30 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_33             ON CuentaContable.seguridadPuerta = SeguridadPuerta_33.id 	-- 33 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaContable.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND codigoArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(codigoArg5)) > 0 THEN
		codigoArg5 = REPLACE(codigoArg5, '''', '''''');
		codigoArg5 = LOWER(TRIM(codigoArg5));
		codigoArg5 = TRANSLATE(codigoArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(codigoArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContable.codigo),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContable.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND ejercicioContableArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(ejercicioContableArg7)) > 0 THEN
		ejercicioContableArg7 = REPLACE(ejercicioContableArg7, '''', '''''');
		ejercicioContableArg7 = LOWER(TRIM(ejercicioContableArg7));
		ejercicioContableArg7 = TRANSLATE(ejercicioContableArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ejercicioContableArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContable.ejercicioContable),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaContableById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaContableById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_CuentaContable_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaContable_1 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaContable_1 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaContableById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_CuentaContable_2 (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, codigoArg5              VARCHAR(11)	-- 5
	, nombreArg6              VARCHAR(50)	-- 6
	, ejercicioContableArg7   VARCHAR(36)	-- 7

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaContable_2 (

	  idArg0                  VARCHAR(36)	-- 0
	, orderByArg1             INTEGER    	-- 1
	, orderByDescArg2         BOOLEAN    	-- 2
	, limitArg3               BIGINT     	-- 3
	, offSetArg4              BIGINT     	-- 4
	, codigoArg5              VARCHAR(11)	-- 5
	, nombreArg6              VARCHAR(50)	-- 6
	, ejercicioContableArg7   VARCHAR(36)	-- 7

) RETURNS SETOF massoftware.t_CuentaContable_2 AS $$

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
				  CuentaContable.id                       AS CuentaContable_id                  	-- 0	.id                                                 		VARCHAR(36)
				, CuentaContable.codigo                   AS CuentaContable_codigo              	-- 1	.codigo                                             		VARCHAR(11)
				, CuentaContable.nombre                   AS CuentaContable_nombre              	-- 2	.nombre                                             		VARCHAR(50)
				, EjercicioContable_3.id                  AS EjercicioContable_3_id             	-- 3	.EjercicioContable.id                               		VARCHAR(36)
				, EjercicioContable_3.numero              AS EjercicioContable_3_numero         	-- 4	.EjercicioContable.numero                           		INTEGER
				, EjercicioContable_3.apertura            AS EjercicioContable_3_apertura       	-- 5	.EjercicioContable.apertura                         		DATE
				, EjercicioContable_3.cierre              AS EjercicioContable_3_cierre         	-- 6	.EjercicioContable.cierre                           		DATE
				, EjercicioContable_3.cerrado             AS EjercicioContable_3_cerrado        	-- 7	.EjercicioContable.cerrado                          		BOOLEAN
				, EjercicioContable_3.cerradoModulos      AS EjercicioContable_3_cerradoModulos 	-- 8	.EjercicioContable.cerradoModulos                   		BOOLEAN
				, EjercicioContable_3.comentario          AS EjercicioContable_3_comentario     	-- 9	.EjercicioContable.comentario                       		VARCHAR(250)
				, CuentaContable.integra                  AS CuentaContable_integra             	-- 10	.integra                                            		VARCHAR(16)
				, CuentaContable.cuentaJerarquia          AS CuentaContable_cuentaJerarquia     	-- 11	.cuentaJerarquia                                    		VARCHAR(16)
				, CuentaContable.imputable                AS CuentaContable_imputable           	-- 12	.imputable                                          		BOOLEAN
				, CuentaContable.ajustaPorInflacion       AS CuentaContable_ajustaPorInflacion  	-- 13	.ajustaPorInflacion                                 		BOOLEAN
				, CuentaContableEstado_14.id              AS CuentaContableEstado_14_id         	-- 14	.CuentaContableEstado.id                            		VARCHAR(36)
				, CuentaContableEstado_14.numero          AS CuentaContableEstado_14_numero     	-- 15	.CuentaContableEstado.numero                        		INTEGER
				, CuentaContableEstado_14.nombre          AS CuentaContableEstado_14_nombre     	-- 16	.CuentaContableEstado.nombre                        		VARCHAR(50)
				, CuentaContable.cuentaConApropiacion     AS CuentaContable_cuentaConApropiacion	-- 17	.cuentaConApropiacion                               		BOOLEAN
				, CentroCostoContable_18.id               AS CentroCostoContable_18_id          	-- 18	.CentroCostoContable.id                             		VARCHAR(36)
				, CentroCostoContable_18.numero           AS CentroCostoContable_18_numero      	-- 19	.CentroCostoContable.numero                         		INTEGER
				, CentroCostoContable_18.nombre           AS CentroCostoContable_18_nombre      	-- 20	.CentroCostoContable.nombre                         		VARCHAR(50)
				, CentroCostoContable_18.abreviatura      AS CentroCostoContable_18_abreviatura 	-- 21	.CentroCostoContable.abreviatura                    		VARCHAR(5)
				, EjercicioContable_22.id                 AS EjercicioContable_22_id            	-- 22	.CentroCostoContable.EjercicioContable.id           		VARCHAR(36)
				, EjercicioContable_22.numero             AS EjercicioContable_22_numero        	-- 23	.CentroCostoContable.EjercicioContable.numero       		INTEGER
				, EjercicioContable_22.apertura           AS EjercicioContable_22_apertura      	-- 24	.CentroCostoContable.EjercicioContable.apertura     		DATE
				, EjercicioContable_22.cierre             AS EjercicioContable_22_cierre        	-- 25	.CentroCostoContable.EjercicioContable.cierre       		DATE
				, EjercicioContable_22.cerrado            AS EjercicioContable_22_cerrado       	-- 26	.CentroCostoContable.EjercicioContable.cerrado      		BOOLEAN
				, EjercicioContable_22.cerradoModulos     AS EjercicioContable_22_cerradoModulos	-- 27	.CentroCostoContable.EjercicioContable.cerradoModulos		BOOLEAN
				, EjercicioContable_22.comentario         AS EjercicioContable_22_comentario    	-- 28	.CentroCostoContable.EjercicioContable.comentario   		VARCHAR(250)
				, CuentaContable.cuentaAgrupadora         AS CuentaContable_cuentaAgrupadora    	-- 29	.cuentaAgrupadora                                   		VARCHAR(50)
				, CuentaContable.porcentaje               AS CuentaContable_porcentaje          	-- 30	.porcentaje                                         		DECIMAL(6,3)
				, PuntoEquilibrio_31.id                   AS PuntoEquilibrio_31_id              	-- 31	.PuntoEquilibrio.id                                 		VARCHAR(36)
				, PuntoEquilibrio_31.numero               AS PuntoEquilibrio_31_numero          	-- 32	.PuntoEquilibrio.numero                             		INTEGER
				, PuntoEquilibrio_31.nombre               AS PuntoEquilibrio_31_nombre          	-- 33	.PuntoEquilibrio.nombre                             		VARCHAR(50)
				, TipoPuntoEquilibrio_34.id               AS TipoPuntoEquilibrio_34_id          	-- 34	.PuntoEquilibrio.TipoPuntoEquilibrio.id             		VARCHAR(36)
				, TipoPuntoEquilibrio_34.numero           AS TipoPuntoEquilibrio_34_numero      	-- 35	.PuntoEquilibrio.TipoPuntoEquilibrio.numero         		INTEGER
				, TipoPuntoEquilibrio_34.nombre           AS TipoPuntoEquilibrio_34_nombre      	-- 36	.PuntoEquilibrio.TipoPuntoEquilibrio.nombre         		VARCHAR(50)
				, EjercicioContable_37.id                 AS EjercicioContable_37_id            	-- 37	.PuntoEquilibrio.EjercicioContable.id               		VARCHAR(36)
				, EjercicioContable_37.numero             AS EjercicioContable_37_numero        	-- 38	.PuntoEquilibrio.EjercicioContable.numero           		INTEGER
				, EjercicioContable_37.apertura           AS EjercicioContable_37_apertura      	-- 39	.PuntoEquilibrio.EjercicioContable.apertura         		DATE
				, EjercicioContable_37.cierre             AS EjercicioContable_37_cierre        	-- 40	.PuntoEquilibrio.EjercicioContable.cierre           		DATE
				, EjercicioContable_37.cerrado            AS EjercicioContable_37_cerrado       	-- 41	.PuntoEquilibrio.EjercicioContable.cerrado          		BOOLEAN
				, EjercicioContable_37.cerradoModulos     AS EjercicioContable_37_cerradoModulos	-- 42	.PuntoEquilibrio.EjercicioContable.cerradoModulos   		BOOLEAN
				, EjercicioContable_37.comentario         AS EjercicioContable_37_comentario    	-- 43	.PuntoEquilibrio.EjercicioContable.comentario       		VARCHAR(250)
				, CostoVenta_44.id                        AS CostoVenta_44_id                   	-- 44	.CostoVenta.id                                      		VARCHAR(36)
				, CostoVenta_44.numero                    AS CostoVenta_44_numero               	-- 45	.CostoVenta.numero                                  		INTEGER
				, CostoVenta_44.nombre                    AS CostoVenta_44_nombre               	-- 46	.CostoVenta.nombre                                  		VARCHAR(50)
				, SeguridadPuerta_47.id                   AS SeguridadPuerta_47_id              	-- 47	.SeguridadPuerta.id                                 		VARCHAR(36)
				, SeguridadPuerta_47.numero               AS SeguridadPuerta_47_numero          	-- 48	.SeguridadPuerta.numero                             		INTEGER
				, SeguridadPuerta_47.nombre               AS SeguridadPuerta_47_nombre          	-- 49	.SeguridadPuerta.nombre                             		VARCHAR(50)
				, SeguridadPuerta_47.equate               AS SeguridadPuerta_47_equate          	-- 50	.SeguridadPuerta.equate                             		VARCHAR(30)
				, SeguridadModulo_51.id                   AS SeguridadModulo_51_id              	-- 51	.SeguridadPuerta.SeguridadModulo.id                 		VARCHAR(36)
				, SeguridadModulo_51.numero               AS SeguridadModulo_51_numero          	-- 52	.SeguridadPuerta.SeguridadModulo.numero             		INTEGER
				, SeguridadModulo_51.nombre               AS SeguridadModulo_51_nombre          	-- 53	.SeguridadPuerta.SeguridadModulo.nombre             		VARCHAR(50)

		FROM	massoftware.CuentaContable
			LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_3              ON CuentaContable.ejercicioContable = EjercicioContable_3.id 	-- 3 LEFT LEVEL: 1
			LEFT JOIN massoftware.CuentaContableEstado AS CuentaContableEstado_14          ON CuentaContable.cuentaContableEstado = CuentaContableEstado_14.id 	-- 14 LEFT LEVEL: 1
			LEFT JOIN massoftware.CentroCostoContable AS CentroCostoContable_18           ON CuentaContable.centroCostoContable = CentroCostoContable_18.id 	-- 18 LEFT LEVEL: 1
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_22             ON CentroCostoContable_18.ejercicioContable = EjercicioContable_22.id 	-- 22 LEFT LEVEL: 2
			LEFT JOIN massoftware.PuntoEquilibrio AS PuntoEquilibrio_31               ON CuentaContable.puntoEquilibrio = PuntoEquilibrio_31.id 	-- 31 LEFT LEVEL: 1
				LEFT JOIN massoftware.TipoPuntoEquilibrio AS TipoPuntoEquilibrio_34           ON PuntoEquilibrio_31.tipoPuntoEquilibrio = TipoPuntoEquilibrio_34.id 	-- 34 LEFT LEVEL: 2
				LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_37             ON PuntoEquilibrio_31.ejercicioContable = EjercicioContable_37.id 	-- 37 LEFT LEVEL: 2
			LEFT JOIN massoftware.CostoVenta AS CostoVenta_44                    ON CuentaContable.costoVenta = CostoVenta_44.id 	-- 44 LEFT LEVEL: 1
			LEFT JOIN massoftware.SeguridadPuerta AS SeguridadPuerta_47               ON CuentaContable.seguridadPuerta = SeguridadPuerta_47.id 	-- 47 LEFT LEVEL: 1
				LEFT JOIN massoftware.SeguridadModulo AS SeguridadModulo_51               ON SeguridadPuerta_47.seguridadModulo = SeguridadModulo_51.id 	-- 51 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' CuentaContable.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND codigoArg5 IS NOT NULL AND CHAR_LENGTH(TRIM(codigoArg5)) > 0 THEN
		codigoArg5 = REPLACE(codigoArg5, '''', '''''');
		codigoArg5 = LOWER(TRIM(codigoArg5));
		codigoArg5 = TRANSLATE(codigoArg5,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(codigoArg5, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContable.codigo),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND nombreArg6 IS NOT NULL AND CHAR_LENGTH(TRIM(nombreArg6)) > 0 THEN
		nombreArg6 = REPLACE(nombreArg6, '''', '''''');
		nombreArg6 = LOWER(TRIM(nombreArg6));
		nombreArg6 = TRANSLATE(nombreArg6,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(nombreArg6, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContable.nombre),
				''/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'',
				''         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'') LIKE ' || '''%' || word || '%''';
				sqlSrcWhereCount = sqlSrcWhereCount + 1;
			END IF;
		END LOOP;
	END IF;

	IF searchById = false AND ejercicioContableArg7 IS NOT NULL AND CHAR_LENGTH(TRIM(ejercicioContableArg7)) > 0 THEN
		ejercicioContableArg7 = REPLACE(ejercicioContableArg7, '''', '''''');
		ejercicioContableArg7 = LOWER(TRIM(ejercicioContableArg7));
		ejercicioContableArg7 = TRANSLATE(ejercicioContableArg7,
			'/\"'''';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ',
			 '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN');
		words = regexp_split_to_array(ejercicioContableArg7, ' ');
		FOREACH word IN ARRAY words
		LOOP
			IF word IS NOT NULL AND CHAR_LENGTH(TRIM(word)) > 0 THEN
				word = TRIM(word);
				IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
				sqlSrcWhere = sqlSrcWhere || ' TRANSLATE(LOWER(CuentaContable.ejercicioContable),
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

DROP FUNCTION IF EXISTS massoftware.f_CuentaContableById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_CuentaContableById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_CuentaContable_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_CuentaContable_2 ( idArg , null, null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_CuentaContable_2 ( null , null, null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_CuentaContableById_2 ('xxx'); 