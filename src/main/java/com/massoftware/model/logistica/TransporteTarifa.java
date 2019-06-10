package com.massoftware.model.logistica;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.logistica.Carga;
import com.massoftware.model.geo.Ciudad;

@ClassLabelAnont(singular = "Tarifa de transporte", plural = "Tarifas de transporte", singularPre = "la tarifa de transporte", pluralPre = "las tarifas de transporte")
public class TransporteTarifa extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº opción
	@FieldConfAnont(label = "Nº opción", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Carga
	@FieldConfAnont(label = "Carga", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Carga carga;

	// Ciudad
	@FieldConfAnont(label = "Ciudad", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Ciudad ciudad;

	// Precio flete
	@FieldConfAnont(label = "Precio flete", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "-9999.9999", maxValue = "99999.9999", mask = "")
	private java.math.BigDecimal precioFlete;

	// Precio unidad facturación
	@FieldConfAnont(label = "Precio unidad facturación", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "-9999.9999", maxValue = "99999.9999", mask = "")
	private java.math.BigDecimal precioUnidadFacturacion;

	// Precio unidad stock
	@FieldConfAnont(label = "Precio unidad stock", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "-9999.9999", maxValue = "99999.9999", mask = "")
	private java.math.BigDecimal precioUnidadStock;

	// Precio bultos
	@FieldConfAnont(label = "Precio bultos", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "-9999.9999", maxValue = "99999.9999", mask = "")
	private java.math.BigDecimal precioBultos;

	// Importe mínimo por entrega
	@FieldConfAnont(label = "Importe mínimo por entrega", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "-9999.9999", maxValue = "99999.9999", mask = "")
	private java.math.BigDecimal importeMinimoEntrega;

	// Importe mínimo por carga
	@FieldConfAnont(label = "Importe mínimo por carga", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "-9999.9999", maxValue = "99999.9999", mask = "")
	private java.math.BigDecimal importeMinimoCarga;

	// ---------------------------------------------------------------------------------------------------------------------------


	public TransporteTarifa() throws Exception {
	}

	public TransporteTarifa(String idArg0, Integer numeroArg1, String idCargaArg2, String idCiudadArg3, java.math.BigDecimal precioFleteArg4, java.math.BigDecimal precioUnidadFacturacionArg5, java.math.BigDecimal precioUnidadStockArg6, java.math.BigDecimal precioBultosArg7, java.math.BigDecimal importeMinimoEntregaArg8, java.math.BigDecimal importeMinimoCargaArg9) throws Exception {

		setter(idArg0, numeroArg1, idCargaArg2, idCiudadArg3, precioFleteArg4, precioUnidadFacturacionArg5, precioUnidadStockArg6, precioBultosArg7, importeMinimoEntregaArg8, importeMinimoCargaArg9);

	}

	public TransporteTarifa(String idArg0, Integer numeroArg1, String idArg2, Integer numeroArg3, String nombreArg4, String idTransporteArg5, String idArg6, Integer numeroArg7, String nombreArg8, String departamentoArg9, Integer numeroAFIPArg10, String idProvinciaArg11, java.math.BigDecimal precioFleteArg12, java.math.BigDecimal precioUnidadFacturacionArg13, java.math.BigDecimal precioUnidadStockArg14, java.math.BigDecimal precioBultosArg15, java.math.BigDecimal importeMinimoEntregaArg16, java.math.BigDecimal importeMinimoCargaArg17) throws Exception {

		setter(idArg0, numeroArg1, idArg2, numeroArg3, nombreArg4, idTransporteArg5, idArg6, numeroArg7, nombreArg8, departamentoArg9, numeroAFIPArg10, idProvinciaArg11, precioFleteArg12, precioUnidadFacturacionArg13, precioUnidadStockArg14, precioBultosArg15, importeMinimoEntregaArg16, importeMinimoCargaArg17);

	}

	public TransporteTarifa(String idArg0, Integer numeroArg1, String idArg2, Integer numeroArg3, String nombreArg4, String idArg5, Integer numeroArg6, String nombreArg7, Long cuitArg8, String ingresosBrutosArg9, String telefonoArg10, String faxArg11, String idCodigoPostalArg12, String domicilioArg13, String comentarioArg14, String idArg15, Integer numeroArg16, String nombreArg17, String departamentoArg18, Integer numeroAFIPArg19, String idArg20, Integer numeroArg21, String nombreArg22, String abreviaturaArg23, Integer numeroAFIPArg24, Integer numeroIngresosBrutosArg25, Integer numeroRENATEAArg26, String idPaisArg27, java.math.BigDecimal precioFleteArg28, java.math.BigDecimal precioUnidadFacturacionArg29, java.math.BigDecimal precioUnidadStockArg30, java.math.BigDecimal precioBultosArg31, java.math.BigDecimal importeMinimoEntregaArg32, java.math.BigDecimal importeMinimoCargaArg33) throws Exception {

		setter(idArg0, numeroArg1, idArg2, numeroArg3, nombreArg4, idArg5, numeroArg6, nombreArg7, cuitArg8, ingresosBrutosArg9, telefonoArg10, faxArg11, idCodigoPostalArg12, domicilioArg13, comentarioArg14, idArg15, numeroArg16, nombreArg17, departamentoArg18, numeroAFIPArg19, idArg20, numeroArg21, nombreArg22, abreviaturaArg23, numeroAFIPArg24, numeroIngresosBrutosArg25, numeroRENATEAArg26, idPaisArg27, precioFleteArg28, precioUnidadFacturacionArg29, precioUnidadStockArg30, precioBultosArg31, importeMinimoEntregaArg32, importeMinimoCargaArg33);

	}

	public TransporteTarifa(String idArg0, Integer numeroArg1, String idArg2, Integer numeroArg3, String nombreArg4, String idArg5, Integer numeroArg6, String nombreArg7, Long cuitArg8, String ingresosBrutosArg9, String telefonoArg10, String faxArg11, String idArg12, String codigoArg13, Integer numeroArg14, String nombreCalleArg15, String numeroCalleArg16, String idCiudadArg17, String domicilioArg18, String comentarioArg19, String idArg20, Integer numeroArg21, String nombreArg22, String departamentoArg23, Integer numeroAFIPArg24, String idArg25, Integer numeroArg26, String nombreArg27, String abreviaturaArg28, Integer numeroAFIPArg29, Integer numeroIngresosBrutosArg30, Integer numeroRENATEAArg31, String idArg32, Integer numeroArg33, String nombreArg34, String abreviaturaArg35, java.math.BigDecimal precioFleteArg36, java.math.BigDecimal precioUnidadFacturacionArg37, java.math.BigDecimal precioUnidadStockArg38, java.math.BigDecimal precioBultosArg39, java.math.BigDecimal importeMinimoEntregaArg40, java.math.BigDecimal importeMinimoCargaArg41) throws Exception {

		setter(idArg0, numeroArg1, idArg2, numeroArg3, nombreArg4, idArg5, numeroArg6, nombreArg7, cuitArg8, ingresosBrutosArg9, telefonoArg10, faxArg11, idArg12, codigoArg13, numeroArg14, nombreCalleArg15, numeroCalleArg16, idCiudadArg17, domicilioArg18, comentarioArg19, idArg20, numeroArg21, nombreArg22, departamentoArg23, numeroAFIPArg24, idArg25, numeroArg26, nombreArg27, abreviaturaArg28, numeroAFIPArg29, numeroIngresosBrutosArg30, numeroRENATEAArg31, idArg32, numeroArg33, nombreArg34, abreviaturaArg35, precioFleteArg36, precioUnidadFacturacionArg37, precioUnidadStockArg38, precioBultosArg39, importeMinimoEntregaArg40, importeMinimoCargaArg41);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	// GET ID
	public String getId() {
		return this.id;
	}
	// SET ID
	public void setId(String id){
		id = (id != null) ? id.trim() : null;
		this.id = (id != null && id.length() == 0) ? null : id;
	}

	// GET Nº opción
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº opción
	public void setNumero(Integer numero ){
		this.numero = numero;
	}

	// BUILD IF NULL AND GET Carga
	public Carga buildCarga() throws Exception {
		this.carga = (this.carga == null) ? new Carga() : this.carga;
		return this.carga;
	}

	// GET Carga
	public Carga getCarga() {
		this.carga = (this.carga != null && this.carga.getId() == null) ? null : this.carga ;
		return this.carga;
	}

	// SET Carga
	public void setCarga(Carga carga ){
		this.carga = carga;
	}

	// BUILD IF NULL AND GET Ciudad
	public Ciudad buildCiudad() throws Exception {
		this.ciudad = (this.ciudad == null) ? new Ciudad() : this.ciudad;
		return this.ciudad;
	}

	// GET Ciudad
	public Ciudad getCiudad() {
		this.ciudad = (this.ciudad != null && this.ciudad.getId() == null) ? null : this.ciudad ;
		return this.ciudad;
	}

	// SET Ciudad
	public void setCiudad(Ciudad ciudad ){
		this.ciudad = ciudad;
	}

	// GET Precio flete
	public java.math.BigDecimal getPrecioFlete() {
		return this.precioFlete;
	}

	// SET Precio flete
	public void setPrecioFlete(java.math.BigDecimal precioFlete ){
		this.precioFlete = precioFlete;
	}

	// GET Precio unidad facturación
	public java.math.BigDecimal getPrecioUnidadFacturacion() {
		return this.precioUnidadFacturacion;
	}

	// SET Precio unidad facturación
	public void setPrecioUnidadFacturacion(java.math.BigDecimal precioUnidadFacturacion ){
		this.precioUnidadFacturacion = precioUnidadFacturacion;
	}

	// GET Precio unidad stock
	public java.math.BigDecimal getPrecioUnidadStock() {
		return this.precioUnidadStock;
	}

	// SET Precio unidad stock
	public void setPrecioUnidadStock(java.math.BigDecimal precioUnidadStock ){
		this.precioUnidadStock = precioUnidadStock;
	}

	// GET Precio bultos
	public java.math.BigDecimal getPrecioBultos() {
		return this.precioBultos;
	}

	// SET Precio bultos
	public void setPrecioBultos(java.math.BigDecimal precioBultos ){
		this.precioBultos = precioBultos;
	}

	// GET Importe mínimo por entrega
	public java.math.BigDecimal getImporteMinimoEntrega() {
		return this.importeMinimoEntrega;
	}

	// SET Importe mínimo por entrega
	public void setImporteMinimoEntrega(java.math.BigDecimal importeMinimoEntrega ){
		this.importeMinimoEntrega = importeMinimoEntrega;
	}

	// GET Importe mínimo por carga
	public java.math.BigDecimal getImporteMinimoCarga() {
		return this.importeMinimoCarga;
	}

	// SET Importe mínimo por carga
	public void setImporteMinimoCarga(java.math.BigDecimal importeMinimoCarga ){
		this.importeMinimoCarga = importeMinimoCarga;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String idCargaArg2, String idCiudadArg3, java.math.BigDecimal precioFleteArg4, java.math.BigDecimal precioUnidadFacturacionArg5, java.math.BigDecimal precioUnidadStockArg6, java.math.BigDecimal precioBultosArg7, java.math.BigDecimal importeMinimoEntregaArg8, java.math.BigDecimal importeMinimoCargaArg9) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.buildCarga().setId(idCargaArg2);
		this.buildCiudad().setId(idCiudadArg3);
		this.setPrecioFlete(precioFleteArg4);
		this.setPrecioUnidadFacturacion(precioUnidadFacturacionArg5);
		this.setPrecioUnidadStock(precioUnidadStockArg6);
		this.setPrecioBultos(precioBultosArg7);
		this.setImporteMinimoEntrega(importeMinimoEntregaArg8);
		this.setImporteMinimoCarga(importeMinimoCargaArg9);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String idArg2, Integer numeroArg3, String nombreArg4, String idTransporteArg5, String idArg6, Integer numeroArg7, String nombreArg8, String departamentoArg9, Integer numeroAFIPArg10, String idProvinciaArg11, java.math.BigDecimal precioFleteArg12, java.math.BigDecimal precioUnidadFacturacionArg13, java.math.BigDecimal precioUnidadStockArg14, java.math.BigDecimal precioBultosArg15, java.math.BigDecimal importeMinimoEntregaArg16, java.math.BigDecimal importeMinimoCargaArg17) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.buildCarga().setId(idArg2);
		this.buildCarga().setNumero(numeroArg3);
		this.buildCarga().setNombre(nombreArg4);
		this.buildCarga().buildTransporte().setId(idTransporteArg5);
		this.buildCiudad().setId(idArg6);
		this.buildCiudad().setNumero(numeroArg7);
		this.buildCiudad().setNombre(nombreArg8);
		this.buildCiudad().setDepartamento(departamentoArg9);
		this.buildCiudad().setNumeroAFIP(numeroAFIPArg10);
		this.buildCiudad().buildProvincia().setId(idProvinciaArg11);
		this.setPrecioFlete(precioFleteArg12);
		this.setPrecioUnidadFacturacion(precioUnidadFacturacionArg13);
		this.setPrecioUnidadStock(precioUnidadStockArg14);
		this.setPrecioBultos(precioBultosArg15);
		this.setImporteMinimoEntrega(importeMinimoEntregaArg16);
		this.setImporteMinimoCarga(importeMinimoCargaArg17);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String idArg2, Integer numeroArg3, String nombreArg4, String idArg5, Integer numeroArg6, String nombreArg7, Long cuitArg8, String ingresosBrutosArg9, String telefonoArg10, String faxArg11, String idCodigoPostalArg12, String domicilioArg13, String comentarioArg14, String idArg15, Integer numeroArg16, String nombreArg17, String departamentoArg18, Integer numeroAFIPArg19, String idArg20, Integer numeroArg21, String nombreArg22, String abreviaturaArg23, Integer numeroAFIPArg24, Integer numeroIngresosBrutosArg25, Integer numeroRENATEAArg26, String idPaisArg27, java.math.BigDecimal precioFleteArg28, java.math.BigDecimal precioUnidadFacturacionArg29, java.math.BigDecimal precioUnidadStockArg30, java.math.BigDecimal precioBultosArg31, java.math.BigDecimal importeMinimoEntregaArg32, java.math.BigDecimal importeMinimoCargaArg33) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.buildCarga().setId(idArg2);
		this.buildCarga().setNumero(numeroArg3);
		this.buildCarga().setNombre(nombreArg4);
		this.buildCarga().buildTransporte().setId(idArg5);
		this.buildCarga().buildTransporte().setNumero(numeroArg6);
		this.buildCarga().buildTransporte().setNombre(nombreArg7);
		this.buildCarga().buildTransporte().setCuit(cuitArg8);
		this.buildCarga().buildTransporte().setIngresosBrutos(ingresosBrutosArg9);
		this.buildCarga().buildTransporte().setTelefono(telefonoArg10);
		this.buildCarga().buildTransporte().setFax(faxArg11);
		this.buildCarga().buildTransporte().buildCodigoPostal().setId(idCodigoPostalArg12);
		this.buildCarga().buildTransporte().setDomicilio(domicilioArg13);
		this.buildCarga().buildTransporte().setComentario(comentarioArg14);
		this.buildCiudad().setId(idArg15);
		this.buildCiudad().setNumero(numeroArg16);
		this.buildCiudad().setNombre(nombreArg17);
		this.buildCiudad().setDepartamento(departamentoArg18);
		this.buildCiudad().setNumeroAFIP(numeroAFIPArg19);
		this.buildCiudad().buildProvincia().setId(idArg20);
		this.buildCiudad().buildProvincia().setNumero(numeroArg21);
		this.buildCiudad().buildProvincia().setNombre(nombreArg22);
		this.buildCiudad().buildProvincia().setAbreviatura(abreviaturaArg23);
		this.buildCiudad().buildProvincia().setNumeroAFIP(numeroAFIPArg24);
		this.buildCiudad().buildProvincia().setNumeroIngresosBrutos(numeroIngresosBrutosArg25);
		this.buildCiudad().buildProvincia().setNumeroRENATEA(numeroRENATEAArg26);
		this.buildCiudad().buildProvincia().buildPais().setId(idPaisArg27);
		this.setPrecioFlete(precioFleteArg28);
		this.setPrecioUnidadFacturacion(precioUnidadFacturacionArg29);
		this.setPrecioUnidadStock(precioUnidadStockArg30);
		this.setPrecioBultos(precioBultosArg31);
		this.setImporteMinimoEntrega(importeMinimoEntregaArg32);
		this.setImporteMinimoCarga(importeMinimoCargaArg33);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String idArg2, Integer numeroArg3, String nombreArg4, String idArg5, Integer numeroArg6, String nombreArg7, Long cuitArg8, String ingresosBrutosArg9, String telefonoArg10, String faxArg11, String idArg12, String codigoArg13, Integer numeroArg14, String nombreCalleArg15, String numeroCalleArg16, String idCiudadArg17, String domicilioArg18, String comentarioArg19, String idArg20, Integer numeroArg21, String nombreArg22, String departamentoArg23, Integer numeroAFIPArg24, String idArg25, Integer numeroArg26, String nombreArg27, String abreviaturaArg28, Integer numeroAFIPArg29, Integer numeroIngresosBrutosArg30, Integer numeroRENATEAArg31, String idArg32, Integer numeroArg33, String nombreArg34, String abreviaturaArg35, java.math.BigDecimal precioFleteArg36, java.math.BigDecimal precioUnidadFacturacionArg37, java.math.BigDecimal precioUnidadStockArg38, java.math.BigDecimal precioBultosArg39, java.math.BigDecimal importeMinimoEntregaArg40, java.math.BigDecimal importeMinimoCargaArg41) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.buildCarga().setId(idArg2);
		this.buildCarga().setNumero(numeroArg3);
		this.buildCarga().setNombre(nombreArg4);
		this.buildCarga().buildTransporte().setId(idArg5);
		this.buildCarga().buildTransporte().setNumero(numeroArg6);
		this.buildCarga().buildTransporte().setNombre(nombreArg7);
		this.buildCarga().buildTransporte().setCuit(cuitArg8);
		this.buildCarga().buildTransporte().setIngresosBrutos(ingresosBrutosArg9);
		this.buildCarga().buildTransporte().setTelefono(telefonoArg10);
		this.buildCarga().buildTransporte().setFax(faxArg11);
		this.buildCarga().buildTransporte().buildCodigoPostal().setId(idArg12);
		this.buildCarga().buildTransporte().buildCodigoPostal().setCodigo(codigoArg13);
		this.buildCarga().buildTransporte().buildCodigoPostal().setNumero(numeroArg14);
		this.buildCarga().buildTransporte().buildCodigoPostal().setNombreCalle(nombreCalleArg15);
		this.buildCarga().buildTransporte().buildCodigoPostal().setNumeroCalle(numeroCalleArg16);
		this.buildCarga().buildTransporte().buildCodigoPostal().buildCiudad().setId(idCiudadArg17);
		this.buildCarga().buildTransporte().setDomicilio(domicilioArg18);
		this.buildCarga().buildTransporte().setComentario(comentarioArg19);
		this.buildCiudad().setId(idArg20);
		this.buildCiudad().setNumero(numeroArg21);
		this.buildCiudad().setNombre(nombreArg22);
		this.buildCiudad().setDepartamento(departamentoArg23);
		this.buildCiudad().setNumeroAFIP(numeroAFIPArg24);
		this.buildCiudad().buildProvincia().setId(idArg25);
		this.buildCiudad().buildProvincia().setNumero(numeroArg26);
		this.buildCiudad().buildProvincia().setNombre(nombreArg27);
		this.buildCiudad().buildProvincia().setAbreviatura(abreviaturaArg28);
		this.buildCiudad().buildProvincia().setNumeroAFIP(numeroAFIPArg29);
		this.buildCiudad().buildProvincia().setNumeroIngresosBrutos(numeroIngresosBrutosArg30);
		this.buildCiudad().buildProvincia().setNumeroRENATEA(numeroRENATEAArg31);
		this.buildCiudad().buildProvincia().buildPais().setId(idArg32);
		this.buildCiudad().buildProvincia().buildPais().setNumero(numeroArg33);
		this.buildCiudad().buildProvincia().buildPais().setNombre(nombreArg34);
		this.buildCiudad().buildProvincia().buildPais().setAbreviatura(abreviaturaArg35);
		this.setPrecioFlete(precioFleteArg36);
		this.setPrecioUnidadFacturacion(precioUnidadFacturacionArg37);
		this.setPrecioUnidadStock(precioUnidadStockArg38);
		this.setPrecioBultos(precioBultosArg39);
		this.setImporteMinimoEntrega(importeMinimoEntregaArg40);
		this.setImporteMinimoCarga(importeMinimoCargaArg41);

	}

	// ---------------------------------------------------------------------------------------------------------------------------

	public String toString() {
		if(this.getNumero() != null && this.getCarga() != null){
			return this.getNumero() + " - " +  this.getCarga();
		} else if(this.getNumero() != null && this.getCarga() == null){
			return this.getNumero().toString();
		} else if(this.getNumero() == null && this.getCarga() != null){
			return this.getCarga().toString();
		} else {
			return super.toString();
		}
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------