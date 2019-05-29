
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoDocumentoAFIP                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoDocumentoAFIP

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_TipoDocumentoAFIPById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_TipoDocumentoAFIPById(idArg VARCHAR(36)) RETURNS massoftware.TipoDocumentoAFIP AS $$

	SELECT
		 TipoDocumentoAFIP.id AS TipoDocumentoAFIP_id       	-- 0
		,TipoDocumentoAFIP.numero AS TipoDocumentoAFIP_numero	-- 1
		,TipoDocumentoAFIP.nombre AS TipoDocumentoAFIP_nombre	-- 2

	FROM	massoftware.TipoDocumentoAFIP

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoDocumentoAFIP.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_TipoDocumentoAFIPById('xxx');

-- SELECT * FROM massoftware.f_TipoDocumentoAFIPById((SELECT TipoDocumentoAFIP.id FROM massoftware.TipoDocumentoAFIP LIMIT 1)::VARCHAR);