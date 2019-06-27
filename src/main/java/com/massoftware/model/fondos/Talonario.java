package com.massoftware.model.fondos;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;
import com.massoftware.model.EntityId;
import com.massoftware.model.fondos.TalonarioLetra;
import com.massoftware.model.fondos.TalonarioControladorFizcal;

@ClassLabelAnont(singular = "Talonario", plural = "Talonarios", singularPre = "el talonario", pluralPre = "los talonarios")
public class Talonario extends EntityId {

	// ---------------------------------------------------------------------------------------------------------------------------


	@FieldConfAnont(label = "ID")
	private String id;

	// Nº talonario
	@FieldConfAnont(label = "Nº talonario", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer numero;

	// Nombre
	@FieldConfAnont(label = "Nombre", labelError = "", unique = true, readOnly = false, required = true, columns = 20.0f, maxLength = 50, minValue = "", maxValue = "", mask = "")
	private String nombre;

	// Letra
	@FieldConfAnont(label = "Letra", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private TalonarioLetra talonarioLetra;

	// Punto de venta
	@FieldConfAnont(label = "Punto de venta", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = 4, minValue = "1", maxValue = "9999", mask = "")
	private Integer puntoVenta;

	// Autonumeración
	@FieldConfAnont(label = "Autonumeración", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean autonumeracion = false;

	// Numeración pre-impresa
	@FieldConfAnont(label = "Numeración pre-impresa", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean numeracionPreImpresa = false;

	// Asociado al RG 100/98
	@FieldConfAnont(label = "Asociado al RG 100/98", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private Boolean asociadoRG10098 = false;

	// Asociado a controlador fizcal
	@FieldConfAnont(label = "Asociado a controlador fizcal", labelError = "", unique = false, readOnly = false, required = true, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private TalonarioControladorFizcal talonarioControladorFizcal;

	// Primer nº
	@FieldConfAnont(label = "Primer nº", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer primerNumero;

	// Próximo nº
	@FieldConfAnont(label = "Próximo nº", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer proximoNumero;

	// Último nº
	@FieldConfAnont(label = "Último nº", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer ultimoNumero;

	// Cant. min. cbtes.
	@FieldConfAnont(label = "Cant. min. cbtes.", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer cantidadMinimaComprobantes;

	// Fecha
	@FieldConfAnont(label = "Fecha", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.util.Date fecha;

	// Nº C.A.I
	@FieldConfAnont(label = "Nº C.A.I", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 14, minValue = "1", maxValue = "99999999999999", mask = "")
	private Long numeroCAI;

	// Vencimiento C.A.I
	@FieldConfAnont(label = "Vencimiento C.A.I", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = -1, minValue = "", maxValue = "", mask = "")
	private java.util.Date vencimiento;

	// Días aviso vto.
	@FieldConfAnont(label = "Días aviso vto.", labelError = "", unique = false, readOnly = false, required = false, columns = 20.0f, maxLength = 10, minValue = "1", maxValue = "2147483647", mask = "")
	private Integer diasAvisoVencimiento;

	// ---------------------------------------------------------------------------------------------------------------------------


	public Talonario() throws Exception {
	}

	public Talonario(String idArg0, Integer numeroArg1, String nombreArg2, String idTalonarioLetraArg3, Integer puntoVentaArg4, Boolean autonumeracionArg5, Boolean numeracionPreImpresaArg6, Boolean asociadoRG10098Arg7, String idTalonarioControladorFizcalArg8, Integer primerNumeroArg9, Integer proximoNumeroArg10, Integer ultimoNumeroArg11, Integer cantidadMinimaComprobantesArg12, java.util.Date fechaArg13, Long numeroCAIArg14, java.util.Date vencimientoArg15, Integer diasAvisoVencimientoArg16) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idTalonarioLetraArg3, puntoVentaArg4, autonumeracionArg5, numeracionPreImpresaArg6, asociadoRG10098Arg7, idTalonarioControladorFizcalArg8, primerNumeroArg9, proximoNumeroArg10, ultimoNumeroArg11, cantidadMinimaComprobantesArg12, fechaArg13, numeroCAIArg14, vencimientoArg15, diasAvisoVencimientoArg16);

	}

	public Talonario(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, String nombreArg4, Integer puntoVentaArg5, Boolean autonumeracionArg6, Boolean numeracionPreImpresaArg7, Boolean asociadoRG10098Arg8, String idArg9, String codigoArg10, String nombreArg11, Integer primerNumeroArg12, Integer proximoNumeroArg13, Integer ultimoNumeroArg14, Integer cantidadMinimaComprobantesArg15, java.util.Date fechaArg16, Long numeroCAIArg17, java.util.Date vencimientoArg18, Integer diasAvisoVencimientoArg19) throws Exception {

		setter(idArg0, numeroArg1, nombreArg2, idArg3, nombreArg4, puntoVentaArg5, autonumeracionArg6, numeracionPreImpresaArg7, asociadoRG10098Arg8, idArg9, codigoArg10, nombreArg11, primerNumeroArg12, proximoNumeroArg13, ultimoNumeroArg14, cantidadMinimaComprobantesArg15, fechaArg16, numeroCAIArg17, vencimientoArg18, diasAvisoVencimientoArg19);

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

	// GET Nº talonario
	public Integer getNumero() {
		return this.numero;
	}

	// SET Nº talonario
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

	// BUILD IF NULL AND GET Letra
	public TalonarioLetra buildTalonarioLetra() throws Exception {
		this.talonarioLetra = (this.talonarioLetra == null) ? new TalonarioLetra() : this.talonarioLetra;
		return this.talonarioLetra;
	}

	// GET Letra
	public TalonarioLetra getTalonarioLetra() {
		this.talonarioLetra = (this.talonarioLetra != null && this.talonarioLetra.getId() == null) ? null : this.talonarioLetra ;
		return this.talonarioLetra;
	}

	// SET Letra
	public void setTalonarioLetra(TalonarioLetra talonarioLetra ){
		this.talonarioLetra = talonarioLetra;
	}

	// GET Punto de venta
	public Integer getPuntoVenta() {
		return this.puntoVenta;
	}

	// SET Punto de venta
	public void setPuntoVenta(Integer puntoVenta ){
		this.puntoVenta = puntoVenta;
	}

	// GET Autonumeración
	public Boolean getAutonumeracion() {
		return this.autonumeracion;
	}

	// SET Autonumeración
	public void setAutonumeracion(Boolean autonumeracion ){
		this.autonumeracion = (autonumeracion == null) ? false : autonumeracion;
	}

	// GET Numeración pre-impresa
	public Boolean getNumeracionPreImpresa() {
		return this.numeracionPreImpresa;
	}

	// SET Numeración pre-impresa
	public void setNumeracionPreImpresa(Boolean numeracionPreImpresa ){
		this.numeracionPreImpresa = (numeracionPreImpresa == null) ? false : numeracionPreImpresa;
	}

	// GET Asociado al RG 100/98
	public Boolean getAsociadoRG10098() {
		return this.asociadoRG10098;
	}

	// SET Asociado al RG 100/98
	public void setAsociadoRG10098(Boolean asociadoRG10098 ){
		this.asociadoRG10098 = (asociadoRG10098 == null) ? false : asociadoRG10098;
	}

	// BUILD IF NULL AND GET Asociado a controlador fizcal
	public TalonarioControladorFizcal buildTalonarioControladorFizcal() throws Exception {
		this.talonarioControladorFizcal = (this.talonarioControladorFizcal == null) ? new TalonarioControladorFizcal() : this.talonarioControladorFizcal;
		return this.talonarioControladorFizcal;
	}

	// GET Asociado a controlador fizcal
	public TalonarioControladorFizcal getTalonarioControladorFizcal() {
		this.talonarioControladorFizcal = (this.talonarioControladorFizcal != null && this.talonarioControladorFizcal.getId() == null) ? null : this.talonarioControladorFizcal ;
		return this.talonarioControladorFizcal;
	}

	// SET Asociado a controlador fizcal
	public void setTalonarioControladorFizcal(TalonarioControladorFizcal talonarioControladorFizcal ){
		this.talonarioControladorFizcal = talonarioControladorFizcal;
	}

	// GET Primer nº
	public Integer getPrimerNumero() {
		return this.primerNumero;
	}

	// SET Primer nº
	public void setPrimerNumero(Integer primerNumero ){
		this.primerNumero = primerNumero;
	}

	// GET Próximo nº
	public Integer getProximoNumero() {
		return this.proximoNumero;
	}

	// SET Próximo nº
	public void setProximoNumero(Integer proximoNumero ){
		this.proximoNumero = proximoNumero;
	}

	// GET Último nº
	public Integer getUltimoNumero() {
		return this.ultimoNumero;
	}

	// SET Último nº
	public void setUltimoNumero(Integer ultimoNumero ){
		this.ultimoNumero = ultimoNumero;
	}

	// GET Cant. min. cbtes.
	public Integer getCantidadMinimaComprobantes() {
		return this.cantidadMinimaComprobantes;
	}

	// SET Cant. min. cbtes.
	public void setCantidadMinimaComprobantes(Integer cantidadMinimaComprobantes ){
		this.cantidadMinimaComprobantes = cantidadMinimaComprobantes;
	}

	// GET Fecha
	public java.util.Date getFecha() {
		return this.fecha;
	}

	// SET Fecha
	public void setFecha(java.util.Date fecha ){
		this.fecha = fecha;
	}

	// GET Nº C.A.I
	public Long getNumeroCAI() {
		return this.numeroCAI;
	}

	// SET Nº C.A.I
	public void setNumeroCAI(Long numeroCAI ){
		this.numeroCAI = numeroCAI;
	}

	// GET Vencimiento C.A.I
	public java.util.Date getVencimiento() {
		return this.vencimiento;
	}

	// SET Vencimiento C.A.I
	public void setVencimiento(java.util.Date vencimiento ){
		this.vencimiento = vencimiento;
	}

	// GET Días aviso vto.
	public Integer getDiasAvisoVencimiento() {
		return this.diasAvisoVencimiento;
	}

	// SET Días aviso vto.
	public void setDiasAvisoVencimiento(Integer diasAvisoVencimiento ){
		this.diasAvisoVencimiento = diasAvisoVencimiento;
	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idTalonarioLetraArg3, Integer puntoVentaArg4, Boolean autonumeracionArg5, Boolean numeracionPreImpresaArg6, Boolean asociadoRG10098Arg7, String idTalonarioControladorFizcalArg8, Integer primerNumeroArg9, Integer proximoNumeroArg10, Integer ultimoNumeroArg11, Integer cantidadMinimaComprobantesArg12, java.util.Date fechaArg13, Long numeroCAIArg14, java.util.Date vencimientoArg15, Integer diasAvisoVencimientoArg16) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildTalonarioLetra().setId(idTalonarioLetraArg3);
		this.setPuntoVenta(puntoVentaArg4);
		this.setAutonumeracion(autonumeracionArg5);
		this.setNumeracionPreImpresa(numeracionPreImpresaArg6);
		this.setAsociadoRG10098(asociadoRG10098Arg7);
		this.buildTalonarioControladorFizcal().setId(idTalonarioControladorFizcalArg8);
		this.setPrimerNumero(primerNumeroArg9);
		this.setProximoNumero(proximoNumeroArg10);
		this.setUltimoNumero(ultimoNumeroArg11);
		this.setCantidadMinimaComprobantes(cantidadMinimaComprobantesArg12);
		this.setFecha(fechaArg13);
		this.setNumeroCAI(numeroCAIArg14);
		this.setVencimiento(vencimientoArg15);
		this.setDiasAvisoVencimiento(diasAvisoVencimientoArg16);

	}

	// ---------------------------------------------------------------------------------------------------------------------------


	public void setter(String idArg0, Integer numeroArg1, String nombreArg2, String idArg3, String nombreArg4, Integer puntoVentaArg5, Boolean autonumeracionArg6, Boolean numeracionPreImpresaArg7, Boolean asociadoRG10098Arg8, String idArg9, String codigoArg10, String nombreArg11, Integer primerNumeroArg12, Integer proximoNumeroArg13, Integer ultimoNumeroArg14, Integer cantidadMinimaComprobantesArg15, java.util.Date fechaArg16, Long numeroCAIArg17, java.util.Date vencimientoArg18, Integer diasAvisoVencimientoArg19) throws Exception {

		this.setId(idArg0);
		this.setNumero(numeroArg1);
		this.setNombre(nombreArg2);
		this.buildTalonarioLetra().setId(idArg3);
		this.buildTalonarioLetra().setNombre(nombreArg4);
		this.setPuntoVenta(puntoVentaArg5);
		this.setAutonumeracion(autonumeracionArg6);
		this.setNumeracionPreImpresa(numeracionPreImpresaArg7);
		this.setAsociadoRG10098(asociadoRG10098Arg8);
		this.buildTalonarioControladorFizcal().setId(idArg9);
		this.buildTalonarioControladorFizcal().setCodigo(codigoArg10);
		this.buildTalonarioControladorFizcal().setNombre(nombreArg11);
		this.setPrimerNumero(primerNumeroArg12);
		this.setProximoNumero(proximoNumeroArg13);
		this.setUltimoNumero(ultimoNumeroArg14);
		this.setCantidadMinimaComprobantes(cantidadMinimaComprobantesArg15);
		this.setFecha(fechaArg16);
		this.setNumeroCAI(numeroCAIArg17);
		this.setVencimiento(vencimientoArg18);
		this.setDiasAvisoVencimiento(diasAvisoVencimientoArg19);

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