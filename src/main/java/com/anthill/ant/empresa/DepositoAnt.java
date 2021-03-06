package com.anthill.ant.empresa;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class DepositoAnt extends Ant {

	// SELECT A.DEPOSITO, A.NOMBRE, A.ABREVIATURA, A.CAJA, A.SUCURSAL, A.MODULO,
	// B.SUCURSAL, B.NOMBRE FROM {oj Depositos A LEFT OUTER JOIN Sucursales B ON
	// A.SUCURSAL= B.SUCURSAL } ORDER BY A.NOMBRE

	private Ant sucursalAnt;
	private Ant depositoModuloAnt;
	private Ant seguridadPuertaAnt;

	public DepositoAnt(Anthill anthill, Ant sucursalAnt, Ant depositoModuloAnt, Ant seguridadPuertaAnt) {
		super(anthill);
		this.sucursalAnt = sucursalAnt;
		this.depositoModuloAnt = depositoModuloAnt;
		this.seguridadPuertaAnt = seguridadPuertaAnt;
	}

	public Clazz build() throws Exception {

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("Deposito");
		c.setNamePlural("Depositos");

		c.setNamePackage("empresa");
		c.setSingular("Depósito");
		c.setPlural("Depósitos");
		c.setSingularPre("el fepósito");
		c.setPluralPre("los depósitos");

		// -------- Atts

		Att numero = new Att("numero", "Nº depósito");
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

		Att sucursal = new Att("sucursal", "Sucursal");
		sucursal.setDataTypeClazz(sucursalAnt.build());
		sucursal.setRequired(true);
		c.addAtt(sucursal);

		Att depositoModulo = new Att("depositoModulo", "Módulo");
		depositoModulo.setDataTypeClazz(depositoModuloAnt.build());
		depositoModulo.setRequired(true);
		c.addAtt(depositoModulo);

		Att puertaOperativo = new Att("puertaOperativo", "Puerta operativo");
		puertaOperativo.setDataTypeClazz(seguridadPuertaAnt.build());
		puertaOperativo.setRequired(true);
		c.addAtt(puertaOperativo);

		Att puertaConsulta = new Att("puertaConsulta", "Puerta consulta");
		puertaConsulta.setDataTypeClazz(seguridadPuertaAnt.build());
		puertaConsulta.setRequired(true);
		c.addAtt(puertaConsulta);

		// -------- GRID

		Att nombreSucursal = new Att("nombreSucursal", "Nombre sucursal");
		Att nombreModulo = new Att("nombreModulo", "Nombre módulo");
		
		c.addAttGrid(numero);
		c.addAttGrid(abreviatura);
		c.addAttGrid(nombre);
		c.addAttGrid(nombreSucursal);
		c.addAttGrid(nombreModulo);

		// -------- SBX Args

		c.addArgument(sucursal);
		c.getLastArgument().setRequired(false);

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

		c.setStmAtts(", Deposito.numero, Deposito.abreviatura, Deposito.nombre, Sucursal.nombre AS nombreSucursal, DepositoModulo.nombre AS nombreModulo");
		c.setStmJoins(" LEFT JOIN massoftware.DepositoModulo ON DepositoModulo.id = Deposito.depositoModulo "
				+ " LEFT JOIN massoftware.Sucursal ON Sucursal.id = Deposito.sucursal");

		return c;

		// ------------------------------------------------
	}

}
