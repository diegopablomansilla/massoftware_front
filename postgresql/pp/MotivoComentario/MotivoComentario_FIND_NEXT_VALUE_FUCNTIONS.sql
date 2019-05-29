
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoComentario                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoComentario

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_MotivoComentario_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_MotivoComentario_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER
	FROM	massoftware.MotivoComentario;

$$ LANGUAGE SQL;

/*

SELECT * FROM massoftware.f_next_MotivoComentario_numero();

*/