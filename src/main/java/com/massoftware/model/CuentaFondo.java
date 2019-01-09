package com.massoftware.model;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.massoftware.backend.BackendContextPG;
import com.massoftware.backend.annotation.ClassLabelAnont;
import com.massoftware.backend.annotation.FieldLabelAnont;

@ClassLabelAnont(singular = "Cuenta de fondo", plural = "Cuentas de fondo")
public class CuentaFondo extends EntityId {

	// fk_ CuentasDeFondosGrupo FOREIGN KEY (Rubro, Grupo) REFERENCES
	// CuentasDeFondosGrupo(Rubro, Grupo)
	// fk_ PlanDeCuentas FOREIGN KEY (Ejercicio, CuentaContable) REFERENCES
	// PlanDeCuentas(Ejercicio, CuentaContable)
	// fk_ Bancos FOREIGN KEY (Banco) REFERENCES Bancos(Banco)
	// fk_ CuentasDeFondos1 FOREIGN KEY (CuentaCaucion) REFERENCES
	// CuentasDeFondos(Cuenta)
	// fk_ CuentasDeFondos2 FOREIGN KEY (CuentaDiferidos) REFERENCES
	// CuentasDeFondos(Cuenta)
	// fk_ Monedas FOREIGN KEY (Moneda) REFERENCES Monedas(Moneda)

	@FieldLabelAnont(value = "ID")
	private String id;
	
	@FieldLabelAnont(value = "Grupo")
	private CuentaFondoGrupo cuentaFondoGrupo;
	
	@FieldLabelAnont(value = "Nº cuenta")
	private Integer numero;
	
	@FieldLabelAnont(value = "Nombre")
	private String nombre;
	
	@FieldLabelAnont(value = "Tipo")
	private CuentaFondoTipo cuentaFondoTipo;
	
	@FieldLabelAnont(value = "Banco")
	private Banco banco;
	
	@FieldLabelAnont(value = "Obsoleto")
	private Boolean bloqueado;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public CuentaFondoGrupo getCuentaFondoGrupo() {
		return cuentaFondoGrupo;
	}

	public void setCuentaFondoGrupo(CuentaFondoGrupo cuentaFondoGrupo) {
		this.cuentaFondoGrupo = cuentaFondoGrupo;
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

	public CuentaFondoTipo getCuentaFondoTipo() {
		return cuentaFondoTipo;
	}

	public void setCuentaFondoTipo(CuentaFondoTipo cuentaFondoTipo) {
		this.cuentaFondoTipo = cuentaFondoTipo;
	}

	public Banco getBanco() {
		return banco;
	}

	public void setBanco(Banco banco) {
		this.banco = banco;
	}

	public Boolean getBloqueado() {
		return bloqueado;
	}

	public void setBloqueado(Boolean bloqueado) {
		this.bloqueado = bloqueado;
	}

	// public List<CuentaFondo> find(int limit, int offset, Map<String, Boolean>
	// orderBy, CuentasFondoFiltro filtro) throws Exception {
	//
	// List<CuentaFondo> listado = new ArrayList<CuentaFondo>();
	//
	// List<EntityId> items = findUtil("numero", null, limit, offset, null, 3);
	//
	// for (EntityId item : items) {
	// listado.add((CuentaFondo) item);
	// }
	//
	// return listado;
	// }

	public List<CuentaFondo> find(int limit, int offset, Map<String, Boolean> orderBy, CuentasFondoFiltro filtro)
			throws Exception {

		filtro.setterTrim();

		List<CuentaFondo> listado = new ArrayList<CuentaFondo>();

		String orderBySQL = "numero";
		String whereSQL = "";

		ArrayList<Object> filtros = new ArrayList<Object>();

		if (filtro.getNumero() != null) {
			filtros.add(filtro.getNumero());
			whereSQL += "numero" + " = ? AND ";
		}
		if (filtro.getIdBanco() != null) {
			filtros.add(filtro.getIdBanco());
			whereSQL += "banco" + " = ? AND ";
		}
		if (filtro.getIdGrupo() != null) {
			filtros.add(filtro.getIdGrupo());
			whereSQL += "cuentaFondoGrupo" + " = ? AND ";
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

		String sql = "SELECT " + this.getClass().getSimpleName() + ".* FROM massoftware."
				+ this.getClass().getSimpleName();

		if (filtro.getIdRubro() != null) {
			sql += " JOIN massoftware." + CuentaFondoGrupo.class.getSimpleName() + " g ON g.id = cuentaFondoGrupo";
			filtros.add(0, filtro.getIdRubro());
			sql += " AND g.cuentaFondoRubro" + " = ?";
		}

		if (whereSQL != null && whereSQL.trim().length() > 0) {
			sql += " WHERE " + whereSQL;
		}

		if (orderBySQL != null && orderBySQL.trim().length() > 0) {
			sql += " ORDER BY " + orderBySQL;
		} else {
			sql += " ORDER BY " + 1;
		}

		if (offset > -1 && limit > -1) {

			sql += " OFFSET " + offset + " LIMIT " + limit;
		}

		Object[][] table = BackendContextPG.get().find(sql, limit, offset, filtros.toArray());

		for (int i = 0; i < table.length; i++) {
			CuentaFondo item = new CuentaFondo();
			item.setter(table[i], 3);

			listado.add(item);
		}

		return listado;
	}

}
