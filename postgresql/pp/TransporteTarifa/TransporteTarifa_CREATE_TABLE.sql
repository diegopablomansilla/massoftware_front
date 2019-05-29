
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
	precioUnidadFacturacion DECIMAL(13, 5) CONSTRAINT TransporteTarifa_precioUnidadFacturacion_chk CHECK ( precioUnidadFacturacion >= -9999.9999 AND precioUnidadFacturacion <= 99999.9999  ), 
	
	-- Precio unidad stock
	precioUnidadStock DECIMAL(13, 5) CONSTRAINT TransporteTarifa_precioUnidadStock_chk CHECK ( precioUnidadStock >= -9999.9999 AND precioUnidadStock <= 99999.9999  ), 
	
	-- Precio bultos
	precioBultos DECIMAL(13, 5) CONSTRAINT TransporteTarifa_precioBultos_chk CHECK ( precioBultos >= -9999.9999 AND precioBultos <= 99999.9999  ), 
	
	-- Importe mínimo por entrega
	importeMinimoEntrega DECIMAL(13, 5) CONSTRAINT TransporteTarifa_importeMinimoEntrega_chk CHECK ( importeMinimoEntrega >= -9999.9999 AND importeMinimoEntrega <= 99999.9999  ), 
	
	-- Importe mínimo por carga
	importeMinimoCarga DECIMAL(13, 5) CONSTRAINT TransporteTarifa_importeMinimoCarga_chk CHECK ( importeMinimoCarga >= -9999.9999 AND importeMinimoCarga <= 99999.9999  )
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