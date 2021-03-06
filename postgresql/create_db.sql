/*
CREATE OR REPLACE  FUNCTION kuntur.ftg_number_admission_period_increment() RETURNS trigger AS $admission_period_increment$
    BEGIN
       
         SELECT INTO NEW.number_admission_period coalesce(MAX(number_admission_period),0) + 1 
         FROM kuntur.admission_period;
         --WHERE 	coalesce(agreement_id,'') = coalesce(NEW.agreement_id,'');
      
        RETURN NEW;
    END;
$admission_period_increment$ LANGUAGE plpgsql;

--DROP TRIGGER tg_number_batch_increment ON model.task;
CREATE TRIGGER tg_number_admission_period_increment BEFORE INSERT ON kuntur.admission_period
    FOR EACH ROW EXECUTE PROCEDURE kuntur.ftg_number_admission_period_increment();
*/



-- CREATE EXTENSION "uuid-ossp";
-- SELECT uuid_generate_v4();

DROP SCHEMA IF EXISTS massoftware CASCADE;

CREATE SCHEMA massoftware AUTHORIZATION massoftwareroot;	

-- ==========================================================================================================================
-- ==========================================================================================================================
-- ==========================================================================================================================
-- =======================																				=====================
-- =======================				FUNCIONES UTILES												=====================	
-- =======================																				=====================
-- ==========================================================================================================================
-- ==========================================================================================================================
-- ==========================================================================================================================

DROP FUNCTION IF EXISTS massoftware.random_between (low INT ,high INT) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.random_between (low INT ,high INT) 
   RETURNS INT AS
$$
BEGIN
   RETURN floor(random()* (high-low + 1) + low);
END;
$$ language 'plpgsql' STRICT;


-- SELECT massoftware.random_between(1, 100);

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.white_is_null (att_val VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.white_is_null(att_val VARCHAR) RETURNS VARCHAR AS $$
BEGIN
	IF CHAR_LENGTH(TRIM(att_val)) = 0 THEN
	
		RETURN null::VARCHAR;
	END IF;

	RETURN TRIM(att_val)::VARCHAR;
		
END;
$$  LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.zero_is_null (att_val INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.zero_is_null(att_val INTEGER) RETURNS INTEGER AS $$
BEGIN
	IF att_val = 0 THEN
	
		RETURN null::INTEGER;
	END IF;

	RETURN att_val::INTEGER;
		
END;
$$  LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.zero_is_null (att_val BIGINT) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.zero_is_null(att_val BIGINT) RETURNS BIGINT AS $$
BEGIN
	IF att_val = 0 THEN
	
		RETURN null::BIGINT;
	END IF;

	RETURN att_val::BIGINT;
		
END;
$$  LANGUAGE plpgsql;


-- ---------------------------------------------------------------------------------------------------------------------------

-- SELECT TRANSLATE('12345', '134', 'ax')

DROP FUNCTION IF EXISTS massoftware.translate_from () CASCADE;

CREATE OR REPLACE FUNCTION massoftware.translate_from() RETURNS VARCHAR AS $$
BEGIN
	
	RETURN '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'::VARCHAR;
		
END;
$$  LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

-- SELECT massoftware.traslate_from();

DROP FUNCTION IF EXISTS massoftware.translate_to () CASCADE;

CREATE OR REPLACE FUNCTION massoftware.translate_to() RETURNS VARCHAR AS $$
BEGIN
	
	RETURN '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN'::VARCHAR;
		
END;
$$  LANGUAGE plpgsql;

-- SELECT massoftware.traslate_to();

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.translate (att_val VARCHAR) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.translate(att_val VARCHAR) RETURNS VARCHAR AS $$
BEGIN
	IF CHAR_LENGTH(TRIM(att_val)) = 0 THEN
	
		RETURN null::VARCHAR;
	END IF;

	RETURN TRANSLATE(att_val, massoftware.translate_from (), massoftware.translate_to())::VARCHAR;
		
END;
$$  LANGUAGE plpgsql;

-- SELECT massoftware.translate('1234567890' || massoftware.translate_from());


-- ==========================================================================================================================
-- ==========================================================================================================================
-- ==========================================================================================================================
-- =======================																				=====================
-- =======================							TABLAS												=====================	
-- =======================																				=====================
-- ==========================================================================================================================
-- ==========================================================================================================================
-- ==========================================================================================================================







-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: Usuario														 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-- Table: massoftware.Usuario

DROP TABLE IF EXISTS massoftware.Usuario CASCADE;

CREATE TABLE massoftware.Usuario
(    
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),      
    numero INTEGER NOT NULL UNIQUE,
    nombre VARCHAR NOT NULL
);

-- CREATE UNIQUE INDEX u_Usuario_nombre ON massoftware.Usuario (LOWER(TRIM(nombre)));

CREATE UNIQUE INDEX u_Usuario_nombre ON massoftware.Usuario (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- SELECT * FROM massoftware.Usuario;    

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatUsuario() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatUsuario() RETURNS TRIGGER AS $formatUsuario$
DECLARE
BEGIN   
	
    NEW.nombre := massoftware.white_is_null(TRIM(NEW.nombre));	

	RETURN NEW;
END;
$formatUsuario$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatUsuario ON massoftware.Usuario CASCADE;

CREATE TRIGGER tgFormatUsuario BEFORE INSERT OR UPDATE 
    ON massoftware.Usuario FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatUsuario();





-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: MonedaAFIP														 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MonedaAFIP

DROP TABLE IF EXISTS massoftware.MonedaAFIP CASCADE;

CREATE TABLE massoftware.MonedaAFIP
(
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    codigo VARCHAR  NOT NULL,
    nombre VARCHAR  NOT NULL
    
);

CREATE UNIQUE INDEX u_MonedaAFIP_codigo ON massoftware.MonedaAFIP (TRANSLATE(LOWER(TRIM(codigo))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));
CREATE UNIQUE INDEX u_MonedaAFIP_nombre ON massoftware.MonedaAFIP (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));



-- SELECT COUNT(*) FROM massoftware.MonedaAFIP;
-- SELECT * FROM massoftware.MonedaAFIP;

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









-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: Moneda															 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.Moneda

DROP TABLE IF EXISTS massoftware.Moneda CASCADE;

CREATE TABLE massoftware.Moneda
( 
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    numero INTEGER  NOT NULL UNIQUE CONSTRAINT Moneda_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL,
    abreviatura VARCHAR  NOT NULL,
    cotizacion DECIMAL(9,4)  NOT NULL, -- CONSTRAINT Moneda_cotizacion_chk CHECK (numero > 0),
    cotizacionFecha TIMESTAMP  NOT NULL,    
    controlActualizacion BOOLEAN  DEFAULT false, 
    monedaAFIP VARCHAR REFERENCES massoftware.MonedaAFIP (id)	
    
);

CREATE UNIQUE INDEX u_Moneda_nombre ON massoftware.Moneda (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_Moneda_abreviatura ON massoftware.Moneda (TRANSLATE(LOWER(TRIM(abreviatura))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));


-- SELECT * FROM massoftware.Moneda;

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












-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: Moneda cotización												 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.MonedaCotizacion

DROP TABLE IF EXISTS massoftware.MonedaCotizacion CASCADE;

CREATE TABLE massoftware.MonedaCotizacion
( 
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    moneda VARCHAR REFERENCES massoftware.Moneda (id),	
    fecha TIMESTAMP  NOT NULL,
    compra DECIMAL(9,4)  NOT NULL, -- CONSTRAINT Moneda_cotizacion_chk CHECK (numero > 0),
    venta DECIMAL(9,4)  NOT NULL, -- CONSTRAINT Moneda_cotizacion_chk CHECK (numero > 0),
    auditoriafecha TIMESTAMP  NOT NULL, 
    usuario VARCHAR REFERENCES massoftware.Usuario (id) -- NOT NULL
    
);

-- CREATE UNIQUE INDEX u_MonedaCotizacion_fecha ON massoftware.MonedaCotizacion (moneda, fecha);
-- CREATE UNIQUE INDEX u_MonedaCotizacion_auditoriafecha ON massoftware.MonedaCotizacion (moneda, auditoriafecha);

-- SELECT * FROM massoftware.MonedaCotizacion;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatMonedaCotizacion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatMonedaCotizacion() RETURNS TRIGGER AS $formatMonedaCotizacion$
DECLARE
BEGIN   

    NEW.id := massoftware.white_is_null(NEW.id);    
    NEW.moneda := massoftware.white_is_null(NEW.moneda);    
    NEW.usuario := massoftware.white_is_null(NEW.usuario);        
    
	RETURN NEW;
END;
$formatMonedaCotizacion$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatMonedaCotizacion ON massoftware.MonedaCotizacion CASCADE;

CREATE TRIGGER tgFormatMonedaCotizacion BEFORE INSERT OR UPDATE 
    ON massoftware.MonedaCotizacion FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatMonedaCotizacion();











-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: SeguridadModulo													 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.SeguridadModulo

DROP TABLE IF EXISTS massoftware.SeguridadModulo CASCADE;

CREATE TABLE massoftware.SeguridadModulo
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    numero INTEGER  NOT NULL UNIQUE CONSTRAINT SeguridadModulo_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL CONSTRAINT SeguridadModulo_nombre_chk CHECK (char_length(nombre) >= 2)    
);

CREATE UNIQUE INDEX u_SeguridadModulo_nombre ON massoftware.SeguridadModulo (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- SELECT * FROM massoftware.SeguridadModulo;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatSeguridadModulo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatSeguridadModulo() RETURNS TRIGGER AS $formatSeguridadModulo$
DECLARE
BEGIN
   
	-- NEW.comentario := massoftware.white_is_null(REPLACE(TRIM(NEW.comentario), '"', ''));	
    NEW.id := massoftware.white_is_null(NEW.id);
    -- NEW.numero := massoftware.zero_is_null(NEW.numero);
    NEW.nombre := massoftware.white_is_null(NEW.nombre);    

	RETURN NEW;
END;
$formatSeguridadModulo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatSeguridadModulo ON massoftware.SeguridadModulo CASCADE;

CREATE TRIGGER tgFormatSeguridadModulo BEFORE INSERT OR UPDATE 
    ON massoftware.SeguridadModulo FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatSeguridadModulo();
    
    
    
    
    
    
    
    
    
    


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: SeguridadPuerta													 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.SeguridadPuerta

DROP TABLE IF EXISTS massoftware.SeguridadPuerta CASCADE;

CREATE TABLE massoftware.SeguridadPuerta
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    seguridadModulo VARCHAR NOT NULL REFERENCES massoftware.SeguridadModulo (id),	
    numero INTEGER  NOT NULL CONSTRAINT SeguridadPuerta_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL CONSTRAINT SeguridadPuerta_nombre_chk CHECK (char_length(nombre) >= 2),    
    equate VARCHAR  NOT NULL    
);

CREATE UNIQUE INDEX u_SeguridadPuerta_seguridadModulo_numero ON massoftware.SeguridadPuerta (seguridadModulo, numero);
CREATE UNIQUE INDEX u_SeguridadPuerta_seguridadModulo_nombre ON massoftware.SeguridadPuerta (seguridadModulo, TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- SELECT * FROM massoftware.SeguridadPuerta;
-- SELECT * FROM massoftware.SeguridadPuerta ORDER BY seguridadModulo, numero;
-- SELECT * FROM massoftware.SeguridadPuerta ORDER BY numero, seguridadModulo;
-- SELECT COALESCE(MAX(numero), 0) + 1 FROM massoftware.SeguridadPuerta WHERE seguridadModulo = '1' ORDER BY 1;
-- SELECT equate FROM massoftware.SeguridadPuerta ORDER BY equate;
-- SELECT COUNT(*)  FROM massoftware.SeguridadPuerta WHERE LOWER(TRIM(massoftware.TRANSLATE(seguridadModulo)))::VARCHAR = LOWER(TRIM(massoftware.TRANSLATE('9')))::VARCHAR AND LOWER(TRIM(massoftware.TRANSLATE(nombre)))::VARCHAR = LOWER(TRIM(massoftware.TRANSLATE('11')))::VARCHAR ORDER BY 1;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatSeguridadPuerta() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatSeguridadPuerta() RETURNS TRIGGER AS $formatSeguridadPuerta$
DECLARE
BEGIN
   
	-- NEW.comentario := massoftware.white_is_null(REPLACE(TRIM(NEW.comentario), '"', ''));	
    NEW.id := massoftware.white_is_null(NEW.id);
    NEW.seguridadModulo := massoftware.white_is_null(NEW.seguridadModulo);
    -- NEW.numero := massoftware.zero_is_null(NEW.numero);
    NEW.nombre := massoftware.white_is_null(NEW.nombre);    
    NEW.equate := massoftware.white_is_null(NEW.equate);    

	RETURN NEW;
END;
$formatSeguridadPuerta$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatSSeguridadPuerta ON massoftware.SeguridadPuerta CASCADE;

CREATE TRIGGER tgFormatSeguridadPuerta BEFORE INSERT OR UPDATE 
    ON massoftware.SeguridadPuerta FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatSeguridadPuerta();
    
    
    
    
    
    
    
    
    
    
    



-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: EjercicioContable												 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.EjercicioContable

DROP TABLE IF EXISTS massoftware.EjercicioContable CASCADE;

CREATE TABLE massoftware.EjercicioContable
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    numero INTEGER  NOT NULL UNIQUE CONSTRAINT EjercicioContable_numero_chk CHECK (numero > 0),
    apertura DATE NOT NULL,    
    cierre DATE NOT NULL,    
	cerrado BOOLEAN  DEFAULT false,    
    cerradoModulos BOOLEAN DEFAULT false,        
    comentario VARCHAR        
);

-- SELECT * FROM massoftware.EjercicioContable;
-- SELECT * FROM massoftware.EjercicioContable WHERE  numero = 2030 ORDER BY 1;
-- SELECT now()::timestamp + '1 years'::interval;
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
    
    
    
    
    
    
    
    
    
    
    



-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: PuntoEquilibrioTipo												 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.PuntoEquilibrioTipo

DROP TABLE IF EXISTS massoftware.PuntoEquilibrioTipo CASCADE;

CREATE TABLE massoftware.PuntoEquilibrioTipo
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    numero INTEGER  NOT NULL UNIQUE CONSTRAINT PuntoEquilibrioTipo_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL CONSTRAINT PuntoEquilibrioTipo_nombre_chk CHECK (char_length(nombre) >= 2)    
);

CREATE UNIQUE INDEX u_PuntoEquilibrioTipo_nombre ON massoftware.PuntoEquilibrioTipo (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));


-- SELECT * FROM massoftware.PuntoEquilibrioTipo;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatPuntoEquilibrioTipo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatPuntoEquilibrioTipo() RETURNS TRIGGER AS $formatPuntoEquilibrioTipo$
DECLARE
BEGIN
   
	-- NEW.comentario := massoftware.white_is_null(REPLACE(TRIM(NEW.comentario), '"', ''));	
    NEW.id := massoftware.white_is_null(NEW.id);
    -- NEW.numero := massoftware.zero_is_null(NEW.numero);
    NEW.nombre := massoftware.white_is_null(NEW.nombre);    
    
	RETURN NEW;
END;
$formatPuntoEquilibrioTipo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatPuntoEquilibrioTipo ON massoftware.PuntoEquilibrioTipo CASCADE;

CREATE TRIGGER tgFormatPuntoEquilibrioTipo BEFORE INSERT OR UPDATE 
    ON massoftware.PuntoEquilibrioTipo FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatPuntoEquilibrioTipo();
    
    
INSERT INTO massoftware.PuntoEquilibrioTipo(id, numero, nombre) VALUES ('1', 1, 'Individual');
INSERT INTO massoftware.PuntoEquilibrioTipo(id, numero, nombre) VALUES ('2', 2, 'Costo de ventas');
INSERT INTO massoftware.PuntoEquilibrioTipo(id, numero, nombre) VALUES ('3', 3, 'Utilidad bruta');
INSERT INTO massoftware.PuntoEquilibrioTipo(id, numero, nombre) VALUES ('4', 4, 'Resultados por sección');
INSERT INTO massoftware.PuntoEquilibrioTipo(id, numero, nombre) VALUES ('5', 5, 'Resultados operativos');











-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: PuntoEquilibrio													 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.PuntoEquilibrio

DROP TABLE IF EXISTS massoftware.PuntoEquilibrio CASCADE;

CREATE TABLE massoftware.PuntoEquilibrio
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),
    ejercicioContable VARCHAR NOT NULL REFERENCES massoftware.EjercicioContable (id),	
    puntoEquilibrioTipo VARCHAR NOT NULL REFERENCES massoftware.PuntoEquilibrioTipo (id),	
    numero INTEGER  NOT NULL CONSTRAINT PuntoEquilibrio_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL -- CONSTRAINT PuntoEquilibrio_nombre_chk CHECK (char_length(nombre) >= 2)    
);


CREATE UNIQUE INDEX u_PuntoEquilibrio_ejercicioContable_numero ON massoftware.PuntoEquilibrio (ejercicioContable, numero);
CREATE UNIQUE INDEX u_PuntoEquilibrio_ejercicioContable_nombre ON massoftware.PuntoEquilibrio (ejercicioContable, TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));


-- SELECT * FROM massoftware.PuntoEquilibrio;
-- SELECT COUNT(*)  FROM massoftware.PuntoEquilibrio WHERE LOWER(TRIM(massoftware.TRANSLATE(ejercicioContable)))::VARCHAR = LOWER(TRIM(massoftware.TRANSLATE('2015')))::VARCHAR AND numero = '6' ORDER BY 1;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatPuntoEquilibrio() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatPuntoEquilibrio() RETURNS TRIGGER AS $formatPuntoEquilibrio$
DECLARE
BEGIN
   
	
    NEW.id := massoftware.white_is_null(NEW.id);
    NEW.ejercicioContable := massoftware.white_is_null(NEW.ejercicioContable);    
    NEW.puntoEquilibrioTipo := massoftware.white_is_null(NEW.puntoEquilibrioTipo);    
    NEW.nombre := massoftware.white_is_null(NEW.nombre);    
    
	RETURN NEW;
END;
$formatPuntoEquilibrio$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatPuntoEquilibrio ON massoftware.PuntoEquilibrio CASCADE;

CREATE TRIGGER tgFormatPuntoEquilibrio BEFORE INSERT OR UPDATE 
    ON massoftware.PuntoEquilibrio FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatPuntoEquilibrio();
    
    
    
    
    
    
    
    
    
    
    
    



-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: CentroCostoContable												 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.CentroCostoContable

DROP TABLE IF EXISTS massoftware.CentroCostoContable CASCADE;

CREATE TABLE massoftware.CentroCostoContable
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),
    ejercicioContable VARCHAR NOT NULL REFERENCES massoftware.EjercicioContable (id),	    
    numero INTEGER  NOT NULL CONSTRAINT PuntoEquilibrio_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL, -- CONSTRAINT PuntoEquilibrio_nombre_chk CHECK (char_length(nombre) >= 2),
    abreviatura VARCHAR  NOT NULL -- CONSTRAINT PuntoEquilibrio_nombre_chk CHECK (char_length(nombre) >= 2)    
);


CREATE UNIQUE INDEX u_CentroCostoContable_ejercicioContable_numero ON massoftware.CentroCostoContable (ejercicioContable, numero);
CREATE UNIQUE INDEX u_CentroCostoContable_ejercicioContable_nombre ON massoftware.CentroCostoContable (ejercicioContable, TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));
CREATE UNIQUE INDEX u_CentroCostoContable_ejercicioContable_abreviatura ON massoftware.CentroCostoContable (ejercicioContable, TRANSLATE(LOWER(TRIM(abreviatura))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));
            


-- SELECT * FROM massoftware.CentroCostoContable;
-- SELECT COUNT(*)  FROM massoftware.CentroCostoContable WHERE LOWER(TRIM(massoftware.TRANSLATE(ejercicioContable)))::VARCHAR = LOWER(TRIM(massoftware.TRANSLATE('2015')))::VARCHAR AND numero = '6' ORDER BY 1;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCentroCostoContable() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCentroCostoContable() RETURNS TRIGGER AS $formatCentroCostoContable$
DECLARE
BEGIN
   
	
    NEW.id := massoftware.white_is_null(NEW.id);
    NEW.ejercicioContable := massoftware.white_is_null(NEW.ejercicioContable);        
    NEW.nombre := massoftware.white_is_null(NEW.nombre);    
    NEW.abreviatura := massoftware.white_is_null(NEW.abreviatura);    
    
	RETURN NEW;
END;
$formatCentroCostoContable$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCentroCostoContable ON massoftware.CentroCostoContable CASCADE;

CREATE TRIGGER tgFormatCentroCostoContable BEFORE INSERT OR UPDATE 
    ON massoftware.CentroCostoContable FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatCentroCostoContable();











-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: CuentaContableEstado												 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.CuentaContableEstado

DROP TABLE IF EXISTS massoftware.CuentaContableEstado CASCADE;

CREATE TABLE massoftware.CuentaContableEstado
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    numero INTEGER  NOT NULL UNIQUE CONSTRAINT CuentaContableEstado_numero_chk CHECK (numero > -1),
    nombre VARCHAR  NOT NULL CONSTRAINT CuentaContableEstado_nombre_chk CHECK (char_length(nombre) >= 2)    
);

CREATE UNIQUE INDEX u_CuentaContableEstado_nombre ON massoftware.CuentaContableEstado (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));


-- SELECT * FROM massoftware.CuentaContableEstado;

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
    
    
INSERT INTO massoftware.CuentaContableEstado(id, numero, nombre) VALUES ('0', 0, 'Cuenta fuera de uso');
INSERT INTO massoftware.CuentaContableEstado(id, numero, nombre) VALUES ('1', 1, 'Cuenta en uso');













-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: CostoVenta														 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.CostoVenta

DROP TABLE IF EXISTS massoftware.CostoVenta CASCADE;

CREATE TABLE massoftware.CostoVenta
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    numero INTEGER  NOT NULL UNIQUE CONSTRAINT CostoVenta_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL CONSTRAINT CostoVenta_nombre_chk CHECK (char_length(nombre) >= 2)    
);

CREATE UNIQUE INDEX u_CostoVenta_nombre ON massoftware.CostoVenta (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));


-- SELECT * FROM massoftware.CostoVenta;

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
    
    
INSERT INTO massoftware.CostoVenta(id, numero, nombre) VALUES ('1', 1, 'No participa');
INSERT INTO massoftware.CostoVenta(id, numero, nombre) VALUES ('2', 2, 'Stock');
INSERT INTO massoftware.CostoVenta(id, numero, nombre) VALUES ('3', 3, 'Compras');
INSERT INTO massoftware.CostoVenta(id, numero, nombre) VALUES ('4', 4, 'Gastos');












-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: CuentaContable													 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.CuentaContable

DROP TABLE IF EXISTS massoftware.CuentaContable CASCADE;

CREATE TABLE massoftware.CuentaContable
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),
    ejercicioContable VARCHAR NOT NULL REFERENCES massoftware.EjercicioContable (id),	    
    integra VARCHAR  NOT NULL,
    cuentaJerarquia VARCHAR  NOT NULL,
    codigo VARCHAR  NOT NULL,
    nombre VARCHAR  NOT NULL,     
    -- ----------------------------------------------------------------	
    imputable BOOLEAN DEFAULT false,    
    ajustaPorInflacion BOOLEAN DEFAULT false,    		
    cuentaContableEstado VARCHAR NOT NULL REFERENCES massoftware.CuentaContableEstado (id),	
    cuentaConApropiacion BOOLEAN DEFAULT false,    		
    -- ----------------------------------------------------------------
    centroCostoContable VARCHAR REFERENCES massoftware.CentroCostoContable (id),	
    cuentaAgrupadora VARCHAR,	    
    porcentaje DOUBLE PRECISION,	
	puntoEquilibrio VARCHAR REFERENCES massoftware.PuntoEquilibrio (id),
    costoVenta VARCHAR REFERENCES massoftware.CostoVenta (id),
    seguridadPuerta VARCHAR REFERENCES massoftware.SeguridadPuerta (id)
    
);

-- CREATE UNIQUE INDEX u_CuentaContable_ejercicioContable_integra ON massoftware.CuentaContable (ejercicioContable, LOWER(TRIM(integra)));
CREATE UNIQUE INDEX u_CuentaContable_ejercicioContable_cuentaJerarquia ON massoftware.CuentaContable (ejercicioContable, LOWER(TRIM(cuentaJerarquia)));
CREATE UNIQUE INDEX u_CuentaContable_ejercicioContable_codigo ON massoftware.CuentaContable (ejercicioContable, LOWER(TRIM(codigo)));
-- CREATE UNIQUE INDEX u_CuentaContable_ejercicioContable_nombre ON massoftware.CuentaContable (ejercicioContable, TRANSLATE(LOWER(TRIM(nombre))
--             , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
--             , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));


-- SELECT * FROM massoftware.CuentaContable;
-- SELECT * FROM massoftware.CuentaContable WHERE ejercicioContable = '2015' ORDER BY ejercicioContable, integra, cuentaJerarquia, codigo, nombre;
-- SELECT * FROM massoftware.CuentaContable WHERE integra = '00000000000' AND ejercicioContable = '2015' ORDER BY cuentaJerarquia ASC, ejercicioContable ASC;
-- SELECT * FROM massoftware.CuentaContable WHERE id = '2015-2' ORDER BY 1;
-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCuentaContable() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCuentaContable() RETURNS TRIGGER AS $formatCuentaContable$
DECLARE
BEGIN   
	
    NEW.id := massoftware.white_is_null(NEW.id);
    NEW.ejercicioContable := massoftware.white_is_null(NEW.ejercicioContable);    
    NEW.integra := massoftware.white_is_null(NEW.integra);    
    NEW.cuentaJerarquia := massoftware.white_is_null(NEW.cuentaJerarquia);    
    NEW.codigo := massoftware.white_is_null(NEW.codigo);    
    NEW.nombre := massoftware.white_is_null(NEW.nombre);    
    -- ----------------------------------------------------------------	     
    NEW.cuentaContableEstado := massoftware.white_is_null(NEW.cuentaContableEstado);                                            
    -- ----------------------------------------------------------------
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
    
    
    
    
    
    
    
    
    
    


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: AsientoModelo												 	 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.AsientoModelo

DROP TABLE IF EXISTS massoftware.AsientoModelo CASCADE;

CREATE TABLE massoftware.AsientoModelo
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    ejercicioContable VARCHAR NOT NULL REFERENCES massoftware.EjercicioContable (id),	
    numero INTEGER  NOT NULL CONSTRAINT AsientoModelo_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL CONSTRAINT AsientoModelo_nombre_chk CHECK (char_length(nombre) >= 2)    
);


CREATE UNIQUE INDEX u_AsientoModelo_ejercicioContable_numero ON massoftware.AsientoModelo (ejercicioContable, numero);
CREATE UNIQUE INDEX u_AsientoModelo_ejercicioContable_nombre ON massoftware.AsientoModelo (ejercicioContable, TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));


-- SELECT * FROM massoftware.AsientoModelo;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatAsientoModelo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatAsientoModelo() RETURNS TRIGGER AS $formatAsientoModelo$
DECLARE
BEGIN   

    NEW.id := massoftware.white_is_null(NEW.id);
    NEW.ejercicioContable := massoftware.white_is_null(NEW.ejercicioContable);    
    NEW.nombre := massoftware.white_is_null(NEW.nombre);    
    
	RETURN NEW;
END;
$formatAsientoModelo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatAsientoModelo ON massoftware.AsientoModelo CASCADE;

CREATE TRIGGER tgFormatAsientoModelo BEFORE INSERT OR UPDATE 
    ON massoftware.AsientoModelo FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatAsientoModelo();       
    
    
    
    
    
    
    
    
    
    
    
    
    

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: AsientoModeloItem											 	 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.AsientoModeloItem

DROP TABLE IF EXISTS massoftware.AsientoModeloItem CASCADE;

CREATE TABLE massoftware.AsientoModeloItem
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    asientoModelo VARCHAR NOT NULL REFERENCES massoftware.AsientoModelo (id),	
    numero INTEGER  NOT NULL CONSTRAINT AsientoModeloItem_numero_chk CHECK (numero > 0),
    cuentaContable VARCHAR NOT NULL REFERENCES massoftware.CuentaContable (id)	            
);

CREATE UNIQUE INDEX u_AsientoModeloItem_asientoModelo_numero ON massoftware.AsientoModeloItem (asientoModelo, numero);
CREATE UNIQUE INDEX u_AsientoModeloItem_asientoModelo_cuentaContable ON massoftware.AsientoModeloItem (asientoModelo, cuentaContable);


-- SELECT * FROM massoftware.AsientoModeloItem;

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












-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: Banco															 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Banco

DROP TABLE IF EXISTS massoftware.Banco CASCADE;

CREATE TABLE massoftware.Banco
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    numero INTEGER  NOT NULL UNIQUE CONSTRAINT banco_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL CONSTRAINT banco_nombre_chk CHECK (char_length(nombre) >= 2),
    cuit BIGINT UNIQUE CONSTRAINT banco_cuit_chk CHECK (char_length(cuit::VARCHAR) = 11),
	bloqueado BOOLEAN DEFAULT false,    
    hoja INTEGER CHECK (hoja > 0),
    primeraFila INTEGER CHECK (primeraFila > 0),
    ultimaFila INTEGER CHECK (ultimaFila > 0),
    fecha VARCHAR(3),
    descripcion VARCHAR(3),
    referencia1 VARCHAR(3),
    importe VARCHAR(3),
    referencia2 VARCHAR(3),
    saldo VARCHAR(3)
);

CREATE UNIQUE INDEX u_Banco_nombre ON massoftware.Banco (TRANSLATE(LOWER(TRIM(nombre))
	, '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
	, '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));


-- SELECT * FROM massoftware.Banco;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatBanco() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatBanco() RETURNS TRIGGER AS $formatBanco$
DECLARE
BEGIN
   
	-- NEW.comentario := massoftware.white_is_null(REPLACE(TRIM(NEW.comentario), '"', ''));	
    NEW.id := massoftware.white_is_null(NEW.id);
    -- NEW.numero := massoftware.zero_is_null(NEW.numero);
    NEW.nombre := massoftware.white_is_null(NEW.nombre);
    -- NEW.cuit := massoftware.zero_is_null(NEW.cuit);
    -- NEW.hoja := massoftware.zero_is_null(NEW.hoja);
    -- NEW.primeraFila := massoftware.zero_is_null(NEW.primeraFila);
    -- -- NEW.ultimaFila := massoftware.zero_is_null(NEW.ultimaFila);
    NEW.fecha := massoftware.white_is_null(NEW.fecha);
    NEW.descripcion := massoftware.white_is_null(NEW.descripcion);
    NEW.referencia1 := massoftware.white_is_null(NEW.referencia1);
    NEW.importe := massoftware.white_is_null(NEW.importe);
    NEW.referencia2 := massoftware.white_is_null(NEW.referencia2);
    NEW.saldo := massoftware.white_is_null(NEW.saldo);        

	RETURN NEW;
END;
$formatBanco$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatBanco ON massoftware.Banco CASCADE;

CREATE TRIGGER tgFormatBanco BEFORE INSERT OR UPDATE 
    ON massoftware.Banco FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatBanco();
    
    
    
    
    
    
    
    
    


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: CuentaFondoRubro													 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.CuentaFondoRubro

DROP TABLE IF EXISTS massoftware.CuentaFondoRubro CASCADE;

CREATE TABLE massoftware.CuentaFondoRubro
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    numero INTEGER  NOT NULL UNIQUE CONSTRAINT cuentafondorubro_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL CONSTRAINT cuentafondorubro_nombre_chk CHECK (char_length(nombre) >= 2)    
);

CREATE UNIQUE INDEX u_CuentaFondoRubro_nombre ON massoftware.CuentaFondoRubro (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));



-- SELECT * FROM massoftware.CuentaFondoRubro;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCuentaFondoRubro() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCuentaFondoRubro() RETURNS TRIGGER AS $formatCuentaFondoRubro$
DECLARE
BEGIN
   
	-- NEW.comentario := massoftware.white_is_null(REPLACE(TRIM(NEW.comentario), '"', ''));	
    NEW.id := massoftware.white_is_null(NEW.id);
    NEW.numero := massoftware.zero_is_null(NEW.numero);
    NEW.nombre := massoftware.white_is_null(NEW.nombre);    
    
	RETURN NEW;
END;
$formatCuentaFondoRubro$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCuentaFondoRubro ON massoftware.CuentaFondoRubro CASCADE;

CREATE TRIGGER tgFormatCuentaFondoRubro BEFORE INSERT OR UPDATE 
    ON massoftware.CuentaFondoRubro FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatCuentaFondoRubro();




















-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: CuentaFondoGrupo													 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.CuentaFondoGrupo

DROP TABLE IF EXISTS massoftware.CuentaFondoGrupo CASCADE;

CREATE TABLE massoftware.CuentaFondoGrupo
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),
    cuentaFondoRubro VARCHAR NOT NULL REFERENCES massoftware.CuentaFondoRubro (id),	
    numero INTEGER  NOT NULL CONSTRAINT cuentafondogrupo_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL CONSTRAINT cuentafondogrupo_nombre_chk CHECK (char_length(nombre) >= 2)    
);


CREATE UNIQUE INDEX u_CuentaFondoGrupo_rubro_grupo ON massoftware.CuentaFondoGrupo (cuentaFondoRubro, numero);
CREATE UNIQUE INDEX u_CuentaFondoGrupo_nombre ON massoftware.CuentaFondoGrupo (cuentaFondoRubro, TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));


-- SELECT * FROM massoftware.CuentaFondoGrupo;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCuentaFondoGrupo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCuentaFondoGrupo() RETURNS TRIGGER AS $formatCuentaFondoGrupo$
DECLARE
BEGIN
   
	-- NEW.comentario := massoftware.white_is_null(REPLACE(TRIM(NEW.comentario), '"', ''));	
    NEW.id := massoftware.white_is_null(NEW.id);
    NEW.cuentaFondoRubro := massoftware.white_is_null(NEW.cuentaFondoRubro);
    -- NEW.numero := massoftware.zero_is_null(NEW.numero);
    NEW.nombre := massoftware.white_is_null(NEW.nombre);    
    
	RETURN NEW;
END;
$formatCuentaFondoGrupo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCuentaFondoGrupo ON massoftware.CuentaFondoGrupo CASCADE;

CREATE TRIGGER tgFormatCuentaFondoGrupo BEFORE INSERT OR UPDATE 
    ON massoftware.CuentaFondoGrupo FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatCuentaFondoGrupo();
    
















-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: CuentaFondoTipo													 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.CuentaFondoTipo

DROP TABLE IF EXISTS massoftware.CuentaFondoTipo CASCADE;

CREATE TABLE massoftware.CuentaFondoTipo
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    numero INTEGER  NOT NULL UNIQUE CONSTRAINT cuentafondotipo_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL CONSTRAINT cuentafondotipo_nombre_chk CHECK (char_length(nombre) >= 2)    
);

CREATE UNIQUE INDEX u_CuentaFondoTipo_nombre ON massoftware.CuentaFondoTipo (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));


-- SELECT * FROM massoftware.CuentaFondoTipo;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCuentaFondoTipo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCuentaFondoTipo() RETURNS TRIGGER AS $formatCuentaFondoTipo$
DECLARE
BEGIN
   
	-- NEW.comentario := massoftware.white_is_null(REPLACE(TRIM(NEW.comentario), '"', ''));	
    NEW.id := massoftware.white_is_null(NEW.id);
    -- NEW.numero := massoftware.zero_is_null(NEW.numero);
    NEW.nombre := massoftware.white_is_null(NEW.nombre);    
    
	RETURN NEW;
END;
$formatCuentaFondoTipo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCuentaFondoTipo ON massoftware.CuentaFondoTipo CASCADE;

CREATE TRIGGER tgFormatCuentaFondoTipo BEFORE INSERT OR UPDATE 
    ON massoftware.CuentaFondoTipo FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatCuentaFondoTipo();

-- ---------------------------------------------------------------------------------------------------------------------------

INSERT INTO massoftware.cuentafondotipo(id, numero, nombre) VALUES ('1', 1, 'Caja');
INSERT INTO massoftware.cuentafondotipo(id, numero, nombre) VALUES ('2', 2, 'Banco');
INSERT INTO massoftware.cuentafondotipo(id, numero, nombre) VALUES ('3', 3, 'Cartera');
INSERT INTO massoftware.cuentafondotipo(id, numero, nombre) VALUES ('4', 4, 'Tarjeta');
INSERT INTO massoftware.cuentafondotipo(id, numero, nombre) VALUES ('5', 5, 'Otra');
INSERT INTO massoftware.cuentafondotipo(id, numero, nombre) VALUES ('6', 6, 'Tickets');










-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: CuentaFondo														 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondo	

DROP TABLE IF EXISTS massoftware.CuentaFondo CASCADE;

CREATE TABLE massoftware.CuentaFondo
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    cuentaFondoGrupo VARCHAR NOT NULL REFERENCES massoftware.CuentaFondoGrupo (id),	
    numero INTEGER  NOT NULL UNIQUE CONSTRAINT cuentafondo_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL CONSTRAINT cuentafondo_nombre_chk CHECK (char_length(nombre) >= 1),
    cuentaFondoTipo VARCHAR NOT NULL REFERENCES massoftware.CuentaFondoTipo (id),	
    banco VARCHAR REFERENCES massoftware.Banco (id),	    
	bloqueado BOOLEAN DEFAULT false        
);

CREATE UNIQUE INDEX u_CuentaFondo_nombre ON massoftware.CuentaFondo (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));


-- SELECT COUNT(*) FROM massoftware.CuentaFondo;
-- SELECT * FROM massoftware.CuentaFondo;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCuentaFondo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCuentaFondo() RETURNS TRIGGER AS $formatCuentaFondo$
DECLARE
BEGIN
   
	-- NEW.comentario := massoftware.white_is_null(REPLACE(TRIM(NEW.comentario), '"', ''));	
    NEW.id := massoftware.white_is_null(NEW.id);
    NEW.cuentaFondoGrupo := massoftware.white_is_null(NEW.cuentaFondoGrupo);
    -- NEW.numero := massoftware.zero_is_null(NEW.numero);
    NEW.nombre := massoftware.white_is_null(NEW.nombre);
    NEW.cuentaFondoTipo := massoftware.white_is_null(NEW.cuentaFondoTipo);
    NEW.banco := massoftware.white_is_null(NEW.banco);
    
	RETURN NEW;
END;
$formatCuentaFondo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCuentaFondo ON massoftware.CuentaFondo CASCADE;

CREATE TRIGGER tgFormatCuentaFondo BEFORE INSERT OR UPDATE 
    ON massoftware.CuentaFondo FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatCuentaFondo();
    



















-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: JuridiccionConvnioMultilateral									 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.JuridiccionConvnioMultilateral

DROP TABLE IF EXISTS massoftware.JuridiccionConvnioMultilateral CASCADE;

CREATE TABLE massoftware.JuridiccionConvnioMultilateral
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),
    cuentaFondo VARCHAR NOT NULL REFERENCES massoftware.CuentaFondo (id),	    
    numero INTEGER  NOT NULL UNIQUE CONSTRAINT JuridiccionConvnioMultilateral_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL -- CONSTRAINT PuntoEquilibrio_nombre_chk CHECK (char_length(nombre) >= 2)
    
);

/*
CREATE UNIQUE INDEX u_JuridiccionConvnioMultilateral_cuentaFondo_numero ON massoftware.JuridiccionConvnioMultilateral (cuentaFondo, numero);
CREATE UNIQUE INDEX u_JuridiccionConvnioMultilateral_cuentaFondo_nombre ON massoftware.JuridiccionConvnioMultilateral (cuentaFondo, TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));
*/            
CREATE UNIQUE INDEX u_JuridiccionConvnioMultilateral_nombre ON massoftware.JuridiccionConvnioMultilateral (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));
            


-- SELECT * FROM massoftware.JuridiccionConvnioMultilateral;
-- SELECT COUNT(*)  FROM massoftware.JuridiccionConvnioMultilateral;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatJuridiccionConvnioMultilateral() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatJuridiccionConvnioMultilateral() RETURNS TRIGGER AS $formatJuridiccionConvnioMultilateral$
DECLARE
BEGIN
   
	
    NEW.id := massoftware.white_is_null(NEW.id);
    NEW.cuentaFondo := massoftware.white_is_null(NEW.cuentaFondo);        
    NEW.nombre := massoftware.white_is_null(NEW.nombre);        
    
	RETURN NEW;
END;
$formatJuridiccionConvnioMultilateral$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatJuridiccionConvnioMultilateral ON massoftware.JuridiccionConvnioMultilateral CASCADE;

CREATE TRIGGER tgFormatJuridiccionConvnioMultilateral BEFORE INSERT OR UPDATE 
    ON massoftware.JuridiccionConvnioMultilateral FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatJuridiccionConvnioMultilateral();

















-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: Caja																 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Caja

DROP TABLE IF EXISTS massoftware.Caja CASCADE;

CREATE TABLE massoftware.Caja
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    numero INTEGER  NOT NULL UNIQUE CONSTRAINT Caja_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL CONSTRAINT Caja_nombre_chk CHECK (char_length(nombre) >= 2) ,
    seguridadPuerta VARCHAR REFERENCES massoftware.SeguridadPuerta (id)	
);

CREATE UNIQUE INDEX u_Caja_nombre ON massoftware.Caja (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));



-- SELECT * FROM massoftware.Caja;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCaja() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCaja() RETURNS TRIGGER AS $formatCaja$
DECLARE
BEGIN
   
	-- NEW.comentario := massoftware.white_is_null(REPLACE(TRIM(NEW.comentario), '"', ''));	
    NEW.id := massoftware.white_is_null(NEW.id);
    -- NEW.numero := massoftware.zero_is_null(NEW.numero);
    NEW.nombre := massoftware.white_is_null(NEW.nombre);    
    NEW.seguridadPuerta := massoftware.white_is_null(NEW.seguridadPuerta);    
    
	RETURN NEW;
END;
$formatCaja$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCaja ON massoftware.Caja CASCADE;

CREATE TRIGGER tgFormatCaja BEFORE INSERT OR UPDATE 
    ON massoftware.Caja FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatCaja();
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: SucursalTipo													 	 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.SucursalTipo

DROP TABLE IF EXISTS massoftware.SucursalTipo CASCADE;

CREATE TABLE massoftware.SucursalTipo
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    numero INTEGER  NOT NULL UNIQUE CONSTRAINT SucursalTipo_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL CONSTRAINT SucursalTipo_nombre_chk CHECK (char_length(nombre) >= 2)    
);

CREATE UNIQUE INDEX u_SucursalTipo_nombre ON massoftware.SucursalTipo (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));


-- SELECT * FROM massoftware.SucursalTipo;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatSucursalTipo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatSucursalTipo() RETURNS TRIGGER AS $formatSucursalTipo$
DECLARE
BEGIN
   
	-- NEW.comentario := massoftware.white_is_null(REPLACE(TRIM(NEW.comentario), '"', ''));	
    NEW.id := massoftware.white_is_null(NEW.id);
    -- NEW.numero := massoftware.zero_is_null(NEW.numero);
    NEW.nombre := massoftware.white_is_null(NEW.nombre);    
    
	RETURN NEW;
END;
$formatSucursalTipo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatSucursalTipo ON massoftware.SucursalTipo CASCADE;

CREATE TRIGGER tgFormatSucursalTipo BEFORE INSERT OR UPDATE 
    ON massoftware.SucursalTipo FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatSucursalTipo();

-- ---------------------------------------------------------------------------------------------------------------------------

INSERT INTO massoftware.SucursalTipo(id, numero, nombre) VALUES ('1', 1, 'Centralizador');
INSERT INTO massoftware.SucursalTipo(id, numero, nombre) VALUES ('2', 2, 'Casa central');
INSERT INTO massoftware.SucursalTipo(id, numero, nombre) VALUES ('3', 3, 'Sucursal');
INSERT INTO massoftware.SucursalTipo(id, numero, nombre) VALUES ('4', 4, 'Punto de venta');

















-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: Sucursal													 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.Sucursal

DROP TABLE IF EXISTS massoftware.Sucursal CASCADE;

CREATE TABLE massoftware.Sucursal
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),
    sucursalTipo VARCHAR NOT NULL REFERENCES massoftware.SucursalTipo (id),	
    numero INTEGER  NOT NULL CONSTRAINT Sucursal_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL CONSTRAINT Sucursal_nombre_chk CHECK (char_length(nombre) >= 2),
    abreviatura VARCHAR  NOT NULL CONSTRAINT Sucursal_abreviatura_chk CHECK (char_length(nombre) >= 1),
    -- --------------------------------------------------------		
	cuentaClienteDesde VARCHAR,
	cuentaClienteHasa VARCHAR,
	cantidadCaracteresCliente INTEGER,
	identificacionNumericaCliente BOOLEAN DEFAULT false,
	permiteCambiarCliente BOOLEAN DEFAULT false,
	-- --------------------------------------------------------		
	clientesOcacionalesDesde INTEGER,
	clientesOcacionalesHasa INTEGER,
	-- --------------------------------------------------------		
	nroCobranzaDesde INTEGER,
	nroCobranzaHasa INTEGER,
	-- --------------------------------------------------------		
	proveedoresDesde VARCHAR,
	proveedoresHasa VARCHAR,
	cantidadCaracteresProveedor INTEGER,
	identificacionNumericaProveedor BOOLEAN DEFAULT false,
	permiteCambiarProveedor BOOLEAN DEFAULT false

);

CREATE UNIQUE INDEX u_Sucursal_nombre ON massoftware.Sucursal (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));


-- SELECT COUNT(*) FROM massoftware.Sucursal;
-- SELECT * FROM massoftware.Sucursal;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatSucursal() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatSucursal() RETURNS TRIGGER AS $formatSucursal$
DECLARE
BEGIN
   
	-- NEW.comentario := massoftware.white_is_null(REPLACE(TRIM(NEW.comentario), '"', ''));	
    NEW.id := massoftware.white_is_null(NEW.id);
    NEW.sucursalTipo := massoftware.white_is_null(NEW.sucursalTipo);
    -- NEW.numero := massoftware.zero_is_null(NEW.numero);
    NEW.nombre := massoftware.white_is_null(NEW.nombre); 
    NEW.abreviatura := massoftware.white_is_null(NEW.abreviatura); 
    NEW.cuentaClienteDesde := massoftware.white_is_null(NEW.cuentaClienteDesde); 
    NEW.cuentaClienteHasa := massoftware.white_is_null(NEW.cuentaClienteHasa); 
    NEW.proveedoresDesde := massoftware.white_is_null(NEW.proveedoresDesde); 
    NEW.proveedoresHasa := massoftware.white_is_null(NEW.proveedoresHasa);
    
	RETURN NEW;
END;
$formatSucursal$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatSucursal ON massoftware.Sucursal CASCADE;

CREATE TRIGGER tgFormatSucursal BEFORE INSERT OR UPDATE 
    ON massoftware.Sucursal FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatSucursal();
    
    
    
    
    
    
    
    
    
    
    
    
    

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: TalonarioLetra												 	 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.TalonarioLetra

DROP TABLE IF EXISTS massoftware.TalonarioLetra CASCADE;

CREATE TABLE massoftware.TalonarioLetra
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),      
    nombre VARCHAR  NOT NULL    
);

CREATE UNIQUE INDEX u_TalonarioLetra_nombre ON massoftware.TalonarioLetra (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));


-- SELECT * FROM massoftware.TalonarioLetra;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatTalonarioLetra() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatTalonarioLetra() RETURNS TRIGGER AS $formatTalonarioLetra$
DECLARE
BEGIN
   
	-- NEW.comentario := massoftware.white_is_null(REPLACE(TRIM(NEW.comentario), '"', ''));	
    NEW.id := massoftware.white_is_null(NEW.id);    
    NEW.nombre := massoftware.white_is_null(NEW.nombre);    
    
	RETURN NEW;
END;
$formatTalonarioLetra$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTalonarioLetra ON massoftware.TalonarioLetra CASCADE;

CREATE TRIGGER tgFormatTalonarioLetra BEFORE INSERT OR UPDATE 
    ON massoftware.TalonarioLetra FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatTalonarioLetra();

-- ---------------------------------------------------------------------------------------------------------------------------

INSERT INTO massoftware.TalonarioLetra(id, nombre) VALUES ('A', 'A');
INSERT INTO massoftware.TalonarioLetra(id, nombre) VALUES ('B', 'B');
INSERT INTO massoftware.TalonarioLetra(id, nombre) VALUES ('C', 'C');
INSERT INTO massoftware.TalonarioLetra(id, nombre) VALUES ('E', 'E');
INSERT INTO massoftware.TalonarioLetra(id, nombre) VALUES ('M', 'M');
INSERT INTO massoftware.TalonarioLetra(id, nombre) VALUES ('R', 'R');
INSERT INTO massoftware.TalonarioLetra(id, nombre) VALUES ('X', 'X');
















-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: TalonarioControladorFizcal									 	 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.TalonarioControladorFizcal

DROP TABLE IF EXISTS massoftware.TalonarioControladorFizcal CASCADE;

CREATE TABLE massoftware.TalonarioControladorFizcal
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    codigo VARCHAR  NOT NULL,    
    nombre VARCHAR  NOT NULL
);


CREATE UNIQUE INDEX u_TalonarioControladorFizcal_codigo ON massoftware.TalonarioControladorFizcal (TRANSLATE(LOWER(TRIM(codigo))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

CREATE UNIQUE INDEX u_TalonarioControladorFizcal_nombre ON massoftware.TalonarioControladorFizcal (LOWER(TRIM(nombre)));


-- SELECT * FROM massoftware.TalonarioControladorFizcal;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatTalonarioControladorFizcal() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatTalonarioControladorFizcal() RETURNS TRIGGER AS $formatTalonarioControladorFizcal$
DECLARE
BEGIN
   
	-- NEW.comentario := massoftware.white_is_null(REPLACE(TRIM(NEW.comentario), '"', ''));	
    NEW.id := massoftware.white_is_null(NEW.id);
    NEW.codigo := massoftware.white_is_null(NEW.codigo);
    NEW.nombre := massoftware.white_is_null(NEW.nombre);    
    
	RETURN NEW;
END;
$formatTalonarioControladorFizcal$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTalonarioControladorFizcal ON massoftware.TalonarioControladorFizcal CASCADE;

CREATE TRIGGER tgFormatTalonarioControladorFizcal BEFORE INSERT OR UPDATE 
    ON massoftware.TalonarioControladorFizcal FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatTalonarioControladorFizcal();

-- ---------------------------------------------------------------------------------------------------------------------------

INSERT INTO massoftware.TalonarioControladorFizcal(id, codigo, nombre) VALUES ('S', 'S', 'Sin controlador');
INSERT INTO massoftware.TalonarioControladorFizcal(id, codigo, nombre) VALUES ('H', 'H', 'Hasar SMH/P-614F');
INSERT INTO massoftware.TalonarioControladorFizcal(id, codigo, nombre) VALUES ('E', 'E', 'Epson TM-300A/F');
INSERT INTO massoftware.TalonarioControladorFizcal(id, codigo, nombre) VALUES ('W', 'W', 'WSFE');
INSERT INTO massoftware.TalonarioControladorFizcal(id, codigo, nombre) VALUES ('M', 'M', 'WSMTXCA');
INSERT INTO massoftware.TalonarioControladorFizcal(id, codigo, nombre) VALUES ('X', 'X', 'WSFEX');


















-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: Talonario	 													 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////



-- Table: massoftware.Talonario

DROP TABLE IF EXISTS massoftware.Talonario CASCADE;

CREATE TABLE massoftware.Talonario
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),    
    numero INTEGER  NOT NULL CONSTRAINT Talonario_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL CONSTRAINT Talonario_nombre_chk CHECK (char_length(nombre) >= 2),    
    talonarioLetra VARCHAR NOT NULL REFERENCES massoftware.TalonarioLetra (id),	        
	puntoVenta INTEGER  NOT NULL CONSTRAINT Talonario_puntoVenta_chk CHECK (numero > 0),
	autonumeracion BOOLEAN DEFAULT false,
	numeracionPreImpresa BOOLEAN DEFAULT false,
	asociadoRG10098 BOOLEAN DEFAULT false,
    talonarioControladorFizcal VARCHAR NOT NULL REFERENCES massoftware.TalonarioControladorFizcal (id),		
	primerNumero INTEGER  CONSTRAINT Talonario_primerNumero_chk CHECK (numero > 0),
	proximoNumero INTEGER  CONSTRAINT Talonario_proximoNumero_chk CHECK (numero > 0),
	ultimoNumero INTEGER  CONSTRAINT Talonario_ultimoNumero_chk CHECK (numero > 0),
	cantidadMinimaComprobantes INTEGER  CONSTRAINT Talonario_cantidadMinimaComprobantes_chk CHECK (numero > 0),
	fecha DATE,	
	numeroCAI NUMERIC,
	vencimiento DATE,	
    diasAvisoVencimiento INTEGER
);

CREATE UNIQUE INDEX u_Talonario_nombre ON massoftware.Talonario (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));


-- SELECT COUNT(*) FROM massoftware.Talonario;
-- SELECT * FROM massoftware.Talonario;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatTalonario() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatTalonario() RETURNS TRIGGER AS $formatTalonario$
DECLARE
BEGIN
   
	-- NEW.comentario := massoftware.white_is_null(REPLACE(TRIM(NEW.comentario), '"', ''));	
    NEW.id := massoftware.white_is_null(NEW.id);        
    NEW.nombre := massoftware.white_is_null(NEW.nombre);     
    NEW.talonarioLetra := massoftware.white_is_null(NEW.talonarioLetra);     
    NEW.talonarioControladorFizcal := massoftware.white_is_null(NEW.talonarioControladorFizcal);     
    
	RETURN NEW;
END;
$formatTalonario$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatTalonario ON massoftware.Talonario CASCADE;

CREATE TRIGGER tgFormatTalonario BEFORE INSERT OR UPDATE 
    ON massoftware.Talonario FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatTalonario();
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: Firmante															 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Firmante

DROP TABLE IF EXISTS massoftware.Firmante CASCADE;

CREATE TABLE massoftware.Firmante
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    numero INTEGER  NOT NULL UNIQUE CONSTRAINT Firmante_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL CONSTRAINT Firmante_nombre_chk CHECK (char_length(nombre) >= 2),
    cargo VARCHAR  NOT NULL,    
	bloqueado BOOLEAN DEFAULT false    
    
);

CREATE UNIQUE INDEX u_Firmante_nombre ON massoftware.Firmante (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));

-- SELECT * FROM massoftware.Firmante;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatFirmante() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatFirmante() RETURNS TRIGGER AS $formatFirmante$
DECLARE
BEGIN   

    NEW.id := massoftware.white_is_null(NEW.id);    
    NEW.nombre := massoftware.white_is_null(NEW.nombre);
    NEW.cargo := massoftware.white_is_null(NEW.cargo);    

	RETURN NEW;
END;
$formatFirmante$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatFirmante ON massoftware.Firmante CASCADE;

CREATE TRIGGER tgFormatFirmante BEFORE INSERT OR UPDATE 
    ON massoftware.Firmante FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatFirmante();











-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: Zona																 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Zona

DROP TABLE IF EXISTS massoftware.Zona CASCADE;

CREATE TABLE massoftware.Zona
(
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    codigo VARCHAR  NOT NULL,
    nombre VARCHAR  NOT NULL,
    bonificacion DOUBLE PRECISION,
	recargo DOUBLE PRECISION
    
);

CREATE UNIQUE INDEX u_Zona_codigo ON massoftware.Zona (TRANSLATE(LOWER(TRIM(codigo))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));
CREATE UNIQUE INDEX u_Zona_nombre ON massoftware.Zona (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));



-- SELECT * FROM massoftware.Zona;

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

















-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: TipoDocumentoAFIP												 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoDocumentoAFIP

DROP TABLE IF EXISTS massoftware.TipoDocumentoAFIP CASCADE;

CREATE TABLE massoftware.TipoDocumentoAFIP
(
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    numero INTEGER NOT NULL UNIQUE CONSTRAINT TipoDocumentoAFIP_numero_chk CHECK (numero > -1),
    nombre VARCHAR  NOT NULL    
    
);

CREATE UNIQUE INDEX u_TipoDocumentoAFIP_nombre ON massoftware.TipoDocumentoAFIP (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));



-- SELECT * FROM massoftware.TipoDocumentoAFIP;

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

















-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: ControlDenunciado												 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ControlDenunciado

DROP TABLE IF EXISTS massoftware.ControlDenunciado CASCADE;

CREATE TABLE massoftware.ControlDenunciado
(
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    numero INTEGER NOT NULL UNIQUE CONSTRAINT ControlDenunciados_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL    
    
);

CREATE UNIQUE INDEX u_ControlDenunciado_nombre ON massoftware.ControlDenunciado (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));



-- SELECT * FROM massoftware.ControlDenunciado;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatControlDenunciado() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatControlDenunciado() RETURNS TRIGGER AS $formatControlDenunciado$
DECLARE
BEGIN   

    NEW.id := massoftware.white_is_null(NEW.id);        
    NEW.nombre := massoftware.white_is_null(NEW.nombre);    

	RETURN NEW;
END;
$formatControlDenunciado$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatControlDenunciado ON massoftware.ControlDenunciado CASCADE;

CREATE TRIGGER tgFormatControlDenunciado BEFORE INSERT OR UPDATE 
    ON massoftware.ControlDenunciado FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatControlDenunciado();        
    
    
INSERT INTO massoftware.ControlDenunciado(id, numero, nombre) VALUES ('1', 1, 'Control numeración siempre en modelo 1');    
INSERT INTO massoftware.ControlDenunciado(id, numero, nombre) VALUES ('2', 2, 'Control numeración en el modelo del ticket');    
















-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: MarcaTicket														 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MarcaTicket

DROP TABLE IF EXISTS massoftware.MarcaTicket CASCADE;

CREATE TABLE massoftware.MarcaTicket
(
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    numero INTEGER NOT NULL UNIQUE CONSTRAINT MarcaTicket_numero_chk CHECK (numero > 0),
    nombre VARCHAR  NOT NULL,    
    fecha TIMESTAMP NOT NULL,
    cantidadPorLotes INTEGER CONSTRAINT MarcaTicket_cantidadPorLotes_chk CHECK (numero > 0),
    controlDenunciado VARCHAR NOT NULL REFERENCES massoftware.ControlDenunciado (id),	        
    valorMaximo DECIMAL(7,2) CONSTRAINT MarcaTicket_valorMaximo_chk CHECK (numero > 0)
    
);

CREATE UNIQUE INDEX u_MarcaTicket_nombre ON massoftware.MarcaTicket (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));



-- SELECT * FROM massoftware.MarcaTicket;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatMarcaTicket() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatMarcaTicket() RETURNS TRIGGER AS $formatMarcaTicket$
DECLARE
BEGIN   

    NEW.id := massoftware.white_is_null(NEW.id);        
    NEW.nombre := massoftware.white_is_null(NEW.nombre);    

	RETURN NEW;
END;
$formatMarcaTicket$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatMarcaTicket ON massoftware.MarcaTicket CASCADE;

CREATE TRIGGER tgFormatMarcaTicket BEFORE INSERT OR UPDATE 
    ON massoftware.MarcaTicket FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatMarcaTicket();              
    
    
    
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //																														 //		
-- //												TABLA: MarcaTicketModelo												 //		
-- //																														 //		
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MarcaTicketModelo

DROP TABLE IF EXISTS massoftware.MarcaTicketModelo CASCADE;

CREATE TABLE massoftware.MarcaTicketModelo
(
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),     	
    marcaTicket VARCHAR NOT NULL REFERENCES massoftware.MarcaTicket (id),		 
	numero INTEGER UNIQUE CHECK (numero > 0),
	nombre VARCHAR,	
	pruebaLectura VARCHAR,	
	identificacionPosicion INTEGER CHECK (identificacionPosicion > 0),	
	identificacionIdentificacion VARCHAR,	
	importePosicion INTEGER CHECK (importePosicion > 0),	
	importeLongitud INTEGER CHECK (importeLongitud > 0),	
	importeCantidadDecimales INTEGER CHECK (importeCantidadDecimales > 0),	
	numeroPosicion INTEGER CHECK (numeroPosicion > 0),	
	numeroLongitud INTEGER CHECK (numeroLongitud > 0),	
	prefijoIdentificacionImportacion VARCHAR,	
	prefijoPosicion INTEGER CHECK (prefijoPosicion > 0),	
	bloqueado BOOLEAN DEFAULT false   
    
);
            
CREATE UNIQUE INDEX u_MarcaTicketModelo_nombre ON massoftware.MarcaTicketModelo (TRANSLATE(LOWER(TRIM(nombre))
            , '/\"'';,_-.âãäåāăąàáÁÂÃÄÅĀĂĄÀèééêëēĕėęěĒĔĖĘĚÉÈËÊìíîïìĩīĭÌÍÎÏÌĨĪĬóôõöōŏőòÒÓÔÕÖŌŎŐùúûüũūŭůÙÚÛÜŨŪŬŮçÇñÑ'
            , '         aaaaaaaaaAAAAAAAAAeeeeeeeeeeEEEEEEEEEiiiiiiiiIIIIIIIIooooooooOOOOOOOOuuuuuuuuUUUUUUUUcCnN' ));
            

-- SELECT * FROM massoftware.MarcaTicketModelo;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatMarcaTicketModelo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatMarcaTicketModelo() RETURNS TRIGGER AS $formatMarcaTicketModelo$
DECLARE
BEGIN
   
	
    NEW.id := massoftware.white_is_null(NEW.id);
    NEW.marcaTicket := massoftware.white_is_null(NEW.marcaTicket);
    NEW.nombre := massoftware.white_is_null(NEW.nombre);
    NEW.pruebaLectura := massoftware.white_is_null(NEW.pruebaLectura);
    NEW.identificacionIdentificacion := massoftware.white_is_null(NEW.identificacionIdentificacion);
    NEW.prefijoIdentificacionImportacion := massoftware.white_is_null(NEW.prefijoIdentificacionImportacion);

	RETURN NEW;
END;
$formatMarcaTicketModelo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatMarcaTicketModelo ON massoftware.MarcaTicketModelo CASCADE;

CREATE TRIGGER tgFormatMarcaTicketModelo BEFORE INSERT OR UPDATE 
    ON massoftware.MarcaTicketModelo FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatMarcaTicketModelo();
    
    
    
    
    
    
    
    
    



















-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////    

-- ==========================================================================================================================
-- ==========================================================================================================================
-- ==========================================================================================================================
-- =======================																				=====================
-- =======================				TABLAS y TRIGGERS												=====================	
-- =======================																				=====================
-- ==========================================================================================================================
-- ==========================================================================================================================
-- ==========================================================================================================================
/*

-- Table: massoftware.EjercicioContable

DROP TABLE IF EXISTS massoftware.EjercicioContable CASCADE;

CREATE TABLE massoftware.EjercicioContable
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    ejercicio INTEGER  NOT NULL UNIQUE,
    fechaApertura DATE NOT NULL,
    fechaCierre DATE NOT NULL,
    ejercicioCerrado BOOLEAN NOT NULL DEFAULT false,
    ejercicioCerradoModulos BOOLEAN NOT NULL DEFAULT false,
    comentario VARCHAR                    
);

-- SELECT * FROM massoftware.EjercicioContable;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatEjercicioContable() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatEjercicioContable() RETURNS TRIGGER AS $formatEjercicioContable$
DECLARE
BEGIN
   
	-- NEW.comentario := massoftware.white_is_null(REPLACE(TRIM(NEW.comentario), '"', ''));	
    NEW.comentario := massoftware.white_is_null(TRIM(NEW.comentario));

	RETURN NEW;
END;
$formatEjercicioContable$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatEjercicioContable ON massoftware.EjercicioContable CASCADE;

CREATE TRIGGER tgFormatEjercicioContable BEFORE INSERT OR UPDATE 
    ON massoftware.EjercicioContable FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatEjercicioContable();
    



-- ==========================================================================================================================

-- Table: massoftware.CentroDeCostoContable

DROP TABLE IF EXISTS massoftware.CentroDeCostoContable CASCADE;

CREATE TABLE massoftware.CentroDeCostoContable
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),  
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    ejercicioContable VARCHAR NOT NULL REFERENCES massoftware.EjercicioContable (id),	
    numero INTEGER NOT NULL,
    nombre VARCHAR,
    abreviatura VARCHAR
);

CREATE UNIQUE INDEX u_CentroDeCostoContable_ejercicioContable_centroDeCostoContable ON massoftware.CentroDeCostoContable (ejercicioContable, numero);

-- SELECT * FROM massoftware.CentroDeCostoContable;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCentroDeCostoContable() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCentroDeCostoContable() RETURNS TRIGGER AS $formatCentroDeCostoContable$
DECLARE
BEGIN
   
	-- NEW.nombre := massoftware.white_is_null(REPLACE(TRIM(NEW.nombre), '"', ''));	
    NEW.nombre := massoftware.white_is_null(TRIM(NEW.nombre));	
    -- NEW.abreviatura := massoftware.white_is_null(REPLACE(TRIM(NEW.abreviatura), '"', ''));	
    NEW.abreviatura := massoftware.white_is_null(TRIM(NEW.abreviatura));	

	RETURN NEW;
END;
$formatCentroDeCostoContable$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatCentroDeCostoContable ON massoftware.CentroDeCostoContable CASCADE;

CREATE TRIGGER tgFormatCentroDeCostoContable BEFORE INSERT OR UPDATE 
    ON massoftware.CentroDeCostoContable FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatCentroDeCostoContable();

-- ==========================================================================================================================

-- Table: massoftware.PuntoDeEquilibrioTipo

DROP TABLE IF EXISTS massoftware.PuntoDeEquilibrioTipo CASCADE;

CREATE TABLE massoftware.PuntoDeEquilibrioTipo
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),          
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),          
    codigo INTEGER NOT NULL,
    nombre VARCHAR NOT NULL
);	

CREATE UNIQUE INDEX u_PuntoDeEquilibrioTipo_codigo ON massoftware.PuntoDeEquilibrioTipo (codigo);
CREATE UNIQUE INDEX u_PuntoDeEquilibrioTipo_nombre ON massoftware.PuntoDeEquilibrioTipo (LOWER(TRIM(nombre)));

-- SELECT * FROM massoftware.PuntoDeEquilibrioTipo;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatPuntoDeEquilibrioTipo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatPuntoDeEquilibrioTipo() RETURNS TRIGGER AS $formatPuntoDeEquilibrioTipo$
DECLARE
BEGIN
   
	NEW.nombre := massoftware.white_is_null(TRIM(NEW.nombre));	    

	RETURN NEW;
END;
$formatPuntoDeEquilibrioTipo$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatPuntoDeEquilibrioTipo ON massoftware.PuntoDeEquilibrioTipo CASCADE;

CREATE TRIGGER tgFormatPuntoDeEquilibrioTipo BEFORE INSERT OR UPDATE 
    ON massoftware.PuntoDeEquilibrioTipo FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatPuntoDeEquilibrioTipo();

-- ---------------------------------------------------------------------------------------------------------------------------
    
-- INSERT INTO massoftware.puntodeequilibriotipo(id, tipo, nombre)	VALUES ('1', 1, 'Individual');
-- INSERT INTO massoftware.puntodeequilibriotipo(id, tipo, nombre)	VALUES ('2', 2, 'Costo de ventas');
-- INSERT INTO massoftware.puntodeequilibriotipo(id, tipo, nombre)	VALUES ('3', 3, 'Utilidad bruta');
-- INSERT INTO massoftware.puntodeequilibriotipo(id, tipo, nombre)	VALUES ('4', 4, 'Resultados por sección');
-- INSERT INTO massoftware.puntodeequilibriotipo(id, tipo, nombre)	VALUES ('5', 5, 'Resultados operativos');    

-- SELECT * FROM massoftware.PuntoDeEquilibrioTipo;

-- ==========================================================================================================================
	
-- Table: massoftware.PuntoDeEquilibrio

DROP TABLE IF EXISTS massoftware.PuntoDeEquilibrio CASCADE;

CREATE TABLE massoftware.PuntoDeEquilibrio
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),      
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),      
    ejercicioContable VARCHAR NOT NULL REFERENCES massoftware.EjercicioContable (id),	
    puntoDeEquilibrio INTEGER NOT NULL, -- numero
    nombre VARCHAR NOT NULL,
    -- tipo INTEGER NOT NULL DEFAULT 1 --PuntoDeEquilibrioTipo                       
    puntoDeEquilibrioTipo VARCHAR NOT NULL REFERENCES massoftware.PuntoDeEquilibrioTipo (id)	
);	

CREATE UNIQUE INDEX u_PuntoDeEquilibrio_ejercicioContable_puntoDeEquilibrio ON massoftware.PuntoDeEquilibrio (ejercicioContable, puntoDeEquilibrio);

-- SELECT * FROM massoftware.PuntoDeEquilibrio;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatPuntoDeEquilibrio() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatPuntoDeEquilibrio() RETURNS TRIGGER AS $formatPuntoDeEquilibrio$
DECLARE
BEGIN
   
	-- NEW.nombre := massoftware.white_is_null(REPLACE(TRIM(NEW.nombre), '"', ''));	
    NEW.nombre := massoftware.white_is_null(TRIM(NEW.nombre));	
    -- NEW.abreviatura := massoftware.white_is_null(REPLACE(TRIM(NEW.abreviatura), '"', ''));	
    -- NEW.abreviatura := massoftware.white_is_null(TRIM(NEW.abreviatura));	

	RETURN NEW;
END;
$formatPuntoDeEquilibrio$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatPuntoDeEquilibrio ON massoftware.PuntoDeEquilibrio CASCADE;

CREATE TRIGGER tgFormatPuntoDeEquilibrio BEFORE INSERT OR UPDATE 
    ON massoftware.PuntoDeEquilibrio FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatPuntoDeEquilibrio();


-- ==========================================================================================================================

-- Table: massoftware.PlanDeCuentaEstado

DROP TABLE IF EXISTS massoftware.PlanDeCuentaEstado CASCADE;

CREATE TABLE massoftware.PlanDeCuentaEstado
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),          
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),          
    codigo INTEGER NOT NULL,
    nombre VARCHAR NOT NULL
);	

CREATE UNIQUE INDEX u_PlanDeCuentaEstado_codigo ON massoftware.PlanDeCuentaEstado (codigo);
CREATE UNIQUE INDEX u_PlanDeCuentaEstado_nombre ON massoftware.PlanDeCuentaEstado (LOWER(TRIM(nombre)));

-- SELECT * FROM massoftware.PlanDeCuentaEstado;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatPlanDeCuentaEstado() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatPlanDeCuentaEstado() RETURNS TRIGGER AS $formatPlanDeCuentaEstado$
DECLARE
BEGIN
   
	NEW.nombre := massoftware.white_is_null(TRIM(NEW.nombre));	    

	RETURN NEW;
END;
$formatPlanDeCuentaEstado$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatPlanDeCuentaEstado ON massoftware.PlanDeCuentaEstado CASCADE;

CREATE TRIGGER tgFormatPlanDeCuentaEstado BEFORE INSERT OR UPDATE 
    ON massoftware.PlanDeCuentaEstado FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatPlanDeCuentaEstado();
    
    
-- SELECT * FROM massoftware.PlanDeCuentaEstado;    

-- ==========================================================================================================================

-- Table: massoftware.CostoDeVenta

DROP TABLE IF EXISTS massoftware.CostoDeVenta CASCADE;

CREATE TABLE massoftware.CostoDeVenta
(
    -- id VARCHAR NOT NULL PRIMARY KEY DEFAULT uuid_generate_v4(),          
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),          
    codigo INTEGER NOT NULL,
    nombre VARCHAR NOT NULL
);	

CREATE UNIQUE INDEX u_CostoDeVenta_codigo ON massoftware.CostoDeVenta (codigo);
CREATE UNIQUE INDEX u_CostoDeVenta_nombre ON massoftware.CostoDeVenta (LOWER(TRIM(nombre)));

-- SELECT * FROM massoftware.CostoDeVenta;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatCostoDeVenta() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatCostoDeVenta() RETURNS TRIGGER AS $formatCostoDeVenta$
DECLARE
BEGIN
   
	NEW.nombre := massoftware.white_is_null(TRIM(NEW.nombre));	    

	RETURN NEW;
END;
$formatCostoDeVenta$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormaCostoDeVenta ON massoftware.CostoDeVenta CASCADE;

CREATE TRIGGER tgFormatCostoDeVenta BEFORE INSERT OR UPDATE 
    ON massoftware.CostoDeVenta FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatCostoDeVenta();
    
    
-- SELECT * FROM massoftware.CostoDeVenta;    

-- ==========================================================================================================================

-- Table: massoftware.PlanDeCuenta

DROP TABLE IF EXISTS massoftware.PlanDeCuenta CASCADE;

CREATE TABLE massoftware.PlanDeCuenta
(
    id VARCHAR PRIMARY KEY DEFAULT uuid_generate_v4(),  
    -- -----------------------------------------------------------------------------------
    ejercicioContable VARCHAR NOT NULL REFERENCES massoftware.EjercicioContable (id),	
    -- -----------------------------------------------------------------------------------
    codigoCuentaPadre VARCHAR  NOT NULL, -- integra
	codigoCuenta VARCHAR  NOT NULL,	-- cuentaDeJerarquia    
    cuentaContable VARCHAR NOT NULL,    
	nombre VARCHAR NOT NULL,
    -- -----------------------------------------------------------------------------------
	imputable BOOLEAN NOT NULL DEFAULT false,
    ajustaPorInflacion BOOLEAN NOT NULL DEFAULT false,
    planDeCuentaEstado VARCHAR NOT NULL REFERENCES massoftware.PlanDeCuentaEstado (id), -- PlanDeCuentaEstado
	cuentaConApropiacion BOOLEAN NOT NULL DEFAULT false,	
	centroDeCostoContable VARCHAR REFERENCES massoftware.CentroDeCostoContable (id),
	cuentaAgrupadora VARCHAR, -- aca va cualquier texto, texto libre
	porcentaje DOUBLE PRECISION NOT NULL DEFAULT 0.0,
	puntoDeEquilibrio VARCHAR REFERENCES massoftware.PuntoDeEquilibrio (id),
    costoDeVenta VARCHAR REFERENCES massoftware.CostoDeVenta (id)	
);	

CREATE UNIQUE INDEX u_PlanDeCuenta_ejercicioContable_codigoCuenta ON massoftware.PlanDeCuenta (ejercicioContable, LOWER(TRIM(codigoCuenta)));
CREATE UNIQUE INDEX u_PlanDeCuenta_ejercicioContable_codigoCuentaPadre_codigoCuenta ON massoftware.PlanDeCuenta (ejercicioContable, LOWER(TRIM(codigoCuentaPadre)), LOWER(TRIM(codigoCuenta)));
CREATE UNIQUE INDEX u_PlanDeCuenta_ejercicioContable_cuentaContable ON massoftware.PlanDeCuenta (ejercicioContable, LOWER(TRIM(cuentaContable)));
-- CREATE UNIQUE INDEX u_PlanDeCuenta_ejercicioContable_nombre ON massoftware.PlanDeCuenta (ejercicioContable, LOWER(TRIM(nombre)));
CREATE UNIQUE INDEX u_PlanDeCuenta_ejercicioContable_codigoCuenta_nombre ON massoftware.PlanDeCuenta (ejercicioContable, LOWER(TRIM(codigoCuenta)), LOWER(TRIM(nombre)));

-- ---------------------------------------------------------------------------------------------------------------------------

DROP FUNCTION IF EXISTS massoftware.ftgFormatPlanDeCuenta() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.ftgFormatPlanDeCuenta() RETURNS TRIGGER AS $formatPlanDeCuenta$
DECLARE
BEGIN
   
	NEW.codigoCuentaPadre := massoftware.white_is_null(REPLACE(TRIM(NEW.codigoCuentaPadre), '"', ''));	
    NEW.codigoCuenta := massoftware.white_is_null(REPLACE(TRIM(NEW.codigoCuenta), '"', ''));	
    NEW.cuentaContable := massoftware.white_is_null(REPLACE(TRIM(NEW.cuentaContable), '"', ''));
    NEW.nombre := massoftware.white_is_null(REPLACE(TRIM(NEW.nombre), '"', ''));	    
    NEW.cuentaAgrupadora := massoftware.white_is_null(REPLACE(TRIM(NEW.cuentaAgrupadora), '"', ''));

	RETURN NEW;
END;
$formatPlanDeCuenta$ LANGUAGE plpgsql;

-- ---------------------------------------------------------------------------------------------------------------------------

DROP TRIGGER IF EXISTS tgFormatPlanDeCuenta ON massoftware.PlanDeCuenta CASCADE;

CREATE TRIGGER tgFormatPlanDeCuenta BEFORE INSERT OR UPDATE 
    ON massoftware.PlanDeCuenta FOR EACH ROW 
    EXECUTE PROCEDURE massoftware.ftgFormatPlanDeCuenta();

-- SELECT * FROM massoftware.PlanDeCuenta;



-- ==========================================================================================================================

-- ==========================================================================================================================
-- ==========================================================================================================================
-- ==========================================================================================================================
-- =======================																				=====================
-- =======================				VISTAS 															=====================	
-- =======================																				=====================
-- ==========================================================================================================================
-- ==========================================================================================================================
-- ==========================================================================================================================


DROP VIEW IF EXISTS massoftware.vEjercicioContable CASCADE; 

CREATE OR REPLACE VIEW massoftware.vEjercicioContable AS

	SELECT	'com.massoftware.model.EjercicioContable' AS ClassEjercicioContable
			,id
			,ejercicio
			,comentario
			,fechaApertura
			,fechaCierre
			,ejercicioCerrado
			,ejercicioCerradoModulos
	FROM	massoftware.EjercicioContable;
    
-- SELECT * FROM massoftware.vEjercicioContable ORDER BY ejercicio DESC;            
    
-- ==========================================================================================================================

DROP VIEW IF EXISTS massoftware.vUsuario CASCADE; 

CREATE OR REPLACE VIEW massoftware.vUsuario AS

	 SELECT	'com.massoftware.model.Usuario' AS ClassUsuario
			,Usuario.id
			,Usuario.numero
			,Usuario.nombre			
            	,vEjercicioContable.id AS ejercicioContable_id		
				,vEjercicioContable.ejercicio AS ejercicioContable_ejercicio		
				,vEjercicioContable.fechaApertura AS ejercicioContable_fechaApertura
				,vEjercicioContable.fechaCierre AS ejercicioContable_fechaCierre
				,vEjercicioContable.ejercicioCerrado AS ejercicioContable_ejercicioCerrado
				,vEjercicioContable.ejercicioCerradoModulos AS ejercicioContable_ejercicioCerradoModulos
				,vEjercicioContable.comentario AS ejercicioContable_comentario
	FROM	massoftware.Usuario
	LEFT JOIN	massoftware.vEjercicioContable 
		ON vEjercicioContable.id = Usuario.ejercicioContable;
        
-- SELECT * FROM massoftware.vUsuario; 

-- ==========================================================================================================================

DROP VIEW IF EXISTS massoftware.vCentroDeCostoContable CASCADE; 

CREATE OR REPLACE VIEW massoftware.vCentroDeCostoContable AS

	 SELECT	'com.massoftware.model.CentroDeCostoContable' AS ClassCentroDeCostoContable
			,CentroDeCostoContable.id
			,CentroDeCostoContable.numero 
			,CentroDeCostoContable.nombre			
            ,CentroDeCostoContable.abreviatura
            	,vEjercicioContable.id AS ejercicioContable_id		
				,vEjercicioContable.ejercicio AS ejercicioContable_ejercicio		
				,vEjercicioContable.fechaApertura AS ejercicioContable_fechaApertura
				,vEjercicioContable.fechaCierre AS ejercicioContable_fechaCierre
				,vEjercicioContable.ejercicioCerrado AS ejercicioContable_ejercicioCerrado
				,vEjercicioContable.ejercicioCerradoModulos AS ejercicioContable_ejercicioCerradoModulos
				,vEjercicioContable.comentario AS ejercicioContable_comentario
	FROM	massoftware.CentroDeCostoContable
	LEFT JOIN	massoftware.vEjercicioContable 
		ON vEjercicioContable.id = CentroDeCostoContable.ejercicioContable;

--  SELECT * FROM massoftware.vCentroDeCostoContable; 

-- ==========================================================================================================================

DROP VIEW IF EXISTS massoftware.vPuntoDeEquilibrioTipo CASCADE; 

CREATE OR REPLACE VIEW massoftware.vPuntoDeEquilibrioTipo AS                                   

	 SELECT	'com.massoftware.model.PuntoDeEquilibrioTipo' AS ClassPuntoDeEquilibrioTipo
			,PuntoDeEquilibrioTipo.id            	
			,PuntoDeEquilibrioTipo.codigo 
			,PuntoDeEquilibrioTipo.nombre	                                    	
	FROM	massoftware.PuntoDeEquilibrioTipo;

--  SELECT * FROM massoftware.vPuntoDeEquilibrioTipo; 

-- ==========================================================================================================================

DROP VIEW IF EXISTS massoftware.vPuntoDeEquilibrio CASCADE; 

CREATE OR REPLACE VIEW massoftware.vPuntoDeEquilibrio AS                                   

	 SELECT	'com.massoftware.model.PuntoDeEquilibrio' AS ClassPuntoDeEquilibrio
			,PuntoDeEquilibrio.id
            	,vEjercicioContable.id AS ejercicioContable_id		
				,vEjercicioContable.ejercicio AS ejercicioContable_ejercicio		
				,vEjercicioContable.fechaApertura AS ejercicioContable_fechaApertura
				,vEjercicioContable.fechaCierre AS ejercicioContable_fechaCierre
				,vEjercicioContable.ejercicioCerrado AS ejercicioContable_ejercicioCerrado
				,vEjercicioContable.ejercicioCerradoModulos AS ejercicioContable_ejercicioCerradoModulos
				,vEjercicioContable.comentario AS ejercicioContable_comentario
			,PuntoDeEquilibrio.puntoDeEquilibrio 
			,PuntoDeEquilibrio.nombre	           
            	,vPuntoDeEquilibrioTipo.id AS puntoDeEquilibrioTipo_id		
				,vPuntoDeEquilibrioTipo.codigo AS puntoDeEquilibrioTipo_codigo	
				,vPuntoDeEquilibrioTipo.nombre AS puntoDeEquilibrioTipo_nombre            	
	FROM	massoftware.PuntoDeEquilibrio
	LEFT JOIN	massoftware.vEjercicioContable 
		ON vEjercicioContable.id = PuntoDeEquilibrio.ejercicioContable
    LEFT JOIN	massoftware.vPuntoDeEquilibrioTipo 
		ON vPuntoDeEquilibrioTipo.id = PuntoDeEquilibrio.puntoDeEquilibrioTipo;    

-- SELECT * FROM massoftware.vPuntoDeEquilibrio; 
-- SELECT * FROM massoftware.PuntoDeEquilibrio; 
-- SELECT * FROM massoftware.vPuntoDeEquilibrioTipo; 

-- ==========================================================================================================================

DROP VIEW IF EXISTS massoftware.vPlanDeCuentaEstado CASCADE; 

CREATE OR REPLACE VIEW massoftware.vPlanDeCuentaEstado AS                                   

	 SELECT	'com.massoftware.model.PlanDeCuentaEstado' AS ClassPlanDeCuentaEstado
			,PlanDeCuentaEstado.id            	
			,PlanDeCuentaEstado.codigo 
			,PlanDeCuentaEstado.nombre	                                    	
	FROM	massoftware.PlanDeCuentaEstado;

--  SELECT * FROM massoftware.vPlanDeCuentaEstado; 
	
-- ==========================================================================================================================

DROP VIEW IF EXISTS massoftware.vCostoDeVenta CASCADE; 

CREATE OR REPLACE VIEW massoftware.vCostoDeVenta AS                                   

	 SELECT	'com.massoftware.model.CostoDeVenta' AS ClassCostoDeVenta
			,CostoDeVenta.id            	
			,CostoDeVenta.codigo 
			,CostoDeVenta.nombre	                                    	
	FROM	massoftware.CostoDeVenta;

--  SELECT * FROM massoftware.vCostoDeVenta; 

-- ==========================================================================================================================

DROP VIEW IF EXISTS massoftware.vPlanDeCuenta CASCADE; 

CREATE OR REPLACE VIEW massoftware.vPlanDeCuenta AS                                   
	

	SELECT	'com.massoftware.model.PlanDeCuenta' AS ClassPlanDeCuenta	
			-----------------------------------------------------------------------------------------------------
			, PlanDeCuenta.id			
			-----------------------------------------------------------------------------------------------------
			, vEjercicioContable.id AS ejercicioContable_id		
				, vEjercicioContable.ejercicio AS ejercicioContable_ejercicio		
				, vEjercicioContable.fechaApertura AS ejercicioContable_fechaApertura
				, vEjercicioContable.fechaCierre AS ejercicioContable_fechaCierre
				, vEjercicioContable.ejercicioCerrado AS ejercicioContable_ejercicioCerrado
				, vEjercicioContable.ejercicioCerradoModulos AS ejercicioContable_ejercicioCerradoModulos
				, vEjercicioContable.comentario AS ejercicioContable_comentario
			-----------------------------------------------------------------------------------------------------			
			, PlanDeCuenta.codigoCuentaPadre -- integra ej 6.40.00.00.00.00
			, PlanDeCuenta.codigoCuenta -- integra ej 6.40.00.00.00.10
			, PlanDeCuenta.cuentaContable -- TEXTO LIBRE
			, PlanDeCuenta.nombre -- TEXTO LIBRE
			-----------------------------------------------------------------------------------------------------
			, PlanDeCuenta.imputable
			, PlanDeCuenta.ajustaPorInflacion
			-----------------------------------------------------------------------------------------------------			
			, vPlanDeCuentaEstado.id  AS planDeCuentaEstado_id			
				, vPlanDeCuentaEstado.codigo AS planDeCuentaEstado_codigo
				, vPlanDeCuentaEstado.nombre AS planDeCuentaEstado_nombre
			-----------------------------------------------------------------------------------------------------
			, PlanDeCuenta.cuentaConApropiacion
			-----------------------------------------------------------------------------------------------------
			, vCentroDeCostoContable.id  AS centroDeCostoContable_id			
				, vCentroDeCostoContable.numero AS centroDeCostoContable_numero
				, vCentroDeCostoContable.nombre AS centroDeCostoContable_nombre
				, vCentroDeCostoContable.abreviatura AS centroDeCostoContable_abreviatura
					-----------------------------------------------------------------------------------------------------
					, vCentroDeCostoContable.ejercicioContable_id AS centroDeCostoContable_ejercicioContable_id		
					, vCentroDeCostoContable.ejercicioContable_ejercicio	AS centroDeCostoContable_ejercicioContable_ejercicio	
					, vCentroDeCostoContable.ejercicioContable_fechaApertura AS centroDeCostoContable_ejercicioContable_fechaApertura		
					, vCentroDeCostoContable.ejercicioContable_fechaCierre AS centroDeCostoContable_ejercicioContable_fechaCierre
					, vCentroDeCostoContable.ejercicioContable_ejercicioCerrado AS centroDeCostoContable_ejercicioContable_ejercicioCerrado		
					, vCentroDeCostoContable.ejercicioContable_ejercicioCerradoModulos AS centroDeCostoContable_ejercicioContable_ejercicioCerradoModulos	
					, vCentroDeCostoContable.ejercicioContable_comentario AS centroDeCostoContable_ejercicioContable_comentario		
			-----------------------------------------------------------------------------------------------------
			, PlanDeCuenta.cuentaAgrupadora -- TEXTO LIBRE
			, PlanDeCuenta.porcentaje
			-----------------------------------------------------------------------------------------------------
			, vPuntoDeEquilibrio.id AS puntoDeEquilibrio_id
					-----------------------------------------------------------------------------------------------------
					, vPuntoDeEquilibrio.ejercicioContable_id AS puntoDeEquilibrio_ejercicioContable_id		
					, vPuntoDeEquilibrio.ejercicioContable_ejercicio	AS puntoDeEquilibrio_ejercicioContable_ejercicio	
					, vPuntoDeEquilibrio.ejercicioContable_fechaApertura AS puntoDeEquilibrio_ejercicioContable_fechaApertura		
					, vPuntoDeEquilibrio.ejercicioContable_fechaCierre AS puntoDeEquilibrio_ejercicioContable_fechaCierre
					, vPuntoDeEquilibrio.ejercicioContable_ejercicioCerrado AS puntoDeEquilibrio_ejercicioContable_ejercicioCerrado		
					, vPuntoDeEquilibrio.ejercicioContable_ejercicioCerradoModulos AS puntoDeEquilibrio_ejercicioContable_ejercicioCerradoModulos	
					, vPuntoDeEquilibrio.ejercicioContable_comentario AS puntoDeEquilibrio_ejercicioContable_comentario
					-----------------------------------------------------------------------------------------------------		
                , vPuntoDeEquilibrio.puntoDeEquilibrio AS puntoDeEquilibrio_puntoDeEquilibrio
                , vPuntoDeEquilibrio.nombre AS puntoDeEquilibrio_nombre
				-----------------------------------------------------------------------------------------------------								
				, vPuntoDeEquilibrio.puntoDeEquilibrioTipo_id AS puntoDeEquilibrio_puntoDeEquilibrioTipo_id				
				, vPuntoDeEquilibrio.puntoDeEquilibrioTipo_codigo AS puntoDeEquilibrio_puntoDeEquilibrioTipo_codigo
				, vPuntoDeEquilibrio.puntoDeEquilibrioTipo_nombre AS puntoDeEquilibrio_puntoDeEquilibrioTipo_nombre 
			-----------------------------------------------------------------------------------------------------
			,vCostoDeVenta.id  AS costoDeVenta_id			
				,vCostoDeVenta.codigo AS costoDeVenta_codigo
				,vCostoDeVenta.nombre AS costoDeVenta_nombre
			-----------------------------------------------------------------------------------------------------
			
			
	FROM massoftware.PlanDeCuenta
	LEFT JOIN	massoftware.vEjercicioContable
			ON		vEjercicioContable.id = PlanDeCuenta.ejercicioContable
	LEFT JOIN	massoftware.vPlanDeCuentaEstado
			ON		vPlanDeCuentaEstado.id = PlanDeCuenta.planDeCuentaEstado
	LEFT JOIN	massoftware.vCentroDeCostoContable
			ON		vCentroDeCostoContable.id = PlanDeCuenta.centroDeCostoContable 
			AND		vCentroDeCostoContable.ejercicioContable_id = PlanDeCuenta.ejercicioContable 
	LEFT JOIN	massoftware.vPuntoDeEquilibrio
			ON		vPuntoDeEquilibrio.id = PlanDeCuenta.puntoDeEquilibrio
			AND		vPuntoDeEquilibrio.ejercicioContable_id = PlanDeCuenta.ejercicioContable 
	LEFT JOIN	massoftware.vCostoDeVenta
			ON		vCostoDeVenta.id = PlanDeCuenta.costoDeVenta;
*/	

	-- SELECT * FROM massoftware.PlanDeCuenta ;
	-- SELECT * FROM massoftware.vPlanDeCuenta ;
	-- SELECT * FROM massoftware.vPlanDeCuenta ORDER BY ejercicioContable_ejercicio DESC, codigoCuenta;	
    /*
        SELECT 	centroDeCostoContable_id			
                    , centroDeCostoContable_numero
                    , centroDeCostoContable_nombre
                    , centroDeCostoContable_abreviatura
                        -----------------------------------------------------------------------------------------------------
                        , centroDeCostoContable_ejercicioContable_id		
                        , centroDeCostoContable_ejercicioContable_ejercicio	
                        , centroDeCostoContable_ejercicioContable_fechaApertura		
                        , centroDeCostoContable_ejercicioContable_fechaCierre
                        , centroDeCostoContable_ejercicioContable_ejercicioCerrado		
                        , centroDeCostoContable_ejercicioContable_ejercicioCerradoModulos	
                        , centroDeCostoContable_ejercicioContable_comentario 
        FROM 	massoftware.vPlanDeCuenta 
        WHERE  	ejercicioContable_ejercicio = 2013 
        ORDER BY ejercicioContable_ejercicio DESC, codigoCuenta;	
    */
    
    