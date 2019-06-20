


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Usuario                                                                                                //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Usuario

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Usuario(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Usuario(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Usuario(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Usuario WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Usuario.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Usuario(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: SeguridadModulo                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.SeguridadModulo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_SeguridadModulo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_SeguridadModulo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.SeguridadModulo(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.SeguridadModulo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND SeguridadModulo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_SeguridadModulo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: SeguridadPuerta                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.SeguridadPuerta

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_SeguridadPuerta(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, equateArg VARCHAR(30)
		, seguridadModuloArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_SeguridadPuerta(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, equateArg VARCHAR(30)
		, seguridadModuloArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.SeguridadPuerta(id, numero, nombre, equate, seguridadModulo) VALUES (idArg, numeroArg, nombreArg, equateArg, seguridadModuloArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.SeguridadPuerta WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND SeguridadPuerta.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_SeguridadPuerta(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(30)
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Zona                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Zona

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Zona(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
		, bonificacionArg DECIMAL(13,5)
		, recargoArg DECIMAL(13,5)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Zona(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
		, bonificacionArg DECIMAL(13,5)
		, recargoArg DECIMAL(13,5)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Zona(id, codigo, nombre, bonificacion, recargo) VALUES (idArg, codigoArg, nombreArg, bonificacionArg, recargoArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Zona WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Zona.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Zona(
		null::VARCHAR(36)
		, null::VARCHAR(3)
		, null::VARCHAR(50)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Pais                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Pais

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Pais(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Pais(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Pais(id, numero, nombre, abreviatura) VALUES (idArg, numeroArg, nombreArg, abreviaturaArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Pais WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Pais.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Pais(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(5)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Provincia                                                                                              //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Provincia

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Provincia(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, numeroAFIPArg INTEGER
		, numeroIngresosBrutosArg INTEGER
		, numeroRENATEAArg INTEGER
		, paisArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Provincia(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, numeroAFIPArg INTEGER
		, numeroIngresosBrutosArg INTEGER
		, numeroRENATEAArg INTEGER
		, paisArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Provincia(id, numero, nombre, abreviatura, numeroAFIP, numeroIngresosBrutos, numeroRENATEA, pais) VALUES (idArg, numeroArg, nombreArg, abreviaturaArg, numeroAFIPArg, numeroIngresosBrutosArg, numeroRENATEAArg, paisArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Provincia WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Provincia(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(5)
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Ciudad                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Ciudad

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Ciudad(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, departamentoArg VARCHAR(50)
		, numeroAFIPArg INTEGER
		, provinciaArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Ciudad(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, departamentoArg VARCHAR(50)
		, numeroAFIPArg INTEGER
		, provinciaArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Ciudad(id, numero, nombre, departamento, numeroAFIP, provincia) VALUES (idArg, numeroArg, nombreArg, departamentoArg, numeroAFIPArg, provinciaArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Ciudad WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ciudad.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Ciudad(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(50)
		, null::INTEGER
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CodigoPostal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CodigoPostal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_CodigoPostal(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(12)
		, numeroArg INTEGER
		, nombreCalleArg VARCHAR(200)
		, numeroCalleArg VARCHAR(20)
		, ciudadArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_CodigoPostal(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(12)
		, numeroArg INTEGER
		, nombreCalleArg VARCHAR(200)
		, numeroCalleArg VARCHAR(20)
		, ciudadArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.CodigoPostal(id, codigo, numero, nombreCalle, numeroCalle, ciudad) VALUES (idArg, codigoArg, numeroArg, nombreCalleArg, numeroCalleArg, ciudadArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.CodigoPostal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_CodigoPostal(
		null::VARCHAR(36)
		, null::VARCHAR(12)
		, null::INTEGER
		, null::VARCHAR(200)
		, null::VARCHAR(20)
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Transporte                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Transporte

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Transporte(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuitArg BIGINT
		, ingresosBrutosArg VARCHAR(13)
		, telefonoArg VARCHAR(50)
		, faxArg VARCHAR(50)
		, codigoPostalArg VARCHAR(36)
		, domicilioArg VARCHAR(150)
		, comentarioArg VARCHAR(300)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Transporte(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuitArg BIGINT
		, ingresosBrutosArg VARCHAR(13)
		, telefonoArg VARCHAR(50)
		, faxArg VARCHAR(50)
		, codigoPostalArg VARCHAR(36)
		, domicilioArg VARCHAR(150)
		, comentarioArg VARCHAR(300)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Transporte(id, numero, nombre, cuit, ingresosBrutos, telefono, fax, codigoPostal, domicilio, comentario) VALUES (idArg, numeroArg, nombreArg, cuitArg, ingresosBrutosArg, telefonoArg, faxArg, codigoPostalArg, domicilioArg, comentarioArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Transporte WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Transporte(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::BIGINT
		, null::VARCHAR(13)
		, null::VARCHAR(50)
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::VARCHAR(150)
		, null::VARCHAR(300)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Carga                                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Carga

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Carga(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, transporteArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Carga(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, transporteArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Carga(id, numero, nombre, transporte) VALUES (idArg, numeroArg, nombreArg, transporteArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Carga WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Carga(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TransporteTarifa                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TransporteTarifa

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_TransporteTarifa(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, cargaArg VARCHAR(36)
		, ciudadArg VARCHAR(36)
		, precioFleteArg DECIMAL(13,5)
		, precioUnidadFacturacionArg DECIMAL(13,5)
		, precioUnidadStockArg DECIMAL(13,5)
		, precioBultosArg DECIMAL(13,5)
		, importeMinimoEntregaArg DECIMAL(13,5)
		, importeMinimoCargaArg DECIMAL(13,5)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_TransporteTarifa(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, cargaArg VARCHAR(36)
		, ciudadArg VARCHAR(36)
		, precioFleteArg DECIMAL(13,5)
		, precioUnidadFacturacionArg DECIMAL(13,5)
		, precioUnidadStockArg DECIMAL(13,5)
		, precioBultosArg DECIMAL(13,5)
		, importeMinimoEntregaArg DECIMAL(13,5)
		, importeMinimoCargaArg DECIMAL(13,5)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF precioFleteArg IS NULL THEN

		precioFleteArg = 0;

	END IF;

	IF precioUnidadFacturacionArg IS NULL THEN

		precioUnidadFacturacionArg = 0;

	END IF;

	IF precioUnidadStockArg IS NULL THEN

		precioUnidadStockArg = 0;

	END IF;

	IF precioBultosArg IS NULL THEN

		precioBultosArg = 0;

	END IF;

	IF importeMinimoEntregaArg IS NULL THEN

		importeMinimoEntregaArg = 0;

	END IF;

	IF importeMinimoCargaArg IS NULL THEN

		importeMinimoCargaArg = 0;

	END IF;

	INSERT INTO massoftware.TransporteTarifa(id, numero, carga, ciudad, precioFlete, precioUnidadFacturacion, precioUnidadStock, precioBultos, importeMinimoEntrega, importeMinimoCarga) VALUES (idArg, numeroArg, cargaArg, ciudadArg, precioFleteArg, precioUnidadFacturacionArg, precioUnidadStockArg, precioBultosArg, importeMinimoEntregaArg, importeMinimoCargaArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.TransporteTarifa WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_TransporteTarifa(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoDocumentoAFIP                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoDocumentoAFIP

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_TipoDocumentoAFIP(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_TipoDocumentoAFIP(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.TipoDocumentoAFIP(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.TipoDocumentoAFIP WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoDocumentoAFIP.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_TipoDocumentoAFIP(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MonedaAFIP                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MonedaAFIP

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_MonedaAFIP(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_MonedaAFIP(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.MonedaAFIP(id, codigo, nombre) VALUES (idArg, codigoArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.MonedaAFIP WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaAFIP.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_MonedaAFIP(
		null::VARCHAR(36)
		, null::VARCHAR(3)
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: NotaCreditoMotivo                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.NotaCreditoMotivo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_NotaCreditoMotivo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_NotaCreditoMotivo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.NotaCreditoMotivo(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.NotaCreditoMotivo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND NotaCreditoMotivo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_NotaCreditoMotivo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoComentario                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoComentario

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_MotivoComentario(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_MotivoComentario(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.MotivoComentario(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.MotivoComentario WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoComentario.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_MotivoComentario(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoCliente                                                                                            //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_TipoCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_TipoCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.TipoCliente(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.TipoCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoCliente.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_TipoCliente(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ClasificacionCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ClasificacionCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_ClasificacionCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, colorArg INTEGER
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_ClasificacionCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, colorArg INTEGER
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.ClasificacionCliente(id, numero, nombre, color) VALUES (idArg, numeroArg, nombreArg, colorArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.ClasificacionCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ClasificacionCliente.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_ClasificacionCliente(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::INTEGER
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoBloqueoCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoBloqueoCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_MotivoBloqueoCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, clasificacionClienteArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_MotivoBloqueoCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, clasificacionClienteArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.MotivoBloqueoCliente(id, numero, nombre, clasificacionCliente) VALUES (idArg, numeroArg, nombreArg, clasificacionClienteArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.MotivoBloqueoCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_MotivoBloqueoCliente(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoSucursal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoSucursal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_TipoSucursal(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_TipoSucursal(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.TipoSucursal(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.TipoSucursal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoSucursal.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_TipoSucursal(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Sucursal                                                                                               //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Sucursal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Sucursal(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, tipoSucursalArg VARCHAR(36)
		, cuentaClientesDesdeArg VARCHAR(7)
		, cuentaClientesHastaArg VARCHAR(7)
		, cantidadCaracteresClientesArg INTEGER
		, identificacionNumericaClientesArg BOOLEAN
		, permiteCambiarClientesArg BOOLEAN
		, cuentaProveedoresDesdeArg VARCHAR(6)
		, cuentaProveedoresHastaArg VARCHAR(6)
		, cantidadCaracteresProveedoresArg INTEGER
		, identificacionNumericaProveedoresArg BOOLEAN
		, permiteCambiarProveedoresArg BOOLEAN
		, clientesOcacionalesDesdeArg INTEGER
		, clientesOcacionalesHastaArg INTEGER
		, numeroCobranzaDesdeArg INTEGER
		, numeroCobranzaHastaArg INTEGER
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Sucursal(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, tipoSucursalArg VARCHAR(36)
		, cuentaClientesDesdeArg VARCHAR(7)
		, cuentaClientesHastaArg VARCHAR(7)
		, cantidadCaracteresClientesArg INTEGER
		, identificacionNumericaClientesArg BOOLEAN
		, permiteCambiarClientesArg BOOLEAN
		, cuentaProveedoresDesdeArg VARCHAR(6)
		, cuentaProveedoresHastaArg VARCHAR(6)
		, cantidadCaracteresProveedoresArg INTEGER
		, identificacionNumericaProveedoresArg BOOLEAN
		, permiteCambiarProveedoresArg BOOLEAN
		, clientesOcacionalesDesdeArg INTEGER
		, clientesOcacionalesHastaArg INTEGER
		, numeroCobranzaDesdeArg INTEGER
		, numeroCobranzaHastaArg INTEGER
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF identificacionNumericaClientesArg IS NULL THEN

		identificacionNumericaClientesArg = false;

	END IF;

	IF permiteCambiarClientesArg IS NULL THEN

		permiteCambiarClientesArg = false;

	END IF;

	IF identificacionNumericaProveedoresArg IS NULL THEN

		identificacionNumericaProveedoresArg = false;

	END IF;

	IF permiteCambiarProveedoresArg IS NULL THEN

		permiteCambiarProveedoresArg = false;

	END IF;

	INSERT INTO massoftware.Sucursal(id, numero, nombre, abreviatura, tipoSucursal, cuentaClientesDesde, cuentaClientesHasta, cantidadCaracteresClientes, identificacionNumericaClientes, permiteCambiarClientes, cuentaProveedoresDesde, cuentaProveedoresHasta, cantidadCaracteresProveedores, identificacionNumericaProveedores, permiteCambiarProveedores, clientesOcacionalesDesde, clientesOcacionalesHasta, numeroCobranzaDesde, numeroCobranzaHasta) VALUES (idArg, numeroArg, nombreArg, abreviaturaArg, tipoSucursalArg, cuentaClientesDesdeArg, cuentaClientesHastaArg, cantidadCaracteresClientesArg, identificacionNumericaClientesArg, permiteCambiarClientesArg, cuentaProveedoresDesdeArg, cuentaProveedoresHastaArg, cantidadCaracteresProveedoresArg, identificacionNumericaProveedoresArg, permiteCambiarProveedoresArg, clientesOcacionalesDesdeArg, clientesOcacionalesHastaArg, numeroCobranzaDesdeArg, numeroCobranzaHastaArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Sucursal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Sucursal.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Sucursal(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(5)
		, null::VARCHAR(36)
		, null::VARCHAR(7)
		, null::VARCHAR(7)
		, null::INTEGER
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(6)
		, null::VARCHAR(6)
		, null::INTEGER
		, null::BOOLEAN
		, null::BOOLEAN
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: DepositoModulo                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.DepositoModulo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_DepositoModulo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_DepositoModulo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.DepositoModulo(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.DepositoModulo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND DepositoModulo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_DepositoModulo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Deposito                                                                                               //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Deposito

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Deposito(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, sucursalArg VARCHAR(36)
		, depositoModuloArg VARCHAR(36)
		, puertaOperativoArg VARCHAR(36)
		, puertaConsultaArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Deposito(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, sucursalArg VARCHAR(36)
		, depositoModuloArg VARCHAR(36)
		, puertaOperativoArg VARCHAR(36)
		, puertaConsultaArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Deposito(id, numero, nombre, abreviatura, sucursal, depositoModulo, puertaOperativo, puertaConsulta) VALUES (idArg, numeroArg, nombreArg, abreviaturaArg, sucursalArg, depositoModuloArg, puertaOperativoArg, puertaConsultaArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Deposito WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Deposito.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Deposito(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(5)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: EjercicioContable                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.EjercicioContable

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


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CentroCostoContable                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CentroCostoContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_CentroCostoContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, ejercicioContableArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_CentroCostoContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, ejercicioContableArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.CentroCostoContable(id, numero, nombre, abreviatura, ejercicioContable) VALUES (idArg, numeroArg, nombreArg, abreviaturaArg, ejercicioContableArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.CentroCostoContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CentroCostoContable.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_CentroCostoContable(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(5)
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoPuntoEquilibrio                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoPuntoEquilibrio

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_TipoPuntoEquilibrio(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_TipoPuntoEquilibrio(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.TipoPuntoEquilibrio(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.TipoPuntoEquilibrio WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoPuntoEquilibrio.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_TipoPuntoEquilibrio(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: PuntoEquilibrio                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.PuntoEquilibrio

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_PuntoEquilibrio(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, tipoPuntoEquilibrioArg VARCHAR(36)
		, ejercicioContableArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_PuntoEquilibrio(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, tipoPuntoEquilibrioArg VARCHAR(36)
		, ejercicioContableArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.PuntoEquilibrio(id, numero, nombre, tipoPuntoEquilibrio, ejercicioContable) VALUES (idArg, numeroArg, nombreArg, tipoPuntoEquilibrioArg, ejercicioContableArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.PuntoEquilibrio WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND PuntoEquilibrio.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_PuntoEquilibrio(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CostoVenta                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CostoVenta

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_CostoVenta(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_CostoVenta(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.CostoVenta(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.CostoVenta WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CostoVenta.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_CostoVenta(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaContableEstado                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaContableEstado

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_CuentaContableEstado(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_CuentaContableEstado(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.CuentaContableEstado(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaContableEstado WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaContableEstado.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_CuentaContableEstado(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaContable                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_CuentaContable(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(11)
		, nombreArg VARCHAR(50)
		, ejercicioContableArg VARCHAR(36)
		, integraArg VARCHAR(16)
		, cuentaJerarquiaArg VARCHAR(16)
		, imputableArg BOOLEAN
		, ajustaPorInflacionArg BOOLEAN
		, cuentaContableEstadoArg VARCHAR(36)
		, cuentaConApropiacionArg BOOLEAN
		, centroCostoContableArg VARCHAR(36)
		, cuentaAgrupadoraArg VARCHAR(50)
		, porcentajeArg DECIMAL(6,3)
		, puntoEquilibrioArg VARCHAR(36)
		, costoVentaArg VARCHAR(36)
		, seguridadPuertaArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_CuentaContable(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(11)
		, nombreArg VARCHAR(50)
		, ejercicioContableArg VARCHAR(36)
		, integraArg VARCHAR(16)
		, cuentaJerarquiaArg VARCHAR(16)
		, imputableArg BOOLEAN
		, ajustaPorInflacionArg BOOLEAN
		, cuentaContableEstadoArg VARCHAR(36)
		, cuentaConApropiacionArg BOOLEAN
		, centroCostoContableArg VARCHAR(36)
		, cuentaAgrupadoraArg VARCHAR(50)
		, porcentajeArg DECIMAL(6,3)
		, puntoEquilibrioArg VARCHAR(36)
		, costoVentaArg VARCHAR(36)
		, seguridadPuertaArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF imputableArg IS NULL THEN

		imputableArg = false;

	END IF;

	IF ajustaPorInflacionArg IS NULL THEN

		ajustaPorInflacionArg = false;

	END IF;

	IF cuentaConApropiacionArg IS NULL THEN

		cuentaConApropiacionArg = false;

	END IF;

	INSERT INTO massoftware.CuentaContable(id, codigo, nombre, ejercicioContable, integra, cuentaJerarquia, imputable, ajustaPorInflacion, cuentaContableEstado, cuentaConApropiacion, centroCostoContable, cuentaAgrupadora, porcentaje, puntoEquilibrio, costoVenta, seguridadPuerta) VALUES (idArg, codigoArg, nombreArg, ejercicioContableArg, integraArg, cuentaJerarquiaArg, imputableArg, ajustaPorInflacionArg, cuentaContableEstadoArg, cuentaConApropiacionArg, centroCostoContableArg, cuentaAgrupadoraArg, porcentajeArg, puntoEquilibrioArg, costoVentaArg, seguridadPuertaArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaContable.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_CuentaContable(
		null::VARCHAR(36)
		, null::VARCHAR(11)
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::VARCHAR(16)
		, null::VARCHAR(16)
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::VARCHAR(50)
		, null::DECIMAL(6,3)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoModelo                                                                                          //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoModelo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_AsientoModelo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, ejercicioContableArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_AsientoModelo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, ejercicioContableArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.AsientoModelo(id, numero, nombre, ejercicioContable) VALUES (idArg, numeroArg, nombreArg, ejercicioContableArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoModelo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoModelo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_AsientoModelo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoModeloItem                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoModeloItem

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_AsientoModeloItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, asientoModeloArg VARCHAR(36)
		, cuentaContableArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_AsientoModeloItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, asientoModeloArg VARCHAR(36)
		, cuentaContableArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.AsientoModeloItem(id, numero, asientoModelo, cuentaContable) VALUES (idArg, numeroArg, asientoModeloArg, cuentaContableArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoModeloItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoModeloItem.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_AsientoModeloItem(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MinutaContable                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MinutaContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_MinutaContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_MinutaContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.MinutaContable(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.MinutaContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MinutaContable.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_MinutaContable(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContableModulo                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoContableModulo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_AsientoContableModulo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_AsientoContableModulo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.AsientoContableModulo(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoContableModulo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContableModulo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_AsientoContableModulo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContable                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_AsientoContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, fechaArg DATE
		, detalleArg VARCHAR(100)
		, ejercicioContableArg VARCHAR(36)
		, minutaContableArg VARCHAR(36)
		, sucursalArg VARCHAR(36)
		, asientoContableModuloArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_AsientoContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, fechaArg DATE
		, detalleArg VARCHAR(100)
		, ejercicioContableArg VARCHAR(36)
		, minutaContableArg VARCHAR(36)
		, sucursalArg VARCHAR(36)
		, asientoContableModuloArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.AsientoContable(id, numero, fecha, detalle, ejercicioContable, minutaContable, sucursal, asientoContableModulo) VALUES (idArg, numeroArg, fechaArg, detalleArg, ejercicioContableArg, minutaContableArg, sucursalArg, asientoContableModuloArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContable.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_AsientoContable(
		null::VARCHAR(36)
		, null::INTEGER
		, null::DATE
		, null::VARCHAR(100)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContableItem                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoContableItem

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_AsientoContableItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, fechaArg DATE
		, detalleArg VARCHAR(100)
		, asientoContableArg VARCHAR(36)
		, cuentaContableArg VARCHAR(36)
		, debeArg DECIMAL(13,5)
		, haberArg DECIMAL(13,5)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_AsientoContableItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, fechaArg DATE
		, detalleArg VARCHAR(100)
		, asientoContableArg VARCHAR(36)
		, cuentaContableArg VARCHAR(36)
		, debeArg DECIMAL(13,5)
		, haberArg DECIMAL(13,5)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.AsientoContableItem(id, numero, fecha, detalle, asientoContable, cuentaContable, debe, haber) VALUES (idArg, numeroArg, fechaArg, detalleArg, asientoContableArg, cuentaContableArg, debeArg, haberArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoContableItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContableItem.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_AsientoContableItem(
		null::VARCHAR(36)
		, null::INTEGER
		, null::DATE
		, null::VARCHAR(100)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Empresa                                                                                                //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Empresa

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


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Moneda                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Moneda

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Moneda(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, cotizacionArg DECIMAL(13,5)
		, cotizacionFechaArg TIMESTAMP
		, controlActualizacionArg BOOLEAN
		, monedaAFIPArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Moneda(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, cotizacionArg DECIMAL(13,5)
		, cotizacionFechaArg TIMESTAMP
		, controlActualizacionArg BOOLEAN
		, monedaAFIPArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF cotizacionArg IS NULL THEN

		cotizacionArg = 1;

	END IF;

	IF cotizacionFechaArg IS NULL THEN

		cotizacionFechaArg = now();

	END IF;

	IF controlActualizacionArg IS NULL THEN

		controlActualizacionArg = false;

	END IF;

	INSERT INTO massoftware.Moneda(id, numero, nombre, abreviatura, cotizacion, cotizacionFecha, controlActualizacion, monedaAFIP) VALUES (idArg, numeroArg, nombreArg, abreviaturaArg, cotizacionArg, cotizacionFechaArg, controlActualizacionArg, monedaAFIPArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Moneda WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Moneda.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Moneda(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(5)
		, null::DECIMAL(13,5)
		, null::TIMESTAMP
		, null::BOOLEAN
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MonedaCotizacion                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MonedaCotizacion

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_MonedaCotizacion(
		  idArg VARCHAR(36)

		, cotizacionFechaArg TIMESTAMP
		, compraArg DECIMAL(13,5)
		, ventaArg DECIMAL(13,5)
		, cotizacionFechaAuditoriaArg TIMESTAMP
		, monedaArg VARCHAR(36)
		, usuarioArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_MonedaCotizacion(
		  idArg VARCHAR(36)

		, cotizacionFechaArg TIMESTAMP
		, compraArg DECIMAL(13,5)
		, ventaArg DECIMAL(13,5)
		, cotizacionFechaAuditoriaArg TIMESTAMP
		, monedaArg VARCHAR(36)
		, usuarioArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF cotizacionFechaAuditoriaArg IS NULL THEN

		cotizacionFechaAuditoriaArg = now();

	END IF;

	INSERT INTO massoftware.MonedaCotizacion(id, cotizacionFecha, compra, venta, cotizacionFechaAuditoria, moneda, usuario) VALUES (idArg, cotizacionFechaArg, compraArg, ventaArg, cotizacionFechaAuditoriaArg, monedaArg, usuarioArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.MonedaCotizacion WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaCotizacion.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_MonedaCotizacion(
		null::VARCHAR(36)
		, null::TIMESTAMP
		, null::DECIMAL(13,5)
		, null::DECIMAL(13,5)
		, null::TIMESTAMP
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Banco                                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Banco

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Banco(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuitArg BIGINT
		, bloqueadoArg BOOLEAN
		, hojaArg INTEGER
		, primeraFilaArg INTEGER
		, ultimaFilaArg INTEGER
		, fechaArg VARCHAR(3)
		, descripcionArg VARCHAR(3)
		, referencia1Arg VARCHAR(3)
		, importeArg VARCHAR(3)
		, referencia2Arg VARCHAR(3)
		, saldoArg VARCHAR(3)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Banco(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuitArg BIGINT
		, bloqueadoArg BOOLEAN
		, hojaArg INTEGER
		, primeraFilaArg INTEGER
		, ultimaFilaArg INTEGER
		, fechaArg VARCHAR(3)
		, descripcionArg VARCHAR(3)
		, referencia1Arg VARCHAR(3)
		, importeArg VARCHAR(3)
		, referencia2Arg VARCHAR(3)
		, saldoArg VARCHAR(3)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF bloqueadoArg IS NULL THEN

		bloqueadoArg = false;

	END IF;

	INSERT INTO massoftware.Banco(id, numero, nombre, cuit, bloqueado, hoja, primeraFila, ultimaFila, fecha, descripcion, referencia1, importe, referencia2, saldo) VALUES (idArg, numeroArg, nombreArg, cuitArg, bloqueadoArg, hojaArg, primeraFilaArg, ultimaFilaArg, fechaArg, descripcionArg, referencia1Arg, importeArg, referencia2Arg, saldoArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Banco WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Banco.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Banco(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::BIGINT
		, null::BOOLEAN
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::VARCHAR(3)
		, null::VARCHAR(3)
		, null::VARCHAR(3)
		, null::VARCHAR(3)
		, null::VARCHAR(3)
		, null::VARCHAR(3)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: BancoFirmante                                                                                          //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.BancoFirmante

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_BancoFirmante(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cargoArg VARCHAR(50)
		, bloqueadoArg BOOLEAN
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_BancoFirmante(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cargoArg VARCHAR(50)
		, bloqueadoArg BOOLEAN
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF bloqueadoArg IS NULL THEN

		bloqueadoArg = false;

	END IF;

	INSERT INTO massoftware.BancoFirmante(id, numero, nombre, cargo, bloqueado) VALUES (idArg, numeroArg, nombreArg, cargoArg, bloqueadoArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.BancoFirmante WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND BancoFirmante.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_BancoFirmante(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(50)
		, null::BOOLEAN
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Caja                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Caja

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_Caja(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, seguridadPuertaArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_Caja(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, seguridadPuertaArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.Caja(id, numero, nombre, seguridadPuerta) VALUES (idArg, numeroArg, nombreArg, seguridadPuertaArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.Caja WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Caja.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_Caja(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondoTipo                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondoTipo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_CuentaFondoTipo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_CuentaFondoTipo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.CuentaFondoTipo(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaFondoTipo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoTipo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_CuentaFondoTipo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondoRubro                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondoRubro

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_CuentaFondoRubro(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_CuentaFondoRubro(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.CuentaFondoRubro(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaFondoRubro WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoRubro.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_CuentaFondoRubro(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondoGrupo                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondoGrupo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_CuentaFondoGrupo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaFondoRubroArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_CuentaFondoGrupo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaFondoRubroArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.CuentaFondoGrupo(id, numero, nombre, cuentaFondoRubro) VALUES (idArg, numeroArg, nombreArg, cuentaFondoRubroArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaFondoGrupo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoGrupo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_CuentaFondoGrupo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondoTipoBanco                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondoTipoBanco

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_CuentaFondoTipoBanco(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_CuentaFondoTipoBanco(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.CuentaFondoTipoBanco(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaFondoTipoBanco WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoTipoBanco.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_CuentaFondoTipoBanco(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondoBancoCopia                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondoBancoCopia

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_CuentaFondoBancoCopia(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_CuentaFondoBancoCopia(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.CuentaFondoBancoCopia(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaFondoBancoCopia WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoBancoCopia.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_CuentaFondoBancoCopia(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondo                                                                                            //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_CuentaFondo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaContableArg VARCHAR(36)
		, cuentaFondoGrupoArg VARCHAR(36)
		, cuentaFondoTipoArg VARCHAR(36)
		, obsoletoArg BOOLEAN
		, noImprimeCajaArg BOOLEAN
		, ventasArg BOOLEAN
		, fondosArg BOOLEAN
		, comprasArg BOOLEAN
		, monedaArg VARCHAR(36)
		, cajaArg VARCHAR(36)
		, rechazadosArg BOOLEAN
		, conciliacionArg BOOLEAN
		, cuentaFondoTipoBancoArg VARCHAR(36)
		, bancoArg VARCHAR(36)
		, cuentaBancariaArg VARCHAR(22)
		, cbuArg VARCHAR(22)
		, limiteDescubiertoArg DECIMAL(13,5)
		, cuentaFondoCaucionArg VARCHAR(50)
		, cuentaFondoDiferidosArg VARCHAR(50)
		, formatoArg VARCHAR(50)
		, cuentaFondoBancoCopiaArg VARCHAR(36)
		, limiteOperacionIndividualArg DECIMAL(13,5)
		, seguridadPuertaUsoArg VARCHAR(36)
		, seguridadPuertaConsultaArg VARCHAR(36)
		, seguridadPuertaLimiteArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_CuentaFondo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaContableArg VARCHAR(36)
		, cuentaFondoGrupoArg VARCHAR(36)
		, cuentaFondoTipoArg VARCHAR(36)
		, obsoletoArg BOOLEAN
		, noImprimeCajaArg BOOLEAN
		, ventasArg BOOLEAN
		, fondosArg BOOLEAN
		, comprasArg BOOLEAN
		, monedaArg VARCHAR(36)
		, cajaArg VARCHAR(36)
		, rechazadosArg BOOLEAN
		, conciliacionArg BOOLEAN
		, cuentaFondoTipoBancoArg VARCHAR(36)
		, bancoArg VARCHAR(36)
		, cuentaBancariaArg VARCHAR(22)
		, cbuArg VARCHAR(22)
		, limiteDescubiertoArg DECIMAL(13,5)
		, cuentaFondoCaucionArg VARCHAR(50)
		, cuentaFondoDiferidosArg VARCHAR(50)
		, formatoArg VARCHAR(50)
		, cuentaFondoBancoCopiaArg VARCHAR(36)
		, limiteOperacionIndividualArg DECIMAL(13,5)
		, seguridadPuertaUsoArg VARCHAR(36)
		, seguridadPuertaConsultaArg VARCHAR(36)
		, seguridadPuertaLimiteArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF obsoletoArg IS NULL THEN

		obsoletoArg = false;

	END IF;

	IF noImprimeCajaArg IS NULL THEN

		noImprimeCajaArg = false;

	END IF;

	IF ventasArg IS NULL THEN

		ventasArg = false;

	END IF;

	IF fondosArg IS NULL THEN

		fondosArg = false;

	END IF;

	IF comprasArg IS NULL THEN

		comprasArg = false;

	END IF;

	IF rechazadosArg IS NULL THEN

		rechazadosArg = false;

	END IF;

	IF conciliacionArg IS NULL THEN

		conciliacionArg = false;

	END IF;

	INSERT INTO massoftware.CuentaFondo(id, numero, nombre, cuentaContable, cuentaFondoGrupo, cuentaFondoTipo, obsoleto, noImprimeCaja, ventas, fondos, compras, moneda, caja, rechazados, conciliacion, cuentaFondoTipoBanco, banco, cuentaBancaria, cbu, limiteDescubierto, cuentaFondoCaucion, cuentaFondoDiferidos, formato, cuentaFondoBancoCopia, limiteOperacionIndividual, seguridadPuertaUso, seguridadPuertaConsulta, seguridadPuertaLimite) VALUES (idArg, numeroArg, nombreArg, cuentaContableArg, cuentaFondoGrupoArg, cuentaFondoTipoArg, obsoletoArg, noImprimeCajaArg, ventasArg, fondosArg, comprasArg, monedaArg, cajaArg, rechazadosArg, conciliacionArg, cuentaFondoTipoBancoArg, bancoArg, cuentaBancariaArg, cbuArg, limiteDescubiertoArg, cuentaFondoCaucionArg, cuentaFondoDiferidosArg, formatoArg, cuentaFondoBancoCopiaArg, limiteOperacionIndividualArg, seguridadPuertaUsoArg, seguridadPuertaConsultaArg, seguridadPuertaLimiteArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaFondo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_CuentaFondo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::BOOLEAN
		, null::BOOLEAN
		, null::BOOLEAN
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(22)
		, null::VARCHAR(22)
		, null::DECIMAL(13,5)
		, null::VARCHAR(50)
		, null::VARCHAR(50)
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::DECIMAL(13,5)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ComprobanteFondoModelo                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ComprobanteFondoModelo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_ComprobanteFondoModelo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_ComprobanteFondoModelo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	INSERT INTO massoftware.ComprobanteFondoModelo(id, numero, nombre) VALUES (idArg, numeroArg, nombreArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.ComprobanteFondoModelo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ComprobanteFondoModelo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_ComprobanteFondoModelo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ComprobanteFondoModeloItem                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ComprobanteFondoModeloItem

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.i_ComprobanteFondoModeloItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, debeArg BOOLEAN
		, comprobanteFondoModeloArg VARCHAR(36)
		, cuentaFondoArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.i_ComprobanteFondoModeloItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, debeArg BOOLEAN
		, comprobanteFondoModeloArg VARCHAR(36)
		, cuentaFondoArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF idArg IS NULL THEN

		idArg = uuid_generate_v4();

	END IF;

	IF debeArg IS NULL THEN

		debeArg = false;

	END IF;

	INSERT INTO massoftware.ComprobanteFondoModeloItem(id, numero, debe, comprobanteFondoModelo, cuentaFondo) VALUES (idArg, numeroArg, debeArg, comprobanteFondoModeloArg, cuentaFondoArg);

	RETURN ((SELECT COUNT(*) FROM massoftware.ComprobanteFondoModeloItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ComprobanteFondoModeloItem.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.i_ComprobanteFondoModeloItem(
		null::VARCHAR(36)
		, null::INTEGER
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/