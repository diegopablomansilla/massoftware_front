
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
	precioFlete DECIMAL(13, 5) NOT NULL  CONSTRAINT TransporteTarifa_precioFlete_chk CHECK ( precioFlete >= -9999.9999 AND precioFlete <= 99999.9999  ), 
	
	-- Precio unidad facturación
	precioUnidadFacturacion DECIMAL(13, 5) NOT NULL  CONSTRAINT TransporteTarifa_precioUnidadFacturacion_chk CHECK ( precioUnidadFacturacion >= -9999.9999 AND precioUnidadFacturacion <= 99999.9999  ), 
	
	-- Precio unidad stock
	precioUnidadStock DECIMAL(13, 5) NOT NULL  CONSTRAINT TransporteTarifa_precioUnidadStock_chk CHECK ( precioUnidadStock >= -9999.9999 AND precioUnidadStock <= 99999.9999  ), 
	
	-- Precio bultos
	precioBultos DECIMAL(13, 5) NOT NULL  CONSTRAINT TransporteTarifa_precioBultos_chk CHECK ( precioBultos >= -9999.9999 AND precioBultos <= 99999.9999  ), 
	
	-- Importe mínimo por entrega
	importeMinimoEntrega DECIMAL(13, 5) NOT NULL  CONSTRAINT TransporteTarifa_importeMinimoEntrega_chk CHECK ( importeMinimoEntrega >= -9999.9999 AND importeMinimoEntrega <= 99999.9999  ), 
	
	-- Importe mínimo por carga
	importeMinimoCarga DECIMAL(13, 5) NOT NULL  CONSTRAINT TransporteTarifa_importeMinimoCarga_chk CHECK ( importeMinimoCarga >= -9999.9999 AND importeMinimoCarga <= 99999.9999  )
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
		, precioFleteArg DECIMAL
		, precioUnidadFacturacionArg DECIMAL
		, precioUnidadStockArg DECIMAL
		, precioBultosArg DECIMAL
		, importeMinimoEntregaArg DECIMAL
		, importeMinimoCargaArg DECIMAL
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_TransporteTarifa(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, cargaArg VARCHAR(36)
		, ciudadArg VARCHAR(36)
		, precioFleteArg DECIMAL
		, precioUnidadFacturacionArg DECIMAL
		, precioUnidadStockArg DECIMAL
		, precioBultosArg DECIMAL
		, importeMinimoEntregaArg DECIMAL
		, importeMinimoCargaArg DECIMAL
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
		, null::DECIMAL
		, null::DECIMAL
		, null::DECIMAL
		, null::DECIMAL
		, null::DECIMAL
		, null::DECIMAL
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_TransporteTarifa(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, cargaArg VARCHAR(36)
		, ciudadArg VARCHAR(36)
		, precioFleteArg DECIMAL
		, precioUnidadFacturacionArg DECIMAL
		, precioUnidadStockArg DECIMAL
		, precioBultosArg DECIMAL
		, importeMinimoEntregaArg DECIMAL
		, importeMinimoCargaArg DECIMAL
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_TransporteTarifa(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, cargaArg VARCHAR(36)
		, ciudadArg VARCHAR(36)
		, precioFleteArg DECIMAL
		, precioUnidadFacturacionArg DECIMAL
		, precioUnidadStockArg DECIMAL
		, precioBultosArg DECIMAL
		, importeMinimoEntregaArg DECIMAL
		, importeMinimoCargaArg DECIMAL
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
		, null::DECIMAL
		, null::DECIMAL
		, null::DECIMAL
		, null::DECIMAL
		, null::DECIMAL
		, null::DECIMAL
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER
	FROM	massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_TransporteTarifa_numero();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_precioFlete() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_precioFlete() RETURNS DECIMAL AS $$

	SELECT (COALESCE(MAX(precioFlete),0) + 1)::DECIMAL
	FROM	massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_TransporteTarifa_precioFlete();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_precioUnidadFacturacion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_precioUnidadFacturacion() RETURNS DECIMAL AS $$

	SELECT (COALESCE(MAX(precioUnidadFacturacion),0) + 1)::DECIMAL
	FROM	massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_TransporteTarifa_precioUnidadFacturacion();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_precioUnidadStock() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_precioUnidadStock() RETURNS DECIMAL AS $$

	SELECT (COALESCE(MAX(precioUnidadStock),0) + 1)::DECIMAL
	FROM	massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_TransporteTarifa_precioUnidadStock();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_precioBultos() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_precioBultos() RETURNS DECIMAL AS $$

	SELECT (COALESCE(MAX(precioBultos),0) + 1)::DECIMAL
	FROM	massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_TransporteTarifa_precioBultos();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_importeMinimoEntrega() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_importeMinimoEntrega() RETURNS DECIMAL AS $$

	SELECT (COALESCE(MAX(importeMinimoEntrega),0) + 1)::DECIMAL
	FROM	massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_TransporteTarifa_importeMinimoEntrega();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_importeMinimoCarga() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_importeMinimoCarga() RETURNS DECIMAL AS $$

	SELECT (COALESCE(MAX(importeMinimoCarga),0) + 1)::DECIMAL
	FROM	massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_TransporteTarifa_importeMinimoCarga();

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById(idArg VARCHAR(36)) RETURNS
	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteTarifaById('xxx');

-- SELECT * FROM massoftware.f_TransporteTarifaById((SELECT TransporteTarifa.id FROM massoftware.TransporteTarifa LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById_1(idArg VARCHAR(36)) RETURNS
	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteTarifaById_1('xxx');

-- SELECT * FROM massoftware.f_TransporteTarifaById_1((SELECT TransporteTarifa.id FROM massoftware.TransporteTarifa LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById_2(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById_2(idArg VARCHAR(36)) RETURNS
	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteTarifaById_2('xxx');

-- SELECT * FROM massoftware.f_TransporteTarifaById_2((SELECT TransporteTarifa.id FROM massoftware.TransporteTarifa LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifaById_3(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifaById_3(idArg VARCHAR(36)) RETURNS
	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TransporteTarifaById_3('xxx');

-- SELECT * FROM massoftware.f_TransporteTarifaById_3((SELECT TransporteTarifa.id FROM massoftware.TransporteTarifa LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.carga ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.carga DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.carga ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.carga DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.ciudad ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.ciudad DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.ciudad ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.ciudad DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.precioFlete ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.precioFlete DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.precioFlete ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.precioFlete DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.precioUnidadFacturacion ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.precioUnidadFacturacion DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.precioUnidadFacturacion ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.precioUnidadFacturacion DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.precioUnidadStock ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.precioUnidadStock DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.precioUnidadStock ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.precioUnidadStock DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.precioBultos ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.precioBultos DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.precioBultos ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.precioBultos DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.importeMinimoEntrega ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.importeMinimoEntrega DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.importeMinimoEntrega ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.importeMinimoEntrega DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.importeMinimoCarga ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.importeMinimoCarga DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.importeMinimoCarga ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 2
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 3
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 4
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 5
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 6
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 7
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 2
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 3
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 4
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 5
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 6
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 7

	FROM	massoftware.TransporteTarifa

	ORDER BY TransporteTarifa.importeMinimoCarga DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.carga ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.carga DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.carga ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.carga DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.ciudad ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.ciudad DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.ciudad ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.ciudad DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioFlete ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioFlete DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioFlete ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioFlete DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioUnidadFacturacion ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioUnidadFacturacion DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioUnidadFacturacion ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioUnidadFacturacion DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioUnidadStock ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioUnidadStock DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioUnidadStock ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioUnidadStock DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioBultos ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioBultos DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioBultos ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.precioBultos DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.importeMinimoEntrega ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.importeMinimoEntrega DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.importeMinimoEntrega ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.importeMinimoEntrega DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.importeMinimoCarga ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_1(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_1(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.importeMinimoCarga DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_1(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.importeMinimoCarga ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_1(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_1(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Ciudad_id VARCHAR(36)                                 	-- 5
		,Ciudad_numero INTEGER                                 	-- 6
		,Ciudad_nombre VARCHAR(50)                             	-- 7
		,Ciudad_departamento VARCHAR(50)                       	-- 8
		,Ciudad_numeroAFIP INTEGER                             	-- 9
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 10
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 11
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 12
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 13
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 14
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 15
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Ciudad.id AS Ciudad_id                                                             	-- 5
		,Ciudad.numero AS Ciudad_numero                                                     	-- 6
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 7
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 8
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 9
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 10
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 11
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 12
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 13
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 14
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 15

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id  	-- 2
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 5

	ORDER BY TransporteTarifa.importeMinimoCarga DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_1(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.carga ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.carga DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.carga ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.carga DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.ciudad ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.ciudad DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.ciudad ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.ciudad DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.precioFlete ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.precioFlete DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.precioFlete ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.precioFlete DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.precioUnidadFacturacion ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.precioUnidadFacturacion DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.precioUnidadFacturacion ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.precioUnidadFacturacion DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.precioUnidadStock ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.precioUnidadStock DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.precioUnidadStock ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.precioUnidadStock DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.precioBultos ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.precioBultos DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.precioBultos ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.precioBultos DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.importeMinimoEntrega ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.importeMinimoEntrega DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.importeMinimoEntrega ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.importeMinimoEntrega DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.importeMinimoCarga ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_2(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_2(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.importeMinimoCarga DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_2(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.importeMinimoCarga ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_2(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_2(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,Transporte_domicilio VARCHAR(150)                     	-- 12
		,Transporte_comentario VARCHAR(300)                    	-- 13
		,Ciudad_id VARCHAR(36)                                 	-- 14
		,Ciudad_numero INTEGER                                 	-- 15
		,Ciudad_nombre VARCHAR(50)                             	-- 16
		,Ciudad_departamento VARCHAR(50)                       	-- 17
		,Ciudad_numeroAFIP INTEGER                             	-- 18
		,Provincia_id VARCHAR(36)                              	-- 19
		,Provincia_numero INTEGER                              	-- 20
		,Provincia_nombre VARCHAR(50)                          	-- 21
		,Provincia_abreviatura VARCHAR(5)                      	-- 22
		,Provincia_numeroAFIP INTEGER                          	-- 23
		,Provincia_numeroIngresosBrutos INTEGER                	-- 24
		,Provincia_numeroRENATEA INTEGER                       	-- 25
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 26
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 27
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 28
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 29
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 30
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 31
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 12
		,Transporte.comentario AS Transporte_comentario                                     	-- 13
		,Ciudad.id AS Ciudad_id                                                             	-- 14
		,Ciudad.numero AS Ciudad_numero                                                     	-- 15
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 16
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 17
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 18
		,Provincia.id AS Provincia_id                                                       	-- 19
		,Provincia.numero AS Provincia_numero                                               	-- 20
		,Provincia.nombre AS Provincia_nombre                                               	-- 21
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 22
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 23
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 24
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 25
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 26
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 27
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 28
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 29
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 30
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 31

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id   	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id	-- 5
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id	-- 14
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id 	-- 19

	ORDER BY TransporteTarifa.importeMinimoCarga DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_2(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.id;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.id

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.numero ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.numero DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.numero ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Numero_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.numero DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Numero_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.carga ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.carga DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.carga ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Carga_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.carga DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Carga_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.ciudad ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.ciudad DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.ciudad ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_Ciudad_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.ciudad DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_Ciudad_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.precioFlete ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.precioFlete DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.precioFlete ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioFlete_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.precioFlete DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioFlete_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.precioUnidadFacturacion ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.precioUnidadFacturacion DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.precioUnidadFacturacion ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadFacturacion_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.precioUnidadFacturacion DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadFacturacion_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.precioUnidadStock ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.precioUnidadStock DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.precioUnidadStock ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioUnidadStock_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.precioUnidadStock DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioUnidadStock_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.precioBultos ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.precioBultos DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.precioBultos ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_PrecioBultos_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.precioBultos DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_PrecioBultos_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.importeMinimoEntrega ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.importeMinimoEntrega DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.importeMinimoEntrega ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoEntrega_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.importeMinimoEntrega DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoEntrega_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.importeMinimoCarga ASC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_3(
		limitArg BIGINT
		, offsetArg BIGINT

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_3(
		limitArg BIGINT
		, offsetArg BIGINT

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.importeMinimoCarga DESC

	LIMIT limitArg OFFSET offsetArg;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_3(
		100
		, 0
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.importeMinimoCarga ASC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_asc_TransporteTarifa_ImporteMinimoCarga_3(
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_3(

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_3(

) RETURNS

	TABLE(
		 TransporteTarifa_id VARCHAR(36)                       	-- 0
		,TransporteTarifa_numero INTEGER                       	-- 1
		,Carga_id VARCHAR(36)                                  	-- 2
		,Carga_numero INTEGER                                  	-- 3
		,Carga_nombre VARCHAR(50)                              	-- 4
		,Transporte_id VARCHAR(36)                             	-- 5
		,Transporte_numero INTEGER                             	-- 6
		,Transporte_nombre VARCHAR(50)                         	-- 7
		,Transporte_cuit BIGINT                                	-- 8
		,Transporte_ingresosBrutos VARCHAR(13)                 	-- 9
		,Transporte_telefono VARCHAR(50)                       	-- 10
		,Transporte_fax VARCHAR(50)                            	-- 11
		,CodigoPostal_id VARCHAR(36)                           	-- 12
		,CodigoPostal_codigo VARCHAR(12)                       	-- 13
		,CodigoPostal_numero INTEGER                           	-- 14
		,CodigoPostal_nombreCalle VARCHAR(200)                 	-- 15
		,CodigoPostal_numeroCalle VARCHAR(20)                  	-- 16
		,Transporte_domicilio VARCHAR(150)                     	-- 17
		,Transporte_comentario VARCHAR(300)                    	-- 18
		,Ciudad_id VARCHAR(36)                                 	-- 19
		,Ciudad_numero INTEGER                                 	-- 20
		,Ciudad_nombre VARCHAR(50)                             	-- 21
		,Ciudad_departamento VARCHAR(50)                       	-- 22
		,Ciudad_numeroAFIP INTEGER                             	-- 23
		,Provincia_id VARCHAR(36)                              	-- 24
		,Provincia_numero INTEGER                              	-- 25
		,Provincia_nombre VARCHAR(50)                          	-- 26
		,Provincia_abreviatura VARCHAR(5)                      	-- 27
		,Provincia_numeroAFIP INTEGER                          	-- 28
		,Provincia_numeroIngresosBrutos INTEGER                	-- 29
		,Provincia_numeroRENATEA INTEGER                       	-- 30
		,Pais_id VARCHAR(36)                                   	-- 31
		,Pais_numero INTEGER                                   	-- 32
		,Pais_nombre VARCHAR(50)                               	-- 33
		,Pais_abreviatura VARCHAR(5)                           	-- 34
		,TransporteTarifa_precioFlete DECIMAL(13, 5)           	-- 35
		,TransporteTarifa_precioUnidadFacturacion DECIMAL(13, 5)	-- 36
		,TransporteTarifa_precioUnidadStock DECIMAL(13, 5)     	-- 37
		,TransporteTarifa_precioBultos DECIMAL(13, 5)          	-- 38
		,TransporteTarifa_importeMinimoEntrega DECIMAL(13, 5)  	-- 39
		,TransporteTarifa_importeMinimoCarga DECIMAL(13, 5)    	-- 40
	) AS $$

	SELECT
		 TransporteTarifa.id AS TransporteTarifa_id                                         	-- 0
		,TransporteTarifa.numero AS TransporteTarifa_numero                                 	-- 1
		,Carga.id AS Carga_id                                                               	-- 2
		,Carga.numero AS Carga_numero                                                       	-- 3
		,Carga.nombre AS Carga_nombre                                                       	-- 4
		,Transporte.id AS Transporte_id                                                     	-- 5
		,Transporte.numero AS Transporte_numero                                             	-- 6
		,Transporte.nombre AS Transporte_nombre                                             	-- 7
		,Transporte.cuit AS Transporte_cuit                                                 	-- 8
		,Transporte.ingresosBrutos AS Transporte_ingresosBrutos                             	-- 9
		,Transporte.telefono AS Transporte_telefono                                         	-- 10
		,Transporte.fax AS Transporte_fax                                                   	-- 11
		,CodigoPostal.id AS CodigoPostal_id                                                 	-- 12
		,CodigoPostal.codigo AS CodigoPostal_codigo                                         	-- 13
		,CodigoPostal.numero AS CodigoPostal_numero                                         	-- 14
		,CodigoPostal.nombreCalle AS CodigoPostal_nombreCalle                               	-- 15
		,CodigoPostal.numeroCalle AS CodigoPostal_numeroCalle                               	-- 16
		,Transporte.domicilio AS Transporte_domicilio                                       	-- 17
		,Transporte.comentario AS Transporte_comentario                                     	-- 18
		,Ciudad.id AS Ciudad_id                                                             	-- 19
		,Ciudad.numero AS Ciudad_numero                                                     	-- 20
		,Ciudad.nombre AS Ciudad_nombre                                                     	-- 21
		,Ciudad.departamento AS Ciudad_departamento                                         	-- 22
		,Ciudad.numeroAFIP AS Ciudad_numeroAFIP                                             	-- 23
		,Provincia.id AS Provincia_id                                                       	-- 24
		,Provincia.numero AS Provincia_numero                                               	-- 25
		,Provincia.nombre AS Provincia_nombre                                               	-- 26
		,Provincia.abreviatura AS Provincia_abreviatura                                     	-- 27
		,Provincia.numeroAFIP AS Provincia_numeroAFIP                                       	-- 28
		,Provincia.numeroIngresosBrutos AS Provincia_numeroIngresosBrutos                   	-- 29
		,Provincia.numeroRENATEA AS Provincia_numeroRENATEA                                 	-- 30
		,Pais.id AS Pais_id                                                                 	-- 31
		,Pais.numero AS Pais_numero                                                         	-- 32
		,Pais.nombre AS Pais_nombre                                                         	-- 33
		,Pais.abreviatura AS Pais_abreviatura                                               	-- 34
		,TransporteTarifa.precioFlete AS TransporteTarifa_precioFlete                       	-- 35
		,TransporteTarifa.precioUnidadFacturacion AS TransporteTarifa_precioUnidadFacturacion	-- 36
		,TransporteTarifa.precioUnidadStock AS TransporteTarifa_precioUnidadStock           	-- 37
		,TransporteTarifa.precioBultos AS TransporteTarifa_precioBultos                     	-- 38
		,TransporteTarifa.importeMinimoEntrega AS TransporteTarifa_importeMinimoEntrega     	-- 39
		,TransporteTarifa.importeMinimoCarga AS TransporteTarifa_importeMinimoCarga         	-- 40

	FROM	massoftware.TransporteTarifa
		LEFT JOIN massoftware.Carga ON TransporteTarifa.carga = Carga.id              	-- 2
		LEFT JOIN massoftware.Transporte ON Carga.transporte = Transporte.id          	-- 5
		LEFT JOIN massoftware.CodigoPostal ON Transporte.codigoPostal = CodigoPostal.id	-- 12
		LEFT JOIN massoftware.Ciudad ON TransporteTarifa.ciudad = Ciudad.id           	-- 19
		LEFT JOIN massoftware.Provincia ON Ciudad.provincia = Provincia.id            	-- 24
		LEFT JOIN massoftware.Pais ON Provincia.pais = Pais.id                        	-- 31

	ORDER BY TransporteTarifa.importeMinimoCarga DESC;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_TransporteTarifa_des_TransporteTarifa_ImporteMinimoCarga_3(
);

*/