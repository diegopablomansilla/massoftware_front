package com.massoftware.model.empresa;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.empresa.TipoSucursal;

@ClassLabelAnont(singular = "Sucursal", plural = "Sucursales", singularPre = "la sucursal", pluralPre = "las sucursales")
public class Sucursal extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº sucursal
	@FieldConfAnont(label = "Nº sucursal", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Abreviatura
	@FieldConfAnont(label = "Abreviatura", labelError = "", unique = true, readOnly = false, required = true, columns = 5.0f, maxLength = 5, minValue = "", maxValue = "", mask = "")
	private String abreviatura;

	// Tipo sucursal
	@FieldConfAnont(label = "Tipo sucursal", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private TipoSucursal tipoSucursal;

	// Cuenta clientes desde
	@FieldConfAnont(label = "Cuenta clientes desde", labelError = "", unique = false, readOnly = false, required = false, columns = 6.0f, maxLength = 7, minValue = "", maxValue = "", mask = "")
	private String cuentaClientesDesde;

	// Cuenta clientes hasta
	@FieldConfAnont(label = "Cuenta clientes hasta", labelError = "", unique = false, readOnly = false, required = false, columns = 6.0f, maxLength = 7, minValue = "", maxValue = "", mask = "")
	private String cuentaClientesHasta;

	// Cantidad caracteres clientes
	@FieldConfAnont(label = "Cantidad caracteres clientes", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = 1, minValue = "3", maxValue = "6", mask = "")
	private Integer cantidadCaracteresClientes;

	// Identificacion numérica clientes
	@FieldConfAnont(label = "Identificacion numérica clientes", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean identificacionNumericaClientes = false;

	// Permite cambiar clientes
	@FieldConfAnont(label = "Permite cambiar clientes", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean permiteCambiarClientes = false;

	// Cuenta proveedores desde
	@FieldConfAnont(label = "Cuenta proveedores desde", labelError = "", unique = false, readOnly = false, required = false, columns = 7.0f, maxLength = 6, minValue = "", maxValue = "", mask = "")
	private String cuentaProveedoresDesde;

	// Cuenta proveedores hasta
	@FieldConfAnont(label = "Cuenta proveedores hasta", labelError = "", unique = false, readOnly = false, required = false, columns = 7.0f, maxLength = 6, minValue = "", maxValue = "", mask = "")
	private String cuentaProveedoresHasta;

	// Cantidad caracteres proveedores
	@FieldConfAnont(label = "Cantidad caracteres proveedores", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = 1, minValue = "3", maxValue = "6", mask = "")
	private Integer cantidadCaracteresProveedores;

	// Identificacion numérica proveedores
	@FieldConfAnont(label = "Identificacion numérica proveedores", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean identificacionNumericaProveedores = false;

	// Permite cambiar proveedores
	@FieldConfAnont(label = "Permite cambiar proveedores", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean permiteCambiarProveedores = false;

	// Clientes ocacionales desde
	@FieldConfAnont(label = "Clientes ocacionales desde", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer clientesOcacionalesDesde;

	// Clientes ocacionales hasta
	@FieldConfAnont(label = "Clientes ocacionales hasta", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer clientesOcacionalesHasta;

	// Número cobranza desde
	@FieldConfAnont(label = "Número cobranza desde", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroCobranzaDesde;

	// Número cobranza hasta
	@FieldConfAnont(label = "Número cobranza hasta", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numeroCobranzaHasta;

	// ---------------------------------------------------------------------------------------------------------------------------


	public Sucursal() throws Exception {
	}

	public Sucursal(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, String idTipoSucursalArg4, String cuentaClientesDesdeArg5, String cuentaClientesHastaArg6, Integer cantidadCaracteresClientesArg7, Boolean identificacionNumericaClientesArg8, Boolean permiteCambiarClientesArg9, String cuentaProveedoresDesdeArg10, String cuentaProveedoresHastaArg11, Integer cantidadCaracteresProveedoresArg12, Boolean identificacionNumericaProveedoresArg13, Boolean permiteCambiarProveedoresArg14, Integer clientesOcacionalesDesdeArg15, Integer clientesOcacionalesHastaArg16, Integer numeroCobranzaDesdeArg17, Integer numeroCobranzaHastaArg18) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, abreviaturaArg3, idTipoSucursalArg4, cuentaClientesDesdeArg5, cuentaClientesHastaArg6, cantidadCaracteresClientesArg7, identificacionNumericaClientesArg8, permiteCambiarClientesArg9, cuentaProveedoresDesdeArg10, cuentaProveedoresHastaArg11, cantidadCaracteresProveedoresArg12, identificacionNumericaProveedoresArg13, permiteCambiarProveedoresArg14, clientesOcacionalesDesdeArg15, clientesOcacionalesHastaArg16, numeroCobranzaDesdeArg17, numeroCobranzaHastaArg18);

	}

	public Sucursal(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, String idArg4, Integer numeroArg5, String nombreArg6, String cuentaClientesDesdeArg7, String cuentaClientesHastaArg8, Integer cantidadCaracteresClientesArg9, Boolean identificacionNumericaClientesArg10, Boolean permiteCambiarClientesArg11, String cuentaProveedoresDesdeArg12, String cuentaProveedoresHastaArg13, Integer cantidadCaracteresProveedoresArg14, Boolean identificacionNumericaProveedoresArg15, Boolean permiteCambiarProveedoresArg16, Integer clientesOcacionalesDesdeArg17, Integer clientesOcacionalesHastaArg18, Integer numeroCobranzaDesdeArg19, Integer numeroCobranzaHastaArg20) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, abreviaturaArg3, idArg4, numeroArg5, nombreArg6, cuentaClientesDesdeArg7, cuentaClientesHastaArg8, cantidadCaracteresClientesArg9, identificacionNumericaClientesArg10, permiteCambiarClientesArg11, cuentaProveedoresDesdeArg12, cuentaProveedoresHastaArg13, cantidadCaracteresProveedoresArg14, identificacionNumericaProveedoresArg15, permiteCambiarProveedoresArg16, clientesOcacionalesDesdeArg17, clientesOcacionalesHastaArg18, numeroCobranzaDesdeArg19, numeroCobranzaHastaArg20);

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

	// GET Nº sucursal
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº sucursal
	public void setNumero(Integer numero ){
		this.numero = numero;
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

	// GET Abreviatura
	public String getAbreviatura() {
		return this.abreviatura;
	}

	// SET Abreviatura
	public void setAbreviatura(String abreviatura ){
		abreviatura = (abreviatura != null) ? abreviatura.trim() : null;
		this.abreviatura = (abreviatura != null && abreviatura.length() == 0) ? null : abreviatura;
	}

	// BUILD IF NULL AND GET Tipo sucursal
	public TipoSucursal buildTipoSucursal() throws Exception {
		this.tipoSucursal = (this.tipoSucursal == null) ? new TipoSucursal() : this.tipoSucursal;
		return this.tipoSucursal;
	}

	// GET Tipo sucursal
	public TipoSucursal getTipoSucursal() {
		this.tipoSucursal = (this.tipoSucursal != null && this.tipoSucursal.getId() == null) ? null : this.tipoSucursal ;
		return this.tipoSucursal;
	}

	// SET Tipo sucursal
	public void setTipoSucursal(TipoSucursal tipoSucursal ){
		this.tipoSucursal = tipoSucursal;
	}

	// GET Cuenta clientes desde
	public String getCuentaClientesDesde() {
		return this.cuentaClientesDesde;
	}

	// SET Cuenta clientes desde
	public void setCuentaClientesDesde(String cuentaClientesDesde ){
		cuentaClientesDesde = (cuentaClientesDesde != null) ? cuentaClientesDesde.trim() : null;
		this.cuentaClientesDesde = (cuentaClientesDesde != null && cuentaClientesDesde.length() == 0) ? null : cuentaClientesDesde;
	}

	// GET Cuenta clientes hasta
	public String getCuentaClientesHasta() {
		return this.cuentaClientesHasta;
	}

	// SET Cuenta clientes hasta
	public void setCuentaClientesHasta(String cuentaClientesHasta ){
		cuentaClientesHasta = (cuentaClientesHasta != null) ? cuentaClientesHasta.trim() : null;
		this.cuentaClientesHasta = (cuentaClientesHasta != null && cuentaClientesHasta.length() == 0) ? null : cuentaClientesHasta;
	}

	// GET Cantidad caracteres clientes
	public Integer getCantidadCaracteresClientes() {
		return this.cantidadCaracteresClientes;
	}

	// SET Cantidad caracteres clientes
	public void setCantidadCaracteresClientes(Integer cantidadCaracteresClientes ){
		this.cantidadCaracteresClientes = cantidadCaracteresClientes;
	}

	// GET Identificacion numérica clientes
	public Boolean getIdentificacionNumericaClientes() {
		return this.identificacionNumericaClientes;
	}

	// SET Identificacion numérica clientes
	public void setIdentificacionNumericaClientes(Boolean identificacionNumericaClientes ){
		this.identificacionNumericaClientes = (identificacionNumericaClientes == null) ? false : identificacionNumericaClientes;
	}

	// GET Permite cambiar clientes
	public Boolean getPermiteCambiarClientes() {
		return this.permiteCambiarClientes;
	}

	// SET Permite cambiar clientes
	public void setPermiteCambiarClientes(Boolean permiteCambiarClientes ){
		this.permiteCambiarClientes = (permiteCambiarClientes == null) ? false : permiteCambiarClientes;
	}

	// GET Cuenta proveedores desde
	public String getCuentaProveedoresDesde() {
		return this.cuentaProveedoresDesde;
	}

	// SET Cuenta proveedores desde
	public void setCuentaProveedoresDesde(String cuentaProveedoresDesde ){
		cuentaProveedoresDesde = (cuentaProveedoresDesde != null) ? cuentaProveedoresDesde.trim() : null;
		this.cuentaProveedoresDesde = (cuentaProveedoresDesde != null && cuentaProveedoresDesde.length() == 0) ? null : cuentaProveedoresDesde;
	}

	// GET Cuenta proveedores hasta
	public String getCuentaProveedoresHasta() {
		return this.cuentaProveedoresHasta;
	}

	// SET Cuenta proveedores hasta
	public void setCuentaProveedoresHasta(String cuentaProveedoresHasta ){
		cuentaProveedoresHasta = (cuentaProveedoresHasta != null) ? cuentaProveedoresHasta.trim() : null;
		this.cuentaProveedoresHasta = (cuentaProveedoresHasta != null && cuentaProveedoresHasta.length() == 0) ? null : cuentaProveedoresHasta;
	}

	// GET Cantidad caracteres proveedores
	public Integer getCantidadCaracteresProveedores() {
		return this.cantidadCaracteresProveedores;
	}

	// SET Cantidad caracteres proveedores
	public void setCantidadCaracteresProveedores(Integer cantidadCaracteresProveedores ){
		this.cantidadCaracteresProveedores = cantidadCaracteresProveedores;
	}

	// GET Identificacion numérica proveedores
	public Boolean getIdentificacionNumericaProveedores() {
		return this.identificacionNumericaProveedores;
	}

	// SET Identificacion numérica proveedores
	public void setIdentificacionNumericaProveedores(Boolean identificacionNumericaProveedores ){
		this.identificacionNumericaProveedores = (identificacionNumericaProveedores == null) ? false : identificacionNumericaProveedores;
	}

	// GET Permite cambiar proveedores
	public Boolean getPermiteCambiarProveedores() {
		return this.permiteCambiarProveedores;
	}

	// SET Permite cambiar proveedores
	public void setPermiteCambiarProveedores(Boolean permiteCambiarProveedores ){
		this.permiteCambiarProveedores = (permiteCambiarProveedores == null) ? false : permiteCambiarProveedores;
	}

	// GET Clientes ocacionales desde
	public Integer getClientesOcacionalesDesde() {
		return this.clientesOcacionalesDesde;
	}

	// SET Clientes ocacionales desde
	public void setClientesOcacionalesDesde(Integer clientesOcacionalesDesde ){
		this.clientesOcacionalesDesde = clientesOcacionalesDesde;
	}

	// GET Clientes ocacionales hasta
	public Integer getClientesOcacionalesHasta() {
		return this.clientesOcacionalesHasta;
	}

	// SET Clientes ocacionales hasta
	public void setClientesOcacionalesHasta(Integer clientesOcacionalesHasta ){
		this.clientesOcacionalesHasta = clientesOcacionalesHasta;
	}

	// GET Número cobranza desde
	public Integer getNumeroCobranzaDesde() {
		return this.numeroCobranzaDesde;
	}

	// SET Número cobranza desde
	public void setNumeroCobranzaDesde(Integer numeroCobranzaDesde ){
		this.numeroCobranzaDesde = numeroCobranzaDesde;
	}

	// GET Número cobranza hasta
	public Integer getNumeroCobranzaHasta() {
		return this.numeroCobranzaHasta;
	}

	// SET Número cobranza hasta
	public void setNumeroCobranzaHasta(Integer numeroCobranzaHasta ){
		this.numeroCobranzaHasta = numeroCobranzaHasta;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, String idTipoSucursalArg4, String cuentaClientesDesdeArg5, String cuentaClientesHastaArg6, Integer cantidadCaracteresClientesArg7, Boolean identificacionNumericaClientesArg8, Boolean permiteCambiarClientesArg9, String cuentaProveedoresDesdeArg10, String cuentaProveedoresHastaArg11, Integer cantidadCaracteresProveedoresArg12, Boolean identificacionNumericaProveedoresArg13, Boolean permiteCambiarProveedoresArg14, Integer clientesOcacionalesDesdeArg15, Integer clientesOcacionalesHastaArg16, Integer numeroCobranzaDesdeArg17, Integer numeroCobranzaHastaArg18) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setAbreviatura(abreviaturaArg3);
		this.buildTipoSucursal().setId(idTipoSucursalArg4);
		this.setCuentaClientesDesde(cuentaClientesDesdeArg5);
		this.setCuentaClientesHasta(cuentaClientesHastaArg6);
		this.setCantidadCaracteresClientes(cantidadCaracteresClientesArg7);
		this.setIdentificacionNumericaClientes(identificacionNumericaClientesArg8);
		this.setPermiteCambiarClientes(permiteCambiarClientesArg9);
		this.setCuentaProveedoresDesde(cuentaProveedoresDesdeArg10);
		this.setCuentaProveedoresHasta(cuentaProveedoresHastaArg11);
		this.setCantidadCaracteresProveedores(cantidadCaracteresProveedoresArg12);
		this.setIdentificacionNumericaProveedores(identificacionNumericaProveedoresArg13);
		this.setPermiteCambiarProveedores(permiteCambiarProveedoresArg14);
		this.setClientesOcacionalesDesde(clientesOcacionalesDesdeArg15);
		this.setClientesOcacionalesHasta(clientesOcacionalesHastaArg16);
		this.setNumeroCobranzaDesde(numeroCobranzaDesdeArg17);
		this.setNumeroCobranzaHasta(numeroCobranzaHastaArg18);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String abreviaturaArg3, String idArg4, Integer numeroArg5, String nombreArg6, String cuentaClientesDesdeArg7, String cuentaClientesHastaArg8, Integer cantidadCaracteresClientesArg9, Boolean identificacionNumericaClientesArg10, Boolean permiteCambiarClientesArg11, String cuentaProveedoresDesdeArg12, String cuentaProveedoresHastaArg13, Integer cantidadCaracteresProveedoresArg14, Boolean identificacionNumericaProveedoresArg15, Boolean permiteCambiarProveedoresArg16, Integer clientesOcacionalesDesdeArg17, Integer clientesOcacionalesHastaArg18, Integer numeroCobranzaDesdeArg19, Integer numeroCobranzaHastaArg20) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.setAbreviatura(abreviaturaArg3);
		this.buildTipoSucursal().setId(idArg4);
		this.buildTipoSucursal().setNumero(numeroArg5);
		this.buildTipoSucursal().setNombre(nombreArg6);
		this.setCuentaClientesDesde(cuentaClientesDesdeArg7);
		this.setCuentaClientesHasta(cuentaClientesHastaArg8);
		this.setCantidadCaracteresClientes(cantidadCaracteresClientesArg9);
		this.setIdentificacionNumericaClientes(identificacionNumericaClientesArg10);
		this.setPermiteCambiarClientes(permiteCambiarClientesArg11);
		this.setCuentaProveedoresDesde(cuentaProveedoresDesdeArg12);
		this.setCuentaProveedoresHasta(cuentaProveedoresHastaArg13);
		this.setCantidadCaracteresProveedores(cantidadCaracteresProveedoresArg14);
		this.setIdentificacionNumericaProveedores(identificacionNumericaProveedoresArg15);
		this.setPermiteCambiarProveedores(permiteCambiarProveedoresArg16);
		this.setClientesOcacionalesDesde(clientesOcacionalesDesdeArg17);
		this.setClientesOcacionalesHasta(clientesOcacionalesHastaArg18);
		this.setNumeroCobranzaDesde(numeroCobranzaDesdeArg19);
		this.setNumeroCobranzaHasta(numeroCobranzaHastaArg20);

	}

	// ---------------------------------------------------------------------------------------------------------------------------

	public String toString() {
		if(this.getNumero() != null && this.getNombre() != null){
			return this.getNumero() + " - " +  this.getNombre();
		} else if(this.getNumero() != null && this.getNombre() == null){
			return this.getNumero().toString();
		} else if(this.getNumero() == null && this.getNombre() != null){
			return this.getNombre();
		} else {
			return super.toString();
		}
	}

} // END CLASS ----------------------------------------------------------------------------------------------------------