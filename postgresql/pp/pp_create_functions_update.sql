


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