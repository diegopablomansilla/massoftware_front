
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

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_exists_EjercicioContable_numero(numeroArg INTEGER) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_exists_EjercicioContable_numero(numeroArg INTEGER) RETURNS BOOLEAN  AS $$

	SELECT (COUNT(*) > 0)::BOOLEAN FROM massoftware.EjercicioContable
	WHERE	(numeroArg IS NULL OR EjercicioContable.numero = numeroArg);

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_exists_EjercicioContable_numero(null::INTEGER);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_EjercicioContable_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_EjercicioContable_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.EjercicioContable;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_EjercicioContable_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_EjercicioContableById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_EjercicioContableById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.EjercicioContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND EjercicioContable.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.EjercicioContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND EjercicioContable.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.EjercicioContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND EjercicioContable.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_EjercicioContableById('xxx');

-- SELECT * FROM massoftware.d_EjercicioContableById((SELECT EjercicioContable.id FROM massoftware.EjercicioContable LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_EjercicioContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, aperturaArg DATE
		, cierreArg DATE
		, cerradoArg BOOLEAN
		, cerradoModulosArg BOOLEAN
		, comentarioArg VARCHAR(250)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_EjercicioContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, aperturaArg DATE
		, cierreArg DATE
		, cerradoArg BOOLEAN
		, cerradoModulosArg BOOLEAN
		, comentarioArg VARCHAR(250)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF cerradoArg IS NULL THEN

		cerradoArg = false;

	END IF;

	IF cerradoModulosArg IS NULL THEN

		cerradoModulosArg = false;

	END IF;

	INSERT INTO massoftware.EjercicioContable(id, numero, apertura, cierre, cerrado, cerradoModulos, comentario) VALUES (idArg, numeroArg, aperturaArg, cierreArg, cerradoArg, cerradoModulosArg, comentarioArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.EjercicioContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND EjercicioContable.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_EjercicioContable(
		null::VARCHAR(36)
		, null::INTEGER
		, null::DATE
		, null::DATE
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(250)
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_EjercicioContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, aperturaArg DATE
		, cierreArg DATE
		, cerradoArg BOOLEAN
		, cerradoModulosArg BOOLEAN
		, comentarioArg VARCHAR(250)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_EjercicioContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, aperturaArg DATE
		, cierreArg DATE
		, cerradoArg BOOLEAN
		, cerradoModulosArg BOOLEAN
		, comentarioArg VARCHAR(250)
) RETURNS BOOLEAN AS $$

BEGIN

	IF cerradoArg IS NULL THEN

		cerradoArg = false;

	END IF;

	IF cerradoModulosArg IS NULL THEN

		cerradoModulosArg = false;

	END IF;

	UPDATE massoftware.EjercicioContable SET 
		  numero = numeroArg
		, apertura = aperturaArg
		, cierre = cierreArg
		, cerrado = cerradoArg
		, cerradoModulos = cerradoModulosArg
		, comentario = comentarioArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND EjercicioContable.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.EjercicioContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND EjercicioContable.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_EjercicioContable(
		null::VARCHAR(36)
		, null::INTEGER
		, null::DATE
		, null::DATE
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(250)
);

*/

DROP FUNCTION IF EXISTS massoftware.f_EjercicioContable (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_EjercicioContable (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4
	, numeroFromArg5    INTEGER    	-- 5
	, numeroToArg6      INTEGER    	-- 6

) RETURNS SETOF massoftware.EjercicioContable AS $$

DECLARE

	sqlSrc TEXT = '';
	sqlSrcWhere TEXT = '';
	sqlSrcWhereCount INTEGER = 0;
	sqlSrcWhereCountOR INTEGER = 0;
	searchById BOOLEAN = false;
	words TEXT[];
	word TEXT = '';

BEGIN


	sqlSrc = '

		SELECT
				  EjercicioContable.id                AS EjercicioContable_id            	-- 0	.id           		VARCHAR(36)
				, EjercicioContable.numero            AS EjercicioContable_numero        	-- 1	.numero       		INTEGER
				, EjercicioContable.apertura          AS EjercicioContable_apertura      	-- 2	.apertura     		DATE
				, EjercicioContable.cierre            AS EjercicioContable_cierre        	-- 3	.cierre       		DATE
				, EjercicioContable.cerrado           AS EjercicioContable_cerrado       	-- 4	.cerrado      		BOOLEAN
				, EjercicioContable.cerradoModulos    AS EjercicioContable_cerradoModulos	-- 5	.cerradoModulos		BOOLEAN
				, EjercicioContable.comentario        AS EjercicioContable_comentario    	-- 6	.comentario   		VARCHAR(250)

		FROM	massoftware.EjercicioContable

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' EjercicioContable.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
	END IF;

	IF searchById = false AND numeroFromArg5 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' EjercicioContable.numero >= ' || numeroFromArg5;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF searchById = false AND numeroToArg6 IS NOT NULL THEN
		IF sqlSrcWhereCount > 0 THEN sqlSrcWhere = sqlSrcWhere || ' AND '; END IF;
		sqlSrcWhere = sqlSrcWhere || ' EjercicioContable.numero <= ' || numeroToArg6;
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
	END IF;

	IF sqlSrcWhere IS NOT NULL AND CHAR_LENGTH(TRIM(sqlSrcWhere)) > 0 THEN
		sqlSrc = sqlSrc || ' WHERE ' || sqlSrcWhere;
	END IF;

	IF searchById = false AND orderByArg1 IS NOT NULL AND orderByArg1 > -1 THEN
		sqlSrc = sqlSrc || ' ORDER BY ' || orderByArg1;
	ELSEIF searchById = false THEN 
		sqlSrc = sqlSrc || ' ORDER BY 1 ';
	END IF;

	IF searchById = false AND orderByDescArg2 IS NOT NULL AND orderByDescArg2 = true THEN
		sqlSrc = sqlSrc || ' DESC ';
	END IF;

	IF searchById = false AND limitArg3 IS NOT NULL AND offSetArg4 IS NOT NULL AND limitArg3 > 0 AND limitArg3 <= 100 AND offSetArg4 >= 0 THEN
		sqlSrc = sqlSrc || ' LIMIT ' || limitArg3 || ' OFFSET ' || offSetArg4;
	END IF;

	-- RAISE EXCEPTION 'information messagess % ', sqlSrc;

	RETURN QUERY EXECUTE sqlSrc || ';';

END;
$$ LANGUAGE plpgsql;

DROP FUNCTION IF EXISTS massoftware.f_EjercicioContableById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_EjercicioContableById (idArg VARCHAR(36)) RETURNS SETOF massoftware.EjercicioContable AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_EjercicioContable ( idArg , null, null, null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_EjercicioContable ( null , null, null, null, null, null, null); 

-- SELECT * FROM massoftware.f_EjercicioContableById ('xxx'); 