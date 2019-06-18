


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Usuario                                                                                                //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Usuario

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Usuario_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Usuario_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Usuario;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Usuario_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: SeguridadModulo                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.SeguridadModulo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_SeguridadModulo_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_SeguridadModulo_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.SeguridadModulo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_SeguridadModulo_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: SeguridadPuerta                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.SeguridadPuerta

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_SeguridadPuerta_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_SeguridadPuerta_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.SeguridadPuerta;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_SeguridadPuerta_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Zona                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Zona

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Zona_bonificacion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Zona_bonificacion() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(bonificacion),0) + 1)::DECIMAL(13,5) FROM massoftware.Zona;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Zona_bonificacion();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Zona_recargo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Zona_recargo() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(recargo),0) + 1)::DECIMAL(13,5) FROM massoftware.Zona;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Zona_recargo();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Pais                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Pais

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Pais_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Pais_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Pais;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Pais_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Provincia                                                                                              //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Provincia

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Provincia_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Provincia_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Provincia;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Provincia_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Provincia_numeroAFIP() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Provincia_numeroAFIP() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numeroAFIP),0) + 1)::INTEGER FROM massoftware.Provincia;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Provincia_numeroAFIP();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Provincia_numeroIngresosBrutos() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Provincia_numeroIngresosBrutos() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numeroIngresosBrutos),0) + 1)::INTEGER FROM massoftware.Provincia;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Provincia_numeroIngresosBrutos();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Provincia_numeroRENATEA() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Provincia_numeroRENATEA() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numeroRENATEA),0) + 1)::INTEGER FROM massoftware.Provincia;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Provincia_numeroRENATEA();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Ciudad                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Ciudad

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Ciudad_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Ciudad_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Ciudad;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Ciudad_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Ciudad_numeroAFIP() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Ciudad_numeroAFIP() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numeroAFIP),0) + 1)::INTEGER FROM massoftware.Ciudad;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Ciudad_numeroAFIP();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CodigoPostal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CodigoPostal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CodigoPostal_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CodigoPostal_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.CodigoPostal;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CodigoPostal_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Transporte                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Transporte

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Transporte_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Transporte_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Transporte;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Transporte_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Transporte_cuit() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Transporte_cuit() RETURNS BIGINT AS $$

	SELECT (COALESCE(MAX(cuit),0) + 1)::BIGINT FROM massoftware.Transporte;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Transporte_cuit();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Carga                                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Carga

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Carga_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Carga_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Carga;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Carga_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TransporteTarifa                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TransporteTarifa

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TransporteTarifa_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_precioFlete() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_precioFlete() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(precioFlete),0) + 1)::DECIMAL(13,5) FROM massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TransporteTarifa_precioFlete();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_precioUnidadFacturacion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_precioUnidadFacturacion() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(precioUnidadFacturacion),0) + 1)::DECIMAL(13,5) FROM massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TransporteTarifa_precioUnidadFacturacion();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_precioUnidadStock() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_precioUnidadStock() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(precioUnidadStock),0) + 1)::DECIMAL(13,5) FROM massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TransporteTarifa_precioUnidadStock();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_precioBultos() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_precioBultos() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(precioBultos),0) + 1)::DECIMAL(13,5) FROM massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TransporteTarifa_precioBultos();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_importeMinimoEntrega() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_importeMinimoEntrega() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(importeMinimoEntrega),0) + 1)::DECIMAL(13,5) FROM massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TransporteTarifa_importeMinimoEntrega();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TransporteTarifa_importeMinimoCarga() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TransporteTarifa_importeMinimoCarga() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(importeMinimoCarga),0) + 1)::DECIMAL(13,5) FROM massoftware.TransporteTarifa;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TransporteTarifa_importeMinimoCarga();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoDocumentoAFIP                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoDocumentoAFIP

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TipoDocumentoAFIP_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TipoDocumentoAFIP_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.TipoDocumentoAFIP;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TipoDocumentoAFIP_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MonedaAFIP                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MonedaAFIP


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Moneda                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Moneda

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Moneda_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Moneda_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Moneda;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Moneda_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Moneda_cotizacion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Moneda_cotizacion() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(cotizacion),0) + 1)::DECIMAL(13,5) FROM massoftware.Moneda;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Moneda_cotizacion();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: NotaCreditoMotivo                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.NotaCreditoMotivo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_NotaCreditoMotivo_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_NotaCreditoMotivo_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.NotaCreditoMotivo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_NotaCreditoMotivo_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoComentario                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoComentario

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_MotivoComentario_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_MotivoComentario_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.MotivoComentario;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_MotivoComentario_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoCliente                                                                                            //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TipoCliente_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TipoCliente_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.TipoCliente;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TipoCliente_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ClasificacionCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ClasificacionCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_ClasificacionCliente_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_ClasificacionCliente_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.ClasificacionCliente;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_ClasificacionCliente_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_ClasificacionCliente_color() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_ClasificacionCliente_color() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(color),0) + 1)::INTEGER FROM massoftware.ClasificacionCliente;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_ClasificacionCliente_color();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MotivoBloqueoCliente                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MotivoBloqueoCliente

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_MotivoBloqueoCliente_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_MotivoBloqueoCliente_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.MotivoBloqueoCliente;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_MotivoBloqueoCliente_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoSucursal                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoSucursal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TipoSucursal_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TipoSucursal_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.TipoSucursal;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TipoSucursal_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Sucursal                                                                                               //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Sucursal

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Sucursal_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Sucursal_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Sucursal;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Sucursal_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Sucursal_cantidadCaracteresClientes() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Sucursal_cantidadCaracteresClientes() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(cantidadCaracteresClientes),0) + 1)::INTEGER FROM massoftware.Sucursal;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Sucursal_cantidadCaracteresClientes();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Sucursal_cantidadCaracteresProveedores() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Sucursal_cantidadCaracteresProveedores() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(cantidadCaracteresProveedores),0) + 1)::INTEGER FROM massoftware.Sucursal;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Sucursal_cantidadCaracteresProveedores();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Sucursal_clientesOcacionalesDesde() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Sucursal_clientesOcacionalesDesde() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(clientesOcacionalesDesde),0) + 1)::INTEGER FROM massoftware.Sucursal;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Sucursal_clientesOcacionalesDesde();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Sucursal_clientesOcacionalesHasta() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Sucursal_clientesOcacionalesHasta() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(clientesOcacionalesHasta),0) + 1)::INTEGER FROM massoftware.Sucursal;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Sucursal_clientesOcacionalesHasta();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Sucursal_numeroCobranzaDesde() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Sucursal_numeroCobranzaDesde() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numeroCobranzaDesde),0) + 1)::INTEGER FROM massoftware.Sucursal;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Sucursal_numeroCobranzaDesde();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Sucursal_numeroCobranzaHasta() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Sucursal_numeroCobranzaHasta() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numeroCobranzaHasta),0) + 1)::INTEGER FROM massoftware.Sucursal;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Sucursal_numeroCobranzaHasta();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: DepositoModulo                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.DepositoModulo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_DepositoModulo_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_DepositoModulo_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.DepositoModulo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_DepositoModulo_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Deposito                                                                                               //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Deposito

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Deposito_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Deposito_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Deposito;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Deposito_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: EjercicioContable                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.EjercicioContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_EjercicioContable_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_EjercicioContable_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.EjercicioContable;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_EjercicioContable_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CentroCostoContable                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CentroCostoContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CentroCostoContable_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CentroCostoContable_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.CentroCostoContable;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CentroCostoContable_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoPuntoEquilibrio                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoPuntoEquilibrio

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TipoPuntoEquilibrio_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TipoPuntoEquilibrio_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.TipoPuntoEquilibrio;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TipoPuntoEquilibrio_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: PuntoEquilibrio                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.PuntoEquilibrio

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_PuntoEquilibrio_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_PuntoEquilibrio_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.PuntoEquilibrio;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_PuntoEquilibrio_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CostoVenta                                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CostoVenta

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CostoVenta_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CostoVenta_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.CostoVenta;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CostoVenta_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaContableEstado                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaContableEstado

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CuentaContableEstado_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CuentaContableEstado_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.CuentaContableEstado;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CuentaContableEstado_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaContable                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CuentaContable_porcentaje() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CuentaContable_porcentaje() RETURNS DECIMAL(6,3) AS $$

	SELECT (COALESCE(MAX(porcentaje),0) + 1)::DECIMAL(6,3) FROM massoftware.CuentaContable;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CuentaContable_porcentaje();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoModelo                                                                                          //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoModelo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_AsientoModelo_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_AsientoModelo_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.AsientoModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_AsientoModelo_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoModeloItem                                                                                      //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoModeloItem

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_AsientoModeloItem_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_AsientoModeloItem_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.AsientoModeloItem;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_AsientoModeloItem_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: MinutaContable                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MinutaContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_MinutaContable_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_MinutaContable_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.MinutaContable;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_MinutaContable_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContableModulo                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoContableModulo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_AsientoContableModulo_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_AsientoContableModulo_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.AsientoContableModulo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_AsientoContableModulo_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContable                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoContable

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_AsientoContable_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_AsientoContable_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.AsientoContable;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_AsientoContable_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: AsientoContableItem                                                                                    //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.AsientoContableItem

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_AsientoContableItem_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_AsientoContableItem_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.AsientoContableItem;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_AsientoContableItem_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_AsientoContableItem_debe() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_AsientoContableItem_debe() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(debe),0) + 1)::DECIMAL(13,5) FROM massoftware.AsientoContableItem;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_AsientoContableItem_debe();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_AsientoContableItem_haber() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_AsientoContableItem_haber() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(haber),0) + 1)::DECIMAL(13,5) FROM massoftware.AsientoContableItem;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_AsientoContableItem_haber();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Empresa                                                                                                //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Empresa