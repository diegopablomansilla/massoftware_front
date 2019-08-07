package com.massoftware.x;

import com.massoftware.custom.x.fondos.banco.WFBancoCustom;
import com.massoftware.custom.x.fondos.banco.WLBancoCustom;
import com.massoftware.model.geo.Pais;
import com.massoftware.service.afip.MonedaAFIPFiltro;
import com.massoftware.service.afip.TipoDocumentoAFIPFiltro;
import com.massoftware.service.clientes.ClasificacionClienteFiltro;
import com.massoftware.service.clientes.MotivoBloqueoClienteFiltro;
import com.massoftware.service.clientes.MotivoComentarioFiltro;
import com.massoftware.service.clientes.TipoClienteFiltro;
import com.massoftware.service.contabilidad.ventas.NotaCreditoMotivoFiltro;
import com.massoftware.service.fondos.banco.BancoFiltro;
import com.massoftware.service.geo.CiudadFiltro;
import com.massoftware.service.geo.CodigoPostalFiltro;
import com.massoftware.service.geo.PaisFiltro;
import com.massoftware.service.geo.ProvinciaFiltro;
import com.massoftware.service.geo.ZonaFiltro;
import com.massoftware.service.logistica.CargaFiltro;
import com.massoftware.service.logistica.TransporteFiltro;
import com.massoftware.service.logistica.TransporteTarifaFiltro;
import com.massoftware.service.monedas.MonedaFiltro;
import com.massoftware.x.afip.WFMonedaCustom;
import com.massoftware.x.afip.WLMonedaAFIP;
import com.massoftware.x.afip.WLMonedaAFIPCustom;
import com.massoftware.x.afip.WLTipoDocumentoAFIP;
import com.massoftware.x.afip.WLTipoDocumentoAFIPCustom;
import com.massoftware.x.clientes.WLClasificacionCliente;
import com.massoftware.x.clientes.WLClasificacionClienteCustom;
import com.massoftware.x.clientes.WLMotivoBloqueoCliente;
import com.massoftware.x.clientes.WLMotivoBloqueoClienteCustom;
import com.massoftware.x.clientes.WLMotivoComentario;
import com.massoftware.x.clientes.WLMotivoComentarioCustom;
import com.massoftware.x.clientes.WLTipoCliente;
import com.massoftware.x.clientes.WLTipoClienteCustom;
import com.massoftware.x.contabilidad.ventas.WLNotaCreditoMotivo;
import com.massoftware.x.contabilidad.ventas.WLNotaCreditoMotivoCustom;
import com.massoftware.x.geo.WFCiudad;
import com.massoftware.x.geo.WFCiudadCustom;
import com.massoftware.x.geo.WFProvincia;
import com.massoftware.x.geo.WFProvinciaCustom;
import com.massoftware.x.geo.WLCiudad;
import com.massoftware.x.geo.WLCiudadCustom;
import com.massoftware.x.geo.WLCodigoPostal;
import com.massoftware.x.geo.WLCodigoPostalCustom;
import com.massoftware.x.geo.WLPais;
import com.massoftware.x.geo.WLPaisCustom;
import com.massoftware.x.geo.WLProvincia;
import com.massoftware.x.geo.WLProvinciaCustom;
import com.massoftware.x.geo.WLZona;
import com.massoftware.x.geo.WLZonaCustom;
import com.massoftware.x.logistica.WFTransporte;
import com.massoftware.x.logistica.WFTransporteCustom;
import com.massoftware.x.logistica.WFTransporteTarifa;
import com.massoftware.x.logistica.WFTransporteTarifaCustom;
import com.massoftware.x.logistica.WLCarga;
import com.massoftware.x.logistica.WLCargaCustom;
import com.massoftware.x.logistica.WLTransporte;
import com.massoftware.x.logistica.WLTransporteCustom;
import com.massoftware.x.logistica.WLTransporteTarifa;
import com.massoftware.x.logistica.WLTransporteTarifaCustom;
import com.massoftware.x.monedas.WFMoneda;
import com.massoftware.x.monedas.WLMoneda;
import com.massoftware.x.monedas.WLMonedaCustom;

public class FactoryWidgetImpl extends AbstractFactoryWidget {

	// -------------------------------------------------------------------------
//	public WLUsuario buildWLUsuario() throws Exception {
//		return new WLUsuarioCustom();
//	}
//
//	public WLUsuario buildWLUsuario(UsuarioFiltro filtro) throws Exception {
//		return new WLUsuarioCustom(filtro);
//	}
//
//	public WFUsuario buildWFUsuario(String mode, String id) throws Exception {
//		return new WFUsuarioCustom(mode, id);
//	}

	// -------------------------------------------------------------------------
	public WLZona buildWLZona() throws Exception {
		return new WLZonaCustom();
	}

	public WLZona buildWLZona(ZonaFiltro filtro) throws Exception {
		return new WLZonaCustom(filtro);
	}

//	public WFZona buildWFZona(String mode, String id) throws Exception {
//		return new WFZonaCustom(mode, id);
//	}

	// -------------------------------------------------------------------------
	public WLPais buildWLPais() throws Exception {
		return new WLPaisCustom();
	}

	public WLPais buildWLPais(PaisFiltro filtro) throws Exception {
		return new WLPaisCustom(filtro);
	}

//	public WFPais buildWFPais(String mode, String id) throws Exception {
//		return new WFPaisCustom(mode, id);
//	}

	// -------------------------------------------------------------------------
	public WLProvincia buildWLProvincia() throws Exception {
		return new WLProvinciaCustom();
	}

	public WLProvincia buildWLProvincia(ProvinciaFiltro filtro) throws Exception {
		return new WLProvinciaCustom(filtro);
	}

	public WFProvincia buildWFProvincia(String mode, String id) throws Exception {
		return new WFProvinciaCustom(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLCiudad buildWLCiudad() throws Exception {
		return new WLCiudadCustom();
	}

	public WLCiudad buildWLCiudad(CiudadFiltro filtro) throws Exception {
		return new WLCiudadCustom(filtro);
	}

//	public WFCiudad buildWFCiudad(String mode, String id) throws Exception {
//		return new WFCiudadCustom(mode, id);
//	}
	
	public WFCiudad buildWFCiudad(String mode, String id, Pais pais) throws Exception {
		return new WFCiudadCustom(mode, id, pais);
	}

	// -------------------------------------------------------------------------
	public WLCodigoPostal buildWLCodigoPostal() throws Exception {
		return new WLCodigoPostalCustom();
	}

	public WLCodigoPostal buildWLCodigoPostal(CodigoPostalFiltro filtro) throws Exception {
		return new WLCodigoPostalCustom(filtro);
	}

//	public WFCodigoPostal buildWFCodigoPostal(String mode, String id) throws Exception {
//		return new WFCodigoPostalCustom(mode, id);
//	}

	// -------------------------------------------------------------------------
	public WLTransporte buildWLTransporte() throws Exception {
		return new WLTransporteCustom();
	}

	public WLTransporte buildWLTransporte(TransporteFiltro filtro) throws Exception {
		return new WLTransporteCustom(filtro);
	}

	public WFTransporte buildWFTransporte(String mode, String id) throws Exception {
		return new WFTransporteCustom(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLCarga buildWLCarga() throws Exception {
		return new WLCargaCustom();
	}

	public WLCarga buildWLCarga(CargaFiltro filtro) throws Exception {
		return new WLCargaCustom(filtro);
	}

//	public WFCarga buildWFCarga(String mode, String id) throws Exception {
//		return new WFCargaCustom(mode, id);
//	}

	// -------------------------------------------------------------------------
	public WLTransporteTarifa buildWLTransporteTarifa() throws Exception {
		return new WLTransporteTarifaCustom();
	}

	public WLTransporteTarifa buildWLTransporteTarifa(TransporteTarifaFiltro filtro) throws Exception {
		return new WLTransporteTarifaCustom(filtro);
	}

	public WFTransporteTarifa buildWFTransporteTarifa(String mode, String id) throws Exception {
		return new WFTransporteTarifaCustom(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLTipoDocumentoAFIP buildWLTipoDocumentoAFIP() throws Exception {
		return new WLTipoDocumentoAFIPCustom();
	}

	public WLTipoDocumentoAFIP buildWLTipoDocumentoAFIP(TipoDocumentoAFIPFiltro filtro) throws Exception {
		return new WLTipoDocumentoAFIPCustom(filtro);
	}

//	public WFTipoDocumentoAFIP buildWFTipoDocumentoAFIP(String mode, String id) throws Exception {
//		return new WFTipoDocumentoAFIPCustom(mode, id);
//	}

	// -------------------------------------------------------------------------
	public WLMonedaAFIP buildWLMonedaAFIP() throws Exception {
		return new WLMonedaAFIPCustom();
	}

	public WLMonedaAFIP buildWLMonedaAFIP(MonedaAFIPFiltro filtro) throws Exception {
		return new WLMonedaAFIPCustom(filtro);
	}

//	public WFMonedaAFIP buildWFMonedaAFIP(String mode, String id) throws Exception {
//		return new WFMonedaAFIPCustom(mode, id);
//	}

	// -------------------------------------------------------------------------
	public WLMoneda buildWLMoneda() throws Exception {
		return new WLMonedaCustom();
	}

	public WLMoneda buildWLMoneda(MonedaFiltro filtro) throws Exception {
		return new WLMonedaCustom(filtro);
	}

	public WFMoneda buildWFMoneda(String mode, String id) throws Exception {
		return new WFMonedaCustom(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLNotaCreditoMotivo buildWLNotaCreditoMotivo() throws Exception {
		return new WLNotaCreditoMotivoCustom();
	}

	public WLNotaCreditoMotivo buildWLNotaCreditoMotivo(NotaCreditoMotivoFiltro filtro) throws Exception {
		return new WLNotaCreditoMotivoCustom(filtro);
	}

//	public WFNotaCreditoMotivo buildWFNotaCreditoMotivo(String mode, String id) throws Exception {
//		return new WFNotaCreditoMotivoCustom(mode, id);
//	}

	// -------------------------------------------------------------------------
	public WLMotivoComentario buildWLMotivoComentario() throws Exception {
		return new WLMotivoComentarioCustom();
	}

	public WLMotivoComentario buildWLMotivoComentario(MotivoComentarioFiltro filtro) throws Exception {
		return new WLMotivoComentarioCustom(filtro);
	}

//	public WFMotivoComentario buildWFMotivoComentario(String mode, String id) throws Exception {
//		return new WFMotivoComentarioCustom(mode, id);
//	}

	// -------------------------------------------------------------------------
	public WLTipoCliente buildWLTipoCliente() throws Exception {
		return new WLTipoClienteCustom();
	}

	public WLTipoCliente buildWLTipoCliente(TipoClienteFiltro filtro) throws Exception {
		return new WLTipoClienteCustom(filtro);
	}

//	public WFTipoCliente buildWFTipoCliente(String mode, String id) throws Exception {
//		return new WFTipoClienteCustom(mode, id);
//	}

	// -------------------------------------------------------------------------
	public WLClasificacionCliente buildWLClasificacionCliente() throws Exception {
		return new WLClasificacionClienteCustom();
	}

	public WLClasificacionCliente buildWLClasificacionCliente(ClasificacionClienteFiltro filtro) throws Exception {
		return new WLClasificacionClienteCustom(filtro);
	}

//	public WFClasificacionCliente buildWFClasificacionCliente(String mode, String id) throws Exception {
//		return new WFClasificacionClienteCustom(mode, id);
//	}

	// -------------------------------------------------------------------------
	public WLMotivoBloqueoCliente buildWLMotivoBloqueoCliente() throws Exception {
		return new WLMotivoBloqueoClienteCustom();
	}

	public WLMotivoBloqueoCliente buildWLMotivoBloqueoCliente(MotivoBloqueoClienteFiltro filtro) throws Exception {
		return new WLMotivoBloqueoClienteCustom(filtro);
	}

//	public WFMotivoBloqueoCliente buildWFMotivoBloqueoCliente(String mode, String id) throws Exception {
//		return new WFMotivoBloqueoClienteCustom(mode, id);
//	}
	
	// -------------------------------------------------------------------------
	public WLBancoCustom buildWLBanco() throws Exception {
		return new WLBancoCustom();
	}
	public WLBancoCustom buildWLBanco(BancoFiltro filtro) throws Exception {
		return new WLBancoCustom(filtro);
	}
	public WFBancoCustom buildWFBanco(String mode, String id) throws Exception {
		return new WFBancoCustom(mode, id);
	}

}