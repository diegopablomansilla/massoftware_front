
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Carga                                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Carga

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Carga CASCADE;

CREATE TABLE massoftware.Carga
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº carga
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Carga_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Transporte
	transporte VARCHAR(36)  NOT NULL  REFERENCES massoftware.Transporte (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Carga_nombre ON massoftware.Carga (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCarga() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCarga() RETURNS TRIGGER AS $formatCarga$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.transporte := massoftware.white_is_null(NEW.transporte);

	RETURN NEW;
END;
$formatCarga$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCarga ON massoftware.Carga CASCADE;

CREATE TRIGGER tgFormatCarga BEFORE INSERT OR UPDATE
	ON massoftware.Carga FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatCarga();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Carga;

-- SELECT * FROM massoftware.Carga LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Carga;

-- SELECT * FROM massoftware.Carga WHERE id = 'xxx';