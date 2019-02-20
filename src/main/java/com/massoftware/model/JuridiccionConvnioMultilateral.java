package com.massoftware.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.cendra.ex.crud.UniqueException;

import com.massoftware.backend.BackendContextPG;
import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldConfAnont;

@ClassLabelAnont(singular = "Juridicción de convnio multilateral", plural = "Juridicciones de convnio multilateral", singularPre = "la juridicción de convnio multilateral", pluralPre = "las juridicciones de convnio multilateral")
public class JuridiccionConvnioMultilateral extends EntityId {

	@FieldConfAnont(label = "ID")
	private String id;

	@FieldConfAnont(label = "Cuenta de fondo", required = true, columns = 30)
	private CuentaFondo cuentaFondo;

	@FieldConfAnont(label = "Nº juridicción", required = true, unique = true)
	private Integer numero;

	@FieldConfAnont(label = "Nombre", required = true, unique = true)
	private String nombre;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public CuentaFondo getCuentaFondo() {
		return cuentaFondo;
	}

	public void setCuentaFondo(CuentaFondo cuentaFondo) {
		this.cuentaFondo = cuentaFondo;
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

	@Override
	public String toString() {

		if (cuentaFondo != null && cuentaFondo.getNumero() != null) {
			return "(" + cuentaFondo.getNumero() + "-" + numero + ") " + nombre;
		}

		return "(" + numero + ") " + nombre;

	}

	public List<JuridiccionConvnioMultilateral> find(JuridiccionConvnioMultilateralFiltro filtro) throws Exception {
		return find(-1, -1, null, filtro);
	}

	public List<JuridiccionConvnioMultilateral> find(int limit, int offset, Map<String, Boolean> orderBy,
			JuridiccionConvnioMultilateralFiltro filtro) throws Exception {

		filtro.setterTrim();

		List<JuridiccionConvnioMultilateral> listado = new ArrayList<JuridiccionConvnioMultilateral>();

		String orderBySQL = "cuentaFondo, numero";
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
		if (filtro.getCuentaFondo() != null && filtro.getCuentaFondo().getId() != null) {
			filtros.add(filtro.getCuentaFondo().getId());
			whereSQL += "cuentaFondo" + " = ? AND ";
		}

		// ==================================================================

		whereSQL = whereSQL.trim();
		if (whereSQL.length() > 0) {
			whereSQL = whereSQL.substring(0, whereSQL.length() - 4);
		} else {
			whereSQL = null;
		}

		// ==================================================================

		List<EntityId> items = findUtil(orderBySQL, whereSQL, limit, offset, filtros.toArray(), 3);

		for (EntityId item : items) {
			listado.add((JuridiccionConvnioMultilateral) item);
		}

		return listado;
	}

	public void checkUniqueEjercicioContableAndNumero() throws Exception {

		String labelCuentaFondo = this.label("cuentaFondo");
		String labelNumero = this.label("numero");

		// -----------------------------------------------

		String idCuentaFondoOriginal = null;
		Integer numeroOriginal = null;
		if (this._originalDTO != null) {
			numeroOriginal = ((JuridiccionConvnioMultilateral) this._originalDTO).getNumero();
			if (((JuridiccionConvnioMultilateral) this._originalDTO).getCuentaFondo() != null) {
				idCuentaFondoOriginal = ((JuridiccionConvnioMultilateral) this._originalDTO)
						.getCuentaFondo().getId();
			}
		}

		// -----------------------------------------------

		String idCuentaFondo = null;
		if (this.getCuentaFondo() != null) {
			idCuentaFondo = this.getCuentaFondo().getId();
		}
		Integer numero = this.getNumero();

		// -----------------------------------------------

		String[] attNames = { "cuentaFondo", "numero" };
		Object[] args = { idCuentaFondo, numero };

		// -----------------------------------------------

		if (idCuentaFondoOriginal != null && numeroOriginal != null && idCuentaFondo != null
				&& numero != null && (idCuentaFondoOriginal.equals(idCuentaFondo) == false
						|| numeroOriginal.equals(numero) == false)) {

			if (BackendContextPG.get().ifExists(this.getClass().getSimpleName(), attNames, args)) {
				throw new UniqueException(labelCuentaFondo, labelNumero);
			}

		} else if (idCuentaFondoOriginal == null && numeroOriginal == null && idCuentaFondo != null
				&& numero != null) {

			if (BackendContextPG.get().ifExists(this.getClass().getSimpleName(), attNames, args)) {
				throw new UniqueException(labelCuentaFondo, labelNumero);
			}
		}

	}

	public void checkUniqueEjercicioContableAndNombre() throws Exception {

		String labelCuentaFondo = this.label("cuentaFondo");
		String labelNombre = this.label("nombre");

		// -----------------------------------------------

		String idCuentaFondoOriginal = null;
		String nombreOriginal = null;
		if (this._originalDTO != null) {
			nombreOriginal = ((JuridiccionConvnioMultilateral) this._originalDTO).getNombre();
			if (((JuridiccionConvnioMultilateral) this._originalDTO).getCuentaFondo() != null) {
				idCuentaFondoOriginal = ((JuridiccionConvnioMultilateral) this._originalDTO)
						.getCuentaFondo().getId();
			}
		}

		// -----------------------------------------------

		String idCuentaFondo = null;
		if (this.getCuentaFondo() != null) {
			idCuentaFondo = this.getCuentaFondo().getId();
		}
		String nombre = this.getNombre();

		// -----------------------------------------------

		String[] attNames = { "cuentaFondo", "nombre" };
		Object[] args = { idCuentaFondo, nombre };

		// -----------------------------------------------

		if (idCuentaFondoOriginal != null && nombreOriginal != null && idCuentaFondo != null
				&& nombre != null && (idCuentaFondoOriginal.equals(idCuentaFondo) == false
						|| nombreOriginal.equals(nombre) == false)) {

			if (BackendContextPG.get().ifExists(this.getClass().getSimpleName(), attNames, args)) {
				throw new UniqueException(labelCuentaFondo, labelNombre);
			}

		} else if (idCuentaFondoOriginal == null && nombreOriginal == null && idCuentaFondo != null
				&& nombre != null) {

			if (BackendContextPG.get().ifExists(this.getClass().getSimpleName(), attNames, args)) {
				throw new UniqueException(labelCuentaFondo, labelNombre);
			}
		}

	}

}
