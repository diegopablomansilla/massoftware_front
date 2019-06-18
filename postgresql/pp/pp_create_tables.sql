


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Usuario                                                                                                //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Usuario

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Usuario CASCADE;

CREATE TABLE massoftware.Usuario
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº usuario
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Usuario_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Usuario_nombre ON massoftware.Usuario (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatUsuario() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatUsuario() RETURNS TRIGGER AS $formatUsuario$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatUsuario$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatUsuario ON massoftware.Usuario CASCADE;

CREATE TRIGGER tgFormatUsuario BEFORE INSERT OR UPDATE
	ON massoftware.Usuario FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatUsuario();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Usuario;

-- SELECT * FROM massoftware.Usuario LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Usuario;

-- SELECT * FROM massoftware.Usuario WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: SeguridadModulo                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.SeguridadModulo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.SeguridadModulo CASCADE;

CREATE TABLE massoftware.SeguridadModulo
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº módulo
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT SeguridadModulo_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_SeguridadModulo_nombre ON massoftware.SeguridadModulo (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatSeguridadModulo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatSeguridadModulo() RETURNS TRIGGER AS $formatSeguridadModulo$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatSeguridadModulo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatSeguridadModulo ON massoftware.SeguridadModulo CASCADE;

CREATE TRIGGER tgFormatSeguridadModulo BEFORE INSERT OR UPDATE
	ON massoftware.SeguridadModulo FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatSeguridadModulo();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.SeguridadModulo;

-- SELECT * FROM massoftware.SeguridadModulo LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.SeguridadModulo;

-- SELECT * FROM massoftware.SeguridadModulo WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: SeguridadPuerta                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.SeguridadPuerta

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.SeguridadPuerta CASCADE;

CREATE TABLE massoftware.SeguridadPuerta
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº puerta
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT SeguridadPuerta_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- I.D
	equate VARCHAR(30) NOT NULL, 
	
	-- Módulo
	seguridadModulo VARCHAR(36)  NOT NULL  REFERENCES massoftware.SeguridadModulo (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_SeguridadPuerta_nombre ON massoftware.SeguridadPuerta (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatSeguridadPuerta() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatSeguridadPuerta() RETURNS TRIGGER AS $formatSeguridadPuerta$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.equate := massoftware.white_is_null(NEW.equate);
	 NEW.seguridadModulo := massoftware.white_is_null(NEW.seguridadModulo);

	RETURN NEW;
END;
$formatSeguridadPuerta$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatSeguridadPuerta ON massoftware.SeguridadPuerta CASCADE;

CREATE TRIGGER tgFormatSeguridadPuerta BEFORE INSERT OR UPDATE
	ON massoftware.SeguridadPuerta FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatSeguridadPuerta();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.SeguridadPuerta;

-- SELECT * FROM massoftware.SeguridadPuerta LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.SeguridadPuerta;

-- SELECT * FROM massoftware.SeguridadPuerta WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Zona                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Zona

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Zona CASCADE;

CREATE TABLE massoftware.Zona
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Código
	codigo VARCHAR(3) NOT NULL, 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Bonificación
	bonificacion DECIMAL(13,5) CONSTRAINT Zona_bonificacion_chk CHECK ( bonificacion >= 0 AND bonificacion <= 99999.9999  ), 
	
	-- Recargo
	recargo DECIMAL(13,5) CONSTRAINT Zona_recargo_chk CHECK ( recargo >= 0 AND recargo <= 99999.9999  )
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Zona_codigo ON massoftware.Zona (TRANSLATE(LOWER(TRIM(codigo))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_Zona_nombre ON massoftware.Zona (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatZona() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatZona() RETURNS TRIGGER AS $formatZona$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.codigo := massoftware.white_is_null(NEW.codigo);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatZona$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatZona ON massoftware.Zona CASCADE;

CREATE TRIGGER tgFormatZona BEFORE INSERT OR UPDATE
	ON massoftware.Zona FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatZona();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Zona;

-- SELECT * FROM massoftware.Zona LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Zona;

-- SELECT * FROM massoftware.Zona WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Pais                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Pais

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Pais CASCADE;

CREATE TABLE massoftware.Pais
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº país
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Pais_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Abreviatura
	abreviatura VARCHAR(5) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Pais_nombre ON massoftware.Pais (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_Pais_abreviatura ON massoftware.Pais (TRANSLATE(LOWER(TRIM(abreviatura))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatPais() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatPais() RETURNS TRIGGER AS $formatPais$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.abreviatura := massoftware.white_is_null(NEW.abreviatura);

	RETURN NEW;
END;
$formatPais$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatPais ON massoftware.Pais CASCADE;

CREATE TRIGGER tgFormatPais BEFORE INSERT OR UPDATE
	ON massoftware.Pais FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatPais();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Pais;

-- SELECT * FROM massoftware.Pais LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Pais;

-- SELECT * FROM massoftware.Pais WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Provincia                                                                                              //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Provincia

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Provincia CASCADE;

CREATE TABLE massoftware.Provincia
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº provincia
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Provincia_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Abreviatura
	abreviatura VARCHAR(5) NOT NULL, 
	
	-- Nº provincia AFIP
	numeroAFIP INTEGER CONSTRAINT Provincia_numeroAFIP_chk CHECK ( numeroAFIP >= 1  ), 
	
	-- Nº provincia ingresos brutos
	numeroIngresosBrutos INTEGER CONSTRAINT Provincia_numeroIngresosBrutos_chk CHECK ( numeroIngresosBrutos >= 1  ), 
	
	-- Nº provincia RENATEA
	numeroRENATEA INTEGER CONSTRAINT Provincia_numeroRENATEA_chk CHECK ( numeroRENATEA >= 1  ), 
	
	-- País
	pais VARCHAR(36)  NOT NULL  REFERENCES massoftware.Pais (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Provincia_nombre ON massoftware.Provincia (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_Provincia_abreviatura ON massoftware.Provincia (TRANSLATE(LOWER(TRIM(abreviatura))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatProvincia() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatProvincia() RETURNS TRIGGER AS $formatProvincia$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.abreviatura := massoftware.white_is_null(NEW.abreviatura);
	 NEW.pais := massoftware.white_is_null(NEW.pais);

	RETURN NEW;
END;
$formatProvincia$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatProvincia ON massoftware.Provincia CASCADE;

CREATE TRIGGER tgFormatProvincia BEFORE INSERT OR UPDATE
	ON massoftware.Provincia FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatProvincia();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Provincia;

-- SELECT * FROM massoftware.Provincia LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Provincia;

-- SELECT * FROM massoftware.Provincia WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Ciudad                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Ciudad

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Ciudad CASCADE;

CREATE TABLE massoftware.Ciudad
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº ciudad
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Ciudad_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Departamento
	departamento VARCHAR(50), 
	
	-- Nº provincia AFIP
	numeroAFIP INTEGER CONSTRAINT Ciudad_numeroAFIP_chk CHECK ( numeroAFIP >= 1  ), 
	
	-- Provincia
	provincia VARCHAR(36)  NOT NULL  REFERENCES massoftware.Provincia (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Ciudad_nombre ON massoftware.Ciudad (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCiudad() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCiudad() RETURNS TRIGGER AS $formatCiudad$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.departamento := massoftware.white_is_null(NEW.departamento);
	 NEW.provincia := massoftware.white_is_null(NEW.provincia);

	RETURN NEW;
END;
$formatCiudad$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCiudad ON massoftware.Ciudad CASCADE;

CREATE TRIGGER tgFormatCiudad BEFORE INSERT OR UPDATE
	ON massoftware.Ciudad FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatCiudad();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Ciudad;

-- SELECT * FROM massoftware.Ciudad LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Ciudad;

-- SELECT * FROM massoftware.Ciudad WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CodigoPostal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CodigoPostal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.CodigoPostal CASCADE;

CREATE TABLE massoftware.CodigoPostal
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Código
	codigo VARCHAR(12) NOT NULL, 
	
	-- Secuencia
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT CodigoPostal_numero_chk CHECK ( numero >= 1  ), 
	
	-- Calle
	nombreCalle VARCHAR(200) NOT NULL, 
	
	-- Número calle
	numeroCalle VARCHAR(20) NOT NULL, 
	
	-- Ciudad
	ciudad VARCHAR(36)  NOT NULL  REFERENCES massoftware.Ciudad (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_CodigoPostal_codigo ON massoftware.CodigoPostal (TRANSLATE(LOWER(TRIM(codigo))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCodigoPostal() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCodigoPostal() RETURNS TRIGGER AS $formatCodigoPostal$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.codigo := massoftware.white_is_null(NEW.codigo);
	 NEW.nombreCalle := massoftware.white_is_null(NEW.nombreCalle);
	 NEW.numeroCalle := massoftware.white_is_null(NEW.numeroCalle);
	 NEW.ciudad := massoftware.white_is_null(NEW.ciudad);

	RETURN NEW;
END;
$formatCodigoPostal$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCodigoPostal ON massoftware.CodigoPostal CASCADE;

CREATE TRIGGER tgFormatCodigoPostal BEFORE INSERT OR UPDATE
	ON massoftware.CodigoPostal FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatCodigoPostal();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.CodigoPostal;

-- SELECT * FROM massoftware.CodigoPostal LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.CodigoPostal;

-- SELECT * FROM massoftware.CodigoPostal WHERE id = 'xxx';


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


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MonedaAFIP                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MonedaAFIP

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.MonedaAFIP CASCADE;

CREATE TABLE massoftware.MonedaAFIP
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Código
	codigo VARCHAR(3) NOT NULL, 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_MonedaAFIP_codigo ON massoftware.MonedaAFIP (TRANSLATE(LOWER(TRIM(codigo))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_MonedaAFIP_nombre ON massoftware.MonedaAFIP (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatMonedaAFIP() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatMonedaAFIP() RETURNS TRIGGER AS $formatMonedaAFIP$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.codigo := massoftware.white_is_null(NEW.codigo);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatMonedaAFIP$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatMonedaAFIP ON massoftware.MonedaAFIP CASCADE;

CREATE TRIGGER tgFormatMonedaAFIP BEFORE INSERT OR UPDATE
	ON massoftware.MonedaAFIP FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatMonedaAFIP();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.MonedaAFIP;

-- SELECT * FROM massoftware.MonedaAFIP LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.MonedaAFIP;

-- SELECT * FROM massoftware.MonedaAFIP WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Moneda                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Moneda

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Moneda CASCADE;

CREATE TABLE massoftware.Moneda
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº moneda
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Moneda_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Abreviatura
	abreviatura VARCHAR(5) NOT NULL, 
	
	-- Cotización
	cotizacion DECIMAL(13,5) NOT NULL  CONSTRAINT Moneda_cotizacion_chk CHECK ( cotizacion >= -9999.9999 AND cotizacion <= 99999.9999  ), 
	
	-- Fecha cotización
	cotizacionFecha TIMESTAMP NOT NULL, 
	
	-- Control de actualizacion
	controlActualizacion BOOLEAN NOT NULL, 
	
	-- Moneda AFIP
	monedaAFIP VARCHAR(36)  NOT NULL  REFERENCES massoftware.MonedaAFIP (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Moneda_nombre ON massoftware.Moneda (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_Moneda_abreviatura ON massoftware.Moneda (TRANSLATE(LOWER(TRIM(abreviatura))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatMoneda() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatMoneda() RETURNS TRIGGER AS $formatMoneda$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.abreviatura := massoftware.white_is_null(NEW.abreviatura);
	 NEW.monedaAFIP := massoftware.white_is_null(NEW.monedaAFIP);

	RETURN NEW;
END;
$formatMoneda$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatMoneda ON massoftware.Moneda CASCADE;

CREATE TRIGGER tgFormatMoneda BEFORE INSERT OR UPDATE
	ON massoftware.Moneda FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatMoneda();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Moneda;

-- SELECT * FROM massoftware.Moneda LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Moneda;

-- SELECT * FROM massoftware.Moneda WHERE id = 'xxx';


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


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoCliente                                                                                            //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.TipoCliente CASCADE;

CREATE TABLE massoftware.TipoCliente
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº tipo de cliente
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT TipoCliente_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_TipoCliente_nombre ON massoftware.TipoCliente (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatTipoCliente() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatTipoCliente() RETURNS TRIGGER AS $formatTipoCliente$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatTipoCliente$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTipoCliente ON massoftware.TipoCliente CASCADE;

CREATE TRIGGER tgFormatTipoCliente BEFORE INSERT OR UPDATE
	ON massoftware.TipoCliente FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatTipoCliente();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.TipoCliente;

-- SELECT * FROM massoftware.TipoCliente LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.TipoCliente;

-- SELECT * FROM massoftware.TipoCliente WHERE id = 'xxx';


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


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoSucursal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoSucursal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.TipoSucursal CASCADE;

CREATE TABLE massoftware.TipoSucursal
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº tipo de sucursal
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT TipoSucursal_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_TipoSucursal_nombre ON massoftware.TipoSucursal (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatTipoSucursal() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatTipoSucursal() RETURNS TRIGGER AS $formatTipoSucursal$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatTipoSucursal$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTipoSucursal ON massoftware.TipoSucursal CASCADE;

CREATE TRIGGER tgFormatTipoSucursal BEFORE INSERT OR UPDATE
	ON massoftware.TipoSucursal FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatTipoSucursal();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.TipoSucursal;

-- SELECT * FROM massoftware.TipoSucursal LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.TipoSucursal;

-- SELECT * FROM massoftware.TipoSucursal WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Sucursal                                                                                               //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Sucursal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Sucursal CASCADE;

CREATE TABLE massoftware.Sucursal
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº sucursal
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Sucursal_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Abreviatura
	abreviatura VARCHAR(5) NOT NULL, 
	
	-- Tipo sucursal
	tipoSucursal VARCHAR(36)  NOT NULL  REFERENCES massoftware.TipoSucursal (id), 
	
	-- Cuenta clientes desde
	cuentaClientesDesde VARCHAR(7), 
	
	-- Cuenta clientes hasta
	cuentaClientesHasta VARCHAR(7), 
	
	-- Cantidad caracteres clientes
	cantidadCaracteresClientes INTEGER NOT NULL  CONSTRAINT Sucursal_cantidadCaracteresClientes_chk CHECK ( cantidadCaracteresClientes >= 3 AND cantidadCaracteresClientes <= 6  ), 
	
	-- Identificacion numérica clientes
	identificacionNumericaClientes BOOLEAN NOT NULL, 
	
	-- Permite cambiar clientes
	permiteCambiarClientes BOOLEAN NOT NULL, 
	
	-- Cuenta proveedores desde
	cuentaProveedoresDesde VARCHAR(6), 
	
	-- Cuenta proveedores hasta
	cuentaProveedoresHasta VARCHAR(6), 
	
	-- Cantidad caracteres proveedores
	cantidadCaracteresProveedores INTEGER NOT NULL  CONSTRAINT Sucursal_cantidadCaracteresProveedores_chk CHECK ( cantidadCaracteresProveedores >= 3 AND cantidadCaracteresProveedores <= 6  ), 
	
	-- Identificacion numérica proveedores
	identificacionNumericaProveedores BOOLEAN NOT NULL, 
	
	-- Permite cambiar proveedores
	permiteCambiarProveedores BOOLEAN NOT NULL, 
	
	-- Clientes ocacionales desde
	clientesOcacionalesDesde INTEGER NOT NULL  CONSTRAINT Sucursal_clientesOcacionalesDesde_chk CHECK ( clientesOcacionalesDesde >= 1  ), 
	
	-- Clientes ocacionales hasta
	clientesOcacionalesHasta INTEGER NOT NULL  CONSTRAINT Sucursal_clientesOcacionalesHasta_chk CHECK ( clientesOcacionalesHasta >= 1  ), 
	
	-- Número cobranza desde
	numeroCobranzaDesde INTEGER NOT NULL  CONSTRAINT Sucursal_numeroCobranzaDesde_chk CHECK ( numeroCobranzaDesde >= 1  ), 
	
	-- Número cobranza hasta
	numeroCobranzaHasta INTEGER NOT NULL  CONSTRAINT Sucursal_numeroCobranzaHasta_chk CHECK ( numeroCobranzaHasta >= 1  )
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Sucursal_nombre ON massoftware.Sucursal (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_Sucursal_abreviatura ON massoftware.Sucursal (TRANSLATE(LOWER(TRIM(abreviatura))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatSucursal() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatSucursal() RETURNS TRIGGER AS $formatSucursal$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.abreviatura := massoftware.white_is_null(NEW.abreviatura);
	 NEW.tipoSucursal := massoftware.white_is_null(NEW.tipoSucursal);
	 NEW.cuentaClientesDesde := massoftware.white_is_null(NEW.cuentaClientesDesde);
	 NEW.cuentaClientesHasta := massoftware.white_is_null(NEW.cuentaClientesHasta);
	 NEW.cuentaProveedoresDesde := massoftware.white_is_null(NEW.cuentaProveedoresDesde);
	 NEW.cuentaProveedoresHasta := massoftware.white_is_null(NEW.cuentaProveedoresHasta);

	RETURN NEW;
END;
$formatSucursal$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatSucursal ON massoftware.Sucursal CASCADE;

CREATE TRIGGER tgFormatSucursal BEFORE INSERT OR UPDATE
	ON massoftware.Sucursal FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatSucursal();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Sucursal;

-- SELECT * FROM massoftware.Sucursal LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Sucursal;

-- SELECT * FROM massoftware.Sucursal WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: DepositoModulo                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.DepositoModulo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.DepositoModulo CASCADE;

CREATE TABLE massoftware.DepositoModulo
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº módulo
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT DepositoModulo_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_DepositoModulo_nombre ON massoftware.DepositoModulo (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatDepositoModulo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatDepositoModulo() RETURNS TRIGGER AS $formatDepositoModulo$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatDepositoModulo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatDepositoModulo ON massoftware.DepositoModulo CASCADE;

CREATE TRIGGER tgFormatDepositoModulo BEFORE INSERT OR UPDATE
	ON massoftware.DepositoModulo FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatDepositoModulo();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.DepositoModulo;

-- SELECT * FROM massoftware.DepositoModulo LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.DepositoModulo;

-- SELECT * FROM massoftware.DepositoModulo WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Deposito                                                                                               //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Deposito

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Deposito CASCADE;

CREATE TABLE massoftware.Deposito
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº depósito
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT Deposito_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Abreviatura
	abreviatura VARCHAR(5) NOT NULL, 
	
	-- Sucursal
	sucursal VARCHAR(36)  REFERENCES massoftware.Sucursal (id), 
	
	-- Módulo
	depositoModulo VARCHAR(36)  NOT NULL  REFERENCES massoftware.DepositoModulo (id), 
	
	-- Puerta operativo
	puertaOperativo VARCHAR(36)  NOT NULL  REFERENCES massoftware.SeguridadPuerta (id), 
	
	-- Puerta consulta
	puertaConsulta VARCHAR(36)  NOT NULL  REFERENCES massoftware.SeguridadPuerta (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_Deposito_nombre ON massoftware.Deposito (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_Deposito_abreviatura ON massoftware.Deposito (TRANSLATE(LOWER(TRIM(abreviatura))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatDeposito() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatDeposito() RETURNS TRIGGER AS $formatDeposito$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.abreviatura := massoftware.white_is_null(NEW.abreviatura);
	 NEW.sucursal := massoftware.white_is_null(NEW.sucursal);
	 NEW.depositoModulo := massoftware.white_is_null(NEW.depositoModulo);
	 NEW.puertaOperativo := massoftware.white_is_null(NEW.puertaOperativo);
	 NEW.puertaConsulta := massoftware.white_is_null(NEW.puertaConsulta);

	RETURN NEW;
END;
$formatDeposito$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatDeposito ON massoftware.Deposito CASCADE;

CREATE TRIGGER tgFormatDeposito BEFORE INSERT OR UPDATE
	ON massoftware.Deposito FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatDeposito();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Deposito;

-- SELECT * FROM massoftware.Deposito LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Deposito;

-- SELECT * FROM massoftware.Deposito WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: EjercicioContable                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.EjercicioContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.EjercicioContable CASCADE;

CREATE TABLE massoftware.EjercicioContable
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº ejercicio
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT EjercicioContable_numero_chk CHECK ( numero >= 1  ), 
	
	-- Apertura
	apertura DATE NOT NULL, 
	
	-- Cierre
	cierre DATE NOT NULL, 
	
	-- Cerrado
	cerrado BOOLEAN NOT NULL, 
	
	-- Cerrado módulos
	cerradoModulos BOOLEAN NOT NULL, 
	
	-- Coemntario
	comentario VARCHAR(250)
);

-- ---------------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatEjercicioContable() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatEjercicioContable() RETURNS TRIGGER AS $formatEjercicioContable$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.comentario := massoftware.white_is_null(NEW.comentario);

	RETURN NEW;
END;
$formatEjercicioContable$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatEjercicioContable ON massoftware.EjercicioContable CASCADE;

CREATE TRIGGER tgFormatEjercicioContable BEFORE INSERT OR UPDATE
	ON massoftware.EjercicioContable FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatEjercicioContable();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.EjercicioContable;

-- SELECT * FROM massoftware.EjercicioContable LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.EjercicioContable;

-- SELECT * FROM massoftware.EjercicioContable WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CentroCostoContable                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CentroCostoContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.CentroCostoContable CASCADE;

CREATE TABLE massoftware.CentroCostoContable
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº cc
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT CentroCostoContable_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Abreviatura
	abreviatura VARCHAR(5) NOT NULL, 
	
	-- Ejercicio
	ejercicioContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.EjercicioContable (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_CentroCostoContable_nombre ON massoftware.CentroCostoContable (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_CentroCostoContable_abreviatura ON massoftware.CentroCostoContable (TRANSLATE(LOWER(TRIM(abreviatura))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCentroCostoContable() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCentroCostoContable() RETURNS TRIGGER AS $formatCentroCostoContable$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.abreviatura := massoftware.white_is_null(NEW.abreviatura);
	 NEW.ejercicioContable := massoftware.white_is_null(NEW.ejercicioContable);

	RETURN NEW;
END;
$formatCentroCostoContable$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCentroCostoContable ON massoftware.CentroCostoContable CASCADE;

CREATE TRIGGER tgFormatCentroCostoContable BEFORE INSERT OR UPDATE
	ON massoftware.CentroCostoContable FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatCentroCostoContable();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.CentroCostoContable;

-- SELECT * FROM massoftware.CentroCostoContable LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.CentroCostoContable;

-- SELECT * FROM massoftware.CentroCostoContable WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoPuntoEquilibrio                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoPuntoEquilibrio

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.TipoPuntoEquilibrio CASCADE;

CREATE TABLE massoftware.TipoPuntoEquilibrio
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº tipo
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT TipoPuntoEquilibrio_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_TipoPuntoEquilibrio_nombre ON massoftware.TipoPuntoEquilibrio (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatTipoPuntoEquilibrio() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatTipoPuntoEquilibrio() RETURNS TRIGGER AS $formatTipoPuntoEquilibrio$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatTipoPuntoEquilibrio$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTipoPuntoEquilibrio ON massoftware.TipoPuntoEquilibrio CASCADE;

CREATE TRIGGER tgFormatTipoPuntoEquilibrio BEFORE INSERT OR UPDATE
	ON massoftware.TipoPuntoEquilibrio FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatTipoPuntoEquilibrio();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.TipoPuntoEquilibrio;

-- SELECT * FROM massoftware.TipoPuntoEquilibrio LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.TipoPuntoEquilibrio;

-- SELECT * FROM massoftware.TipoPuntoEquilibrio WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: PuntoEquilibrio                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.PuntoEquilibrio

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.PuntoEquilibrio CASCADE;

CREATE TABLE massoftware.PuntoEquilibrio
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº cc
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT PuntoEquilibrio_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Tipo
	tipoPuntoEquilibrio VARCHAR(36)  NOT NULL  REFERENCES massoftware.TipoPuntoEquilibrio (id), 
	
	-- Ejercicio
	ejercicioContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.EjercicioContable (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_PuntoEquilibrio_nombre ON massoftware.PuntoEquilibrio (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatPuntoEquilibrio() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatPuntoEquilibrio() RETURNS TRIGGER AS $formatPuntoEquilibrio$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.tipoPuntoEquilibrio := massoftware.white_is_null(NEW.tipoPuntoEquilibrio);
	 NEW.ejercicioContable := massoftware.white_is_null(NEW.ejercicioContable);

	RETURN NEW;
END;
$formatPuntoEquilibrio$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatPuntoEquilibrio ON massoftware.PuntoEquilibrio CASCADE;

CREATE TRIGGER tgFormatPuntoEquilibrio BEFORE INSERT OR UPDATE
	ON massoftware.PuntoEquilibrio FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatPuntoEquilibrio();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.PuntoEquilibrio;

-- SELECT * FROM massoftware.PuntoEquilibrio LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.PuntoEquilibrio;

-- SELECT * FROM massoftware.PuntoEquilibrio WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CostoVenta                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CostoVenta

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.CostoVenta CASCADE;

CREATE TABLE massoftware.CostoVenta
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº tipo
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT CostoVenta_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_CostoVenta_nombre ON massoftware.CostoVenta (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCostoVenta() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCostoVenta() RETURNS TRIGGER AS $formatCostoVenta$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatCostoVenta$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCostoVenta ON massoftware.CostoVenta CASCADE;

CREATE TRIGGER tgFormatCostoVenta BEFORE INSERT OR UPDATE
	ON massoftware.CostoVenta FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatCostoVenta();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.CostoVenta;

-- SELECT * FROM massoftware.CostoVenta LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.CostoVenta;

-- SELECT * FROM massoftware.CostoVenta WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaContableEstado                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaContableEstado

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.CuentaContableEstado CASCADE;

CREATE TABLE massoftware.CuentaContableEstado
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº tipo
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT CuentaContableEstado_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_CuentaContableEstado_nombre ON massoftware.CuentaContableEstado (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCuentaContableEstado() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCuentaContableEstado() RETURNS TRIGGER AS $formatCuentaContableEstado$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatCuentaContableEstado$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCuentaContableEstado ON massoftware.CuentaContableEstado CASCADE;

CREATE TRIGGER tgFormatCuentaContableEstado BEFORE INSERT OR UPDATE
	ON massoftware.CuentaContableEstado FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatCuentaContableEstado();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.CuentaContableEstado;

-- SELECT * FROM massoftware.CuentaContableEstado LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.CuentaContableEstado;

-- SELECT * FROM massoftware.CuentaContableEstado WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaContable                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.CuentaContable CASCADE;

CREATE TABLE massoftware.CuentaContable
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Cuenta contable
	codigo VARCHAR(11) NOT NULL, 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Ejercicio
	ejercicioContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.EjercicioContable (id), 
	
	-- Integra
	integra VARCHAR(16) NOT NULL  CONSTRAINT CuentaContable_integra_chk CHECK ( char_length(integra::VARCHAR) >= 16  ), 
	
	-- Cuenta de jerarquia
	cuentaJerarquia VARCHAR(16) NOT NULL  CONSTRAINT CuentaContable_cuentaJerarquia_chk CHECK ( char_length(cuentaJerarquia::VARCHAR) >= 16  ), 
	
	-- Imputable
	imputable BOOLEAN NOT NULL, 
	
	-- Ajusta por inflación
	ajustaPorInflacion BOOLEAN NOT NULL, 
	
	-- Estado
	cuentaContableEstado VARCHAR(36)  NOT NULL  REFERENCES massoftware.CuentaContableEstado (id), 
	
	-- Cuenta con apropiación
	cuentaConApropiacion BOOLEAN NOT NULL, 
	
	-- Estado
	centroCostoContable VARCHAR(36)  REFERENCES massoftware.CentroCostoContable (id), 
	
	-- Cuenta agrupadora
	cuentaAgrupadora VARCHAR(50), 
	
	-- Porcentaje
	porcentaje DECIMAL(6,3) CONSTRAINT CuentaContable_porcentaje_chk CHECK ( porcentaje >= 0 AND porcentaje <= 999.99  ), 
	
	-- Punto de equilibrio
	puntoEquilibrio VARCHAR(36)  REFERENCES massoftware.PuntoEquilibrio (id), 
	
	-- Costo de venta
	costoVenta VARCHAR(36)  REFERENCES massoftware.CostoVenta (id), 
	
	-- Puerta
	seguridadPuerta VARCHAR(36)  REFERENCES massoftware.SeguridadPuerta (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_CuentaContable_codigo ON massoftware.CuentaContable (TRANSLATE(LOWER(TRIM(codigo))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_CuentaContable_nombre ON massoftware.CuentaContable (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCuentaContable() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCuentaContable() RETURNS TRIGGER AS $formatCuentaContable$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.codigo := massoftware.white_is_null(NEW.codigo);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.ejercicioContable := massoftware.white_is_null(NEW.ejercicioContable);
	 NEW.integra := massoftware.white_is_null(NEW.integra);
	 NEW.cuentaJerarquia := massoftware.white_is_null(NEW.cuentaJerarquia);
	 NEW.cuentaContableEstado := massoftware.white_is_null(NEW.cuentaContableEstado);
	 NEW.centroCostoContable := massoftware.white_is_null(NEW.centroCostoContable);
	 NEW.cuentaAgrupadora := massoftware.white_is_null(NEW.cuentaAgrupadora);
	 NEW.puntoEquilibrio := massoftware.white_is_null(NEW.puntoEquilibrio);
	 NEW.costoVenta := massoftware.white_is_null(NEW.costoVenta);
	 NEW.seguridadPuerta := massoftware.white_is_null(NEW.seguridadPuerta);

	RETURN NEW;
END;
$formatCuentaContable$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCuentaContable ON massoftware.CuentaContable CASCADE;

CREATE TRIGGER tgFormatCuentaContable BEFORE INSERT OR UPDATE
	ON massoftware.CuentaContable FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatCuentaContable();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.CuentaContable;

-- SELECT * FROM massoftware.CuentaContable LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.CuentaContable;

-- SELECT * FROM massoftware.CuentaContable WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoModelo                                                                                          //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoModelo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.AsientoModelo CASCADE;

CREATE TABLE massoftware.AsientoModelo
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº asiento
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT AsientoModelo_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL, 
	
	-- Ejercicio
	ejercicioContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.EjercicioContable (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_AsientoModelo_nombre ON massoftware.AsientoModelo (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatAsientoModelo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatAsientoModelo() RETURNS TRIGGER AS $formatAsientoModelo$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);
	 NEW.ejercicioContable := massoftware.white_is_null(NEW.ejercicioContable);

	RETURN NEW;
END;
$formatAsientoModelo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatAsientoModelo ON massoftware.AsientoModelo CASCADE;

CREATE TRIGGER tgFormatAsientoModelo BEFORE INSERT OR UPDATE
	ON massoftware.AsientoModelo FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatAsientoModelo();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.AsientoModelo;

-- SELECT * FROM massoftware.AsientoModelo LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.AsientoModelo;

-- SELECT * FROM massoftware.AsientoModelo WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoModeloItem                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoModeloItem

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.AsientoModeloItem CASCADE;

CREATE TABLE massoftware.AsientoModeloItem
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº item
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT AsientoModeloItem_numero_chk CHECK ( numero >= 1  ), 
	
	-- Asiento modelo
	asientoModelo VARCHAR(36)  NOT NULL  REFERENCES massoftware.AsientoModelo (id), 
	
	-- Cuenta contable
	cuentaContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.CuentaContable (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatAsientoModeloItem() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatAsientoModeloItem() RETURNS TRIGGER AS $formatAsientoModeloItem$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.asientoModelo := massoftware.white_is_null(NEW.asientoModelo);
	 NEW.cuentaContable := massoftware.white_is_null(NEW.cuentaContable);

	RETURN NEW;
END;
$formatAsientoModeloItem$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatAsientoModeloItem ON massoftware.AsientoModeloItem CASCADE;

CREATE TRIGGER tgFormatAsientoModeloItem BEFORE INSERT OR UPDATE
	ON massoftware.AsientoModeloItem FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatAsientoModeloItem();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.AsientoModeloItem;

-- SELECT * FROM massoftware.AsientoModeloItem LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.AsientoModeloItem;

-- SELECT * FROM massoftware.AsientoModeloItem WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MinutaContable                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MinutaContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.MinutaContable CASCADE;

CREATE TABLE massoftware.MinutaContable
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº minuta
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT MinutaContable_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_MinutaContable_nombre ON massoftware.MinutaContable (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatMinutaContable() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatMinutaContable() RETURNS TRIGGER AS $formatMinutaContable$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatMinutaContable$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatMinutaContable ON massoftware.MinutaContable CASCADE;

CREATE TRIGGER tgFormatMinutaContable BEFORE INSERT OR UPDATE
	ON massoftware.MinutaContable FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatMinutaContable();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.MinutaContable;

-- SELECT * FROM massoftware.MinutaContable LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.MinutaContable;

-- SELECT * FROM massoftware.MinutaContable WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContableModulo                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoContableModulo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.AsientoContableModulo CASCADE;

CREATE TABLE massoftware.AsientoContableModulo
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº módulo
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT AsientoContableModulo_numero_chk CHECK ( numero >= 1  ), 
	
	-- Nombre
	nombre VARCHAR(50) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


CREATE UNIQUE INDEX u_AsientoContableModulo_nombre ON massoftware.AsientoContableModulo (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatAsientoContableModulo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatAsientoContableModulo() RETURNS TRIGGER AS $formatAsientoContableModulo$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.nombre := massoftware.white_is_null(NEW.nombre);

	RETURN NEW;
END;
$formatAsientoContableModulo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatAsientoContableModulo ON massoftware.AsientoContableModulo CASCADE;

CREATE TRIGGER tgFormatAsientoContableModulo BEFORE INSERT OR UPDATE
	ON massoftware.AsientoContableModulo FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatAsientoContableModulo();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.AsientoContableModulo;

-- SELECT * FROM massoftware.AsientoContableModulo LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.AsientoContableModulo;

-- SELECT * FROM massoftware.AsientoContableModulo WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContable                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.AsientoContable CASCADE;

CREATE TABLE massoftware.AsientoContable
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº asiento
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT AsientoContable_numero_chk CHECK ( numero >= 1  ), 
	
	-- Fecha
	fecha DATE NOT NULL, 
	
	-- Detalle
	detalle VARCHAR(100), 
	
	-- Ejercicio
	ejercicioContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.EjercicioContable (id), 
	
	-- Minuta contable
	minutaContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.MinutaContable (id), 
	
	-- Sucursal
	sucursal VARCHAR(36)  NOT NULL  REFERENCES massoftware.Sucursal (id), 
	
	-- Módulo
	asientoContableModulo VARCHAR(36)  NOT NULL  REFERENCES massoftware.AsientoContableModulo (id)
);

-- ---------------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatAsientoContable() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatAsientoContable() RETURNS TRIGGER AS $formatAsientoContable$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.detalle := massoftware.white_is_null(NEW.detalle);
	 NEW.ejercicioContable := massoftware.white_is_null(NEW.ejercicioContable);
	 NEW.minutaContable := massoftware.white_is_null(NEW.minutaContable);
	 NEW.sucursal := massoftware.white_is_null(NEW.sucursal);
	 NEW.asientoContableModulo := massoftware.white_is_null(NEW.asientoContableModulo);

	RETURN NEW;
END;
$formatAsientoContable$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatAsientoContable ON massoftware.AsientoContable CASCADE;

CREATE TRIGGER tgFormatAsientoContable BEFORE INSERT OR UPDATE
	ON massoftware.AsientoContable FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatAsientoContable();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.AsientoContable;

-- SELECT * FROM massoftware.AsientoContable LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.AsientoContable;

-- SELECT * FROM massoftware.AsientoContable WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContableItem                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoContableItem

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.AsientoContableItem CASCADE;

CREATE TABLE massoftware.AsientoContableItem
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Nº item
	numero INTEGER NOT NULL  UNIQUE  CONSTRAINT AsientoContableItem_numero_chk CHECK ( numero >= 1  ), 
	
	-- Fecha
	fecha DATE NOT NULL, 
	
	-- Detalle
	detalle VARCHAR(100), 
	
	-- Asiento contable
	asientoContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.AsientoContable (id), 
	
	-- Cuenta contable
	cuentaContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.CuentaContable (id), 
	
	-- Debe
	debe DECIMAL(13,5) NOT NULL, 
	
	-- Haber
	haber DECIMAL(13,5) NOT NULL
);

-- ---------------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatAsientoContableItem() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatAsientoContableItem() RETURNS TRIGGER AS $formatAsientoContableItem$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.detalle := massoftware.white_is_null(NEW.detalle);
	 NEW.asientoContable := massoftware.white_is_null(NEW.asientoContable);
	 NEW.cuentaContable := massoftware.white_is_null(NEW.cuentaContable);

	RETURN NEW;
END;
$formatAsientoContableItem$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatAsientoContableItem ON massoftware.AsientoContableItem CASCADE;

CREATE TRIGGER tgFormatAsientoContableItem BEFORE INSERT OR UPDATE
	ON massoftware.AsientoContableItem FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatAsientoContableItem();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.AsientoContableItem;

-- SELECT * FROM massoftware.AsientoContableItem LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.AsientoContableItem;

-- SELECT * FROM massoftware.AsientoContableItem WHERE id = 'xxx';


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Empresa                                                                                                //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Empresa

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TABLE IF EXISTS massoftware.Empresa CASCADE;

CREATE TABLE massoftware.Empresa
(
	id VARCHAR(36) PRIMARY KEY DEFAULT uuid_generate_v4(),
	
	-- Ejercicio
	ejercicioContable VARCHAR(36)  NOT NULL  REFERENCES massoftware.EjercicioContable (id), 
	
	-- Fecha cierre ventas
	fechaCierreVentas DATE, 
	
	-- Fecha cierre stock
	fechaCierreStock DATE, 
	
	-- Fecha cierre fondo
	fechaCierreFondo DATE, 
	
	-- Fecha cierre compras
	fechaCierreCompras DATE, 
	
	-- Fecha cierre contabilidad
	fechaCierreContabilidad DATE, 
	
	-- Fecha cierre garantia y devoluciones
	fechaCierreGarantiaDevoluciones DATE, 
	
	-- Fecha cierre tambos
	fechaCierreTambos DATE, 
	
	-- Fecha cierre RRHH
	fechaCierreRRHH DATE
);

-- ---------------------------------------------------------------------------------------------------------------------------


-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatEmpresa() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatEmpresa() RETURNS TRIGGER AS $formatEmpresa$
DECLARE
BEGIN
	 NEW.id := massoftware.white_is_null(NEW.id);
	 NEW.ejercicioContable := massoftware.white_is_null(NEW.ejercicioContable);

	RETURN NEW;
END;
$formatEmpresa$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatEmpresa ON massoftware.Empresa CASCADE;

CREATE TRIGGER tgFormatEmpresa BEFORE INSERT OR UPDATE
	ON massoftware.Empresa FOR EACH ROW
	EXECUTE PROCEDURE massoftware.ftgFormatEmpresa();

-- ---------------------------------------------------------------------------------------------------------------------------



-- SELECT COUNT(*) FROM massoftware.Empresa;

-- SELECT * FROM massoftware.Empresa LIMIT 100 OFFSET 0;

-- SELECT * FROM massoftware.Empresa;

-- SELECT * FROM massoftware.Empresa WHERE id = 'xxx';