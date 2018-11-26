package com.massoftware.windows.comprobante_de_fondo;

import java.security.Timestamp;
import java.util.Date;

import com.massoftware.windows.UtilModel;

public class ComprobanteDeFondo {

	private Cajas caja;
	private Timestamp apertura;
	private Comprobantes comprobante;
	private Integer codigo;
	private Date fecha;
	private String detalle;
	private Boolean conciliacionAutomatica;

	public Cajas getCaja() {
		return caja;
	}

	public void setCaja(Cajas caja) {
		this.caja = caja;
	}

	public Timestamp getApertura() {
		return apertura;
	}

	public void setApertura(Timestamp apertura) {
		this.apertura = apertura;
	}

	public Comprobantes getComprobante() {
		return comprobante;
	}

	public void setComprobante(Comprobantes comprobante) {
		this.comprobante = comprobante;
	}

	public Integer getCodigo() {
		return codigo;
	}

	public void setCodigo(Integer codigo) {
		this.codigo = codigo;
	}

	public Date getFecha() {
		return fecha;
	}

	public void setFecha(Date fecha) {
		this.fecha = fecha;
	}

	public String getDetalle() {		
		return detalle;
	}

	public void setDetalle(String detalle) {
		this.detalle = UtilModel.format(detalle);
	}

	public Boolean getConciliacionAutomatica() {
		return conciliacionAutomatica;
	}

	public void setConciliacionAutomatica(Boolean conciliacionAutomatica) {
		this.conciliacionAutomatica = UtilModel.format(conciliacionAutomatica);
	}

	@Override
	public String toString() {
		return "ComprobanteDeFondo [caja=" + caja + ", apertura=" + apertura
				+ ", comprobante=" + comprobante + ", codigo=" + codigo
				+ ", fecha=" + fecha + ", detalle=" + detalle
				+ ", conciliacionAutomatica=" + conciliacionAutomatica + "]";
	}
	
	

}
