


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Usuario                                                                                                //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Usuario

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Usuario(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Usuario(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Usuario SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Usuario.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Usuario WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Usuario.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Usuario(
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


DROP FUNCTION IF EXISTS massoftware.u_SeguridadModulo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_SeguridadModulo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.SeguridadModulo SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND SeguridadModulo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.SeguridadModulo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND SeguridadModulo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_SeguridadModulo(
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


DROP FUNCTION IF EXISTS massoftware.u_SeguridadPuerta(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, equateArg VARCHAR(30)
		, seguridadModuloArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_SeguridadPuerta(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, equateArg VARCHAR(30)
		, seguridadModuloArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.SeguridadPuerta SET 
		  numero = numeroArg
		, nombre = nombreArg
		, equate = equateArg
		, seguridadModulo = seguridadModuloArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND SeguridadPuerta.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.SeguridadPuerta WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND SeguridadPuerta.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_SeguridadPuerta(
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


DROP FUNCTION IF EXISTS massoftware.u_Zona(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
		, bonificacionArg DECIMAL(13,5)
		, recargoArg DECIMAL(13,5)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Zona(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
		, bonificacionArg DECIMAL(13,5)
		, recargoArg DECIMAL(13,5)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Zona SET 
		  codigo = codigoArg
		, nombre = nombreArg
		, bonificacion = bonificacionArg
		, recargo = recargoArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Zona.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Zona WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Zona.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Zona(
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


DROP FUNCTION IF EXISTS massoftware.u_Pais(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Pais(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Pais SET 
		  numero = numeroArg
		, nombre = nombreArg
		, abreviatura = abreviaturaArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Pais.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Pais WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Pais.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Pais(
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


DROP FUNCTION IF EXISTS massoftware.u_Provincia(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, numeroAFIPArg INTEGER
		, numeroIngresosBrutosArg INTEGER
		, numeroRENATEAArg INTEGER
		, paisArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Provincia(
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

	UPDATE massoftware.Provincia SET 
		  numero = numeroArg
		, nombre = nombreArg
		, abreviatura = abreviaturaArg
		, numeroAFIP = numeroAFIPArg
		, numeroIngresosBrutos = numeroIngresosBrutosArg
		, numeroRENATEA = numeroRENATEAArg
		, pais = paisArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Provincia WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Provincia.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Provincia(
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


DROP FUNCTION IF EXISTS massoftware.u_Ciudad(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, departamentoArg VARCHAR(50)
		, numeroAFIPArg INTEGER
		, provinciaArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Ciudad(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, departamentoArg VARCHAR(50)
		, numeroAFIPArg INTEGER
		, provinciaArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Ciudad SET 
		  numero = numeroArg
		, nombre = nombreArg
		, departamento = departamentoArg
		, numeroAFIP = numeroAFIPArg
		, provincia = provinciaArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ciudad.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Ciudad WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ciudad.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Ciudad(
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


DROP FUNCTION IF EXISTS massoftware.u_CodigoPostal(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(12)
		, numeroArg INTEGER
		, nombreCalleArg VARCHAR(200)
		, numeroCalleArg VARCHAR(20)
		, ciudadArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_CodigoPostal(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(12)
		, numeroArg INTEGER
		, nombreCalleArg VARCHAR(200)
		, numeroCalleArg VARCHAR(20)
		, ciudadArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.CodigoPostal SET 
		  codigo = codigoArg
		, numero = numeroArg
		, nombreCalle = nombreCalleArg
		, numeroCalle = numeroCalleArg
		, ciudad = ciudadArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CodigoPostal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CodigoPostal.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_CodigoPostal(
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


DROP FUNCTION IF EXISTS massoftware.u_Transporte(
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

CREATE OR REPLACE FUNCTION massoftware.u_Transporte(
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

	UPDATE massoftware.Transporte SET 
		  numero = numeroArg
		, nombre = nombreArg
		, cuit = cuitArg
		, ingresosBrutos = ingresosBrutosArg
		, telefono = telefonoArg
		, fax = faxArg
		, codigoPostal = codigoPostalArg
		, domicilio = domicilioArg
		, comentario = comentarioArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Transporte WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Transporte.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Transporte(
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


DROP FUNCTION IF EXISTS massoftware.u_Carga(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, transporteArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Carga(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, transporteArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Carga SET 
		  numero = numeroArg
		, nombre = nombreArg
		, transporte = transporteArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Carga WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Carga.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Carga(
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


DROP FUNCTION IF EXISTS massoftware.u_TransporteTarifa(
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

CREATE OR REPLACE FUNCTION massoftware.u_TransporteTarifa(
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

	UPDATE massoftware.TransporteTarifa SET 
		  numero = numeroArg
		, carga = cargaArg
		, ciudad = ciudadArg
		, precioFlete = precioFleteArg
		, precioUnidadFacturacion = precioUnidadFacturacionArg
		, precioUnidadStock = precioUnidadStockArg
		, precioBultos = precioBultosArg
		, importeMinimoEntrega = importeMinimoEntregaArg
		, importeMinimoCarga = importeMinimoCargaArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TransporteTarifa WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TransporteTarifa.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_TransporteTarifa(
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


DROP FUNCTION IF EXISTS massoftware.u_TipoDocumentoAFIP(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_TipoDocumentoAFIP(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.TipoDocumentoAFIP SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoDocumentoAFIP.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TipoDocumentoAFIP WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoDocumentoAFIP.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_TipoDocumentoAFIP(
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


DROP FUNCTION IF EXISTS massoftware.u_MonedaAFIP(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_MonedaAFIP(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.MonedaAFIP SET 
		  codigo = codigoArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaAFIP.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.MonedaAFIP WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaAFIP.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_MonedaAFIP(
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


DROP FUNCTION IF EXISTS massoftware.u_NotaCreditoMotivo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_NotaCreditoMotivo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.NotaCreditoMotivo SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND NotaCreditoMotivo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.NotaCreditoMotivo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND NotaCreditoMotivo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_NotaCreditoMotivo(
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


DROP FUNCTION IF EXISTS massoftware.u_MotivoComentario(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_MotivoComentario(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.MotivoComentario SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoComentario.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.MotivoComentario WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoComentario.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_MotivoComentario(
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


DROP FUNCTION IF EXISTS massoftware.u_TipoCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_TipoCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.TipoCliente SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoCliente.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TipoCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoCliente.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_TipoCliente(
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


DROP FUNCTION IF EXISTS massoftware.u_ClasificacionCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, colorArg INTEGER
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_ClasificacionCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, colorArg INTEGER
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.ClasificacionCliente SET 
		  numero = numeroArg
		, nombre = nombreArg
		, color = colorArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ClasificacionCliente.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.ClasificacionCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ClasificacionCliente.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_ClasificacionCliente(
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


DROP FUNCTION IF EXISTS massoftware.u_MotivoBloqueoCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, clasificacionClienteArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_MotivoBloqueoCliente(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, clasificacionClienteArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.MotivoBloqueoCliente SET 
		  numero = numeroArg
		, nombre = nombreArg
		, clasificacionCliente = clasificacionClienteArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.MotivoBloqueoCliente WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MotivoBloqueoCliente.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_MotivoBloqueoCliente(
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


DROP FUNCTION IF EXISTS massoftware.u_TipoSucursal(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_TipoSucursal(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.TipoSucursal SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoSucursal.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TipoSucursal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoSucursal.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_TipoSucursal(
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


DROP FUNCTION IF EXISTS massoftware.u_Sucursal(
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

CREATE OR REPLACE FUNCTION massoftware.u_Sucursal(
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

	UPDATE massoftware.Sucursal SET 
		  numero = numeroArg
		, nombre = nombreArg
		, abreviatura = abreviaturaArg
		, tipoSucursal = tipoSucursalArg
		, cuentaClientesDesde = cuentaClientesDesdeArg
		, cuentaClientesHasta = cuentaClientesHastaArg
		, cantidadCaracteresClientes = cantidadCaracteresClientesArg
		, identificacionNumericaClientes = identificacionNumericaClientesArg
		, permiteCambiarClientes = permiteCambiarClientesArg
		, cuentaProveedoresDesde = cuentaProveedoresDesdeArg
		, cuentaProveedoresHasta = cuentaProveedoresHastaArg
		, cantidadCaracteresProveedores = cantidadCaracteresProveedoresArg
		, identificacionNumericaProveedores = identificacionNumericaProveedoresArg
		, permiteCambiarProveedores = permiteCambiarProveedoresArg
		, clientesOcacionalesDesde = clientesOcacionalesDesdeArg
		, clientesOcacionalesHasta = clientesOcacionalesHastaArg
		, numeroCobranzaDesde = numeroCobranzaDesdeArg
		, numeroCobranzaHasta = numeroCobranzaHastaArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Sucursal.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Sucursal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Sucursal.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Sucursal(
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


DROP FUNCTION IF EXISTS massoftware.u_DepositoModulo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_DepositoModulo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.DepositoModulo SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND DepositoModulo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.DepositoModulo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND DepositoModulo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_DepositoModulo(
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


DROP FUNCTION IF EXISTS massoftware.u_Deposito(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, sucursalArg VARCHAR(36)
		, depositoModuloArg VARCHAR(36)
		, puertaOperativoArg VARCHAR(36)
		, puertaConsultaArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Deposito(
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

	UPDATE massoftware.Deposito SET 
		  numero = numeroArg
		, nombre = nombreArg
		, abreviatura = abreviaturaArg
		, sucursal = sucursalArg
		, depositoModulo = depositoModuloArg
		, puertaOperativo = puertaOperativoArg
		, puertaConsulta = puertaConsultaArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Deposito.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Deposito WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Deposito.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Deposito(
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


DROP FUNCTION IF EXISTS massoftware.u_EjercicioContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, aperturaArg DATE
		, cierreArg DATE
		, cerradoArg BOOLEAN
		, cerradoModulosArg BOOLEAN
		, comentarioArg VARCHAR(250)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_EjercicioContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, aperturaArg DATE
		, cierreArg DATE
		, cerradoArg BOOLEAN
		, cerradoModulosArg BOOLEAN
		, comentarioArg VARCHAR(250)
) RETURNS BOOLEAN AS $$

BEGIN

	IF cerradoArg IS NULL THEN

		cerradoArg = false;

	END IF;

	IF cerradoModulosArg IS NULL THEN

		cerradoModulosArg = false;

	END IF;

	UPDATE massoftware.EjercicioContable SET 
		  numero = numeroArg
		, apertura = aperturaArg
		, cierre = cierreArg
		, cerrado = cerradoArg
		, cerradoModulos = cerradoModulosArg
		, comentario = comentarioArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND EjercicioContable.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.EjercicioContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND EjercicioContable.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_EjercicioContable(
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


DROP FUNCTION IF EXISTS massoftware.u_CentroCostoContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, ejercicioContableArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_CentroCostoContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, ejercicioContableArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.CentroCostoContable SET 
		  numero = numeroArg
		, nombre = nombreArg
		, abreviatura = abreviaturaArg
		, ejercicioContable = ejercicioContableArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CentroCostoContable.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CentroCostoContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CentroCostoContable.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_CentroCostoContable(
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


DROP FUNCTION IF EXISTS massoftware.u_TipoPuntoEquilibrio(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_TipoPuntoEquilibrio(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.TipoPuntoEquilibrio SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoPuntoEquilibrio.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TipoPuntoEquilibrio WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoPuntoEquilibrio.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_TipoPuntoEquilibrio(
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


DROP FUNCTION IF EXISTS massoftware.u_PuntoEquilibrio(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, tipoPuntoEquilibrioArg VARCHAR(36)
		, ejercicioContableArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_PuntoEquilibrio(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, tipoPuntoEquilibrioArg VARCHAR(36)
		, ejercicioContableArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.PuntoEquilibrio SET 
		  numero = numeroArg
		, nombre = nombreArg
		, tipoPuntoEquilibrio = tipoPuntoEquilibrioArg
		, ejercicioContable = ejercicioContableArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND PuntoEquilibrio.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.PuntoEquilibrio WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND PuntoEquilibrio.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_PuntoEquilibrio(
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


DROP FUNCTION IF EXISTS massoftware.u_CostoVenta(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_CostoVenta(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.CostoVenta SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CostoVenta.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CostoVenta WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CostoVenta.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_CostoVenta(
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


DROP FUNCTION IF EXISTS massoftware.u_CuentaContableEstado(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_CuentaContableEstado(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.CuentaContableEstado SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaContableEstado.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaContableEstado WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaContableEstado.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_CuentaContableEstado(
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


DROP FUNCTION IF EXISTS massoftware.u_CuentaContable(
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

CREATE OR REPLACE FUNCTION massoftware.u_CuentaContable(
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

	IF imputableArg IS NULL THEN

		imputableArg = false;

	END IF;

	IF ajustaPorInflacionArg IS NULL THEN

		ajustaPorInflacionArg = false;

	END IF;

	IF cuentaConApropiacionArg IS NULL THEN

		cuentaConApropiacionArg = false;

	END IF;

	UPDATE massoftware.CuentaContable SET 
		  codigo = codigoArg
		, nombre = nombreArg
		, ejercicioContable = ejercicioContableArg
		, integra = integraArg
		, cuentaJerarquia = cuentaJerarquiaArg
		, imputable = imputableArg
		, ajustaPorInflacion = ajustaPorInflacionArg
		, cuentaContableEstado = cuentaContableEstadoArg
		, cuentaConApropiacion = cuentaConApropiacionArg
		, centroCostoContable = centroCostoContableArg
		, cuentaAgrupadora = cuentaAgrupadoraArg
		, porcentaje = porcentajeArg
		, puntoEquilibrio = puntoEquilibrioArg
		, costoVenta = costoVentaArg
		, seguridadPuerta = seguridadPuertaArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaContable.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaContable.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_CuentaContable(
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


DROP FUNCTION IF EXISTS massoftware.u_AsientoModelo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, ejercicioContableArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_AsientoModelo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, ejercicioContableArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.AsientoModelo SET 
		  numero = numeroArg
		, nombre = nombreArg
		, ejercicioContable = ejercicioContableArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoModelo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoModelo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoModelo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_AsientoModelo(
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


DROP FUNCTION IF EXISTS massoftware.u_AsientoModeloItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, asientoModeloArg VARCHAR(36)
		, cuentaContableArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_AsientoModeloItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, asientoModeloArg VARCHAR(36)
		, cuentaContableArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.AsientoModeloItem SET 
		  numero = numeroArg
		, asientoModelo = asientoModeloArg
		, cuentaContable = cuentaContableArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoModeloItem.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoModeloItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoModeloItem.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_AsientoModeloItem(
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


DROP FUNCTION IF EXISTS massoftware.u_MinutaContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_MinutaContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.MinutaContable SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MinutaContable.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.MinutaContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MinutaContable.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_MinutaContable(
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


DROP FUNCTION IF EXISTS massoftware.u_AsientoContableModulo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_AsientoContableModulo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.AsientoContableModulo SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContableModulo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoContableModulo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContableModulo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_AsientoContableModulo(
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


DROP FUNCTION IF EXISTS massoftware.u_AsientoContable(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, fechaArg DATE
		, detalleArg VARCHAR(100)
		, ejercicioContableArg VARCHAR(36)
		, minutaContableArg VARCHAR(36)
		, sucursalArg VARCHAR(36)
		, asientoContableModuloArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_AsientoContable(
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

	UPDATE massoftware.AsientoContable SET 
		  numero = numeroArg
		, fecha = fechaArg
		, detalle = detalleArg
		, ejercicioContable = ejercicioContableArg
		, minutaContable = minutaContableArg
		, sucursal = sucursalArg
		, asientoContableModulo = asientoContableModuloArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContable.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoContable WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContable.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_AsientoContable(
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


DROP FUNCTION IF EXISTS massoftware.u_AsientoContableItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, fechaArg DATE
		, detalleArg VARCHAR(100)
		, asientoContableArg VARCHAR(36)
		, cuentaContableArg VARCHAR(36)
		, debeArg DECIMAL(13,5)
		, haberArg DECIMAL(13,5)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_AsientoContableItem(
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

	UPDATE massoftware.AsientoContableItem SET 
		  numero = numeroArg
		, fecha = fechaArg
		, detalle = detalleArg
		, asientoContable = asientoContableArg
		, cuentaContable = cuentaContableArg
		, debe = debeArg
		, haber = haberArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContableItem.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.AsientoContableItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND AsientoContableItem.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_AsientoContableItem(
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


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Moneda                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Moneda

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Moneda(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, abreviaturaArg VARCHAR(5)
		, cotizacionArg DECIMAL(13,5)
		, cotizacionFechaArg TIMESTAMP
		, controlActualizacionArg BOOLEAN
		, monedaAFIPArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Moneda(
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

	IF controlActualizacionArg IS NULL THEN

		controlActualizacionArg = false;

	END IF;

	UPDATE massoftware.Moneda SET 
		  numero = numeroArg
		, nombre = nombreArg
		, abreviatura = abreviaturaArg
		, cotizacion = cotizacionArg
		, cotizacionFecha = cotizacionFechaArg
		, controlActualizacion = controlActualizacionArg
		, monedaAFIP = monedaAFIPArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Moneda.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Moneda WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Moneda.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Moneda(
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


DROP FUNCTION IF EXISTS massoftware.u_MonedaCotizacion(
		  idArg VARCHAR(36)

		, cotizacionFechaArg TIMESTAMP
		, compraArg DECIMAL(13,5)
		, ventaArg DECIMAL(13,5)
		, cotizacionFechaAuditoriaArg TIMESTAMP
		, monedaArg VARCHAR(36)
		, usuarioArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_MonedaCotizacion(
		  idArg VARCHAR(36)

		, cotizacionFechaArg TIMESTAMP
		, compraArg DECIMAL(13,5)
		, ventaArg DECIMAL(13,5)
		, cotizacionFechaAuditoriaArg TIMESTAMP
		, monedaArg VARCHAR(36)
		, usuarioArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.MonedaCotizacion SET 
		  cotizacionFecha = cotizacionFechaArg
		, compra = compraArg
		, venta = ventaArg
		, cotizacionFechaAuditoria = cotizacionFechaAuditoriaArg
		, moneda = monedaArg
		, usuario = usuarioArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaCotizacion.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.MonedaCotizacion WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND MonedaCotizacion.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_MonedaCotizacion(
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


DROP FUNCTION IF EXISTS massoftware.u_Banco(
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

CREATE OR REPLACE FUNCTION massoftware.u_Banco(
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

	IF bloqueadoArg IS NULL THEN

		bloqueadoArg = false;

	END IF;

	UPDATE massoftware.Banco SET 
		  numero = numeroArg
		, nombre = nombreArg
		, cuit = cuitArg
		, bloqueado = bloqueadoArg
		, hoja = hojaArg
		, primeraFila = primeraFilaArg
		, ultimaFila = ultimaFilaArg
		, fecha = fechaArg
		, descripcion = descripcionArg
		, referencia1 = referencia1Arg
		, importe = importeArg
		, referencia2 = referencia2Arg
		, saldo = saldoArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Banco.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Banco WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Banco.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Banco(
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


DROP FUNCTION IF EXISTS massoftware.u_BancoFirmante(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cargoArg VARCHAR(50)
		, bloqueadoArg BOOLEAN
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_BancoFirmante(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cargoArg VARCHAR(50)
		, bloqueadoArg BOOLEAN
) RETURNS BOOLEAN AS $$

BEGIN

	IF bloqueadoArg IS NULL THEN

		bloqueadoArg = false;

	END IF;

	UPDATE massoftware.BancoFirmante SET 
		  numero = numeroArg
		, nombre = nombreArg
		, cargo = cargoArg
		, bloqueado = bloqueadoArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND BancoFirmante.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.BancoFirmante WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND BancoFirmante.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_BancoFirmante(
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


DROP FUNCTION IF EXISTS massoftware.u_Caja(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, seguridadPuertaArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Caja(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, seguridadPuertaArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Caja SET 
		  numero = numeroArg
		, nombre = nombreArg
		, seguridadPuerta = seguridadPuertaArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Caja.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Caja WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Caja.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Caja(
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


DROP FUNCTION IF EXISTS massoftware.u_CuentaFondoTipo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_CuentaFondoTipo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.CuentaFondoTipo SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoTipo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaFondoTipo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoTipo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_CuentaFondoTipo(
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


DROP FUNCTION IF EXISTS massoftware.u_CuentaFondoRubro(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_CuentaFondoRubro(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.CuentaFondoRubro SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoRubro.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaFondoRubro WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoRubro.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_CuentaFondoRubro(
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


DROP FUNCTION IF EXISTS massoftware.u_CuentaFondoGrupo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaFondoRubroArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_CuentaFondoGrupo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaFondoRubroArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.CuentaFondoGrupo SET 
		  numero = numeroArg
		, nombre = nombreArg
		, cuentaFondoRubro = cuentaFondoRubroArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoGrupo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaFondoGrupo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoGrupo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_CuentaFondoGrupo(
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


DROP FUNCTION IF EXISTS massoftware.u_CuentaFondoTipoBanco(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_CuentaFondoTipoBanco(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.CuentaFondoTipoBanco SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoTipoBanco.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaFondoTipoBanco WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoTipoBanco.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_CuentaFondoTipoBanco(
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


DROP FUNCTION IF EXISTS massoftware.u_CuentaFondoBancoCopia(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_CuentaFondoBancoCopia(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.CuentaFondoBancoCopia SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoBancoCopia.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaFondoBancoCopia WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondoBancoCopia.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_CuentaFondoBancoCopia(
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


DROP FUNCTION IF EXISTS massoftware.u_CuentaFondo(
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

CREATE OR REPLACE FUNCTION massoftware.u_CuentaFondo(
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

	UPDATE massoftware.CuentaFondo SET 
		  numero = numeroArg
		, nombre = nombreArg
		, cuentaContable = cuentaContableArg
		, cuentaFondoGrupo = cuentaFondoGrupoArg
		, cuentaFondoTipo = cuentaFondoTipoArg
		, obsoleto = obsoletoArg
		, noImprimeCaja = noImprimeCajaArg
		, ventas = ventasArg
		, fondos = fondosArg
		, compras = comprasArg
		, moneda = monedaArg
		, caja = cajaArg
		, rechazados = rechazadosArg
		, conciliacion = conciliacionArg
		, cuentaFondoTipoBanco = cuentaFondoTipoBancoArg
		, banco = bancoArg
		, cuentaBancaria = cuentaBancariaArg
		, cbu = cbuArg
		, limiteDescubierto = limiteDescubiertoArg
		, cuentaFondoCaucion = cuentaFondoCaucionArg
		, cuentaFondoDiferidos = cuentaFondoDiferidosArg
		, formato = formatoArg
		, cuentaFondoBancoCopia = cuentaFondoBancoCopiaArg
		, limiteOperacionIndividual = limiteOperacionIndividualArg
		, seguridadPuertaUso = seguridadPuertaUsoArg
		, seguridadPuertaConsulta = seguridadPuertaConsultaArg
		, seguridadPuertaLimite = seguridadPuertaLimiteArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.CuentaFondo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND CuentaFondo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_CuentaFondo(
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


DROP FUNCTION IF EXISTS massoftware.u_ComprobanteFondoModelo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_ComprobanteFondoModelo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.ComprobanteFondoModelo SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ComprobanteFondoModelo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.ComprobanteFondoModelo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ComprobanteFondoModelo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_ComprobanteFondoModelo(
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


DROP FUNCTION IF EXISTS massoftware.u_ComprobanteFondoModeloItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, debeArg BOOLEAN
		, comprobanteFondoModeloArg VARCHAR(36)
		, cuentaFondoArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_ComprobanteFondoModeloItem(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, debeArg BOOLEAN
		, comprobanteFondoModeloArg VARCHAR(36)
		, cuentaFondoArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	IF debeArg IS NULL THEN

		debeArg = false;

	END IF;

	UPDATE massoftware.ComprobanteFondoModeloItem SET 
		  numero = numeroArg
		, debe = debeArg
		, comprobanteFondoModelo = comprobanteFondoModeloArg
		, cuentaFondo = cuentaFondoArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ComprobanteFondoModeloItem.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.ComprobanteFondoModeloItem WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ComprobanteFondoModeloItem.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_ComprobanteFondoModeloItem(
		null::VARCHAR(36)
		, null::INTEGER
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TalonarioLetra                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TalonarioLetra

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_TalonarioLetra(
		  idArg VARCHAR(36)

		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_TalonarioLetra(
		  idArg VARCHAR(36)

		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.TalonarioLetra SET 
		  nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TalonarioLetra.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TalonarioLetra WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TalonarioLetra.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_TalonarioLetra(
		null::VARCHAR(36)
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TalonarioControladorFizcal                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TalonarioControladorFizcal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_TalonarioControladorFizcal(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(10)
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_TalonarioControladorFizcal(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(10)
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.TalonarioControladorFizcal SET 
		  codigo = codigoArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TalonarioControladorFizcal.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TalonarioControladorFizcal WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TalonarioControladorFizcal.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_TalonarioControladorFizcal(
		null::VARCHAR(36)
		, null::VARCHAR(10)
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Talonario                                                                                              //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Talonario

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Talonario(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, talonarioLetraArg VARCHAR(36)
		, puntoVentaArg INTEGER
		, autonumeracionArg BOOLEAN
		, numeracionPreImpresaArg BOOLEAN
		, asociadoRG10098Arg BOOLEAN
		, talonarioControladorFizcalArg VARCHAR(36)
		, primerNumeroArg INTEGER
		, proximoNumeroArg INTEGER
		, ultimoNumeroArg INTEGER
		, cantidadMinimaComprobantesArg INTEGER
		, fechaArg DATE
		, numeroCAIArg BIGINT
		, vencimientoArg DATE
		, diasAvisoVencimientoArg INTEGER
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Talonario(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, talonarioLetraArg VARCHAR(36)
		, puntoVentaArg INTEGER
		, autonumeracionArg BOOLEAN
		, numeracionPreImpresaArg BOOLEAN
		, asociadoRG10098Arg BOOLEAN
		, talonarioControladorFizcalArg VARCHAR(36)
		, primerNumeroArg INTEGER
		, proximoNumeroArg INTEGER
		, ultimoNumeroArg INTEGER
		, cantidadMinimaComprobantesArg INTEGER
		, fechaArg DATE
		, numeroCAIArg BIGINT
		, vencimientoArg DATE
		, diasAvisoVencimientoArg INTEGER
) RETURNS BOOLEAN AS $$

BEGIN

	IF autonumeracionArg IS NULL THEN

		autonumeracionArg = false;

	END IF;

	IF numeracionPreImpresaArg IS NULL THEN

		numeracionPreImpresaArg = false;

	END IF;

	IF asociadoRG10098Arg IS NULL THEN

		asociadoRG10098Arg = false;

	END IF;

	UPDATE massoftware.Talonario SET 
		  numero = numeroArg
		, nombre = nombreArg
		, talonarioLetra = talonarioLetraArg
		, puntoVenta = puntoVentaArg
		, autonumeracion = autonumeracionArg
		, numeracionPreImpresa = numeracionPreImpresaArg
		, asociadoRG10098 = asociadoRG10098Arg
		, talonarioControladorFizcal = talonarioControladorFizcalArg
		, primerNumero = primerNumeroArg
		, proximoNumero = proximoNumeroArg
		, ultimoNumero = ultimoNumeroArg
		, cantidadMinimaComprobantes = cantidadMinimaComprobantesArg
		, fecha = fechaArg
		, numeroCAI = numeroCAIArg
		, vencimiento = vencimientoArg
		, diasAvisoVencimiento = diasAvisoVencimientoArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Talonario.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Talonario WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Talonario.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Talonario(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::INTEGER
		, null::BOOLEAN
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(36)
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::DATE
		, null::BIGINT
		, null::DATE
		, null::INTEGER
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TicketControlDenunciados                                                                               //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TicketControlDenunciados

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_TicketControlDenunciados(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_TicketControlDenunciados(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.TicketControlDenunciados SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TicketControlDenunciados.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TicketControlDenunciados WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TicketControlDenunciados.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_TicketControlDenunciados(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Ticket                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Ticket

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Ticket(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, fechaActualizacionArg DATE
		, cantidadPorLotesArg INTEGER
		, ticketControlDenunciadosArg VARCHAR(36)
		, valorMaximoArg DECIMAL(13,5)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Ticket(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, fechaActualizacionArg DATE
		, cantidadPorLotesArg INTEGER
		, ticketControlDenunciadosArg VARCHAR(36)
		, valorMaximoArg DECIMAL(13,5)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.Ticket SET 
		  numero = numeroArg
		, nombre = nombreArg
		, fechaActualizacion = fechaActualizacionArg
		, cantidadPorLotes = cantidadPorLotesArg
		, ticketControlDenunciados = ticketControlDenunciadosArg
		, valorMaximo = valorMaximoArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ticket.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Ticket WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Ticket.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Ticket(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::DATE
		, null::INTEGER
		, null::VARCHAR(36)
		, null::DECIMAL(13,5)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TicketModelo                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TicketModelo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_TicketModelo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, ticketArg VARCHAR(36)
		, pruebaLecturaArg VARCHAR(50)
		, activoArg BOOLEAN
		, longitudLecturaArg INTEGER
		, identificacionPosicionArg INTEGER
		, identificacionArg INTEGER
		, importePosicionArg INTEGER
		, longitudArg INTEGER
		, cantidadDecimalesArg INTEGER
		, numeroPosicionArg INTEGER
		, numeroLongitudArg INTEGER
		, prefijoIdentificacionArg VARCHAR(10)
		, posicionPrefijoArg INTEGER
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_TicketModelo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, ticketArg VARCHAR(36)
		, pruebaLecturaArg VARCHAR(50)
		, activoArg BOOLEAN
		, longitudLecturaArg INTEGER
		, identificacionPosicionArg INTEGER
		, identificacionArg INTEGER
		, importePosicionArg INTEGER
		, longitudArg INTEGER
		, cantidadDecimalesArg INTEGER
		, numeroPosicionArg INTEGER
		, numeroLongitudArg INTEGER
		, prefijoIdentificacionArg VARCHAR(10)
		, posicionPrefijoArg INTEGER
) RETURNS BOOLEAN AS $$

BEGIN

	IF activoArg IS NULL THEN

		activoArg = false;

	END IF;

	UPDATE massoftware.TicketModelo SET 
		  numero = numeroArg
		, nombre = nombreArg
		, ticket = ticketArg
		, pruebaLectura = pruebaLecturaArg
		, activo = activoArg
		, longitudLectura = longitudLecturaArg
		, identificacionPosicion = identificacionPosicionArg
		, identificacion = identificacionArg
		, importePosicion = importePosicionArg
		, longitud = longitudArg
		, cantidadDecimales = cantidadDecimalesArg
		, numeroPosicion = numeroPosicionArg
		, numeroLongitud = numeroLongitudArg
		, prefijoIdentificacion = prefijoIdentificacionArg
		, posicionPrefijo = posicionPrefijoArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TicketModelo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TicketModelo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TicketModelo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_TicketModelo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::VARCHAR(50)
		, null::BOOLEAN
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::VARCHAR(10)
		, null::INTEGER
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: JuridiccionConvnioMultilateral                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.JuridiccionConvnioMultilateral

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_JuridiccionConvnioMultilateral(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaFondoArg VARCHAR(36)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_JuridiccionConvnioMultilateral(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaFondoArg VARCHAR(36)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.JuridiccionConvnioMultilateral SET 
		  numero = numeroArg
		, nombre = nombreArg
		, cuentaFondo = cuentaFondoArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND JuridiccionConvnioMultilateral.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.JuridiccionConvnioMultilateral WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND JuridiccionConvnioMultilateral.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_JuridiccionConvnioMultilateral(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Chequera                                                                                               //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Chequera

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_Chequera(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaFondoArg VARCHAR(36)
		, primerNumeroArg INTEGER
		, ultimoNumeroArg INTEGER
		, proximoNumeroArg INTEGER
		, bloqueadoArg BOOLEAN
		, impresionDiferidaArg BOOLEAN
		, formatoArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_Chequera(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
		, cuentaFondoArg VARCHAR(36)
		, primerNumeroArg INTEGER
		, ultimoNumeroArg INTEGER
		, proximoNumeroArg INTEGER
		, bloqueadoArg BOOLEAN
		, impresionDiferidaArg BOOLEAN
		, formatoArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	IF bloqueadoArg IS NULL THEN

		bloqueadoArg = false;

	END IF;

	IF impresionDiferidaArg IS NULL THEN

		impresionDiferidaArg = false;

	END IF;

	UPDATE massoftware.Chequera SET 
		  numero = numeroArg
		, nombre = nombreArg
		, cuentaFondo = cuentaFondoArg
		, primerNumero = primerNumeroArg
		, ultimoNumero = ultimoNumeroArg
		, proximoNumero = proximoNumeroArg
		, bloqueado = bloqueadoArg
		, impresionDiferida = impresionDiferidaArg
		, formato = formatoArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Chequera.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.Chequera WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND Chequera.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_Chequera(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
		, null::VARCHAR(36)
		, null::INTEGER
		, null::INTEGER
		, null::INTEGER
		, null::BOOLEAN
		, null::BOOLEAN
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoComprobanteConcepto                                                                                //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoComprobanteConcepto

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_TipoComprobanteConcepto(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_TipoComprobanteConcepto(
		  idArg VARCHAR(36)

		, codigoArg VARCHAR(3)
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.TipoComprobanteConcepto SET 
		  codigo = codigoArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoComprobanteConcepto.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TipoComprobanteConcepto WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoComprobanteConcepto.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_TipoComprobanteConcepto(
		null::VARCHAR(36)
		, null::VARCHAR(3)
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ClaseComprobante                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ClaseComprobante

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_ClaseComprobante(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_ClaseComprobante(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.ClaseComprobante SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ClaseComprobante.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.ClaseComprobante WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ClaseComprobante.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_ClaseComprobante(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ComportamientoComprobante                                                                              //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ComportamientoComprobante

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_ComportamientoComprobante(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_ComportamientoComprobante(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.ComportamientoComprobante SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ComportamientoComprobante.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.ComportamientoComprobante WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND ComportamientoComprobante.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_ComportamientoComprobante(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoComprobanteCopia                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoComprobanteCopia

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_TipoComprobanteCopia(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_TipoComprobanteCopia(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.TipoComprobanteCopia SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoComprobanteCopia.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TipoComprobanteCopia WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoComprobanteCopia.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_TipoComprobanteCopia(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoComprobanteCopiaAlternativo                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoComprobanteCopiaAlternativo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.u_TipoComprobanteCopiaAlternativo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) CASCADE;

CREATE OR REPLACE FUNCTION massoftware.u_TipoComprobanteCopiaAlternativo(
		  idArg VARCHAR(36)

		, numeroArg INTEGER
		, nombreArg VARCHAR(50)
) RETURNS BOOLEAN AS $$

BEGIN

	UPDATE massoftware.TipoComprobanteCopiaAlternativo SET 
		  numero = numeroArg
		, nombre = nombreArg
	WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoComprobanteCopiaAlternativo.id = TRIM(idArg)::VARCHAR;

	RETURN ((SELECT COUNT(*) FROM massoftware.TipoComprobanteCopiaAlternativo WHERE idArg IS NOT NULL AND CHAR_LENGTH(TRIM(idArg)) > 0 AND TipoComprobanteCopiaAlternativo.id = TRIM(idArg)::VARCHAR) = 1)::BOOLEAN;

END;
$$ LANGUAGE plpgsql;

/*

SELECT * FROM massoftware.u_TipoComprobanteCopiaAlternativo(
		null::VARCHAR(36)
		, null::INTEGER
		, null::VARCHAR(50)
);

*/