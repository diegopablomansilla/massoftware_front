package com.massoftware.model;

import java.util.ArrayList;
import java.util.List;

import org.cendra.ex.crud.UniqueException;

import com.massoftware.backend.BackendContext;
import com.massoftware.backend.annotation.FieldLabelAnont;

public class CuentaFondoGrupo extends EntityId {

	@FieldLabelAnont(value = "ID")
	private String id;

	@FieldLabelAnont(value = "Rubro")
	private CuentaFondoRubro cuentaFondoRubro;

	@FieldLabelAnont(value = "Nº grupo")
	private Integer numero;

	@FieldLabelAnont(value = "Nombre")
	private String nombre;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public CuentaFondoRubro getCuentaFondoRubro() {
		return cuentaFondoRubro;
	}

	public void setCuentaFondoRubro(CuentaFondoRubro cuentaFondoRubro) {
		this.cuentaFondoRubro = cuentaFondoRubro;
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

	public List<CuentaFondoGrupo> findByRubro(CuentaFondoRubro rubro) throws Exception {

		List<CuentaFondoGrupo> listado = new ArrayList<CuentaFondoGrupo>();

		List<EntityId> items = findUtil("numero", CuentaFondoRubro.class.getSimpleName() + " = ?", -1, -1,
				new Object[] { rubro.getId() }, 2);

		for (EntityId item : items) {
			listado.add((CuentaFondoGrupo) item);
		}

		return listado;
	}

	public String insert() throws Exception {
		checkUniqueRubroAndNumero();
		return super.insert();
	}

	public String update() throws Exception {
		checkUniqueRubroAndNumero();
		return super.update();
	}

	public void checkUniqueRubroAndNumero() throws Exception {

		String labelRubro = this.label("cuentaFondoRubro");
		String labelNumero = this.label("numero");

		// -----------------------------------------------

		String idRubroOriginal = null;
		Integer numeroOriginal = null;
		if (this._originalDTO != null) {
			numeroOriginal = ((CuentaFondoGrupo) this._originalDTO).getNumero();
			if (((CuentaFondoGrupo) this._originalDTO).getCuentaFondoRubro() != null) {
				idRubroOriginal = ((CuentaFondoGrupo) this._originalDTO).getCuentaFondoRubro().getId();
			}
		}

		// -----------------------------------------------

		String idRubro = null;
		if (this.getCuentaFondoRubro() != null) {
			idRubro = this.getCuentaFondoRubro().getId();
		}
		Integer numero = this.getNumero();

		// -----------------------------------------------

		String[] attNames = { "cuentaFondoRubro", "numero" };
		Object[] args = { idRubro, numero };

		// -----------------------------------------------

		if (idRubroOriginal != null && numeroOriginal != null && idRubro != null && numero != null
				&& (idRubroOriginal.equals(idRubro) == false || numeroOriginal.equals(numero) == false)) {

			if (BackendContext.get().ifExists(this, attNames, args)) {
				throw new UniqueException(labelRubro, labelNumero);
			}

		} else if (idRubroOriginal == null && numeroOriginal == null && idRubro != null && numero != null) {

			if (BackendContext.get().ifExists(this, attNames, args)) {
				throw new UniqueException(labelRubro, labelNumero);
			}
		}

	}

	@Override
	public String toString() {

		if (cuentaFondoRubro != null && cuentaFondoRubro.getNumero() != null) {
			return "(" + cuentaFondoRubro.getNumero() + "-" + numero + ") " + nombre;
		}

		return "(" + numero + ") " + nombre;

	}

}
