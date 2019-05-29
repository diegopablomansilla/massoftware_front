
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoDocumentoAFIP                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoDocumentoAFIP

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.TipoDocumentoAFIP CASCADE;

CREATE TABLE massoftware.TipoDocumentoAFIP
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº tipo
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT TipoDocumentoAFIP_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_TipoDocumentoAFIP_nombre ON massoftware.TipoDocumentoAFIP (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatTipoDocumentoAFIP() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatTipoDocumentoAFIP() RETURNS TRIGGER AS $formatTipoDocumentoAFIP$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatTipoDocumentoAFIP$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTipoDocumentoAFIP ON massoftware.TipoDocumentoAFIP CASCADE;

CREATE TRIGGER tgFormatTipoDocumentoAFIP BEFORE INSERT OR UPDATE
	ON massoftware.TipoDocumentoAFIP FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatTipoDocumentoAFIP();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.TipoDocumentoAFIP;

-- SELECT * FROM massoftware.TipoDocumentoAFIP LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.TipoDocumentoAFIP;

-- SELECT * FROM massoftware.TipoDocumentoAFIP WHERE id = 'xxx';