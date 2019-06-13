package com.massoftware.model.contabilidad;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.contabilidad.EjercicioContable;
import com.massoftware.model.contabilidad.CuentaContableEstado;
import com.massoftware.model.contabilidad.CentroCostoContable;
import com.massoftware.model.contabilidad.PuntoEquilibrio;
import com.massoftware.model.contabilidad.CostoVenta;
import com.massoftware.model.seguridad.SeguridadPuerta;

@ClassLabelAnont(singular = "Cuenta contable", plural = "Cuentas contables", singularPre = "la cuenta contable", pluralPre = "las cuentas contables")
public class CuentaContable extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Cuenta contable
	@FieldConfAnont(label = "Cuenta contable", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 11, minValue = "", maxValue = "", mask = "")
	private String codigo;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Ejercicio
	@FieldConfAnont(label = "Ejercicio", labelError = "", unique = false, readOnly = true, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private EjercicioContable ejercicioContable;

	// Integra
	@FieldConfAnont(label = "Integra", labelError = "", unique = false, readOnly = true, required = false, columns = 16.0f, maxLength = 16, minValue = "", maxValue = "", mask = "9.99.99.99.99.99")
	private String integra;

	// Cuenta de jerarquia
	@FieldConfAnont(label = "Cuenta de jerarquia", labelError = "", unique = false, readOnly = true, required = false, columns = 16.0f, maxLength = 16, minValue = "", maxValue = "", mask = "9.99.99.99.99.99")
	private String cuentaJerarquia;

	// Imputable
	@FieldConfAnont(label = "Imputable", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean imputable = false;

	// Ajusta por inflación
	@FieldConfAnont(label = "Ajusta por inflación", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean ajustaPorInflacion = false;

	// Estado
	@FieldConfAnont(label = "Estado", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private CuentaContableEstado cuentaContableEstado;

	// Cuenta con apropiación
	@FieldConfAnont(label = "Cuenta con apropiación", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean cuentaConApropiacion = false;

	// Estado
	@FieldConfAnont(label = "Estado", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private CentroCostoContable centroCostoContable;

	// Cuenta agrupadora
	@FieldConfAnont(label = "Cuenta agrupadora", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String cuentaAgrupadora;

	// Porcentaje
	@FieldConfAnont(label = "Porcentaje", labelError = "", unique = false, readOnly = false, required = false, columns = 6.0f, maxLength = 6, minValue = "0", maxValue = "999.99", mask = "")
	private java.math.BigDecimal porcentaje;

	// Punto de equilibrio
	@FieldConfAnont(label = "Punto de equilibrio", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private PuntoEquilibrio puntoEquilibrio;

	// Costo de venta
	@FieldConfAnont(label = "Costo de venta", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private CostoVenta costoVenta;

	// Puerta
	@FieldConfAnont(label = "Puerta", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private SeguridadPuerta seguridadPuerta;

	// ---------------------------------------------------------------------------------------------------------------------------


	public CuentaContable() throws Exception {
	}

	public CuentaContable(String idArg0, String codigoArg1, String nombreArg2, String idEjercicioContableArg3, String integraArg4, String cuentaJerarquiaArg5, Boolean imputableArg6, Boolean ajustaPorInflacionArg7, String idCuentaContableEstadoArg8, Boolean cuentaConApropiacionArg9, String idCentroCostoContableArg10, String cuentaAgrupadoraArg11, java.math.BigDecimal porcentajeArg12, String idPuntoEquilibrioArg13, String idCostoVentaArg14, String idSeguridadPuertaArg15) throws Exception {

		setter(idArg0, codigoArg1, nombreArg2, idEjercicioContableArg3, integraArg4, cuentaJerarquiaArg5, imputableArg6, ajustaPorInflacionArg7, idCuentaContableEstadoArg8, cuentaConApropiacionArg9, idCentroCostoContableArg10, cuentaAgrupadoraArg11, porcentajeArg12, idPuntoEquilibrioArg13, idCostoVentaArg14, idSeguridadPuertaArg15);

	}

	public CuentaContable(String idArg0, String codigoArg1, String nombreArg2, String idArg3, Integer numeroArg4, java.util.Date aperturaArg5, java.util.Date cierreArg6, Boolean cerradoArg7, Boolean cerradoModulosArg8, String comentarioArg9, String integraArg10, String cuentaJerarquiaArg11, Boolean imputableArg12, Boolean ajustaPorInflacionArg13, String idArg14, Integer numeroArg15, String nombreArg16, Boolean cuentaConApropiacionArg17, String idArg18, Integer numeroArg19, String nombreArg20, String abreviaturaArg21, String idEjercicioContableArg22, String cuentaAgrupadoraArg23, java.math.BigDecimal porcentajeArg24, String idArg25, Integer numeroArg26, String nombreArg27, String idTipoPuntoEquilibrioArg28, String idEjercicioContableArg29, String idArg30, Integer numeroArg31, String nombreArg32, String idArg33, Integer numeroArg34, String nombreArg35, String equateArg36, String idSeguridadModuloArg37) throws Exception {

		setter(idArg0, codigoArg1, nombreArg2, idArg3, numeroArg4, aperturaArg5, cierreArg6, cerradoArg7, cerradoModulosArg8, comentarioArg9, integraArg10, cuentaJerarquiaArg11, imputableArg12, ajustaPorInflacionArg13, idArg14, numeroArg15, nombreArg16, cuentaConApropiacionArg17, idArg18, numeroArg19, nombreArg20, abreviaturaArg21, idEjercicioContableArg22, cuentaAgrupadoraArg23, porcentajeArg24, idArg25, numeroArg26, nombreArg27, idTipoPuntoEquilibrioArg28, idEjercicioContableArg29, idArg30, numeroArg31, nombreArg32, idArg33, numeroArg34, nombreArg35, equateArg36, idSeguridadModuloArg37);

	}

	public CuentaContable(String idArg0, String codigoArg1, String nombreArg2, String idArg3, Integer numeroArg4, java.util.Date aperturaArg5, java.util.Date cierreArg6, Boolean cerradoArg7, Boolean cerradoModulosArg8, String comentarioArg9, String integraArg10, String cuentaJerarquiaArg11, Boolean imputableArg12, Boolean ajustaPorInflacionArg13, String idArg14, Integer numeroArg15, String nombreArg16, Boolean cuentaConApropiacionArg17, String idArg18, Integer numeroArg19, String nombreArg20, String abreviaturaArg21, String idArg22, Integer numeroArg23, java.util.Date aperturaArg24, java.util.Date cierreArg25, Boolean cerradoArg26, Boolean cerradoModulosArg27, String comentarioArg28, String cuentaAgrupadoraArg29, java.math.BigDecimal porcentajeArg30, String idArg31, Integer numeroArg32, String nombreArg33, String idArg34, Integer numeroArg35, String nombreArg36, String idArg37, Integer numeroArg38, java.util.Date aperturaArg39, java.util.Date cierreArg40, Boolean cerradoArg41, Boolean cerradoModulosArg42, String comentarioArg43, String idArg44, Integer numeroArg45, String nombreArg46, String idArg47, Integer numeroArg48, String nombreArg49, String equateArg50, String idArg51, Integer numeroArg52, String nombreArg53) throws Exception {

		setter(idArg0, codigoArg1, nombreArg2, idArg3, numeroArg4, aperturaArg5, cierreArg6, cerradoArg7, cerradoModulosArg8, comentarioArg9, integraArg10, cuentaJerarquiaArg11, imputableArg12, ajustaPorInflacionArg13, idArg14, numeroArg15, nombreArg16, cuentaConApropiacionArg17, idArg18, numeroArg19, nombreArg20, abreviaturaArg21, idArg22, numeroArg23, aperturaArg24, cierreArg25, cerradoArg26, cerradoModulosArg27, comentarioArg28, cuentaAgrupadoraArg29, porcentajeArg30, idArg31, numeroArg32, nombreArg33, idArg34, numeroArg35, nombreArg36, idArg37, numeroArg38, aperturaArg39, cierreArg40, cerradoArg41, cerradoModulosArg42, comentarioArg43, idArg44, numeroArg45, nombreArg46, idArg47, numeroArg48, nombreArg49, equateArg50, idArg51, numeroArg52, nombreArg53);

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

	// GET Cuenta contable
	public String getCodigo() {
		return this.codigo;
	}

	// SET Cuenta contable
	public void setCodigo(String codigo ){
		codigo = (codigo != null) ? codigo.trim() : null;
		this.codigo = (codigo != null && codigo.length() == 0) ? null : codigo;
	}

	// GET Nombre
	public String getNombre() {
		return this.nombre;
	}

	// SET Nombre
	public void setNombre(String nombre ){
		nombre = (nombre != null) ? nombre.trim() : null;
		this.nombre = (nombre != null && nombre.length() == 0) ? null : nombre;
	}

	// BUILD IF NULL AND GET Ejercicio
	public EjercicioContable buildEjercicioContable() throws Exception {
		this.ejercicioContable = (this.ejercicioContable == null) ? new EjercicioContable() : this.ejercicioContable;
		return this.ejercicioContable;
	}

	// GET Ejercicio
	public EjercicioContable getEjercicioContable() {
		this.ejercicioContable = (this.ejercicioContable != null && this.ejercicioContable.getId() == null) ? null : this.ejercicioContable ;
		return this.ejercicioContable;
	}

	// SET Ejercicio
	public void setEjercicioContable(EjercicioContable ejercicioContable ){
		this.ejercicioContable = ejercicioContable;
	}

	// GET Integra
	public String getIntegra() {
		return this.integra;
	}

	// SET Integra
	public void setIntegra(String integra ){
		integra = (integra != null) ? integra.trim() : null;
		this.integra = (integra != null && integra.length() == 0) ? null : integra;
	}

	// GET Cuenta de jerarquia
	public String getCuentaJerarquia() {
		return this.cuentaJerarquia;
	}

	// SET Cuenta de jerarquia
	public void setCuentaJerarquia(String cuentaJerarquia ){
		cuentaJerarquia = (cuentaJerarquia != null) ? cuentaJerarquia.trim() : null;
		this.cuentaJerarquia = (cuentaJerarquia != null && cuentaJerarquia.length() == 0) ? null : cuentaJerarquia;
	}

	// GET Imputable
	public Boolean getImputable() {
		return this.imputable;
	}

	// SET Imputable
	public void setImputable(Boolean imputable ){
		this.imputable = (imputable == null) ? false : imputable;
	}

	// GET Ajusta por inflación
	public Boolean getAjustaPorInflacion() {
		return this.ajustaPorInflacion;
	}

	// SET Ajusta por inflación
	public void setAjustaPorInflacion(Boolean ajustaPorInflacion ){
		this.ajustaPorInflacion = (ajustaPorInflacion == null) ? false : ajustaPorInflacion;
	}

	// BUILD IF NULL AND GET Estado
	public CuentaContableEstado buildCuentaContableEstado() throws Exception {
		this.cuentaContableEstado = (this.cuentaContableEstado == null) ? new CuentaContableEstado() : this.cuentaContableEstado;
		return this.cuentaContableEstado;
	}

	// GET Estado
	public CuentaContableEstado getCuentaContableEstado() {
		this.cuentaContableEstado = (this.cuentaContableEstado != null && this.cuentaContableEstado.getId() == null) ? null : this.cuentaContableEstado ;
		return this.cuentaContableEstado;
	}

	// SET Estado
	public void setCuentaContableEstado(CuentaContableEstado cuentaContableEstado ){
		this.cuentaContableEstado = cuentaContableEstado;
	}

	// GET Cuenta con apropiación
	public Boolean getCuentaConApropiacion() {
		return this.cuentaConApropiacion;
	}

	// SET Cuenta con apropiación
	public void setCuentaConApropiacion(Boolean cuentaConApropiacion ){
		this.cuentaConApropiacion = (cuentaConApropiacion == null) ? false : cuentaConApropiacion;
	}

	// BUILD IF NULL AND GET Estado
	public CentroCostoContable buildCentroCostoContable() throws Exception {
		this.centroCostoContable = (this.centroCostoContable == null) ? new CentroCostoContable() : this.centroCostoContable;
		return this.centroCostoContable;
	}

	// GET Estado
	public CentroCostoContable getCentroCostoContable() {
		this.centroCostoContable = (this.centroCostoContable != null && this.centroCostoContable.getId() == null) ? null : this.centroCostoContable ;
		return this.centroCostoContable;
	}

	// SET Estado
	public void setCentroCostoContable(CentroCostoContable centroCostoContable ){
		this.centroCostoContable = centroCostoContable;
	}

	// GET Cuenta agrupadora
	public String getCuentaAgrupadora() {
		return this.cuentaAgrupadora;
	}

	// SET Cuenta agrupadora
	public void setCuentaAgrupadora(String cuentaAgrupadora ){
		cuentaAgrupadora = (cuentaAgrupadora != null) ? cuentaAgrupadora.trim() : null;
		this.cuentaAgrupadora = (cuentaAgrupadora != null && cuentaAgrupadora.length() == 0) ? null : cuentaAgrupadora;
	}

	// GET Porcentaje
	public java.math.BigDecimal getPorcentaje() {
		return this.porcentaje;
	}

	// SET Porcentaje
	public void setPorcentaje(java.math.BigDecimal porcentaje ){
		this.porcentaje = porcentaje;
	}

	// BUILD IF NULL AND GET Punto de equilibrio
	public PuntoEquilibrio buildPuntoEquilibrio() throws Exception {
		this.puntoEquilibrio = (this.puntoEquilibrio == null) ? new PuntoEquilibrio() : this.puntoEquilibrio;
		return this.puntoEquilibrio;
	}

	// GET Punto de equilibrio
	public PuntoEquilibrio getPuntoEquilibrio() {
		this.puntoEquilibrio = (this.puntoEquilibrio != null && this.puntoEquilibrio.getId() == null) ? null : this.puntoEquilibrio ;
		return this.puntoEquilibrio;
	}

	// SET Punto de equilibrio
	public void setPuntoEquilibrio(PuntoEquilibrio puntoEquilibrio ){
		this.puntoEquilibrio = puntoEquilibrio;
	}

	// BUILD IF NULL AND GET Costo de venta
	public CostoVenta buildCostoVenta() throws Exception {
		this.costoVenta = (this.costoVenta == null) ? new CostoVenta() : this.costoVenta;
		return this.costoVenta;
	}

	// GET Costo de venta
	public CostoVenta getCostoVenta() {
		this.costoVenta = (this.costoVenta != null && this.costoVenta.getId() == null) ? null : this.costoVenta ;
		return this.costoVenta;
	}

	// SET Costo de venta
	public void setCostoVenta(CostoVenta costoVenta ){
		this.costoVenta = costoVenta;
	}

	// BUILD IF NULL AND GET Puerta
	public SeguridadPuerta buildSeguridadPuerta() throws Exception {
		this.seguridadPuerta = (this.seguridadPuerta == null) ? new SeguridadPuerta() : this.seguridadPuerta;
		return this.seguridadPuerta;
	}

	// GET Puerta
	public SeguridadPuerta getSeguridadPuerta() {
		this.seguridadPuerta = (this.seguridadPuerta != null && this.seguridadPuerta.getId() == null) ? null : this.seguridadPuerta ;
		return this.seguridadPuerta;
	}

	// SET Puerta
	public void setSeguridadPuerta(SeguridadPuerta seguridadPuerta ){
		this.seguridadPuerta = seguridadPuerta;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, String codigoArg1, String nombreArg2, String idEjercicioContableArg3, String integraArg4, String cuentaJerarquiaArg5, Boolean imputableArg6, Boolean ajustaPorInflacionArg7, String idCuentaContableEstadoArg8, Boolean cuentaConApropiacionArg9, String idCentroCostoContableArg10, String cuentaAgrupadoraArg11, java.math.BigDecimal porcentajeArg12, String idPuntoEquilibrioArg13, String idCostoVentaArg14, String idSeguridadPuertaArg15) throws Exception {

		this.setId(idArg0);
		this.setCodigo(codigoArg1);
		this.setNombre(nombreArg2);
		this.buildEjercicioContable().setId(idEjercicioContableArg3);
		this.setIntegra(integraArg4);
		this.setCuentaJerarquia(cuentaJerarquiaArg5);
		this.setImputable(imputableArg6);
		this.setAjustaPorInflacion(ajustaPorInflacionArg7);
		this.buildCuentaContableEstado().setId(idCuentaContableEstadoArg8);
		this.setCuentaConApropiacion(cuentaConApropiacionArg9);
		this.buildCentroCostoContable().setId(idCentroCostoContableArg10);
		this.setCuentaAgrupadora(cuentaAgrupadoraArg11);
		this.setPorcentaje(porcentajeArg12);
		this.buildPuntoEquilibrio().setId(idPuntoEquilibrioArg13);
		this.buildCostoVenta().setId(idCostoVentaArg14);
		this.buildSeguridadPuerta().setId(idSeguridadPuertaArg15);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, String codigoArg1, String nombreArg2, String idArg3, Integer numeroArg4, java.util.Date aperturaArg5, java.util.Date cierreArg6, Boolean cerradoArg7, Boolean cerradoModulosArg8, String comentarioArg9, String integraArg10, String cuentaJerarquiaArg11, Boolean imputableArg12, Boolean ajustaPorInflacionArg13, String idArg14, Integer numeroArg15, String nombreArg16, Boolean cuentaConApropiacionArg17, String idArg18, Integer numeroArg19, String nombreArg20, String abreviaturaArg21, String idEjercicioContableArg22, String cuentaAgrupadoraArg23, java.math.BigDecimal porcentajeArg24, String idArg25, Integer numeroArg26, String nombreArg27, String idTipoPuntoEquilibrioArg28, String idEjercicioContableArg29, String idArg30, Integer numeroArg31, String nombreArg32, String idArg33, Integer numeroArg34, String nombreArg35, String equateArg36, String idSeguridadModuloArg37) throws Exception {

		this.setId(idArg0);
		this.setCodigo(codigoArg1);
		this.setNombre(nombreArg2);
		this.buildEjercicioContable().setId(idArg3);
		this.buildEjercicioContable().setNumero(numeroArg4);
		this.buildEjercicioContable().setApertura(aperturaArg5);
		this.buildEjercicioContable().setCierre(cierreArg6);
		this.buildEjercicioContable().setCerrado(cerradoArg7);
		this.buildEjercicioContable().setCerradoModulos(cerradoModulosArg8);
		this.buildEjercicioContable().setComentario(comentarioArg9);
		this.setIntegra(integraArg10);
		this.setCuentaJerarquia(cuentaJerarquiaArg11);
		this.setImputable(imputableArg12);
		this.setAjustaPorInflacion(ajustaPorInflacionArg13);
		this.buildCuentaContableEstado().setId(idArg14);
		this.buildCuentaContableEstado().setNumero(numeroArg15);
		this.buildCuentaContableEstado().setNombre(nombreArg16);
		this.setCuentaConApropiacion(cuentaConApropiacionArg17);
		this.buildCentroCostoContable().setId(idArg18);
		this.buildCentroCostoContable().setNumero(numeroArg19);
		this.buildCentroCostoContable().setNombre(nombreArg20);
		this.buildCentroCostoContable().setAbreviatura(abreviaturaArg21);
		this.buildCentroCostoContable().buildEjercicioContable().setId(idEjercicioContableArg22);
		this.setCuentaAgrupadora(cuentaAgrupadoraArg23);
		this.setPorcentaje(porcentajeArg24);
		this.buildPuntoEquilibrio().setId(idArg25);
		this.buildPuntoEquilibrio().setNumero(numeroArg26);
		this.buildPuntoEquilibrio().setNombre(nombreArg27);
		this.buildPuntoEquilibrio().buildTipoPuntoEquilibrio().setId(idTipoPuntoEquilibrioArg28);
		this.buildPuntoEquilibrio().buildEjercicioContable().setId(idEjercicioContableArg29);
		this.buildCostoVenta().setId(idArg30);
		this.buildCostoVenta().setNumero(numeroArg31);
		this.buildCostoVenta().setNombre(nombreArg32);
		this.buildSeguridadPuerta().setId(idArg33);
		this.buildSeguridadPuerta().setNumero(numeroArg34);
		this.buildSeguridadPuerta().setNombre(nombreArg35);
		this.buildSeguridadPuerta().setEquate(equateArg36);
		this.buildSeguridadPuerta().buildSeguridadModulo().setId(idSeguridadModuloArg37);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, String codigoArg1, String nombreArg2, String idArg3, Integer numeroArg4, java.util.Date aperturaArg5, java.util.Date cierreArg6, Boolean cerradoArg7, Boolean cerradoModulosArg8, String comentarioArg9, String integraArg10, String cuentaJerarquiaArg11, Boolean imputableArg12, Boolean ajustaPorInflacionArg13, String idArg14, Integer numeroArg15, String nombreArg16, Boolean cuentaConApropiacionArg17, String idArg18, Integer numeroArg19, String nombreArg20, String abreviaturaArg21, String idArg22, Integer numeroArg23, java.util.Date aperturaArg24, java.util.Date cierreArg25, Boolean cerradoArg26, Boolean cerradoModulosArg27, String comentarioArg28, String cuentaAgrupadoraArg29, java.math.BigDecimal porcentajeArg30, String idArg31, Integer numeroArg32, String nombreArg33, String idArg34, Integer numeroArg35, String nombreArg36, String idArg37, Integer numeroArg38, java.util.Date aperturaArg39, java.util.Date cierreArg40, Boolean cerradoArg41, Boolean cerradoModulosArg42, String comentarioArg43, String idArg44, Integer numeroArg45, String nombreArg46, String idArg47, Integer numeroArg48, String nombreArg49, String equateArg50, String idArg51, Integer numeroArg52, String nombreArg53) throws Exception {

		this.setId(idArg0);
		this.setCodigo(codigoArg1);
		this.setNombre(nombreArg2);
		this.buildEjercicioContable().setId(idArg3);
		this.buildEjercicioContable().setNumero(numeroArg4);
		this.buildEjercicioContable().setApertura(aperturaArg5);
		this.buildEjercicioContable().setCierre(cierreArg6);
		this.buildEjercicioContable().setCerrado(cerradoArg7);
		this.buildEjercicioContable().setCerradoModulos(cerradoModulosArg8);
		this.buildEjercicioContable().setComentario(comentarioArg9);
		this.setIntegra(integraArg10);
		this.setCuentaJerarquia(cuentaJerarquiaArg11);
		this.setImputable(imputableArg12);
		this.setAjustaPorInflacion(ajustaPorInflacionArg13);
		this.buildCuentaContableEstado().setId(idArg14);
		this.buildCuentaContableEstado().setNumero(numeroArg15);
		this.buildCuentaContableEstado().setNombre(nombreArg16);
		this.setCuentaConApropiacion(cuentaConApropiacionArg17);
		this.buildCentroCostoContable().setId(idArg18);
		this.buildCentroCostoContable().setNumero(numeroArg19);
		this.buildCentroCostoContable().setNombre(nombreArg20);
		this.buildCentroCostoContable().setAbreviatura(abreviaturaArg21);
		this.buildCentroCostoContable().buildEjercicioContable().setId(idArg22);
		this.buildCentroCostoContable().buildEjercicioContable().setNumero(numeroArg23);
		this.buildCentroCostoContable().buildEjercicioContable().setApertura(aperturaArg24);
		this.buildCentroCostoContable().buildEjercicioContable().setCierre(cierreArg25);
		this.buildCentroCostoContable().buildEjercicioContable().setCerrado(cerradoArg26);
		this.buildCentroCostoContable().buildEjercicioContable().setCerradoModulos(cerradoModulosArg27);
		this.buildCentroCostoContable().buildEjercicioContable().setComentario(comentarioArg28);
		this.setCuentaAgrupadora(cuentaAgrupadoraArg29);
		this.setPorcentaje(porcentajeArg30);
		this.buildPuntoEquilibrio().setId(idArg31);
		this.buildPuntoEquilibrio().setNumero(numeroArg32);
		this.buildPuntoEquilibrio().setNombre(nombreArg33);
		this.buildPuntoEquilibrio().buildTipoPuntoEquilibrio().setId(idArg34);
		this.buildPuntoEquilibrio().buildTipoPuntoEquilibrio().setNumero(numeroArg35);
		this.buildPuntoEquilibrio().buildTipoPuntoEquilibrio().setNombre(nombreArg36);
		this.buildPuntoEquilibrio().buildEjercicioContable().setId(idArg37);
		this.buildPuntoEquilibrio().buildEjercicioContable().setNumero(numeroArg38);
		this.buildPuntoEquilibrio().buildEjercicioContable().setApertura(aperturaArg39);
		this.buildPuntoEquilibrio().buildEjercicioContable().setCierre(cierreArg40);
		this.buildPuntoEquilibrio().buildEjercicioContable().setCerrado(cerradoArg41);
		this.buildPuntoEquilibrio().buildEjercicioContable().setCerradoModulos(cerradoModulosArg42);
		this.buildPuntoEquilibrio().buildEjercicioContable().setComentario(comentarioArg43);
		this.buildCostoVenta().setId(idArg44);
		this.buildCostoVenta().setNumero(numeroArg45);
		this.buildCostoVenta().setNombre(nombreArg46);
		this.buildSeguridadPuerta().setId(idArg47);
		this.buildSeguridadPuerta().setNumero(numeroArg48);
		this.buildSeguridadPuerta().setNombre(nombreArg49);
		this.buildSeguridadPuerta().setEquate(equateArg50);
		this.buildSeguridadPuerta().buildSeguridadModulo().setId(idArg51);
		this.buildSeguridadPuerta().buildSeguridadModulo().setNumero(numeroArg52);
		this.buildSeguridadPuerta().buildSeguridadModulo().setNombre(nombreArg53);

	}

	// ---------------------------------------------------------------------------------------------------------------------------

	public String toString() {
		if(this.getCodigo() != null && this.getNombre() != null){
			return this.getCodigo() + " - " +  this.getNombre();
		} else if(this.getCodigo() != null && this.getNombre() == null){
			return this.getCodigo();
		} else if(this.getCodigo() == null && this.getNombre() != null){
			return this.getNombre();
		} else {
			return super.toString();
		}
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------