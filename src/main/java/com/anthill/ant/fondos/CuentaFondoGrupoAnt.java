package com.anthill.ant.fondos;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class CuentaFondoGrupoAnt extends Ant {

	private Ant cuentaFondoRubroAnt;

	public CuentaFondoGrupoAnt(Anthill anthill, Ant cuentaFondoRubroAnt) {
		super(anthill);
		this.cuentaFondoRubroAnt = cuentaFondoRubroAnt;
	}

	public Clazz build() throws Exception {

		//

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("CuentaFondoGrupo");
		c.setNamePlural("CuentasFondosGrupos");

		c.setNamePackage("fondos");
		c.setSingular("Grupo de cuenta fondo");
		c.setPlural("Grupos de cuenta fondo");
		c.setSingularPre("el grupo de cuenta fondo");
		c.setPluralPre("los grupos de cuenta fondo");

		// -------- Atts

		Att numero = new Att("numero", "Nº grupo");
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

		Att cuentaFondoRubro = new Att("cuentaFondoRubro", "Rubro");
		cuentaFondoRubro.setDataTypeClazz(cuentaFondoRubroAnt.build());
		cuentaFondoRubro.setRequired(true);
		c.addAtt(cuentaFondoRubro);

		// -------- SBX Args

		c.addArgument(numero, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		c.addArgument(nombre);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		// -------- Simple Args

		c.addArgument(cuentaFondoRubro);
		c.getLastArgument().setRequired(true);

		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
