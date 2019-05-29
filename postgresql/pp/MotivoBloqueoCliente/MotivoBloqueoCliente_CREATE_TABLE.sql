
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoBloqueoCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoBloqueoCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.MotivoBloqueoCliente CASCADE;

CREATE TABLE massoftware.MotivoBloqueoCliente
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº motivo
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT MotivoBloqueoCliente_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Clasificación de cliente
	clasificacionCliente VARCHAR(36)  NOT NULL  REFERENCES massoftware.ClasificacionCliente (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_MotivoBloqueoCliente_nombre ON massoftware.MotivoBloqueoCliente (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatMotivoBloqueoCliente() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatMotivoBloqueoCliente() RETURNS TRIGGER AS $formatMotivoBloqueoCliente$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.clasificacionCliente := massoftware.white_is_null(NEW.clasificacionCliente);

	RETURN NEW;
END;
$formatMotivoBloqueoCliente$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatMotivoBloqueoCliente ON massoftware.MotivoBloqueoCliente CASCADE;

CREATE TRIGGER tgFormatMotivoBloqueoCliente BEFORE INSERT OR UPDATE
	ON massoftware.MotivoBloqueoCliente FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatMotivoBloqueoCliente();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.MotivoBloqueoCliente;

-- SELECT * FROM massoftware.MotivoBloqueoCliente LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.MotivoBloqueoCliente;

-- SELECT * FROM massoftware.MotivoBloqueoCliente WHERE id = 'xxx';