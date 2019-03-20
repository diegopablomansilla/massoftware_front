package com.massoftware.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;

@ClassLabelAnont(singular = "Modelo ticket", plural = "Modelos de ticket", singularPre = "el modelo ticket", pluralPre = "los modelos ticket")
public class MarcaTicketModelo extends EntityId {

	@FieldConfAnont(label = "ID")
	private String id;

	@FieldConfAnont(label = "Marca ticket", required = true)
	private MarcaTicket marcaTicket;

	@FieldConfAnont(label = "Nº modelo", required = true, unique = true)
	private Integer numero;

	@FieldConfAnont(label = "Nombre", required = true, unique = true)
	private String nombre;

	@FieldConfAnont(label = "Prueba lectura")
	private String pruebaLectura;

	@FieldConfAnont(label = "Posición")
	private Integer identificacionPosicion;

	@FieldConfAnont(label = "Identificación")
	private String identificacionIdentificacion;

	@FieldConfAnont(label = "Posición")
	private Integer importePosicion;

	@FieldConfAnont(label = "Longitud")
	private Integer importeLongitud;

	@FieldConfAnont(label = "Cantidad decimales")
	private Integer importeCantidadDecimales;

	@FieldConfAnont(label = "Posición")
	private Integer numeroPosicion;

	@FieldConfAnont(label = "Longitud")
	private Integer numeroLongitud;

	@FieldConfAnont(label = "Prefijo identificacion importacion")
	private String prefijoIdentificacionImportacion;

	@FieldConfAnont(label = "Posición prefijo")
	private Integer prefijoPosicion;

	@FieldConfAnont(label = "Obsoleto")
	private Boolean bloqueado;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public MarcaTicket getMarcaTicket() {
		return marcaTicket;
	}

	public void setMarcaTicket(MarcaTicket marcaTicket) {
		this.marcaTicket = marcaTicket;
	}

	public Integer getNumero() {
		return numero;
	}

	public void setNumero(Integer numero) {
		this.numero = numero;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getPruebaLectura() {
		return pruebaLectura;
	}

	public void setPruebaLectura(String pruebaLectura) {
		this.pruebaLectura = pruebaLectura;
	}

	public Integer getIdentificacionPosicion() {
		return identificacionPosicion;
	}

	public void setIdentificacionPosicion(Integer identificacionPosicion) {
		this.identificacionPosicion = identificacionPosicion;
	}

	public String getIdentificacionIdentificacion() {
		return identificacionIdentificacion;
	}

	public void setIdentificacionIdentificacion(String identificacionIdentificacion) {
		this.identificacionIdentificacion = identificacionIdentificacion;
	}

	public Integer getImportePosicion() {
		return importePosicion;
	}

	public void setImportePosicion(Integer importePosicion) {
		this.importePosicion = importePosicion;
	}

	public Integer getImporteLongitud() {
		return importeLongitud;
	}

	public void setImporteLongitud(Integer importeLongitud) {
		this.importeLongitud = importeLongitud;
	}

	public Integer getImporteCantidadDecimales() {
		return importeCantidadDecimales;
	}

	public void setImporteCantidadDecimales(Integer importeCantidadDecimales) {
		this.importeCantidadDecimales = importeCantidadDecimales;
	}

	public Integer getNumeroPosicion() {
		return numeroPosicion;
	}

	public void setNumeroPosicion(Integer numeroPosicion) {
		this.numeroPosicion = numeroPosicion;
	}

	public Integer getNumeroLongitud() {
		return numeroLongitud;
	}

	public void setNumeroLongitud(Integer numeroLongitud) {
		this.numeroLongitud = numeroLongitud;
	}

	public String getPrefijoIdentificacionImportacion() {
		return prefijoIdentificacionImportacion;
	}

	public void setPrefijoIdentificacionImportacion(String prefijoIdentificacionImportacion) {
		this.prefijoIdentificacionImportacion = prefijoIdentificacionImportacion;
	}

	public Integer getPrefijoPosicion() {
		return prefijoPosicion;
	}

	public void setPrefijoPosicion(Integer prefijoPosicion) {
		this.prefijoPosicion = prefijoPosicion;
	}

	public Boolean getBloqueado() {
		return bloqueado;
	}

	public void setBloqueado(Boolean bloqueado) {
		this.bloqueado = bloqueado;
	}

	@Override
	public String toString() {
		if (numero != null && nombre != null) {
			return "(" + numero + ") " + numero;
		}

		return null;
	}

	public List<MarcaTicketModelo> find(MarcasTicketModeloFiltro filtro) throws Exception {
		return find(-1, -1, null, filtro);
	}

	public List<MarcaTicketModelo> find(int limit, int offset, Map<String, Boolean> orderBy,
			MarcasTicketModeloFiltro filtro) throws Exception {

		filtro.setterTrim();

		List<MarcaTicketModelo> listado = new ArrayList<MarcaTicketModelo>();

		String orderBySQL = "numero";
		String whereSQL = "";

		ArrayList<Object> filtros = new ArrayList<Object>();

		if (filtro.getNumero() != null) {
			filtros.add(filtro.getNumero());
			whereSQL += "numero" + " = ? AND ";
		}
		if (filtro.getNombre() != null) {
			String[] palabras = filtro.getNombre().split(" ");
			for (String palabra : palabras) {
				filtros.add(palabra.trim());
				whereSQL += "TRIM(massoftware.TRANSLATE(" + "nombre"
						+ "))::VARCHAR ILIKE ('%' || TRIM(massoftware.TRANSLATE(?)) || '%')::VARCHAR AND ";
			}
		}
		if (filtro.getBloqueado() != null && filtro.getBloqueado() == 1) {
			filtros.add(true);
			whereSQL += "bloqueado" + " = ? AND ";
		} else if (filtro.getBloqueado() != null && filtro.getBloqueado() == 2) {
			filtros.add(false);
			whereSQL += "bloqueado" + " = ? AND ";
		}

		// ==================================================================

		whereSQL = whereSQL.trim();
		if (whereSQL.length() > 0) {
			whereSQL = whereSQL.substring(0, whereSQL.length() - 4);
		} else {
			whereSQL = null;
		}

		// ==================================================================

		List<EntityId> items = findUtil(orderBySQL, whereSQL, limit, offset, filtros.toArray(), 0);

		for (EntityId item : items) {
			listado.add((MarcaTicketModelo) item);
		}

		return listado;
	}

}
