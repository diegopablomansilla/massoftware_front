
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ClasificacionCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ClasificacionCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.ClasificacionCliente CASCADE;

CREATE TABLE massoftware.ClasificacionCliente
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº clasificación
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT ClasificacionCliente_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Color
	color INTEGER NOT NULL  CONSTRAINT ClasificacionCliente_color_chk CHECK ( color >= 1  )
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_ClasificacionCliente_nombre ON massoftware.ClasificacionCliente (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatClasificacionCliente() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatClasificacionCliente() RETURNS TRIGGER AS $formatClasificacionCliente$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatClasificacionCliente$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatClasificacionCliente ON massoftware.ClasificacionCliente CASCADE;

CREATE TRIGGER tgFormatClasificacionCliente BEFORE INSERT OR UPDATE
	ON massoftware.ClasificacionCliente FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatClasificacionCliente();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.ClasificacionCliente;

-- SELECT * FROM massoftware.ClasificacionCliente LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.ClasificacionCliente;

-- SELECT * FROM massoftware.ClasificacionCliente WHERE id = 'xxx';