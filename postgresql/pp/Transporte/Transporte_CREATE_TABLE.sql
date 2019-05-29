
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Transporte                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Transporte

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Transporte CASCADE;

CREATE TABLE massoftware.Transporte
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº transporte
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Transporte_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- CUIT
	cuit BIGINT NOT NULL  UNIQUE  CONSTRAINT Transporte_cuit_chk CHECK ( cuit >= 1 AND cuit <= 99999999999 AND char_length(cuit::VARCHAR) >= 11 AND char_length(cuit::VARCHAR) <= 11  ), 
	
	-- Ingresos brutos
	ingresosBrutos VARCHAR(13), 
	
	-- Teléfono
	telefono VARCHAR(50), 
	
	-- Fax
	fax VARCHAR(50), 
	
	-- Código postal
	codigoPostal VARCHAR(36)  NOT NULL  REFERENCES massoftware.CodigoPostal (id), 
	
	-- Domicilio
	domicilio VARCHAR(150), 
	
	-- Comentario
	comentario VARCHAR(300)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Transporte_nombre ON massoftware.Transporte (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatTransporte() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatTransporte() RETURNS TRIGGER AS $formatTransporte$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.ingresosBrutos := massoftware.white_is_null(NEW.ingresosBrutos);
	 NEW.telefono := massoftware.white_is_null(NEW.telefono);
	 NEW.fax := massoftware.white_is_null(NEW.fax);
	 NEW.codigoPostal := massoftware.white_is_null(NEW.codigoPostal);
	 NEW.domicilio := massoftware.white_is_null(NEW.domicilio);
	 NEW.comentario := massoftware.white_is_null(NEW.comentario);

	RETURN NEW;
END;
$formatTransporte$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTransporte ON massoftware.Transporte CASCADE;

CREATE TRIGGER tgFormatTransporte BEFORE INSERT OR UPDATE
	ON massoftware.Transporte FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatTransporte();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Transporte;

-- SELECT * FROM massoftware.Transporte LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Transporte;

-- SELECT * FROM massoftware.Transporte WHERE id = 'xxx';