package com.massoftware.x;

import com.massoftware.service.seguridad.UsuarioFiltro;
import com.massoftware.x.seguridad.WLUsuario;
import com.massoftware.x.seguridad.WFUsuario;
import com.massoftware.service.geo.ZonaFiltro;
import com.massoftware.x.geo.WLZona;
import com.massoftware.x.geo.WFZona;
import com.massoftware.service.geo.PaisFiltro;
import com.massoftware.x.geo.WLPais;
import com.massoftware.x.geo.WFPais;
import com.massoftware.service.geo.ProvinciaFiltro;
import com.massoftware.x.geo.WLProvincia;
import com.massoftware.x.geo.WFProvincia;
import com.massoftware.service.geo.CiudadFiltro;
import com.massoftware.x.geo.WLCiudad;
import com.massoftware.x.geo.WFCiudad;
import com.massoftware.service.geo.CodigoPostalFiltro;
import com.massoftware.x.geo.WLCodigoPostal;
import com.massoftware.x.geo.WFCodigoPostal;
import com.massoftware.service.logistica.TransporteFiltro;
import com.massoftware.x.logistica.WLTransporte;
import com.massoftware.x.logistica.WFTransporte;
import com.massoftware.service.logistica.CargaFiltro;
import com.massoftware.x.logistica.WLCarga;
import com.massoftware.x.logistica.WFCarga;
import com.massoftware.service.logistica.TransporteTarifaFiltro;
import com.massoftware.x.logistica.WLTransporteTarifa;
import com.massoftware.x.logistica.WFTransporteTarifa;
import com.massoftware.service.afip.TipoDocumentoAFIPFiltro;
import com.massoftware.x.afip.WLTipoDocumentoAFIP;
import com.massoftware.x.afip.WFTipoDocumentoAFIP;
import com.massoftware.service.afip.MonedaAFIPFiltro;
import com.massoftware.x.afip.WLMonedaAFIP;
import com.massoftware.x.afip.WFMonedaAFIP;
import com.massoftware.service.monedas.MonedaFiltro;
import com.massoftware.x.monedas.WLMoneda;
import com.massoftware.x.monedas.WFMoneda;
import com.massoftware.service.contabilidad.ventas.NotaCreditoMotivoFiltro;
import com.massoftware.x.contabilidad.ventas.WLNotaCreditoMotivo;
import com.massoftware.x.contabilidad.ventas.WFNotaCreditoMotivo;
import com.massoftware.service.clientes.MotivoComentarioFiltro;
import com.massoftware.x.clientes.WLMotivoComentario;
import com.massoftware.x.clientes.WFMotivoComentario;
import com.massoftware.service.clientes.TipoClienteFiltro;
import com.massoftware.x.clientes.WLTipoCliente;
import com.massoftware.x.clientes.WFTipoCliente;
import com.massoftware.service.clientes.ClasificacionClienteFiltro;
import com.massoftware.x.clientes.WLClasificacionCliente;
import com.massoftware.x.clientes.WFClasificacionCliente;
import com.massoftware.service.clientes.MotivoBloqueoClienteFiltro;
import com.massoftware.x.clientes.WLMotivoBloqueoCliente;
import com.massoftware.x.clientes.WFMotivoBloqueoCliente;


public abstract class AbstractFactoryWidget {


	// -------------------------------------------------------------------------
	public WLUsuario buildWLUsuario() throws Exception {
		return new WLUsuario();
	}
	public WLUsuario buildWLUsuario(UsuarioFiltro filtro) throws Exception {
		return new WLUsuario(filtro);
	}
	public WFUsuario buildWFUsuario(String mode, String id) throws Exception {
		return new WFUsuario(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLZona buildWLZona() throws Exception {
		return new WLZona();
	}
	public WLZona buildWLZona(ZonaFiltro filtro) throws Exception {
		return new WLZona(filtro);
	}
	public WFZona buildWFZona(String mode, String id) throws Exception {
		return new WFZona(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLPais buildWLPais() throws Exception {
		return new WLPais();
	}
	public WLPais buildWLPais(PaisFiltro filtro) throws Exception {
		return new WLPais(filtro);
	}
	public WFPais buildWFPais(String mode, String id) throws Exception {
		return new WFPais(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLProvincia buildWLProvincia() throws Exception {
		return new WLProvincia();
	}
	public WLProvincia buildWLProvincia(ProvinciaFiltro filtro) throws Exception {
		return new WLProvincia(filtro);
	}
	public WFProvincia buildWFProvincia(String mode, String id) throws Exception {
		return new WFProvincia(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLCiudad buildWLCiudad() throws Exception {
		return new WLCiudad();
	}
	public WLCiudad buildWLCiudad(CiudadFiltro filtro) throws Exception {
		return new WLCiudad(filtro);
	}
	public WFCiudad buildWFCiudad(String mode, String id) throws Exception {
		return new WFCiudad(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLCodigoPostal buildWLCodigoPostal() throws Exception {
		return new WLCodigoPostal();
	}
	public WLCodigoPostal buildWLCodigoPostal(CodigoPostalFiltro filtro) throws Exception {
		return new WLCodigoPostal(filtro);
	}
	public WFCodigoPostal buildWFCodigoPostal(String mode, String id) throws Exception {
		return new WFCodigoPostal(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLTransporte buildWLTransporte() throws Exception {
		return new WLTransporte();
	}
	public WLTransporte buildWLTransporte(TransporteFiltro filtro) throws Exception {
		return new WLTransporte(filtro);
	}
	public WFTransporte buildWFTransporte(String mode, String id) throws Exception {
		return new WFTransporte(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLCarga buildWLCarga() throws Exception {
		return new WLCarga();
	}
	public WLCarga buildWLCarga(CargaFiltro filtro) throws Exception {
		return new WLCarga(filtro);
	}
	public WFCarga buildWFCarga(String mode, String id) throws Exception {
		return new WFCarga(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLTransporteTarifa buildWLTransporteTarifa() throws Exception {
		return new WLTransporteTarifa();
	}
	public WLTransporteTarifa buildWLTransporteTarifa(TransporteTarifaFiltro filtro) throws Exception {
		return new WLTransporteTarifa(filtro);
	}
	public WFTransporteTarifa buildWFTransporteTarifa(String mode, String id) throws Exception {
		return new WFTransporteTarifa(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLTipoDocumentoAFIP buildWLTipoDocumentoAFIP() throws Exception {
		return new WLTipoDocumentoAFIP();
	}
	public WLTipoDocumentoAFIP buildWLTipoDocumentoAFIP(TipoDocumentoAFIPFiltro filtro) throws Exception {
		return new WLTipoDocumentoAFIP(filtro);
	}
	public WFTipoDocumentoAFIP buildWFTipoDocumentoAFIP(String mode, String id) throws Exception {
		return new WFTipoDocumentoAFIP(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLMonedaAFIP buildWLMonedaAFIP() throws Exception {
		return new WLMonedaAFIP();
	}
	public WLMonedaAFIP buildWLMonedaAFIP(MonedaAFIPFiltro filtro) throws Exception {
		return new WLMonedaAFIP(filtro);
	}
	public WFMonedaAFIP buildWFMonedaAFIP(String mode, String id) throws Exception {
		return new WFMonedaAFIP(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLMoneda buildWLMoneda() throws Exception {
		return new WLMoneda();
	}
	public WLMoneda buildWLMoneda(MonedaFiltro filtro) throws Exception {
		return new WLMoneda(filtro);
	}
	public WFMoneda buildWFMoneda(String mode, String id) throws Exception {
		return new WFMoneda(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLNotaCreditoMotivo buildWLNotaCreditoMotivo() throws Exception {
		return new WLNotaCreditoMotivo();
	}
	public WLNotaCreditoMotivo buildWLNotaCreditoMotivo(NotaCreditoMotivoFiltro filtro) throws Exception {
		return new WLNotaCreditoMotivo(filtro);
	}
	public WFNotaCreditoMotivo buildWFNotaCreditoMotivo(String mode, String id) throws Exception {
		return new WFNotaCreditoMotivo(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLMotivoComentario buildWLMotivoComentario() throws Exception {
		return new WLMotivoComentario();
	}
	public WLMotivoComentario buildWLMotivoComentario(MotivoComentarioFiltro filtro) throws Exception {
		return new WLMotivoComentario(filtro);
	}
	public WFMotivoComentario buildWFMotivoComentario(String mode, String id) throws Exception {
		return new WFMotivoComentario(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLTipoCliente buildWLTipoCliente() throws Exception {
		return new WLTipoCliente();
	}
	public WLTipoCliente buildWLTipoCliente(TipoClienteFiltro filtro) throws Exception {
		return new WLTipoCliente(filtro);
	}
	public WFTipoCliente buildWFTipoCliente(String mode, String id) throws Exception {
		return new WFTipoCliente(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLClasificacionCliente buildWLClasificacionCliente() throws Exception {
		return new WLClasificacionCliente();
	}
	public WLClasificacionCliente buildWLClasificacionCliente(ClasificacionClienteFiltro filtro) throws Exception {
		return new WLClasificacionCliente(filtro);
	}
	public WFClasificacionCliente buildWFClasificacionCliente(String mode, String id) throws Exception {
		return new WFClasificacionCliente(mode, id);
	}

	// -------------------------------------------------------------------------
	public WLMotivoBloqueoCliente buildWLMotivoBloqueoCliente() throws Exception {
		return new WLMotivoBloqueoCliente();
	}
	public WLMotivoBloqueoCliente buildWLMotivoBloqueoCliente(MotivoBloqueoClienteFiltro filtro) throws Exception {
		return new WLMotivoBloqueoCliente(filtro);
	}
	public WFMotivoBloqueoCliente buildWFMotivoBloqueoCliente(String mode, String id) throws Exception {
		return new WFMotivoBloqueoCliente(mode, id);
	}

}