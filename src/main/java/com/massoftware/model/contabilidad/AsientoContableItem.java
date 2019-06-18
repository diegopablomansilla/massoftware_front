package com.massoftware.model.contabilidad;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.contabilidad.AsientoContable;
import com.massoftware.model.contabilidad.CuentaContable;

@ClassLabelAnont(singular = "Item de asiento contable", plural = "Items de asientos contables", singularPre = "el item de asiento contable", pluralPre = "los items de asientos contables")
public class AsientoContableItem extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº item
	@FieldConfAnont(label = "Nº item", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Fecha
	@FieldConfAnont(label = "Fecha", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.util.Date fecha;

	// Detalle
	@FieldConfAnont(label = "Detalle", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 100, minValue = "", maxValue = "", mask = "")
	private String detalle;

	// Asiento contable
	@FieldConfAnont(label = "Asiento contable", labelError = "", unique = false, readOnly = true, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private AsientoContable asientoContable;

	// Cuenta contable
	@FieldConfAnont(label = "Cuenta contable", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private CuentaContable cuentaContable;

	// Debe
	@FieldConfAnont(label = "Debe", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.math.BigDecimal debe;

	// Haber
	@FieldConfAnont(label = "Haber", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.math.BigDecimal haber;

	// ---------------------------------------------------------------------------------------------------------------------------


	public AsientoContableItem() throws Exception {
	}

	public AsientoContableItem(String idArg0, Integer numeroArg1, java.util.Date fechaArg2, String detalleArg3, String idAsientoContableArg4, String idCuentaContableArg5, java.math.BigDecimal debeArg6, java.math.BigDecimal haberArg7) throws Exception {

		setter(idArg0, numeroArg1, fechaArg2, detalleArg3, idAsientoContableArg4, idCuentaContableArg5, debeArg6, haberArg7);

	}

	public AsientoContableItem(String idArg0, Integer numeroArg1, java.util.Date fechaArg2, String detalleArg3, String idArg4, Integer numeroArg5, java.util.Date fechaArg6, String detalleArg7, String idEjercicioContableArg8, String idMinutaContableArg9, String idSucursalArg10, String idAsientoContableModuloArg11, String idArg12, String codigoArg13, String nombreArg14, String idEjercicioContableArg15, String integraArg16, String cuentaJerarquiaArg17, Boolean imputableArg18, Boolean ajustaPorInflacionArg19, String idCuentaContableEstadoArg20, Boolean cuentaConApropiacionArg21, String idCentroCostoContableArg22, String cuentaAgrupadoraArg23, java.math.BigDecimal porcentajeArg24, String idPuntoEquilibrioArg25, String idCostoVentaArg26, String idSeguridadPuertaArg27, java.math.BigDecimal debeArg28, java.math.BigDecimal haberArg29) throws Exception {

		setter(idArg0, numeroArg1, fechaArg2, detalleArg3, idArg4, numeroArg5, fechaArg6, detalleArg7, idEjercicioContableArg8, idMinutaContableArg9, idSucursalArg10, idAsientoContableModuloArg11, idArg12, codigoArg13, nombreArg14, idEjercicioContableArg15, integraArg16, cuentaJerarquiaArg17, imputableArg18, ajustaPorInflacionArg19, idCuentaContableEstadoArg20, cuentaConApropiacionArg21, idCentroCostoContableArg22, cuentaAgrupadoraArg23, porcentajeArg24, idPuntoEquilibrioArg25, idCostoVentaArg26, idSeguridadPuertaArg27, debeArg28, haberArg29);

	}

	public AsientoContableItem(String idArg0, Integer numeroArg1, java.util.Date fechaArg2, String detalleArg3, String idArg4, Integer numeroArg5, java.util.Date fechaArg6, String detalleArg7, String idArg8, Integer numeroArg9, java.util.Date aperturaArg10, java.util.Date cierreArg11, Boolean cerradoArg12, Boolean cerradoModulosArg13, String comentarioArg14, String idArg15, Integer numeroArg16, String nombreArg17, String idArg18, Integer numeroArg19, String nombreArg20, String abreviaturaArg21, String idTipoSucursalArg22, String cuentaClientesDesdeArg23, String cuentaClientesHastaArg24, Integer cantidadCaracteresClientesArg25, Boolean identificacionNumericaClientesArg26, Boolean permiteCambiarClientesArg27, String cuentaProveedoresDesdeArg28, String cuentaProveedoresHastaArg29, Integer cantidadCaracteresProveedoresArg30, Boolean identificacionNumericaProveedoresArg31, Boolean permiteCambiarProveedoresArg32, Integer clientesOcacionalesDesdeArg33, Integer clientesOcacionalesHastaArg34, Integer numeroCobranzaDesdeArg35, Integer numeroCobranzaHastaArg36, String idArg37, Integer numeroArg38, String nombreArg39, String idArg40, String codigoArg41, String nombreArg42, String idArg43, Integer numeroArg44, java.util.Date aperturaArg45, java.util.Date cierreArg46, Boolean cerradoArg47, Boolean cerradoModulosArg48, String comentarioArg49, String integraArg50, String cuentaJerarquiaArg51, Boolean imputableArg52, Boolean ajustaPorInflacionArg53, String idArg54, Integer numeroArg55, String nombreArg56, Boolean cuentaConApropiacionArg57, String idArg58, Integer numeroArg59, String nombreArg60, String abreviaturaArg61, String idEjercicioContableArg62, String cuentaAgrupadoraArg63, java.math.BigDecimal porcentajeArg64, String idArg65, Integer numeroArg66, String nombreArg67, String idTipoPuntoEquilibrioArg68, String idEjercicioContableArg69, String idArg70, Integer numeroArg71, String nombreArg72, String idArg73, Integer numeroArg74, String nombreArg75, String equateArg76, String idSeguridadModuloArg77, java.math.BigDecimal debeArg78, java.math.BigDecimal haberArg79) throws Exception {

		setter(idArg0, numeroArg1, fechaArg2, detalleArg3, idArg4, numeroArg5, fechaArg6, detalleArg7, idArg8, numeroArg9, aperturaArg10, cierreArg11, cerradoArg12, cerradoModulosArg13, comentarioArg14, idArg15, numeroArg16, nombreArg17, idArg18, numeroArg19, nombreArg20, abreviaturaArg21, idTipoSucursalArg22, cuentaClientesDesdeArg23, cuentaClientesHastaArg24, cantidadCaracteresClientesArg25, identificacionNumericaClientesArg26, permiteCambiarClientesArg27, cuentaProveedoresDesdeArg28, cuentaProveedoresHastaArg29, cantidadCaracteresProveedoresArg30, identificacionNumericaProveedoresArg31, permiteCambiarProveedoresArg32, clientesOcacionalesDesdeArg33, clientesOcacionalesHastaArg34, numeroCobranzaDesdeArg35, numeroCobranzaHastaArg36, idArg37, numeroArg38, nombreArg39, idArg40, codigoArg41, nombreArg42, idArg43, numeroArg44, aperturaArg45, cierreArg46, cerradoArg47, cerradoModulosArg48, comentarioArg49, integraArg50, cuentaJerarquiaArg51, imputableArg52, ajustaPorInflacionArg53, idArg54, numeroArg55, nombreArg56, cuentaConApropiacionArg57, idArg58, numeroArg59, nombreArg60, abreviaturaArg61, idEjercicioContableArg62, cuentaAgrupadoraArg63, porcentajeArg64, idArg65, numeroArg66, nombreArg67, idTipoPuntoEquilibrioArg68, idEjercicioContableArg69, idArg70, numeroArg71, nombreArg72, idArg73, numeroArg74, nombreArg75, equateArg76, idSeguridadModuloArg77, debeArg78, haberArg79);

	}

	public AsientoContableItem(String idArg0, Integer numeroArg1, java.util.Date fechaArg2, String detalleArg3, String idArg4, Integer numeroArg5, java.util.Date fechaArg6, String detalleArg7, String idArg8, Integer numeroArg9, java.util.Date aperturaArg10, java.util.Date cierreArg11, Boolean cerradoArg12, Boolean cerradoModulosArg13, String comentarioArg14, String idArg15, Integer numeroArg16, String nombreArg17, String idArg18, Integer numeroArg19, String nombreArg20, String abreviaturaArg21, String idArg22, Integer numeroArg23, String nombreArg24, String cuentaClientesDesdeArg25, String cuentaClientesHastaArg26, Integer cantidadCaracteresClientesArg27, Boolean identificacionNumericaClientesArg28, Boolean permiteCambiarClientesArg29, String cuentaProveedoresDesdeArg30, String cuentaProveedoresHastaArg31, Integer cantidadCaracteresProveedoresArg32, Boolean identificacionNumericaProveedoresArg33, Boolean permiteCambiarProveedoresArg34, Integer clientesOcacionalesDesdeArg35, Integer clientesOcacionalesHastaArg36, Integer numeroCobranzaDesdeArg37, Integer numeroCobranzaHastaArg38, String idArg39, Integer numeroArg40, String nombreArg41, String idArg42, String codigoArg43, String nombreArg44, String idArg45, Integer numeroArg46, java.util.Date aperturaArg47, java.util.Date cierreArg48, Boolean cerradoArg49, Boolean cerradoModulosArg50, String comentarioArg51, String integraArg52, String cuentaJerarquiaArg53, Boolean imputableArg54, Boolean ajustaPorInflacionArg55, String idArg56, Integer numeroArg57, String nombreArg58, Boolean cuentaConApropiacionArg59, String idArg60, Integer numeroArg61, String nombreArg62, String abreviaturaArg63, String idArg64, Integer numeroArg65, java.util.Date aperturaArg66, java.util.Date cierreArg67, Boolean cerradoArg68, Boolean cerradoModulosArg69, String comentarioArg70, String cuentaAgrupadoraArg71, java.math.BigDecimal porcentajeArg72, String idArg73, Integer numeroArg74, String nombreArg75, String idArg76, Integer numeroArg77, String nombreArg78, String idArg79, Integer numeroArg80, java.util.Date aperturaArg81, java.util.Date cierreArg82, Boolean cerradoArg83, Boolean cerradoModulosArg84, String comentarioArg85, String idArg86, Integer numeroArg87, String nombreArg88, String idArg89, Integer numeroArg90, String nombreArg91, String equateArg92, String idArg93, Integer numeroArg94, String nombreArg95, java.math.BigDecimal debeArg96, java.math.BigDecimal haberArg97) throws Exception {

		setter(idArg0, numeroArg1, fechaArg2, detalleArg3, idArg4, numeroArg5, fechaArg6, detalleArg7, idArg8, numeroArg9, aperturaArg10, cierreArg11, cerradoArg12, cerradoModulosArg13, comentarioArg14, idArg15, numeroArg16, nombreArg17, idArg18, numeroArg19, nombreArg20, abreviaturaArg21, idArg22, numeroArg23, nombreArg24, cuentaClientesDesdeArg25, cuentaClientesHastaArg26, cantidadCaracteresClientesArg27, identificacionNumericaClientesArg28, permiteCambiarClientesArg29, cuentaProveedoresDesdeArg30, cuentaProveedoresHastaArg31, cantidadCaracteresProveedoresArg32, identificacionNumericaProveedoresArg33, permiteCambiarProveedoresArg34, clientesOcacionalesDesdeArg35, clientesOcacionalesHastaArg36, numeroCobranzaDesdeArg37, numeroCobranzaHastaArg38, idArg39, numeroArg40, nombreArg41, idArg42, codigoArg43, nombreArg44, idArg45, numeroArg46, aperturaArg47, cierreArg48, cerradoArg49, cerradoModulosArg50, comentarioArg51, integraArg52, cuentaJerarquiaArg53, imputableArg54, ajustaPorInflacionArg55, idArg56, numeroArg57, nombreArg58, cuentaConApropiacionArg59, idArg60, numeroArg61, nombreArg62, abreviaturaArg63, idArg64, numeroArg65, aperturaArg66, cierreArg67, cerradoArg68, cerradoModulosArg69, comentarioArg70, cuentaAgrupadoraArg71, porcentajeArg72, idArg73, numeroArg74, nombreArg75, idArg76, numeroArg77, nombreArg78, idArg79, numeroArg80, aperturaArg81, cierreArg82, cerradoArg83, cerradoModulosArg84, comentarioArg85, idArg86, numeroArg87, nombreArg88, idArg89, numeroArg90, nombreArg91, equateArg92, idArg93, numeroArg94, nombreArg95, debeArg96, haberArg97);

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

	// GET Nº item
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº item
	public void setNumero(Integer numero ){
		this.numero = numero;
	}

	// GET Fecha
	public java.util.Date getFecha() {
		return this.fecha;
	}

	// SET Fecha
	public void setFecha(java.util.Date fecha ){
		this.fecha = fecha;
	}

	// GET Detalle
	public String getDetalle() {
		return this.detalle;
	}

	// SET Detalle
	public void setDetalle(String detalle ){
		detalle = (detalle != null) ? detalle.trim() : null;
		this.detalle = (detalle != null && detalle.length() == 0) ? null : detalle;
	}

	// BUILD IF NULL AND GET Asiento contable
	public AsientoContable buildAsientoContable() throws Exception {
		this.asientoContable = (this.asientoContable == null) ? new AsientoContable() : this.asientoContable;
		return this.asientoContable;
	}

	// GET Asiento contable
	public AsientoContable getAsientoContable() {
		this.asientoContable = (this.asientoContable != null && this.asientoContable.getId() == null) ? null : this.asientoContable ;
		return this.asientoContable;
	}

	// SET Asiento contable
	public void setAsientoContable(AsientoContable asientoContable ){
		this.asientoContable = asientoContable;
	}

	// BUILD IF NULL AND GET Cuenta contable
	public CuentaContable buildCuentaContable() throws Exception {
		this.cuentaContable = (this.cuentaContable == null) ? new CuentaContable() : this.cuentaContable;
		return this.cuentaContable;
	}

	// GET Cuenta contable
	public CuentaContable getCuentaContable() {
		this.cuentaContable = (this.cuentaContable != null && this.cuentaContable.getId() == null) ? null : this.cuentaContable ;
		return this.cuentaContable;
	}

	// SET Cuenta contable
	public void setCuentaContable(CuentaContable cuentaContable ){
		this.cuentaContable = cuentaContable;
	}

	// GET Debe
	public java.math.BigDecimal getDebe() {
		return this.debe;
	}

	// SET Debe
	public void setDebe(java.math.BigDecimal debe ){
		this.debe = debe;
	}

	// GET Haber
	public java.math.BigDecimal getHaber() {
		return this.haber;
	}

	// SET Haber
	public void setHaber(java.math.BigDecimal haber ){
		this.haber = haber;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, java.util.Date fechaArg2, String detalleArg3, String idAsientoContableArg4, String idCuentaContableArg5, java.math.BigDecimal debeArg6, java.math.BigDecimal haberArg7) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setFecha(fechaArg2);
		this.setDetalle(detalleArg3);
		this.buildAsientoContable().setId(idAsientoContableArg4);
		this.buildCuentaContable().setId(idCuentaContableArg5);
		this.setDebe(debeArg6);
		this.setHaber(haberArg7);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, java.util.Date fechaArg2, String detalleArg3, String idArg4, Integer numeroArg5, java.util.Date fechaArg6, String detalleArg7, String idEjercicioContableArg8, String idMinutaContableArg9, String idSucursalArg10, String idAsientoContableModuloArg11, String idArg12, String codigoArg13, String nombreArg14, String idEjercicioContableArg15, String integraArg16, String cuentaJerarquiaArg17, Boolean imputableArg18, Boolean ajustaPorInflacionArg19, String idCuentaContableEstadoArg20, Boolean cuentaConApropiacionArg21, String idCentroCostoContableArg22, String cuentaAgrupadoraArg23, java.math.BigDecimal porcentajeArg24, String idPuntoEquilibrioArg25, String idCostoVentaArg26, String idSeguridadPuertaArg27, java.math.BigDecimal debeArg28, java.math.BigDecimal haberArg29) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setFecha(fechaArg2);
		this.setDetalle(detalleArg3);
		this.buildAsientoContable().setId(idArg4);
		this.buildAsientoContable().setNumero(numeroArg5);
		this.buildAsientoContable().setFecha(fechaArg6);
		this.buildAsientoContable().setDetalle(detalleArg7);
		this.buildAsientoContable().buildEjercicioContable().setId(idEjercicioContableArg8);
		this.buildAsientoContable().buildMinutaContable().setId(idMinutaContableArg9);
		this.buildAsientoContable().buildSucursal().setId(idSucursalArg10);
		this.buildAsientoContable().buildAsientoContableModulo().setId(idAsientoContableModuloArg11);
		this.buildCuentaContable().setId(idArg12);
		this.buildCuentaContable().setCodigo(codigoArg13);
		this.buildCuentaContable().setNombre(nombreArg14);
		this.buildCuentaContable().buildEjercicioContable().setId(idEjercicioContableArg15);
		this.buildCuentaContable().setIntegra(integraArg16);
		this.buildCuentaContable().setCuentaJerarquia(cuentaJerarquiaArg17);
		this.buildCuentaContable().setImputable(imputableArg18);
		this.buildCuentaContable().setAjustaPorInflacion(ajustaPorInflacionArg19);
		this.buildCuentaContable().buildCuentaContableEstado().setId(idCuentaContableEstadoArg20);
		this.buildCuentaContable().setCuentaConApropiacion(cuentaConApropiacionArg21);
		this.buildCuentaContable().buildCentroCostoContable().setId(idCentroCostoContableArg22);
		this.buildCuentaContable().setCuentaAgrupadora(cuentaAgrupadoraArg23);
		this.buildCuentaContable().setPorcentaje(porcentajeArg24);
		this.buildCuentaContable().buildPuntoEquilibrio().setId(idPuntoEquilibrioArg25);
		this.buildCuentaContable().buildCostoVenta().setId(idCostoVentaArg26);
		this.buildCuentaContable().buildSeguridadPuerta().setId(idSeguridadPuertaArg27);
		this.setDebe(debeArg28);
		this.setHaber(haberArg29);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, java.util.Date fechaArg2, String detalleArg3, String idArg4, Integer numeroArg5, java.util.Date fechaArg6, String detalleArg7, String idArg8, Integer numeroArg9, java.util.Date aperturaArg10, java.util.Date cierreArg11, Boolean cerradoArg12, Boolean cerradoModulosArg13, String comentarioArg14, String idArg15, Integer numeroArg16, String nombreArg17, String idArg18, Integer numeroArg19, String nombreArg20, String abreviaturaArg21, String idTipoSucursalArg22, String cuentaClientesDesdeArg23, String cuentaClientesHastaArg24, Integer cantidadCaracteresClientesArg25, Boolean identificacionNumericaClientesArg26, Boolean permiteCambiarClientesArg27, String cuentaProveedoresDesdeArg28, String cuentaProveedoresHastaArg29, Integer cantidadCaracteresProveedoresArg30, Boolean identificacionNumericaProveedoresArg31, Boolean permiteCambiarProveedoresArg32, Integer clientesOcacionalesDesdeArg33, Integer clientesOcacionalesHastaArg34, Integer numeroCobranzaDesdeArg35, Integer numeroCobranzaHastaArg36, String idArg37, Integer numeroArg38, String nombreArg39, String idArg40, String codigoArg41, String nombreArg42, String idArg43, Integer numeroArg44, java.util.Date aperturaArg45, java.util.Date cierreArg46, Boolean cerradoArg47, Boolean cerradoModulosArg48, String comentarioArg49, String integraArg50, String cuentaJerarquiaArg51, Boolean imputableArg52, Boolean ajustaPorInflacionArg53, String idArg54, Integer numeroArg55, String nombreArg56, Boolean cuentaConApropiacionArg57, String idArg58, Integer numeroArg59, String nombreArg60, String abreviaturaArg61, String idEjercicioContableArg62, String cuentaAgrupadoraArg63, java.math.BigDecimal porcentajeArg64, String idArg65, Integer numeroArg66, String nombreArg67, String idTipoPuntoEquilibrioArg68, String idEjercicioContableArg69, String idArg70, Integer numeroArg71, String nombreArg72, String idArg73, Integer numeroArg74, String nombreArg75, String equateArg76, String idSeguridadModuloArg77, java.math.BigDecimal debeArg78, java.math.BigDecimal haberArg79) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setFecha(fechaArg2);
		this.setDetalle(detalleArg3);
		this.buildAsientoContable().setId(idArg4);
		this.buildAsientoContable().setNumero(numeroArg5);
		this.buildAsientoContable().setFecha(fechaArg6);
		this.buildAsientoContable().setDetalle(detalleArg7);
		this.buildAsientoContable().buildEjercicioContable().setId(idArg8);
		this.buildAsientoContable().buildEjercicioContable().setNumero(numeroArg9);
		this.buildAsientoContable().buildEjercicioContable().setApertura(aperturaArg10);
		this.buildAsientoContable().buildEjercicioContable().setCierre(cierreArg11);
		this.buildAsientoContable().buildEjercicioContable().setCerrado(cerradoArg12);
		this.buildAsientoContable().buildEjercicioContable().setCerradoModulos(cerradoModulosArg13);
		this.buildAsientoContable().buildEjercicioContable().setComentario(comentarioArg14);
		this.buildAsientoContable().buildMinutaContable().setId(idArg15);
		this.buildAsientoContable().buildMinutaContable().setNumero(numeroArg16);
		this.buildAsientoContable().buildMinutaContable().setNombre(nombreArg17);
		this.buildAsientoContable().buildSucursal().setId(idArg18);
		this.buildAsientoContable().buildSucursal().setNumero(numeroArg19);
		this.buildAsientoContable().buildSucursal().setNombre(nombreArg20);
		this.buildAsientoContable().buildSucursal().setAbreviatura(abreviaturaArg21);
		this.buildAsientoContable().buildSucursal().buildTipoSucursal().setId(idTipoSucursalArg22);
		this.buildAsientoContable().buildSucursal().setCuentaClientesDesde(cuentaClientesDesdeArg23);
		this.buildAsientoContable().buildSucursal().setCuentaClientesHasta(cuentaClientesHastaArg24);
		this.buildAsientoContable().buildSucursal().setCantidadCaracteresClientes(cantidadCaracteresClientesArg25);
		this.buildAsientoContable().buildSucursal().setIdentificacionNumericaClientes(identificacionNumericaClientesArg26);
		this.buildAsientoContable().buildSucursal().setPermiteCambiarClientes(permiteCambiarClientesArg27);
		this.buildAsientoContable().buildSucursal().setCuentaProveedoresDesde(cuentaProveedoresDesdeArg28);
		this.buildAsientoContable().buildSucursal().setCuentaProveedoresHasta(cuentaProveedoresHastaArg29);
		this.buildAsientoContable().buildSucursal().setCantidadCaracteresProveedores(cantidadCaracteresProveedoresArg30);
		this.buildAsientoContable().buildSucursal().setIdentificacionNumericaProveedores(identificacionNumericaProveedoresArg31);
		this.buildAsientoContable().buildSucursal().setPermiteCambiarProveedores(permiteCambiarProveedoresArg32);
		this.buildAsientoContable().buildSucursal().setClientesOcacionalesDesde(clientesOcacionalesDesdeArg33);
		this.buildAsientoContable().buildSucursal().setClientesOcacionalesHasta(clientesOcacionalesHastaArg34);
		this.buildAsientoContable().buildSucursal().setNumeroCobranzaDesde(numeroCobranzaDesdeArg35);
		this.buildAsientoContable().buildSucursal().setNumeroCobranzaHasta(numeroCobranzaHastaArg36);
		this.buildAsientoContable().buildAsientoContableModulo().setId(idArg37);
		this.buildAsientoContable().buildAsientoContableModulo().setNumero(numeroArg38);
		this.buildAsientoContable().buildAsientoContableModulo().setNombre(nombreArg39);
		this.buildCuentaContable().setId(idArg40);
		this.buildCuentaContable().setCodigo(codigoArg41);
		this.buildCuentaContable().setNombre(nombreArg42);
		this.buildCuentaContable().buildEjercicioContable().setId(idArg43);
		this.buildCuentaContable().buildEjercicioContable().setNumero(numeroArg44);
		this.buildCuentaContable().buildEjercicioContable().setApertura(aperturaArg45);
		this.buildCuentaContable().buildEjercicioContable().setCierre(cierreArg46);
		this.buildCuentaContable().buildEjercicioContable().setCerrado(cerradoArg47);
		this.buildCuentaContable().buildEjercicioContable().setCerradoModulos(cerradoModulosArg48);
		this.buildCuentaContable().buildEjercicioContable().setComentario(comentarioArg49);
		this.buildCuentaContable().setIntegra(integraArg50);
		this.buildCuentaContable().setCuentaJerarquia(cuentaJerarquiaArg51);
		this.buildCuentaContable().setImputable(imputableArg52);
		this.buildCuentaContable().setAjustaPorInflacion(ajustaPorInflacionArg53);
		this.buildCuentaContable().buildCuentaContableEstado().setId(idArg54);
		this.buildCuentaContable().buildCuentaContableEstado().setNumero(numeroArg55);
		this.buildCuentaContable().buildCuentaContableEstado().setNombre(nombreArg56);
		this.buildCuentaContable().setCuentaConApropiacion(cuentaConApropiacionArg57);
		this.buildCuentaContable().buildCentroCostoContable().setId(idArg58);
		this.buildCuentaContable().buildCentroCostoContable().setNumero(numeroArg59);
		this.buildCuentaContable().buildCentroCostoContable().setNombre(nombreArg60);
		this.buildCuentaContable().buildCentroCostoContable().setAbreviatura(abreviaturaArg61);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setId(idEjercicioContableArg62);
		this.buildCuentaContable().setCuentaAgrupadora(cuentaAgrupadoraArg63);
		this.buildCuentaContable().setPorcentaje(porcentajeArg64);
		this.buildCuentaContable().buildPuntoEquilibrio().setId(idArg65);
		this.buildCuentaContable().buildPuntoEquilibrio().setNumero(numeroArg66);
		this.buildCuentaContable().buildPuntoEquilibrio().setNombre(nombreArg67);
		this.buildCuentaContable().buildPuntoEquilibrio().buildTipoPuntoEquilibrio().setId(idTipoPuntoEquilibrioArg68);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setId(idEjercicioContableArg69);
		this.buildCuentaContable().buildCostoVenta().setId(idArg70);
		this.buildCuentaContable().buildCostoVenta().setNumero(numeroArg71);
		this.buildCuentaContable().buildCostoVenta().setNombre(nombreArg72);
		this.buildCuentaContable().buildSeguridadPuerta().setId(idArg73);
		this.buildCuentaContable().buildSeguridadPuerta().setNumero(numeroArg74);
		this.buildCuentaContable().buildSeguridadPuerta().setNombre(nombreArg75);
		this.buildCuentaContable().buildSeguridadPuerta().setEquate(equateArg76);
		this.buildCuentaContable().buildSeguridadPuerta().buildSeguridadModulo().setId(idSeguridadModuloArg77);
		this.setDebe(debeArg78);
		this.setHaber(haberArg79);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, java.util.Date fechaArg2, String detalleArg3, String idArg4, Integer numeroArg5, java.util.Date fechaArg6, String detalleArg7, String idArg8, Integer numeroArg9, java.util.Date aperturaArg10, java.util.Date cierreArg11, Boolean cerradoArg12, Boolean cerradoModulosArg13, String comentarioArg14, String idArg15, Integer numeroArg16, String nombreArg17, String idArg18, Integer numeroArg19, String nombreArg20, String abreviaturaArg21, String idArg22, Integer numeroArg23, String nombreArg24, String cuentaClientesDesdeArg25, String cuentaClientesHastaArg26, Integer cantidadCaracteresClientesArg27, Boolean identificacionNumericaClientesArg28, Boolean permiteCambiarClientesArg29, String cuentaProveedoresDesdeArg30, String cuentaProveedoresHastaArg31, Integer cantidadCaracteresProveedoresArg32, Boolean identificacionNumericaProveedoresArg33, Boolean permiteCambiarProveedoresArg34, Integer clientesOcacionalesDesdeArg35, Integer clientesOcacionalesHastaArg36, Integer numeroCobranzaDesdeArg37, Integer numeroCobranzaHastaArg38, String idArg39, Integer numeroArg40, String nombreArg41, String idArg42, String codigoArg43, String nombreArg44, String idArg45, Integer numeroArg46, java.util.Date aperturaArg47, java.util.Date cierreArg48, Boolean cerradoArg49, Boolean cerradoModulosArg50, String comentarioArg51, String integraArg52, String cuentaJerarquiaArg53, Boolean imputableArg54, Boolean ajustaPorInflacionArg55, String idArg56, Integer numeroArg57, String nombreArg58, Boolean cuentaConApropiacionArg59, String idArg60, Integer numeroArg61, String nombreArg62, String abreviaturaArg63, String idArg64, Integer numeroArg65, java.util.Date aperturaArg66, java.util.Date cierreArg67, Boolean cerradoArg68, Boolean cerradoModulosArg69, String comentarioArg70, String cuentaAgrupadoraArg71, java.math.BigDecimal porcentajeArg72, String idArg73, Integer numeroArg74, String nombreArg75, String idArg76, Integer numeroArg77, String nombreArg78, String idArg79, Integer numeroArg80, java.util.Date aperturaArg81, java.util.Date cierreArg82, Boolean cerradoArg83, Boolean cerradoModulosArg84, String comentarioArg85, String idArg86, Integer numeroArg87, String nombreArg88, String idArg89, Integer numeroArg90, String nombreArg91, String equateArg92, String idArg93, Integer numeroArg94, String nombreArg95, java.math.BigDecimal debeArg96, java.math.BigDecimal haberArg97) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setFecha(fechaArg2);
		this.setDetalle(detalleArg3);
		this.buildAsientoContable().setId(idArg4);
		this.buildAsientoContable().setNumero(numeroArg5);
		this.buildAsientoContable().setFecha(fechaArg6);
		this.buildAsientoContable().setDetalle(detalleArg7);
		this.buildAsientoContable().buildEjercicioContable().setId(idArg8);
		this.buildAsientoContable().buildEjercicioContable().setNumero(numeroArg9);
		this.buildAsientoContable().buildEjercicioContable().setApertura(aperturaArg10);
		this.buildAsientoContable().buildEjercicioContable().setCierre(cierreArg11);
		this.buildAsientoContable().buildEjercicioContable().setCerrado(cerradoArg12);
		this.buildAsientoContable().buildEjercicioContable().setCerradoModulos(cerradoModulosArg13);
		this.buildAsientoContable().buildEjercicioContable().setComentario(comentarioArg14);
		this.buildAsientoContable().buildMinutaContable().setId(idArg15);
		this.buildAsientoContable().buildMinutaContable().setNumero(numeroArg16);
		this.buildAsientoContable().buildMinutaContable().setNombre(nombreArg17);
		this.buildAsientoContable().buildSucursal().setId(idArg18);
		this.buildAsientoContable().buildSucursal().setNumero(numeroArg19);
		this.buildAsientoContable().buildSucursal().setNombre(nombreArg20);
		this.buildAsientoContable().buildSucursal().setAbreviatura(abreviaturaArg21);
		this.buildAsientoContable().buildSucursal().buildTipoSucursal().setId(idArg22);
		this.buildAsientoContable().buildSucursal().buildTipoSucursal().setNumero(numeroArg23);
		this.buildAsientoContable().buildSucursal().buildTipoSucursal().setNombre(nombreArg24);
		this.buildAsientoContable().buildSucursal().setCuentaClientesDesde(cuentaClientesDesdeArg25);
		this.buildAsientoContable().buildSucursal().setCuentaClientesHasta(cuentaClientesHastaArg26);
		this.buildAsientoContable().buildSucursal().setCantidadCaracteresClientes(cantidadCaracteresClientesArg27);
		this.buildAsientoContable().buildSucursal().setIdentificacionNumericaClientes(identificacionNumericaClientesArg28);
		this.buildAsientoContable().buildSucursal().setPermiteCambiarClientes(permiteCambiarClientesArg29);
		this.buildAsientoContable().buildSucursal().setCuentaProveedoresDesde(cuentaProveedoresDesdeArg30);
		this.buildAsientoContable().buildSucursal().setCuentaProveedoresHasta(cuentaProveedoresHastaArg31);
		this.buildAsientoContable().buildSucursal().setCantidadCaracteresProveedores(cantidadCaracteresProveedoresArg32);
		this.buildAsientoContable().buildSucursal().setIdentificacionNumericaProveedores(identificacionNumericaProveedoresArg33);
		this.buildAsientoContable().buildSucursal().setPermiteCambiarProveedores(permiteCambiarProveedoresArg34);
		this.buildAsientoContable().buildSucursal().setClientesOcacionalesDesde(clientesOcacionalesDesdeArg35);
		this.buildAsientoContable().buildSucursal().setClientesOcacionalesHasta(clientesOcacionalesHastaArg36);
		this.buildAsientoContable().buildSucursal().setNumeroCobranzaDesde(numeroCobranzaDesdeArg37);
		this.buildAsientoContable().buildSucursal().setNumeroCobranzaHasta(numeroCobranzaHastaArg38);
		this.buildAsientoContable().buildAsientoContableModulo().setId(idArg39);
		this.buildAsientoContable().buildAsientoContableModulo().setNumero(numeroArg40);
		this.buildAsientoContable().buildAsientoContableModulo().setNombre(nombreArg41);
		this.buildCuentaContable().setId(idArg42);
		this.buildCuentaContable().setCodigo(codigoArg43);
		this.buildCuentaContable().setNombre(nombreArg44);
		this.buildCuentaContable().buildEjercicioContable().setId(idArg45);
		this.buildCuentaContable().buildEjercicioContable().setNumero(numeroArg46);
		this.buildCuentaContable().buildEjercicioContable().setApertura(aperturaArg47);
		this.buildCuentaContable().buildEjercicioContable().setCierre(cierreArg48);
		this.buildCuentaContable().buildEjercicioContable().setCerrado(cerradoArg49);
		this.buildCuentaContable().buildEjercicioContable().setCerradoModulos(cerradoModulosArg50);
		this.buildCuentaContable().buildEjercicioContable().setComentario(comentarioArg51);
		this.buildCuentaContable().setIntegra(integraArg52);
		this.buildCuentaContable().setCuentaJerarquia(cuentaJerarquiaArg53);
		this.buildCuentaContable().setImputable(imputableArg54);
		this.buildCuentaContable().setAjustaPorInflacion(ajustaPorInflacionArg55);
		this.buildCuentaContable().buildCuentaContableEstado().setId(idArg56);
		this.buildCuentaContable().buildCuentaContableEstado().setNumero(numeroArg57);
		this.buildCuentaContable().buildCuentaContableEstado().setNombre(nombreArg58);
		this.buildCuentaContable().setCuentaConApropiacion(cuentaConApropiacionArg59);
		this.buildCuentaContable().buildCentroCostoContable().setId(idArg60);
		this.buildCuentaContable().buildCentroCostoContable().setNumero(numeroArg61);
		this.buildCuentaContable().buildCentroCostoContable().setNombre(nombreArg62);
		this.buildCuentaContable().buildCentroCostoContable().setAbreviatura(abreviaturaArg63);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setId(idArg64);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setNumero(numeroArg65);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setApertura(aperturaArg66);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setCierre(cierreArg67);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setCerrado(cerradoArg68);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setCerradoModulos(cerradoModulosArg69);
		this.buildCuentaContable().buildCentroCostoContable().buildEjercicioContable().setComentario(comentarioArg70);
		this.buildCuentaContable().setCuentaAgrupadora(cuentaAgrupadoraArg71);
		this.buildCuentaContable().setPorcentaje(porcentajeArg72);
		this.buildCuentaContable().buildPuntoEquilibrio().setId(idArg73);
		this.buildCuentaContable().buildPuntoEquilibrio().setNumero(numeroArg74);
		this.buildCuentaContable().buildPuntoEquilibrio().setNombre(nombreArg75);
		this.buildCuentaContable().buildPuntoEquilibrio().buildTipoPuntoEquilibrio().setId(idArg76);
		this.buildCuentaContable().buildPuntoEquilibrio().buildTipoPuntoEquilibrio().setNumero(numeroArg77);
		this.buildCuentaContable().buildPuntoEquilibrio().buildTipoPuntoEquilibrio().setNombre(nombreArg78);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setId(idArg79);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setNumero(numeroArg80);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setApertura(aperturaArg81);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setCierre(cierreArg82);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setCerrado(cerradoArg83);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setCerradoModulos(cerradoModulosArg84);
		this.buildCuentaContable().buildPuntoEquilibrio().buildEjercicioContable().setComentario(comentarioArg85);
		this.buildCuentaContable().buildCostoVenta().setId(idArg86);
		this.buildCuentaContable().buildCostoVenta().setNumero(numeroArg87);
		this.buildCuentaContable().buildCostoVenta().setNombre(nombreArg88);
		this.buildCuentaContable().buildSeguridadPuerta().setId(idArg89);
		this.buildCuentaContable().buildSeguridadPuerta().setNumero(numeroArg90);
		this.buildCuentaContable().buildSeguridadPuerta().setNombre(nombreArg91);
		this.buildCuentaContable().buildSeguridadPuerta().setEquate(equateArg92);
		this.buildCuentaContable().buildSeguridadPuerta().buildSeguridadModulo().setId(idArg93);
		this.buildCuentaContable().buildSeguridadPuerta().buildSeguridadModulo().setNumero(numeroArg94);
		this.buildCuentaContable().buildSeguridadPuerta().buildSeguridadModulo().setNombre(nombreArg95);
		this.setDebe(debeArg96);
		this.setHaber(haberArg97);

	}

	// ---------------------------------------------------------------------------------------------------------------------------

	public String toString() {
		if(this.getNumero() != null && this.getFecha() != null){
			return this.getNumero() + " - " +  this.getFecha();
		} else if(this.getNumero() != null && this.getFecha() == null){
			return this.getNumero().toString();
		} else if(this.getNumero() == null && this.getFecha() != null){
			return this.getFecha().toString();
		} else {
			return super.toString();
		}
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------