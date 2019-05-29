
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MonedaAFIP                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MonedaAFIP

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_MonedaAFIPById(idArg VARCHAR(36)) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_MonedaAFIPById(idArg VARCHAR(36)) RETURNS massoftware.MonedaAFIP AS $$

	SELECT
		 MonedaAFIP.id AS MonedaAFIP_id       	-- 0
		,MonedaAFIP.codigo AS MonedaAFIP_codigo	-- 1
		,MonedaAFIP.nombre AS MonedaAFIP_nombre	-- 2

	FROM	massoftware.MonedaAFIP

	WHERE 	idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaAFIP.id = TRIM(idArg)::VARCHAR;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_MonedaAFIPById('xxx');

-- SELECT * FROM massoftware.f_MonedaAFIPById((SELECT MonedaAFIP.id FROM massoftware.MonedaAFIP LIMIT 1)::VARCHAR);