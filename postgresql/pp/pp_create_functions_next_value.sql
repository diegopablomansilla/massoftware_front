


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
-- //          TABLA: MonedaCotizacion                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.MonedaCotizacion

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_MonedaCotizacion_compra() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_MonedaCotizacion_compra() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(compra),0) + 1)::DECIMAL(13,5) FROM massoftware.MonedaCotizacion;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_MonedaCotizacion_compra();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_MonedaCotizacion_venta() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_MonedaCotizacion_venta() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(venta),0) + 1)::DECIMAL(13,5) FROM massoftware.MonedaCotizacion;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_MonedaCotizacion_venta();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Banco                                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Banco

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Banco_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Banco_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Banco;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Banco_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Banco_cuit() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Banco_cuit() RETURNS BIGINT AS $$

	SELECT (COALESCE(MAX(cuit),0) + 1)::BIGINT FROM massoftware.Banco;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Banco_cuit();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Banco_hoja() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Banco_hoja() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(hoja),0) + 1)::INTEGER FROM massoftware.Banco;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Banco_hoja();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Banco_primeraFila() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Banco_primeraFila() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(primeraFila),0) + 1)::INTEGER FROM massoftware.Banco;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Banco_primeraFila();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Banco_ultimaFila() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Banco_ultimaFila() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(ultimaFila),0) + 1)::INTEGER FROM massoftware.Banco;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Banco_ultimaFila();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: BancoFirmante                                                                                          //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.BancoFirmante

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_BancoFirmante_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_BancoFirmante_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.BancoFirmante;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_BancoFirmante_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Caja                                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Caja

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Caja_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Caja_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Caja;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Caja_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondoTipo                                                                                        //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondoTipo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CuentaFondoTipo_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CuentaFondoTipo_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.CuentaFondoTipo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CuentaFondoTipo_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondoRubro                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondoRubro

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CuentaFondoRubro_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CuentaFondoRubro_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.CuentaFondoRubro;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CuentaFondoRubro_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondoGrupo                                                                                       //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondoGrupo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CuentaFondoGrupo_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CuentaFondoGrupo_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.CuentaFondoGrupo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CuentaFondoGrupo_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondoTipoBanco                                                                                   //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondoTipoBanco

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CuentaFondoTipoBanco_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CuentaFondoTipoBanco_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.CuentaFondoTipoBanco;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CuentaFondoTipoBanco_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondoBancoCopia                                                                                  //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondoBancoCopia

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CuentaFondoBancoCopia_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CuentaFondoBancoCopia_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.CuentaFondoBancoCopia;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CuentaFondoBancoCopia_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: CuentaFondo                                                                                            //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.CuentaFondo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CuentaFondo_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CuentaFondo_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.CuentaFondo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CuentaFondo_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CuentaFondo_limiteDescubierto() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CuentaFondo_limiteDescubierto() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(limiteDescubierto),0) + 1)::DECIMAL(13,5) FROM massoftware.CuentaFondo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CuentaFondo_limiteDescubierto();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_CuentaFondo_limiteOperacionIndividual() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_CuentaFondo_limiteOperacionIndividual() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(limiteOperacionIndividual),0) + 1)::DECIMAL(13,5) FROM massoftware.CuentaFondo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_CuentaFondo_limiteOperacionIndividual();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ComprobanteFondoModelo                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ComprobanteFondoModelo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_ComprobanteFondoModelo_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_ComprobanteFondoModelo_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.ComprobanteFondoModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_ComprobanteFondoModelo_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: ComprobanteFondoModeloItem                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.ComprobanteFondoModeloItem

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_ComprobanteFondoModeloItem_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_ComprobanteFondoModeloItem_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.ComprobanteFondoModeloItem;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_ComprobanteFondoModeloItem_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TalonarioLetra                                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TalonarioLetra


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TalonarioControladorFizcal                                                                             //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TalonarioControladorFizcal


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Talonario                                                                                              //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Talonario

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Talonario_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Talonario_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Talonario;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Talonario_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Talonario_puntoVenta() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Talonario_puntoVenta() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(puntoVenta),0) + 1)::INTEGER FROM massoftware.Talonario;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Talonario_puntoVenta();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Talonario_primerNumero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Talonario_primerNumero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(primerNumero),0) + 1)::INTEGER FROM massoftware.Talonario;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Talonario_primerNumero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Talonario_proximoNumero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Talonario_proximoNumero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(proximoNumero),0) + 1)::INTEGER FROM massoftware.Talonario;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Talonario_proximoNumero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Talonario_ultimoNumero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Talonario_ultimoNumero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(ultimoNumero),0) + 1)::INTEGER FROM massoftware.Talonario;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Talonario_ultimoNumero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Talonario_cantidadMinimaComprobantes() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Talonario_cantidadMinimaComprobantes() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(cantidadMinimaComprobantes),0) + 1)::INTEGER FROM massoftware.Talonario;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Talonario_cantidadMinimaComprobantes();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Talonario_numeroCAI() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Talonario_numeroCAI() RETURNS BIGINT AS $$

	SELECT (COALESCE(MAX(numeroCAI),0) + 1)::BIGINT FROM massoftware.Talonario;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Talonario_numeroCAI();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Talonario_diasAvisoVencimiento() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Talonario_diasAvisoVencimiento() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(diasAvisoVencimiento),0) + 1)::INTEGER FROM massoftware.Talonario;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Talonario_diasAvisoVencimiento();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TicketControlDenunciados                                                                               //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TicketControlDenunciados

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketControlDenunciados_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketControlDenunciados_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.TicketControlDenunciados;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketControlDenunciados_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Ticket                                                                                                 //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Ticket

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Ticket_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Ticket_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Ticket;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Ticket_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Ticket_cantidadPorLotes() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Ticket_cantidadPorLotes() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(cantidadPorLotes),0) + 1)::INTEGER FROM massoftware.Ticket;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Ticket_cantidadPorLotes();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Ticket_valorMaximo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Ticket_valorMaximo() RETURNS DECIMAL(13,5) AS $$

	SELECT (COALESCE(MAX(valorMaximo),0) + 1)::DECIMAL(13,5) FROM massoftware.Ticket;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Ticket_valorMaximo();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TicketModelo                                                                                           //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TicketModelo

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_longitudLectura() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_longitudLectura() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(longitudLectura),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_longitudLectura();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_identificacionPosicion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_identificacionPosicion() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(identificacionPosicion),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_identificacionPosicion();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_identificacion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_identificacion() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(identificacion),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_identificacion();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_importePosicion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_importePosicion() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(importePosicion),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_importePosicion();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_longitud() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_longitud() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(longitud),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_longitud();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_cantidadDecimales() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_cantidadDecimales() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(cantidadDecimales),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_cantidadDecimales();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_numeroPosicion() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_numeroPosicion() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numeroPosicion),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_numeroPosicion();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_numeroLongitud() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_numeroLongitud() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numeroLongitud),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_numeroLongitud();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_TicketModelo_posicionPrefijo() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_TicketModelo_posicionPrefijo() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(posicionPrefijo),0) + 1)::INTEGER FROM massoftware.TicketModelo;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_TicketModelo_posicionPrefijo();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: JuridiccionConvnioMultilateral                                                                         //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.JuridiccionConvnioMultilateral

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_JuridiccionConvnioMultilateral_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_JuridiccionConvnioMultilateral_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.JuridiccionConvnioMultilateral;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_JuridiccionConvnioMultilateral_numero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: Chequera                                                                                               //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.Chequera

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Chequera_numero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Chequera_numero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(numero),0) + 1)::INTEGER FROM massoftware.Chequera;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Chequera_numero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Chequera_primerNumero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Chequera_primerNumero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(primerNumero),0) + 1)::INTEGER FROM massoftware.Chequera;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Chequera_primerNumero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Chequera_ultimoNumero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Chequera_ultimoNumero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(ultimoNumero),0) + 1)::INTEGER FROM massoftware.Chequera;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Chequera_ultimoNumero();

-- ---------------------------------------------------------------------------------------------------------------------------


DROP FUNCTION IF EXISTS massoftware.f_next_Chequera_proximoNumero() CASCADE;

CREATE OR REPLACE FUNCTION massoftware.f_next_Chequera_proximoNumero() RETURNS INTEGER AS $$

	SELECT (COALESCE(MAX(proximoNumero),0) + 1)::INTEGER FROM massoftware.Chequera;

$$ LANGUAGE SQL;

-- SELECT * FROM massoftware.f_next_Chequera_proximoNumero();


-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-- //                                                                                                                        //
-- //          TABLA: TipoComprobanteConcepto                                                                                //
-- //                                                                                                                        //
-- ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


-- Table: massoftware.TipoComprobanteConcepto