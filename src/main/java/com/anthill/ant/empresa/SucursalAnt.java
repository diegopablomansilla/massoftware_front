package com.anthill.ant.empresa;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class SucursalAnt extends Ant {
	
	// SELECT  A.SUCURSAL, A.NOMBRE, A.TIPOSUCURSAL FROM Sucursales A ORDER BY  A.NOMBRE

	private Ant tipoSucursalAnt;

	public SucursalAnt(Anthill anthill, Ant tipoSucursalAnt) {
		super(anthill);
		this.tipoSucursalAnt = tipoSucursalAnt;
	}

	public Clazz build() throws Exception {

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("Sucursal");

		c.setNamePackage("empresa");
		c.setSingular("Sucursal");
		c.setPlural("Sucursales");
		c.setSingularPre("la sucursal");
		c.setPluralPre("las sucursales");

		// -------- Atts

		Att numero = new Att("numero", "Nº sucursal");
		numero.setDataTypeInteger(1, null);
		((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		numero.setRequired(true);
		numero.setUnique(true);
		c.addAtt(numero);

		Att nombre = new Att("nombre", "Nombre");
		nombre.setRequired(true);
		nombre.setUnique(true);
		nombre.setLength(null, 50);
		c.addAtt(nombre);

		Att abreviatura = new Att("abreviatura", "Abreviatura");
		abreviatura.setRequired(true);
		abreviatura.setUnique(true);
		abreviatura.setLength(null, 5);
		abreviatura.setColumns((float) 5);
		c.addAtt(abreviatura);

		Att tipoSucursal = new Att("tipoSucursal", "Tipo sucursal");
		tipoSucursal.setDataTypeClazz(tipoSucursalAnt.build());
		tipoSucursal.setRequired(true);
		c.addAtt(tipoSucursal);

		Att cuentaClientesDesde = new Att("cuentaClientesDesde", "Cuenta clientes desde");
		cuentaClientesDesde.setLength(null, 7);
		cuentaClientesDesde.setColumns((float) 6);
		c.addAtt(cuentaClientesDesde);

		Att cuentaClientesHasta = new Att("cuentaClientesHasta", "Cuenta clientes hasta");
		cuentaClientesHasta.setLength(null, 7);
		cuentaClientesHasta.setColumns((float) 6);
		c.addAtt(cuentaClientesHasta);

		Att cantidadCaracteresClientes = new Att("cantidadCaracteresClientes", "Cantidad caracteres clientes");
		cantidadCaracteresClientes.setDataTypeInteger(3, 6);
		cantidadCaracteresClientes.setRequired(true);
		c.addAtt(cantidadCaracteresClientes);

		Att identificacionNumericaClientes = new Att("identificacionNumericaClientes",
				"Identificacion numérica clientes");
		identificacionNumericaClientes.setDataTypeBoolean();
		identificacionNumericaClientes.setRequired(true);
		c.addAtt(identificacionNumericaClientes);

		Att permiteCambiarClientes = new Att("permiteCambiarClientes", "Permite cambiar clientes");
		permiteCambiarClientes.setDataTypeBoolean();
		permiteCambiarClientes.setRequired(true);
		c.addAtt(permiteCambiarClientes);

		// --------------------------------------------------------------

		Att cuentaProveedoresDesde = new Att("cuentaProveedoresDesde", "Cuenta proveedores desde");
		cuentaProveedoresDesde.setLength(null, 6);
		cuentaProveedoresDesde.setColumns((float) 7);
		c.addAtt(cuentaProveedoresDesde);

		Att cuentaProveedoresHasta = new Att("cuentaProveedoresHasta", "Cuenta proveedores hasta");
		cuentaProveedoresHasta.setLength(null, 6);
		cuentaProveedoresHasta.setColumns((float) 7);
		c.addAtt(cuentaProveedoresHasta);

		Att cantidadCaracteresProveedores = new Att("cantidadCaracteresProveedores", "Cantidad caracteres proveedores");
		cantidadCaracteresProveedores.setDataTypeInteger(3, 6);
		cantidadCaracteresProveedores.setRequired(true);
		c.addAtt(cantidadCaracteresProveedores);

		Att identificacionNumericaProveedores = new Att("identificacionNumericaProveedores",
				"Identificacion numérica proveedores");
		identificacionNumericaProveedores.setDataTypeBoolean();
		identificacionNumericaProveedores.setRequired(true);
		c.addAtt(identificacionNumericaProveedores);

		Att permiteCambiarProveedores = new Att("permiteCambiarProveedores", "Permite cambiar proveedores");
		permiteCambiarProveedores.setDataTypeBoolean();
		permiteCambiarProveedores.setRequired(true);
		c.addAtt(permiteCambiarProveedores);
		
		// --------------------------------------------------------------

		Att clientesOcacionalesDesde = new Att("clientesOcacionalesDesde", "Clientes ocacionales desde");
		clientesOcacionalesDesde.setDataTypeInteger(1, null);
		clientesOcacionalesDesde.setRequired(true);
		c.addAtt(clientesOcacionalesDesde);

		Att clientesOcacionalesHasta = new Att("clientesOcacionalesHasta", "Clientes ocacionales hasta");
		clientesOcacionalesHasta.setDataTypeInteger(1, null);
		clientesOcacionalesHasta.setRequired(true);
		c.addAtt(clientesOcacionalesHasta);

		Att numeroCobranzaDesde = new Att("numeroCobranzaDesde", "Número cobranza desde");
		numeroCobranzaDesde.setDataTypeInteger(1, null);
		numeroCobranzaDesde.setRequired(true);
		c.addAtt(numeroCobranzaDesde);

		Att numeroCobranzaHasta = new Att("numeroCobranzaHasta", "Número cobranza hasta");
		numeroCobranzaHasta.setDataTypeInteger(1, null);
		numeroCobranzaHasta.setRequired(true);
		c.addAtt(numeroCobranzaHasta);

		// -------- SBX Args

		c.addArgument(numero, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(nombre);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		// -------- Simple Args

		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
