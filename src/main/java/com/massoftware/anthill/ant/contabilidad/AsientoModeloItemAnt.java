package com.massoftware.anthill.ant.contabilidad;

import com.massoftware.anthill.Ant;
import com.massoftware.anthill.Anthill;
import com.massoftware.anthill.Att;
import com.massoftware.anthill.Clazz;
import com.massoftware.anthill.DataTypeInteger;

public class AsientoModeloItemAnt extends Ant {
	
	private Ant asientoModeloAnt;
	private Ant cuentaContableAnt;

	public AsientoModeloItemAnt(Anthill anthill, Ant asientoModeloAnt, Ant cuentaContableAnt) {
		super(anthill);
		this.asientoModeloAnt = asientoModeloAnt;
		this.cuentaContableAnt = cuentaContableAnt;
	}

	public Clazz build() throws Exception {

		// AsientosModelosMov

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("AsientoModeloItem");

		c.setNamePackage("contabilidad");
		c.setSingular("Item de asiento modelo");
		c.setPlural("Items de asiento modelo");
		c.setSingularPre("el item de asiento modelo");
		c.setPluralPre("los items de asientos modelo");

		// -------- Atts

		Att numero = new Att("numero", "Nº item");
		numero.setDataTypeInteger(1, null);
		((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		numero.setRequired(true);
		numero.setUnique(true);
		c.addAtt(numero);		
		
		Att asientoModelo = new Att("asientoModelo", "Asiento modelo");
		asientoModelo.setDataTypeClazz(asientoModeloAnt.build());
		asientoModelo.setRequired(true);
		asientoModelo.setReadOnlyGUI(true);
		c.addAtt(asientoModelo);
		
		Att cuentaContable = new Att("cuentaContable", "Cuenta contable");
		cuentaContable.setDataTypeClazz(cuentaContableAnt.build());
		cuentaContable.setRequired(true);
		c.addAtt(cuentaContable);

		// -------- SBX Args				

		// -------- Simple Args

		c.addArgument(asientoModelo);
		c.getLastArgument().setRequired(true);
		
		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
