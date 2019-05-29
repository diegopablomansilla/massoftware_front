
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ClasificacionCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ClasificacionCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_ClasificacionClienteById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_ClasificacionClienteById(idArg VARCHAR(36)) RETURNS massoftware.ClasificacionCliente AS $$

	SELECT
		 ClasificacionCliente.id AS ClasificacionCliente_id       	-- 0
		,ClasificacionCliente.numero AS ClasificacionCliente_numero	-- 1
		,ClasificacionCliente.nombre AS ClasificacionCliente_nombre	-- 2
		,ClasificacionCliente.color AS ClasificacionCliente_color 	-- 3

	FROM	massoftware.ClasificacionCliente

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ClasificacionCliente.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_ClasificacionClienteById('xxx');

-- SELECT * FROM massoftware.f_ClasificacionClienteById((SELECT ClasificacionCliente.id FROM massoftware.ClasificacionCliente LIMIT 1)::VARCHAR);