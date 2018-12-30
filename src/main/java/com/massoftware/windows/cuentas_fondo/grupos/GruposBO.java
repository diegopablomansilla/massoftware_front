package com.massoftware.windows.cuentas_fondo.grupos;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.cendra.ex.crud.DeleteForeingObjectConflictException;
import org.cendra.ex.crud.InsertNullException;
import org.cendra.ex.crud.NullFieldException;

import com.massoftware.backend.BackendContext;

class GruposBO {
	
	private String attNumero = "CAST(RUBRO AS INTEGER)";
	private String attNombre = "LTRIM(RTRIM(CAST(NOMBRE AS VARCHAR)))";

	public List<Grupos> find(int limit, int offset, Map<String, Boolean> orderBy) throws Exception {

		// SELECT RUBRO, NOMBRE, ESCUENTADEFONDO FROM CuentasDeFondosRubro ORDER BY
		// RUBRO

		// ==================================================================
		// MS SQL SERVER

		String tableSQL = "CuentasDeFondosRubro";
		String attsSQL = attNumero + ", " + attNombre;
		String orderBySQL = attNumero;

		// ==================================================================

		ArrayList<Grupos> lista = new ArrayList<Grupos>();

		Object[][] table = BackendContext.get().find(tableSQL, attsSQL, orderBySQL, null, limit, offset, null);

		for (int i = 0; i < table.length; i++) {
			Grupos item = new Grupos();
			item.setNumero((Integer) table[i][0]);
			item.setNombre((String) table[i][1]);

			lista.add(item);
		}

		return lista;
	}

	public void deleteItem(Grupos item) throws Exception {

		// ALTER TABLE CuentasDeFondosGrupo ADD CONSTRAINT fk_CuentasDeFondosRubro
		// FOREIGN KEY (Rubro) REFERENCES CuentasDeFondosRubro(Rubro)
		//

		// ==================================================================
		// CHECKs NULLs

		if (item == null) {
			throw new InsertNullException("Banco");
		}
		if (item.getNumero() == null) {
			throw new NullFieldException("Numero");
		}

		// ==================================================================
		// CHECKs FKs

		Integer c = ifExists(item.getNumero());

		if (c > 0) {
			throw new DeleteForeingObjectConflictException("el", "Banco", item, c, "Cuenta de Fondo");
		}

		// ==================================================================

		String tableSQL = "CuentasDeFondosRubro";
		String whereSQL = "";

		ArrayList<Object> args = new ArrayList<Object>();

		args.add(item.getNumero());
		whereSQL += attNumero + " = ?";

		BackendContext.get().delete(tableSQL, whereSQL, args.toArray());

	}

	private Integer ifExists(Integer numero) throws Exception {

		// ==================================================================
		// MS SQL SERVER

		String tableSQL = "CuentasDeFondosGrupo";

		String attsSQL = "COUNT(" + attNumero + ") ";
		String orderBySQL = null;
		String whereSQL = "";

		ArrayList<Object> filtros = new ArrayList<Object>();

		if (attNumero != null) {
			filtros.add(numero);
			whereSQL += attNumero + " = ? AND ";
		}

		// ==================================================================

		whereSQL = whereSQL.trim();
		if (whereSQL.length() > 0) {
			whereSQL = whereSQL.substring(0, whereSQL.length() - 4);
		} else {
			whereSQL = null;
		}

		Object[][] table = BackendContext.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1,
				filtros.toArray());

		return (Integer) table[0][0];

	}

}
