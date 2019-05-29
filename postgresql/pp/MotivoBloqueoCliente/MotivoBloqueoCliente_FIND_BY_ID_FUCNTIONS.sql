
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoBloqueoCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoBloqueoCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoClienteById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoClienteById(idArg VARCHAR(36)) RETURNS massoftware.MotivoBloqueoCliente AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2

	FROM	massoftware.MotivoBloqueoCliente

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_MotivoBloqueoClienteById('xxx');

-- SELECT * FROM massoftware.f_MotivoBloqueoClienteById((SELECT MotivoBloqueoCliente.id FROM massoftware.MotivoBloqueoCliente LIMIT 1)::VARCHAR);

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MotivoBloqueoClienteById_1(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MotivoBloqueoClienteById_1(idArg VARCHAR(36)) RETURNS massoftware.type_MotivoBloqueoCliente_level_1 AS $$

	SELECT
		 MotivoBloqueoCliente.id AS MotivoBloqueoCliente_id       	-- 0
		,MotivoBloqueoCliente.numero AS MotivoBloqueoCliente_numero	-- 1
		,MotivoBloqueoCliente.nombre AS MotivoBloqueoCliente_nombre	-- 2
		,ClasificacionCliente.id AS ClasificacionCliente_id       	-- 3
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 4
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 5
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 6

	FROM	massoftware.MotivoBloqueoCliente
		LEFT JOIN massoftware.ClasificacionCliente ON MotivoBloqueoCliente.clasificacionCliente = ClasificacionCliente.id	-- 3

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_MotivoBloqueoClienteById_1('xxx');

-- SELECT * FROM massoftware.f_MotivoBloqueoClienteById_1((SELECT MotivoBloqueoCliente.id FROM massoftware.MotivoBloqueoCliente LIMIT 1)::VARCHAR);