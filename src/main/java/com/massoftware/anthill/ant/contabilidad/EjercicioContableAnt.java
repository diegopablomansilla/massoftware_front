package com.massoftware.anthill.ant.contabilidad;

import com.massoftware.anthill.Ant;
import com.massoftware.anthill.Anthill;
import com.massoftware.anthill.Att;
import com.massoftware.anthill.Clazz;
import com.massoftware.anthill.DataTypeInteger;

public class EjercicioContableAnt extends Ant {

	// SELECT A.EJERCICIO, A.FECHAAPERTURASQL, A.FECHACIERRESQL, A.EJERCICIOCERRADO,
	// A.EJERCICIOCERRADOMODULOS FROM EjerciciosContables A ORDER BY A.EJERCICIO
	// DESC

	public EjercicioContableAnt(Anthill anthill) {
		super(anthill);
	}

	public Clazz build() throws Exception {

		// -------- Clazz

		Clazz c = new Clazz();

		c.setName("EjercicioContable");

		c.setNamePackage("contabilidad");
		c.setSingular("Ejercicio");
		c.setPlural("Ejercicios");
		c.setSingularPre("el ejercicio");
		c.setPluralPre("los ejercicios");

		// -------- Atts

		Att numero = new Att("numero", "Nº ejercicio");
		numero.setDataTypeInteger(1, null);
		((DataTypeInteger) numero.getDataType()).setNextValueProposed(true);
		numero.setRequired(true);
		numero.setUnique(true);
		c.addAtt(numero);
		
		Att apertura = new Att("apertura", "Apertura");				
		apertura.setDataTypeDate();
		apertura.setRequired(true);
		c.addAtt(apertura);
		
		Att cierre = new Att("cierre", "Cierre");				
		cierre.setDataTypeDate();
		cierre.setRequired(true);
		c.addAtt(cierre);
		
		Att cerrado = new Att("cerrado", "Cerrado");				
		cerrado.setDataTypeBoolean();
		cerrado.setRequired(true);
		c.addAtt(cerrado);
		
		Att cerradoModulos = new Att("cerradoModulos", "Cerrado módulos");				
		cerradoModulos.setDataTypeBoolean();
		cerradoModulos.setRequired(true);
		c.addAtt(cerradoModulos);

		Att comentario = new Att("comentario", "Coemntario");				
		comentario.setLength(null, 250);
		c.addAtt(comentario);

		// -------- SBX Args

		c.addArgument(numero, true);
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
