
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: NotaCreditoMotivo                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.NotaCreditoMotivo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_NotaCreditoMotivoById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_NotaCreditoMotivoById(idArg VARCHAR(36)) RETURNS massoftware.NotaCreditoMotivo AS $$

	SELECT
		 NotaCreditoMotivo.id AS NotaCreditoMotivo_id       	-- 0
		,NotaCreditoMotivo.numero AS NotaCreditoMotivo_numero	-- 1
		,NotaCreditoMotivo.nombre AS NotaCreditoMotivo_nombre	-- 2

	FROM	massoftware.NotaCreditoMotivo

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND NotaCreditoMotivo.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_NotaCreditoMotivoById('xxx');

-- SELECT * FROM massoftware.f_NotaCreditoMotivoById((SELECT NotaCreditoMotivo.id FROM massoftware.NotaCreditoMotivo LIMIT 1)::VARCHAR);