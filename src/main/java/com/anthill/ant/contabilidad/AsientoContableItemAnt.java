package com.anthill.ant.contabilidad;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class AsientoContableItemAnt extends Ant {

	private Ant asientoContableAnt;
	private Ant cuentaContableAnt;

	public AsientoContableItemAnt(Anthill anthill, Ant asientoContableAnt, Ant cuentaContableAnt) {
		super(anthill);
		this.asientoContableAnt = asientoContableAnt;
		this.cuentaContableAnt = cuentaContableAnt;
	}

	public Clazz build() throws Exception {

		// SELECT [EJERCICIO]
//	     		 ,[NUMEROASIENTO]
//	    	     ,[CUENTACONTABLE]
//	    	     ,[DEBE]
//	    	     ,[HABER]
//	    	     ,[DETALLE]
//	    	     ,[FECHASQL]
//	    	     ,[ORDEN]
//	    	     ,[NROREGISTRO]
//	    	 FROM [dbo].[MovContabilidad]

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("AsientoContableItem");

		c.setNamePackage("contabilidad");
		c.setSingular("Item de asiento contable");
		c.setPlural("Items de asientos contables");
		c.setSingularPre("el item de asiento contable");
		c.setPluralPre("los items de asientos contables");

		// -------- Atts

		Att numero = new Att("numero", "Nº item");
		numero.setDataTypeInteger(1, null);
		((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		numero.setRequired(true);
		numero.setUnique(true);
		c.addAtt(numero);

		Att fecha = new Att("fecha", "Fecha");
		fecha.setDataTypeDate();
		fecha.setRequired(true);
		c.addAtt(fecha);

		Att detalle = new Att("detalle", "Detalle");
		detalle.setLength(null, 100);
		c.addAtt(detalle);

		Att asientoContable = new Att("asientoContable", "Asiento contable");
		asientoContable.setDataTypeClazz(asientoContableAnt.build());
		asientoContable.setRequired(true);
		asientoContable.setReadOnlyGUI(true);
		c.addAtt(asientoContable);

		Att cuentaContable = new Att("cuentaContable", "Cuenta contable");
		cuentaContable.setDataTypeClazz(cuentaContableAnt.build());
		cuentaContable.setRequired(true);
		c.addAtt(cuentaContable);

		Att debe = new Att("debe", "Debe");
		debe.setDataTypeBigDecimal(null, null, 13, 5);		
		debe.setRequired(true);
		c.addAtt(debe);

		Att haber = new Att("haber", "Haber");
		haber.setDataTypeBigDecimal(null, null, 13, 5);		
		haber.setRequired(true);
		c.addAtt(haber);

		// -------- SBX Args

		c.addArgument(numero, true);
//		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(detalle);
//		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		// -------- Simple Args

		c.addArgument(asientoContable);
		c.getLastArgument().setRequired(true);

		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
