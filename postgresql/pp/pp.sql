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