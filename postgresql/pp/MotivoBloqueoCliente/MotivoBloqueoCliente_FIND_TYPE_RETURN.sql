
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoBloqueoCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoBloqueoCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP TYPE IF EXISTS massoftware.type_MotivoBloqueoCliente_level_1 CASCADE;

CREATE TYPE massoftware.type_MotivoBloqueoCliente_level_1(

		 MotivoBloqueoCliente_id VARCHAR(36)   	-- 0
		,MotivoBloqueoCliente_numero INTEGER   	-- 1
		,MotivoBloqueoCliente_nombre VARCHAR(50)	-- 2
		,ClasificacionCliente_id VARCHAR(36)   	-- 3
		,ClasificacionCliente_numero INTEGER   	-- 4
		,ClasificacionCliente_nombre VARCHAR(50)	-- 5
		,ClasificacionCliente_color INTEGER    	-- 6
);