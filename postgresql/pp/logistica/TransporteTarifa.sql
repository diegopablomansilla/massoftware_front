
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TransporteTarifa                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TransporteTarifa



-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.TransporteTarifa CASCADE;

CREATE TABLE massoftware.TransporteTarifa
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº opción
	numero INTEGER NOT NULL  CONSTRAINT TransporteTarifa_numero_chk CHECK ( numero >= 1  ), 
	
	-- Carga
	carga VARCHAR(36)  NOT NULL  REFERENCES massoftware.Carga (id), 
	
	-- Ciudad
	ciudad VARCHAR(36)  NOT NULL  REFERENCES massoftware.Ciudad (id), 
	
	-- Precio flete
	precioFlete DECIMAL(13,5) NOT NULL  CONSTRAINT TransporteTarifa_precioFlete_chk CHECK ( precioFlete >= -9999.9999 AND precioFlete <= 99999.9999  ), 
	
	-- Precio unidad facturación
	precioUnidadFacturacion DECIMAL(13,5) CONSTRAINT TransporteTarifa_precioUnidadFacturacion_chk CHECK ( precioUnidadFacturacion >= -9999.9999 AND precioUnidadFacturacion <= 99999.9999  ), 
	
	-- Precio unidad stock
	precioUnidadStock DECIMAL(13,5) CONSTRAINT TransporteTarifa_precioUnidadStock_chk CHECK ( precioUnidadStock >= -9999.9999 AND precioUnidadStock <= 99999.9999  ), 
	
	-- Precio bultos
	precioBultos DECIMAL(13,5) CONSTRAINT TransporteTarifa_precioBultos_chk CHECK ( precioBultos >= -9999.9999 AND precioBultos <= 99999.9999  ), 
	
	-- Importe mínimo por entrega
	importeMinimoEntrega DECIMAL(13,5) CONSTRAINT TransporteTarifa_importeMinimoEntrega_chk CHECK ( importeMinimoEntrega >= -9999.9999 AND importeMinimoEntrega <= 99999.9999  ), 
	
	-- Importe mínimo por carga
	importeMinimoCarga DECIMAL(13,5) CONSTRAINT TransporteTarifa_importeMinimoCarga_chk CHECK ( importeMinimoCarga >= -9999.9999 AND importeMinimoCarga <= 99999.9999  )
);

-- ---------------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatTransporteTarifa() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatTransporteTarifa() RETURNS TRIGGER AS $formatTransporteTarifa$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.carga := massoftware.white_is_null(NEW.carga);
	 NEW.ciudad := massoftware.white_is_null(NEW.ciudad);

	RETURN NEW;
END;
$formatTransporteTarifa$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTransporteTarifa ON massoftware.TransporteTarifa CASCADE;

CREATE TRIGGER tgFormatTransporteTarifa BEFORE INSERT OR UPDATE
	ON massoftware.TransporteTarifa FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatTransporteTarifa();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.TransporteTarifa;

-- SELECT * FROM massoftware.TransporteTarifa LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.TransporteTarifa;

-- SELECT * FROM massoftware.TransporteTarifa WHERE id = 'xxx';

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TransporteTarifa_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_precioFlete() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_precioFlete() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(precioFlete),0) + 1)::DECIMAL(13,5) FROM massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TransporteTarifa_precioFlete();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_precioUnidadFacturacion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_precioUnidadFacturacion() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(precioUnidadFacturacion),0) + 1)::DECIMAL(13,5) FROM massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TransporteTarifa_precioUnidadFacturacion();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_precioUnidadStock() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_precioUnidadStock() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(precioUnidadStock),0) + 1)::DECIMAL(13,5) FROM massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TransporteTarifa_precioUnidadStock();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_precioBultos() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_precioBultos() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(precioBultos),0) + 1)::DECIMAL(13,5) FROM massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TransporteTarifa_precioBultos();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_importeMinimoEntrega() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_importeMinimoEntrega() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(importeMinimoEntrega),0) + 1)::DECIMAL(13,5) FROM massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TransporteTarifa_importeMinimoEntrega();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_importeMinimoCarga() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_importeMinimoCarga() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(importeMinimoCarga),0) + 1)::DECIMAL(13,5) FROM massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TransporteTarifa_importeMinimoCarga();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_TransporteTarifaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_TransporteTarifaById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.TransporteTarifa WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.TransporteTarifa WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TransporteTarifa WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_TransporteTarifaById('xxx');

-- SELECT * FROM massoftware.d_TransporteTarifaById((SELECT TransporteTarifa.id FROM massoftware.TransporteTarifa LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_TransporteTarifa(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, cargaArg VARCHAR(36)
		, ciudadArg VARCHAR(36)
		, precioFleteArg DECIMAL(13,5)
		, precioUnidadFacturacionArg DECIMAL(13,5)
		, precioUnidadStockArg DECIMAL(13,5)
		, precioBultosArg DECIMAL(13,5)
		, importeMinimoEntregaArg DECIMAL(13,5)
		, importeMinimoCargaArg DECIMAL(13,5)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_TransporteTarifa(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, cargaArg VARCHAR(36)
		, ciudadArg VARCHAR(36)
		, precioFleteArg DECIMAL(13,5)
		, precioUnidadFacturacionArg DECIMAL(13,5)
		, precioUnidadStockArg DECIMAL(13,5)
		, precioBultosArg DECIMAL(13,5)
		, importeMinimoEntregaArg DECIMAL(13,5)
		, importeMinimoCargaArg DECIMAL(13,5)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF precioFleteArg IS NULL THEN

		precioFleteArg = 0;

	END IF;

	IF precioUnidadFacturacionArg IS NULL THEN

		precioUnidadFacturacionArg = 0;

	END IF;

	IF precioUnidadStockArg IS NULL THEN

		precioUnidadStockArg = 0;

	END IF;

	IF precioBultosArg IS NULL THEN

		precioBultosArg = 0;

	END IF;

	IF importeMinimoEntregaArg IS NULL THEN

		importeMinimoEntregaArg = 0;

	END IF;

	IF importeMinimoCargaArg IS NULL THEN

		importeMinimoCargaArg = 0;

	END IF;

	INSERT INTO massoftware.TransporteTarifa(id, numero, carga, ciudad, precioFlete, precioUnidadFacturacion, precioUnidadStock, precioBultos, importeMinimoEntrega, importeMinimoCarga) VALUES (idArg, numeroArg, cargaArg, ciudadArg, precioFleteArg, precioUnidadFacturacionArg, precioUnidadStockArg, precioBultosArg, importeMinimoEntregaArg, importeMinimoCargaArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.TransporteTarifa WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_TransporteTarifa(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_TransporteTarifa(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, cargaArg VARCHAR(36)
		, ciudadArg VARCHAR(36)
		, precioFleteArg DECIMAL(13,5)
		, precioUnidadFacturacionArg DECIMAL(13,5)
		, precioUnidadStockArg DECIMAL(13,5)
		, precioBultosArg DECIMAL(13,5)
		, importeMinimoEntregaArg DECIMAL(13,5)
		, importeMinimoCargaArg DECIMAL(13,5)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_TransporteTarifa(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, cargaArg VARCHAR(36)
		, ciudadArg VARCHAR(36)
		, precioFleteArg DECIMAL(13,5)
		, precioUnidadFacturacionArg DECIMAL(13,5)
		, precioUnidadStockArg DECIMAL(13,5)
		, precioBultosArg DECIMAL(13,5)
		, importeMinimoEntregaArg DECIMAL(13,5)
		, importeMinimoCargaArg DECIMAL(13,5)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.TransporteTarifa SET 
		  numero = numeroArg
		, carga = cargaArg
		, ciudad = ciudadArg
		, precioFlete = precioFleteArg
		, precioUnidadFacturacion = precioUnidadFacturacionArg
		, precioUnidadStock = precioUnidadStockArg
		, precioBultos = precioBultosArg
		, importeMinimoEntrega = importeMinimoEntregaArg
		, importeMinimoCarga = importeMinimoCargaArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TransporteTarifa WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_TransporteTarifa(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
);

*/

DROP TYPE IF EXISTS massoftware.t_TransporteTarifa_1 CASCADE;

CREATE TYPE massoftware.t_TransporteTarifa_1 AS (

	  TransporteTarifa_id                     	VARCHAR(36)  		-- 0	TransporteTarifa.id
	, TransporteTarifa_numero                 	INTEGER      		-- 1	TransporteTarifa.numero
	, Carga_2_id                              	VARCHAR(36)  		-- 2	TransporteTarifa.Carga.id
	, Carga_2_numero                          	INTEGER      		-- 3	TransporteTarifa.Carga.numero
	, Carga_2_nombre                          	VARCHAR(50)  		-- 4	TransporteTarifa.Carga.nombre
	, Carga_2_transporte                      	VARCHAR(36)  		-- 5	TransporteTarifa.Carga.transporte
	, Ciudad_6_id                             	VARCHAR(36)  		-- 6	TransporteTarifa.Ciudad.id
	, Ciudad_6_numero                         	INTEGER      		-- 7	TransporteTarifa.Ciudad.numero
	, Ciudad_6_nombre                         	VARCHAR(50)  		-- 8	TransporteTarifa.Ciudad.nombre
	, Ciudad_6_departamento                   	VARCHAR(50)  		-- 9	TransporteTarifa.Ciudad.departamento
	, Ciudad_6_numeroAFIP                     	INTEGER      		-- 10	TransporteTarifa.Ciudad.numeroAFIP
	, Ciudad_6_provincia                      	VARCHAR(36)  		-- 11	TransporteTarifa.Ciudad.provincia
	, TransporteTarifa_precioFlete            	DECIMAL(13,5)		-- 12	TransporteTarifa.precioFlete
	, TransporteTarifa_precioUnidadFacturacion	DECIMAL(13,5)		-- 13	TransporteTarifa.precioUnidadFacturacion
	, TransporteTarifa_precioUnidadStock      	DECIMAL(13,5)		-- 14	TransporteTarifa.precioUnidadStock
	, TransporteTarifa_precioBultos           	DECIMAL(13,5)		-- 15	TransporteTarifa.precioBultos
	, TransporteTarifa_importeMinimoEntrega   	DECIMAL(13,5)		-- 16	TransporteTarifa.importeMinimoEntrega
	, TransporteTarifa_importeMinimoCarga     	DECIMAL(13,5)		-- 17	TransporteTarifa.importeMinimoCarga

);

DROP TYPE IF EXISTS massoftware.t_TransporteTarifa_2 CASCADE;

CREATE TYPE massoftware.t_TransporteTarifa_2 AS (

	  TransporteTarifa_id                     	VARCHAR(36)  		-- 0	TransporteTarifa.id
	, TransporteTarifa_numero                 	INTEGER      		-- 1	TransporteTarifa.numero
	, Carga_2_id                              	VARCHAR(36)  		-- 2	TransporteTarifa.Carga.id
	, Carga_2_numero                          	INTEGER      		-- 3	TransporteTarifa.Carga.numero
	, Carga_2_nombre                          	VARCHAR(50)  		-- 4	TransporteTarifa.Carga.nombre
	, Transporte_5_id                         	VARCHAR(36)  		-- 5	TransporteTarifa.Carga.Transporte.id
	, Transporte_5_numero                     	INTEGER      		-- 6	TransporteTarifa.Carga.Transporte.numero
	, Transporte_5_nombre                     	VARCHAR(50)  		-- 7	TransporteTarifa.Carga.Transporte.nombre
	, Transporte_5_cuit                       	BIGINT       		-- 8	TransporteTarifa.Carga.Transporte.cuit
	, Transporte_5_ingresosBrutos             	VARCHAR(13)  		-- 9	TransporteTarifa.Carga.Transporte.ingresosBrutos
	, Transporte_5_telefono                   	VARCHAR(50)  		-- 10	TransporteTarifa.Carga.Transporte.telefono
	, Transporte_5_fax                        	VARCHAR(50)  		-- 11	TransporteTarifa.Carga.Transporte.fax
	, Transporte_5_codigoPostal               	VARCHAR(36)  		-- 12	TransporteTarifa.Carga.Transporte.codigoPostal
	, Transporte_5_domicilio                  	VARCHAR(150) 		-- 13	TransporteTarifa.Carga.Transporte.domicilio
	, Transporte_5_comentario                 	VARCHAR(300) 		-- 14	TransporteTarifa.Carga.Transporte.comentario
	, Ciudad_15_id                            	VARCHAR(36)  		-- 15	TransporteTarifa.Ciudad.id
	, Ciudad_15_numero                        	INTEGER      		-- 16	TransporteTarifa.Ciudad.numero
	, Ciudad_15_nombre                        	VARCHAR(50)  		-- 17	TransporteTarifa.Ciudad.nombre
	, Ciudad_15_departamento                  	VARCHAR(50)  		-- 18	TransporteTarifa.Ciudad.departamento
	, Ciudad_15_numeroAFIP                    	INTEGER      		-- 19	TransporteTarifa.Ciudad.numeroAFIP
	, Provincia_20_id                         	VARCHAR(36)  		-- 20	TransporteTarifa.Ciudad.Provincia.id
	, Provincia_20_numero                     	INTEGER      		-- 21	TransporteTarifa.Ciudad.Provincia.numero
	, Provincia_20_nombre                     	VARCHAR(50)  		-- 22	TransporteTarifa.Ciudad.Provincia.nombre
	, Provincia_20_abreviatura                	VARCHAR(5)   		-- 23	TransporteTarifa.Ciudad.Provincia.abreviatura
	, Provincia_20_numeroAFIP                 	INTEGER      		-- 24	TransporteTarifa.Ciudad.Provincia.numeroAFIP
	, Provincia_20_numeroIngresosBrutos       	INTEGER      		-- 25	TransporteTarifa.Ciudad.Provincia.numeroIngresosBrutos
	, Provincia_20_numeroRENATEA              	INTEGER      		-- 26	TransporteTarifa.Ciudad.Provincia.numeroRENATEA
	, Provincia_20_pais                       	VARCHAR(36)  		-- 27	TransporteTarifa.Ciudad.Provincia.pais
	, TransporteTarifa_precioFlete            	DECIMAL(13,5)		-- 28	TransporteTarifa.precioFlete
	, TransporteTarifa_precioUnidadFacturacion	DECIMAL(13,5)		-- 29	TransporteTarifa.precioUnidadFacturacion
	, TransporteTarifa_precioUnidadStock      	DECIMAL(13,5)		-- 30	TransporteTarifa.precioUnidadStock
	, TransporteTarifa_precioBultos           	DECIMAL(13,5)		-- 31	TransporteTarifa.precioBultos
	, TransporteTarifa_importeMinimoEntrega   	DECIMAL(13,5)		-- 32	TransporteTarifa.importeMinimoEntrega
	, TransporteTarifa_importeMinimoCarga     	DECIMAL(13,5)		-- 33	TransporteTarifa.importeMinimoCarga

);

DROP TYPE IF EXISTS massoftware.t_TransporteTarifa_3 CASCADE;

CREATE TYPE massoftware.t_TransporteTarifa_3 AS (

	  TransporteTarifa_id                     	VARCHAR(36)  		-- 0	TransporteTarifa.id
	, TransporteTarifa_numero                 	INTEGER      		-- 1	TransporteTarifa.numero
	, Carga_2_id                              	VARCHAR(36)  		-- 2	TransporteTarifa.Carga.id
	, Carga_2_numero                          	INTEGER      		-- 3	TransporteTarifa.Carga.numero
	, Carga_2_nombre                          	VARCHAR(50)  		-- 4	TransporteTarifa.Carga.nombre
	, Transporte_5_id                         	VARCHAR(36)  		-- 5	TransporteTarifa.Carga.Transporte.id
	, Transporte_5_numero                     	INTEGER      		-- 6	TransporteTarifa.Carga.Transporte.numero
	, Transporte_5_nombre                     	VARCHAR(50)  		-- 7	TransporteTarifa.Carga.Transporte.nombre
	, Transporte_5_cuit                       	BIGINT       		-- 8	TransporteTarifa.Carga.Transporte.cuit
	, Transporte_5_ingresosBrutos             	VARCHAR(13)  		-- 9	TransporteTarifa.Carga.Transporte.ingresosBrutos
	, Transporte_5_telefono                   	VARCHAR(50)  		-- 10	TransporteTarifa.Carga.Transporte.telefono
	, Transporte_5_fax                        	VARCHAR(50)  		-- 11	TransporteTarifa.Carga.Transporte.fax
	, CodigoPostal_12_id                      	VARCHAR(36)  		-- 12	TransporteTarifa.Carga.Transporte.CodigoPostal.id
	, CodigoPostal_12_codigo                  	VARCHAR(12)  		-- 13	TransporteTarifa.Carga.Transporte.CodigoPostal.codigo
	, CodigoPostal_12_numero                  	INTEGER      		-- 14	TransporteTarifa.Carga.Transporte.CodigoPostal.numero
	, CodigoPostal_12_nombreCalle             	VARCHAR(200) 		-- 15	TransporteTarifa.Carga.Transporte.CodigoPostal.nombreCalle
	, CodigoPostal_12_numeroCalle             	VARCHAR(20)  		-- 16	TransporteTarifa.Carga.Transporte.CodigoPostal.numeroCalle
	, CodigoPostal_12_ciudad                  	VARCHAR(36)  		-- 17	TransporteTarifa.Carga.Transporte.CodigoPostal.ciudad
	, Transporte_5_domicilio                  	VARCHAR(150) 		-- 18	TransporteTarifa.Carga.Transporte.domicilio
	, Transporte_5_comentario                 	VARCHAR(300) 		-- 19	TransporteTarifa.Carga.Transporte.comentario
	, Ciudad_20_id                            	VARCHAR(36)  		-- 20	TransporteTarifa.Ciudad.id
	, Ciudad_20_numero                        	INTEGER      		-- 21	TransporteTarifa.Ciudad.numero
	, Ciudad_20_nombre                        	VARCHAR(50)  		-- 22	TransporteTarifa.Ciudad.nombre
	, Ciudad_20_departamento                  	VARCHAR(50)  		-- 23	TransporteTarifa.Ciudad.departamento
	, Ciudad_20_numeroAFIP                    	INTEGER      		-- 24	TransporteTarifa.Ciudad.numeroAFIP
	, Provincia_25_id                         	VARCHAR(36)  		-- 25	TransporteTarifa.Ciudad.Provincia.id
	, Provincia_25_numero                     	INTEGER      		-- 26	TransporteTarifa.Ciudad.Provincia.numero
	, Provincia_25_nombre                     	VARCHAR(50)  		-- 27	TransporteTarifa.Ciudad.Provincia.nombre
	, Provincia_25_abreviatura                	VARCHAR(5)   		-- 28	TransporteTarifa.Ciudad.Provincia.abreviatura
	, Provincia_25_numeroAFIP                 	INTEGER      		-- 29	TransporteTarifa.Ciudad.Provincia.numeroAFIP
	, Provincia_25_numeroIngresosBrutos       	INTEGER      		-- 30	TransporteTarifa.Ciudad.Provincia.numeroIngresosBrutos
	, Provincia_25_numeroRENATEA              	INTEGER      		-- 31	TransporteTarifa.Ciudad.Provincia.numeroRENATEA
	, Pais_32_id                              	VARCHAR(36)  		-- 32	TransporteTarifa.Ciudad.Provincia.Pais.id
	, Pais_32_numero                          	INTEGER      		-- 33	TransporteTarifa.Ciudad.Provincia.Pais.numero
	, Pais_32_nombre                          	VARCHAR(50)  		-- 34	TransporteTarifa.Ciudad.Provincia.Pais.nombre
	, Pais_32_abreviatura                     	VARCHAR(5)   		-- 35	TransporteTarifa.Ciudad.Provincia.Pais.abreviatura
	, TransporteTarifa_precioFlete            	DECIMAL(13,5)		-- 36	TransporteTarifa.precioFlete
	, TransporteTarifa_precioUnidadFacturacion	DECIMAL(13,5)		-- 37	TransporteTarifa.precioUnidadFacturacion
	, TransporteTarifa_precioUnidadStock      	DECIMAL(13,5)		-- 38	TransporteTarifa.precioUnidadStock
	, TransporteTarifa_precioBultos           	DECIMAL(13,5)		-- 39	TransporteTarifa.precioBultos
	, TransporteTarifa_importeMinimoEntrega   	DECIMAL(13,5)		-- 40	TransporteTarifa.importeMinimoEntrega
	, TransporteTarifa_importeMinimoCarga     	DECIMAL(13,5)		-- 41	TransporteTarifa.importeMinimoCarga

);

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) RETURNS SETOF massoftware.TransporteTarifa AS $$

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
				  TransporteTarifa.id                         AS TransporteTarifa_id                     	-- 0	.id                    		VARCHAR(36)
				, TransporteTarifa.numero                     AS TransporteTarifa_numero                 	-- 1	.numero                		INTEGER
				, TransporteTarifa.carga                      AS TransporteTarifa_carga                  	-- 2	.carga                 		VARCHAR(36)	Carga.id
				, TransporteTarifa.ciudad                     AS TransporteTarifa_ciudad                 	-- 3	.ciudad                		VARCHAR(36)	Ciudad.id
				, TransporteTarifa.precioFlete                AS TransporteTarifa_precioFlete            	-- 4	.precioFlete           		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadFacturacion    AS TransporteTarifa_precioUnidadFacturacion	-- 5	.precioUnidadFacturacion		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadStock          AS TransporteTarifa_precioUnidadStock      	-- 6	.precioUnidadStock     		DECIMAL(13,5)
				, TransporteTarifa.precioBultos               AS TransporteTarifa_precioBultos           	-- 7	.precioBultos          		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoEntrega       AS TransporteTarifa_importeMinimoEntrega   	-- 8	.importeMinimoEntrega  		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoCarga         AS TransporteTarifa_importeMinimoCarga     	-- 9	.importeMinimoCarga    		DECIMAL(13,5)

		FROM	massoftware.TransporteTarifa

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TransporteTarifa.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
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

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById (idArg VARCHAR(36)) RETURNS SETOF massoftware.TransporteTarifa AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TransporteTarifa ( idArg , null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_TransporteTarifa ( null , null, null, null, null); 

-- SELECT * FROM massoftware.f_TransporteTarifaById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) RETURNS SETOF massoftware.t_TransporteTarifa_1 AS $$

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
				  TransporteTarifa.id                          AS TransporteTarifa_id                     	-- 0	.id                    		VARCHAR(36)
				, TransporteTarifa.numero                      AS TransporteTarifa_numero                 	-- 1	.numero                		INTEGER
				, Carga_2.id                                   AS Carga_2_id                              	-- 2	.Carga.id              		VARCHAR(36)
				, Carga_2.numero                               AS Carga_2_numero                          	-- 3	.Carga.numero          		INTEGER
				, Carga_2.nombre                               AS Carga_2_nombre                          	-- 4	.Carga.nombre          		VARCHAR(50)
				, Carga_2.transporte                           AS Carga_2_transporte                      	-- 5	.Carga.transporte      		VARCHAR(36)	Transporte.id
				, Ciudad_6.id                                  AS Ciudad_6_id                             	-- 6	.Ciudad.id             		VARCHAR(36)
				, Ciudad_6.numero                              AS Ciudad_6_numero                         	-- 7	.Ciudad.numero         		INTEGER
				, Ciudad_6.nombre                              AS Ciudad_6_nombre                         	-- 8	.Ciudad.nombre         		VARCHAR(50)
				, Ciudad_6.departamento                        AS Ciudad_6_departamento                   	-- 9	.Ciudad.departamento   		VARCHAR(50)
				, Ciudad_6.numeroAFIP                          AS Ciudad_6_numeroAFIP                     	-- 10	.Ciudad.numeroAFIP     		INTEGER
				, Ciudad_6.provincia                           AS Ciudad_6_provincia                      	-- 11	.Ciudad.provincia      		VARCHAR(36)	Provincia.id
				, TransporteTarifa.precioFlete                 AS TransporteTarifa_precioFlete            	-- 12	.precioFlete           		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadFacturacion     AS TransporteTarifa_precioUnidadFacturacion	-- 13	.precioUnidadFacturacion		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadStock           AS TransporteTarifa_precioUnidadStock      	-- 14	.precioUnidadStock     		DECIMAL(13,5)
				, TransporteTarifa.precioBultos                AS TransporteTarifa_precioBultos           	-- 15	.precioBultos          		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoEntrega        AS TransporteTarifa_importeMinimoEntrega   	-- 16	.importeMinimoEntrega  		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoCarga          AS TransporteTarifa_importeMinimoCarga     	-- 17	.importeMinimoCarga    		DECIMAL(13,5)

		FROM	massoftware.TransporteTarifa
			LEFT JOIN massoftware.Carga AS Carga_2         ON TransporteTarifa.carga = Carga_2.id 	-- 2 LEFT LEVEL: 1
			LEFT JOIN massoftware.Ciudad AS Ciudad_6        ON TransporteTarifa.ciudad = Ciudad_6.id 	-- 6 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TransporteTarifa.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
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

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_TransporteTarifa_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TransporteTarifa_1 ( idArg , null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_TransporteTarifa_1 ( null , null, null, null, null); 

-- SELECT * FROM massoftware.f_TransporteTarifaById_1 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_2 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) RETURNS SETOF massoftware.t_TransporteTarifa_2 AS $$

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
				  TransporteTarifa.id                          AS TransporteTarifa_id                     	-- 0	.id                                  		VARCHAR(36)
				, TransporteTarifa.numero                      AS TransporteTarifa_numero                 	-- 1	.numero                              		INTEGER
				, Carga_2.id                                   AS Carga_2_id                              	-- 2	.Carga.id                            		VARCHAR(36)
				, Carga_2.numero                               AS Carga_2_numero                          	-- 3	.Carga.numero                        		INTEGER
				, Carga_2.nombre                               AS Carga_2_nombre                          	-- 4	.Carga.nombre                        		VARCHAR(50)
				, Transporte_5.id                              AS Transporte_5_id                         	-- 5	.Carga.Transporte.id                 		VARCHAR(36)
				, Transporte_5.numero                          AS Transporte_5_numero                     	-- 6	.Carga.Transporte.numero             		INTEGER
				, Transporte_5.nombre                          AS Transporte_5_nombre                     	-- 7	.Carga.Transporte.nombre             		VARCHAR(50)
				, Transporte_5.cuit                            AS Transporte_5_cuit                       	-- 8	.Carga.Transporte.cuit               		BIGINT
				, Transporte_5.ingresosBrutos                  AS Transporte_5_ingresosBrutos             	-- 9	.Carga.Transporte.ingresosBrutos     		VARCHAR(13)
				, Transporte_5.telefono                        AS Transporte_5_telefono                   	-- 10	.Carga.Transporte.telefono           		VARCHAR(50)
				, Transporte_5.fax                             AS Transporte_5_fax                        	-- 11	.Carga.Transporte.fax                		VARCHAR(50)
				, Transporte_5.codigoPostal                    AS Transporte_5_codigoPostal               	-- 12	.Carga.Transporte.codigoPostal       		VARCHAR(36)	CodigoPostal.id
				, Transporte_5.domicilio                       AS Transporte_5_domicilio                  	-- 13	.Carga.Transporte.domicilio          		VARCHAR(150)
				, Transporte_5.comentario                      AS Transporte_5_comentario                 	-- 14	.Carga.Transporte.comentario         		VARCHAR(300)
				, Ciudad_15.id                                 AS Ciudad_15_id                            	-- 15	.Ciudad.id                           		VARCHAR(36)
				, Ciudad_15.numero                             AS Ciudad_15_numero                        	-- 16	.Ciudad.numero                       		INTEGER
				, Ciudad_15.nombre                             AS Ciudad_15_nombre                        	-- 17	.Ciudad.nombre                       		VARCHAR(50)
				, Ciudad_15.departamento                       AS Ciudad_15_departamento                  	-- 18	.Ciudad.departamento                 		VARCHAR(50)
				, Ciudad_15.numeroAFIP                         AS Ciudad_15_numeroAFIP                    	-- 19	.Ciudad.numeroAFIP                   		INTEGER
				, Provincia_20.id                              AS Provincia_20_id                         	-- 20	.Ciudad.Provincia.id                 		VARCHAR(36)
				, Provincia_20.numero                          AS Provincia_20_numero                     	-- 21	.Ciudad.Provincia.numero             		INTEGER
				, Provincia_20.nombre                          AS Provincia_20_nombre                     	-- 22	.Ciudad.Provincia.nombre             		VARCHAR(50)
				, Provincia_20.abreviatura                     AS Provincia_20_abreviatura                	-- 23	.Ciudad.Provincia.abreviatura        		VARCHAR(5)
				, Provincia_20.numeroAFIP                      AS Provincia_20_numeroAFIP                 	-- 24	.Ciudad.Provincia.numeroAFIP         		INTEGER
				, Provincia_20.numeroIngresosBrutos            AS Provincia_20_numeroIngresosBrutos       	-- 25	.Ciudad.Provincia.numeroIngresosBrutos		INTEGER
				, Provincia_20.numeroRENATEA                   AS Provincia_20_numeroRENATEA              	-- 26	.Ciudad.Provincia.numeroRENATEA      		INTEGER
				, Provincia_20.pais                            AS Provincia_20_pais                       	-- 27	.Ciudad.Provincia.pais               		VARCHAR(36)	Pais.id
				, TransporteTarifa.precioFlete                 AS TransporteTarifa_precioFlete            	-- 28	.precioFlete                         		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadFacturacion     AS TransporteTarifa_precioUnidadFacturacion	-- 29	.precioUnidadFacturacion             		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadStock           AS TransporteTarifa_precioUnidadStock      	-- 30	.precioUnidadStock                   		DECIMAL(13,5)
				, TransporteTarifa.precioBultos                AS TransporteTarifa_precioBultos           	-- 31	.precioBultos                        		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoEntrega        AS TransporteTarifa_importeMinimoEntrega   	-- 32	.importeMinimoEntrega                		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoCarga          AS TransporteTarifa_importeMinimoCarga     	-- 33	.importeMinimoCarga                  		DECIMAL(13,5)

		FROM	massoftware.TransporteTarifa
			LEFT JOIN massoftware.Carga AS Carga_2                ON TransporteTarifa.carga = Carga_2.id 	-- 2 LEFT LEVEL: 1
				LEFT JOIN massoftware.Transporte AS Transporte_5           ON Carga_2.transporte = Transporte_5.id 	-- 5 LEFT LEVEL: 2
			LEFT JOIN massoftware.Ciudad AS Ciudad_15               ON TransporteTarifa.ciudad = Ciudad_15.id 	-- 15 LEFT LEVEL: 1
				LEFT JOIN massoftware.Provincia AS Provincia_20           ON Ciudad_15.provincia = Provincia_20.id 	-- 20 LEFT LEVEL: 2

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TransporteTarifa.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
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

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById_2 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById_2 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_TransporteTarifa_2 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TransporteTarifa_2 ( idArg , null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_TransporteTarifa_2 ( null , null, null, null, null); 

-- SELECT * FROM massoftware.f_TransporteTarifaById_2 ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_3 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) RETURNS SETOF massoftware.t_TransporteTarifa_3 AS $$

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
				  TransporteTarifa.id                          AS TransporteTarifa_id                     	-- 0	.id                                      		VARCHAR(36)
				, TransporteTarifa.numero                      AS TransporteTarifa_numero                 	-- 1	.numero                                  		INTEGER
				, Carga_2.id                                   AS Carga_2_id                              	-- 2	.Carga.id                                		VARCHAR(36)
				, Carga_2.numero                               AS Carga_2_numero                          	-- 3	.Carga.numero                            		INTEGER
				, Carga_2.nombre                               AS Carga_2_nombre                          	-- 4	.Carga.nombre                            		VARCHAR(50)
				, Transporte_5.id                              AS Transporte_5_id                         	-- 5	.Carga.Transporte.id                     		VARCHAR(36)
				, Transporte_5.numero                          AS Transporte_5_numero                     	-- 6	.Carga.Transporte.numero                 		INTEGER
				, Transporte_5.nombre                          AS Transporte_5_nombre                     	-- 7	.Carga.Transporte.nombre                 		VARCHAR(50)
				, Transporte_5.cuit                            AS Transporte_5_cuit                       	-- 8	.Carga.Transporte.cuit                   		BIGINT
				, Transporte_5.ingresosBrutos                  AS Transporte_5_ingresosBrutos             	-- 9	.Carga.Transporte.ingresosBrutos         		VARCHAR(13)
				, Transporte_5.telefono                        AS Transporte_5_telefono                   	-- 10	.Carga.Transporte.telefono               		VARCHAR(50)
				, Transporte_5.fax                             AS Transporte_5_fax                        	-- 11	.Carga.Transporte.fax                    		VARCHAR(50)
				, CodigoPostal_12.id                           AS CodigoPostal_12_id                      	-- 12	.Carga.Transporte.CodigoPostal.id        		VARCHAR(36)
				, CodigoPostal_12.codigo                       AS CodigoPostal_12_codigo                  	-- 13	.Carga.Transporte.CodigoPostal.codigo    		VARCHAR(12)
				, CodigoPostal_12.numero                       AS CodigoPostal_12_numero                  	-- 14	.Carga.Transporte.CodigoPostal.numero    		INTEGER
				, CodigoPostal_12.nombreCalle                  AS CodigoPostal_12_nombreCalle             	-- 15	.Carga.Transporte.CodigoPostal.nombreCalle		VARCHAR(200)
				, CodigoPostal_12.numeroCalle                  AS CodigoPostal_12_numeroCalle             	-- 16	.Carga.Transporte.CodigoPostal.numeroCalle		VARCHAR(20)
				, CodigoPostal_12.ciudad                       AS CodigoPostal_12_ciudad                  	-- 17	.Carga.Transporte.CodigoPostal.ciudad    		VARCHAR(36)	Ciudad.id
				, Transporte_5.domicilio                       AS Transporte_5_domicilio                  	-- 18	.Carga.Transporte.domicilio              		VARCHAR(150)
				, Transporte_5.comentario                      AS Transporte_5_comentario                 	-- 19	.Carga.Transporte.comentario             		VARCHAR(300)
				, Ciudad_20.id                                 AS Ciudad_20_id                            	-- 20	.Ciudad.id                               		VARCHAR(36)
				, Ciudad_20.numero                             AS Ciudad_20_numero                        	-- 21	.Ciudad.numero                           		INTEGER
				, Ciudad_20.nombre                             AS Ciudad_20_nombre                        	-- 22	.Ciudad.nombre                           		VARCHAR(50)
				, Ciudad_20.departamento                       AS Ciudad_20_departamento                  	-- 23	.Ciudad.departamento                     		VARCHAR(50)
				, Ciudad_20.numeroAFIP                         AS Ciudad_20_numeroAFIP                    	-- 24	.Ciudad.numeroAFIP                       		INTEGER
				, Provincia_25.id                              AS Provincia_25_id                         	-- 25	.Ciudad.Provincia.id                     		VARCHAR(36)
				, Provincia_25.numero                          AS Provincia_25_numero                     	-- 26	.Ciudad.Provincia.numero                 		INTEGER
				, Provincia_25.nombre                          AS Provincia_25_nombre                     	-- 27	.Ciudad.Provincia.nombre                 		VARCHAR(50)
				, Provincia_25.abreviatura                     AS Provincia_25_abreviatura                	-- 28	.Ciudad.Provincia.abreviatura            		VARCHAR(5)
				, Provincia_25.numeroAFIP                      AS Provincia_25_numeroAFIP                 	-- 29	.Ciudad.Provincia.numeroAFIP             		INTEGER
				, Provincia_25.numeroIngresosBrutos            AS Provincia_25_numeroIngresosBrutos       	-- 30	.Ciudad.Provincia.numeroIngresosBrutos   		INTEGER
				, Provincia_25.numeroRENATEA                   AS Provincia_25_numeroRENATEA              	-- 31	.Ciudad.Provincia.numeroRENATEA          		INTEGER
				, Pais_32.id                                   AS Pais_32_id                              	-- 32	.Ciudad.Provincia.Pais.id                		VARCHAR(36)
				, Pais_32.numero                               AS Pais_32_numero                          	-- 33	.Ciudad.Provincia.Pais.numero            		INTEGER
				, Pais_32.nombre                               AS Pais_32_nombre                          	-- 34	.Ciudad.Provincia.Pais.nombre            		VARCHAR(50)
				, Pais_32.abreviatura                          AS Pais_32_abreviatura                     	-- 35	.Ciudad.Provincia.Pais.abreviatura       		VARCHAR(5)
				, TransporteTarifa.precioFlete                 AS TransporteTarifa_precioFlete            	-- 36	.precioFlete                             		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadFacturacion     AS TransporteTarifa_precioUnidadFacturacion	-- 37	.precioUnidadFacturacion                 		DECIMAL(13,5)
				, TransporteTarifa.precioUnidadStock           AS TransporteTarifa_precioUnidadStock      	-- 38	.precioUnidadStock                       		DECIMAL(13,5)
				, TransporteTarifa.precioBultos                AS TransporteTarifa_precioBultos           	-- 39	.precioBultos                            		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoEntrega        AS TransporteTarifa_importeMinimoEntrega   	-- 40	.importeMinimoEntrega                    		DECIMAL(13,5)
				, TransporteTarifa.importeMinimoCarga          AS TransporteTarifa_importeMinimoCarga     	-- 41	.importeMinimoCarga                      		DECIMAL(13,5)

		FROM	massoftware.TransporteTarifa
			LEFT JOIN massoftware.Carga AS Carga_2                      ON TransporteTarifa.carga = Carga_2.id 	-- 2 LEFT LEVEL: 1
				LEFT JOIN massoftware.Transporte AS Transporte_5                ON Carga_2.transporte = Transporte_5.id 	-- 5 LEFT LEVEL: 2
					LEFT JOIN massoftware.CodigoPostal AS CodigoPostal_12             ON Transporte_5.codigoPostal = CodigoPostal_12.id 	-- 12 LEFT LEVEL: 3
			LEFT JOIN massoftware.Ciudad AS Ciudad_20                    ON TransporteTarifa.ciudad = Ciudad_20.id 	-- 20 LEFT LEVEL: 1
				LEFT JOIN massoftware.Provincia AS Provincia_25                 ON Ciudad_20.provincia = Provincia_25.id 	-- 25 LEFT LEVEL: 2
					LEFT JOIN massoftware.Pais AS Pais_32                     ON Provincia_25.pais = Pais_32.id 	-- 32 LEFT LEVEL: 3

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' TransporteTarifa.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
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

DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById_3 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById_3 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_TransporteTarifa_3 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_TransporteTarifa_3 ( idArg , null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_TransporteTarifa_3 ( null , null, null, null, null); 

-- SELECT * FROM massoftware.f_TransporteTarifaById_3 ('xxx'); 