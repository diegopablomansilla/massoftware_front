
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoCliente                                                                                            //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TipoClienteById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoClienteById(idArg VARCHAR(36)) RETURNS massoftware.TipoCliente AS $$

	SELECT
		 TipoCliente.id AS TipoCliente_id       	-- 0
		,TipoCliente.numero AS TipoCliente_numero	-- 1
		,TipoCliente.nombre AS TipoCliente_nombre	-- 2

	FROM	massoftware.TipoCliente

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoCliente.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TipoClienteById('xxx');

-- SELECT * FROM massoftware.f_TipoClienteById((SELECT TipoCliente.id FROM massoftware.TipoCliente LIMIT 1)::VARCHAR);