package com.massoftware.backend.migracion;

import com.massoftware.backend.BackendContextMS;
import com.massoftware.model.Banco;
import com.massoftware.model.CuentaFondo;
import com.massoftware.model.CuentaFondoGrupo;
import com.massoftware.model.CuentaFondoRubro;

public class MigradorMSToPG {

	public static void main(String[] args) {
		try {

			migrar();

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static void migrar() throws Exception {

		System.out.println("\n\nStart Migrador\n\n");

		banco();

		rubro();

		grupo();

		cuentaFondo();

		System.out.println("\n\nEnd Migrador\n\n");

	}

	public static void banco() throws Exception {

		// ==================================================================
		// MS SQL SERVER

		String attId = "CAST(A.BANCO AS VARCHAR)";
		String attNumero = "CAST(A.BANCO AS INTEGER)";
		String attNombre = "A.NOMBRE";
		String attCuit = "CAST(A.CUIT AS BIGINT)";
		String attBloqueado = "CAST(A.BLOQUEADO AS BIT)";
		String attHoja = "CAST(A.HOJA AS INTEGER)";
		String attPrimeraFila = "CAST(A.PRIMERAFILA AS INTEGER)";
		String attUltimaFila = "CAST(A.ULTIMAFILA AS INTEGER)";
		String attFecha = "A.COLUMNAFECHA";
		String attDescripcion = "A.COLUMNADESCRIPCION";
		String attReferencia1 = "A.COLUMNAREFERENCIA1";
		String attReferencia2 = "A.COLUMNAREFERENCIA2";
		String attImporte = "A.COLUMNAIMPORTE";
		String attSaldo = "A.COLUMNASALDO";

		String tableSQL = "Bancos A";

		String attsSQL = attId + ", " + attNumero + ", " + attNombre + ", " + attCuit + ", " + attBloqueado + ", "
				+ attHoja + ", " + attPrimeraFila + ", " + attUltimaFila + ", " + attFecha + ", " + attDescripcion
				+ ", " + attReferencia1 + ", " + attReferencia2 + ", " + attImporte + ", " + attSaldo;
		String orderBySQL = null;
		String whereSQL = null;

		// ==================================================================

		Object[][] table = BackendContextMS.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1, null);

		for (int i = 0; i < table.length; i++) {

			Banco item = new Banco();
			item.setter(table[i], 0);
			item.insert();

		}

	}

	public static void rubro() throws Exception {

		// ==================================================================
		// MS SQL SERVER

		String attId = "CAST(A.RUBRO AS VARCHAR)";
		String attNumero = "CAST(A.RUBRO AS INTEGER)";
		String attNombre = "LTRIM(RTRIM(CAST(A.NOMBRE AS VARCHAR)))";

		String tableSQL = "CuentasDeFondosRubro A";

		String attsSQL = attId + ", " + attNumero + ", " + attNombre;
		String orderBySQL = null;
		String whereSQL = null;

		// ==================================================================

		// ==================================================================

		Object[][] table = BackendContextMS.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1, null);

		for (int i = 0; i < table.length; i++) {

			CuentaFondoRubro item = new CuentaFondoRubro();
			item.setter(table[i], 0);
			item.insert();

		}

	}

	public static void grupo() throws Exception {

		// ==================================================================
		// MS SQL SERVER

		String attId = " CONCAT (RUBRO, '-', GRUPO )";
		String attNumeroRubro = "CASE WHEN RUBRO = 0 THEN null ELSE RUBRO END";
		String attNumero = "CAST(GRUPO AS INTEGER)";
		String attNombre = "NOMBRE";

		String tableSQL = "CuentasDeFondosGrupo A";

		String attsSQL = attId + ", " + attNumeroRubro + ", " + attNumero + ", " + attNombre;
		String orderBySQL = null;
		String whereSQL = null;

		// ==================================================================

		// ==================================================================

		Object[][] table = BackendContextMS.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1, null);

		for (int i = 0; i < table.length; i++) {

			CuentaFondoGrupo item = new CuentaFondoGrupo();
			item.setter(table[i], 0);
			item.insert();

		}

	}

	public static void cuentaFondo() throws Exception {

		// ==================================================================
		// MS SQL SERVER

		String id = "CUENTA";
		String cuentaFondoGrupo = "CONCAT(CASE WHEN RUBRO = 0 THEN null ELSE RUBRO END, '-', CASE WHEN GRUPO = 0 THEN null ELSE GRUPO END)";
		String numero = "CAST(CUENTA AS INTEGER)";
		String nombre = "NOMBRE";
		String cuentaFondoTipo = "TIPO";
		String banco = " CASE WHEN BANCO = 0 THEN null ELSE BANCO END";
		String bloqueado = "CAST(OBSOLETA AS BIT)";

		String tableSQL = "CuentasDeFondos";

		String attsSQL = id + ", " + cuentaFondoGrupo + ", " + numero + ", " + nombre + ", " + cuentaFondoTipo + ", "
				+ banco + ", " + bloqueado;
		String orderBySQL = numero;
		String whereSQL = null;

		// ==================================================================

		Object[][] table = BackendContextMS.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1, null);

		for (int i = 0; i < table.length; i++) {

			CuentaFondo item = new CuentaFondo();
			item.setter(table[i], 0);
			try {
				item.insert();
			} catch (Exception e) {				
				System.err.println(e);
//				throw e;
			}

		}

	}

}
