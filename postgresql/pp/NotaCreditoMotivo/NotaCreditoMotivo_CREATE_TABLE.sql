
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: NotaCreditoMotivo                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.NotaCreditoMotivo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.NotaCreditoMotivo CASCADE;

CREATE TABLE massoftware.NotaCreditoMotivo
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº motivo
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT NotaCreditoMotivo_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_NotaCreditoMotivo_nombre ON massoftware.NotaCreditoMotivo (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatNotaCreditoMotivo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatNotaCreditoMotivo() RETURNS TRIGGER AS $formatNotaCreditoMotivo$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatNotaCreditoMotivo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatNotaCreditoMotivo ON massoftware.NotaCreditoMotivo CASCADE;

CREATE TRIGGER tgFormatNotaCreditoMotivo BEFORE INSERT OR UPDATE
	ON massoftware.NotaCreditoMotivo FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatNotaCreditoMotivo();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.NotaCreditoMotivo;

-- SELECT * FROM massoftware.NotaCreditoMotivo LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.NotaCreditoMotivo;

-- SELECT * FROM massoftware.NotaCreditoMotivo WHERE id = 'xxx';