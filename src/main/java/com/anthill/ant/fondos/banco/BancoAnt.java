package com.anthill.ant.fondos.banco;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class BancoAnt extends Ant {

	public BancoAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		// SELECT  A.BANCO, A.NOMBRE, A.NOMBRECOMPLETO, A.BLOQUEADO FROM Bancos A ORDER BY  A.BANCO
		
		
		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("Banco");

		c.setNamePackage("fondos.banco");
		c.setSingular("Banco");
		c.setPlural("Bancos");
		c.setSingularPre("el banco");
		c.setPluralPre("los bancos");

		// -------- Atts

		Att numero = new Att("numero", "Nº banco");
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

		Att cuit = new Att("cuit", "CUIT");
		cuit.setDataTypeLong(1L, 99999999999L);
		cuit.setRequired(true);
		cuit.setUnique(true);
		cuit.setColumns((float) 11);
		cuit.setLength(11, 11);
		cuit.setMask("99-99999999-9");
		c.addAtt(cuit);

		Att bloqueado = new Att("bloqueado", "Obsoleto");
		bloqueado.setDataTypeBoolean();
		c.addAtt(bloqueado);

		Att hoja = new Att("hoja", "Hoja");
		hoja.setDataTypeInteger(1, 100);
		c.addAtt(hoja);

		Att primeraFila = new Att("primeraFila", "Primera fila");
		primeraFila.setDataTypeInteger(1, 1000);
		c.addAtt(primeraFila);

		Att ultimaFila = new Att("ultimaFila", "Última fila");
		ultimaFila.setDataTypeInteger(1, 1000);
		c.addAtt(ultimaFila);

		Att fecha = new Att("fecha", "Fecha");
		fecha.setColumns((float) 6);
		fecha.setLength(null, 3);
		c.addAtt(fecha);

		Att descripcion = new Att("descripcion", "Descripción");
		descripcion.setColumns((float) 6);
		descripcion.setLength(null, 3);
		c.addAtt(descripcion);

		Att referencia1 = new Att("referencia1", "Referencia 1");
		referencia1.setColumns((float) 6);
		referencia1.setLength(null, 3);
		c.addAtt(referencia1);

		Att importe = new Att("importe", "Importe");
		importe.setColumns((float) 6);
		importe.setLength(null, 3);
		c.addAtt(importe);

		Att referencia2 = new Att("referencia2", "Referencia 2");
		referencia2.setColumns((float) 6);
		referencia2.setLength(null, 3);
		c.addAtt(referencia2);

		Att saldo = new Att("saldo", "Saldo");
		saldo.setColumns((float) 6);
		saldo.setLength(null, 3);
		c.addAtt(saldo);

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
