package com.massoftware.x;

import com.massoftware.dao.afip.monedas.MonedaAFIPFiltro;
import com.massoftware.dao.geo.PaisFiltro;
import com.massoftware.dao.geo.ProvinciaFiltro;
import com.massoftware.model.geo.Pais;
import com.massoftware.x.afip.WFTipoDocumentoAFIP;
import com.massoftware.x.afip.WLTipoDocumentoAFIPCustom;
import com.massoftware.x.afip.monedas.WFMonedaAFIP;
import com.massoftware.x.afip.monedas.WLMonedaAFIPCustom;
import com.massoftware.x.clientes.WFMotivoComentario;
import com.massoftware.x.clientes.WFTipoCliente;
import com.massoftware.x.clientes.WLMotivoComentarioCustom;
import com.massoftware.x.clientes.WLTipoClienteCustom;
import com.massoftware.x.contabilidad.ventas.WFNotaCreditoMotivo;
import com.massoftware.x.contabilidad.ventas.WLNotaCreditoMotivoCustom;
import com.massoftware.x.geo.WFCiudad;
import com.massoftware.x.geo.WFCiudadCustom;
import com.massoftware.x.geo.WFPais;
import com.massoftware.x.geo.WFProvinciaCustom;
import com.massoftware.x.geo.WFZona;
import com.massoftware.x.geo.WLCiudadCustom;
import com.massoftware.x.geo.WLPaisCustom;
import com.massoftware.x.geo.WLProvinciaCustom;
import com.massoftware.x.geo.WLZonaCustom;
import com.massoftware.x.monedas.WFMoneda;
import com.massoftware.x.seguridad.WFUsuario;

public class WindowBuilder {

	// ------------------------------------------

	public WFUsuario buildWFUsuario(String mode, String id) throws Exception {
		return new WFUsuario(mode, id);
	}

	// ------------------------------------------

	public WFTipoCliente buildWFTipoCliente(String mode, String id) throws Exception {
		return new WFTipoCliente(mode, id);
	}
	
	public WLTipoClienteCustom buildWLTipoCliente() throws Exception {
		return new WLTipoClienteCustom();
	}

	// ------------------------------------------

	public WFMotivoComentario buildWFMotivoComentario(String mode, String id) throws Exception {
		return new WFMotivoComentario(mode, id);
	}
	
	public WLNotaCreditoMotivoCustom buildWLNotaCreditoMotivo() throws Exception {
		return new WLNotaCreditoMotivoCustom();
	}

	// ------------------------------------------

	public WFNotaCreditoMotivo buildWFNotaCreditoMotivo(String mode, String id) throws Exception {
		return new WFNotaCreditoMotivo(mode, id);
	}
	
	public WLMotivoComentarioCustom buildWLMotivoComentario() throws Exception {
		return new WLMotivoComentarioCustom();
	}

	// ------------------------------------------

	public WFZona buildWFZona(String mode, String id) throws Exception {
		return new WFZona(mode, id);
	}
	
	public WLZonaCustom buildWLZona() throws Exception {
		return new WLZonaCustom();
	}

	// ------------------------------------------

	public WFMoneda buildWFMoneda(String mode, String id) throws Exception {
		return new WFMoneda(mode, id);
	}

	// ------------------------------------------

	public WLMonedaAFIPCustom buildWLMonedaAFIP() throws Exception {
		return new WLMonedaAFIPCustom();
	}

	public WLMonedaAFIPCustom buildWLMonedaAFIP(MonedaAFIPFiltro filtro) throws Exception {
		return new WLMonedaAFIPCustom(filtro);
	}

	public WFMonedaAFIP buildWFMonedaAFIP(String mode, String id) throws Exception {
		return new WFMonedaAFIP(mode, id);
	}

	// ------------------------------------------

	public WLPaisCustom buildWLPais() throws Exception {
		return new WLPaisCustom();
	}

	public WLPaisCustom buildWLPais(PaisFiltro filtro) throws Exception {
		return new WLPaisCustom(filtro);
	}

	public WFPais buildWFPais(String mode, String id) throws Exception {
		return new WFPais(mode, id);
	}

	// ------------------------------------------

	public WLProvinciaCustom buildWLProvincia() throws Exception {
		return new WLProvinciaCustom();
	}

	public WLProvinciaCustom buildWLProvincia(ProvinciaFiltro filtro) throws Exception {
		return new WLProvinciaCustom(filtro);
	}

	public WFProvinciaCustom buildWFProvincia(String mode, String id) throws Exception {
		return new WFProvinciaCustom(mode, id);
	}

	// ------------------------------------------
	
	public WLCiudadCustom buildWLCiudad() throws Exception {
		return new WLCiudadCustom();
	}

	public WFCiudad buildWFCiudad(String mode, String id) throws Exception {
		return new WFCiudad(mode, id);
	}

	public WFCiudadCustom buildWFCiudad(String mode, String id, Pais pais) throws Exception {
		return new WFCiudadCustom(mode, id, pais);
	}

	// ------------------------------------------

	public WLTipoDocumentoAFIPCustom buildWLTipoDocumentoAFIP() throws Exception {
		return new WLTipoDocumentoAFIPCustom();
	}

	public WFTipoDocumentoAFIP buildWFTipoDocumentoAFIP(String mode, String id) {
		return new WFTipoDocumentoAFIP(mode, id);
	}

	// ------------------------------------------

}
