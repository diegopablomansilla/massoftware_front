
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

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.d_EmpresaById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.d_EmpresaById(idArg VARCHAR(36)) RETURNS BOOLEAN AS $$

BEGIN

	IF ((SELECT COUNT(*) FROM massoftware.Empresa WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Empresa.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN THEN

		RETURN false;

	END IF;

	DELETE FROM massoftware.Empresa WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Empresa.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Empresa WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Empresa.id = TRIM(idArg)::VARCHAR) = 0)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

-- SELECT * FROM massoftware.d_EmpresaById('xxx');

-- SELECT * FROM massoftware.d_EmpresaById((SELECT Empresa.id FROM massoftware.Empresa LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Empresa(
		  idArg VARCHAR(36)

		, ejercicioContableArg VARCHAR(36)
		, fechaCierreVentasArg DATE
		, fechaCierreStockArg DATE
		, fechaCierreFondoArg DATE
		, fechaCierreComprasArg DATE
		, fechaCierreContabilidadArg DATE
		, fechaCierreGarantiaDevolucionesArg DATE
		, fechaCierreTambosArg DATE
		, fechaCierreRRHHArg DATE
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Empresa(
		  idArg VARCHAR(36)

		, ejercicioContableArg VARCHAR(36)
		, fechaCierreVentasArg DATE
		, fechaCierreStockArg DATE
		, fechaCierreFondoArg DATE
		, fechaCierreComprasArg DATE
		, fechaCierreContabilidadArg DATE
		, fechaCierreGarantiaDevolucionesArg DATE
		, fechaCierreTambosArg DATE
		, fechaCierreRRHHArg DATE
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Empresa(id, ejercicioContable, fechaCierreVentas, fechaCierreStock, fechaCierreFondo, fechaCierreCompras, fechaCierreContabilidad, fechaCierreGarantiaDevoluciones, fechaCierreTambos, fechaCierreRRHH) VALUES (idArg, ejercicioContableArg, fechaCierreVentasArg, fechaCierreStockArg, fechaCierreFondoArg, fechaCierreComprasArg, fechaCierreContabilidadArg, fechaCierreGarantiaDevolucionesArg, fechaCierreTambosArg, fechaCierreRRHHArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Empresa WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Empresa.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Empresa(
		null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::DATE
		, null::DATE
		, null::DATE
		, null::DATE
		, null::DATE
		, null::DATE
		, null::DATE
		, null::DATE
);

*/

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Empresa(
		  idArg VARCHAR(36)

		, ejercicioContableArg VARCHAR(36)
		, fechaCierreVentasArg DATE
		, fechaCierreStockArg DATE
		, fechaCierreFondoArg DATE
		, fechaCierreComprasArg DATE
		, fechaCierreContabilidadArg DATE
		, fechaCierreGarantiaDevolucionesArg DATE
		, fechaCierreTambosArg DATE
		, fechaCierreRRHHArg DATE
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Empresa(
		  idArg VARCHAR(36)

		, ejercicioContableArg VARCHAR(36)
		, fechaCierreVentasArg DATE
		, fechaCierreStockArg DATE
		, fechaCierreFondoArg DATE
		, fechaCierreComprasArg DATE
		, fechaCierreContabilidadArg DATE
		, fechaCierreGarantiaDevolucionesArg DATE
		, fechaCierreTambosArg DATE
		, fechaCierreRRHHArg DATE
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Empresa SET 
		  ejercicioContable = ejercicioContableArg
		, fechaCierreVentas = fechaCierreVentasArg
		, fechaCierreStock = fechaCierreStockArg
		, fechaCierreFondo = fechaCierreFondoArg
		, fechaCierreCompras = fechaCierreComprasArg
		, fechaCierreContabilidad = fechaCierreContabilidadArg
		, fechaCierreGarantiaDevoluciones = fechaCierreGarantiaDevolucionesArg
		, fechaCierreTambos = fechaCierreTambosArg
		, fechaCierreRRHH = fechaCierreRRHHArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Empresa.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Empresa WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Empresa.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Empresa(
		null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::DATE
		, null::DATE
		, null::DATE
		, null::DATE
		, null::DATE
		, null::DATE
		, null::DATE
		, null::DATE
);

*/

DROP TYPE IF EXISTS massoftware.t_Empresa_1 CASCADE;

CREATE TYPE massoftware.t_Empresa_1 AS (

	  Empresa_id                             	VARCHAR(36) 		-- 0	Empresa.id
	, EjercicioContable_1_id                 	VARCHAR(36) 		-- 1	Empresa.EjercicioContable.id
	, EjercicioContable_1_numero             	INTEGER     		-- 2	Empresa.EjercicioContable.numero
	, EjercicioContable_1_apertura           	DATE        		-- 3	Empresa.EjercicioContable.apertura
	, EjercicioContable_1_cierre             	DATE        		-- 4	Empresa.EjercicioContable.cierre
	, EjercicioContable_1_cerrado            	BOOLEAN     		-- 5	Empresa.EjercicioContable.cerrado
	, EjercicioContable_1_cerradoModulos     	BOOLEAN     		-- 6	Empresa.EjercicioContable.cerradoModulos
	, EjercicioContable_1_comentario         	VARCHAR(250)		-- 7	Empresa.EjercicioContable.comentario
	, Empresa_fechaCierreVentas              	DATE        		-- 8	Empresa.fechaCierreVentas
	, Empresa_fechaCierreStock               	DATE        		-- 9	Empresa.fechaCierreStock
	, Empresa_fechaCierreFondo               	DATE        		-- 10	Empresa.fechaCierreFondo
	, Empresa_fechaCierreCompras             	DATE        		-- 11	Empresa.fechaCierreCompras
	, Empresa_fechaCierreContabilidad        	DATE        		-- 12	Empresa.fechaCierreContabilidad
	, Empresa_fechaCierreGarantiaDevoluciones	DATE        		-- 13	Empresa.fechaCierreGarantiaDevoluciones
	, Empresa_fechaCierreTambos              	DATE        		-- 14	Empresa.fechaCierreTambos
	, Empresa_fechaCierreRRHH                	DATE        		-- 15	Empresa.fechaCierreRRHH

);

DROP FUNCTION IF EXISTS massoftware.f_Empresa (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Empresa (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) RETURNS SETOF massoftware.Empresa AS $$

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
				  Empresa.id                                 AS Empresa_id                             	-- 0	.id                            		VARCHAR(36)
				, Empresa.ejercicioContable                  AS Empresa_ejercicioContable              	-- 1	.ejercicioContable             		VARCHAR(36)	EjercicioContable.id
				, Empresa.fechaCierreVentas                  AS Empresa_fechaCierreVentas              	-- 2	.fechaCierreVentas             		DATE
				, Empresa.fechaCierreStock                   AS Empresa_fechaCierreStock               	-- 3	.fechaCierreStock              		DATE
				, Empresa.fechaCierreFondo                   AS Empresa_fechaCierreFondo               	-- 4	.fechaCierreFondo              		DATE
				, Empresa.fechaCierreCompras                 AS Empresa_fechaCierreCompras             	-- 5	.fechaCierreCompras            		DATE
				, Empresa.fechaCierreContabilidad            AS Empresa_fechaCierreContabilidad        	-- 6	.fechaCierreContabilidad       		DATE
				, Empresa.fechaCierreGarantiaDevoluciones    AS Empresa_fechaCierreGarantiaDevoluciones	-- 7	.fechaCierreGarantiaDevoluciones		DATE
				, Empresa.fechaCierreTambos                  AS Empresa_fechaCierreTambos              	-- 8	.fechaCierreTambos             		DATE
				, Empresa.fechaCierreRRHH                    AS Empresa_fechaCierreRRHH                	-- 9	.fechaCierreRRHH               		DATE

		FROM	massoftware.Empresa

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Empresa.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
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

DROP FUNCTION IF EXISTS massoftware.f_EmpresaById (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_EmpresaById (idArg VARCHAR(36)) RETURNS SETOF massoftware.Empresa AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Empresa ( idArg , null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Empresa ( null , null, null, null, null); 

-- SELECT * FROM massoftware.f_EmpresaById ('xxx'); 

DROP FUNCTION IF EXISTS massoftware.f_Empresa_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_Empresa_1 (

	  idArg0            VARCHAR(36)	-- 0
	, orderByArg1       INTEGER    	-- 1
	, orderByDescArg2   BOOLEAN    	-- 2
	, limitArg3         BIGINT     	-- 3
	, offSetArg4        BIGINT     	-- 4

) RETURNS SETOF massoftware.t_Empresa_1 AS $$

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
				  Empresa.id                                  AS Empresa_id                             	-- 0	.id                             		VARCHAR(36)
				, EjercicioContable_1.id                      AS EjercicioContable_1_id                 	-- 1	.EjercicioContable.id           		VARCHAR(36)
				, EjercicioContable_1.numero                  AS EjercicioContable_1_numero             	-- 2	.EjercicioContable.numero       		INTEGER
				, EjercicioContable_1.apertura                AS EjercicioContable_1_apertura           	-- 3	.EjercicioContable.apertura     		DATE
				, EjercicioContable_1.cierre                  AS EjercicioContable_1_cierre             	-- 4	.EjercicioContable.cierre       		DATE
				, EjercicioContable_1.cerrado                 AS EjercicioContable_1_cerrado            	-- 5	.EjercicioContable.cerrado      		BOOLEAN
				, EjercicioContable_1.cerradoModulos          AS EjercicioContable_1_cerradoModulos     	-- 6	.EjercicioContable.cerradoModulos		BOOLEAN
				, EjercicioContable_1.comentario              AS EjercicioContable_1_comentario         	-- 7	.EjercicioContable.comentario   		VARCHAR(250)
				, Empresa.fechaCierreVentas                   AS Empresa_fechaCierreVentas              	-- 8	.fechaCierreVentas              		DATE
				, Empresa.fechaCierreStock                    AS Empresa_fechaCierreStock               	-- 9	.fechaCierreStock               		DATE
				, Empresa.fechaCierreFondo                    AS Empresa_fechaCierreFondo               	-- 10	.fechaCierreFondo               		DATE
				, Empresa.fechaCierreCompras                  AS Empresa_fechaCierreCompras             	-- 11	.fechaCierreCompras             		DATE
				, Empresa.fechaCierreContabilidad             AS Empresa_fechaCierreContabilidad        	-- 12	.fechaCierreContabilidad        		DATE
				, Empresa.fechaCierreGarantiaDevoluciones     AS Empresa_fechaCierreGarantiaDevoluciones	-- 13	.fechaCierreGarantiaDevoluciones		DATE
				, Empresa.fechaCierreTambos                   AS Empresa_fechaCierreTambos              	-- 14	.fechaCierreTambos              		DATE
				, Empresa.fechaCierreRRHH                     AS Empresa_fechaCierreRRHH                	-- 15	.fechaCierreRRHH                		DATE

		FROM	massoftware.Empresa
			LEFT JOIN massoftware.EjercicioContable AS EjercicioContable_1        ON Empresa.ejercicioContable = EjercicioContable_1.id 	-- 1 LEFT LEVEL: 1

	';

	IF idArg0 IS NOT NULL AND CHAR_LENGTH(TRIM(idArg0)) > 0 THEN
		sqlSrcWhere = sqlSrcWhere || ' Empresa.id = ''' || TRIM(idArg0) || '''';
		sqlSrcWhereCount = sqlSrcWhereCount + 1;
		searchById = true;
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

DROP FUNCTION IF EXISTS massoftware.f_EmpresaById_1 (idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_EmpresaById_1 (idArg VARCHAR(36)) RETURNS SETOF massoftware.t_Empresa_1 AS $$

DECLARE

BEGIN


	IF idArg IS NULL OR CHAR_LENGTH(TRIM(idArg)) = 0 THEN
		RAISE EXCEPTION 'Se esperaba un id (Pais.id) no nulo/vacio.';
	END IF;

	RETURN QUERY SELECT * FROM massoftware.f_Empresa_1 ( idArg , null, null, null, null); 

END;
$$ LANGUAGE plpgsql;


-- SELECT * FROM massoftware.f_Empresa_1 ( null , null, null, null, null); 

-- SELECT * FROM massoftware.f_EmpresaById_1 ('xxx'); 