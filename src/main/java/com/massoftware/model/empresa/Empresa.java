package com.massoftware.model.empresa;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.contabilidad.EjercicioContable;

@ClassLabelAnont(singular = "Empresa", plural = "Empresas", singularPre = "la empresa", pluralPre = "las empresas")
public class Empresa extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Ejercicio
	@FieldConfAnont(label = "Ejercicio", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private EjercicioContable ejercicioContable;

	// Fecha cierre ventas
	@FieldConfAnont(label = "Fecha cierre ventas", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.util.Date fechaCierreVentas;

	// Fecha cierre stock
	@FieldConfAnont(label = "Fecha cierre stock", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.util.Date fechaCierreStock;

	// Fecha cierre fondo
	@FieldConfAnont(label = "Fecha cierre fondo", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.util.Date fechaCierreFondo;

	// Fecha cierre compras
	@FieldConfAnont(label = "Fecha cierre compras", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.util.Date fechaCierreCompras;

	// Fecha cierre contabilidad
	@FieldConfAnont(label = "Fecha cierre contabilidad", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.util.Date fechaCierreContabilidad;

	// Fecha cierre garantia y devoluciones
	@FieldConfAnont(label = "Fecha cierre garantia y devoluciones", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.util.Date fechaCierreGarantiaDevoluciones;

	// Fecha cierre tambos
	@FieldConfAnont(label = "Fecha cierre tambos", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.util.Date fechaCierreTambos;

	// Fecha cierre RRHH
	@FieldConfAnont(label = "Fecha cierre RRHH", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.util.Date fechaCierreRRHH;

	// ---------------------------------------------------------------------------------------------------------------------------


	public Empresa() throws Exception {
	}

	public Empresa(String idArg0, String idEjercicioContableArg1, java.util.Date fechaCierreVentasArg2, java.util.Date fechaCierreStockArg3, java.util.Date fechaCierreFondoArg4, java.util.Date fechaCierreComprasArg5, java.util.Date fechaCierreContabilidadArg6, java.util.Date fechaCierreGarantiaDevolucionesArg7, java.util.Date fechaCierreTambosArg8, java.util.Date fechaCierreRRHHArg9) throws Exception {

		setter(idArg0, idEjercicioContableArg1, fechaCierreVentasArg2, fechaCierreStockArg3, fechaCierreFondoArg4, fechaCierreComprasArg5, fechaCierreContabilidadArg6, fechaCierreGarantiaDevolucionesArg7, fechaCierreTambosArg8, fechaCierreRRHHArg9);

	}

	public Empresa(String idArg0, String idArg1, Integer numeroArg2, java.util.Date aperturaArg3, java.util.Date cierreArg4, Boolean cerradoArg5, Boolean cerradoModulosArg6, String comentarioArg7, java.util.Date fechaCierreVentasArg8, java.util.Date fechaCierreStockArg9, java.util.Date fechaCierreFondoArg10, java.util.Date fechaCierreComprasArg11, java.util.Date fechaCierreContabilidadArg12, java.util.Date fechaCierreGarantiaDevolucionesArg13, java.util.Date fechaCierreTambosArg14, java.util.Date fechaCierreRRHHArg15) throws Exception {

		setter(idArg0, idArg1, numeroArg2, aperturaArg3, cierreArg4, cerradoArg5, cerradoModulosArg6, comentarioArg7, fechaCierreVentasArg8, fechaCierreStockArg9, fechaCierreFondoArg10, fechaCierreComprasArg11, fechaCierreContabilidadArg12, fechaCierreGarantiaDevolucionesArg13, fechaCierreTambosArg14, fechaCierreRRHHArg15);

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

	// GET Fecha cierre ventas
	public java.util.Date getFechaCierreVentas() {
		return this.fechaCierreVentas;
	}

	// SET Fecha cierre ventas
	public void setFechaCierreVentas(java.util.Date fechaCierreVentas ){
		this.fechaCierreVentas = fechaCierreVentas;
	}

	// GET Fecha cierre stock
	public java.util.Date getFechaCierreStock() {
		return this.fechaCierreStock;
	}

	// SET Fecha cierre stock
	public void setFechaCierreStock(java.util.Date fechaCierreStock ){
		this.fechaCierreStock = fechaCierreStock;
	}

	// GET Fecha cierre fondo
	public java.util.Date getFechaCierreFondo() {
		return this.fechaCierreFondo;
	}

	// SET Fecha cierre fondo
	public void setFechaCierreFondo(java.util.Date fechaCierreFondo ){
		this.fechaCierreFondo = fechaCierreFondo;
	}

	// GET Fecha cierre compras
	public java.util.Date getFechaCierreCompras() {
		return this.fechaCierreCompras;
	}

	// SET Fecha cierre compras
	public void setFechaCierreCompras(java.util.Date fechaCierreCompras ){
		this.fechaCierreCompras = fechaCierreCompras;
	}

	// GET Fecha cierre contabilidad
	public java.util.Date getFechaCierreContabilidad() {
		return this.fechaCierreContabilidad;
	}

	// SET Fecha cierre contabilidad
	public void setFechaCierreContabilidad(java.util.Date fechaCierreContabilidad ){
		this.fechaCierreContabilidad = fechaCierreContabilidad;
	}

	// GET Fecha cierre garantia y devoluciones
	public java.util.Date getFechaCierreGarantiaDevoluciones() {
		return this.fechaCierreGarantiaDevoluciones;
	}

	// SET Fecha cierre garantia y devoluciones
	public void setFechaCierreGarantiaDevoluciones(java.util.Date fechaCierreGarantiaDevoluciones ){
		this.fechaCierreGarantiaDevoluciones = fechaCierreGarantiaDevoluciones;
	}

	// GET Fecha cierre tambos
	public java.util.Date getFechaCierreTambos() {
		return this.fechaCierreTambos;
	}

	// SET Fecha cierre tambos
	public void setFechaCierreTambos(java.util.Date fechaCierreTambos ){
		this.fechaCierreTambos = fechaCierreTambos;
	}

	// GET Fecha cierre RRHH
	public java.util.Date getFechaCierreRRHH() {
		return this.fechaCierreRRHH;
	}

	// SET Fecha cierre RRHH
	public void setFechaCierreRRHH(java.util.Date fechaCierreRRHH ){
		this.fechaCierreRRHH = fechaCierreRRHH;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, String idEjercicioContableArg1, java.util.Date fechaCierreVentasArg2, java.util.Date fechaCierreStockArg3, java.util.Date fechaCierreFondoArg4, java.util.Date fechaCierreComprasArg5, java.util.Date fechaCierreContabilidadArg6, java.util.Date fechaCierreGarantiaDevolucionesArg7, java.util.Date fechaCierreTambosArg8, java.util.Date fechaCierreRRHHArg9) throws Exception {

		this.setId(idArg0);
		this.buildEjercicioContable().setId(idEjercicioContableArg1);
		this.setFechaCierreVentas(fechaCierreVentasArg2);
		this.setFechaCierreStock(fechaCierreStockArg3);
		this.setFechaCierreFondo(fechaCierreFondoArg4);
		this.setFechaCierreCompras(fechaCierreComprasArg5);
		this.setFechaCierreContabilidad(fechaCierreContabilidadArg6);
		this.setFechaCierreGarantiaDevoluciones(fechaCierreGarantiaDevolucionesArg7);
		this.setFechaCierreTambos(fechaCierreTambosArg8);
		this.setFechaCierreRRHH(fechaCierreRRHHArg9);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, String idArg1, Integer numeroArg2, java.util.Date aperturaArg3, java.util.Date cierreArg4, Boolean cerradoArg5, Boolean cerradoModulosArg6, String comentarioArg7, java.util.Date fechaCierreVentasArg8, java.util.Date fechaCierreStockArg9, java.util.Date fechaCierreFondoArg10, java.util.Date fechaCierreComprasArg11, java.util.Date fechaCierreContabilidadArg12, java.util.Date fechaCierreGarantiaDevolucionesArg13, java.util.Date fechaCierreTambosArg14, java.util.Date fechaCierreRRHHArg15) throws Exception {

		this.setId(idArg0);
		this.buildEjercicioContable().setId(idArg1);
		this.buildEjercicioContable().setNumero(numeroArg2);
		this.buildEjercicioContable().setApertura(aperturaArg3);
		this.buildEjercicioContable().setCierre(cierreArg4);
		this.buildEjercicioContable().setCerrado(cerradoArg5);
		this.buildEjercicioContable().setCerradoModulos(cerradoModulosArg6);
		this.buildEjercicioContable().setComentario(comentarioArg7);
		this.setFechaCierreVentas(fechaCierreVentasArg8);
		this.setFechaCierreStock(fechaCierreStockArg9);
		this.setFechaCierreFondo(fechaCierreFondoArg10);
		this.setFechaCierreCompras(fechaCierreComprasArg11);
		this.setFechaCierreContabilidad(fechaCierreContabilidadArg12);
		this.setFechaCierreGarantiaDevoluciones(fechaCierreGarantiaDevolucionesArg13);
		this.setFechaCierreTambos(fechaCierreTambosArg14);
		this.setFechaCierreRRHH(fechaCierreRRHHArg15);

	}

	// ---------------------------------------------------------------------------------------------------------------------------

	public String toString() {
		if(this.getEjercicioContable() != null && this.getFechaCierreVentas() != null){
			return this.getEjercicioContable() + " - " +  this.getFechaCierreVentas();
		} else if(this.getEjercicioContable() != null && this.getFechaCierreVentas() == null){
			return this.getEjercicioContable().toString();
		} else if(this.getEjercicioContable() == null && this.getFechaCierreVentas() != null){
			return this.getFechaCierreVentas().toString();
		} else {
			return super.toString();
		}
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------