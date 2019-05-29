
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoComentario                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoComentario

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.MotivoComentario CASCADE;

CREATE TABLE massoftware.MotivoComentario
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº motivo
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT MotivoComentario_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_MotivoComentario_nombre ON massoftware.MotivoComentario (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatMotivoComentario() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatMotivoComentario() RETURNS TRIGGER AS $formatMotivoComentario$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatMotivoComentario$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatMotivoComentario ON massoftware.MotivoComentario CASCADE;

CREATE TRIGGER tgFormatMotivoComentario BEFORE INSERT OR UPDATE
	ON massoftware.MotivoComentario FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatMotivoComentario();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.MotivoComentario;

-- SELECT * FROM massoftware.MotivoComentario LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.MotivoComentario;

-- SELECT * FROM massoftware.MotivoComentario WHERE id = 'xxx';