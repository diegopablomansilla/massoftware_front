package com.massoftware.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldLabelAnont;

@ClassLabelAnont(singular = "Banco", plural = "Bancos")
public class Banco extends EntityId {

	@FieldLabelAnont(value = "ID")
	private String id;
	
	@FieldLabelAnont(value = "Nº banco")
	private Integer numero;
	
	@FieldLabelAnont(value = "Nombre")
	private String nombre;
	
	@FieldLabelAnont(value = "CUIT")
	private Long cuit;
	
	@FieldLabelAnont(value = "Obsoleto")
	private Boolean bloqueado;
	
	@FieldLabelAnont(value = "Hoja")
	private Integer hoja;
	
	@FieldLabelAnont(value = "Primera fila")
	private Integer primeraFila;
	
	@FieldLabelAnont(value = "Última fila")
	private Integer ultimaFila;
	
	@FieldLabelAnont(value = "Fecha")
	private String fecha;
	
	@FieldLabelAnont(value = "Descripción")
	private String descripcion;
	
	@FieldLabelAnont(value = "Referencia 1")
	private String referencia1;
	
	@FieldLabelAnont(value = "Importe")
	private String importe;
	
	@FieldLabelAnont(value = "Referencia 2")
	private String referencia2;
	
	@FieldLabelAnont(value = "Saldo")
	private String saldo;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
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

	public Long getCuit() {
		return cuit;
	}

	public void setCuit(Long cuit) {
		this.cuit = cuit;
	}

	public Boolean getBloqueado() {
		return bloqueado;
	}

	public void setBloqueado(Boolean bloqueado) {
		this.bloqueado = bloqueado;
	}

	public Integer getHoja() {
		return hoja;
	}

	public void setHoja(Integer hoja) {
		this.hoja = hoja;
	}

	public Integer getPrimeraFila() {
		return primeraFila;
	}

	public void setPrimeraFila(Integer primeraFila) {
		this.primeraFila = primeraFila;
	}

	public Integer getUltimaFila() {
		return ultimaFila;
	}

	public void setUltimaFila(Integer ultimaFila) {
		this.ultimaFila = ultimaFila;
	}

	public String getFecha() {
		return fecha;
	}

	public void setFecha(String fecha) {
		this.fecha = fecha;
	}

	public String getDescripcion() {
		return descripcion;
	}

	public void setDescripcion(String descripcion) {
		this.descripcion = descripcion;
	}

	public String getReferencia1() {
		return referencia1;
	}

	public void setReferencia1(String referencia1) {
		this.referencia1 = referencia1;
	}

	public String getImporte() {
		return importe;
	}

	public void setImporte(String importe) {
		this.importe = importe;
	}

	public String getReferencia2() {
		return referencia2;
	}

	public void setReferencia2(String referencia2) {
		this.referencia2 = referencia2;
	}

	public String getSaldo() {
		return saldo;
	}

	public void setSaldo(String saldo) {
		this.saldo = saldo;
	}

	@Override
	public String toString() {
		return "(" + numero + ") " + nombre;
	}

	public List<Banco> find(BancosFiltro2 bancosFiltro) throws Exception {
		return find(-1, -1, null, bancosFiltro);
	}

	public List<Banco> find(int limit, int offset, Map<String, Boolean> orderBy, BancosFiltro2 filtro)
			throws Exception {

		filtro.setterTrim();

		List<Banco> listado = new ArrayList<Banco>();

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

		List<EntityId> items = findUtil(orderBySQL, whereSQL, limit, offset, filtros.toArray(), 1);

		for (EntityId item : items) {
			listado.add((Banco) item);
		}

		return listado;
	}

	// private boolean check(Banco itemOriginal, Banco item) throws Exception {
	//
	// // ==================================================================
	// // CHECKs NULLs
	//
	//
	// if (item.getNumero() == null) {
	// throw new NullFieldException("Numero");
	// }
	// if (item.getNombre() == null) {
	// throw new NullFieldException("Nombre");
	// }
	// if (item.getCuit() == null) {
	// throw new NullFieldException("CUIT");
	// }
	//
	// // ==================================================================
	// // CHECKs UNIQUE
	//
	//// if (itemOriginal != null) {
	//// checkUniqueNumero("Numero", itemOriginal.getNumero(), item.getNumero());
	//// checkUniqueNombre("Nombre", itemOriginal.getNombre(), item.getNombre());
	//// checkUniqueNombreOficial("Nombre oficial", itemOriginal.getNombreOficial(),
	// item.getNombreOficial());
	//// checkUniqueCuit("CUIT", itemOriginal.getCuit(), item.getCuit());
	//// } else {
	//// checkUniqueNumero("Numero", null, item.getNumero());
	//// checkUniqueNombre("Nombre", null, item.getNombre());
	//// checkUniqueNombreOficial("Nombre oficial", null, item.getNombreOficial());
	//// checkUniqueCuit("CUIT", null, item.getCuit());
	//// }
	//
	// // ==================================================================
	//
	// return true;
	// }

}
