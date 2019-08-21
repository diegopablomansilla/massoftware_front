package com.anthill.ant.fondos;

import com.anthill.Anthill;
import com.anthill.ant.Ant;
import com.anthill.model.Att;
import com.anthill.model.Clazz;
import com.anthill.model.DataTypeInteger;

public class ComprobanteFondoModeloItemAnt extends Ant {
	
	private ComprobanteFondoModeloAnt comprobanteFondoModeloAnt;
	private CuentaFondoAnt cuentaFondoAnt;

	public ComprobanteFondoModeloItemAnt(Anthill anthill, ComprobanteFondoModeloAnt comprobanteFondoModeloAnt, CuentaFondoAnt cuentaFondoAnt) {
		super(anthill);
		this.comprobanteFondoModeloAnt = comprobanteFondoModeloAnt;
		this.cuentaFondoAnt = cuentaFondoAnt;
	}

	public Clazz build() throws Exception {

		// SELECT [NUMERO],[CUENTA],[CONCEPTO],[AJUSTASALDO],[ELIMINAR] FROM [dbo].[FondosModMov]

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("ComprobanteFondoModeloItem");
		c.setNamePlural("ComprobantesFondosModelosItems");

		c.setNamePackage("fondos");
		c.setSingular("Modelo de comprobante de fondo");
		c.setPlural("Modelos de comprobante de fondo");
		c.setSingularPre("el nodelo de comprobante de fondo");
		c.setPluralPre("los modelos de comprobante de fondo");

		// -------- Atts

		Att numero = new Att("numero", "Nº modelo");
		numero.setDataTypeInteger(1, null);
		((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		numero.setRequired(true);
		numero.setUnique(true);
		c.addAtt(numero);

		Att debe = new Att("debe", "Debe");
		debe.setDataTypeBoolean();
		debe.setRequired(true);		
		c.addAtt(debe);
		
		Att comprobanteFondoModelo = new Att("comprobanteFondoModelo", "Modelo");
		comprobanteFondoModelo.setDataTypeClazz(comprobanteFondoModeloAnt.build());
		comprobanteFondoModelo.setRequired(true);
		c.addAtt(comprobanteFondoModelo);
		
		Att cuentaFondo = new Att("cuentaFondo", "Cuenta fondo");
		cuentaFondo.setDataTypeClazz(cuentaFondoAnt.build());
		cuentaFondo.setRequired(true);
		c.addAtt(cuentaFondo);

		// -------- SBX Args

		c.addArgument(numero, true);
		c.getLastArgument().setRequired(false);
		c.addArgumentSBX(c.getLastArgument());

		// -------- Simple Args
		
		c.addArgument(cuentaFondo);
		c.getLastArgument().setRequired(true);		

		// -------- Order

		c.addOrderAllAtts();

		c.getOrderDefault().setDesc(true);

		// ------------------------------------------------

		return c;

		// ------------------------------------------------
	}

}
