package com.massoftware.backend.migracion;

import com.massoftware.backend.BackendContextMS;
import com.massoftware.model.Banco;
import com.massoftware.model.Caja;
import com.massoftware.model.CuentaFondo;
import com.massoftware.model.CuentaFondoGrupo;
import com.massoftware.model.CuentaFondoRubro;
import com.massoftware.model.SeguridadModulo;
import com.massoftware.model.SeguridadPuerta;
import com.massoftware.model.Sucursal;
import com.massoftware.model.Talonario;

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

		modulo();

		puerta();

		caja();

		banco();

		rubro();

		grupo();

		cuentaFondo();

		sucursal();
		
		talonario();

		System.out.println("\n\nEnd Migrador\n\n");

	}

	public static void banco() throws Exception {

		// ==================================================================
		// MS SQL SERVER

		String attId = "CAST(A.BANCO AS VARCHAR)";
		String attNumero = "CAST(A.BANCO AS INTEGER)";
		String attNombre = "A.NOMBRE";
		String attCuit = "CASE WHEN A.CUIT = 0 THEN null ELSE CAST(A.CUIT AS BIGINT) END";
		String attBloqueado = "CAST(A.BLOQUEADO AS BIT)";
		String attHoja = "CAST(A.HOJA AS INTEGER)";
		String attPrimeraFila = "A.PRIMERAFILA";
		String attUltimaFila = "A.ULTIMAFILA";
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
		String orderBySQL = attNumero;
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
		String attNombre = "A.NOMBRE";

		String tableSQL = "CuentasDeFondosRubro A";

		String attsSQL = attId + ", " + attNumero + ", " + attNombre;
		String orderBySQL = attNumero;
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
		String orderBySQL = attNumeroRubro + ", " + attNumero;
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
			item.insert();

		}

	}

	public static void modulo() throws Exception {

		// ==================================================================
		// MS SQL SERVER

		String attId = "CAST(A.NO AS VARCHAR)";
		String attNumero = "A.NO";
		String attNombre = "A.NAME";

		String tableSQL = "SSECUR_DoorGroup A";

		String attsSQL = attId + ", " + attNumero + ", " + attNombre;
		String orderBySQL = attNumero;
		String whereSQL = null;

		// ==================================================================

		// ==================================================================

		Object[][] table = BackendContextMS.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1, null);

		for (int i = 0; i < table.length; i++) {

			SeguridadModulo item = new SeguridadModulo();
			item.setter(table[i], 0);
			item.insert();

		}

	}

	public static void puerta() throws Exception {

		// SELECT A."NO", A.DGRPNO, A.EQUATE, A.DESCRIPTION FROM dbo.SSECUR_Door A WHERE
		// ( A.DGRPNO = 3 ) ORDER BY A.DGRPNO, UPPER( A.DESCRIPTION)

		// ==================================================================
		// MS SQL SERVER

		String attId = " CONCAT (DGRPNO, '-', NO )";
		String attNumeroModulo = "CASE WHEN DGRPNO = 0 THEN null ELSE DGRPNO END";
		String attNumero = "CAST(NO AS INTEGER)";
		String attNombre = "DESCRIPTION";
		String attEquate = "EQUATE";

		String tableSQL = "SSECUR_Door";

		String attsSQL = attId + ", " + attNumeroModulo + ", " + attNumero + ", " + attNombre + ", " + attEquate;
		String orderBySQL = attNumeroModulo + ", " + attNumero;
		String whereSQL = null;

		// ==================================================================

		// ==================================================================

		Object[][] table = BackendContextMS.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1, null);

		for (int i = 0; i < table.length; i++) {

			SeguridadPuerta item = new SeguridadPuerta();
			item.setter(table[i], 0);
			item.insert();

		}

	}

	public static void caja() throws Exception {

		// ==================================================================
		// MS SQL SERVER

		String attId = "CAST(A.CAJA AS VARCHAR)";
		String attNumero = "CAST(A.CAJA AS INTEGER)";
		String attNombre = "A.NOMBRE";
		String attPuerta = "A.DOORNOPERMISO";

		String tableSQL = "Cajas A";

		String attsSQL = attId + ", " + attNumero + ", " + attNombre + ", " + attPuerta;
		String orderBySQL = attNumero;
		String whereSQL = null;

		// ==================================================================

		// ==================================================================

		Object[][] table = BackendContextMS.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1, null);

		for (int i = 0; i < table.length; i++) {

			Caja item = new Caja();
			item.setter(table[i], 0);
			item.insert();

		}

	}

	public static void sucursal() throws Exception {

		// 'SELECT A.SUCURSAL, A.NOMBRE, A.TIPOSUCURSAL FROM Sucursales A ORDER BY
		// A.NOMBRE'

		// ==================================================================
		// MS SQL SERVER

		String attId = "CAST(A.SUCURSAL AS VARCHAR)";
		String attTipo = "A.TIPOSUCURSAL";
		String attNumero = "CAST(A.SUCURSAL AS INTEGER)";
		String attNombre = "A.NOMBRE";

		String attAbreviatura = "A.ABREVIATURA";

		String cuentaClienteDesde = "A.CUENTASCLIENTESDESDE";
		String cuentaClienteHasa = "A.CUENTASCLIENTESHASTA";
		String cantidadCaracteresCliente = "CAST(A.CANTIDADCARACTERESCLIENTES AS INTEGER)";
		String identificacionNumericaCliente = "CAST(A.NUMERICOCLIENTES AS BIT)";
		String permiteCambiarCliente = "CAST(A.PERMITECAMBIARCLIENTES AS BIT)";
		// -- --------------------------------------------------------
		String clientesOcacionalesDesde = "CASE WHEN A.CUENTASCLIENTESOCASIONALESDESDE = 0 THEN null ELSE CAST(A.CUENTASCLIENTESOCASIONALESDESDE AS INTEGER) END";
		String clientesOcacionalesHasa = "CASE WHEN A.CUENTASCLIENTESOCASIONALESHASTA = 0 THEN null ELSE CAST(A.CUENTASCLIENTESOCASIONALESHASTA AS INTEGER) END";
		// -- --------------------------------------------------------
		String nroCobranzaDesde = "CASE WHEN A.NROCOBRANZADESDE = 0 THEN null ELSE CAST(A.NROCOBRANZADESDE AS INTEGER) END";
		String nroCobranzaHasa = "CASE WHEN A.NROCOBRANZAHASTA = 0 THEN null ELSE CAST(A.NROCOBRANZAHASTA AS INTEGER) END";
		// -- --------------------------------------------------------
		String proveedoresDesde = "A.CUENTASPROVEEDORESDESDE";
		String proveedoresHasa = "A.CUENTASPROVEEDORESHASTA";
		String cantidadCaracteresProveedor = "CAST(A.CANTIDADCARACTERESPROVEEDOR AS INTEGER)";
		String identificacionNumericaProveedor = "CAST(A.NUMERICOPROVEEDOR AS BIT)";
		String permiteCambiarProveedor = "CAST(A.PERMITECAMBIARPROVEEDOR AS BIT)";

		String tableSQL = "Sucursales A";

		String attsSQL = attId + ", " + attTipo + ", " + attNumero + ", " + attNombre + ", " + attAbreviatura + ", "
				+ cuentaClienteDesde + ", " + cuentaClienteHasa + ", " + cantidadCaracteresCliente + ", "
				+ identificacionNumericaCliente + ", " + permiteCambiarCliente + ", " + clientesOcacionalesDesde + ", "
				+ clientesOcacionalesHasa + ", " + nroCobranzaDesde + ", " + nroCobranzaHasa + ", " + proveedoresDesde
				+ ", " + proveedoresHasa + ", " + cantidadCaracteresProveedor + ", " + identificacionNumericaProveedor
				+ ", " + permiteCambiarProveedor;

		String orderBySQL = attNumero;
		String whereSQL = null;

		// ==================================================================

		// ==================================================================

		Object[][] table = BackendContextMS.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1, null);

		for (int i = 0; i < table.length; i++) {

			Sucursal item = new Sucursal();
			item.setter(table[i], 0);
			item.insert();

		}

	}

	public static void talonario() throws Exception {

		// SELECT A.MULTIPROPOSITO, A.NOMBRE, A.LETRA, A.SUCURSAL, A.PROXIMONUMERO FROM
		// TablaDeMultiproposito A ORDER BY A.MULTIPROPOSITO

		// ==================================================================
		// MS SQL SERVER

		String id = "CAST(A.MULTIPROPOSITO AS VARCHAR)";
		String numero = "CAST(A.MULTIPROPOSITO AS INTEGER)";
		String nombre = "A.NOMBRE";
		String talonarioLetra = "A.LETRA";
		String puntoVenta = "CAST(A.SUCURSAL AS INTEGER)";
		String autonumeracion = "CAST(A.AUTONUMERACION AS BIT)";
		String numeracionPreImpresa = "CAST(A.NUMERACIONPREIMPRESA AS BIT)";
		String asociadoRG10098 = "CAST(A.RG10098 AS BIT)";
		String talonarioControladorFizcal = "A.CONTROLFISCAL";
		String primerNumero = "CASE WHEN A.PRIMERNUMERO = 0 THEN null ELSE CAST(A.PRIMERNUMERO AS INTEGER) END";
		String proximoNumero = "CASE WHEN A.PROXIMONUMERO = 0 THEN null ELSE CAST(A.PROXIMONUMERO AS INTEGER) END";
		String ultimoNumero = "CASE WHEN A.ULTIMONUMERO = 0 THEN null ELSE CAST(A.ULTIMONUMERO AS INTEGER) END";
		String cantidadMinimaComprobantes = "CASE WHEN A.ALERTACANTIDADMINIMADECBTES = 0 THEN null ELSE CAST(A.ALERTACANTIDADMINIMADECBTES AS INTEGER) END";
		String fecha = "A.ULTIMAFECHASQL";
		String numeroCAI = "CASE WHEN A.CAI = 0 THEN null ELSE A.CAI END";
		String vencimiento = "A.VENCIMIENTOCAISQL";
		String diasAvisoVencimiento = "CASE WHEN A.DIASAVISOVENCIMIENTO = 0 THEN null ELSE CAST(A.DIASAVISOVENCIMIENTO AS INTEGER) END";

		String tableSQL = "TablaDeMultiproposito A";

		String attsSQL = id + ", " + numero + ", " + nombre + ", " + talonarioLetra + ", " + puntoVenta + ", "
				+ autonumeracion + ", " + numeracionPreImpresa + ", " + asociadoRG10098 + ", "
				+ talonarioControladorFizcal + ", " + primerNumero + ", " + proximoNumero + ", " + ultimoNumero + ", "
				+ cantidadMinimaComprobantes + ", " + fecha + ", " + numeroCAI + ", " + vencimiento + ", "
				+ diasAvisoVencimiento;

		String orderBySQL = numero;
		String whereSQL = null;

		// ==================================================================

		// ==================================================================

		Object[][] table = BackendContextMS.get().find(tableSQL, attsSQL, orderBySQL, whereSQL, -1, -1, null);

		for (int i = 0; i < table.length; i++) {

			Talonario item = new Talonario();
			item.setter(table[i], 0);
			item.insert();

		}

	}

}
