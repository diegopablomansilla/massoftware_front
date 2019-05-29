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

	public TransporteTarifa(String idArg0, Integer numeroArg1, java.math.BigDecimal precioFleteArg2, java.math.BigDecimal precioUnidadFacturacionArg3, java.math.BigDecimal precioUnidadStockArg4, java.math.BigDecimal precioBultosArg5, java.math.BigDecimal importeMinimoEntregaArg6, java.math.BigDecimal importeMinimoCargaArg7) throws Exception {

		setter(idArg0, numeroArg1, precioFleteArg2, precioUnidadFacturacionArg3, precioUnidadStockArg4, precioBultosArg5, importeMinimoEntregaArg6, importeMinimoCargaArg7);

	}

	public TransporteTarifa(String idArg0, Integer numeroArg1, String idArg2, Integer numeroArg3, String nombreArg4, String idArg5, Integer numeroArg6, String nombreArg7, String departamentoArg8, Integer numeroAFIPArg9, java.math.BigDecimal precioFleteArg10, java.math.BigDecimal precioUnidadFacturacionArg11, java.math.BigDecimal precioUnidadStockArg12, java.math.BigDecimal precioBultosArg13, java.math.BigDecimal importeMinimoEntregaArg14, java.math.BigDecimal importeMinimoCargaArg15) throws Exception {

		setter(idArg0, numeroArg1, idArg2, numeroArg3, nombreArg4, idArg5, numeroArg6, nombreArg7, departamentoArg8, numeroAFIPArg9, precioFleteArg10, precioUnidadFacturacionArg11, precioUnidadStockArg12, precioBultosArg13, importeMinimoEntregaArg14, importeMinimoCargaArg15);

	}

	public TransporteTarifa(String idArg0, Integer numeroArg1, String idArg2, Integer numeroArg3, String nombreArg4, String idArg5, Integer numeroArg6, String nombreArg7, Long cuitArg8, String ingresosBrutosArg9, String telefonoArg10, String faxArg11, String domicilioArg12, String comentarioArg13, String idArg14, Integer numeroArg15, String nombreArg16, String departamentoArg17, Integer numeroAFIPArg18, String idArg19, Integer numeroArg20, String nombreArg21, String abreviaturaArg22, Integer numeroAFIPArg23, Integer numeroIngresosBrutosArg24, Integer numeroRENATEAArg25, java.math.BigDecimal precioFleteArg26, java.math.BigDecimal precioUnidadFacturacionArg27, java.math.BigDecimal precioUnidadStockArg28, java.math.BigDecimal precioBultosArg29, java.math.BigDecimal importeMinimoEntregaArg30, java.math.BigDecimal importeMinimoCargaArg31) throws Exception {

		setter(idArg0, numeroArg1, idArg2, numeroArg3, nombreArg4, idArg5, numeroArg6, nombreArg7, cuitArg8, ingresosBrutosArg9, telefonoArg10, faxArg11, domicilioArg12, comentarioArg13, idArg14, numeroArg15, nombreArg16, departamentoArg17, numeroAFIPArg18, idArg19, numeroArg20, nombreArg21, abreviaturaArg22, numeroAFIPArg23, numeroIngresosBrutosArg24, numeroRENATEAArg25, precioFleteArg26, precioUnidadFacturacionArg27, precioUnidadStockArg28, precioBultosArg29, importeMinimoEntregaArg30, importeMinimoCargaArg31);

	}

	public TransporteTarifa(String idArg0, Integer numeroArg1, String idArg2, Integer numeroArg3, String nombreArg4, String idArg5, Integer numeroArg6, String nombreArg7, Long cuitArg8, String ingresosBrutosArg9, String telefonoArg10, String faxArg11, String idArg12, String codigoArg13, Integer numeroArg14, String nombreCalleArg15, String numeroCalleArg16, String domicilioArg17, String comentarioArg18, String idArg19, Integer numeroArg20, String nombreArg21, String departamentoArg22, Integer numeroAFIPArg23, String idArg24, Integer numeroArg25, String nombreArg26, String abreviaturaArg27, Integer numeroAFIPArg28, Integer numeroIngresosBrutosArg29, Integer numeroRENATEAArg30, String idArg31, Integer numeroArg32, String nombreArg33, String abreviaturaArg34, java.math.BigDecimal precioFleteArg35, java.math.BigDecimal precioUnidadFacturacionArg36, java.math.BigDecimal precioUnidadStockArg37, java.math.BigDecimal precioBultosArg38, java.math.BigDecimal importeMinimoEntregaArg39, java.math.BigDecimal importeMinimoCargaArg40) throws Exception {

		setter(idArg0, numeroArg1, idArg2, numeroArg3, nombreArg4, idArg5, numeroArg6, nombreArg7, cuitArg8, ingresosBrutosArg9, telefonoArg10, faxArg11, idArg12, codigoArg13, numeroArg14, nombreCalleArg15, numeroCalleArg16, domicilioArg17, comentarioArg18, idArg19, numeroArg20, nombreArg21, departamentoArg22, numeroAFIPArg23, idArg24, numeroArg25, nombreArg26, abreviaturaArg27, numeroAFIPArg28, numeroIngresosBrutosArg29, numeroRENATEAArg30, idArg31, numeroArg32, nombreArg33, abreviaturaArg34, precioFleteArg35, precioUnidadFacturacionArg36, precioUnidadStockArg37, precioBultosArg38, importeMinimoEntregaArg39, importeMinimoCargaArg40);

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


	public void setter(String idArg0, Integer numeroArg1, java.math.BigDecimal precioFleteArg2, java.math.BigDecimal precioUnidadFacturacionArg3, java.math.BigDecimal precioUnidadStockArg4, java.math.BigDecimal precioBultosArg5, java.math.BigDecimal importeMinimoEntregaArg6, java.math.BigDecimal importeMinimoCargaArg7) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setPrecioFlete(precioFleteArg2);
		this.setPrecioUnidadFacturacion(precioUnidadFacturacionArg3);
		this.setPrecioUnidadStock(precioUnidadStockArg4);
		this.setPrecioBultos(precioBultosArg5);
		this.setImporteMinimoEntrega(importeMinimoEntregaArg6);
		this.setImporteMinimoCarga(importeMinimoCargaArg7);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String idArg2, Integer numeroArg3, String nombreArg4, String idArg5, Integer numeroArg6, String nombreArg7, String departamentoArg8, Integer numeroAFIPArg9, java.math.BigDecimal precioFleteArg10, java.math.BigDecimal precioUnidadFacturacionArg11, java.math.BigDecimal precioUnidadStockArg12, java.math.BigDecimal precioBultosArg13, java.math.BigDecimal importeMinimoEntregaArg14, java.math.BigDecimal importeMinimoCargaArg15) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.buildCarga().setId(idArg2);
		this.buildCarga().setNumero(numeroArg3);
		this.buildCarga().setNombre(nombreArg4);
		this.buildCiudad().setId(idArg5);
		this.buildCiudad().setNumero(numeroArg6);
		this.buildCiudad().setNombre(nombreArg7);
		this.buildCiudad().setDepartamento(departamentoArg8);
		this.buildCiudad().setNumeroAFIP(numeroAFIPArg9);
		this.setPrecioFlete(precioFleteArg10);
		this.setPrecioUnidadFacturacion(precioUnidadFacturacionArg11);
		this.setPrecioUnidadStock(precioUnidadStockArg12);
		this.setPrecioBultos(precioBultosArg13);
		this.setImporteMinimoEntrega(importeMinimoEntregaArg14);
		this.setImporteMinimoCarga(importeMinimoCargaArg15);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String idArg2, Integer numeroArg3, String nombreArg4, String idArg5, Integer numeroArg6, String nombreArg7, Long cuitArg8, String ingresosBrutosArg9, String telefonoArg10, String faxArg11, String domicilioArg12, String comentarioArg13, String idArg14, Integer numeroArg15, String nombreArg16, String departamentoArg17, Integer numeroAFIPArg18, String idArg19, Integer numeroArg20, String nombreArg21, String abreviaturaArg22, Integer numeroAFIPArg23, Integer numeroIngresosBrutosArg24, Integer numeroRENATEAArg25, java.math.BigDecimal precioFleteArg26, java.math.BigDecimal precioUnidadFacturacionArg27, java.math.BigDecimal precioUnidadStockArg28, java.math.BigDecimal precioBultosArg29, java.math.BigDecimal importeMinimoEntregaArg30, java.math.BigDecimal importeMinimoCargaArg31) throws Exception {

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
		this.buildCarga().buildTransporte().setDomicilio(domicilioArg12);
		this.buildCarga().buildTransporte().setComentario(comentarioArg13);
		this.buildCiudad().setId(idArg14);
		this.buildCiudad().setNumero(numeroArg15);
		this.buildCiudad().setNombre(nombreArg16);
		this.buildCiudad().setDepartamento(departamentoArg17);
		this.buildCiudad().setNumeroAFIP(numeroAFIPArg18);
		this.buildCiudad().buildProvincia().setId(idArg19);
		this.buildCiudad().buildProvincia().setNumero(numeroArg20);
		this.buildCiudad().buildProvincia().setNombre(nombreArg21);
		this.buildCiudad().buildProvincia().setAbreviatura(abreviaturaArg22);
		this.buildCiudad().buildProvincia().setNumeroAFIP(numeroAFIPArg23);
		this.buildCiudad().buildProvincia().setNumeroIngresosBrutos(numeroIngresosBrutosArg24);
		this.buildCiudad().buildProvincia().setNumeroRENATEA(numeroRENATEAArg25);
		this.setPrecioFlete(precioFleteArg26);
		this.setPrecioUnidadFacturacion(precioUnidadFacturacionArg27);
		this.setPrecioUnidadStock(precioUnidadStockArg28);
		this.setPrecioBultos(precioBultosArg29);
		this.setImporteMinimoEntrega(importeMinimoEntregaArg30);
		this.setImporteMinimoCarga(importeMinimoCargaArg31);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String idArg2, Integer numeroArg3, String nombreArg4, String idArg5, Integer numeroArg6, String nombreArg7, Long cuitArg8, String ingresosBrutosArg9, String telefonoArg10, String faxArg11, String idArg12, String codigoArg13, Integer numeroArg14, String nombreCalleArg15, String numeroCalleArg16, String domicilioArg17, String comentarioArg18, String idArg19, Integer numeroArg20, String nombreArg21, String departamentoArg22, Integer numeroAFIPArg23, String idArg24, Integer numeroArg25, String nombreArg26, String abreviaturaArg27, Integer numeroAFIPArg28, Integer numeroIngresosBrutosArg29, Integer numeroRENATEAArg30, String idArg31, Integer numeroArg32, String nombreArg33, String abreviaturaArg34, java.math.BigDecimal precioFleteArg35, java.math.BigDecimal precioUnidadFacturacionArg36, java.math.BigDecimal precioUnidadStockArg37, java.math.BigDecimal precioBultosArg38, java.math.BigDecimal importeMinimoEntregaArg39, java.math.BigDecimal importeMinimoCargaArg40) throws Exception {

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
		this.buildCarga().buildTransporte().setDomicilio(domicilioArg17);
		this.buildCarga().buildTransporte().setComentario(comentarioArg18);
		this.buildCiudad().setId(idArg19);
		this.buildCiudad().setNumero(numeroArg20);
		this.buildCiudad().setNombre(nombreArg21);
		this.buildCiudad().setDepartamento(departamentoArg22);
		this.buildCiudad().setNumeroAFIP(numeroAFIPArg23);
		this.buildCiudad().buildProvincia().setId(idArg24);
		this.buildCiudad().buildProvincia().setNumero(numeroArg25);
		this.buildCiudad().buildProvincia().setNombre(nombreArg26);
		this.buildCiudad().buildProvincia().setAbreviatura(abreviaturaArg27);
		this.buildCiudad().buildProvincia().setNumeroAFIP(numeroAFIPArg28);
		this.buildCiudad().buildProvincia().setNumeroIngresosBrutos(numeroIngresosBrutosArg29);
		this.buildCiudad().buildProvincia().setNumeroRENATEA(numeroRENATEAArg30);
		this.buildCiudad().buildProvincia().buildPais().setId(idArg31);
		this.buildCiudad().buildProvincia().buildPais().setNumero(numeroArg32);
		this.buildCiudad().buildProvincia().buildPais().setNombre(nombreArg33);
		this.buildCiudad().buildProvincia().buildPais().setAbreviatura(abreviaturaArg34);
		this.setPrecioFlete(precioFleteArg35);
		this.setPrecioUnidadFacturacion(precioUnidadFacturacionArg36);
		this.setPrecioUnidadStock(precioUnidadStockArg37);
		this.setPrecioBultos(precioBultosArg38);
		this.setImporteMinimoEntrega(importeMinimoEntregaArg39);
		this.setImporteMinimoCarga(importeMinimoCargaArg40);

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